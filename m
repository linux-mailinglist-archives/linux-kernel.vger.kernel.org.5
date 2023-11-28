Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BC07FC1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345321AbjK1SHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjK1SHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:07:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8E4AB;
        Tue, 28 Nov 2023 10:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701194826; x=1732730826;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EeyQbQkwGtpaPWXrYXjELaDlGVMx1ZNDEakvPDDbB2Y=;
  b=Z47OvWEexGaV9oaWP1wlXO0dYIg2FKzFMNkyrhq1zcTfrBawXBMq77GL
   IE2aZAZZcCmkhTPK8hyF2ESbwhIFcCa+OWGobtjQUjP1hzbv/C5o1mT9s
   CS/jUzLwXPqlksQ+rRof5PbY0H7UyE1hH/TfUpdyCMY8tZBTiXnuXx/LV
   i3EygIZwCKVqVWQdxqUUqCfiLUilXKC4KnhmkfmlwVbd+HGYfZ7YTQ1KR
   nz68Q1eo3A3XdwlDOm1Kh/Wnqv7JlzG2J0E72NsTcSd9rFjT0TkgdsZ9e
   M1hoqFyBXRKZatF2JtFEg63n8KC39sjaKSZQXZcWJdD+8LNnQypsP08Tu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="424130945"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="424130945"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 10:05:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="834723966"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="834723966"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.221.84])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 10:05:20 -0800
Message-ID: <655c5964-0917-4021-b254-7917b368b05f@intel.com>
Date:   Tue, 28 Nov 2023 20:05:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7][2/4] mmc: Add Synopsys DesignWare mmc cmdq host driver
Content-Language: en-US
To:     Jyan Chou <jyanchou@realtek.com>, ulf.hansson@linaro.org,
        jh80.chung@samsung.com, riteshh@codeaurora.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     conor+dt@kernel.org, asutoshd@codeaurora.org,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, briannorris@chromium.org, doug@schmorgal.com,
        tonyhuang.sunplus@gmail.com, abel.vesa@linaro.org,
        william.qiu@starfivetech.com
References: <20231121091101.5540-1-jyanchou@realtek.com>
 <20231121091101.5540-3-jyanchou@realtek.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231121091101.5540-3-jyanchou@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/23 11:10, Jyan Chou wrote:
> We implemented cmdq feature on Synopsys DesignWare mmc driver.
> The difference between dw_mmc.c and dw_mmc_cqe.c were distinct
> register definitions, mmc user flow and the addition of cmdq.
> 
> New version of User Guide had modify mmc driver's usage flow,
> we may need to renew code to precisely follow user guide.
> 
> More over, We added a wait status function to satisfy synopsys
> user guide's description, since this flow might be specific in
> synopsys host driver only.
> 
> Signed-off-by: Jyan Chou <jyanchou@realtek.com>
> 

Some comments below wrt cqhci

> —--
> v6 -> v7:
> - Remove reset-names in driver and adjust reset control's code.
> 
> v5 -> v6:
> - Fix linux coding style issues.
> - Drop useless code that is not described in the bindings.
> - Replace devm_clk_get and clk_prepare_enable with devm_clk_get_enabled.
> - Replace EXPORT_SYMBOL with EXPORT_SYMBOL_GPL.
> 
> v4 -> v5:
> - Fix linux coding style issues.
> - Fix test robot build errors to make good use of setup_tran_desc
>   call back function.
> - Remove useless function.
> 
> v3 -> v4:
> - Modify dma mode selection and dma addressing bit to statisfy
>   linux coding style.
> 
> v1 -> v2:
> - Remove dw_mci_cqe_set_tran_desc due to the duplicated function.
> - Add ->pre_enable() / ->post_disable()
> 
> v0 -> v1:
> - Seperate different support into single patch.
> - Fix the compiler complains.
> ---
> ---
>  drivers/mmc/host/Kconfig      |   13 +
>  drivers/mmc/host/Makefile     |    1 +
>  drivers/mmc/host/dw_mmc_cqe.c | 1467 +++++++++++++++++++++++++++++++++
>  drivers/mmc/host/dw_mmc_cqe.h |  456 ++++++++++
>  4 files changed, 1937 insertions(+)
>  create mode 100644 drivers/mmc/host/dw_mmc_cqe.c
>  create mode 100644 drivers/mmc/host/dw_mmc_cqe.h
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 58bd5fe4cd25..06bb4de28cc4 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -837,6 +837,19 @@ config MMC_DW_STARFIVE
>  	  Synopsys DesignWare Memory Card Interface driver. Select this option
>  	  for platforms based on StarFive JH7110 SoC.
>  
> +config MMC_DW_CQE
> +	tristate "Synopsys DesignWare Memory Card with CQE Interface"
> +	depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
> +	select MMC_CQHCI
> +	help
> +	 This selects support for the Synopsys DesignWare Mobile Storage IP
> +	 block after JEDEC Standard version 5.1. Select this option for SD and
> +	 MMC interfaces that use command queue.
> +
> +	 If you have a controller with this interface, say Y or M here.
> +
> +	 If unsure, say Y.
> +
>  config MMC_SH_MMCIF
>  	tristate "SuperH Internal MMCIF support"
>  	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index d0be4465f3ec..464fe58f8541 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_MMC_DW_K3)		+= dw_mmc-k3.o
>  obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
>  obj-$(CONFIG_MMC_DW_ROCKCHIP)	+= dw_mmc-rockchip.o
>  obj-$(CONFIG_MMC_DW_STARFIVE)	+= dw_mmc-starfive.o
> +obj-$(CONFIG_MMC_DW_CQE)	+= dw_mmc_cqe.o
>  obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
>  obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
>  obj-$(CONFIG_MMC_VUB300)	+= vub300.o
> diff --git a/drivers/mmc/host/dw_mmc_cqe.c b/drivers/mmc/host/dw_mmc_cqe.c
> new file mode 100644
> index 000000000000..eb00d6a474b2
> --- /dev/null
> +++ b/drivers/mmc/host/dw_mmc_cqe.c
> @@ -0,0 +1,1467 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Synopsys DesignWare Multimedia Card Interface driver with CMDQ support
> + *  (Based on Synopsys DesignWare Multimedia Card Interface driver)
> + *
> + * Copyright (c) 2023 Realtek Semiconductor Corp
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/blkdev.h>
> +#include <linux/clk.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/ioport.h>
> +#include <linux/irq.h>
> +#include <linux/mmc/card.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/sd.h>
> +#include <linux/mmc/sdio.h>
> +#include <linux/mmc/slot-gpio.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/seq_file.h>
> +#include <linux/sizes.h>
> +#include <linux/slab.h>
> +#include <linux/stat.h>
> +
> +#include "dw_mmc_cqe.h"
> +#include "cqhci.h"
> +
> +#define DW_MCI_FREQ_MAX	200000000	/* unit: HZ */
> +#define DW_MCI_FREQ_MIN	100000		/* unit: HZ */
> +#define DW_MCI_CMDQ_DISABLED	0x30f0001
> +#define DW_MCI_CMDQ_ENABLED	0x30f0101
> +#define DW_MCI_POWEROFF		0x3220301
> +#define DW_MCI_DESC_LEN		0x100000
> +#define DW_MCI_MAX_SCRIPT_BLK	128
> +#define DW_MCI_TIMEOUT_Ms	200
> +#define DW_MCI_TIMEOUT		200000
> +#define TUNING_ERR		531

Could just use EIO

> +#define DW_MCI_NOT_READY	9999
> +
> +DECLARE_COMPLETION(dw_mci_wait);
> +
> +static int dw_mci_cqe_regs_show(struct dw_mci *host,
> +				struct mmc_command *cmd, u32 cmd_flags)
> +{
> +	dev_info(host->dev, "opcode = %d, arg = 0x%x, cmdflags = 0x%x\n",
> +		 cmd->opcode, cmd->arg, cmd_flags);
> +	dev_info(host->dev, "status_int = 0x%x\n", host->normal_interrupt);
> +	dev_info(host->dev, "error_int = 0x%x\n", host->error_interrupt);
> +	dev_info(host->dev, "auto_error_int = 0x%x\n", host->auto_error_interrupt);
> +
> +	return 0;
> +}
> +
> +static void dw_mci_cqe_dumpregs(struct mmc_host *mmc)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci *host = slot->host;
> +
> +	dev_info(host->dev, "%s: cmd idx 0x%08x\n", __func__, mcq_readw(host, CMD_R));
> +}
> +
> +static void dw_mci_cqe_setup_tran_desc(struct mmc_data *data,
> +				       struct cqhci_host *cq_host,
> +					u8 *desc,
> +					int sg_count)
> +{
> +	struct scatterlist *sg;
> +	u32 cur_blk_cnt, remain_blk_cnt;
> +	unsigned int begin, end;
> +	int i, len;
> +	bool last = false;
> +	bool dma64 = cq_host->dma64;
> +	dma_addr_t addr;
> +
> +	for_each_sg(data->sg, sg, sg_count, i) {
> +		addr = sg_dma_address(sg);
> +		len = sg_dma_len(sg);
> +		remain_blk_cnt  = len >> 9;
> +
> +		while (remain_blk_cnt) {
> +			if (remain_blk_cnt > DW_MCI_MAX_SCRIPT_BLK)

Use max_seg_size then that won't happen

> +				cur_blk_cnt = DW_MCI_MAX_SCRIPT_BLK;
> +			else
> +				cur_blk_cnt = remain_blk_cnt;
> +
> +			begin = addr / SZ_128M;
> +			end = (addr + cur_blk_cnt * SZ_512) / SZ_128M;
> +
> +			if (begin != end)
> +				cur_blk_cnt = (end * SZ_128M - addr) / SZ_512;
> +
> +			if ((i + 1) == sg_count && remain_blk_cnt == cur_blk_cnt)
> +				last = true;
> +
> +			cqhci_set_tran_desc(desc, addr,
> +					    (cur_blk_cnt << 9), last, dma64);
> +
> +			addr = addr + (cur_blk_cnt << 9);
> +			remain_blk_cnt -= cur_blk_cnt;
> +			desc += cq_host->trans_desc_len;
> +		}
> +	}
> +}

Provide a hook for cqhci_set_tran_desc() instead of cqhci_prep_tran_desc()
You'll need to check the details, but something like:


diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index b3d7d6d8d654..98e7e9d3030d 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -522,7 +522,10 @@ static int cqhci_prep_tran_desc(struct mmc_request *mrq,
 
 		if ((i+1) == sg_count)
 			end = true;
-		cqhci_set_tran_desc(desc, addr, len, end, dma64);
+		if (cq_host->ops->set_tran_desc)
+			cq_host->ops->set_tran_desc(&desc, addr, len, end, dma64);
+		else
+			cqhci_set_tran_desc(desc, addr, len, end, dma64);
 		desc += cq_host->trans_desc_len;
 	}

And:

#define BOUNDARY_OK(addr, len) \
	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))


static void dw_mci_cqe_set_tran_desc(u8 **desc, dma_addr_t addr, int len, bool end, bool dma64)
{
	int tmplen, offset;

	if (likely(!len || BOUNDARY_OK(addr, len))) {
		cqhci_set_tran_desc(*desc, addr, len, end, dma64);
		return;
	}

	offset = addr & (SZ_128M - 1);
	tmplen = SZ_128M - offset;
	cqhci_set_tran_desc(*desc, addr, tmplen, false, dma64);

	addr += tmplen;
	len -= tmplen;
	*desc += cq_host->trans_desc_len;
	cqhci_set_tran_desc(*desc, addr, len, end, dma64);
}


> +
> +static void dw_mci_cqe_enable(struct mmc_host *mmc)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci *host = slot->host;
> +
> +	mcq_writeb(host, SW_RST_R, SDMMC_RST_DAT);
> +	mcq_writew(host, XFER_MODE_R,
> +		   ((1 << SDMMC_MULTI_BLK_SEL) | SDMMC_BLOCK_COUNT_ENABLE
> +			| SDMMC_DMA_ENABLE));
> +
> +	mcq_writeb(host, HOST_CTRL1_R,
> +		   (mcq_readb(host, HOST_CTRL1_R) & 0xe7) |
> +			(SDMMC_ADMA2_32 << SDMMC_DMA_SEL));
> +	mcq_writew(host, BLOCKSIZE_R, 0x200);
> +	mcq_writew(host, BLOCKCOUNT_R, 0);
> +
> +	mcq_writel(host, SDMASA_R, 0);
> +
> +	cqhci_writel(host->cqe, 0x10, CQHCI_SSC1);
> +	cqhci_writel(host->cqe, 0, CQHCI_CTL);
> +
> +	if (cqhci_readl(host->cqe, CQHCI_CTL) && CQHCI_HALT) {
> +		dev_err(host->dev, "%s: cqhci: CQE failed to exit halt state\n",
> +			mmc_hostname(mmc));
> +	}
> +
> +	dw_mci_clr_signal_int(host);
> +	dw_mci_en_cqe_int(host);
> +}
> +
> +static void dw_mci_cqe_pre_enable(struct mmc_host *mmc)
> +{
> +	struct cqhci_host *cq_host = mmc->cqe_private;
> +	u32 reg;
> +
> +	reg = cqhci_readl(cq_host, CQHCI_CFG);
> +	reg |= CQHCI_ENABLE;
> +	cqhci_writel(cq_host, reg, CQHCI_CFG);
> +}
> +
> +static void dw_mci_cqe_post_disable(struct mmc_host *mmc)
> +{
> +	struct cqhci_host *cq_host = mmc->cqe_private;
> +	u32 reg;
> +
> +	reg = cqhci_readl(cq_host, CQHCI_CFG);
> +	reg &= ~CQHCI_ENABLE;
> +	cqhci_writel(cq_host, reg, CQHCI_CFG);
> +}
> +
> +static const struct cqhci_host_ops dw_mci_cqhci_host_ops = {
> +	.enable = dw_mci_cqe_enable,
> +	.dumpregs = dw_mci_cqe_dumpregs,
> +	.pre_enable = dw_mci_cqe_pre_enable,
> +	.post_disable = dw_mci_cqe_post_disable,
> +	.setup_tran_desc = dw_mci_cqe_setup_tran_desc,
> +};
> +

[SNIP]

> +
> +static irqreturn_t dw_mci_cqe_interrupt(int irq, void *dev_id)
> +{
> +	struct dw_mci *host = dev_id;
> +	struct mmc_host *mmc = host->slot->mmc;
> +	struct cqhci_host *cq_host = NULL;
> +	int cmd_error = 0, data_error = 0;
> +
> +	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE))
> +		cq_host = mmc->cqe_private;
> +
> +	dw_mci_get_int(host);
> +
> +	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE)) {
> +		if (!mmc->cqe_on && !cq_host->activated)

Shouldn't really look at internals like mmc->cqe_on or
cq_host->activated.  There are the cqhci_host_ops ->enable()
and ->disable() callbacks to keep track of whether cqhci is
expecting interrupts.

> +			dw_mci_clr_signal_int(host);
> +	} else {
> +		dw_mci_clr_signal_int(host);
> +	}
> +
> +	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE) &&
> +	    mmc->cqe_on && cq_host->activated) {

As above

> +		if (host->normal_interrupt & SDMMC_ERR_INTERRUPT) {
> +			dev_err(host->dev, "cmdq error: interrupt status=%08x, error interrupt=0x%08x, CQIS=0x%x, CQTCN=0x%x\n",
> +				host->normal_interrupt, host->error_interrupt,
> +				readl(host->cqe->mmio + CQHCI_IS),
> +				readl(host->cqe->mmio + CQHCI_TCN));
> +
> +			dw_mci_cqe_command_complete(host, host->error_interrupt, &cmd_error);
> +			dw_mci_cqe_data_complete(host, host->error_interrupt, &data_error);
> +		}
> +		cqhci_irq(mmc, (u32)(host->normal_interrupt), cmd_error, data_error);
> +		dw_mci_clr_int(host);
> +
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (host->int_waiting) {
> +		del_timer(&host->timer);
> +		complete(host->int_waiting);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +


