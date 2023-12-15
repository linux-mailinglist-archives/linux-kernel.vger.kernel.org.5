Return-Path: <linux-kernel+bounces-1424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38437814EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EC028748E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C461482ED2;
	Fri, 15 Dec 2023 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0b+fpO2r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7453010A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2c9f85eff28so12660531fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 09:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702661517; x=1703266317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13gliIVcQbLU7hKnOSD6BJq01ueaRAAu4jm5L+NVTns=;
        b=0b+fpO2rkETJEdiGFDBfneuXk59LoQQyQ3OsOBqPNdHwU4D67rH7OZWW1DU/EOzYNU
         ly2Mb3bDAJ+m/zQ37+1iFUpxwodVL9zr5kRXaD0e1D7QNzZEay85FSTYouLFo7bbDjvj
         AVJBD7pq1XT9twqiF5GsgYy1yhZvEbv0x8TxndhEvSoexLQzNN6okGpO9oRv5FzzjxBQ
         3am0bk4jCIQ9Je7tA6o07osbp4ZS6xL2U1LGCO2vQ8ysq3Zf9ysZnjyb2tVMuk+Icn2I
         kZxtFv8bBEYm7HujV4hXI1/1Gn6SQOjfhKRkquylMSWzBe++G66HVIPM0WXIZBq4NVWg
         KjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702661517; x=1703266317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13gliIVcQbLU7hKnOSD6BJq01ueaRAAu4jm5L+NVTns=;
        b=XXJDHObtX3pflhdC93fWuJlH9B3dwTgWnyVRVBrGZAoZIkG0hOJx6/vUjjT17t1pww
         lIYbkNyDwsSFS0Z88gnp8tHcTpzb0BpR/l49hNnfVRl4cpO/MrpuR2gqDl7/A5pmLc3j
         3PnrrKR+LrH2Pr0AAYyw2v3GbQ3kgoHdt5cBdaQdmmp5c0cyZiqUsRdaMAk/Qc9eZwX8
         5Zsz44WtVe6beLQomJILT8/RdtwX02O6sQB3V/eTUHDQI6VBny3vXkQJqDzrLNlcKv8j
         GL/TylWOlzv7TyxCUowLrN+ub9KMFz5uoyCSoJFXSJzbyfHnnAmzcTwQ0nHeVO1wWa1w
         LYqA==
X-Gm-Message-State: AOJu0YxDuWxvw/Wi1+VgdE78vyy7kv/42s0QFD8NLNxYKhXfCLf4rabI
	a70Usj2CgZVs/trciBxjiHzyiaOltZM9DJoicAI96w==
X-Google-Smtp-Source: AGHT+IFxmmKUPom/holribS2VHUERs+Ifa/Hn3mwBjJChRW4DE+E8HwHzNK/uqopAZogvwI1KxYaH/zKVAEN73mIK7g=
X-Received: by 2002:a05:651c:220b:b0:2cc:1c1f:a895 with SMTP id
 y11-20020a05651c220b00b002cc1c1fa895mr5329917ljq.22.1702661517493; Fri, 15
 Dec 2023 09:31:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com>
 <20231215-ad7380-mainline-v3-3-7a11ebf642b9@baylibre.com> <66e9fe7a-927b-465f-aafe-8aea0e5998a4@wanadoo.fr>
In-Reply-To: <66e9fe7a-927b-465f-aafe-8aea0e5998a4@wanadoo.fr>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 15 Dec 2023 18:31:46 +0100
Message-ID: <CAMknhBEPxYtZps2cFk0ZPckbcHenXJ_v4Dv+82ENg47J52gHxQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iio: adc: ad7380: new driver for AD7380 ADCs
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: broonie@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com, 
	robh+dt@kernel.org, stefan.popa@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 5:53=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 15/12/2023 =C3=A0 11:32, David Lechner a =C3=A9crit :
> > This adds a new driver for the AD7380 family ADCs.
> >
> > The driver currently implements basic support for the AD7380, AD7381,
> > AD7383, and AD7384 2-channel differential ADCs. Support for additional
> > single-ended and 4-channel chips that use the same register map as well
> > as additional features of the chip will be added in future patches.
> >
> > Co-developed-by: Stefan Popa <stefan.popa-OyLXuOCK7orQT0dZR+AlfA@public=
.gmane.org>
> > Signed-off-by: Stefan Popa <stefan.popa-OyLXuOCK7orQT0dZR+AlfA@public.g=
mane.org>
> > Reviewed-by: Nuno Sa <nuno.sa-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> > Signed-off-by: David Lechner <dlechner-rdvid1DuHRBWk0Htik3J/w@public.gm=
ane.org>
> > ---
>
> ...
>
> > +static void ad7380_regulator_disable(void *p)
> > +{
> > +     regulator_disable(p);
> > +}
> > +
> > +static int ad7380_probe(struct spi_device *spi)
> > +{
> > +     struct iio_dev *indio_dev;
> > +     struct ad7380_state *st;
> > +     int ret;
> > +
> > +     indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     st =3D iio_priv(indio_dev);
> > +     st->spi =3D spi;
> > +     st->chip_info =3D spi_get_device_match_data(spi);
> > +     if (!st->chip_info)
> > +             return dev_err_probe(&spi->dev, -EINVAL, "missing match d=
ata\n");
> > +
> > +     st->vref =3D devm_regulator_get_optional(&spi->dev, "refio");
>
> Hi,
>
> devm_regulator_get_enable_optional()?
> to save some LoC below and ad7380_regulator_disable()

It would be nice if we could, but we need the pointer to the regulator
to read the voltage of the regulator (it is the reference voltage for
an ADC). So we can't use devm_regulator_get_enable_optional() because
it only an int and not the pointer to the regulator.

>
> CJ
>
> > +     if (IS_ERR(st->vref)) {
> > +             /*
> > +              * If there is no REFIO supply, then it means that we are=
 using
> > +              * the internal 2.5V reference.
> > +              */
> > +             if (PTR_ERR(st->vref) =3D=3D -ENODEV)
> > +                     st->vref =3D NULL;
> > +             else
> > +                     return dev_err_probe(&spi->dev, PTR_ERR(st->vref)=
,
> > +                                          "Failed to get refio regulat=
or\n");
> > +     }
> > +
> > +     if (st->vref) {
> > +             ret =3D regulator_enable(st->vref);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D devm_add_action_or_reset(&spi->dev, ad7380_regula=
tor_disable,
> > +                                            st->vref);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     st->regmap =3D devm_regmap_init(&spi->dev, NULL, st, &ad7380_regm=
ap_config);
> > +     if (IS_ERR(st->regmap))
> > +             return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
> > +                                  "failed to allocate register map\n")=
;
> > +
> > +     indio_dev->channels =3D st->chip_info->channels;
> > +     indio_dev->num_channels =3D st->chip_info->num_channels;
> > +     indio_dev->name =3D st->chip_info->name;
> > +     indio_dev->info =3D &ad7380_info;
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +     indio_dev->available_scan_masks =3D ad7380_2_channel_scan_masks;
> > +
> > +     ret =3D devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> > +                                           iio_pollfunc_store_time,
> > +                                           ad7380_trigger_handler, NUL=
L);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D ad7380_init(st);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return devm_iio_device_register(&spi->dev, indio_dev);
> > +}
>
> ...
>

