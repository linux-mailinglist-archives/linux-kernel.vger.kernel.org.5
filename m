Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFF279D648
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbjILQ2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbjILQ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:28:38 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D43210E5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:28:35 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 895995C022E;
        Tue, 12 Sep 2023 12:28:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 12 Sep 2023 12:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694536114; x=1694622514; bh=l1QmaKsAs0paNUi+ts0YZyUc8/34+jxr73p
        6s3d8XgM=; b=CGv0U/fN66Lrt9dDPPSCbQa5AY52dtGJOyDZ0tS7J1mGwebKfps
        NhByliGCEQkj6G9iRYleWIxPKatnk3rJ+a3YHxdHMGGVH37D5ZtF7No7vvUokyK9
        m6rYYOfIbeW5T5WzXU1YQSQh/ujkDjAp/GS6wb3VFCgQtB3NsRu7HsCzxiO6Tay8
        h//tS5qjIls/sjbucjzlUWQVvi/pHFFOKF+KaCd1kZ8XHVTxaT1oZ34RcKwXkOIP
        x7TR4ziqR4Q4enld9IeNFdHldT655BJNYA6nqAxlGEyVFDRzybk+DDVlSOlXPWS3
        KDrLFpYI4P1+1qsZwB1jmNLdY9FPBG7A4Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694536114; x=1694622514; bh=l1QmaKsAs0paNUi+ts0YZyUc8/34+jxr73p
        6s3d8XgM=; b=Vo2kSa9Nzs4JRJzpGNI+smMKi1kWj7MvyRZkuvWyDbwklDKbNhR
        VtKNQ5K4LAtVehWPTp3K0wnH3Z7lwEM2QbBQ0lmVuTrZ5eJ/iF9xFeCDE3GBLowJ
        dswvJsUbW3/QBcQjmazYMI/Db03ANvlW6HavV4F6KDvvaDu7IUCgtWTqpqoOn2hj
        f5x6uu8UTIuEgfADSSmO37zlt8Gk4Jwii64Y4doC0dCIJ07ZtWm0Sw1J9A0ZdAi3
        9awfWb0w/+pt1bzsGqK8LIC+Qz5nXcei30LmyucoiQS5yL4irtCavl0HrIoVZTR+
        supWj9q8RT+NIUfYfm4Uwl/Wuw1hB81+R6g==
X-ME-Sender: <xms:spEAZYM_66JvaRKHU3Mqt2H1UHBSiCmNLWnlc3004ri_7hTtOdID_Q>
    <xme:spEAZe_Y8ycEgCRA2-B5clsR6n4K5NHHqXeP9G4WxVih3VXmzQhpxZPmMT7v_vEN8
    WSDuNAMK_Ym02XDBQ>
X-ME-Received: <xmr:spEAZfRvbk2NexBHl-n-4gzkWPUwHIrK3BbVoVTaXwsrImIs0bRoSglvtn9QiJsUwKNv1EABChzsdx1-MU_FtuEyPqyKTdzEFmB9tPk_Pf7XgOsWA6KE_hWx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepge
    eghedugfduuddvleehheetgeeltdetieevuefhffevkefhveeufeeiieejgedvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:spEAZQtPbkKRaEvTWDIRA0ew_uUJbPHikp2bMDEhP0HzS4CTlEKGjg>
    <xmx:spEAZQdOYwjW7Cy21fknuNY5Adum0hU-1IFfYglXVCs9ArG51ropZw>
    <xmx:spEAZU0fvUtGk8FrgY6KgJsF0xFT4aBOhYfC3fE8xT-sS49XQmxvNw>
    <xmx:spEAZTtbE-Mo3hCjdNv5fZzZ2HbqfT4m22XJx94GpsXGkRTSpHkHqQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 12:28:33 -0400 (EDT)
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
Subject: [RFC PATCH 2/4] mm/compaction: optimize >0 order folio compaction with free page split.
Date:   Tue, 12 Sep 2023 12:28:13 -0400
Message-Id: <20230912162815.440749-3-zi.yan@sent.com>
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
index 868e92e55d27..45747ab5f380 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1801,9 +1801,46 @@ static struct folio *compaction_alloc(struct folio *=
src, unsigned long data)
 	struct compact_control *cc =3D (struct compact_control *)data;
 	struct folio *dst;
 	int order =3D folio_order(src);
+	bool has_isolated_pages =3D false;
=20
+again:
 	if (!cc->freepages[order].nr_free) {
-		isolate_freepages(cc);
+		int i;
+
+		for (i =3D order + 1; i <=3D MAX_ORDER; i++) {
+			if (cc->freepages[i].nr_free) {
+				struct page *freepage =3D
+					list_first_entry(&cc->freepages[i].pages,
+							 struct page, lru);
+
+				int start_order =3D i;
+				unsigned long size =3D 1 << start_order;
+
+				list_del(&freepage->lru);
+				cc->freepages[i].nr_free--;
+
+				while (start_order > order) {
+					start_order--;
+					size >>=3D 1;
+
+					list_add(&freepage[size].lru,
+						&cc->freepages[start_order].pages);
+					cc->freepages[start_order].nr_free++;
+					set_page_private(&freepage[size], start_order);
+				}
+				post_alloc_hook(freepage, order, __GFP_MOVABLE);
+				if (order)
+					prep_compound_page(freepage, order);
+				dst =3D page_folio(freepage);
+				goto done;
+			}
+		}
+		if (!has_isolated_pages) {
+			isolate_freepages(cc);
+			has_isolated_pages =3D true;
+			goto again;
+		}
+
 		if (!cc->freepages[order].nr_free)
 			return NULL;
 	}
@@ -1814,6 +1851,7 @@ static struct folio *compaction_alloc(struct folio *s=
rc, unsigned long data)
 	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
 	if (order)
 		prep_compound_page(&dst->page, order);
+done:
 	cc->nr_freepages -=3D 1 << order;
 	return dst;
 }
--=20
2.40.1

