Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426317EA19C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjKMRCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjKMRC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:02:27 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1A818D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 09:02:25 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 829795C0099;
        Mon, 13 Nov 2023 12:02:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 13 Nov 2023 12:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to; s=
        fm3; t=1699894944; x=1699981344; bh=nzOUpjfyn/JJJn/Enob781hONORF
        3mJcpBIoO1y6HOc=; b=LLVv3yloNFUmMZ6xGakYy4VMI5jabZP1oX9qTx7H16gO
        1CZG/Vu4y682pbGiU601G2tvZkKoGS/cQelvSjNl8IyVRCvBxY6ZDp/I8Z0El/7X
        9ZfcY15EYusoFRVwvMbdZP6TQvbCHhLECsmgGAFbJf9HFgYb01aD31ORb3xofy3Y
        7MIOzM0o59YHJxOvwcxZHA0/sbuL5Je60bq6A/+EhOnwDSY4kDNInc0UL2GwUU2y
        KoMrFOjoHe/NngSo17AreCt7IaANttkYOr1/Q8o2fk4fb2YI47vmTdRL2ARxdrcs
        37aplOkVJOt1jGNxORVOB3T9vRyR7rMhKXKxozk+5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1699894944; x=1699981344; bh=nzOUpjfyn/JJJn/Enob781hONORF
        3mJcpBIoO1y6HOc=; b=BY18zVIIhn/w0FEXwxzpd9RefEDeDi6eMLhNRbpMZAVb
        9dGnvGsCq+Z6W22Gby2w0+eOoExdovlBnvJ84qpX5Plpj10dvXTreo4EGwYu7EXN
        C0G1KpE+tNFcW/GqNrybEqajzff+3jNMkIQdJaYehnaeJl2Dwkc2E0poBSk45Qbk
        nCPaOWGnMh/SBtyKU3va+yhTH7DvRNKe9NfqaeaXfGUbEQDjCaGg6XRfUbGaQ1YU
        3hnkKo6HsZhFLBGIbuxZHZCximCfxM2GOv+SU6jOJyn/jEb74S9EN0ECVc+h43Bf
        xVLHDT/QAI2Qqt1sAZQ5wYKxhrWruO0RmuXr7juCMQ==
X-ME-Sender: <xms:nlZSZUC51WCAdHY5zjgGa8a1h0CyHrFk8naMFoyvVf008-AGD9CPhA>
    <xme:nlZSZWh8Zc4zceKCSZlMTihWpmgrpTYzajutseTvJ8dKa05tVez911OXR4Usp87UM
    wtBBfoIwELic2Iaqw>
X-ME-Received: <xmr:nlZSZXnAO-a3uWp5XLK49qTug4Kdrfq1nEk-fDTMqaAQLW5IeXj3p2KzVmctDHyUWj7AKaylz0vvg9CI6XybA0ExdVcvIFWnWUi3klgelbBHnu1tDlrFlVV3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeftddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:n1ZSZawVzVgoZ_LGRKvOQ5EKmlSXNOQEJeWIb-K2xu0Vev3fn_ZhmQ>
    <xmx:n1ZSZZSGnm_oOs_22AKHkk6jNlJvZkQRPySmyyeeIufqzMKRryDtoQ>
    <xmx:n1ZSZVbhvty-ldXu0RKlsoEtzG5zHUXpVFewhZYgx2T-T0weX2nrDA>
    <xmx:oFZSZaLxdjx4nozNtjrlypAA8lKdF1RCRmv0taEOIEDUjarbkAdJsA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Nov 2023 12:02:22 -0500 (EST)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Zi Yan <ziy@nvidia.com>, "Huang, Ying" <ying.huang@intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v1 4/4] mm/compaction: optimize >0 order folio compaction by sorting source pages.
Date:   Mon, 13 Nov 2023 12:01:57 -0500
Message-ID: <20231113170157.280181-5-zi.yan@sent.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231113170157.280181-1-zi.yan@sent.com>
References: <20231113170157.280181-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

It should maximize high order free page use and minimize free page splits.
It might be useful before free page merging is implemented.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/compaction.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 9c083e6b399a..91809bee5422 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -127,6 +127,37 @@ static unsigned long release_free_list(struct page_list *freepages)
 }
 
 #ifdef CONFIG_COMPACTION
+
+static void sort_folios_by_order(struct list_head *pages)
+{
+	struct page_list page_list[MAX_ORDER + 1];
+	int order;
+	struct folio *folio, *next;
+
+	for (order = 0; order <= MAX_ORDER; order++)
+		init_page_list(&page_list[order]);
+
+	list_for_each_entry_safe(folio, next, pages, lru) {
+		order = folio_order(folio);
+
+		if (order > MAX_ORDER)
+			continue;
+
+		list_move(&folio->lru, &page_list[order].pages);
+		page_list[order].nr_pages++;
+	}
+
+	for (order = MAX_ORDER; order >= 0; order--) {
+		if (page_list[order].nr_pages) {
+
+			list_for_each_entry_safe(folio, next,
+						 &page_list[order].pages, lru) {
+				list_move_tail(&folio->lru, pages);
+			}
+		}
+	}
+}
+
 bool PageMovable(struct page *page)
 {
 	const struct movable_operations *mops;
@@ -2639,6 +2670,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 				pageblock_start_pfn(cc->migrate_pfn - 1));
 		}
 
+		sort_folios_by_order(&cc->migratepages);
+
 		err = migrate_pages(&cc->migratepages, compaction_alloc,
 				compaction_free, (unsigned long)cc, cc->mode,
 				MR_COMPACTION, &nr_succeeded);
-- 
2.42.0

