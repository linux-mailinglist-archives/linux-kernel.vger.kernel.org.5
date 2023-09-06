Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF003793FE3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242327AbjIFPDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242322AbjIFPDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:03:51 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06A619A8;
        Wed,  6 Sep 2023 08:03:37 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 40E453200904;
        Wed,  6 Sep 2023 11:03:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 06 Sep 2023 11:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694012615; x=1694099015; bh=X7/kZB7lpmBCw2k1unMB2GujXf55nXH6oT8
        ByqeAnAs=; b=s56TOG/g3wW3xdiIqMGnd+ngS6IcPFOJrgFciXKXnjSSlKj8Inc
        gmOg53MxNHCTU+4MczmgLmSph3GPf+dxfRb5d6RJmtabLNp16TcmtIQeYj53m14O
        T9BvHZZ5HcHgHl2ccLvCgVbR73GsLu1VXPNu3K4/bCMRea5wTpWW5oZ1x1+N4HlC
        3IYNRuCZ5ehUJ3fAsJRaVmkV/AAy2x85yhX4BDK94tR7AWi73acL19o92+oj+JaQ
        bxr3F/dwKY/UI39cMU59sNCk+jk8xeMn9LMBSBDkK3iJu8rw5/KD7x8+nf1+Jlo6
        C9z4I3J/habuZfvWzbufCWdsbiCRpIWnEpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694012615; x=1694099015; bh=X7/kZB7lpmBCw2k1unMB2GujXf55nXH6oT8
        ByqeAnAs=; b=dsbymiPbH/noxVmpwQtJWj92IfMyXpQwtT4715YnPxEu8wfhQ42
        K/L4u3Gk9fzKNgeCzhS3sqGqqIn2mvqETe1CUukPuAINgN+pmvIlIKnWQOAU6C7i
        V6BNXA4eyYrWCUB+JCg9pY1yEPjtOqcwNGDY6C5T+uXMqDP2hQ6F+PAOyiLMN1TI
        lPtzNPQ1+eAkE2XV7vOH5lSQdPC7Qm3rHP9+4DITK2enroBBmsRHzh/gaNAvNeaE
        a4nIdAya9YboYqVIE3dYeHcqGgD3oxb1oiG7d3MC8X3KYlchpUuk+QwYKS8RSkJi
        aSdUgeOU/Bs85BZdWwyEJXsRdfOqvu990nw==
X-ME-Sender: <xms:x5T4ZEgdUmO5xtmL8fK-F1K7l-Tzm8y0-W3jQEJf9edgrE1L_rbELQ>
    <xme:x5T4ZNBDm8Zq9TSDHrOIxEs3Q_y2XPDLTMlMLfGF5yMgNc4Oz4V19cH_UWtguMgaC
    nty5TA20q_CKkieLg>
X-ME-Received: <xmr:x5T4ZMEXKepRL1GBC6gIzp6EkD1-lWq43AYLbo4gBdtW3AhZg74w_Ofq6ZTSTM4ihACjE6pYY8vHXNBnBKVp8W7NayfxKHh3ZOe6B1kOexA0OBmhf8g_a2e1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehfedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvfevufffkffojghfrhgg
    gfestdhqredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghnsehsvghnth
    drtghomheqnecuggftrfgrthhtvghrnhepgeeghedugfduuddvleehheetgeeltdetieev
    uefhffevkefhveeufeeiieejgedvnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:x5T4ZFTvpSfz6hwl9nz9mJGvG37WNxdrH0kE7HOWooiuHl8cFRYm2g>
    <xmx:x5T4ZBwjYKxh5Pbtt8jHrNeFh2zfvT4ME-aNOzFYDsmWH_pECV9Grw>
    <xmx:x5T4ZD63MOtJmF4CJB0FsmZoTZMlvxs8pd1uhtQRhWh2NLxzyCDG2w>
    <xmx:x5T4ZGq0xX0W3K7rDi664LxRTh0UKuQ8QnB_x_3LuEVcftRSmHraOA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Sep 2023 11:03:34 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v2 5/5] mips: use nth_page() in place of direct struct page manipulation.
Date:   Wed,  6 Sep 2023 11:03:09 -0400
Message-Id: <20230906150309.114360-6-zi.yan@sent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230906150309.114360-1-zi.yan@sent.com>
References: <20230906150309.114360-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Fixes: 15fa3e8e3269 ("mips: implement the new page table range API")
Cc: <stable@vger.kernel.org>
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

