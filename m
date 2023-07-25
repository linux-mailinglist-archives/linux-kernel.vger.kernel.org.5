Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22687622F4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjGYUFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjGYUFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:05:46 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BCC1FFC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:05:44 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666edfc50deso172107b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690315544; x=1690920344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LFAdcXQq2TbouVe/mhNRHhN8yEAUVW7zlofTPbemmaQ=;
        b=SpbOLV6hmgXaXShe5PIT+d3dvOUDu7fuESHBtgRBLBcZsMjOJr4K5qt9EeSCxNzHZv
         CfSSMci5zM1EHX4We1Hlg03rP0QdgpwqTZXf6doFcUMQZPEl+xe0mw92Lr+O1mC4w5r1
         Nxv/2ZAM3HjHF7f8dRNYaOmUw3CaCxW0UyrIYraNe0Gsq6fWAX3xnwRFpEYJK1I8QAUz
         dfCUt84sYToB9bp6XYUinRKnv6+jz+7zKgpcUYVWduclNGN1VNbI5VtvQJek4CzfBCXQ
         v3BcImtrCDMMNqDLSAWTrqJchH0Tai2h0xXI6hpfBpbb3gtunK0LqFD9fKspPxUgro1A
         8v0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690315544; x=1690920344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFAdcXQq2TbouVe/mhNRHhN8yEAUVW7zlofTPbemmaQ=;
        b=MSMOKWzJr0aw1nPqt+eUuhm5Z++o+D//X7Xd5TmxsiJFQ5/QmR3USFcnyHEeXAtFUE
         A4plOdbGXWHTEyty7UZ9A95R72GlUvbDB1p62zaSuv9OnFCpajJ0h9ChR7qearjjJCtK
         l14rKWxxQBd/2X1nJdZAYtDNstbgKxhXbKDVJuHu3iDLf7u0UTg8doMqjd+eD5G8djtK
         wNfoRAmwbhTDKZTBbNZ8/O6iYkpe/LqqEGlsrU+/OjBAzRhj6X3wag150RNukE4mFWEr
         e/qLVCYuKnUrGdV4M4XcCmHuVcWx3kOi3T6rZEoHNEwPSlIuXt590wiz5UTLVVcxPwJX
         gpzw==
X-Gm-Message-State: ABy/qLbWKNSJ+WeNwfUAN6/97FX5cGoMPK+4FkIdFxa3CuSnyN/YpYq8
        KCc2hrHpoI9jNxaoDb2nXlMGQQ==
X-Google-Smtp-Source: APBJJlH0XpWJCxlu0n3SaBiolZbr7Vn8DktJDCGrpC7bf4UzXUjX0SjLrqRDh6fvkUKYscx7Hj9ZnA==
X-Received: by 2002:a05:6a20:6a1a:b0:133:6696:1db with SMTP id p26-20020a056a206a1a00b00133669601dbmr176622pzk.29.1690315543962;
        Tue, 25 Jul 2023 13:05:43 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2116:2b1f:2fd8:ec8d])
        by smtp.gmail.com with ESMTPSA id p13-20020a62ab0d000000b00686bdff1d6fsm193249pff.77.2023.07.25.13.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 13:05:43 -0700 (PDT)
Date:   Tue, 25 Jul 2023 14:05:40 -0600
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
Subject: Re: [PATCH v15 08/13] remoteproc: mediatek: Remove dependency of
 MT8195 SCP L2TCM power control on dual-core SCP
Message-ID: <ZMArFGTabcc2j6i9@p14s>
References: <20230721024132.6548-1-tinghan.shen@mediatek.com>
 <20230721024132.6548-9-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721024132.6548-9-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:41:27AM +0800, Tinghan Shen wrote:
> Previously, SCP core 0 controlled the power of L2TCM and dictated that
> SCP core 1 could only boot after SCP core 0. To address this constraint,
> extracted the power control flow of L2TCM and made it shared
> between both cores, enabling support of arbitrary boot order.
>

s/of/for

> The flow for controlling L2TCM power has been incorporated into the
> mt8195_scp_before_load() and mt8195_scp_stop() APIs, which are
> respectively invoked during the rproc->ops->start() and
> rproc->ops->stop() operations. These APIs effectively serve the same
> purpose as the rproc prepare()/unprepare() APIs."
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  drivers/remoteproc/mtk_common.h |  3 ++
>  drivers/remoteproc/mtk_scp.c    | 71 ++++++++++++++++++++++++++-------
>  2 files changed, 59 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> index 1438159ae736..fea05bbba9aa 100644
> --- a/drivers/remoteproc/mtk_common.h
> +++ b/drivers/remoteproc/mtk_common.h
> @@ -106,6 +106,9 @@ struct mtk_scp_of_cluster {
>  	size_t l1tcm_size;
>  	phys_addr_t l1tcm_phys;
>  	struct list_head mtk_scp_list;
> +	/* Prevent concurrent operations of this structure and L2TCM power control. */
> +	struct mutex cluster_lock;
> +	u32 l2tcm_refcnt;
>  };
>  
>  struct mtk_scp {
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index 34095a461e15..c624f9c3db17 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -454,19 +454,37 @@ static int mt8192_scp_before_load(struct mtk_scp *scp)
>  	return 0;
>  }
>  
> -static int mt8195_scp_before_load(struct mtk_scp *scp)
> +static int mt8195_scp_l2tcm_on(struct mtk_scp *scp)
>  {
> -	/* clear SPM interrupt, SCP2SPM_IPC_CLR */
> -	writel(0xff, scp->cluster->reg_base + MT8192_SCP2SPM_IPC_CLR);
> +	struct mtk_scp_of_cluster *scp_cluster = scp->cluster;
> +
> +	mutex_lock(&scp_cluster->cluster_lock);
> +
> +	if (scp_cluster->l2tcm_refcnt == 0) {
> +		/* clear SPM interrupt, SCP2SPM_IPC_CLR */
> +		writel(0xff, scp->cluster->reg_base + MT8192_SCP2SPM_IPC_CLR);
> +
> +		/* Power on L2TCM */
> +		scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> +		scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> +		scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> +		scp_sram_power_on(scp->cluster->reg_base + MT8192_L1TCM_SRAM_PDN,
> +				  MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);
> +	}
> +
> +	scp_cluster->l2tcm_refcnt += 1;
>  
> +	mutex_unlock(&scp_cluster->cluster_lock);
> +
> +	return 0;
> +}
> +
> +static int mt8195_scp_before_load(struct mtk_scp *scp)
> +{
>  	writel(1, scp->cluster->reg_base + MT8192_CORE0_SW_RSTN_SET);
>  
> -	/* enable SRAM clock */
> -	scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> -	scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> -	scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> -	scp_sram_power_on(scp->cluster->reg_base + MT8192_L1TCM_SRAM_PDN,
> -			  MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);
> +	mt8195_scp_l2tcm_on(scp);
> +
>  	scp_sram_power_on(scp->cluster->reg_base + MT8192_CPU0_SRAM_PD, 0);
>  
>  	/* enable MPU for all memory regions */
> @@ -479,6 +497,8 @@ static int mt8195_scp_c1_before_load(struct mtk_scp *scp)
>  {
>  	scp->data->scp_reset_assert(scp);
>  
> +	mt8195_scp_l2tcm_on(scp);
> +
>  	scp_sram_power_on(scp->cluster->reg_base + MT8195_CPU1_SRAM_PD, 0);
>  
>  	/* enable MPU for all memory regions */
> @@ -645,14 +665,31 @@ static void mt8192_scp_stop(struct mtk_scp *scp)
>  	writel(0, scp->cluster->reg_base + MT8192_CORE0_WDT_CFG);
>  }
>  
> +static void mt8195_scp_l2tcm_off(struct mtk_scp *scp)
> +{
> +	struct mtk_scp_of_cluster *scp_cluster = scp->cluster;
> +
> +	mutex_lock(&scp_cluster->cluster_lock);
> +
> +	if (scp_cluster->l2tcm_refcnt > 0)
> +		scp_cluster->l2tcm_refcnt -= 1;
> +
> +	if (scp_cluster->l2tcm_refcnt == 0) {
> +		/* Power off L2TCM */
> +		scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> +		scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> +		scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> +		scp_sram_power_off(scp->cluster->reg_base + MT8192_L1TCM_SRAM_PDN,
> +				   MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);
> +	}
> +
> +	mutex_unlock(&scp_cluster->cluster_lock);
> +}
> +
>  static void mt8195_scp_stop(struct mtk_scp *scp)
>  {
> -	/* Disable SRAM clock */
> -	scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> -	scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> -	scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> -	scp_sram_power_off(scp->cluster->reg_base + MT8192_L1TCM_SRAM_PDN,
> -			   MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);
> +	mt8195_scp_l2tcm_off(scp);
> +
>  	scp_sram_power_off(scp->cluster->reg_base + MT8192_CPU0_SRAM_PD, 0);
>  
>  	/* Disable SCP watchdog */
> @@ -661,6 +698,8 @@ static void mt8195_scp_stop(struct mtk_scp *scp)
>  
>  static void mt8195_scp_c1_stop(struct mtk_scp *scp)
>  {
> +	mt8195_scp_l2tcm_off(scp);
> +
>  	/* Power off CPU SRAM */
>  	scp_sram_power_off(scp->cluster->reg_base + MT8195_CPU1_SRAM_PD, 0);
>  
> @@ -1103,6 +1142,7 @@ static int scp_probe(struct platform_device *pdev)
>  	}
>  
>  	INIT_LIST_HEAD(&scp_cluster->mtk_scp_list);
> +	mutex_init(&scp_cluster->cluster_lock);
>  
>  	ret = devm_of_platform_populate(dev);
>  	if (ret)
> @@ -1126,6 +1166,7 @@ static void scp_remove(struct platform_device *pdev)
>  		rproc_del(scp->rproc);
>  		scp_free(scp);
>  	}
> +	mutex_destroy(&scp_cluster->cluster_lock);
>  }
>  
>  static const struct mtk_scp_of_data mt8183_of_data = {
> -- 
> 2.18.0
> 
