Return-Path: <linux-kernel+bounces-72843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C8085B952
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A5128486B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0243265BAB;
	Tue, 20 Feb 2024 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uoq1mVIm"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751F160EE5;
	Tue, 20 Feb 2024 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425694; cv=none; b=Q7wMBHowJluqAT0KhjB7UzDNa6z0q8FK0pRjFCUwSkDqx4Hg6OcF7Enkh5HL4Wwp23msrRA3SP+oFWfDDwJUlvVNcke+gY/gHJBHJ/1zcG4uNkLJJnACpOWtirbrPM7jVUt5d8BPbEi+sXRU4dj3aFromcrk2DCMDHxLiQTZFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425694; c=relaxed/simple;
	bh=/B7Oqp6BZc9jTnP4hA6macWM61pXhIAWVi5ZSwt7fQo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qhn1RqRCUa3hXq0BJpnkTCRWHhM6M6Uxtg2rTIS9QHz1ewvlC9kuC7BL6ZP1daWrrM03RVzpbOAMU9jMVO1S+MSJDdvEls1Het2p+Dsehwd82eP4aQcTyYsrfkZ8sLP+lssVBgdKnYeOBp/tMuOApWwxVzWAD8GL8kwRdNVI7L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uoq1mVIm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412718a8ea7so155495e9.3;
        Tue, 20 Feb 2024 02:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708425691; x=1709030491; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ffOH1itwl3Z/6WXt9S5kShMdP0MfLLwhwAMSm7CnAc=;
        b=Uoq1mVIm62ed0/mg5pyshE0PwPbI+xjrmetFE4fvIUKB+qPUMevdIocw8Ri63/unLO
         xe7UFf4tDutcPE8ujd4DdEBHSxryFFnhwxXnz5zyhALMdNNHqfcNaPn7oxLJxKYYYGA7
         HTat9MvyXhLfU8t9+QMNws+XW5MVHsvnAk9YJvv6IRmFNKTlNz5Jo/3hjHwpuaXB6FB/
         4nPGehWEikU16alESPFU/vlcpi62OvNGgAcB5Ye1+BESTfsa1B3WQh4ooKFKgTL5nKco
         +xr4UWLX/7K2uenUaCaspEgQE+q9vFLYsnm2ORSYDRj82R+hNpmii9JAo9KwyFshUnrO
         h/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708425691; x=1709030491;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ffOH1itwl3Z/6WXt9S5kShMdP0MfLLwhwAMSm7CnAc=;
        b=epggdKV8i08VI0pwQ51XtRdYX0F5Rs6hSgaBvPywMAR3SuYZm/j9Dg/r1FyglDLFH5
         knUZJcqbURWc/wjrUTpZslP/FiV177pUiuwiza68gfsRQWvbSpnHxEiL+4judNjHpYTw
         m0gOd1l75W7HWZRY2mnzcN2ovrphHgYQiPQpiETdiL5YHbREhJDVzdF7/piSkYopE/gr
         bJd1oZKeLkXUod3n9pK/q+EfE/eA4N/m6w2+eDM8Rc5AIPvP6SKvuHHgrlh5I6XalgEH
         RZc6fBXJduvfqq/mX0xLmXmVPQM/w1mZXoMcerutuHN1i3+F4cW5xMxurTCYGZpRoSfV
         87MA==
X-Forwarded-Encrypted: i=1; AJvYcCWkr0JNQUfuiJNpAAAiuSwP2VReh1QaP6amTW0KbmoOyDO1RBulIK6n/zGTPE5kPvR5fDHOMWjtQAX4hHLstoY1xDYz8wTSlhOr3aDG6lPjaCUMfYgreMyIApIfb1NVEnz1M0aXOLDHSvxxQDONAj/EoRUkIl2QeotCSJtGtY8HSZ7o
X-Gm-Message-State: AOJu0YzFYbueD+AHP/sFshCutj5tHdz+PguEqzeljQwf6NEjhckcVd51
	ma2yjcbW3sotRWKsM1QgN4mmA+6iMmVaLhsBPSRImICx4BHxWEGO
X-Google-Smtp-Source: AGHT+IFDrhQX32VSUY+dvsggxvJw3807349WRgyk55H4GHmP6zw0T6olauNngu8d77E6a61PPbdeog==
X-Received: by 2002:a05:6000:1a8a:b0:33d:3a00:554d with SMTP id f10-20020a0560001a8a00b0033d3a00554dmr6111440wry.8.1708425690688;
        Tue, 20 Feb 2024 02:41:30 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id b7-20020adfe647000000b0033b406bc689sm13193409wrn.75.2024.02.20.02.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 02:41:30 -0800 (PST)
Message-ID: <0ec567d7df3632a9c8104485c4207a47e159fdb9.camel@gmail.com>
Subject: Re: [PATCH v2 5/5] iio: adc: ad7380: use spi_optimize_message()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>
Cc: Martin Sperl <kernel@martin.sperl.org>, David Jander
 <david@protonic.nl>,  Jonathan Cameron <jic23@kernel.org>, Michael
 Hennerich <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Alain Volmat <alain.volmat@foss.st.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-iio@vger.kernel.org, Julien
 Stephan <jstephan@baylibre.com>
Date: Tue, 20 Feb 2024 11:41:29 +0100
In-Reply-To: <20240219-mainline-spi-precook-message-v2-5-4a762c6701b9@baylibre.com>
References: 
	<20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
	 <20240219-mainline-spi-precook-message-v2-5-4a762c6701b9@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-19 at 16:33 -0600, David Lechner wrote:
> This modifies the ad7380 ADC driver to use spi_optimize_message() to
> optimize the SPI message for the buffered read operation. Since buffered
> reads reuse the same SPI message for each read, this can improve
> performance by reducing the overhead of setting up some parts the SPI
> message in each spi_sync() call.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> v2 changes:
> - Removed dynamic allocation of spi xfer/msg
> - Moved spi message optimization to probe function
> - Dropped buffer pre/post callbacks
>=20
> =C2=A0drivers/iio/adc/ad7380.c | 36 ++++++++++++++++++++++++++++++------
> =C2=A01 file changed, 30 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index abd746aef868..6b3fd20c8f1f 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -133,6 +133,9 @@ struct ad7380_state {
> =C2=A0	struct spi_device *spi;
> =C2=A0	struct regulator *vref;
> =C2=A0	struct regmap *regmap;
> +	/* xfer and msg for buffer reads */
> +	struct spi_transfer xfer;
> +	struct spi_message msg;
> =C2=A0	/*
> =C2=A0	 * DMA (thus cache coherency maintenance) requires the
> =C2=A0	 * transfer buffers to live in their own cache lines.
> @@ -236,14 +239,9 @@ static irqreturn_t ad7380_trigger_handler(int irq, v=
oid *p)
> =C2=A0	struct iio_poll_func *pf =3D p;
> =C2=A0	struct iio_dev *indio_dev =3D pf->indio_dev;
> =C2=A0	struct ad7380_state *st =3D iio_priv(indio_dev);
> -	struct spi_transfer xfer =3D {
> -		.bits_per_word =3D st->chip_info->channels[0].scan_type.realbits,
> -		.len =3D 4,
> -		.rx_buf =3D st->scan_data.raw,
> -	};
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D spi_sync_transfer(st->spi, &xfer, 1);
> +	ret =3D spi_sync(st->spi, &st->msg);
> =C2=A0	if (ret)
> =C2=A0		goto out;
> =C2=A0
> @@ -335,6 +333,28 @@ static const struct iio_info ad7380_info =3D {
> =C2=A0	.debugfs_reg_access =3D &ad7380_debugfs_reg_access,
> =C2=A0};
> =C2=A0
> +static void ad7380_unoptimize_spi_msg(void *msg)
> +{
> +	spi_unoptimize_message(msg);
> +}
> +
> +static int devm_ad7380_setup_spi_msg(struct device *dev, struct ad7380_s=
tate *st)
> +{
> +	int ret;
> +
> +	st->xfer.bits_per_word =3D st->chip_info->channels[0].scan_type.realbit=
s;
> +	st->xfer.len =3D 4;
> +	st->xfer.rx_buf =3D st->scan_data.raw;
> +
> +	spi_message_init_with_transfers(&st->msg, &st->xfer, 1);
> +
> +	ret =3D spi_optimize_message(st->spi, &st->msg);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to optimize message\n");
> +
> +	return devm_add_action_or_reset(dev, ad7380_unoptimize_spi_msg, &st->ms=
g);
> +}
> +
> =C2=A0static int ad7380_init(struct ad7380_state *st)
> =C2=A0{
> =C2=A0	int ret;
> @@ -411,6 +431,10 @@ static int ad7380_probe(struct spi_device *spi)
> =C2=A0		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to allocate register map\n");
> =C2=A0
> +	ret =3D devm_ad7380_setup_spi_msg(&spi->dev, st);
> +	if (ret)
> +		return ret;
> +
> =C2=A0	indio_dev->channels =3D st->chip_info->channels;
> =C2=A0	indio_dev->num_channels =3D st->chip_info->num_channels;
> =C2=A0	indio_dev->name =3D st->chip_info->name;
>=20


