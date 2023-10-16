Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067097CADCF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjJPPmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjJPPmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:42:14 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F070383
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:42:10 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 28F2D5C02AE;
        Mon, 16 Oct 2023 11:42:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 16 Oct 2023 11:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1697470930; x=1697557330; bh=Ue
        mfV4Gp6AsBHDDvuajuUvalvcQkOw1ynNlnNSjNndE=; b=ao+hJIbVMlCc80+xz1
        DRb0PAtMUumDou9lEsn8CRT1G6I0BmztwUbPoD4L2YWNDxmWqknotRCGoRkpF4ny
        sryhoY3t/7imJJ0uC67mo44/1kmrWwCERxL7gYdwJkoXQZh2Y2cgi0yrsjDudXt5
        dK49EOiCu1AsXiuv1rkcqZwKC4fFdeyxyinrrgVvMS1TN5HwYP5QUCLe3eT8+Gra
        Xhx8ue74igoAiNc7FyXMx0XCYDuQAyZ4VV9xhTd4UPoHhx4WzNWD/DczodFIjPsm
        /oZq+OH3Bcfp03Y2qqn4g7zUCKUQ27+395J7RoBKGu3gugy0D/jqe/b3WbTV3U3V
        Q2Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1697470930; x=1697557330; bh=U
        emfV4Gp6AsBHDDvuajuUvalvcQkOw1ynNlnNSjNndE=; b=LV6+i1vJKKFDJwS4U
        uus6PGhNnzg+DejED9ZlPibFMH0fAS6GSY2dElvzMpPo034PYRmwRLFbOMUJNzZi
        z3PQjtCeT5sujStIojMmv+I2sufJ1pfHGFep+5FkvgpcLeQYD/c0H+KeihQ9jYgr
        qn4z4QiC9Ua/WzCxJsnpPJ8tyfAGTVtkh07dM9NlzeeQYX7HlQ9GI7gXIPP4vknY
        YeOr/KsYtcWWYbNZT6n5Z0SxGy11Tvk1gRkqQ5ab140sHxgW+Q5rGIkdHj9IY1z7
        VcCwh0hQ5vRgS/NlU2P5fbEQ+pn3tcB3tA2qGA5/xLs6VS0Za12ddh+s0M8BfvDB
        imT8Q==
X-ME-Sender: <xms:0VktZXOhB-hylousPrLUq7zMUIrlPila4Xcqs6dZ_m9pIbe5OTU8Pg>
    <xme:0VktZR8sR37QkxFZYSTeBnavJh5EALyeGifFuRB4Kt0r-mxYStXRMF6qsCOOrXtVQ
    ATHhtymwLR3KaEW_g>
X-ME-Received: <xmr:0VktZWT75TsvOMjDpNW1hlbwS_3OKn8KzjUgaPZMmd9z0wRi3JoLrYuV_T2ARcTXljJhFQNd0K-9jeR4yau1FURrplSVDeX8Jf4rAjkRWYGrB3ixJJwllld2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedtgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkfforhgggfestdhqredtredttdenucfhrhhomhepkghiucgjrghn
    uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnheptdfghfdtte
    eltdekiefhfeeuueehvdduhfdvieefvedtkedttefgieeijeeuhfdtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnth
    drtghomh
X-ME-Proxy: <xmx:0VktZbtN2931qimzKTyCnDIOJb0W00pwdO08V_W6y9thzk1TB9mI6g>
    <xmx:0VktZffe3Yzpi_PApkWn8uAYL9KGRi_ltK59Lm4V00EX9zstWWNoYg>
    <xmx:0VktZX11ZI8sLAPbbHh97pzd-wr9t0JKNUv7GP8-TM8DDPVnOXRi7g>
    <xmx:0lktZXRJvOzI0FxZZIKoe6M68RbrccSrqrKHZoCBHpEZSmRxRUoesw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Oct 2023 11:42:09 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH v2] mm/migrate: correct nr_failed in migrate_pages_sync()
Date:   Mon, 16 Oct 2023 11:41:56 -0400
Message-ID: <20231016154156.1948815-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.42.0
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

nr_failed was missing the large folio splits from migrate_pages_batch()
and can cause a mismatch between migrate_pages() return value and the
number of not migrated pages, i.e., when the return value of
migrate_pages() is 0, there are still pages left in the from page list.
It will happen when a non-PMD THP large folio fails to migrate due to
-ENOMEM and is split successfully but not all the split pages are not
migrated, migrate_pages_batch() would return non-zero, but
astats.nr_thp_split =3D 0. nr_failed would be 0 and returned to the caller
of migrate_pages(), but the not migrated pages are left in the from page
list without being added back to LRU lists.

Fix it by adding a new nr_split counter for large folio splits and adding
it to nr_failed in migrate_page_sync() after migrate_pages_batch() is
done.

Fixes: 2ef7dbb26990 ("migrate_pages: try migrate in batch asynchronously fi=
rstly")
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/trace/events/migrate.h | 24 ++++++++++++++----------
 mm/migrate.c                   | 15 +++++++++++----
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index 061b5128f335..0190ef725b43 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -49,10 +49,11 @@ TRACE_EVENT(mm_migrate_pages,
=20
 	TP_PROTO(unsigned long succeeded, unsigned long failed,
 		 unsigned long thp_succeeded, unsigned long thp_failed,
-		 unsigned long thp_split, enum migrate_mode mode, int reason),
+		 unsigned long thp_split, unsigned long large_folio_split,
+		 enum migrate_mode mode, int reason),
=20
 	TP_ARGS(succeeded, failed, thp_succeeded, thp_failed,
-		thp_split, mode, reason),
+		thp_split, large_folio_split, mode, reason),
=20
 	TP_STRUCT__entry(
 		__field(	unsigned long,		succeeded)
@@ -60,26 +61,29 @@ TRACE_EVENT(mm_migrate_pages,
 		__field(	unsigned long,		thp_succeeded)
 		__field(	unsigned long,		thp_failed)
 		__field(	unsigned long,		thp_split)
+		__field(	unsigned long,		large_folio_split)
 		__field(	enum migrate_mode,	mode)
 		__field(	int,			reason)
 	),
=20
 	TP_fast_assign(
-		__entry->succeeded	=3D succeeded;
-		__entry->failed		=3D failed;
-		__entry->thp_succeeded	=3D thp_succeeded;
-		__entry->thp_failed	=3D thp_failed;
-		__entry->thp_split	=3D thp_split;
-		__entry->mode		=3D mode;
-		__entry->reason		=3D reason;
+		__entry->succeeded			=3D succeeded;
+		__entry->failed				=3D failed;
+		__entry->thp_succeeded		=3D thp_succeeded;
+		__entry->thp_failed			=3D thp_failed;
+		__entry->thp_split			=3D thp_split;
+		__entry->large_folio_split	=3D large_folio_split;
+		__entry->mode				=3D mode;
+		__entry->reason				=3D reason;
 	),
=20
-	TP_printk("nr_succeeded=3D%lu nr_failed=3D%lu nr_thp_succeeded=3D%lu nr_t=
hp_failed=3D%lu nr_thp_split=3D%lu mode=3D%s reason=3D%s",
+	TP_printk("nr_succeeded=3D%lu nr_failed=3D%lu nr_thp_succeeded=3D%lu nr_t=
hp_failed=3D%lu nr_thp_split=3D%lu nr_split=3D%lu mode=3D%s reason=3D%s",
 		__entry->succeeded,
 		__entry->failed,
 		__entry->thp_succeeded,
 		__entry->thp_failed,
 		__entry->thp_split,
+		__entry->large_folio_split,
 		__print_symbolic(__entry->mode, MIGRATE_MODE),
 		__print_symbolic(__entry->reason, MIGRATE_REASON))
 );
diff --git a/mm/migrate.c b/mm/migrate.c
index c602bf6dec97..4caf405b6504 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1495,6 +1495,7 @@ struct migrate_pages_stats {
 	int nr_thp_succeeded;	/* THP migrated successfully */
 	int nr_thp_failed;	/* THP failed to be migrated */
 	int nr_thp_split;	/* THP split before migrating */
+	int nr_split;	/* Large folio (include THP) split before migrating */
 };
=20
 /*
@@ -1614,6 +1615,7 @@ static int migrate_pages_batch(struct list_head *from,
 	int nr_retry_pages =3D 0;
 	int pass =3D 0;
 	bool is_thp =3D false;
+	bool is_large =3D false;
 	struct folio *folio, *folio2, *dst =3D NULL, *dst2;
 	int rc, rc_saved =3D 0, nr_pages;
 	LIST_HEAD(unmap_folios);
@@ -1629,7 +1631,8 @@ static int migrate_pages_batch(struct list_head *from,
 		nr_retry_pages =3D 0;
=20
 		list_for_each_entry_safe(folio, folio2, from, lru) {
-			is_thp =3D folio_test_large(folio) && folio_test_pmd_mappable(folio);
+			is_large =3D folio_test_large(folio);
+			is_thp =3D is_large && folio_test_pmd_mappable(folio);
 			nr_pages =3D folio_nr_pages(folio);
=20
 			cond_resched();
@@ -1649,6 +1652,7 @@ static int migrate_pages_batch(struct list_head *from,
 				stats->nr_thp_failed++;
 				if (!try_split_folio(folio, split_folios)) {
 					stats->nr_thp_split++;
+					stats->nr_split++;
 					continue;
 				}
 				stats->nr_failed_pages +=3D nr_pages;
@@ -1677,11 +1681,12 @@ static int migrate_pages_batch(struct list_head *fr=
om,
 				nr_failed++;
 				stats->nr_thp_failed +=3D is_thp;
 				/* Large folio NUMA faulting doesn't split to retry. */
-				if (folio_test_large(folio) && !nosplit) {
+				if (is_large && !nosplit) {
 					int ret =3D try_split_folio(folio, split_folios);
=20
 					if (!ret) {
 						stats->nr_thp_split +=3D is_thp;
+						stats->nr_split++;
 						break;
 					} else if (reason =3D=3D MR_LONGTERM_PIN &&
 						   ret =3D=3D -EAGAIN) {
@@ -1827,6 +1832,7 @@ static int migrate_pages_sync(struct list_head *from,=
 new_folio_t get_new_folio,
 	stats->nr_succeeded +=3D astats.nr_succeeded;
 	stats->nr_thp_succeeded +=3D astats.nr_thp_succeeded;
 	stats->nr_thp_split +=3D astats.nr_thp_split;
+	stats->nr_split +=3D astats.nr_split;
 	if (rc < 0) {
 		stats->nr_failed_pages +=3D astats.nr_failed_pages;
 		stats->nr_thp_failed +=3D astats.nr_thp_failed;
@@ -1834,7 +1840,7 @@ static int migrate_pages_sync(struct list_head *from,=
 new_folio_t get_new_folio,
 		return rc;
 	}
 	stats->nr_thp_failed +=3D astats.nr_thp_split;
-	nr_failed +=3D astats.nr_thp_split;
+	nr_failed +=3D astats.nr_split + astats.nr_thp_split;
 	/*
 	 * Fall back to migrate all failed folios one by one synchronously. All
 	 * failed folios except split THPs will be retried, so their failure
@@ -1969,7 +1975,8 @@ int migrate_pages(struct list_head *from, new_folio_t=
 get_new_folio,
 	count_vm_events(THP_MIGRATION_SPLIT, stats.nr_thp_split);
 	trace_mm_migrate_pages(stats.nr_succeeded, stats.nr_failed_pages,
 			       stats.nr_thp_succeeded, stats.nr_thp_failed,
-			       stats.nr_thp_split, mode, reason);
+			       stats.nr_thp_split, stats.nr_split, mode,
+			       reason);
=20
 	if (ret_succeeded)
 		*ret_succeeded =3D stats.nr_succeeded;
--=20
2.42.0

