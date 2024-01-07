Return-Path: <linux-kernel+bounces-18982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9EB8265FB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACAF01C2157B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 20:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB801173F;
	Sun,  7 Jan 2024 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSpIvbE8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1592F11706;
	Sun,  7 Jan 2024 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e7f58c5fbso1313710e87.1;
        Sun, 07 Jan 2024 12:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704660734; x=1705265534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e5PMeecEEo3AqtvbhWJChBGMmTa++0S5sl1/vnCPNtk=;
        b=hSpIvbE8fDC1To4OQpqhgNOcG7GLsR9cA7R0X/ZXGrqCybSTKL+IOtbwqi58eKU2wq
         ByA2w6cCqL0GBQRe2vHDvTLhw2ITjsszaABXQXL2DHda8qP5nwZRC8biHuIwu8x9k3Nb
         Fo0MDvmsNcfSXdkcps/tKXgXlf4gzGvWJic2YSVtFTaX7U/x22sA2diSYIfywHaKd4gv
         3xMr9akn67DgyE7UIXCH0z8MjKj2/vQgAaBCPIkF3O/w7M9znGM3NKNcfVdLsfvRmanl
         2Vlq3pGM0W4l/Sf0n1QSRMmUGcYDBtL5ygRxblPGTcMavp8ElFMG8DpScQKGwnnDLZBJ
         eN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704660734; x=1705265534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5PMeecEEo3AqtvbhWJChBGMmTa++0S5sl1/vnCPNtk=;
        b=ZwlOoO5XWeoYAY6417HeArU+x7Z04cZyfCmobAaXZ9h1oLhyM0RD3L0Gwl3/cwQ4tV
         t9w4uxAdXfguYbSTV328Ii4VE5X7rt5f4oN06dDXf33cSR+nrc40yfznpIzmPPWMdxjZ
         iL7Ee6ux/3UMrIpzChuf+7yT6nNJZ+BeJnv9vDjZsu0chjAjROKzS86k0VYEKoK7ov3+
         v5YtDAosRgKfmfnRv/ruyR5Tu5nl28DMcY9J2xsBw+ufYL4kK80LsMobXCKb7GsaGcu4
         JcypZoCJcRumxXbjmeZnQoyVCIfDfforWwMqzE0JC+lMHLRbluL/Bp2DZlE9yYz0BwxI
         STkA==
X-Gm-Message-State: AOJu0YwwcXUjsOun6+tEdhmthtDKGEjr2bpWHqwbC2Zw3x1Rqc00UxI+
	0bHDN9tQFjdoH0mTBXURtr4=
X-Google-Smtp-Source: AGHT+IGJQYWRpMRV/Lg31RH/oBbOsUP/kNiVqW8GI/ctj2lJw+LfzVDraxmhGM4BQagSFwFrbPuZTg==
X-Received: by 2002:a05:6512:3d05:b0:50e:56b6:593e with SMTP id d5-20020a0565123d0500b0050e56b6593emr1380348lfv.89.1704660733959;
        Sun, 07 Jan 2024 12:52:13 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id a8-20020a19ca08000000b0050e810689e5sm950590lfg.33.2024.01.07.12.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 12:52:13 -0800 (PST)
Date: Sun, 7 Jan 2024 23:52:11 +0300
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
Subject: Re: [PATCH net-next v2 4/4] net: stmmac: Use interrupt mode INTM=1
 for per channel irq
Message-ID: <jvnoq2jo3dzsw3vuqzathjuyox3xipaullzeaur3ppzlmtux5k@v64tckj7pvo2>
References: <20240105070925.2948871-1-leong.ching.swee@intel.com>
 <20240105070925.2948871-5-leong.ching.swee@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105070925.2948871-5-leong.ching.swee@intel.com>

On Fri, Jan 05, 2024 at 03:09:25PM +0800, Leong Ching Swee wrote:
> From: Swee Leong Ching <leong.ching.swee@intel.com>
> 
> Enable per DMA channel interrupt that uses shared peripheral
> interrupt (SPI), so only per channel TX and RX intr (TI/RI)
> are handled by TX/RX ISR without calling common interrupt ISR.
> 
> Signed-off-by: Teoh Ji Sheng <ji.sheng.teoh@intel.com>
> Signed-off-by: Swee Leong Ching <leong.ching.swee@intel.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  3 ++
>  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 32 +++++++++++--------
>  2 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 207ff1799f2c..04bf731cb7ea 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -346,6 +346,9 @@
>  /* DMA Registers */
>  #define XGMAC_DMA_MODE			0x00003000
>  #define XGMAC_SWR			BIT(0)

> +#define XGMAC_DMA_MODE_INTM_MASK	GENMASK(13, 12)
> +#define XGMAC_DMA_MODE_INTM_SHIFT	12
> +#define XGMAC_DMA_MODE_INTM_MODE1	0x1

AFAICS the DW XGMAC module doesn't maintain a convention of having the
CSR fields macro names prefixed with the CSR name. Let's drop the
DMA_MODE suffix from the macro name then:
+#define XGMAC_INTM_MASK		GENMASK(13, 12)
+#define XGMAC_INTM_SHIFT		12
+#define XGMAC_INTM_MODE1		0x1
to have it unified with the rest of the macros in dwxgmac2.h.

Other than that the change looks good. Thanks.

-Serge(y)

>  #define XGMAC_DMA_SYSBUS_MODE		0x00003004
>  #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
>  #define XGMAC_WR_OSR_LMT_SHIFT		24
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index 3cde695fec91..dcb9f094415d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -31,6 +31,13 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
>  		value |= XGMAC_EAME;
>  
>  	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
> +
> +	if (dma_cfg->multi_irq_en) {
> +		value = readl(ioaddr + XGMAC_DMA_MODE);
> +		value &= ~XGMAC_DMA_MODE_INTM_MASK;
> +		value |= (XGMAC_DMA_MODE_INTM_MODE1 << XGMAC_DMA_MODE_INTM_SHIFT);
> +		writel(value, ioaddr + XGMAC_DMA_MODE);
> +	}
>  }
>  
>  static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
> @@ -365,19 +372,18 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
>  	}
>  
>  	/* TX/RX NORMAL interrupts */
> -	if (likely(intr_status & XGMAC_NIS)) {
> -		if (likely(intr_status & XGMAC_RI)) {
> -			u64_stats_update_begin(&rxq_stats->syncp);
> -			rxq_stats->rx_normal_irq_n++;
> -			u64_stats_update_end(&rxq_stats->syncp);
> -			ret |= handle_rx;
> -		}
> -		if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
> -			u64_stats_update_begin(&txq_stats->syncp);
> -			txq_stats->tx_normal_irq_n++;
> -			u64_stats_update_end(&txq_stats->syncp);
> -			ret |= handle_tx;
> -		}
> +	if (likely(intr_status & XGMAC_RI)) {
> +		u64_stats_update_begin(&rxq_stats->syncp);
> +		rxq_stats->rx_normal_irq_n++;
> +		u64_stats_update_end(&rxq_stats->syncp);
> +		ret |= handle_rx;
> +	}
> +
> +	if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
> +		u64_stats_update_begin(&txq_stats->syncp);
> +		txq_stats->tx_normal_irq_n++;
> +		u64_stats_update_end(&txq_stats->syncp);
> +		ret |= handle_tx;
>  	}
>  
>  	/* Clear interrupts */
> -- 
> 2.34.1
> 
> 

