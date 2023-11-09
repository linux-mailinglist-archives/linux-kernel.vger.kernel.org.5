Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE65F7E64CF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjKIHzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjKIHzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:55:39 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EE81716;
        Wed,  8 Nov 2023 23:55:37 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9becde9ea7bso349223166b.0;
        Wed, 08 Nov 2023 23:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699516535; x=1700121335; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4DT7KbStmBKIyXguUJVsEhwW3sZLd8u/CViWdFU++us=;
        b=PDzgTFvd+vBIfxWwAaPCtNmC6E9/9arN58U7XKlT67+1m0S8qhNjcl3yj8HGgLYQXb
         eiiumBNylBlJETv+eEhY54Utk6xRCGqKAiZ1vASUuqfRjbP4z/o58w94TBBqW9dWSgeY
         KLrfa7z/mdv3U7J8uzK1TAOLGC7riRbRCm6ScheKHPiUk4Egd1Dy/QPuZ2+2wOSHzwtB
         bAfvnKwuMemfOWcwWAcQg94Veob2Jkb7+6JmhaDmib8CxOTwc+s3W9iZR8+TE7FJtSyY
         VZlfu6JiqnrHFI8VsPY37rQVB09ZduCUilTPjUv+RBAWSlxQ84gAVebF3/CLRQLSE6FS
         d9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699516535; x=1700121335;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4DT7KbStmBKIyXguUJVsEhwW3sZLd8u/CViWdFU++us=;
        b=wfev15Sq+ak0ImmOv/FpaMeDxH0S3SVi8TfsGjC+9ijHLuCJJDszOC5LQowaHHUj+e
         mS/p60TBOTvGkhGblnOw+orToUfQoUmWda0pJiB0AGmTZPHrGk3rIELPGrrSHkGcnDJw
         hRioYjGDwdrMXkp3yRzyaw9N1rX2Db1qlX7Lqqvu5THBJgyT+ZAoHI5jXaQD2831wVaO
         p0BlD3tHMEBSn87/z54BCSmwzrbEyxdxQTUukMjuFjkMVd6LMHKyUWWcpkZecJoMaOMM
         ahpHAEkslMoZmfXThfETS8CH97jVza42erJ6iAnPnx5cGOr/6kbDEevwniXCznXjHM40
         nWFA==
X-Gm-Message-State: AOJu0Yye6Graya7mkQYgjkbin5K5bD6cA3Ttu8NTo1JL17p9yq3dxyYu
        K2mLlEnp2TJBoyGRyET75dw=
X-Google-Smtp-Source: AGHT+IHoZaA0GKZk6O7gCurRmuDoN2dF5sTBZ6TfLPTfaTomNuRl4tfRrqcffYnM+MhuHKNZcDUzIw==
X-Received: by 2002:a17:907:d89:b0:9bd:d405:4e8a with SMTP id go9-20020a1709070d8900b009bdd4054e8amr4394735ejc.17.1699516535329;
        Wed, 08 Nov 2023 23:55:35 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:361b:8f29:1cbf:5e69? (p200300f6ef1b2000361b8f291cbf5e69.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:361b:8f29:1cbf:5e69])
        by smtp.gmail.com with ESMTPSA id bo17-20020a170906d05100b009dddec5a96fsm2234918ejb.170.2023.11.08.23.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 23:55:34 -0800 (PST)
Message-ID: <9b9df9a9dec28ff46fef6df1c482e5a09f338891.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] iio: amplifiers: hmc425a: add support for
 ADRF5740 Attenuator
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Ana-Maria Cusco <anamaria.cuscoo@gmail.com>,
        Ana-Maria Cusco <ana-maria.cusco@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 09 Nov 2023 08:58:30 +0100
In-Reply-To: <20231107132118.1165494-2-anamaria.cuscoo@gmail.com>
References: <20231107132118.1165494-1-anamaria.cuscoo@gmail.com>
         <20231107132118.1165494-2-anamaria.cuscoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-07 at 15:21 +0200, Ana-Maria Cusco wrote:
> From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
>=20
> This adds support for the Analog Devices ADRF5740 2 dB LSB, 4-Bit,
> Silicon Digital Attenuator, 10 MHz to 60 GHz
>=20
> Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> ---
> =C2=A0drivers/iio/amplifiers/hmc425a.c | 23 +++++++++++++++++++++++
> =C2=A01 file changed, 23 insertions(+)
>=20
> diff --git a/drivers/iio/amplifiers/hmc425a.c
> b/drivers/iio/amplifiers/hmc425a.c
> index e87d35d50a95..ed4d72922696 100644
> --- a/drivers/iio/amplifiers/hmc425a.c
> +++ b/drivers/iio/amplifiers/hmc425a.c
> @@ -5,6 +5,7 @@
> =C2=A0 * Copyright 2020 Analog Devices Inc.
> =C2=A0 */
> =C2=A0
> +#include <linux/bitops.h>
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/err.h>
> =C2=A0#include <linux/gpio/consumer.h>
> @@ -22,6 +23,7 @@
> =C2=A0enum hmc425a_type {
> =C2=A0	ID_HMC425A,
> =C2=A0	ID_HMC540S,
> +	ID_ADRF5740
> =C2=A0};
> =C2=A0
> =C2=A0struct hmc425a_chip_info {
> @@ -74,6 +76,10 @@ static int hmc425a_read_raw(struct iio_dev *indio_dev,
> =C2=A0		case ID_HMC540S:
> =C2=A0			gain =3D ~code * -1000;
> =C2=A0			break;
> +		case ID_ADRF5740:
> +			code =3D code & BIT(3) ? code & ~BIT(2) : code;
> +			gain =3D code * -2000;
> +			break;
> =C2=A0		}
> =C2=A0
> =C2=A0		*val =3D gain / 1000;
> @@ -113,6 +119,10 @@ static int hmc425a_write_raw(struct iio_dev *indio_d=
ev,
> =C2=A0	case ID_HMC540S:
> =C2=A0		code =3D ~((abs(gain) / 1000) & 0xF);
> =C2=A0		break;
> +	case ID_ADRF5740:
> +		code =3D (abs(gain) / 2000) & 0xF;
> +		code =3D code & BIT(3) ? code | BIT(2) : code;
> +		break;
> =C2=A0	}
> =C2=A0
> =C2=A0	mutex_lock(&st->lock);
> @@ -165,6 +175,7 @@ static const struct iio_chan_spec hmc425a_channels[] =
=3D {
> =C2=A0static const struct of_device_id hmc425a_of_match[] =3D {
> =C2=A0	{ .compatible =3D "adi,hmc425a", .data =3D (void *)ID_HMC425A },
> =C2=A0	{ .compatible =3D "adi,hmc540s", .data =3D (void *)ID_HMC540S },
> +	{ .compatible =3D "adi,adrf5740", .data =3D (void *)ID_ADRF5740 },
> =C2=A0	{},
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(of, hmc425a_of_match);
> @@ -188,6 +199,15 @@ static struct hmc425a_chip_info hmc425a_chip_info_tb=
l[] =3D
> {
> =C2=A0		.gain_max =3D 0,
> =C2=A0		.default_gain =3D -0x10, /* set default gain -15.0db*/
> =C2=A0	},
> +	[ID_ADRF5740] =3D {
> +		.name =3D "adrf5740",
> +		.channels =3D hmc425a_channels,
> +		.num_channels =3D ARRAY_SIZE(hmc425a_channels),
> +		.num_gpios =3D 4,
> +		.gain_min =3D -22000,
> +		.gain_max =3D 0,
> +		.default_gain =3D 0xF, /* set default gain -22.0db*/
> +	},
> =C2=A0};
> =C2=A0
> =C2=A0static int hmc425a_probe(struct platform_device *pdev)
> @@ -229,6 +249,9 @@ static int hmc425a_probe(struct platform_device *pdev=
)
> =C2=A0	indio_dev->info =3D &hmc425a_info;
> =C2=A0	indio_dev->modes =3D INDIO_DIRECT_MODE;
> =C2=A0
> +	/* Set default gain */
> +	hmc425a_write(indio_dev, st->gain);
> +

This is an unrelated change. It's simple enough to sneak it in but you shou=
ld at
least mention it in the commit message.


With that,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

