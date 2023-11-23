Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188127F655D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345530AbjKWRXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbjKWRXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:23:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202E0173E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700760206; x=1732296206;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q2jHeb2M9+68iSx1dkcg8acO6+XHJ/Y13S8JQuUrU3Q=;
  b=G2Kak/s+CXhAJjhILIWy6Ath9Ho3YLQE5/9JX5rNKB7VBpMHD5E7kuUV
   muvptmvnzCo35RxbIQRgLOaf5+yRcUFpIpsT1L3tswDy6Q78kHeCEY+Eo
   oQlIMnjyQu0E5BT/CJV8SpPOuqE0EAm2TANFIKxLp6hp/fKzFXTbpB4bM
   mnYa8HjKcHrC0xnFlD5gEakYCz39yeK/NvgJiDsIRfsqow4OdzeQGmxL0
   stIVoaJm6p3XnD3GjbOBiQJkRZNWeU5GHrmq/zqQF4sZ1Wj69+XROp0lh
   i88zADtUUdJK8btb/mMp0Exp/O3A3gj65F0gJ9doDk2Sp0qlh4/zburWA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5508238"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="5508238"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 09:23:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="837848501"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="837848501"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 23 Nov 2023 09:23:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 77E142A6; Thu, 23 Nov 2023 19:23:22 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/1] mm: list_lru: Update kernel documentation to follow the requirements
Date:   Thu, 23 Nov 2023 19:23:17 +0200
Message-ID: <20231123172320.2434780-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel-doc is not happy about documentation in list_lru.h:

list_lru.h:90: warning: Function parameter or member 'lru' not described in 'list_lru_add'
list_lru.h:90: warning: Excess function parameter 'list_lru' description in 'list_lru_add'
list_lru.h:90: warning: No description found for return value of 'list_lru_add'
list_lru.h:103: warning: Function parameter or member 'lru' not described in 'list_lru_del'
list_lru.h:103: warning: Excess function parameter 'list_lru' description in 'list_lru_del'
list_lru.h:103: warning: No description found for return value of 'list_lru_del'
list_lru.h:116: warning: No description found for return value of 'list_lru_count_one'
list_lru.h:168: warning: No description found for return value of 'list_lru_walk_one'
list_lru.h:185: warning: No description found for return value of 'list_lru_walk_one_irq'

Fix the documentation accordingly.

While at it, fix the references to the parameters in functions
inside the long descriptions, on which the above script is not
complaining (yet?).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/list_lru.h | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index b35968ee9fb5..db86ad78d428 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -73,7 +73,7 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *paren
 
 /**
  * list_lru_add: add an element to the lru list's tail
- * @list_lru: the lru pointer
+ * @lru: the lru pointer
  * @item: the item to be added.
  *
  * If the element is already part of a list, this function returns doing
@@ -83,22 +83,22 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *paren
  * the caller organize itself in a way that elements can be in more than
  * one type of list, it is up to the caller to fully remove the item from
  * the previous list (with list_lru_del() for instance) before moving it
- * to @list_lru
+ * to @lru.
  *
- * Return value: true if the list was updated, false otherwise
+ * Return: true if the list was updated, false otherwise
  */
 bool list_lru_add(struct list_lru *lru, struct list_head *item);
 
 /**
  * list_lru_del: delete an element to the lru list
- * @list_lru: the lru pointer
+ * @lru: the lru pointer
  * @item: the item to be deleted.
  *
- * This function works analogously as list_lru_add in terms of list
+ * This function works analogously as list_lru_add() in terms of list
  * manipulation. The comments about an element already pertaining to
- * a list are also valid for list_lru_del.
+ * a list are also valid for list_lru_del().
  *
- * Return value: true if the list was updated, false otherwise
+ * Return: true if the list was updated, false otherwise
  */
 bool list_lru_del(struct list_lru *lru, struct list_head *item);
 
@@ -108,9 +108,11 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item);
  * @nid: the node id to count from.
  * @memcg: the cgroup to count from.
  *
- * Always return a non-negative number, 0 for empty lists. There is no
- * guarantee that the list is not updated while the count is being computed.
- * Callers that want such a guarantee need to provide an outer lock.
+ * There is no guarantee that the list is not updated while the count is being
+ * computed. Callers that want such a guarantee need to provide an outer lock.
+ *
+ * Return: 0 for empty lists, otherwise the number of objects
+ * currently held by @lru.
  */
 unsigned long list_lru_count_one(struct list_lru *lru,
 				 int nid, struct mem_cgroup *memcg);
@@ -141,7 +143,7 @@ typedef enum lru_status (*list_lru_walk_cb)(struct list_head *item,
 		struct list_lru_one *list, spinlock_t *lock, void *cb_arg);
 
 /**
- * list_lru_walk_one: walk a list_lru, isolating and disposing freeable items.
+ * list_lru_walk_one: walk a @lru, isolating and disposing freeable items.
  * @lru: the lru pointer.
  * @nid: the node id to scan from.
  * @memcg: the cgroup to scan from.
@@ -150,24 +152,24 @@ typedef enum lru_status (*list_lru_walk_cb)(struct list_head *item,
  * @cb_arg: opaque type that will be passed to @isolate
  * @nr_to_walk: how many items to scan.
  *
- * This function will scan all elements in a particular list_lru, calling the
+ * This function will scan all elements in a particular @lru, calling the
  * @isolate callback for each of those items, along with the current list
  * spinlock and a caller-provided opaque. The @isolate callback can choose to
  * drop the lock internally, but *must* return with the lock held. The callback
- * will return an enum lru_status telling the list_lru infrastructure what to
+ * will return an enum lru_status telling the @lru infrastructure what to
  * do with the object being scanned.
  *
- * Please note that nr_to_walk does not mean how many objects will be freed,
+ * Please note that @nr_to_walk does not mean how many objects will be freed,
  * just how many objects will be scanned.
  *
- * Return value: the number of objects effectively removed from the LRU.
+ * Return: the number of objects effectively removed from the LRU.
  */
 unsigned long list_lru_walk_one(struct list_lru *lru,
 				int nid, struct mem_cgroup *memcg,
 				list_lru_walk_cb isolate, void *cb_arg,
 				unsigned long *nr_to_walk);
 /**
- * list_lru_walk_one_irq: walk a list_lru, isolating and disposing freeable items.
+ * list_lru_walk_one_irq: walk a @lru, isolating and disposing freeable items.
  * @lru: the lru pointer.
  * @nid: the node id to scan from.
  * @memcg: the cgroup to scan from.
@@ -176,7 +178,7 @@ unsigned long list_lru_walk_one(struct list_lru *lru,
  * @cb_arg: opaque type that will be passed to @isolate
  * @nr_to_walk: how many items to scan.
  *
- * Same as @list_lru_walk_one except that the spinlock is acquired with
+ * Same as list_lru_walk_one() except that the spinlock is acquired with
  * spin_lock_irq().
  */
 unsigned long list_lru_walk_one_irq(struct list_lru *lru,
-- 
2.43.0.rc1.1.gbec44491f096

