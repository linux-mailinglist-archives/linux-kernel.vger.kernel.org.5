Return-Path: <linux-kernel+bounces-159554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3358B3033
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483731F23288
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D897C13A869;
	Fri, 26 Apr 2024 06:18:59 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3930813A407;
	Fri, 26 Apr 2024 06:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714112339; cv=none; b=JJ+Qz8ioZaGeVCuPo9NLbKvRjC4RjXjCw+TSvvOAwAg0D17wZRSj1S4SlpUy3LKXNdznqUi4N9jfFgAwZZi1gUAYcYnYDu6IQxr6aZRNk0kWZgRmZwv482XWoAwXD7IJm/1lX7j/sjClRbQYKkSdHC1bM8D6irHP5i6YouSdQ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714112339; c=relaxed/simple;
	bh=IAC3rV1q7fFIx2vqAtJsSOMjBW1kF3SrkP4zjxbT0Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsHbMV+zuPBeEUXxYbFo1FTc2OP4b03E4gIgPi5Nzuq667HYjFjSbqxwb2y63tTXyMGQJdUj2AmspIYDyXGXzlQiJcGQjU77VU7xbbRZeUqbQI0MxnR5WOISg65n8IFkfil5CeeipLxkGtl9iemD/Eo/SJhCHxHMlbQjlyNZZfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 599A268C7B; Fri, 26 Apr 2024 08:18:52 +0200 (CEST)
Date: Fri, 26 Apr 2024 08:18:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: mhklinux@outlook.com
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, hch@lst.de,
	m.szyprowski@samsung.com, corbet@lwn.net, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	petr@tesarici.cz, roberto.sassu@huaweicloud.com
Subject: Re: [PATCH v2 1/1] Documentation/core-api: Add swiotlb
 documentation
Message-ID: <20240426061852.GA5645@lst.de>
References: <20240424150253.560999-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424150253.560999-1-mhklinux@outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 24, 2024 at 08:02:53AM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> There's currently no documentation for the swiotlb. Add documentation

s/the // ?  (note that this is used in quite a few places)

Can you use up the full 80 characters for your text?  As-is it reads a
little odd due to the very short lines.

The other thing that strikes me as odd is the placement in the core-api
directory together with other drivers-facing documentation.  Swiotlb
is internal to the dma-mapping subsystem and not really what is a core
API.  I don't really know where else it should be placed, though - nor
do I really understand the "modern" hierarchy in Documentation, but maybe
Jon has a good idea?

Except for these nitpicks the documentation looks good to me, thanks
a lot!

