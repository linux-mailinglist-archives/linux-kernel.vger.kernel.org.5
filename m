Return-Path: <linux-kernel+bounces-119444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D567A88C8E0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF1F1F8119E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E6F13C9D5;
	Tue, 26 Mar 2024 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aytQV14L"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98DB13C8E8;
	Tue, 26 Mar 2024 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470023; cv=none; b=XkWwM8HwW4xpmdSKCWzxx7o609KDvhtHde6csSJjbyFotLVVFbn40mxDww4QWdFwyw+ZG+E6o1IhfcSVh3n118QgdB4K6R9gfS3i16HVZh8u4Kj8TiI+mVPjNrT/JvimJqR2xCu0tkTJ2RKdbyY0Job6hcPd0moDjVmTQfHTpaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470023; c=relaxed/simple;
	bh=D95Kc3TjFggL8YT1WZrh/h3Li8LRC6IjIGC7ruEV3OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n554DMjz+++GtCGYUAP2fLUzVoLCtDG7PVnNcoYQy5FjVsHExo0O/rtcXXdpauYULzeVEzDf6NQIMINV7kARybtxMF/FGE1g4JS8PjQC8cAmrsI0VbBybGgR9DGNDn52kTX2x1X8elac8+p18/eHTj6tWPquR6YDlUazWycArAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aytQV14L; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4316101ed5eso7256521cf.2;
        Tue, 26 Mar 2024 09:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711470021; x=1712074821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IKaEl4faDXOubqbj8s61EhSq4y0/fdmoF1112F2KMY=;
        b=aytQV14Lb0JXxOR/0GKE5r9n6/HJAIh1VUm602RPHu0BNI9aHvfH8VTo700YAIgovD
         646hgjjNsrbRjjotLw7xj/ljoPTcMCudGQBL4dB9JT2PDcfkCUfy98Cyf8L1eT0vyPI2
         LL8SScNK1alV1IFrTl8hHHT5fXdGYPYRtLfuqxDpW9+MjgHdyOw3h4UrtpGgiOMkaOnK
         jjRMJUomDot8AiwDNV8Dhk/KU2tjouH99SfEoOTmXvOCib8mC+LK6fdT9CNSaSich44U
         2HxTRZPPGjH+a8rT/DxSFRuWnLLfhbQTjb1r+VHb8Ffb5sd0IwXg6c5QRIszwtBV1b1z
         N6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711470021; x=1712074821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IKaEl4faDXOubqbj8s61EhSq4y0/fdmoF1112F2KMY=;
        b=BIAk2jtx74ruxmxXQOu+N03p1CI/iWeuO8kis3v6jvxA1cWFeL0ssefoRu7fqvB0l+
         QBjwBQpMFSq5d+T4FL/es7XkrsZq6vc4SrWNlBepzjsGwirq7QPQer0BrPdI4IlRmTv1
         IETKsBwZGq5LqQ+vmUAXpwqH9xd5aJsg+K0BvUUJNG8JhIKmozSws7jc3zLNemYfs1jz
         HdcWIKK/pyPMu16CERcuW2tdrnizpiiN/XlL4rYjpJ1ElrDMxcJl8S4xjc3y0VQYWQNs
         2iGvHHYjXXVZFG5gRWuRmCxhCgBalcv0SID10+GiDQbx9t293g/ZJkzJJ/u+w0CIBTrZ
         m6ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCvvJGk59+iyI7izuKYPO3nURAw1+TNtd1X44mvAiePsOiDDI9B8fVUuELkK3OFsBXjDxLIT/Vk/KM4V5GUIntWcJxxOnI2tMUK/hnjW2sgDT11c96yUJXiJhi6KJe0ouDAwGAvYAa+w==
X-Gm-Message-State: AOJu0YyBxaaKqgfyvAM0xCMDJBjhqwcIPpQ3/PtrF6OQxPyXp4QZgxVn
	dfbUJ0l7qUqMd9FAVkrVvuJG9m/xiTsMqLulywmUiEl2q82jP/OUwiHn3vJk3ctymHIcNeMxNbL
	aWzjWjkP5Txgh4qrwkY4DpF/wjPQ=
X-Google-Smtp-Source: AGHT+IEgWiPWgP4UoqnhIOVp4j2Q6nGMB+4QzZqu9/AG9F+lszMXGkP5HHgXQTkrdrHALrwK/Ui+sOPR4x6Vn1lt4qs=
X-Received: by 2002:a05:6214:2a46:b0:696:71fb:c66f with SMTP id
 jf6-20020a0562142a4600b0069671fbc66fmr80542qvb.58.1711470020667; Tue, 26 Mar
 2024 09:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325210045.153827-1-afd@ti.com> <2024032631-excursion-opposing-be36@gregkh>
In-Reply-To: <2024032631-excursion-opposing-be36@gregkh>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Tue, 26 Mar 2024 11:19:54 -0500
Message-ID: <CAOCHtYjauA+BAxZJBMTaxxaMGcvipP9=ZPeWe4FiNFs_jpq6dg@mail.gmail.com>
Subject: Re: [PATCH] uio: pruss: Deprecate use of this driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Kridner <jkridner@beagleboard.org>, 
	Matthijs van Duin <matthijsvanduin@gmail.com>, Drew Fustini <drew@beagleboard.org>
Cc: Andrew Davis <afd@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 12:41=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Mar 25, 2024 at 04:00:45PM -0500, Andrew Davis wrote:
> > This UIO driver was used to control the PRU processors found on various
> > TI SoCs. It was created before the Remoteproc framework, but now with
> > that we have a standard way to program and manage the PRU processors.
> > The proper PRU Remoteproc driver should be used instead of this driver.
> > Mark this driver deprecated.
> >
> > The userspace tools to use this are no longer available, so also remove
> > those dead links from the Kconfig description.
> >
> > Signed-off-by: Andrew Davis <afd@ti.com>
> > ---
> >  drivers/uio/Kconfig | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> > index 2e16c5338e5b1..358dc2d19b885 100644
> > --- a/drivers/uio/Kconfig
> > +++ b/drivers/uio/Kconfig
> > @@ -126,19 +126,13 @@ config UIO_FSL_ELBC_GPCM_NETX5152
> >         http://www.hilscher.com/netx
> >
> >  config UIO_PRUSS
> > -     tristate "Texas Instruments PRUSS driver"
> > +     tristate "Texas Instruments PRUSS driver (DEPRECATED)"
>
> This isn't going to do much, why not just delete the driver entirely if
> no one uses it?

CC'ing Matthijs one of our BeagleBoard community members who utilizes
and supports UIO on a number of community projects.

We know TI and Mainline in general do not like this UIO driver as it's
very open-ended.

While the remoteproc_pruss driver is now mainline (it has taken a long
time, since 3.14.x i I think TI first started this..)

There is a large user base of UIO examples that have been running
since 3.8.x and as a community we have made sure ( mostly Matthijs )
that these continue to operate on this driver in
v5.x/v6.x/lts/mainline branches.

We can always revert/etc..  But I'm hoping Matthijs will chime-in..

Regards,

--=20
Robert Nelson
https://rcn-ee.com/

