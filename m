Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D43777AA62
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 19:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjHMR0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 13:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjHMR0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 13:26:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F9F10DD;
        Sun, 13 Aug 2023 10:26:36 -0700 (PDT)
Date:   Sun, 13 Aug 2023 17:26:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691947593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3rtUuurXpz5X38s5vfCKJt9YuvD1VEhvJzZac2vIjiE=;
        b=3PCCTCySDOGBZWg08LsSVfQgz9zJxEsoIO++HEUlU1N0wr5uurOdVNNu715zRr8+4minjz
        6dBGsPniUgui1VSLOXFZh8UKvUGbflltflnKnOyyEtnWbua6xHmUU7BWn5LQavslImX6n4
        luu76yaYOJJSdNE69UehcPDItdAbuDOrTT0ruDh/bR8M2tFjqY4qCY/TgKec+HNVsYYXwk
        od1EHAK5bg6Qd6kQa66Xku74274M3YYYF/rB9p/L7MVNHpQzA7PriV87eiPYC8LnKFwMBq
        mctF4H14LpjUUxKYRkgBpkJzgOsLPXSLvPvVoEwHa4ynEP3OQMBLwQraaAUVGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691947593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3rtUuurXpz5X38s5vfCKJt9YuvD1VEhvJzZac2vIjiE=;
        b=r5GtLIfa3I6NGW5AoKhNzRWmcsk32P1C6y3NVHU1UA4YT/LbYZLUAZ5yF/VFeAMQN2pxUx
        hI83qwPGU96IThCg==
From:   "tip-bot2 for Ashok Raj" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Include vendor headers into microcode.h
Cc:     Boris Petkov <bp@alien8.de>, Ashok Raj <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230812195727.776541545@linutronix.de>
References: <20230812195727.776541545@linutronix.de>
MIME-Version: 1.0
Message-ID: <169194759323.27769.9885078704782858476.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     82ad097b02b6ab7985375b925efd06ac042caf1d
Gitweb:        https://git.kernel.org/tip/82ad097b02b6ab7985375b925efd06ac042caf1d
Author:        Ashok Raj <ashok.raj@intel.com>
AuthorDate:    Sat, 12 Aug 2023 21:58:42 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 13 Aug 2023 18:42:55 +02:00

x86/microcode: Include vendor headers into microcode.h

Currently vendor specific headers are included explicitly when used in
common code. Instead, include the vendor specific headers in
microcode.h, and include that in all usages.

No functional change.

Suggested-by: Boris Petkov <bp@alien8.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230812195727.776541545@linutronix.de
---
 arch/x86/include/asm/microcode.h       | 5 ++++-
 arch/x86/include/asm/microcode_amd.h   | 2 --
 arch/x86/include/asm/microcode_intel.h | 2 --
 arch/x86/kernel/cpu/common.c           | 1 -
 arch/x86/kernel/cpu/intel.c            | 2 +-
 arch/x86/kernel/cpu/microcode/amd.c    | 1 -
 arch/x86/kernel/cpu/microcode/core.c   | 2 --
 arch/x86/kernel/cpu/microcode/intel.c  | 2 +-
 drivers/platform/x86/intel/ifs/load.c  | 2 +-
 9 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 0deab6c..9c713b7 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -2,10 +2,13 @@
 #ifndef _ASM_X86_MICROCODE_H
 #define _ASM_X86_MICROCODE_H
 
-#include <asm/cpu.h>
 #include <linux/earlycpio.h>
 #include <linux/initrd.h>
 
+#include <asm/cpu.h>
+#include <asm/microcode_amd.h>
+#include <asm/microcode_intel.h>
+
 struct ucode_patch {
 	struct list_head plist;
 	void *data;		/* Intel uses only this one */
diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index 58e9c83..febe9bf 100644
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_X86_MICROCODE_AMD_H
 #define _ASM_X86_MICROCODE_AMD_H
 
-#include <asm/microcode.h>
-
 #define UCODE_MAGIC			0x00414d44
 #define UCODE_EQUIV_CPU_TABLE_TYPE	0x00000000
 #define UCODE_UCODE_TYPE		0x00000001
diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index 4a32ead..9951a4b 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_X86_MICROCODE_INTEL_H
 #define _ASM_X86_MICROCODE_INTEL_H
 
-#include <asm/microcode.h>
-
 struct microcode_header_intel {
 	unsigned int            hdrver;
 	unsigned int            rev;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 06015f3..1ea5f82 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -59,7 +59,6 @@
 #include <asm/cacheinfo.h>
 #include <asm/memtype.h>
 #include <asm/microcode.h>
-#include <asm/microcode_intel.h>
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 5a8f569..be40456 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -20,7 +20,7 @@
 #include <asm/bugs.h>
 #include <asm/cpu.h>
 #include <asm/intel-family.h>
-#include <asm/microcode_intel.h>
+#include <asm/microcode.h>
 #include <asm/hwcap2.h>
 #include <asm/elf.h>
 #include <asm/cpu_device_id.h>
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index a28b103..dc0a3be 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -29,7 +29,6 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 
-#include <asm/microcode_amd.h>
 #include <asm/microcode.h>
 #include <asm/processor.h>
 #include <asm/setup.h>
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index c9a53e3..73a3c22 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -31,9 +31,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 
-#include <asm/microcode_intel.h>
 #include <asm/cpu_device_id.h>
-#include <asm/microcode_amd.h>
 #include <asm/perf_event.h>
 #include <asm/microcode.h>
 #include <asm/processor.h>
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 952f173..171d96b 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -30,9 +30,9 @@
 #include <linux/uio.h>
 #include <linux/mm.h>
 
-#include <asm/microcode_intel.h>
 #include <asm/intel-family.h>
 #include <asm/processor.h>
+#include <asm/microcode.h>
 #include <asm/tlbflush.h>
 #include <asm/setup.h>
 #include <asm/msr.h>
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index e6ae826..390862a 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -3,7 +3,7 @@
 
 #include <linux/firmware.h>
 #include <asm/cpu.h>
-#include <asm/microcode_intel.h>
+#include <asm/microcode.h>
 
 #include "ifs.h"
 
