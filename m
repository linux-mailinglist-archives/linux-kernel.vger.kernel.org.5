Return-Path: <linux-kernel+bounces-39768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A47CF83D5E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128E91F281CE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01C21C28A;
	Fri, 26 Jan 2024 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="z+nrrGxV"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE2D14276;
	Fri, 26 Jan 2024 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258181; cv=none; b=MH67avjLsvkeJnczEEywvrnL1kHEUyydKAHPUfksyjOj2FNy34MbIL1eePCNGI3js9lfF9ZSGDm6o/KzrjqBQW/V5jI5GuDyWSmBcAUbKvydgjE/GuG0SW4dtY7E3cNL12NAI25CAL2Osj84QXj6vml+o5ZnT23c3P+EaTgQFN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258181; c=relaxed/simple;
	bh=tkg39RAYsAhIELMHYR7dU6szqBbIFK6BgQpLq2STJIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LePb6/4pYtT0zakKAaXyyYaRwfIFQA3IRFODohOayGd9jgh6Kef45s3R8kpF2O1frVHDDqn4p32T+CIyZcBUnIn+TfVj4hpmSD/efAWpElEQjz9nTJFVY8vQrrlougheKB8Uy7Q7+GQSpqWM/lhxsppHpDVVGwYki4vhxAVe5N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=z+nrrGxV; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=GfWOdJizn9qajP2fgFEpsk2c/JN4N7LIyYRvIOWoG84=; b=z+nrrGxVXrBFOfyxlMj3aHedI9
	acH/1Fxur1lc7V7veDwL0sRWrLxY1i0lZKHq9i8gvklx0sVnfe+PONud9xMEUOghestnulhzCWIbC
	At5DzfwRL72qRhozA2gRWzcMAUBcf2YRSP6PWH7S3hHc5Xat2NFuUuIswgEYf6ULyoq+XO6AxufTc
	JkDoZGTrhBm0FW56xaDfoqm7ABHVqWOwpRjpj4Sx8ODLHvOZEfgOLMfMpJdzMlaxVWy35MMh6vesq
	y4ngsAXlNb+wxroZRgEe8MBy1ZXN2LAwMyi3eOKKgrcQVRCvh07l53+TgQXTdsZjnjPnUSZbOelRw
	hCrp8c1w==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rTHfy-000AzR-Lb; Fri, 26 Jan 2024 09:35:02 +0100
Received: from [87.49.42.9] (helo=localhost)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <esben@geanix.com>)
	id 1rTHfx-000Ioh-Jv; Fri, 26 Jan 2024 09:35:01 +0100
From: Esben Haabendal <esben@geanix.com>
To: Rohan G Thomas <rohan.g.thomas@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  Jose Abreu <joabreu@synopsys.com>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Maxime Coquelin <mcoquelin.stm32@gmail.com>,
  Rob Herring <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Giuseppe Cavallaro <peppe.cavallaro@st.com>,  Serge Semin
 <fancer.lancer@gmail.com>,  netdev@vger.kernel.org,
  linux-stm32@st-md-mailman.stormreply.com,
  linux-arm-kernel@lists.infradead.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: stmmac: TBS support for platform driver
In-Reply-To: <20230927130919.25683-3-rohan.g.thomas@intel.com> (Rohan G.
	Thomas's message of "Wed, 27 Sep 2023 21:09:19 +0800")
References: <20230927130919.25683-1-rohan.g.thomas@intel.com>
	<20230927130919.25683-3-rohan.g.thomas@intel.com>
Date: Fri, 26 Jan 2024 09:35:01 +0100
Message-ID: <87v87g4hmy.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27165/Thu Jan 25 10:51:15 2024)

Rohan G Thomas <rohan.g.thomas@intel.com> writes:

> Enable Time Based Scheduling(TBS) support for Tx queues through the
> stmmac platform driver. For this a new per-queue tx-config property,
> tbs-enabled is added to the devicetree.
>
> Commit 7eadf57290ec ("net: stmmac: pci: Enable TBS on GMAC5 IPK PCI
> entry") enables similar support for the stmmac pci driver.
>
> Also add check whether TBS support is available for a Tx DMA channel
> before enabling TBS support for that Tx DMA channel.
>
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 25 +++++++++++++++----
>  .../ethernet/stmicro/stmmac/stmmac_platform.c |  4 +++
>  2 files changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 81b6f3ecdf92..7333f0640b3d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3773,12 +3773,18 @@ stmmac_setup_dma_desc(struct stmmac_priv *priv, unsigned int mtu)
>  		dma_conf->dma_rx_size = DMA_DEFAULT_RX_SIZE;
>  
>  	/* Earlier check for TBS */
> -	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++) {
> -		struct stmmac_tx_queue *tx_q = &dma_conf->tx_queue[chan];
> -		int tbs_en = priv->plat->tx_queues_cfg[chan].tbs_en;
> +	if (priv->dma_cap.tbssel) {
> +		/* TBS is available only for tbs_ch_num of Tx DMA channels,
> +		 * starting from the highest Tx DMA channel.
> +		 */
> +		chan = priv->dma_cap.number_tx_channel - priv->dma_cap.tbs_ch_num;
> +		for (; chan < priv->plat->tx_queues_to_use; chan++) {
> +			struct stmmac_tx_queue *tx_q = &dma_conf->tx_queue[chan];
> +			int tbs_en = priv->plat->tx_queues_cfg[chan].tbs_en;
>  
> -		/* Setup per-TXQ tbs flag before TX descriptor alloc */
> -		tx_q->tbs |= tbs_en ? STMMAC_TBS_AVAIL : 0;
> +			/* Setup per-TXQ tbs flag before TX descriptor alloc */
> +			tx_q->tbs |= tbs_en ? STMMAC_TBS_AVAIL : 0;
> +		}
>  	}
>  
>  	ret = alloc_dma_desc_resources(priv, dma_conf);
> @@ -7505,6 +7511,15 @@ int stmmac_dvr_probe(struct device *device,
>  		}
>  	}
>  
> +	/* If TBS feature is supported(i.e. tbssel is true), then at least 1 Tx
> +	 * DMA channel supports TBS. So if tbs_ch_num is 0 and tbssel is true,
> +	 * assume all Tx DMA channels support TBS. TBS_CH field, which gives
> +	 * number of Tx DMA channels with TBS support is only available only for
> +	 * DW xGMAC IP. For other DWMAC IPs all Tx DMA channels can support TBS.

The Ethernet QOS controllers found in various i.MX socs does not support
TBS on TX queue 0. I believe this patch would break the dwmac driver for
these platforms.

> +	 */
> +	if (priv->dma_cap.tbssel && !priv->dma_cap.tbs_ch_num)
> +		priv->dma_cap.tbs_ch_num = priv->dma_cap.number_tx_channel;
> +
>  	ndev->features |= ndev->hw_features | NETIF_F_HIGHDMA;
>  	ndev->watchdog_timeo = msecs_to_jiffies(watchdog);
>  #ifdef STMMAC_VLAN_TAG_USED
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 843bd8804bfa..6c0191c84071 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -279,6 +279,10 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
>  		plat->tx_queues_cfg[queue].coe_unsupported =
>  			of_property_read_bool(q_node, "snps,coe-unsupported");
>  
> +		/* Select TBS for supported queues */
> +		plat->tx_queues_cfg[queue].tbs_en =
> +			of_property_read_bool(q_node, "snps,tbs-enabled");
> +
>  		queue++;
>  	}
>  	if (queue != plat->tx_queues_to_use) {

/Esben

