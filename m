Return-Path: <linux-kernel+bounces-95579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE1F874FB8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB1328337D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22CD12C532;
	Thu,  7 Mar 2024 13:13:38 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9841512B141;
	Thu,  7 Mar 2024 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817218; cv=none; b=IY5ibmESVsy3ashKTcC58hHvr+5sTlBVorvZB2YoaJv7bOePfa48HSr0na/tFH4wEbcK8R1Cym/rU40uQPU+s9/oNWq0Egl5+yqqmQPoo867NMic1pXTULJHKIR5qHRiXQA9uI833xpTnViFiMAgaa6w1pr59WG1T6lvr7Mi+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817218; c=relaxed/simple;
	bh=5565Dl57cUrtcvE9uRHrmU1SUVCRFojaEHMTPf6ehto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxZsAv8c7VMvAFflhVAQRuKGqqYudjhun6LKUmSTbEDs0gL8avciWz0Apzybiv6P4hv6uE/RaEgwzOZhXBnQ/ZCBBzIVnavZB2Sme9mTUWguFOHUjHb4KSqcIo1i5isqvNGeJJhnpQ57cYe+sxMBBW/G6FzjTWaGIKEXulcYGJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60982a6d8a7so10532737b3.0;
        Thu, 07 Mar 2024 05:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709817215; x=1710422015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIkBiPAlFe5WfWAAKfD9w/ivCRZtGTgbavVJepP7P3Q=;
        b=IMcIyqumTpG2CEoTd0NLWrHP8fSXeWBv0u9vhBdcUQDTrpUaDLR+oIkbv+vln7ub47
         msF5Ybh9ytke3LIB9/uSMvF0Gb5hUwUgU66OLAF1baLnz4Nc7ETcthmBOejNKnPoWYuE
         BCdR2mJPcWpjfTZseEy2TpxWfQCbF4AnBQXds82jhcitvnjih1eVPTQYP6f30wpArSb6
         21KyQnpYTpFMsT+GSJ5NhVVhHfn6oLNn5xQEMxT4vu4MfiHKPFx5wv1gG1ghXqKmcqOP
         Jh11lU+3sq4Lb8CLX0yPUKaasaxB5IS+FGrRxPy/KQ3jIHCcai/5PTa9S2I6HdpYaPgc
         zdMw==
X-Forwarded-Encrypted: i=1; AJvYcCXWYssGN5hg973UmvQv5mrx+WODmrotZjd9m81pmk8Cx7KF3h8ugJ8y4IgOxxtXDOxCL+lWz8tX5pv4yz8Yynb2vP6hXQIVwUXBywPiVH2Tcwkdi+Yj7U844+XYwqasQrYBiZGMugtEwNcusn62FEw781eQBkmS4075E/s0Hz+EGQn3dE8=
X-Gm-Message-State: AOJu0Yx7hirkQJYgdlEI7wTik6gd4BLAarCklCRG08ADJ/PaFeUThvJD
	9/JhfrEsZYqE+FAE0KrYNAdV4hmZSujBlUJbMr+E1gomM45/24+oY4fXLj5KLto=
X-Google-Smtp-Source: AGHT+IGHiVGamju10vzgpEvuZje9ogx2PyvIVlq4+da5Hty/BYKt1BH2B3idGMFpJDKoXxh1QxGRYw==
X-Received: by 2002:a0d:f207:0:b0:609:33d2:c70d with SMTP id b7-20020a0df207000000b0060933d2c70dmr18143021ywf.37.1709817215224;
        Thu, 07 Mar 2024 05:13:35 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id u84-20020a814757000000b0060784b3bba8sm4229039ywa.35.2024.03.07.05.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 05:13:35 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60982a6d8a7so10532417b3.0;
        Thu, 07 Mar 2024 05:13:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJTWMH3zo2k71nLgNuTCN4eVyUTRkWRyG9N6cQzOT2mvMoQqNgXWbMNbOZftUXD1+YSfpKhGi0PVBmnYU+xOU032TFdNUcvgVEQBawG50hybLPjP0m0t2NvGbAt/dwRsaCRPUvx/IQVramxMJBOrkzKAUgM3Xu4SIMJ+MjMiM+dv4KCJ0=
X-Received: by 2002:a81:5ec6:0:b0:609:82d7:a280 with SMTP id
 s189-20020a815ec6000000b0060982d7a280mr19545880ywb.11.1709817214857; Thu, 07
 Mar 2024 05:13:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306235021.976083-1-chris.packham@alliedtelesis.co.nz> <20240306235021.976083-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240306235021.976083-2-chris.packham@alliedtelesis.co.nz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Mar 2024 14:13:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUzrkRk_07SfQoZoe8b+bxkX+fLH_f5tVqbUZu23=DN_Q@mail.gmail.com>
Message-ID: <CAMuHMdUzrkRk_07SfQoZoe8b+bxkX+fLH_f5tVqbUZu23=DN_Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] auxdisplay: Add 7-segment LED display driver
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andy@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, lee@kernel.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Thu, Mar 7, 2024 at 12:50=E2=80=AFAM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
> Add a driver for a 7-segment LED display. At the moment only one
> character is supported but it should be possible to expand this to
> support more characters and/or 14-segment displays in the future.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>
> Notes:
>     Changes in v5:
>     - Add depends on GPIOLIB || COMPILE_TEST
>     - Validate that we get enough GPIOs

Thanks for the update!

> --- /dev/null
> +++ b/drivers/auxdisplay/seg-led-gpio.c

> +static void seg_led_update(struct work_struct *work)
> +{
> +       struct seg_led_priv *priv =3D container_of(work, struct seg_led_p=
riv, work.work);
> +       struct linedisp *linedisp =3D &priv->linedisp;
> +       struct linedisp_map *map =3D linedisp->map;
> +       DECLARE_BITMAP(values, 8) =3D { 0 };
> +
> +       bitmap_set_value8(values, map_to_seg7(&map->map.seg7, linedisp->b=
uf[0]), 0);
> +
> +       gpiod_set_array_value_cansleep(priv->segment_gpios->ndescs, priv-=
>segment_gpios->desc,
> +                                      priv->segment_gpios->info, values)=
;

This may still cause an out-of-bounds access of values if ndescs > 8.

> +}

> +static int seg_led_probe(struct platform_device *pdev)
> +{
> +       struct seg_led_priv *priv;
> +       struct device *dev =3D &pdev->dev;
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, priv);
> +
> +       priv->segment_gpios =3D devm_gpiod_get_array(dev, "segment", GPIO=
D_OUT_LOW);
> +       if (IS_ERR(priv->segment_gpios))
> +               return PTR_ERR(priv->segment_gpios);
> +
> +       if (priv->segment_gpios->ndescs < 7)

|| priv->segment_gpios->ndescs > 8

> +               return -EINVAL;

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

