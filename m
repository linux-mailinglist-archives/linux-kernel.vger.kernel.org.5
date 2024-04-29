Return-Path: <linux-kernel+bounces-162731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 964AF8B5FCE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A54C283393
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAE4126F1E;
	Mon, 29 Apr 2024 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+wWeS0n"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA58665A;
	Mon, 29 Apr 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410777; cv=none; b=rqFEf9zhl4pT3M/LFoRv42jQ8jnwQN/+Okmz0GzuzU6m133ad+7T14Got+xVoN69f5rI3UE5EFx8EqZIGMESeqseWBPSz1nDD5UEbSJ3W9RQETFJryo47EyORTAgVyvnkcS9FJ8pQVk9Xk/rioDMWnyhDspMkAULqI7IILJETSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410777; c=relaxed/simple;
	bh=/MPV5FzIfjehuMgB7WhfgO6UyJ+ldK02eXZDzKyMkmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdxauHvER0JT78SSqqO93YIlmZDKhHPDidZQbTynIBDtHPxBzezrrw8MCq5I8pNylhAXAswvCrxn1wIUPWA0323HrQOUi4Wnp/xmDXWZlSXh1S4WkCizvYB0JCB83JPNDHSnQCz04uGzz1MTdkAha+Fg102WX7lLQDSxjfE7rmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+wWeS0n; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e0b2ddc54fso9695671fa.0;
        Mon, 29 Apr 2024 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714410774; x=1715015574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVVcC2d3P9RfUE14S22XAZSzG+fQaw6/pld3YgfjEfA=;
        b=F+wWeS0nayIvstVZLirQ3ly7ixhRat7IJLXBEm6k1mC4qY9B6ZP/1pJtDVUqdhm7Pn
         SadjJnKyg0ic6RZmJKKJYTIc+0yhRDG4p1SmFFs7vRrx4u6unZc4FYeJOYFzFNxjGIAn
         d+vhpOudwU8p71VLrlozJgH4d1p8sqFX4Kbc8aDaCMSxw7NsmWebw9XUajAeHRd0a4I2
         U2+7RJrIzgQABwEiSGfyzU4C67dtxWKPbMsXzeEATyW1PwEKF+H76k/gxikmLglorbit
         i/b3OFOujDpKrJ2GULEeEZRXKcM1Md8rRsIgoJai+75spWMOO3qD/zu+OYDolgnWgtdj
         6Mow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714410774; x=1715015574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVVcC2d3P9RfUE14S22XAZSzG+fQaw6/pld3YgfjEfA=;
        b=bwsi7pxcCOGv/iKnVnLeSRQHPgnqdVvV9cdyALSJonhhh7Xwo1AZtRfcn7q67eWqvu
         HGZMm1lM0mRhHjudbLm3qL7j2KzgxHLpxlGUGBZmHnMXMZHuaEPS/Y2UsvSZMLLNnLIu
         RkSrGjc182EYZbejAumWMZYU8HyTAXXxCQ9xRzyRyZXF6kW7GPX2subQyhAlla8exXA/
         HwbWK1/AcuaE5T2T2cv4ioMxN3LyzgFP3XZWN78ns+StAJSD0pdvw46eKWH5OvwEzE7d
         5o+395QuxjSXPef7txtfj5D1XgEZJPyGM2P19JIReRshW525enV0d3CG1tCGCyyi2uGI
         FQug==
X-Forwarded-Encrypted: i=1; AJvYcCWOCX0FzG/4jXclB6MpByHd8zqsh7KNMyJczjSzwm/IxjLetQPq4cIc8yRZiY7hbW1ER8od89HM+kJxt/QU0ojkDu/5k1jbjV8562V5zOzFoS3lnxuVV2ZBihU0S3XlgkTDkR7DMsXsciTceDUAGcxd4Ji8rU9fG1+J4rvW5utf47vY/4Wi
X-Gm-Message-State: AOJu0YzbwyQ9R5AgLFx/4Gw7ytnO+I21Gjsu+4uSVOKQVlmT7vhQPyOX
	cNto19rN16lrsEtbb3E7/xDtwDinSOCeqzMBi4zpAW7QsASH1GjlLuTYG3IOiMaXHXYgwNBolm3
	EYb/2CKndYbdHLSYNOCUj/12ARNXuwA==
X-Google-Smtp-Source: AGHT+IGNiSfJ4BwPEI0kDNwbXBcoy1KPjFvzf3fyMLy02hho60uukqxepyJT3bcAhnIBhdizWy6pmmRLNgIX/C++Log=
X-Received: by 2002:a2e:3615:0:b0:2df:a29f:8b45 with SMTP id
 d21-20020a2e3615000000b002dfa29f8b45mr4883802lja.49.1714410773438; Mon, 29
 Apr 2024 10:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426155801.25277-1-johan+linaro@kernel.org>
 <CAD=FV=V-pG9+5fLonNvydmjS=ziUFUHAyF8T7YTkEHiO405aSA@mail.gmail.com>
 <ZizKmtcUIYAMpvOQ@hovoldconsulting.com> <dbba45d2-f955-4d3a-aeab-26b0900d5823@quicinc.com>
 <Zi-ohCWv58d2h5VM@hovoldconsulting.com>
In-Reply-To: <Zi-ohCWv58d2h5VM@hovoldconsulting.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 Apr 2024 13:12:40 -0400
Message-ID: <CABBYNZJyqrNKebwPPPqjOAdrkpBJ0fqHyD2iVtypeQKCDcL+AQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: generalise device address check
To: Johan Hovold <johan@kernel.org>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>, Doug Anderson <dianders@chromium.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, 
	quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 29, 2024 at 10:02=E2=80=AFAM Johan Hovold <johan@kernel.org> wr=
ote:
>
> Hi Janaki,
>
> Please avoid top and remember to trim unnecessary context when replying
> to the mailing lists.
>
> On Mon, Apr 29, 2024 at 03:34:32PM +0530, Janaki Ramaiah Thota wrote:
>
> > Having a default BDA list from NVM BDA tag value will prevent developer=
s
> > from using the device if there is no user space app(In Fluoride) to set
> > the BDA. Therefore, we are requesting to use default address check patc=
h,
> > so that developer can change the NVM BDA to make use of the device.
>
> But a developer on such an old platform that can patch and replace the
> NVM configuration file should also be able to just disable the check in
> the driver right (e.g. by commenting out the call to
> qca_check_bdaddr())?
>
> >   List Of default Addresses:
> >   ---------------------------------------------------------
> > |       BDA          |      Chipset                       |
> >   ---------------------------------------------------------
> > | 39 80 10 00 00 20  |  WCN3988 with ROM Version 0x0200   |
> >   ---------------------------------------------------------
> > | 39 80 12 74 08 00  |  WCN3988 with ROM Version 0x0201   |
> >   ---------------------------------------------------------
> > | 39 90 21 64 07 00  |  WCN3990                           |
> >   ---------------------------------------------------------
> > | 39 98 00 00 5A AD  |  WCN3991                           |
> >   ---------------------------------------------------------
> > | 00 00 00 00 5A AD  |  QCA DEFAULT                       |
> >   ---------------------------------------------------------
>
> What about WCN6750 and 64:90:00:00:5a:ad?
>
> And then there's currently also:
>
> > > bluetooth hci0: bd_addr =3D 61:47:aa:31:22:14 (qca/nvm_00130300.bin)
> > > bluetooth hci0: bd_addr =3D 61:47:aa:32:44:07 (qca/nvm_00130302.bin)
>
> Which controllers use these configurations?

These are not unique addresses though, we can't just have addresses by
chipset address mapping logic as that would cause address clashes over
the air, e.g. if there are other devices with the same chipset in the
vicinity.

--=20
Luiz Augusto von Dentz

