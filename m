Return-Path: <linux-kernel+bounces-47923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C87918454B4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CB51C2200D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7862515A4A1;
	Thu,  1 Feb 2024 10:01:34 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CC14DA09;
	Thu,  1 Feb 2024 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781694; cv=none; b=VQJR+IizAv8s+rBLLowk9RokLUaqk/wRBmp0o6HUD2lKdloZWRzINChK0i4TRpS/ezB2ko7gtK/OaMGSZHUfpw/GEwnJzZifCYj6C3XBxfIzZ0B1jvsNy6rXnfyN0Z1z9UorQGrjJfG33cyA0llv3QwsZg53w/aeoFIX8qiNBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781694; c=relaxed/simple;
	bh=u1Uvg9oUUncx35nT7fRJBSIHT13HAua1hb3+DJIIYys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5xq5twBEDCNoVtkEczNeDUzZnz1Qf8I1XqqYBSELonn+stfe290EhbVfoRCgiGmNvEXHx9Oubn+B6Q0jeNISBC29u4/4i4SDlg5lcTjZ/vfZ/TrIx9DKm0MqpboU1SXaIFIVS1XrQF1TSvdKxOVAjy9HcbrAmM3EJiEXpvZeNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp80t1706781656tgo37e7k
X-QQ-Originating-IP: PK/NarRl/MeqzaPkEJw+1wfoLdsvqflCxliwHeKqvCs=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 01 Feb 2024 18:00:55 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: iDzLjIm7mlalU/PY8yIblSw4l+whSSFexs4iFFo9II1visfiO9WBNLWdxejp5
	yxvhuC2nsK3JGYv9uUPyIXCsp/H5WbbnR9mCCT7sQ5OmCkaQvtpdywowkdbghLHmaBFgQDI
	/MaBJXR3X9qzCbVnwucu8j1ctbEe5Cck3k6SC37O8Xb6ti7l/YTSdQxAiEJmks5R3InCS4P
	UOsGKLi5gcZ9HmehdmYd2U09SaAueBFQD2q0tiiXvrEduac8wwlH/RkcPfrFcVcYO97iPk8
	hOZxnZN/o0lWky4K1OXev4xc5/zyHT/J/oKP4+oIs+i5G5+gk8jVVLzT+t2mttP+udb7V7K
	4ahNi93Sp9sQKVQGWI1W4IJmM4qZDrvXAHYCOfeZkKWsfaruuqLZx/X0VIpJQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2883616253048242610
Date: Thu, 1 Feb 2024 18:00:54 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Rob Herring <robh@kernel.org>
Cc: frowand.list@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com
Subject: Re: [PATCH 1/2] of: Introduce __of_phandle_update_cache
Message-ID: <F096F87333105368+Zbtr1h1ryCvzA3fB@centos8>
References: <20240130105236.3097126-1-dawei.li@shingroup.cn>
 <20240130105236.3097126-2-dawei.li@shingroup.cn>
 <20240131212938.GB2303754-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131212938.GB2303754-robh@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Rob,

Thanks for reviewing,

On Wed, Jan 31, 2024 at 03:29:38PM -0600, Rob Herring wrote:
> On Tue, Jan 30, 2024 at 06:52:35PM +0800, Dawei Li wrote:
> > For system with CONFIG_OF_DYNAMIC=y, device nodes can be inserted/removed
> > dynamically from device tree. Meanwhile phandle_cache is created for fast
> > lookup from phandle to device node.
> 
> Why do we need it to be fast? What's the usecase (upstream dynamic DT 
> usecases are limited) and what's the performance difference? We'll 
> already cache the new phandle on the first lookup. Plus with only 128 
> entries you are likely evicting an entry. 

I read the history changelog and get that a _lot_ of lookup has been
taken before of_core_init(), so the update of cache in lookup operation
mean a lot to performance improvement.

> 
> > For node detach, phandle cache of removed node is invalidated to maintain
> > the mapping up to date, but the counterpart operation on node attach is
> > not implemented yet.
> > 
> > Thus, implement the cache updating operation on node attach.
> 
> Except this patch does not do that. The next patch does.

Agreed.

> 
> > 
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > ---
> >  drivers/of/base.c       | 16 ++++++++++++++++
> >  drivers/of/of_private.h |  1 +
> >  2 files changed, 17 insertions(+)
> > 
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index b0ad8fc06e80..8b7da27835eb 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -163,6 +163,22 @@ void __of_phandle_cache_inv_entry(phandle handle)
> >  		phandle_cache[handle_hash] = NULL;
> >  }
> >  
> > +void __of_phandle_update_cache(struct device_node *np, bool lock)
> > +{
> > +	u32 hash;
> > +
> > +	if (lock)
> > +		lockdep_assert_held(&devtree_lock);
> 
> I don't think this is a good use of a function parameter.

Yep, assertion under condition is odd.

> 
> > +
> > +	if (unlikely(!np || !np->phandle))
> > +		return;
> > +
> > +	hash = of_phandle_cache_hash(np->phandle);
> > +
> > +	if (!phandle_cache[hash])
> > +		phandle_cache[hash] = np;
> 
> Okay, so you don't evict existing entries. I'm not sure what makes more 

Yes, the updating policy of dynamic nodes is exactly same with static nodes
(the ones in of_core_init()), no eviction/invalidation on _existing_ cache
involved.

> sense. I would imagine old entries are less likely to be accessed than 

Well, I don't think we are gonna implement a full-fledged cache replacing
algorithm such as LRU.

> new phandles for just added nodes given DT is kind of parse it all once 
> (e.g. at boot time). Again, need to understand your usecase and 
> performance differences.

It's kinda awkward that no such usecases/stats are available for now.

My motivation is simple as that:
As long as detached nodes are supposed to be removed from cache entries,
the newly inserted nodes should be added to cache entries, it is more
balanced and symmetric.

And I am sorry if it breaks/undermines current design.

Thanks,

    Dawei

> 
> Rob
> 

