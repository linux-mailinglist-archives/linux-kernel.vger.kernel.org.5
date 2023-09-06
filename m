Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59082793FD9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242257AbjIFPDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjIFPDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:03:32 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51992172E;
        Wed,  6 Sep 2023 08:03:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BE0B5320093F;
        Wed,  6 Sep 2023 11:03:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 06 Sep 2023 11:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694012606; x=1694099006; bh=FRhlzq8UvIObngBkM6dyssvnlfJTeG6TGLo
        3e9CVZKk=; b=ylb72mJgqmxN2pfmztXzBSYqUI0fCUryU9RZLnqhKRV6cdzQHPw
        WewNuJTadJnzAvfVVRxf5nAh2kQ+qRzYNJU3xPo/eWU0FHQRlpmtm8ojnyFRLaNG
        WAAE7vy0TSD4FClXqKHbrNYxYMUzHOS3nt39qBZiB3Qid8X8WaCpfF5YffMtZ4E0
        lo5G79gkH6vB2HP52Yknle1/Zxz+TzayRAtcmBZ0BKaom8BxvQKURAx1sBOg4uiV
        JKOqVGNrlOm0oqAIjUJAaE/yULsfmxGRO6MzcRQz3qdCryUT6kvioH0ytebE8pU9
        fpgKt1Czpg95KCYtQOcPxdYK1O325Bx10Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694012606; x=1694099006; bh=FRhlzq8UvIObngBkM6dyssvnlfJTeG6TGLo
        3e9CVZKk=; b=RyFkVW0vu58VoPxEjNCtMjVVEPg2uyGQhsVQI8c4UW2TuZZo30I
        EwigMAAynz1rFI8G1RAqCKG7OC9YZ1wSQpcVQArDwmmDwwpXuq3STKkmTk+63ahu
        MvDcewe93JMI10bkI7o4l93bEDVgSCzcpClVOo6B6Su9Z5DpPcaDRbedPbDjahDB
        gyA+QzhEGSNCPgAuf9j1bQhFetOMKdqadlqHqiEahWQ6NvMOzboJa4SGCixqvuRV
        4p0uedH/D/LWU2laHLcu423rHmnFEcg15LhSbgv5lb3VGacOGcARjQ35xVchFTYL
        RsDzarygujS44z4Wynen1EJMc/3e5ZYKbmA==
X-ME-Sender: <xms:vZT4ZLxoDmisrBQ_9XauWHwj-1N5nEJ9h-0r0xRkxtiNcoBrm3ZYww>
    <xme:vZT4ZDScgR27o5197JFp7egegCMTbhSlThalO4RzQdM07WSoRrYpU04kOBNGglOUk
    RajLiHtCC9hsZxJ5Q>
X-ME-Received: <xmr:vZT4ZFWS1hHbGCPtICPdKU1lRaKu5DzWvf9-Q5erekg_A0bQ7Ol7_bPqJsuPMsJD7U-pylP7tt30Ha3kDyUZOU4IivGUbRq0GVVEdp2ZMSlltoqck7LZeYx->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehfedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvfevufffkffojghfrhgg
    gfestdhqredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghnsehsvghnth
    drtghomheqnecuggftrfgrthhtvghrnhepgeeghedugfduuddvleehheetgeeltdetieev
    uefhffevkefhveeufeeiieejgedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:vZT4ZFgYFEGOAI0RNgFLn_TatZhM53DWGqERX3OIB4fS4Fauu-J_4A>
    <xmx:vZT4ZNAx0cDpXYbPDSCzndUnnPMj-Y8gW7QyX6aSWKfVndJUmatjDA>
    <xmx:vZT4ZOKxediCBe8AuCv53w95AU1jqRl0mzPymUxapA9sXyBWPkMdFA>
    <xmx:vpT4ZCIBSIMA5F0E4Mqy_a86xhmP6l5vh2dCyCc-puicVU-Vz0vEKA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Sep 2023 11:03:24 -0400 (EDT)
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
Subject: [PATCH v2 2/5] mm/hugetlb: use nth_page() in place of direct struct page manipulation.
Date:   Wed,  6 Sep 2023 11:03:06 -0400
Message-Id: <20230906150309.114360-3-zi.yan@sent.com>
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

Fixes: 57a196a58421 ("hugetlb: simplify hugetlb handling in follow_page_mas=
k")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2e7188876672..2521cc694fd4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6489,7 +6489,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_=
struct *vma,
 			}
 		}
=20
-		page +=3D ((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
+		page =3D nth_page(page, ((address & ~huge_page_mask(h)) >> PAGE_SHIFT));
=20
 		/*
 		 * Note that page may be a sub-page, and with vmemmap
--=20
2.40.1

