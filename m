Return-Path: <linux-kernel+bounces-90768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F22408704B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5EB62826A1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79604652D;
	Mon,  4 Mar 2024 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aV+DonLP"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EBF3FB02;
	Mon,  4 Mar 2024 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564462; cv=none; b=nLiOpddFZeeNiOOWT9qQVb0j8inoBdpw3idhEpj8UYfHwr/Z/4b5UXwlQWJaE3JgBiRe2LIMVPp6g6kLVLibU0m0w/K943gRMclrTl0ICGLOMFpNjDcpeR0nlyc1QlUbaC9tHo3ctNngAqWsU9ryID93mu2ojVYhaRvzvQ4impQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564462; c=relaxed/simple;
	bh=B7A1SkCWWhs3QDeTt76VgfTW85Y77VOmWBLPoG/2e64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEwLTwSzpSf7RNfTGWR5eXnhZtBCMclRLOH5RBq5H+2SQolfnx/SrYTQVC4QGtRZwalXpozFH8wT8Q0gDUdOW2BNeu1uJ7ZQMYXJejif+juukS6nw+8Wov3zYXShu2NViTYAXSKA4Lnlx4wATAiqF1zqooATmpy8zzGRCGCPeWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aV+DonLP; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512bc0e8ce1so4538274e87.0;
        Mon, 04 Mar 2024 07:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709564459; x=1710169259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ryogkmg4U5SyBvGjIJC4z0+f23srY+M91RcmcN00aH4=;
        b=aV+DonLPFjMAWr9Hoo6E+24HnW4K2lZswqBmgz0o/3MVb2TMxwEQ370jbotYneOjfT
         DeVAaLbpajMZmHptYnkYhU/TaK7o3ITMhF5kCiNHowv7ddhiXiAxxsCFF0UDRL1mGfaT
         kpS4n1mHIqy2Qa9sDS3Bb1lk7ID1lnfxJHpy91lY0482P3fS0vjywM+WR+HdvyHFeq8U
         2gUezb5usipVuwqELWe+X7A2Kfkjo1H188Sk1isro9qHpuUJHGwc4ze7vBvZyUKpUYYX
         eryTf1pRWi4O1U8lSRi8c1T3CpEuiYlP756Stv9yVKn7GzE5AbhTTAMq5CDj2i6+BCZb
         lWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564459; x=1710169259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryogkmg4U5SyBvGjIJC4z0+f23srY+M91RcmcN00aH4=;
        b=bV7pNM+LjuVn9b/GrsRuFEuX3Ig5s45SwhNV3uWkUEpk8aKoxBXGwT2rYZphnMAczI
         q+Vq5qlH6PcuI0WGr1L8aiH0PG66w4kC69eCzaZlubtxm6ju4QMrtAtlo/v3nYvI7WDY
         /bZQ3/F8dkkYuQl7/wrh1WxSpDxaMKHsN5T+OUmIVCIp3CPDRIjm5fQhLM8orsbdu/WA
         L6agr7yo26rBCaJaE5IM9582O6Qn66OanwtGN9pXpAWDv+G3xNM4GX+IZDvc/gQoasvJ
         fphzLie1JAhIqysHicTjinRH1w3Jynu8y5UUbppo6D98UvM/APMNHT7fJVctBpxnwhWB
         RvTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpl4WtVldorhAjfeFvi0M+yD4xAv9v1T/Ljns/O+/CoERwST4ClfhQbgfyRae8ZH3ynEuXMOGG/7Awqu/aU1l1bYLHUWwA+9Nt
X-Gm-Message-State: AOJu0YxZyguKfwod+mhfbvSvjLIO/Ayh7NFWkLiqA6cHe/xLBI97a4NV
	xli/794bnCw6MFv4Jv5hvEPc4jjMG9ga7l32dMc+mKnInjxI+TJ3
X-Google-Smtp-Source: AGHT+IEfmtEeF1oiI3ERNUo2zhrocN2ZILY42oo2L7o8RSnWmc1pdsjdTuUlGN48PpCskvATWWPQEQ==
X-Received: by 2002:a05:6512:402:b0:513:17bf:87d5 with SMTP id u2-20020a056512040200b0051317bf87d5mr5387095lfk.63.1709564458395;
        Mon, 04 Mar 2024 07:00:58 -0800 (PST)
Received: from [172.17.5.242] (avpn01.yadro.com. [89.207.88.243])
        by smtp.gmail.com with ESMTPSA id y10-20020ac255aa000000b005132b1e65a3sm1573222lfg.71.2024.03.04.07.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 07:00:57 -0800 (PST)
Message-ID: <7096c3c9-89e5-41a4-80ed-dbc485252497@gmail.com>
Date: Mon, 4 Mar 2024 18:00:56 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] mmc: sdhci-of-dwcmshc: Implement SDHCI CQE support
Content-Language: en-US
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Jyan Chou <jyanchou@realtek.com>,
 linux-mmc@vger.kernel.org
References: <20231231144619.758290-1-serghox@gmail.com>
 <20231231144619.758290-3-serghox@gmail.com>
 <b1b1f215-738d-4d4d-90cf-0ea5cea11c14@rock-chips.com>
From: Sergey Khimich <serghox@gmail.com>
In-Reply-To: <b1b1f215-738d-4d4d-90cf-0ea5cea11c14@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Shawn!

Sorry for the late reply. And I really appreciate you've tested my patch 
on Rockchip SoCs! I'll add cqhci_suspend/resume to fix work with s2r.

Speaking about force enabling v4 mode - actually I never managed to run 
CQE for my IP with disabled v4 mode and I thought, that it doesn`t work

without v4. Now when you've tested the case I suggest to remove the 
checking of v4 mode for CQE in general, but I'll add force setting v4

for my platform (when it will be ready) in separate patch.

On 04.01.2024 6:01, Shawn Lin wrote:
> Hi Sergey
>
> On 2023/12/31 22:46, Sergey Khimich wrote:
>> From: Sergey Khimich <serghox@gmail.com>
>>
>> For enabling CQE support just set 'supports-cqe' in your DevTree file
>> for appropriate mmc node.
>>
>
> I have tested this patchset and it seems work fine on Rockchip SoCs 
> when I removed sdhci_enable_v4_mode as we don't have 
> SDHCI_CAN_64BIT_V4 support. Why do we force to enable v4?
>
> And I found it breaks s2r, since the patch didn't call cqhci_suspend
> and cqhci_resume.
>
>> Signed-off-by: Sergey Khimich <serghox@gmail.com>
>> ---
>>   drivers/mmc/host/Kconfig            |   1 +
>>   drivers/mmc/host/sdhci-of-dwcmshc.c | 181 +++++++++++++++++++++++++++-
>>   2 files changed, 180 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 58bd5fe4cd25..f7594705b013 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -233,6 +233,7 @@ config MMC_SDHCI_OF_DWCMSHC
>>       depends on MMC_SDHCI_PLTFM
>>       depends on OF
>>       depends on COMMON_CLK
>> +    select MMC_CQHCI
>>       help
>>         This selects Synopsys DesignWare Cores Mobile Storage Controller
>>         support.
>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c 
>> b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> index 3a3bae6948a8..0ba1df4bcf36 100644
>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/sizes.h>
>>     #include "sdhci-pltfm.h"
>> +#include "cqhci.h"
>>     #define SDHCI_DWCMSHC_ARG2_STUFF    GENMASK(31, 16)
>>   @@ -36,6 +37,9 @@
>>   #define DWCMSHC_ENHANCED_STROBE        BIT(8)
>>   #define DWCMSHC_EMMC_ATCTRL        0x40
>>   +/* DWC IP vendor area 2 pointer */
>> +#define DWCMSHC_P_VENDOR_AREA2        0xea
>> +
>>   /* Rockchip specific Registers */
>>   #define DWCMSHC_EMMC_DLL_CTRL        0x800
>>   #define DWCMSHC_EMMC_DLL_RXCLK        0x804
>> @@ -75,6 +79,11 @@
>>   #define BOUNDARY_OK(addr, len) \
>>       ((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
>>   +#define DWCMSHC_SDHCI_CQE_TRNS_MODE    (SDHCI_TRNS_MULTI | \
>> +                     SDHCI_TRNS_BLK_CNT_EN | \
>> +                     SDHCI_TRNS_DMA)
>> +
>> +
>>   enum dwcmshc_rk_type {
>>       DWCMSHC_RK3568,
>>       DWCMSHC_RK3588,
>> @@ -90,7 +99,9 @@ struct rk35xx_priv {
>>     struct dwcmshc_priv {
>>       struct clk    *bus_clk;
>> -    int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA reg */
>> +    int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA1 reg */
>> +    int vendor_specific_area2; /* P_VENDOR_SPECIFIC_AREA2 reg */
>> +
>>       void *priv; /* pointer to SoC private stuff */
>>   };
>>   @@ -210,6 +221,90 @@ static void 
>> dwcmshc_hs400_enhanced_strobe(struct mmc_host *mmc,
>>       sdhci_writel(host, vendor, reg);
>>   }
>>   +static int dwcmshc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>> +{
>> +    int err = sdhci_execute_tuning(mmc, opcode);
>> +    struct sdhci_host *host = mmc_priv(mmc);
>> +
>> +    if (err)
>> +        return err;
>> +
>> +    /*
>> +     * Tuning can leave the IP in an active state (Buffer Read 
>> Enable bit
>> +     * set) which prevents the entry to low power states (i.e. 
>> S0i3). Data
>> +     * reset will clear it.
>> +     */
>> +    sdhci_reset(host, SDHCI_RESET_DATA);
>> +
>> +    return 0;
>> +}
>> +
>> +static u32 dwcmshc_cqe_irq_handler(struct sdhci_host *host, u32 
>> intmask)
>> +{
>> +    int cmd_error = 0;
>> +    int data_error = 0;
>> +
>> +    if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
>> +        return intmask;
>> +
>> +    cqhci_irq(host->mmc, intmask, cmd_error, data_error);
>> +
>> +    return 0;
>> +}
>> +
>> +static void dwcmshc_sdhci_cqe_enable(struct mmc_host *mmc)
>> +{
>> +    struct sdhci_host *host = mmc_priv(mmc);
>> +    u8 ctrl;
>> +
>> +    sdhci_writew(host, DWCMSHC_SDHCI_CQE_TRNS_MODE, 
>> SDHCI_TRANSFER_MODE);
>> +
>> +    sdhci_cqe_enable(mmc);
>> +
>> +    /*
>> +     * The "DesignWare Cores Mobile Storage Host Controller
>> +     * DWC_mshc / DWC_mshc_lite Databook" says:
>> +     * when Host Version 4 Enable" is 1 in Host Control 2 register,
>> +     * SDHCI_CTRL_ADMA32 bit means ADMA2 is selected.
>> +     * Selection of 32-bit/64-bit System Addressing:
>> +     * either 32-bit or 64-bit system addressing is selected by
>> +     * 64-bit Addressing bit in Host Control 2 register.
>> +     *
>> +     * On the other hand the "DesignWare Cores Mobile Storage Host
>> +     * Controller DWC_mshc / DWC_mshc_lite User Guide" says, that we 
>> have to
>> +     * set DMA_SEL to ADMA2 _only_ mode in the Host Control 2 register.
>> +     */
>> +    ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>> +    ctrl &= ~SDHCI_CTRL_DMA_MASK;
>> +    ctrl |= SDHCI_CTRL_ADMA32;
>> +    sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>> +}
>> +
>> +static void dwcmshc_set_tran_desc(struct cqhci_host *cq_host, u8 
>> **desc,
>> +                  dma_addr_t addr, int len, bool end, bool dma64)
>> +{
>> +    int tmplen, offset;
>> +
>> +    if (likely(!len || BOUNDARY_OK(addr, len))) {
>> +        cqhci_set_tran_desc(*desc, addr, len, end, dma64);
>> +        return;
>> +    }
>> +
>> +    offset = addr & (SZ_128M - 1);
>> +    tmplen = SZ_128M - offset;
>> +    cqhci_set_tran_desc(*desc, addr, tmplen, false, dma64);
>> +
>> +    addr += tmplen;
>> +    len -= tmplen;
>> +    *desc += cq_host->trans_desc_len;
>> +    cqhci_set_tran_desc(*desc, addr, len, end, dma64);
>> +}
>> +
>> +static void dwcmshc_cqhci_dumpregs(struct mmc_host *mmc)
>> +{
>> +    sdhci_dumpregs(mmc_priv(mmc));
>> +}
>> +
>>   static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, 
>> unsigned int clock)
>>   {
>>       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> @@ -345,6 +440,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
>>       .get_max_clock        = dwcmshc_get_max_clock,
>>       .reset            = sdhci_reset,
>>       .adma_write_desc    = dwcmshc_adma_write_desc,
>> +    .irq            = dwcmshc_cqe_irq_handler,
>>   };
>>     static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
>> @@ -379,6 +475,71 @@ static const struct sdhci_pltfm_data 
>> sdhci_dwcmshc_rk35xx_pdata = {
>>              SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>>   };
>>   +static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
>> +    .enable        = dwcmshc_sdhci_cqe_enable,
>> +    .disable    = sdhci_cqe_disable,
>> +    .dumpregs    = dwcmshc_cqhci_dumpregs,
>> +    .set_tran_desc    = dwcmshc_set_tran_desc,
>> +};
>> +
>> +static void dwcmshc_cqhci_init(struct sdhci_host *host, struct 
>> platform_device *pdev)
>> +{
>> +    struct cqhci_host *cq_host;
>> +    struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +    struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +    bool dma64 = false;
>> +    u16 clk;
>> +    int err;
>> +
>> +    host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
>> +    cq_host = devm_kzalloc(&pdev->dev, sizeof(*cq_host), GFP_KERNEL);
>> +    if (!cq_host) {
>> +        dev_err(mmc_dev(host->mmc), "Unable to setup CQE: not enough 
>> memory\n");
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * For dwcmshc host controller we have to enable internal clock
>> +     * before access to some registers from Vendor Specific Aria 2.
>> +     */
>> +    clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>> +    clk |= SDHCI_CLOCK_INT_EN;
>> +    sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>> +    clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>> +    if (!(clk & SDHCI_CLOCK_INT_EN)) {
>> +        dev_err(mmc_dev(host->mmc), "Unable to setup CQE: internal 
>> clock enable error\n");
>> +        goto free_cq_host;
>> +    }
>> +
>> +    cq_host->mmio = host->ioaddr + priv->vendor_specific_area2;
>> +    cq_host->ops = &dwcmshc_cqhci_ops;
>> +
>> +    /* Enable using of 128-bit task descriptors */
>> +    dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
>> +    if (dma64) {
>> +        dev_dbg(mmc_dev(host->mmc), "128-bit task descriptors\n");
>> +        cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
>> +    }
>> +    err = cqhci_init(cq_host, host->mmc, dma64);
>> +    if (err) {
>> +        dev_err(mmc_dev(host->mmc), "Unable to setup CQE: error 
>> %d\n", err);
>> +        goto int_clock_disable;
>> +    }
>> +
>> +    dev_dbg(mmc_dev(host->mmc), "CQE init done\n");
>> +
>> +    return;
>> +
>> +int_clock_disable:
>> +    clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>> +    clk &= ~SDHCI_CLOCK_INT_EN;
>> +    sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>> +
>> +free_cq_host:
>> +    devm_kfree(&pdev->dev, cq_host);
>> +}
>> +
>> +
>>   static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct 
>> dwcmshc_priv *dwc_priv)
>>   {
>>       int err;
>> @@ -471,7 +632,7 @@ static int dwcmshc_probe(struct platform_device 
>> *pdev)
>>       struct rk35xx_priv *rk_priv = NULL;
>>       const struct sdhci_pltfm_data *pltfm_data;
>>       int err;
>> -    u32 extra;
>> +    u32 extra, caps;
>>         pltfm_data = device_get_match_data(&pdev->dev);
>>       if (!pltfm_data) {
>> @@ -519,9 +680,12 @@ static int dwcmshc_probe(struct platform_device 
>> *pdev)
>>         priv->vendor_specific_area1 =
>>           sdhci_readl(host, DWCMSHC_P_VENDOR_AREA1) & 
>> DWCMSHC_AREA1_MASK;
>> +    priv->vendor_specific_area2 =
>> +        sdhci_readw(host, DWCMSHC_P_VENDOR_AREA2);
>>         host->mmc_host_ops.request = dwcmshc_request;
>>       host->mmc_host_ops.hs400_enhanced_strobe = 
>> dwcmshc_hs400_enhanced_strobe;
>> +    host->mmc_host_ops.execute_tuning = dwcmshc_execute_tuning;
>>         if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
>>           rk_priv = devm_kzalloc(&pdev->dev, sizeof(struct 
>> rk35xx_priv), GFP_KERNEL);
>> @@ -547,6 +711,10 @@ static int dwcmshc_probe(struct platform_device 
>> *pdev)
>>           sdhci_enable_v4_mode(host);
>>   #endif
>>   +    caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>> +    if (caps & SDHCI_CAN_64BIT_V4)
>> +        sdhci_enable_v4_mode(host);
>> +
>>       host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>>         pm_runtime_get_noresume(dev);
>> @@ -557,6 +725,15 @@ static int dwcmshc_probe(struct platform_device 
>> *pdev)
>>       if (err)
>>           goto err_rpm;
>>   +    /* Setup Command Queue Engine if enabled */
>> +    if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
>> +        if (caps & SDHCI_CAN_64BIT_V4)
>> +            dwcmshc_cqhci_init(host, pdev);
>> +        else
>> +            dev_warn(dev, "Cannot enable CQE without V4 mode 
>> support\n");
>> +    }
>> +
>> +
>>       if (rk_priv)
>>           dwcmshc_rk35xx_postinit(host, priv);

