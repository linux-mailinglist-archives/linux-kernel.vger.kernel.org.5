Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30DD756BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjGQSYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjGQSXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:23:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734A9187;
        Mon, 17 Jul 2023 11:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 122F8611EB;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF88C433C8;
        Mon, 17 Jul 2023 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618219;
        bh=b/eNon7mDrEjuIWvXF4pUCAkjYxY4mdPTldqQXIN8lI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sffcGzzCyP7e8aMbrCQhThT6SQGeiLJuDgstLhi0w8hXnd1OqKb6ljkq0R0nAZfe3
         Flt3+eoGgPdJ84j6CJ7ziMDLgO+8DMWC8L4xclyzxsbyhc+6eRTGpUaqtZeOx5tLis
         cp60Od69zy+A6qrwm4bq5wSckYzTq/LaxeEreLqBQ+K2MwHuiNMvN0bJ9M0w0kBxni
         jTKpnKiBqIlyoLfGRBNOyPUuwEWNTcEBTHVPdgB03qXLjn8HzcbLDXW/Zj5gzY9kRO
         pqvVp+sc6fir6nv8vEFOUgz2jDFSFWw6q/2y88CXSym9IFYZKOutxd5uBVo5/KDoMc
         Nqw0QNLDR/ajA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1ECF7CE03F1; Mon, 17 Jul 2023 11:23:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH rcu 01/18] rcutorture: Remove obsolete BOOTPARAM_HOTPLUG_CPU0 Kconfig option
Date:   Mon, 17 Jul 2023 11:23:20 -0700
Message-Id: <20230717182337.1098991-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
References: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the BOOTPARAM_HOTPLUG_CPU0 Kconfig option is in the process of
being removed, it is time to remove rcutorture's use of it.

Link: https://lore.kernel.org/lkml/20230414232309.510911744@linutronix.de/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <x86@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE01 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE01 b/tools/testing/selftests/rcutorture/configs/rcu/TREE01
index 04831ef1f9b5..8ae41d5f81a3 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE01
@@ -15,4 +15,3 @@ CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_RCU_BOOST=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
-CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
-- 
2.40.1

