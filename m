Return-Path: <linux-kernel+bounces-69013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C299858369
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6391F2386E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411AA131729;
	Fri, 16 Feb 2024 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="KeWgkpLH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nA9WCOef"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191E130E27
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103091; cv=none; b=FgRWZsKlHf4aiS4RGtHb3CsBFFtePAtOndqY5lMRLJYS5pjj5ASQc6j2/t0NMfx2fR993r4E6pcPfanphjuL7nFQgdV5Wfl4NnlA9nmPBr5qJ9grygFo55MQQoSlD3BJNlJHUj7ndODGclpgEqQ3YNnStYRkNuaGH4M4sX/gC7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103091; c=relaxed/simple;
	bh=AZRPic9i3EQrfTrEUZCLdsDgVGaWankE3PcrdXSA2IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aW5d9cXhfmBNks5KearoDHitcxkmGiiVJuxbtKUHL55StgOUnkBFf4xva3r7ecxgrQIbWuhiDZ/spfCgfBF3QJuX+lTuB0qAl2Br065gmVFJ+YmrQwWFuZOK4oK8IvtwkjBw7xaKQKZztaklT6NY2CZy9Yz4W6buZ+g4ilMH74Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=KeWgkpLH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nA9WCOef; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id C12E75C0032;
	Fri, 16 Feb 2024 12:04:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 16 Feb 2024 12:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1708103087; x=1708189487; bh=WD56Myi2ma1dKYxOJWeOyvZTZc0rVPwnTQ4
	cjyMsISI=; b=KeWgkpLHvEgib+nAV2iSIRK1oPhtFJyIarQ2y/xOs5yYd/BGSPz
	uimtlyTVya0vqRic9W7BfgqjjY/LiexKL75iLtAUb85dLjtGN25wGGAlDaLiQk6c
	WUFjKBSoUHSGYwyDxL4/B5/EZlmvfLjjqnqSzLtGWJ+zhHfTU9pGWlFeGmNhlSj/
	Zcfc0IBHI4hlVFRbnFLGfZ0xDWKz4kJqM74Go/BaWahS+1feW0dSN8W5DCijwwNS
	Rm3mPzCcdqxQnCZ0Xk42Mq4B9po52QwbtXkezGK10XmaF8hxeNF9oNzD6UZswpm6
	OwwYof0mMUOaovwZeY/Arq5YQqj5aH3ZgHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1708103087; x=1708189487; bh=WD56Myi2ma1dKYxOJWeOyvZTZc0rVPwnTQ4
	cjyMsISI=; b=nA9WCOef4yROrcXUY6gTn/Rl5akvLP8BE1kABzdgqYYdWRfoOUS
	7TwaSNJI/uFo5/U1YOQLzow4T/pS8+OLFS/o/s8lNY5EUzoupMI5myGgUovIa2jX
	yuKRRDYn5DRzsNd4V3HE0f/RUaNIui4QMdOQ8DRjp1Ql3NXakxOmuoEdVuafF5xq
	BAfsVpiMWNsQv+2T59MPucgsAzhdTXWgw0TkXbMOhWsYMqYwkBg9zQJol2c/63N+
	H76UfoGN4mLp/0SyxB+hnvOHXyY5Vo/hVfm1nQfsVqqSTCPUbyc4pPw7YEFFPbJ1
	wLEKWg5SZdqRFHjWVTzTj+rxP1oKJmEUGzQ==
X-ME-Sender: <xms:r5XPZc9FkUuxUBRow1HRLQlUfWJShSMhwAoq398OwDYV-LQfPv0hVw>
    <xme:r5XPZUvPXNb-16E-vT5Bf72XYhT1ZZgoaFAGGjKcgeigoNV1bKG_ZM4Rjn-FI9XXn
    x4A3odzFJNmTWmbFQ>
X-ME-Received: <xmr:r5XPZSD9RcLo643qMFxQU1-5RtCMm9pBlSqnhYgy3txW6C-EzhL2BWjuree69M8gZgXllG6z84BMkt_6y2iHupR4rMm0jUpZ4IfDZk7H_KDA0ZSEkga1WnUq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfrhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeejke
    etkeffleelkeduffdtfedvtdejjeeutdeutdetgeejgfevtdefudejkeeiveenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:r5XPZcfymvfxRGHOwQMjAzymtvxx-5rRT3PTSE36bLdW0KyC6T5A7Q>
    <xmx:r5XPZRPtz0CxvTkQD_QK6r5zmKK5tdVWnAJuyng68Ol6kwallfxSyQ>
    <xmx:r5XPZWmf8e9mxaqBy14czsjIky4GFS0cBqZWK1dpwKD39yutOeiHOQ>
    <xmx:r5XPZcGemWdAfQTnGkWJ-0kH7k8nSopol84fHAG-EKyDhfNbjvJI4w>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Feb 2024 12:04:47 -0500 (EST)
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
Subject: [PATCH v6 1/4] mm/page_alloc: remove unused fpi_flags in free_pages_prepare()
Date: Fri, 16 Feb 2024 12:04:29 -0500
Message-ID: <20240216170432.1268753-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216170432.1268753-1-zi.yan@sent.com>
References: <20240216170432.1268753-1-zi.yan@sent.com>
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

fpi_flags is only passed to should_skip_kasan_poison() but ignored
by the function. Remove the unused parameter.

Signed-off-by: Zi Yan <ziy@nvidia.com>
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


