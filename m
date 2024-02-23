Return-Path: <linux-kernel+bounces-78451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4BA8613B5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E791F22AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335D380BE4;
	Fri, 23 Feb 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGJ2F8h0"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DABD7F46E;
	Fri, 23 Feb 2024 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697568; cv=none; b=apFq1g1M6WGcx5rXRmapiLVhKmxMs7+KyEKXZjANUes0x8giwTN0uQ5nYKKC1tP7vnc8Ys59yeSIRaawmAHT/IQU+tWosbJqGae9Yq1R5xeK26KBk4sfbw7bQU70Tb7hUU9SkeNktlYFGaN4FS9P3T+sVb8sh8ZUdBockoz/yWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697568; c=relaxed/simple;
	bh=bUlp46Zm9bHTWoStRR28lGnePyraKkEGReXUW7v5XGA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mw0zZYQG4+VW0sNpD+WN6NSqHScktRSYqKHK8PCoX+Xy6BP3bl7Schgp21iUY8ohTM6Cm1zUl4GvmMzPBMeqMrz9djDp8ntoinqUchjUKFU8Uzqq3j5jKk2S1ekyV0BJd5kP+Irvc1Ke4n9oiL9pJISSv7BtWpTUxGPrHxXR6+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGJ2F8h0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41294136c27so3593935e9.3;
        Fri, 23 Feb 2024 06:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708697564; x=1709302364; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P4gYPQDKRW28f/+Hb98TaIICcu3K1spSmQnj/lPb0BY=;
        b=cGJ2F8h0FLbwYerfoOvThEPAieJFAPxsC50iB5V8ikb1/fXNXLo2FJhv4gU2ba6XwN
         6eSkFddNlxNwBlv71zPLL/+4b5w9zVtODxx99FTxCfH2iZ2t1TVHAXeXGbyDmICF5Zn7
         9b8Y2oiijgTSzgyJRMppSs2TtVgMGj/8BezYwGcIVxpfzbVEmompGXdcKNuyVTegtDeM
         /ORgxFYi/bHm/CwHIEaixWSOIydH31pKwdJWZFdlAnR/dPq2hyPoLfHYZyBevg0bzPOI
         s/jygUwwM31tsnDb1Ckc7DkakTuQh+UQWZmdD1uew3Z7AnWltKclJW8MyaoacTpi2j5r
         DAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708697564; x=1709302364;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P4gYPQDKRW28f/+Hb98TaIICcu3K1spSmQnj/lPb0BY=;
        b=MF643JJQTNHcRLUz2xagM6/RBVHHzQxglF0O1Ijnavt28QsRSkHTQZN3OY9UDB2ar1
         JLS63VJbiwN/FJlqEXd11JgySgJNXR0qnaWOwf3oyA302wzRGtbsuj4uMkrEBW45yX4t
         HMsH7iDbuz0/I+fblf5Eh2IUDsbleSZ05GP4xym0TTa6S9P7PZQ/kxKmpN6QQ1j+SciS
         0Cu46SHaF6wrsohwYtRHb0SagqZJQC2vLuc/DgCC0MdtTkA1lifNU/0ZK0O/NRuFzkmP
         X1qV8fjSnYxk2TJhqbJ52CXVftadnMFryVRRQXqGaMyyUzJhbH8pQzndO5+Eu86yH0xh
         wzaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/xxRvilrz7PRhsjaeoSXOfjJuFImn8TsHUqsWKO2KkvOn8z10TGDRmIKsrtEKOXT/98heZ2bPGahIFXr69AbWmAyWPbvAcCgeqolwsvOh3U7JnLyyH/D3SHu1Mv0X66bTQ4FFAofaYN9N76NKlepaxIPyDTtHdM4na7FkYQrUBnpxTjmg4zWqZR6DFlqPh5br4D0YX6e+MHHZVsIyFag=
X-Gm-Message-State: AOJu0YztRbS6PnU7+WjkeI85/1i/Ksex9eMqHSUSsaHx1C2APlZjx0yb
	s85UTWgrvWZ80ty5og0t1wusmpvmbISQOrDAt8xc/IVMpVNcEdci
X-Google-Smtp-Source: AGHT+IGLF41VZJ8Eg25oa4IAtL3SpllI6mhpkk3XR+mCfxtVp291bgmLEnl5sysU9tZOQZw7+WctnQ==
X-Received: by 2002:adf:fd81:0:b0:33d:2710:b424 with SMTP id d1-20020adffd81000000b0033d2710b424mr1590190wrr.22.1708697564206;
        Fri, 23 Feb 2024 06:12:44 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id u2-20020a056000038200b0033db0bbc2ccsm1313636wrf.3.2024.02.23.06.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 06:12:43 -0800 (PST)
Message-ID: <b08539f4afdceeb5a0d675113734f6f2f402a311.camel@gmail.com>
Subject: Re: [PATCH v15 2/3] iio: adc: ad_sigma_delta: Add optional irq
 selection
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org, 
 linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Jonathan
 Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Michael Walle <michael@walle.cc>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>,  ChiaEn Wu
 <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard
 =?ISO-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>, Mike Looijmans
 <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, David Lechner <dlechner@baylibre.com>, Ceclan
 Dumitru <dumitru.ceclan@analog.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 23 Feb 2024 15:16:04 +0100
In-Reply-To: <20240223133758.9787-2-mitrutzceclan@gmail.com>
References: <20240223133758.9787-1-mitrutzceclan@gmail.com>
	 <20240223133758.9787-2-mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-23 at 15:37 +0200, Dumitru Ceclan wrote:
> Add optional irq_num attribute to ad_sigma_delta_info structure for
> selecting the used interrupt line for ADC's conversion completion.
>=20
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> V15->V14
> =C2=A0- Uppercase ADC acronym in commit message
> =C2=A0- Rename irq_num to irq_line, change type to int
> V13->V14
> =C2=A0- Invert logic checking the presence of the optional irq_num attrib=
ute
> V1->V12
> <Not present>
> =C2=A0drivers/iio/adc/ad_sigma_delta.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 23 ++++++++++++++---------
> =C2=A0include/linux/iio/adc/ad_sigma_delta.h |=C2=A0 3 +++
> =C2=A02 files changed, 17 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad_sigma_delta.c
> b/drivers/iio/adc/ad_sigma_delta.c
> index 7e2192870743..03c170b638a8 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -222,11 +222,11 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_de=
lta,
> =C2=A0		goto out;
> =C2=A0
> =C2=A0	sigma_delta->irq_dis =3D false;
> -	enable_irq(sigma_delta->spi->irq);
> +	enable_irq(sigma_delta->irq_line);
> =C2=A0	timeout =3D wait_for_completion_timeout(&sigma_delta->completion, =
2 *
> HZ);
> =C2=A0	if (timeout =3D=3D 0) {
> =C2=A0		sigma_delta->irq_dis =3D true;
> -		disable_irq_nosync(sigma_delta->spi->irq);
> +		disable_irq_nosync(sigma_delta->irq_line);
> =C2=A0		ret =3D -EIO;
> =C2=A0	} else {
> =C2=A0		ret =3D 0;
> @@ -295,7 +295,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev
> *indio_dev,
> =C2=A0	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_SINGLE);
> =C2=A0
> =C2=A0	sigma_delta->irq_dis =3D false;
> -	enable_irq(sigma_delta->spi->irq);
> +	enable_irq(sigma_delta->irq_line);
> =C2=A0	ret =3D wait_for_completion_interruptible_timeout(
> =C2=A0			&sigma_delta->completion, HZ);
> =C2=A0
> @@ -315,7 +315,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev
> *indio_dev,
> =C2=A0
> =C2=A0out:
> =C2=A0	if (!sigma_delta->irq_dis) {
> -		disable_irq_nosync(sigma_delta->spi->irq);
> +		disable_irq_nosync(sigma_delta->irq_line);
> =C2=A0		sigma_delta->irq_dis =3D true;
> =C2=A0	}
> =C2=A0
> @@ -396,7 +396,7 @@ static int ad_sd_buffer_postenable(struct iio_dev
> *indio_dev)
> =C2=A0		goto err_unlock;
> =C2=A0
> =C2=A0	sigma_delta->irq_dis =3D false;
> -	enable_irq(sigma_delta->spi->irq);
> +	enable_irq(sigma_delta->irq_line);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0
> @@ -414,7 +414,7 @@ static int ad_sd_buffer_postdisable(struct iio_dev
> *indio_dev)
> =C2=A0	wait_for_completion_timeout(&sigma_delta->completion, HZ);
> =C2=A0
> =C2=A0	if (!sigma_delta->irq_dis) {
> -		disable_irq_nosync(sigma_delta->spi->irq);
> +		disable_irq_nosync(sigma_delta->irq_line);
> =C2=A0		sigma_delta->irq_dis =3D true;
> =C2=A0	}
> =C2=A0
> @@ -516,7 +516,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, voi=
d *p)
> =C2=A0irq_handled:
> =C2=A0	iio_trigger_notify_done(indio_dev->trig);
> =C2=A0	sigma_delta->irq_dis =3D false;
> -	enable_irq(sigma_delta->spi->irq);
> +	enable_irq(sigma_delta->irq_line);
> =C2=A0
> =C2=A0	return IRQ_HANDLED;
> =C2=A0}
> @@ -586,9 +586,9 @@ static int devm_ad_sd_probe_trigger(struct device *de=
v,
> struct iio_dev *indio_de
> =C2=A0	sigma_delta->irq_dis =3D true;
> =C2=A0
> =C2=A0	/* the IRQ core clears IRQ_DISABLE_UNLAZY flag when freeing an IRQ=
 */
> -	irq_set_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
> +	irq_set_status_flags(sigma_delta->irq_line, IRQ_DISABLE_UNLAZY);
> =C2=A0
> -	ret =3D devm_request_irq(dev, sigma_delta->spi->irq,
> +	ret =3D devm_request_irq(dev, sigma_delta->irq_line,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad_sd_data_rdy_trig_poll,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sigma_delta->info->irq_flag=
s | IRQF_NO_AUTOEN,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->name,
> @@ -668,6 +668,11 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, s=
truct
> iio_dev *indio_dev,
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> +	if (info->irq_line)
> +		sigma_delta->irq_line =3D info->irq_line;
> +	else
> +		sigma_delta->irq_line =3D spi->irq;
> +
> =C2=A0	iio_device_set_drvdata(indio_dev, sigma_delta);
> =C2=A0
> =C2=A0	return 0;
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h
> b/include/linux/iio/adc/ad_sigma_delta.h
> index 7852f6c9a714..576eb617939d 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -45,6 +45,7 @@ struct iio_dev;
> =C2=A0 * @data_reg: Address of the data register, if 0 the default addres=
s of 0x3
> will
> =C2=A0 *=C2=A0=C2=A0 be used.
> =C2=A0 * @irq_flags: flags for the interrupt used by the triggered buffer
> + * @irq_line: IRQ for reading conversions. If 0, spi->irq will be used
> =C2=A0 * @num_slots: Number of sequencer slots
> =C2=A0 */
> =C2=A0struct ad_sigma_delta_info {
> @@ -60,6 +61,7 @@ struct ad_sigma_delta_info {
> =C2=A0	unsigned int data_reg;
> =C2=A0	unsigned long irq_flags;
> =C2=A0	unsigned int num_slots;
> +	int irq_line;
> =C2=A0};
> =C2=A0
> =C2=A0/**
> @@ -87,6 +89,7 @@ struct ad_sigma_delta {
> =C2=A0	unsigned int		active_slots;
> =C2=A0	unsigned int		current_slot;
> =C2=A0	unsigned int		num_slots;
> +	int		irq_line;
> =C2=A0	bool			status_appended;
> =C2=A0	/* map slots to channels in order to know what to expect from devi=
ces
> */
> =C2=A0	unsigned int		*slots;


