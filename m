Return-Path: <linux-kernel+bounces-81858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3706E867B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8EB41F2CB4D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437BE12C7FD;
	Mon, 26 Feb 2024 16:02:03 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D18112BF3C;
	Mon, 26 Feb 2024 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963322; cv=none; b=WTLwndwgzUUi8q0BpNBNaZFfwGCDdZ69Wy+QwxGTrjiX5WX4bHxyUtOJhii/Km67HY/Vnzh0OcnX0Rh3f5GUAuq3s+DXGpgYNLl8W2RS7oi6iWiomR4CbUR0SezI41VH7gb/i+34c+K/L4G2Js8AVpvvaAZdnv2R1Hzou3fYbZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963322; c=relaxed/simple;
	bh=z1qeTpEjMEfc2m6/6tnNBSOhd7axsMR5VpVy+elxQ20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AT+t/SM0FZYA78VGuenK8QkrwyT7JoUkyDl1uYODhCnclN2ha3hoMLFeFVtPCfFeRgEiAdKCgNXnx9BeVVVvnlFwgzQLyJl85objJyO4Jgr/u1dWkenCRqXXTT6P4KfsLgQFoV8O3mh/mmrEBZNwIfcs7gE0j3hskl914PBNnHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-607e54b6cf5so21992767b3.0;
        Mon, 26 Feb 2024 08:02:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708963319; x=1709568119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYLdQGeG0+orphpmC7yUAHvEglcSX2xBetFEu0Q3iXQ=;
        b=OUrsjVLO1WFlPifNNYrpZzOeqsGt84XY5/43PsYF6D16Gp6YplrY2UNwUgUgI2Pb7U
         lQCA+4a/z1oNWP666dOa0BAGiqEMgD3I8AgOY6JUM3I5/ZFCZ9x5Yso93MZ0uxF4U61D
         YARAXbYyX2UuHfCZiUKGIsM7vycFNP6XYrBvri/AxtOIrPqbpvNZoXml4BaFa5cRtMYT
         nfRlKRTMJ/TGb2hnvn3O2nrmAwZrDcHE6WQPiYzVo0TRPKfz6+ZRQhFWG/Qs9pypVwK4
         4SIQMLHM/lyPnTINMqlGvuhgi6PJ9pBpDasCGVoDBOlMVOfsfFAQNm9R9vHByGrVmS1Y
         TFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOa2ED2kO9hQTiWh27SW023CGNGgrv3xP6Ekc56gU3vioZszupeISrzjIY5H6DUjhGaynd8n6OV13AnPvS6orLxPKcLM5yUP1y8HKGxvVOIxYJRvkTNQ/wgtp2IocwKVqrgQNi3jemVQ==
X-Gm-Message-State: AOJu0YyCMPomDNM7/6jnKl76pDRTvuKLTeKYX2dO1z884MiI6n6+oSPm
	lOPmWH8Gs4zbHCOKxIVi47FP7UYB7NwD9Qa8BplBPelcBzouwgEAJfpdXkOqYMw=
X-Google-Smtp-Source: AGHT+IFWp6qoVWibZnaoUG6/6q4jndWnf1FBWR5155ZcWCf/bajewxyzUgo5a4pzMRlI/bfsXmS/eQ==
X-Received: by 2002:a81:ae62:0:b0:608:b1eb:f631 with SMTP id g34-20020a81ae62000000b00608b1ebf631mr3888836ywk.3.1708963318708;
        Mon, 26 Feb 2024 08:01:58 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id f187-20020a0dc3c4000000b00607bc220c5esm1232202ywd.102.2024.02.26.08.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 08:01:58 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbed179f0faso1799401276.1;
        Mon, 26 Feb 2024 08:01:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUnqaGkn8K7XmgE2pg4xd08EDjclbV+BGwoJwieYPvQ3KJTDhx6gbcL7SKPFUVQb5AeFyOzpget+i77N1dSwGRaI5Eb1s1X15HqDQxDj/No6eAn4f5NuRqSs1TulTyewRHNR9rVN11o2Q==
X-Received: by 2002:a25:e0ce:0:b0:dc6:e7f6:254a with SMTP id
 x197-20020a25e0ce000000b00dc6e7f6254amr4561945ybg.8.1708963318051; Mon, 26
 Feb 2024 08:01:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com> <20240219170337.2161754-10-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240219170337.2161754-10-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2024 17:01:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWpepH0P8g9dPfq1rsZRJsvOnoZ7VnjqTL9nkSGtKFpYQ@mail.gmail.com>
Message-ID: <CAMuHMdWpepH0P8g9dPfq1rsZRJsvOnoZ7VnjqTL9nkSGtKFpYQ@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] auxdisplay: Add driver for MAX695x 7-segment LED controllers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, Feb 19, 2024 at 6:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Add initial driver for the MAX6958 and MAX6959 7-segment LED
> controllers.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch!

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- /dev/null
> +++ b/drivers/auxdisplay/max6959.c

> +static void max6959_disp_update(struct work_struct *work)
> +{
> +       struct max6959_priv *priv =3D container_of(work, struct max6959_p=
riv, work.work);
> +       struct linedisp *linedisp =3D &priv->linedisp;
> +       struct linedisp_map *map =3D linedisp->map;
> +       char *s =3D linedisp->buf;
> +       u8 buf[4];
> +
> +       /* Map segments according to datasheet */
> +       buf[0] =3D bitrev8(map_to_seg7(&map->map.seg7, *s++)) >> 1;
> +       buf[1] =3D bitrev8(map_to_seg7(&map->map.seg7, *s++)) >> 1;
> +       buf[2] =3D bitrev8(map_to_seg7(&map->map.seg7, *s++)) >> 1;
> +       buf[3] =3D bitrev8(map_to_seg7(&map->map.seg7, *s++)) >> 1;

for (unsigned int i =3D 0; i < linedisp->num_chars; i++) { ... }

> +
> +       regmap_bulk_write(priv->regmap, REG_DIGIT(0), buf, ARRAY_SIZE(buf=
));

linedisp->num_chars

> +}

> +static int max6959_i2c_probe(struct i2c_client *client)
> +{
> +       struct device *dev =3D &client->dev;
> +       struct max6959_priv *priv;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->regmap =3D devm_regmap_init_i2c(client, &max6959_regmap_con=
fig);
> +       if (IS_ERR(priv->regmap))
> +               return PTR_ERR(priv->regmap);
> +
> +       ret =3D max6959_power_on(priv);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D linedisp_register(&priv->linedisp, dev, 4, &max6959_lined=
isp_ops);

+ device_property_read_u32(dev, "display-width-chars", ...) handling.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

