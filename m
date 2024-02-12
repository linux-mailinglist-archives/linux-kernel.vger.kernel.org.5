Return-Path: <linux-kernel+bounces-61995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BE48519B6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A781F23B06
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723243D986;
	Mon, 12 Feb 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="HlmOQr9q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J2YOywBV"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8901B182C5
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755720; cv=none; b=RlfhgeFm4mlLH1otL2UVwD9jEzLWs/G3EB5UHdD8K9LAEvUDDZXgHbG0ADJZMw+2FPxib6+36P4wplzlsN9C5t2AFgcp783Zjx2cSj4zKZhcqkHz/kh7ZCAFCTMP089XFKs1o9NmgtTPSQCKRD6zZyWBcs91/OMEv69xP31xphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755720; c=relaxed/simple;
	bh=IDzhkY1a4910plU/Bf1p6UotGfhcV2qh2ZuJcavuoW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kn0EfuQR50fBqOK/VLaq53O6NRfz8Lq1onJ3BId08Vgzbpuawm8XlkfkaDLMi+HDXpeL9+1HplMQqwms5ezg08HSzg24RwakwfPDW898764WbzZahU+SiviAKbeLVtLoFqFLaSTS6TrTNngCHfRdvliz8eh2S60qR/hxrdZQK7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=HlmOQr9q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J2YOywBV; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 8F20A5C00CA;
	Mon, 12 Feb 2024 11:35:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 12 Feb 2024 11:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1707755717; x=1707842117; bh=/EqPdua3wUu7egs9hj3joQyCeB5KILvG5+1
	7pYfAKJw=; b=HlmOQr9qvHE0N6b7r3vJLZNcb3UVrG8RUx4z6QwPWhLBya5sAT9
	V/S8Zqpwle9MkAqKRpupK3V2y9nYsva6hSKmft+SWN0zTIoSACDHPIyodradZMjy
	g+GChb5rZTZ44gfLzd7CUhTC0ssGdm7FJ4mYXHBBtjFA0hDoYMWCuOFobhFSSMaK
	my8JWVzC16TrYyZO0HNWwVqcee9zpknq/X4JA2fQlF2BU5e2k/PCfbhgTnkzNt2i
	2hZBq9/vVwdpRqc9Jw3Ba02aMdxcuP6xjPriauzPyPw+VO5OH8Q9t/KqKNte/okX
	gxJiwWJoFaUX3BdyN2TVc42jIOZnVCM3oNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1707755717; x=1707842117; bh=/EqPdua3wUu7egs9hj3joQyCeB5KILvG5+1
	7pYfAKJw=; b=J2YOywBVYcHvZh7SL9Ztx6GaM3mrxWauzT0f5e3Y4/dspDxc67z
	0VnElepBVZ/VU9ofd0CW9IdSk+E7tGKMbk72o8MDHt4nIP/V3BV1+7XRh8zkGLZi
	Qwjkb6t/nNlSuJseIqlikcvWUbzFbWnXQJ+MheLqK7u1DlXuf28jrhHStz07sqFi
	0GW/1LGHaNq5478fa5nBMOQpSzr6nmCKNpj7n/tRqAbB07H0Iwze+SKx5tyt2Blm
	H0L4gRsQaUbjFFUNrwbG1TrzHq5cqxNGBkLFKaCIgBOOftaOWtNkzNsfxoiCkguE
	JICNz/Blga59c1UaxavgBIMUYrtQMc6AtlA==
X-ME-Sender: <xms:xUjKZW19TcXlYp1OWqkFk1aHf6XmhvY3ozWfISZLR3GFdWHkFFn0tg>
    <xme:xUjKZZFxIA8lrTbUqCso1VyWk8GcYS4D39llvE_pgcinOXEUmog3HUNuHn_SQ2bGj
    6l9sZ8mdGC7lwvGVQ>
X-ME-Received: <xmr:xUjKZe745P32t8fSTQHQbkGkPADHwFvcv6_x2ChbvJ9z-hmQSncZkRYjiFMshBC34M5zPbsURgREvq_MV7PY7plXtpj6f2X1lqIiq-U-cS0AczBKY5FnL0_G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfrhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeejke
    etkeffleelkeduffdtfedvtdejjeeutdeutdetgeejgfevtdefudejkeeiveenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:xUjKZX09b_Z0b7LBqXtu-UsXl5mZ62eleEsmniGdmZz7gNAJ28_TlA>
    <xmx:xUjKZZFAGzBJJmZD2dofOUdsIndBrXGwhqCuGYOlCvbqYDV5UoSEjQ>
    <xmx:xUjKZQ9gL7y10Chg0dmi4lf-AdaoBVHlFBmxO9_3rUihPP7Ds1xjXg>
    <xmx:xUjKZX9vRLw49H2efiaiekvsz-gEoMdvyUna-_VZZqqtyBIx9PBB1w>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 11:35:16 -0500 (EST)
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
Subject: [PATCH v4 3/3] mm/compaction: optimize >0 order folio compaction with free page split.
Date: Mon, 12 Feb 2024 11:35:10 -0500
Message-ID: <20240212163510.859822-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212163510.859822-1-zi.yan@sent.com>
References: <20240212163510.859822-1-zi.yan@sent.com>
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
Cc: Yu Zhao <yuzhao@google.com>
---
 mm/compaction.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index d0a05a621b67..25908e36b97c 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1832,15 +1832,41 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
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
+		if (!has_isolated_pages) {
+			isolate_freepages(cc);
+			has_isolated_pages = true;
+			goto again;
+		} else
 			return NULL;
 	}
 
-	dst = list_first_entry(&cc->freepages[order], struct folio, lru);
-	list_del(&dst->lru);
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
+	}
+	dst = (struct folio *)freepage;
+
 	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
 	if (order)
 		prep_compound_page(&dst->page, order);
-- 
2.43.0


