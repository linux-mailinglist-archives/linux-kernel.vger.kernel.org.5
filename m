Return-Path: <linux-kernel+bounces-107554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA8987FE0C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353DE1F229CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6E980025;
	Tue, 19 Mar 2024 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="AHyUN+tF"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4397E767;
	Tue, 19 Mar 2024 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853543; cv=none; b=TJz+LVrTnWio17FWbRLIzNNOp0TfCpQndXrBclsdPkpLJ7MG3dJCyxzeBTBe2eeE+kYeAz0KzgHoOn4cuIG/1zA0v+B9MqlMF2bYuYhdY/JyGiMTRHhE5SXtjFV9Yrpj9zDJOH6gfZr8OaDGyyqtO/3M5fS6eDcYApM38Ujq0S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853543; c=relaxed/simple;
	bh=/97r7iXSsDNTYmULHXVK1ctFTQ73QJVdp8X5PO/FNT8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=cCV+ktnNSqrqe5agH/BQY8QcS5sTKZS3Qt3LNTE+8XVjk4Ctr46G9S8RnEsReZtZheR9B1qLQLF71DLv8KJDddcJ1HsNEt9rigq23gCkTW9hpHYkzq0wbVWytGZLggwI9MTvTakpBK8QFtrC2/P7UEde41atiEZn1AN9HHfgJi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=AHyUN+tF; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1C1689C4ACB;
	Tue, 19 Mar 2024 09:05:32 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id GurWxxw7TEHa; Tue, 19 Mar 2024 09:05:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2CBAF9C5396;
	Tue, 19 Mar 2024 09:05:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 2CBAF9C5396
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1710853530; bh=CK99kLcw9PEfo9MbsDde8HxpTFYuUaCC9hKhjNwcG5Q=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=AHyUN+tFORXxM96kQQtuHIT4SdsL5VJ3hgTNhNAGF+wOQkEsjUzKX3YLNwPRFnIaz
	 pB3cwMh1tThhGRJS9A/cu7pO6haCd5zIwSDus1DL7N8j9OWFhSW/L9fMBvtygkBjgV
	 cCRptOrbrc1tU+purpQ64BgAvXF3nM8UnahqXl2icsYpgzFX44TcQ+ZofjxkG8J1hj
	 3zkyiHNEIo04N1gwcPSOiMJCbOkhpdTCTfacyJDLrqWyKPuuvU07V79VGsuRi/tr2p
	 L7/cDD+KOUA+9YzZnrqI0m5CeN8ANbtpCU3Ad2MzXeYgtJyJWiNMTgH8S7KizDpGB9
	 wiRKJzETIgFgg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id YVFnzGiEUBxk; Tue, 19 Mar 2024 09:05:30 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DD3BA9C4ACB;
	Tue, 19 Mar 2024 09:05:29 -0400 (EDT)
Date: Tue, 19 Mar 2024 09:05:29 -0400 (EDT)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: mdf <mdf@kernel.org>, Allen VANDIVER <avandiver@markem-imaje.com>, 
	Brian CODY <bcody@markem-imaje.com>, hao wu <hao.wu@intel.com>, 
	yilun xu <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, 
	linux-fpga <linux-fpga@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <1292581697.1872237.1710853529674.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <ZfkyMSczuFUdy3tU@yilunxu-OptiPlex-7050>
References: <20240313225746.489253-1-charles.perry@savoirfairelinux.com> <20240313225746.489253-4-charles.perry@savoirfairelinux.com> <ZfkyMSczuFUdy3tU@yilunxu-OptiPlex-7050>
Subject: Re: [PATCH v5 3/3] fpga: xilinx-selectmap: add new driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - FF120 (Linux)/8.8.15_GA_4581)
Thread-Topic: fpga: xilinx-selectmap: add new driver
Thread-Index: 0HF96KxB+j7D1rBnTxEW357y9Tr3RQ==


On Mar 19, 2024, at 2:35 AM, Xu Yilun yilun.xu@linux.intel.com wrote:
> On Wed, Mar 13, 2024 at 06:57:37PM -0400, Charles Perry wrote:
>> Xilinx 7 series FPGA can be programmed using a parallel port named
>> the SelectMAP interface in the datasheet. This interface is compatible
>> with the i.MX6 EIM bus controller but other types of external memory
>> mapped parallel bus might work.
>> 
>> xilinx-selectmap currently only supports the x8 mode where data is loaded
>> at one byte per rising edge of the clock, with the MSb of each byte
>> presented to the D0 pin.
>> 
>> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
>> ---
>> Changes since v4: (from Yilun review)
>>  * xilinx-core: select between prog/init and prog_b/init-b
>> 
>>  drivers/fpga/Kconfig            |  8 +++
>>  drivers/fpga/Makefile           |  1 +
>>  drivers/fpga/xilinx-core.c      | 29 +++++++++-
>>  drivers/fpga/xilinx-selectmap.c | 97 +++++++++++++++++++++++++++++++++
>>  4 files changed, 133 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/fpga/xilinx-selectmap.c
>> 
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index d27a1ebf40838..37b35f58f0dfb 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -67,6 +67,14 @@ config FPGA_MGR_STRATIX10_SOC
>>  config FPGA_MGR_XILINX_CORE
>>  	tristate
>> 
>> +config FPGA_MGR_XILINX_SELECTMAP
>> +	tristate "Xilinx Configuration over SelectMAP"
>> +	depends on HAS_IOMEM
>> +	select FPGA_MGR_XILINX_CORE
>> +	help
>> +	  FPGA manager driver support for Xilinx FPGA configuration
>> +	  over SelectMAP interface.
>> +
>>  config FPGA_MGR_XILINX_SPI
>>  	tristate "Xilinx Configuration over Slave Serial (SPI)"
>>  	depends on SPI
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> index 7ec795b6a5a70..aeb89bb13517e 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -16,6 +16,7 @@ obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)	+= socfpga-a10.o
>>  obj-$(CONFIG_FPGA_MGR_STRATIX10_SOC)	+= stratix10-soc.o
>>  obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
>>  obj-$(CONFIG_FPGA_MGR_XILINX_CORE)	+= xilinx-core.o
>> +obj-$(CONFIG_FPGA_MGR_XILINX_SELECTMAP)	+= xilinx-selectmap.o
>>  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
>>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>>  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
>> diff --git a/drivers/fpga/xilinx-core.c b/drivers/fpga/xilinx-core.c
>> index a35c43382dd5f..ccdeb45eba4ee 100644
>> --- a/drivers/fpga/xilinx-core.c
>> +++ b/drivers/fpga/xilinx-core.c
>> @@ -171,6 +171,29 @@ static int xilinx_core_write_complete(struct fpga_manager
>> *mgr,
>>  	return -ETIMEDOUT;
>>  }
>> 
>> +/**
>> + * xilinx_core_devm_gpiod_get - Obtain a resource-managed GPIO using a
>> + *                              legacy consumer name fallback.
>> + *
>> + * @dev:           Device managing the GPIO
>> + * @con_id:        Consumer id
>> + * @legacy_con_id: Legacy consumer id
>> + * @flags:         optional GPIO initialization flags
>> + */
> 
> No need to have kernel doc comments for internal functions.
> 

Ok, will remove.

>> +static inline struct gpio_desc *
>> +xilinx_core_devm_gpiod_get(struct device *dev, const char *con_id,
>> +			   const char *legacy_con_id, enum gpiod_flags flags)
>> +{
>> +	struct gpio_desc *desc;
>> +
>> +	desc = devm_gpiod_get(dev, con_id, flags);
>> +	if (IS_ERR(desc) && PTR_ERR(desc) == -ENOENT &&
>> +	    of_device_is_compatible(dev->of_node, "xlnx,fpga-slave-serial"))
>> +		desc = devm_gpiod_get(dev, legacy_con_id, flags);
>> +
>> +	return desc;
>> +}
>> +
>>  static const struct fpga_manager_ops xilinx_core_ops = {
>>  	.state = xilinx_core_state,
>>  	.write_init = xilinx_core_write_init,
>> @@ -186,12 +209,14 @@ int xilinx_core_probe(struct xilinx_fpga_core *core)
>>  		return -EINVAL;
>> 
>>  	/* PROGRAM_B is active low */
>> -	core->prog_b = devm_gpiod_get(core->dev, "prog_b", GPIOD_OUT_LOW);
>> +	core->prog_b = xilinx_core_devm_gpiod_get(core->dev, "prog", "prog_b",
>> +						  GPIOD_OUT_LOW);
>>  	if (IS_ERR(core->prog_b))
>>  		return dev_err_probe(core->dev, PTR_ERR(core->prog_b),
>>  				     "Failed to get PROGRAM_B gpio\n");
>> 
>> -	core->init_b = devm_gpiod_get_optional(core->dev, "init-b", GPIOD_IN);
>> +	core->init_b = xilinx_core_devm_gpiod_get(core->dev, "init", "init-b",
>> +						  GPIOD_IN);
>>  	if (IS_ERR(core->init_b))
>>  		return dev_err_probe(core->dev, PTR_ERR(core->init_b),
>>  				     "Failed to get INIT_B gpio\n");
> 
> Please make a separate patch for the naming change. This give a chance
> to explain why the change and how to correctly use the GPIO names.
> 

Ok

>> diff --git a/drivers/fpga/xilinx-selectmap.c b/drivers/fpga/xilinx-selectmap.c
>> new file mode 100644
>> index 0000000000000..b63f4623f8b2c
>> --- /dev/null
>> +++ b/drivers/fpga/xilinx-selectmap.c
>> @@ -0,0 +1,97 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Xilinx Spartan6 and 7 Series SelectMAP interface driver
>> + *
>> + * (C) 2024 Charles Perry <charles.perry@savoirfairelinux.com>
>> + *
>> + * Manage Xilinx FPGA firmware loaded over the SelectMAP configuration
>> + * interface.
>> + */
>> +
>> +#include "xilinx-core.h"
>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/of.h>
>> +#include <linux/io.h>
> 
> alphabetical order please.
> 

Ok

>> +
>> +struct xilinx_selectmap_conf {
>> +	struct xilinx_fpga_core core;
>> +	void __iomem *base;
>> +};
>> +
>> +#define to_xilinx_selectmap_conf(obj) \
>> +	container_of(obj, struct xilinx_selectmap_conf, core)
>> +
>> +static int xilinx_selectmap_write(struct xilinx_fpga_core *core,
>> +				  const char *buf, size_t count)
>> +{
>> +	struct xilinx_selectmap_conf *conf = to_xilinx_selectmap_conf(core);
>> +	u32 i;
>> +
>> +	for (i = 0; i < count; ++i)
>> +		writeb(buf[i], conf->base);
>> +
>> +	return 0;
>> +}
>> +
>> +static int xilinx_selectmap_probe(struct platform_device *pdev)
>> +{
>> +	struct xilinx_selectmap_conf *conf;
>> +	struct resource *r;
>> +	void __iomem *base;
>> +	struct gpio_desc *csi_b;
>> +	struct gpio_desc *rdwr_b;
> 
> One gpio_desc is enough, is it?  We don't use these gpio_desc anywhere
> else.
> 

Ok

> BTW, reverse Xmas tree is not strictly required, but please do it when it is
> easy to follow.
>

Ok
 
>> +
>> +	conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
>> +	if (!conf)
>> +		return -ENOMEM;
>> +
>> +	conf->core.dev = &pdev->dev;
>> +	conf->core.write = xilinx_selectmap_write;
>> +
>> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
> 
> I can't find where 'r' is used.
> 
> Thanks,
> Yilun
> 

I'm guilty of keeping things around in case I need them in the future
here! Ok, will use NULL.

Regards,
Charles

>> +	if (IS_ERR(base))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(base),
>> +				     "ioremap error\n");
>> +	conf->base = base;
>> +
>> +	/* CSI_B is active low */
>> +	csi_b = devm_gpiod_get_optional(&pdev->dev, "csi", GPIOD_OUT_HIGH);
>> +	if (IS_ERR(csi_b))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(csi_b),
>> +				     "Failed to get CSI_B gpio\n");
>> +
>> +	/* RDWR_B is active low */
>> +	rdwr_b = devm_gpiod_get_optional(&pdev->dev, "rdwr", GPIOD_OUT_HIGH);
>> +	if (IS_ERR(rdwr_b))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(rdwr_b),
>> +				     "Failed to get RDWR_B gpio\n");
>> +
>> +	return xilinx_core_probe(&conf->core);
>> +}
>> +
>> +static const struct of_device_id xlnx_selectmap_of_match[] = {
>> +	{ .compatible = "xlnx,fpga-xc7s-selectmap", }, // Spartan-7
>> +	{ .compatible = "xlnx,fpga-xc7a-selectmap", }, // Artix-7
>> +	{ .compatible = "xlnx,fpga-xc7k-selectmap", }, // Kintex-7
>> +	{ .compatible = "xlnx,fpga-xc7v-selectmap", }, // Virtex-7
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, xlnx_selectmap_of_match);
>> +
>> +static struct platform_driver xilinx_selectmap_driver = {
>> +	.driver = {
>> +		.name = "xilinx-selectmap",
>> +		.of_match_table = xlnx_selectmap_of_match,
>> +	},
>> +	.probe  = xilinx_selectmap_probe,
>> +};
>> +
>> +module_platform_driver(xilinx_selectmap_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Charles Perry <charles.perry@savoirfairelinux.com>");
>> +MODULE_DESCRIPTION("Load Xilinx FPGA firmware over SelectMap");
>> --
>> 2.43.0

