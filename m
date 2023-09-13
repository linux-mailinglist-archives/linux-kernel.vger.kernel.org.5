Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313A379F2B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjIMUNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjIMUNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:13:30 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364A71BEF;
        Wed, 13 Sep 2023 13:13:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A1BC43200495;
        Wed, 13 Sep 2023 16:13:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 13 Sep 2023 16:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1694636001; x=1694722401; bh=l4bevEHulLiJ5YHyw6Y9teMcyGqHbAaeFHU
        aV/6ZIds=; b=H+ayEHKc5Yx5k+Dpc1wOOB1Y3ycugVwzEwwHd91K9eeo6tz2GMZ
        o33ft/YdfjMmTvM8YBdqDgvvVlPdq3S4OIgTsrSpnDohjyqct1/YmeU4yDSoy02A
        tPkjTNDVL6a3mQ19/TUut7cl2giLJq98zopfOqmR9d5eBAsXnIRLasFx428VGFiu
        RQ4oK4Cyz/3A0XTw/dvzJhkEmWaycHldo+LMf0LcfpAkV/vIuvL8lxrND9KvTeS6
        WYC70OuysEGIDRBToO65ln/Cyo7B5Agdp1LtNShS4+BJS+TtX2pkZvvLBq0eAXLl
        WJdnEZZWQDha8YWY4EJ+ifRxu/i1o6HoQ/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1694636001; x=1694722401; bh=l4bevEHulLiJ5YHyw6Y9teMcyGqHbAaeFHU
        aV/6ZIds=; b=YgxV1M8oM33Puqg8fj6ipfY4rlBIRJuVZuMSIN9kxRevCGOpP+W
        aoW2pFq0J91Gro+JxjekWxs09v8kElVXgHstaNMEONK6uRSBBPu212JouOcLr3N4
        7BuiAMO58woKwmVen+hAOQPd7KNStogYTQUHa5rXDK87CGePkfSRCmGi4XBOPOGh
        Pl3oMdD2LGDUWDzIkx6b+ke06EPe5+IIWzBnIkvY/jUhaCJHSpNF9RDq9nJBrl8D
        gmyNu+EwD1DbYD3/m92dw3hbK52VLvp09SkNBa1GJD7x/ESvHPZzgFGjEqUIdNTu
        fY3/9QQCffj6h8vIDhr2sSZOyjVGtF5ddgQ==
X-ME-Sender: <xms:4RcCZcphjoqBBov82s36srRr93mxMlEdks-Rg-Vwhzi4zQIegLjHNQ>
    <xme:4RcCZSo7qYRMKKrWV_YSzcAb4aiaG7L_UVBr0E-gHmpECTNioY9We3Cb9eblQ-tzG
    TuL29zVs3CyfIjb8Q>
X-ME-Received: <xmr:4RcCZRNFTnV80jEs9Fi4EAN_9XVHaw-g37aEGnQarQDDRT_6MhwN2AOp5vmF1BUiX-NlNVwZw-UTFdABxcevjHdLAWjiPVGDM8G9cR1gmCEMBdGiP2s_xloy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhhr
    ggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggrnhcuoeiiihdrhigrnhesshgvnh
    htrdgtohhmqeenucggtffrrghtthgvrhhnpeeggeehudfgudduvdelheehteegledtteei
    veeuhfffveekhfevueefieeijeegvdenucevlhhushhtvghrufhiiigvpedunecurfgrrh
    grmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:4RcCZT7nybB_IOhWkP7Dtm99zPXUwCAjiPydEHo7bV03IUmpdmvzJw>
    <xmx:4RcCZb7tJNmuN71SdxBonujl-2IaWrdG_D41pDnUdiw99N95mbC1Cg>
    <xmx:4RcCZTiKYBKtqmeTp7LHPg_GLFVn2UtgGQrYed2feLme2CkA20eEhQ>
    <xmx:4RcCZfiajUv-lJnY_64MCRZHZ0pclmjCH_0J5yahjePmMIslSox1qw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Sep 2023 16:13:20 -0400 (EDT)
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
Subject: [PATCH v3 4/5] fs: use nth_page() in place of direct struct page manipulation.
Date:   Wed, 13 Sep 2023 16:12:47 -0400
Message-Id: <20230913201248.452081-5-zi.yan@sent.com>
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

When dealing with hugetlb pages, struct page is not guaranteed to be
contiguous on SPARSEMEM without VMEMMAP. Use nth_page() to handle it
properly.

Fixes: 38c1ddbde6c6 ("hugetlbfs: improve read HWPOISON hugepage")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/hugetlbfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 7083fa0caaab..14d3d28e41b0 100644
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

