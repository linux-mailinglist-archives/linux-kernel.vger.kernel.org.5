Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE24793FDF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242317AbjIFPDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242286AbjIFPDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:03:43 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABF1172E;
        Wed,  6 Sep 2023 08:03:34 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 45E1632009C5;
        Wed,  6 Sep 2023 11:03:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 06 Sep 2023 11:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694012612; x=1694099012; bh=cqtMZEUvBe54JghNmYIOYKwpXMmZI+q66Bi
        2kSF9BAQ=; b=pCUlhr0PqKkKxrLg6/MAEej8PHN+UaXMGYaUKHfsyEqZii72vIv
        gF0fdzEG7vtIqYpsYif27qqiciuJZzSDA7T2n7kmrF6jYoO4IbIeU7tWfi44QyhO
        oA/2yQBIU24n81ylhfY2Uwg+ko+lEw4sQWOCQjHJ9bQUtylPhYkxswK9Bom7G2Mr
        steSMIHZpymEEv6tObZHSSMoWMvHdbCz41mA0Jup92qZz7oNa9OwMRQb1pGmrd+e
        Pq+xtKcSl10jploMADZBMHSKRZUhEfTTqWDrOX0BmF1lf8LFc96vYrrnLrmYX5t8
        E4WBACH3Il/bRFeSCRzmP6v2BwcvEP3khfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694012612; x=1694099012; bh=cqtMZEUvBe54JghNmYIOYKwpXMmZI+q66Bi
        2kSF9BAQ=; b=qhSDgtanx+0+pDt3JTxcMZmdRwzhQPSAjuqOLwGGTNZLjO57/tf
        WGxNmarVSk8cnsbHZlErQ7AvWs2JK+xMUdbld8zXeqCu65S8QwCeJJqVqP/IhCUq
        0WNVFsMVBLnF6psCkT7qZofRZcAkaE5qJv26bJEze+db608cOoTam68AgTDzY6Ja
        MG8x2WjkNaBlVIlLdGckGofLL7kZE6aycGsmA4peiiHgBE+rRCWAz8iVyHrGCTsP
        gq77YUMS8WGl7Lk6Cc1YrtApBiTV5XK51y9CbUQil26cyUNceJyZbXLByzlLabGa
        RgOL68x+vSiMAhQHz/oTn6PUSsVILwOLfIQ==
X-ME-Sender: <xms:xJT4ZBY71GYStdWBRlHBWO-8i0BJOfsKezrAoojoilZT3JbZHdZHIA>
    <xme:xJT4ZIYIsUlHfjVq_76WSWr2d0IpCy2mzHjjpdrXPqzAF7v6l1L7bid9gvr1JkpuP
    u-nPYc8wAagF12-wA>
X-ME-Received: <xmr:xJT4ZD9d8XStu7PVDDBlDXsQZ9ioFJU1K8m5pn445Wvyayqnfft0I7O8Bw97W2UURbc5gIkMeLYSNmtzAM6geey8Rr0QqqA8KOpMy6o6NHagv9uzqpR6Olro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehfedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvfevufffkffojghfrhgg
    gfestdhqredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghnsehsvghnth
    drtghomheqnecuggftrfgrthhtvghrnhepgeeghedugfduuddvleehheetgeeltdetieev
    uefhffevkefhveeufeeiieejgedvnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:xJT4ZPq5goF-CykdXQPaV9zgOdARNtQnkAbZJ4TiPtc5vlnpqGv1cA>
    <xmx:xJT4ZMqPexIDgACBGKgrXcfwrt8-edSVRaz2HO3Sg-bgMseJ5Tk-eQ>
    <xmx:xJT4ZFRR6hw0k6MxacvO32sny1-63PgvqFcYcrafGEiwPEjCt_LSKA>
    <xmx:xJT4ZBRhx8TOEi-R15o7nAvxjH1il-in8fUP3uTahPeThzVg2EWWkg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Sep 2023 11:03:31 -0400 (EDT)
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
Subject: [PATCH v2 4/5] fs: use nth_page() in place of direct struct page manipulation.
Date:   Wed,  6 Sep 2023 11:03:08 -0400
Message-Id: <20230906150309.114360-5-zi.yan@sent.com>
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

