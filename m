Return-Path: <linux-kernel+bounces-150310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3C98A9D35
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AC59B24B50
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F60C1649DE;
	Thu, 18 Apr 2024 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ewajqedC"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA331411E4;
	Thu, 18 Apr 2024 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450534; cv=none; b=aughiVwx1mu72oPn4tLiYLxMZ0+a9bdNfIgKdW7jwsVIfBNlc3VN+VFSV0oiBItaxM8jIS8o48pXE4YNLFDOJCU++U9fIkRpbgyA+6VuxwqwcRdHvajVozfYjPfjmqV9mD2aE43gLwFz9+jzrD0R60+Wnu3IlSFUtNpMgAKC5+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450534; c=relaxed/simple;
	bh=g9aW0yKi9LhdVrspFApEnJlHcPlnA4Sbkv91eE43FPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhcXiaNPGs2QcK45mgJc6571woVjFh+c6NKrQ2rPm08dJFq1HIJhRKumsvXC+ow8Cq6SFN+c4UalNpPhGW/UkERuzxIsYAq9JoyrYI1JDrKILC1K/LJpBQwNhJZ/SqCrJJiTdKpKI0Avq7toJC0ytCp9VF16Wv9oWYcPHp/WRnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ewajqedC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KiB0o+jVhF1CLQhKFyf/81T8bBmdPfULP1ceIgm0uGE=; b=ewajqedCwqccTk//ZCZ6mL8nMd
	Ypd11wlsChKGQ6szQ8gHTJ0hi6c4n6JPgyP9F/b35SQaHEyfMw/dc5NfXBAhHQ1YsEwKgWfbvG4sa
	lL7etxyLAcdBPK1A+0mxS+ofBQWL/UrfOfwPcFREmtBtGlrTLHfdRSwIL+jT1bEaFhEi3jWRKnSwy
	LIKFW2BO28AXFiStWq8EGEv5PewRFbdE+HfWYfI3XPy/yrA0eyZE64eiX1ex/JjtQeyI6an3FeMlo
	Q+9JoqvmHYO0dxEw3c4Oqnp9SfQzRpiwpT5Gfk/a7/W17VP2XUjjgTq9kWBmDHpA2KBK+nYSu1pfM
	vKbjMW+g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxSki-00000005W7K-0uVU;
	Thu, 18 Apr 2024 14:28:40 +0000
Date: Thu, 18 Apr 2024 15:28:40 +0100
From: Matthew Wilcox <willy@infradead.org>
To: mhklinux@outlook.com
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, hch@lst.de,
	m.szyprowski@samsung.com, corbet@lwn.net, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	petr@tesarici.cz, roberto.sassu@huaweicloud.com
Subject: Re: [PATCH 1/1] Documentation/core-api: Add swiotlb documentation
Message-ID: <ZiEuGIoa-FCE0p4X@casper.infradead.org>
References: <20240418135213.426671-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418135213.426671-1-mhklinux@outlook.com>

On Thu, Apr 18, 2024 at 06:52:13AM -0700, mhkelley58@gmail.com wrote:
> There's currently no documentation for the swiotlb. Add documentation
> describing usage scenarios, the key APIs, and implementation details.
> Group the new documentation with other DMA-related documentation.

This is really well written.  Thank you.  One minor nit below.

> +Usage Scenarios
> +---------------
> +The swiotlb was originally created to handle DMA for devices
> +with addressing limitations. As physical memory sizes grew
> +beyond 4 Gbytes, some devices could only provide 32-bit DMA
> +addresses. By allocating bounce buffer memory below the 4 Gbyte

I'd prefer GiB to Gbytes; we might also prefer GB, Gigabyte or Gibibyte,
but Gbytes seems wrong.

You've written a lot here, and I'm not an expert on swiommu, but nothing
else leapt out at me.

