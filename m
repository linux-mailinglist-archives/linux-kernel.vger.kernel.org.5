Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56E4793FDC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242283AbjIFPDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242286AbjIFPDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:03:37 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D598D173F;
        Wed,  6 Sep 2023 08:03:31 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 349A332009B4;
        Wed,  6 Sep 2023 11:03:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 06 Sep 2023 11:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694012609; x=1694099009; bh=xs9KL3ri9aVI+oSz6c/wzHeHoEyYgueyVep
        lOsiSZNc=; b=nB5E8Nf0GD6htUo2aB4p6yasTdnEGokEuYUgdnPHevyRvD+KCkp
        N0NbHMsERPS0fbnw8fRvJTxRO/oZy+uwVXCoffh9/V7DiL/YooG3rI0Iknk3UMlJ
        Jn1ve3i+kfepifLG2+YMczZwP6hYfkuGGYTsrR0dpH4D5g8szHurVlMglHfAE2Nw
        vz1IzDq3LMsH1l55+342ENlb4iViNA/l0F+QL6Rbl89rGSqZ300iQNin1uwY7gt/
        ShQLkG2HN5NinkY4VpN9pAV5FeovYMZpgxGbs3toTEwWrAR5y9QaPsvgy1U8LWFb
        qO/7bGq0wnYGjE0CCMb7jopJc7eF4iDZFcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694012609; x=1694099009; bh=xs9KL3ri9aVI+oSz6c/wzHeHoEyYgueyVep
        lOsiSZNc=; b=aXvL/qIcbNerg/966+RIQLQ9nA/n3Ukd8U5WJbdEZm6vwrid1Nl
        FToc5Hnw1VWFaeKCb28wiRh22eYTgChPUcq5gTy0V3uFckWRe0XFyWiEaKb3hY04
        FmxX+uynciVOqI0kMOawAYg6aIixIR+f8SG+pm2y4bVKCGg2LH7EWEcCwjb70KrL
        sSKzqUBRL3lHL9o1axhL//JzYLylnNFw01HA0j6z4X99CVue7pEU0eb3sZljwrLL
        ppvdSfotAlWLaaIfOoV5XrwkTZjHG9h9sjbFVc2o2fmSMmfWDSStdRHuPTsauNkF
        1KBmC7grgN1XHuIw3GKVQxVxPoWthxoO9dQ==
X-ME-Sender: <xms:wJT4ZBDvnMmA-k7gLbL54g0Tvazm_rERi74HdidQ00VVITUkEVUB_w>
    <xme:wJT4ZPhFUGFKBlivCh48PnIWvLMLXm_QTcWPoHx6p2FaXEHBWZVpEqOs-5alI0Ipv
    tKmpo4QyLpmDOc44g>
X-ME-Received: <xmr:wJT4ZMnyChaMMjizGmEr8tqKtPik9_d7Hq-NPcWIvoxT76dwfXMimTTd-t0qYigMT1NuCa5uA4dOk4ISzYrFRmntPqoVr7_jGzNnbIsYD-DZCDQPxw7B5VTG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehfedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvfevufffkffojghfrhgg
    gfestdhqredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghnsehsvghnth
    drtghomheqnecuggftrfgrthhtvghrnhepgeeghedugfduuddvleehheetgeeltdetieev
    uefhffevkefhveeufeeiieejgedvnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:wJT4ZLxh-Zy5_1B-OGM3Qx3CZLLOIARl3Ud5IERV8uX0LCbMcwS3LA>
    <xmx:wJT4ZGRJkUHOo6BctyPnMa7uyVYUagVzdVXI2wiEEWVfvFztgNw5qg>
    <xmx:wJT4ZOaz4lMA5hXBB-3sVAJEBCRpsXNQjQm0mmf6UFXprXM8B_lgmw>
    <xmx:wZT4ZCaMxRSZJ0pt2cWJJMqWN3qoIHUH-Lo2bSrYs6iOCroNzUH6-Q>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Sep 2023 11:03:28 -0400 (EDT)
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
Subject: [PATCH v2 3/5] mm/memory_hotplug: use nth_page() in place of direct struct page manipulation.
Date:   Wed,  6 Sep 2023 11:03:07 -0400
Message-Id: <20230906150309.114360-4-zi.yan@sent.com>
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

Fixes: eeb0efd071d8 ("mm,memory_hotplug: fix scan_movable_pages() for gigan=
tic hugepages")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1b03f4ec6fd2..3b301c4023ff 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1689,7 +1689,7 @@ static int scan_movable_pages(unsigned long start, un=
signed long end,
 		 */
 		if (HPageMigratable(head))
 			goto found;
-		skip =3D compound_nr(head) - (page - head);
+		skip =3D compound_nr(head) - (pfn - page_to_pfn(head));
 		pfn +=3D skip - 1;
 	}
 	return -ENOENT;
--=20
2.40.1

