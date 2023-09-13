Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA9E79F2B0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjIMUNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjIMUN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:13:29 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10BF1BCF;
        Wed, 13 Sep 2023 13:13:20 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 25AC7320098D;
        Wed, 13 Sep 2023 16:13:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 13 Sep 2023 16:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1694635998; x=1694722398; bh=0WyzrkiVwl0HyDd6Aci2MQZZb/Gy7N43VoX
        zZpGq6Jc=; b=naPdsB3dfR1YBhvIR8pdDs7slpAMXOvSUBxRMTlGo8NMy8jMZ/E
        vvG+mB2vn+0vCRBIQ5YzI14b/fcYj4pef1sM4+aIRJqZBIfN+fcDie6TsW9EJ2J1
        iYZUct01uyaBS4lO8rjJWS7cQxtE6cbWBOvTKAIXfXFjlN6o5NoQjTt7ALDP/R9C
        9DEIHh0t9nSkJPu06rigfkgSMV3jWGYmLfnfshlJ7HpRzXzC6jxLshs+2cXUDdHT
        F/6Re+X3Zd4Jhi9DPfLeg3ccZFx2Cx8gUoj03MrSB0oaDFntrPUqvXY+rBFe9VfI
        nFi8rN5IYyskwETE285/XelyAcZ6BaMMvOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1694635998; x=1694722398; bh=0WyzrkiVwl0HyDd6Aci2MQZZb/Gy7N43VoX
        zZpGq6Jc=; b=gUo/FnX8pMldlTdPvkX01eISqaj/5SU9K0sixsYw5fh7hOuaxVg
        wnIQeTY3i4rUcpwpGV1sFA6LoWS5ojkvkzq/9GFLTbqE5oSycXU4LbcrfWfiZf7N
        gjJT/7AdYJk5QwTexrGkKZoSzpmMgmw6hMByVhg+5y1Jqep0E8Apl/M/xOafFppW
        Ph3hI002dwiCvgE+UsQWXrSNZ7y5N8N7e20KZNeP3xCLVqX6FjxxzrR5GMqPAfWh
        fU9u6+oJ2bR2ppwbvmVSEuw7lbT+XWQPA/K0N54soWxj2Osls+9AhVVXCpGed41k
        Wrfmg5nfB6k6EzSq4oO+nKkhwNNaCSs5s9A==
X-ME-Sender: <xms:3hcCZTiTc85ObMWk9HkyEAv2vInpPF3uq5igZ_HgHaFFMf79V0vdMw>
    <xme:3hcCZQAbEE1r_xjW-WbJDkXjy9nbEewVCtl1tAvIuKQpwfSgRuKSvsm9FReoV_z3g
    Bc_fLK5GIOmdu3RcA>
X-ME-Received: <xmr:3hcCZTHXfSN-BkCpX6Q2DNo8pc3Al-FM9tB_YEdkwLtRn0L5Lhb4K9PJ9WlRTjOSh0BVy5aiv7lpo2cIFsZ1fyWNv6OGgbb3fsJjvADVciDyxqctfZUTCSgB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhhr
    ggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggrnhcuoeiiihdrhigrnhesshgvnh
    htrdgtohhmqeenucggtffrrghtthgvrhhnpeeggeehudfgudduvdelheehteegledtteei
    veeuhfffveekhfevueefieeijeegvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:3hcCZQQS-k_KEFVlp4anaG7V6ySsqELcgTOuMCjAQhsnMtXCC7xGPA>
    <xmx:3hcCZQwInQklHEuWNoZ7Gd_reqUqgRi79G326H8IsMV_A1xTMBoNog>
    <xmx:3hcCZW7RDYGjLzHMRfN0gV_-F7chgdIQZ0T3J7iMf1stePH_nUSRgQ>
    <xmx:3hcCZa4bk0QJ7_B0i55g9S2LeaJD9HDwuGXmTkHBccwQ7EFNK9wcvg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Sep 2023 16:13:17 -0400 (EDT)
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
Subject: [PATCH v3 3/5] mm/memory_hotplug: use pfn math in place of direct struct page manipulation.
Date:   Wed, 13 Sep 2023 16:12:46 -0400
Message-Id: <20230913201248.452081-4-zi.yan@sent.com>
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
to be contiguous on SPARSEMEM without VMEMMAP. Use pfn calculation to
handle it properly.

Fixes: eeb0efd071d8 ("mm,memory_hotplug: fix scan_movable_pages() for gigan=
tic hugepages")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
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

