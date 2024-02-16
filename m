Return-Path: <linux-kernel+bounces-69379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA520858842
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF63F1C23100
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365A51474A7;
	Fri, 16 Feb 2024 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="i72NtDXk"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4DD1D69A;
	Fri, 16 Feb 2024 21:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708120435; cv=none; b=otRe2t/+1XS4qBxP3CeKmTRP5aUhZK2JKQzZPCh6H8LOgKeuqu8f/TyAfZ0cjdTE2qxY5Zm4ZnoMzCS2pzSmnJDYdedDJyTXiEdjSSNK+zl9gkx8qwgTyLEXppcP+XYeLmir4/x4a45+t2T1YX3g7oARTtyn1WTRw0ojXDb4ir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708120435; c=relaxed/simple;
	bh=faDLuUfC4PoWjPlJpxcxDrdtzNYVfOeJTJQqsa5JK8s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmskWVC7e5BOkAkHUwXo4L7GLQ8euO8vj9DvbmZvRmu+OWNJ5pftg+7r5ySZhzNiSn0DywKE1VZCI9NT5HbxO3ZHhduvw/BcYTuQ/9QpRGG78MUdEAo6DgfqbivTpa+ZYfwU1EKjuavM5bAdNAMtXebiJxsdzHMK8cU0iAdZk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=i72NtDXk; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 61241100005;
	Sat, 17 Feb 2024 00:53:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 61241100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1708120422;
	bh=ycgHfvDP6Hmv7AFNbq/y/sSR6DpzCZqZPxpxoqGzESc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=i72NtDXk5VCxkH9s0GL1gSoFkkEXriXLV9VGszo63DOXe2aOg2HNj0+dAqUkd9lhy
	 vcPwKj9r7R9ZWwHN8QNIZ296b57NGB4Wem99dxyxB2b26356KzJRli0DForEv3sLiO
	 Res5HY/ykm9WqOYQ3VEHT1t02EdWBVYKuxTHgF1ZgWjT4nWZQcr5MXAOCbErRrYZXL
	 YSAKHz1kHFBtSC8au6u2agGhveAayceDoIE1rAz5PG83NfQDhmvWqIiiM+AoZT6Fj4
	 aZPgeI/7IQtn9t6xoRbflLYdV5C+toNJlwBwh3X8RZqSB2KvgHyoT8WmXjMxwWaWap
	 BCCfCAyWufYdg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 17 Feb 2024 00:53:41 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 17 Feb
 2024 00:53:41 +0300
Date: Sat, 17 Feb 2024 00:53:41 +0300
From: Evgeny Bachinin <eabachinin@salutedevices.com>
To: Viacheslav Bocharov <adeep@lexina.in>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 4/5] soc: amlogic: Add Amlogic secure-monitor SoC
 Information driver
Message-ID: <vln6wuzy3hdql6wwwghmwoetywm24jzzhzy6wutr6qphjl42hr@vfdsc737cust>
References: <20231122125643.1717160-1-adeep@lexina.in>
 <20231122125643.1717160-5-adeep@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231122125643.1717160-5-adeep@lexina.in>
User-Agent: NeoMutt/20231006
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183517 [Feb 16 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: eabachinin@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/16 20:10:00 #23642199
X-KSMG-AntiVirus-Status: Clean, skipped

please, see notes below

On Wed, Nov 22, 2023 at 03:56:42PM +0300, Viacheslav Bocharov wrote:
> Amlogic SoCs have a SoC information secure-monitor call for SoC type,
> package type, revision information and chipid.
> This patchs adds support for secure-monitor call decoding and exposing


s/patchs/patch/


> with the SoC bus infrastructure in addition to the previous SoC
> Information driver.
> 
> Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
> ---
>  drivers/soc/amlogic/Kconfig               |  10 ++
>  drivers/soc/amlogic/Makefile              |   1 +
>  drivers/soc/amlogic/meson-gx-socinfo-sm.c | 178 ++++++++++++++++++++++
>  3 files changed, 189 insertions(+)
>  create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-sm.c
> 
> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
> index d08e398bdad4..5634ecb60478 100644
> --- a/drivers/soc/amlogic/Kconfig
> +++ b/drivers/soc/amlogic/Kconfig
> @@ -26,6 +26,16 @@ config MESON_GX_SOCINFO
>  	  Say yes to support decoding of Amlogic Meson GX SoC family
>  	  information about the type, package and version.
>  
> +config MESON_GX_SOCINFO_SM
> +	bool "Amlogic Meson GX SoC Information driver via Secure Monitor"
> +	depends on (ARM64 && ARCH_MESON && MESON_GX_SOCINFO && MESON_SM) || COMPILE_TEST
> +	default MESON_GX_SOCINFO && MESON_SM
> +	select SOC_BUS
> +	help
> +	  Say yes to support decoding of Amlogic Meson GX SoC family
> +	  information about the type, package and version from secure
> +	  monitor call.
> +
>  config MESON_MX_SOCINFO
>  	bool "Amlogic Meson MX SoC Information driver"
>  	depends on (ARM && ARCH_MESON) || COMPILE_TEST
> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
> index c25f835e6a26..45d9d6f5904c 100644
> --- a/drivers/soc/amlogic/Makefile
> +++ b/drivers/soc/amlogic/Makefile
> @@ -2,4 +2,5 @@
>  obj-$(CONFIG_MESON_CANVAS) += meson-canvas.o
>  obj-$(CONFIG_MESON_CLK_MEASURE) += meson-clk-measure.o
>  obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
> +obj-$(CONFIG_MESON_GX_SOCINFO_SM) += meson-gx-socinfo-sm.o
>  obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
> diff --git a/drivers/soc/amlogic/meson-gx-socinfo-sm.c b/drivers/soc/amlogic/meson-gx-socinfo-sm.c
> new file mode 100644
> index 000000000000..52bf3bce09e2
> --- /dev/null
> +++ b/drivers/soc/amlogic/meson-gx-socinfo-sm.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2023 JetHome
> + * Author: Viacheslav Bocharov <adeep@lexina.in>
> + *
> + */
> +
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/sys_soc.h>
> +#include <linux/bitfield.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +
> +#include <linux/firmware/meson/meson_sm.h>
> +
> +#include "meson-gx-socinfo-internal.h"
> +
> +static char *socinfo_get_cpuid(struct device *dev, struct meson_sm_firmware *fw,
> +			       unsigned int *socinfo)
> +{
> +	char *buf;
> +	uint8_t *id_buf;
> +	int chip_id_version;
> +	int ret;
> +
> +	id_buf = devm_kzalloc(dev, SM_CHIP_ID_LENGTH, GFP_KERNEL);
> +	if (!id_buf)
> +		return NULL;
> +
> +	ret = meson_sm_call_read(fw, id_buf, SM_CHIP_ID_LENGTH, SM_GET_CHIP_ID,
> +				 2, 0, 0, 0, 0);
> +	if (ret < 0) {
> +		kfree(id_buf);
> +		return NULL;
> +	}
> +
> +	chip_id_version = *((unsigned int *)id_buf);
> +
> +	if (chip_id_version != 2) {
> +		uint8_t tmp;

minor:
The scope of the variable 'tmp' can be reduced.

Up to you, guys. I just highlighted here.

> +		/**
> +		 * Legacy 12-byte chip ID read out, transform data

The Amlogic chipID v1 and v2 are both 16 bytes long. Probably,
the "serial" was intended here under "12 byte". However, since we are
dealing with chipID in this function, wouldn't it be better to just
remove "12-byte"?"


> +		 * to expected order format
> +		 */
> +
> +		memmove(&id_buf[SM_CHIP_ID_OFFSET + 4], &id_buf[SM_CHIP_ID_OFFSET], 12);
> +		for (int i = 0; i < 6; i++) {
> +			tmp = id_buf[i + SM_CHIP_ID_OFFSET + 4];
> +			id_buf[i + SM_CHIP_ID_OFFSET + 4] = id_buf[15 - i + SM_CHIP_ID_OFFSET];
> +			id_buf[15 - i + SM_CHIP_ID_OFFSET] = tmp;
> +		}
> +		*(uint32_t *)(id_buf + SM_CHIP_ID_OFFSET) =
> +					((*socinfo & 0xff000000)	|	// Family ID
> +					((*socinfo << 8) & 0xff0000)	|	// Chip Revision
> +					((*socinfo >> 8) & 0xff00))	|	// Package ID
> +					((*socinfo) & 0xff);			// Misc
> +	} else {
> +		*socinfo = id_buf[SM_CHIP_ID_OFFSET] << 24 |	// Family ID
> +		   id_buf[SM_CHIP_ID_OFFSET + 2] << 16 |	// Chip revision
> +		   id_buf[SM_CHIP_ID_OFFSET + 1] << 8 |		// Package ID
> +		   id_buf[SM_CHIP_ID_OFFSET + 3];		// Misc
> +	}
> +
> +	buf = kasprintf(GFP_KERNEL, "%16phN\n", &id_buf[SM_CHIP_ID_OFFSET]);
> +	kfree(id_buf);
> +
> +	return buf;
> +}
> +
> +static int meson_gx_socinfo_sm_probe(struct platform_device *pdev)
> +{
> +	struct soc_device_attribute *soc_dev_attr;
> +	struct soc_device *soc_dev;
> +	struct device_node *sm_np;
> +	struct meson_sm_firmware *fw;
> +	struct regmap *regmap;
> +	unsigned int socinfo;
> +	struct device *dev;
> +	int ret;
> +
> +	/* check if chip-id is available */

My apologies for nitpicking, but looks like the term "has-chip-id" is
misleading, too.
AFAIU it does not reflect the presence of the chipID in a particular
Amlogic SoC. Instead, it specifies the driver's ability to read the
cpu_id value from the register (via regmap). Therefore, I think,
it would be more accurate to call it as "has-cpu-id", although it seems
"has-chip-id" term is a legacy now.

> +	if (!of_property_read_bool(pdev->dev.of_node, "amlogic,has-chip-id"))
> +		return -ENODEV;
> +
> +	/* node should be a syscon */
> +	regmap = syscon_node_to_regmap(pdev->dev.of_node);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&pdev->dev, "failed to get regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	sm_np = of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);
> +	if (!sm_np) {
> +		dev_err(&pdev->dev, "no secure-monitor node found\n");
> +		return -ENODEV;
> +	}
> +
> +	fw = meson_sm_get(sm_np);
> +	of_node_put(sm_np);
> +	if (!fw)
> +		return -EPROBE_DEFER;
> +
> +	dev_err(&pdev->dev, "secure-monitor node found\n");

Debug leftover?
Strange to see an error in the non-error path. I mean is it proper
log level?

> +
> +	ret = regmap_read(regmap, AO_SEC_SOCINFO_OFFSET, &socinfo);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!socinfo) {
> +		dev_err(&pdev->dev, "invalid regmap chipid value\n");

s/chipid/cpuid/ ?
because value read from register is actually 4 byte cpuid

> +		return -EINVAL;
> +	}
> +
> +	soc_dev_attr = devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr),
> +				    GFP_KERNEL);
> +	if (!soc_dev_attr)
> +		return -ENOMEM;
> +
> +	soc_dev_attr->serial_number = socinfo_get_cpuid(&pdev->dev, fw, &socinfo);

Several notes.

1) Could you please clarify, why don't you pass socinfo by value?

What's the necessity to overwrite inside socinfo_get_cpuid() the
socinfo value read above via regmap?

2) Seems, again names' collision.
Actually, the function returns the chipid as a retval (16 bytes,
consisting of cpu_id + SoC serial), but the function is named as
socinfo_get_cpuid(). The reason for this could be that the distinct
function carries out two actions (returning socinfo and chipid) instead
of just one specific action.

All in all, what do you think, could the function be renamed as
s/socinfo_get_cpuid/socinfo_get_chipid/ ?

> +
> +	meson_gx_socinfo_prepare_soc_driver_attr(soc_dev_attr, socinfo);
> +
> +	soc_dev = soc_device_register(soc_dev_attr);
> +	if (IS_ERR(soc_dev)) {
> +		kfree(soc_dev_attr->revision);
> +		kfree_const(soc_dev_attr->soc_id);
> +		kfree(soc_dev_attr);
> +		return PTR_ERR(soc_dev);
> +	}
> +
> +	dev = soc_device_to_device(soc_dev);
> +	platform_set_drvdata(pdev, soc_dev);
> +
> +	dev_info(dev, "Amlogic Meson %s Revision %x:%x (%x:%x) Detected at SM driver %x\n",
> +			soc_dev_attr->soc_id,
> +			socinfo_to_major(socinfo),
> +			socinfo_to_minor(socinfo),
> +			socinfo_to_pack(socinfo),
> +			socinfo_to_misc(socinfo), socinfo);
> +
> +	return PTR_ERR_OR_ZERO(dev);
> +}
> +
> +

is extra line supposed?

> +static int meson_gx_socinfo_sm_remove(struct platform_device *pdev)
> +{
> +	struct soc_device *soc_dev = platform_get_drvdata(pdev);
> +
> +	soc_device_unregister(soc_dev);
> +	return 0;
> +}
> +
> +static const struct of_device_id meson_gx_socinfo_match[] = {
> +	{ .compatible = "amlogic,meson-gx-ao-secure", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, meson_gx_socinfo_match);
> +
> +static struct platform_driver meson_gx_socinfo_driver = {
> +	.probe = meson_gx_socinfo_sm_probe,
> +	.remove	= meson_gx_socinfo_sm_remove,
> +	.driver = {
> +		.name = "meson-gx-socinfo-sm",
> +		.of_match_table = meson_gx_socinfo_match,
> +	},
> +};
> +
> +

extra line?

> +module_platform_driver(meson_gx_socinfo_driver);
> +
> +MODULE_AUTHOR("Viacheslav Bocharov <adeep@lexina.in>");
> +MODULE_DESCRIPTION("Amlogic Meson GX SOC SM driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 
> 

-- 
Best Regards,
Evgeny Bachinin

