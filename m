Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F487C887A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjJMPUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjJMPUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:20:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0F3DD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:20:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9be1ee3dc86so23743166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697210414; x=1697815214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GLjqW8MQlPfxIHOeZ/jgZ5+mBDjCMR3Z1xMvLF7yrI4=;
        b=JFZK1XZrHyyR23RIKGHLe/7gJFT2u2A/TpavS4YtyMqZipw5fovgzhyXCcz57qAcJH
         4j79K8MDc05qbSyXnWQkhAVuYbQgF4HeZnk/ISK3S2JNmEDz5/VoL/KGXEQkfRmizNJ7
         WYA+4nk9uZf14DSCYq+zyHf/CzG2ShDSFlOO8yYXD0/9BzFVsxIKJg8YyrMNAKKGUnRQ
         hLr1wusRCyWcYJIayEPxLtwKUjBunP658lfVUQMcLicvk8DN6L8W8pTqlay9KBH2Xawf
         y/4cnqmchPd7thYZmffTWk6dOrEAgKlJfpY8iP4BPpb5MQ96nqc+rmlgbNmzO/S/0eHE
         uPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697210414; x=1697815214;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GLjqW8MQlPfxIHOeZ/jgZ5+mBDjCMR3Z1xMvLF7yrI4=;
        b=HcFFnNIDFv8BRxAc2467lpImcgZCcUz4sq529TZnaf4sElF1j8I0+act7tWSnl/hGs
         l4avJFglNydCDrZHIPueoXVYpqL6NIGzrJa7urSSOEcKj7esoKofcM7dHne4O/UA5XJV
         KN+GWUom5fyL4b01f4Xhjk/d0ewjl/Dsm4vM+kvqgvluBVV5yf3QYpxJwIhbGzRZ53iv
         ljIQjQcqTyTHeJ5R+2yOaopnGAIqQm8Yc2nlpvmEKvccGfih1LY9zxe0KU4b+OgS+76A
         tA+Gx0RwbL3TB19jFIaGLa36QfALjG7yFgH65AZLpuSo1QmFTeOfg/+Z2zt71pU0D8LD
         OVvg==
X-Gm-Message-State: AOJu0Yz43SvlVdWl3h8SeV0r7aaQlo/TzDbhByGjM4OU6pR9vtF2A6uQ
        BHs9TYMLkAvymoOflMqcdflQzw==
X-Google-Smtp-Source: AGHT+IHAC3jrVta0zP33yMo86zUj6tK9Y2k1ATmNcU+pPDDHABIEIaMdrs1P088qG4DmXzzxsklN/w==
X-Received: by 2002:a17:906:1d:b0:9ae:505d:310b with SMTP id 29-20020a170906001d00b009ae505d310bmr24504594eja.39.1697210413906;
        Fri, 13 Oct 2023 08:20:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id md19-20020a170906ae9300b009a1a653770bsm12464169ejb.87.2023.10.13.08.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 08:20:13 -0700 (PDT)
Message-ID: <3aed801f-cb11-4306-b588-b1de1405f93f@linaro.org>
Date:   Fri, 13 Oct 2023 17:20:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] w1: Add 1-wire master driver for AMD programmable
 logic IP Core
Content-Language: en-US
To:     Kris Chaplin <kris.chaplin@amd.com>, thomas.delev@amd.com,
        michal.simek@amd.com, robh+dt@kernel.org, conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20231013093109.37165-1-kris.chaplin@amd.com>
 <20231013093109.37165-3-kris.chaplin@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231013093109.37165-3-kris.chaplin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2023 11:30, Kris Chaplin wrote:
> Add a master driver to support the AMD 1-Wire programmable logic IP block.
> This block guarantees protocol timing for driving off-board devices such
> as thermal sensors, proms, etc.
> 
> Add file to MAINTAINERS
> 
> Co-developed-by: Thomas Delev <thomas.delev@amd.com>
> Signed-off-by: Thomas Delev <thomas.delev@amd.com>
> Signed-off-by: Kris Chaplin <kris.chaplin@amd.com>
> ---
>  MAINTAINERS                 |   1 +
>  drivers/w1/masters/Kconfig  |  11 +
>  drivers/w1/masters/Makefile |   1 +
>  drivers/w1/masters/amd_w1.c | 422 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 435 insertions(+)
>  create mode 100644 drivers/w1/masters/amd_w1.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6ec3922b256e..7f26dab5261b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1072,6 +1072,7 @@ R:	Thomas Delev <thomas.delev@amd.com>
>  R:	Michal Simek <michal.simek@amd.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/w1/amd,axi-1wire-master.yaml
> +F:	drivers/w1/masters/amd_w1.c
>  
>  AMD XGBE DRIVER
>  M:	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>
> diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
> index ad316573288a..9232fd1f4e5b 100644
> --- a/drivers/w1/masters/Kconfig
> +++ b/drivers/w1/masters/Kconfig
> @@ -67,5 +67,16 @@ config W1_MASTER_SGI
>  	  This support is also available as a module.  If so, the module
>  	  will be called sgi_w1.
>  
> +config W1_MASTER_AMD

This looks oddly places. Isn't entry above 'S', so A should go before?
The rule is for entire Linux kernel: do not stuff things to the end of
the lists.

> +	tristate "AMD AXI 1-wire bus master"
> +	help
> +	  Say Y here is you want to support the AMD AXI 1-wire IP core.
> +	  This driver makes use of the programmable logic IP to perform
> +	  correctly timed 1 wire transactions without relying on GPIO timing
> +	  through the kernel.
> +
> +	  This driver can also be built as a module.  If so, the module will be
> +	  called amd_w1.
> +
>  endmenu
>  
> diff --git a/drivers/w1/masters/Makefile b/drivers/w1/masters/Makefile
> index c5d85a827e52..cd3da1daaf97 100644
> --- a/drivers/w1/masters/Makefile
> +++ b/drivers/w1/masters/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_W1_MASTER_MXC)		+= mxc_w1.o
>  obj-$(CONFIG_W1_MASTER_GPIO)		+= w1-gpio.o
>  obj-$(CONFIG_HDQ_MASTER_OMAP)		+= omap_hdq.o
>  obj-$(CONFIG_W1_MASTER_SGI)		+= sgi_w1.o
> +obj-$(CONFIG_W1_MASTER_AMD)		+= amd_w1.o
> diff --git a/drivers/w1/masters/amd_w1.c b/drivers/w1/masters/amd_w1.c
> new file mode 100644
> index 000000000000..04bf08c1b6d7
> --- /dev/null
> +++ b/drivers/w1/masters/amd_w1.c
> @@ -0,0 +1,422 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * amd_w1 - AMD 1Wire bus master driver
> + *
> + * Copyright (C) 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/types.h>
> +#include <linux/wait.h>
> +
> +#include <linux/w1.h>
> +
> +/* 1-wire AMD IP definition */
> +#define AXIW1_IPID	0x10ee4453
> +/* Registers offset */
> +#define AXIW1_INST_REG	0x0
> +#define AXIW1_CTRL_REG	0x4
> +#define AXIW1_IRQE_REG	0x8
> +#define AXIW1_STAT_REG	0xC
> +#define AXIW1_DATA_REG	0x10
> +#define AXIW1_IPVER_REG	0x18
> +#define AXIW1_IPID_REG	0x1C
> +/* Instructions */
> +#define AXIW1_INITPRES	0x0800
> +#define AXIW1_READBIT	0x0C00
> +#define AXIW1_WRITEBIT	0x0E00
> +#define AXIW1_READBYTE	0x0D00
> +#define AXIW1_WRITEBYTE	0x0F00
> +/* Status flag masks */
> +#define AXIW1_DONE	BIT(0)
> +#define AXIW1_READY	BIT(4)
> +#define AXIW1_PRESENCE	BIT(31)
> +#define AXIW1_MAJORVER_MASK	GENMASK(23, 8)
> +#define AXIW1_MINORVER_MASK	GENMASK(7, 0)
> +/* Control flag */
> +#define AXIW1_GO	BIT(0)
> +#define AXI_CLEAR	0
> +#define AXI_RESET	BIT(31)
> +#define AXIW1_READDATA	BIT(0)
> +/* Interrupt Enable */
> +#define AXIW1_READY_IRQ_EN	BIT(4)
> +#define AXIW1_DONE_IRQ_EN	BIT(0)
> +
> +#define AXIW1_TIMEOUT	msecs_to_jiffies(100)
> +
> +#define DRIVER_NAME	"amd_w1"
> +
> +struct amd_w1_local {
> +	struct device *dev;
> +	void __iomem *base_addr;
> +	int irq;
> +	atomic_t flag;

Document what this flag does and what its purpose.

> +	struct clk *clk;

Why do you need this? It's never changed (after fixing the bug).

> +	wait_queue_head_t wait_queue;
> +};
> +
> +/**
> + * amd_w1_write_register() - Helper to write a hardware register.
> + *
> + * @amd_w1_local:	Pointer to device structure
> + * @reg_offset:		Register offset in bytes to write
> + * @val:		Value to write
> + */
> +static inline void amd_w1_write_register(struct amd_w1_local *amd_w1_local,
> +					 u8 reg_offset, u32 val)
> +{
> +	iowrite32(val, amd_w1_local->base_addr + reg_offset);

Unwrapped code:
  iowrite32(IRQ, amd_w1_local->base_addr + AXIW1_IRQE_REG);

Your wrapper:
  amd_w1_write_register(amd_w1_local, AXIW1_IRQE_REG, IRQ);

Does not look simpler. If you want to use wrappers, they should actually
help.

> +};
> +
> +/**
> + * amd_w1_read_register() - Helper to write a hardware register.
> + *
> + * @amd_w1_local:	Pointer to device structure
> + * @reg_offset:		Register offset in bytes to write
> + *
> + * Return:		Value of register read
> + */
> +static inline u32 amd_w1_read_register(struct amd_w1_local *amd_w1_local, u8 reg_offset)
> +{
> +	return ioread32(amd_w1_local->base_addr + reg_offset);
> +};
> +
> +/**
> + * amd_w1_wait_irq_interruptible_timeout() - Wait for IRQ with timeout.
> + *
> + * @amd_w1_local:	Pointer to device structure
> + * @IRQ:		IRQ channel to wait on
> + *
> + * Return:		%0 - OK, %-EINTR - Interrupted, %-EBUSY - Timed out
> + */
> +static inline int amd_w1_wait_irq_interruptible_timeout(struct amd_w1_local *amd_w1_local, u32 IRQ)

Drop inline.
This does not look like wrapped according to Linux coding convention.
Please abide by the convention, so wrap at 80.

> +{
> +	int ret;
> +
> +	/* Enable the IRQ requested and wait for flag to indicate it's been triggered */
> +	amd_w1_write_register(amd_w1_local, AXIW1_IRQE_REG, IRQ);
> +	ret = wait_event_interruptible_timeout(amd_w1_local->wait_queue,
> +					       atomic_read(&amd_w1_local->flag) != 0,
> +					       AXIW1_TIMEOUT);
> +	if (ret < 0) {
> +		dev_err(amd_w1_local->dev, "Wait IRQ Interrupted\n");
> +		return -EINTR;
> +	}
> +
> +	if (!ret) {
> +		dev_err(amd_w1_local->dev, "Wait IRQ Timeout\n");
> +		return -EBUSY;
> +	}
> +
> +	/* Clear flag */

Drop.

> +	atomic_set(&amd_w1_local->flag, 0);
> +	return 0;
> +}
> +
> +/**
> + * amd_w1_touch_bit() - Performs the touch-bit function, which writes a 0 or 1 and reads the level.
> + *
> + * @data:	Pointer to device structure
> + * @bit:	The level to write
> + *
> + * Return:	The level read
> + */
> +static u8 amd_w1_touch_bit(void *data, u8 bit)
> +{
> +	struct amd_w1_local *amd_w1_local = data;
> +	u8 val = 0;
> +	int rc;
> +
> +	/* Wait for READY signal to be 1 to ensure 1-wire IP is ready */
> +	while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_READY) == 0) {
> +		rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_READY_IRQ_EN);
> +		if (rc < 0)
> +			return 1; /* Callee doesn't test for error. Return inactive bus state */
> +	}
> +
> +	if (bit)
> +		/* Read. Write read Bit command in register 0 */
> +		amd_w1_write_register(amd_w1_local, AXIW1_INST_REG, AXIW1_READBIT);
> +	else
> +		/* Write. Write tx Bit command in instruction register with bit to transmit */
> +		amd_w1_write_register(amd_w1_local, AXIW1_INST_REG,
> +				      (AXIW1_WRITEBIT + (bit & 0x01)));
> +
> +	/* Write Go signal and clear control reset signal in control register */
> +	amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXIW1_GO);
> +
> +	/* Wait for done signal to be 1 */
> +	while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_DONE) != 1) {
> +		rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_DONE_IRQ_EN);
> +		if (rc < 0)
> +			return 1; /* Callee doesn't test for error. Return inactive bus state */
> +	}
> +
> +	/* If read, Retrieve data from register */
> +	if (bit)
> +		val = (u8)(amd_w1_read_register(amd_w1_local, AXIW1_DATA_REG) & AXIW1_READDATA);
> +
> +	/* Clear Go signal in register 1 */
> +	amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXI_CLEAR);
> +
> +	return val;
> +}
> +
> +/**
> + * amd_w1_read_byte - Performs the read byte function.
> + *
> + * @data:	Pointer to device structure
> + * Return:	The value read
> + */
> +static u8 amd_w1_read_byte(void *data)
> +{
> +	struct amd_w1_local *amd_w1_local = data;
> +	u8 val = 0;
> +	int rc;
> +
> +	/* Wait for READY signal to be 1 to ensure 1-wire IP is ready */
> +	while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_READY) == 0) {
> +		rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_READY_IRQ_EN);
> +		if (rc < 0)
> +			return 0xFF; /* Return inactive bus state */
> +	}
> +
> +	/* Write read Byte command in instruction register*/
> +	amd_w1_write_register(amd_w1_local, AXIW1_INST_REG, AXIW1_READBYTE);
> +	/* Write Go signal and clear control reset signal in control register */
> +	amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXIW1_GO);
> +
> +	/* Wait for done signal to be 1 */
> +	while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_DONE) != 1) {
> +		rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_DONE_IRQ_EN);
> +		if (rc < 0)
> +			return 0xFF; /* Return inactive bus state */
> +	}
> +
> +	/* Retrieve LSB bit in data register to get RX byte */
> +	val = (u8)(amd_w1_read_register(amd_w1_local, AXIW1_DATA_REG) & 0x000000FF);
> +
> +	/* Clear Go signal in control register */
> +	amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXI_CLEAR);
> +
> +	return val;
> +}
> +
> +/**
> + * amd_w1_write_byte - Performs the write byte function.
> + *
> + * @data:	The ds2482 channel pointer
> + * @val:	The value to write
> + */
> +static void amd_w1_write_byte(void *data, u8 val)
> +{
> +	struct amd_w1_local *amd_w1_local = data;
> +	int rc;
> +
> +	/* Wait for READY signal to be 1 to ensure 1-wire IP is ready */
> +	while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_READY) == 0) {
> +		rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_READY_IRQ_EN);
> +		if (rc < 0)
> +			return;
> +	}
> +
> +	/* Write tx Byte command in instruction register with bit to transmit */
> +	amd_w1_write_register(amd_w1_local, AXIW1_INST_REG, (AXIW1_WRITEBYTE + val));
> +	/* Write Go signal and clear control reset signal in register 1 */
> +	amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXIW1_GO);
> +
> +	/* Wait for done signal to be 1 */
> +	while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_DONE) != 1) {
> +		rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_DONE_IRQ_EN);
> +		if (rc < 0)
> +			return;
> +	}
> +
> +	/* Clear Go signal in control register */
> +	amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXI_CLEAR);
> +}
> +
> +/**
> + * amd_w1_reset_bus() - Issues a reset bus sequence.
> + *
> + * @data:	the bus master data struct
> + * Return:	0=Device present, 1=No device present or error
> + */
> +static u8 amd_w1_reset_bus(void *data)
> +{
> +	struct amd_w1_local *amd_w1_local = data;
> +	u8 val = 0;
> +	int rc;
> +
> +	/* Reset 1-wire Axi IP */
> +	amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXI_RESET);
> +
> +	/* Wait for READY signal to be 1 to ensure 1-wire IP is ready */
> +	while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_READY) == 0) {
> +		rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_READY_IRQ_EN);
> +		if (rc < 0)
> +			return 1; /* Something went wrong with the hardware */
> +	}
> +	/* Write Initialization command in instruction register */
> +	amd_w1_write_register(amd_w1_local, AXIW1_INST_REG, AXIW1_INITPRES);
> +	/* Write Go signal and clear control reset signal in register 1 */
> +	amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXIW1_GO);
> +
> +	/* Wait for done signal to be 1 */
> +	while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_DONE) != 1) {
> +		rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_DONE_IRQ_EN);
> +		if (rc < 0)
> +			return 1; /* Something went wrong with the hardware */
> +	}
> +	/* Retrieve MSB bit in status register to get failure bit */
> +	if ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_PRESENCE) != 0)
> +		val = 1;
> +
> +	/* Clear Go signal in control register */
> +	amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXI_CLEAR);
> +
> +	return val;
> +}
> +
> +/* 1-wire master structure */
> +static struct w1_bus_master amd_w1_master = {

And how does it work with two devices?

> +	.touch_bit	= amd_w1_touch_bit,
> +	.read_byte	= amd_w1_read_byte,
> +	.write_byte	= amd_w1_write_byte,
> +	.reset_bus	= amd_w1_reset_bus,
> +};
> +
> +/* Reset the 1-wire AXI IP. Put the IP in reset state and clear registers */
> +static void amd_w1_reset(struct amd_w1_local *amd_w1_local)
> +{
> +	amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXI_RESET);
> +	amd_w1_write_register(amd_w1_local, AXIW1_INST_REG, AXI_CLEAR);
> +	amd_w1_write_register(amd_w1_local, AXIW1_IRQE_REG, AXI_CLEAR);
> +	amd_w1_write_register(amd_w1_local, AXIW1_STAT_REG, AXI_CLEAR);
> +	amd_w1_write_register(amd_w1_local, AXIW1_DATA_REG, AXI_CLEAR);
> +}
> +
> +static irqreturn_t amd_w1_irq(int irq, void *lp)
> +{
> +	struct amd_w1_local *amd_w1_local = lp;
> +
> +	/* Clear enables in IRQ enable register */

I don't understand this comment.

> +	amd_w1_write_register(amd_w1_local, AXIW1_IRQE_REG, AXI_CLEAR);
> +
> +	/* Wake up the waiting queue */


Drop obvious comments.

> +	atomic_set(&amd_w1_local->flag, 1);
> +	wake_up_interruptible(&amd_w1_local->wait_queue);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int amd_w1_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct amd_w1_local *lp;
> +	u32 ver_major, ver_minor;
> +	int val, rc = 0;
> +
> +	/* Get iospace for the device */

This is memory allocation, not IO space.

> +	lp = devm_kzalloc(dev, sizeof(*lp), GFP_KERNEL);
> +	if (!lp)
> +		return -ENOMEM;
> +
> +	lp->dev = dev;
> +	lp->base_addr = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(lp->base_addr))
> +		return PTR_ERR(lp->base_addr);
> +
> +	/* Get IRQ for the device */

Drop obvious comments.

> +	lp->irq = platform_get_irq(pdev, 0);
> +	if (lp->irq <= 0)

Open platform_get_irq() function and read the help. Error handling
couldn't be more explicit there...

> +		return lp->irq;
> +
> +	rc = devm_request_irq(dev, lp->irq, &amd_w1_irq, IRQF_TRIGGER_HIGH, DRIVER_NAME, lp);
> +	if (rc) {
> +		dev_err(dev, "Could not allocate interrupt %d.\n", lp->irq);

return dev_err_probe(). But this leads us to second question: why would
you notify about allocation errors? Core does it. Do you mean request?

> +		return rc;
> +	}
> +
> +	/* Initialize wait queue and flag */
> +	init_waitqueue_head(&lp->wait_queue);
> +
> +	lp->clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(lp->clk))
> +		return PTR_ERR(lp->clk);
> +
> +	/* Verify IP presence in HW */
> +	if (amd_w1_read_register(lp, AXIW1_IPID_REG) != AXIW1_IPID) {
> +		dev_err(dev, "AMD 1-wire IP not detected in hardware\n");
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * Allow for future driver expansion supporting new hardware features
> +	 * This driver currently only supports hardware 1.x, but include logic
> +	 * to detect if a potentially incompatible future version is used
> +	 * by reading major version ID. It is highly undesirable for new IP versions
> +	 * to break the API, but this code will at least allow for graceful failure
> +	 * should that happen. Future new features can be enabled by hardware
> +	 * incrementing the minor version and augmenting the driver to detect capability
> +	 * using the minor version number
> +	 */
> +	val = amd_w1_read_register(lp, AXIW1_IPVER_REG);
> +	ver_major = FIELD_GET(AXIW1_MAJORVER_MASK, val);
> +	ver_minor = FIELD_GET(AXIW1_MINORVER_MASK, val);
> +
> +	if (ver_major != 1) {
> +		dev_err(dev, "AMD AXI W1 Master version %u.%u is not supported by this driver",
> +			ver_major, ver_minor);
> +		return -ENODEV;
> +	}
> +
> +	amd_w1_master.data = (void *)lp;
> +	amd_w1_reset(lp);
> +
> +	platform_set_drvdata(pdev, lp);
> +	rc = w1_add_master_device(&amd_w1_master);
> +	if (rc) {
> +		dev_err(dev, "Could not add master device\n");
> +		amd_w1_reset(lp);

Why? Does this mean that w1_add_master_device() changes the state of
hardware?

> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static void amd_w1_remove(struct platform_device *pdev)
> +{
> +	struct amd_w1_local *lp = platform_get_drvdata(pdev);
> +
> +	w1_remove_master_device(&amd_w1_master);
> +	clk_disable_unprepare(lp->clk);

This wasn't tested. Duplicated disable.

> +}
> +
> +static const struct of_device_id amd_w1_of_match[] = {
> +	{ .compatible = "amd,axi-1wire-master" },
> +	{ /* end of list */ },
> +};
> +MODULE_DEVICE_TABLE(of, amd_w1_of_match);
> +
> +static struct platform_driver amd_w1_driver = {
> +	.probe = amd_w1_probe,
> +	.remove_new = amd_w1_remove,
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.of_match_table = amd_w1_of_match,
> +	},
> +};
> +module_platform_driver(amd_w1_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Kris Chaplin <kris.chaplin@amd.com>");
> +MODULE_DESCRIPTION("Driver for AMD AXI 1 Wire IP core");

Best regards,
Krzysztof

