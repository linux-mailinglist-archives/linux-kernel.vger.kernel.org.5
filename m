Return-Path: <linux-kernel+bounces-36800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5AE83A6EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E3A1C21821
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20691078B;
	Wed, 24 Jan 2024 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlwkyR4J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3297ED30E;
	Wed, 24 Jan 2024 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092682; cv=none; b=pfn6TZwcnpGz59/utXn3h1+0rNtuDqyWoFgpugOTggHbqxFDyLNO2L0UlSsd9mHV64j5hx3iPZwQnymBJZ2xgQCFFVSf+MK4J8cOerLX6NbJnNIYk5RhEcDsvsFolXJ+PAd3tP+xE0BHZkkgBdG7cTIYhLIt1D2wqhdBKXY7+0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092682; c=relaxed/simple;
	bh=awCUu/zAoPjP441QqLdh/w8BhQUkYprnvRPUfzN5ep8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esXN7/Btu3etVnZ9PT+w/Gja5lfxAepZfI/g9CeRChrSsL0QugylVN49MsOgTmKPn04k4EyoCUc4Oj2ew8mhlD9gQh5iL0w9Dc0ACBXR3PIyAsqncVsTx7yXL6iljj6EruDLaKAts4YG+WdaS/RriMg5d6TRc8IHVKAd8DApbQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlwkyR4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EF9C43390;
	Wed, 24 Jan 2024 10:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706092681;
	bh=awCUu/zAoPjP441QqLdh/w8BhQUkYprnvRPUfzN5ep8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WlwkyR4JKsJVWJxvy5qFdtbu6ox0w/8DRYKl4mirwWL/b44pwh57KHyJrtzft1UeO
	 nW77dIF9Q8S/TXxbHBMQb7iLTI2hlmbriRkw0W+zqmLrsXQfcGfeOf0V2QXdXJJMaK
	 9ft+w9XaFMjoScmLR5vGyPHk+SB4BX1M2rrVKDZ8PzdIYrqlEFfh7x8sXIkSeb92Vs
	 PFsjEahFjvXlgKTJ7UC1NVvf0PBG53qGJebVs+iJeK6/FYcltYzZwJGJxBo7s11Tja
	 YjmoUDJqPWlWcYq76wPgfYH6Gh6CRTy5y/wpGCjvbu7Qgdo6ZrFmCQ6jKC+I1nEJu4
	 y7HHfmLuYD9TQ==
Date: Wed, 24 Jan 2024 10:37:55 +0000
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Suman Ghosh <sumang@marvell.com>
Subject: Re: [EXT] Re: [PATCH net] octeontx2-af: Initialize bitmap arrays.
Message-ID: <20240124103755.GY254773@kernel.org>
References: <20240123051245.3801246-1-rkannoth@marvell.com>
 <20240123181716.GP254773@kernel.org>
 <MWHPR1801MB1918ADCA9FD3FAFAF9CC68B3D37B2@MWHPR1801MB1918.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR1801MB1918ADCA9FD3FAFAF9CC68B3D37B2@MWHPR1801MB1918.namprd18.prod.outlook.com>

On Wed, Jan 24, 2024 at 03:01:15AM +0000, Ratheesh Kannoth wrote:
> > From: Simon Horman <horms@kernel.org>
> > Subject: [EXT] Re: [PATCH net] octeontx2-af: Initialize bitmap arrays.
> > 
> > Hi Ratheesh,
> > 
> > I assume that the reason that the cited commit moved away from devm_
> > allocations was to allow more natural management of the resources
> > independently of the life cycle of the driver instance. Or in other words, the
> > need to free the bitmaps in npc_mcam_rsrcs_deinit() probably indicates that
> > devm_ allocations of them aren't giving us anything.
> > 
> > So, perhaps kcalloc() is more appropriate than devm_kcalloc() ?
> This was a comment from @Subbaraya Sundeep Bhatta during our internal review.  
> Could you please help with below questions/doubts ?
> 1. why devm_kfree() API  is available if it is done independently 

Hi Ratheesh,

I think the question is: if the devm_kfree() calls are removed,
then is the lifecycle of the objects in question managed correctly?

> 2. I could see instances of devm_kfree() usage in current kernel where it does explicit calls.

Sure. But in this case the use of devm_* doesn't seem to be adding
anything if the memory is _always_ freed by explicit calls to
devm_kfree().

