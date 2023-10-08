Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85F77BCD97
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 11:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344574AbjJHJmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 05:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343527AbjJHJl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 05:41:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC93B6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 02:41:58 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5363227cc80so5813250a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696758116; x=1697362916; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mI5xpXIO77B1BFKuz6UZMwRyfjm0TpuR0XOiu9hGU1g=;
        b=CHFI2WxEk3KnkSyDrsB8IySRifpjNHoG/WvUmJREWITiwRSoVpJyBCgtdVm4oMEDz+
         FUevsik9k+k81FJa8yIDkdv2QxV6CoG20zzEx4qb7xLWeJnlBGf/sPpDqOMeYBJ08m7Q
         Ua6R+eAh9G3k0pC+ESskbdG9yaHrW+uoHFuxBGGqQEp/3zpT8rDT7e4RADC3XOLRNHgr
         xO7DK9bfqu4ywgw4AtfBtCDcnkrGgWLXzbmAsMeJOHvBb/hHyBUV0Q9Y/+nnLe4LQjKK
         QP64CtVUumbt4/RZy3bk3GAn7LsTGxO4fwG5CYidd9DdC2mC90tla6mgayW6Q+y65+BI
         Quxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696758116; x=1697362916;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mI5xpXIO77B1BFKuz6UZMwRyfjm0TpuR0XOiu9hGU1g=;
        b=pxf/4/269kR0zYwP+f4z1//uHDtJnSTxDdC79iTb6+Sokma8a748pjuXx8DzSOqdh4
         fX+CYZi3aVYDvViCzNt1/4SB82s0LaKa38pe+xmNaVBBAWhdyeYUKv5CiIVO2Zr6h5iX
         SL3PCz0RcSen+D/nFFVP0ZUD01KpP4gQpmhnmcaf+XFqeYwPiMu0QLAoLDkMUiWyc7mS
         5VdgQlAk8FLQbgKbXYzdTG6cEPruOjdRnwikP/cujqtYqGHRnSELHqyzKXrDiS9hidii
         eD0sTJjNh9wpiZOfD/ATgZ/S9P28e9VHhNJK6dkmXcjk8WUmzGW9Zao0Z9fcjuJ2fRhm
         eHnw==
X-Gm-Message-State: AOJu0YzSgaPuCIhyfO2IAKOnYyznU+0RvhAQzeKFP9fMckRTyjgo7Dav
        Mr+RVgDWgmOUv8hFyMR05KI=
X-Google-Smtp-Source: AGHT+IFQBReuZQ1HqDymRMn397whXN3qrHhBGDjCe8kkZvd3PLwxDxxfy6SO6FOR1j6qfSK+e/bwQQ==
X-Received: by 2002:aa7:db45:0:b0:533:520:a5a8 with SMTP id n5-20020aa7db45000000b005330520a5a8mr11051719edt.29.1696758116380;
        Sun, 08 Oct 2023 02:41:56 -0700 (PDT)
Received: from gmail.com (195-38-113-164.pool.digikabel.hu. [195.38.113.164])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d9c4000000b0052284228e3bsm4822707eds.8.2023.10.08.02.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 02:41:54 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 8 Oct 2023 11:41:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <ZSJ5YIr3w5y24idY@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-10-08

   # HEAD: 62d5e970d022ef4bde18948dd67247c3194384c1 x86/sev: Change npages to unsigned long in snp_accept_memory()

Misc fixes:

 - Fix SEV-SNP guest crashes that may happen on NMIs

 - Fix a potential SEV platform memory setup overflow

 Thanks,

	Ingo

------------------>
Tom Lendacky (2):
      x86/sev: Use the GHCB protocol when available for SNP CPUID requests
      x86/sev: Change npages to unsigned long in snp_accept_memory()


 arch/x86/kernel/sev-shared.c | 69 +++++++++++++++++++++++++++++++++++---------
 arch/x86/kernel/sev.c        |  3 +-
 2 files changed, 56 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 2eabccde94fb..dcf325b7b022 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -256,7 +256,7 @@ static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
 	return 0;
 }
 
-static int sev_cpuid_hv(struct cpuid_leaf *leaf)
+static int __sev_cpuid_hv_msr(struct cpuid_leaf *leaf)
 {
 	int ret;
 
@@ -279,6 +279,45 @@ static int sev_cpuid_hv(struct cpuid_leaf *leaf)
 	return ret;
 }
 
+static int __sev_cpuid_hv_ghcb(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+{
+	u32 cr4 = native_read_cr4();
+	int ret;
+
+	ghcb_set_rax(ghcb, leaf->fn);
+	ghcb_set_rcx(ghcb, leaf->subfn);
+
+	if (cr4 & X86_CR4_OSXSAVE)
+		/* Safe to read xcr0 */
+		ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
+	else
+		/* xgetbv will cause #UD - use reset value for xcr0 */
+		ghcb_set_xcr0(ghcb, 1);
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (!(ghcb_rax_is_valid(ghcb) &&
+	      ghcb_rbx_is_valid(ghcb) &&
+	      ghcb_rcx_is_valid(ghcb) &&
+	      ghcb_rdx_is_valid(ghcb)))
+		return ES_VMM_ERROR;
+
+	leaf->eax = ghcb->save.rax;
+	leaf->ebx = ghcb->save.rbx;
+	leaf->ecx = ghcb->save.rcx;
+	leaf->edx = ghcb->save.rdx;
+
+	return ES_OK;
+}
+
+static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+{
+	return ghcb ? __sev_cpuid_hv_ghcb(ghcb, ctxt, leaf)
+		    : __sev_cpuid_hv_msr(leaf);
+}
+
 /*
  * This may be called early while still running on the initial identity
  * mapping. Use RIP-relative addressing to obtain the correct address
@@ -388,19 +427,20 @@ snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 	return false;
 }
 
-static void snp_cpuid_hv(struct cpuid_leaf *leaf)
+static void snp_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 {
-	if (sev_cpuid_hv(leaf))
+	if (sev_cpuid_hv(ghcb, ctxt, leaf))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
 }
 
-static int snp_cpuid_postprocess(struct cpuid_leaf *leaf)
+static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+				 struct cpuid_leaf *leaf)
 {
 	struct cpuid_leaf leaf_hv = *leaf;
 
 	switch (leaf->fn) {
 	case 0x1:
-		snp_cpuid_hv(&leaf_hv);
+		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
 
 		/* initial APIC ID */
 		leaf->ebx = (leaf_hv.ebx & GENMASK(31, 24)) | (leaf->ebx & GENMASK(23, 0));
@@ -419,7 +459,7 @@ static int snp_cpuid_postprocess(struct cpuid_leaf *leaf)
 		break;
 	case 0xB:
 		leaf_hv.subfn = 0;
-		snp_cpuid_hv(&leaf_hv);
+		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
 
 		/* extended APIC ID */
 		leaf->edx = leaf_hv.edx;
@@ -467,7 +507,7 @@ static int snp_cpuid_postprocess(struct cpuid_leaf *leaf)
 		}
 		break;
 	case 0x8000001E:
-		snp_cpuid_hv(&leaf_hv);
+		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
 
 		/* extended APIC ID */
 		leaf->eax = leaf_hv.eax;
@@ -488,7 +528,7 @@ static int snp_cpuid_postprocess(struct cpuid_leaf *leaf)
  * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
  * should be treated as fatal by caller.
  */
-static int snp_cpuid(struct cpuid_leaf *leaf)
+static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
@@ -522,7 +562,7 @@ static int snp_cpuid(struct cpuid_leaf *leaf)
 			return 0;
 	}
 
-	return snp_cpuid_postprocess(leaf);
+	return snp_cpuid_postprocess(ghcb, ctxt, leaf);
 }
 
 /*
@@ -544,14 +584,14 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	leaf.fn = fn;
 	leaf.subfn = subfn;
 
-	ret = snp_cpuid(&leaf);
+	ret = snp_cpuid(NULL, NULL, &leaf);
 	if (!ret)
 		goto cpuid_done;
 
 	if (ret != -EOPNOTSUPP)
 		goto fail;
 
-	if (sev_cpuid_hv(&leaf))
+	if (__sev_cpuid_hv_msr(&leaf))
 		goto fail;
 
 cpuid_done:
@@ -848,14 +888,15 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	return ret;
 }
 
-static int vc_handle_cpuid_snp(struct pt_regs *regs)
+static int vc_handle_cpuid_snp(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
+	struct pt_regs *regs = ctxt->regs;
 	struct cpuid_leaf leaf;
 	int ret;
 
 	leaf.fn = regs->ax;
 	leaf.subfn = regs->cx;
-	ret = snp_cpuid(&leaf);
+	ret = snp_cpuid(ghcb, ctxt, &leaf);
 	if (!ret) {
 		regs->ax = leaf.eax;
 		regs->bx = leaf.ebx;
@@ -874,7 +915,7 @@ static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
 	enum es_result ret;
 	int snp_cpuid_ret;
 
-	snp_cpuid_ret = vc_handle_cpuid_snp(regs);
+	snp_cpuid_ret = vc_handle_cpuid_snp(ghcb, ctxt);
 	if (!snp_cpuid_ret)
 		return ES_OK;
 	if (snp_cpuid_ret != -EOPNOTSUPP)
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 2787826d9f60..d8c1e3be74c0 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -868,8 +868,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned long npages)
 
 void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 {
-	unsigned long vaddr;
-	unsigned int npages;
+	unsigned long vaddr, npages;
 
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return;
