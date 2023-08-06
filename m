Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCFE7714FC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 14:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjHFMVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 08:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjHFMVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 08:21:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8112F4;
        Sun,  6 Aug 2023 05:21:47 -0700 (PDT)
Date:   Sun, 06 Aug 2023 12:21:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691324505;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lj2o2lMy4Naxup/WI6x4iavrDazv2xdKBIHEdvWvGYk=;
        b=JR4gvvSAVQ2luaSxrRQahxfaU3Lut2HPhXRDp4VvMi4RBmkl1XydmI3IF79lj7nHMCX0xX
        jOeMO/Icgljg/MavVK/yMFxpRvxMSojgTOPQ9Ds4avQv4mwbm2sn85A8F52/6ToQAzKVfq
        LO1+L5GTQKBkaauqSJA55GrzTpDvgWiF0nGEsDxqglKMN4pnHGuMVko9CyvowPRxaMHDUm
        QCUfnIKX7lnHvPTD5JYPgTsWG7eZNXq58sIYHYi6j48PxO4kLIjIEKNaL5nUuYXlRTHKaq
        5zBj3+BYf0okgEpm7PtSdI7LxEybkaeqoYIvmDFj7qGQ819Rga2CLPLGNC/Dzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691324505;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lj2o2lMy4Naxup/WI6x4iavrDazv2xdKBIHEdvWvGYk=;
        b=R13j8xtNxnxwKCJA3eJNGY+lstH1VYUHi+piSQriVC8z3yGEwmBsQzxzKzufTTAFz5KqmW
        F4mgobINPp5dgUCQ==
From:   "tip-bot2 for Xin Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] tools: Get rid of IRQ_MOVE_CLEANUP_VECTOR from tools
Cc:     Xin Li <xin3.li@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230621171248.6805-4-xin3.li@intel.com>
References: <20230621171248.6805-4-xin3.li@intel.com>
MIME-Version: 1.0
Message-ID: <169132450428.28540.15994029338286764122.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     6e3edb0fb5c0ee3ab1edc1fcfd159e7dd177ef0e
Gitweb:        https://git.kernel.org/tip/6e3edb0fb5c0ee3ab1edc1fcfd159e7dd177ef0e
Author:        Xin Li <xin3.li@intel.com>
AuthorDate:    Wed, 21 Jun 2023 10:12:48 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 06 Aug 2023 14:15:10 +02:00

tools: Get rid of IRQ_MOVE_CLEANUP_VECTOR from tools

IRQ_MOVE_CLEANUP_VECTOR is not longer in use. Remove the last traces.

Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230621171248.6805-4-xin3.li@intel.com

---
 tools/arch/x86/include/asm/irq_vectors.h               | 7 -------
 tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh | 2 +-
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/arch/x86/include/asm/irq_vectors.h b/tools/arch/x86/include/asm/irq_vectors.h
index 43dcb92..3a19904 100644
--- a/tools/arch/x86/include/asm/irq_vectors.h
+++ b/tools/arch/x86/include/asm/irq_vectors.h
@@ -35,13 +35,6 @@
  */
 #define FIRST_EXTERNAL_VECTOR		0x20
 
-/*
- * Reserve the lowest usable vector (and hence lowest priority)  0x20 for
- * triggering cleanup after irq migration. 0x21-0x2f will still be used
- * for device interrupts.
- */
-#define IRQ_MOVE_CLEANUP_VECTOR		FIRST_EXTERNAL_VECTOR
-
 #define IA32_SYSCALL_VECTOR		0x80
 
 /*
diff --git a/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh b/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
index eed9ce0..87dc68c 100755
--- a/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
+++ b/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
@@ -12,7 +12,7 @@ x86_irq_vectors=${arch_x86_header_dir}/irq_vectors.h
 
 # FIRST_EXTERNAL_VECTOR is not that useful, find what is its number
 # and then replace whatever is using it and that is useful, which at
-# the time of writing of this script was: IRQ_MOVE_CLEANUP_VECTOR.
+# the time of writing of this script was: 0x20.
 
 first_external_regex='^#define[[:space:]]+FIRST_EXTERNAL_VECTOR[[:space:]]+(0x[[:xdigit:]]+)$'
 first_external_vector=$(grep -E ${first_external_regex} ${x86_irq_vectors} | sed -r "s/${first_external_regex}/\1/g")
