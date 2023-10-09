Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CAE7BEBA1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377883AbjJIUcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377354AbjJIUcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:32:46 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21B2A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:32:44 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 275C35C02BB;
        Mon,  9 Oct 2023 16:32:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 09 Oct 2023 16:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1696883564; x=1696969964; bh=SzCcXEw24lbVQoLDSre4+93FDqVAU/sVIvB
        TCkxblE4=; b=HO/OHuE6kHokYBVlkHykez21S6VDvdr5Gdj8uzoCr0GpVgruifQ
        z2EvzdEc+i0Ot5AnVWz81RGSHnjudXQ3xUD78PWToBX5Vs7YmxhAzj9MuA1VV3pa
        NvcfEuKgRJr2JZ1jmj3V/QQ+wSr4egq/dPryEiVVBOUnQrXr8ErC9hMzMn3bvsrP
        poeEHolD3/Zfe6YFV82couRd50Ghdk8/PX//RP7dvKHtJF5cjwo3KtbAMeD6Gdlt
        rC3s/dcipacwuf/C/VDG9uDgFmQ8uxwGZMVPBK7/oUIbJpJ/rp9K7U4MFNmHgSoK
        CkOmG07Dd1Q7Qohy6B3fFUpsd3bGoJWqMCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696883564; x=1696969964; bh=SzCcXEw24lbVQoLDSre4+93FDqVAU/sVIvB
        TCkxblE4=; b=cxlJl5XSYwGSdUJuN2SWs1jXmMEgUjXvWe4uTI5C4XzeZIQJGEu
        RX4VJvhg0Nlb1xSdbHG/RcmJg+Krgga5HiWDk6/WszGY7n8bjJ0pPz1SaZU1L2xs
        KEItHfvP6P2dtzh6U6h0nkMBcUvVjyckqXnlqFF0Po6r6ye+KOjyiy9886Udb8pC
        AcfRDwY6G3Sgc3CEyzzWzzDL5GBw0Gn5U/QKRk22o8D/FtidDp5JAf5IPVDuh9Tg
        RXS7QzAh8HH+I9mIG4avSNNpWVtUlyFtUMVPflGqwbovIQM0YY0VtWB1GRypz95T
        eV0C4cDS3Mh6RouqBqijHJPDa7vHt1liCAA==
X-ME-Sender: <xms:bGMkZeHdVG_Yi5UZ5KRSXOuj_KoJg6QGFZM5DSQvcP_NgcVMYMxs7A>
    <xme:bGMkZfW63JfH8TV2jexitU5UvfZidpTdUMzOM75Fu4dG-f6lDjP2X_lSx_HGznguz
    -Y_lDc_dogB22xblQ>
X-ME-Received: <xmr:bGMkZYIQMMDbVMB2T3Fv3CVaqU0Y87OCZR6x7ckDcVvGpnl1Ad0B1n2OwWLkmWoPkG7NUrZCWhKhtJyxGN6sV4Ip28J8jWJYI_ty8sAh5vch5OIs3ABgQOyG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheefgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:bGMkZYE_BzxMNmVqUYOC-g2MGdISt7g_tZOJc79qkzgUwxVWDj4mDA>
    <xmx:bGMkZUW0U7csK56ON3SEpzo0RQuxBgsRqN16hn3zf3v4qZQKJgsH1A>
    <xmx:bGMkZbNbHMmwX-t2q4A7UIycqkw_YhzLA7oegw5kscx5J8PLq_7UYg>
    <xmx:bGMkZWJ9qYMN-PXmyE8kEaX9vPVvHP--VGxCo76zcFcUm9g834UkNw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Oct 2023 16:32:43 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH 1/1] mm/migrate: correct nr_failed in migrate_pages_sync()
Date:   Mon,  9 Oct 2023 16:32:31 -0400
Message-ID: <20231009203231.1715845-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009203231.1715845-1-zi.yan@sent.com>
References: <20231009203231.1715845-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

nr_failed was missing the rc value from migrate_pages_batch() and can
cause a mismatch between migrate_pages() return value and the number of
not migrated pages, i.e., when the return value of migrate_pages() is 0,
there are still pages left in the from page list. It will happen when a
non-PMD THP large folio fails to migrate due to -ENOMEM and is split
successfully but not all the split pages are not migrated,
migrate_pages_batch() would return non-zero, but astats.nr_thp_split =3D 0.
nr_failed would be 0 and returned to the caller of migrate_pages(), but
the not migrated pages are left in the from page list without being added
back to LRU lists.

Fixes: 2ef7dbb26990 ("migrate_pages: try migrate in batch asynchronously fi=
rstly")
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c602bf6dec97..5348827bd958 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1834,7 +1834,7 @@ static int migrate_pages_sync(struct list_head *from,=
 new_folio_t get_new_folio,
 		return rc;
 	}
 	stats->nr_thp_failed +=3D astats.nr_thp_split;
-	nr_failed +=3D astats.nr_thp_split;
+	nr_failed +=3D rc + astats.nr_thp_split;
 	/*
 	 * Fall back to migrate all failed folios one by one synchronously. All
 	 * failed folios except split THPs will be retried, so their failure
--=20
2.42.0

