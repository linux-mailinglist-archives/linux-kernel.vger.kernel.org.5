Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AA880B95A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 07:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjLJGig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 01:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJGif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 01:38:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545F8E7
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 22:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=KxuMmHejzwcAfbqSkq9KLGid4QEHdgcdfkIDW6jbR7U=; b=cNf8oJZ2UeugVtVhYQ1sqXxpz5
        mRDagUgxAhEF5CvkYxJSJqzFQXu4Lg4CtSkqE54K95n6KISyAZcvIMrkzqYT4Fl/tymdH08n2eJpU
        ZW2AtbRvYkK05M9ezou350Wnfu1MphrSZTKo1wszX1+7Ms1kJckL+vgZ5CoswbvEsHbISDfi6e6Js
        aNC7O38ohjbI9YI5HGKPDJkq3eqP2RTxWeM+gEZr/CeSwR1lwdcrZqH6h9AOHd8u20vtY2XRaN6Pi
        CgnhHXIvE/xU8RIwGmZYeu2VOk7V9IFFNV6IjTDsbbyX8iblMdPrambV3RfjxYeeTUwhSK6FBxp8K
        R9k49wGg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rCDSZ-0012hS-2y;
        Sun, 10 Dec 2023 06:38:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] maple_tree: fix typos/spellos etc.
Date:   Sat,  9 Dec 2023 22:38:39 -0800
Message-ID: <20231210063839.29967-1-rdunlap@infradead.org>
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

Fix typos/grammar and spellos in documentation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/maple_tree.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -- a/lib/maple_tree.c b/lib/maple_tree.c
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -16,8 +16,8 @@
  * and are simply the slot index + the minimum of the node.
  *
  * In regular B-Tree terms, pivots are called keys.  The term pivot is used to
- * indicate that the tree is specifying ranges,  Pivots may appear in the
- * subtree with an entry attached to the value where as keys are unique to a
+ * indicate that the tree is specifying ranges.  Pivots may appear in the
+ * subtree with an entry attached to the value whereas keys are unique to a
  * specific position of a B-tree.  Pivot values are inclusive of the slot with
  * the same index.
  *
@@ -2500,7 +2500,7 @@ static inline void mast_set_split_parent
 }
 
 /*
- * mas_topiary_node() - Dispose of a singe node
+ * mas_topiary_node() - Dispose of a single node
  * @mas: The maple state for pushing nodes
  * @enode: The encoded maple node
  * @in_rcu: If the tree is in rcu mode
@@ -5474,7 +5474,7 @@ int mas_preallocate(struct ma_state *mas
 		goto ask_now;
 	}
 
-	/* New root needs a singe node */
+	/* New root needs a single node */
 	if (unlikely(mte_is_root(mas->node)))
 		goto ask_now;
 
