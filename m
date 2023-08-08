Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9068774D39
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjHHVnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjHHVnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:43:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295091CA74;
        Tue,  8 Aug 2023 10:14:45 -0700 (PDT)
Date:   Tue, 08 Aug 2023 17:14:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691514883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YOb2x6mt0eFNIk/LmR8xz0yg/z1yvjxM0oWW1/EPPjw=;
        b=nqDkC0e7t1+UsirdX7xeAiS3apFEnEleCPANZBdFOXCoTmTJ3Xv8dPb4zKFfNXDagt3fBV
        vUp+HTovcu2tP+tMhLIzTcuAhsgLKVl4o19Cw5Hc5wj8IcCMksyBua5eoftc6eqZgHOG+C
        ikseVP3hmEK0/O30dEOjtTkNfxF2XL0jqaSN8V7xQMw/f0y8BufXm9cPrwZY0tPL9Jpd6c
        psJOL5xpZON2VGu9RMiMyn1D9SHYi8hyhr6x47urkiybcXY9o51RwGWwLvPOhDe573N7Bl
        v12AZPQeCb5zv6+Nr8UgKTriCM85o4NCM29RuqJJ3OCDYPz/3jugFQHWJnWGXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691514883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YOb2x6mt0eFNIk/LmR8xz0yg/z1yvjxM0oWW1/EPPjw=;
        b=YhadQQTpSoNn1uNFQn8ED6kO1uDN0nk3MXOiiS/l8EZWqGTae1eoR7RM962Qfhf8zLIe/h
        XkhR8cB/s+zi08CA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Remove microcode_mutex
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230804075853.JF_n6GXC@linutronix.de>
References: <20230804075853.JF_n6GXC@linutronix.de>
MIME-Version: 1.0
Message-ID: <169151488243.27769.14789329848292946571.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     80347cd515ca149f1da31786ec9a59b0dfd1e579
Gitweb:        https://git.kernel.org/tip/80347cd515ca149f1da31786ec9a59b0dfd1e579
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 04 Aug 2023 09:58:53 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 08 Aug 2023 19:06:29 +02:00

x86/microcode: Remove microcode_mutex

microcode_mutex is only used by reload_store(). It has a comment saying
"to synchronize with each other". Other user of this mutex have been
removed in the commits

  181b6f40e9ea8 ("x86/microcode: Rip out the OLD_INTERFACE").
  b6f86689d5b74 ("x86/microcode: Rip out the subsys interface gunk")

The sysfs interface does not need additional synchronisation vs itself
because it is provided as kernfs_ops::mutex which is acquired in
kernfs_fop_write_iter().

Remove the superfluous microcode_mutex.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230804075853.JF_n6GXC@linutronix.de
---
 arch/x86/kernel/cpu/common.c         | 3 +--
 arch/x86/kernel/cpu/microcode/core.c | 6 ------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 52683fd..06015f3 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2276,8 +2276,7 @@ void store_cpu_caps(struct cpuinfo_x86 *curr_info)
  * @prev_info:	CPU capabilities stored before an update.
  *
  * The microcode loader calls this upon late microcode load to recheck features,
- * only when microcode has been updated. Caller holds microcode_mutex and CPU
- * hotplug lock.
+ * only when microcode has been updated. Caller holds and CPU hotplug lock.
  *
  * Return: None
  */
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 192adf5..c9a53e3 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -54,15 +54,12 @@ LIST_HEAD(microcode_cache);
  *
  * All non cpu-hotplug-callback call sites use:
  *
- * - microcode_mutex to synchronize with each other;
  * - cpus_read_lock/unlock() to synchronize with
  *   the cpu-hotplug-callback call sites.
  *
  * We guarantee that only a single cpu is being
  * updated at any particular moment of time.
  */
-static DEFINE_MUTEX(microcode_mutex);
-
 struct ucode_cpu_info		ucode_cpu_info[NR_CPUS];
 
 struct cpu_info_ctx {
@@ -488,10 +485,7 @@ static ssize_t reload_store(struct device *dev,
 	if (tmp_ret != UCODE_NEW)
 		goto put;
 
-	mutex_lock(&microcode_mutex);
 	ret = microcode_reload_late();
-	mutex_unlock(&microcode_mutex);
-
 put:
 	cpus_read_unlock();
 
