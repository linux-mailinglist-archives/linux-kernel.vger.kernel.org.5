Return-Path: <linux-kernel+bounces-107322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED19B87FB0E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7931C21BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97077D09D;
	Tue, 19 Mar 2024 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgPZ4EVC"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568067D079
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841767; cv=none; b=najEhJ8ErbDbVP6K53EVYgdQ+PzlyPekarPek3bPwMTrA1rJOSMimdWqk9U3xtL2WdQsqpBw62nZxCM5EXiK9TnltLOOAUBYRgya9Nc7QWMnIghEpZlSJdOLgimYxnU1KBOPGe6J+T4Ht2MJ2Iikt2VWzIUjpxLqkcH1I3IWIzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841767; c=relaxed/simple;
	bh=P7FKBfYF+6UwTUSXOGt+8bPufHPRfVzztzpNqVPw6RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWBbMAAm6q2w/tjZUZ+nE9mNjkdU14u9ZxU0X9d2u+5p+xhxf7TuUS3AzgpKQuFQjDDvx0+XliriEcii6jM/KDFISRrpwzToPEk1jj7X8Xj99/rz1m5qtnrF+1pxs6V/Mf65Z2Y/vnBGkttfdXu+hwjxgcpHH5JRvcR0fnoxc7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dgPZ4EVC; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56b95eb687fso525543a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710841764; x=1711446564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Vw3KjgS782wX4cjsT0ZyCV8eiyep4xMafh2tE0txz0=;
        b=dgPZ4EVCxCi7l+MYhH6x+ejRKrniditV7QfJtaWtcb8JUygjGqFDfdwvSAApb2GWb1
         IfimVxmJzV1xciG6Ps5aZUEErmvoXbyEOJSB/W/NrOZOwvUsX26CuIAIFaTD1XLZwnek
         j7zQzxTmdPwyPRkbgFa6ZxIcgd72GDQxbFoV912b3tHUI4iCuAKSOEX2u3QcXPQwDcmY
         BltJEkMPRJtPjBlUvAPwk8wdVb06lj3+SmzTFDmF1pDUZcfbGadS3UiHlRiFhEdc/vWu
         BYllLIBH8KVgQsPojc0I9j0+M0K+2yQ+HVVuCo+nU47UiS+g33vhJ3EVhVtUPdVZ9nhV
         3M0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710841764; x=1711446564;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Vw3KjgS782wX4cjsT0ZyCV8eiyep4xMafh2tE0txz0=;
        b=EuZyE9N8fBrymEj2xzL/myFhfi42ClhwlaTczLV8AP2XUkx67LtDWE7O5QPltY1Wpf
         DE7H96V/FrFKB+LxAHK51ShY7Thv5aAt3DFyu2iM4UBT8UdhM45pawaADtuNeMLhbppW
         ranUTMjbOn01u3Q/Sh4dP/xJypqrkLp2ELz6O+k6plJ04dhAuxcT6R96UgITG7R6jeBA
         orJSKkOsLQYcCHz2lIVVDs9BdmwIed9ZftN20ge/iTHV8Zn4z/rKZVJNV78IclRAW+oE
         msYh9wtYrfQ+zdw0EcPnoQewIQD3dKog7u1JB/JBwr7TTOIvfONRYpi5utwjQ6ozLGYy
         wdow==
X-Forwarded-Encrypted: i=1; AJvYcCXiExQllZdSv99tfGNp1Uchill46GooAv0FYoJTwg2dicQjy34h4N32krykK0JsH6MyfDNLQyUBOQaGfAfQNShhSSmO2MLY/LI4SynT
X-Gm-Message-State: AOJu0Ywq9HlQpSSYAM9/5sT/ZNnR0oEtSxrVWpyChvPyxAT1QsanKfjD
	WSpQcG151OsqJlVUoSgo/ps8rhlguP4J2Dh9D0iL3RORhrRqeUgfrYtxi7LhC+Q=
X-Google-Smtp-Source: AGHT+IHPJsITMU7LOWi8sZ3BEoORdt63XwYZlXUWAxb844DmrvhQoMc+QVFINgFzprc0INkf5SZERg==
X-Received: by 2002:a05:6402:1943:b0:568:d7c0:eb10 with SMTP id f3-20020a056402194300b00568d7c0eb10mr5042331edz.3.1710841763577;
        Tue, 19 Mar 2024 02:49:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id c12-20020a0564021f8c00b005682f8b62a6sm5578150edc.97.2024.03.19.02.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 02:49:23 -0700 (PDT)
Message-ID: <fdb557a6-f505-487b-899b-3b794f9dbaf0@linaro.org>
Date: Tue, 19 Mar 2024 10:49:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] Add eSPI device driver (flash channel)
To: Manojkiran Eda <manojkiran.eda@gmail.com>, patrick.rudolph@9elements.com,
 chiawei_wang@aspeedtech.com, ryan_chen@aspeedtech.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 jk@codeconstruct.com.au, openbmc@lists.ozlabs.org
References: <20240319093405.39833-1-manojkiran.eda@gmail.com>
 <20240319093405.39833-2-manojkiran.eda@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240319093405.39833-2-manojkiran.eda@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 10:34, Manojkiran Eda wrote:
> This patch adds the driver support for the eSPI controller of
> Aspeed 5/6th generation SoCs. This controller is a slave device
> communicating with a master over Enhanced Serial Peripheral
> Interface (eSPI).
> 
> eSPI supports 4 channels, namely peripheral, virtual wire,
> out-of-band, and flash, and operates at max frequency of 66MHz.
> 
> But at the moment, this patch set only supports the mafs mode
> (master attached flash sharing mode) in the flash channel.
> 
> Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>
> ---
>  drivers/soc/aspeed/Kconfig                  |  38 ++
>  drivers/soc/aspeed/Makefile                 |   2 +
>  drivers/soc/aspeed/aspeed-espi-ctrl.c       | 197 +++++++++
>  drivers/soc/aspeed/aspeed-espi-ctrl.h       | 169 +++++++
>  drivers/soc/aspeed/aspeed-espi-flash-mafs.c | 467 ++++++++++++++++++++
>  drivers/soc/aspeed/aspeed-espi-flash.h      |  71 +++
>  6 files changed, 944 insertions(+)
>  create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.c
>  create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.h
>  create mode 100644 drivers/soc/aspeed/aspeed-espi-flash-mafs.c
>  create mode 100644 drivers/soc/aspeed/aspeed-espi-flash.h
> 
> diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
> index f579ee0b5afa..c300ee8fe33a 100644
> --- a/drivers/soc/aspeed/Kconfig
> +++ b/drivers/soc/aspeed/Kconfig
> @@ -52,6 +52,44 @@ config ASPEED_SOCINFO
>  	help
>  	  Say yes to support decoding of ASPEED BMC information.
>  
> +menu "ASPEED eSPI Support"
> +
> +config ASPEED_ESPI
> +	bool "ASPEED eSPI slave driver"

Why this is not tristate?

> +	select REGMAP
> +	select MFD_SYSCON
> +	depends on ASPEED_ESPI_FLASH
> +	default n
> +	help
> +	  Enable driver support for the Aspeed eSPI engine. The eSPI engine
> +	  plays as a slave device in BMC to communicate with the Host over
> +	  the eSPI interface.
> +
> +menu "ASPEED eSPI Flash channel support"

You have way too many menus...

> +
> +config  ASPEED_ESPI_FLASH

This is not used, drop.

> +	bool "ASPEED eSPI flash channel support"
> +	default n
> +	depends on ASPEED_ESPI_FLASH_MAFS
> +	select ASPEED_ESPI
> +	help
> +	  Enable eSPI flash channel support.
> +
> +menu "ASPEED eSPI flash modes"
> +
> +config ASPEED_ESPI_FLASH_MAFS
> +	bool "Master attached flash sharing (MAFS) support in eSPI"

Why this is not tristate?


> +	default n
> +	select ASPEED_ESPI_FLASH
> +	help
> +	  Select this option if you have a Master attached flash connected to
> +	  the eSPI controller.
> +
> +endmenu # eSPI Flash Modes
> +endmenu # eSPI Flash Channel support
> +endmenu # eSPI Support
> +
> +
>  endmenu
>  
>  endif
> diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
> index b35d74592964..cecbba700071 100644
> --- a/drivers/soc/aspeed/Makefile
> +++ b/drivers/soc/aspeed/Makefile
> @@ -4,3 +4,5 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)		+= aspeed-lpc-snoop.o
>  obj-$(CONFIG_ASPEED_UART_ROUTING)	+= aspeed-uart-routing.o
>  obj-$(CONFIG_ASPEED_P2A_CTRL)		+= aspeed-p2a-ctrl.o
>  obj-$(CONFIG_ASPEED_SOCINFO)		+= aspeed-socinfo.o
> +obj-$(CONFIG_ASPEED_ESPI)               += aspeed-espi-ctrl.o
> +obj-$(CONFIG_ASPEED_ESPI_FLASH_MAFS)    += aspeed-espi-flash-mafs.o

Why did you put spi drivers in soc? SPI drivers usually go to spi, don't
they?



> diff --git a/drivers/soc/aspeed/aspeed-espi-ctrl.c b/drivers/soc/aspeed/aspeed-espi-ctrl.c
> new file mode 100644
> index 000000000000..7e2b86849fd0
> --- /dev/null
> +++ b/drivers/soc/aspeed/aspeed-espi-ctrl.c
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 Aspeed Technology Inc.
> + */
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/miscdevice.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/uaccess.h>
> +#include <linux/vmalloc.h>
> +
> +#include "aspeed-espi-ctrl.h"
> +#include "aspeed-espi-flash.h"
> +
> +/**

No need for kerneldoc for private functions.

> + * aspeed_espi_ctrl_isr - function to handle various interrupts
> + * @irq: interrupt line
> + * @arg: pointer to access device registers
> + *
> + * Returns IRQ_HANDLED
> + */
> +static irqreturn_t aspeed_espi_ctrl_isr(int irq, void *arg)
> +{
> +	uint32_t sts;
> +	struct aspeed_espi_ctrl *espi_ctrl = (struct aspeed_espi_ctrl *)arg;
> +
> +	regmap_read(espi_ctrl->map, ESPI_INT_STS, &sts);
> +
> +	if (sts & ESPI_INT_STS_FLASH_BITS) {
> +		aspeed_espi_flash_event(sts, espi_ctrl->flash);
> +		regmap_write(espi_ctrl->map, ESPI_INT_STS,
> +			     sts & ESPI_INT_STS_FLASH_BITS);
> +	}
> +
> +	if (sts & ESPI_INT_STS_HW_RST_DEASSERT) {
> +		aspeed_espi_flash_enable(espi_ctrl->flash);
> +
> +		regmap_write(espi_ctrl->map, ESPI_SYSEVT_INT_T0, 0x0);
> +		regmap_write(espi_ctrl->map, ESPI_SYSEVT_INT_T1, 0x0);
> +		regmap_write(espi_ctrl->map, ESPI_SYSEVT_INT_EN, 0xffffffff);
> +
> +		regmap_write(espi_ctrl->map, ESPI_SYSEVT1_INT_T0, 0x1);
> +		regmap_write(espi_ctrl->map, ESPI_SYSEVT1_INT_EN, 0x1);
> +
> +		regmap_update_bits(espi_ctrl->map, ESPI_INT_EN,
> +				   ESPI_INT_EN_HW_RST_DEASSERT,
> +				   ESPI_INT_EN_HW_RST_DEASSERT);
> +
> +		regmap_update_bits(
> +			espi_ctrl->map, ESPI_SYSEVT,
> +			ESPI_SYSEVT_SLV_BOOT_STS | ESPI_SYSEVT_SLV_BOOT_DONE,
> +			ESPI_SYSEVT_SLV_BOOT_STS | ESPI_SYSEVT_SLV_BOOT_DONE);
> +
> +		regmap_write(espi_ctrl->map, ESPI_INT_STS,
> +			     ESPI_INT_STS_HW_RST_DEASSERT);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * aspeed_espi_ctrl_probe - function to probe the platform driver
> + * @pdev: platform device
> + *
> + * Returns 0 on success, -ENOMEM on error

Drop useless kerneldoc / entire function comment. That's just probe...

> + */
> +static int aspeed_espi_ctrl_probe(struct platform_device *pdev)
> +{
> +	int rc = 0;
> +	struct aspeed_espi_ctrl *espi_ctrl;
> +	struct device *dev = &pdev->dev;
> +
> +	espi_ctrl = devm_kzalloc(dev, sizeof(*espi_ctrl), GFP_KERNEL);
> +	if (!espi_ctrl)
> +		return -ENOMEM;
> +
> +	espi_ctrl->model = of_device_get_match_data(dev);
> +
> +	espi_ctrl->map = syscon_node_to_regmap(dev->parent->of_node);
> +	if (IS_ERR(espi_ctrl->map)) {
> +		dev_err(dev, "cannot get remap\n");
> +		return PTR_ERR(espi_ctrl->map);

return dev_err_probe

> +	}
> +
> +	espi_ctrl->irq = platform_get_irq(pdev, 0);
> +	if (espi_ctrl->irq < 0)
> +		return espi_ctrl->irq;
> +
> +	espi_ctrl->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(espi_ctrl->clk)) {
> +		dev_err(dev, "cannot get clock\n");
> +		return PTR_ERR(espi_ctrl->clk);

return dev_err_probe

> +	}
> +
> +	rc = clk_prepare_enable(espi_ctrl->clk);
> +	if (rc) {
> +		dev_err(dev, "cannot enable clock\n");
> +		return rc;
> +	}
> +
> +	/*
> +	 * This takes care of deferred probe , incase the mtd core
> +	 * subsystem is not probed yet.
> +	 */
> +	espi_ctrl->flash = aspeed_espi_flash_alloc(dev, espi_ctrl);
> +	if (IS_ERR(espi_ctrl->flash)) {
> +		dev_err(dev, "failed to allocate flash channel\n");
> +		pr_info("flash alloc failed with return code %ld\n",
> +			PTR_ERR(espi_ctrl->flash));

Please clean up the code. Drop.

> +		return PTR_ERR(espi_ctrl->flash);
> +	}
> +
> +	regmap_write(espi_ctrl->map, ESPI_SYSEVT_INT_T0, 0x0);
> +	regmap_write(espi_ctrl->map, ESPI_SYSEVT_INT_T1, 0x0);
> +	regmap_write(espi_ctrl->map, ESPI_SYSEVT_INT_EN, 0xffffffff);
> +
> +	regmap_write(espi_ctrl->map, ESPI_SYSEVT1_INT_T0, 0x1);
> +	regmap_write(espi_ctrl->map, ESPI_SYSEVT1_INT_EN, 0x1);
> +
> +	rc = devm_request_irq(dev, espi_ctrl->irq, aspeed_espi_ctrl_isr, 0,
> +			      DEVICE_NAME, espi_ctrl);
> +	if (rc) {
> +		dev_err(dev, "failed to request IRQ\n");
> +		return rc;
> +	}
> +
> +	// clear the interrupt enable register
> +	regmap_write(espi_ctrl->map, ESPI_INT_EN_CLR, 0x7fffffff);
> +
> +	// Disable the interrupts in all channels except flash channel
> +	regmap_update_bits(espi_ctrl->map, ESPI_INT_EN,
> +			   ESPI_INT_EN_FLASH_BITS | ESPI_INT_EN_HW_RST_DEASSERT,
> +			   ESPI_INT_EN_FLASH_BITS |
> +				   ESPI_INT_STS_HW_RST_DEASSERT);

Why do you first request interrupt and then disable them? What if it
fires earlier?

> +
> +	dev_set_drvdata(dev, espi_ctrl);
> +
> +	dev_info(dev, "module loaded\n");

No, drop such simple function success statements.
> +
> +	return 0;
> +}
> +
> +/**
> + * aspeed_espi_ctrl_remove - Release the driver
> + * @pdev: the platform device
> + *
> + * Returns 0
> + */

Drop entire comment, useless.


..

> +
> +void *aspeed_espi_flash_alloc(struct device *dev,
> +			      struct aspeed_espi_ctrl *espi_ctrl)
> +{
> +	int ret, index;
> +	struct aspeed_espi_flash_dma *dma;
> +	struct mtd_info *mtd;
> +	struct aspeed_espi_flash *espi_flash;
> +	struct resource res;
> +	u32 reg;
> +
> +	espi_flash =
> +		devm_kzalloc(dev, sizeof(struct aspeed_espi_flash), GFP_KERNEL);

sizeof(*)

> +	if (!espi_flash)
> +		return ERR_PTR(-ENOMEM);
> +
> +	espi_flash->ctrl = espi_ctrl;
> +
> +	/* Bus lock */
> +	mutex_init(&espi_flash->lock);
> +
> +	init_waitqueue_head(&espi_flash->wq);
> +
> +	spin_lock_init(&espi_flash->spinlock);
> +
> +	dma = &espi_flash->dma;
> +
> +	dma->tx_virt =
> +		dma_alloc_coherent(dev, PAGE_SIZE, &dma->tx_addr, GFP_KERNEL);

Wrong wrapping.

> +	if (!dma->tx_virt) {
> +		dev_err(dev, "cannot allocate DMA TX buffer\n");

Do not print anything on allocation failures.

> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	dma->rx_virt =
> +		dma_alloc_coherent(dev, PAGE_SIZE, &dma->rx_addr, GFP_KERNEL);
> +	if (!dma->rx_virt) {
> +		dev_err(dev, "cannot allocate DMA RX buffer\n");

Drop

> +		return ERR_PTR(-ENOMEM);
> +	}
> +	index = of_property_match_string(dev->of_node, "reg-names",
> +					 "espi_flash");
> +	ret = of_address_to_resource(dev->of_node, index, &res);

Why such unusual code? Why you cannot just map the io space?

> +	if (ret < 0) {
> +		dev_err(dev,
> +			"Could not find espi_flash resource block size in devtree\n");
> +		return ERR_PTR(-ENODEV);
> +	}
> +	reg = resource_size(&res);
> +	mtd = &espi_flash->mtd;
> +	mtd->dev.parent = dev;
> +	mtd->size = reg;
> +	mtd->flags = MTD_CAP_NORFLASH;
> +	mtd->_erase = aspeed_espi_flash_erase;
> +	mtd->_read = aspeed_espi_flash_read;
> +	mtd->_write = aspeed_espi_flash_write;
> +	mtd->type = MTD_NORFLASH;
> +	mtd->name = "espi-flash-mafs";
> +
> +	regmap_read(espi_ctrl->map, ESPI_CH3_CAP_N_CONF, &reg);
> +	reg = (reg & ESPI_CH3_CAP_N_CONF_ERASE_MASK) >>
> +	      ESPI_CH3_CAP_N_CONF_ERASE_SHIFT;
> +	espi_flash->erase_mask = reg;
> +	switch (reg) {
> +	case ESPI_CH3_CAP_N_CONF_ERASE_SIZE_4KB:
> +	case ESPI_CH3_CAP_N_CONF_ERASE_SIZE_4KB_64KB:
> +		mtd->erasesize = 0x1000;
> +		espi_flash->erase_mask = 1;
> +		break;
> +	case ESPI_CH3_CAP_N_CONF_ERASE_SIZE_64KB:
> +		mtd->erasesize = 0x10000;
> +		break;
> +	case ESPI_CH3_CAP_N_CONF_ERASE_SIZE_128KB:
> +		mtd->erasesize = 0x20000;
> +		break;
> +	case ESPI_CH3_CAP_N_CONF_ERASE_SIZE_256KB:
> +		mtd->erasesize = 0x40000;
> +		break;
> +	default:
> +		dev_notice(dev, "Unknown erase size %x\n", reg);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	mtd->writesize = 1;
> +	mtd->owner = THIS_MODULE;
> +	mtd->priv = espi_flash;
> +
> +	ret = mtd_device_register(mtd, NULL, 0);
> +	if (ret) {
> +		dev_notice(dev, "aspeed-espi-mtd: Failed to register mtd device\n");
> +		return ERR_PTR(ret);
> +	}
> +
> +	aspeed_espi_flash_enable(espi_flash);
> +	return espi_flash;
> +}

Missing export as GPL


> +
> +void aspeed_espi_flash_free(struct device *dev,
> +			    struct aspeed_espi_flash *espi_flash)
> +{
> +	struct aspeed_espi_flash_dma *dma = &espi_flash->dma;
> +
> +	dma_free_coherent(dev, PAGE_SIZE, dma->tx_virt, dma->tx_addr);
> +	dma_free_coherent(dev, PAGE_SIZE, dma->rx_virt, dma->rx_addr);
> +
> +	mtd_device_unregister(&espi_flash->mtd);
> +}

Missing export as GPL




Best regards,
Krzysztof


