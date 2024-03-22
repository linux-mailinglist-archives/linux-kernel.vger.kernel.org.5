Return-Path: <linux-kernel+bounces-111742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1DE887040
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23B8CB2245D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C23856B79;
	Fri, 22 Mar 2024 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IdDw0AIz"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C8141C6A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123394; cv=none; b=iGeU7Oh679OYVolrsWlBkQf4AqX0021iZBh32BanvTGQVWDzcUlq5pa5w0B2HmztyNQ9epUPolQUjtmXIH9s4/zUTRfqDZT63t5xPlv64b7EJaisXwhIuC1bdMwmzgZ2K5ShbNaGR4WgBn/TRkypmCyjPh8ScVDehLXPEwiB9hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123394; c=relaxed/simple;
	bh=SvJGLYHJxEO+kQPgbDvLc6DOGWqvWJBC/KeHsXQ0S+4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=HBTwgffkQ/80yP2JVOIiKNJptaGPAdJdUVV5ksft5nFkafn0eWBP6T+EAUA52AadpgQBX7PlVgILM4ceVTxLZ0+ElkZT/KjegAX2I9qyuMm7PTJ6Zjr/04iz7yL73SH0vAeryKYcXjUnx8RF7i9bcsn7yN5ZdsY6PZVQG/+wQec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IdDw0AIz; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so31218161fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711123390; x=1711728190; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kh0B0Op/7iFcRFrIOoiJQuhYzDeOdAJ2QNUlBpVkvVY=;
        b=IdDw0AIzYkF3KLWngPQI+az8mx+M8FLiWwNYqRIE92h8Vu9srNP9eZVFiNGc7jtPGA
         Ih89BDJdG9LFzi2dVc6cam4pv2zesvKRNxKYOSDUnFqxFZEUW/yVWNqD0bdxut/MYyDB
         dML5PQc5dNse+OU64tVuoIjNUO8bApbXSsFiR/yWFhKl1A5B9tGZfD64CsH/PgdECJM1
         KPL6zNMYuXmleSPYhC21pYuyYgUSQNnGV2k9Y9Mjp/WHXv4Z7CKhk8NJJUXEmBhcDerA
         Ey21LQwfdKeZ2OqOI+V3JMqd9Ts9EOw3/9wHS2EY9+S2I7eLvf7L91yC9X7TKKWED4il
         MYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711123390; x=1711728190;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kh0B0Op/7iFcRFrIOoiJQuhYzDeOdAJ2QNUlBpVkvVY=;
        b=GXs5dJHmhy6fvjPzRD1RM1lFioWRuk0D1tjBr4D5EsoMz+3K3jr2vzQQXNTnionw13
         EiUO+SWc/VUph3SohRXImS79DM0ue8T506xrNyOvUXGFwY0qKV/9lZqjJSd3f8DXPKEg
         A3PR44rvBsmOXVaRIjYZl2xullTPWPQKavYVOv8lmZi3KeoumdW1AlwwBa7Z/m+lB2na
         rRSYMi8aCvFSyGBl0JlWGBfQkcAGDi8erolS4I8uiMTa3fG9qrpKztYz7LJReb9LjznM
         hA+9BxVkNw0PXePI8uytkZB39ir3JpH238D0WzBF+cfSNZ1dAumJBmQB0JlDll9QEZrZ
         7fqw==
X-Forwarded-Encrypted: i=1; AJvYcCWZvvHJLGPKzWfHJg51OAulawWNXu4EKPsM9ebEeG5Q6fMHIAKBfOUOYxfu0IOp21Vqlb22yQZ/LTayJgg6/vNHtAYhj9agDTEyvW0R
X-Gm-Message-State: AOJu0YwCGXvTLd6HqjPnlyfM1XI8ACp/NJ0q4v0wjBGePgqGW/JXm+uC
	l2Y6OPnUuQk7bpVW0FlMqnM8GDALQhq5fOPdqPuRgedlsjV3GeSkqNxDLXmAQXs=
X-Google-Smtp-Source: AGHT+IEkR6PizaNuC62j5Grot13csXnQY6gVrSzN5nx/GfkID77oL8KO3GnXgbM82pcwsLxNamFMfQ==
X-Received: by 2002:a2e:9f4c:0:b0:2d4:6910:2ee5 with SMTP id v12-20020a2e9f4c000000b002d469102ee5mr2129385ljk.8.1711123390044;
        Fri, 22 Mar 2024 09:03:10 -0700 (PDT)
Received: from localhost (alyon-651-1-22-137.w82-122.abo.wanadoo.fr. [82.122.123.137])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c310b00b0041408e16e6bsm3472839wmo.25.2024.03.22.09.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 09:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Mar 2024 17:03:08 +0100
Message-Id: <D00EM8TTYGXL.3MMIBWJT03M5R@baylibre.com>
Subject: Re: [PATCH v4 10/11] pinctrl: pinctrl-tps6594: Add TPS65224 PMIC
 pinctrl and GPIO
From: "Esteban Blanc" <eblanc@baylibre.com>
To: "Bhargav Raviprakash" <bhargav.r@ltts.com>,
 <linux-kernel@vger.kernel.org>
Cc: <m.nirmaladevi@ltts.com>, <lee@kernel.org>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <jpanis@baylibre.com>, <devicetree@vger.kernel.org>, <arnd@arndb.de>,
 <gregkh@linuxfoundation.org>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
 <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <nm@ti.com>, <vigneshr@ti.com>,
 <kristo@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240320102559.464981-1-bhargav.r@ltts.com>
 <20240320102559.464981-11-bhargav.r@ltts.com>
In-Reply-To: <20240320102559.464981-11-bhargav.r@ltts.com>

On Wed Mar 20, 2024 at 11:25 AM CET, Bhargav Raviprakash wrote:
> From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
>
> Add support for TPS65224 pinctrl and GPIOs to TPS6594 driver as they have
> significant functional overlap.
> TPS65224 PMIC has 6 GPIOS which can be configured as GPIO or other
> dedicated device functions.
>
> Signed-off-by: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/pinctrl/pinctrl-tps6594.c | 258 +++++++++++++++++++++++++-----
>  1 file changed, 215 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-tps6594.c b/drivers/pinctrl/pinctrl-=
tps6594.c
> index 66985e54b..db0f5d2a8 100644
> --- a/drivers/pinctrl/pinctrl-tps6594.c
> +++ b/drivers/pinctrl/pinctrl-tps6594.c
> @@ -320,8 +451,18 @@ static int tps6594_pinctrl_probe(struct platform_dev=
ice *pdev)
>  		return -ENOMEM;
>  	pctrl_desc->name =3D dev_name(dev);
>  	pctrl_desc->owner =3D THIS_MODULE;
> -	pctrl_desc->pins =3D tps6594_pins;
> -	pctrl_desc->npins =3D ARRAY_SIZE(tps6594_pins);
> +	switch (tps->chip_id) {
> +	case TPS65224:
> +		pctrl_desc->pins =3D tps65224_pins;
> +		pctrl_desc->npins =3D ARRAY_SIZE(tps65224_pins);
> +		break;
> +	case TPS6594:
> +		pctrl_desc->pins =3D tps6594_pins;
> +		pctrl_desc->npins =3D ARRAY_SIZE(tps6594_pins);
> +		break;
> +	default:
> +		break;
> +	}
>  	pctrl_desc->pctlops =3D &tps6594_pctrl_ops;
>  	pctrl_desc->pmxops =3D &tps6594_pmx_ops;

See below.

> @@ -329,8 +470,28 @@ static int tps6594_pinctrl_probe(struct platform_dev=
ice *pdev)
>  	if (!pinctrl)
>  		return -ENOMEM;
>  	pinctrl->tps =3D dev_get_drvdata(dev->parent);
> -	pinctrl->funcs =3D pinctrl_functions;
> -	pinctrl->pins =3D tps6594_pins;
> +	switch (pinctrl->tps->chip_id) {

You could use tps->chip_id like in the previous switch.

> +	case TPS65224:
> +		pinctrl->funcs =3D tps65224_pinctrl_functions;
> +		pinctrl->func_cnt =3D ARRAY_SIZE(tps65224_pinctrl_functions);
> +		pinctrl->pins =3D tps65224_pins;
> +		pinctrl->num_pins =3D ARRAY_SIZE(tps65224_pins);
> +		pinctrl->mux_sel_mask =3D TPS65224_MASK_GPIO_SEL;
> +		pinctrl->remap =3D tps65224_muxval_remap;
> +		pinctrl->remap_cnt =3D ARRAY_SIZE(tps65224_muxval_remap);
> +		break;
> +	case TPS6594:
> +		pinctrl->funcs =3D pinctrl_functions;

This should be tps6594_pinctrl_functions

> +		pinctrl->func_cnt =3D ARRAY_SIZE(pinctrl_functions);
> +		pinctrl->pins =3D tps6594_pins;
> +		pinctrl->num_pins =3D ARRAY_SIZE(tps6594_pins);
> +		pinctrl->mux_sel_mask =3D TPS6594_MASK_GPIO_SEL;
> +		pinctrl->remap =3D tps6594_muxval_remap;
> +		pinctrl->remap_cnt =3D ARRAY_SIZE(tps6594_muxval_remap);
> +		break;
> +	default:
> +		break;
> +	}

See blow.

>  	pinctrl->pctl_dev =3D devm_pinctrl_register(dev, pctrl_desc, pinctrl);
>  	if (IS_ERR(pinctrl->pctl_dev))
>  		return dev_err_probe(dev, PTR_ERR(pinctrl->pctl_dev),
> @@ -338,8 +499,18 @@ static int tps6594_pinctrl_probe(struct platform_dev=
ice *pdev)
> =20
>  	config.parent =3D tps->dev;
>  	config.regmap =3D tps->regmap;
> -	config.ngpio =3D TPS6594_PINCTRL_PINS_NB;
> -	config.ngpio_per_reg =3D 8;
> +	switch (pinctrl->tps->chip_id) {

Same here, use tps->chip_id

> +	case TPS65224:
> +		config.ngpio =3D ARRAY_SIZE(tps65224_gpio_func_group_names);
> +		config.ngpio_per_reg =3D TPS65224_NGPIO_PER_REG;
> +		break;
> +	case TPS6594:
> +		config.ngpio =3D ARRAY_SIZE(tps6594_gpio_func_group_names);
> +		config.ngpio_per_reg =3D TPS6594_NGPIO_PER_REG;
> +		break;
> +	default:
> +		break;
> +	}
>  	config.reg_dat_base =3D TPS6594_REG_GPIO_IN_1;
>  	config.reg_set_base =3D TPS6594_REG_GPIO_OUT_1;
>  	config.reg_dir_out_base =3D TPS6594_REG_GPIOX_CONF(0);

Regarding all the switch case, they should be use to set all the struct
fields that are known at runtime only. For example, pinctrl->funcs, and
pinctrl->func_cnt are known at compile time. You should create template
structs, one for TPS6594 the other TPS65224, initialise the allocated
struct with the template and then fill the remaining fields with the
runtime values. Something like this:

```c
struct test {
    int a;
    int *b;
};

static struct test template =3D {
    .a =3D 42,
};

int main(void) {
    struct test *test =3D malloc(sizeof(*test));
    *test =3D sample;
    test->b =3D NULL;

    return 0;
}
```

You could also try to reduce the number of switch case, there is no good
reason to have 2 switch instead of one for pctrl_desc and pinctrl
structs.

Best regards,

--=20
Esteban "Skallwar" Blanc
BayLibre


