Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2552E79D64A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbjILQ2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjILQ2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:28:40 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0165910F2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:28:37 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5FFBE5C0209;
        Tue, 12 Sep 2023 12:28:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 12 Sep 2023 12:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694536116; x=1694622516; bh=TwEWLaTSuiPfXSyZQQREOyn/d6B8hR8gYLY
        TWMqOU5E=; b=u5uNvQki5IChwpw7dqOdoH2RgOW6FYZOpuvWCwUsE8BibTdAFyC
        L8upBPyueKVuNqlWXYbuyapJfDQO20M5AqGh1+0aVvuzhlNl1Krtf7epALgCiqVT
        LtrFxAwSrToe6Er0K0x1TQOGJUoauWNEH1H9r5iPq0AQSuELfsQjRG9AbfXrPLfz
        M6xMX2l1mAwZ9/iAbsgg/soIaEIHaX3K9ZC3DzbgNUM+4GsJ94yzCA90KcELtR75
        KHS06immhfhB8LT+Ir2TYfZg1Ha9S0LWb4+HYB3Mv0LDhdbH1t91QBfV+b73TkEX
        H47LcrEu6//1SXi+ITP1Xw21mEu44uXADXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694536116; x=1694622516; bh=TwEWLaTSuiPfXSyZQQREOyn/d6B8hR8gYLY
        TWMqOU5E=; b=VvFvl65/6cb6f0859IZG6gNDxwnMA826lLsINlmO37UMNzdvAeV
        KvEUnoG/gbp7oYZQ73UiJJiXyyO3TpEqnLU+6Cj6YZlgDhnG825QlYnTlw4bLhp8
        JVzF3PzjA0HovacaUJerZ9qdg24e6KF4dV/PPPOGyaRmAekJv4SkXA1xOQtOe6Hu
        2PxnMutqZ0KnjG0/dlscS3wTI67voGp/+tzIf453kIeWIUhQ+Z7OdrY75DMFLz9A
        zKTXBtzoxlfLqjVkSgz+FubWk32IaGcd5KJfDorOCzW3CrckRl9J49UllAbMkild
        lq6+F8xObqmsMXpZTojwhRCOit/zuGfhW+g==
X-ME-Sender: <xms:tJEAZeVIb57pUqdxIUmoJE_YgIYAJqsma0h03NFEYHAAdXZmaY7F4g>
    <xme:tJEAZanj8YFRIdqLjkI4j2MOJ_5-ibYo7TYPfRP6n_85ILcJONbE1Lh01O1t6TBuN
    Nyn_FYjGKS0QzM3kg>
X-ME-Received: <xmr:tJEAZSYdtAu8pZxgcBGlCvWC9UYY9DCFzkn7cRM4R6wV9M4hojBARP4xTfhznOYf0R-yGqbXC1Z3e-a-Na-xT1YOtLGwpPoTzIK_7zql7vXFnZ72f4fSWT9P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepge
    eghedugfduuddvleehheetgeeltdetieevuefhffevkefhveeufeeiieejgedvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:tJEAZVX5y-W8O65pSbwvxu_xTLUDLrcnktn3B8IhSb4njbkfGL2vpg>
    <xmx:tJEAZYlLe-Z7VDa8mfcLw5r5XY38mJGBo6H2uCzFrUmk6bJGmO6R1A>
    <xmx:tJEAZafbjtknj21ERGDAdujYNuO5HVXupaDHO93g2Bc64OVmJvo8RQ>
    <xmx:tJEAZS39HS__OJmKfRH6E93Gk4uYxkoBHvcUBuE38zNFVpDVMU2ypQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 12:28:35 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Zi Yan <ziy@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [RFC PATCH 4/4] mm/compaction: enable compacting >0 order folios.
Date:   Tue, 12 Sep 2023 12:28:15 -0400
Message-Id: <20230912162815.440749-5-zi.yan@sent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230912162815.440749-1-zi.yan@sent.com>
References: <20230912162815.440749-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Since compaction code can compact >0 order folios, enable it during the
process.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/compaction.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 4300d877b824..f72af74094de 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1087,11 +1087,17 @@ isolate_migratepages_block(struct compact_control *=
cc, unsigned long low_pfn,
 		if (PageCompound(page) && !cc->alloc_contig) {
 			const unsigned int order =3D compound_order(page);
=20
-			if (likely(order <=3D MAX_ORDER)) {
-				low_pfn +=3D (1UL << order) - 1;
-				nr_scanned +=3D (1UL << order) - 1;
+			/*
+			 * Compacting > pageblock_order pages does not improve
+			 * memory fragmentation. Also skip hugetlbfs pages.
+			 */
+			if (likely(order >=3D pageblock_order) || PageHuge(page)) {
+				if (order <=3D MAX_ORDER) {
+					low_pfn +=3D (1UL << order) - 1;
+					nr_scanned +=3D (1UL << order) - 1;
+				}
+				goto isolate_fail;
 			}
-			goto isolate_fail;
 		}
=20
 		/*
@@ -1214,17 +1220,6 @@ isolate_migratepages_block(struct compact_control *c=
c, unsigned long low_pfn,
 					goto isolate_abort;
 				}
 			}
-
-			/*
-			 * folio become large since the non-locked check,
-			 * and it's on LRU.
-			 */
-			if (unlikely(folio_test_large(folio) && !cc->alloc_contig)) {
-				low_pfn +=3D folio_nr_pages(folio) - 1;
-				nr_scanned +=3D folio_nr_pages(folio) - 1;
-				folio_set_lru(folio);
-				goto isolate_fail_put;
-			}
 		}
=20
 		/* The folio is taken off the LRU */
--=20
2.40.1

