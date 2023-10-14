Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D687C96FA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 00:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjJNWI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 18:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJNWIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 18:08:25 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BA1C9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 15:08:23 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4054496bde3so32870775e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 15:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697321302; x=1697926102; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ghDZoWO9ubo5ZD+moVqdmgS7dUweAjCjy7g/qakcfGI=;
        b=kUaPEhU4OZGvmuaJUBM+yhEeQ7Ldm2cSfMA9HIMzN+a0SgokQHVlzUFPjS8ICKhCVI
         y+QyyP2PS1eWMA4bVhZpqxcU/YU3rmEiHcDl6V1BgCmxUaO6L3/8GRTVjI+ZnqaK3nPK
         yMOpLzROssUIAlxLEXZa9Nqjsmp1FCG6dksTEsXIWeTUjaQ9kbq/WvfBV4BtONhVFjqr
         9iqTpTlQ8VBN+HRMDYMeGHlCLy/tPKWcrXWNWAJ22tfFjulUPJO4cpYVu7wObEiW96iU
         eKlTB8wrUUIzDBOwdTvs4cnpyPg8kbY1KBHe8tSfu7V5tPG50qxHedToAhKuSvmPfGK7
         kJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697321302; x=1697926102;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghDZoWO9ubo5ZD+moVqdmgS7dUweAjCjy7g/qakcfGI=;
        b=QiRoheakOYa2fh4MzIa48n31jrHEFUiQmQ0bPlzwPdATb3niiSqGwbVSIC2F1abFYe
         XLIqfKqwJdux1IyJJwpA0+oJSx0xf3jJDXNaRzw1wURAcvp104fd428XBJ+ZHGEd4avQ
         Y3GaZbdxRyr2syoKvioir7VUOR4+01wFFXmvMcBXVdvEnvapgBoiULRWXunovRMR7aMS
         LCYbJ6+NQi/P9pBMC7kukY4ibVfnNigahiNVa80ya8K9u1XJx7KwJiPJfs7ywVuIk7wz
         SzpwyEl/Oruc2NlkRP8/+ro4hyX5/5vHU+gFKQ73QiA/MT2PMS7oBlUajPqrweGWGygo
         ttMA==
X-Gm-Message-State: AOJu0Yx0LzVcAMOtByvnERiSv+zOTrYd3WSwUdTfGSLPS83O1FzDchNe
        pnxjukjFkzMvUfz63J+jiIE=
X-Google-Smtp-Source: AGHT+IEUeilQeSXlpgldc67C9sLaN2NGvhi+DV75IkdDAjdsg0nUiNaTAwtibe5+Ie2BOjEkVRYKzA==
X-Received: by 2002:a5d:570d:0:b0:32d:9e48:c2ef with SMTP id a13-20020a5d570d000000b0032d9e48c2efmr4408631wrv.44.1697321301857;
        Sat, 14 Oct 2023 15:08:21 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id hy1-20020a1709068a6100b0099bc08862b6sm1456293ejc.171.2023.10.14.15.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 15:08:20 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 15 Oct 2023 00:08:17 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <ZSsRUR7nXpY7lAWM@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-10-15

   # HEAD: d35652a5fc9944784f6f50a5c979518ff8dacf61 x86/alternatives: Disable KASAN in apply_alternatives()

Fix a false-positive KASAN warning, fix an AMD erratum on Zen4 CPUs,
and fix kernel-doc build warnings.

 Thanks,

	Ingo

------------------>
Borislav Petkov (AMD) (1):
      x86/cpu: Fix AMD erratum #1485 on Zen4-based CPUs

Kirill A. Shutemov (1):
      x86/alternatives: Disable KASAN in apply_alternatives()

Randy Dunlap (1):
      x86/resctrl: Fix kernel-doc warnings


 arch/x86/include/asm/msr-index.h      |  9 +++++++--
 arch/x86/kernel/alternative.c         | 13 +++++++++++++
 arch/x86/kernel/cpu/amd.c             |  8 ++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c | 10 +++++-----
 4 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 1d111350197f..b37abb55e948 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -637,12 +637,17 @@
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
-/* Fam 17h MSRs */
-#define MSR_F17H_IRPERF			0xc00000e9
+/* Zen4 */
+#define MSR_ZEN4_BP_CFG			0xc001102e
+#define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
 
+/* Zen 2 */
 #define MSR_ZEN2_SPECTRAL_CHICKEN	0xc00110e3
 #define MSR_ZEN2_SPECTRAL_CHICKEN_BIT	BIT_ULL(1)
 
+/* Fam 17h MSRs */
+#define MSR_F17H_IRPERF			0xc00000e9
+
 /* Fam 16h MSRs */
 #define MSR_F16H_L2I_PERF_CTL		0xc0010230
 #define MSR_F16H_L2I_PERF_CTR		0xc0010231
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 517ee01503be..73be3931e4f0 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -403,6 +403,17 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	u8 insn_buff[MAX_PATCH_LEN];
 
 	DPRINTK(ALT, "alt table %px, -> %px", start, end);
+
+	/*
+	 * In the case CONFIG_X86_5LEVEL=y, KASAN_SHADOW_START is defined using
+	 * cpu_feature_enabled(X86_FEATURE_LA57) and is therefore patched here.
+	 * During the process, KASAN becomes confused seeing partial LA57
+	 * conversion and triggers a false-positive out-of-bound report.
+	 *
+	 * Disable KASAN until the patching is complete.
+	 */
+	kasan_disable_current();
+
 	/*
 	 * The scan order should be from start to end. A later scanned
 	 * alternative code can overwrite previously scanned alternative code.
@@ -452,6 +463,8 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 
 		text_poke_early(instr, insn_buff, insn_buff_sz);
 	}
+
+	kasan_enable_current();
 }
 
 static inline bool is_jcc32(struct insn *insn)
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 03ef962a6992..ece2b5b7b0fe 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -80,6 +80,10 @@ static const int amd_div0[] =
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x00, 0x0, 0x2f, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0x50, 0x0, 0x5f, 0xf));
 
+static const int amd_erratum_1485[] =
+	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x19, 0x10, 0x0, 0x1f, 0xf),
+			   AMD_MODEL_RANGE(0x19, 0x60, 0x0, 0xaf, 0xf));
+
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
 {
 	int osvw_id = *erratum++;
@@ -1149,6 +1153,10 @@ static void init_amd(struct cpuinfo_x86 *c)
 		pr_notice_once("AMD Zen1 DIV0 bug detected. Disable SMT for full protection.\n");
 		setup_force_cpu_bug(X86_BUG_DIV0);
 	}
+
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
+	     cpu_has_amd_erratum(c, amd_erratum_1485))
+		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
 }
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index ded1fc7cb7cb..f136ac046851 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -30,15 +30,15 @@ struct rmid_entry {
 	struct list_head		list;
 };
 
-/**
- * @rmid_free_lru    A least recently used list of free RMIDs
+/*
+ * @rmid_free_lru - A least recently used list of free RMIDs
  *     These RMIDs are guaranteed to have an occupancy less than the
  *     threshold occupancy
  */
 static LIST_HEAD(rmid_free_lru);
 
-/**
- * @rmid_limbo_count     count of currently unused but (potentially)
+/*
+ * @rmid_limbo_count - count of currently unused but (potentially)
  *     dirty RMIDs.
  *     This counts RMIDs that no one is currently using but that
  *     may have a occupancy value > resctrl_rmid_realloc_threshold. User can
@@ -46,7 +46,7 @@ static LIST_HEAD(rmid_free_lru);
  */
 static unsigned int rmid_limbo_count;
 
-/**
+/*
  * @rmid_entry - The entry in the limbo and free lists.
  */
 static struct rmid_entry	*rmid_ptrs;
