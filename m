Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E64B7E8FBC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 13:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjKLMX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 07:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLMX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 07:23:28 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73322D57
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 04:23:24 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4A6B540E0176;
        Sun, 12 Nov 2023 12:23:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0IiONS9UJNBm; Sun, 12 Nov 2023 12:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1699791798; bh=oOL7OIVmvkaQAJpcQZjhIaJkX+/+3Fk315+IDmKqeVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NzI1K5h8et8fL+qxXB694S17rzAjdeSIZ6afyKHfdTU14PFAmU1jjHtCfbjE7LmND
         cyHSCZrx1v7Ih0/vhXvjE+gkYzKyBQ47V7QFcbXnFJocCJZQlRQdEoS99vnL3AT1XX
         sUO4tZZykSVqnshA1TBJM2PNs4NC43ZGboXDXhLpI3pPyQJUGKYH1tgkpoyo6Gvhuz
         x+HkXknzBZVkJ3Pv44p7e6uRdsEmbnA/eVkOCicyAmyO3sUL3kdR5mAp8FEVKTT9Al
         Rt6yxm7ZWborS34dB+9PHC98zTbTOhojdC6sIrKBUgGG6uSGDHMqsWo6JQSuyaZBWr
         gxP1xucW/TjySOUL5Iy8qDs8GAY1E/dtxHVEmM/bztC6X79JNaca0/9XeMkM0tpozG
         zr7l+k2X009RV5C/8I/HXuijZHhfUEXUVvQQjS1uy6xXTJjdDLOXpmdyX9TapSOLQx
         rlO9AejxhY9eLr37NHx0E0F79/lylGHyw91gnovzEx8E15U3hcF3g1J/bnpPE0Rijl
         sIJd8PcnIy523xvcJnNUn6Uf2n5lcDqd4mafdg4ppBu9KthzYqGn/OXUs8sCjxEL4t
         85RSePCOBCx/h5hqSyzV3DDkIk9bL1zfOISWDjXMw1vHvLIfHwxIMoHVlgKmHMnbH8
         ayK/a0MhOLy0pcrlWkFO6pYw=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BDF1C40E0032;
        Sun, 12 Nov 2023 12:23:14 +0000 (UTC)
Date:   Sun, 12 Nov 2023 13:23:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/microcode for 6.7
Message-ID: <20231112122309.GAZVDDrYRiH4RuVbRV@fat_crate.local>
References: <20231103110600.GAZUTUGFjhoLm1KZzE@fat_crate.local>
 <CAHk-=wg=+8rceshMkB4VnKxmRccVLtBLPBawnewZuuqyx5U=3A@mail.gmail.com>
 <20231111223549.GBZVABxWKgkuGNhEqe@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231111223549.GBZVABxWKgkuGNhEqe@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 11:35:49PM +0100, Borislav Petkov wrote:
> Yeah, it is on the todo list. I'll take a look next week.

Yeah, so I think something along the lines of the below.

This has been bothering me for a while now too but I wanted to get
tglx's stuff taken care of first.

Basically, we can simply report the previous and the potentially new
revision only once on driver load.

Even if the AMD side theoretically still supports mixed silicon
steppings, there's no need to do per-thread reporting as that info is
already in /proc/cpuinfo for those who are really interested.

So this below should be good enough.

I'll test it some more next week and split it.

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 9373ec01c5ae..7213dea21a15 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -104,7 +104,7 @@ struct cont_desc {
 	size_t		     size;
 };
 
-static u32 ucode_new_rev;
+static u32 early_new_rev, old_rev;
 
 /*
  * Microcode patch container file is prepended to the initrd in cpio
@@ -447,7 +447,6 @@ static bool early_apply_microcode(u32 cpuid_1_eax, void *ucode, size_t size)
 	struct cont_desc desc = { 0 };
 	struct microcode_amd *mc;
 	bool ret = false;
-	u32 rev, dummy;
 
 	desc.cpuid_1_eax = cpuid_1_eax;
 
@@ -457,22 +456,15 @@ static bool early_apply_microcode(u32 cpuid_1_eax, void *ucode, size_t size)
 	if (!mc)
 		return ret;
 
-	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
 	/*
 	 * Allow application of the same revision to pick up SMT-specific
 	 * changes even if the revision of the other SMT thread is already
 	 * up-to-date.
 	 */
-	if (rev > mc->hdr.patch_id)
+	if (old_rev > mc->hdr.patch_id)
 		return ret;
 
-	if (!__apply_microcode_amd(mc)) {
-		ucode_new_rev = mc->hdr.patch_id;
-		ret = true;
-	}
-
-	return ret;
+	return !__apply_microcode_amd(mc);
 }
 
 static bool get_builtin_microcode(struct cpio_data *cp, unsigned int family)
@@ -509,6 +501,9 @@ static void __init find_blobs_in_containers(unsigned int cpuid_1_eax, struct cpi
 void __init load_ucode_amd_bsp(unsigned int cpuid_1_eax)
 {
 	struct cpio_data cp = { };
+	u32 dummy;
+
+	native_rdmsr(MSR_AMD64_PATCH_LEVEL, old_rev, dummy);
 
 	/* Needed in load_microcode_amd() */
 	ucode_cpu_info[0].cpu_sig.sig = cpuid_1_eax;
@@ -517,7 +512,8 @@ void __init load_ucode_amd_bsp(unsigned int cpuid_1_eax)
 	if (!(cp.data && cp.size))
 		return;
 
-	early_apply_microcode(cpuid_1_eax, cp.data, cp.size);
+	if (early_apply_microcode(cpuid_1_eax, cp.data, cp.size))
+		native_rdmsr(MSR_AMD64_PATCH_LEVEL, early_new_rev, dummy);
 }
 
 static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size);
@@ -626,8 +622,8 @@ void reload_ucode_amd(unsigned int cpu)
 
 	if (rev < mc->hdr.patch_id) {
 		if (!__apply_microcode_amd(mc)) {
-			ucode_new_rev = mc->hdr.patch_id;
-			pr_info("reload patch_level=0x%08x\n", ucode_new_rev);
+			early_new_rev = mc->hdr.patch_id;
+			pr_info_once("reload revision: 0x%08x\n", early_new_rev);
 		}
 	}
 }
@@ -649,8 +645,6 @@ static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 	if (p && (p->patch_id == csig->rev))
 		uci->mc = p->data;
 
-	pr_info("CPU%d: patch_level=0x%08x\n", cpu, csig->rev);
-
 	return 0;
 }
 
@@ -691,8 +685,6 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	rev = mc_amd->hdr.patch_id;
 	ret = UCODE_UPDATED;
 
-	pr_info("CPU%d: new patch_level=0x%08x\n", cpu, rev);
-
 out:
 	uci->cpu_sig.rev = rev;
 	c->microcode	 = rev;
@@ -936,9 +928,11 @@ struct microcode_ops * __init init_amd_microcode(void)
 		return NULL;
 	}
 
-	if (ucode_new_rev)
-		pr_info_once("microcode updated early to new patch_level=0x%08x\n",
-			     ucode_new_rev);
+	pr_info_once("Current revision: 0x%08x\n", (early_new_rev ?: old_rev));
+
+	if (early_new_rev)
+		pr_info_once("Updated early from: 0x%08x\n",
+			     old_rev);
 
 	return &microcode_amd_ops;
 }
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 666d25bbc5ad..b4be3a2c79df 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -41,8 +41,6 @@
 
 #include "internal.h"
 
-#define DRIVER_VERSION	"2.2"
-
 static struct microcode_ops	*microcode_ops;
 bool dis_ucode_ldr = true;
 
@@ -846,8 +844,6 @@ static int __init microcode_init(void)
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/microcode:online",
 			  mc_cpu_online, mc_cpu_down_prep);
 
-	pr_info("Microcode Update Driver: v%s.", DRIVER_VERSION);
-
 	return 0;
 
  out_pdev:

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
