Return-Path: <linux-kernel+bounces-104371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0F387CCF3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194E6282F62
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8DF1BF3C;
	Fri, 15 Mar 2024 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSKfMvxD"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4991BC4D;
	Fri, 15 Mar 2024 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710503439; cv=none; b=mDC0ZES/SU0szFxnV9ZTcir1hTFx2shOWQBow0wwA5XQk/Ll5YrFbawyT/X/7bpMmLKZXrbraogUOqjbpLxFqgMfvmp0hnmQyOy0ortEEI8NTN/ROd3MBCdQaAAcilxCVyWxQs42ub+hkcMFebg0oF856bo1FF/Mt8RlFwT77x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710503439; c=relaxed/simple;
	bh=5me4MpQUzHBIAyZZmzqVKhBXLOvXSeBvU6Zqe0D70Mk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aLiXGxmHb5B3Y35c/GTYMgbX773KJ+VMM9mgtvruXXk0aF6c2PRgPLxvLtT+IFVLCP3qTi1bEPgfRQNsQLRJyLM5WzXbe2FLSSIYMtaXo5iWujIiw1416GP5I1h3L+055fnGllWoy3bYwd8rpw06XM6EosktiASOw/mppSdnKf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSKfMvxD; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-568a5e15ae8so1657687a12.0;
        Fri, 15 Mar 2024 04:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710503436; x=1711108236; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vRgmGDbr9L2V3Xbw1VXsP1cW1O/+83SnI0SSy+HlJx4=;
        b=WSKfMvxDXqtVo8QT3jVD9h5+ieGxyG2euElTMr98pWA4U8QnnOmspaLZ/9gsWgk9fd
         /45fgtoZZHtvz1wiVb4AlRW08lRRQJoi+MGAmh0Pm2ulgLtSF4aK67j687jvST4aw/aj
         yqRXo4SHw0lrRceOUJpyeIxbxveDdRESNQj2Sq2QHN7FW/Yrp4Q1CB1koryWCR1f76jB
         AwNNxFV9ZgZcDbFWrgGlX4R/wkoGMtnZQssBykrvAYXvJxizcgSuy2oCGwxt0La+dhWu
         uLIOXqcHRg6lddX9hr6xTpbj6cTf/s6CnXvYiw1Wv0cbc3Hqmv/Fb9UBiq0BdVXeTODT
         +hOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710503436; x=1711108236;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vRgmGDbr9L2V3Xbw1VXsP1cW1O/+83SnI0SSy+HlJx4=;
        b=g5lW5wRmOhWLHypY13ka6C4+XY+m85CU6mjcwfzq+WjgXGw2Vh8yQZcfc0SpjAZM2M
         lJmj9+evWN+XMz8dX2rdE/tfeDFd+7EvolaK07zLr5LI75ljACF0t/jTndb0FeVprqkt
         5G8xgtsYXy+qVPa0ovE2GDzqsyM5Q8d+vcCMSS2NW1x1sx6yi8LDkljcpylzNqsois89
         1foFbnI6SQSRztxAIehSTIOgMTJRVE/w0sgC/5+g8kyc0hQprL6YULOmPpT72VQK4yLc
         8t0D29PMojf7I8JugBgmt9q2x66oKo80n+YODCkd13IaeWQllfitjUU0pXyLPlduf9n8
         BV2A==
X-Forwarded-Encrypted: i=1; AJvYcCUdkodsTJLZpG8QJvHRzk13fFwYRp9pDLb7Y+aidwrtZgz116c2ZTOg4vRLDRdSdoH/0zLnhB5890Px5V64gSFnrw/UxlLb/Bv0WIieh3+hMPiDcmzXMvkYUcUP+uUy9WrRIWG0mw==
X-Gm-Message-State: AOJu0Yxk6Me96p87tdh7z/5l4htMfOuKHAw9sAoCWcbCbIlwz1bYbQd0
	ZkJh6lSgLfvv8wvVVlz/Mqq+cKqro2Fhcy3lmcrxOYFeTC682Kfu
X-Google-Smtp-Source: AGHT+IFEFByoovbYhj/9o6d4RldFJLNtIRiP4vqehi8OtR8upquQ/pPaWuhTwxiyHTaggdoAj8+SGg==
X-Received: by 2002:a17:906:9c8e:b0:a46:66c6:2d5a with SMTP id fj14-20020a1709069c8e00b00a4666c62d5amr3740897ejc.54.1710503436014;
        Fri, 15 Mar 2024 04:50:36 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906338a00b00a4679ce135dsm1122962eja.216.2024.03.15.04.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:50:35 -0700 (PDT)
Message-ID: <9e05b15d086c57ea94b410b6bf72a6d22a9550b9.camel@gmail.com>
Subject: Re: [PATCH 2/2] pwm: axi-pwmgen: support version 2.00.a
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Trevor Gamblin <tgamblin@baylibre.com>, linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de, 
 michael.hennerich@analog.com, nuno.sa@analog.com,
 devicetree@vger.kernel.org,  robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 dlechner@baylibre.com
Date: Fri, 15 Mar 2024 12:54:03 +0100
In-Reply-To: <20240314204722.1291993-3-tgamblin@baylibre.com>
References: <20240314204722.1291993-1-tgamblin@baylibre.com>
	 <20240314204722.1291993-3-tgamblin@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-14 at 16:47 -0400, Trevor Gamblin wrote:
> This adds support for the AXI PWMGEN v2 IP block. This version is
> nearly identical to v1 other than it supports up to 16 channels instead
> of 4 and a few of the memory mapped registers have moved.
>=20
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---

LGTM

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/pwm/pwm-axi-pwmgen.c | 62 ++++++++++++++++++++++++++++-----=
---
> =C2=A01 file changed, 49 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> index 0c8f7f893a21..539625c404ac 100644
> --- a/drivers/pwm/pwm-axi-pwmgen.c
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -32,16 +32,25 @@
> =C2=A0#define AXI_PWMGEN_REG_CORE_MAGIC	0x0C
> =C2=A0#define AXI_PWMGEN_REG_CONFIG		0x10
> =C2=A0#define AXI_PWMGEN_REG_NPWM		0x14
> -#define AXI_PWMGEN_CHX_PERIOD(ch)	(0x40 + (12 * (ch)))
> -#define AXI_PWMGEN_CHX_DUTY(ch)		(0x44 + (12 * (ch)))
> -#define AXI_PWMGEN_CHX_OFFSET(ch)	(0x48 + (12 * (ch)))
> +#define AXI_PWMGEN_CHX_PERIOD(v, ch)	((v)->period_base + (v)->ch_step *
> (ch))
> +#define AXI_PWMGEN_CHX_DUTY(v, ch)	((v)->duty_base + (v)->ch_step *
> (ch))
> +#define AXI_PWMGEN_CHX_OFFSET(v, ch)	((v)->offset_base + (v)->ch_step *
> (ch))
> =C2=A0#define AXI_PWMGEN_REG_CORE_MAGIC_VAL	0x601A3471 /* Identification =
number
> to test during setup */
> =C2=A0#define AXI_PWMGEN_LOAD_CONFIG		BIT(1)
> =C2=A0#define AXI_PWMGEN_RESET		BIT(0)
> =C2=A0
> +struct axi_pwm_variant {
> +	u8 period_base;
> +	u8 duty_base;
> +	u8 offset_base;
> +	u8 major_version;
> +	u8 ch_step;
> +};
> +
> =C2=A0struct axi_pwmgen_ddata {
> =C2=A0	struct regmap *regmap;
> =C2=A0	unsigned long clk_rate_hz;
> +	const struct axi_pwm_variant *variant;
> =C2=A0};
> =C2=A0
> =C2=A0static const struct regmap_config axi_pwmgen_regmap_config =3D {
> @@ -50,12 +59,30 @@ static const struct regmap_config axi_pwmgen_regmap_c=
onfig
> =3D {
> =C2=A0	.val_bits =3D 32,
> =C2=A0};
> =C2=A0
> +static const struct axi_pwm_variant pwmgen_1_00_variant =3D {
> +	.period_base =3D 0x40,
> +	.duty_base =3D 0x44,
> +	.offset_base =3D 0x48,
> +	.major_version =3D 1,
> +	.ch_step =3D 12,
> +};
> +
> +static const struct axi_pwm_variant pwmgen_2_00_variant =3D {
> +	.period_base =3D 0x40,
> +	.duty_base =3D 0x80,
> +	.offset_base =3D 0xC0,
> +	.major_version =3D 2,
> +	.ch_step =3D 4,
> +};
> +
> +
> =C2=A0static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> =C2=A0			=C2=A0=C2=A0=C2=A0 const struct pwm_state *state)
> =C2=A0{
> =C2=A0	struct axi_pwmgen_ddata *ddata =3D pwmchip_get_drvdata(chip);
> =C2=A0	unsigned int ch =3D pwm->hwpwm;
> =C2=A0	struct regmap *regmap =3D ddata->regmap;
> +	const struct axi_pwm_variant *variant =3D ddata->variant;
> =C2=A0	u64 period_cnt, duty_cnt;
> =C2=A0	int ret;
> =C2=A0
> @@ -70,7 +97,7 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, stru=
ct
> pwm_device *pwm,
> =C2=A0		if (period_cnt =3D=3D 0)
> =C2=A0			return -EINVAL;
> =C2=A0
> -		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch),
> period_cnt);
> +		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(variant,
> ch), period_cnt);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0
> @@ -78,15 +105,15 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, s=
truct
> pwm_device *pwm,
> =C2=A0		if (duty_cnt > UINT_MAX)
> =C2=A0			duty_cnt =3D UINT_MAX;
> =C2=A0
> -		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch),
> duty_cnt);
> +		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(variant, ch),
> duty_cnt);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0	} else {
> -		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), 0);
> +		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(variant,
> ch), 0);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0
> -		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), 0);
> +		ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(variant, ch),
> 0);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0	}
> @@ -99,11 +126,12 @@ static int axi_pwmgen_get_state(struct pwm_chip *chi=
p,
> struct pwm_device *pwm,
> =C2=A0{
> =C2=A0	struct axi_pwmgen_ddata *ddata =3D pwmchip_get_drvdata(chip);
> =C2=A0	struct regmap *regmap =3D ddata->regmap;
> +	const struct axi_pwm_variant *variant =3D ddata->variant;
> =C2=A0	unsigned int ch =3D pwm->hwpwm;
> =C2=A0	u32 cnt;
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(ch), &cnt);
> +	ret =3D regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(variant, ch), &cnt);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -111,7 +139,7 @@ static int axi_pwmgen_get_state(struct pwm_chip *chip=
,
> struct pwm_device *pwm,
> =C2=A0
> =C2=A0	state->period =3D DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata-
> >clk_rate_hz);
> =C2=A0
> -	ret =3D regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(ch), &cnt);
> +	ret =3D regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(variant, ch), &cnt);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -127,7 +155,8 @@ static const struct pwm_ops axi_pwmgen_pwm_ops =3D {
> =C2=A0	.get_state =3D axi_pwmgen_get_state,
> =C2=A0};
> =C2=A0
> -static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
> +static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev,=
=20
> +			=C2=A0=C2=A0=C2=A0 const struct axi_pwm_variant *variant)
> =C2=A0{
> =C2=A0	int ret;
> =C2=A0	u32 val;
> @@ -146,7 +175,7 @@ static int axi_pwmgen_setup(struct regmap *regmap, st=
ruct
> device *dev)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	if (ADI_AXI_PCORE_VER_MAJOR(val) !=3D 1) {
> +	if (ADI_AXI_PCORE_VER_MAJOR(val) !=3D variant->major_version) {
> =C2=A0		return dev_err_probe(dev, -ENODEV, "Unsupported peripheral
> version %u.%u.%u\n",
> =C2=A0			ADI_AXI_PCORE_VER_MAJOR(val),
> =C2=A0			ADI_AXI_PCORE_VER_MINOR(val),
> @@ -178,9 +207,14 @@ static int axi_pwmgen_probe(struct platform_device *=
pdev)
> =C2=A0	struct pwm_chip *chip;
> =C2=A0	struct axi_pwmgen_ddata *ddata;
> =C2=A0	struct clk *clk;
> +	const struct axi_pwm_variant *variant;
> =C2=A0	void __iomem *io_base;
> =C2=A0	int ret;
> =C2=A0
> +	variant =3D device_get_match_data(dev);
> +	if (!variant)
> +		return -EINVAL;
> +
> =C2=A0	io_base =3D devm_platform_ioremap_resource(pdev, 0);
> =C2=A0	if (IS_ERR(io_base))
> =C2=A0		return PTR_ERR(io_base);
> @@ -190,7 +224,7 @@ static int axi_pwmgen_probe(struct platform_device *p=
dev)
> =C2=A0		return dev_err_probe(dev, PTR_ERR(regmap),
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to init register map\n");
> =C2=A0
> -	ret =3D axi_pwmgen_setup(regmap, dev);
> +	ret =3D axi_pwmgen_setup(regmap, dev, variant);
> =C2=A0	if (ret < 0)
> =C2=A0		return ret;
> =C2=A0
> @@ -199,6 +233,7 @@ static int axi_pwmgen_probe(struct platform_device *p=
dev)
> =C2=A0		return PTR_ERR(chip);
> =C2=A0	ddata =3D pwmchip_get_drvdata(chip);
> =C2=A0	ddata->regmap =3D regmap;
> +	ddata->variant =3D variant;
> =C2=A0
> =C2=A0	clk =3D devm_clk_get_enabled(dev, NULL);
> =C2=A0	if (IS_ERR(clk))
> @@ -224,7 +259,8 @@ static int axi_pwmgen_probe(struct platform_device *p=
dev)
> =C2=A0}
> =C2=A0
> =C2=A0static const struct of_device_id axi_pwmgen_ids[] =3D {
> -	{ .compatible =3D "adi,axi-pwmgen-1.00.a" },
> +	{ .compatible =3D "adi,axi-pwmgen-1.00.a", .data =3D &pwmgen_1_00_varia=
nt
> },
> +	{ .compatible =3D "adi,axi-pwmgen-2.00.a", .data =3D &pwmgen_2_00_varia=
nt
> },
> =C2=A0	{ }
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(of, axi_pwmgen_ids);


