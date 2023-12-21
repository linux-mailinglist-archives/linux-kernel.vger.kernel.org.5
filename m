Return-Path: <linux-kernel+bounces-7836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E09C881AE09
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3816C1F246C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E3EAD55;
	Thu, 21 Dec 2023 04:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HTyM/uIy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40B5AD31
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 04:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cB5JX0tcfLHov/oOLKrnY2gF6gOzh9ftJuk4/XCl/z0=; b=HTyM/uIyDJmBjphHYszMh9jD7H
	3JXXxZqMtbbq/4YNg/S0iNx94XKARoA+K4F7ARByzGmOOkIi3c9jkyGT8ydHjA/34VEq5a920K/5c
	mmuLZO1rLYSXeZC6HAfjAgrRmPNl1cKQXJnuJvYptdaqUCKPXqU/Hz6Z0qduM9mjiCr1dTcPlFOl6
	1UoD6Gm1eRCx5wsxdmSVg1RWiw2CuCuwDKXKHTI5i6zRcvT4+/O1omxD/v/9nY5Qb/PrONQeyFA/t
	T4zTRNkWCLDHdrRn5CCGLioaLx1bjUGRrHL44+2ovj1D/MZW1/QDGoOz+Om/WuF4amGKoanCZTY6S
	AWXvKEYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rGAke-004f14-MS; Thu, 21 Dec 2023 04:33:40 +0000
Date: Thu, 21 Dec 2023 04:33:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2 01/40] mm/rmap: rename hugepage_add* to hugetlb_add*
Message-ID: <ZYPAJJacaqDxCtu4@casper.infradead.org>
References: <20231220224504.646757-1-david@redhat.com>
 <20231220224504.646757-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220224504.646757-2-david@redhat.com>

On Wed, Dec 20, 2023 at 11:44:25PM +0100, David Hildenbrand wrote:
> Let's just call it "hugetlb_".
> 
> Yes, it's all already inconsistent and confusing because we have a lot
> of "hugepage_" functions for legacy reasons. But "hugetlb" cannot possibly
> be confused with transparent huge pages, and it matches "hugetlb.c" and
> "folio_test_hugetlb()". So let's minimize confusion in rmap code.
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

