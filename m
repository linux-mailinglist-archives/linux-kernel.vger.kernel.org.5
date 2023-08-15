Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C522577D082
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbjHORAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238645AbjHOQ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:59:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7896419AF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:59:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E569065DAD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EA5C433C8;
        Tue, 15 Aug 2023 16:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692118787;
        bh=mLRArd87VCRBloiJX09e0/PI8MM1Zw1DXRlkXwrUeC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bt+I/owqj8GsFNTqU77OHs77q5qkpM9Ahy1SWO2ZEouQ878svwPN2vTIEtrtReBzm
         xZR9LRfi1xFYCoaaIeY9fgq069UnHtvdQqkyFCf91UWGOcygKGyiDWPx0bl2zBcJok
         8DyGwHBT/rM5NfteI1Sa1a5KJOlc2ol8OINJsgeNaaIJlmHUkA8WUf20oa2HOZBqyd
         Xbs3hAe2U2dergbADjItA6l9XuMRIt3ODEYkJ3s4iyOUTtxNUS8POiDWp81hToQS+T
         mZZA9TevTwIqA3Mzd3/YFANZ1DZJRLo7oQ1AFS1ZOr9tp3xrwPnCMTw0hkIDdJoN/e
         0TqnCI5N8tXOA==
Date:   Tue, 15 Aug 2023 17:59:43 +0100
From:   Lee Jones <lee@kernel.org>
To:     "Wenkai.Chung" <Wenkai.Chung@advantech.com.tw>
Cc:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Susi.Driver" <Susi.Driver@advantech.com>
Subject: Re: [PATCH] Add a mfd driver to support Advantech EIO-IS200 series
 EC.
Message-ID: <20230815165943.GB648357@google.com>
References: <20230727053655.92525-1-wenkai.chung@advantech.com.tw>
 <ebc6d86e627242a785f75f88623108c6@advantech.com.tw>
 <3fbfadad386d475f8ecd0dfbc0d91fea@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fbfadad386d475f8ecd0dfbc0d91fea@advantech.com.tw>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023, Wenkai.Chung wrote:

> Hi Jones,
> 
> I am writing to follow up on the email and patch I sent you on July 27th. 
> Did you receive the patch? I appreciate your response.

I have the patch.  It's in my queue.

> -----Original Message-----
> From: Wenkai.Chung 
> Sent: Thursday, July 27, 2023 1:43 PM
> To: 'Lee Jones' <lee@kernel.org>; 'linux-kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>
> Cc: Susi.Driver <Susi.Driver@advantech.com>
> Subject: [PATCH] Add a mfd driver to support Advantech EIO-IS200 series EC.
> 
> 
> Add a mfd driver to support Advantech EIO-IS200 series EC.
> 
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
> +	default m
> +	select MFD_CORE
> +	help
> +	  Support for the EIO-IS200 controller.
> +
> +	  This driver provides common support for accessing the device,
> +	  additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +
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
> +#include <linux/stddef.h>
> +#include <linux/io.h>
> +#include <linux/regmap.h>
> +
> +// Definition
> +#define EIOIS200_CHIPID1				0x20
> +#define EIOIS200_CHIPID2				0x21
> +#define EIOIS200_CHIPVER				0x22
> +#define EIOIS200_SIOCTRL				0x23
> +#define EIOIS200_SIOCTRL_SIOEN				BIT(0)
> +#define EIOIS200_SIOCTRL_SWRST				BIT(1)
> +#define EIOIS200_IRQCTRL				0x70
> +#define EIOIS200_CHIP_ID				0x9610
> +#define EIO201_211_CHIP_ID				0x9620
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
> +eiois200_core_pmc_operation(const struct _pmc_port *pmc,
> +				const struct _pmc_op *operation,
> +				enum eiois200_rw_operation rw);
> +
> +int eiois200_core_new_pmc_operation(const struct _pmc_port *pmc,
> +				    const struct _pmc_new_op *operation);
> +
> +int eiois200_core_pmc_wait_ibf(const struct _pmc_port *pmc); int 
> +eiois200_core_pmc_wait_obf(const struct _pmc_port *pmc);
> +
> +#define WAIT_IBF(pmc)		eiois200_core_pmc_wait_ibf(pmc)
> +#define WAIT_OBF(pmc)		eiois200_core_pmc_wait_obf(pmc)
> +#define NEW_CODE_BASE		(eiois200_dev->flag & EIOIS200_F_NEW_CODE_BASE)
> +
> +#ifdef pr_fmt
> +#undef pr_fmt
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt #endif
> +
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
> +#include "eiois200.h"
> +
> +static int timeout = 500;
> +module_param(timeout, int, 0);
> +MODULE_PARM_DESC(timeout,
> +		 "IO exponential increased timeout value. (default="
> +		 __MODULE_STRING(timeout) ")");
> +
> +struct _eiois200_dev_port eio_pnp_port[EC_NUM] = {
> +	{EIOIS200_PNP_INDEX,	 EIOIS200_PNP_DATA    },
> +	{EIOIS200_SUB_PNP_INDEX, EIOIS200_SUB_PNP_DATA} };
> +
> +struct _eiois200_dev *eiois200_dev;
> +struct regmap *regmap_is200;
> +
> +static struct mfd_cell susi_mfd_devs[] = {
> +	{ .name = "eiois200_wdt"},
> +};
> +
> +/* For regmap */
> +static int reg_read(void *context, unsigned int reg, unsigned int *val) 
> +{
> +	*val = inb(reg);
> +
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
> +	{EIOIS200_PNP_INDEX,	 EIOIS200_PNP_DATA	 },
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
> +{
> +	int ret;
> +
> +	regmap_write(regmap_is200, port->idx, idx);
> +	regmap_read(regmap_is200, port->data, &ret);
> +
> +	return ret;
> +}
> +
> +static void is200_pnp_out(const struct _eiois200_dev_port *port, u8 
> +idx, u8 data) {
> +	regmap_write(regmap_is200, port->idx, idx);
> +	regmap_write(regmap_is200, port->data, data); }
> +
> +static void is200_ext_entry(const struct _eiois200_dev_port *port) {
> +	regmap_write(regmap_is200, port->idx, EIOIS200_EXT_MODE_ENTER);
> +	regmap_write(regmap_is200, port->idx, EIOIS200_EXT_MODE_ENTER); }
> +
> +static void eio_ext_leave(const struct _eiois200_dev_port *port) {
> +	regmap_write(regmap_is200, port->idx, EIOIS200_EXT_MODE_EXIT); }
> +
> +/* EIO-IS200 io port access function for pmc command */ static int 
> +pmc_out_data(const struct _pmc_port *pmc, u8 value) {
> +	if (WAIT_IBF(pmc))
> +		return -ETIME;
> +
> +	regmap_write(regmap_is200, pmc->data, value);
> +
> +	return 0;
> +}
> +
> +static int pmc_out_cmd(const struct _pmc_port *pmc, u8 value) {
> +	if (WAIT_IBF(pmc))
> +		return -ETIME;
> +
> +	regmap_write(regmap_is200, pmc->cmd, value);
> +
> +	return 0;
> +}
> +
> +static int pmc_in_data(const struct _pmc_port *pmc, u8 *value) {
> +	int val;
> +
> +	if (WAIT_OBF(pmc))
> +		return -ETIME;
> +
> +	regmap_read(regmap_is200, pmc->data, &val);
> +
> +	*value = val & 0xFF;
> +
> +	return 0;
> +}
> +
> +static int pmc_in_status(const struct _pmc_port *pmc) {
> +	int val;
> +
> +	regmap_read(regmap_is200, pmc->data, &val);
> +
> +	return val;
> +}
> +
> +static void pmc_clear(const struct _pmc_port *pmc) {
> +	int val;
> +
> +	/* Read out previous garbage if needed */
> +	if (pmc_in_status(pmc) & EIOIS200_PMC_STATUS_IBF)
> +		regmap_read(regmap_is200, pmc->data, &val); }
> +
> +/* Wait input buffer clear */
> +int eiois200_core_pmc_wait_ibf(const struct _pmc_port *pmc) {
> +	u32 time;
> +	unsigned int val;
> +
> +	for (time = 0 ; time < timeout ; time++) {
> +		regmap_read(regmap_is200, pmc->status, &val);
> +		if ((val & EIOIS200_PMC_STATUS_IBF) == 0)
> +			return 0;
> +
> +		/* incremental delay */
> +		if (time * 10 < 1000)
> +			ndelay(time * 10);
> +		else
> +			msleep(time / 100);
> +	}
> +
> +	/* over 0.5 s */
> +	return -ETIME;
> +}
> +EXPORT_SYMBOL(eiois200_core_pmc_wait_ibf);
> +
> +/* Wait output buffer filled */
> +int eiois200_core_pmc_wait_obf(const struct _pmc_port *pmc) {
> +	u32 time;
> +	unsigned int val;
> +
> +	for (time = 0 ; time < timeout ; time++) {
> +		regmap_read(regmap_is200, pmc->status, &val);
> +		if ((val & EIOIS200_PMC_STATUS_OBF))
> +			return 0;
> +
> +		/* incremental delay */
> +		if (time * 10 < 1000)
> +			ndelay(time * 10);
> +		else
> +			msleep(time / 100);
> +	}
> +
> +	/* over 0.5 s */
> +	return -ETIME;
> +}
> +EXPORT_SYMBOL(eiois200_core_pmc_wait_obf);
> +
> +/* Execute a old pmc (power management channel) command */ int 
> +eiois200_core_pmc_operation(const struct _pmc_port *pmc,
> +				const struct _pmc_op *op,
> +				enum eiois200_rw_operation rw)
> +{
> +	bool read_cmd = rw == OPERATION_READ;
> +	bool has_index = op->index == EIOIS200_PMC_NO_INDEX;
> +
> +	mutex_lock(&eiois200_dev->eiois200_io_mutex);
> +
> +	if (rw != OPERATION_READ && rw != OPERATION_WRITE)
> +		return -EINVAL;
> +
> +	pmc_clear(pmc);
> +
> +	if (pmc_out_cmd(pmc, op->cmd))
> +		goto exit;
> +
> +	if (has_index && pmc_out_data(pmc, op->index))
> +		goto exit;
> +
> +	if (pmc_out_data(pmc, op->offset) ||
> +	    pmc_out_data(pmc, op->len))
> +		goto exit;
> +
> +	for (u8 i = 0 ; i < op->len ; i++)
> +		if (read_cmd) {
> +			if (pmc_in_data(pmc, &op->data[i]))
> +				goto exit;
> +		} else {
> +			if (pmc_out_data(pmc, op->data[i]))
> +				goto exit;
> +		}
> +
> +	mutex_unlock(&eiois200_dev->eiois200_io_mutex);
> +	return 0;
> +
> +exit:
> +	mutex_unlock(&eiois200_dev->eiois200_io_mutex);
> +	return -ETIME;
> +}
> +EXPORT_SYMBOL(eiois200_core_pmc_operation);
> +
> +/* Execute a new pmc command (fixed length) */ int 
> +eiois200_core_new_pmc_operation(const struct _pmc_port *pmc, const 
> +struct _pmc_new_op *op) {
> +	bool read_cmd = op->cmd & 0x01;
> +
> +	mutex_lock(&eiois200_dev->eiois200_io_mutex);
> +
> +	pmc_clear(pmc);
> +
> +	if (pmc_out_cmd(pmc, op->cmd)	     ||
> +	    pmc_out_data(pmc, op->control)   ||
> +	    pmc_out_data(pmc, op->device_id) ||
> +	    pmc_out_data(pmc, op->size))
> +		goto exit;
> +
> +	for (u8 i = 0 ; i < op->size ; i++)
> +		if (read_cmd) {
> +			if (pmc_in_data(pmc, &op->payload[i]))
> +				goto exit;
> +		} else {
> +			if (pmc_out_data(pmc, op->payload[i]))
> +				goto exit;
> +		}
> +
> +	mutex_unlock(&eiois200_dev->eiois200_io_mutex);
> +	return 0;
> +
> +exit:
> +	mutex_unlock(&eiois200_dev->eiois200_io_mutex);
> +	return -ETIME;
> +}
> +EXPORT_SYMBOL(eiois200_core_new_pmc_operation);
> +
> +static int get_pmc_port(void)
> +{
> +	u8 i = 0;
> +
> +	mutex_lock(&eiois200_dev->eiois200_io_mutex);
> +
> +	for (i = 0 ; i < EC_NUM ; i++) {
> +		struct _eiois200_dev_port *port = eio_pnp_port + i;
> +		struct _pmc_port *pmc_ptr = i == 0 ? &eiois200_dev->pmc : 
> +&eiois200_dev->pmc1;
> +
> +		is200_ext_entry(port);
> +
> +		/* Switch to PMC device */
> +		is200_pnp_out(port, EIOIS200_LDN, EIOIS200_LDN_PMC1);
> +
> +		/* Active device */
> +		is200_pnp_out(port, EIOIS200_LDAR, EIOIS200_LDAR_LDACT);
> +
> +		/* Get PMC base port address */
> +		pmc_ptr->data  = is200_pnp_in(port, EIOIS200_IOBA0H) << 8;
> +		pmc_ptr->data |= is200_pnp_in(port, EIOIS200_IOBA0L);
> +		pmc_ptr->cmd   = is200_pnp_in(port, EIOIS200_IOBA1H) << 8;
> +		pmc_ptr->cmd  |= is200_pnp_in(port, EIOIS200_IOBA1L);
> +
> +		/* Disable IRQ */
> +		is200_pnp_out(port, EIOIS200_IRQCTRL, 0);
> +
> +		eio_ext_leave(port);
> +
> +		if ((eiois200_dev->flag & EIOIS200_F_SUB_CHIP_EXIST) == 0)
> +			break;
> +	}
> +
> +	mutex_unlock(&eiois200_dev->eiois200_io_mutex);
> +
> +	return 0;
> +}
> +
> +static int eiois200_exist(void)
> +{
> +	u16 chipid = 0;
> +	u8  tmp = 0, i = 0;
> +
> +	for (i = 0 ; i < EC_NUM ; i++) {
> +		struct _eiois200_dev_port *port = eio_pnp_port + i;
> +
> +		is200_ext_entry(port);
> +
> +		chipid  = is200_pnp_in(port, EIOIS200_CHIPID1) << 8;
> +		chipid |= is200_pnp_in(port, EIOIS200_CHIPID2);
> +
> +		if (chipid == EIOIS200_CHIP_ID || chipid == EIO201_211_CHIP_ID) {
> +			/* Enable SIO devices */
> +			pr_info("chipID = 0x%X\n", chipid);
> +			tmp = is200_pnp_in(port, EIOIS200_SIOCTRL);
> +			tmp |= EIOIS200_SIOCTRL_SIOEN;
> +			is200_pnp_out(port, EIOIS200_SIOCTRL, tmp);
> +
> +			eiois200_dev->flag |= EIOIS200_F_CHIP_EXIST;
> +
> +			if (port->data == EIOIS200_SUB_PNP_DATA)
> +				eiois200_dev->flag |= EIOIS200_F_SUB_CHIP_EXIST;
> +
> +			get_pmc_port();
> +
> +			eio_ext_leave(port);
> +			return 0;
> +		}
> +
> +		eio_ext_leave(port);
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +/* read information of acpi store in EC */ static uint8_t 
> +acpiram_access(const struct _pmc_port *pmc, uint8_t acpi_ram_address) {
> +	u8 ret;
> +
> +	mutex_lock(&eiois200_dev->eiois200_io_mutex);
> +
> +	/* clear previous garbage */
> +	pmc_clear(pmc);
> +	msleep(1);
> +
> +	/* procedure for read data */
> +	if (pmc_out_cmd(pmc, EIOIS200_PMC_CMD_ACPIRAM_READ) ||
> +	    pmc_out_data(pmc, acpi_ram_address)	||
> +	    pmc_out_data(pmc, 1) ||
> +	    pmc_in_data(pmc, &ret)) {
> +		/* return 0 for error */
> +		mutex_unlock(&eiois200_dev->eiois200_io_mutex);
> +		return 0;
> +	}
> +
> +	mutex_unlock(&eiois200_dev->eiois200_io_mutex);
> +	return ret;
> +}
> +
> +static int firmware_code_base(struct device *dev,
> +			      const struct _pmc_port *pmc)
> +{
> +	u8 ic_vendor, ic_code, code_base;
> +
> +	ic_vendor = acpiram_access(pmc, EIOIS200_ACPIRAM_ICVENDOR);
> +	ic_code   = acpiram_access(pmc, EIOIS200_ACPIRAM_ICCODE);
> +	code_base = acpiram_access(pmc, EIOIS200_ACPIRAM_CODEBASE);
> +
> +	if (ic_vendor != 'R')
> +		goto exit;
> +
> +	if (ic_code != EIOIS200_ICCODE &&
> +	    ic_code != EIO201_ICCODE   &&
> +	    ic_code != EIO211_ICCODE)
> +		goto exit;
> +
> +	if (code_base == 0x80) {
> +		eiois200_dev->flag |= EIOIS200_F_NEW_CODE_BASE;
> +		return 0;
> +	}
> +
> +	if (code_base == 0 && (ic_code == EIO201_ICCODE ||
> +			       ic_code == EIO211_ICCODE))
> +		return 0;
> +
> + exit:
> +	dev_err(dev,
> +		"Codebase check fail:\n"
> +		"ic_vendor: 0x%X  ,ic_code : 0x%X ,code_base : 0x%X\n",
> +		ic_vendor, ic_code, code_base);
> +	return -ENODEV;
> +}
> +
> +int eiois200_probe(struct device *dev, unsigned int id) {
> +	int ret = 0;
> +
> +	pr_err("timeout=%d\n", timeout);
> +
> +	eiois200_dev = devm_kzalloc(dev, sizeof(struct _eiois200_dev), GFP_KERNEL);
> +	if (!eiois200_dev)
> +		return -ENOMEM;
> +
> +	mutex_init(&eiois200_dev->eiois200_io_mutex);
> +
> +	regmap_is200 = devm_regmap_init(dev, NULL, eiois200_dev, &pnp_regmap_config);
> +	if (!regmap_is200)
> +		return -ENOMEM;
> +
> +	if (eiois200_exist()) {
> +		dev_err(dev, "EIO IS-200 not detected.\n");
> +		return -ENODEV;
> +	}
> +
> +	if (firmware_code_base(dev, &eiois200_dev->pmc)) {
> +		dev_err(dev, "Codebase check fail\n");
> +		return -EIO;
> +	}
> +
> +	dev_set_drvdata(dev, eiois200_dev);
> +
> +	ret = devm_mfd_add_devices(dev, -1, susi_mfd_devs,
> +				   ARRAY_SIZE(susi_mfd_devs),
> +				   NULL, -1, NULL);
> +	if (ret)
> +		dev_err(dev, "Cannot add sub device (error = %d )\n", ret);
> +
> +	return ret;
> +}
> +
> +void eiois200_config_save(const struct _pmc_port *pmc) {
> +	mutex_lock(&eiois200_dev->eiois200_io_mutex);
> +
> +	pmc_out_cmd(pmc, EIOIS200_PMC_CMD_CFG_SAVE);
> +
> +	mutex_unlock(&eiois200_dev->eiois200_io_mutex);
> +}
> +
> +static int eiois200_store_settings(void) {
> +	if ((eiois200_dev->flag & EIOIS200_F_CHIP_EXIST) == 0)
> +		return 0;
> +
> +	if (NEW_CODE_BASE)
> +		return 0;
> +
> +	if (eiois200_dev->flag & EIOIS200_F_CHANGED)
> +		eiois200_config_save(&eiois200_dev->pmc);
> +
> +	if (eiois200_dev->flag & EIOIS200_F_SUB_CHANGED)
> +		eiois200_config_save(&eiois200_dev->pmc1);
> +
> +	return 0;
> +}
> +
> +void eiois200_shutdown(struct device *dev, unsigned int id) {
> +	eiois200_store_settings();
> +}
> +
> +int eiois200_suspend(struct device *dev, unsigned int id, pm_message_t 
> +msg) {
> +	return eiois200_store_settings();
> +}
> +
> +static struct isa_driver eiois200_driver = {
> +	.probe    = eiois200_probe,
> +	.shutdown = eiois200_shutdown,
> +	.suspend  = eiois200_suspend,
> +
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name  = KBUILD_MODNAME,
> +	},
> +};
> +
> +module_isa_driver(eiois200_driver, 1);
> +
> +MODULE_AUTHOR("susi.driver <susi.driver@advantech.com.tw>"); 
> +MODULE_DESCRIPTION("Mfd driver for Advantech EIO-IS200 EC"); 
> +MODULE_LICENSE("GPL v2");
> +
> --
> 2.34.1
> 

-- 
Lee Jones [李琼斯]
