Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97AF7CA6E7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjJPLmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjJPLmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:42:15 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C89BE1;
        Mon, 16 Oct 2023 04:42:13 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507ad511315so1360841e87.0;
        Mon, 16 Oct 2023 04:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697456532; x=1698061332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eg/eFTP6EELAoUzRnMBU3vyJA1RjAJcy3NDdF5/XCv0=;
        b=LPXEUNiDHpzprGG1CaUBpdv0I9a03IDfQ0jNgNXzUgcrfHg0p9TTLmVWIX2TU34/3y
         VXUetgp+Tc3J03EKWjR26LMcmckv/JsrtvgSTMKfFGNce8eXThKuZhGEXrcchVLVmS3X
         madHkCbZUCa8suxWCSajq/mAWE/5p6jQwzj/hnYb9uXnNK8NAV852qXgBRVgJre79o5y
         sqvlrTipD2cD8U8AuUqXMPEnxy79M2A4phf/1B2SyvlHIYiNee7VxL7lWFctKltW5D/U
         iBkYxK2N2KvgKoB7idmC5rSoSDYpj4Ww3a2pvmBKYW7Q0EnqHQwh2MjiFqHW/8k9SKbA
         CEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697456532; x=1698061332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eg/eFTP6EELAoUzRnMBU3vyJA1RjAJcy3NDdF5/XCv0=;
        b=c/OXnZwsC9J3XC7gHmuKXGNW++DF3niLeU94hJEN/TJCBv6A1sCqxopkFby9WChPl/
         uttdw7Cu1LnBr+Xl3xljKFfVjhLPjPTjFuL+ssfAqSeo9NRJ5GyDt+Sutuxf1RK5pNgK
         hbHErsQZRB2XY5pDKbsd3LY2XB/5e6LBDgspk4goVgRqCxHTaRfH3eEJJltdf7wZBwfi
         vXkw+95uATR8uVz7lOFAkxZpirr9IaClhVPvoe7TYdb5Ruv1DukaGiJdskNGp2Gk2T94
         Lc+cfAtU6p+M/GXOKjgE56fT9ESg+bnxKgMRqXbjuIoiQRX53BBiiLbhUZ5FJxW81JQ8
         Za0A==
X-Gm-Message-State: AOJu0YySt+0Cn8tm8bGOVjhho0Ma9oaQ85yThJo7+76Tpqzd6/q4vrjE
        hKlDN7bq3WfGe6e0dSicDeE=
X-Google-Smtp-Source: AGHT+IGt7LM8re+ffiWVpx4/WB1gD6e/KgAnW270g1Dz+wnhGZkHrQAl86YvMigECN5WB0AxJigcFQ==
X-Received: by 2002:ac2:5e21:0:b0:502:ff3b:766f with SMTP id o1-20020ac25e21000000b00502ff3b766fmr23018958lfg.6.1697456531240;
        Mon, 16 Oct 2023 04:42:11 -0700 (PDT)
Received: from [192.168.1.67] (79-139-149-24.dynamic.spd-mgts.ru. [79.139.149.24])
        by smtp.gmail.com with ESMTPSA id o19-20020ac25e33000000b00507a3b8b008sm994145lfg.112.2023.10.16.04.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 04:42:10 -0700 (PDT)
Message-ID: <0a3f634b-62d4-475d-9cb0-d7eb5ee12b17@gmail.com>
Date:   Mon, 16 Oct 2023 14:42:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Implement SDHCI CQE support for DesignWare SDHCI.
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jyan Chou <jyanchou@realtek.com>
References: <20231002113301.1531717-1-serghox@gmail.com>
 <20231002113301.1531717-3-serghox@gmail.com>
 <0932b124-16da-495c-9706-bbadadb3b076@intel.com>
From:   Sergey Khimich <serghox@gmail.com>
In-Reply-To: <0932b124-16da-495c-9706-bbadadb3b076@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Adrian!

Thanks for review and comments! There are few questions I`d like to clarify:

On 09.10.2023 18:39, Adrian Hunter wrote:
> On 2/10/23 14:33, Sergey Khimich wrote:
>> From: Sergey Khimich <serghox@gmail.com>
>>
>> For enabling CQE support just set 'supports-cqe' in your DevTree file
>> for appropriate mmc node.
>>
>> Signed-off-by: Sergey Khimich <serghox@gmail.com>
>> ---
>>   drivers/mmc/host/Kconfig            |   1 +
>>   drivers/mmc/host/sdhci-of-dwcmshc.c | 233 +++++++++++++++++++++++++++-
>>   2 files changed, 232 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 554e67103c1a..f3380b014ca9 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -233,6 +233,7 @@ config MMC_SDHCI_OF_DWCMSHC
>>   	depends on MMC_SDHCI_PLTFM
>>   	depends on OF
>>   	depends on COMMON_CLK
>> +	select MMC_CQHCI
>>   	help
>>   	  This selects Synopsys DesignWare Cores Mobile Storage Controller
>>   	  support.
>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> index 3a3bae6948a8..7d43ae011811 100644
>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/sizes.h>
>>   
>>   #include "sdhci-pltfm.h"
>> +#include "cqhci.h"
>>   
>>   #define SDHCI_DWCMSHC_ARG2_STUFF	GENMASK(31, 16)
>>   
>> @@ -36,6 +37,9 @@
>>   #define DWCMSHC_ENHANCED_STROBE		BIT(8)
>>   #define DWCMSHC_EMMC_ATCTRL		0x40
>>   
>> +/* DWC IP vendor area 2 pointer */
>> +#define DWCMSHC_P_VENDOR_AREA2		0xea
>> +
>>   /* Rockchip specific Registers */
>>   #define DWCMSHC_EMMC_DLL_CTRL		0x800
>>   #define DWCMSHC_EMMC_DLL_RXCLK		0x804
>> @@ -75,6 +79,10 @@
>>   #define BOUNDARY_OK(addr, len) \
>>   	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
>>   
>> +#define DWCMSHC_SDHCI_CQE_TRNS_MODE	(SDHCI_TRNS_MULTI | \
>> +					 SDHCI_TRNS_BLK_CNT_EN | \
>> +					 SDHCI_TRNS_DMA)
>> +
>>   enum dwcmshc_rk_type {
>>   	DWCMSHC_RK3568,
>>   	DWCMSHC_RK3588,
>> @@ -90,7 +98,8 @@ struct rk35xx_priv {
>>   
>>   struct dwcmshc_priv {
>>   	struct clk	*bus_clk;
>> -	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA reg */
>> +	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA1 reg */
>> +	int vendor_specific_area2; /* P_VENDOR_SPECIFIC_AREA2 reg */
>>   	void *priv; /* pointer to SoC private stuff */
>>   };
>>   
>> @@ -210,6 +219,147 @@ static void dwcmshc_hs400_enhanced_strobe(struct mmc_host *mmc,
>>   	sdhci_writel(host, vendor, reg);
>>   }
>>   
>> +static u32 dwcmshc_cqe_irq_handler(struct sdhci_host *host, u32 intmask)
>> +{
>> +	int cmd_error = 0;
>> +	int data_error = 0;
>> +
>> +	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
>> +		return intmask;
>> +
>> +	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
>> +
>> +	return 0;
>> +}
>> +
>> +static void dwcmshc_sdhci_cqe_enable(struct mmc_host *mmc)
>> +{
>> +	struct sdhci_host *host = mmc_priv(mmc);
>> +	u32 pstate;
>> +	u8 ctrl;
>> +	int count = 10;
>> +
>> +	/*
>> +	 * CQE gets stuck if it sees Buffer Read Enable bit set, which can be
>> +	 * the case after tuning, so ensure the buffer is drained.
>> +	 */
>> +	pstate = sdhci_readl(host, SDHCI_PRESENT_STATE);
>> +	while (pstate & SDHCI_DATA_AVAILABLE) {
>> +		sdhci_readl(host, SDHCI_BUFFER);
>> +		pstate = sdhci_readl(host, SDHCI_PRESENT_STATE);
>> +		if (count-- == 0) {
>> +			dev_warn(mmc_dev(host->mmc),
>> +				 "CQE may get stuck because the Buffer Read Enable bit is set\n");
>> +			break;
>> +		}
>> +		mdelay(1);
>> +	}
> An alternative, which might be easier, is to do a
> data reset which may also help allow the device to
> subsequently enter low power states.
> Refer commit f8870ae6e2d6be75b1accc2db981169fdfbea7ab
> and commit 7b7d57fd1b773d25d8358c6017592b4928bf76ce

Thanks, I'll fix it in the next version of the patch.

>
>> +
>> +	sdhci_writew(host, DWCMSHC_SDHCI_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
>> +
>> +	sdhci_cqe_enable(mmc);
>> +
>> +	/*
>> +	 * The "DesignWare Cores Mobile Storage Host Controller
>> +	 * DWC_mshc / DWC_mshc_lite Databook" says:
>> +	 * when Host Version 4 Enable" is 1 in Host Control 2 register,
>> +	 * SDHCI_CTRL_ADMA32 bit means ADMA2 is selected.
>> +	 * Selection of 32-bit/64-bit System Addressing:
>> +	 * either 32-bit or 64-bit system addressing is selected by
>> +	 * 64-bit Addressing bit in Host Control 2 register.
>> +	 *
>> +	 * On the other hand the "DesignWare Cores Mobile Storage Host
>> +	 * Controller DWC_mshc / DWC_mshc_lite User Guide" says, that we have to
>> +	 * set DMA_SEL to ADMA2 _only_ mode in the Host Control 2 register.
>> +	 */
>> +	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>> +	ctrl &= ~SDHCI_CTRL_DMA_MASK;
>> +	ctrl |= SDHCI_CTRL_ADMA32;
>> +	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>> +}
>> +
>> +static void dwcmshc_sdhci_cqe_disable(struct mmc_host *mmc, bool recovery)
>> +{
>> +	/*
>> +	 * If an ioctl was issued, cqe_disable will be called.
>> +	 * For CQE of sdhci-of-dwcmshc, the previous in-flight cmd will be lost quietly.
>> +	 * So wait for mmc idle state.
> This sounds like it should be fixed in the mmc block driver.
> Can you provide an example of when this happens?
Unfortunately I can't provide an example.
But this part of the patch is updated by me on the advice of Shawn Lin 
after his reviewing V1 of the patch.
Please find his message here:
https://patchwork.kernel.org/project/linux-mmc/patch/20230825143525.869906-2-serghox@gmail.com/

Just in case here I also quote the part of his comment that refers to 
this part of the patch:
"And another issue was found when Rockchip added CQE support for
sdhci-of-dwcmshc internally, is that if a ioctl was issued, cqe_disable
will be called. For CQE of sdhci-of-dwcmshc, the previous in-flight cmd
will be lost quietly. So a mmc->cqe_ops->cqe_wait_for_idle(mmc) should
be added before sdhci_cqe_disable(), so you need a dwcmshc specified
cqe_disable hook in sdhci-of-dwcmshc."

>
>> +	 */
>> +	mmc->cqe_ops->cqe_wait_for_idle(mmc);
>> +
>> +	return sdhci_cqe_disable(mmc, recovery);
>> +}
>> +
>> +static void dwcmshc_cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,
>> +					bool dma64)
>> +{
>> +	__le32 *attr = (__le32 __force *)desc;
>> +
>> +	*attr = (CQHCI_VALID(1) |
>> +		 CQHCI_END(end ? 1 : 0) |
>> +		 CQHCI_INT(0) |
>> +		 CQHCI_ACT(0x4) |
>> +		 CQHCI_DAT_LENGTH(len));
>> +
>> +	if (dma64) {
>> +		__le64 *dataddr = (__le64 __force *)(desc + 4);
>> +
>> +		dataddr[0] = cpu_to_le64(addr);
>> +	} else {
>> +		__le32 *dataddr = (__le32 __force *)(desc + 4);
>> +
>> +		dataddr[0] = cpu_to_le32(addr);
>> +	}
>> +}
> This is the same as cqhci_set_tran_desc(). Might as well export that
> instead.
Thanks, I'll fix it in the next version of the patch.
>> +
>> +static void dwcmshc_cqhci_prep_tran_desc(struct mmc_data *data,
>> +					 struct cqhci_host *cq_host,
>> +					 u8 *desc, int sg_count)
>> +{
>> +	int i, len, tmplen, offset;
>> +	bool end = false;
>> +	bool dma64 = cq_host->dma64;
>> +	dma_addr_t addr;
>> +	struct scatterlist *sg;
>> +
>> +	for_each_sg(data->sg, sg, sg_count, i) {
>> +		addr = sg_dma_address(sg);
>> +		len = sg_dma_len(sg);
>> +
>> +		/*
>> +		 * According to the "DesignWare Cores Mobile Storage Host Controller
>> +		 * DWC_mshc / DWC_mshc_lite Databook" the host memory data buffer size
>> +		 * and start address must not exceed 128 Mb. If it exceeds,
>> +		 * the data buffer must be split using two descritors.
>> +		 */
>> +
>> +		if (likely(BOUNDARY_OK(addr, len))) {
>> +			if ((i + 1) == sg_count)
>> +				end = true;
>> +			dwcmshc_cqhci_set_tran_desc(desc, addr, len, end, dma64);
>> +			desc += cq_host->trans_desc_len;
>> +		} else {
>> +			offset = addr & (SZ_128M - 1);
>> +			tmplen = SZ_128M - offset;
>> +			dwcmshc_cqhci_set_tran_desc(desc, addr, tmplen, end, dma64);
>> +			desc += cq_host->trans_desc_len;
>> +
>> +			if ((i + 1) == sg_count)
>> +				end = true;
>> +
>> +			addr += tmplen;
>> +			len -= tmplen;
>> +			dwcmshc_cqhci_set_tran_desc(desc, addr, len, end, dma64);
>> +			desc += cq_host->trans_desc_len;
>> +		}
>> +	}
>> +}
> Could this be done more like dwcmshc_adma_write_desc()
Actually I'm not sure what do you mean. I reused checking boundary 
construction with
"BOUNDARY_OK" macro and used the same variable names. I would appreciate 
it if you could clarify
what does mean "more like dwcmshc_adma_write_desc()"
>
>> +
>> +static void dwcmshc_cqhci_dumpregs(struct mmc_host *mmc)
>> +{
>> +	sdhci_dumpregs(mmc_priv(mmc));
>> +}
>> +
>>   static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock)
>>   {
>>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> @@ -345,6 +495,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
>>   	.get_max_clock		= dwcmshc_get_max_clock,
>>   	.reset			= sdhci_reset,
>>   	.adma_write_desc	= dwcmshc_adma_write_desc,
>> +	.irq			= dwcmshc_cqe_irq_handler,
>>   };
>>   
>>   static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
>> @@ -379,6 +530,70 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
>>   		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>>   };
>>   
>> +static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
>> +	.enable		= dwcmshc_sdhci_cqe_enable,
>> +	.disable	= dwcmshc_sdhci_cqe_disable,
>> +	.dumpregs	= dwcmshc_cqhci_dumpregs,
>> +	.prep_tran_desc	= dwcmshc_cqhci_prep_tran_desc,
>> +};
>> +
>> +static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *pdev)
>> +{
>> +	struct cqhci_host *cq_host;
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +	bool dma64 = false;
>> +	u16 clk;
>> +	int err;
>> +
>> +	host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
>> +	cq_host = devm_kzalloc(&pdev->dev, sizeof(*cq_host), GFP_KERNEL);
>> +	if (!cq_host) {
>> +		dev_err(mmc_dev(host->mmc), "Unable to setup CQE: not enough memory\n");
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * For dwcmshc host controller we have to enable internal clock
>> +	 * before access to some registers from Vendor Specific Aria 2.
>> +	 */
>> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>> +	clk |= SDHCI_CLOCK_INT_EN;
>> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>> +	if (!(clk & SDHCI_CLOCK_INT_EN)) {
>> +		dev_err(mmc_dev(host->mmc), "Unable to setup CQE: internal clock enable error\n");
>> +		goto free_cq_host;
>> +	}
>> +
>> +	cq_host->mmio = host->ioaddr + priv->vendor_specific_area2;
>> +	cq_host->ops = &dwcmshc_cqhci_ops;
>> +
>> +	/* Enable using of 128-bit task descriptors */
>> +	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
>> +	if (dma64) {
>> +		dev_dbg(mmc_dev(host->mmc), "128-bit task descriptors\n");
>> +		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
>> +	}
>> +	err = cqhci_init(cq_host, host->mmc, dma64);
>> +	if (err) {
>> +		dev_err(mmc_dev(host->mmc), "Unable to setup CQE: error %d\n", err);
>> +		goto int_clok_disable;
>> +	}
>> +
>> +	dev_dbg(mmc_dev(host->mmc), "CQE init done\n");
>> +
>> +	return;
>> +
>> +int_clok_disable:
> 'clok' is an odd abbreviation of 'clock'.  Perhaps 'clk' or just 'clock'
Thanks, I'll fix it in the next version of the patch.
>
>> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>> +	clk &= ~SDHCI_CLOCK_INT_EN;
>> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>> +
>> +free_cq_host:
>> +	devm_kfree(&pdev->dev, cq_host);
>> +}
>> +
>>   static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
>>   {
>>   	int err;
>> @@ -471,7 +686,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>   	struct rk35xx_priv *rk_priv = NULL;
>>   	const struct sdhci_pltfm_data *pltfm_data;
>>   	int err;
>> -	u32 extra;
>> +	u32 extra, caps;
>>   
>>   	pltfm_data = device_get_match_data(&pdev->dev);
>>   	if (!pltfm_data) {
>> @@ -519,6 +734,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>   
>>   	priv->vendor_specific_area1 =
>>   		sdhci_readl(host, DWCMSHC_P_VENDOR_AREA1) & DWCMSHC_AREA1_MASK;
>> +	priv->vendor_specific_area2 =
>> +		sdhci_readw(host, DWCMSHC_P_VENDOR_AREA2);
>>   
>>   	host->mmc_host_ops.request = dwcmshc_request;
>>   	host->mmc_host_ops.hs400_enhanced_strobe = dwcmshc_hs400_enhanced_strobe;
>> @@ -547,6 +764,10 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>   		sdhci_enable_v4_mode(host);
>>   #endif
>>   
>> +	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>> +	if (caps & SDHCI_CAN_64BIT_V4)
>> +		sdhci_enable_v4_mode(host);
>> +
>>   	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>>   
>>   	pm_runtime_get_noresume(dev);
>> @@ -557,6 +778,14 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>   	if (err)
>>   		goto err_rpm;
>>   
>> +	/* Setup Command Queue Engine if enabled */
>> +	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
>> +		if (caps & SDHCI_CAN_64BIT_V4)
>> +			dwcmshc_cqhci_init(host, pdev);
>> +		else
>> +			dev_warn(dev, "Cannot enable CQE without V4 mode support\n");
>> +	}
>> +
>>   	if (rk_priv)
>>   		dwcmshc_rk35xx_postinit(host, priv);
>>   
