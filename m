Return-Path: <linux-kernel+bounces-47928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 895DE8454BE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A5F1F27EFA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49B015B10F;
	Thu,  1 Feb 2024 10:03:26 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4C74D9FE;
	Thu,  1 Feb 2024 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781806; cv=none; b=HSuGtbHsdjbS5duw3bBfnjcLHqWEV5ZVhJL4qsnertoVPVpQbj2TgbDVKlUPGiL1bH/qIezJ2qYf65eG6qcGiYxEij413JmquQDoGoeZYELzMW7n/zS4zhe0OJrMdKNfuBs1e2J38oBYqxe5EZ+TfHR6qNjy/iJfNbZLrWbGFT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781806; c=relaxed/simple;
	bh=DKso4YS41skSyS1xsizUAxJeS/P+dmXu009Uxk+kUnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAMgqs8cddI+Om2O2uZgrdjkV7Es3KB2RxYPbq1G4CMy6E2qunV9imOHRT3hihsuGp1+BxUZs6Qz9rOPuKythpSiZ+2FH7jdDy8YtD24SnyJXsfcahrkEC0bnZ0n9z+16zLB4DYIQqSXAkFxgIM0QHQWbuExYri7MkpC+bKZa8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp78t1706781784tkkpgdyz
X-QQ-Originating-IP: +JWxgiMlSMFigd7fs7xBIqWiE9nm36/UMQXx/r1lq/Q=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 01 Feb 2024 18:03:03 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: oGOjGSUjcuDKQ+aqRluaCH/DpwlgcE5FBILQGBVUf39RpxHBY3eVtKuY1HUzg
	BEDAaBW7ez6PNw9VtMD5dohFgqgrc58OAVA/1f0I8vVeghPYStuLH85zlcgb+pOhUh5CSC3
	hGhOp683YifZnCsIaOdFFgUWSDd+jMNf8VTI+qjDCzcxuEQupC3SvZbX8m53vJHQMUvbfhu
	rcZEw4lgpcKg0SBKFSuXd0Epxk5Ol+EhteJF8QOzyutO9O24kT1jj1/WBotnH8eUBsWC73p
	C/fHUS5aC4L0/gb2vOfCHur7v9XNDd/BL6jU2Fz4EgNYPq639V2ufWkROvL8b8SRqdhDdvo
	u2mtg+kwYGPBTClU3h8qNFX+SpRE9+oul7qSGhpBT7raQP4dGGLb8KQerYAGA9th730lszA
	HwABS8bA45A=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 110192563837687786
Date: Thu, 1 Feb 2024 18:03:03 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Rob Herring <robh@kernel.org>
Cc: frowand.list@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com
Subject: Re: [PATCH 2/2] of: Implment cache update operation on device node
 attach
Message-ID: <A5E6C26210115B9B+ZbtsVxPxJ4WCFtdp@centos8>
References: <20240130105236.3097126-1-dawei.li@shingroup.cn>
 <20240130105236.3097126-3-dawei.li@shingroup.cn>
 <20240131211227.GA2303754-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131211227.GA2303754-robh@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Rob,

Thanks for review.

On Wed, Jan 31, 2024 at 03:12:27PM -0600, Rob Herring wrote:
> On Tue, Jan 30, 2024 at 06:52:36PM +0800, Dawei Li wrote:
> > Use implemented __of_phandle_update_cache to update phandle cache on
> > device node attachment.
> > 
> > While at it, make explicit assertion on locking dependency for
> > __of_phandle_cache_inv_entry.
> 
> 'While at it' is a red flag for should be a separate commit.

Agreed. It should be in a separate commit.

Thanks,

    Dawei

> 
> > 
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > ---
> >  drivers/of/base.c    | 6 ++++--
> >  drivers/of/dynamic.c | 2 ++
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index 8b7da27835eb..44e542b566e1 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -153,6 +153,8 @@ void __of_phandle_cache_inv_entry(phandle handle)
> >  	u32 handle_hash;
> >  	struct device_node *np;
> >  
> > +	lockdep_assert_held(&devtree_lock);
> > +
> >  	if (!handle)
> >  		return;
> >  
> > @@ -195,8 +197,8 @@ void __init of_core_init(void)
> >  	}
> >  	for_each_of_allnodes(np) {
> >  		__of_attach_node_sysfs(np);
> > -		if (np->phandle && !phandle_cache[of_phandle_cache_hash(np->phandle)])
> > -			phandle_cache[of_phandle_cache_hash(np->phandle)] = np;
> > +
> > +		__of_phandle_update_cache(np, false);
> >  	}
> >  	mutex_unlock(&of_mutex);
> >  
> > diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> > index 3bf27052832f..a68bf58f2c24 100644
> > --- a/drivers/of/dynamic.c
> > +++ b/drivers/of/dynamic.c
> > @@ -219,6 +219,8 @@ static void __of_attach_node(struct device_node *np)
> >  			np->phandle = 0;
> >  	}
> >  
> > +	__of_phandle_update_cache(np, true);
> > +
> >  	np->child = NULL;
> >  	np->sibling = np->parent->child;
> >  	np->parent->child = np;
> > -- 
> > 2.27.0
> > 
> 

