Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BD67DDFC8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjKAKvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjKAKvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:51:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD26115
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 03:51:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BDAC433C7;
        Wed,  1 Nov 2023 10:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698835867;
        bh=PUb5cnlFGehCaLm9tBDLh1LIRhoSslutvGk/oy47Q/c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QhWnbdga9QU5q6D0VrSZRDntOmo1wrS6bith0nos9UiFN+Rcrg31M4RxpYnr4Xe4M
         2IVSQKirOZ0XMdAhq+W7Z+ce9ItU+TW+NYZeFwFfQPA4LdnuvIwdJaxDX5iWsljJdx
         4PCfO8Z7zdu5yuzYxrS04tnTYhB09uqBi2Un+0k0kSIik3jDWXZPMVEVR0lDhsyPeD
         bpFIiZLOIx1pumn2GVfxLoOM+ZBAXibkDRDOrF4j3rkW4sdfDebQpiex4s7NnPb4rq
         PKIkxiFwnnjFcfEE/Yd6CbiGX8PO0FETtVLLybVyJz+5VpwcV/HOsfJZjcAXOr1JFy
         XUfUpHx7bdOBg==
Message-ID: <a2a87ae8-932a-4bc0-8c9c-f08bf109f0f2@kernel.org>
Date:   Wed, 1 Nov 2023 11:51:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] phy: sprd: Add Spreadtrum usb20 hsphy driver
Content-Language: en-US
To:     Pu Li <pu.li@unisoc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Zhiyong Liu <zhiyong.liu@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231101054432.27509-1-pu.li@unisoc.com>
 <20231101054432.27509-3-pu.li@unisoc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20231101054432.27509-3-pu.li@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2023 06:44, Pu Li wrote:
> Add Spreadtrum platform USB20 HSPHY driver support. This driver
> takes care of all the PHY functionality, normally paired with
> DesignWare USB20 (DRD) Controller or Spreadtrum musb phy (DRD )controller.
> 
> Signed-off-by: Pu Li <pu.li@unisoc.com>
> ---


> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/timer.h>
> +#include <linux/usb/otg.h>
> +#include <uapi/linux/usb/charger.h>
> +
> +#include "phy-sprd-usb20-hs.h"
> +
> +static const struct sprd_hsphy_cfg *phy_cfg;

File-scope variables do not look good.

> +

...

> +
> +static int sprd_hsphy_cali_mode(void)
> +{
> +	struct device_node *cmdline_node;
> +	const char *cmdline, *mode;
> +	int ret;
> +
> +	cmdline_node = of_find_node_by_path("/chosen");
> +	ret = of_property_read_string(cmdline_node, "bootargs", &cmdline);
> +
> +	if (ret) {
> +		pr_err("Can't not parse bootargs\n");
> +		return 0;
> +	}
> +
> +	mode = strstr(cmdline, "androidboot.mode=cali");

NAK, drop this nonsense.

> +	if (mode)
> +		return 1;
> +
> +	mode = strstr(cmdline, "sprdboot.mode=cali");

NAK, drop this nonsense.


> +	if (mode)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int sprd_hsphy_probe(struct platform_device *pdev)
> +{
> +	struct sprd_hsphy *phy;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	int ret = 0, calimode = 0;
> +	struct usb_otg *otg;
> +
> +	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	otg = devm_kzalloc(dev, sizeof(*otg), GFP_KERNEL);
> +	if (!otg)
> +		return -ENOMEM;
> +
> +	/* phy cfg data */
> +	phy_cfg = of_device_get_match_data(dev);
> +	if (!phy_cfg) {
> +		dev_err(dev, "no matching driver data found\n");
> +		return -EINVAL;
> +	}
> +
> +	/* set vdd */
> +	ret = of_property_read_u32(dev->of_node, "sprd,vdd-voltage",
> +				   &phy->vdd_vol);
> +	if (ret < 0) {
> +		dev_err(dev, "unable to read hsphy vdd voltage\n");
> +		return ret;
> +	}
> +
> +	calimode = sprd_hsphy_cali_mode();
> +	if (calimode) {
> +		phy->vdd_vol = phy_cfg->parameters[FULLSPEED_USB33_TUNE];
> +		dev_info(dev, "calimode vdd_vol:%d\n", phy->vdd_vol);
> +	}
> +
> +	phy->vdd = devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(phy->vdd)) {
> +		dev_err(dev, "unable to get hsphy vdd supply\n");

You do not have regulators. You clearly did not test the code, DTS or
the bindings. Maybe nothing here was tested.

> +		return PTR_ERR(phy->vdd);

Syntax is anyway return dev_err_probe().

> +	}
> +
> +	ret = regulator_set_voltage(phy->vdd, phy->vdd_vol, phy->vdd_vol);
> +	if (ret < 0) {
> +		dev_err(dev, "fail to set hsphy vdd voltage at %dmV\n",
> +			phy->vdd_vol);
> +		return ret;
> +	}
> +
> +	/* phy tune */
> +	if (phy_cfg->phy_version == VERSION1) {
> +		ret = of_property_read_u32(dev->of_node, "sprd,tune-value",

Nope, it is not allowed in your bindings.

> +					&phy->phy_tune);
> +		if (ret < 0) {
> +			dev_err(dev, "unable to read hsphy usb phy tune\n");
> +			return ret;
> +		}
> +	}
> +
> +	/* phy base */
> +	if (phy_cfg->phy_version == VERSION1 ||
> +		phy_cfg->phy_version == VERSION2) {
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy_glb_regs");

This was not expressed in the bindings.

> +		if (!res) {
> +			dev_err(dev, "missing USB PHY registers resource\n");
> +			return -ENODEV;
> +		}
> +
> +		phy->base = devm_ioremap(dev, res->start, resource_size(res));
> +		if (IS_ERR(phy->base)) {
> +			dev_err(dev, "unable to get phy base!\n");
> +			return PTR_ERR(phy->base);
> +		}
> +	}
> +
> +	/* analog & aoapb & apahb regmap */
> +	phy->aon_apb = syscon_regmap_lookup_by_phandle(dev->of_node,
> +				 "sprd,syscon-enable");
> +	if (IS_ERR(phy->aon_apb)) {
> +		dev_err(dev, "USB aon apb syscon failed!\n");

return dev_err_probe, if it stays

> +		return PTR_ERR(phy->aon_apb);
> +	}
> +
> +	if (phy_cfg->phy_version == VERSION2) {


> +		phy->ap_ahb = syscon_regmap_lookup_by_phandle(dev->of_node,
> +				 "sprd,syscon-apahb");

NAK, there is no such property!

> +		if (IS_ERR(phy->ap_ahb)) {
> +			dev_err(dev, "USB apahb syscon failed!\n");

> +			return PTR_ERR(phy->ap_ahb);
> +		}
> +	}
> +
> +	if (phy_cfg->phy_version != VERSION1) {

This was not expressed in your bindings


> +		phy->analog = syscon_regmap_lookup_by_phandle(dev->of_node,
> +				 "sprd,syscon-ana");


> +		if (IS_ERR(phy->analog)) {
> +			dev_err(dev, "USB analog syscon failed!\n");
> +			return PTR_ERR(phy->analog);

return dev_err_probe, if it stays, but I insist to remove it.

> +		}
> +	}
> +
> +	/* prepare eye pattern */
> +	ret = sprd_eye_pattern_prepared(phy, dev);
> +	if (ret < 0)
> +		dev_warn(dev, "sprd_eye_pattern_prepared failed, ret = %d\n", ret);
> +
> +	/* enable usb module */
> +	if (phy_cfg->phy_version == VERSION2 ||
> +		phy_cfg->phy_version == VERSION3) {
> +		phy_cfg->cfg_ops->usb_enable_ctrl(phy, CTRL2);
> +	}
> +
> +	/* usb phy power down */
> +	if (phy_cfg->phy_version != VERSION4)
> +		phy_cfg->cfg_ops->usb_phy_power_ctrl(phy, CTRL2);
> +
> +	phy->dev = dev;
> +	phy->phy.dev = dev;
> +	phy->phy.label = "sprd-hsphy";
> +	phy->phy.otg = otg;
> +	phy->phy.init = sprd_hsphy_init;
> +	phy->phy.shutdown = sprd_hsphy_shutdown;
> +	phy->phy.set_vbus = sprd_hostphy_set;
> +	phy->phy.type = USB_PHY_TYPE_USB2;
> +	phy->phy.vbus_nb.notifier_call = sprd_hsphy_vbus_notify;
> +	otg->usb_phy = &phy->phy;
> +
> +	device_init_wakeup(phy->dev, true);
> +	phy->wake_lock = wakeup_source_register(phy->dev, "sprd-hsphy");
> +	if (!phy->wake_lock) {
> +		dev_err(dev, "fail to register wakeup lock.\n");
> +		return -ENOMEM;
> +	}
> +	INIT_WORK(&phy->work, sprd_hsphy_charger_detect_work);
> +	platform_set_drvdata(pdev, phy);
> +
> +	ret = usb_add_phy_dev(&phy->phy);
> +	if (ret) {
> +		dev_err(dev, "fail to add phy\n");
> +		return ret;
> +	}
> +
> +	ret = sysfs_create_groups(&dev->kobj, usb_hsphy_groups);
> +	if (ret)
> +		dev_warn(dev, "failed to create usb hsphy attributes\n");
> +
> +	if (extcon_get_state(phy->phy.edev, EXTCON_USB) > 0)
> +		usb_phy_set_charger_state(&phy->phy, USB_CHARGER_PRESENT);
> +
> +	dev_info(dev, "sprd usb phy probe ok !\n");

Drop. This code looks very, very poor :(. Lack of testing is even worse.

> +
> +	return ret;
> +}

...

> +static int __init sprd_hsphy_driver_init(void)
> +{
> +	return platform_driver_register(&sprd_hsphy_driver);
> +}
> +
> +static void __exit sprd_hsphy_driver_exit(void)
> +{
> +	platform_driver_unregister(&sprd_hsphy_driver);
> +}
> +
> +late_initcall(sprd_hsphy_driver_init);
> +module_exit(sprd_hsphy_driver_exit);
> +
> +MODULE_ALIAS("platform:spreadtrum-usb20-hsphy");

You should not need MODULE_ALIAS() in normal cases. If you need it,
usually it means your device ID table is wrong (e.g. misses either
entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute
for incomplete ID table.


> +MODULE_AUTHOR("Pu Li <lip308226@gmail.com>");
> +MODULE_DESCRIPTION("Spreadtrum USB20 HSPHY driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/phy/sprd/phy-sprd-usb20-hs.h b/drivers/phy/sprd/phy-sprd-usb20-hs.h
> new file mode 100644
> index 000000000000..897ee5e64482
> --- /dev/null
> +++ b/drivers/phy/sprd/phy-sprd-usb20-hs.h
> @@ -0,0 +1,525 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * phy-sprd-usb20-hs.h - Spreadtrum usb20 phy Glue layer h file
> + *
> + * Copyright 2020-2023 Unisoc Inc.
> + */
> +
> +#ifndef __SPRD_USB20_HS_H
> +#define __SPRD_USB20_HS_H
> +
> +#include <linux/regmap.h>
> +#include <linux/usb/phy.h>
> +
> +struct sprd_hsphy {
> +	struct device		*dev;
> +	struct usb_phy		phy;
> +	void __iomem		*base;
> +	struct regulator	*vdd;
> +	struct regmap           *aon_apb;
> +	struct regmap           *ap_ahb;
> +	struct regmap           *analog;
> +	struct wakeup_source	*wake_lock;
> +	struct work_struct	work;
> +	unsigned long event;
> +	u32			vdd_vol;
> +	u32			phy_tune;
> +	u32			host_eye_pattern;
> +	u32			device_eye_pattern;
> +	u32			host_otg_ctrl0;
> +	u32			device_otg_ctrl0;
> +	u32			host_otg_ctrl1;
> +	u32			device_otg_ctrl1;
> +	atomic_t		reset;
> +	atomic_t		inited;
> +	bool			is_host;
> +};
> +
> +enum hsphy_parameters {
> +	TUNEHSAMP_SHIFT,
> +	TUNEEQ_SHIFT,
> +	TFREGRES_SHIFT,
> +	FULLSPEED_USB33_TUNE,
> +};
> +
> +enum sprd_hsphy_reg_layout {
> +	REG_AON_APB_APB_RST1,
> +	REG_AON_APB_APB_RST2,
> +	REG_AON_APB_APB_EB1,
> +	REG_AON_APB_APB_EB2,
> +	REG_AON_APB_CGM_REG1,
> +	REG_AON_APB_OTG_PHY_TEST,
> +	REG_AON_APB_OTG_PHY_CTRL,
> +	REG_AON_APB_PWR_CTRL,
> +	REG_AON_APB_AON_SOC_USB_CTRL,
> +	REG_AON_APB_MIPI_CSI_POWER_CTRL,
> +	REG_AP_AHB_AHB_EB,
> +	REG_AP_AHB_AHB_RST,
> +	REG_AP_AHB_OTG_CTRL0,
> +	REG_AP_AHB_OTG_CTRL1,
> +	REG_AP_AHB_OTG_PHY_CTRL,
> +	REG_AP_AHB_OTG_PHY_TUNE,
> +	REG_AP_AHB_OTG_PHY_TEST,
> +	REG_ANALOG_USB20_USB20_ISO_SW,
> +	REG_ANALOG_USB20_USB20_BATTER_PLL,
> +	REG_ANALOG_USB20_USB20_UTMI_CTL1,
> +	REG_ANALOG_USB20_USB20_TRIMMING,
> +	REG_ANALOG_USB20_USB20_UTMI_CTL2,
> +	REG_ANALOG_USB20_REG_SEL_CFG_0,
> +	REG_ANALOG_USB20_IDDG,
> +	REG_ANALOG_USB20_USB20_PHY,
> +};
> +
> +enum sprd_hsphy_mask_layout {
> +	MASK_AON_APB_USB_PHY_PD_S,
> +	MASK_AON_APB_USB_PHY_PD_L,
> +	MASK_AON_APB_ANLG_APB_EB,
> +	MASK_AON_APB_ANLG_EB,
> +	MASK_AON_APB_OTG_REF_EB,
> +	MASK_AON_APB_ANA_EB,
> +	MASK_AON_APB_OTG_UTMI_EB,
> +	MASK_AON_APB_AON_USB2_TOP_EB,
> +	MASK_AON_APB_OTG_PHY_EB,
> +	MASK_AON_APB_CGM_OTG_REF_EN,
> +	MASK_AON_APB_CGM_DPHY_REF_EN,
> +	MASK_AON_APB_USB_ISO_SW_EN,
> +	MASK_AON_APB_OTG_PHY_SOFT_RST,
> +	MASK_AON_APB_OTG_UTMI_SOFT_RST,
> +	MASK_AON_APB_OTG_VBUS_VALID_PHYREG,
> +	MASK_AON_APB_USB2_PHY_IDDIG,
> +	MASK_AON_APB_UTMI_WIDTH_SEL,
> +	MASK_AON_APB_USB20_CTRL_MUX_REG,
> +	MASK_AON_APB_USB20_ISO_SW_EN,
> +	MASK_AON_APB_C2G_ANALOG_USB20_USB20_PS_PD_S,
> +	MASK_AON_APB_C2G_ANALOG_USB20_USB20_PS_PD_L,
> +	MASK_AP_AHB_OTG_EB,
> +	MASK_AP_AHB_OTG_PHY_SOFT_RST,
> +	MASK_AP_AHB_OTG_UTMI_SOFT_RST,
> +	MASK_AP_AHB_OTG_SOFT_RST,
> +	MASK_AP_AHB_USB2_PHY_IDDIG,
> +	MASK_AP_AHB_OTG_DPPULLDOWN,
> +	MASK_AP_AHB_OTG_DMPULLDOWN,
> +	MASK_AP_AHB_OTG_VBUS_VALID_EXT,
> +	MASK_AP_AHB_OTG_VBUS_VALID_PHYREG,
> +	MASK_AP_AHB_UTMI_WIDTH_SEL,
> +	MASK_AP_AHB_USB2_DATABUS16_8,
> +	MASK_AP_AHB_USB20_SAMPLER_SEL,
> +	MASK_AP_AHB_USB20_TUNEHSAMP,
> +	MASK_AP_AHB_USB20_TUNEEQ,
> +	MASK_AP_AHB_USB20_TFREGRES,
> +	MASK_ANALOG_USB20_USB20_VBUSVLDEXT,
> +	MASK_ANALOG_USB20_USB20_DATABUS16_8,
> +	MASK_DBG_SEL_ANALOG_USB20_USB20_DMPULLDOWN,
> +	MASK_DBG_SEL_ANALOG_USB20_USB20_DPPULLDOWN,
> +	MASK_ANALOG_USB20_USB20_DMPULLDOWN,
> +	MASK_ANALOG_USB20_USB20_DPPULLDOWN,
> +	MASK_ANALOG_USB20_UTMIOTG_IDDG,
> +	MASK_ANALOG_USB20_USB20_PS_PD_S,
> +	MASK_ANALOG_USB20_USB20_PS_PD_L,
> +	MASK_ANALOG_USB20_USB20_RESERVED,
> +	MASK_ANALOG_USB20_USB20_ISO_SW_EN,
> +	MASK_ANALOG_USB20_USB20_TUNEHSAMP,
> +	MASK_ANALOG_USB20_USB20_TUNEEQ,
> +	MASK_ANALOG_USB20_USB20_TFREGRES,
> +};
> +
> +enum {
> +	CTRL0 = 0,
> +	CTRL1,
> +	CTRL2,
> +};
> +
> +struct sprd_hsphy_cfg_ops {
> +	void (*usb_enable_ctrl)(struct sprd_hsphy *phy, int on);
> +	void (*usb_phy_power_ctrl)(struct sprd_hsphy *phy, int on);
> +	void (*usb_vbus_ctrl)(struct sprd_hsphy *phy, int on);
> +	void (*utmi_width_sel)(struct sprd_hsphy *phy);
> +	void (*reset_core)(struct sprd_hsphy *phy);
> +	int (*set_mode)(struct sprd_hsphy *phy, int on);
> +};
> +
> +enum hsphy_ip_version {
> +	VERSION1,
> +	VERSION2,
> +	VERSION3,
> +	VERSION4,
> +};
> +
> +enum hsphy_owner {
> +	PIKE2,
> +	SHARKLE,
> +	SHARKL3,
> +	SHARKL5,
> +	SHARKL5PRO,
> +	QOGIRL6,
> +	QOGIRN6LITE,
> +	UIS8520,
> +};
> +
> +struct sprd_hsphy_cfg {
> +	/* array of registers with different offsets */
> +	const unsigned int *regs;
> +
> +	const unsigned int *masks;
> +
> +	/* private ops for each SOC */
> +	const struct sprd_hsphy_cfg_ops *cfg_ops;
> +
> +	const unsigned int *parameters;
> +
> +	enum hsphy_ip_version phy_version;
> +
> +	enum hsphy_owner	owner;
> +};
> +
> +static const unsigned int pike2_regs_layout[] = {

Static data allocated in every unit including this header? No, this does
not look like correct code (yeah, it compiles but it is just wrong).

Best regards,
Krzysztof

