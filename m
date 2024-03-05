Return-Path: <linux-kernel+bounces-91904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1786C871828
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C303A28235A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5B27F480;
	Tue,  5 Mar 2024 08:23:23 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6049C7E567;
	Tue,  5 Mar 2024 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709627002; cv=none; b=d9ayCoVzh71zvDnVQpuHz+IVAou6/SJzUJELFGfoyv0LkonGeC6RHw+bq5JfQcDJac46XjanaX95Zf9PM/leS6EoF0IEtWSvg9MlwHDPfIFejcWHb40ky4B1Gkm7nsgCSABYQAGIXYMWJFmS9HIwyBTymaOEUhr4zn9y+5+txa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709627002; c=relaxed/simple;
	bh=CbVPR2QHJ5QJ4GDfn5v6V7p1OPdCrT5jCuJ1e6nCBaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sfs0tkDotf1Iu6eZiBkA6omVSbJWyXr8L5TGnJMo5U6ZvNRDT2gKVU1CfycLRKpH6KZ4WJ2TL8qlflPkpwviky3DG91lSdDfwCDtOIOo0sY0dIliiqT5XCFm3hHZCtQFm/3+QAQ2gwD0CgOdEz1bxQMiWwAS1JCRlgNGx7cYShE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6098a20ab22so32153417b3.2;
        Tue, 05 Mar 2024 00:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709627000; x=1710231800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JK8R63Wb4mcVyO26iwlrTXo/1vZKzjuEZvuH8WXk/8g=;
        b=e8Mn8PNn4t1BHc0F+YE0mlnaXAgIAIqwrBTQ5onHZvAZgRwk3PWhOqSsk7rmyQBLxB
         21wr77kH5AS2S92o2hYWp5TRiUKdJRGD4hEiZVHnEIQhgTyUWiUFeQUVPLvLXjn5qACl
         zN/KrWBAxcSq9NNxHK16yeDTbZNGg2hGrMEzSmLuppjqrWSsItCCZzblj6l8tcg9BaHY
         tvHffG8+DoguxoUpX3IynVLMyhSMQa3sHy0s6vRGLYg07tiVPZK7/KWg/UKSrMGu3bLX
         PUUEi4+8APKZlXkvvLvKz3wdo0CJ/ey41LN7eCrEHZvx68VBKVNQlJ4acllaHMMl3Mvb
         rtZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXZLTEnfUWTsW813JOkhVT1levDI7DmI1lJ3GeWMeKT4+v99KSxrAC5ulVmgzS3eopPjUOaHIFLYV3HwMtaCCH+ZSpzwbZg0IVspOl0W4Y4vtjcp6zshJ3daqGZtIhFRIAn7IWKX6snJczvwHtsF9OxC7SZAmPhXqXrUQIdPsNS3u+ah4=
X-Gm-Message-State: AOJu0Yxj0GKBGt8lHJi6s5/6aiEbKmDaDVSFHWzGIWt1T156xyI0SHBw
	Sdenw0HExknaj5NQZ5SABYFqkBcN62ibutRTNLXNEJumZ0C0mFkqsTq1Om0P74o=
X-Google-Smtp-Source: AGHT+IG6zXeTV/eR2uLzcRDW0bfoB2HCabMj3C6+G1+YLhAtkz2hp2VJV93lljae6jC+kQXyh5Z23Q==
X-Received: by 2002:a81:9194:0:b0:609:80ff:ea5c with SMTP id i142-20020a819194000000b0060980ffea5cmr12012630ywg.12.1709626999689;
        Tue, 05 Mar 2024 00:23:19 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id y17-20020a81a111000000b00607a42af275sm3063483ywg.48.2024.03.05.00.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 00:23:19 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcc73148611so5654375276.3;
        Tue, 05 Mar 2024 00:23:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVTD6bUTmPqMHDeZ6DpowFbXuXIp8Lx/QGxF4Wi11HMmQhNLY8MKnCByvj+0eHQz9XW/f8q/OuRNKeTCdqEKo2uD+iaUXW4pz8myOxF4PmDKbj8IatsQPeW/jh13OwklFrha1eSlnSeRYU3Nd3ASML9L4qKStqCBa28tIQR+X++MfRcdM4=
X-Received: by 2002:a25:aa8b:0:b0:dcd:5bdb:4aa4 with SMTP id
 t11-20020a25aa8b000000b00dcd5bdb4aa4mr8894973ybi.51.1709626999323; Tue, 05
 Mar 2024 00:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305035853.916430-1-chris.packham@alliedtelesis.co.nz> <20240305035853.916430-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240305035853.916430-2-chris.packham@alliedtelesis.co.nz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Mar 2024 09:23:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXF+12PHa5A7WeyPMfvsGcJN13WaPuCbTmJU52Huq=osA@mail.gmail.com>
Message-ID: <CAMuHMdXF+12PHa5A7WeyPMfvsGcJN13WaPuCbTmJU52Huq=osA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] auxdisplay: Add 7-segment LED display driver
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andy@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, lee@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Tue, Mar 5, 2024 at 4:59=E2=80=AFAM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
> Add a driver for a 7-segment LED display. At the moment only one
> character is supported but it should be possible to expand this to
> support more characters and/or 14-segment displays in the future.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Sorry, I spoke too soon...

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

This needs some validation of priv->segment_gpios->ndescs, else the
call to gpiod_set_array_value_cansleep() in seg_led_update() may
trigger an out-of-bounds access of the values bitmap.

> +
> +       return linedisp_register(&priv->linedisp, dev, 1, &seg_led_linedi=
sp_ops);
> +}

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

