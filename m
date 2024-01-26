Return-Path: <linux-kernel+bounces-40643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAA783E391
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC076288921
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992C42421C;
	Fri, 26 Jan 2024 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NV5uPXbQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A3C250EB;
	Fri, 26 Jan 2024 21:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706302905; cv=none; b=nLdBmqynZJzxSLkMqFCVIpkUapG38mMnJCVZ6Vki++s+54VFVKTpAfutG59m1/D2jFcYOtnP28GYDl+UhrgGSNotAs1sZA7WgLqT1VhJ7QiCXBfYxRPve4plNNj7LdGGVATGHP9BvvSaOGStpwsXjcOTr4v/ZtmS1XFON9dT6go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706302905; c=relaxed/simple;
	bh=RO+RzcVefXpbLKxJEas0gVSK2qzAcIkqMzHPX6hX3zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQPgxzxlMOAieKy99vUBowOBxV1LtqGnznBSAM+doHvD/zh5BYU51gxjyPu2OKRv0QHuRKm/N3jzye5s1cszjDJjjUn6Anu0v6h4zo/HmW+dqvskr5o0SWyjZNNFQL0iwhqgnY9pxdkiZJlTxiAsEeimzAc54lt3LIF9Xh8U/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NV5uPXbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0CDC433F1;
	Fri, 26 Jan 2024 21:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706302905;
	bh=RO+RzcVefXpbLKxJEas0gVSK2qzAcIkqMzHPX6hX3zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NV5uPXbQFU0HYto3E0oiQJVegdBKQiXhJKx/T7pioy7VkaJwoiTNTDRNo+7NWOEGq
	 E7TYdXVo7Oi/QMEzV43WHfXZ3/e7aF8Ih1C2zFAURSkN/fKkggHsTE54H8Tn7GeZpW
	 JDwE9CW6uduTmzdkqZZp0G78FvzVQc2k6uLqn2ZBChuLpwR5Dmye8y46SJX73mExwW
	 cG7lBWkQ8EcX5HaSpGjScz/1mdvvqKezrg6WD865iP8LVnpPPnhS7K9oIwAMdsVA72
	 wBQqyzF0O11gZCMUeuxQIP6xcMcHWppqF5cA5yP8lm0X3LLzGWInktWZ6RtEiyJi+b
	 QkY2M/cd/Ranw==
Date: Fri, 26 Jan 2024 21:01:39 +0000
From: Simon Horman <horms@kernel.org>
To: Brett Creeley <bcreeley@amd.com>
Cc: Ratheesh Kannoth <rkannoth@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [EXT] Re: [PATCH net] octeontx2-af: Initialize bitmap arrays.
Message-ID: <20240126210139.GD401354@kernel.org>
References: <20240123051245.3801246-1-rkannoth@marvell.com>
 <cf035125-d7fb-4423-8f64-a5be7505243d@amd.com>
 <MWHPR1801MB1918035FC2D71BD916DE716ED37A2@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <05156615-8dcc-41ec-aa6a-aa41c515d25b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05156615-8dcc-41ec-aa6a-aa41c515d25b@amd.com>

On Thu, Jan 25, 2024 at 07:56:22AM -0800, Brett Creeley wrote:
> 
> 
> On 1/24/2024 9:06 PM, Ratheesh Kannoth wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > > From: Brett Creeley <bcreeley@amd.com>
> > > Subject: [EXT] Re: [PATCH net] octeontx2-af: Initialize bitmap arrays.
> > > Is there any reason to not use:
> > > 
> > > bitmap_zalloc() and bitmap_free()?
> > Will follow simon's suggestion to keep patch diff minimal. As bitmap_zalloc() does not give any advantage over the other.
> 
> It does make some sense because in multiple places you are open coding
> bitmap_zalloc()->bitmap_alloc() in multiple places.
> 
> For example:
> 
>         mcam->bmap = kmalloc_array(BITS_TO_LONGS(mcam->bmap_entries),
> +                                  sizeof(long), GFP_KERNEL | __GFP_ZERO);
> 
> This is exactly what bitmap_zalloc()->bitmap_alloc() are doing.

Yes, I agree and I should have suggested using
bitmap_zalloc() and bitmap_free().



