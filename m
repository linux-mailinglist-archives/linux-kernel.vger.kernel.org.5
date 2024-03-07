Return-Path: <linux-kernel+bounces-95772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57499875254
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABEF1C22855
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175F912DD99;
	Thu,  7 Mar 2024 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrKVEwwZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5714E1EB2B;
	Thu,  7 Mar 2024 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823112; cv=none; b=pn6W7cWrihbLHMzmMzcNFdG3e1zPVqc1z7/hqJp7t86xKNDz6JdHgUZGw8ohjn+fvi45GKL6ZMp8STPg8pDQ6CEoP8e0BjNFxIeXZt+jHcSGdOYGWVWEqQVCTjxd1VO1T7TuGJXp9c9Z42b2zKki1EyyfRij3Ci9v7gZW3q17Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823112; c=relaxed/simple;
	bh=jmDXRT1UHHl9wuZwkCbShwjLFqFjqh3WNMPKmI4PmDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irKIyZjdAKVP28S2UqooRsddSXv9BwHFCsUC72Annj1Pc/IruICXu0QmQI6vkaZXKLMPYHkS5gqke7CKzcBbC1dTuGmZP52YsSwNECvQZIDW8FtDTa2Byzxjbzq0mQhPUy405JIb++3U8AVpw5Tj6uHHo6gX2IzwMT353zXu8CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrKVEwwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6196C433F1;
	Thu,  7 Mar 2024 14:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709823111;
	bh=jmDXRT1UHHl9wuZwkCbShwjLFqFjqh3WNMPKmI4PmDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VrKVEwwZDMVXu96zzJnPJ98MvmbYZPykuAClMNSXnd8VstCnROhLvCLwUYqkBDLdL
	 EQuwthvZpj9Rchvva+eRiZRyOTqRU1xPUdWsKyEzSt1DnNRtw2DIFaCLDkv2ZE89MV
	 CExqMzSxfYV9wvGb55cO/DSRs4OgfVcjGfIH+kjY0xieCLx8nTTCkXIG3xl8STRMVW
	 nHjMnHLFiKmLnIH9WqX+qeu31/5LSelkS1TwxDcPsajp0w9zLHBBBjb2X/fgjZ4EQe
	 YxKnFuevN/q2mBGUXl4KOyaGVaziIYB9B7VrrD5T8c9YMZHwokmCojR+3FZixo+oXr
	 YKD8HIDX8J2dA==
Date: Thu, 7 Mar 2024 14:51:46 +0000
From: Simon Horman <horms@kernel.org>
To: Radha Mohan Chintakuntla <radhac@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	lcherian@marvell.com, gakula@marvell.com, hkelam@marvell.com,
	jerinj@marvell.com, sbhatta@marvell.com
Subject: Re: [PATCH] octeontx2-af: Increase maximum BPID channels
Message-ID: <20240307145146.GB576211@kernel.org>
References: <20240306213806.431830-1-radhac@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306213806.431830-1-radhac@marvell.com>

On Wed, Mar 06, 2024 at 01:38:06PM -0800, Radha Mohan Chintakuntla wrote:
> Any NIX interface type can have maximum 256 channels. So increased the
> backpressure ID count to 256 so that it can cover cn9k and cn10k SoCs that
> have different NIX interface types with varied maximum channels.
> 
> Signed-off-by: Radha Mohan Chintakuntla <radhac@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/mbox.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index d5c4f810da61..223a2e39172c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -1207,10 +1207,8 @@ struct nix_bp_cfg_req {
>  	/* bpid_per_chan = 1 assigns separate bp id for each channel */
>  };
>  
> -/* PF can be mapped to either CGX or LBK interface,
> - * so maximum 64 channels are possible.
> - */
> -#define NIX_MAX_BPID_CHAN	64
> +/* Maximum channels any single NIX interface can have */
> +#define NIX_MAX_BPID_CHAN	256
>  struct nix_bp_cfg_rsp {
>  	struct mbox_msghdr hdr;
>  	u16	chan_bpid[NIX_MAX_BPID_CHAN]; /* Channel and bpid mapping */

Hi Radha,

looking over this, I am curious to know how out-of bounds access
to chan_bpid is prevented. The bounds seems to be the
the number of PF or VF rings. Which I assume is derived from
the HW. But if so, what if the HW reports more than NIX_MAX_BPID_CHAN
rings?

On a different note, struct includes the following field:

	u16 bpid[NIX_MAX_BPID_CHAN];

But here the index used seems to be

1. VLAN priority (which has maximum value of 8) if DCB is used
2. 0 otherwise

So perhaps fewer elements are needed?

Apologies in advance if I'm on the wrong track here.


