Return-Path: <linux-kernel+bounces-148974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 091F28A89EB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E70285DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C335171670;
	Wed, 17 Apr 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlWIee21"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35117109B;
	Wed, 17 Apr 2024 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373756; cv=none; b=jmIyR2rfksrmltuOEYXnC/+1fYZ5dp4YF/jrCfK4rkzWduBNQxdXAakaNUBOdRit7EI3yUMrT9gTgcmMYdinyRmtHVOUe+9mUQk3hrT65mSerYj53XphHxmjJLm4s+i3ZPTLe1ZMCPpJKgKgWAjQxnJVuGtrZ2fPY7YBvELLCBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373756; c=relaxed/simple;
	bh=9crrGJWSO/pmgfGBhncc5oXIfUwpP6oo0bwAmhis4mY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lbz/C7FjaVwJn5FNj4+C2DXfFSOGOjA5ZrFDcc3t5y4RAiaj/y3tX9AeNDLP3zBFjZfvGpqJgbfX1ilC+ZkQ0FCJSvCFvWrk7U0pfOeKZkfSSpvO3DPtYYfTLbLFFin4L/wc380lPeOt0WBrqQDBrbSY3FoQTVSuxHwNjYYnLsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlWIee21; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a555b203587so108472766b.3;
        Wed, 17 Apr 2024 10:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713373754; x=1713978554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPwBYmncLO39M6iuxDIL5VGVqta8zUBMbRZjwo+JNAI=;
        b=VlWIee21uT0QrqUl9xZO7cAsP8jC1gn9p6/fo8r80y8Tfo5WRSXX5vSoaE4YeKlJFF
         WD6HaHrPcaGDYA/4cHnv9NO7mf2XlNsSX/SOTuWYG6s1uqC9c60mjX7StNYZ0kxdWdHd
         RdAEkTXrlFA38m8l8owhwexvzaSJhw+tt+y3QgXXxdV+bFEJESsgsNhfc76C85C/BeK/
         QRkWJ7s0ZLjzRNKpQf1Rso6Z8H2Vg7Qn1rd+r8JTVfMQ8fWN/nmh9PvDWyI/NoyTm80v
         M62bceD6o/4KQgjAKbjO2LupRBgw8TVm+ACMPb7xw9Xt/PLU0Vtp3IM+FkInonQUTFAp
         bNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373754; x=1713978554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPwBYmncLO39M6iuxDIL5VGVqta8zUBMbRZjwo+JNAI=;
        b=fxcNwGRXMz9T3SIQBkjszmMLUrVrzVHugqzwp8MZR2fZPi+7ERVnq6E/HKs/tlnn0u
         VHXPw3jk5oInLerDvdFJokmE2YAYqhEU4c1quFfXPeW3Pbpgz8gefcxBxagZfvWvtY+M
         IH5EirX/EVnKPdjAvRM4P58XvGISyCSxrAsJPlHLq9HwTYdkCRLuIIKid+ghaTx3ccF/
         +uCiDezSPBcRAEgRwfgpQ2kurV6aDJz/scUlvDqFHQOMJvFjhSRM0RGgcsBlnYT0SeE6
         hXJYsNyev+7Bglm8P26noVgUwq07uLE//ikh22ecw7VtRzKvsCM6M2WT8QXi+dyTPHyY
         hfVA==
X-Forwarded-Encrypted: i=1; AJvYcCWok/GPNcMqSYEDuk0KbJ6dC1kbSKGRSJyPk68xbE/OeJWUVBQFGIs7FdqhwtxCgca32O/5wPk8yy0dNLVmdKpaFhV13xvAkP32oLFMBldgbrwHmJAxOSkNluaQZeQHIMltSGoXBzM5794y5E/mcYa/CsfCmFhZZ1yhMm9brIaWHuQBlA==
X-Gm-Message-State: AOJu0YyVF7Tvf32wz/QkJUE7laATbEVHN6s8TQt3YfiK5OhCPtDoovRX
	C03xY6MRbGjhljvdZBMUfyD9gCArYuXh7fWWPUMLKKNNoYBTyVTnED7i/LnYLlXKOw9iznd1xJA
	UPN5abcLPi6wqMU7d1apydFUAIOI=
X-Google-Smtp-Source: AGHT+IGr2IF61Tq5V2UoeP6NsqjvosuELY8jr+3LLYgQOP9eBfScgTsWuXwRjeksq/gzaCVFXN++KM9eLd0ViexGnK0=
X-Received: by 2002:a17:906:28d6:b0:a55:41fd:a013 with SMTP id
 p22-20020a17090628d600b00a5541fda013mr97880ejd.23.1713373753535; Wed, 17 Apr
 2024 10:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417170054.140587-1-alisa.roman@analog.com> <20240417170054.140587-4-alisa.roman@analog.com>
In-Reply-To: <20240417170054.140587-4-alisa.roman@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 17 Apr 2024 20:08:37 +0300
Message-ID: <CAHp75VcT3VHcA8YVjc02PBXUxErnWg56Wyn1iiJshYVWv1YWxQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] iio: adc: ad7192: Add aincom supply
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org, nuno.sa@analog.com, 
	marcelo.schmitt@analog.com, bigunclemax@gmail.com, dlechner@baylibre.com, 
	okan.sahin@analog.com, fr0st61te@gmail.com, alisa.roman@analog.com, 
	marcus.folkesson@gmail.com, schnelle@linux.ibm.com, liambeguin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 8:01=E2=80=AFPM Alisa-Dariana Roman
<alisadariana@gmail.com> wrote:
>
> AINCOM should actually be a supply. AINx inputs are referenced to AINCOM
> in pseduo-differential operation mode. AINCOM voltage represets the

pseudo

> offset of corresponding channels.

..

> +               case IIO_VOLTAGE:
> +                       if (st->aincom_mv && !chan->differential)
> +                               *val +=3D DIV_ROUND_CLOSEST_ULL((u64)st->=
aincom_mv * 1000000000,

It's quite easy to make a mistake in this long constant. Can you use
an appropriate one from units.h?

> +                                                             st->scale_a=
vail[gain][1]);
> +                       return IIO_VAL_INT;

..

> +       aincom =3D devm_regulator_get_optional(&spi->dev, "aincom");
> +       if (!IS_ERR(aincom)) {

Why not a positive condition?

> +               ret =3D regulator_enable(aincom);
> +               if (ret) {

> +                       dev_err(&spi->dev, "Failed to enable specified AI=
NCOM supply\n");

return dev_err_probe();

> +                       return ret;
> +               }
> +
> +               ret =3D devm_add_action_or_reset(&spi->dev, ad7192_reg_di=
sable, aincom);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D regulator_get_voltage(aincom);
> +               if (ret < 0)
> +                       return dev_err_probe(&spi->dev, ret,
> +                                            "Device tree error, AINCOM v=
oltage undefined\n");
> +               st->aincom_mv =3D ret / 1000;
> +       } else {
> +               st->aincom_mv =3D 0;
> +       }

..

> @@ -1113,6 +1145,7 @@ static int ad7192_probe(struct spi_device *spi)
>         st->int_vref_mv =3D ret / 1000;
>
>         st->chip_info =3D spi_get_device_match_data(spi);
> +
>         indio_dev->name =3D st->chip_info->name;
>         indio_dev->modes =3D INDIO_DIRECT_MODE;
>         indio_dev->channels =3D st->chip_info->channels;

Stray change.

--=20
With Best Regards,
Andy Shevchenko

