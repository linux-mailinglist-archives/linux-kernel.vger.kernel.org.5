Return-Path: <linux-kernel+bounces-57592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEDB84DB21
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F056B222A0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B74A6A031;
	Thu,  8 Feb 2024 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9LY/bZU"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27AB6A02A;
	Thu,  8 Feb 2024 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380004; cv=none; b=ODIFGeT1ZS20Im3rJQOesGl+3+RicUgSsDUbd/vVa14JES9ayhtmBnGIg9x/UBpdGYKgoGPgSrgM5GQBsdjK1Memr4dkItfB0MKRZJYT69vnuSkK0U3guQuJbMUDwMCFeytNDvTNCJC7o0AxkQzquKpPc6JIOcfbb3TGQo/qeIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380004; c=relaxed/simple;
	bh=UA3stFUK+sZfYhD7A+md4yAd+YohoJN0Hxu+7GRCgYU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OBqC+7Qh+RmcqWHXmS4njTIJh78ygR8Is+woW32y4mEhv5pM40JOE6yKwkbAXzjm5GAiIMjq9dlmamxGvtFLNSGtmJmC8UbOE3wzKXebGmtSpFpQRfdukHNB2YPCJnuBDXqRTvqgSiWXoFo/amNXDrOLgJFaIGBICa3cxy3z2RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9LY/bZU; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3bbad234feso4148666b.0;
        Thu, 08 Feb 2024 00:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707380001; x=1707984801; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g4/0jxeBtg+1MnJB8RP6rWrTRP1J3ZwXZrPm0MzHNP4=;
        b=E9LY/bZU2Iwo2K3hrKH9AaSaRSUgQ+KpFApG1vLmP7DtypwIDYFSjRD4hEBhNePG2K
         NUomOBmTcIxbiExMVdSXh1EVcqRSGRKLaaeg4y4kMv5EAcc0xL2t4os68ldP52qjA6kd
         8lWTrD2/Qy1dYeKBTx5tE+jqmNvUdfPTLX1jI/Vgsa4ioTFhdYwCG0Oe1dMYC/bJ14dt
         1qR5l4sn74wsFyhwFexANNlbCW/vEJrUkwAt8WhU+AdaaEu7VR+/qpsC1dJZ+88AGWVc
         hzLTjl0DeucxYccofU4UEq7PRnwoI6UY0QyY8mlolP8abHKrbOh64D/nHt0r9ilkygC2
         u3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707380001; x=1707984801;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g4/0jxeBtg+1MnJB8RP6rWrTRP1J3ZwXZrPm0MzHNP4=;
        b=iwGC6b61PWAiLJv0Q3c/GSGqVCVGuT6WW/0+SEi7rqQqOAOQRFrMjd1ZvpDVihXV8a
         rKO2NYCTGnWcVO5xyIKF/3D5wdID2HH2ZAINGCv6I/ib/WGMIVMJHJ4CbASW3vvpV/9e
         qLeGx0/TrASLOgjyOzf9gs+fvLWo7m2tmmgJi86IDRAvDXtiQzfESR2UNYeB5Rt7G2Wp
         tNAOTodhkwmhYpVK569k1tN50CpeJW8xJ0gkJO3PkmFjho+1u+aKBSB+NwRnUp7CvpR1
         qLMDOs+ATUph5mx/erOANAq9GCui/UzEo8GoibavPfmrVsPfgReKTIqTxNX0aXjYpBVq
         CR0g==
X-Forwarded-Encrypted: i=1; AJvYcCWXIQBQgGNJJnnGvgoEZFGcpPY6nzpO5odef9wjx/ewAYD3vWforZpWP6iT9Va4lcuH+6BSoA6bSnr+i0XS5g2zI2i9hhuTQn++xpaMXdXIXLTmaalLV7WoZTEKJSf+othX+UIWhORI
X-Gm-Message-State: AOJu0Yx0PQ8SUhQo0FyY1webHohSC/GJyYbQ0187YPFlXbIlbEy286mN
	m12QvIES2ytzpURG/fznj0wezymE4jYLriP3+rftnIL9uDl7tGmq
X-Google-Smtp-Source: AGHT+IHF8hU0HVhoHVIDa9BaERNcuAZDY4B51LbUZjy59wyvjtBk8rLRnNxaYNNV/Zsyar9iZwvX1Q==
X-Received: by 2002:a17:906:d18b:b0:a38:2ad:e458 with SMTP id c11-20020a170906d18b00b00a3802ade458mr6052847ejz.29.1707380000780;
        Thu, 08 Feb 2024 00:13:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeKNciW2HDH2t2H/zs0TRFs9TI7wyQeVuve4B5WEzHAFwN+lg8myPUvjE0iOVtP8ZeFV+zwCTIUvyVRDPiFPFetL01TORpcBi6Fijl2a35EjCu7gVx5Iq62fGIo+GjT9M4jrfnENwp9K7BrDrW/txHy4B81d7fxcmZ2QES3YrKkxd8H0fJXAZR/mjk/Zms+Bp9IGdRYrJCsxkh1f8etPHntTA9P0E/Rifv+VeLMeKgXuLl+vZi0o31U48jcOTOeh9Kpvg=
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id qo8-20020a170907874800b00a2b1a20e662sm1641368ejc.34.2024.02.08.00.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 00:13:20 -0800 (PST)
Message-ID: <4eb13d801cd227e8682f10804025f5b6da2dfafc.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad4130: only set GPIO_CTRL if pin is
 unused
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Cosmin Tanislav <demonsingur@gmail.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron
	 <jic23@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Feb 2024 09:16:39 +0100
In-Reply-To: <20240207132007.253768-2-demonsingur@gmail.com>
References: <20240207132007.253768-1-demonsingur@gmail.com>
	 <20240207132007.253768-2-demonsingur@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-07 at 15:20 +0200, Cosmin Tanislav wrote:
> Currently, GPIO_CTRL bits are set even if the pins are used for
> measurements.
>=20
> GPIO_CTRL bits should only be set if the pin is not used for
> other functionality.
>=20
> Fix this by only setting the GPIO_CTRL bits if the pin has no
> other function.
>=20
> Fixes: 62094060cf3a ("iio: adc: ad4130: add AD4130 driver")
> Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4130.c | 10 +++++++---
> =C2=A01 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
> index c7df499f9775..febb64e67955 100644
> --- a/drivers/iio/adc/ad4130.c
> +++ b/drivers/iio/adc/ad4130.c
> @@ -1864,10 +1864,14 @@ static int ad4130_setup(struct iio_dev *indio_dev=
)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	/*
> -	 * Configure all GPIOs for output. If configured, the interrupt
> function
> -	 * of P2 takes priority over the GPIO out function.
> +	 * Configure unused GPIOs for output. If configured, the interrupt
> +	 * function of P2 takes priority over the GPIO out function.
> =C2=A0	 */
> -	val =3D=C2=A0 AD4130_IO_CONTROL_GPIO_CTRL_MASK;
> +	val =3D 0;
> +	for (i =3D 0; i < AD4130_MAX_GPIOS; i++)
> +		if (st->pins_fn[i + AD4130_AIN2_P1] =3D=3D AD4130_PIN_FN_NONE)
> +			val |=3D FIELD_PREP(AD4130_IO_CONTROL_GPIO_CTRL_MASK,
> BIT(i));
> +
> =C2=A0	val |=3D FIELD_PREP(AD4130_IO_CONTROL_INT_PIN_SEL_MASK, st-
> >int_pin_sel);
> =C2=A0
> =C2=A0	ret =3D regmap_write(st->regmap, AD4130_IO_CONTROL_REG, val);


