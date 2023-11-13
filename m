Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CA37EA19B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjKMRCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjKMRC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:02:26 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8015FD72
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 09:02:22 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EC8375C01C0;
        Mon, 13 Nov 2023 12:02:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 13 Nov 2023 12:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to; s=
        fm3; t=1699894941; x=1699981341; bh=NjTQdoHSfkchZC9ErjtVbGgxIgag
        QAkQl6Bv0Pdns3o=; b=xsBipDatk1P2U27rv1kUFkwMhX791z5A0ZKrm9KsdRqC
        gK6LlO03b005sR4uhJ4VXn3/9VPBjEHQAMKvUVOv7m97BXF8z5zMtwC3ek/ARRhF
        R6v4qyrbVM0PFppvmB6I0q3RMcI3XpCo9wukEu2BBKS5uK7l4ihGaoOTmEPr3uxr
        svRq7x+dKmgUJLdrqLGNvLQlhVBUWAmpTSNILEd4R2eguie/IUl5kxGip9n8nK7h
        VDYs+w5hlskJ1Vz1joC4tprZsQdQ0bJwEblbA1M8i/4tVtw7ss08GvSGirrCjwbX
        oUYKngh5vZP3UEq3PJZRcMkOejKm03tUkeGpA5Z10A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1699894941; x=1699981341; bh=NjTQdoHSfkchZC9ErjtVbGgxIgag
        QAkQl6Bv0Pdns3o=; b=fWrybCjv/T/lN8stCivDytBqdHgfEhrf4OaHsDT1O5FD
        4WUOTiYtFuR1PHaSD6uYBAaSfGOmJtckDM4l3a8ngGYYKTuyQPHtPHNeRpctctNU
        CIoksa10PwZKw4Y18dINEDXQc9Iu1uku41mhRD8qc8lhyB0DdUgdt2lSwMBjQD59
        lkTzkCpwoAx77imEhu1tP+vmNmSAgFEPIh9Dg/aX6csqf5wf9xlQc26XLh0oE+GA
        UPuz+ENFtAnSdnna61Lu8ieDd3c2x3Ta8aEC1kHhBgYlSkRzFq+7jM7fPjBwG8/y
        FBcBCLXq4rHtb6oOkAVDkQLkrNAXAbrkAc1Kpih2LQ==
X-ME-Sender: <xms:nVZSZasMuxJd7pbK2RcAbtnPESEE9UvoUoYLzt9c1hJoTv6Hqb4-rA>
    <xme:nVZSZfcioEbeIQk5yMuiOf5UGVyaIO2_uZcoPSedeRKzk5oRs40NPCSnPPDgGi9Dh
    pV1eHzNJNEymMvkjQ>
X-ME-Received: <xmr:nVZSZVwlrVZv9ogrFqp2eleXxZHUGR6RLQ5xcOnVIVJzf7B-aSU0_zq0V0wnunBhglf1m3brBjnlvG5slFVNx0TC6ilKLBdNxd2xHQ0UDClr4FbX4tEJEzdf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeftddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:nVZSZVP8_PRLJYcdq-4IpD2eloYPw4YBEXz4PiBlbtuJMQ5mtkKtzw>
    <xmx:nVZSZa_FMW01gHgicBuwA6uNrrLYFPw_9osreaK2NFyGxVk1ZvW5QQ>
    <xmx:nVZSZdUBB7bPdxWnr4Yu1N97qn3Hkz5K3Y9clsvV5Vi0wJbxpTV_vA>
    <xmx:nVZSZd2tD3WN64Ry2nFpFUkb6KrNjy5oc1WZlUm2KlKujxjvAg0zYw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Nov 2023 12:02:20 -0500 (EST)
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
Subject: [PATCH v1 3/4] mm/compaction: optimize >0 order folio compaction with free page split.
Date:   Mon, 13 Nov 2023 12:01:56 -0500
Message-ID: <20231113170157.280181-4-zi.yan@sent.com>
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

During migration in a memory compaction, free pages are placed in an array
of page lists based on their order. But the desired free page order (i.e.,
the order of a source page) might not be always present, thus leading to
migration failures. Split a high order free pages when source migration
page has a lower order to increase migration successful rate.

Note: merging free pages when a migration fails and a lower order free
page is returned via compaction_free() is possible, but there is too much
work. Since the free pages are not buddy pages, it is hard to identify
these free pages using existing PFN-based page merging algorithm.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/compaction.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index ec6b5cc7e907..9c083e6b399a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1806,9 +1806,46 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 	struct compact_control *cc = (struct compact_control *)data;
 	struct folio *dst;
 	int order = folio_order(src);
+	bool has_isolated_pages = false;
 
+again:
 	if (!cc->freepages[order].nr_pages) {
-		isolate_freepages(cc);
+		int i;
+
+		for (i = order + 1; i <= MAX_ORDER; i++) {
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
+				post_alloc_hook(freepage, order, __GFP_MOVABLE);
+				if (order)
+					prep_compound_page(freepage, order);
+				dst = page_folio(freepage);
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
@@ -1819,6 +1856,7 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
 	if (order)
 		prep_compound_page(&dst->page, order);
+done:
 	cc->nr_freepages -= 1 << order;
 	return page_rmappable_folio(&dst->page);
 }
-- 
2.42.0

