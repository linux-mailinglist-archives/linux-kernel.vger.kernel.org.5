Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EBE780B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376629AbjHRLXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376623AbjHRLXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:23:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDDD3AB2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 04:22:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AF11622F3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 11:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5C6C433C7;
        Fri, 18 Aug 2023 11:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692357763;
        bh=esUcxGlLtmLpX0rrWFbXIJUVxro4x8w6QXsOFYvEz+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fljKBfqIdRjLkpKAuOJgCGfwzYNEiVCbiJOELxSggLv/dig9Cic+vseY8tY8v4rSF
         R12U6N45UyCvg/DJum87SxQfcyMYZ3oQ8W4xdjIXUS8JlMyEGlA0QsjG+RLhZ448Um
         Ndt8g1kMhj8OSORIc609NvUp8WefcBTP+6HR7Xu51YFFyw6MSjH/m3+Qiq18tXFjyC
         16/2opZCb2w3+2WVLvd0lZoRwHL6c59H7kYpFlVTY9kE6C8nh+Q9l4nX6ICwVwVV3E
         +QdF0JmWvMcVPpNyI+KV038mMWU8GvH5svpnITKVy3w+Xu6ZkxEVsAGevU2jl3eFjU
         AsPOMMO8KGNhQ==
Date:   Fri, 18 Aug 2023 12:22:39 +0100
From:   Lee Jones <lee@kernel.org>
To:     "Wenkai.Chung" <Wenkai.Chung@advantech.com.tw>
Cc:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Susi.Driver" <Susi.Driver@advantech.com>
Subject: Re: [PATCH] Add a mfd driver to support Advantech EIO-IS200 series
 EC.
Message-ID: <20230818112239.GT986605@google.com>
References: <20230727053655.92525-1-wenkai.chung@advantech.com.tw>
 <ebc6d86e627242a785f75f88623108c6@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebc6d86e627242a785f75f88623108c6@advantech.com.tw>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With respect to the subject, please use this command for examples:

  git log --oneline -- drivers/mfd

On Thu, 27 Jul 2023, Wenkai.Chung wrote:

> Add a mfd driver to support Advantech EIO-IS200 series EC.

Please drop all references to "mfd".  It's not a real thing.

Please tell us all about your driver here.  A one line description is
not appropriate for a 600 line commit.

> Signed-off-by: wenkai.chung <wenkai.chung@advantech.com.tw>
> ---
>  drivers/mfd/Kconfig         |  13 +
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/eiois200.h      | 146 +++++++++++
>  drivers/mfd/eiois200_core.c | 496 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 656 insertions(+)
>  create mode 100644 drivers/mfd/eiois200.h  create mode 100644 drivers/mfd/eiois200_core.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig index 6f5b259a6d6a..ca792a077da9 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -154,6 +154,19 @@ config MFD_ATMEL_HLCDC
>  	  This driver provides common support for accessing the device,
>  	  additional drivers must be enabled in order to use the
>  	  functionality of the device.
> +	  
> + config MFD_EIOIS200
> +	tristate "Advantech EIO-IS200 Embedded Controller core driver"
> +	depends on X86 && m

Depends on m?

> +	default m

Are you sure you want this?

> +	select MFD_CORE
> +	help
> +	  Support for the EIO-IS200 controller.

Which is ...

> +	  This driver provides common support for accessing the device,
> +	  additional drivers must be enabled in order to use the functionality
> +	  of the device.

What will the module be called?

What other devices does this h/w support?

> +

You don't need 2 spaces here.

>  
>  config MFD_ATMEL_SMC
>  	bool
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile index f3d1f1dc73b5..59e911054688 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -276,6 +276,7 @@ obj-$(CONFIG_MFD_INTEL_M10_BMC_PMCI)   += intel-m10-bmc-pmci.o
>  
>  obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
>  obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
> +obj-$(CONFIG_MFD_EIOIS200)	+= eiois200_core.o
>  
>  rsmu-i2c-objs			:= rsmu_core.o rsmu_i2c.o
>  rsmu-spi-objs			:= rsmu_core.o rsmu_spi.o
> diff --git a/drivers/mfd/eiois200.h b/drivers/mfd/eiois200.h new file mode 100644 index 000000000000..24a448d70d00
> --- /dev/null
> +++ b/drivers/mfd/eiois200.h
> @@ -0,0 +1,146 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef _MFD_EIOIS200_H_
> +#define _MFD_EIOIS200_H_

'\n'

> +#include <linux/stddef.h>

What are you using this for?

> +#include <linux/io.h>
> +#include <linux/regmap.h>
> +
> +// Definition

No C++ style comments.

> +#define EIOIS200_CHIPID1				0x20
> +#define EIOIS200_CHIPID2				0x21
> +#define EIOIS200_CHIPVER				0x22
> +#define EIOIS200_SIOCTRL				0x23
> +#define EIOIS200_SIOCTRL_SIOEN				BIT(0)
> +#define EIOIS200_SIOCTRL_SWRST				BIT(1)
> +#define EIOIS200_IRQCTRL				0x70
> +#define EIOIS200_CHIP_ID				0x9610
> +#define EIO201_211_CHIP_ID				0x9620

CHIP_ID or CHIPID, please be consistent.

> +#define EIOIS200_ICCODE					0x10
> +#define EIO201_ICCODE					0x20
> +#define EIO211_ICCODE					0x21
> +
> +// LPC PNP
> +#define EIOIS200_PNP_INDEX				0x299
> +#define EIOIS200_PNP_DATA				0x29A
> +#define EIOIS200_SUB_PNP_INDEX				0x499
> +#define EIOIS200_SUB_PNP_DATA				0x49A
> +#define EIOIS200_EXT_MODE_ENTER				0x87
> +#define EIOIS200_EXT_MODE_EXIT				0xAA
> +
> +// LPC LDN
> +#define EIOIS200_LDN					0x07
> +#define EIOIS200_LDN_PMC0				0x0C
> +#define EIOIS200_LDN_PMC1				0x0D
> +
> +// PMC common registers
> +#define EIOIS200_LDAR					0x30
> +#define EIOIS200_LDAR_LDACT				BIT(0)
> +#define EIOIS200_IOBA0H					0x60
> +#define EIOIS200_IOBA0L					0x61
> +#define EIOIS200_IOBA1H					0x62
> +#define EIOIS200_IOBA1L					0x63
> +#define EIOIS200_PMC_STATUS_IBF				BIT(1)
> +#define EIOIS200_PMC_STATUS_OBF				BIT(0)
> +#define EIOIS200_PMC_PORT				0x2F0
> +
> +// PMC (Power management channel) command list

(Power Management Channel)

Why aren't the abbreviations above expanded out as well?

> +#define EIOIS200_PMC_CMD_WDT_WRITE			0x2A
> +#define EIOIS200_PMC_CMD_WDT_READ			0x2B
> +#define EIOIS200_PMC_CMD_WDT_START			0x2C
> +#define EIOIS200_PMC_CMD_WDT_STOP			0x2D
> +#define EIOIS200_PMC_CMD_WDT_TRIG			0x2E
> +#define EIOIS200_PMC_CMD_ACPIRAM_READ			0x31
> +#define EIOIS200_PMC_CMD_CFG_SAVE			0x56
> +
> +// New PMC command list
> +#define EIOIS200_NEW_PMC_CMD_DOC_FW_READ		0x03
> +#define EIOIS200_NEW_PMC_CMD_SYSTEM_READ		0x55
> +#define EIOIS200_NEW_PMC_CMD_WDT_WRITE			0x2A
> +#define EIOIS200_NEW_PMC_CMD_WDT_READ			0x2B
> +
> +// OLD PMC
> +#define EIOIS200_PMC_NO_INDEX				0xFF
> +
> +// ACPI RAM Address Table
> +#define EIOIS200_ACPIRAM_VERSIONSECTION	(0xFA)
> +#define EIOIS200_ACPIRAM_ICVENDOR	(EIOIS200_ACPIRAM_VERSIONSECTION + 0x00)
> +#define EIOIS200_ACPIRAM_ICCODE		(EIOIS200_ACPIRAM_VERSIONSECTION + 0x01)
> +#define EIOIS200_ACPIRAM_CODEBASE	(EIOIS200_ACPIRAM_VERSIONSECTION + 0x02)
> +
> +/* Firmware **/
> +#define EIOIS200_F_SUB_NEW_CODE_BASE	BIT(6)	// Identity second EC code base version
> +#define EIOIS200_F_SUB_CHANGED		BIT(7)	// Setting second EC changed
> +#define EIOIS200_F_NEW_CODE_BASE	BIT(8)	// Identity code base version
> +#define EIOIS200_F_CHANGED		BIT(9)	// Setting changed
> +#define EIOIS200_F_SUB_CHIP_EXIST	BIT(30)	// Second EIO-IS200 exist
> +#define EIOIS200_F_CHIP_EXIST		BIT(31)	// EIO-IS200 exist
> +
> +/* Others **/

What comment style is this?

> +#define EC_NUM	2
> +
> +struct _pmc_port {
> +	union {
> +		u16 cmd;
> +		u16 status;
> +	};
> +	u16 data;
> +};
> +
> +struct _eiois200_dev_port {
> +	u16 idx;
> +	u16 data;
> +};
> +
> +struct _pmc_op {
> +	u8 cmd;
> +	u8 index;	// use 0xFF to identify PMC command with index or not.
> +	u8 offset;
> +	u8 len;
> +	u8 *data;
> +};
> +
> +struct _pmc_new_op {
> +	u8  cmd;
> +	u8  control;
> +	u8  device_id;
> +	u8  size;
> +	u8  *payload;
> +};
> +
> +enum eiois200_rw_operation {
> +	OPERATION_READ,
> +	OPERATION_WRITE,
> +};
> +
> +struct _eiois200_dev {
> +	u32 flag;
> +
> +	struct _pmc_port  pmc;
> +	struct _pmc_port  pmc1;
> +
> +	struct mutex eiois200_io_mutex;		// mutex lock for eiois200 io access
> +};
> +
> +/* exported symbol */
> +//extern struct _eiois200_dev *eiois200_dev; int 

No commented out code.

> +eiois200_core_pmc_operation(const struct _pmc_port *pmc,
> +				const struct _pmc_op *operation,
> +				enum eiois200_rw_operation rw);
> +
> +int eiois200_core_new_pmc_operation(const struct _pmc_port *pmc,
> +				    const struct _pmc_new_op *operation);
> +
> +int eiois200_core_pmc_wait_ibf(const struct _pmc_port *pmc); int 

Does this even compile?

> +eiois200_core_pmc_wait_obf(const struct _pmc_port *pmc);
> +
> +#define WAIT_IBF(pmc)		eiois200_core_pmc_wait_ibf(pmc)
> +#define WAIT_OBF(pmc)		eiois200_core_pmc_wait_obf(pmc)
> +#define NEW_CODE_BASE		(eiois200_dev->flag & EIOIS200_F_NEW_CODE_BASE)
> +
> +#ifdef pr_fmt
> +#undef pr_fmt
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt #endif

Why do you need this?

> +#endif
> diff --git a/drivers/mfd/eiois200_core.c b/drivers/mfd/eiois200_core.c new file mode 100644 index 000000000000..4be6c8651b6a
> --- /dev/null
> +++ b/drivers/mfd/eiois200_core.c
> @@ -0,0 +1,496 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MFD driver for Advantech EIO-IS200 Embedded controller.
> + *
> + * This driver provides PMC commands interface for subdrivers.
> + *
> + * Copyright (C) 2023 Advantech Corporation. All rights reserved.
> + */
> +
> +#include <linux/uaccess.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +#include <linux/isa.h>

Alphabetical.

> +#include "eiois200.h"
> +
> +static int timeout = 500;

Why 500?  Is this ms or us?

> +module_param(timeout, int, 0);
> +MODULE_PARM_DESC(timeout,
> +		 "IO exponential increased timeout value. (default="
> +		 __MODULE_STRING(timeout) ")");

Do you really need to override this value?

> +struct _eiois200_dev_port eio_pnp_port[EC_NUM] = {
> +	{EIOIS200_PNP_INDEX,	 EIOIS200_PNP_DATA    },
> +	{EIOIS200_SUB_PNP_INDEX, EIOIS200_SUB_PNP_DATA} };

Formatting.

> +struct _eiois200_dev *eiois200_dev;

Why the '_'?

> +struct regmap *regmap_is200;

Why do these need to be global?

> +static struct mfd_cell susi_mfd_devs[] = {
> +	{ .name = "eiois200_wdt"},
> +};

Where are the other devices?

> +/* For regmap */

You don't need this.

> +static int reg_read(void *context, unsigned int reg, unsigned int *val) 

Whitespace at the end of the line.

> +{
> +	*val = inb(reg);

This looks odd.  Surely this basic use-case is catered for elsewhere?

> +	return 0;
> +}
> +
> +static int reg_write(void *context, unsigned int reg, unsigned int val) 
> +{
> +	outb(val, reg);
> +
> +	return 0;
> +}
> +
> +struct regmap_range is200_rang[] = {

range*

> +	{EIOIS200_PNP_INDEX,	 EIOIS200_PNP_DATA	 },

Space after the '{'

> +	{EIOIS200_SUB_PNP_INDEX, EIOIS200_SUB_PNP_DATA	 },
> +	{EIOIS200_PMC_PORT,	 EIOIS200_PMC_PORT + 0x0F},
> +};
> +
> +static const struct regmap_access_table volatile_regs = {
> +	.yes_ranges = is200_rang,
> +	.n_yes_ranges = ARRAY_SIZE(is200_rang), };
> +
> +static const struct regmap_config pnp_regmap_config = {
> +	.reg_bits	= 16,
> +	.val_bits	= 8,
> +	.volatile_table = &volatile_regs,
> +
> +	.reg_write	= reg_write,
> +	.reg_read	= reg_read,
> +};
> +
> +/* For EIO-IS200 pnp io port access */
> +static int is200_pnp_in(const struct _eiois200_dev_port *port, u8 idx) 

Please do a check for whitespace issues everywhere - I see lots.

> +{
> +	int ret;
> +
> +	regmap_write(regmap_is200, port->idx, idx);
> +	regmap_read(regmap_is200, port->data, &ret);

It's not a ret - please use 'value'.

> +
> +	return ret;
> +}
> +
> +static void is200_pnp_out(const struct _eiois200_dev_port *port, u8 
> +idx, u8 data) {

This is an odd place to linewrap - please also tab out to the '('.

> +	regmap_write(regmap_is200, port->idx, idx);
> +	regmap_write(regmap_is200, port->data, data); }
> +
> +static void is200_ext_entry(const struct _eiois200_dev_port *port) {
> +	regmap_write(regmap_is200, port->idx, EIOIS200_EXT_MODE_ENTER);
> +	regmap_write(regmap_is200, port->idx, EIOIS200_EXT_MODE_ENTER); }

Formatting - and throughout.

> +static void eio_ext_leave(const struct _eiois200_dev_port *port) {
> +	regmap_write(regmap_is200, port->idx, EIOIS200_EXT_MODE_EXIT); }
> +
> +/* EIO-IS200 io port access function for pmc command */ static int 

The return type should not be up there.

[...]

I'm going to stop here for now.  Lots to do.

Please make sure you read the documents pointed to from here:

  https://docs.kernel.org/process/5.Posting.html

And run and fix issue alluded to by scripts/checkpatch.pl before reposting.

-- 
Lee Jones [李琼斯]
