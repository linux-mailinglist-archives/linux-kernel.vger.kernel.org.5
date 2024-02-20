Return-Path: <linux-kernel+bounces-73006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5525B85BBF2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102CA281F11
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102D0692F3;
	Tue, 20 Feb 2024 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOVx3Nz6"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE035A4DE;
	Tue, 20 Feb 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431854; cv=none; b=izuVizCIjUStwWb2QEgHmbrbz8aYLYzyAt/AXE2f0Oles04YDqP9sLAatmAvELnmJ8EWXa3AKDH3l4V1vlO2Xdioe27J6qVqeNnA2d6kmGmn2tVqq4Xrcv9jpMHjeu5+St1bTPUxbCkY7e4h2FRMd/PJd4OSUDJJE1qVEZQuuUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431854; c=relaxed/simple;
	bh=MOe1ntfyBbrujcdxdVf3xapPEj8+VoAILYJkCVcv2U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Op/zrv0egxt9J2WGYwQKODFMzxkrQ9zkmESOC+PWxonEK/H1Ghu/p4M1ilthypDfzWQR7LNg8mV51hppBLTzGIXa5y9RvYJlsEbW23u+d0sIYdfGx8ZRBWKgiRkWorj57gsNyC1G2glSk/f9ZQMw7WMoE9TKpxxsK9blyuws4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOVx3Nz6; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d0cdbd67f0so75979401fa.3;
        Tue, 20 Feb 2024 04:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708431850; x=1709036650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7xVIgRYq2zX1M+4Lj3mROKuit32dmjgTDliMwakaDVo=;
        b=AOVx3Nz6NAJXCSfD10GKjtUHj6tflP3upMQdvpSpJjnJZ2PnTqhVrPe7F56y+kuXol
         x279J/VSI61UpCwSjU1vT1X2k06tQQp9FJaYOFGaN3aMPxP1dkx3VZ+/fmshZhdti0Al
         M0YDBOmsvews66Ps6jdHzy2oay1G2NKFqxtIErDpUk6gkzxXD7vuNZl1FfWIQ5jOQ24S
         Y+GylhIEwgtdJxDdG7v/Z5rQk7HGiXTky5i6g9ld71GodN8pFMZxCnyYaFmH+JZ2c0Cf
         kDTpfzebGP01s/9Pf6eYoupiQhkcoFcJChC+ry47klLLy2nsCISsGlEjA/z1vITdVUUf
         iynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708431850; x=1709036650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xVIgRYq2zX1M+4Lj3mROKuit32dmjgTDliMwakaDVo=;
        b=mZ6kLPrghzTfBn4Mk1yLzIOIvAXwEiK8OdRxRlmm0DDST0Ei2Ri4dCW/u1O2tarpbc
         /xOZvesLGnr+LyyxDBleAFSWsPl/H/CURpv/VIsMjShCM30TRiCDvCH6UsCyx/EYcSIB
         iQfqGhr+PylA3Xpsca/rCTFBLh6OGs6MOM7yIvX2IUV4xls2r6TTMCHF/6qJwJ7IC5lQ
         cH+gMQ/yaLGYev7LX4VoAMQcOpf6FW0TwUA3BrTaS7J4QQYnoQxJ7/mRTMYqRVo/RhF0
         mzT7c35BFk7B2MFLQ0opnp4niVrT1/AVsO6mctoswytjSVm+zI5FSUkYNAQmIRmRizs7
         3GfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUxtBgr9vwCbElLCgRhELUkIO62X/KN5rHCa+lZhPDdBof4XR+FmPtC6v6o/YeJbCxygqAuaf8k/kvQ21ftqUELnRYtdRofS8euRj9QGs6Z1gR359hI0jGwoHZrDtOAa9MSy/F
X-Gm-Message-State: AOJu0YxXqJ4ins6gxubX4vF2chHwDrImjFcVeGnQFLHem3hNZXBizRjN
	QEz/xelbUixoTn4/do5s5YBVrwJ/+iuhp5xvNZcdEqws+6hpVsi7
X-Google-Smtp-Source: AGHT+IH0+M4gsIzfcGOa2EqDm7y/fIdjp0DpuJYVAj/0Y6VXOddx4unexLgLZwBdJo/LhWVn7WTRog==
X-Received: by 2002:a2e:97d7:0:b0:2d2:3085:c3ad with SMTP id m23-20020a2e97d7000000b002d23085c3admr5097897ljj.31.1708431850166;
        Tue, 20 Feb 2024 04:24:10 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id n22-20020a2e86d6000000b002d0acb57c89sm1468992ljj.64.2024.02.20.04.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 04:24:09 -0800 (PST)
Date: Tue, 20 Feb 2024 15:24:06 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v2] net: stmmac: mmc_core: Drop interrupt registers from
 stats
Message-ID: <sz3jfyimap4thkhxg76nrv6m2lyk5rwnsve5xxghqt7e5uo6lg@wkxcwsdhp44v>
References: <20240220-stmmac_stats-v2-1-0a78863bec70@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-stmmac_stats-v2-1-0a78863bec70@axis.com>

Hi Jesper

On Tue, Feb 20, 2024 at 01:00:22PM +0100, Jesper Nilsson wrote:
> The MMC IPC interrupt status and interrupt mask registers are
> of little use as Ethernet statistics, but incrementing counters
> based on the current interrupt and interrupt mask registers
> makes them actively misleading.
> 
> For example, if the interrupt mask is set to 0x08420842,
> the current code will increment by that amount each iteration,
> leading to the following sequence of nonsense:
> 
> mmc_rx_ipc_intr_mask: 969816526
> mmc_rx_ipc_intr_mask: 1108361744
> 
> These registers have been included in the Ethernet statistics
> since the first version of MMC back in 2011 (commit 1c901a46d57).
> That commit also mentions the MMC interrupts as
> "something to add later (if actually useful)".
> 
> If the registers are actually useful, they should probably
> be part of the Ethernet register dump instead of statistics,
> but for now, drop the counters for mmc_rx_ipc_intr and
> mmc_rx_ipc_intr_mask completely.
> 
> Signed-off-by: Jesper Nilsson <jesper.nilsson@axis.com>

Thank you very much! Definitely:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

One more statistics-related clean-up you may find useful:

net: stmmac: mmc: Discard double Rx CRC errors counter read
    
DW XGMAC MMC Rx CRC errors counter is read twice in a row. It's redundant
to do so, because unlikely the counter has changed since the first read
much while up to date statistics can be retrieved on the next MMC-read
operation. In that matter Rx CRC errors counter is no different from the
other counters, which are read just once in the same callback. So most
likely the second Rx CRC errors counter read has been added by mistake.
Let's discard it then.
    
Fixes: b6cdf09f51c2 ("net: stmmac: xgmac: Implement MMC counters")

diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
index 8597c6abae8d..759a83100f11 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
@@ -467,8 +467,6 @@ static void dwxgmac_mmc_read(void __iomem *mmcaddr, struct stmmac_counters *mmc)
                             &mmc->mmc_rx_multicastframe_g);
        dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_CRC_ERR,
                             &mmc->mmc_rx_crc_error);
-       dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_CRC_ERR,
-                            &mmc->mmc_rx_crc_error);
        mmc->mmc_rx_run_error += readl(mmcaddr + MMC_XGMAC_RX_RUNT_ERR);
        mmc->mmc_rx_jabber_error += readl(mmcaddr + MMC_XGMAC_RX_JABBER_ERR);
        mmc->mmc_rx_undersize_g += readl(mmcaddr + MMC_XGMAC_RX_UNDER);

-Serge(y)

> ---
> Changes in v2:
> - Drop the misleading registers completely
> - Link to v1: https://lore.kernel.org/r/20240216-stmmac_stats-v1-1-7065fa4613f8@axis.com
> ---
>  drivers/net/ethernet/stmicro/stmmac/mmc.h            | 3 ---
>  drivers/net/ethernet/stmicro/stmmac/mmc_core.c       | 3 ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 --
>  3 files changed, 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc.h b/drivers/net/ethernet/stmicro/stmmac/mmc.h
> index a0c05925883e..8cfba817491b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/mmc.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/mmc.h
> @@ -78,9 +78,6 @@ struct stmmac_counters {
>  	unsigned int mmc_rx_fifo_overflow;
>  	unsigned int mmc_rx_vlan_frames_gb;
>  	unsigned int mmc_rx_watchdog_error;
> -	/* IPC */
> -	unsigned int mmc_rx_ipc_intr_mask;
> -	unsigned int mmc_rx_ipc_intr;
>  	/* IPv4 */
>  	unsigned int mmc_rx_ipv4_gd;
>  	unsigned int mmc_rx_ipv4_hderr;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> index 6a7c1d325c46..ab3b7770f62d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> @@ -279,9 +279,6 @@ static void dwmac_mmc_read(void __iomem *mmcaddr, struct stmmac_counters *mmc)
>  	mmc->mmc_rx_fifo_overflow += readl(mmcaddr + MMC_RX_FIFO_OVERFLOW);
>  	mmc->mmc_rx_vlan_frames_gb += readl(mmcaddr + MMC_RX_VLAN_FRAMES_GB);
>  	mmc->mmc_rx_watchdog_error += readl(mmcaddr + MMC_RX_WATCHDOG_ERROR);
> -	/* IPC */
> -	mmc->mmc_rx_ipc_intr_mask += readl(mmcaddr + MMC_RX_IPC_INTR_MASK);
> -	mmc->mmc_rx_ipc_intr += readl(mmcaddr + MMC_RX_IPC_INTR);
>  	/* IPv4 */
>  	mmc->mmc_rx_ipv4_gd += readl(mmcaddr + MMC_RX_IPV4_GD);
>  	mmc->mmc_rx_ipv4_hderr += readl(mmcaddr + MMC_RX_IPV4_HDERR);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index f628411ae4ae..28accdc98282 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -236,8 +236,6 @@ static const struct stmmac_stats stmmac_mmc[] = {
>  	STMMAC_MMC_STAT(mmc_rx_fifo_overflow),
>  	STMMAC_MMC_STAT(mmc_rx_vlan_frames_gb),
>  	STMMAC_MMC_STAT(mmc_rx_watchdog_error),
> -	STMMAC_MMC_STAT(mmc_rx_ipc_intr_mask),
> -	STMMAC_MMC_STAT(mmc_rx_ipc_intr),
>  	STMMAC_MMC_STAT(mmc_rx_ipv4_gd),
>  	STMMAC_MMC_STAT(mmc_rx_ipv4_hderr),
>  	STMMAC_MMC_STAT(mmc_rx_ipv4_nopay),
> 
> ---
> base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
> change-id: 20240216-stmmac_stats-e3561d460d0e
> 
> Best regards,
> -- 
> 
> /^JN - Jesper Nilsson
> -- 
>                Jesper Nilsson -- jesper.nilsson@axis.com
> 
> 

