Return-Path: <linux-kernel+bounces-157234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1738A8B0EED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13BDDB2DDA9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ED316C85B;
	Wed, 24 Apr 2024 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQcJh1Mp"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F0316ABC7;
	Wed, 24 Apr 2024 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973319; cv=none; b=CybufDDkTqSwgMTAxBSddQCQmoPiXgxq3u/mWVRccRrkEDAnTM7mUhz2JemecNoQDypS0mXnPzgRPfI9Wd2CTtYEONqMw6YYvMhKoRYYT3M4itjZ5MjXdQX1+2yIFUX6fYNoWGxZgRIaAl+qIxjNejswWp7oWaa/1O3ByWqeWpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973319; c=relaxed/simple;
	bh=t93zKHSPtsBnQSWADg6nKxHiZzT/Xq3KTswC0usIJ2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XC0rQv9V4sxLf+L1VggkdwnMk8ciCb7ODJXTTpKg/h2FMzacPYdrHiddOGxD4RUt4puHCf+3qGGLNbIJrKN67RcwzR29/mk39Xbe09OocnZxGHMsaUagw5xElObLUxtS86E1CTHEkdbGr0D+wgcCEltv5MSIvDnCIRd9PFajwUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQcJh1Mp; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d87660d5c9so74990851fa.2;
        Wed, 24 Apr 2024 08:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713973316; x=1714578116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irGVQcAEFbUn9GBhtEboC87nWk4XwwJpeZ6vgx4r4Tk=;
        b=FQcJh1MpuGF4aiw0MSBi9uTwDB7+h2x6KbmSY+WZ4xjQt2d9oT8lyJ/XR2rGTp3tfC
         3iVBzmagO+MwuTz3h2CFjvlsGHw55+QFE1TpI0mfHEk1Ubyys4L+wUjFyhWAFzdiuZxZ
         Zc3+3Z5L813Oeg/ixlPYNSj/F0c3EDwgGHa4rSbWX1/bW8NsJMZvBy5/H6zVxZRmCBuJ
         lE00NpVaLdptg1lLHfb1je0qdl+2YlccwaN2kG4QkWNr6rECOVxreoQI0UM9ihj8bh0I
         fzH/Hc0S9KJLVTV+cEtgaeBOWhbzp82k41q2usN9GiByi9HWablj/E1o1yWNNg1TEEnH
         8vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713973316; x=1714578116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irGVQcAEFbUn9GBhtEboC87nWk4XwwJpeZ6vgx4r4Tk=;
        b=W5j4NPVRxvBu5RZAExyi2aJFLTqqB7L+2VXY5C5Nx9MX0hdgDGQIXLCcBKfrMTw/1A
         54GBOJxXriCRKbCzcUxLNOViM3OszXTmTV8jrHKU3PixipoPKRWTOg2CQf0bRq6Y5v9t
         bG18KlmtW5Vfu7x7u8+fUtMdCyo2C9VZlIWHsUJDLs5YtV3mAcrFW34NJJPMzcIc4NW5
         TIu60yACz24Ghmex1ysGRBEIgIpvVXHEdWs0HXyUW3EpjhjJBrhBJi+eXwQFj+2Y56sr
         seS3xdTGqxOi6sHVys5G2MlYL9mCGcdR6c7l/JlZ/GpSXAvHNiZeaJ+qJiYMw2oscZtT
         ntCA==
X-Forwarded-Encrypted: i=1; AJvYcCUphAg9PPe3mciziDWQPCwjMLWUn1yyiaIPNamoMGlh44yi3jig33t3yxvFhfinMSAof9CTxfA7E0VPHYZwm7ywGCNNQ2zeJDldPlqynscKQUmhuc0lzt2e5gca8oapXvI/2sNyajDbW0YAhgtJ
X-Gm-Message-State: AOJu0Yz6IAVv5Nx+0XwFnBr8dFLQUsngxiGAchqV0IpsRrDQJqWVCQba
	esmfRadF8VyIXkUT6PtiynL50d+++5D6El1aS9WavKIwon/i0mfvYKS7jH8dgOcmZDb5GnWO88a
	tSejvSqPe2noFE0leqjQHrnCEC3I=
X-Google-Smtp-Source: AGHT+IG5yfSd6cq5rZtpNoywZAG4FJRubDrqh6PzQdHGnwqqNz3lEBXwHk33OBFQ/1RrRaMNb9ijvZaLZE2oNQuk9m8=
X-Received: by 2002:a2e:9207:0:b0:2d8:5b4e:bddb with SMTP id
 k7-20020a2e9207000000b002d85b4ebddbmr2343776ljg.52.1713973315971; Wed, 24 Apr
 2024 08:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424122932.79120-1-brgl@bgdev.pl> <0f8ba1b5-490e-4961-80e2-7942f66730ec@linaro.org>
 <CACMJSeuBCkNyaD60qGVpAq91DqD_OA=tCVEY0t+JNK2vcWBc+Q@mail.gmail.com>
 <d82c2e39-d2b8-4de0-a11a-6ab2420f8f95@quicinc.com> <f4bffd0e-0d9b-4fb9-926e-c75a20c92b50@quicinc.com>
 <CAMRc=MfqKsRqKck5Wb052zuUURxqRykjbu+c3K9oFPMHaHuiJA@mail.gmail.com> <f1d41e3a-e864-43a3-bb59-f59a8667b595@quicinc.com>
In-Reply-To: <f1d41e3a-e864-43a3-bb59-f59a8667b595@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 24 Apr 2024 11:41:42 -0400
Message-ID: <CABBYNZ+5R8gJVWXjO_VMsZ9MN9e6YV-Cnp3oYEnnbRJz1D=W=g@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wren Turkal <wt@penguintechs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Quic_zijuhu,

On Wed, Apr 24, 2024 at 11:35=E2=80=AFAM quic_zijuhu <quic_zijuhu@quicinc.c=
om> wrote:
>
> On 4/24/2024 11:31 PM, Bartosz Golaszewski wrote:
> > On Wed, Apr 24, 2024 at 5:30=E2=80=AFPM quic_zijuhu <quic_zijuhu@quicin=
c.com> wrote:
> >>
> >> On 4/24/2024 11:24 PM, quic_zijuhu wrote:
> >>> On 4/24/2024 10:52 PM, Bartosz Golaszewski wrote:
> >>>> On Wed, 24 Apr 2024 at 16:46, Krzysztof Kozlowski
> >>>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>>
> >>>>> On 24/04/2024 14:29, Bartosz Golaszewski wrote:
> >>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>>>>
> >>>>>
> >>>>>>               qcadev->susclk =3D devm_clk_get_optional(&serdev->de=
v, NULL);
> >>>>>>               if (IS_ERR(qcadev->susclk)) {
> >>>>>> @@ -2355,10 +2360,13 @@ static int qca_serdev_probe(struct serdev_=
device *serdev)
> >>>>>>               qcadev->bt_en =3D devm_gpiod_get_optional(&serdev->d=
ev, "enable",
> >>>>>>                                              GPIOD_OUT_LOW);
> >>>>>>               if (IS_ERR(qcadev->bt_en)) {
> >>>>>> -                     dev_warn(&serdev->dev, "failed to acquire en=
able gpio\n");
> >>>>>> -                     power_ctrl_enabled =3D false;
> >>>>>> +                     dev_err(&serdev->dev, "failed to acquire ena=
ble gpio\n");
> >>>>>> +                     return PTR_ERR(qcadev->bt_en);
> >>> please think about for QCA2066. if it is returned from here.  BT will
> >>> not working at all.  if you don't return here. i will be working fine
> >>> for every BT functionality.
> >> sorry, correct a type error, it is QCA6390 not QCA2066.
> >
> > Doesn't matter. If enable-gpios is not there, gpiod_get_optional()
> > will return NULL and we will not return.
> >
> i think i need to explain more for my consider case.
> let me take QCA6390,  if the property enable-gpios is configured.
> but IS_ERR(qcadev->bt_en) case happens, your change will do error
> return, so BT will not work at all
>
> but if you don't do error return, BT will working fine.
>
> so your fix is not right regarding QCA6390.

Actually I'd say he is probably right with respect to DT because that
seems to require GPIO, we probably need a clearer way to differentiate
if a device is being set up via DT or not (btattach), in any case DT
is probably preferable thus why I went ahead and applied this one.

> > Bart
> >
> >>> NAK again by me.
> >>>
> >>>>>>               }
> >>>>>>
> >>>>>> +             if (!qcadev->bt_en)
> >>>>>> +                     power_ctrl_enabled =3D false;
> >>>>>
> >>>>> This looks duplicated - you already have such check earlier.
> >>>>>
> >>>>
> >>>> It's under a different switch case!
> >>>>
> >>>> Bartosz
> >>>
> >>>
> >>
>


--=20
Luiz Augusto von Dentz

