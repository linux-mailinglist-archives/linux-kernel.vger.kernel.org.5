Return-Path: <linux-kernel+bounces-118379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D653B88B9E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9005A2C5568
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9D212AACB;
	Tue, 26 Mar 2024 05:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uxmAGfaz"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0B8446BA;
	Tue, 26 Mar 2024 05:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711431850; cv=none; b=XkPdWXlHmHg1O9dSQt+ogU2U/BrihwY3smMulqvm0/i7fWxx/4zPnfknQ4BETORhsL2l7nHmKEBjaB+ioxgfNV5y9Ici4yOgYwH42jZeIdjQpmW/aiaFZ6fK3VAfg0SQvSpfYSJb/GnaDbMqEiKTxgysFhTT1Tuixe9HShTYYec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711431850; c=relaxed/simple;
	bh=tvQqxPyvFgOefL6xeKRQZhrzxYEj/ITsWdt1PsilITA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2NeZhUF6cDSeCxUQwrB5Bt18Y/3d7spJJbR8bKxY8VQJil+DGugCf5gXjomPM5RCw4QSZxtS28Ykqedyvdp6dDkn/9uc3CDKavehiEsMFX//4V92S3zX5yMLF1aXyIKEm+8vJ/F9+5uBl8QIf+iEVnNf+VqeNKjWhEuPifKTSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uxmAGfaz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=B7ubNl0s9pj4zKsixRowhvQt20MjA4ggloW4HBz7kcA=; b=uxmAGfazzOu06FH/R0g2JvhtUy
	EGVJ26Drp9hC+U4EBwaKJ6uA7DDo403PCk9GxwZmaaslD/DXz4kHnooyCcsu9lkYlVKfD19QAaokw
	55qKprqaeI15YsdybJUEfp+OTs1CWJ6goSmLmVk6DO7quABRMj1d4sHzKgX7olD2JSFKxSbUFbcG8
	9F5V6C9IjsrjvfBEwEOuJ9BHemiJfg7NaR/O2YuE5/hassVAtrPAYGDWo0Cl9FOXbBLxR1RvVRKo5
	abd4rkq+IU2Ec3+C3kavNPYfV+FXsWiX/ZFw8MvzLEOe+odwrUAyjTuCGatq7dL0ij3QXA0kK4MY4
	hOXA+9tQ==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rozbT-00000003AWu-2Eob;
	Tue, 26 Mar 2024 05:44:07 +0000
Message-ID: <5e1321ca-0d46-4e9d-a6e5-0560d99f65ff@infradead.org>
Date: Mon, 25 Mar 2024 22:44:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warnings after merge of the mm tree
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240325123603.1bdd6588@canb.auug.org.au>
 <CAJuCfpH4Ee00hM9+B7=mi5Dwjrhov8vUK-KwPuoO3wsD7iJSAQ@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAJuCfpH4Ee00hM9+B7=mi5Dwjrhov8vUK-KwPuoO3wsD7iJSAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/25/24 19:19, Suren Baghdasaryan wrote:
> On Sun, Mar 24, 2024 at 6:36 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> After merging the mm tree, today's linux-next build (htmldocs) produced
>> these warnings:
>>
>> include/linux/slab.h:545: warning: expecting prototype for kmem_cache_alloc(). Prototype was for kmem_cache_alloc_noprof() instead
>> include/linux/slab.h:652: warning: expecting prototype for kmalloc(). Prototype was for kmalloc_noprof() instead
>> include/linux/slab.h:692: warning: expecting prototype for kmalloc_array(). Prototype was for kmalloc_array_noprof() instead
>> include/linux/slab.h:714: warning: expecting prototype for krealloc_array(). Prototype was for krealloc_array_noprof() instead
>> include/linux/slab.h:730: warning: Function parameter or struct member '_n' not described in 'kcalloc'
>> include/linux/slab.h:730: warning: Function parameter or struct member '_size' not described in 'kcalloc'
>> include/linux/slab.h:730: warning: Function parameter or struct member '_flags' not described in 'kcalloc'
>> include/linux/slab.h:730: warning: Excess function parameter 'n' description in 'kcalloc'
>> include/linux/slab.h:730: warning: Excess function parameter 'size' description in 'kcalloc'
>> include/linux/slab.h:730: warning: Excess function parameter 'flags' description in 'kcalloc'
>> include/linux/slab.h:774: warning: expecting prototype for kzalloc(). Prototype was for kzalloc_noprof() instead
>> mm/slab_common.c:1217: warning: expecting prototype for krealloc(). Prototype was for krealloc_noprof() instead
>> mm/util.c:751: warning: expecting prototype for __vcalloc(). Prototype was for __vcalloc_noprof() instead
>> mm/vmalloc.c:3897: warning: expecting prototype for vmalloc(). Prototype was for vmalloc_noprof() instead
>> mm/vmalloc.c:3916: warning: expecting prototype for vmalloc_huge(). Prototype was for vmalloc_huge_noprof() instead
>> mm/vmalloc.c:3953: warning: expecting prototype for vmalloc_user(). Prototype was for vmalloc_user_noprof() instead
>> mm/mempool.c:245: warning: expecting prototype for mempool_init(). Prototype was for mempool_init_noprof() instead
>> mm/mempool.c:271: warning: Function parameter or struct member 'gfp_mask' not described in 'mempool_create_node_noprof'
>> mm/mempool.c:271: warning: Function parameter or struct member 'node_id' not described in 'mempool_create_node_noprof'
>> mm/mempool.c:271: warning: expecting prototype for mempool_create_node(). Prototype was for mempool_create_node_noprof() instead
>>
>> Introduced by commits
>>
>>   c64e38ed88d1 ("mm/slab: enable slab allocation tagging for kmalloc and friends")
>>   ea7b8933f21b ("mempool: hook up to memory allocation profiling")
>>   576477564ede ("mm: vmalloc: enable memory allocation profiling")
>>
>> from the mm-unstable branch of the mm tree.
> 
> Thanks for the report, Stephen!
> Let us check with Randy Dunlap how we should handle these. I assume we
> still want documentation to document kmalloc(), not kmalloc_noprof().
> Maybe there is a way to mute these warnings.

A proposed patch is here:
  https://lore.kernel.org/lkml/20240326054149.2121-1-rdunlap@infradead.org/T/#u


-- 
#Randy

