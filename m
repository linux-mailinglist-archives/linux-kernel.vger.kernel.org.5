Return-Path: <linux-kernel+bounces-47170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F30A844A14
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BEBF1C24E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557AB3A1BC;
	Wed, 31 Jan 2024 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rneGBcjK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CA23985A;
	Wed, 31 Jan 2024 21:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736581; cv=none; b=Z6P9TWqYSDLJV912bt+7zA6qlyXLqdbDsQ8eVeCFL8HT0vjjDVQofqLRPZkhktfvaHhjG/JxOxxvbItQ/Tu3cgJjPrko3aqy9WbVA6qxuKeAu5zTwljnaDgp4Kt3mrhX7I+6AH/qqew9Cu083qwL0S8MSKb71dEFvzlE3gG+Vi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736581; c=relaxed/simple;
	bh=+ZV2cN1u7YTwLufo+MSlE1shle2HFWJbJPm0fQ1GzBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iA1ElnyWmf++RnnI/cpraMm0tamJltxZKeFQ9zcwtbieMvxx8RfnovUmPguexFhZ+GDo1jjuIDqFdnUTEdFWPws79NrtRuZb7j9h8GjigiQIKcEUj3nXJ3x5VBzr4XeKatUyADwoWa6vb7alqHIwKVc9fShSmi9mAq+brug5AxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rneGBcjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95A7C433C7;
	Wed, 31 Jan 2024 21:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706736581;
	bh=+ZV2cN1u7YTwLufo+MSlE1shle2HFWJbJPm0fQ1GzBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rneGBcjKDAVaVzQgBrzml07UEUx3wI24DIog/I3aLVvBTFmCTfTrjD/cetBRVfgzf
	 Vzk1WrWXmRQCz09lsQcmHfQsTZ5qpkevKuibFLdZwLy/EUzxaIFWdA68qlaVOZbue7
	 Bnh39eCNZVII4QGvOuCfoN7iGXhsML2STxSss9VHuIISep+1VvBwmKGghFA/dmVBUi
	 yNTbFP2gPkLmsv/KwPdu+KHfqlbYEaJ+aTHCaeqodO9tkMuRHf9xOkYKG6s8evD7js
	 UbH3M4WOEh8wM0lfWIQjnq+CGgZNoBGnTIzgtEx/O2pO0LcdtxmTic2rvsLzpO7+MZ
	 tRih2Alw/HRTQ==
Date: Wed, 31 Jan 2024 15:29:38 -0600
From: Rob Herring <robh@kernel.org>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: frowand.list@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com
Subject: Re: [PATCH 1/2] of: Introduce __of_phandle_update_cache
Message-ID: <20240131212938.GB2303754-robh@kernel.org>
References: <20240130105236.3097126-1-dawei.li@shingroup.cn>
 <20240130105236.3097126-2-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130105236.3097126-2-dawei.li@shingroup.cn>

On Tue, Jan 30, 2024 at 06:52:35PM +0800, Dawei Li wrote:
> For system with CONFIG_OF_DYNAMIC=y, device nodes can be inserted/removed
> dynamically from device tree. Meanwhile phandle_cache is created for fast
> lookup from phandle to device node.

Why do we need it to be fast? What's the usecase (upstream dynamic DT 
usecases are limited) and what's the performance difference? We'll 
already cache the new phandle on the first lookup. Plus with only 128 
entries you are likely evicting an entry. 

> For node detach, phandle cache of removed node is invalidated to maintain
> the mapping up to date, but the counterpart operation on node attach is
> not implemented yet.
> 
> Thus, implement the cache updating operation on node attach.

Except this patch does not do that. The next patch does.

> 
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>  drivers/of/base.c       | 16 ++++++++++++++++
>  drivers/of/of_private.h |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index b0ad8fc06e80..8b7da27835eb 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -163,6 +163,22 @@ void __of_phandle_cache_inv_entry(phandle handle)
>  		phandle_cache[handle_hash] = NULL;
>  }
>  
> +void __of_phandle_update_cache(struct device_node *np, bool lock)
> +{
> +	u32 hash;
> +
> +	if (lock)
> +		lockdep_assert_held(&devtree_lock);

I don't think this is a good use of a function parameter.

> +
> +	if (unlikely(!np || !np->phandle))
> +		return;
> +
> +	hash = of_phandle_cache_hash(np->phandle);
> +
> +	if (!phandle_cache[hash])
> +		phandle_cache[hash] = np;

Okay, so you don't evict existing entries. I'm not sure what makes more 
sense. I would imagine old entries are less likely to be accessed than 
new phandles for just added nodes given DT is kind of parse it all once 
(e.g. at boot time). Again, need to understand your usecase and 
performance differences.

Rob

