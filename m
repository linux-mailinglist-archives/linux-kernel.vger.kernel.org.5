Return-Path: <linux-kernel+bounces-78881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9006F861A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444381F2713C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4B513B2B7;
	Fri, 23 Feb 2024 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWCzy3j4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F128133296
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709897; cv=none; b=eG1CMu8tkRFjJ5GZTSodJRlUogxZCyLnlbcFzKMVbeGXqAJ4sNY+KLV/hta2BQ7T69f90xa/tjqHrRDg88QdBPGLSudpTfNg0EQ/NZNITSa3jDbmNWWG8gxCww9VRSH/SFptD5Hv07FaizrvCApRLwKZOMBR84VeJEZZzuh4Hcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709897; c=relaxed/simple;
	bh=ttrzHMHz6eq+1XGV7AwZlunD2vgDHUr+e4dp54rXgjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VitoFyXy7KKBRW4FsG4j+hENcoHOgqQftH1Pg7Vagmr6krjs2hZkOicXqFhcVUMB41R45gVxCtIzQ6vp/yEbmW9vhTBeFLQYfKKcRYPMuDNRNsqjz6fXT+fNMkHa0/9W9GTUCwx+m8E7u+i6Ri/brAUjQY5C57wwShYbkYUtchg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWCzy3j4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9219C433F1;
	Fri, 23 Feb 2024 17:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708709897;
	bh=ttrzHMHz6eq+1XGV7AwZlunD2vgDHUr+e4dp54rXgjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fWCzy3j43oA72Js7OrwHVRgXRHqDpU/OiUWIAnfNLP4BpGxH6yhmKKDepanL0LF5p
	 +Hr6f+i5d1ys6ys+Xt27OWltlBz5eXb5VoeJns0Un2uVR/yJxFsB60gtp0SE2pXp++
	 QrJPOwE2VBL6NhNZqOUynmviaJGIT81lf/S95a7mIfyxnr4zjWmtfX6Z54G9Z1Lxg1
	 9wK0zLhPfiW/tf2SW4F1OvvFjTS21VZjiUr9dcgMBY68/Xq6bV1rENR70IW4RoG31n
	 JGNeidQ/3gk953LC/C9a24Fywzf1hmWxQmHd6IqKU+dXZgFqdw1Nkv9BkAzs9+lVmk
	 BXjrlrwI98duw==
Date: Fri, 23 Feb 2024 09:38:15 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: Juhyung Park <qkrwngud825@gmail.com>,
	Niklas Cassel <niklas.cassel@wdc.com>,
	Damien Le Moal <damien.lemoal@wdc.com>, daehojeong@google.com,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [f2fs-dev] [PATCH 3/3 v2] f2fs: kill zone-capacity support
Message-ID: <ZdjYBwNTaxbZHpo4@google.com>
References: <20240207005105.3744811-1-jaegeuk@kernel.org>
 <20240207005105.3744811-3-jaegeuk@kernel.org>
 <ZcQSV0HyTwoiW8os@google.com>
 <f174092a-192a-47f9-a1d4-14d86bba266c@kernel.org>
 <ZdT3EqOB-wXM1NLm@google.com>
 <CAD14+f106hmLXMOfLu_cd55rAKmv-KLq-HqCSrKULt27OPhk=w@mail.gmail.com>
 <ZdYylhiPrv9Pa7It@google.com>
 <65e03e4d-b7ef-27f9-2651-eac372f17a9b@bjorling.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65e03e4d-b7ef-27f9-2651-eac372f17a9b@bjorling.me>

On 02/22, Matias Bjørling wrote:
> On 21-02-2024 18:27, Jaegeuk Kim wrote:
> 
> > > Doesn't this break practically all ZNS NVMe devices?
> > 
> > Yes, so here I'm in questioning who is really using w/ zone capacity. If there's
> > no user complaining, I'd like to deprecate this, since this adds code complexity
> > and unnecessary checks.
> > 
> 
> Hi Jaegeuk,
> 
> I like to make a couple of points to hopefully keep the support in a little
> while longer.
> 
> - NVMe-based zone devices continue to be developed with the pow2 zone size
> and zone size != zone cap features. There was some divergence in the
> first-gen drives. However, all the second-gen drives I know of are
> implemented with those features in mind.
> 
> - A very active community is doing work using f2fs, and many of those
> members are working with the ZN540s device (which exposes a pow2 zone size).
> 
> - For drives with a capacity of less than 16TiB, f2fs is an excellent file
> system to use and is really useful for various use cases. We're using the
> f2fs daily for a couple of our workloads.
> 
> Work is ongoing on btrfs and XFS to support zoned storage devices, but they
> have yet to be through the trenches as much as f2fs has been with its zone
> support. So it would be great to have f2fs continue to support the pow2 zone
> sizes, as it is a valuable feature for the currently used and second-gen
> drives that have been released or are soon becoming available.
> 
> If there is a performance concern with the feature re: ZUFS, maybe the pow2
> implementation could be slightly more computationally expensive, as the
> feature, anyway, typically is used on more beefy systems.

Thanks, Matias for the background. It seems to be fair for keeping this for a
while tho, IMO, non-pow2 could address both parties.

> 
> Regards,
> Matias

