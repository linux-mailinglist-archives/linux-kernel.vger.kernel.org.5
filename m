Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3F7764425
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjG0DJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjG0DJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:09:23 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A82651719;
        Wed, 26 Jul 2023 20:09:19 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8BxHOve38FkVYMKAA--.21091S3;
        Thu, 27 Jul 2023 11:09:18 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxjiPc38FkP3c8AA--.55963S3;
        Thu, 27 Jul 2023 11:09:17 +0800 (CST)
Subject: Re: [PATCH v13 2/2] spi: loongson: add bus driver for the loongson
 spi controller
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        zhuyinbo@loongson.cn
References: <20230613075834.5219-1-zhuyinbo@loongson.cn>
 <20230613075834.5219-3-zhuyinbo@loongson.cn>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <3822f248-39dc-fb8d-321a-7b6c833cbb3e@loongson.cn>
Date:   Thu, 27 Jul 2023 11:09:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230613075834.5219-3-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiPc38FkP3c8AA--.55963S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Friendly ping ?


ÔÚ 2023/6/13 ÏÂÎç3:58, Yinbo Zhu Ð´µÀ:
> This bus driver supports the Loongson SPI hardware controller in the
> Loongson platforms and supports the use DTS and PCI framework to
> register SPI device resources.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>   MAINTAINERS                     |   4 +
>   drivers/spi/Kconfig             |  26 +++
>   drivers/spi/Makefile            |   3 +
>   drivers/spi/spi-loongson-core.c | 279 ++++++++++++++++++++++++++++++++
>   drivers/spi/spi-loongson-pci.c  |  55 +++++++
>   drivers/spi/spi-loongson-plat.c |  47 ++++++
>   drivers/spi/spi-loongson.h      |  49 ++++++
>   7 files changed, 463 insertions(+)
>   create mode 100644 drivers/spi/spi-loongson-core.c
>   create mode 100644 drivers/spi/spi-loongson-pci.c
>   create mode 100644 drivers/spi/spi-loongson-plat.c
>   create mode 100644 drivers/spi/spi-loongson.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e604dddd87b..69cb8fb2a0e1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12191,6 +12191,10 @@ M:	Yinbo Zhu <zhuyinbo@loongson.cn>
>   L:	linux-spi@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
> +F:	drivers/spi/spi-loongson-core.c
> +F:	drivers/spi/spi-loongson-pci.c
> +F:	drivers/spi/spi-loongson-plat.c
> +F:	drivers/spi/spi-loongson.h
>   
>   LOONGSON-2 SOC SERIES GUTS DRIVER
>   M:	Yinbo Zhu <zhuyinbo@loongson.cn>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 3de2ebe8294a..6b953904792e 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -516,6 +516,32 @@ config SPI_LM70_LLP
>   	  which interfaces to an LM70 temperature sensor using
>   	  a parallel port.
>   
> +config SPI_LOONGSON_CORE
> +	tristate
> +	depends on LOONGARCH || COMPILE_TEST
> +
> +config SPI_LOONGSON_PCI
> +	tristate "Loongson SPI Controller PCI Driver Support"
> +	select SPI_LOONGSON_CORE
> +	depends on PCI && (LOONGARCH || COMPILE_TEST)
> +	help
> +	  This bus driver supports the Loongson SPI hardware controller in
> +	  the Loongson platforms and supports to use PCI framework to
> +	  register SPI device resources.
> +	  Say Y or M here if you want to use the SPI controller on
> +	  Loongson platform.
> +
> +config SPI_LOONGSON_PLATFORM
> +	tristate "Loongson SPI Controller Platform Driver Support"
> +	select SPI_LOONGSON_CORE
> +	depends on OF && (LOONGARCH || COMPILE_TEST)
> +	help
> +	  This bus driver supports the Loongson SPI hardware controller in
> +	  the Loongson platforms and supports to use DTS framework to
> +	  register SPI device resources.
> +	  Say Y or M here if you want to use the SPI controller on
> +	  Loongson platform.
> +
>   config SPI_LP8841_RTC
>   	tristate "ICP DAS LP-8841 SPI Controller for RTC"
>   	depends on MACH_PXA27X_DT || COMPILE_TEST
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 28c4817a8a74..3e933064d237 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -71,6 +71,9 @@ obj-$(CONFIG_SPI_INTEL_PLATFORM)	+= spi-intel-platform.o
>   obj-$(CONFIG_SPI_LANTIQ_SSC)		+= spi-lantiq-ssc.o
>   obj-$(CONFIG_SPI_JCORE)			+= spi-jcore.o
>   obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
> +obj-$(CONFIG_SPI_LOONGSON_CORE)		+= spi-loongson-core.o
> +obj-$(CONFIG_SPI_LOONGSON_PCI)		+= spi-loongson-pci.o
> +obj-$(CONFIG_SPI_LOONGSON_PLATFORM)	+= spi-loongson-plat.o
>   obj-$(CONFIG_SPI_LP8841_RTC)		+= spi-lp8841-rtc.o
>   obj-$(CONFIG_SPI_MESON_SPICC)		+= spi-meson-spicc.o
>   obj-$(CONFIG_SPI_MESON_SPIFC)		+= spi-meson-spifc.o
> diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-core.c
> new file mode 100644
> index 000000000000..f97800b6fd65
> --- /dev/null
> +++ b/drivers/spi/spi-loongson-core.c
> @@ -0,0 +1,279 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Loongson SPI Support
> +// Copyright (C) 2023 Loongson Technology Corporation Limited
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +
> +#include "spi-loongson.h"
> +
> +static inline void loongson_spi_write_reg(struct loongson_spi *spi, unsigned char reg,
> +					  unsigned char data)
> +{
> +	writeb(data, spi->base + reg);
> +}
> +
> +static inline char loongson_spi_read_reg(struct loongson_spi *spi, unsigned char reg)
> +{
> +	return readb(spi->base + reg);
> +}
> +
> +static void loongson_spi_set_cs(struct spi_device *spi, bool en)
> +{
> +	int cs;
> +	unsigned char mask = (BIT(4) | BIT(0)) << spi_get_chipselect(spi, 0);
> +	unsigned char val = en ? mask :  (BIT(0) << spi_get_chipselect(spi, 0));
> +	struct loongson_spi *loongson_spi = spi_controller_get_devdata(spi->controller);
> +
> +	cs = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_REG) & ~mask;
> +	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, val | cs);
> +}
> +
> +static void loongson_spi_set_clk(struct loongson_spi *loongson_spi, unsigned int hz)
> +{
> +	unsigned char val;
> +	unsigned int div, div_tmp;
> +	static const char rdiv[12] = {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};
> +
> +	div = clamp_val(DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz), 2, 4096);
> +	div_tmp = rdiv[fls(div - 1)];
> +	loongson_spi->spcr = (div_tmp & GENMASK(1, 0)) >> 0;
> +	loongson_spi->sper = (div_tmp & GENMASK(3, 2)) >> 2;
> +	val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
> +	val &= ~GENMASK(1, 0);
> +	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, val |
> +			       loongson_spi->spcr);
> +	val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG);
> +	val &= ~GENMASK(1, 0);
> +	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, val |
> +			       loongson_spi->sper);
> +	loongson_spi->hz = hz;
> +}
> +
> +static void loongson_spi_set_mode(struct loongson_spi *loongson_spi,
> +				  struct spi_device *spi)
> +{
> +	unsigned char val;
> +
> +	val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
> +	val &= ~(LOONGSON_SPI_SPCR_CPOL | LOONGSON_SPI_SPCR_CPHA);
> +	if (spi->mode & SPI_CPOL)
> +		val |= LOONGSON_SPI_SPCR_CPOL;
> +	if (spi->mode & SPI_CPHA)
> +		val |= LOONGSON_SPI_SPCR_CPHA;
> +
> +	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, val);
> +	loongson_spi->mode |= spi->mode;
> +}
> +
> +static int loongson_spi_update_state(struct loongson_spi *loongson_spi,
> +				struct spi_device *spi, struct spi_transfer *t)
> +{
> +	if (t && loongson_spi->hz != t->speed_hz)
> +		loongson_spi_set_clk(loongson_spi, t->speed_hz);
> +
> +	if ((spi->mode ^ loongson_spi->mode) & SPI_MODE_X_MASK)
> +		loongson_spi_set_mode(loongson_spi, spi);
> +
> +	return 0;
> +}
> +
> +static int loongson_spi_setup(struct spi_device *spi)
> +{
> +	struct loongson_spi *loongson_spi;
> +
> +	loongson_spi = spi_controller_get_devdata(spi->controller);
> +	if (spi->bits_per_word % 8)
> +		return -EINVAL;
> +
> +	if (spi_get_chipselect(spi, 0) >= spi->controller->num_chipselect)
> +		return -EINVAL;
> +
> +	loongson_spi->hz = 0;
> +	loongson_spi_set_cs(spi, true);
> +
> +	return 0;
> +}
> +
> +static int loongson_spi_write_read_8bit(struct spi_device *spi, const u8 **tx_buf,
> +					u8 **rx_buf, unsigned int num)
> +{
> +	int ret;
> +	struct loongson_spi *loongson_spi = spi_controller_get_devdata(spi->controller);
> +
> +	if (tx_buf && *tx_buf)
> +		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG, *((*tx_buf)++));
> +	else
> +		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG, 0);
> +
> +	ret = readb_poll_timeout(loongson_spi->base + LOONGSON_SPI_SPSR_REG,
> +				 loongson_spi->spsr, (loongson_spi->spsr &
> +				 LOONGSON_SPI_SPSR_RFEMPTY) != LOONGSON_SPI_SPSR_RFEMPTY,
> +				 1, USEC_PER_MSEC);
> +
> +	if (rx_buf && *rx_buf)
> +		*(*rx_buf)++ = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_FIFO_REG);
> +	else
> +		loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_FIFO_REG);
> +
> +	return ret;
> +}
> +
> +static int loongson_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
> +{
> +	int ret;
> +	unsigned int count;
> +	const u8 *tx = xfer->tx_buf;
> +	u8 *rx = xfer->rx_buf;
> +
> +	count = xfer->len;
> +	do {
> +		ret = loongson_spi_write_read_8bit(spi, &tx, &rx, count);
> +		if (ret)
> +			break;
> +	} while (--count);
> +
> +	return ret;
> +}
> +
> +static int loongson_spi_prepare_message(struct spi_controller *ctlr, struct spi_message *m)
> +{
> +	struct loongson_spi *loongson_spi = spi_controller_get_devdata(ctlr);
> +
> +	loongson_spi->para = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_REG);
> +	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loongson_spi->para &
> +			       ~LOONGSON_SPI_PARA_MEM_EN);
> +
> +	return 0;
> +}
> +
> +static int loongson_spi_transfer_one(struct spi_controller *ctrl, struct spi_device *spi,
> +				     struct spi_transfer *xfer)
> +{
> +	struct loongson_spi *loongson_spi = spi_controller_get_devdata(spi->controller);
> +
> +	loongson_spi_update_state(loongson_spi, spi, xfer);
> +	if (xfer->len)
> +		return loongson_spi_write_read(spi, xfer);
> +
> +	return 0;
> +}
> +
> +static int loongson_spi_unprepare_message(struct spi_controller *ctrl, struct spi_message *m)
> +{
> +	struct loongson_spi *loongson_spi = spi_controller_get_devdata(ctrl);
> +
> +	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loongson_spi->para);
> +
> +	return 0;
> +}
> +
> +static void loongson_spi_reginit(struct loongson_spi *loongson_spi_dev)
> +{
> +	unsigned char val;
> +
> +	val = loongson_spi_read_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG);
> +	val &= ~LOONGSON_SPI_SPCR_SPE;
> +	loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG, val);
> +
> +	loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPSR_REG,
> +			       (LOONGSON_SPI_SPSR_SPIF | LOONGSON_SPI_SPSR_WCOL));
> +
> +	val = loongson_spi_read_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG);
> +	val |= LOONGSON_SPI_SPCR_SPE;
> +	loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG, val);
> +}
> +
> +int loongson_spi_init_controller(struct device *dev, void __iomem *regs)
> +{
> +	struct spi_controller *controller;
> +	struct loongson_spi *spi;
> +	struct clk *clk;
> +
> +	controller = devm_spi_alloc_host(dev, sizeof(struct loongson_spi));
> +	if (controller == NULL)
> +		return -ENOMEM;
> +
> +	controller->mode_bits = SPI_MODE_X_MASK | SPI_CS_HIGH;
> +	controller->setup = loongson_spi_setup;
> +	controller->prepare_message = loongson_spi_prepare_message;
> +	controller->transfer_one = loongson_spi_transfer_one;
> +	controller->unprepare_message = loongson_spi_unprepare_message;
> +	controller->set_cs = loongson_spi_set_cs;
> +	controller->num_chipselect = 4;
> +	device_set_node(&controller->dev, dev_fwnode(dev));
> +	dev_set_drvdata(dev, controller);
> +
> +	spi = spi_controller_get_devdata(controller);
> +	spi->base = regs;
> +	spi->controller = controller;
> +
> +	clk = devm_clk_get_optional(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "unable to get clock\n");
> +
> +	spi->clk_rate = clk_get_rate(clk);
> +	loongson_spi_reginit(spi);
> +
> +	spi->mode = 0;
> +
> +	return devm_spi_register_controller(dev, controller);
> +}
> +EXPORT_SYMBOL_NS_GPL(loongson_spi_init_controller, SPI_LOONGSON_CORE);
> +
> +static int __maybe_unused loongson_spi_suspend(struct device *dev)
> +{
> +	struct loongson_spi *loongson_spi;
> +	struct spi_controller *controller;
> +
> +	controller = dev_get_drvdata(dev);
> +	spi_controller_suspend(controller);
> +
> +	loongson_spi = spi_controller_get_devdata(controller);
> +
> +	loongson_spi->spcr = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
> +	loongson_spi->sper = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG);
> +	loongson_spi->spsr = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPSR_REG);
> +	loongson_spi->para = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_REG);
> +	loongson_spi->sfcs = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_REG);
> +	loongson_spi->timi = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_TIMI_REG);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused loongson_spi_resume(struct device *dev)
> +{
> +	struct loongson_spi *loongson_spi;
> +	struct spi_controller *controller;
> +
> +	controller = dev_get_drvdata(dev);
> +	loongson_spi = spi_controller_get_devdata(controller);
> +
> +	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, loongson_spi->spcr);
> +	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, loongson_spi->sper);
> +	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPSR_REG, loongson_spi->spsr);
> +	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loongson_spi->para);
> +	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, loongson_spi->sfcs);
> +	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_TIMI_REG, loongson_spi->timi);
> +
> +	spi_controller_resume(controller);
> +
> +	return 0;
> +}
> +
> +const struct dev_pm_ops loongson_spi_dev_pm_ops = {
> +	.suspend = loongson_spi_suspend,
> +	.resume = loongson_spi_resume,
> +};
> +EXPORT_SYMBOL_NS_GPL(loongson_spi_dev_pm_ops, SPI_LOONGSON_CORE);
> +
> +MODULE_DESCRIPTION("Loongson SPI core driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/spi/spi-loongson-pci.c b/drivers/spi/spi-loongson-pci.c
> new file mode 100644
> index 000000000000..134cda0c13a5
> --- /dev/null
> +++ b/drivers/spi/spi-loongson-pci.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// PCI interface driver for Loongson SPI Support
> +// Copyright (C) 2023 Loongson Technology Corporation Limited
> +
> +#include <linux/mod_devicetable.h>
> +#include <linux/pci.h>
> +
> +#include "spi-loongson.h"
> +
> +static int loongson_spi_pci_register(struct pci_dev *pdev,
> +			const struct pci_device_id *ent)
> +{
> +	int ret;
> +	void __iomem *reg_base;
> +	struct device *dev = &pdev->dev;
> +	int pci_bar = 0;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "cannot enable pci device\n");
> +
> +	ret = pcim_iomap_regions(pdev, BIT(pci_bar), pci_name(pdev));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to request and remap memory\n");
> +
> +	reg_base = pcim_iomap_table(pdev)[pci_bar];
> +
> +	ret = loongson_spi_init_controller(dev, reg_base);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize controller\n");
> +
> +	return 0;
> +}
> +
> +static struct pci_device_id loongson_spi_devices[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a0b) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a1b) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, loongson_spi_devices);
> +
> +static struct pci_driver loongson_spi_pci_driver = {
> +	.name       = "loongson-spi-pci",
> +	.id_table   = loongson_spi_devices,
> +	.probe      = loongson_spi_pci_register,
> +	.driver	= {
> +		.bus = &pci_bus_type,
> +		.pm = &loongson_spi_dev_pm_ops,
> +	},
> +};
> +module_pci_driver(loongson_spi_pci_driver);
> +
> +MODULE_DESCRIPTION("Loongson spi pci driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(SPI_LOONGSON_CORE);
> diff --git a/drivers/spi/spi-loongson-plat.c b/drivers/spi/spi-loongson-plat.c
> new file mode 100644
> index 000000000000..c066e5f5891e
> --- /dev/null
> +++ b/drivers/spi/spi-loongson-plat.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Platform driver for Loongson SPI Support
> +// Copyright (C) 2023 Loongson Technology Corporation Limited
> +
> +#include <linux/err.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +
> +#include "spi-loongson.h"
> +
> +static int loongson_spi_platform_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	void __iomem *reg_base;
> +	struct device *dev = &pdev->dev;
> +
> +	reg_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(reg_base))
> +		return PTR_ERR(reg_base);
> +
> +	ret = loongson_spi_init_controller(dev, reg_base);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize controller\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id loongson_spi_id_table[] = {
> +	{ .compatible = "loongson,ls2k1000-spi" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, loongson_spi_id_table);
> +
> +static struct platform_driver loongson_spi_plat_driver = {
> +	.probe = loongson_spi_platform_probe,
> +	.driver	= {
> +		.name	= "loongson-spi",
> +		.bus = &platform_bus_type,
> +		.pm = &loongson_spi_dev_pm_ops,
> +		.of_match_table = loongson_spi_id_table,
> +	},
> +};
> +module_platform_driver(loongson_spi_plat_driver);
> +
> +MODULE_DESCRIPTION("Loongson spi platform driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(SPI_LOONGSON_CORE);
> diff --git a/drivers/spi/spi-loongson.h b/drivers/spi/spi-loongson.h
> new file mode 100644
> index 000000000000..35f95b161842
> --- /dev/null
> +++ b/drivers/spi/spi-loongson.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* Header File for Loongson SPI Driver. */
> +/* Copyright (C) 2023 Loongson Technology Corporation Limited */
> +
> +#ifndef __LINUX_SPI_LOONGSON_H
> +#define __LINUX_SPI_LOONGSON_H
> +
> +#include <linux/bits.h>
> +#include <linux/pm.h>
> +#include <linux/types.h>
> +
> +#define	LOONGSON_SPI_SPCR_REG	0x00
> +#define	LOONGSON_SPI_SPSR_REG	0x01
> +#define	LOONGSON_SPI_FIFO_REG	0x02
> +#define	LOONGSON_SPI_SPER_REG	0x03
> +#define	LOONGSON_SPI_PARA_REG	0x04
> +#define	LOONGSON_SPI_SFCS_REG	0x05
> +#define	LOONGSON_SPI_TIMI_REG	0x06
> +
> +/* Bits definition for Loongson SPI register */
> +#define	LOONGSON_SPI_PARA_MEM_EN	BIT(0)
> +#define	LOONGSON_SPI_SPCR_CPHA	BIT(2)
> +#define	LOONGSON_SPI_SPCR_CPOL	BIT(3)
> +#define	LOONGSON_SPI_SPCR_SPE	BIT(6)
> +#define	LOONGSON_SPI_SPSR_RFEMPTY	BIT(0)
> +#define	LOONGSON_SPI_SPSR_WCOL	BIT(6)
> +#define	LOONGSON_SPI_SPSR_SPIF	BIT(7)
> +
> +struct device;
> +struct spi_controller;
> +
> +struct loongson_spi {
> +	struct	spi_controller	*controller;
> +	void __iomem		*base;
> +	int			cs_active;
> +	unsigned int		hz;
> +	unsigned char		spcr;
> +	unsigned char		sper;
> +	unsigned char		spsr;
> +	unsigned char		para;
> +	unsigned char		sfcs;
> +	unsigned char		timi;
> +	unsigned int		mode;
> +	u64			clk_rate;
> +};
> +
> +int loongson_spi_init_controller(struct device *dev, void __iomem *reg);
> +extern const struct dev_pm_ops loongson_spi_dev_pm_ops;
> +#endif /* __LINUX_SPI_LOONGSON_H */
> 

