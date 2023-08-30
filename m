Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDED78DC58
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242817AbjH3Sow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344207AbjH3S2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 14:28:24 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025D6198;
        Wed, 30 Aug 2023 11:28:22 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 70DC23200942;
        Wed, 30 Aug 2023 14:28:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 30 Aug 2023 14:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1693420099; x=1693506499; bh=UaWYMjZoz/qbv6HU3P8JXTg44k1buzeqH5W
        8mgla10I=; b=EYBx63EvFZjpL4B27TvMy7dGqT0pwxAoSEQMIg8pIUrC14oW5Qe
        NQQkav+XRQAccBSjDYtL6wGLdshSlcg1rzwDN10arpEUSJWVjaH6IgApWfE4wz2k
        NJrHO5LIciwfDdoPDOe6ZjYQxyAx+9Qp/yhg90D1Mu/zDRHBh+usGjHa8kak61BH
        +wRtghRwUfwcK5/g4dAMCzoN5W7fRgb6/Fc0s9E42Y4N6bQRYuO/UkeirPUMSiZp
        yZ2IN3lwvHgVsMMyVUZL8ujlFJZVEXlmSYvbJK3v4JmwYHq8eQAgRitNdVAr72K/
        83+G2VVVKYJBkgGYIUdzl6PFgre20wJhuxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693420099; x=1693506499; bh=UaWYMjZoz/qbv6HU3P8JXTg44k1buzeqH5W
        8mgla10I=; b=cIqp7OcqR9mAO5om8208dHU0wNnEriPSq/ag/Nx4a6D5SqamN6H
        u5pPrVI3kn3E2aS0lJco43LEkbh81xEEzrwAjk1UPuFe/Q1Gu0D3lR1Jd20Zu1Mb
        gdjd18scjP00w/1McZqpwobB31v+bdGi+n1BVFMzoHn//F67+rVg9YaYsXDC1vi1
        b49vnbHA72x2FuM7RHMCZpxiG9NycXuTOEiki0emG1ppfM0lGJf6JXWoJSRt9xrv
        eX/aAvXfHx1aQbS9TyPhFAOhk0jRQP0Bm66uUGmD/P3FdC5dkgxYpXaV/oKOBN+Y
        D5N/biYochIaLDXNgUc6e45rtgmFJlOkXGw==
X-ME-Sender: <xms:Q4rvZK2ThFYHPgkFHwMbRXTHhzc9BTSa4gJ-nUYJ3WT4ARHSKKo7Ow>
    <xme:Q4rvZNFqkmTEzG-Ob_osEiA9AJZEUzGn706jadaI56xRdlcznCo_ma30Qe8cTgy0k
    hpvjo59WMifcCalYw>
X-ME-Received: <xmr:Q4rvZC6ZWwz8ycvKHrjZIRY_fvfASIWEQhJtur8MfQMSbEhJTZGtQUNU1tA4XNKq3-25_37qCXAoXRz4hdJgC16NoG29j2lvng7c_Kd01KM8qKXuwDphTbog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefkedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhhr
    ggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggrnhcuoeiiihdrhigrnhesshgvnh
    htrdgtohhmqeenucggtffrrghtthgvrhhnpeeggeehudfgudduvdelheehteegledtteei
    veeuhfffveekhfevueefieeijeegvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:Q4rvZL346u1_UfBpWjzl87Rw7CyGhd0RDxasHMhGKfpImbsnOq-Y-w>
    <xmx:Q4rvZNF6BdmO2rFxg6wRJ3qYNy7hEOIJFJn_U7Iwm5oQNp66gJ9Q9Q>
    <xmx:Q4rvZE-tP0tveb64gnIifFzwKegTZyfdHQXCopNAlJ9sqJO-3y7aKw>
    <xmx:Q4rvZMDCU_EPWqv6N6ufuNZGBXo8iVzJpOXRWJL1cpdCW6UGiOWS3A>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Aug 2023 14:28:19 -0400 (EDT)
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
Subject: [PATCH 3/3] mips: use nth_page() in place of direct struct page manipulation.
Date:   Wed, 30 Aug 2023 14:27:53 -0400
Message-Id: <20230830182753.55367-4-zi.yan@sent.com>
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

__flush_dcache_pages() is called during hugetlb migration via
migrate_pages() -> migrate_hugetlbs() -> unmap_and_move_huge_page()
-> move_to_new_folio() -> flush_dcache_folio(). And with hugetlb and
without sparsemem vmemmap, struct page is not guaranteed to be contiguous
beyond a section. Use nth_page() instead.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 arch/mips/mm/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 02042100e267..7f830634dbe7 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -117,7 +117,7 @@ void __flush_dcache_pages(struct page *page, unsigned i=
nt nr)
 	 * get faulted into the tlb (and thus flushed) anyways.
 	 */
 	for (i =3D 0; i < nr; i++) {
-		addr =3D (unsigned long)kmap_local_page(page + i);
+		addr =3D (unsigned long)kmap_local_page(nth_page(page, i));
 		flush_data_cache_page(addr);
 		kunmap_local((void *)addr);
 	}
--=20
2.40.1

