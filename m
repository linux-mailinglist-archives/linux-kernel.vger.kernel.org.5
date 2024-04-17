Return-Path: <linux-kernel+bounces-147970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C36F8A7BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F4B281AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D635338F;
	Wed, 17 Apr 2024 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPH4Drlv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCB952F6A;
	Wed, 17 Apr 2024 05:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713333354; cv=none; b=FoDRzudjilDA2xKGWFfYfa/APTo7LYwzTiO79P+SJn9h4aQYIhiiik+LhR7LZse5Libc+7PLXoss2hu/ufyBG7gBGuFC8dHF4cvo9GzecAwImloOWhTrw9rymdgfgul00pryoUL6TcPsI2UstR3+r62z/9P96tyYZIiGit3o3fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713333354; c=relaxed/simple;
	bh=O9FmMFUzDkQ7nDs/vZHy+9Q1QnSIFEtJv05CC2EKQho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkNXqZeiurwNDWIVY6KPqkqi5gTG6fH0zY0HgJJpP468uPx5QZC5Od/6j7t7uA+41PUtyG1/UNtu4k/EmG+pOBkRlFqTXIBCUJcQMh2RzMhkjHLlimp/Z6ceLQHKcPP7YdNT8t043nM4G69hnlBOqyyy8oKm+VfVW2ZV9Kh/bz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPH4Drlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED07C072AA;
	Wed, 17 Apr 2024 05:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713333353;
	bh=O9FmMFUzDkQ7nDs/vZHy+9Q1QnSIFEtJv05CC2EKQho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bPH4DrlvslPNp+oELqW1c6KOj4BdlN908yjOXXy3O2woVIYezrjAdETI+jSlN7zbI
	 9AhsYYBEWWEZsNp8/YDr6UbjkDpPuDgOkq0pcXlgTtxcZmToWLt9fObgazLXt86arS
	 B93gTUirCfd5lHLYVMcziUzaIcr6KX5yz+YBVB0wRk0obVw2VOd6ZaMh5e8z12i2Jr
	 RaaqN1vS0VOm4rHMD+oVvZtOUWCsRB4OqExrgg01aOjUXHYHTkj3d/5s8gbpmwzTfK
	 1iO3uDagRMgIXRvu3ba2grpPM5Z58rCFjFVYRH3j+VwgT+WwzJGkVy6m22N1wGjtzf
	 4N2vdLu1l+ySg==
Date: Wed, 17 Apr 2024 08:54:43 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: skseofh@gmail.com, robh@kernel.org, saravanak@google.com,
	akpm@linux-foundation.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Daero Lee <daero_le.lee@samsung.com>
Subject: Re: [PATCH] memblock: add no-map alloc functions
Message-ID: <Zh9kI81ctisgukT8@kernel.org>
References: <20240415142448.333271-1-skseofh@gmail.com>
 <Zh1HP8IWWjexAUKN@kernel.org>
 <20240417023147.ybefdy6fn5drvq5w@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417023147.ybefdy6fn5drvq5w@master>

On Wed, Apr 17, 2024 at 02:31:47AM +0000, Wei Yang wrote:
> On Mon, Apr 15, 2024 at 06:26:55PM +0300, Mike Rapoport wrote:
> [...]
> >> +	
> >
> >This changes behaviour of internal function, what effect will it have on
> >the users?
> >
> >>  	if (!base)
> >>  		return -ENOMEM;
> >>  
> >>  	*res_base = base;
> >>  	if (nomap) {
> >>  		err = memblock_mark_nomap(base, size);
> 
> Mike
> 
> One question may not directly relevant to this thread.
> 
> NOMAP doesn't apply to all arch? I took a look into the direct mapping
> function on x86, memory_map_top_down(). It seems iterate all available pfn
> instead of skipping NOMAP range. 

Right, x86 does not use NOMAP.
NOMAP was introduced to ensure that device/firmware memory on arm64 does
not have an alias mapping in the direct map because MMU does not allow
alias mapping with different caching modes.
 
> >> -		if (err)
> >> -			memblock_phys_free(base, size);
> >>  	}
> >>  
> >>  	kmemleak_ignore_phys(base);
> >
> >-- 
> >Sincerely yours,
> >Mike.
> 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.

