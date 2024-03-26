Return-Path: <linux-kernel+bounces-119162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8457988C4F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111161F63F25
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC13763FF;
	Tue, 26 Mar 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iovTnrQS"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1192476053;
	Tue, 26 Mar 2024 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462649; cv=none; b=WCMotzUD7alE0d/bVPVzIU2gdgnxTI5XVZkisv+WJ+HcCMeKcgEzs9bJBSvsVQGHiE4Pius3fJ38cUSK39K/XWnsoYL+tqwW9AWRSYGYpwMYeeb1P2nj2030r7xzmyDGJMsfTnrLk5dSsLqdsgQAF3CHePAO7VMFVC+FwigDd88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462649; c=relaxed/simple;
	bh=+krnLDQUclK1illgGMyFVfdlSO05mR2Nuwt4J5jFAKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8E0XO6UuAFkGl17a/skw+2HvHfOYxdCbW3iVmAtg5clcER6iSTOU1I3Km1Qz1R4kJMeXDXF+yGpb39DPYa42xcX9YGFv8GEexqZCLwIL1ZX8FNMbyWJ2t6/N0L6PqKYgau8Q2k53Jatvpej/IZjsBYKx54Y4rS3SNznVzYzWUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iovTnrQS; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d476d7972aso89388301fa.1;
        Tue, 26 Mar 2024 07:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711462646; x=1712067446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ms8vWcwf7m0AJcENPnkb47qcys5bsP/SBjcv/l6anGY=;
        b=iovTnrQSCSNryE1IMD28ghCtAQaZj9qYsSN+2qD05z8IpZXgpXL8Ewey5mfBv5tLlR
         /28DH0f4Zu5RSWEME01Kd3NUOvVy0Dh7ZYguhKOu0vvR3XLpnR2Srkhu12VaxV0Bs4HA
         3k9nQR2zC10P5T9fWTiRkZXL8nKpu7qQZChi6u4PhXcLI9mqILGRO9fDCPfexlN6IxWr
         v7KnE4X95MiTjnhqn0nswKpwbHWTpTnDIxQ589YvoN8er6cMHkdQ9mXB4M5+63RI376w
         46ReQQnSBuNq//5OcsvaH75xmTnYn674eDWKWzBD0ELNGYnNbC3XlE0tHVWdiU4S4FjA
         UK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711462646; x=1712067446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ms8vWcwf7m0AJcENPnkb47qcys5bsP/SBjcv/l6anGY=;
        b=LZZ0jELVPODVoSs1ajqMDR/3979cXckS3NrnVUMcY0/t82nw/76HDCQFYavXGIEgM+
         isJaGsJbp9FOxUUe259NWRByByl3r0wzloACclL30uPNJMPjZPnTxBzX6TClYFPfvIyp
         oHeRzMVpfuE94Ufy1J00x0Ub+OgaybeskOKYZvQzGJCcnBuy16IgahGm2bfUxLWUEEPk
         yP2MLqTirm3d5t+kKqPedY2J3ZxjZClFEJ5p8eNcBFYkX2w6pVRlDISZiHxjUspn4jFq
         cmgWf4RK9pgYljnG0dhIXEpx2IZ45rulr3FX53tQgdrvcT8dlc9y7+Cnx2IouCpf34NP
         UQ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJbW98f5yWrIu3KgXyMHz2xp11PQq+fAIf1Da+WisnaV0lmYkHPA79SADRp8qUOV+CYru58rn5WKz94t82B8hWEGrj+j1E8PAzrOrLOaj+x2f5D0yyRTm/Gl3eOWVZePcHlB8Y+6Gkc0OmXUWbNh1ITVztd3b5VDFJP+WYhMk5HdlRt1Hv
X-Gm-Message-State: AOJu0YwiKjp6LC5+uAXKNrdNdezLuxz/DOvk359grZqy45HxJIFuZZbL
	5wxd1REbM4ejY85Oi+kzqWaux3OqOKzE6rKyWCY/kNVq4m6aAQ8LDjQPP4LoGt+SCpmAI+taSqJ
	y0cVV8VpB2MgMtMnBJ9Aiiw06RgQ=
X-Google-Smtp-Source: AGHT+IFL9XDPAaK62k8nut2Lx2rk5TkufZ8U0p7j7fS5DORaIk+YsthRyhtW5kQUXJUoFB0lhQ8JOOEXVg2k4/ITw9Q=
X-Received: by 2002:a2e:93d0:0:b0:2d4:8878:a15d with SMTP id
 p16-20020a2e93d0000000b002d48878a15dmr6894746ljh.7.1711462645848; Tue, 26 Mar
 2024 07:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZJV1htg46Gyu=7_iUWdukM+rHLitsLjxmWWYFGXty3tVw@mail.gmail.com>
 <ZfMStHjwtCT1SW3z@hovoldconsulting.com> <964131ff-293d-47d1-8119-a389fa21f385@leemhuis.info>
 <CABBYNZJ0ukd_8=SFzy8CEwgP7hV5unodca0NZ2zDZh+jPJsEFQ@mail.gmail.com>
 <ZgGzWWV4Lh2Nal--@hovoldconsulting.com> <CABBYNZJaXUhu1A+NyVT-TAJw49zcV6TMdGeVy2F+AVKWBOVC-g@mail.gmail.com>
 <ZgHVFjAZ1uqEiUa2@hovoldconsulting.com> <CABBYNZJUVhNKVD=s+=eYJ1q+j1W8rVSRqM4bKPbxT=TKrnZdoQ@mail.gmail.com>
 <ZgHbPo57UKUxK7G8@hovoldconsulting.com> <CABBYNZJFzDaLdXsdNEP1384JaJEN5E78cgmWfOus_LGOREGsWA@mail.gmail.com>
 <ZgJ0okobGv5nPreG@hovoldconsulting.com>
In-Reply-To: <ZgJ0okobGv5nPreG@hovoldconsulting.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 26 Mar 2024 10:17:13 -0400
Message-ID: <CABBYNZKJJuPHEwyXFRi8Z=P0GyaY-HdamsxmV8sR+R97ETTmEg@mail.gmail.com>
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
To: Johan Hovold <johan@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Johan Hovold <johan+linaro@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Tue, Mar 26, 2024 at 3:09=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Mon, Mar 25, 2024 at 04:31:53PM -0400, Luiz Augusto von Dentz wrote:
> > On Mon, Mar 25, 2024 at 4:14=E2=80=AFPM Johan Hovold <johan@kernel.org>=
 wrote:
> > > On Mon, Mar 25, 2024 at 04:07:03PM -0400, Luiz Augusto von Dentz wrot=
e:
>
> > > > Probably needs rebasing:
> > > >
> > > > Applying: Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode e=
xists in DT"
> > > > error: drivers/bluetooth/hci_qca.c: does not match index
> > > > Patch failed at 0001 Revert "Bluetooth: hci_qca: Set BDA quirk bit =
if
> > > > fwnode exists in DT"
> > >
> > > I just verified that it applies cleanly to 6.9-rc1.
> > >
> > >         $ git checkout tmp v6.9-rc1
> > >         $ b4 am -sl ZgHVFjAZ1uqEiUa2@hovoldconsulting.com
> > >         ...
> > >         $ git am ./20240314_johan_linaro_revert_bluetooth_hci_qca_set=
_bda_quirk_bit_if_fwnode_exists_in_dt.mbx
> > >         Applying: Revert "Bluetooth: hci_qca: Set BDA quirk bit if fw=
node exists in DT"
> > >         $ b4 am -sl 20240320075554.8178-2-johan+linaro@kernel.org
> > >         ...
> > >         $ git am ./v4_20240320_johan_linaro_bluetooth_qca_fix_device_=
address_endianness.mbx
> > >         Applying: dt-bindings: bluetooth: add 'qcom,local-bd-address-=
broken'
> > >         Applying: arm64: dts: qcom: sc7180-trogdor: mark bluetooth ad=
dress as broken
> > >         Applying: Bluetooth: add quirk for broken address properties
> > >         Applying: Bluetooth: qca: fix device-address endianness
> > >
> > > Do you have anything else in your tree which may interfere? What tree=
 is
> > > that exactly?
> >
> > bluetooth-next tree, why would it be anything other than that?
>
> I ask because I did not see anything in either the bluetooth or
> bluetooth-next tree which should interfere.
>
> And I just verified that by applying the revert followed by the series
> to bluetooth-next. In that order it applies just fine, as expected.
>
> > All the
> > CI automation is done on bluetooth-next and if you are asking to be
> > done via bluetooth tree which is based on the latest rc that is not
> > how things works here, we usually first apply to bluetooth-next and in
> > case it needs to be backported then it later done via pull-request.
>
> The revert fixes a regression in 6.7-rc7 and should get to Linus as soon
> as possible and I assume you have some way to get fixes into mainline
> for the current development cycle.

Yeah I will send it later today to be included in the next rc release
and since it is marked for stable that shall trigger the process of
backporting it.

> The series fixes a critical bug in the Qualcomm driver and should
> similarly get into mainline as soon as possible to avoid having people
> unknowingly start relying on the broken behaviour (reversed address).
> The bug in this case is older, but since the bug is severe and we're
> only at rc1, I don't think this one should wait for 6.10 either.

The revert is now pushed, I had to apply it manually though since it
didn't apply cleanly, that said the other set still don't apply:

Applying: Bluetooth: qca: fix device-address endianness
error: patch failed: drivers/bluetooth/btqca.c:826
error: drivers/bluetooth/btqca.c: patch does not apply
error: drivers/bluetooth/hci_qca.c: does not match index
Patch failed at 0004 Bluetooth: qca: fix device-address endianness

So please rebase and send a v5.

--=20
Luiz Augusto von Dentz

