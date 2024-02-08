Return-Path: <linux-kernel+bounces-57589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B319C84DB1A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE271F229F0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD686A02C;
	Thu,  8 Feb 2024 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av8cP3Df"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7066A00A;
	Thu,  8 Feb 2024 08:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707379847; cv=none; b=NC3xVggiGJ9p9mjqDAiaj+aIHymiCaBRCQ+h0MRgK2mhtCDax+uHCqGfik5cBIE2rfTjGs/ujMUXHRVLHbSHMxRdM7H7XUsUrQuIT6Ii98zOxww8TGmxW3w/tPS/+Fn27Qiq4+VKoVmmfnIjkw3BuaBK0H9kk7q5LC7llt/p2zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707379847; c=relaxed/simple;
	bh=rLKPlL1wEfVtpztK5+qtVFeIsRFv/xqZd2IV7yywC6c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dp9wzb4q3B3Ba+NmsDqQKgC2ZJMMsJnMuUXdyyJFnQEbniyOs9oHcuWKVUPfZHkjnVM2nqO5hIRomdA5IpfWgrKmkpEpmQtbH9jqATxm3LjBWu96o1a8tonEg7BMDyxYsRvSKaZAZwlxYrl7rf5MmwMUlCPHFKbkIrmrKaH42e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Av8cP3Df; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a271a28aeb4so187765666b.2;
        Thu, 08 Feb 2024 00:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707379844; x=1707984644; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A4BxlffO0l3fwoq6w4rpg/mg5qyOOcNcpda+degXM4o=;
        b=Av8cP3DfDWBlACo4OBYNaRB47VDQeMDnOMbBNn+QfuVGTJwmM5S2kvDEIhi9kwPxuz
         VNcG2G6Ja3lA/3TORFNu+jJxrsnC2T+5e7mi9dWgJWP5eQ6IkB3cE+4zPTjT13Hl5ody
         9AxdStMjIdccFQOTyKf+DVW595lgBRkRwRLsWLAGL9Xxy+85LqZUZx3Pso0sJE1QXEC0
         nmGCW3ebeUATzazwaK9StPGdLdua+vWVHIFPeZJApMLjuaoShXPEpC96Slw0NuMuZ7AG
         ncwbe3zj4Z80No2PcPq8w7hlx8wbrev7+JZ29XtRXL98VBgeP+2SWZDXESR0z3N1Gpfy
         vUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707379844; x=1707984644;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A4BxlffO0l3fwoq6w4rpg/mg5qyOOcNcpda+degXM4o=;
        b=HM0xjmtEpc2L174a/V+FwdNXpqgGals9w1MU8IGyE3kKrShRxptKaePRgegOOTTVls
         JOkwUFKMo3jR58hegK0a5Xhkd9stQPQbVbeuH9CatYJM01Ko0Qa6PcucsqqrrN2I/fto
         y4Rd1v43SCIrLvGg2YXelUBcswOV8O8uM4+nwE7Z+Vtun0DGOvJF+sdzx9FK/x87rxmx
         Rl8B30xO9lLA0BQbyNMjI1kWG2IXwWze9ao+uCWE32LwyGAC1bAccJzZ2k5WCfBRXS7s
         o0x2LhMk0YWQrp0ECtVLbxDA/bdeiWnCTXxigYHF7gpDqwfVXv5a9LMx5feuj70BjnMn
         EH7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXruJv1KCKTXiU5NmJwZ9izVaUzZZYQpDz+kglNp4OxLbPoVDVO3SiTq+lvSyPmukhvBCYlqwzXu2GkfOmOOL3i3p82zjeu0oZSUm2BMdgmAAh3B4osz5MAoqvpURuNRybtXIUUcgXi
X-Gm-Message-State: AOJu0YwFF5wNqQkZ4YrO/f/G1ZY5Vq7PSKwrdsAhmVvjJbId6ubPHGIW
	1Pr9Fk7gCSqOm60DoccD2E4Kos6MHnum9dOdKuQSlQqIZTMNDsvd
X-Google-Smtp-Source: AGHT+IHWpJ8qgGwQcsaJWVHxEudzxCSlYlLl06Zcz72xNXSVvpGkRmx/fkkmRyr9BJpXbsY0xTj0+w==
X-Received: by 2002:a17:906:2929:b0:a38:9590:cde8 with SMTP id v9-20020a170906292900b00a389590cde8mr2020590ejd.73.1707379843908;
        Thu, 08 Feb 2024 00:10:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOgSN+wd2xECL+6OaSYfgS/SafieK3W22OI4tXV26I7HGHKOzMzB/GQ5rpVlwLebD/Ka4kk4E+0//VaV6oiDH+3gkytuFD6J5qZjBeP9aOG4c+3zL6MSp5ICJQ0HrSMeXINXqKZlI89MWx6NiSu9y2O2CmqN/2qZHCZMtRR28yfJgEE8WwCyaoFa1AmYZZRLKSFNtJwmu93ae0LvDvFdfb0oYd3GKsjGKEHtl9XyPzjixI6ByTJ4bQjy26AJt9IWmBLvsstsjde25fYNVh/WlBEY4IdSP+4GMn
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id tj9-20020a170907c24900b00a3916c1f708sm714477ejc.173.2024.02.08.00.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 00:10:43 -0800 (PST)
Message-ID: <a9ddd254d985e5e9e29466199ee45a9733d4043a.camel@gmail.com>
Subject: Re: [PATCH v3 03/32] iio: adc: ad_sigma_delta: Follow renaming of
 SPI "master" to "controller"
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
	Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Thu, 08 Feb 2024 09:14:02 +0100
In-Reply-To: <de866d09c80c89816df62602ba4ba8ba30e9971f.1707324794.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
	 <de866d09c80c89816df62602ba4ba8ba30e9971f.1707324794.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-07 at 19:40 +0100, Uwe Kleine-K=C3=B6nig wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
>=20
> To be able to remove these compatibility macros push the renaming into
> this driver.
>=20
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---

Acked-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad_sigma_delta.c | 14 +++++++-------
> =C2=A01 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad_sigma_delta.c
> b/drivers/iio/adc/ad_sigma_delta.c
> index 7e2192870743..55442eddf57c 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -212,7 +212,7 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delt=
a,
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	spi_bus_lock(sigma_delta->spi->master);
> +	spi_bus_lock(sigma_delta->spi->controller);
> =C2=A0	sigma_delta->bus_locked =3D true;
> =C2=A0	sigma_delta->keep_cs_asserted =3D true;
> =C2=A0	reinit_completion(&sigma_delta->completion);
> @@ -235,7 +235,7 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delt=
a,
> =C2=A0	sigma_delta->keep_cs_asserted =3D false;
> =C2=A0	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
> =C2=A0	sigma_delta->bus_locked =3D false;
> -	spi_bus_unlock(sigma_delta->spi->master);
> +	spi_bus_unlock(sigma_delta->spi->controller);
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}
> @@ -287,7 +287,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev
> *indio_dev,
> =C2=A0
> =C2=A0	ad_sigma_delta_set_channel(sigma_delta, chan->address);
> =C2=A0
> -	spi_bus_lock(sigma_delta->spi->master);
> +	spi_bus_lock(sigma_delta->spi->controller);
> =C2=A0	sigma_delta->bus_locked =3D true;
> =C2=A0	sigma_delta->keep_cs_asserted =3D true;
> =C2=A0	reinit_completion(&sigma_delta->completion);
> @@ -322,7 +322,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev
> *indio_dev,
> =C2=A0	sigma_delta->keep_cs_asserted =3D false;
> =C2=A0	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
> =C2=A0	sigma_delta->bus_locked =3D false;
> -	spi_bus_unlock(sigma_delta->spi->master);
> +	spi_bus_unlock(sigma_delta->spi->controller);
> =C2=A0	iio_device_release_direct_mode(indio_dev);
> =C2=A0
> =C2=A0	if (ret)
> @@ -387,7 +387,7 @@ static int ad_sd_buffer_postenable(struct iio_dev
> *indio_dev)
> =C2=A0
> =C2=A0	sigma_delta->samples_buf =3D samples_buf;
> =C2=A0
> -	spi_bus_lock(sigma_delta->spi->master);
> +	spi_bus_lock(sigma_delta->spi->controller);
> =C2=A0	sigma_delta->bus_locked =3D true;
> =C2=A0	sigma_delta->keep_cs_asserted =3D true;
> =C2=A0
> @@ -401,7 +401,7 @@ static int ad_sd_buffer_postenable(struct iio_dev
> *indio_dev)
> =C2=A0	return 0;
> =C2=A0
> =C2=A0err_unlock:
> -	spi_bus_unlock(sigma_delta->spi->master);
> +	spi_bus_unlock(sigma_delta->spi->controller);
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}
> @@ -426,7 +426,7 @@ static int ad_sd_buffer_postdisable(struct iio_dev
> *indio_dev)
> =C2=A0
> =C2=A0	ad_sigma_delta_disable_all(sigma_delta);
> =C2=A0	sigma_delta->bus_locked =3D false;
> -	return spi_bus_unlock(sigma_delta->spi->master);
> +	return spi_bus_unlock(sigma_delta->spi->controller);
> =C2=A0}
> =C2=A0
> =C2=A0static irqreturn_t ad_sd_trigger_handler(int irq, void *p)


