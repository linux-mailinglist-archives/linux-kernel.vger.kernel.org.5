Return-Path: <linux-kernel+bounces-111307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD249886A78
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698EF28297D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2149421A0A;
	Fri, 22 Mar 2024 10:35:32 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDEE20B27
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103731; cv=none; b=TsKxe7M6vpmjpeirE2eLvJrWLlGE1f02ymh/ypj1OpoSVcEiWw1nYBjP1wiuFR8qDeUcPTcnOANR4IUi93/uwY70Yzg8t/MRO8j/0wTO/K8zKTfHLPF+CNy62wdcdZdZMmkzwYHp8qW4KR88lYG7tfothhkvwjaHpxH/azPEVnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103731; c=relaxed/simple;
	bh=22UYp43u0WniFDVzh6t9LE97qhvkiKEi33z4I/mf6nM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5pM10zezOfovUNUjKVEOJng82JlCkcPa/k0yBcgKIlOUvEB9wnB0HqTRfXa1K+/jZrL23MY34JkqhDe2GhGgMMz3bbkhsT+9YTjChRmlHleSaa8ilrioJRM2zmK0+jFFUGHYO7QSyxpLZQC+yxDjVBYVHGYW2MHICYie6zxmrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V1JWp5T6Yz67l0C;
	Fri, 22 Mar 2024 18:31:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 44BAE1409F9;
	Fri, 22 Mar 2024 18:35:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 22 Mar
 2024 10:35:22 +0000
Date: Fri, 22 Mar 2024 10:35:21 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shimrra Shai <shimmyshai00@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <heiko@sntech.de>,
	<max.schwarz@online.de>, <niyas.sait@huawei.com>
Subject: Re: [PATCH 0/0] (proposed?) Add ACPI binding to Rockchip RK3xxx I2C
 bus
Message-ID: <20240322103521.00001a12@Huawei.com>
In-Reply-To: <20240321173447.15660-1-shimmyshai00@gmail.com>
References: <20240321173447.15660-1-shimmyshai00@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 21 Mar 2024 12:34:47 -0500
Shimrra Shai <shimmyshai00@gmail.com> wrote:

> Hi! I have been contributing to a firmware project for Rockchip RK3588-
> based board using the TianoCore EDK2 firmware development kit, at
> https://github.com/edk2-porting/edk2-rk3588. I am seeking to get it
> possible to seamlessly boot mainline kernels using it on these platforms,
> especially given how that mainline support for this platform has progressed
> far since its debut. Since this is not a firmware from a board vendor, I'm
> actually not really sure how to best interface or integrate its development
> with the Linux kernel community. Particularly the question of Device Tree
> Blob (DTB) vs. ACPI binding for configuration bindings, for which previous
> discussions have always seemed to center around situations where the
> firmware was not controllable by the kernel developer, but that is not the
> case with this situation here and now. However, I've found, particularly
> given the firmware has an HDMI driver that the currnet kernel does not,
> that I am able to get a quicker path to mainline boot on this platform
> going through the ACPI route, which inspires the following patch.
> 
> In particular, I found one small issue that obstructs immediate direct
> booting of the off-the-shelf downloaded 6.8.x kernel series on my platform
> (Firefly ITX-3588J, with no mainline device tree blob support) which is
> that the I2C bus lacks code to configure it in the ACPI boot mode. The
> firmware came with ACPI bindings for it, nonetheless, and so this patch
> acts to enable and document those bindings for future use.

It would be good to highlight in this description what is missing for
doing a standard ACPI binding and not using any specific hacks in the
driver (get clocks as normal etc).

There are ACPI clock bindings, but Linux doesn't support the yet (I think?)
See ACPICA commit
https://github.com/acpica/acpica/commit/661feab5ee01a34af95a389a18c82e79f1aba05a

I've seen prototype code but was a while back.  I'd like to see that
work compled rather than having every driver need to paper over the hole.

The alias is a different question that needs to be addressed.
If this is a common pattern, push it up in to the i2c core, not
a specific driver.  I see there is already code related to that
in i2c_add_adapter - that just wants an ACPI option.

Jonathan


> 
> Signed-off-by: Shimrra Shai <shimmyshai00@gmail.com>
> ---
> 
>  Documentation/firmware-guide/acpi/dsd/soc/general.rst |  32 ++++++++
>  Documentation/firmware-guide/acpi/dsd/soc/soc-i2c.rst |  50 ++++++++++++
>  drivers/i2c/busses/i2c-rk3x.c                         | 105 +++++++++++++++++++++++---
>  3 files changed, 177 insertions(+), 10 deletions(-)
>  
> diff --git a/Documentation/firmware-guide/acpi/dsd/soc/general.rst b/Documentation/firmware-guide/acpi/dsd/soc/general.rst
> new file mode 100644
> index 000000000..d21ccad2d
> --- /dev/null
> +++ b/Documentation/firmware-guide/acpi/dsd/soc/general.rst
> @@ -0,0 +1,32 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==========================================
> +System-on-Chip (SoC) facility descriptions
> +==========================================
> +
> +These documents describe how to create ACPI profiles for devices compsed into

composed

Spell check the whole thing.


> +system-on-chip (SoC) architectures. Currently, we only describe the options
> +availed in the _DSD block for select platforms; other considerations are not
> +yet applied. The inspiration for these documents are based around the advent
> +(as of March 2024) of hefty, non-Apple ARM SoC systems such as the Rockchip
> +RK3588 and newer chips that have desktop-like performance and thus are prime
> +candidates for a UEFI-based desktop-like boot system with the goal being to
> +deliver the same user-friendly ease of loading operating systems as on the
> +Intel x86 sphere. Open-source UEFI-based firmware engines, such as TianoCore
> +[1], mean it is possible on such platforms for the open-source developer to
> +control both firmware and kernel simultaneously, which is not the case for
> +the situation with Intel-based PC boards where boards are provided with pre-
> +baked, vendor-selected and opaque firmwares.
> +
> +The description of ACPI usage here is not meant to suggest that ACPI replace
> +Deviec Tree altogether for such SoCs; rather, we recognize that given they
> +often will have a variety of applications that may include embedded usage where
> +that more hard-wired boot loader setups such as U-Boot still shine, the
> +maintenance of ACPI and DTB-based configuration options should be in parallel,
> +and it may be possible for the same firmware to deploy both options.
> +
> +References
> +==========
> +
> +[1] EDK2-RK3588 port of TianoCore EDK2 firmware.
> +    https://github.com/edk2-porting/edk2-rk3588
> diff --git a/Documentation/firmware-guide/acpi/dsd/soc/soc-i2c.rst b/Documentation/firmware-guide/acpi/dsd/soc/soc-i2c.rst
> new file mode 100644
> index 000000000..47ff69db4
> --- /dev/null
> +++ b/Documentation/firmware-guide/acpi/dsd/soc/soc-i2c.rst
> @@ -0,0 +1,50 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +I2C buses on SoCs
> +=================
> +
> +This document describes the ACPI _DSD parameters currently being employed for
> +Inter-Integrated Circuit (I2C) buses in the Linux kernel. It is based off the
> +conventions used in the Rockchip RK3588 firmware project [1], which is also the
> +first SoC documented here.
> +
> +General considerations
> +======================
> +
> +For general use, we recommend indicating I2C busses in the ACPI firmware table
> +in the following manner. First, they should be named I2Cx, where "x" is the bus
> +index, and that index should also be used for the _UID component, e.g. on
> +Rockchip RK3588 (see below), we use:
> +
> +  Device (I2Cx) {
> +    Name (_HID, "RKCP3001")
> +    Name (_CID, "PRP0001")

That implies that the kernel can cope with the device tree wrapped up in
ACPI path.  If that's the case, why do you need RKCP3001 as you can
match on the compatible?

> +    Name (_UID, x)
> +    Name (_CCA, 0)
> +
> +    ...
> +  }
> +
> +Interrupts should be specified in the usual ACPI manner. Parameters specific to
> +the Rockchip and I2C devices are indicated in the _DSD block as given below.
> +The parameters are a curated selection from the Device Tree Blob (DTB)
> +representation.
> +
> +_DSD parameters for different SoCs
> +==================================
> +
> +Rockchip RK3588
> +---------------
> +
> +The following parameters are accepted for the I2C on Rockchip RK3588.
> +
> +- i2c,clk-rate 	Describe the pclk rate for the I2C bus, in Hz.
> +- rockchip,bclk	Describe the bclk rate for the I2C bus, in Hz.
> +
> +References
> +==========
> +
> +[1] EDK2-RK3588 port of TianoCore EDK2 firmware.
> +    https://github.com/edk2-porting/edk2-rk3588
> +
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index 086fdf262..5a5e1d551 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -19,6 +19,9 @@
>  #include <linux/of_irq.h>
>  #include <linux/spinlock.h>
>  #include <linux/clk.h>
> +#ifdef CONFIG_ACPI
> +#include <linux/clk-provider.h>
> +#endif
>  #include <linux/wait.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
> @@ -1235,6 +1238,15 @@ static const struct of_device_id rk3x_i2c_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, rk3x_i2c_match);
>  
> +#ifdef CONFIG_ACPI
> +/* for RK3588 and at least when loaded with EDK2-RK3588 Tianocore firmware */
> +static const struct acpi_device_id rk3x_i2c_acpi_match[] = {
> +	{ .id = "RKCP3001", .driver_data = (kernel_ulong_t)&rk3399_soc_data },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, rk3x_i2c_acpi_match);
> +#endif
> +
>  static int rk3x_i2c_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> @@ -1243,6 +1255,10 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
>  	int ret = 0;
>  	int bus_nr;
>  	u32 value;
> +#ifdef CONFIG_ACPI
> +	u64 value64;
> +	char clk_name[20];
> +#endif
>  	int irq;
>  	unsigned long clk_rate;
>  
> @@ -1250,8 +1266,12 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
>  	if (!i2c)
>  		return -ENOMEM;
>  
> -	match = of_match_node(rk3x_i2c_match, np);
> -	i2c->soc_data = match->data;
> +	if (acpi_disabled) {
> +		match = of_match_node(rk3x_i2c_match, np);
> +		i2c->soc_data = match->data;
> +	} else {
> +		i2c->soc_data = device_get_match_data(&pdev->dev);
> +	}
>  
>  	/* use common interface to get I2C timing properties */
>  	i2c_parse_fw_timings(&pdev->dev, &i2c->t, true);
> @@ -1266,6 +1286,9 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
>  
>  	i2c->dev = &pdev->dev;
>  
> +	if (!acpi_disabled)
> +		ACPI_COMPANION_SET(&i2c->adap.dev, ACPI_COMPANION(&pdev->dev));
> +
>  	spin_lock_init(&i2c->lock);
>  	init_waitqueue_head(&i2c->wait);
>  
> @@ -1273,8 +1296,25 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
>  	if (IS_ERR(i2c->regs))
>  		return PTR_ERR(i2c->regs);
>  
> -	/* Try to set the I2C adapter number from dt */
> -	bus_nr = of_alias_get_id(np, "i2c");
> +	if (acpi_disabled) {
> +		/* Try to set the I2C adapter number from dt */
> +		bus_nr = of_alias_get_id(np, "i2c");
> +	} else {
> +		ret = acpi_dev_uid_to_integer(ACPI_COMPANION(&pdev->dev),
> +					      &value64);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Cannot retrieve UID\n");
> +			return ret;
> +		}
> +
> +		if (value64 < INT_MAX) {
> +			bus_nr = (int) value64;
> +		} else {
> +			/* shouldn't happen!!! */
> +			dev_err(&pdev->dev, "Too big UID\n");
> +			return -EINVAL;
> +		}
> +	}
>  
>  	/*
>  	 * Switch to new interface if the SoC also offers the old one.
> @@ -1325,13 +1365,58 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, i2c);
>  
> -	if (i2c->soc_data->calc_timings == rk3x_i2c_v0_calc_timings) {
> -		/* Only one clock to use for bus clock and peripheral clock */
> -		i2c->clk = devm_clk_get(&pdev->dev, NULL);
> -		i2c->pclk = i2c->clk;
> +	if (acpi_disabled) {
> +		if (i2c->soc_data->calc_timings == rk3x_i2c_v0_calc_timings) {
> +			/* Only one clock to use for bus clock and peripheral
> +			 * clock
> +			 */
> +			i2c->clk = devm_clk_get(&pdev->dev, NULL);
> +			i2c->pclk = i2c->clk;
> +		} else {
> +			i2c->clk = devm_clk_get(&pdev->dev, "i2c");
> +			i2c->pclk = devm_clk_get(&pdev->dev, "pclk");
> +		}
>  	} else {
> -		i2c->clk = devm_clk_get(&pdev->dev, "i2c");
> -		i2c->pclk = devm_clk_get(&pdev->dev, "pclk");
> +		if (i2c->soc_data->calc_timings != rk3x_i2c_v0_calc_timings) {
> +			u32 bclkrate = 0;
> +			u32 pclkrate = 0;
> +
> +			device_property_read_u32(&pdev->dev, "rockchip,bclk",
> +						 &bclkrate);
> +			device_property_read_u32(&pdev->dev, "i2c,clk-rate",
> +						 &pclkrate);
> +
> +			if (bclkrate != 0) {
> +				sprintf(clk_name, "rockchip,i2c-clk.%d", bus_nr);
> +				i2c->clk = clk_register_fixed_rate(&pdev->dev,
> +								   clk_name,
> +								   NULL,
> +								   0, bclkrate);
> +				dev_dbg(&pdev->dev,
> +					"registered i2c clk at %u Hz\n",
> +					bclkrate);
> +			}
> +
> +			if (pclkrate != 0) {
> +				sprintf(clk_name, "rockchip,i2c-pclk.%d",
> +					bus_nr);
> +				i2c->pclk = clk_register_fixed_rate(&pdev->dev,
> +								    clk_name,
> +								    NULL, 0,
> +								    pclkrate);
> +				dev_dbg(&pdev->dev,
> +					"registered i2c pclk at %u Hz\n",
> +					pclkrate);
> +			}
> +		} else {
> +			/* NB: currently not expected w/UEFI firmware given
> +			 * these are not super performant RK3xxx
> +			 */
> +			dev_err(&pdev->dev,
> +				"ACPI not supported for this RK3xxx\n");
> +
> +			return -EINVAL;
> +		}
>  	}
>  
>  	if (IS_ERR(i2c->clk))
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


