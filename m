Return-Path: <linux-kernel+bounces-133046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67597899E04
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057C51F21E78
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D940D16D4C1;
	Fri,  5 Apr 2024 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sp9GE3XK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2645A16D309;
	Fri,  5 Apr 2024 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322562; cv=none; b=dhJ2iga6GrlQ8ufPqddLMV8lUd0E5HeH+3zFc8P4SRdMgV3Die6xrtwgvOgiuwD8CzvtaxKIYedpgHrjF2jWvRdVy2RNtPsBGYU6CEf29XgMKud+vsUhs95eJs0zRRl75fvkyp1n3ibtiLYNifUNCY17L1SEBJAuKFll4xPY2xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322562; c=relaxed/simple;
	bh=qAKidEoTYRNtqSmgllugIMY0zUQILjAkcGZs3RLSVu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6kkH8JRBsVkFuht9iSsnTCAE1oUeEP5CZ1T3EoUVQDgsya/P7xlmMlvaf5ZSO6IagBwcF7gI5QTA9PzGYj7yH1IgOvQyqcNLAW42/xr9BJU+cH+BO69sNgxgNXVdPN+g7RLPsVHD0Bxoni8l4gmn4lpAUl9rczGqEIPNirNHQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp9GE3XK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F1FC433C7;
	Fri,  5 Apr 2024 13:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712322562;
	bh=qAKidEoTYRNtqSmgllugIMY0zUQILjAkcGZs3RLSVu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sp9GE3XKQFad/xVU/xs6CqX8rKQ8bVmwZeRKKcNcl1Uc+hKDBhJAt5c/LICvwgyC8
	 JerSGMggqqYjkXzcB8R+XbjxNB1cSUV9BKCF50myYPtyz+q6tKwaWdzxQcJMYmFTfo
	 VvxuhcVZK2YXtzagcb0R4hoTV/9OubOonxrLyje5nMhFTFFVWpdms+is3W1z8DtNYB
	 LSQ8q/revxgaY1UXnfXF8N+ZpypmmJy593i8SrlNw9RuTVsp51BliiH7L6X2DqRSJ3
	 6yeOsYiFkMWyQgI7fxj+N6nZxT9RKWVGChGIIG7iK6ZoB62x719mhiWCswAYRe9/mW
	 hKIVwGGta3LYA==
Date: Fri, 5 Apr 2024 15:09:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the vfs-brauner tree
Message-ID: <20240405-verpachten-mengenlehre-d59b3cc82eda@brauner>
References: <20240404101038.11486a24@canb.auug.org.au>
 <Zg3tWULD56chInTG@codewreck.org>
 <5f56a81b-ac8a-417c-85ad-149f9f64649b@infradead.org>
 <Zg4F9SAGNcmKIa1v@codewreck.org>
 <20240405-entkleidet-performanz-2f46c4f67751@brauner>
 <Zg_g3usopd3KWtF0@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zg_g3usopd3KWtF0@codewreck.org>

On Fri, Apr 05, 2024 at 08:30:38PM +0900, Dominique Martinet wrote:
> Christian Brauner wrote on Fri, Apr 05, 2024 at 12:57:08PM +0200:
> > > Given this I'd favor keeping Randy's older commit in my tree, so I'll
> > > send it to Linus as soon as Christian gives his ok on dropping the
> > > patch (or I guess it doesn't really make that much sense to wait any
> > > longer at this point?)
> > 
> > The patches are part of David's larger netfs-writeback series afaict.
> > So what patch do you need dropped?
> 
> This one:
>  528aa74c091d ("9p: Clean up a kdoc warning.")

Ok, David will drop it.

