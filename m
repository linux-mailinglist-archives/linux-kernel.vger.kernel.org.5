Return-Path: <linux-kernel+bounces-47879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE420845413
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0E6285222
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E56715AAC6;
	Thu,  1 Feb 2024 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4OMQogt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1C04D9F4;
	Thu,  1 Feb 2024 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779886; cv=none; b=joXsrvqQf+bPzp/AL/bHIhSBVE/FoU794xZuCNC4Q62HcONvt0BfT03dHO5jqObUCFeogKxvK6kshYbHmS9aWqbVAbl/DjYOqVaV0/M4LACXvaoE6XwsUj7mmhBtVFpUCONJFci3FbwYeBfRpfaWh9UpD3xudjr8qH0dJm/8h2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779886; c=relaxed/simple;
	bh=NCINvj4Y1T2SJFg7Qok5Q80wpETFi8oJObXS6KhNNjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AV3IyNqI1xN1OFq95l8ngZRg4vRvAIqfDHqlBwaPQGaHmR64SFhg4bIf5DCar/TLJwdqPYPT2Cafd0KZASaibpyCBU3ZGEFxlYEpAo8boEqGDCE6tPMe0vykMOXcf1xc2unYq3tfjegR0SLBWuL20jVbbRepygHKTQWhRVVFJWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4OMQogt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9DDC433F1;
	Thu,  1 Feb 2024 09:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706779885;
	bh=NCINvj4Y1T2SJFg7Qok5Q80wpETFi8oJObXS6KhNNjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4OMQogtkyu0vL8S5TV2Q593vFtymlGsJaf1sxbSKdsN17VUmTdK/ga9qYaQrV9Wb
	 928Hwt1LqE9cnMePmG6qZlixdgRKiEpiWv32XqzsbZs9YplBy5QNMcqzNkS2c/+xKV
	 9ozWzTpqV85BAqIShl3kQd7lQCiBYyXZGDAXNKZ+rD9qaHKDHDWz2wkpdpZVK1mp3g
	 b+/+AQ3XNf0psoILlvoCH6iMSmm93D+mnfa82U3la5hCa0kNweSGGQChH114mx8OuE
	 Ge5hfnXCRxm2Eai7n53R/ndt956xR2sqwLra3OWTg1hz7iaXEdbM2PAtFhVdsw2a1j
	 WYscoU2nXOTVw==
Date: Thu, 1 Feb 2024 10:31:19 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, bcreeley@amd.com,
	sbhatta@marvell.com, gakula@marvell.com, hkelam@marvell.com,
	sumang@marvell.com
Subject: Re: [PATCH net v3] octeontx2-af: Initialize maps.
Message-ID: <20240201093119.GB514352@kernel.org>
References: <20240131024118.254758-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131024118.254758-1-rkannoth@marvell.com>

On Wed, Jan 31, 2024 at 08:11:18AM +0530, Ratheesh Kannoth wrote:
> kmalloc_array() without __GFP_ZERO flag does not initialize
> memory to zero. This causes issues. Use __GFP_ZERO flag for maps and
> bitmap_zalloc() for bimaps.
> 
> Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
> 
> ChangeLogs:
> v2 -> v3: Used GFP_ZERO for normal map arrays
> v1 -> v2: Used bitmap_zalloc() API.
> v0 -> v1: Removed devm_kcalloc()._
> ---
>  .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 26 ++++++++++---------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index 167145bdcb75..6a8f0efd96a5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -1850,8 +1850,8 @@ void npc_mcam_rsrcs_deinit(struct rvu *rvu)
>  {
>  	struct npc_mcam *mcam = &rvu->hw->mcam;
> 
> -	kfree(mcam->bmap);
> -	kfree(mcam->bmap_reverse);
> +	bitmap_free(mcam->bmap);
> +	bitmap_free(mcam->bmap_reverse);
>  	kfree(mcam->entry2pfvf_map);
>  	kfree(mcam->cntr2pfvf_map);
>  	kfree(mcam->entry2cntr_map);
> @@ -1904,13 +1904,11 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
>  	mcam->pf_offset = mcam->nixlf_offset + nixlf_count;
> 
>  	/* Allocate bitmaps for managing MCAM entries */
> -	mcam->bmap = kmalloc_array(BITS_TO_LONGS(mcam->bmap_entries),
> -				   sizeof(long), GFP_KERNEL);
> +	mcam->bmap = bitmap_zalloc(mcam->bmap_entries, GFP_KERNEL);
>  	if (!mcam->bmap)
>  		return -ENOMEM;
> 
> -	mcam->bmap_reverse = kmalloc_array(BITS_TO_LONGS(mcam->bmap_entries),
> -					   sizeof(long), GFP_KERNEL);
> +	mcam->bmap_reverse = bitmap_zalloc(mcam->bmap_entries, GFP_KERNEL);
>  	if (!mcam->bmap_reverse)
>  		goto free_bmap;
> 
> @@ -1918,7 +1916,8 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
> 
>  	/* Alloc memory for saving entry to RVU PFFUNC allocation mapping */
>  	mcam->entry2pfvf_map = kmalloc_array(mcam->bmap_entries,
> -					     sizeof(u16), GFP_KERNEL);
> +					     sizeof(u16),
> +					     GFP_KERNEL | __GFP_ZERO);

Hi Ratheesh,

The use of bitmap_zalloc()/bitmap_free() looks good to me.
But for the kmalloc_array(..., GFP_KERNEL | __GFP_ZERO) cases
I think kcalloc() is the way to go.

>  	if (!mcam->entry2pfvf_map)
>  		goto free_bmap_reverse;
> 
> @@ -1942,7 +1941,8 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
>  		goto free_entry_map;
> 
>  	mcam->cntr2pfvf_map = kmalloc_array(mcam->counters.max,
> -					    sizeof(u16), GFP_KERNEL);
> +					    sizeof(u16),
> +					    GFP_KERNEL | __GFP_ZERO);
>  	if (!mcam->cntr2pfvf_map)
>  		goto free_cntr_bmap;
> 
> @@ -1950,12 +1950,14 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
>  	 * counter's reference count.
>  	 */
>  	mcam->entry2cntr_map = kmalloc_array(mcam->bmap_entries,
> -					     sizeof(u16), GFP_KERNEL);
> +					     sizeof(u16),
> +					     GFP_KERNEL | __GFP_ZERO);
>  	if (!mcam->entry2cntr_map)
>  		goto free_cntr_map;
> 
>  	mcam->cntr_refcnt = kmalloc_array(mcam->counters.max,
> -					  sizeof(u16), GFP_KERNEL);
> +					  sizeof(u16),
> +					  GFP_KERNEL | __GFP_ZERO);
>  	if (!mcam->cntr_refcnt)
>  		goto free_entry_cntr_map;
> 
> @@ -1988,9 +1990,9 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
>  free_entry_map:
>  	kfree(mcam->entry2pfvf_map);
>  free_bmap_reverse:
> -	kfree(mcam->bmap_reverse);
> +	bitmap_free(mcam->bmap_reverse);
>  free_bmap:
> -	kfree(mcam->bmap);
> +	bitmap_free(mcam->bmap);
> 
>  	return -ENOMEM;
>  }
> --
> 2.25.1
> 

-- 
pw-bot: changes-requested

