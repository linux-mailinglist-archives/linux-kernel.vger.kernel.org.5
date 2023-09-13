Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5602F79F2AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjIMUNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjIMUNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:13:19 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E28B1BC3;
        Wed, 13 Sep 2023 13:13:15 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id EC566320097B;
        Wed, 13 Sep 2023 16:13:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 13 Sep 2023 16:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1694635993; x=1694722393; bh=W7emFMpfIMC3wLaZ+9JtBDyJqJ6ODUK3zLR
        X50gZBXo=; b=sQpceFCLA909BuTBZz+XL7Q94NZUOHGGjEudXMqrizGzLm9Mb35
        QM+B7t8k3bGRHWOpM/I482LZgSftZIcr83fv6RxhAbx9PYx7xrpH9GBYEcHV8pAY
        092W5LzEHe5FlGT9COx/ZIMaak1lx5dG4Hy3cSU00rZ21EUlzJ1TS8V7t8oNwEd9
        TGzQ2QwH816D/VZjV51qnHMOAo22MmKiPSyltaa9W7YrRoID0uyOz27pGvX6ScmW
        PhCfwmjfx7T5kl9ANLy520k73m101Dbjvf2e4pUcgL1RUK6Magi2AMGuKnhZ93WD
        +KMSNhzFvGhVh/inlQ0KSLF9hLelEjS5gdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1694635993; x=1694722393; bh=W7emFMpfIMC3wLaZ+9JtBDyJqJ6ODUK3zLR
        X50gZBXo=; b=f1J1usMYiSOuxL63bAr+b2r34zPIFYmvIMyOXr6CZeN2rm009Kf
        FFNbRaH5Zx7NXkXq4ElkCtNaRarPsMZHXaDe1qU6YTMkKuYG1qu49BqwYdiRdC86
        8bPr3ikD2rS7M4sEajJfpBPmUwRVZOYV5EsZWY0cLSPUMm1W/LSqWbcHFl5y6fsY
        v+7MbXPcmDhVQQtKIrAX8ivkvC6fWEKOBTRvP3GAtI3jarH2FVTlPsvgGKeXQXvz
        DPEl4UDmWoBKthefGJm40hI1C76wHMX8xPVldQHBqILyAP6g/IpHBeMOvWSkAC6K
        12Rp/ZsWNw8NW3aG5+v22TqG0QbmheKzZ4g==
X-ME-Sender: <xms:2BcCZevRr-QfJmTo3ZaeWPIvIWjqPi7QnQW2dUzenunJA4DQbvaFdg>
    <xme:2BcCZTefD-zkeY3R0hi2N5KBlZBD4zj93jKz6R0cJn7vCAn7ErpmF65BrP9s_n7-n
    iVnJv9lVFIv11uZGw>
X-ME-Received: <xmr:2BcCZZyMxvumtO06aL80cxMEYDW3vAHh4J9LuXEGyOWjQgcf-s2xrQ2m3Ih6OVliTeoS_DHT2F6iqEU93T2WnOqBBeA94rSuBo1rFX_1VVX_-SugAPfDJts0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhhr
    ggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggrnhcuoeiiihdrhigrnhesshgvnh
    htrdgtohhmqeenucggtffrrghtthgvrhhnpeeggeehudfgudduvdelheehteegledtteei
    veeuhfffveekhfevueefieeijeegvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:2RcCZZNykcInH8bcBGv-ysUqWXDceI9mHaAbqvmawch-h-qGzytRKQ>
    <xmx:2RcCZe-epdp_SUh04beadXcoWUDFPoy4oLI9_t-qIVWWkb3HoXU-rw>
    <xmx:2RcCZRUCiiw6sAicY2_zi3gi8OQRawabtdzOVf7CFFR8fPc3wFFyfA>
    <xmx:2RcCZRXEKHNz33TIAlST263_pOAX91VKxOmjuu2HopZhPyZ6gJylEA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Sep 2023 16:13:12 -0400 (EDT)
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
Subject: [PATCH v3 1/5] mm/cma: use nth_page() in place of direct struct page manipulation.
Date:   Wed, 13 Sep 2023 16:12:44 -0400
Message-Id: <20230913201248.452081-2-zi.yan@sent.com>
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

