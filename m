Return-Path: <linux-kernel+bounces-47112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6316084497D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176D01F28545
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB38639846;
	Wed, 31 Jan 2024 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lx/fv15E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0581C37708;
	Wed, 31 Jan 2024 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735550; cv=none; b=lFIe7176yD/CrtDpoSFdyBtCqzyH3u2WTgcHAkYy+Q05jZIpELSMFSqo9LSjuwVkDzvbWHf26eV3vJvWOcE5BVRjuMYh8cafI3akrOs+j6BPnsVHeqH0/BPzu8FDc3dwXwY4wzPQjGXKmy8atuqqFiQXO0q6SWZYqWBt7s5DvOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735550; c=relaxed/simple;
	bh=TMAJw5trvrHSoQXuua0D6gjbFFkghENqCVXMflEDAhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdyyV4CJHN5PDa30xhey8MW9QD4IYdL24mTj7PAbyrwmv7SkpIhYlDgskvw8oC3pEBWXziZ6S8TtbXKwZ2fVc4mOmPn+J4yl3K1LWrLdUeoWgkXh5/t8k1Y3urvSC/RNp7/yvHFH8sQ3bTw0PmPbH2UaJH+zR49GpJ9REPupnHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lx/fv15E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E0DC433C7;
	Wed, 31 Jan 2024 21:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706735549;
	bh=TMAJw5trvrHSoQXuua0D6gjbFFkghENqCVXMflEDAhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lx/fv15EkNLoOVO7ba8/snGcJDux7+jNGgg1dU+axDvhrPNbIU5HvIQHv+hhExX8G
	 8n02I3gIWcE1FP+BHUE/LnYHPQO6bPf3mgBgaB0KAsJh+cJ5UUdsXjPtHX3oNCR18G
	 HUy+xE7QqpNPo5ZJ4oVYSWw8SS2BNRrRJk4ww50yrH6VPdVw7+I5JQrtQirLB+DiCp
	 sXzGoF4skLPcCxycdTDqdHvnBKjMKkQ5wKK0Ft9HLtiCrA3uc9kzv/Cmy33JWkMEeP
	 42LSppvDylTLBNhVdtvGGynKy8pAb3MVS+wTRynV/KXreTTwW1hTm++FyqRpLTq1un
	 dKRywggBfQl1w==
Date: Wed, 31 Jan 2024 15:12:27 -0600
From: Rob Herring <robh@kernel.org>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: frowand.list@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com
Subject: Re: [PATCH 2/2] of: Implment cache update operation on device node
 attach
Message-ID: <20240131211227.GA2303754-robh@kernel.org>
References: <20240130105236.3097126-1-dawei.li@shingroup.cn>
 <20240130105236.3097126-3-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130105236.3097126-3-dawei.li@shingroup.cn>

On Tue, Jan 30, 2024 at 06:52:36PM +0800, Dawei Li wrote:
> Use implemented __of_phandle_update_cache to update phandle cache on
> device node attachment.
> 
> While at it, make explicit assertion on locking dependency for
> __of_phandle_cache_inv_entry.

'While at it' is a red flag for should be a separate commit.

> 
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>  drivers/of/base.c    | 6 ++++--
>  drivers/of/dynamic.c | 2 ++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 8b7da27835eb..44e542b566e1 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -153,6 +153,8 @@ void __of_phandle_cache_inv_entry(phandle handle)
>  	u32 handle_hash;
>  	struct device_node *np;
>  
> +	lockdep_assert_held(&devtree_lock);
> +
>  	if (!handle)
>  		return;
>  
> @@ -195,8 +197,8 @@ void __init of_core_init(void)
>  	}
>  	for_each_of_allnodes(np) {
>  		__of_attach_node_sysfs(np);
> -		if (np->phandle && !phandle_cache[of_phandle_cache_hash(np->phandle)])
> -			phandle_cache[of_phandle_cache_hash(np->phandle)] = np;
> +
> +		__of_phandle_update_cache(np, false);
>  	}
>  	mutex_unlock(&of_mutex);
>  
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index 3bf27052832f..a68bf58f2c24 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -219,6 +219,8 @@ static void __of_attach_node(struct device_node *np)
>  			np->phandle = 0;
>  	}
>  
> +	__of_phandle_update_cache(np, true);
> +
>  	np->child = NULL;
>  	np->sibling = np->parent->child;
>  	np->parent->child = np;
> -- 
> 2.27.0
> 

