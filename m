Return-Path: <linux-kernel+bounces-18981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCA78265F6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF681C2157B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 20:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C442511739;
	Sun,  7 Jan 2024 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDO0NDbu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8036D11700;
	Sun,  7 Jan 2024 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cd053d5683so12399381fa.2;
        Sun, 07 Jan 2024 12:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704659930; x=1705264730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rWIKvi1hnVUw865j4JFaimjjwkxSfRuC7mbyHpWGOpM=;
        b=YDO0NDbu3elSTD2vkS+8CifYqNyHYrWjZN9LuNtVrI08RW3FetlNE1LeSgh5H2QM+B
         Szjw1T3pHuRdsRJFbB/cW6SdiDqbE9YyHV4ZXWfaZJC3Jqh5iJqjxvafBipwdNKFMCdk
         AgIsyx32lyaIcpF1PhRM2Gu7tKVv1SOIGsdfRBh2LJR60q5qlGgUI0zOp3CxGJxjQHE8
         RZKnj57wn5aFIadogTT+u6TAHj30ujYWZe4tF/XqGTr5ppwJbJZW+0z5IzNgaZFGrt7T
         et3SRIVtWL/Y06MoqtvPuhC1BdlFJtVtJpzzpcf7Y1X1DZY3jmq1K4Gf8qE+42R/KfR5
         zp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704659930; x=1705264730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWIKvi1hnVUw865j4JFaimjjwkxSfRuC7mbyHpWGOpM=;
        b=ej2VUfyveZbODMwf2GUHyopWHcokTSqtL51i0EWZqD5edfj0No6ylyhW1qDH3RBC7q
         4vMxDIWMcKsapjv3paE0k5n4/WywqE6HIWna6r7wqLUetYFdccZEjpnjBCL5+yRgOw5T
         XhaWHM7j2C2J2Yp593cs9WW/4GSTTAKS1tXUS1yH32lN7zMOnGyQnHaTDllDfLIr+2qv
         HUxT0oA+s+2pQ6K9nbY1Kymap6+hQzf7OZUzGcPLx+rB3SeGJ+5xh6yJiu9cemrT1SK8
         /cHxVKKDgp7sh68tIRgkBuTGxrzovgkrE9JPWGHzLvtBEV1nDfbSMk/cI6nxbDTHMDNm
         xJZQ==
X-Gm-Message-State: AOJu0YwSoUCK+w6qhkhy3T3s5mPXIcjnwRV5FlagDxoJv77RZwUOZaHQ
	XeKyDEyw/2rjVYnXPCb2VbI=
X-Google-Smtp-Source: AGHT+IGf/Yyv7wSMS0i9F/tpUZxtbrw3bOb3lTUoMOnmKCIdtuSDBq6EtPRjB7mAxRnLhJyTVDlImQ==
X-Received: by 2002:ac2:5fa6:0:b0:50e:698c:2d93 with SMTP id s6-20020ac25fa6000000b0050e698c2d93mr685779lfe.57.1704659930101;
        Sun, 07 Jan 2024 12:38:50 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id w10-20020ac2598a000000b0050e7e38c9e0sm918192lfn.62.2024.01.07.12.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 12:38:49 -0800 (PST)
Date: Sun, 7 Jan 2024 23:38:46 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Leong Ching Swee <leong.ching.swee@intel.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	Teoh Ji Sheng <ji.sheng.teoh@intel.com>
Subject: Re: [PATCH net-next v2 3/4] net: stmmac: Add support for TX/RX
 channel interrupt
Message-ID: <xybq2523vgod6rbefw4zjs2kb2xtfmizecdwdjzyl6l2iovjqq@o3q4t2qny55o>
References: <20240105070925.2948871-1-leong.ching.swee@intel.com>
 <20240105070925.2948871-4-leong.ching.swee@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105070925.2948871-4-leong.ching.swee@intel.com>

On Fri, Jan 05, 2024 at 03:09:24PM +0800, Leong Ching Swee wrote:
> From: Swee Leong Ching <leong.ching.swee@intel.com>
> 
> Enable TX/RX channel interrupt registration for MAC that interrupts CPU
> through shared peripheral interrupt (SPI).
> 
> Per channel interrupts and interrupt-names are registered through,
> Eg: 4 tx and 4 rx channels:
> interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
>              <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
>              <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
>              <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
>              <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
>              <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
>              <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
>              <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> interrupt-names = "dma_tx0",
>                   "dma_tx1",
>                   "dma_tx2",
>                   "dma_tx3",
>                   "dma_rx0",
>                   "dma_rx1",
>                   "dma_rx2",
>                   "dma_rx3";
> 
> Signed-off-by: Teoh Ji Sheng <ji.sheng.teoh@intel.com>
> Signed-off-by: Swee Leong Ching <leong.ching.swee@intel.com>
> ---
>  .../ethernet/stmicro/stmmac/stmmac_platform.c | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 70eadc83ca68..ae6859153e98 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -710,6 +710,10 @@ EXPORT_SYMBOL_GPL(devm_stmmac_probe_config_dt);
>  int stmmac_get_platform_resources(struct platform_device *pdev,
>  				  struct stmmac_resources *stmmac_res)
>  {

> +	char irq_name[9];
> +	int i;
> +	int irq;
> +

Reverse xmas tree please. Also what the point in having "i" and "irq"
defined separately? Wouldn't it be better to merge them into a single
statement:
+	char irq_name[9];
+	int i, irq;

>  	memset(stmmac_res, 0, sizeof(*stmmac_res));
>  
>  	/* Get IRQ information early to have an ability to ask for deferred
> @@ -743,6 +747,30 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
>  		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
>  	}
>  

> +	/* For RX Channel */

Why haven't you added a more descriptive comment as I suggested on v1:

+	/* Get optional Tx/Rx DMA per-channel IRQs, which otherwise
+	 * are supposed to be delivered via the common MAC IRQ line
+	 */

?

> +	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
> +		snprintf(irq_name, sizeof(irq_name), "dma_rx%i", i);
> +		irq = platform_get_irq_byname_optional(pdev, irq_name);
> +		if (irq == -EPROBE_DEFER)
> +			return irq;
> +		else if (irq < 0)
> +			break;
> +
> +		stmmac_res->rx_irq[i] = irq;
> +	}
> +

> +	/* For TX Channel */

* see the comment above

-Serge(y)

> +	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
> +		snprintf(irq_name, sizeof(irq_name), "dma_tx%i", i);
> +		irq = platform_get_irq_byname_optional(pdev, irq_name);
> +		if (irq == -EPROBE_DEFER)
> +			return irq;
> +		else if (irq < 0)
> +			break;
> +
> +		stmmac_res->tx_irq[i] = irq;
> +	}
> +
>  	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
>  
>  	return PTR_ERR_OR_ZERO(stmmac_res->addr);
> -- 
> 2.34.1
> 
> 

