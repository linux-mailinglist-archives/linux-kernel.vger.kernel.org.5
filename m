Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A432279F2B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjIMUNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjIMUNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:13:32 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A051BCA;
        Wed, 13 Sep 2023 13:13:25 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 080353200931;
        Wed, 13 Sep 2023 16:13:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 13 Sep 2023 16:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1694636003; x=1694722403; bh=X7/kZB7lpmBCw2k1unMB2GujXf55nXH6oT8
        ByqeAnAs=; b=CBOmFlmfdeIyUT89JnMFFy916vpAbJ9+Y0cZlpwErL9EqitXWZr
        uWr88udnznLV80ohjAvV5685ZWBBQEMoyF/qfcAqemAtrrEK8k2olxVb30YmPdUb
        Tlw0uK7KZPsGp+9j2OEfkrZzL3C4xkJNsEsDOva5YkPZKoeyPIr/gi7yBB1kbrNG
        XQ/I7z1bQqc9rOKkyTjShHd/+ahqxjRc4+Wxu3LFOY1SfwXY0murBB0Fl66mQpZj
        mc1dNZHIxQBFcfRzGoMNRSO+h6/Ikh4yrOGcLfNTjoXUcwObnu+yngcJ2fo4OrR/
        TZHsqYmSk/VKyjpVhXMYY2cWckPbFTAE38w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1694636003; x=1694722403; bh=X7/kZB7lpmBCw2k1unMB2GujXf55nXH6oT8
        ByqeAnAs=; b=R04EHa4qTG7s8rcZ3kVmP7mF3cLiCpbqwhsy5PJ+JwddtemnzQg
        CItzHuqb0aYBhWIBiGLIMyiQTfFeiTWpL+kSNDmPk6GkETnDAxmr6Nn2SVT+1vxp
        +i3Rdh3+cwEz1i4Z1IvmMlZ1edrQzgOpthPVnO5/0hfHMG/FsfUhmbGug0Cl0vqN
        MEcTlaWjY0Dnag15ONS44d/LdHbsl+wyeW+Lb5qXIwakLsnak8D7/ZiIJrn6psKI
        QtAKo0eOOGQrnQEiUSXWkkzeBXz61ifLsTqrqpNSflEXdMxnzJQltUpa4mWx5PoC
        1PIex+iS2CJvgsszhUZhSBOnSzyc6//awNQ==
X-ME-Sender: <xms:4xcCZXsmNBaHUclrYaXVr-3_Qgw13vjhf-1DnvV7dH2r0-HIxkTOXA>
    <xme:4xcCZYcAIbrEY1R0zKl8flpP2u1RGJAmaSG0-yQRSIk0ofGQ_7wZomwDKmngYElvF
    lP_NVThntUGpfpC1Q>
X-ME-Received: <xmr:4xcCZazbWmxVpq9z_yiiQYw47FP2zNYNlecYC3YiHTYr55oKvF2kKX4osW62ENUpAWZT5rCgRhx1fv6QRNoBuhEqVU6E-2hq5d4pizIbRVU0Dofve5CMnV7U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhhr
    ggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggrnhcuoeiiihdrhigrnhesshgvnh
    htrdgtohhmqeenucggtffrrghtthgvrhhnpeeggeehudfgudduvdelheehteegledtteei
    veeuhfffveekhfevueefieeijeegvdenucevlhhushhtvghrufhiiigvpedunecurfgrrh
    grmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:4xcCZWN8f7OE-3HSKDPGRHwNvZebwzmkquDGmsx2N2JxYLrZkjjIow>
    <xmx:4xcCZX-skLjL0Ol3pzrqv_YnE42nFptn8X-QssatblXPcjnikZZ76w>
    <xmx:4xcCZWUojjg6s02HLL4eADw1iwWH_aHcMkOzR7o4p2hc02EbFfmQyg>
    <xmx:4xcCZY1cB1j40vdMIFELOR-l4oS3-XA19hTuDNHrGE47aK8RZVr1hg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Sep 2023 16:13:23 -0400 (EDT)
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
Subject: [PATCH v3 5/5] mips: use nth_page() in place of direct struct page manipulation.
Date:   Wed, 13 Sep 2023 16:12:48 -0400
Message-Id: <20230913201248.452081-6-zi.yan@sent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913201248.452081-1-zi.yan@sent.com>
References: <20230913201248.452081-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

