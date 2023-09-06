Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AC4793FD6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242248AbjIFPD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241373AbjIFPD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:03:28 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11801717;
        Wed,  6 Sep 2023 08:03:24 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 2FC0332009C2;
        Wed,  6 Sep 2023 11:03:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 06 Sep 2023 11:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694012601; x=1694099001; bh=W7emFMpfIMC3wLaZ+9JtBDyJqJ6ODUK3zLR
        X50gZBXo=; b=vcYBM45Z0NyfFhbQnfqMxgYUvYl6KExbiuS5d4pGXEm6TPZt6wa
        LevI4fk+W5gH/9RzeC5Jw+9b7P1KGiTJV9zp93SsgnTikIc1lor43Ryy2D+9NYAq
        Q+V1uoMNIQctbWdXHEHR2+pUPsfsIIcsEWwgDOOcj2p43cK0/UTA6WD/l0mNYHTg
        OnH5Km5sFPNuK3YfISX47UXgqyogINQZz8Id/rbjwKhCqH8qxu7VfAqZMQV2msIK
        36hLQOogNALv9IzK+N7dY87aQbt+esmJP7cDRe7UfrbFHjmY+tMREaZIv7+KT/Sp
        24ZB4lE/iDe6ju5TOzqDPjkU/ZJcSmhHaOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694012601; x=1694099001; bh=W7emFMpfIMC3wLaZ+9JtBDyJqJ6ODUK3zLR
        X50gZBXo=; b=dUCL8M+RdnSQEis5+inefIkWRr+eO17dlVGmXvF+szI3ylwv5sj
        hW+6e3IRKftMQ8I/aSXitmrkd96cXnwmeWK1rS3JjL887VdFgoWBwQGaoAwkq08U
        Tmj1Dm/fz6lCmqKNEcP/4y7Og5ilEBc2NN+SS/IgcThjeDlVCs2e+VWdKNniJyov
        lHQ1tBLgfbRwKE+lfrq+O27C5X2iDuqu+onMRH+wUY/RuJ3byVmrax6h27xoguXC
        RfOT0v2wSP+Zi+AsENyrD6aJajz+iGiKQPzhjdTCnkMyJYAWngFNFhOCI30TODCl
        ERq5GxYS7RNVXCKOqRZ7smQuBMIjjh+LaqQ==
X-ME-Sender: <xms:uJT4ZIhH1e_r1qne70Fk08eD5S-DYwpdcuUZbBiARLeXN5gRPC9zjQ>
    <xme:uJT4ZBDBaeUrfcg7Zz7Tlc9J03ReNX1AO98BQwOKo7jxVD8xnUqRCQkKfP3meqA1g
    7PANCgOYMJ0eixO2A>
X-ME-Received: <xmr:uJT4ZAHsm4OThYV58AdwXp3OE1XltpJmLC8uR6JxeqmF_2LkBCSVCzBYmU4nBUA8Re708nbhj7ZhJDmK01tiIMrmJEeSrgxtfZbGrzNhCFQnsFBAxoW2mYuM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehfedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvfevufffkffojghfrhgg
    gfestdhqredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghnsehsvghnth
    drtghomheqnecuggftrfgrthhtvghrnhepgeeghedugfduuddvleehheetgeeltdetieev
    uefhffevkefhveeufeeiieejgedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:uJT4ZJTOO9NRlilyh1STVPCXqMH8ZTFrpqXagUazLIfri7w1YWow5A>
    <xmx:uJT4ZFyxw7AHV_nOceY9ZrKSeDRzRa561RrtFVQJ_L6EQt2k6mGyzg>
    <xmx:uJT4ZH7IYd6P28YI_p4uuPGBaj4my0KdSPpLmCoX3ZPsQbYzeNC7lw>
    <xmx:uZT4ZL72EpL7Kuxw9nwprBENHPq-cAkSOWHgSyD2uFTxIrrMpupVSg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Sep 2023 11:03:19 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>, stable@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 1/5] mm/cma: use nth_page() in place of direct struct page manipulation.
Date:   Wed,  6 Sep 2023 11:03:05 -0400
Message-Id: <20230906150309.114360-2-zi.yan@sent.com>
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

When dealing with hugetlb pages, manipulating struct page pointers
directly can get to wrong struct page, since struct page is not guaranteed
to be contiguous on SPARSEMEM without VMEMMAP. Use nth_page() to handle
it properly.

Fixes: 2813b9c02962 ("kasan, mm, arm64: tag non slab memory allocated via p=
agealloc")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
--=20
2.40.1

