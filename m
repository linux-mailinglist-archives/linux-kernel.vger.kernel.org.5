Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA5777D85D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbjHPCUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241268AbjHPCTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:19:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167F310C3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:19:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A62FF65466
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0707FC433C7;
        Wed, 16 Aug 2023 02:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692152379;
        bh=shV+iYA7ut2oA2tvBRQwaaEfQePJeM63FpWOFvBMNzw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=opILOkjnSzAtikHhouPRe/B1MGm/T8bpR5tBJ5LMf7oVz1E33jcjs979N0Q23wffY
         WQUyazv/GKGdaL/9WIyAWCMxibCNMJjBM2vXQ2Ho9DJB3dFtEMCFu27rswcxhU/Jpy
         XT554ZE57pZi8PnnVVk+l2TQhnKMlsEN/5/BiWOVokFOVMo6G8Q3FtFT371d+YnwT4
         ND2yQxEdQKpVGs30MPq9WrZ8K2nIkW/XjFj0WClhpXoRkb7T8595G40Po6wOHVA9fJ
         JNJe9hzeJe5tshfqzxwHiD1VqJyvUW4c4xtJj0WdnJ9YHdqZ62w2slFjgIRpF9uBM8
         RtkNIipr5YD2A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9AEFACE0592; Tue, 15 Aug 2023 19:19:38 -0700 (PDT)
Date:   Tue, 15 Aug 2023 19:19:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2023.08.14a 49/51]
 kernel/rcu/rcutorture.c:24:10: fatal error: linux/rcu_notifier.h: No such
 file or directory
Message-ID: <a5fa35dc-6244-41ef-9f5b-08aa497d9a74@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202308160930.YEekR3Wf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308160930.YEekR3Wf-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 09:55:30AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.08.14a
> head:   a90c4cbc91475bd5df35f712a954972fbfff40a1
> commit: 37730a9ba11627b63d8108dd8b3061ea2ee04df9 [49/51] rcutorture: Add test of RCU CPU stall notifiers
> config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230816/202308160930.YEekR3Wf-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230816/202308160930.YEekR3Wf-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308160930.YEekR3Wf-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> kernel/rcu/rcutorture.c:24:10: fatal error: linux/rcu_notifier.h: No such file or directory
>       24 | #include <linux/rcu_notifier.h>
>          |          ^~~~~~~~~~~~~~~~~~~~~~
>    compilation terminated.

You would think that I would remember "git add".  ;-)

Does the patch below fix things up?

							Thanx, Paul

------------------------------------------------------------------------

commit 2b7e462695eee212f81f7000af4f4af2523ece35
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Aug 15 19:17:50 2023 -0700

    fixup! rcu: Add RCU CPU stall notifier
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/rcu_notifier.h b/include/linux/rcu_notifier.h
new file mode 100644
index 000000000000..ebf371364581
--- /dev/null
+++ b/include/linux/rcu_notifier.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Read-Copy Update notifiers, initially RCU CPU stall notifier.
+ * Separate from rcupdate.h to avoid #include loops.
+ *
+ * Copyright (C) 2023 Paul E. McKenney.
+ */
+
+#ifndef __LINUX_RCU_NOTIFIER_H
+#define __LINUX_RCU_NOTIFIER_H
+
+// Actions for RCU CPU stall notifier calls.
+#define RCU_STALL_NOTIFY_NORM	1
+#define RCU_STALL_NOTIFY_EXP	2
+
+#ifdef CONFIG_RCU_STALL_COMMON
+
+#include <linux/notifier.h>
+#include <linux/types.h>
+
+int rcu_stall_chain_notifier_register(struct notifier_block *n);
+int rcu_stall_chain_notifier_unregister(struct notifier_block *n);
+
+#else // #ifdef CONFIG_RCU_STALL_COMMON
+
+// No RCU CPU stall warnings in Tiny RCU.
+static inline int rcu_stall_chain_notifier_register(struct notifier_block *n) { return -EEXIST; }
+static inline int rcu_stall_chain_notifier_unregister(struct notifier_block *n) { return -ENOENT; }
+
+#endif // #else // #ifdef CONFIG_RCU_STALL_COMMON
+
+#endif /* __LINUX_RCU_NOTIFIER_H */
