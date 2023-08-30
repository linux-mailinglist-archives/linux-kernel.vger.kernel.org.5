Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6EF78DEC4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344236AbjH3T0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344204AbjH3S2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 14:28:20 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DC0198;
        Wed, 30 Aug 2023 11:28:16 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 46F693200946;
        Wed, 30 Aug 2023 14:28:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 30 Aug 2023 14:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1693420094; x=1693506494; bh=B/34aYGd//k30w6FAZcn4rQLSn8omlUfm+J
        uIQdqDGI=; b=bp98RaEmsAkKBW8ghMIXww+CS6+V/zkoC6Rhda0iWyOG6/7XJYc
        /8v4rROgB+oFQlulTvKrM8AkcGcy3GW2TRL/6qU9FKRX/EHKaTFwq11SJY0VY2FO
        5C+nnb47gm2+n9BbEkTT6VOF10qVjWVjD1RJZbqlhRWZFQscEyHK+z98E7nYMqNw
        4R9ImSJxA2sY37IVm79RLXwwDy+8QQL4A/6RMa8O7MFZAu0hkWxBWlw8uCbXDp0e
        Tgqoh5wGfjq8IYiyVJQUNBCRAAteZl0WMhZqbS7rr30h9u95LNMxv9Gt8kHdMlmB
        vZc5S0cVVAQz2YGQHboVUerB+m0jD6BQEKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693420094; x=1693506494; bh=B/34aYGd//k30w6FAZcn4rQLSn8omlUfm+J
        uIQdqDGI=; b=In+KJmv1kp6XqtiudbjR4d1p1MACS6EJdB/jlntYE7YOmHkENiw
        94pZU35qb54jSOyhROCBdyZJjJwlXjuBsEYgAtR9VpDXbShAJof3KzJnAwigidei
        vuTsLTIWEHGcfYIqfChEIDn0mmmfKLOgusenxkUM6vwZblGEhUOyTyyli+swpfft
        DWkWBccN23ADyp/Oz2IvClEYeaN3U2kt6iTv5+t+wzw+0m7EmSPNTM2n1j82uB1b
        iezbSj1VeP68EIYfvBBcKmAT4+7tArikfr5ZGR0sKTGa2lPsdvdwrgSSFW/7QF3S
        VJmUzhwXKRkovWljPV7DK59WC3l/pdAtLEA==
X-ME-Sender: <xms:PorvZJomg4-Gfuqr6B0gGFj9AlqNHkNMTvfkuMFRb3z9NgoeToKCWw>
    <xme:PorvZLrnc1mIW8lbmlvJz9KGP-7usPcERZXBXBohUYLQgaDJ37dgRUmANwBvGUJ9f
    KH7UGrMoNmDJVyxvw>
X-ME-Received: <xmr:PorvZGMeYxtx-LgD-5xP_O6OGl2pDC4A73KVVW3p8_QTqMklB7uKInYl2In8h9iuedZ6_HuE18xVJLw2b4p4Bk5VEP9AFbx51ox9P0U5wR9QLnf0XlLfNAaI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefkedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhhr
    ggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggrnhcuoeiiihdrhigrnhesshgvnh
    htrdgtohhmqeenucggtffrrghtthgvrhhnpeeggeehudfgudduvdelheehteegledtteei
    veeuhfffveekhfevueefieeijeegvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:PorvZE5OqNhfPbAZ1bw-sYc08VDzvlcPjzNG6Jtll6IvAivimimPPg>
    <xmx:PorvZI4vL4b-D849DyiHtbhLfsPs9O031OFJWUswIYiNrGwj9H5L9Q>
    <xmx:PorvZMhvnwKD4hi6lfrM6l4PQ1bnGYgKDB-k4pbJGm5ZERd07taEbQ>
    <xmx:PorvZJGexSuCnIvqcQ1DM2J_L9grFuPz_BUQbSDJsgzby1_A58HgbA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Aug 2023 14:28:14 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>
Subject: [PATCH 1/3] mm: use nth_page() in place of direct struct page manipulation.
Date:   Wed, 30 Aug 2023 14:27:51 -0400
Message-Id: <20230830182753.55367-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230830182753.55367-1-zi.yan@sent.com>
References: <20230830182753.55367-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

When dealing with hugetlb pages, manipulating struct page pointers
directly can get to wrong struct page, since struct page is not guaranteed
to be contiguous on SPARSEMEM without VMEMMAP. Use nth_page() to handle
it properly.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/cma.c            | 2 +-
 mm/hugetlb.c        | 2 +-
 mm/memory_hotplug.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index da2967c6a223..2b2494fd6b59 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -505,7 +505,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long c=
ount,
 	 */
 	if (page) {
 		for (i =3D 0; i < count; i++)
-			page_kasan_tag_reset(page + i);
+			page_kasan_tag_reset(nth_page(page, i));
 	}
=20
 	if (ret && !no_warn) {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ba6d39b71cb1..77e8d2cf4eed 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6474,7 +6474,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_=
struct *vma,
 			}
 		}
=20
-		page +=3D ((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
+		page =3D nth_page(page, ((address & ~huge_page_mask(h)) >> PAGE_SHIFT));
=20
 		/*
 		 * Note that page may be a sub-page, and with vmemmap
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1b03f4ec6fd2..3b301c4023ff 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1689,7 +1689,7 @@ static int scan_movable_pages(unsigned long start, un=
signed long end,
 		 */
 		if (HPageMigratable(head))
 			goto found;
-		skip =3D compound_nr(head) - (page - head);
+		skip =3D compound_nr(head) - (pfn - page_to_pfn(head));
 		pfn +=3D skip - 1;
 	}
 	return -ENOENT;
--=20
2.40.1

