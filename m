Return-Path: <linux-kernel+bounces-128224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512A38957F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F0BB237B9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8C012CD8A;
	Tue,  2 Apr 2024 15:10:32 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C8C12C7F8;
	Tue,  2 Apr 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070631; cv=none; b=bHRt6GXZlUZGVKHy+25o2nT9fgOxH18g6J16Sd/lUap8NTDpsovUo+3ynHO6FbLrLVNqu2j/5SwPka1zmh7Xeo2KvD2+lCW1UtstX/Y4fJnVbdZFG3JKoie0mlyOgMRl2h1UAcvHY5n5eyzwl4+oVNNSWksKLqFuGSFMzRe7qJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070631; c=relaxed/simple;
	bh=sRajvdrV7rqeXiMmpuswBdvcbYNZJGIC389pFfFEwCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfXk8cDM1CKgCgJGeyB2WvJsBJqHdXFqYxbtq7svVA0lpRBkA1m/KKnJUHBkKdbAo9QhPwgHYZ8fLv06C5NP8uSBCsVeRQ2I0SptYhQKVz/osXB8rd+TaLSXuOECUglXCNw/KisB9ThTN/xzCX3A2uBNNVVeLv6JOmIV4Vu34W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8918368CFE; Tue,  2 Apr 2024 17:10:27 +0200 (CEST)
Date: Tue, 2 Apr 2024 17:10:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dexuan Cui <decui@microsoft.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	zhangpeng362@huawei.com, iommu@lists.linux.dev,
	mhklinux@outlook.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] swiotlb: Do not set total_used to 0 in
 swiotlb_create_debugfs_files()
Message-ID: <20240402151027.GC2117@lst.de>
References: <20240329192809.17318-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329192809.17318-1-decui@microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to the dma-mapping tree for Linux 6.9-rc.


