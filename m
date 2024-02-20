Return-Path: <linux-kernel+bounces-73513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 261C885C3A5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88CAEB21F31
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67385128830;
	Tue, 20 Feb 2024 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="OSmmEdRo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gmSswlMA"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E3127B6C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453963; cv=none; b=JwGFq4/r7y9VBjT4JktNJj0vLqiJI8kP5M1kKLtfVl8INaJGzE8KQNM/mvNRSWdxaQwLOoI/Xrk2F7ZGgoC8LocYRz/lkKrJOpKzh/xqg7EEH4SeyfF2sp8CRWqO99wAb0vIXp0Kck08SwXcFNYtXrJMq/Nd/zhwWm4LOGHy/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453963; c=relaxed/simple;
	bh=jysQqj4P6OHjX2f8XiwuDNsMZWqBz8wpGxcTRhCdhAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cj89DY+MBOajkwQjWjJ/OrQQeSMhg6ebBsoriOJmrne80Nqvll+/8h28kspZdH/tGXJvVpRpmOyWJnF1p+TKXqLHnKg5p0/iKuLWUceWXID5mBRigv6juibGDl1mv6f8lFT8OMt5efUKkXbPXzYKKdp2SbVMvWoy1HuuLGBkMd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=OSmmEdRo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gmSswlMA; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 4F7983200495;
	Tue, 20 Feb 2024 13:32:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 20 Feb 2024 13:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1708453958; x=1708540358; bh=3te7tA2WvcLuVx5XlSmApKI15+NRwijvQju
	oj0usTfY=; b=OSmmEdRoDCwAgPBnLo0uZuQmHYzka++qvdQaXCk44ZDkenqRSb/
	K0hZmACbnPKTnIsRqCesEe/C/TxyJW1JtH3gDiOYSbyF/lPmgVgJHa74i9MPm7Jh
	+xvtuWp0gV4+1HEK/3fO/FEoeQIJE7pkTCxHyF7EjWGEzWwX2+e43B7Z5mqLpcxV
	CAtDT76PMAUS67DsKKkWC8s/WhKVzmpArFJn5fQwR/PbJICXsLUVT1mK7haRlUCz
	q20JRQS7zbZ2s/C4ugZifll3pLFFfeH/uY8Xy/zbFahW1D/qOhX4BAPxHlVBbf8x
	UiEcd+fQdY2ss9rZHvh9zePsQIzaKA7AxVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1708453958; x=1708540358; bh=3te7tA2WvcLuVx5XlSmApKI15+NRwijvQju
	oj0usTfY=; b=gmSswlMAp/+WPxW+MYBqcg9EJgcY/p1MxHMZAoruS9GrwGchYPy
	3Ous9gaijN0aVRwVNWXOKzWiekjpb3GPsNmM27lXwaOzEATaSZRln67Z2gwdpcwH
	P8tDUsZ96dxTJg1enKijxxxmJ7EY3Ulh9wCBwheJRscZJuQ4kP7yQCOhmIZ3qo1R
	2+zvY0cUT0NAAgl3tWqEjFvleWyVa6PXV6s85zwbJsbCzKG+yuGZEa9yJxxc/kaK
	LKJTYsEgjYX/aYYH27H9VUZDnpg8UqgWttfzdBVGAFgx2ECmXKM/N2iv4mKc2hQN
	STYviACeyGO3U9Pdx7uwp/A5LSjRlCNGLLQ==
X-ME-Sender: <xms:RfDUZS0Q3A5SegZzmvRJ4-Hemd0X50lbFS5jc6gyda3vVgKHiAkB3A>
    <xme:RfDUZVFtrUEroRR85s3fZYlp22TbqEsq5MecnX2nJ5mFanb5NEoEuIXTZ4t21SolP
    4w5CaMhXyP-3jVmdw>
X-ME-Received: <xmr:RfDUZa6pGsNZC8Ufx-baAa9kBa8qmpHiZ3IXiSt9zfjxbrv2NZ_k8XlpVsGdz4Be2h2l_sAf3VC3Rz2xWLMddQDzQ39NzBld18DHoXBiGGbdX00lMqrbgiLq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:RfDUZT3_F5yt_98rEzJvL8oZ0isM4IOFP7dQPROMb0v6UPqx1olIBw>
    <xmx:RfDUZVE_CHTwGmyLtmxONciSr3kGXl2S5iq8ztCQRK44q8SdbF9pOA>
    <xmx:RfDUZc9X-O1YC4UeyItYPPnHeamzp6JOPCq5IB9J7vrJgAkmScoq2Q>
    <xmx:RvDUZT-2fX70h2sgKK-gtcg0GlRu3nbtLoq5fxCc2HYd4GpqGBEKSg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 13:32:37 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Yin, Fengwei" <fengwei.yin@intel.com>,
	Yu Zhao <yuzhao@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rohan Puri <rohan.puri15@gmail.com>,
	Mcgrof Chamberlain <mcgrof@kernel.org>,
	Adam Manzanares <a.manzanares@samsung.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v7 1/4] mm/page_alloc: remove unused fpi_flags in free_pages_prepare()
Date: Tue, 20 Feb 2024 13:32:17 -0500
Message-ID: <20240220183220.1451315-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220183220.1451315-1-zi.yan@sent.com>
References: <20240220183220.1451315-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

Commit 0a54864f8dfb ("kasan: remove PG_skip_kasan_poison flag") removes
the use of fpi_flags in should_skip_kasan_poison() and fpi_flags is only
passed to should_skip_kasan_poison() in free_pages_prepare(). Remove the
unused parameter.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7ae4b74c9e5c..70c1ed3addf3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1061,7 +1061,7 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
  * on-demand allocation and then freed again before the deferred pages
  * initialization is done, but this is not likely to happen.
  */
-static inline bool should_skip_kasan_poison(struct page *page, fpi_t fpi_flags)
+static inline bool should_skip_kasan_poison(struct page *page)
 {
 	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
 		return deferred_pages_enabled();
@@ -1081,10 +1081,10 @@ static void kernel_init_pages(struct page *page, int numpages)
 }
 
 static __always_inline bool free_pages_prepare(struct page *page,
-			unsigned int order, fpi_t fpi_flags)
+			unsigned int order)
 {
 	int bad = 0;
-	bool skip_kasan_poison = should_skip_kasan_poison(page, fpi_flags);
+	bool skip_kasan_poison = should_skip_kasan_poison(page);
 	bool init = want_init_on_free();
 	bool compound = PageCompound(page);
 
@@ -1266,7 +1266,7 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	unsigned long pfn = page_to_pfn(page);
 	struct zone *zone = page_zone(page);
 
-	if (!free_pages_prepare(page, order, fpi_flags))
+	if (!free_pages_prepare(page, order))
 		return;
 
 	/*
@@ -2379,7 +2379,7 @@ static bool free_unref_page_prepare(struct page *page, unsigned long pfn,
 {
 	int migratetype;
 
-	if (!free_pages_prepare(page, order, FPI_NONE))
+	if (!free_pages_prepare(page, order))
 		return false;
 
 	migratetype = get_pfnblock_migratetype(page, pfn);
-- 
2.43.0


