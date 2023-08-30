Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080B778DFDD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242611AbjH3TUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344206AbjH3S2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 14:28:22 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A600A3;
        Wed, 30 Aug 2023 11:28:19 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id F3E6B3200941;
        Wed, 30 Aug 2023 14:28:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 30 Aug 2023 14:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1693420097; x=1693506497; bh=TK10HtZMWkaeyr29jSGk50ed2+QFV4733lj
        LHyyzZmA=; b=wVMie9QfMJAfZCtvv/CLDGpDzW3bh1Gk2NBoHI0hoWVREkq3dgY
        +48nO3GAyn8XC8bHDHwCMgtHeYijkz4DyOvLKjhu5deoObYlNMb0goJJjbZPsuSH
        Cv7QNhvzmMVF2GY3Ww2fGD756MsZeGZyt4qWPrS3k4peKFRXBklabFvKqkEzEkfo
        65LebOhjDZ0OjDqI+IEjtYVPRVxlNBWX3PvW79tpEsPO7LmlzMplzFuvc4lEXItR
        JybkxgkU+tSm8bLdjGkGvLQwvl4WA39HGvA25kn8MF5WXW3C6gnj5OwbFHEXvrYa
        +OghkryonUAqHfmrb85aB3C6QdtiBxWzK/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693420097; x=1693506497; bh=TK10HtZMWkaeyr29jSGk50ed2+QFV4733lj
        LHyyzZmA=; b=ziKY7X6dy6aRNNRouY0tNqlLuvndGRS+knN/IbPMk7xsieoO0V9
        t6GT+lSpAx7hVmg7VucGt/Mf8iWiYr7Zdmf2FyWYpnsdARUqCpaBz9kkgIODylZb
        wqGxcXVnoqmfusEjtA52SiWcxEbwNmo+oDq/xRfEW8fabKcf/ZkcbddJZmvfI3w+
        G92FFGG49+NslDWY2fNtHQUWvbdA1euJRCL1IEBizJ9G10crBI0P0l3yPJiXa+xs
        BIJuSuh/hZoDcqS4cPssInZIixidGnVxs3HLgfvtXqpTRFDyMwAbORQCMs63yYDb
        tztU+jJdL6QM8YZSiM2ZSY1hiJ5RAPf2NWw==
X-ME-Sender: <xms:QYrvZNYi-5DkzwPJvBqpRna5m0jWUAxPy8NgLAN4Y7d4KL4cbPk_Pg>
    <xme:QYrvZEY1eFXC7P9RNWEllrMuqHKHWXHTY_7EeVl8_U6FoqjxpLEH6dmRlgj37Bsr1
    fXUPy3Sj84xfcL3JA>
X-ME-Received: <xmr:QYrvZP_q8ytMJEmSDnoRI_0Ese3KE1mtTx3tzbEJvIpjbPAbP7MCmqReegt4z-QYbIrHxML_wbr7QTXVy2HEG6ipP7mKD4esuTEoyosa-kRdD0gkTzbZaXTN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefkedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhhr
    ggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggrnhcuoeiiihdrhigrnhesshgvnh
    htrdgtohhmqeenucggtffrrghtthgvrhhnpeeggeehudfgudduvdelheehteegledtteei
    veeuhfffveekhfevueefieeijeegvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:QYrvZLqU8-UlBZLFbDm7YSpoQXHGYuy-lEN8nJFjLap7X5qkuuu0ZA>
    <xmx:QYrvZIozEWQedIqN-o2O-6qIK4N_ObxNMZfD8LcyJduY95ioqA6gxA>
    <xmx:QYrvZBSKv7_TpSxXF-f3g3s4590Ghr1T6z3rHnzhuhiPUxi9x4KJ3Q>
    <xmx:QYrvZP1XX4s2COZTo9H7aNK126Me1Y7MKfLIDqyiktUWw--2vStFgA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Aug 2023 14:28:16 -0400 (EDT)
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
Subject: [PATCH 2/3] fs: use nth_page() in place of direct struct page manipulation.
Date:   Wed, 30 Aug 2023 14:27:52 -0400
Message-Id: <20230830182753.55367-3-zi.yan@sent.com>
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

When dealing with hugetlb pages, struct page is not guaranteed to be
contiguous on SPARSEMEM without VMEMMAP. Use nth_page() to handle it
properly.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 fs/hugetlbfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 316c4cebd3f3..60fce26ff937 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -295,7 +295,7 @@ static size_t adjust_range_hwpoison(struct page *page, =
size_t offset, size_t byt
 	size_t res =3D 0;
=20
 	/* First subpage to start the loop. */
-	page +=3D offset / PAGE_SIZE;
+	page =3D nth_page(page, offset / PAGE_SIZE);
 	offset %=3D PAGE_SIZE;
 	while (1) {
 		if (is_raw_hwpoison_page_in_hugepage(page))
@@ -309,7 +309,7 @@ static size_t adjust_range_hwpoison(struct page *page, =
size_t offset, size_t byt
 			break;
 		offset +=3D n;
 		if (offset =3D=3D PAGE_SIZE) {
-			page++;
+			page =3D nth_page(page, 1);
 			offset =3D 0;
 		}
 	}
--=20
2.40.1

