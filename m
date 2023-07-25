Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A267622BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjGYT4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGYT43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:56:29 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231001FF3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:56:26 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bbc7b2133fso3665535ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690314985; x=1690919785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7fn+g5SVM5/TVR6A9/+TfRK8MQLSGt6ds677hc73rRw=;
        b=GWPgF24TpcpAr/vdigenZ2GQta85arMUzNMGV/lGi5gvBTxa7detC8YIcxFtVrHPEP
         n/moNwtbrz3ooaaGTareRvWz9aPBSG7hibHHMxxawzNEICh4RXwJKF/L8eEvswR1Gn4i
         UExC5vY/a0KpvzGTiYqaiYMDfNVmQUnL/O6hEDkIgeQJZOGz4gxP5OGJAWWeuSPn/i5g
         amrXqleaJPiys8aMQTX5n5vkxTijXzis016ai45lS6JvB03EgSQnNi6AiaZ5jMKdk6k7
         sf0wnJV2W0oNmIW9LxOt6vbzFET24wgp+u1Ula3jyLrp8d5cVuUMPet8d8y2UsIdGJEF
         6sPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690314985; x=1690919785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fn+g5SVM5/TVR6A9/+TfRK8MQLSGt6ds677hc73rRw=;
        b=Vinm8v/C5hrbochvYRNxU/+bxITAKoLvFGh+4FdetOBu57Sw3cFucETwbWYcJQfqYo
         u6/RSYGWrctkIunL6TDbGqFioOvhm6Mk8oZzcLv5833VEc/zQF6Ht84WXVLUHXUtRQ2b
         2d/bh27/tX2BMIP0zzbON6MomDOxQZqL4YLdlZ65TAcbnVfZIHcWqlbHBMHsx3rTHuDU
         vA5WVhk8pAWhrhpGRI2eedg1gi5/n+qJtK0eRD+4hXBiuAYBnIJST3nD5z/13HqJNcYe
         C26dGCS2z7BY5gWgvktFM/KXqUZ/c+1gfljMWFsx3ZEqo6sJePjlavLKhpwI+bX8b2eg
         CPww==
X-Gm-Message-State: ABy/qLbModGgaqdULZYMxQB28r49NUL3T6KAfNkM+3uDQrhGblnlDTFj
        0c/E87MZIRYrgZJTD2LB4nxFvg==
X-Google-Smtp-Source: APBJJlE2vJeGxX0/rouk6QeAPjw+F+MntjweUpG+RUKh0k5PR9X3sKbyos6sssk9MsGN9IsrZY0Giw==
X-Received: by 2002:a17:902:d2c1:b0:1b5:edd:e3c7 with SMTP id n1-20020a170902d2c100b001b50edde3c7mr168517plc.16.1690314985497;
        Tue, 25 Jul 2023 12:56:25 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2116:2b1f:2fd8:ec8d])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902820d00b001b89f6550d1sm11455997pln.16.2023.07.25.12.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 12:56:24 -0700 (PDT)
Date:   Tue, 25 Jul 2023 13:56:22 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v15 05/13] remoteproc: mediatek: Extract SCP common
 registers
Message-ID: <ZMAo5sn4KnvfvSWq@p14s>
References: <20230721024132.6548-1-tinghan.shen@mediatek.com>
 <20230721024132.6548-6-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721024132.6548-6-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:41:24AM +0800, Tinghan Shen wrote:
> This is the 1st preliminary steps for probing multi-core SCP.
> The registers of config and l1tcm are common on single-core SCP
> and multi-core SCP. Extract these registers out to reduce duplicated
> fields in mtk_scp when probing multi-core SCP.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  drivers/remoteproc/mtk_common.h  |  13 +-
>  drivers/remoteproc/mtk_scp.c     | 201 +++++++++++++++++--------------
>  drivers/remoteproc/mtk_scp_ipi.c |   4 +-
>  3 files changed, 122 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> index c0905aec3b4b..b04d71277c1f 100644
> --- a/drivers/remoteproc/mtk_common.h
> +++ b/drivers/remoteproc/mtk_common.h
> @@ -100,17 +100,20 @@ struct mtk_scp_of_data {
>  	size_t ipi_buf_offset;
>  };
>  
> +struct mtk_scp_of_cluster {
> +	void __iomem *reg_base;
> +	void __iomem *l1tcm_base;
> +	size_t l1tcm_size;
> +	phys_addr_t l1tcm_phys;
> +};
> +

Ok

>  struct mtk_scp {
>  	struct device *dev;
>  	struct rproc *rproc;
>  	struct clk *clk;
> -	void __iomem *reg_base;
>  	void __iomem *sram_base;
>  	size_t sram_size;
>  	phys_addr_t sram_phys;
> -	void __iomem *l1tcm_base;
> -	size_t l1tcm_size;
> -	phys_addr_t l1tcm_phys;
> 

Ok

>  	const struct mtk_scp_of_data *data;
>  
> @@ -128,6 +131,8 @@ struct mtk_scp {
>  	size_t dram_size;
>  
>  	struct rproc_subdev *rpmsg_subdev;
> +
> +	struct mtk_scp_of_cluster *cluster;

Ok

>  };
>  
>  /**
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index 48e759c2d486..9486f5020946 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -152,45 +152,45 @@ static void mt8183_scp_reset_assert(struct mtk_scp *scp)
>  {
>  	u32 val;
>  
> -	val = readl(scp->reg_base + MT8183_SW_RSTN);
> +	val = readl(scp->cluster->reg_base + MT8183_SW_RSTN);
>  	val &= ~MT8183_SW_RSTN_BIT;
> -	writel(val, scp->reg_base + MT8183_SW_RSTN);
> +	writel(val, scp->cluster->reg_base + MT8183_SW_RSTN);
>  }
>  
>  static void mt8183_scp_reset_deassert(struct mtk_scp *scp)
>  {
>  	u32 val;
>  
> -	val = readl(scp->reg_base + MT8183_SW_RSTN);
> +	val = readl(scp->cluster->reg_base + MT8183_SW_RSTN);
>  	val |= MT8183_SW_RSTN_BIT;
> -	writel(val, scp->reg_base + MT8183_SW_RSTN);
> +	writel(val, scp->cluster->reg_base + MT8183_SW_RSTN);
>  }
>  
>  static void mt8192_scp_reset_assert(struct mtk_scp *scp)
>  {
> -	writel(1, scp->reg_base + MT8192_CORE0_SW_RSTN_SET);
> +	writel(1, scp->cluster->reg_base + MT8192_CORE0_SW_RSTN_SET);
>  }
>  
>  static void mt8192_scp_reset_deassert(struct mtk_scp *scp)
>  {
> -	writel(1, scp->reg_base + MT8192_CORE0_SW_RSTN_CLR);
> +	writel(1, scp->cluster->reg_base + MT8192_CORE0_SW_RSTN_CLR);
>  }
>  
>  static void mt8195_scp_c1_reset_assert(struct mtk_scp *scp)
>  {
> -	writel(1, scp->reg_base + MT8195_CORE1_SW_RSTN_SET);
> +	writel(1, scp->cluster->reg_base + MT8195_CORE1_SW_RSTN_SET);
>  }
>  
>  static void mt8195_scp_c1_reset_deassert(struct mtk_scp *scp)
>  {
> -	writel(1, scp->reg_base + MT8195_CORE1_SW_RSTN_CLR);
> +	writel(1, scp->cluster->reg_base + MT8195_CORE1_SW_RSTN_CLR);
>  }
>  
>  static void mt8183_scp_irq_handler(struct mtk_scp *scp)
>  {
>  	u32 scp_to_host;
>  
> -	scp_to_host = readl(scp->reg_base + MT8183_SCP_TO_HOST);
> +	scp_to_host = readl(scp->cluster->reg_base + MT8183_SCP_TO_HOST);
>  	if (scp_to_host & MT8183_SCP_IPC_INT_BIT)
>  		scp_ipi_handler(scp);
>  	else
> @@ -198,14 +198,14 @@ static void mt8183_scp_irq_handler(struct mtk_scp *scp)
>  
>  	/* SCP won't send another interrupt until we set SCP_TO_HOST to 0. */
>  	writel(MT8183_SCP_IPC_INT_BIT | MT8183_SCP_WDT_INT_BIT,
> -	       scp->reg_base + MT8183_SCP_TO_HOST);
> +	       scp->cluster->reg_base + MT8183_SCP_TO_HOST);
>  }
>  
>  static void mt8192_scp_irq_handler(struct mtk_scp *scp)
>  {
>  	u32 scp_to_host;
>  
> -	scp_to_host = readl(scp->reg_base + MT8192_SCP2APMCU_IPC_SET);
> +	scp_to_host = readl(scp->cluster->reg_base + MT8192_SCP2APMCU_IPC_SET);
>  
>  	if (scp_to_host & MT8192_SCP_IPC_INT_BIT) {
>  		scp_ipi_handler(scp);
> @@ -215,10 +215,10 @@ static void mt8192_scp_irq_handler(struct mtk_scp *scp)
>  		 * MT8192_SCP2APMCU_IPC.
>  		 */
>  		writel(MT8192_SCP_IPC_INT_BIT,
> -		       scp->reg_base + MT8192_SCP2APMCU_IPC_CLR);
> +		       scp->cluster->reg_base + MT8192_SCP2APMCU_IPC_CLR);
>  	} else {
>  		scp_wdt_handler(scp, scp_to_host);
> -		writel(1, scp->reg_base + MT8192_CORE0_WDT_IRQ);
> +		writel(1, scp->cluster->reg_base + MT8192_CORE0_WDT_IRQ);
>  	}
>  }
>  
> @@ -226,12 +226,12 @@ static void mt8195_scp_c1_irq_handler(struct mtk_scp *scp)
>  {
>  	u32 scp_to_host;
>  
> -	scp_to_host = readl(scp->reg_base + MT8195_SSHUB2APMCU_IPC_SET);
> +	scp_to_host = readl(scp->cluster->reg_base + MT8195_SSHUB2APMCU_IPC_SET);
>  
>  	if (scp_to_host & MT8192_SCP_IPC_INT_BIT)
>  		scp_ipi_handler(scp);
>  
> -	writel(scp_to_host, scp->reg_base + MT8195_SSHUB2APMCU_IPC_CLR);
> +	writel(scp_to_host, scp->cluster->reg_base + MT8195_SSHUB2APMCU_IPC_CLR);
>  }
>  
>  static irqreturn_t scp_irq_handler(int irq, void *priv)
> @@ -363,26 +363,26 @@ static int mt8195_scp_clk_get(struct mtk_scp *scp)
>  static int mt8183_scp_before_load(struct mtk_scp *scp)
>  {
>  	/* Clear SCP to host interrupt */
> -	writel(MT8183_SCP_IPC_INT_BIT, scp->reg_base + MT8183_SCP_TO_HOST);
> +	writel(MT8183_SCP_IPC_INT_BIT, scp->cluster->reg_base + MT8183_SCP_TO_HOST);
>  
>  	/* Reset clocks before loading FW */
> -	writel(0x0, scp->reg_base + MT8183_SCP_CLK_SW_SEL);
> -	writel(0x0, scp->reg_base + MT8183_SCP_CLK_DIV_SEL);
> +	writel(0x0, scp->cluster->reg_base + MT8183_SCP_CLK_SW_SEL);
> +	writel(0x0, scp->cluster->reg_base + MT8183_SCP_CLK_DIV_SEL);
>  
>  	/* Initialize TCM before loading FW. */
> -	writel(0x0, scp->reg_base + MT8183_SCP_L1_SRAM_PD);
> -	writel(0x0, scp->reg_base + MT8183_SCP_TCM_TAIL_SRAM_PD);
> +	writel(0x0, scp->cluster->reg_base + MT8183_SCP_L1_SRAM_PD);
> +	writel(0x0, scp->cluster->reg_base + MT8183_SCP_TCM_TAIL_SRAM_PD);
>  
>  	/* Turn on the power of SCP's SRAM before using it. */
> -	writel(0x0, scp->reg_base + MT8183_SCP_SRAM_PDN);
> +	writel(0x0, scp->cluster->reg_base + MT8183_SCP_SRAM_PDN);
>  
>  	/*
>  	 * Set I-cache and D-cache size before loading SCP FW.
>  	 * SCP SRAM logical address may change when cache size setting differs.
>  	 */
>  	writel(MT8183_SCP_CACHE_CON_WAYEN | MT8183_SCP_CACHESIZE_8KB,
> -	       scp->reg_base + MT8183_SCP_CACHE_CON);
> -	writel(MT8183_SCP_CACHESIZE_8KB, scp->reg_base + MT8183_SCP_DCACHE_CON);
> +	       scp->cluster->reg_base + MT8183_SCP_CACHE_CON);
> +	writel(MT8183_SCP_CACHESIZE_8KB, scp->cluster->reg_base + MT8183_SCP_DCACHE_CON);
>  
>  	return 0;
>  }
> @@ -408,28 +408,28 @@ static void scp_sram_power_off(void __iomem *addr, u32 reserved_mask)
>  static int mt8186_scp_before_load(struct mtk_scp *scp)
>  {
>  	/* Clear SCP to host interrupt */
> -	writel(MT8183_SCP_IPC_INT_BIT, scp->reg_base + MT8183_SCP_TO_HOST);
> +	writel(MT8183_SCP_IPC_INT_BIT, scp->cluster->reg_base + MT8183_SCP_TO_HOST);
>  
>  	/* Reset clocks before loading FW */
> -	writel(0x0, scp->reg_base + MT8183_SCP_CLK_SW_SEL);
> -	writel(0x0, scp->reg_base + MT8183_SCP_CLK_DIV_SEL);
> +	writel(0x0, scp->cluster->reg_base + MT8183_SCP_CLK_SW_SEL);
> +	writel(0x0, scp->cluster->reg_base + MT8183_SCP_CLK_DIV_SEL);
>  
>  	/* Turn on the power of SCP's SRAM before using it. Enable 1 block per time*/
> -	scp_sram_power_on(scp->reg_base + MT8183_SCP_SRAM_PDN, 0);
> +	scp_sram_power_on(scp->cluster->reg_base + MT8183_SCP_SRAM_PDN, 0);
>  
>  	/* Initialize TCM before loading FW. */
> -	writel(0x0, scp->reg_base + MT8183_SCP_L1_SRAM_PD);
> -	writel(0x0, scp->reg_base + MT8183_SCP_TCM_TAIL_SRAM_PD);
> -	writel(0x0, scp->reg_base + MT8186_SCP_L1_SRAM_PD_P1);
> -	writel(0x0, scp->reg_base + MT8186_SCP_L1_SRAM_PD_p2);
> +	writel(0x0, scp->cluster->reg_base + MT8183_SCP_L1_SRAM_PD);
> +	writel(0x0, scp->cluster->reg_base + MT8183_SCP_TCM_TAIL_SRAM_PD);
> +	writel(0x0, scp->cluster->reg_base + MT8186_SCP_L1_SRAM_PD_P1);
> +	writel(0x0, scp->cluster->reg_base + MT8186_SCP_L1_SRAM_PD_p2);
>  
>  	/*
>  	 * Set I-cache and D-cache size before loading SCP FW.
>  	 * SCP SRAM logical address may change when cache size setting differs.
>  	 */
>  	writel(MT8183_SCP_CACHE_CON_WAYEN | MT8183_SCP_CACHESIZE_8KB,
> -	       scp->reg_base + MT8183_SCP_CACHE_CON);
> -	writel(MT8183_SCP_CACHESIZE_8KB, scp->reg_base + MT8183_SCP_DCACHE_CON);
> +	       scp->cluster->reg_base + MT8183_SCP_CACHE_CON);
> +	writel(MT8183_SCP_CACHESIZE_8KB, scp->cluster->reg_base + MT8183_SCP_DCACHE_CON);
>  
>  	return 0;
>  }
> @@ -437,19 +437,19 @@ static int mt8186_scp_before_load(struct mtk_scp *scp)
>  static int mt8192_scp_before_load(struct mtk_scp *scp)
>  {
>  	/* clear SPM interrupt, SCP2SPM_IPC_CLR */
> -	writel(0xff, scp->reg_base + MT8192_SCP2SPM_IPC_CLR);
> +	writel(0xff, scp->cluster->reg_base + MT8192_SCP2SPM_IPC_CLR);
>  
> -	writel(1, scp->reg_base + MT8192_CORE0_SW_RSTN_SET);
> +	writel(1, scp->cluster->reg_base + MT8192_CORE0_SW_RSTN_SET);
>  
>  	/* enable SRAM clock */
> -	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> -	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> -	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> -	scp_sram_power_on(scp->reg_base + MT8192_L1TCM_SRAM_PDN, 0);
> -	scp_sram_power_on(scp->reg_base + MT8192_CPU0_SRAM_PD, 0);
> +	scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> +	scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> +	scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> +	scp_sram_power_on(scp->cluster->reg_base + MT8192_L1TCM_SRAM_PDN, 0);
> +	scp_sram_power_on(scp->cluster->reg_base + MT8192_CPU0_SRAM_PD, 0);
>  
>  	/* enable MPU for all memory regions */
> -	writel(0xff, scp->reg_base + MT8192_CORE0_MEM_ATT_PREDEF);
> +	writel(0xff, scp->cluster->reg_base + MT8192_CORE0_MEM_ATT_PREDEF);
>  
>  	return 0;
>  }
> @@ -457,20 +457,20 @@ static int mt8192_scp_before_load(struct mtk_scp *scp)
>  static int mt8195_scp_before_load(struct mtk_scp *scp)
>  {
>  	/* clear SPM interrupt, SCP2SPM_IPC_CLR */
> -	writel(0xff, scp->reg_base + MT8192_SCP2SPM_IPC_CLR);
> +	writel(0xff, scp->cluster->reg_base + MT8192_SCP2SPM_IPC_CLR);
>  
> -	writel(1, scp->reg_base + MT8192_CORE0_SW_RSTN_SET);
> +	writel(1, scp->cluster->reg_base + MT8192_CORE0_SW_RSTN_SET);
>  
>  	/* enable SRAM clock */
> -	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> -	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> -	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> -	scp_sram_power_on(scp->reg_base + MT8192_L1TCM_SRAM_PDN,
> +	scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> +	scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> +	scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> +	scp_sram_power_on(scp->cluster->reg_base + MT8192_L1TCM_SRAM_PDN,
>  			  MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);
> -	scp_sram_power_on(scp->reg_base + MT8192_CPU0_SRAM_PD, 0);
> +	scp_sram_power_on(scp->cluster->reg_base + MT8192_CPU0_SRAM_PD, 0);
>  
>  	/* enable MPU for all memory regions */
> -	writel(0xff, scp->reg_base + MT8192_CORE0_MEM_ATT_PREDEF);
> +	writel(0xff, scp->cluster->reg_base + MT8192_CORE0_MEM_ATT_PREDEF);
>  
>  	return 0;
>  }
> @@ -479,10 +479,10 @@ static int mt8195_scp_c1_before_load(struct mtk_scp *scp)
>  {
>  	scp->data->scp_reset_assert(scp);
>  
> -	scp_sram_power_on(scp->reg_base + MT8195_CPU1_SRAM_PD, 0);
> +	scp_sram_power_on(scp->cluster->reg_base + MT8195_CPU1_SRAM_PD, 0);
>  
>  	/* enable MPU for all memory regions */
> -	writel(0xff, scp->reg_base + MT8195_CORE1_MEM_ATT_PREDEF);
> +	writel(0xff, scp->cluster->reg_base + MT8195_CORE1_MEM_ATT_PREDEF);
>  
>  	return 0;
>  }
> @@ -601,11 +601,11 @@ static void *mt8192_scp_da_to_va(struct mtk_scp *scp, u64 da, size_t len)
>  	}
>  
>  	/* optional memory region */
> -	if (scp->l1tcm_size &&
> -	    da >= scp->l1tcm_phys &&
> -	    (da + len) <= scp->l1tcm_phys + scp->l1tcm_size) {
> -		offset = da - scp->l1tcm_phys;
> -		return (void __force *)scp->l1tcm_base + offset;
> +	if (scp->cluster->l1tcm_size &&
> +	    da >= scp->cluster->l1tcm_phys &&
> +	    (da + len) <= scp->cluster->l1tcm_phys + scp->cluster->l1tcm_size) {
> +		offset = da - scp->cluster->l1tcm_phys;
> +		return (void __force *)scp->cluster->l1tcm_base + offset;
>  	}
>  
>  	/* optional memory region */
> @@ -629,43 +629,43 @@ static void *scp_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iome
>  static void mt8183_scp_stop(struct mtk_scp *scp)
>  {
>  	/* Disable SCP watchdog */
> -	writel(0, scp->reg_base + MT8183_WDT_CFG);
> +	writel(0, scp->cluster->reg_base + MT8183_WDT_CFG);
>  }
>  
>  static void mt8192_scp_stop(struct mtk_scp *scp)
>  {
>  	/* Disable SRAM clock */
> -	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> -	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> -	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> -	scp_sram_power_off(scp->reg_base + MT8192_L1TCM_SRAM_PDN, 0);
> -	scp_sram_power_off(scp->reg_base + MT8192_CPU0_SRAM_PD, 0);
> +	scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> +	scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> +	scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> +	scp_sram_power_off(scp->cluster->reg_base + MT8192_L1TCM_SRAM_PDN, 0);
> +	scp_sram_power_off(scp->cluster->reg_base + MT8192_CPU0_SRAM_PD, 0);
>  
>  	/* Disable SCP watchdog */
> -	writel(0, scp->reg_base + MT8192_CORE0_WDT_CFG);
> +	writel(0, scp->cluster->reg_base + MT8192_CORE0_WDT_CFG);
>  }
>  
>  static void mt8195_scp_stop(struct mtk_scp *scp)
>  {
>  	/* Disable SRAM clock */
> -	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> -	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> -	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> -	scp_sram_power_off(scp->reg_base + MT8192_L1TCM_SRAM_PDN,
> +	scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> +	scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> +	scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> +	scp_sram_power_off(scp->cluster->reg_base + MT8192_L1TCM_SRAM_PDN,
>  			   MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);
> -	scp_sram_power_off(scp->reg_base + MT8192_CPU0_SRAM_PD, 0);
> +	scp_sram_power_off(scp->cluster->reg_base + MT8192_CPU0_SRAM_PD, 0);
>  
>  	/* Disable SCP watchdog */
> -	writel(0, scp->reg_base + MT8192_CORE0_WDT_CFG);
> +	writel(0, scp->cluster->reg_base + MT8192_CORE0_WDT_CFG);
>  }
>  
>  static void mt8195_scp_c1_stop(struct mtk_scp *scp)
>  {
>  	/* Power off CPU SRAM */
> -	scp_sram_power_off(scp->reg_base + MT8195_CPU1_SRAM_PD, 0);
> +	scp_sram_power_off(scp->cluster->reg_base + MT8195_CPU1_SRAM_PD, 0);
>  
>  	/* Disable SCP watchdog */
> -	writel(0, scp->reg_base + MT8195_CORE1_WDT_CFG);
> +	writel(0, scp->cluster->reg_base + MT8195_CORE1_WDT_CFG);
>  }
>  
>  static int scp_stop(struct rproc *rproc)
> @@ -854,7 +854,8 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
>  	}
>  }
>  
> -static int scp_probe(struct platform_device *pdev)
> +static int scp_cluster_init(struct platform_device *pdev,
> +			    struct mtk_scp_of_cluster *scp_cluster)

Why is the mtk_scp and mtk_scp_of_cluster structure refactoring entangled with
scp_probe()?  Just add another patch to prepare the upcoming work, exactly the
same way pach 04/13 does.

>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
> @@ -876,6 +877,7 @@ static int scp_probe(struct platform_device *pdev)
>  	scp->rproc = rproc;
>  	scp->dev = dev;
>  	scp->data = of_device_get_match_data(dev);
> +	scp->cluster = scp_cluster;
>  	platform_set_drvdata(pdev, scp);
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
> @@ -887,24 +889,6 @@ static int scp_probe(struct platform_device *pdev)
>  	scp->sram_size = resource_size(res);
>  	scp->sram_phys = res->start;
>  
> -	/* l1tcm is an optional memory region */
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "l1tcm");
> -	scp->l1tcm_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(scp->l1tcm_base)) {
> -		ret = PTR_ERR(scp->l1tcm_base);
> -		if (ret != -EINVAL) {
> -			return dev_err_probe(dev, ret, "Failed to map l1tcm memory\n");
> -		}
> -	} else {
> -		scp->l1tcm_size = resource_size(res);
> -		scp->l1tcm_phys = res->start;
> -	}
> -
> -	scp->reg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
> -	if (IS_ERR(scp->reg_base))
> -		return dev_err_probe(dev, PTR_ERR(scp->reg_base),
> -				     "Failed to parse and map cfg memory\n");
> -
>  	ret = scp->data->scp_clk_get(scp);
>  	if (ret)
>  		return ret;
> @@ -956,6 +940,43 @@ static int scp_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int scp_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mtk_scp_of_cluster *scp_cluster;
> +	struct resource *res;
> +	int ret;
> +
> +	scp_cluster = devm_kzalloc(dev, sizeof(*scp_cluster), GFP_KERNEL);
> +	if (!scp_cluster)
> +		return -ENOMEM;
> +
> +	scp_cluster->reg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
> +	if (IS_ERR(scp_cluster->reg_base))
> +		return dev_err_probe(dev, PTR_ERR(scp_cluster->reg_base),
> +				     "Failed to parse and map cfg memory\n");
> +
> +	/* l1tcm is an optional memory region */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "l1tcm");
> +	scp_cluster->l1tcm_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(scp_cluster->l1tcm_base)) {
> +		ret = PTR_ERR(scp_cluster->l1tcm_base);
> +		if (ret != -EINVAL)
> +			return dev_err_probe(dev, ret, "Failed to map l1tcm memory\n");
> +
> +		scp_cluster->l1tcm_base = NULL;
> +	} else {
> +		scp_cluster->l1tcm_size = resource_size(res);
> +		scp_cluster->l1tcm_phys = res->start;
> +	}
> +
> +	ret = scp_cluster_init(pdev, scp_cluster);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static void scp_remove(struct platform_device *pdev)
>  {
>  	struct mtk_scp *scp = platform_get_drvdata(pdev);
> diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
> index 9c7c17b9d181..cd0b60106ec2 100644
> --- a/drivers/remoteproc/mtk_scp_ipi.c
> +++ b/drivers/remoteproc/mtk_scp_ipi.c
> @@ -177,7 +177,7 @@ int scp_ipi_send(struct mtk_scp *scp, u32 id, void *buf, unsigned int len,
>  	mutex_lock(&scp->send_lock);
>  
>  	 /* Wait until SCP receives the last command */
> -	ret = readl_poll_timeout_atomic(scp->reg_base + scp->data->host_to_scp_reg,
> +	ret = readl_poll_timeout_atomic(scp->cluster->reg_base + scp->data->host_to_scp_reg,
>  					val, !val, 0, SCP_TIMEOUT_US);
>  	if (ret) {
>  		dev_err(scp->dev, "%s: IPI timeout!\n", __func__);
> @@ -192,7 +192,7 @@ int scp_ipi_send(struct mtk_scp *scp, u32 id, void *buf, unsigned int len,
>  	scp->ipi_id_ack[id] = false;
>  	/* send the command to SCP */
>  	writel(scp->data->host_to_scp_int_bit,
> -	       scp->reg_base + scp->data->host_to_scp_reg);
> +	       scp->cluster->reg_base + scp->data->host_to_scp_reg);
>  
>  	if (wait) {
>  		/* wait for SCP's ACK */
> -- 
> 2.18.0
> 
