Return-Path: <linux-kernel+bounces-118523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567A388BC18
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769141C2D13D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3531C133998;
	Tue, 26 Mar 2024 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oxt-co.20230601.gappssmtp.com header.i=@oxt-co.20230601.gappssmtp.com header.b="tsPfr+Im"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761251332BC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440923; cv=none; b=RCa1bRQaOe2WnFNlw7dQykn+MYOelG9xfLH3hEftu3nODAA4Hc4NZ2EIZM6TX2/rLfPYBIlZjzubtgRNonWMpoaiR7qMBLwVPhCqSRQV4OkP8T5yWaMJTErMpdDPnMhrbITdaMtmCNEmLFwRIS/dY+ZTDD/LDO+jy5ZbEX3RUZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440923; c=relaxed/simple;
	bh=AHsF7pl4Nf8PIxJRkpi6eIzZQcxPKtxq/DQ61XjaxM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyhVrdPizby5D7YnqgvKFGF9u5puKfCcysve1suUlUAutiCVZHK0l2NxPaaM1z9D7i9nvV8ZfCw7uzv4gbcQmuIgxF+lleW40nuSlYCfPLFkXOOsydptcQZKEN+D4xRkDV34rCLV5t0yDyODr85XEJWZjC+WC8KW7T5/K5m1DMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oxt.co; spf=none smtp.mailfrom=oxt.co; dkim=pass (2048-bit key) header.d=oxt-co.20230601.gappssmtp.com header.i=@oxt-co.20230601.gappssmtp.com header.b=tsPfr+Im; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oxt.co
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=oxt.co
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7e04e70c372so1470648241.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oxt-co.20230601.gappssmtp.com; s=20230601; t=1711440920; x=1712045720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CM2Y038SjZyb1eGsQwstN6fVzjkdst+K8jbQKRjvRBI=;
        b=tsPfr+Im1AzjeUZ3orsTLi8UAgqn2+T56M6o6LquCISwOm5hZsMZtINtwZ3sYE2Wm+
         P7vQA9taDGUxOW2LXRumfHS8A8v1EJ64ADWv8XIfKDGGVphKFCtQxCemF2vFqOgHVJdR
         kb1EXivMPNr0ttRIhNQVUwU2TxiRYi2FlVylgnDClxyZdpYlpkqhAlDIgDd7Olwm4TxR
         GqNGhXJbp451sX2CtzFEZ/gTrrWGS14Ek8vOflLMK4Q6M4Ghn1m2oAN5hDwYY/Xivi47
         iWfAD3A0DHHn6V5Umv9pm18uzBbAI+EorCOmVjseRoBd0cKQ2qbLXsVB6bcOgRmV5vSQ
         bFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711440920; x=1712045720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CM2Y038SjZyb1eGsQwstN6fVzjkdst+K8jbQKRjvRBI=;
        b=hyya9wm2+QJhr9rMz3jhsxKd+B9fAgnygd/liuJV2olomwZ67zeoTZZeaiRJB8+3v1
         ZUulmAzihcacafynFUt++zcVPXPeM9m+Sz0ML3ut3ba+KDpHrZ8UjLbDnzrMEJi1oVkO
         iy7OToQBbNT6VWo3DYXypDn6HQ4awsPSJitnpTYsf2nX1k+ctkbzskU4bYVlxcl4kC3k
         Imvqbkx7Z626lT+461aC+2fwdwlkJcEW6EyTFY892j6wcXs7yQgeGJ/a6TEcpK7yOkqi
         UJ33xVvTF3ao6kZkFv07N2Rpo4k0qwmzCFcxcEP7ZRntOi58SZJbHNpH9/7WMEj3gozn
         S4yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVzIZU54RUnL+Q3WcXJ8HztHwisU3BT46ME/O6O8MRaq1YeguH5g78eSY7T9OTXX/+R/1H4g+jXhIpMWPKYdNpERYu6pKMpi+WkxZN
X-Gm-Message-State: AOJu0YxIApUCWDafHlfVikwZCJ3YBhZCyvqybA0yLir4eCVIs1hhALHd
	FU+VwgeqzPYwSv2OvS6DBMvh7ez5sBWe7WP3e3Bz+6ACAqPOIMa4GSTW4mg11pBLEzdBg7Qc0UU
	U9X9537JSXe3AvGOAmtmQDMMFLRUwHGNHEKD+ISISHMC1quIYWfsT2A==
X-Google-Smtp-Source: AGHT+IEmFzrkE1uu0P3w6ZHI4kWUQ7hFSMcinvjcf0h7M46f1eXFfIlN081Cp6Cmf6kN+ncXGA4KEAXyFanQJg4lhZs=
X-Received: by 2002:ac5:cdd1:0:b0:4d4:15d2:8b3b with SMTP id
 u17-20020ac5cdd1000000b004d415d28b3bmr6113449vkn.9.1711440920144; Tue, 26 Mar
 2024 01:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325-obsbot-quirk-fix-relative-ptz-speed-v1-1-0eb1387d98c7@securitylive.com>
 <6e6b75a15cdc6a1239edc4d49b927b187ed20054.camel@irl.hu> <CAMB8T1ULcfBOB5VwZzUtvRnp4FvtBCFWxxTdb+OJK8FOpjKCXA@mail.gmail.com>
 <ec0430f6e687fc5e1a19338e381804b9d6aeabba.camel@irl.hu> <CAMB8T1Vv7CMqhH1ZY6fouxsE6r+6JbmeLnuFma_0_de814UoMA@mail.gmail.com>
 <CAMB8T1VWGaWtE0k5en4-xhE69G=OyFnhqJ3mexcgNSuvO_7uUQ@mail.gmail.com> <CANiDSCvGfA=B5YCQhSMRW-0cTQNWKGytQF74z9F_x-77WFPHpw@mail.gmail.com>
In-Reply-To: <CANiDSCvGfA=B5YCQhSMRW-0cTQNWKGytQF74z9F_x-77WFPHpw@mail.gmail.com>
From: John Bauer <john@oxt.co>
Date: Tue, 26 Mar 2024 03:15:09 -0500
Message-ID: <CAMB8T1W5K68fX4jw=V8+kqc8eT2HGCv75PAidO0Nkzy-A1jFAQ@mail.gmail.com>
Subject: Re: [PATCH] uvcvideo: Remo OBSBOT quirk fix for incorrect relative
 min pan/tilt/zoom speeds
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Gergo Koteles <soyer@irl.hu>, johnebgood@securitylive.com, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linh.tp.vu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

According to the spec bPanRelative and bTiltRelative are of "Signed
Number" but bPanSpeed and bTiltSpeed are of "Number". I think this
implies that a negative number is not possible for a minimum here.

It is very beneficial that the direction and speed are condensed into
one value, it greatly simplifies control as shown in a test I just did
below.

Here is a quick test I just did with the patch I'll be sending
shortly: https://www.youtube.com/watch?v=3D1XqWPROw49s

Thanks,
John

On Tue, Mar 26, 2024 at 2:47=E2=80=AFAM Ricardo Ribalda <ribalda@chromium.o=
rg> wrote:
>
> Hi Jon, Hi Gergo
>
> On Tue, 26 Mar 2024 at 07:23, John Bauer <john@oxt.co> wrote:
> >
> > After looking through the current implementation all of the proper chec=
ks are done in the getter and setter for the pan/tilt/zoom controls so the =
only change needed is the 2 locations to get/check/set the minimum when nee=
ded. Thankfully all the code that does the hard work is already implemented=
 I'll be submitting another patch that summarizes our findings.
>
>
> My issue with the spec is that it is not clear about what GET_MIN
> should return.  Is it the minimum absolute value for that control, or
> the minimum value in that direction?
>
> In other words, can we have a device with a range (-10,20) (-A,B), or
> only (-20,20) (-A,A) is allowed.
>
> If there is no device that supports (-A,B), then we do not need a quirk.
>
> Regards!
>
>
> >
> > Thanks,
> > John
> >
> >
> >
> > On Mon, Mar 25, 2024 at 10:42=E2=80=AFPM John Bauer <john@oxt.co> wrote=
:
> >>
> >> Ok, I get you now Gergo, I think I got lucky and I think you're right!=
 Digging into the UVC 1.5 spec I can see why this works, the first byte in =
each 2 byte pair signifying the direction is just getting the signed bit se=
t when a negative value is applied to both bytes so there should probably b=
e some checks.
> >>
> >> Here from the UVC 1.5 spec:  CT_PANTILT_RELATIVE_CONTROL
> >> +--------+---------------+------+---------------+---------------------=
---------------------------+
> >> | Offset |     Field     | Size |     Value     |                  Des=
cription                   |
> >> +--------+---------------+------+---------------+---------------------=
---------------------------+
> >> |      0 | bPanRelative  |    1 | Signed Number | 0: Stop, 1: clockwis=
e, 0xFF: counter-clockwise |
> >> |      1 | bPanSpeed     |    1 | Number        | Speed of the Pan mov=
ement                      |
> >> |      2 | bTiltRelative |    1 | Signed Number | 0: Stop, 1: tilt up,=
 0xFF: tilt down           |
> >> |      3 | bTiltSpeed    |    1 | Number        | Speed for the Tilt m=
ovement                    |
> >> +--------+---------------+------+---------------+---------------------=
---------------------------+
> >>
> >> I think it is the direction of the original implementation which is wa=
y easier to use than having 2 controls anyway, I would say it's preferred, =
it's how I have all my analog stick controls mappings.
> >>
> >> While the OBSBOT firmware implementation may handle any signed negativ=
e value in the direction byte we should probably check and make sure it con=
forms to spec with 0xFF for counter clockwise and down.
> >>
> >> In the current implementation both pan and tilt each use 2 bytes:
> >>
> >> {
> >> .id =3D V4L2_CID_PAN_SPEED,
> >> .entity =3D UVC_GUID_UVC_CAMERA,
> >> .selector =3D UVC_CT_PANTILT_RELATIVE_CONTROL,
> >> .size =3D 16,
> >> .offset =3D 0,
> >> .v4l2_type =3D V4L2_CTRL_TYPE_INTEGER,
> >> .data_type =3D UVC_CTRL_DATA_TYPE_SIGNED,
> >> .get =3D uvc_ctrl_get_rel_speed,
> >> .set =3D uvc_ctrl_set_rel_speed,
> >> },
> >> {
> >> .id =3D V4L2_CID_TILT_SPEED,
> >> .entity =3D UVC_GUID_UVC_CAMERA,
> >> .selector =3D UVC_CT_PANTILT_RELATIVE_CONTROL,
> >> .size =3D 16,
> >> .offset =3D 16,
> >> .v4l2_type =3D V4L2_CTRL_TYPE_INTEGER,
> >> .data_type =3D UVC_CTRL_DATA_TYPE_SIGNED,
> >> .get =3D uvc_ctrl_get_rel_speed,
> >> .set =3D uvc_ctrl_set_rel_speed,
> >> },
> >>
> >> Going to do some testing and report back.
> >>
> >> Thanks,
> >> John
> >>
> >>
> >>
> >> On Mon, Mar 25, 2024 at 9:23=E2=80=AFPM Gergo Koteles <soyer@irl.hu> w=
rote:
> >>>
> >>> Hi John,
> >>>
> >>> On Mon, 2024-03-25 at 20:51 -0500, John Bauer wrote:
> >>>
> >>> I understand this patch might not be the ideal or proper solution; bu=
t it works. I don't think the UVC
> >>> implementation can be trusted on these cameras, just like the Windows=
 DirectShow implementation is off.
> >>> I put this patch out there as I have encountered many Linux users who=
 are struggling to get proper
> >>> control of these awesome cameras. If the patch dies here for now, tha=
t's OK, at least there's a possible
> >>> patch for those in need.
> >>>
> >>>
> >>> Sorry, maybe I didn't phrase it well. Based on the UVC specs, I think=
 your patch is good for all UVC PTZ cameras, so you don't need to use UVC_Q=
UIRK_OBSBOT_MIN_SETTINGS quirk entry, just apply the quirk changes to all c=
ameras.
> >>>
> >>> Thanks for doing this!
> >>>
> >>> Regards,
> >>> Gergo
> >>>
>
>
> --
> Ricardo Ribalda

