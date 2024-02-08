Return-Path: <linux-kernel+bounces-58486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD6284E70A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B631F2304E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC44823CF;
	Thu,  8 Feb 2024 17:46:18 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33D51272CB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414377; cv=none; b=rdmN9YQi5R/X+Snj8t/JcJ41ptlHjvEFDfrzkvpz95eySLKKy1i9JLYHB/a/b/QHdAa2810q+8HSXwtHEnBKNWXtuQARDaIUyuBgnYUOgCvquE0fwEY9gDJqhFwktLjYJIoew37DpmZQ7KX2P4Sc/IljSre295XIzqhtbDTXFws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414377; c=relaxed/simple;
	bh=3VQDVYamvDI0F8I8Z+Y2urEQQoaqAqAjv0XpDZccfZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X3tGABaQBGYrqIeEs7wo2GXNNKD17KTBOoxakJLvSR8OGQMu/e4wBW9kixioYzMk2hantHldmPCtX7tQ36wOrfA+YXdJH7FkNzU1JqTgn1vlE23bA3FxGioN4eip5IUD90Fgle8TOAO93laATUNFQKPnpDDV6j+YuPzOlvTGrvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3a77f27524so5455666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 09:46:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707414374; x=1708019174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/24bFWljGRV/DKhqud1PT50P697UNQfWzXVLQTqE/Rw=;
        b=lSZ7HDb8NeJejY65DTwL9rzDAlC/PQbemrpmc0nfN+JJb+IJmbSBi7ctiU9gcNhvBi
         YSXgxz7oLoXU62KctPTaR5nbhl645fDd1P4S/UxSMrHWJMTcNZzzU2C5KkpK9XNNlOVq
         IlN9pbwW8xjkKOxzA/VwQtkctvzR5yLyGEQ6OeyMHIsHTbnHpiLqelV+lAJ6q7wyvu+g
         tIZUFtdWt3u2tWd0NLmr2/mch7kwEwmhIJD+0qCj9ojQos7lSG3muXr2tqXWQyR//iBy
         XF8evcqVdUiRs592lPN0LOiz5sR2B9boXlxEYggevMin829ez1YPa3hUHjA4YsFyG/Zo
         bHjw==
X-Gm-Message-State: AOJu0Yw0B1RFh4VxlfkFU+l2V2uiMyouSlgsunR8gSwNDGsvQ5D0Fo1X
	LsJGWCpVE/UAqS27QHpJKCSozB3R9v3NcCFhegszs/5R1SWBTsRv
X-Google-Smtp-Source: AGHT+IEQrsyN70xcZKp0zP74ztrHxf+XN++RBLNHZu/qmzfClUXE4MKdPDRU8GoAa8Hou7M5tlkCKg==
X-Received: by 2002:a17:906:c30c:b0:a3b:41ab:e62 with SMTP id s12-20020a170906c30c00b00a3b41ab0e62mr35661ejz.26.1707414373989;
        Thu, 08 Feb 2024 09:46:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWcEMOO75WGS7f7KCJdY7Fn14Wt07/mSz7lle18S4WDv4FxOpCH6lq8H91KJf65/1ECPAIs6U7+vuPscKXSsduJvq0gJRtC+n8SbeKURRAzTGnoidA4680LLMMIFGgASc7aL3L93YOZ5X9oz37KU02u5i8dp8lKdAlIOnqnk0YswE1cQwjeiBjHfKW2ImJVSwWlNqKOKBZT3jhKuZ8kodr8mdw+6ivC3IU+85kaSqXRB76x6AVb7CWyUcz9FRBt6q9SbzqY4HSvssK3UZ4WxUeUX4XFQ4b5b3rMQA==
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id cw4-20020a170907160400b00a3b936d79bfsm271779ejd.117.2024.02.08.09.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:46:13 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: mingo@redhat.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] x86/bugs: Add a separate config for missing mitigation
Date: Thu,  8 Feb 2024 09:45:55 -0800
Message-Id: <20240208174555.44200-4-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240208174555.44200-1-leitao@debian.org>
References: <20240208174555.44200-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
where some mitigations have entries in Kconfig, and they could be
modified, while others mitigations do not have Kconfig entries, and
could not be controlled at build time.

Create an entry for each CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
them at compilation time.

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 101 +++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/bugs.c |  39 ++++++++------
 2 files changed, 125 insertions(+), 15 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d5e3f1a8cacd..7dc6fca80c7f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2612,6 +2612,107 @@ config MITIGATION_GDS_FORCE
 
 	  If in doubt, say N.
 
+config MITIGATION_MDS
+	bool "Mitigate Microarchitectural Data Sampling (MDS) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Microarchitectural Data Sampling (MDS). MDS is
+	  a hardware vulnerability which allows unprivileged speculative access
+	  to data which is available in various CPU internal buffers.
+	  See also <file:Documentation/admin-guide/hw-vuln/mds.rst>
+
+config MITIGATION_TAA
+	bool "Mitigate TSX Asynchronous Abort (TAA) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for TSX Asynchronous Abort (TAA). TAA is a hardware
+	  vulnerability that allows unprivileged speculative access to data
+	  which is available in various CPU internal buffers by using
+	  asynchronous aborts within an Intel TSX transactional region.
+	  See also <file:Documentation/admin-guide/hw-vuln/tsx_async_abort.rst>
+
+config MITIGATION_MMIO_STALE_DATA
+	bool "Mitigate MMIO Stale Data hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for MMIO Stale Data hardware bugs.  Processor MMIO
+	  Stale Data Vulnerabilities are a class of memory-mapped I/O (MMIO)
+	  vulnerabilities that can expose data. The vulnerabilities require the
+	  attacker to have access to MMIO.
+	  See also
+	  <file:Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst>
+
+config MITIGATION_L1TF
+	bool "Mitigate L1 Terminal Fault (L1TF) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Mitigate L1 Terminal Fault (L1TF) hardware bug. L1 Terminal Fault is a
+	  hardware vulnerability which allows unprivileged speculative access to data
+	  available in the Level 1 Data Cache.
+	  See <file:Documentation/admin-guide/hw-vuln/l1tf.rst
+
+config MITIGATION_RETBLEED
+	bool "Mitigate RETBleed hardware bug"
+	depends on (CPU_SUP_INTEL && MITIGATION_SPECTRE_V2) || MITIGATION_UNRET_ENTRY || MITIGATION_IBPB_ENTRY
+	default y
+	help
+	  Enable mitigation for RETBleed (Arbitrary Speculative Code Execution
+	  with Return Instructions) vulnerability.  RETBleed is a speculative
+	  execution attack which takes advantage of microarchitectural behavior
+	  in many modern microprocessors, similar to Spectre v2. An
+	  unprivileged attacker can use these flaws to bypass conventional
+	  memory security restrictions to gain read access to privileged memory
+	  that would otherwise be inaccessible.
+
+config MITIGATION_SPECTRE_V1
+	bool "Mitigate SPECTRE V1 hardware bug"
+	default y
+	help
+	  Enable mitigation for Spectre V1 (Bounds Check Bypass). Spectre V1 is a
+	  class of side channel attacks that takes advantage of speculative
+	  execution that bypasses conditional branch instructions used for
+	  memory access bounds check.
+	  See also <file:Documentation/admin-guide/hw-vuln/spectre.rst>
+
+config MITIGATION_SPECTRE_V2
+	bool "Mitigate SPECTRE V2 hardware bug"
+	default y
+	help
+	  Enable mitigation for Spectre V2 (Branch Target Injection). Spectre
+	  V2 is a class of side channel attacks that takes advantage of
+	  indirect branch predictors inside the processor. In Spectre variant 2
+	  attacks, the attacker can steer speculative indirect branches in the
+	  victim to gadget code by poisoning the branch target buffer of a CPU
+	  used for predicting indirect branch addresses.
+	  See also <file:Documentation/admin-guide/hw-vuln/spectre.rst>
+
+config MITIGATION_SRBDS
+	bool "Mitigate Special Register Buffer Data Sampling (SRBDS) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Special Register Buffer Data Sampling (SRBDS).
+	  SRBDS is a hardware vulnerability that allows Microarchitectural Data
+	  Sampling (MDS) techniques to infer values returned from special
+	  register accesses. An unprivileged user can extract values returned
+	  from RDRAND and RDSEED executed on another core or sibling thread
+	  using MDS techniques.
+	  See also
+	  <file:Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst>
+
+config MITIGATION_SSB
+	bool "Mitigate Speculative Store Bypass (SSB) hardware bug"
+	default y
+	help
+	  Enable mitigation for Speculative Store Bypass (SSB). SSB is a
+	  hardware security vulnerability and its exploitation takes advantage
+	  of speculative execution in a similar way to the Meltdown and Spectre
+	  security vulnerabilities.
+
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1fe2e939c0b3..8db2d50ec16e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -232,7 +232,8 @@ static void x86_amd_ssb_disable(void)
 #define pr_fmt(fmt)	"MDS: " fmt
 
 /* Default mitigation for MDS-affected CPUs */
-static enum mds_mitigations mds_mitigation __ro_after_init = MDS_MITIGATION_FULL;
+static enum mds_mitigations mds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_MDS) ? MDS_MITIGATION_FULL : MDS_MITIGATION_OFF;
 static bool mds_nosmt __ro_after_init = false;
 
 static const char * const mds_strings[] = {
@@ -292,7 +293,8 @@ enum taa_mitigations {
 };
 
 /* Default mitigation for TAA-affected CPUs */
-static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_VERW;
+static enum taa_mitigations taa_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_TAA) ? TAA_MITIGATION_VERW : TAA_MITIGATION_OFF;
 static bool taa_nosmt __ro_after_init;
 
 static const char * const taa_strings[] = {
@@ -393,7 +395,8 @@ enum mmio_mitigations {
 };
 
 /* Default mitigation for Processor MMIO Stale Data vulnerabilities */
-static enum mmio_mitigations mmio_mitigation __ro_after_init = MMIO_MITIGATION_VERW;
+static enum mmio_mitigations mmio_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_MMIO_STALE_DATA) ? MMIO_MITIGATION_VERW : MMIO_MITIGATION_OFF;
 static bool mmio_nosmt __ro_after_init = false;
 
 static const char * const mmio_strings[] = {
@@ -542,7 +545,8 @@ enum srbds_mitigations {
 	SRBDS_MITIGATION_HYPERVISOR,
 };
 
-static enum srbds_mitigations srbds_mitigation __ro_after_init = SRBDS_MITIGATION_FULL;
+static enum srbds_mitigations srbds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_SRBDS) ? SRBDS_MITIGATION_FULL : SRBDS_MITIGATION_OFF;
 
 static const char * const srbds_strings[] = {
 	[SRBDS_MITIGATION_OFF]		= "Vulnerable",
@@ -812,7 +816,8 @@ enum spectre_v1_mitigation {
 };
 
 static enum spectre_v1_mitigation spectre_v1_mitigation __ro_after_init =
-	SPECTRE_V1_MITIGATION_AUTO;
+	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V1) ?
+		SPECTRE_V1_MITIGATION_AUTO : SPECTRE_V1_MITIGATION_NONE;
 
 static const char * const spectre_v1_strings[] = {
 	[SPECTRE_V1_MITIGATION_NONE] = "Vulnerable: __user pointer sanitization and usercopy barriers only; no swapgs barriers",
@@ -927,7 +932,7 @@ static const char * const retbleed_strings[] = {
 static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
 	RETBLEED_MITIGATION_NONE;
 static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
-	RETBLEED_CMD_AUTO;
+	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_CMD_AUTO : RETBLEED_CMD_OFF;
 
 static int __ro_after_init retbleed_nosmt = false;
 
@@ -1392,17 +1397,18 @@ static void __init spec_v2_print_cond(const char *reason, bool secure)
 
 static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 {
-	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_CMD_AUTO;
+	enum spectre_v2_mitigation_cmd cmd;
 	char arg[20];
 	int ret, i;
 
+	cmd = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?  SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
 	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2") ||
 	    cpu_mitigations_off())
 		return SPECTRE_V2_CMD_NONE;
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
 	if (ret < 0)
-		return SPECTRE_V2_CMD_AUTO;
+		return cmd;
 
 	for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
 		if (!match_option(arg, ret, mitigation_options[i].option))
@@ -1412,8 +1418,8 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	}
 
 	if (i >= ARRAY_SIZE(mitigation_options)) {
-		pr_err("unknown option (%s). Switching to AUTO select\n", arg);
-		return SPECTRE_V2_CMD_AUTO;
+		pr_err("unknown option (%s). Switching to default mode\n", arg);
+		return cmd;
 	}
 
 	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||
@@ -1886,10 +1892,12 @@ static const struct {
 
 static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 {
-	enum ssb_mitigation_cmd cmd = SPEC_STORE_BYPASS_CMD_AUTO;
+	enum ssb_mitigation_cmd cmd;
 	char arg[20];
 	int ret, i;
 
+	cmd = IS_ENABLED(CONFIG_MITIGATION_SSB) ?
+		SPEC_STORE_BYPASS_CMD_AUTO : SPEC_STORE_BYPASS_CMD_NONE;
 	if (cmdline_find_option_bool(boot_command_line, "nospec_store_bypass_disable") ||
 	    cpu_mitigations_off()) {
 		return SPEC_STORE_BYPASS_CMD_NONE;
@@ -1897,7 +1905,7 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 		ret = cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
 					  arg, sizeof(arg));
 		if (ret < 0)
-			return SPEC_STORE_BYPASS_CMD_AUTO;
+			return cmd;
 
 		for (i = 0; i < ARRAY_SIZE(ssb_mitigation_options); i++) {
 			if (!match_option(arg, ret, ssb_mitigation_options[i].option))
@@ -1908,8 +1916,8 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 		}
 
 		if (i >= ARRAY_SIZE(ssb_mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
-			return SPEC_STORE_BYPASS_CMD_AUTO;
+			pr_err("unknown option (%s). Switching to default mode\n", arg);
+			return cmd;
 		}
 	}
 
@@ -2236,7 +2244,8 @@ EXPORT_SYMBOL_GPL(itlb_multihit_kvm_mitigation);
 #define pr_fmt(fmt)	"L1TF: " fmt
 
 /* Default mitigation for L1TF-affected CPUs */
-enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_FLUSH;
+enum l1tf_mitigations l1tf_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_L1TF) ? L1TF_MITIGATION_FLUSH : L1TF_MITIGATION_OFF;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 EXPORT_SYMBOL_GPL(l1tf_mitigation);
 #endif
-- 
2.39.3


