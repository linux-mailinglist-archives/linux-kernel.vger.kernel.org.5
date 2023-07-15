Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5071754969
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjGOOjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGOOje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:39:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8824418F
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:39:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2582E604F5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 14:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F80C433C8;
        Sat, 15 Jul 2023 14:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689431972;
        bh=yLy9hPmEOACpwf15ubFppAKNWnWFOsypMrYr5jicS/s=;
        h=From:To:Cc:Subject:Date:From;
        b=MRMxNx46KODtFdbO6iKKsSo/RU70ReUU3WrHomUID0zU7LgjuH5JNks7JHYFVD2WL
         DenpMEkmWOIJOzZXuPg80WeU9tkYCHs64UNp2bbIL87hFVlXnLOVIO39e1SaNygeCd
         XcsGsZu753MMiq8/E3yvT0bnuDMDosRXbi0f9DgJjjLfS2CSIlMAs3qjUtUySEeFIS
         QWPJ7JHuh5zmqfW4jj9kmkWl5fLkX2ZNZxCQevllxj+BmATy6w8poZJJhSVLgY3SRj
         ckW/CEJmD1hYC16wyanMMUBIffjosCdyClduojGhHNjgD3cPjWytcbV6sTPpHbzrbQ
         lL9wXeQgBGNDw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] maple_tree: mtree_insert*: fix typo in kernel-doc description
Date:   Sat, 15 Jul 2023 17:39:20 +0300
Message-Id: <20230715143920.994812-1-rppt@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Replace "Insert and entry at a give index" with "Insert an entry at a
given index"

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 lib/maple_tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 92da9c27fbd9..da07c720c380 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6299,7 +6299,7 @@ int mtree_store(struct maple_tree *mt, unsigned long index, void *entry,
 EXPORT_SYMBOL(mtree_store);
 
 /**
- * mtree_insert_range() - Insert an entry at a give range if there is no value.
+ * mtree_insert_range() - Insert an entry at a given range if there is no value.
  * @mt: The maple tree
  * @first: The start of the range
  * @last: The end of the range
@@ -6335,7 +6335,7 @@ int mtree_insert_range(struct maple_tree *mt, unsigned long first,
 EXPORT_SYMBOL(mtree_insert_range);
 
 /**
- * mtree_insert() - Insert an entry at a give index if there is no value.
+ * mtree_insert() - Insert an entry at a given index if there is no value.
  * @mt: The maple tree
  * @index : The index to store the value
  * @entry: The entry to store
-- 
2.39.2

