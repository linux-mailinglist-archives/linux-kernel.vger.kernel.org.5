Return-Path: <linux-kernel+bounces-98581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32411877C48
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DFD1C20B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E3A14284;
	Mon, 11 Mar 2024 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="TKzUSJ5g"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCD013AC0;
	Mon, 11 Mar 2024 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148225; cv=none; b=GIHltqj2QgLEQ5W5OZXlOuSXev7Q3vX792luAxmz0Z2foXH3KNyQSnH8bO8VYQwIlQLGtwyks8kgUDRGiSacMjbdf8yGbCRqBTGtKGfVm3ki1FWprHwQf49qMTx/xLypcq0eAXZfbTH5d+kfZ2As01nbqhp1Jo4LjkOmV8iXxjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148225; c=relaxed/simple;
	bh=SscYIF7vE+KO1fHQMXRIaw7eVNGaHMYtCtB+jMcDxYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yl8ZnFHa9/xYhJnxJ8XQKfSG5nK0jcVckJM0jLg4OmP60RvmlN0l50zKQ3WuHS+D3MWgAxfHuIrzorT9+eu+974m+5XqDgNrTUXIXu8N7RkT4WTh5EtvAQ+hv7NTGwq3n+2HJm31c0Xz3oQSFR4n40/sG+QEyrjwVW4GwwH7hxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=TKzUSJ5g; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1710148221; x=1741684221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uTDAPCzmuP745QYe+GL9SisGbnAWI4D5kd3ai+SNj1I=;
  b=TKzUSJ5gH2v8G9ZlPNpAdnLSwFfqYdS2oB6DXan7fDmfiLODkHKrAoW5
   Zdi3NTtX31iQczsv2agzMByveh41Xu4K/ogDiGYSHwQdFWvj9gcFeJuHO
   MRhgg5c7Qao2v6+12Ce64dqwNrcmSOC7g4AgLaf8OwotwWuaymUI5V080
   vZy9jJeIl3pghYimunWIGlx8EffDjXH/eThABJPdBlixmoX1+JAm8vJpX
   DXxzYRKC0FYAifSZbdYLcEOJLHRNQ1V9WzNCk3G0LU2fRiulTs15k3Rxm
   x98gvbRPV74q2vba7zhp2HeW0em6X1rSRRvcJ2ah6w+PHM6PwyEBLLHed
   Q==;
X-IronPort-AV: E=Sophos;i="6.07,116,1708383600"; 
   d="scan'208";a="35830094"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 11 Mar 2024 10:09:09 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 8BAE528007C;
	Mon, 11 Mar 2024 10:09:08 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: ping.bai@nxp.com, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH v2 2/3] regulator: pca9450: add pca9451a support
Date: Mon, 11 Mar 2024 10:09:12 +0100
Message-ID: <6027895.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240311084758.377889-3-joy.zou@nxp.com>
References: <20240311084758.377889-1-joy.zou@nxp.com> <20240311084758.377889-3-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,

thanks for the update.

Am Montag, 11. M=E4rz 2024, 09:47:56 CET schrieb Joy Zou:
> Adding support for pmic pca9451a.
>=20
> This patch support old and new pmic pca9451a. The new pmic trimed BUCK1.
> The default value of Toff_Deb is used to distinguish the old and new pmic.

This section doesn't apply anymore. Please remove it.

> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes in v2:
> 1. remove the old part support because the old part only is used for samp=
le
> and is diffcult to distinguish old and new part. so drop old part.
> 2. remove the unnecessary marco definition in the file pca9450.h.
> ---
>  drivers/regulator/pca9450-regulator.c | 197 +++++++++++++++++++++++++-
>  include/linux/regulator/pca9450.h     |   1 +
>  2 files changed, 195 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pc=
a9450-regulator.c
> index 2ab365d2749f..50c324e275b5 100644
> --- a/drivers/regulator/pca9450-regulator.c
> +++ b/drivers/regulator/pca9450-regulator.c
> @@ -103,7 +103,15 @@ static const struct regulator_ops pca9450_ldo_regula=
tor_ops =3D {
>   * 0.60 to 2.1875V (12.5mV step)
>   */
>  static const struct linear_range pca9450_dvs_buck_volts[] =3D {
> -	REGULATOR_LINEAR_RANGE(600000,  0x00, 0x7F, 12500),
> +	REGULATOR_LINEAR_RANGE(600000, 0x00, 0x7F, 12500),
> +};

That's an unrelated change.

> +/*
> + * BUCK1/3
> + * 0.65 to 2.2375V (12.5mV step)
> + */
> +static const struct linear_range pca9451a_dvs_buck_volts[] =3D {
> +	REGULATOR_LINEAR_RANGE(650000, 0x00, 0x7F, 12500),
>  };
> =20
>  /*
> @@ -662,6 +670,178 @@ static const struct pca9450_regulator_desc pca9450b=
c_regulators[] =3D {
>  	},
>  };
> =20
> +static const struct pca9450_regulator_desc pca9451a_regulators[] =3D {
> +	{
> +		.desc =3D {
> +			.name =3D "buck1",
> +			.of_match =3D of_match_ptr("BUCK1"),
> +			.regulators_node =3D of_match_ptr("regulators"),
> +			.id =3D PCA9450_BUCK1,
> +			.ops =3D &pca9450_dvs_buck_regulator_ops,
> +			.type =3D REGULATOR_VOLTAGE,
> +			.n_voltages =3D PCA9450_BUCK1_VOLTAGE_NUM,
> +			.linear_ranges =3D pca9451a_dvs_buck_volts,
> +			.n_linear_ranges =3D ARRAY_SIZE(pca9451a_dvs_buck_volts),
> +			.vsel_reg =3D PCA9450_REG_BUCK1OUT_DVS0,
> +			.vsel_mask =3D BUCK1OUT_DVS0_MASK,
> +			.enable_reg =3D PCA9450_REG_BUCK1CTRL,
> +			.enable_mask =3D BUCK1_ENMODE_MASK,
> +			.enable_val =3D BUCK_ENMODE_ONREQ,
> +			.ramp_mask =3D BUCK1_RAMP_MASK,
> +			.ramp_delay_table =3D pca9450_dvs_buck_ramp_table,
> +			.n_ramp_values =3D ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
> +			.owner =3D THIS_MODULE,
> +			.of_parse_cb =3D pca9450_set_dvs_levels,
> +		},
> +		.dvs =3D {
> +			.run_reg =3D PCA9450_REG_BUCK1OUT_DVS0,
> +			.run_mask =3D BUCK1OUT_DVS0_MASK,
> +			.standby_reg =3D PCA9450_REG_BUCK1OUT_DVS1,
> +			.standby_mask =3D BUCK1OUT_DVS1_MASK,
> +		},
> +	},
> +	{
> +		.desc =3D {
> +			.name =3D "buck2",
> +			.of_match =3D of_match_ptr("BUCK2"),
> +			.regulators_node =3D of_match_ptr("regulators"),
> +			.id =3D PCA9450_BUCK2,
> +			.ops =3D &pca9450_dvs_buck_regulator_ops,
> +			.type =3D REGULATOR_VOLTAGE,
> +			.n_voltages =3D PCA9450_BUCK2_VOLTAGE_NUM,
> +			.linear_ranges =3D pca9450_dvs_buck_volts,
> +			.n_linear_ranges =3D ARRAY_SIZE(pca9450_dvs_buck_volts),
> +			.vsel_reg =3D PCA9450_REG_BUCK2OUT_DVS0,
> +			.vsel_mask =3D BUCK2OUT_DVS0_MASK,
> +			.enable_reg =3D PCA9450_REG_BUCK2CTRL,
> +			.enable_mask =3D BUCK2_ENMODE_MASK,
> +			.enable_val =3D BUCK_ENMODE_ONREQ_STBYREQ,
> +			.ramp_mask =3D BUCK2_RAMP_MASK,
> +			.ramp_delay_table =3D pca9450_dvs_buck_ramp_table,
> +			.n_ramp_values =3D ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
> +			.owner =3D THIS_MODULE,
> +			.of_parse_cb =3D pca9450_set_dvs_levels,
> +		},
> +		.dvs =3D {
> +			.run_reg =3D PCA9450_REG_BUCK2OUT_DVS0,
> +			.run_mask =3D BUCK2OUT_DVS0_MASK,
> +			.standby_reg =3D PCA9450_REG_BUCK2OUT_DVS1,
> +			.standby_mask =3D BUCK2OUT_DVS1_MASK,
> +		},
> +	},
> +	{
> +		.desc =3D {
> +			.name =3D "buck4",
> +			.of_match =3D of_match_ptr("BUCK4"),
> +			.regulators_node =3D of_match_ptr("regulators"),
> +			.id =3D PCA9450_BUCK4,
> +			.ops =3D &pca9450_buck_regulator_ops,
> +			.type =3D REGULATOR_VOLTAGE,
> +			.n_voltages =3D PCA9450_BUCK4_VOLTAGE_NUM,
> +			.linear_ranges =3D pca9450_buck_volts,
> +			.n_linear_ranges =3D ARRAY_SIZE(pca9450_buck_volts),
> +			.vsel_reg =3D PCA9450_REG_BUCK4OUT,
> +			.vsel_mask =3D BUCK4OUT_MASK,
> +			.enable_reg =3D PCA9450_REG_BUCK4CTRL,
> +			.enable_mask =3D BUCK4_ENMODE_MASK,
> +			.enable_val =3D BUCK_ENMODE_ONREQ,
> +			.owner =3D THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc =3D {
> +			.name =3D "buck5",
> +			.of_match =3D of_match_ptr("BUCK5"),
> +			.regulators_node =3D of_match_ptr("regulators"),
> +			.id =3D PCA9450_BUCK5,
> +			.ops =3D &pca9450_buck_regulator_ops,
> +			.type =3D REGULATOR_VOLTAGE,
> +			.n_voltages =3D PCA9450_BUCK5_VOLTAGE_NUM,
> +			.linear_ranges =3D pca9450_buck_volts,
> +			.n_linear_ranges =3D ARRAY_SIZE(pca9450_buck_volts),
> +			.vsel_reg =3D PCA9450_REG_BUCK5OUT,
> +			.vsel_mask =3D BUCK5OUT_MASK,
> +			.enable_reg =3D PCA9450_REG_BUCK5CTRL,
> +			.enable_mask =3D BUCK5_ENMODE_MASK,
> +			.enable_val =3D BUCK_ENMODE_ONREQ,
> +			.owner =3D THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc =3D {
> +			.name =3D "buck6",
> +			.of_match =3D of_match_ptr("BUCK6"),
> +			.regulators_node =3D of_match_ptr("regulators"),
> +			.id =3D PCA9450_BUCK6,
> +			.ops =3D &pca9450_buck_regulator_ops,
> +			.type =3D REGULATOR_VOLTAGE,
> +			.n_voltages =3D PCA9450_BUCK6_VOLTAGE_NUM,
> +			.linear_ranges =3D pca9450_buck_volts,
> +			.n_linear_ranges =3D ARRAY_SIZE(pca9450_buck_volts),
> +			.vsel_reg =3D PCA9450_REG_BUCK6OUT,
> +			.vsel_mask =3D BUCK6OUT_MASK,
> +			.enable_reg =3D PCA9450_REG_BUCK6CTRL,
> +			.enable_mask =3D BUCK6_ENMODE_MASK,
> +			.enable_val =3D BUCK_ENMODE_ONREQ,
> +			.owner =3D THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc =3D {
> +			.name =3D "ldo1",
> +			.of_match =3D of_match_ptr("LDO1"),
> +			.regulators_node =3D of_match_ptr("regulators"),
> +			.id =3D PCA9450_LDO1,
> +			.ops =3D &pca9450_ldo_regulator_ops,
> +			.type =3D REGULATOR_VOLTAGE,
> +			.n_voltages =3D PCA9450_LDO1_VOLTAGE_NUM,
> +			.linear_ranges =3D pca9450_ldo1_volts,
> +			.n_linear_ranges =3D ARRAY_SIZE(pca9450_ldo1_volts),
> +			.vsel_reg =3D PCA9450_REG_LDO1CTRL,
> +			.vsel_mask =3D LDO1OUT_MASK,
> +			.enable_reg =3D PCA9450_REG_LDO1CTRL,
> +			.enable_mask =3D LDO1_EN_MASK,
> +			.owner =3D THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc =3D {
> +			.name =3D "ldo4",
> +			.of_match =3D of_match_ptr("LDO4"),
> +			.regulators_node =3D of_match_ptr("regulators"),
> +			.id =3D PCA9450_LDO4,
> +			.ops =3D &pca9450_ldo_regulator_ops,
> +			.type =3D REGULATOR_VOLTAGE,
> +			.n_voltages =3D PCA9450_LDO4_VOLTAGE_NUM,
> +			.linear_ranges =3D pca9450_ldo34_volts,
> +			.n_linear_ranges =3D ARRAY_SIZE(pca9450_ldo34_volts),
> +			.vsel_reg =3D PCA9450_REG_LDO4CTRL,
> +			.vsel_mask =3D LDO4OUT_MASK,
> +			.enable_reg =3D PCA9450_REG_LDO4CTRL,
> +			.enable_mask =3D LDO4_EN_MASK,
> +			.owner =3D THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc =3D {
> +			.name =3D "ldo5",
> +			.of_match =3D of_match_ptr("LDO5"),
> +			.regulators_node =3D of_match_ptr("regulators"),
> +			.id =3D PCA9450_LDO5,
> +			.ops =3D &pca9450_ldo_regulator_ops,
> +			.type =3D REGULATOR_VOLTAGE,
> +			.n_voltages =3D PCA9450_LDO5_VOLTAGE_NUM,
> +			.linear_ranges =3D pca9450_ldo5_volts,
> +			.n_linear_ranges =3D ARRAY_SIZE(pca9450_ldo5_volts),
> +			.vsel_reg =3D PCA9450_REG_LDO5CTRL_H,
> +			.vsel_mask =3D LDO5HOUT_MASK,
> +			.enable_reg =3D PCA9450_REG_LDO5CTRL_H,
> +			.enable_mask =3D LDO5H_EN_MASK,
> +			.owner =3D THIS_MODULE,
> +		},
> +	},
> +};
> +
>  static irqreturn_t pca9450_irq_handler(int irq, void *data)
>  {
>  	struct pca9450 *pca9450 =3D data;
> @@ -729,6 +909,10 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
>  		regulator_desc =3D pca9450bc_regulators;
>  		pca9450->rcnt =3D ARRAY_SIZE(pca9450bc_regulators);
>  		break;
> +	case PCA9450_TYPE_PCA9451A:
> +		regulator_desc =3D pca9451a_regulators;
> +		pca9450->rcnt =3D ARRAY_SIZE(pca9451a_regulators);
> +		break;
>  	default:
>  		dev_err(&i2c->dev, "Unknown device type");
>  		return -EINVAL;
> @@ -755,7 +939,8 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
> =20
>  	/* Check your board and dts for match the right pmic */
>  	if (((device_id >> 4) !=3D 0x1 && type =3D=3D PCA9450_TYPE_PCA9450A) ||
> -	    ((device_id >> 4) !=3D 0x3 && type =3D=3D PCA9450_TYPE_PCA9450BC)) {
> +	    ((device_id >> 4) !=3D 0x3 && type =3D=3D PCA9450_TYPE_PCA9450BC) ||
> +	    ((device_id >> 4) !=3D 0x9 && type =3D=3D PCA9450_TYPE_PCA9451A)) {
>  		dev_err(&i2c->dev, "Device id(%x) mismatched\n",
>  			device_id >> 4);
>  		return -EINVAL;
> @@ -767,6 +952,7 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
>  		const struct pca9450_regulator_desc *r;
> =20
>  		r =3D &regulator_desc[i];
> +

Please don't add this empty line. Seems like a leftover from v1.

Thanks and best regards,
Alexander

>  		desc =3D &r->desc;
> =20
>  		config.regmap =3D pca9450->regmap;
> @@ -846,7 +1032,8 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
>  	}
> =20
>  	dev_info(&i2c->dev, "%s probed.\n",
> -		type =3D=3D PCA9450_TYPE_PCA9450A ? "pca9450a" : "pca9450bc");
> +		type =3D=3D PCA9450_TYPE_PCA9450A ? "pca9450a" :
> +		(type =3D=3D PCA9450_TYPE_PCA9451A ? "pca9451a" : "pca9450bc"));
> =20
>  	return 0;
>  }
> @@ -864,6 +1051,10 @@ static const struct of_device_id pca9450_of_match[]=
 =3D {
>  		.compatible =3D "nxp,pca9450c",
>  		.data =3D (void *)PCA9450_TYPE_PCA9450BC,
>  	},
> +	{
> +		.compatible =3D "nxp,pca9451a",
> +		.data =3D (void *)PCA9450_TYPE_PCA9451A,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, pca9450_of_match);
> diff --git a/include/linux/regulator/pca9450.h b/include/linux/regulator/=
pca9450.h
> index 505c908dbb81..243633c8dceb 100644
> --- a/include/linux/regulator/pca9450.h
> +++ b/include/linux/regulator/pca9450.h
> @@ -9,6 +9,7 @@
>  enum pca9450_chip_type {
>  	PCA9450_TYPE_PCA9450A =3D 0,
>  	PCA9450_TYPE_PCA9450BC,
> +	PCA9450_TYPE_PCA9451A,
>  	PCA9450_TYPE_AMOUNT,
>  };
> =20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



