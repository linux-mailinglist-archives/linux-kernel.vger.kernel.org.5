Return-Path: <linux-kernel+bounces-83853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA88869F48
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A238CB2342E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884674F200;
	Tue, 27 Feb 2024 18:44:51 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA3B4CB45;
	Tue, 27 Feb 2024 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709059491; cv=none; b=pLB1KJju49krQtkHXNStVyIKKWzZvW5OTk6MjZ11KzKoE5BteJ50j0hJIohIXfiGunLWQTaPv0Zw9ci2rLUyZYpGwm22nqrVJcd49NBASL+zBFX+oLwbEa4fZVOR1finmA2h6L7VoPzO8hZaJzSwHBHFe8b/228i9tY3bQ65GVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709059491; c=relaxed/simple;
	bh=e5LEOg3Dp4RGsCdApUKXSKlKWZtAYCNCKl6mAFykbDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpNGv9kRewaOzWavt+T5eXpLw4CGG8VbnUO+h/ZJOTdoFixp/Bg5sZDoAYp2hZtgisC+Nrk3sRS1CKx7PSjAaFHcE/xcEhXAvZ69fJsjTmagBk/FjAcMxbyxTK+35mbQjnlNSseTiWHTasIBRkEjyCbte6BGanCJK106Vt+fxKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5979D68C4E; Tue, 27 Feb 2024 19:44:44 +0100 (CET)
Date: Tue, 27 Feb 2024 19:44:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-contiguous: remove debug code to removed
 CONFIG_CMA_DEBUG
Message-ID: <20240227184444.GA20094@lst.de>
References: <20240207143825.986-1-lukas.bulwahn@gmail.com> <20240227154424.GB15319@lst.de> <CAKXUXMxctfDVt=+UHNrFfQFMhRitiQVQ1DBu-X0gtuM-WZYJgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKXUXMxctfDVt=+UHNrFfQFMhRitiQVQ1DBu-X0gtuM-WZYJgA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 27, 2024 at 07:23:36PM +0100, Lukas Bulwahn wrote:
> On Tue, Feb 27, 2024 at 4:44 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Thanks,
> >
> > added to the dma-mapping for-next branch.
> >
> 
> Christoph, please drop this patch in your for-next branch if possible.
> 
> Andrew has picked this patch already and squashed it together with the
> commit "mm/cma: drop CONFIG_CMA_DEBUG" in the mm tree. So, you do not
> need to add it anymore.

Ok, I'll drop it.

