Return-Path: <linux-kernel+bounces-10069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5810581CF8D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AFE4B20D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 21:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5667F2EAFA;
	Fri, 22 Dec 2023 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRVPH0uO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150A22E857;
	Fri, 22 Dec 2023 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cca5d81826so21267121fa.2;
        Fri, 22 Dec 2023 13:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703281755; x=1703886555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy+I7LnjOAXPaFtrmXfqjIk/V4/7h6p6CdTlzhvcUuQ=;
        b=gRVPH0uOUYfREW1NybyulRSScJ8jsegIRjoFiKNkLQ+sETJAeKputrMfV8NhSiwOWA
         ruGOTOgthByRsTza0rNRAtG13prKkx/dBHC5xMStiullspuhSzbl4FwuOkgBg8NQX7NN
         NQ9phinCku9CqceIZSCsMejXO6baDaBslG70lmgd1AG1Ay48p+57wbPUQkQ0WVCMLS0O
         mcve5jx5a5ROwQqRXrJoFwht259uQHDwpjQn9PR5DOBsnnzX/EqAZlxx2unU+SB/CBKI
         MM9V3o1kjxRo8OqZLyU3CTgfIWZoROAXPZ742S9mPsQZF4Wr3Oykm9YSLv/co11CTyfK
         EUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703281755; x=1703886555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vy+I7LnjOAXPaFtrmXfqjIk/V4/7h6p6CdTlzhvcUuQ=;
        b=e1MANfAlE6m35wzXeRKoVnkk9VRsg74TDSi2zne3aPz9QnBZO5xl1eE6H6q42bGZnq
         scSAm6MEcBUNiD6cCuN0mVUZmqdZWNAHlsbLUjMysVTo76dhhQeJrU/l/O9Z6o2ObhO7
         dNUyYqNmG4rnC2OWbiUf5o+DcfJBOs6NKR96ASYNbg0PLjxbD4jMehcmKWEKzMgt/nd3
         0UgDtbbs6WMBYX28pp/sGid/2wIvFYNPSA/sjqL2WtEBd/2075W2X+yPzxNs4mtP15Bu
         YuRCrUpQI9S23QePjvfmajXhkUG8MS5YN4uCbZL0qWEc5PTiW9WWVDmBbISTEhjavlYO
         V+Lw==
X-Gm-Message-State: AOJu0YwbH5renU6mH6BVIz+q+TSZwb5LjKZ5A/482Co+dgcS3xiUU+px
	8PuVz7mLE+ZkxKYvSe2R95E=
X-Google-Smtp-Source: AGHT+IFa9n/ld3l+fvWjT1a659p1CwK1uQUNIgQVx9mR3Q1BIRhe7l9cxDlBDhzqjXJN1Wj785LXQw==
X-Received: by 2002:a2e:6a16:0:b0:2cc:1dac:fe2a with SMTP id f22-20020a2e6a16000000b002cc1dacfe2amr1135192ljc.64.1703281754750;
        Fri, 22 Dec 2023 13:49:14 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id bd7-20020a05651c168700b002cc70f6ce25sm744700ljb.14.2023.12.22.13.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 13:49:14 -0800 (PST)
Date: Sat, 23 Dec 2023 00:49:10 +0300
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
Subject: Re: [PATCH net-next v1 3/4] net: stmmac: Add support for TX/RX
 channel interrupt
Message-ID: <qyiveqz3egzctymkwflgw4u6ubnpiss2x244fsepop7t3ve7ev@7x24oaiferuy>
References: <20231222054451.2683242-1-leong.ching.swee@intel.com>
 <20231222054451.2683242-4-leong.ching.swee@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222054451.2683242-4-leong.ching.swee@intel.com>

On Fri, Dec 22, 2023 at 01:44:50PM +0800, Leong Ching Swee wrote:
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
>  .../ethernet/stmicro/stmmac/stmmac_platform.c | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 70eadc83ca68..f857907f13a0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -710,6 +710,8 @@ EXPORT_SYMBOL_GPL(devm_stmmac_probe_config_dt);
>  int stmmac_get_platform_resources(struct platform_device *pdev,
>  				  struct stmmac_resources *stmmac_res)
>  {

> +	char irq_name[8];

By DW XGMAC v2.x IP-core design there can be up to 16 Tx channels and
12 Rx channels. Thus it's better to set irq_name size being at least
(strlen("dma_tx16") + 1) == 9 beforehand since you are adding this
code anyway and for some reason didn't consider to pick the Jisheng'
patch up which fixed the MTL_MAX_TX_QUEUES/MTL_MAX_RX_QUEUES macros.

> +	int i;

Please add an empty line between the variables declaration and the
next statement.

>  	memset(stmmac_res, 0, sizeof(*stmmac_res));
>  
>  	/* Get IRQ information early to have an ability to ask for deferred
> @@ -719,6 +721,28 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
>  	if (stmmac_res->irq < 0)
>  		return stmmac_res->irq;
>  

> +	/* For RX Channel */
> +	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
> +		snprintf(irq_name, sizeof(irq_name), "dma_rx%i", i);
> +		stmmac_res->rx_irq[i] = platform_get_irq_byname_optional(pdev, irq_name);
> +		if (stmmac_res->rx_irq[i] < 0) {
> +			if (stmmac_res->rx_irq[i] == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
> +			break;
> +		}
> +	}

What about:

+	/* Get optional Tx/Rx DMA per-channel IRQs, which otherwise
+	 * are supposed to be delivered via the common MAC IRQ line
+	 */
+	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
+		snprintf(irq_name, sizeof(irq_name), "dma_rx%i", i);
+		irq = platform_get_irq_byname_optional(pdev, irq_name);
+		if (irq == -EPROBE_DEFER)
+			return irq;
+		else if (irq < 0)
+			break;
+
+		stmmac_res->rx_irq[i] = irq;
+	}

It's cleaner a bit with less indentations and doesn't pollute
rx_irq[]/tx_irq[] arrays with the error numbers.

> +
> +	/* For TX Channel */
> +	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
> +		snprintf(irq_name, sizeof(irq_name), "dma_tx%i", i);
> +		stmmac_res->tx_irq[i] = platform_get_irq_byname_optional(pdev, irq_name);
> +		if (stmmac_res->tx_irq[i] < 0) {
> +			if (stmmac_res->rx_irq[i] == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
> +			break;
> +		}
> +	}
> +

Please move the Tx/Rx IRQs getting loops to the bottom of the
stmmac_get_platform_resources() method. Thus the order of the IRQs
getting would be the same as the order of the IRQs requests
implemented in the stmmac_request_irq_multi_msi() and
stmmac_request_irq_single() methods.

-Serge(y)

>  	/* On some platforms e.g. SPEAr the wake up irq differs from the mac irq
>  	 * The external wake up irq can be passed through the platform code
>  	 * named as "eth_wake_irq"
> -- 
> 2.34.1
> 
> 

