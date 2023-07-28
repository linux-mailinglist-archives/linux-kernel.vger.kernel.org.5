Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9631E7666F1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjG1IX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbjG1IW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:22:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64F41FF2;
        Fri, 28 Jul 2023 01:21:22 -0700 (PDT)
Date:   Fri, 28 Jul 2023 08:21:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690532481;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMfd0HelnlVjNH3W4Qx7FiKgivaaAG98nFZrasSoh3k=;
        b=vGW8b2dEOtvSfOI9UVMDi8XG7jCGBKutFCDW+bAgRsDeAUDKTfcp0bS51qrLcSlhB9cda4
        IL+GF9mJQQ+cMAbUgfYxkJowiIj/20F/4EsaBs3A0vZetpqw6skMAYC0hUVF4sokr7bumx
        kCdYLYksm3oORVIjJW7zc8lz+6HsS56SUF1jzIEZBNHzuOd0MV04dqLO/yBd1tUfhsZbeV
        S/qBF5iFyQaH7VVXML8FB7c7JYHjADwru+EuvPATyuu2zFE0tiuzG4v7GSc1ZJpyLc8CD2
        zqX3AEHnhXmTXqqJc8KWMvtJ2eFjGKf7FeT8pSCezHm7FHakDaZKmXdKQBqJ9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690532481;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMfd0HelnlVjNH3W4Qx7FiKgivaaAG98nFZrasSoh3k=;
        b=/71fy/Q5QFqSXJqoFPYLv1J7i9VSGzLty/4et+VaFMGOD7rIm6rkkvI+lJKPe2iB3K8ExA
        xY3kpHpGNArJVdBw==
From:   "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/smpboot: Change smp_store_boot_cpu_info() to static
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230727180533.3119660-4-sohil.mehta@intel.com>
References: <20230727180533.3119660-4-sohil.mehta@intel.com>
MIME-Version: 1.0
Message-ID: <169053248069.28540.9487948211210505000.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     d7114f83ee051dfeac82546d7ba03d74f8b92af3
Gitweb:        https://git.kernel.org/tip/d7114f83ee051dfeac82546d7ba03d74f8b92af3
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Thu, 27 Jul 2023 18:05:33 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 28 Jul 2023 10:17:53 +02:00

x86/smpboot: Change smp_store_boot_cpu_info() to static

The function is only used locally. Convert it to a static one.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230727180533.3119660-4-sohil.mehta@intel.com

---
 arch/x86/include/asm/smp.h | 2 --
 arch/x86/kernel/smpboot.c  | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 094f31d..cf7217a 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -134,8 +134,6 @@ void native_send_call_func_ipi(const struct cpumask *mask);
 void native_send_call_func_single_ipi(int cpu);
 
 bool smp_park_other_cpus_in_init(void);
-
-void smp_store_boot_cpu_info(void);
 void smp_store_cpu_info(int id);
 
 asmlinkage __visible void smp_reboot_interrupt(void);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 6a09a02..28c590b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -422,7 +422,7 @@ found:
 	return 0;
 }
 
-void __init smp_store_boot_cpu_info(void)
+static void __init smp_store_boot_cpu_info(void)
 {
 	int id = 0; /* CPU 0 */
 	struct cpuinfo_x86 *c = &cpu_data(id);
