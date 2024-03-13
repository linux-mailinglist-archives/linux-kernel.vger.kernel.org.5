Return-Path: <linux-kernel+bounces-102613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5796E87B493
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3891C21923
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC505BACB;
	Wed, 13 Mar 2024 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="iydUiKWb"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72BD5D8EB;
	Wed, 13 Mar 2024 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370089; cv=none; b=hINrPu/h6uZVqiXKRy3gDegngjVqlzsT8/LSHYYZSFHBAAETtRWGz3rw0Hgz8Ok/xTOrDm9yKIq1YGTQqDt8dirZpq6xR2RHaROR+zHqVr+K2kqIQPDGtw89CiflwHHLxVoPe/7wn/gRq1G1lN9wucXVSxTHwEiZWiZyUYGK+aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370089; c=relaxed/simple;
	bh=QDffdnpVJ8UuhZhQPowE0oVw8ewzHVa66mnf6v2OgVo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=gg5lin/qklY0SH53WtTGwJKnu0e1xP2iAu/QIez0Ljw8f8dLZiaDDjSVi0movwvVhFkpXlPFfAYDMa4aYnlNOVpUnjxEvoWC+mdxO5xaqcm8Q5j+jtgXF8918bCFTEgyGS3sm/rn4NeO/Ix/X3RR+g842txUD9qxq2gQl1MSYOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=iydUiKWb; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A84689C427D;
	Wed, 13 Mar 2024 18:47:56 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id xaZrPhPNJYVB; Wed, 13 Mar 2024 18:47:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 100969C5403;
	Wed, 13 Mar 2024 18:47:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 100969C5403
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1710370075; bh=EXdrZY8dUBLLI/DygiB/KvorQDQg9TU5RftnAaBpjz0=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=iydUiKWbEhBll9Bg7DYonzvi2lFJIu3BQyFtkN1ntXu7uPakSZPEpFbDGj0mCrwHs
	 3eQ++LcLsxcSI2uzBzlj/RRoWYAo61DebGzlXrtc2mu8GaWYcrsMhNZT9N4jPGYRVR
	 7+1daaOVCg7ywlagCcOs5ReP1JecigaJXc5rWVxK1ObiFWguG5XP51HUgXUVjD1anV
	 WQI4112yFBXSWXalJ014yf6Z41zLx4sNiTcnoQRa0zX6bw9vpq1/HQX5AXv8D24gXn
	 28KqZVepaZH+XcSei5Q+gsxqP9seUyh0AngrJYOeo2FVEB+Chd7IiCrasUTXc3kIdL
	 aRGCJCNLrq0Sw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id KTK1KVkf7TZJ; Wed, 13 Mar 2024 18:47:54 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BB32A9C427D;
	Wed, 13 Mar 2024 18:47:54 -0400 (EDT)
Date: Wed, 13 Mar 2024 18:47:54 -0400 (EDT)
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
Message-ID: <735798303.1747344.1710370074702.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <1667978841.1508200.1709486558665.JavaMail.zimbra@savoirfairelinux.com>
References: <20240221195058.1281973-1-charles.perry@savoirfairelinux.com> <20240221195058.1281973-4-charles.perry@savoirfairelinux.com> <Zdxe7mvBbHDHzbiS@yilunxu-OptiPlex-7050> <1667978841.1508200.1709486558665.JavaMail.zimbra@savoirfairelinux.com>
Subject: Re: [PATCH v4 3/3] fpga: xilinx-selectmap: add new driver
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
Thread-Index: ZKiev4qNzSquSIuuXA0kTMbwGPBpeJ8WKeUT



On Mar 3, 2024, at 12:22 PM, Charles Perry charles.perry@savoirfairelinux.com wrote:
> On Feb 26, 2024, at 2:50 AM, Xu Yilun yilun.xu@linux.intel.com wrote:
> 
>> On Wed, Feb 21, 2024 at 02:50:49PM -0500, Charles Perry wrote:
>>> Xilinx 7 series FPGA can be programmed using a parallel port named
>>> the SelectMAP interface in the datasheet. This interface is compatible
>>> with the i.MX6 EIM bus controller but other types of external memory
>>> mapped parallel bus might work.
>>> 
>>> xilinx-selectmap currently only supports the x8 mode where data is loaded
>>> at one byte per rising edge of the clock, with the MSb of each byte
>>> presented to the D0 pin.
>>> 
>>> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
>>> ---
>>>  drivers/fpga/Kconfig            |  8 +++
>>>  drivers/fpga/Makefile           |  1 +
>>>  drivers/fpga/xilinx-selectmap.c | 97 +++++++++++++++++++++++++++++++++
>>>  3 files changed, 106 insertions(+)
>>>  create mode 100644 drivers/fpga/xilinx-selectmap.c
>>> 
>>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>>> index d27a1ebf40838..37b35f58f0dfb 100644
>>> --- a/drivers/fpga/Kconfig
>>> +++ b/drivers/fpga/Kconfig
>>> @@ -67,6 +67,14 @@ config FPGA_MGR_STRATIX10_SOC
>>>  config FPGA_MGR_XILINX_CORE
>>>  	tristate
>>>  
>>> +config FPGA_MGR_XILINX_SELECTMAP
>>> +	tristate "Xilinx Configuration over SelectMAP"
>>> +	depends on HAS_IOMEM
>>> +	select FPGA_MGR_XILINX_CORE
>>> +	help
>>> +	  FPGA manager driver support for Xilinx FPGA configuration
>>> +	  over SelectMAP interface.
>>> +
>>>  config FPGA_MGR_XILINX_SPI
>>>  	tristate "Xilinx Configuration over Slave Serial (SPI)"
>>>  	depends on SPI
>>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>>> index 7ec795b6a5a70..aeb89bb13517e 100644
>>> --- a/drivers/fpga/Makefile
>>> +++ b/drivers/fpga/Makefile
>>> @@ -16,6 +16,7 @@ obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)	+= socfpga-a10.o
>>>  obj-$(CONFIG_FPGA_MGR_STRATIX10_SOC)	+= stratix10-soc.o
>>>  obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
>>>  obj-$(CONFIG_FPGA_MGR_XILINX_CORE)	+= xilinx-core.o
>>> +obj-$(CONFIG_FPGA_MGR_XILINX_SELECTMAP)	+= xilinx-selectmap.o
>>>  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
>>>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>>>  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
>>> diff --git a/drivers/fpga/xilinx-selectmap.c b/drivers/fpga/xilinx-selectmap.c
>>> new file mode 100644
>>> index 0000000000000..b63f4623f8b2c
>>> --- /dev/null
>>> +++ b/drivers/fpga/xilinx-selectmap.c
>>> @@ -0,0 +1,97 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Xilinx Spartan6 and 7 Series SelectMAP interface driver
>>> + *
>>> + * (C) 2024 Charles Perry <charles.perry@savoirfairelinux.com>
>>> + *
>>> + * Manage Xilinx FPGA firmware loaded over the SelectMAP configuration
>>> + * interface.
>>> + */
>>> +
>>> +#include "xilinx-core.h"
>>> +
>>> +#include <linux/platform_device.h>
>>> +#include <linux/gpio/consumer.h>
>>> +#include <linux/module.h>
>>> +#include <linux/mod_devicetable.h>
>>> +#include <linux/of.h>
>>> +#include <linux/io.h>
>>> +
>>> +struct xilinx_selectmap_conf {
>>> +	struct xilinx_fpga_core core;
>>> +	void __iomem *base;
>>> +};
>>> +
>>> +#define to_xilinx_selectmap_conf(obj) \
>>> +	container_of(obj, struct xilinx_selectmap_conf, core)
>>> +
>>> +static int xilinx_selectmap_write(struct xilinx_fpga_core *core,
>>> +				  const char *buf, size_t count)
>>> +{
>>> +	struct xilinx_selectmap_conf *conf = to_xilinx_selectmap_conf(core);
>>> +	u32 i;
>>> +
>>> +	for (i = 0; i < count; ++i)
>>> +		writeb(buf[i], conf->base);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int xilinx_selectmap_probe(struct platform_device *pdev)
>>> +{
>>> +	struct xilinx_selectmap_conf *conf;
>>> +	struct resource *r;
>>> +	void __iomem *base;
>>> +	struct gpio_desc *csi_b;
>>> +	struct gpio_desc *rdwr_b;
>>> +
>>> +	conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
>>> +	if (!conf)
>>> +		return -ENOMEM;
>>> +
>>> +	conf->core.dev = &pdev->dev;
>>> +	conf->core.write = xilinx_selectmap_write;
>>> +
>>> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
>>> +	if (IS_ERR(base))
>>> +		return dev_err_probe(&pdev->dev, PTR_ERR(base),
>>> +				     "ioremap error\n");
>>> +	conf->base = base;
>>> +
>>> +	/* CSI_B is active low */
>>> +	csi_b = devm_gpiod_get_optional(&pdev->dev, "csi", GPIOD_OUT_HIGH);
>>> +	if (IS_ERR(csi_b))
>>> +		return dev_err_probe(&pdev->dev, PTR_ERR(csi_b),
>>> +				     "Failed to get CSI_B gpio\n");
>>> +
>>> +	/* RDWR_B is active low */
>>> +	rdwr_b = devm_gpiod_get_optional(&pdev->dev, "rdwr", GPIOD_OUT_HIGH);
>>> +	if (IS_ERR(rdwr_b))
>>> +		return dev_err_probe(&pdev->dev, PTR_ERR(rdwr_b),
>>> +				     "Failed to get RDWR_B gpio\n");
>>> +
>>> +	return xilinx_core_probe(&conf->core);
>>> +}
>>> +
>>> +static const struct of_device_id xlnx_selectmap_of_match[] = {
>>> +	{ .compatible = "xlnx,fpga-xc7s-selectmap", }, // Spartan-7
>>> +	{ .compatible = "xlnx,fpga-xc7a-selectmap", }, // Artix-7
>>> +	{ .compatible = "xlnx,fpga-xc7k-selectmap", }, // Kintex-7
>>> +	{ .compatible = "xlnx,fpga-xc7v-selectmap", }, // Virtex-7
>>> +	{},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, xlnx_selectmap_of_match);
>> 
>> Does the driver have to be used with OF or not?
>> 
>> If yes, please specify the reason and enforce in Kconfig.
>> If no, please ensure it decently compiles without CONFIG_OF.
>> 
>> Thanks,
>> Yilun
>> 
> 
> No, it doesn't need OF explicitly as it only needs a few GPIO and a
> memory mapped IO region. It would be possible to get this info from
> platform data.
> 
> I'll fix the compilation without CONFIG_OF.

It does compile without CONFIG_OF in its current form as I can compile
it for x86_64 without warnings.

One of the reason why xilinx-spi.c needs an "#ifdef CONFIG_OF" wrapper
around the of_device_id table is because it uses of_match_ptr() which
resolves to NULL when CONFIG_OF is not set, which triggers an unused
variable warning. This is not the case in xilinx-selectmap.c because
it's not using of_match_ptr().

Regards,
Charles

> 
> Regards,
> Charles
> 
>>> +
>>> +static struct platform_driver xilinx_selectmap_driver = {
>>> +	.driver = {
>>> +		.name = "xilinx-selectmap",
>>> +		.of_match_table = xlnx_selectmap_of_match,
>>> +	},
>>> +	.probe  = xilinx_selectmap_probe,
>>> +};
>>> +
>>> +module_platform_driver(xilinx_selectmap_driver);
>>> +
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_AUTHOR("Charles Perry <charles.perry@savoirfairelinux.com>");
>>> +MODULE_DESCRIPTION("Load Xilinx FPGA firmware over SelectMap");
>>> --
>>> 2.43.0

