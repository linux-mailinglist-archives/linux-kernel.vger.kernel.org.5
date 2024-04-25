Return-Path: <linux-kernel+bounces-158161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A90D8B1C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB221F23107
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F7A75808;
	Thu, 25 Apr 2024 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cqOQ7wEn"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950536E5FE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714031972; cv=none; b=GJSGyVd/cl4ZcUU0QG2xmcCEj+Nw5ZcSJhoJXDNrLqdByqs/kPn8wpBhgxu3ixBCPJgFRC14jW4im/qpSyJLZDmeBVPTXeSxArvErZSnC9aeJLNqiCOii6rbVLsBV/EpxJ2kZTx07DFfaIO35hXMtvSzeUuHFuG8EOl9xF69WDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714031972; c=relaxed/simple;
	bh=xrSdkqAR2Ts7zjorkQIr3WlQ784Ey6Ra4r7EpBZsoi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ev8R++0JwssMf1U0T7JckJ9DIXmUTNVJfAi57onEm/r/5sY0GiyhXJzhFQefglGIocavXnw6Cqk8WOeYYqy1bK6Ih3RUkIVmjFuN9qAt2NW6Xuba9AgLD3MbtB3NmJDluQM9x1WaN/j43fw9axuf/gSgHcW5VSxEUinvPEGi+6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cqOQ7wEn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41b5dc5e037so707535e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714031968; x=1714636768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KgkkBkwl2a3w3YPdRbEvUKh5659wVwBZZZWyPb6VST4=;
        b=cqOQ7wEnSgmR/2/5UZgObCkwE8kaLY8GREAylp3QgZvmwfT/92+L0w/fwkUbSho6Fy
         5mosiFEeZSCkPX0nqVDhoBXaObMpolLAg3Lyr02brANkzN5YnEoxf0iAS3yzLDYAJLEt
         +gcB49RtrrVXTA7LIYNJd7PsgkKK9EBJI9zYq4XToxngVxOWN4+Br4gv4T2SlwVXQaEp
         DRauDMps1jcpN3cfiFy79MkGLR/Kjp9vH2VzJaTXAJV+9KBBiaqmc/E6qtbX8Q8Vcx99
         EEMxYpq/g6NuOid2ABEKSSpSuhJq/TV4keoTdw0JGnEkNh+oJyhcaUvsJbplXbIdvdr0
         wpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714031968; x=1714636768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgkkBkwl2a3w3YPdRbEvUKh5659wVwBZZZWyPb6VST4=;
        b=vdygSVUsNtAeFFw0fuTMXkHdn6fyn4PQc/WMSnEVaKEXodlmq8ddJOYQV846+gEFfj
         nU6oVLpeou/938pRa7d9aj1O9sceBS8rczeKt4AcXQz8peL1J0JTOq/chaYpSAgmwwnU
         tLqzdufJSJe4zdOhXkAcD66J9K+L+oxNMemwnFDyXCxz7+VeFMy0UJv2ZH3pAn2kGz4c
         /DFj6jPXcvWIf14R87wcrhQxQm37M5F7JQctxBG5uv5uPYQ73YBtA73q1NGmXOPcV7hG
         cs4LkIRF0WHVqP4pHyKF0ZjbRTYDBbC7KgMWIAsR0LVKkzaIgIFc2iMbPrkPMQ5Tt2j7
         N9yQ==
X-Gm-Message-State: AOJu0YwndPq/KG5y9xrtsmxdtDCiXi8gu/NHHkp+7lS4X2GZxTctKOLn
	/scHeZpxt2fqgtFkMs0Kxgd0OvCdRoLt6SaAlDsYMg/XCxADGpj+JfdG1t07CP8=
X-Google-Smtp-Source: AGHT+IH+6ksnS68uM1lve6mEz21PPZmuDBvFqCYzVE2GClX0FySihV87rV5bb402rbO+C9JZZ4+oLw==
X-Received: by 2002:a05:600c:548a:b0:41a:7ab1:fd98 with SMTP id iv10-20020a05600c548a00b0041a7ab1fd98mr3724905wmb.21.1714031967408;
        Thu, 25 Apr 2024 00:59:27 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b00416e2c8b290sm30503963wmo.1.2024.04.25.00.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 00:59:27 -0700 (PDT)
Date: Thu, 25 Apr 2024 10:59:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
Cc: linux-kernel@vger.kernel.org, m.nirmaladevi@ltts.com, lee@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jpanis@baylibre.com,
	devicetree@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org,
	linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com,
	kristo@kernel.org, eblanc@baylibre.com
Subject: Re: [PATCH v7 08/10] regulator: tps6594-regulator: Add TI TPS65224
 PMIC regulators
Message-ID: <54eca1ac-288c-4f88-8c06-f5859bfa715c@moroto.mountain>
References: <20240417114934.186248-1-bhargav.r@ltts.com>
 <0109018eebe46a92-b169814e-4300-450a-ab0d-45fbe3c2d988-000000@ap-south-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0109018eebe46a92-b169814e-4300-450a-ab0d-45fbe3c2d988-000000@ap-south-1.amazonses.com>

On Wed, Apr 17, 2024 at 11:49:59AM +0000, Bhargav Raviprakash wrote:
> From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> 
> Add support for TPS65224 regulators (bucks and LDOs) to TPS6594 driver as
> they have significant functional overlap. TPS65224 PMIC has 4 buck
> regulators and 3 LDOs. BUCK12 can operate in dual phase.
> The output voltages are configurable and are meant to supply power to the
> main processor and other components.
> 
> Signed-off-by: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/regulator/Kconfig             |   4 +-
>  drivers/regulator/tps6594-regulator.c | 243 +++++++++++++++++++++++---
>  2 files changed, 222 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 7db0a29b5..1e4119f00 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -1563,13 +1563,15 @@ config REGULATOR_TPS6594
>  	depends on MFD_TPS6594 && OF
>  	default MFD_TPS6594
>  	help
> -	  This driver supports TPS6594 voltage regulator chips.
> +	  This driver supports TPS6594 series and TPS65224 voltage regulator chips.
>  	  TPS6594 series of PMICs have 5 BUCKs and 4 LDOs
>  	  voltage regulators.
>  	  BUCKs 1,2,3,4 can be used in single phase or multiphase mode.
>  	  Part number defines which single or multiphase mode is i used.
>  	  It supports software based voltage control
>  	  for different voltage domains.
> +	  TPS65224 PMIC has 4 BUCKs and 3 LDOs. BUCK12 can be used in dual phase.
> +	  All BUCKs and LDOs volatge can be controlled through software.
>  
>  config REGULATOR_TPS6524X
>  	tristate "TI TPS6524X Power regulators"
> diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
> index b7f0c8779..3c8e0b1cd 100644
> --- a/drivers/regulator/tps6594-regulator.c
> +++ b/drivers/regulator/tps6594-regulator.c
> @@ -66,6 +66,15 @@ static struct tps6594_regulator_irq_type tps6594_ext_regulator_irq_types[] = {
>  	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
>  };
>  
> +static struct tps6594_regulator_irq_type tps65224_ext_regulator_irq_types[] = {
> +	{ TPS65224_IRQ_NAME_VCCA_UVOV, "VCCA", "voltage out of range",
> +	  REGULATOR_EVENT_REGULATION_OUT },
> +	{ TPS65224_IRQ_NAME_VMON1_UVOV, "VMON1", "voltage out of range",
> +	  REGULATOR_EVENT_REGULATION_OUT },
> +	{ TPS65224_IRQ_NAME_VMON2_UVOV, "VMON2", "voltage out of range",
> +	  REGULATOR_EVENT_REGULATION_OUT },
> +};
> +
>  struct tps6594_regulator_irq_data {
>  	struct device *dev;
>  	struct tps6594_regulator_irq_type *type;
> @@ -122,6 +131,27 @@ static const struct linear_range ldos_4_ranges[] = {
>  	REGULATOR_LINEAR_RANGE(1200000, 0x20, 0x74, 25000),
>  };
>  
> +/* Voltage range for TPS65224 Bucks and LDOs */
> +static const struct linear_range tps65224_bucks_1_ranges[] = {
> +	REGULATOR_LINEAR_RANGE(500000, 0x0a, 0x0e, 20000),
> +	REGULATOR_LINEAR_RANGE(600000, 0x0f, 0x72, 5000),
> +	REGULATOR_LINEAR_RANGE(1100000, 0x73, 0xaa, 10000),
> +	REGULATOR_LINEAR_RANGE(1660000, 0xab, 0xfd, 20000),
> +};
> +
> +static const struct linear_range tps65224_bucks_2_3_4_ranges[] = {
> +	REGULATOR_LINEAR_RANGE(500000, 0x0, 0x1a, 25000),
> +	REGULATOR_LINEAR_RANGE(1200000, 0x1b, 0x45, 50000),
> +};
> +
> +static const struct linear_range tps65224_ldos_1_ranges[] = {
> +	REGULATOR_LINEAR_RANGE(1200000, 0xC, 0x36, 50000),
> +};
> +
> +static const struct linear_range tps65224_ldos_2_3_ranges[] = {
> +	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x38, 50000),
> +};
> +
>  /* Operations permitted on BUCK1/2/3/4/5 */
>  static const struct regulator_ops tps6594_bucks_ops = {
>  	.is_enabled		= regulator_is_enabled_regmap,
> @@ -197,6 +227,38 @@ static const struct regulator_desc buck_regs[] = {
>  			  4, 0, 0, NULL, 0, 0),
>  };
>  
> +/* Buck configuration for TPS65224 */
> +static const struct regulator_desc tps65224_buck_regs[] = {
> +	TPS6594_REGULATOR("BUCK1", "buck1", TPS6594_BUCK_1,
> +			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS65224_MASK_BUCK1_VSET,
> +			  TPS6594_REG_BUCKX_VOUT_1(0),
> +			  TPS65224_MASK_BUCK1_VSET,
> +			  TPS6594_REG_BUCKX_CTRL(0),
> +			  TPS6594_BIT_BUCK_EN, 0, 0, tps65224_bucks_1_ranges,
> +			  4, 0, 0, NULL, 0, 0),
> +	TPS6594_REGULATOR("BUCK2", "buck2", TPS6594_BUCK_2,
> +			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS65224_MASK_BUCKS_VSET,
> +			  TPS6594_REG_BUCKX_VOUT_1(1),
> +			  TPS65224_MASK_BUCKS_VSET,
> +			  TPS6594_REG_BUCKX_CTRL(1),
> +			  TPS6594_BIT_BUCK_EN, 0, 0, tps65224_bucks_2_3_4_ranges,
> +			  4, 0, 0, NULL, 0, 0),
> +	TPS6594_REGULATOR("BUCK3", "buck3", TPS6594_BUCK_3,
> +			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS65224_MASK_BUCKS_VSET,
> +			  TPS6594_REG_BUCKX_VOUT_1(2),
> +			  TPS65224_MASK_BUCKS_VSET,
> +			  TPS6594_REG_BUCKX_CTRL(2),
> +			  TPS6594_BIT_BUCK_EN, 0, 0, tps65224_bucks_2_3_4_ranges,
> +			  4, 0, 0, NULL, 0, 0),
> +	TPS6594_REGULATOR("BUCK4", "buck4", TPS6594_BUCK_4,
> +			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS65224_MASK_BUCKS_VSET,
> +			  TPS6594_REG_BUCKX_VOUT_1(3),
> +			  TPS65224_MASK_BUCKS_VSET,
> +			  TPS6594_REG_BUCKX_CTRL(3),
> +			  TPS6594_BIT_BUCK_EN, 0, 0, tps65224_bucks_2_3_4_ranges,
> +			  4, 0, 0, NULL, 0, 0),
> +};
> +
>  static struct tps6594_regulator_irq_type tps6594_buck1_irq_types[] = {
>  	{ TPS6594_IRQ_NAME_BUCK1_OV, "BUCK1", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
>  	{ TPS6594_IRQ_NAME_BUCK1_UV, "BUCK1", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
> @@ -269,6 +331,41 @@ static struct tps6594_regulator_irq_type tps6594_ldo4_irq_types[] = {
>  	  REGULATOR_EVENT_OVER_CURRENT },
>  };
>  
> +static struct tps6594_regulator_irq_type tps65224_buck1_irq_types[] = {
> +	{ TPS65224_IRQ_NAME_BUCK1_UVOV, "BUCK1", "voltage out of range",
> +	  REGULATOR_EVENT_REGULATION_OUT },
> +};
> +
> +static struct tps6594_regulator_irq_type tps65224_buck2_irq_types[] = {
> +	{ TPS65224_IRQ_NAME_BUCK2_UVOV, "BUCK2", "voltage out of range",
> +	  REGULATOR_EVENT_REGULATION_OUT },
> +};
> +
> +static struct tps6594_regulator_irq_type tps65224_buck3_irq_types[] = {
> +	{ TPS65224_IRQ_NAME_BUCK3_UVOV, "BUCK3", "voltage out of range",
> +	  REGULATOR_EVENT_REGULATION_OUT },
> +};
> +
> +static struct tps6594_regulator_irq_type tps65224_buck4_irq_types[] = {
> +	{ TPS65224_IRQ_NAME_BUCK4_UVOV, "BUCK4", "voltage out of range",
> +	  REGULATOR_EVENT_REGULATION_OUT },
> +};
> +
> +static struct tps6594_regulator_irq_type tps65224_ldo1_irq_types[] = {
> +	{ TPS65224_IRQ_NAME_LDO1_UVOV, "LDO1", "voltage out of range",
> +	  REGULATOR_EVENT_REGULATION_OUT },
> +};
> +
> +static struct tps6594_regulator_irq_type tps65224_ldo2_irq_types[] = {
> +	{ TPS65224_IRQ_NAME_LDO2_UVOV, "LDO2", "voltage out of range",
> +	  REGULATOR_EVENT_REGULATION_OUT },
> +};
> +
> +static struct tps6594_regulator_irq_type tps65224_ldo3_irq_types[] = {
> +	{ TPS65224_IRQ_NAME_LDO3_UVOV, "LDO3", "voltage out of range",
> +	  REGULATOR_EVENT_REGULATION_OUT },
> +};
> +
>  static struct tps6594_regulator_irq_type *tps6594_bucks_irq_types[] = {
>  	tps6594_buck1_irq_types,
>  	tps6594_buck2_irq_types,
> @@ -284,7 +381,20 @@ static struct tps6594_regulator_irq_type *tps6594_ldos_irq_types[] = {
>  	tps6594_ldo4_irq_types,
>  };
>  
> -static const struct regulator_desc multi_regs[] = {
> +static struct tps6594_regulator_irq_type *tps65224_bucks_irq_types[] = {
> +	tps65224_buck1_irq_types,
> +	tps65224_buck2_irq_types,
> +	tps65224_buck3_irq_types,
> +	tps65224_buck4_irq_types,
> +};
> +
> +static struct tps6594_regulator_irq_type *tps65224_ldos_irq_types[] = {
> +	tps65224_ldo1_irq_types,
> +	tps65224_ldo2_irq_types,
> +	tps65224_ldo3_irq_types,
> +};
> +
> +static const struct regulator_desc tps6594_multi_regs[] = {
>  	TPS6594_REGULATOR("BUCK12", "buck12", TPS6594_BUCK_1,
>  			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
>  			  TPS6594_REG_BUCKX_VOUT_1(1),
> @@ -315,7 +425,17 @@ static const struct regulator_desc multi_regs[] = {
>  			  4, 4000, 0, NULL, 0, 0),
>  };
>  
> -static const struct regulator_desc ldo_regs[] = {
> +static const struct regulator_desc tps65224_multi_regs[] = {
> +	TPS6594_REGULATOR("BUCK12", "buck12", TPS6594_BUCK_1,
> +			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS65224_MASK_BUCK1_VSET,
> +			  TPS6594_REG_BUCKX_VOUT_1(0),
> +			  TPS65224_MASK_BUCK1_VSET,
> +			  TPS6594_REG_BUCKX_CTRL(0),
> +			  TPS6594_BIT_BUCK_EN, 0, 0, tps65224_bucks_1_ranges,
> +			  4, 4000, 0, NULL, 0, 0),
> +};
> +
> +static const struct regulator_desc tps6594_ldo_regs[] = {
>  	TPS6594_REGULATOR("LDO1", "ldo1", TPS6594_LDO_1,
>  			  REGULATOR_VOLTAGE, tps6594_ldos_1_2_3_ops, TPS6594_MASK_LDO123_VSET,
>  			  TPS6594_REG_LDOX_VOUT(0),
> @@ -346,6 +466,30 @@ static const struct regulator_desc ldo_regs[] = {
>  			  1, 0, 0, NULL, 0, 0),
>  };
>  
> +static const struct regulator_desc tps65224_ldo_regs[] = {
> +	TPS6594_REGULATOR("LDO1", "ldo1", TPS6594_LDO_1,
> +			  REGULATOR_VOLTAGE, tps6594_ldos_1_2_3_ops, TPS6594_MASK_LDO123_VSET,
> +			  TPS6594_REG_LDOX_VOUT(0),
> +			  TPS6594_MASK_LDO123_VSET,
> +			  TPS6594_REG_LDOX_CTRL(0),
> +			  TPS6594_BIT_LDO_EN, 0, 0, tps65224_ldos_1_ranges,
> +			  1, 0, 0, NULL, 0, TPS6594_BIT_LDO_BYPASS),
> +	TPS6594_REGULATOR("LDO2", "ldo2", TPS6594_LDO_2,
> +			  REGULATOR_VOLTAGE, tps6594_ldos_1_2_3_ops, TPS6594_MASK_LDO123_VSET,
> +			  TPS6594_REG_LDOX_VOUT(1),
> +			  TPS6594_MASK_LDO123_VSET,
> +			  TPS6594_REG_LDOX_CTRL(1),
> +			  TPS6594_BIT_LDO_EN, 0, 0, tps65224_ldos_2_3_ranges,
> +			  1, 0, 0, NULL, 0, TPS6594_BIT_LDO_BYPASS),
> +	TPS6594_REGULATOR("LDO3", "ldo3", TPS6594_LDO_3,
> +			  REGULATOR_VOLTAGE, tps6594_ldos_1_2_3_ops, TPS6594_MASK_LDO123_VSET,
> +			  TPS6594_REG_LDOX_VOUT(2),
> +			  TPS6594_MASK_LDO123_VSET,
> +			  TPS6594_REG_LDOX_CTRL(2),
> +			  TPS6594_BIT_LDO_EN, 0, 0, tps65224_ldos_2_3_ranges,
> +			  1, 0, 0, NULL, 0, TPS6594_BIT_LDO_BYPASS),
> +};
> +
>  static irqreturn_t tps6594_regulator_irq_handler(int irq, void *data)
>  {
>  	struct tps6594_regulator_irq_data *irq_data = data;
> @@ -369,17 +513,18 @@ static irqreturn_t tps6594_regulator_irq_handler(int irq, void *data)
>  static int tps6594_request_reg_irqs(struct platform_device *pdev,
>  				    struct regulator_dev *rdev,
>  				    struct tps6594_regulator_irq_data *irq_data,
> -				    struct tps6594_regulator_irq_type *tps6594_regs_irq_types,
> +				    struct tps6594_regulator_irq_type *regs_irq_types,
> +				    size_t interrupt_cnt,
>  				    int *irq_idx)
>  {
>  	struct tps6594_regulator_irq_type *irq_type;
>  	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
> -	int j;
> +	size_t j;
>  	int irq;
>  	int error;
>  
> -	for (j = 0; j < REGS_INT_NB; j++) {
> -		irq_type = &tps6594_regs_irq_types[j];
> +	for (j = 0; j < interrupt_cnt; j++) {
> +		irq_type = &regs_irq_types[j];
>  		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
>  		if (irq < 0)
>  			return -EINVAL;
> @@ -412,14 +557,38 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
>  	struct tps6594_ext_regulator_irq_data *irq_ext_reg_data;
>  	struct tps6594_regulator_irq_type *irq_type;
>  	u8 buck_configured[BUCK_NB] = { 0 };
> +	u8 ldo_configured[LDO_NB] = { 0 };

This should be bool and the related changes like using true/false.

Actually, on reviewing this code even more, I really suggest you first
do some clean up to this driver and then just change this to:

	int nr_ldo;

Then use that instead of LDO_NB.

buck_configured[] should be bool as well.

>  	u8 buck_multi[MULTI_PHASE_NB] = { 0 };
> -	static const char * const multiphases[] = {"buck12", "buck123", "buck1234", "buck34"};
> +	static const char * const tps6594_multiphases[] = {"buck12", "buck123",
> +							   "buck1234", "buck34"};
> +	static const char * const tps65224_multiphases[] = {"buck12"};

The tps65224_multiphases[] array is never used except to get the
ARRAY_SIZE().  Neither of these are necessary.  Just use
multi_regs[multi].supply_name instead.


>  	static const char *npname;
>  	int error, i, irq, multi, delta;
>  	int irq_idx = 0;
>  	int buck_idx = 0;
> +	unsigned int multi_phase_cnt = 0;

No need to initialize this here.

>  	size_t ext_reg_irq_nb = 2;
>  	size_t reg_irq_nb;
> +	struct tps6594_regulator_irq_type **bucks_irq_types;
> +	const struct regulator_desc *multi_regs;
> +	struct tps6594_regulator_irq_type **ldos_irq_types;
> +	const struct regulator_desc *ldo_regs;
> +	size_t interrupt_count;
> +
> +	if (tps->chip_id == TPS65224) {
> +		bucks_irq_types = tps65224_bucks_irq_types;
> +		interrupt_count = ARRAY_SIZE(tps65224_buck1_irq_types);
> +		multi_regs = tps65224_multi_regs;
> +		ldos_irq_types = tps65224_ldos_irq_types;
> +		ldo_regs = tps65224_ldo_regs;
> +	} else {
> +		bucks_irq_types = tps6594_bucks_irq_types;
> +		interrupt_count = ARRAY_SIZE(tps6594_buck1_irq_types);
> +		multi_regs = tps6594_multi_regs;
> +		ldos_irq_types = tps6594_ldos_irq_types;
> +		ldo_regs = tps6594_ldo_regs;


Initialize multi_phase_cnt in this block with all the other variables
instead of below.

> +	}
> +
>  	enum {
>  		MULTI_BUCK12,
>  		MULTI_BUCK123,
> @@ -434,6 +603,10 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
>  	config.driver_data = tps;
>  	config.regmap = tps->regmap;
>  
> +	multi_phase_cnt = (tps->chip_id == TPS65224) ?
> +			   ARRAY_SIZE(tps65224_multiphases) :
> +			   ARRAY_SIZE(tps6594_multiphases);
> +
>  	/*
>  	 * Switch case defines different possible multi phase config
>  	 * This is based on dts buck node name.
> @@ -442,13 +615,13 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
>  	 * In case of Multiphase configuration, value should be defined for
>  	 * buck_configured to avoid creating bucks for every buck in multiphase
>  	 */
> -	for (multi = MULTI_FIRST; multi < MULTI_NUM; multi++) {
> -		np = of_find_node_by_name(tps->dev->of_node, multiphases[multi]);
> +	for (multi = MULTI_FIRST; multi < multi_phase_cnt; multi++) {
> +		np = of_find_node_by_name(tps->dev->of_node, tps6594_multiphases[multi]);

Use multi_regs[multi].supply_name here.

>  		npname = of_node_full_name(np);
>  		np_pmic_parent = of_get_parent(of_get_parent(np));
>  		if (of_node_cmp(of_node_full_name(np_pmic_parent), tps->dev->of_node->full_name))
>  			continue;
> -		delta = strcmp(npname, multiphases[multi]);
> +		delta = strcmp(npname, tps6594_multiphases[multi]);
>  		if (!delta) {

Unrelated to your patch but this should be:

	if (strcmp(npname, tps6594_multiphases[multi]) == 0) {

The == means that the strings are equal.  No need for a delta variable.

>  			switch (multi) {
>  			case MULTI_BUCK12:
> @@ -486,6 +659,11 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
>  		/* There is only 4 buck on LP8764 */
>  		buck_configured[4] = 1;
>  		reg_irq_nb = size_mul(REGS_INT_NB, (BUCK_NB - 1));
> +	} else if (tps->chip_id == TPS65224) {
> +		/* TPS65224 has 4 bucks and 3 LDOs. 1 Interrupt for each buck and ldo */
> +		buck_configured[4] = 1;
> +		ldo_configured[3] = 1;
> +		reg_irq_nb = size_mul(1, (size_add((BUCK_NB - 1), (LDO_NB - 1))));
>  	} else {
>  		reg_irq_nb = size_mul(REGS_INT_NB, (size_add(BUCK_NB, LDO_NB)));

No need for size_add/mul().  These are small constants so it's not
going to integer overflow.

The other suggestion here would be to do a clean up of the driver first
so instead of marking the last buck_configured[4] = 1; we would instead
say "nr_buck = 4;"  Then the math become easier and we can remove the
comments and the confusing subtractions.

        if (tps->chip_id == LP8764) {
                nr_buck = 4;
                nr_ldo = 0;
        } else if (tps->chip_id == TPS65224) {
                nr_buck = ARRAY_SIZE(tps65224_buck_regs);
                nr_ldo = ARRAY_SIZE(tps65224_ldo_regs);
        } else {
                nr_buck = BUCK_NB;  // FIXME.  ARRAY_SIZE()
                nr_ldo = ARRAY_SIZE(tps6594_ldo_regs);
        }

        reg_irq_nb = multi_regs * (nr_buck + nr_ldo);

>  	}
> @@ -495,7 +673,7 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
>  	if (!irq_data)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < MULTI_PHASE_NB; i++) {
> +	for (i = 0; i < multi_phase_cnt; i++) {
>  		if (buck_multi[i] == 0)
>  			continue;
>  
> @@ -508,18 +686,23 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
>  		/* config multiphase buck12+buck34 */
>  		if (i == 1)
>  			buck_idx = 2;
> +
>  		error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
> -						 tps6594_bucks_irq_types[buck_idx], &irq_idx);
> +						 bucks_irq_types[buck_idx],
> +						 interrupt_count, &irq_idx);
>  		if (error)
>  			return error;
> +
>  		error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
> -						 tps6594_bucks_irq_types[buck_idx + 1], &irq_idx);
> +						 bucks_irq_types[buck_idx + 1],
> +						 interrupt_count, &irq_idx);
>  		if (error)
>  			return error;
>  
>  		if (i == 2 || i == 3) {
>  			error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
>  							 tps6594_bucks_irq_types[buck_idx + 2],
> +							 interrupt_count,
>  							 &irq_idx);
>  			if (error)
>  				return error;
> @@ -527,6 +710,7 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
>  		if (i == 3) {
>  			error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
>  							 tps6594_bucks_irq_types[buck_idx + 3],
> +							 interrupt_count,
>  							 &irq_idx);
>  			if (error)
>  				return error;
> @@ -537,21 +721,26 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
>  		if (buck_configured[i] == 1)
>  			continue;
>  
> -		rdev = devm_regulator_register(&pdev->dev, &buck_regs[i], &config);
> +		const struct regulator_desc *buck_cfg = (tps->chip_id == TPS65224) ?
> +							 tps65224_buck_regs : buck_regs;
> +
> +		rdev = devm_regulator_register(&pdev->dev, &buck_cfg[i], &config);
>  		if (IS_ERR(rdev))
>  			return dev_err_probe(tps->dev, PTR_ERR(rdev),
> -					     "failed to register %s regulator\n",
> -					     pdev->name);
> +					     "failed to register %s regulator\n", pdev->name);

There are too many unrelated white space changes in this patch.

>  
>  		error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
> -						 tps6594_bucks_irq_types[i], &irq_idx);
> +						 bucks_irq_types[i], interrupt_count, &irq_idx);
>  		if (error)
>  			return error;
>  	}
>  
> -	/* LP8764 dosen't have LDO */
> +	/* LP8764 doesn't have LDO */
>  	if (tps->chip_id != LP8764) {
> -		for (i = 0; i < ARRAY_SIZE(ldo_regs); i++) {
> +		for (i = 0; i < LDO_NB; i++) {
> +			if (ldo_configured[i] == 1)
> +				continue;
> +

Now that we have introduced a nr_ldo variable we can delete the
/* LP8764 doesn't have LDO */ comment and the if LP8764 statement and
the if (ldo_configured[i] == 1) condition.

	for (i = 0; i < nr_ldo; i++) {
		rdev = devm_regulator_register(&pdev->dev, &ldo_regs[i], &config);

The BUCK loop would only loop nr_buck times as well.

>  			rdev = devm_regulator_register(&pdev->dev, &ldo_regs[i], &config);
>  			if (IS_ERR(rdev))
>  				return dev_err_probe(tps->dev, PTR_ERR(rdev),
> @@ -559,7 +748,7 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
>  						     pdev->name);
>  
>  			error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
> -							 tps6594_ldos_irq_types[i],
> +							 ldos_irq_types[i], interrupt_count,
>  							 &irq_idx);
>  			if (error)
>  				return error;
> @@ -568,16 +757,21 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
>  
>  	if (tps->chip_id == LP8764)
>  		ext_reg_irq_nb = ARRAY_SIZE(tps6594_ext_regulator_irq_types);
> +	else if (tps->chip_id == TPS65224)
> +		ext_reg_irq_nb = ARRAY_SIZE(tps65224_ext_regulator_irq_types);

Declare an irq_types pointer.

	if (tps->chip_id == TPS65224) {
		irq_types = tps65224_ext_regulator_irq_types;
		irq_count = ARRAY_SIZE(tps65224_ext_regulator_irq_types);
	} else {
		irq_types = tps6594_ext_regulator_irq_types;
		if (tps->chip_id == LP8764)
			irq_count = ARRAY_SIZE(tps6594_ext_regulator_irq_types);
		else
			irq_count = 2;
	}

>  
>  	irq_ext_reg_data = devm_kmalloc_array(tps->dev,
> -					ext_reg_irq_nb,
> -					sizeof(struct tps6594_ext_regulator_irq_data),
> -					GFP_KERNEL);
> +					      ext_reg_irq_nb,
> +					      sizeof(struct tps6594_ext_regulator_irq_data),
> +					      GFP_KERNEL);

Unrelated.

>  	if (!irq_ext_reg_data)
>  		return -ENOMEM;
>  
>  	for (i = 0; i < ext_reg_irq_nb; ++i) {
> -		irq_type = &tps6594_ext_regulator_irq_types[i];
> +		if (tps->chip_id == TPS65224)
> +			irq_type = &tps65224_ext_regulator_irq_types[i];
> +		else
> +			irq_type = &tps6594_ext_regulator_irq_types[i];
>  
>  		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
>  		if (irq < 0)

regards,
dan carpenter

