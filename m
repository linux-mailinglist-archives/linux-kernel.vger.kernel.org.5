Return-Path: <linux-kernel+bounces-104451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F0987CE15
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF1B0B21A07
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C237B28E05;
	Fri, 15 Mar 2024 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaFMVt99"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A72241E3;
	Fri, 15 Mar 2024 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710509316; cv=none; b=tishvGDo/01qyAPotndregmXVutHU6cVYkyBbVnc+aJU6bYKIKHakyeYh8yrr9hAnBFC9FE/k0tJCanaY/ULfcDlSh2ecRtTZEi0C2fPTo8W14DAPED6SRu6JfWw6+vq2ft7FIwjsCNnFnv5Vc+p9gKIPf9Nc5E07109eG2gAHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710509316; c=relaxed/simple;
	bh=3dxMC2NWrL2jkQXTqFE6WL0+KeMZlS/E2z9RrTtp75o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aOzcFDvUS9zSWjAMiLZZs76GNTxBllq5/jTc6MHngnrSQr6OKFNuHRIe9GZzLcUPlwBVWyu2uGNFQfK1CfWeCarrcH5u+0b0RnwK427wV3udlqxyim+O+Q5BnsiFi+mewz/DWTsoOfFBephthJOG9jeIOV3jiD/rvj7odHeorAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaFMVt99; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41403889b6aso2516075e9.2;
        Fri, 15 Mar 2024 06:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710509313; x=1711114113; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3dxMC2NWrL2jkQXTqFE6WL0+KeMZlS/E2z9RrTtp75o=;
        b=IaFMVt99U79FV1SE/DGH5W/ltFiZmhN4I1U/7fM1OILyk/+xgyOFaUG5QETcVbxzTC
         OGoxFV8kiSFNNjWCiadC00b26Q8VNnrYxbvym9yu5aPFr3fuxVjW/zzRmcvLIdOOffa1
         //HGE2NHsTOH/2W9YxOpfZC/rI5utLO6RS8Kv0W99s9EPWkwb9D7xSQ4BG3D+/W+i38g
         tXXv0pf/vonSlK9x+mP4BFx9PlVH8BV1X+NBQLpgRXg/T8M+MFN04E+AffkTlsd5sLph
         C0U0+h62V7A3gj7uIyubKYMo19HU8v3QiyQf+v4PpZW5CEJc1vIEERQnOK/VJG8YJYXo
         ZBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710509313; x=1711114113;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3dxMC2NWrL2jkQXTqFE6WL0+KeMZlS/E2z9RrTtp75o=;
        b=U7gVkO60X7mTKsN7Q9+riK58VMfUGbzYh512azcIOAgA6nVhiw9Z2LpWDUp1cnilCz
         e4I6avr6ZzL+qxJXOKWh+za9xC1X4MNctKLmCoSdtjW+caaRTj7IiXDSANfLvF1uLr1u
         VukdYgL1uxpebS+Ny4j0lap8FGrY82yCJbQ7fdiNFcLmYEKsHirU8OGkEw5KLkgw5F4q
         qPMSDintoYVnqkf7A/yG6lWxyRy671E28t2+4s9JamWJUPOO1pxDy1DkumK7XFlEkrXa
         +w2DW1PHxHobgB0vCiMWe0wb0sz4yht4J41ARcHuTsAKvGEjXVj7WsUbRs3O22S9Xox4
         M7nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVhUj4GaeZ5WpFgvvenQasR/HDmrd2pdYJQvGrNzLHr1HxQxHqlFz6Ic/bYidusQBED+6zep2JWo6mBxuMZuosQGUGLI8+Gq8F2v1bqYaFGIwMveSyHzZHh7jmnl7/X+E0RGW4QAWD
X-Gm-Message-State: AOJu0Yxp4BaR8hvC8BqrhN5TQdvKCAb0sQZwnuYta2RdGnGMMI0tlnQR
	bI84fcKTbubctvQ5MzxlZ8hyOhQbGp/lxTPT3itKsZrY50RdNyo/
X-Google-Smtp-Source: AGHT+IHU05fjLOlHzExfbUIUX3oLmGbpwVhNti0XZYEPvRidj4JYinMnW9K13aJSA3CUoFQuf5T7rA==
X-Received: by 2002:a05:600c:354b:b0:413:f04d:d037 with SMTP id i11-20020a05600c354b00b00413f04dd037mr4174384wmq.18.1710509312442;
        Fri, 15 Mar 2024 06:28:32 -0700 (PDT)
Received: from [192.168.90.166] (121.red-83-37-9.dynamicip.rima-tde.net. [83.37.9.121])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b00413f035d58esm5806194wmq.10.2024.03.15.06.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 06:28:32 -0700 (PDT)
Message-ID: <63d6a4b0cb2155d5c194b3b65fa60c985a6338ca.camel@gmail.com>
Subject: Re: [PATCH v2 4/6] iio: pressure: Simplify and make more clear
 temperature readings
From: Angel Iglesias <ang.iglesiasg@gmail.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de, 
 andriy.shevchenko@linux.intel.com, mazziesaccount@gmail.com,
 ak@it-klinger.de,  petre.rodan@subdimension.ro, linus.walleij@linaro.org,
 phil@raspberrypi.com,  579lpy@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 15 Mar 2024 14:28:30 +0100
In-Reply-To: <ZfQPVlqv7A3zxExl@vamoirid-EDL-PC>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
	 <20240313174007.1934983-5-vassilisamir@gmail.com>
	 <20240314150959.585367b5@jic23-huawei>
	 <20240314201718.GD1964894@vamoiridPC>
	 <46389801aeb20f18affed86d979aff7a62cf36d5.camel@gmail.com>
	 <ZfQPVlqv7A3zxExl@vamoirid-EDL-PC>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-15 at 10:05 +0100, Vasileios Amoiridis wrote:
> On Fri, Mar 15, 2024 at 12:22:50AM +0100, Angel Iglesias wrote:
> > On Thu, 2024-03-14 at 21:17 +0100, Vasileios Amoiridis wrote:
> > > On Thu, Mar 14, 2024 at 03:09:59PM +0000, Jonathan Cameron wrote:
> > > > On Wed, 13 Mar 2024 18:40:05 +0100
> > > > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> > > >=20
> > > > > The read_press/read_humid functions need the updated t_fine value
> > > > > in order to calculate the current pressure/humidity. Temperature
> > > > > reads should be removed from the read_press/read_humid functions
> > > > > and should be placed in the oneshot captures before the pressure
> > > > > and humidity reads. This makes the code more intuitive.
> > > > >=20
> > > > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > >=20
> > > > To me this makes the use of these calls less obvious than they were
> > > > previously.=C2=A0 The calls are made close to where t_fine is used =
and
> > > > don't have to go via the indirection of chip_info.
> > > >=20
> > > > So I disagree. I think this change makes the code a lot less
> > > > clear.
> > > >=20
> > >=20
> > > This was mainly driven by the fact that I wanted to avoid reading
> > > the temperature 3 times in case temp, press and humid are enabled
> > > and there are consecutive buffer readings. But thank you for the
> > > proposal I really appreciate it!
> > >=20
> >=20
> > Hi, just a side note reflecting on this. Depending on your sampling
> > frequency
> > and registers data shadowing, to avoid compensating with different samp=
les
> > between readings, we should be doing burst readings to get a bundle of =
the
> > temperature+pressure and/or humidity.
> > On the bmp/bme280 and bmp380 this can be done as registers are contiguo=
us on
> > the
> > memory. On the bmp580 this is not a problem as the values are already
> > compensated, you`ll get always the latest reading.
> >=20
> > Kind regard,
> > Angel
>=20
> Hi Angel,
>=20
> Thank you for pointing this out! Indeed that's true but I noticed that th=
is is
> not
> the case for the BMP{085/180} devices. I just feel that some changes migh=
t
> make
> data acquisition/processing faster for a device (like the one you propose=
d)
> but
> it might make the code much more unreadable and unmaintanable. I will try=
 and
> see if something could be done in that sense but I feel that keeping it s=
imple
> will
> be good for everyone!
>=20
> Cheers,
> Vasilis

Yeah, data adquisition on bmp085/180 is already different as they don't sup=
port
continuous mode as the newer models and you have to warm-up the sensor and =
do
one-shot readings. There's already a different code path in place for that
models. I guess that is the price to pay to support that wide range of
sensors...
Anyway, this patches are already big and you're doing quite a lot of heavy-
lifting right now, so don't pay much attention to my ramblings! Regardless,
happy to help with tasks polishing and updating this driver :)

Kind regards,
Angel


