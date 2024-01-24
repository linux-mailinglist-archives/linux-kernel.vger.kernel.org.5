Return-Path: <linux-kernel+bounces-37107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4199683AB9F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A066AB2A858
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8EC7A729;
	Wed, 24 Jan 2024 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVMcHh4w"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D6C60DD1;
	Wed, 24 Jan 2024 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106338; cv=none; b=c8Faaphc4MxauTjsnrcDyYn96/x4u/IltEXxtpWKhHTtPbpaTIRcCEp12V/vpEYG7NllrMxPeEBPvlCI9OsgEkQmlJ0kiuwGC+cjBTWaItN03au/14fgAfjPhalrVXWu7W79LiimeY6R77Ar+WCWD4DTzQmvb8wb1JC+x8e3jJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106338; c=relaxed/simple;
	bh=lMQVKwQEtUk214d4vm+VBxmy/h2Gaq10ehD9cWY7mLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhzkokXH/QW6eAEDNDjTQ7vFvxXTSyvrFgdv/OHkljfEoIKw2v0+/b5INTDw30n2yqar62IT9lvAd4n9rFBkQD9D77tLoSIfTCA4Ffai87n9iVJQFQFNv6C88e7Li9bvVSaJ+x8k66/xkuSaC8IpWWltU+4YEY8cG8RpwHoDBPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVMcHh4w; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5100c3f7df1so1943785e87.0;
        Wed, 24 Jan 2024 06:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706106335; x=1706711135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ojxeaViB6pLAJ/Tfy0YrKqXrdt1fiDqjnZZPco7s5Fg=;
        b=MVMcHh4wyBcFu2mn7iiVUucILoee6h3vjNdXUDwOb3rRlVHXZzWls3Ol7dx6YaixxG
         OndCJEOKDBPg5OzRv6ZUEdieCYyq1FEtzt/ucYXnPdnOTqLJRkG3wCYyPCFu9uUpzrZr
         n4nNVNMZptUQIO2q+apKAySncTIylNtQN/0gVVUa5MLQmuhvTjp7K9o5kLns9wm6cEVd
         qyS2lA4wo2zXWpikANZr7JR6ZmY7jT13vKRRbU7FSiZ3DUefiEXcu6j/SKzNnoTo8qXu
         2qY6TCm8ydYmyGNtQ9lqPhnHiR0cnipXKZaqr+HbdTRMGw23zTlzj2lpm3TAIlBpBiOR
         LRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706106335; x=1706711135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojxeaViB6pLAJ/Tfy0YrKqXrdt1fiDqjnZZPco7s5Fg=;
        b=jzZkohqx5II3UfrKx1LVCHv8Jp0P+4As/HpB+QHmrrxHqK+LDGoatihY8Wmb/Inwtm
         uGH7UYBCqpVN0VQcGQOd+9QKrfM9/t+3pADbjAXa/2SaY0yFWAicZy8OCwU0AQ4D2mtT
         L+PQWapMJSqH8Q6i0J/xXSBwmqu/hge5YapGCe2Cc97gx8+brwykUpGW+HYJcs+kh4wh
         xR1G+spIB2P5CRWeqwkJlOcdwwxJXwKIYM4ILc8oBRMe4W/p4DTS8gyZk6K8kdHRoUsa
         XBJHH9C5DfVBPv1wtP350Ycc8InnldIDykzv+6G1fB5zBicnjY1K+xo4ouf0/Jl2BoCq
         2hnw==
X-Gm-Message-State: AOJu0Yx/Qycz2PbG5zl6AtD7hrG7+qEopNnL6m/YiYXeF3hRz3fD36uF
	1eTiDoGH1jIvMvij6QM3/J++xkJZYc5upcSBnuXAv8quS/SXXDdC
X-Google-Smtp-Source: AGHT+IHZppZBPpxX7hjhZ7O8ug4KnGQsVC8AN7TdTefrgFlvP30wVj6eWIswTHqQKGcYw9kXPrw9eA==
X-Received: by 2002:a05:6512:32c2:b0:50e:7d27:f930 with SMTP id f2-20020a05651232c200b0050e7d27f930mr4450478lfg.29.1706106334687;
        Wed, 24 Jan 2024 06:25:34 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id a8-20020a19ca08000000b005100cb8395esm308291lfg.15.2024.01.24.06.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 06:25:32 -0800 (PST)
Date: Wed, 24 Jan 2024 17:25:27 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Joao Pinto <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net] net: stmmac: xgmac: fix safety error descriptions
Message-ID: <ii3muj3nmhuo6s5hm3g7wuiubtyzr632klrcesubtuaoyifogb@ohmunpxvdtsv>
References: <20240123085037.939471-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123085037.939471-1-0x1207@gmail.com>

On Tue, Jan 23, 2024 at 04:50:37PM +0800, Furong Xu wrote:
> Commit 56e58d6c8a56 ("net: stmmac: Implement Safety Features in
> XGMAC core") prints safety error descriptions when safety error assert,
> but missed some special errors, and mixed correctable errors and
> uncorrectable errors together.
> This patch complete the error code list and print the type of errors.

The XGMAC ECC Safety code has likely been just copied from the DW GMAC
v5 (DW QoS Eth) part. So this change is partly relevant to that code too. I
can't confirm that the special errors support is relevant to the DW
QoS Eth too (it likely is though), so what about splitting this patch
up into two:
1. Elaborate the errors description for DW GMAC v5 and DW XGMAC.
2. Add new ECC safety errors support.
?

On the other hand if we were sure that both DW QoS Eth and XGMAC
safety features implementation match the ideal solution would be to
refactor out the common code into a dedicated module.

-Serge(y)

> 
> Fixes: 56e58d6c8a56 ("net: stmmac: Implement Safety Features in XGMAC core")
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 36 +++++++++----------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index eb48211d9b0e..ad812484059e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -748,29 +748,29 @@ static void dwxgmac3_handle_mac_err(struct net_device *ndev,
>  }
>  
>  static const struct dwxgmac3_error_desc dwxgmac3_mtl_errors[32]= {
> -	{ true, "TXCES", "MTL TX Memory Error" },
> +	{ true, "TXCES", "MTL TX Memory Correctable Error" },
>  	{ true, "TXAMS", "MTL TX Memory Address Mismatch Error" },
> -	{ true, "TXUES", "MTL TX Memory Error" },
> +	{ true, "TXUES", "MTL TX Memory Uncorrectable Error" },
>  	{ false, "UNKNOWN", "Unknown Error" }, /* 3 */
> -	{ true, "RXCES", "MTL RX Memory Error" },
> +	{ true, "RXCES", "MTL RX Memory Correctable Error" },
>  	{ true, "RXAMS", "MTL RX Memory Address Mismatch Error" },
> -	{ true, "RXUES", "MTL RX Memory Error" },
> +	{ true, "RXUES", "MTL RX Memory Uncorrectable Error" },
>  	{ false, "UNKNOWN", "Unknown Error" }, /* 7 */
> -	{ true, "ECES", "MTL EST Memory Error" },
> +	{ true, "ECES", "MTL EST Memory Correctable Error" },
>  	{ true, "EAMS", "MTL EST Memory Address Mismatch Error" },
> -	{ true, "EUES", "MTL EST Memory Error" },
> +	{ true, "EUES", "MTL EST Memory Uncorrectable Error" },
>  	{ false, "UNKNOWN", "Unknown Error" }, /* 11 */
> -	{ true, "RPCES", "MTL RX Parser Memory Error" },
> +	{ true, "RPCES", "MTL RX Parser Memory Correctable Error" },
>  	{ true, "RPAMS", "MTL RX Parser Memory Address Mismatch Error" },
> -	{ true, "RPUES", "MTL RX Parser Memory Error" },
> +	{ true, "RPUES", "MTL RX Parser Memory Uncorrectable Error" },
>  	{ false, "UNKNOWN", "Unknown Error" }, /* 15 */
> -	{ false, "UNKNOWN", "Unknown Error" }, /* 16 */
> -	{ false, "UNKNOWN", "Unknown Error" }, /* 17 */
> -	{ false, "UNKNOWN", "Unknown Error" }, /* 18 */
> +	{ true, "SCES", "MTL SGF GCL Memory Correctable Error" },
> +	{ true, "SAMS", "MTL SGF GCL Memory Address Mismatch Error" },
> +	{ true, "SUES", "MTL SGF GCL Memory Uncorrectable Error" },
>  	{ false, "UNKNOWN", "Unknown Error" }, /* 19 */
> -	{ false, "UNKNOWN", "Unknown Error" }, /* 20 */
> -	{ false, "UNKNOWN", "Unknown Error" }, /* 21 */
> -	{ false, "UNKNOWN", "Unknown Error" }, /* 22 */
> +	{ true, "RXFCES", "MTL RXF Memory Correctable Error" },
> +	{ true, "RXFAMS", "MTL RXF Memory Address Mismatch Error" },
> +	{ true, "RXFUES", "MTL RXF Memory Uncorrectable Error" },
>  	{ false, "UNKNOWN", "Unknown Error" }, /* 23 */
>  	{ false, "UNKNOWN", "Unknown Error" }, /* 24 */
>  	{ false, "UNKNOWN", "Unknown Error" }, /* 25 */
> @@ -796,13 +796,13 @@ static void dwxgmac3_handle_mtl_err(struct net_device *ndev,
>  }
>  
>  static const struct dwxgmac3_error_desc dwxgmac3_dma_errors[32]= {
> -	{ true, "TCES", "DMA TSO Memory Error" },
> +	{ true, "TCES", "DMA TSO Memory Correctable Error" },
>  	{ true, "TAMS", "DMA TSO Memory Address Mismatch Error" },
> -	{ true, "TUES", "DMA TSO Memory Error" },
> +	{ true, "TUES", "DMA TSO Memory Uncorrectable Error" },
>  	{ false, "UNKNOWN", "Unknown Error" }, /* 3 */
> -	{ true, "DCES", "DMA DCACHE Memory Error" },
> +	{ true, "DCES", "DMA DCACHE Memory Correctable Error" },
>  	{ true, "DAMS", "DMA DCACHE Address Mismatch Error" },
> -	{ true, "DUES", "DMA DCACHE Memory Error" },
> +	{ true, "DUES", "DMA DCACHE Memory Uncorrectable Error" },
>  	{ false, "UNKNOWN", "Unknown Error" }, /* 7 */
>  	{ false, "UNKNOWN", "Unknown Error" }, /* 8 */
>  	{ false, "UNKNOWN", "Unknown Error" }, /* 9 */
> -- 
> 2.34.1
> 
> 

