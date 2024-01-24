Return-Path: <linux-kernel+bounces-37202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D534583ACD1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76A04B35A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9A263103;
	Wed, 24 Jan 2024 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5KnuI48"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885CF7CF19;
	Wed, 24 Jan 2024 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706107674; cv=none; b=YALw6dHcfV06kEpWdexd/yGUOkNDHSmA/G2kYLlADDtQHM9w+q7b9zcvYPRMSHeUtEXA3RxqWERDAuM4RC1Mlwhe3q7bEu7aJTSjE1mh/EKbhVtuUPCiiTmX+yd48Iz5qxRciCcl5eezqFM5mywtlprHzbSNcBONXcmR2tJaCfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706107674; c=relaxed/simple;
	bh=1yxtbzaxGd3JHca2hGgqggGoBpu9WDknn9qolkIZq6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+iaFvRyIYG29HVqLBrqj2q9KInerSKsfcEchVVzE+pb9ElhmodkCwHFL0S2XBhS9/K3w/i76b32PILp8l2fWVJuim/xV3Iu3iqVUTKUR66UY/GkwKkXdCJRxVUPV7l26uWz3qfXgmufZROoMteVl3qjXyb94t7qZRTVREgWICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5KnuI48; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cdeb4b9aa4so59441211fa.0;
        Wed, 24 Jan 2024 06:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706107670; x=1706712470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8jdVGJh8za10q3EFpTX1IKnwAYGvPrQt1ejh8CiHA1I=;
        b=f5KnuI488i8z8rQrDWsDdXW01FeQWnSCeEyRXs84xBnTCGfmU+Ezzz60wwcioxpJhC
         y7hhLBimUHcLBuIG9RZAIFyD4JFhuHidqG2VOKLgdtVcS8X3LjSZvi99pxvcLzE2rPci
         b30yQLUGATbs7b6aKhSeXSnXJ+TCK/YEd90SFi+ZnI1KzMyIOes+Jvs3zBxLR0Ij356G
         StCfPQsWbbswJlrknW6Rb4WFrLgkjGzuI3XPYjwIi/FIPF+yqHv1HphmOKolmkWf5ezQ
         ugwB+tS6ZV06Ut/8nc6baNeST3NEbjfyhrD4Tp3Glhv9kVT5Pqg+7Jz+R+WiqSyIQPVv
         YtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706107670; x=1706712470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jdVGJh8za10q3EFpTX1IKnwAYGvPrQt1ejh8CiHA1I=;
        b=LwKMvgHZxvXF2aLEUsqu9HFHOK24QbHwLTkGo2m4PadNqQooAh2P7RRKrf3Q2DWG6m
         vEv6aCyMEEb4wZnwl6qxD5ojbJsS9ZiR6amd29bITJDZlyfjOXVdmXPj0y41kmY9ieVX
         h2fJPt2LXrCUGsCw33BWHGyEgLWtMtqsxBFULQU4t1IDEUi6VAvYLCvGkFpjthd8v5f6
         4/g4t4JN27Qi9b8sW0rVguuFihMuHoCeMdjOOd6MJPyT2I+4WcRzgikzg0nijSwx6Gpz
         k6bFuajNp1qwCzNV3Fc1mG6znsvtaUGKRxrDwVIaSpp8YVH1JI1vN1bZwgH1N/rOqQAe
         Njhw==
X-Gm-Message-State: AOJu0YyTAtI5WJ9jApOw5HhoLFnutb7Fr4MoW5ufMDaPsKCnMM5yYkJI
	O5GAPtfrQ9bKbsOtoigj9QY7MZ0iAvKwppC6e6MjckY7EHN6lu2D/Ryk4xIevNc=
X-Google-Smtp-Source: AGHT+IFB0v+/iAU72gYpt7fE4kN8HObShyq5rUUwvRkwioFblh4A3yoOtG09Y6Hd8ZJRwCr+4Zfc0g==
X-Received: by 2002:a2e:6a05:0:b0:2ce:f93b:3af5 with SMTP id f5-20020a2e6a05000000b002cef93b3af5mr878125ljc.9.1706107670346;
        Wed, 24 Jan 2024 06:47:50 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id y9-20020a05651c020900b002cc870295edsm3923276ljn.28.2024.01.24.06.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 06:47:49 -0800 (PST)
Date: Wed, 24 Jan 2024 17:47:46 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Swee, Leong Ching" <leong.ching.swee@intel.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	Teoh Ji Sheng <ji.sheng.teoh@intel.com>
Subject: Re: [PATCH net-next v2 2/4] net: stmmac: Make MSI interrupt routine
 generic
Message-ID: <a5hmg3iwzvltim73aozbrxqxmmhyflszp4a6ea65alk752dbcy@d4jzua45igxe>
References: <20240105070925.2948871-1-leong.ching.swee@intel.com>
 <20240105070925.2948871-3-leong.ching.swee@intel.com>
 <7euscw66rss3iux2cvf7fkvfburmlf6lo4arfx76k42gihspkz@xm3klojs4e26>
 <CH0PR11MB54909CC4F6E791FFF063BA17CF692@CH0PR11MB5490.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR11MB54909CC4F6E791FFF063BA17CF692@CH0PR11MB5490.namprd11.prod.outlook.com>

On Wed, Jan 10, 2024 at 05:51:37AM +0000, Swee, Leong Ching wrote:
> > -----Original Message-----
> > From: Serge Semin <fancer.lancer@gmail.com>
> > Sent: Monday, January 8, 2024 4:28 AM
> > To: Swee, Leong Ching <leong.ching.swee@intel.com>
> > Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>; Alexandre Torgue
> > <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
> > David S . Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> > Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> > <conor+dt@kernel.org>; Giuseppe Cavallaro <peppe.cavallaro@st.com>;
> > linux-stm32@st-md-mailman.stormreply.com; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > netdev@vger.kernel.org; devicetree@vger.kernel.org; Teoh Ji Sheng
> > <ji.sheng.teoh@intel.com>
> > Subject: Re: [PATCH net-next v2 2/4] net: stmmac: Make MSI interrupt
> > routine generic
> > 
> > On Fri, Jan 05, 2024 at 03:09:23PM +0800, Leong Ching Swee wrote:
> > > From: Swee Leong Ching <leong.ching.swee@intel.com>
> > >
> > > There is no support for per DMA channel interrupt for non-MSI
> > > platform, where the MAC's per channel interrupt hooks up to interrupt
> > > controller(GIC) through shared peripheral interrupt(SPI) to handle
> > > interrupt from TX/RX transmit channel.
> > >
> > > This patch generalize the existing MSI ISR to also support non-MSI
> > > platform.
> > 
> > Basically this patch just fixes the individual IRQ handling code names.
> >

> Will change the commit log to below, please check if it sounds ok?
>
> net: stmmac: Fixes individual IRQ handling code names
> 
> Individual IRQ can also be used for non-MSI platform, 
> today some of the code name for individual IRQ has
> msi naming, so change msi naming to irq to make it common
> for both platforms.

Much better but IMO the next wording would be a bit more descriptive:

net: stmmac: Generalize individual IRQs handling code names

The individual IRQs can be also available on the non-MSI platforms.
The respective code has been developed with the MSI-based platform in
mind thus having the "MSI" word in implementation entities. Drop such
wording or replace it with just "IRQ" where it's relevant in order to
generalize the individual IRQs handling code.

-Serge(y)

>  
> > >
> > > Signed-off-by: Teoh Ji Sheng <ji.sheng.teoh@intel.com>
> > > Signed-off-by: Swee Leong Ching <leong.ching.swee@intel.com>
> > > ---
> > >  .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 +--
> > >  .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  3 ++
> > >  .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +-
> > > .../net/ethernet/stmicro/stmmac/stmmac_main.c | 30 +++++++++----------
> > >  include/linux/stmmac.h                        |  4 +--
> > >  5 files changed, 23 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> > > b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> > > index 60283543ffc8..f0ec69af96c9 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> > > @@ -952,7 +952,7 @@ static int stmmac_config_single_msi(struct pci_dev
> > > *pdev,
> > >
> > >  	res->irq = pci_irq_vector(pdev, 0);
> > >  	res->wol_irq = res->irq;
> > > -	plat->flags &= ~STMMAC_FLAG_MULTI_MSI_EN;
> > > +	plat->flags &= ~STMMAC_FLAG_MULTI_IRQ_EN;
> > >  	dev_info(&pdev->dev, "%s: Single IRQ enablement successful\n",
> > >  		 __func__);
> > >
> > > @@ -1004,7 +1004,7 @@ static int stmmac_config_multi_msi(struct
> > pci_dev *pdev,
> > >  	if (plat->msi_sfty_ue_vec < STMMAC_MSI_VEC_MAX)
> > >  		res->sfty_ue_irq = pci_irq_vector(pdev, plat-
> > >msi_sfty_ue_vec);
> > >
> > > -	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> > > +	plat->flags |= STMMAC_FLAG_MULTI_IRQ_EN;
> > >  	dev_info(&pdev->dev, "%s: multi MSI enablement successful\n",
> > > __func__);
> > >
> > >  	return 0;
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > > b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > > index ba2ce776bd4d..cf43fb3c6cc5 100644
> > 
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > > @@ -427,6 +427,9 @@ static int socfpga_dwmac_probe(struct
> > platform_device *pdev)
> > >  	plat_dat->bsp_priv = dwmac;
> > >  	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;
> > >
> > > +	if (stmmac_res.rx_irq[0] > 0 && stmmac_res.tx_irq[0] > 0)
> > > +		plat_dat->flags |= STMMAC_FLAG_MULTI_IRQ_EN;
> > > +
> > >  	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
> > >  	if (ret)
> > >  		return ret;
> > 
> > This is unrelated change. It adds the individual DMA IRQs support for the SoC
> > FPGA platform, which AFAICS doesn't have it supported at the moment.
> > Please move this into a separate patch with the commit log describing the
> > change.
> > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> > > b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> > > index 84d3a8551b03..5f649106ffcd 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> > > @@ -175,7 +175,7 @@ static void dwmac4_dma_init(void __iomem
> > *ioaddr,
> > >
> > >  	value = readl(ioaddr + DMA_BUS_MODE);
> > >
> > > -	if (dma_cfg->multi_msi_en) {
> > > +	if (dma_cfg->multi_irq_en) {
> > >  		value &= ~DMA_BUS_MODE_INTM_MASK;
> > >  		value |= (DMA_BUS_MODE_INTM_MODE1 <<
> > DMA_BUS_MODE_INTM_SHIFT);
> > >  	}
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > index 47de466e432c..57873b879b33 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > @@ -129,8 +129,8 @@ static irqreturn_t stmmac_interrupt(int irq, void
> > > *dev_id);
> > >  /* For MSI interrupts handling */
> > >  static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id);
> > > static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id);
> > > -static irqreturn_t stmmac_msi_intr_tx(int irq, void *data); -static
> > > irqreturn_t stmmac_msi_intr_rx(int irq, void *data);
> > > +static irqreturn_t stmmac_dma_tx_interrupt(int irq, void *data);
> > > +static irqreturn_t stmmac_dma_rx_interrupt(int irq, void *data);
> > >  static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32
> > > queue);  static void stmmac_reset_tx_queue(struct stmmac_priv *priv,
> > > u32 queue);  static void stmmac_reset_queues_param(struct stmmac_priv
> > > *priv); @@ -3602,7 +3602,7 @@ static void stmmac_free_irq(struct
> > net_device *dev,
> > >  	}
> > >  }
> > >
> > > -static int stmmac_request_irq_multi_msi(struct net_device *dev)
> > > +static int stmmac_request_irq_multi(struct net_device *dev)
> > >  {
> > >  	struct stmmac_priv *priv = netdev_priv(dev);
> > >  	enum request_irq_err irq_err;
> > > @@ -3697,7 +3697,7 @@ static int stmmac_request_irq_multi_msi(struct
> > net_device *dev)
> > >  		}
> > >  	}
> > >
> > > -	/* Request Rx MSI irq */
> > 
> > > +	/* Request Rx irq */
> > 
> > s/irq/IRQ
> > (capitalize)
> Sure, rework on v3. 
> > 
> > >  	for (i = 0; i < priv->plat->rx_queues_to_use; i++) {
> > >  		if (i >= MTL_MAX_RX_QUEUES)
> > >  			break;
> > > @@ -3707,11 +3707,11 @@ static int stmmac_request_irq_multi_msi(struct
> > net_device *dev)
> > >  		int_name = priv->int_name_rx_irq[i];
> > >  		sprintf(int_name, "%s:%s-%d", dev->name, "rx", i);
> > >  		ret = request_irq(priv->rx_irq[i],
> > > -				  stmmac_msi_intr_rx,
> > > +				  stmmac_dma_rx_interrupt,
> > >  				  0, int_name, &priv-
> > >dma_conf.rx_queue[i]);
> > >  		if (unlikely(ret < 0)) {
> > >  			netdev_err(priv->dev,
> > > -				   "%s: alloc rx-%d  MSI %d (error: %d)\n",
> > 
> > > +				   "%s: alloc rx-%d  dma rx_irq %d (error:
> > %d)\n",
> > 
> > s/ dma/DMA
> > (capitalize and drop extra space)
> > 
> Thanks, rework on v3.
> > >  				   __func__, i, priv->rx_irq[i], ret);
> > >  			irq_err = REQ_IRQ_ERR_RX;
> > >  			irq_idx = i;
> > > @@ -3722,7 +3722,7 @@ static int stmmac_request_irq_multi_msi(struct
> > net_device *dev)
> > >  		irq_set_affinity_hint(priv->rx_irq[i], &cpu_mask);
> > >  	}
> > >
> > > -	/* Request Tx MSI irq */
> > 
> > > +	/* Request Tx irq */
> > 
> > s/irq/IRQ
> > 
> rework on v3.
> > >  	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
> > >  		if (i >= MTL_MAX_TX_QUEUES)
> > >  			break;
> > > @@ -3732,11 +3732,11 @@ static int stmmac_request_irq_multi_msi(struct
> > net_device *dev)
> > >  		int_name = priv->int_name_tx_irq[i];
> > >  		sprintf(int_name, "%s:%s-%d", dev->name, "tx", i);
> > >  		ret = request_irq(priv->tx_irq[i],
> > > -				  stmmac_msi_intr_tx,
> > > +				  stmmac_dma_tx_interrupt,
> > >  				  0, int_name, &priv-
> > >dma_conf.tx_queue[i]);
> > >  		if (unlikely(ret < 0)) {
> > >  			netdev_err(priv->dev,
> > > -				   "%s: alloc tx-%d  MSI %d (error: %d)\n",
> > 
> > > +				   "%s: alloc tx-%d  dma tx_irq %d (error:
> > %d)\n",
> > 
> > s/ dma/DMA
> > 
> > -Serge(y)
> > 
> rework on v3.
> > >  				   __func__, i, priv->tx_irq[i], ret);
> > >  			irq_err = REQ_IRQ_ERR_TX;
> > >  			irq_idx = i;
> > > @@ -3811,8 +3811,8 @@ static int stmmac_request_irq(struct net_device
> > *dev)
> > >  	int ret;
> > >
> > >  	/* Request the IRQ lines */
> > > -	if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN)
> > > -		ret = stmmac_request_irq_multi_msi(dev);
> > > +	if (priv->plat->flags & STMMAC_FLAG_MULTI_IRQ_EN)
> > > +		ret = stmmac_request_irq_multi(dev);
> > >  	else
> > >  		ret = stmmac_request_irq_single(dev);
> > >
> > > @@ -6075,7 +6075,7 @@ static irqreturn_t stmmac_safety_interrupt(int
> > irq, void *dev_id)
> > >  	return IRQ_HANDLED;
> > >  }
> > >
> > > -static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
> > > +static irqreturn_t stmmac_dma_tx_interrupt(int irq, void *data)
> > >  {
> > >  	struct stmmac_tx_queue *tx_q = (struct stmmac_tx_queue *)data;
> > >  	struct stmmac_dma_conf *dma_conf;
> > > @@ -6107,7 +6107,7 @@ static irqreturn_t stmmac_msi_intr_tx(int irq,
> > void *data)
> > >  	return IRQ_HANDLED;
> > >  }
> > >
> > > -static irqreturn_t stmmac_msi_intr_rx(int irq, void *data)
> > > +static irqreturn_t stmmac_dma_rx_interrupt(int irq, void *data)
> > >  {
> > >  	struct stmmac_rx_queue *rx_q = (struct stmmac_rx_queue *)data;
> > >  	struct stmmac_dma_conf *dma_conf;
> > > @@ -7456,8 +7456,8 @@ int stmmac_dvr_probe(struct device *device,
> > >  	priv->plat = plat_dat;
> > >  	priv->ioaddr = res->addr;
> > >  	priv->dev->base_addr = (unsigned long)res->addr;
> > > -	priv->plat->dma_cfg->multi_msi_en =
> > > -		(priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN);
> > > +	priv->plat->dma_cfg->multi_irq_en =
> > > +		(priv->plat->flags & STMMAC_FLAG_MULTI_IRQ_EN);
> > >
> > >  	priv->dev->irq = res->irq;
> > >  	priv->wol_irq = res->wol_irq;
> > > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h index
> > > dee5ad6e48c5..b950e6f9761d 100644
> > > --- a/include/linux/stmmac.h
> > > +++ b/include/linux/stmmac.h
> > > @@ -98,7 +98,7 @@ struct stmmac_dma_cfg {
> > >  	int mixed_burst;
> > >  	bool aal;
> > >  	bool eame;
> > > -	bool multi_msi_en;
> > > +	bool multi_irq_en;
> > >  	bool dche;
> > >  };
> > >
> > > @@ -215,7 +215,7 @@ struct dwmac4_addrs {
> > >  #define STMMAC_FLAG_TSO_EN			BIT(4)
> > >  #define STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP	BIT(5)
> > >  #define STMMAC_FLAG_VLAN_FAIL_Q_EN		BIT(6)
> > > -#define STMMAC_FLAG_MULTI_MSI_EN		BIT(7)
> > > +#define STMMAC_FLAG_MULTI_IRQ_EN		BIT(7)
> > >  #define STMMAC_FLAG_EXT_SNAPSHOT_EN		BIT(8)
> > >  #define STMMAC_FLAG_INT_SNAPSHOT_EN		BIT(9)
> > >  #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
> > > --
> > > 2.34.1
> > >
> > >

