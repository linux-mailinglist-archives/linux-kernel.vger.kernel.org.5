Return-Path: <linux-kernel+bounces-38522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C06683C0FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69DC1F2352D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B19236123;
	Thu, 25 Jan 2024 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fox/lw+v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F636225DF;
	Thu, 25 Jan 2024 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182421; cv=none; b=DF7QMJVmSsSpm4Da5R2cPC2GIM7OpipgWC3HXASOKVsvaliU66DfhXSZfbj7VKrdTIk/Hc1pkmECtAGjeZvrGXsBn0ZxGsQSZjVjDUrq10aekFFpgMaO/UomdWd+5xXx9x1XIzsVKtino0fs7P7ojqArqv8n3setxFRKxzV7W30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182421; c=relaxed/simple;
	bh=IGYfPI7688VfayKOecv3nY8+501LOVMN+CzGWqpbr0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsu6mDzCxbmFFhYsl8Z8y6iFRLOZabitD6nus8LDddmbu37umIRryUSAKLGVd8Y6pN686M/lA/W8LN3LN8te7a4FiV+yO/QhrxvjlJwKoZ9Uqig/LlYxe+L/33DL0YoMadCSGWA2wHnbuckTxwNv7mRTy680unocI7msC0cn1oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fox/lw+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADE4C433F1;
	Thu, 25 Jan 2024 11:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706182421;
	bh=IGYfPI7688VfayKOecv3nY8+501LOVMN+CzGWqpbr0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fox/lw+voPCBAsWOueVB3iJzpSaSNiWS0nwdr9xKBupWBpySniTn/+Z7a3znK8NBO
	 JoJUpPgusVpkIisNqYcq9bFOCrWGvipvWkekke6dsxP/WcfcQqXr5rBQstC8e97KBa
	 DXPpHpnVJptQOPeOmcn7NAE7BZBkx4m+6/NPq2dFUep1RUrXk1/z0TaqRvfhukAnno
	 Zs1wcoxTFYhINRkq6/ZMkBx7G9lJyQw+3mxMKirPamwSZPnp9oRDcbno0TsHYmcoKk
	 ow4OLBXaxg4LGxvvr38vQCc+MrtBtBbYupRUgzorsbqRSZ0ice10emaqmIMk+L9wdi
	 W2hrpqzE1tO8g==
Date: Thu, 25 Jan 2024 11:33:36 +0000
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH 1/3] octeontx2-af: Create BPIDs free pool
Message-ID: <20240125113336.GF217708@kernel.org>
References: <20240124055014.32694-1-gakula@marvell.com>
 <20240124055014.32694-2-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124055014.32694-2-gakula@marvell.com>

On Wed, Jan 24, 2024 at 11:20:12AM +0530, Geetha sowjanya wrote:
> Current code reserves 64 bpids for 64 LBK channels. But in most
> of the cases multiple LBK channels uses same bpid. This leads
> to inefficient use of bpids. Latest HW support configured multiple
> bpids per channel for other interface types (CGX). For better use
> of these bpids, this patch creates pool of free bpids from reserved
> LBK bpids. This free pool is used to allocate bpid on request for
> another interface like sso etc.
> 
> This patch also reduces the number of bpids for cgx interfaces to 8
> and adds proper error code
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Hi Geetha,

I have some suggestions for possible follow-up below.
That notwithstanding patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 66203a90f052..e1eae16b09b3 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -499,14 +499,84 @@ static void nix_interface_deinit(struct rvu *rvu, u16 pcifunc, u8 nixlf)
>  	rvu_cgx_disable_dmac_entries(rvu, pcifunc);
>  }
>  
> +#define NIX_BPIDS_PER_LMAC	8
> +#define NIX_BPIDS_PER_CPT	1
> +static int nix_setup_bpids(struct rvu *rvu, struct nix_hw *hw, int blkaddr)
> +{
> +	struct nix_bp *bp = &hw->bp;
> +	int err, max_bpids;
> +	u64 cfg;
> +
> +	cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST1);
> +	max_bpids = (cfg >> 12) & 0xFFF;

I don't think this needs to block progress of this patch,
but rather I'm providing this as a suggestion for a follow-up.

I think it would be nice to define a mask, created using GENMASK,
that names the register field (I don't know what it is).
And then uses FIELD_GET here.

Likewise for the 0xFFF below, and possibly elsewhere in this patch.

Further, in patch 2 I see the use of BIT(11) in the following patch.
And existing use of BIT(16) in this file.  I assume are register fields.
If so it would be nice to make #defines to name them too.

> +
> +	/* Reserve the BPIds for CGX and SDP */
> +	bp->cgx_bpid_cnt = rvu->hw->cgx_links * NIX_BPIDS_PER_LMAC;
> +	bp->sdp_bpid_cnt = rvu->hw->sdp_links * (cfg & 0xFFF);
> +	bp->free_pool_base = bp->cgx_bpid_cnt + bp->sdp_bpid_cnt +
> +			     NIX_BPIDS_PER_CPT;
> +	bp->bpids.max = max_bpids - bp->free_pool_base;

..

