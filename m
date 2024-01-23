Return-Path: <linux-kernel+bounces-34690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C56838625
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF111C265B3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C38120E4;
	Tue, 23 Jan 2024 03:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="Qb1tyZd8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y6CtXNfh"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0D31846
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705981632; cv=none; b=WwYCfZC7LVuNp15Nx1llWc0JUrrp4gv0f1AgAQ5YGPGrcp/4qOfLxgjbIiHif/XbEeEUOgBjl7ERWc+a1tFyb5nY+TO90u3bhGCmVIAE2zuLDCxo9lLz5zcEB7AbhKJaLejmLYdHgdoRvbI2zuU0AXwJ6VKaTdnIIpuxiLZHOPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705981632; c=relaxed/simple;
	bh=ChbwKacJ/HMj8dgI/u5v/MtBZcKgELpNCavNVXl7nio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqqrO93pbUU0e8XeGekVb3Z8UvCXjmQ73Lnn6xKstrrlbeiG5o102vKJ2g6/O0CcxSE9ltd74Gfn9fMpI2BRUBamNTrHHPzegUnOuly5HSgrcWpY37S7Q0pgpOezxVDazl9aToPj3sgrpjSgLRtWKDUrZxD02Y8JP6VDjKyAoGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=Qb1tyZd8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y6CtXNfh; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 6F0165C0335;
	Mon, 22 Jan 2024 22:47:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 22 Jan 2024 22:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1705981630; x=1706068030; bh=nFXKGo9rKF119RBUFLJm4CCIEN+EywVvwTP
	6Mlui2MY=; b=Qb1tyZd8hBxmQdzvOqm/NUrXgHvdk6O59nKJ/UAjsWmR+NJt8o0
	sQMQ3BHdYvYBMUEaTgEVGQ1Yg0p04a5toQcQHryZNBnFE/N5HHcXAjP1RpfJGbBg
	zPxkJCCea7vc0sx3iBeqQy2Kxpj5MYwfVZHYJh8Yqrw/4c2PUnINhNsXKCl+3Wwn
	Z78At21kPb3Rb1YBAt0Fjjn0QCaYhlfnl/tbX02RhfSUi3eBNufKh+/pEgpOOvE7
	DQW1765+/v+nbu7Tf8agm8NoaVUoa4ohTLXtbJk7cY2KtIYz35JKRDhqDy5SnuqG
	5/D/WpH1IkLPUgbJm1HcW4IcFI0J+VhgOxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1705981630; x=1706068030; bh=nFXKGo9rKF119RBUFLJm4CCIEN+EywVvwTP
	6Mlui2MY=; b=y6CtXNfhQE6UEMdpchPy2BMY5+J1ZsljEUixwVzuhCDkmIckFIu
	MXK96g2nWTilV5FRWN9CrDxiyGd9DbYosxAXS9pSZYbZqN17/nULWf+mylk3uEm8
	CCC6nENgxubwk4/OmfXmDfGlB2tHQI5SQV8A4vVyHUsqRKvAvRr6s03hxvmCeViT
	jJerNmHRpIN0E0Fo0RChyTjp5BNs4uZjvZk4SnQFETm0b+iJL0bK5GBtbM5PFhzq
	z574F6aBUj9JBJjAZdDvWvX+Jpk47SjgmRkm6lTvWSFKzUeYVen1otfGPdf9/UGI
	k75oGdJXDYQGfdq8CvnGI/Tp74NEEKpvGWw==
X-ME-Sender: <xms:vjavZbqlPpM-cW5IL-hDh9JyddLcsnVQ0kLD2rY1suCmIiPtkakv4A>
    <xme:vjavZVrI_1U7rSgi84UzSArFB61Z5lKIJqUu0PnGHCefHXBtTWQXyBDu-LR21Q2O7
    8E5spSRhdFTyd6PmA>
X-ME-Received: <xmr:vjavZYOCQSKOHsculXKAEy4n33g5XiRpZvnr3PNCYYhwcRsqfJgKC3jn0HWTy2S39O_-bytLDJ5TtS2ETOcNeWc65-Ap82TGhM2o-CLUssWXqgySaFT3wCza>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekjedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:vjavZe6vzaB3d4dh7di0Awm3L2TA83e77HGYpovW2bKFDT5WKVQrGw>
    <xmx:vjavZa6ATxOrF9R5_2D69K2aB_BlkZb9LgZ6rTc-gvqSul5-AJdlPw>
    <xmx:vjavZWi6xKvC8EZqj0Tqg4zeLDUGuy-yvzumNtc3d8nQB6_DGIGJ1g>
    <xmx:vjavZXzfBl0JOUpb9PjfD-uePouMKz8ej97DPmvhgT7EED9FHk5qrA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 22:47:09 -0500 (EST)
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
Subject: [PATCH v2 3/3] mm/compaction: optimize >0 order folio compaction with free page split.
Date: Mon, 22 Jan 2024 22:46:35 -0500
Message-ID: <20240123034636.1095672-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123034636.1095672-1-zi.yan@sent.com>
References: <20240123034636.1095672-1-zi.yan@sent.com>
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
of page lists based on their order. But the desired free page order (i.e.,
the order of a source page) might not be always present, thus leading to
migration failures and premature compaction termination. Split a high
order free pages when source migration page has a lower order to increase
migration successful rate.

Note: merging free pages when a migration fails and a lower order free
page is returned via compaction_free() is possible, but there is too much
work. Since the free pages are not buddy pages, it is hard to identify
these free pages using existing PFN-based page merging algorithm.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/compaction.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 11f9898e39da..052c82481d64 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1812,9 +1812,43 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 	struct compact_control *cc = (struct compact_control *)data;
 	struct folio *dst;
 	int order = folio_order(src);
+	bool has_isolated_pages = false;
 
+again:
 	if (!cc->freepages[order].nr_pages) {
-		isolate_freepages(cc);
+		int i;
+
+		for (i = order + 1; i < NR_PAGE_ORDERS; i++) {
+			if (cc->freepages[i].nr_pages) {
+				struct page *freepage =
+					list_first_entry(&cc->freepages[i].pages,
+							 struct page, lru);
+
+				int start_order = i;
+				unsigned long size = 1 << start_order;
+
+				list_del(&freepage->lru);
+				cc->freepages[i].nr_pages--;
+
+				while (start_order > order) {
+					start_order--;
+					size >>= 1;
+
+					list_add(&freepage[size].lru,
+						&cc->freepages[start_order].pages);
+					cc->freepages[start_order].nr_pages++;
+					set_page_private(&freepage[size], start_order);
+				}
+				dst = (struct folio *)freepage;
+				goto done;
+			}
+		}
+		if (!has_isolated_pages) {
+			isolate_freepages(cc);
+			has_isolated_pages = true;
+			goto again;
+		}
+
 		if (!cc->freepages[order].nr_pages)
 			return NULL;
 	}
@@ -1822,6 +1856,7 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 	dst = list_first_entry(&cc->freepages[order].pages, struct folio, lru);
 	cc->freepages[order].nr_pages--;
 	list_del(&dst->lru);
+done:
 	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
 	if (order)
 		prep_compound_page(&dst->page, order);
-- 
2.43.0


