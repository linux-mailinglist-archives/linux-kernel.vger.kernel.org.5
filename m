Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439B275CC75
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjGUPuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjGUPuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:50:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7564C19B2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:49:59 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 53E5E1EC058A;
        Fri, 21 Jul 2023 17:49:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1689954597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=t2iBqcFQK3WF1S1lGxZqN4L+GMbnomAE4xFn+tKb1vI=;
        b=VebH7nIVqnjFrrIA5z7jrTtPPBHN2E+WYMyrvJNe5Q05T43YCgVHTyD5sxlqRFNX2BDdhy
        ADZoqEwXvyZjwLVC2bIKVy6Fbk8CNbvSNSvvHn+m1vK3pjyzI2VvvWCi0oqLLHtcMRBfJR
        Uibu79PKqAb/nQs5iDga1QEdn9vX9uE=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WUTeEKfPPN9w; Fri, 21 Jul 2023 15:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1689954593; bh=t2iBqcFQK3WF1S1lGxZqN4L+GMbnomAE4xFn+tKb1vI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgZcf5KLr7ujNybeqRAmZLF4xHUDi6MrADFBTgUowu0grtE/BDueMkVV3jmcl1IDS
         eIGeMToT4HaayHzcwlPTStrWE7eMbjDT3qE5KWR5iFhvJhFPz0IL+9rLyR9M9zeTnE
         sIF2z4OMKwB1OYsx6x1/oBewtebvtUcwrxd9A16umY7f+p3eKjBhiP5LbcWehqXoxc
         Ha/KN7rJtESwlbucvwc25nByfKmSyt3Fp3I/Z9hwxG6/Sguk23NrIRT6hqcThOz11K
         gSsQlBDB7PNCH77fmTjtTwGoo88MocV9e2O8FhxAOGaCxWJO6mL85iyw+ZNqW4N5JJ
         K4OqsGH/XQH0SBbhbOzzqCAr7Pyr1vfYAfgHz5cnlYgHq05MMaL6FRFLzZLITFHJeO
         nyw9f12PnqEvMKSKI61IYBE/UGYS0q3ogef8izCPGMLqDdYUHVRfALEZXWSp85zbCV
         n3lY505MsE3jlc1OQ7K+UIRK7p8rWToH3Of9SQY16KECScbjTibDr21KJRPCgx2KFb
         CjC+zOXioVIolks9uTuQbJBeTC8ZxC54qDZ4kMKpiBYVKDprSFoJp9qGvXk1wG2khv
         6nsiwIGPKeCIoueHbHOi5yCUVMsaEh6CaB7AEH4VFbpGc33puthcIU1ANHCT2IfbyU
         /vgjRFLK7+lnO8APHD4LOLJM=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FA6C40E0185;
        Fri, 21 Jul 2023 15:49:47 +0000 (UTC)
Date:   Fri, 21 Jul 2023 17:49:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     John Allen <john.allen@amd.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org
Subject: Re: [PATCH] x86/microcode/AMD: Increase microcode PATCH_MAX_SIZE
Message-ID: <20230721154942.GBZLqpFkZoWn1Um+bq@fat_crate.local>
References: <20230720202813.3269888-1-john.allen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720202813.3269888-1-john.allen@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove stable@.

This below seems to work here on a couple of machines.

Can you run it too pls to confirm?

Thx.

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Wed, 7 Jun 2023 21:01:06 +0200
Subject: [PATCH] x86/microcode/AMD: Rip out static buffers

Load straight from the containers (initrd or builtin, for example).
There's no need to cache the patch per node.

This even simplifies the code a bit with the opportunity for more
cleanups later.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/microcode_amd.h |  6 +-
 arch/x86/kernel/cpu/microcode/amd.c  | 91 +++++++++-------------------
 arch/x86/kernel/cpu/microcode/core.c |  4 +-
 3 files changed, 31 insertions(+), 70 deletions(-)

diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index e6662adf3af4..a995b7685223 100644
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -44,13 +44,11 @@ struct microcode_amd {
 #define PATCH_MAX_SIZE (3 * PAGE_SIZE)
 
 #ifdef CONFIG_MICROCODE_AMD
-extern void __init load_ucode_amd_bsp(unsigned int family);
-extern void load_ucode_amd_ap(unsigned int family);
+extern void load_ucode_amd_early(unsigned int cpuid_1_eax);
 extern int __init save_microcode_in_initrd_amd(unsigned int family);
 void reload_ucode_amd(unsigned int cpu);
 #else
-static inline void __init load_ucode_amd_bsp(unsigned int family) {}
-static inline void load_ucode_amd_ap(unsigned int family) {}
+static inline void load_ucode_amd_early(unsigned int cpuid_1_eax) {}
 static inline int __init
 save_microcode_in_initrd_amd(unsigned int family) { return -EINVAL; }
 static inline void reload_ucode_amd(unsigned int cpu) {}
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 87208e46f7ed..a28b103256ff 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -56,9 +56,6 @@ struct cont_desc {
 
 static u32 ucode_new_rev;
 
-/* One blob per node. */
-static u8 amd_ucode_patch[MAX_NUMNODES][PATCH_MAX_SIZE];
-
 /*
  * Microcode patch container file is prepended to the initrd in cpio
  * format. See Documentation/arch/x86/microcode.rst
@@ -415,20 +412,17 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
  *
  * Returns true if container found (sets @desc), false otherwise.
  */
-static bool early_apply_microcode(u32 cpuid_1_eax, void *ucode, size_t size, bool save_patch)
+static bool early_apply_microcode(u32 cpuid_1_eax, void *ucode, size_t size)
 {
 	struct cont_desc desc = { 0 };
-	u8 (*patch)[PATCH_MAX_SIZE];
 	struct microcode_amd *mc;
 	u32 rev, dummy, *new_rev;
 	bool ret = false;
 
 #ifdef CONFIG_X86_32
 	new_rev = (u32 *)__pa_nodebug(&ucode_new_rev);
-	patch	= (u8 (*)[PATCH_MAX_SIZE])__pa_nodebug(&amd_ucode_patch);
 #else
 	new_rev = &ucode_new_rev;
-	patch	= &amd_ucode_patch[0];
 #endif
 
 	desc.cpuid_1_eax = cpuid_1_eax;
@@ -452,9 +446,6 @@ static bool early_apply_microcode(u32 cpuid_1_eax, void *ucode, size_t size, boo
 	if (!__apply_microcode_amd(mc)) {
 		*new_rev = mc->hdr.patch_id;
 		ret      = true;
-
-		if (save_patch)
-			memcpy(patch, mc, min_t(u32, desc.psize, PATCH_MAX_SIZE));
 	}
 
 	return ret;
@@ -507,7 +498,7 @@ static void find_blobs_in_containers(unsigned int cpuid_1_eax, struct cpio_data
 	*ret = cp;
 }
 
-void __init load_ucode_amd_bsp(unsigned int cpuid_1_eax)
+static void apply_ucode_from_containers(unsigned int cpuid_1_eax)
 {
 	struct cpio_data cp = { };
 
@@ -515,42 +506,12 @@ void __init load_ucode_amd_bsp(unsigned int cpuid_1_eax)
 	if (!(cp.data && cp.size))
 		return;
 
-	early_apply_microcode(cpuid_1_eax, cp.data, cp.size, true);
+	early_apply_microcode(cpuid_1_eax, cp.data, cp.size);
 }
 
-void load_ucode_amd_ap(unsigned int cpuid_1_eax)
+void load_ucode_amd_early(unsigned int cpuid_1_eax)
 {
-	struct microcode_amd *mc;
-	struct cpio_data cp;
-	u32 *new_rev, rev, dummy;
-
-	if (IS_ENABLED(CONFIG_X86_32)) {
-		mc	= (struct microcode_amd *)__pa_nodebug(amd_ucode_patch);
-		new_rev = (u32 *)__pa_nodebug(&ucode_new_rev);
-	} else {
-		mc	= (struct microcode_amd *)amd_ucode_patch;
-		new_rev = &ucode_new_rev;
-	}
-
-	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
-	/*
-	 * Check whether a new patch has been saved already. Also, allow application of
-	 * the same revision in order to pick up SMT-thread-specific configuration even
-	 * if the sibling SMT thread already has an up-to-date revision.
-	 */
-	if (*new_rev && rev <= mc->hdr.patch_id) {
-		if (!__apply_microcode_amd(mc)) {
-			*new_rev = mc->hdr.patch_id;
-			return;
-		}
-	}
-
-	find_blobs_in_containers(cpuid_1_eax, &cp);
-	if (!(cp.data && cp.size))
-		return;
-
-	early_apply_microcode(cpuid_1_eax, cp.data, cp.size, false);
+	return apply_ucode_from_containers(cpuid_1_eax);
 }
 
 static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size);
@@ -578,23 +539,6 @@ int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 	return 0;
 }
 
-void reload_ucode_amd(unsigned int cpu)
-{
-	u32 rev, dummy __always_unused;
-	struct microcode_amd *mc;
-
-	mc = (struct microcode_amd *)amd_ucode_patch[cpu_to_node(cpu)];
-
-	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
-	if (rev < mc->hdr.patch_id) {
-		if (!__apply_microcode_amd(mc)) {
-			ucode_new_rev = mc->hdr.patch_id;
-			pr_info("reload patch_level=0x%08x\n", ucode_new_rev);
-		}
-	}
-}
-
 /*
  * a small, trivial cache of per-family ucode patches
  */
@@ -655,6 +599,28 @@ static struct ucode_patch *find_patch(unsigned int cpu)
 	return cache_find_patch(equiv_id);
 }
 
+void reload_ucode_amd(unsigned int cpu)
+{
+	u32 rev, dummy __always_unused;
+	struct microcode_amd *mc;
+	struct ucode_patch *p;
+
+	p = find_patch(cpu);
+	if (!p)
+		return;
+
+	mc = p->data;
+
+	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
+
+	if (rev < mc->hdr.patch_id) {
+		if (!__apply_microcode_amd(mc)) {
+			ucode_new_rev = mc->hdr.patch_id;
+			pr_info("reload patch_level=0x%08x\n", ucode_new_rev);
+		}
+	}
+}
+
 static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
@@ -875,9 +841,6 @@ static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t siz
 			continue;
 
 		ret = UCODE_NEW;
-
-		memset(&amd_ucode_patch[nid], 0, PATCH_MAX_SIZE);
-		memcpy(&amd_ucode_patch[nid], p->data, min_t(u32, p->size, PATCH_MAX_SIZE));
 	}
 
 	return ret;
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 3afcf3de0dd4..192adf5f948e 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -172,7 +172,7 @@ void __init load_ucode_bsp(void)
 	if (intel)
 		load_ucode_intel_bsp();
 	else
-		load_ucode_amd_bsp(cpuid_1_eax);
+		load_ucode_amd_early(cpuid_1_eax);
 }
 
 static bool check_loader_disabled_ap(void)
@@ -200,7 +200,7 @@ void load_ucode_ap(void)
 		break;
 	case X86_VENDOR_AMD:
 		if (x86_family(cpuid_1_eax) >= 0x10)
-			load_ucode_amd_ap(cpuid_1_eax);
+			load_ucode_amd_early(cpuid_1_eax);
 		break;
 	default:
 		break;
-- 
2.41.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
