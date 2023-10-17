Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013D47CC8E4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbjJQQbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjJQQbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:31:43 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DBD9E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:31:41 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id EFF983200A2B;
        Tue, 17 Oct 2023 12:31:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 17 Oct 2023 12:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1697560299; x=1697646699; bh=1kkUVLmhYZKWaHKAN/xp7aL8gGntQ2zJwQB
        I6DdNoNU=; b=unvXa1k4H/Q7Jd14QuUPoZ4jcQPo5sBEh1o0/eDJkujCX6U7beP
        nLH41Xgpe4pvssOe6gtCU9QDPKGBdlvmDNw4yxg1llrYmG8knOVw/82VQq96Uwo4
        6y6K9KLnFIWYY3kACqOdaJaBGKfF9AueTa2/7h6p+RBBh+QTPGQanQj9wbhPs2Wc
        RObbk5G5SE2pHWZgMvenTvoEusWbtcSWWmmHuwjDmMNjbriu8zD7FZxSScFyAU++
        bcV6VUTUXfKhq3wfxGM89ExEcpII8cZ6IrOOTlxZetRzEtRdkQ9PWg54NXwJfeXa
        db1DXiSSJ6kc0rwPgl0NRBV+67mJh28LPSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1697560299; x=1697646699; bh=1kkUVLmhYZKWaHKAN/xp7aL8gGntQ2zJwQB
        I6DdNoNU=; b=PJ7gUlT3xyf2PcJF4ucbSQ9erQHE7TVNVKbQYEiQccw2LMr40XW
        71t0mIFiDHwU4EOH6jKK1Mvv2PiFJrJBczuUX81w3okgCFxj+oom9KFTeMWGr6Ey
        0YCiJK00XtIx1YyCPmmmVx4wvdlGMb43WsGLGcFprGjRiz1dToZodBSvGzPWPRHW
        euWGW61zhbCNpC1/GbbtJ+l4AKkyo5D1CCqGrOfu4vhuOlNg8llOABZBMEKSt8nE
        wdVEqOO1xLiNa63xg3rv7WQNJI4N/P3R7h/FLa82D0MY+YGv8tQNOJl0wm/5i4XC
        o3OkMlTpIDG52BWMZPM+GuDMGSCYifZiSZA==
X-ME-Sender: <xms:67YuZWwlpoQhL1UN9aEN3rZLWlZsPY-lsYx856DiwML0o8RPztNIDA>
    <xme:67YuZSQT4y8eMsquh5Vh8WmXW4MavnI2IUeUsAYUkehAM9Ml9H4WsSmxjo9vZpmXx
    Kbzbu-YCLMleR0RIQ>
X-ME-Received: <xmr:67YuZYXWcTtj3a6K9TENXzL_Z-XQQXh_uY8oe_yX1H3tDjYGJxPp4LM_LYmkJ9FuWG2wiujoI-CYm5CoxNjeIReyXMehQiNxFkjGBkLWsnxGJP2Duj2PnUf->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepudfgfe
    elhfekiefgtedvudfghfduffefieefffejvefhlefhhffgkedtfeevhfevnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:67YuZchAs_PcAtbVDEzLknqwIne6hSwnRM-7HHCq66anaG-ounHy6Q>
    <xmx:67YuZYAJKjQU5yYRy2rR-ESqYfSjxHffPIhz0pmvTCScCFAEEqYezw>
    <xmx:67YuZdKnVT2XG2ak24TFyxSVgvkEiy-Jv4zw3eMffqnMwraGY3ITWw>
    <xmx:67YuZa291xoN7Ai37YO0T6y4_x8deNalsFKBoR9fRTgybzU9CiIFdg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Oct 2023 12:31:38 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH v3 2/2] mm/migrate: add nr_split to trace_mm_migrate_pages stats.
Date:   Tue, 17 Oct 2023 12:31:29 -0400
Message-ID: <20231017163129.2025214-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017163129.2025214-1-zi.yan@sent.com>
References: <20231017163129.2025214-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Add nr_split to trace_mm_migrate_pages for large folio (including THP)
split events.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 include/trace/events/migrate.h | 24 ++++++++++++++----------
 mm/migrate.c                   |  3 ++-
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index 061b5128f335..0190ef725b43 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -49,10 +49,11 @@ TRACE_EVENT(mm_migrate_pages,
 
 	TP_PROTO(unsigned long succeeded, unsigned long failed,
 		 unsigned long thp_succeeded, unsigned long thp_failed,
-		 unsigned long thp_split, enum migrate_mode mode, int reason),
+		 unsigned long thp_split, unsigned long large_folio_split,
+		 enum migrate_mode mode, int reason),
 
 	TP_ARGS(succeeded, failed, thp_succeeded, thp_failed,
-		thp_split, mode, reason),
+		thp_split, large_folio_split, mode, reason),
 
 	TP_STRUCT__entry(
 		__field(	unsigned long,		succeeded)
@@ -60,26 +61,29 @@ TRACE_EVENT(mm_migrate_pages,
 		__field(	unsigned long,		thp_succeeded)
 		__field(	unsigned long,		thp_failed)
 		__field(	unsigned long,		thp_split)
+		__field(	unsigned long,		large_folio_split)
 		__field(	enum migrate_mode,	mode)
 		__field(	int,			reason)
 	),
 
 	TP_fast_assign(
-		__entry->succeeded	= succeeded;
-		__entry->failed		= failed;
-		__entry->thp_succeeded	= thp_succeeded;
-		__entry->thp_failed	= thp_failed;
-		__entry->thp_split	= thp_split;
-		__entry->mode		= mode;
-		__entry->reason		= reason;
+		__entry->succeeded			= succeeded;
+		__entry->failed				= failed;
+		__entry->thp_succeeded		= thp_succeeded;
+		__entry->thp_failed			= thp_failed;
+		__entry->thp_split			= thp_split;
+		__entry->large_folio_split	= large_folio_split;
+		__entry->mode				= mode;
+		__entry->reason				= reason;
 	),
 
-	TP_printk("nr_succeeded=%lu nr_failed=%lu nr_thp_succeeded=%lu nr_thp_failed=%lu nr_thp_split=%lu mode=%s reason=%s",
+	TP_printk("nr_succeeded=%lu nr_failed=%lu nr_thp_succeeded=%lu nr_thp_failed=%lu nr_thp_split=%lu nr_split=%lu mode=%s reason=%s",
 		__entry->succeeded,
 		__entry->failed,
 		__entry->thp_succeeded,
 		__entry->thp_failed,
 		__entry->thp_split,
+		__entry->large_folio_split,
 		__print_symbolic(__entry->mode, MIGRATE_MODE),
 		__print_symbolic(__entry->reason, MIGRATE_REASON))
 );
diff --git a/mm/migrate.c b/mm/migrate.c
index fc2e70b17704..1fecebf4c301 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1979,7 +1979,8 @@ int migrate_pages(struct list_head *from, new_folio_t get_new_folio,
 	count_vm_events(THP_MIGRATION_SPLIT, stats.nr_thp_split);
 	trace_mm_migrate_pages(stats.nr_succeeded, stats.nr_failed_pages,
 			       stats.nr_thp_succeeded, stats.nr_thp_failed,
-			       stats.nr_thp_split, mode, reason);
+			       stats.nr_thp_split, stats.nr_split, mode,
+			       reason);
 
 	if (ret_succeeded)
 		*ret_succeeded = stats.nr_succeeded;
-- 
2.42.0

