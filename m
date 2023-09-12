Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C026279D649
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbjILQ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbjILQ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:28:39 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101931704
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:28:36 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7034B5C023E;
        Tue, 12 Sep 2023 12:28:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 12 Sep 2023 12:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694536115; x=1694622515; bh=byTyyd05JmDbEdKIibYodeYHRw97CddSTrR
        NeSPfl1g=; b=QqdKC9Fa63nIIylhuX3PCGQuwV9dmtWfR/mazLyGKQ2+4OZ9meo
        6u0MbfmLELVh08tPW3VpY7eE0jUGpD0f0hBCcPsYbrayTPcKt/3g1vA79iRGirU0
        0DDb98OuKZ+PT4Apw5Utx1zuXFyQY16Z0/Xa27jNbU38TSEDSAa5eVX1SRabMaK3
        rU5n6S7L6TLL+OXTLhBTgYibdxYKKNvNlyE2JwryH+czxTQVES2TV7N744KECOgg
        Q99ZR3+1ToHDH6Px8nmnpvYBezdgguG/oJPurUO7UvHR36q6uUvVvj2jSaeqOSNh
        M2o69Dm4EJYBpPihti1BcLJfCecaK0eNMHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694536115; x=1694622515; bh=byTyyd05JmDbEdKIibYodeYHRw97CddSTrR
        NeSPfl1g=; b=AN0P2K2RSLzgy6uNFWDc4/uLPjZXoOm9SaCVkKxTpK1h/+O5YvW
        RH69TUb9/Pk7kdQYyfQeDpfaqTKnldImPdLpBLg9I0r1pC5C9YOe/zFQRLyjcjLE
        6CLXwwzTneyVPkCjv0P3DNAcfh/58tJXgnOFP80Yru1KuPKDPNQdE3qR4Uvj3JqR
        UVuLKi632KaIKJwUpl2haQIKZ6+sIBk9SHD1GUADGTtx8GlNig7dqgijjl9pMXs0
        U0yMjxL/RaikpR8MC+LgeXuFHTAAgRRMhoivHoE4sfhDdPGdIZu8QjRvxXE8Lg5X
        2B1jHKabqKGec0yBj+SglEIA9NrhPDanLKA==
X-ME-Sender: <xms:s5EAZV02gbRI-7aIaCmHKQPrls2JcuSX6MH-PPH_k3yZywv4EmXueQ>
    <xme:s5EAZcHPjf2RU9x5_ORH4Slx6QgoFUfgknQOHy3H03AEgKs5gt-xThlm3u2RFz9g9
    B5tLvA9QG02MvS2vQ>
X-ME-Received: <xmr:s5EAZV4zVTk8TAxwhd2VTULBjVH_9WkJiUsUpYWgzlF8uTh6-mK3Oaue2CIHOD2bf5EkZA423pZEOdSXeFn2F0TYiK2zuGFc6UasHHoSmKL_U8529xPMofbl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepge
    eghedugfduuddvleehheetgeeltdetieevuefhffevkefhveeufeeiieejgedvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:s5EAZS2_-BhctqixTBYkpewLV_08BK2TN1qitYizK6p6jJuj1EQiYA>
    <xmx:s5EAZYGYa53mkHSzg-AQYXhbuBnwSdlQwDoj8roClTs1Mfv-m5Xw6Q>
    <xmx:s5EAZT9xpqfPkSsLyNnDw6u0dn7pQxrHnlsmdg5S7vmkhev_NS2aww>
    <xmx:s5EAZWVgmnQVjnDMLeKZcN5yXKEUAAvBbm8ADgdGxAA-WYn_1P5dxA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 12:28:34 -0400 (EDT)
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
Subject: [RFC PATCH 3/4] mm/compaction: optimize >0 order folio compaction by sorting source pages.
Date:   Tue, 12 Sep 2023 12:28:14 -0400
Message-Id: <20230912162815.440749-4-zi.yan@sent.com>
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

It should maximize high order free page use and minimize free page splits.
It might be useful before free page merging is implemented.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/compaction.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 45747ab5f380..4300d877b824 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -145,6 +145,38 @@ static void sort_free_pages(struct list_head *src, str=
uct free_list *dst)
 	}
 }
=20
+static void sort_folios_by_order(struct list_head *pages)
+{
+	struct free_list page_list[MAX_ORDER + 1];
+	int order;
+	struct folio *folio, *next;
+
+	for (order =3D 0; order <=3D MAX_ORDER; order++) {
+		INIT_LIST_HEAD(&page_list[order].pages);
+		page_list[order].nr_free =3D 0;
+	}
+
+	list_for_each_entry_safe(folio, next, pages, lru) {
+		order =3D folio_order(folio);
+
+		if (order > MAX_ORDER)
+			continue;
+
+		list_move(&folio->lru, &page_list[order].pages);
+		page_list[order].nr_free++;
+	}
+
+	for (order =3D MAX_ORDER; order >=3D 0; order--) {
+		if (page_list[order].nr_free) {
+
+			list_for_each_entry_safe(folio, next,
+						 &page_list[order].pages, lru) {
+				list_move_tail(&folio->lru, pages);
+			}
+		}
+	}
+}
+
 #ifdef CONFIG_COMPACTION
 bool PageMovable(struct page *page)
 {
@@ -2636,6 +2668,8 @@ compact_zone(struct compact_control *cc, struct captu=
re_control *capc)
 				pageblock_start_pfn(cc->migrate_pfn - 1));
 		}
=20
+		sort_folios_by_order(&cc->migratepages);
+
 		err =3D migrate_pages(&cc->migratepages, compaction_alloc,
 				compaction_free, (unsigned long)cc, cc->mode,
 				MR_COMPACTION, &nr_succeeded);
--=20
2.40.1

