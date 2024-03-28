Return-Path: <linux-kernel+bounces-123298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACCF890641
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5A01C306E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A9E7EEFD;
	Thu, 28 Mar 2024 16:46:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93F218C22;
	Thu, 28 Mar 2024 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644403; cv=none; b=pQgVpe1OyGc9VXXEQVkJeKQq8Ev4sDNPCj0+0JBq/3CsSgX027MIl/+tPLqHsiCGS9Uo8cn3tlMVKU3c26Q4pM0qp4T6nNGu6Gbl0uKRV1exd/KUjPmgQ+8WuILUAEag1mEiq3VV+0qPRvOBCdeymJlBgLV1S6yGnE2eAc8DWnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644403; c=relaxed/simple;
	bh=/7oEBbCWMXpbKoQrKMMTnevOb8vD6EJN8BtbKnGfIFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IK+sbD7yVL5qVPrUJb8opSDQL+ik1BBEPR2XEgwya/wi9fRExFvh7feFQVgs+C8hfvBuaf7Pm0NfavNCVWuK77Da2WwzLjmejSh+owj1J+4yhTRyrnuymkoh3PjWSBmqwg8ql+gakNfrcyTHNClyGEU95a0wllmxK1VMqNlwHgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B32C51476;
	Thu, 28 Mar 2024 09:47:13 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 983E43F694;
	Thu, 28 Mar 2024 09:46:38 -0700 (PDT)
Date: Thu, 28 Mar 2024 16:46:36 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: Re: [PATCH v6 4/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Message-ID: <ZgWe7ISUoCsdn5LB@pluto>
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
 <20240323-pinctrl-scmi-v6-4-a895243257c0@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323-pinctrl-scmi-v6-4-a895243257c0@nxp.com>

On Sat, Mar 23, 2024 at 08:15:17PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> scmi-pinctrl driver implements pinctrl driver interface and using
> SCMI protocol to redirect messages from pinctrl subsystem SDK to
> SCMI platform firmware, which does the changes in HW.
> 

Hi,

> Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  MAINTAINERS                         |   1 +
>  drivers/firmware/arm_scmi/pinctrl.c |   1 +
>  drivers/pinctrl/Kconfig             |  11 +
>  drivers/pinctrl/Makefile            |   1 +
>  drivers/pinctrl/pinctrl-scmi.c      | 564 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 578 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4b511a55101c..d8270ac6651a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21457,6 +21457,7 @@ F:	drivers/cpufreq/sc[mp]i-cpufreq.c
>  F:	drivers/firmware/arm_scmi/
>  F:	drivers/firmware/arm_scpi.c
>  F:	drivers/hwmon/scmi-hwmon.c
> +F:	drivers/pinctrl/pinctrl-scmi.c
>  F:	drivers/pmdomain/arm/
>  F:	drivers/powercap/arm_scmi_powercap.c
>  F:	drivers/regulator/scmi-regulator.c
> diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
> index 87d9b89cab13..0ecefe855432 100644
> --- a/drivers/firmware/arm_scmi/pinctrl.c
> +++ b/drivers/firmware/arm_scmi/pinctrl.c
> @@ -465,6 +465,7 @@ scmi_pinctrl_settings_conf(const struct scmi_protocol_handle *ph,
>  
>  		tx = t->tx.buf;
>  		tx->identifier = cpu_to_le32(selector);
> +		tx->function_id = cpu_to_le32(0xFFFFFFFF);

As already said....does not belong to this patch

>  		attributes = FIELD_PREP(GENMASK(1, 0), type) |
>  			FIELD_PREP(GENMASK(9, 2), chunk);
>  		tx->attributes = cpu_to_le32(attributes);
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index d45657aa986a..4e6f65cf0e76 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -450,6 +450,17 @@ config PINCTRL_ROCKCHIP
>  	help
>            This support pinctrl and GPIO driver for Rockchip SoCs.
>  
> +config PINCTRL_SCMI
> +	tristate "Pinctrl driver using SCMI protocol interface"
> +	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
> +	select PINMUX
> +	select GENERIC_PINCONF
> +	help
> +	  This driver provides support for pinctrl which is controlled
> +	  by firmware that implements the SCMI interface.
> +	  It uses SCMI Message Protocol to interact with the
> +	  firmware providing all the pinctrl controls.
> +

[snip]

> +static int pinctrl_scmi_pinconf_group_get(struct pinctrl_dev *pctldev,
> +					  unsigned int group,
> +					  unsigned long *config)
> +{
> +	int ret;
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +	enum pin_config_param config_type;
> +	enum scmi_pinctrl_conf_type type;
> +	u32 config_value;
> +
> +	if (!config)
> +		return -EINVAL;
> +
> +	config_type = pinconf_to_config_param(*config);
> +	ret = pinctrl_scmi_map_pinconf_type(config_type, &type);
> +	if (ret) {
> +		dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = pinctrl_ops->settings_get(pmx->ph, group, GROUP_TYPE, type,
> +					&config_value);
> +	if (ret)
> +		return ret;
> +
> +	*config = pinconf_to_config_packed(config_type, config_value);
> +
> +	return 0;
> +}
> +
> +static const struct pinconf_ops pinctrl_scmi_pinconf_ops = {
> +	.is_generic = true,
> +	.pin_config_get = pinctrl_scmi_pinconf_get,
> +	.pin_config_set = pinctrl_scmi_pinconf_set,
> +	.pin_config_group_set = pinctrl_scmi_pinconf_group_set,
> +	.pin_config_group_get = pinctrl_scmi_pinconf_group_get,
> +	.pin_config_config_dbg_show = pinconf_generic_dump_config,
> +};
> +
> +static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
> +				 struct pinctrl_desc *desc)
> +{
> +	struct pinctrl_pin_desc *pins;
> +	unsigned int npins;
> +	int ret, i;
> +
> +	npins = pinctrl_ops->count_get(pmx->ph, PIN_TYPE);
> +	pins = devm_kmalloc_array(pmx->dev, npins, sizeof(*pins), GFP_KERNEL);
> +	if (!pins)
> +		return -ENOMEM;
> +

This is fine only if npins != 0, because on zero npins
devm_kmalloc_array will return ZERO_SIZE_PTR which is NOT-NULL so I
would add a check for !npins and bail out..or use ZERO_OR_NULL_PTR()
to check the return value...if from the previous pinctrl patch you
had decided to bail out at the protocol layer when (nr_pins == 0) and so
you will never get here, please add a comment above that npins cannot be
zero...

> +	for (i = 0; i < npins; i++) {
> +		pins[i].number = i;
> +		ret = pinctrl_ops->name_get(pmx->ph, i, PIN_TYPE, &pins[i].name);
> +		if (ret)
> +			return dev_err_probe(pmx->dev, ret,
> +					     "Can't get name for pin %d", i);
> +	}
> +
> +	desc->npins = npins;
> +	desc->pins = pins;
> +	dev_dbg(pmx->dev, "got pins %d", npins);
> +
> +	return 0;
> +}
> +
> +static const struct scmi_device_id scmi_id_table[] = {
> +	{ SCMI_PROTOCOL_PINCTRL, "pinctrl" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> +
> +static int scmi_pinctrl_probe(struct scmi_device *sdev)
> +{
> +	int ret;
> +	struct device *dev = &sdev->dev;
> +	struct scmi_pinctrl *pmx;
> +	const struct scmi_handle *handle;
> +	struct scmi_protocol_handle *ph;
> +
> +	if (!sdev || !sdev->handle)

if (!sdev->handle) is enough...

> +		return -EINVAL;
> +
> +	handle = sdev->handle;
> +
> +	pinctrl_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PINCTRL,
> +						&ph);
> +	if (IS_ERR(pinctrl_ops))
> +		return PTR_ERR(pinctrl_ops);
> +
> +	pmx = devm_kzalloc(dev, sizeof(*pmx), GFP_KERNEL);
> +	if (!pmx)
> +		return -ENOMEM;
> +
> +	pmx->ph = ph;
> +
> +	pmx->dev = dev;
> +	pmx->pctl_desc.name = DRV_NAME;
> +	pmx->pctl_desc.owner = THIS_MODULE;
> +	pmx->pctl_desc.pctlops = &pinctrl_scmi_pinctrl_ops;
> +	pmx->pctl_desc.pmxops = &pinctrl_scmi_pinmux_ops;
> +	pmx->pctl_desc.confops = &pinctrl_scmi_pinconf_ops;
> +
> +	ret = pinctrl_scmi_get_pins(pmx, &pmx->pctl_desc);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_pinctrl_register_and_init(dev, &pmx->pctl_desc, pmx,
> +					     &pmx->pctldev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register pinctrl\n");
> +
> +	pmx->nr_functions = pinctrl_scmi_get_functions_count(pmx->pctldev);
> +	pmx->functions = devm_kcalloc(dev, pmx->nr_functions,
> +				      sizeof(*pmx->functions),
> +				      GFP_KERNEL);
> +	if (!pmx->functions)
> +		return -ENOMEM;
> +
> +	return pinctrl_enable(pmx->pctldev);
> +}
> +
> +static struct scmi_driver scmi_pinctrl_driver = {
> +	.name = DRV_NAME,
> +	.probe = scmi_pinctrl_probe,
> +	.id_table = scmi_id_table,
> +};
> +module_scmi_driver(scmi_pinctrl_driver);
> +
> +MODULE_AUTHOR("Oleksii Moisieiev <oleksii_moisieiev@epam.com>");
> +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> +MODULE_DESCRIPTION("ARM SCMI pin controller driver");
> +MODULE_LICENSE("GPL");
> 

Thanks,
Cristian

