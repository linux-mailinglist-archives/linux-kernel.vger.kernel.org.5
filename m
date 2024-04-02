Return-Path: <linux-kernel+bounces-128222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B32948957DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE702860A4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05C812C528;
	Tue,  2 Apr 2024 15:10:15 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD21812BF22
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070615; cv=none; b=qgU+LTFunxerVAdomYIQPR70lqYtPQ3MALjXYwNh3uFvhS7YCp78Bg/tati+J8l7aJGybb4sQ3JZ7snrDzr0e7RR42/phS7rAop8zwsTH60RYPk9roDpiwukngPhLH6jApBI3ozqJTImNi+/L8iWpiZyeqt9KB2PZXrkt1IXsQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070615; c=relaxed/simple;
	bh=sRajvdrV7rqeXiMmpuswBdvcbYNZJGIC389pFfFEwCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgPW9JTqg9KqENulRo9Pl1/Fga4KtkJq2I7fAc/RQHv9KxSJkDs85EhKRpNFNk+OjgZ8fh+sEG9EW+CJPc0dMfZce7XyfZVxGIhjh3gk0f2hif87x9eIAwYRFXHs0nxUMM2JTezUWLg4DQ3lM4V/rjv7SoZprXbVVwEx1iIYy/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 44D3C68BFE; Tue,  2 Apr 2024 17:10:09 +0200 (CEST)
Date: Tue, 2 Apr 2024 17:10:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Will Deacon <will@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Petr Tesarik <petr@tesarici.cz>
Subject: Re: [PATCH v4 1/2] swiotlb: extend buffer pre-padding to
 alloc_align_mask if necessary
Message-ID: <20240402151009.GA2117@lst.de>
References: <20240325083105.658-1-petrtesarik@huaweicloud.com> <20240325083105.658-2-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325083105.658-2-petrtesarik@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to the dma-mapping tree for Linux 6.9-rc.

