Return-Path: <linux-kernel+bounces-50628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C67847BED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64121C24D77
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF4383A18;
	Fri,  2 Feb 2024 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9G1nt/h"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF84839FE;
	Fri,  2 Feb 2024 21:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911125; cv=none; b=dj35CoaTfiZLEdFbeDAlMj+oMpvZGfymd5/RE+2n5iCMXWgxzrTJvIcRcmNGJ829Erp7mbcGviSm6tkarRGblKGsZQSJEYsrYiaJB1IOfxwUltwxWs2MGjhUIDNLP+RzokqlRDjIHgfzdfivPvjuHbLB8HsjeD/ZhENDonLSbPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911125; c=relaxed/simple;
	bh=mHobk4bO/pfvy0QxHuEkqz6AsozV7Holesa3dQkPZXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAihRFHeSxeMf9VXdn1OknF6YQWItxEGOW2wCG49OhQfqi2C8/kx9oNlHMPDXs0tXW/C3kdL8KpGmmV9ruFAQZKDATae7q40o4KwnkW7CZfrX4O2lJ68Kxm+3z8zP3Bh3M0jhqY+d/kdkVMTGqNBV0o90yr3Yqm2QGDNu5WLJ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9G1nt/h; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5112bd13a4fso2405550e87.0;
        Fri, 02 Feb 2024 13:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706911122; x=1707515922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E39dEMdG0r2fMpEBTkdZZwQ7jTYMRj0NqErtFuymXG4=;
        b=C9G1nt/hq9KXWqcpbgCa6yjuTRfIH5B+bjraVAq0MMWBQPrrbZ/bYrWiWC+2RMk1tC
         qWwqMlAdN6FFP0bhVNGvKJJ3PfkiYlOYlGFWYhO8RpmWx0Chqvp36m/kWARh/RkJ9KyN
         evRZx4z8DSNTp69SuxhW0QLLz8ys7axXfH9dUXOSgri1an6cIJk+rXZ9bzkF790QQV0n
         dsvHIJRcKwWWNoQiDFcQU9/tdSCMTxvsnHJe29R+aUpnGpaL0x2nOLx7tMkAStPa3pZh
         ehz/FyCwQh64f/B4bysuwNdaRujufDDGxNa1QSWj/ABrBgnZn0uUk+2e8/3E6hDMY4og
         87XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706911122; x=1707515922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E39dEMdG0r2fMpEBTkdZZwQ7jTYMRj0NqErtFuymXG4=;
        b=jjRwnQB4msa41t/qDqKry61Xm+Oc3IQHALvDn/Y80F8pjoj4q5yAeHwbJfaaJ7jk3B
         YSkpLaiULsiasYqoN5oK5963+HtUc6wKpDDWDXoJUQ2iK0lMzu9QFV8QDdJOsQeOObDf
         WVtAiIAa+CHQhOxwr4q9HQWKY95vrd3oakPNKVs97x1Ru0i9RJECHoNjUdgI4lghDR7C
         Vm6hdQSgS+DBxXqD3jSIiNOhZd8baQ7Mzy9HeFx7FR1c7xf7VCQ68EB8iJavcv8QXWYG
         RRi5qQ++rXZcLxlxgW5TlHxOCccaTsrp1Rk3v7GXKSlBjjEANmKPEQsYXflVIAoe+0rG
         JdLw==
X-Gm-Message-State: AOJu0YzVMUqTDw7XXxyWUx2AGCS08hEZPUooaY8Qr0vIewO2YpOPOrEJ
	u+8wcdo+KW9gUh1Y5oc61SSdNHZDdFN70ymEecXsEnHNWirAKci/
X-Google-Smtp-Source: AGHT+IFh/Jf6hZ5Vd5yjSlGVUByuXTqyJ5TuyPRxKtHqX2Czd1rY63m0hTtERJPqN5BAEQldRR3xlg==
X-Received: by 2002:a19:641c:0:b0:510:24dc:aa8f with SMTP id y28-20020a19641c000000b0051024dcaa8fmr87881lfb.14.1706911121776;
        Fri, 02 Feb 2024 13:58:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV4/mhmdTBnHJjXi9UYlDEK/W41Atpdj0exzH9ziHik/17Uh0o+kqMY39Cbw3Eo+3JaPLKJMUOC9VRBJVmxyKsRfpNKdO1eg4QVIi2IkY9T6koAKFNrlxDIOGM9q5XBgMoQAuhNJV30UCGLffnJyAteYBLrHOyGSpw9DKft6DzNGRkFpn5EZW1WZBUPKLRwT53kdUPjAILAsu/JZf9lH4B03bg7O0lalXXTF/f7VkwkgeLywImeFcOWECnsWoW/LLnyHfZWudQ9Gzq2cp+2Fk+N4OZc+vp9Tyfrhb3IKhgIT72G/G1uAw/AutFw6SSDemJPEnf/H46cfInopW5EN6fyEmx7FE+lsTTh4cgJOvR+s+0Tt6rpD08B5jNOzfpjHKD6AjTzJ3ttpVDSP4RPC7dv9+doRRgSp6oMLsSQNaMbdrjuFffApuPcLHprjY9jvvvN1l/MKhsd20cNUzXagP6SSwbQsuf4bKpELDRY6B/8gbqHKsSrKhXQAkdQCg==
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id a24-20020a05651c211800b002ca092c194asm387382ljq.13.2024.02.02.13.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 13:58:41 -0800 (PST)
Date: Sat, 3 Feb 2024 00:58:39 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Furong Xu <0x1207@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Joao Pinto <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net v3] net: stmmac: xgmac: fix handling of DPP safety
 error for DMA channels
Message-ID: <ksfs7uag4yukqbeygch7pxvr5axyrqz4gunq2xes3ppmtrgm5b@hwh5yx5qz3wl>
References: <20240131020828.2007741-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131020828.2007741-1-0x1207@gmail.com>

On Wed, Jan 31, 2024 at 10:08:28AM +0800, Furong Xu wrote:
> Commit 56e58d6c8a56 ("net: stmmac: Implement Safety Features in
> XGMAC core") checks and reports safety errors, but leaves the
> Data Path Parity Errors for each channel in DMA unhandled at all, lead to
> a storm of interrupt.
> Fix it by checking and clearing the DMA_DPP_Interrupt_Status register.
> 
> Fixes: 56e58d6c8a56 ("net: stmmac: Implement Safety Features in XGMAC core")
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
> Changes in v3:
>  - code style fix, thanks Paolo Abeni
> 
> Changes in v2:
>   - explicit enable Data Path Parity Protection
>   - add new counters to stmmac_safety_stats
>   - add detailed log
> ---
>  drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
>  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  3 +
>  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 57 ++++++++++++++++++-
>  3 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> index 721c1f8e892f..b4f60ab078d6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -216,6 +216,7 @@ struct stmmac_safety_stats {
>  	unsigned long mac_errors[32];
>  	unsigned long mtl_errors[32];
>  	unsigned long dma_errors[32];
> +	unsigned long dma_dpp_errors[32];
>  };
>  
>  /* Number of fields in Safety Stats */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 207ff1799f2c..5c67a3f89f08 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -303,6 +303,8 @@
>  #define XGMAC_RXCEIE			BIT(4)
>  #define XGMAC_TXCEIE			BIT(0)
>  #define XGMAC_MTL_ECC_INT_STATUS	0x000010cc
> +#define XGMAC_MTL_DPP_CONTROL		0x000010e0

> +#define XGMAC_DDPP_DISABLE		BIT(0)

Is the double "D" a typo? Shouldn't this be XGMAC_DPP_DISABLE or just
XGMAC_DDPP (if the "DDPP" means "Disable DPP")?

If so, David/Jakub, is it possible to rebase the branch with the macro
fixed in the commit or a new cleanup patch is the only option?

Other than the nit above no more notes from my side:

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

>  #define XGMAC_MTL_TXQ_OPMODE(x)		(0x00001100 + (0x80 * (x)))
>  #define XGMAC_TQS			GENMASK(25, 16)
>  #define XGMAC_TQS_SHIFT			16
> @@ -385,6 +387,7 @@
>  #define XGMAC_DCEIE			BIT(1)
>  #define XGMAC_TCEIE			BIT(0)
>  #define XGMAC_DMA_ECC_INT_STATUS	0x0000306c
> +#define XGMAC_DMA_DPP_INT_STATUS	0x00003074
>  #define XGMAC_DMA_CH_CONTROL(x)		(0x00003100 + (0x80 * (x)))
>  #define XGMAC_SPH			BIT(24)
>  #define XGMAC_PBLx8			BIT(16)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index eb48211d9b0e..04d7c4dc2e35 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -830,6 +830,43 @@ static const struct dwxgmac3_error_desc dwxgmac3_dma_errors[32]= {
>  	{ false, "UNKNOWN", "Unknown Error" }, /* 31 */
>  };
>  
> +static const char * const dpp_rx_err = "Read Rx Descriptor Parity checker Error";
> +static const char * const dpp_tx_err = "Read Tx Descriptor Parity checker Error";
> +static const struct dwxgmac3_error_desc dwxgmac3_dma_dpp_errors[32] = {
> +	{ true, "TDPES0", dpp_tx_err },
> +	{ true, "TDPES1", dpp_tx_err },
> +	{ true, "TDPES2", dpp_tx_err },
> +	{ true, "TDPES3", dpp_tx_err },
> +	{ true, "TDPES4", dpp_tx_err },
> +	{ true, "TDPES5", dpp_tx_err },
> +	{ true, "TDPES6", dpp_tx_err },
> +	{ true, "TDPES7", dpp_tx_err },
> +	{ true, "TDPES8", dpp_tx_err },
> +	{ true, "TDPES9", dpp_tx_err },
> +	{ true, "TDPES10", dpp_tx_err },
> +	{ true, "TDPES11", dpp_tx_err },
> +	{ true, "TDPES12", dpp_tx_err },
> +	{ true, "TDPES13", dpp_tx_err },
> +	{ true, "TDPES14", dpp_tx_err },
> +	{ true, "TDPES15", dpp_tx_err },
> +	{ true, "RDPES0", dpp_rx_err },
> +	{ true, "RDPES1", dpp_rx_err },
> +	{ true, "RDPES2", dpp_rx_err },
> +	{ true, "RDPES3", dpp_rx_err },
> +	{ true, "RDPES4", dpp_rx_err },
> +	{ true, "RDPES5", dpp_rx_err },
> +	{ true, "RDPES6", dpp_rx_err },
> +	{ true, "RDPES7", dpp_rx_err },
> +	{ true, "RDPES8", dpp_rx_err },
> +	{ true, "RDPES9", dpp_rx_err },
> +	{ true, "RDPES10", dpp_rx_err },
> +	{ true, "RDPES11", dpp_rx_err },
> +	{ true, "RDPES12", dpp_rx_err },
> +	{ true, "RDPES13", dpp_rx_err },
> +	{ true, "RDPES14", dpp_rx_err },
> +	{ true, "RDPES15", dpp_rx_err },
> +};
> +
>  static void dwxgmac3_handle_dma_err(struct net_device *ndev,
>  				    void __iomem *ioaddr, bool correctable,
>  				    struct stmmac_safety_stats *stats)
> @@ -841,6 +878,13 @@ static void dwxgmac3_handle_dma_err(struct net_device *ndev,
>  
>  	dwxgmac3_log_error(ndev, value, correctable, "DMA",
>  			   dwxgmac3_dma_errors, STAT_OFF(dma_errors), stats);
> +
> +	value = readl(ioaddr + XGMAC_DMA_DPP_INT_STATUS);
> +	writel(value, ioaddr + XGMAC_DMA_DPP_INT_STATUS);
> +
> +	dwxgmac3_log_error(ndev, value, false, "DMA_DPP",
> +			   dwxgmac3_dma_dpp_errors,
> +			   STAT_OFF(dma_dpp_errors), stats);
>  }
>  
>  static int
> @@ -881,6 +925,12 @@ dwxgmac3_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
>  	value |= XGMAC_TMOUTEN; /* FSM Timeout Feature */
>  	writel(value, ioaddr + XGMAC_MAC_FSM_CONTROL);
>  
> +	/* 5. Enable Data Path Parity Protection */
> +	value = readl(ioaddr + XGMAC_MTL_DPP_CONTROL);
> +	/* already enabled by default, explicit enable it again */
> +	value &= ~XGMAC_DDPP_DISABLE;
> +	writel(value, ioaddr + XGMAC_MTL_DPP_CONTROL);
> +
>  	return 0;
>  }
>  
> @@ -914,7 +964,11 @@ static int dwxgmac3_safety_feat_irq_status(struct net_device *ndev,
>  		ret |= !corr;
>  	}
>  
> -	err = dma & (XGMAC_DEUIS | XGMAC_DECIS);
> +	/* DMA_DPP_Interrupt_Status is indicated by MCSIS bit in
> +	 * DMA_Safety_Interrupt_Status, so we handle DMA Data Path
> +	 * Parity Errors here
> +	 */
> +	err = dma & (XGMAC_DEUIS | XGMAC_DECIS | XGMAC_MCSIS);
>  	corr = dma & XGMAC_DECIS;
>  	if (err) {
>  		dwxgmac3_handle_dma_err(ndev, ioaddr, corr, stats);
> @@ -930,6 +984,7 @@ static const struct dwxgmac3_error {
>  	{ dwxgmac3_mac_errors },
>  	{ dwxgmac3_mtl_errors },
>  	{ dwxgmac3_dma_errors },
> +	{ dwxgmac3_dma_dpp_errors },
>  };
>  
>  static int dwxgmac3_safety_feat_dump(struct stmmac_safety_stats *stats,
> -- 
> 2.34.1
> 

