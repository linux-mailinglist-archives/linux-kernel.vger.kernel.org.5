Return-Path: <linux-kernel+bounces-57744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D320F84DCEA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7E81C26783
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01DF6DD1C;
	Thu,  8 Feb 2024 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRu8/JvU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7705171B4;
	Thu,  8 Feb 2024 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384393; cv=none; b=PHI+CKry0i97KO5BxKKIFBGsgbCYstjBYdhpZbRrUGpB7d/GVuQ+LFTUlaO8j2Vn2au73qYbiH9hle6KMwPKruJl+2m2wTFD3D6tFnuT4EqsTj8GCQpFYZIKVjs4jk80hNPRTRbxQEiS18peTbhfiXaZr5pT0p1D4M53576jccM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384393; c=relaxed/simple;
	bh=DJn/JznV4z6gHv7cVHFcfLco3THQI2iFxeIjFcAeR5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyiDFwDryc3apqIrFexVKqFn7ZCQjU6IwgPoo0+8itNGx3xqDR4nHeKZIAksCHwjjenU1zQQI3sFzsXTZpBQ3DfVa+XiqEOy07IxNCd0TtMZy9TVpLHZOM4Sf9KDW9mIshKNl0Mus/5h7CD05V53jVs1ssGQxhRJN4nrbEAWrV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRu8/JvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83EBC433C7;
	Thu,  8 Feb 2024 09:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707384393;
	bh=DJn/JznV4z6gHv7cVHFcfLco3THQI2iFxeIjFcAeR5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRu8/JvUYQ3LRRE7NieWOIEMI5jR0RbvmIng0aOkFS2Rj/gVCVdMjQ8FxxVrgvAAm
	 7OfNfkva16HRK8+2FS+CH3gsDZMMdRV0wVZw/l/DNIQFSUSYY/I0JATtG8G9MZY2We
	 RrskuRl2UMdcVPeOH3EWrN3AnHO9U792zatvgVapsq4bw4zUe/rUttOW6BFW7KZ6Hu
	 sjJEYfv8bJ5a576g7soea/ckwko3A3hietiDU5Wbi8/AP0FZciUE2cWDub69NHgcew
	 tw0z+MTh1PaccjMqYtDwAsJIoc4wi9wmQgLBud9yMnKQXy6v9Hn9Ls3+ejIpatUunK
	 CUuuRz17hiROA==
Date: Thu, 8 Feb 2024 09:26:27 +0000
From: Simon Horman <horms@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Furong Xu <0x1207@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net v4] net: stmmac: xgmac: fix handling of DPP safety
 error for DMA channels
Message-ID: <20240208092627.GP1297511@kernel.org>
References: <20240203051439.1127090-1-0x1207@gmail.com>
 <c25eb595-8d91-40ea-9f52-efa15ebafdbc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c25eb595-8d91-40ea-9f52-efa15ebafdbc@nvidia.com>

On Wed, Feb 07, 2024 at 11:56:26AM +0000, Jon Hunter wrote:
> 
> On 03/02/2024 05:14, Furong Xu wrote:
> > Commit 56e58d6c8a56 ("net: stmmac: Implement Safety Features in
> > XGMAC core") checks and reports safety errors, but leaves the
> > Data Path Parity Errors for each channel in DMA unhandled at all, lead to
> > a storm of interrupt.
> > Fix it by checking and clearing the DMA_DPP_Interrupt_Status register.
> > 
> > Fixes: 56e58d6c8a56 ("net: stmmac: Implement Safety Features in XGMAC core")
> > Signed-off-by: Furong Xu <0x1207@gmail.com>
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> > Changes in v4:
> >   - fix a typo name of DDPP bit, thanks Serge Semin
> > 
> > Changes in v3:
> >   - code style fix, thanks Paolo Abeni
> > 
> > Changes in v2:
> >    - explicit enable Data Path Parity Protection
> >    - add new counters to stmmac_safety_stats
> >    - add detailed log
> > ---
> >   drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
> >   .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  3 +
> >   .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 57 ++++++++++++++++++-
> >   3 files changed, 60 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> > index 721c1f8e892f..b4f60ab078d6 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> > @@ -216,6 +216,7 @@ struct stmmac_safety_stats {
> >   	unsigned long mac_errors[32];
> >   	unsigned long mtl_errors[32];
> >   	unsigned long dma_errors[32];
> > +	unsigned long dma_dpp_errors[32];
> >   };
> >   /* Number of fields in Safety Stats */
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > index 207ff1799f2c..5c67a3f89f08 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > @@ -303,6 +303,8 @@
> >   #define XGMAC_RXCEIE			BIT(4)
> >   #define XGMAC_TXCEIE			BIT(0)
> >   #define XGMAC_MTL_ECC_INT_STATUS	0x000010cc
> > +#define XGMAC_MTL_DPP_CONTROL		0x000010e0
> > +#define XGMAC_DPP_DISABLE		BIT(0)
> >   #define XGMAC_MTL_TXQ_OPMODE(x)		(0x00001100 + (0x80 * (x)))
> >   #define XGMAC_TQS			GENMASK(25, 16)
> >   #define XGMAC_TQS_SHIFT			16
> > @@ -385,6 +387,7 @@
> >   #define XGMAC_DCEIE			BIT(1)
> >   #define XGMAC_TCEIE			BIT(0)
> >   #define XGMAC_DMA_ECC_INT_STATUS	0x0000306c
> > +#define XGMAC_DMA_DPP_INT_STATUS	0x00003074
> >   #define XGMAC_DMA_CH_CONTROL(x)		(0x00003100 + (0x80 * (x)))
> >   #define XGMAC_SPH			BIT(24)
> >   #define XGMAC_PBLx8			BIT(16)
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > index eb48211d9b0e..04d7c4dc2e35 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > @@ -830,6 +830,43 @@ static const struct dwxgmac3_error_desc dwxgmac3_dma_errors[32]= {
> >   	{ false, "UNKNOWN", "Unknown Error" }, /* 31 */
> >   };
> > +static const char * const dpp_rx_err = "Read Rx Descriptor Parity checker Error";
> > +static const char * const dpp_tx_err = "Read Tx Descriptor Parity checker Error";
> > +static const struct dwxgmac3_error_desc dwxgmac3_dma_dpp_errors[32] = {
> > +	{ true, "TDPES0", dpp_tx_err },
> > +	{ true, "TDPES1", dpp_tx_err },
> > +	{ true, "TDPES2", dpp_tx_err },
> > +	{ true, "TDPES3", dpp_tx_err },
> > +	{ true, "TDPES4", dpp_tx_err },
> > +	{ true, "TDPES5", dpp_tx_err },
> > +	{ true, "TDPES6", dpp_tx_err },
> > +	{ true, "TDPES7", dpp_tx_err },
> > +	{ true, "TDPES8", dpp_tx_err },
> > +	{ true, "TDPES9", dpp_tx_err },
> > +	{ true, "TDPES10", dpp_tx_err },
> > +	{ true, "TDPES11", dpp_tx_err },
> > +	{ true, "TDPES12", dpp_tx_err },
> > +	{ true, "TDPES13", dpp_tx_err },
> > +	{ true, "TDPES14", dpp_tx_err },
> > +	{ true, "TDPES15", dpp_tx_err },
> > +	{ true, "RDPES0", dpp_rx_err },
> > +	{ true, "RDPES1", dpp_rx_err },
> > +	{ true, "RDPES2", dpp_rx_err },
> > +	{ true, "RDPES3", dpp_rx_err },
> > +	{ true, "RDPES4", dpp_rx_err },
> > +	{ true, "RDPES5", dpp_rx_err },
> > +	{ true, "RDPES6", dpp_rx_err },
> > +	{ true, "RDPES7", dpp_rx_err },
> > +	{ true, "RDPES8", dpp_rx_err },
> > +	{ true, "RDPES9", dpp_rx_err },
> > +	{ true, "RDPES10", dpp_rx_err },
> > +	{ true, "RDPES11", dpp_rx_err },
> > +	{ true, "RDPES12", dpp_rx_err },
> > +	{ true, "RDPES13", dpp_rx_err },
> > +	{ true, "RDPES14", dpp_rx_err },
> > +	{ true, "RDPES15", dpp_rx_err },
> > +};
> > +
> >   static void dwxgmac3_handle_dma_err(struct net_device *ndev,
> >   				    void __iomem *ioaddr, bool correctable,
> >   				    struct stmmac_safety_stats *stats)
> > @@ -841,6 +878,13 @@ static void dwxgmac3_handle_dma_err(struct net_device *ndev,
> >   	dwxgmac3_log_error(ndev, value, correctable, "DMA",
> >   			   dwxgmac3_dma_errors, STAT_OFF(dma_errors), stats);
> > +
> > +	value = readl(ioaddr + XGMAC_DMA_DPP_INT_STATUS);
> > +	writel(value, ioaddr + XGMAC_DMA_DPP_INT_STATUS);
> > +
> > +	dwxgmac3_log_error(ndev, value, false, "DMA_DPP",
> > +			   dwxgmac3_dma_dpp_errors,
> > +			   STAT_OFF(dma_dpp_errors), stats);
> >   }
> >   static int
> > @@ -881,6 +925,12 @@ dwxgmac3_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
> >   	value |= XGMAC_TMOUTEN; /* FSM Timeout Feature */
> >   	writel(value, ioaddr + XGMAC_MAC_FSM_CONTROL);
> > +	/* 5. Enable Data Path Parity Protection */
> > +	value = readl(ioaddr + XGMAC_MTL_DPP_CONTROL);
> > +	/* already enabled by default, explicit enable it again */
> > +	value &= ~XGMAC_DPP_DISABLE;
> > +	writel(value, ioaddr + XGMAC_MTL_DPP_CONTROL);
> > +
> >   	return 0;
> >   }
> > @@ -914,7 +964,11 @@ static int dwxgmac3_safety_feat_irq_status(struct net_device *ndev,
> >   		ret |= !corr;
> >   	}
> > -	err = dma & (XGMAC_DEUIS | XGMAC_DECIS);
> > +	/* DMA_DPP_Interrupt_Status is indicated by MCSIS bit in
> > +	 * DMA_Safety_Interrupt_Status, so we handle DMA Data Path
> > +	 * Parity Errors here
> > +	 */
> > +	err = dma & (XGMAC_DEUIS | XGMAC_DECIS | XGMAC_MCSIS);
> >   	corr = dma & XGMAC_DECIS;
> >   	if (err) {
> >   		dwxgmac3_handle_dma_err(ndev, ioaddr, corr, stats);
> > @@ -930,6 +984,7 @@ static const struct dwxgmac3_error {
> >   	{ dwxgmac3_mac_errors },
> >   	{ dwxgmac3_mtl_errors },
> >   	{ dwxgmac3_dma_errors },
> > +	{ dwxgmac3_dma_dpp_errors },
> >   };
> >   static int dwxgmac3_safety_feat_dump(struct stmmac_safety_stats *stats,
> 
> 
> This change is breaking the build on some of our builders that are still using GCC 6.x ...
> 
> drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:836:20: error: initialiser element is not constant
>   { true, "TDPES0", dpp_tx_err },
>                     ^~~~~~~~~~
> drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:836:20: note: (near initialisation for ‘dwxgmac3_dma_dpp_errors[0].detailed_desc’)
> drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:837:20: error: initialiser element is not constant
>   { true, "TDPES1", dpp_tx_err },
>                     ^~~~~~~~~~
> drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:837:20: note: (near initialisation for ‘dwxgmac3_dma_dpp_errors[1].detailed_desc’)
> ...
> 
> I know that this is quite old but the minimum supported by the kernel is v5.1 ...
> 
> https://www.kernel.org/doc/html/next/process/changes.html

Thanks Jon,

I separately received a notification about this occurring with gcc 7.

https://lore.kernel.org/oe-kbuild-all/202402081135.lAxxBXHk-lkp@intel.com/

It is unclear to me why this occurs, as dpp_tx_err and dpp_tx_err are const.
But I do seem to be able to address this problem by using #defines for
these values instead.

I plan to post a patch shortly.

