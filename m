Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC846810922
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 05:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378469AbjLMEdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 23:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378403AbjLMEdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 23:33:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4C4BE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 20:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=BOGx4vYrU5GrgTY39jAMH2cXZ04K82JMOmcHOoL9elA=; b=Tv5JkdxAXPxaQF0MZln313Rqdn
        S2fg7Vhb2qF/gXtG98YEMriApAvbJoyjnQ6ZvdFK0+oytoqo3Sg9rQyG35CBTuh6ivm440AdPq4P/
        7breRZV3iO6rZduAe0uJo/RgHsRJd55DOkkt0YOdoDCVUwDst1aiDJfcth0/N7XGC/KdLznqHobJh
        VbeiBHvMSTxTQGAjI0sccxKlw0uJkAhNg7KKu4rt31Bk2uNIGn29qF91OY84wbFDJa0Fdg6ukrU5R
        Gujy3eDqsSfVp5iCSxEsdpWxN0NhqGwwZAY4dn75ZJkTPSFFhlzDyVx6SlhJfpouwpete6jyEKvlZ
        tu6CfLnw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rDGvt-00DaF5-0A;
        Wed, 13 Dec 2023 04:33:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH] gfp: gfp_types.h: fix typos & punctuation
Date:   Tue, 12 Dec 2023 20:33:16 -0800
Message-ID: <20231213043316.10128-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct typos/spellos and punctutation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 include/linux/gfp_types.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff -- a/include/linux/gfp_types.h b/include/linux/gfp_types.h
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -162,25 +162,25 @@ typedef unsigned int __bitwise gfp_t;
  * %__GFP_RECLAIM is shorthand to allow/forbid both direct and kswapd reclaim.
  *
  * The default allocator behavior depends on the request size. We have a concept
- * of so called costly allocations (with order > %PAGE_ALLOC_COSTLY_ORDER).
+ * of so-called costly allocations (with order > %PAGE_ALLOC_COSTLY_ORDER).
  * !costly allocations are too essential to fail so they are implicitly
  * non-failing by default (with some exceptions like OOM victims might fail so
  * the caller still has to check for failures) while costly requests try to be
  * not disruptive and back off even without invoking the OOM killer.
  * The following three modifiers might be used to override some of these
- * implicit rules
+ * implicit rules.
  *
  * %__GFP_NORETRY: The VM implementation will try only very lightweight
  * memory direct reclaim to get some memory under memory pressure (thus
  * it can sleep). It will avoid disruptive actions like OOM killer. The
  * caller must handle the failure which is quite likely to happen under
  * heavy memory pressure. The flag is suitable when failure can easily be
- * handled at small cost, such as reduced throughput
+ * handled at small cost, such as reduced throughput.
  *
  * %__GFP_RETRY_MAYFAIL: The VM implementation will retry memory reclaim
  * procedures that have previously failed if there is some indication
- * that progress has been made else where.  It can wait for other
- * tasks to attempt high level approaches to freeing memory such as
+ * that progress has been made elsewhere.  It can wait for other
+ * tasks to attempt high-level approaches to freeing memory such as
  * compaction (which removes fragmentation) and page-out.
  * There is still a definite limit to the number of retries, but it is
  * a larger limit than with %__GFP_NORETRY.
@@ -230,7 +230,7 @@ typedef unsigned int __bitwise gfp_t;
  * is being zeroed (either via __GFP_ZERO or via init_on_alloc, provided that
  * __GFP_SKIP_ZERO is not set). This flag is intended for optimization: setting
  * memory tags at the same time as zeroing memory has minimal additional
- * performace impact.
+ * performance impact.
  *
  * %__GFP_SKIP_KASAN makes KASAN skip unpoisoning on page allocation.
  * Used for userspace and vmalloc pages; the latter are unpoisoned by
