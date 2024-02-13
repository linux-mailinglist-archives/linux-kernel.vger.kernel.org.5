Return-Path: <linux-kernel+bounces-63262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 868F7852CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3C5289A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B9B249E6;
	Tue, 13 Feb 2024 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtmYBZed"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F3824215;
	Tue, 13 Feb 2024 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817680; cv=none; b=DLUcH/QbG0cFLXysvHm7oMqYkFW2bNrjqSIVJ4BBOE6gz26ouEzQthpmAqwvIN2QvC5QXbUoaV+5rK4D1IgCnv7n6XJbMV3oV5Be2nO3LlwkPCHWUuJNV7xu7MAEgcpvEqgzC7G+4IK/V/HeQQp8bT/jIrkbxBQwjZI54e/dpME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817680; c=relaxed/simple;
	bh=QRvz9k5h/IeCUy3TUDiip0dIvWB+r9Nc+Ypte5fX2YY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=acfz1oO6usikymEFWhfraMO3Bp0a6eEti4xyochw3XYHhPnCgIuFNI6nKBT+J/quqX9/Ul7NT7J7THuTX5FJuYAO6k9QE9dVJyY75kDZHNMW5WVKlzRg+HtytsGBHW/0YPKKGEDhddkDrGNHf6up+9EZVRALGiR4nyDWmiboMbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtmYBZed; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3c309236c1so352213766b.2;
        Tue, 13 Feb 2024 01:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707817677; x=1708422477; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nMaXfRaZB1Ui4wig/pjd3aNv6fO2xjtyP225zQQw8a4=;
        b=EtmYBZedeU4RYMUqcpalDuUHLuSCgbD/N94Mk30Htt1B6gFuftrOy8Ud4HQmfg6qZz
         XQDHdRzv9okcdbvv/2Vy0V4mzQb6DaXMnA4KJnq5/2thB8NMwUr+uVyzU2Rj5I4B6SSQ
         0ceXb1eHnGCNkHU39HzpOTlVXkZlrgggAE0Dh76MAMD1v/fSJjU3tA6U9C7BSkHzNf0f
         5NXCMu3Hs8rdmn4C3d2scHAhPJFLPaPEE7JDKBBH62PGWxFO5VS0vwAze+Nv9rRUayWW
         hN7rpH3Q1jEVINx3x4Y0DHGare9Lrf1QiLHWtlGhTt9Cn2HsI3JzvQAC7FOGKWTS+XMm
         Hwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707817677; x=1708422477;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nMaXfRaZB1Ui4wig/pjd3aNv6fO2xjtyP225zQQw8a4=;
        b=t2j1EOiyb4mJUnKMEXpRYlxdUcgNgoqM+u4Nsw49AQKt4qGvKjJJlgevP9RwAyDn78
         9Jwd79w2umb2NolPa7rHumJ8hxoc9p3ciRiAcIkPS1GW4yJ6PWNU/PAXLAdrf+to+F9W
         cRgiuR1SNPddWc4cs+NI1AOTgKzNJ2CEs672EQqwERJ2BKallOi84GqcFl2ReQ7L0pOx
         IUH4EBdKukjJZFh8Yt/yoqN6Lr8CN6rmoM3refpyWjjjy9ODmFR8tbRDmRGi37QTNFm+
         jChgIxNsydMV1zZ33qm98UXJ2Qa8Fl4DthBlo0x51+tI8OQxV/j12QaKi30IYHwCRRFM
         /4Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUKtt13qopaoiLBSOtA4BN4k0n0yaffg8Lb2FxfuAGfeahrtPk84nVWEjlKiPKw9d/+qRCkC1TUiNfE12sMs3iw5jFxRaHsv9jPO/5S0PyxZcqE9WAMMoRtgy4rqwn7U8BWrVJ9flpSgL0dqADTRG2/7tuTuqpA4qF4T7r61fDnOwZs
X-Gm-Message-State: AOJu0YwhtMi8J2HeM+mU+PhUQs2Us8dEjwonjH0kMmYc2yjqgY3K6lUQ
	4GjWhru8UiMkfXcIdWOJP8PbqPNDNekVTUtCiqjtd4I4syWVVa5T
X-Google-Smtp-Source: AGHT+IEY9GonQD/xWOqpsBEOt4y93Mfor49QxCWI0jOVlg6uODaZXNkzggCVUKUwtT/B8Oo/+cxXbQ==
X-Received: by 2002:a17:906:7116:b0:a3c:e436:d114 with SMTP id x22-20020a170906711600b00a3ce436d114mr1728171ejj.30.1707817676549;
        Tue, 13 Feb 2024 01:47:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+fiCsGVuZsVyYFzEaTqEywRi/vEqX6uvvUXD5siGAuywmoKLuGLqrtXTJZPhmuJpuyDfTa3K819AQwa581QG5A7+X0D30FgXRRYMbxfGczms7fdBB0PR1uQEsDpkIrdWHXqLqdq8hhSseC0v4+BY85Dckwiyk/0eYQq8eoOHySjxeAjfMZg3z+HOB4g4F+7Xll1+sLgf1zgD6GeV90HbP/PqJucQzX2zd5cLnlWBpUhYqaiyjrJqnRCp3kuAzUFG2f3ty7pRuY4YPp4lT5w5nRFjbaNaVv4mc4d6oKFSUfuQZQ2pxyGHVJJTe6CipGDn3hn91pc1V6V0x7wpaxOKMpMmcBe7qBdz+TIvtC19Wh3xjXeAwrzLuyUEaMvWocCeX7iLJ/pJ3CeLkEoWXtp3v1MbNQfTcDqu2A6hjsIuPcNW4KFOMz788IflOqYkjDEDlz60lOgFF3UH8SoQfGEdyIn+CQE1q2rd/FjtQeopa4QkfywxEArM+OMVRAJRZd4s7/oH8Ucc+kNUtYrxLeFX5
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id br18-20020a170906d15200b00a38a868bcf7sm1112046ejb.41.2024.02.13.01.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:47:56 -0800 (PST)
Message-ID: <c06dfa1ecf88b07ef467ad7c08667d0cab400613.camel@gmail.com>
Subject: Re: [PATCH 5/5] iio: adc: ad7380: use spi_optimize_message()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>
Cc: Martin Sperl <kernel@martin.sperl.org>, David Jander
 <david@protonic.nl>,  Jonathan Cameron <jic23@kernel.org>, Michael
 Hennerich <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Alain Volmat <alain.volmat@foss.st.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-iio@vger.kernel.org
Date: Tue, 13 Feb 2024 10:51:15 +0100
In-Reply-To: <20240212-mainline-spi-precook-message-v1-5-a2373cd72d36@baylibre.com>
References: 
	<20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
	 <20240212-mainline-spi-precook-message-v1-5-a2373cd72d36@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-12 at 17:26 -0600, David Lechner wrote:
> This modifies the ad7380 ADC driver to use spi_optimize_message() to
> optimize the SPI message for the buffered read operation. Since buffered
> reads reuse the same SPI message for each read, this can improve
> performance by reducing the overhead of setting up some parts the SPI
> message in each spi_sync() call.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> =C2=A0drivers/iio/adc/ad7380.c | 52 +++++++++++++++++++++++++++++++++++++=
++++------
> -
> =C2=A01 file changed, 45 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index abd746aef868..5c5d2642a474 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -133,6 +133,7 @@ struct ad7380_state {
> =C2=A0	struct spi_device *spi;
> =C2=A0	struct regulator *vref;
> =C2=A0	struct regmap *regmap;
> +	struct spi_message *msg;
> =C2=A0	/*
> =C2=A0	 * DMA (thus cache coherency maintenance) requires the
> =C2=A0	 * transfer buffers to live in their own cache lines.
> @@ -231,19 +232,55 @@ static int ad7380_debugfs_reg_access(struct iio_dev
> *indio_dev, u32 reg,
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> +static int ad7380_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad7380_state *st =3D iio_priv(indio_dev);
> +	struct spi_transfer *xfer;
> +	int ret;
> +
> +	st->msg =3D spi_message_alloc(1, GFP_KERNEL);
> +	if (!st->msg)
> +		return -ENOMEM;
> +
> +	xfer =3D list_first_entry(&st->msg->transfers, struct spi_transfer,
> +				transfer_list);
> +
> +	xfer->bits_per_word =3D st->chip_info->channels[0].scan_type.realbits;
> +	xfer->len =3D 4;
> +	xfer->rx_buf =3D st->scan_data.raw;
> +
> +	ret =3D spi_optimize_message(st->spi, st->msg);
> +	if (ret) {
> +		spi_message_free(st->msg);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad7380_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ad7380_state *st =3D iio_priv(indio_dev);
> +
> +	spi_unoptimize_message(st->msg);
> +	spi_message_free(st->msg);
> +
> +	return 0;
> +}
> +

Not such a big deal but unless I'm missing something we could have the
spi_message (+ the transfer) statically allocated in struct ad7380_state an=
d do
the optimize only once at probe (naturally with proper devm action for
unoptimize). Then we would not need to this for every buffer enable + disab=
le. I
know in terms of performance it won't matter but it would be less code I gu=
ess.

Am I missing something?

- Nuno S=C3=A1


