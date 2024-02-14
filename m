Return-Path: <linux-kernel+bounces-66023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E321D855581
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE1F1F2687E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3F91419B3;
	Wed, 14 Feb 2024 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="TYVPJiuB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HqHud2bg"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7A2141988
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948281; cv=none; b=qK9H2H7YiRBEzRe1lTpMfGDZgbTQ+ae1njgv3icR5zVEzETHpMv1mbFN3Gg1LzlianIRm6trABmkRa1WIeI844ydsg320tXHgOaiDRrZaHh+5EQnxJ6OIBDjIPhW6Dt97HTXhFEDkWwtoRvH/Oyyy0M1bQOfzmca4PLwvUHN/II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948281; c=relaxed/simple;
	bh=g9C2eZyu0HruNfOf1LAuN/17P6rNfDs6CE3m85il8Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YP6xn+dB2+69EtovrUzPiU3K6+grDT/typ9A0keu3n96ps1RFd+ji/TO78C45dZWAgO3yIbpx/iXFo46lZIBT8+jUyCvxv00PepUD69NjlYXJKf3bkSRqYe9b9saYsjgGDLSxV3qivsVZY+2hEexOHCzS4issrGmM0f6qHgnxXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=TYVPJiuB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HqHud2bg; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id A39FC5C0086;
	Wed, 14 Feb 2024 17:04:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 14 Feb 2024 17:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1707948278; x=1708034678; bh=wQXk9BjzfNbSk+TtQUdIPTBzuKrc4Uz9jkx
	3jsjH0ns=; b=TYVPJiuB1JXeQIw8A86L+E6UEI1u4J6XAa1bTxbdRDxlLKK6T9f
	1SKgzazMOLcJAFUvzSSe18CwB8JAk2lGIinVMXUswOyaPYyU9MKcZ/0gUG64DlE+
	iotkdloZi8W6SU2CDx3DdY7EyzM4xvyJVxZZXLb5ff1heJw+9iG2AHeNEz3Vm3lj
	KYJcFrSuBUbv53jyQs8E7fCmqs9LxBVjqDdldFm5CkZF1muz32jl8CoUn1UbTF70
	Hpfr5MD9QtU/YpuKYeeNKkTfxw9sVc1pVyr+UFOYioNEyEBUrSfbC7kgo2FHy2eA
	O++9ITQ1VvlZC0PuQw3c7pKO3pQV4eCgbeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1707948278; x=1708034678; bh=wQXk9BjzfNbSk+TtQUdIPTBzuKrc4Uz9jkx
	3jsjH0ns=; b=HqHud2bgtxbuleg7JIQcX/6DijCsT84RWDVT6WNJueqIH8OoZz5
	QHc0wZ5e0+c0P8e1gDZj/PLns77lLJU3OurXalw7lsCU4Ozff3kzIBlFICbROKz5
	Wr63YF3Tp0rb5FvwOHBYA3QDMQpVhypJkSEx/uO5DTSDYRpsgdmNIP3pslQiQaDX
	R7ja2MceSRwLgMR0gMRqB/E973AYvLWD9U7gB4OECl3nI5kGjlQtFHMREofZCpAt
	fMzWhn4bnRDdT0k6lOwItkdiP264YIQXALVJgNDiwRHlAiyu1Ka+tknWutKzxjcG
	aEzhxaMbrq/v1MZr5B2/dFn5qCJbKuW35jg==
X-ME-Sender: <xms:9TjNZd7kmSu9Fa3kz4vWyaVGzot-c0acZdO5Rt5lkZBdrS5St2iOHA>
    <xme:9TjNZa4CxJwL5IZyqdE4mA6txv94XCSwjYJWeIjw8JcB9dYDPWm_1liiyXKCLmYPj
    8O5cBWOlqeh8-o6gg>
X-ME-Received: <xmr:9TjNZUfQpS1-Arjno_B2-HwaFimB7a9cOgwPVqmYnt9hBVBkQwbldE-VMTy_x3QMEOOL1qotcFCFJyR2W_mLFdNIIu0rd4yRoEc6YDJmgRbREQgr5YocwJMi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgdduheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:9jjNZWLkEEFUWNqHdY-fDxZSfXu94_E66Xk-E_86ceAgk4FWsYpKkQ>
    <xmx:9jjNZRIO_aO17nIWtwFtm1C_7Pot0dxdT4izBe0J6kEnjMnn6dw9zg>
    <xmx:9jjNZfzF4UIuOZghM3d75YQ37Tm5p7agofSglLBfSS8K--YUInCkmw>
    <xmx:9jjNZWB2vDbGNvFMBcAM86jT2DyNy59JuRoqY7hUVXQuxJdZtWzePA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 17:04:37 -0500 (EST)
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
Subject: [PATCH v5 3/3] mm/compaction: optimize >0 order folio compaction with free page split.
Date: Wed, 14 Feb 2024 17:04:20 -0500
Message-ID: <20240214220420.1229173-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214220420.1229173-1-zi.yan@sent.com>
References: <20240214220420.1229173-1-zi.yan@sent.com>
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

During migration in a memory compaction, free pages are placed in an array
of page lists based on their order.  But the desired free page order
(i.e., the order of a source page) might not be always present, thus
leading to migration failures and premature compaction termination.  Split
a high order free pages when source migration page has a lower order to
increase migration successful rate.

Note: merging free pages when a migration fails and a lower order free
page is returned via compaction_free() is possible, but there is too much
work.  Since the free pages are not buddy pages, it is hard to identify
these free pages using existing PFN-based page merging algorithm.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Yu Zhao <yuzhao@google.com>
Cc: Adam Manzanares <a.manzanares@samsung.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/compaction.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index d0a05a621b67..b261c5f13bef 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1832,15 +1832,40 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 	struct compact_control *cc = (struct compact_control *)data;
 	struct folio *dst;
 	int order = folio_order(src);
+	bool has_isolated_pages = false;
+	int start_order;
+	struct page *freepage;
+	unsigned long size;
+
+again:
+	for (start_order = order; start_order < NR_PAGE_ORDERS; start_order++)
+		if (!list_empty(&cc->freepages[start_order]))
+			break;
 
-	if (list_empty(&cc->freepages[order])) {
-		isolate_freepages(cc);
-		if (list_empty(&cc->freepages[order]))
+	/* no free pages in the list */
+	if (start_order == NR_PAGE_ORDERS) {
+		if (has_isolated_pages)
 			return NULL;
+		isolate_freepages(cc);
+		has_isolated_pages = true;
+		goto again;
+	}
+
+	freepage = list_first_entry(&cc->freepages[start_order], struct page,
+				lru);
+	size = 1 << start_order;
+
+	list_del(&freepage->lru);
+
+	while (start_order > order) {
+		start_order--;
+		size >>= 1;
+
+		list_add(&freepage[size].lru, &cc->freepages[start_order]);
+		set_page_private(&freepage[size], start_order);
 	}
+	dst = (struct folio *)freepage;
 
-	dst = list_first_entry(&cc->freepages[order], struct folio, lru);
-	list_del(&dst->lru);
 	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
 	if (order)
 		prep_compound_page(&dst->page, order);
-- 
2.43.0


