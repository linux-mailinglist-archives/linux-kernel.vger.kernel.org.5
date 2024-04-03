Return-Path: <linux-kernel+bounces-129444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7373C896AE4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145801F21508
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD8A133981;
	Wed,  3 Apr 2024 09:42:33 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A2E1327F2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137353; cv=none; b=j3SNAFXw0I2OA3bhI6fTbFZ9dAFibVVUFoqI8uo9pE6eMpNbOma2w3hxFfjidnF07H7QaeNGpZ7lDV3sSh0wQftvoCRer6bvBmk+vWoRh7pM2i6pfYGtJJf6GTmoyYagDzMLwCBbOLh4SEw0MBGOye5yLgh3LmWpiRaadjHtzAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137353; c=relaxed/simple;
	bh=QRA1YwCiHBI26HpUVKJGnNMRhX+qFRxiIVI0/xjn2E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuCBU2gNdezPNC5cRELdDLmz9LLDvImwXuPPh0GoGozwRBIVRWaVUQsaLJtE4q2bosMu06uXu2aTzoOu4nWd1xohfWgw9D4R0QV2JHo8h85hRm9Zjuvyb6WWu/FfhWknupaGosWLn1OyFg2+HvjqW+YeUxIB5lJ3xhi1lq8aOho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7B47A68BFE; Wed,  3 Apr 2024 11:42:25 +0200 (CEST)
Date: Wed, 3 Apr 2024 11:42:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Michal Nazarewicz <mina86@mina86.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Yajun Deng <yajun.deng@linux.dev>, Binglei Wang <l3b2w1@gmail.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>, iommu@lists.linux.dev
Subject: Re: [PATCH 14/34] dma/congiguous: avoid warning about unused
 size_bytes
Message-ID: <20240403094225.GA4828@lst.de>
References: <20240403080702.3509288-1-arnd@kernel.org> <20240403080702.3509288-15-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080702.3509288-15-arnd@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

contiguous is misspelled in the subject.

Instead of the __maybe_unused annotation I'd just conver it to a
cpp #define.  I can take care of that if you want.

