Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A6D79F2AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjIMUNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjIMUNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:13:21 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150981BC6;
        Wed, 13 Sep 2023 13:13:18 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 77567320039A;
        Wed, 13 Sep 2023 16:13:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 13 Sep 2023 16:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1694635995; x=1694722395; bh=mxKjLm7C5akdzlDNgIeEXW3U7M/tKbi4yzp
        ZmBIFkQc=; b=Q33sr6nx2erdmdA0tv9szaorSFCWd9oTgbOkZK628yvpAxE/Fa9
        FyX0a3c04OIInmTb6z3uxuQbtG6IS5dHzgzxbK69YCFKOgIG2qfkwUS7eLsPJasE
        aiO6lQdwhpHuHUaGHIou4krQLlWzg607QRWrdOep0NAdCES5s5HooJgRYkKKiNMi
        nUVEhU5/8iBKyKUuLi3+MeM64aY7Kk01wqGkAhV/fVbHx6xa/C1Iu/EHwm2gS6SL
        1uI2WOogXSeA4cPx0/QIDBiPyzmUB9bpsxV1hYuavNsRuICEKaGnveUuhzgPQgOi
        0Fq+voBYJ/AD2PtGTEXlcvHMYso5Bb4zxMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1694635995; x=1694722395; bh=mxKjLm7C5akdzlDNgIeEXW3U7M/tKbi4yzp
        ZmBIFkQc=; b=nln4VLWKEOaRlKOXjSxM+LK+Tyjpnm7IUNmvfLA/g8VkGuNjPPN
        G0K5zRF1KTJLBd+CypPRybFrIVS8Ic6oYobIUDsIB8L1YeVz/75fetXVcgbjvLha
        AfMk5zpriqRiL0vH3y1eurV+1Ra5k0M+tePqkQKO8A/JATeKsYFvEQULIt2ijkMI
        uhhDhmMdzsQol6jeUdbtZVReuyJzfcnIl6TUgWXcSkJ8+zZwctipxjnw+gCJiM6c
        GFTS6pP7osGaiVfn5m6PMEe229B5qYRn71H/KfFp9Pt65ginaXsiXV7XnSduwP2s
        8vRpLBKfaVx5XfR9Zd52R6LvLogYT92iXiQ==
X-ME-Sender: <xms:2xcCZT0EnJXKoZHPWbBh5loz7L5kUX1ZxrfExBHEMeKLZ4haLNQdNw>
    <xme:2xcCZSG4bvXsjfHVmvRjZkGpdKX0PfLDG4-S8OwpLZK1BrpSBKo3u5jbOfVNwnRx8
    EHQIEyBmvLsrCbcgQ>
X-ME-Received: <xmr:2xcCZT5kXk0dPMFFIDIVyIyMGkLGWXFq6bYbaziD1iChsANO7VWEiw_GuqbMvgTq7o_KMujvwSuohyXWs34yDoAxc8Y__tZrVirnZBWcYmDyGrJCz-j_t-j2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhhr
    ggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggrnhcuoeiiihdrhigrnhesshgvnh
    htrdgtohhmqeenucggtffrrghtthgvrhhnpeeggeehudfgudduvdelheehteegledtteei
    veeuhfffveekhfevueefieeijeegvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:2xcCZY3OSzF9E_NlFOWBlBNAUQkgaYoV2ejcle9IyT4lBiKfWdBqTw>
    <xmx:2xcCZWFkGQUesFISRXHYlJkWeBrl0qCPBO12HqcEpU--Eau4GNLKHg>
    <xmx:2xcCZZ9_USRLWOZuNgfnArwRy79w9BMWxMiRuirG95T8PVD5oHxqGw>
    <xmx:2xcCZR-4Uo5a613AgzCdNEx3cinqCGXpa_jlBwqHmKpU_AmOkJAnJw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Sep 2023 16:13:15 -0400 (EDT)
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
Subject: [PATCH v3 2/5] mm/hugetlb: use nth_page() in place of direct struct page manipulation.
Date:   Wed, 13 Sep 2023 16:12:45 -0400
Message-Id: <20230913201248.452081-3-zi.yan@sent.com>
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
index af74e83d92aa..8e68e6c53e66 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6469,7 +6469,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_=
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

