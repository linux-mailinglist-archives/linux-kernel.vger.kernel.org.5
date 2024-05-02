Return-Path: <linux-kernel+bounces-166472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB18F8B9B25
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9154B1F22540
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD11824A4;
	Thu,  2 May 2024 12:56:07 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9799577F1B
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714654567; cv=none; b=Z3SLmuX8jSVmrM38BpOrNgE9wV+JIN5bAlsopma81XGhSP4IM3gMPQTWbEEfbNiJNB4pRrr52b0ns64rkNH0yCJCVz4gRKo6JDiAK9sh6xEtGhS1Bh7tB1bJAD71IG29oeP/+qLfla4D3Aw3WOBIBUMRXzLptDY2Whu/V85ovII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714654567; c=relaxed/simple;
	bh=Edm49+lEiDwR/UHak/i9XLp8JHz+DtOyt1ZL8rAyQWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZGNxNCGb7XSGbZv34PxmU3ETxyg3g4DTkprFvY/2IM8pSK0UiiRW8FJzka3hLBQ2+lb7BJ0nnD0PzXDX8HQ+HgOfJ1vDD/TNt9pO1+gCCfa4TWqXcpZAe2GM7OD29ZDFlhKQrzD08ylR7+Nl75PaMy1geBT6N6ooQII7ldB1TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3FC47227A87; Thu,  2 May 2024 14:56:01 +0200 (CEST)
Date: Thu, 2 May 2024 14:56:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Michael Kelley <mhkelley58@gmail.com>,
	Nikita Ioffe <ioffe@google.com>
Subject: Re: [PATCH] swiotlb: Initialise restricted pool list_head when
 SWIOTLB_DYNAMIC=y
Message-ID: <20240502125601.GA20723@lst.de>
References: <20240502093723.16820-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502093723.16820-1-will@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to the dma-mapping for-linus branch.

I plan to send it to Linus this weekend unless someone find a grave bug
in this pretty obvious one liner.


