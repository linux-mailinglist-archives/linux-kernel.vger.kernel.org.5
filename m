Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A375B756B29
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjGQSBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjGQSBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905DB1BE;
        Mon, 17 Jul 2023 11:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01F90611D0;
        Mon, 17 Jul 2023 18:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F51CC43395;
        Mon, 17 Jul 2023 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689616872;
        bh=4H5bZcoG+0w9ieEzeSthnT4nJRX8tO6DLkfwj3Il66k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtpKCZlN+OtkLZWQbdGg9iStTUBMHDho2PwBrOUbZSOew1cdg8FOlMwI0GwnMv+tS
         nnUt0ZsWRL5IT44W+fBP/BZ/ADUc357QMvZSIaidaBQTrSJjdvMz9sAODwhcQYIOHv
         D7e5e/tiNMmgsa6re/QAfAaxbR8HHYneBYbCjsI6Br4AKPCXEHg+3cWAplYD9rJ39M
         8eXnV4hN5LBFzDTdmIV5EBUnN8CA+nodzVQJCs7spfpz/+z6gyPnxDz72Nic5SOutF
         U6x/zFnIBBk/aaKhZn4uO9SUHAy/c9J39JJv40P0p78cGAygMUV/Gl8PSL6tTiB8rs
         Ha4qMnoHLjPZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DB19BCE0902; Mon, 17 Jul 2023 11:01:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, SeongJae Park <sj@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/7] Docs/RCU/rculist_nulls: Specify type of the object in examples
Date:   Mon, 17 Jul 2023 11:01:08 -0700
Message-Id: <20230717180110.1097362-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ee7a3e6b-eb1b-4413-b5c3-83b22f7271dd@paulmck-laptop>
References: <ee7a3e6b-eb1b-4413-b5c3-83b22f7271dd@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

The type of 'obj' in example code of rculist_nulls.rst is implicit.
Provide the specific type of it before the example code.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/rcu/43943609-f80c-4b6a-9844-994eef800757@paulmck-laptop/
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rculist_nulls.rst | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 4d6f077552ed..479cedfec446 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -18,7 +18,16 @@ to solve following problem.
 
 Without 'nulls', a typical RCU linked list managing objects which are
 allocated with SLAB_TYPESAFE_BY_RCU kmem_cache can use the following
-algorithms:
+algorithms.  Following examples assume 'obj' is a pointer to such
+objects, which is having below type.
+
+::
+
+  struct object {
+    struct hlist_node obj_node;
+    atomic_t refcnt;
+    unsigned int key;
+  };
 
 1) Lookup algorithm
 -------------------
@@ -144,6 +153,9 @@ the beginning. If the object was moved to the same chain,
 then the reader doesn't care: It might occasionally
 scan the list again without harm.
 
+Note that using hlist_nulls means the type of 'obj_node' field of
+'struct object' becomes 'struct hlist_nulls_node'.
+
 
 1) lookup algorithm
 -------------------
-- 
2.40.1

