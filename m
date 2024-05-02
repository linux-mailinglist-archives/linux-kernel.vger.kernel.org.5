Return-Path: <linux-kernel+bounces-166363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D768B998E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0B51C2119B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0809A8004E;
	Thu,  2 May 2024 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YllihD5f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C77E792;
	Thu,  2 May 2024 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647582; cv=none; b=kflmD5RMPRmhkYgxYZsMUoHj8QeRtQRbDkGWBziJa2VGU+FSB/dKkhFYhNss/geB16F6eGggi7MLcPOJs79eYd0kEddveTWr1xJ7jH9miBz27+r51SzdN8QpxQKqnnm1NGgTiCDD4oXhsklyyk/AK2DqdFQMUigIl8N3P8u+9cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647582; c=relaxed/simple;
	bh=j0jIdLZ1QSZWN0tNXwU+IAzzOzVCKGDIqO33CuafnFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U1L2t3CaNmWCWJegCgnx3fuS35LaS+caKI0+b7+rV6aFUKEICx6FdORUM6INUt9AxZyOcvt6qZHN/1lvxAZ6/2Zolf72Szi0nesq0CbqrIppxFW2W6XDKS2BnOq/k+WCOU+nByuTHYjwlQ9SO/LAIYKvsUsYwmKw4vMNXFcMdW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YllihD5f; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714647580; x=1746183580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j0jIdLZ1QSZWN0tNXwU+IAzzOzVCKGDIqO33CuafnFQ=;
  b=YllihD5fGb7lN1qBhK6rQAeb2rTAnrBA0wyAa3e1MKLZ36Q4VyE67ciT
   Ye/DbW5koe6u87eYWzqeQ1t6UeBLY0Hqbv44paM1JYyg0PH4U+vxo4RGB
   r/YR/CbVFA2KuJVwiqzkTGsqZe/9f/NJbvFoKLnaWoWzL7Mkb6gLa5WtQ
   cN8WLwrbRJ/YAbLqKWBTUmLYulkxyQeoUUhhgnvzaHuTs3XhXjJ2OqZc6
   n6LcpX6kMx+Gm/lJLea7FzfNHMvIE4VBBu9QAi5kvy4JhGjisH5F5pPPi
   +sxYipUjv++fzZWc4uIHUA+mXMG5lmklD3wkTWbgKUygfG6zxSCqiKw0l
   w==;
X-CSE-ConnectionGUID: p9sXrKdnTEmtKhID7UZwpQ==
X-CSE-MsgGUID: Se4afvrBT+CkPDnxJ2jAFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="14228662"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="14228662"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:59:40 -0700
X-CSE-ConnectionGUID: qwr+9mF2Sp+COxi/JgXqYA==
X-CSE-MsgGUID: FMGz8uXyTx6a2jRgiJZcTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="50278956"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.208.210])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:59:36 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: linux-kernel@vger.kernel.org
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 07/10] x86/insn: Add support for APX EVEX to the instruction decoder logic
Date: Thu,  2 May 2024 13:58:50 +0300
Message-Id: <20240502105853.5338-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502105853.5338-1-adrian.hunter@intel.com>
References: <20240502105853.5338-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Intel Advanced Performance Extensions (APX) extends the EVEX prefix to
support:
 - extended general purpose registers (EGPRs) i.e. r16 to r31
 - Push-Pop Acceleration (PPX) hints
 - new data destination (NDD) register
 - suppress status flags writes (NF) of common instructions
 - new instructions

Refer to the Intel Advanced Performance Extensions (Intel APX) Architecture
Specification for details.

The extended EVEX prefix does not need amended instruction decoder logic,
except in one area. Some instructions are defined as SCALABLE which means
the EVEX.W bit and EVEX.pp bits are used to determine operand size.
Specifically, if an instruction is SCALABLE and EVEX.W is zero, then
EVEX.pp value 0 (representing no prefix NP) means default operand size,
whereas EVEX.pp value 1 (representing 66 prefix) means operand size
override i.e. 16 bits

Add an attribute (INAT_EVEX_SCALABLE) to identify such instructions, and
amend the logic appropriately.

Amend the awk script that generates the attribute tables from the opcode
map, to recognise "(es)" as attribute INAT_EVEX_SCALABLE.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/include/asm/inat.h                | 6 ++++++
 arch/x86/include/asm/insn.h                | 7 +++++++
 arch/x86/lib/insn.c                        | 4 ++++
 arch/x86/tools/gen-insn-attr-x86.awk       | 4 ++++
 tools/arch/x86/include/asm/inat.h          | 6 ++++++
 tools/arch/x86/include/asm/insn.h          | 7 +++++++
 tools/arch/x86/lib/insn.c                  | 4 ++++
 tools/arch/x86/tools/gen-insn-attr-x86.awk | 4 ++++
 8 files changed, 42 insertions(+)

diff --git a/arch/x86/include/asm/inat.h b/arch/x86/include/asm/inat.h
index 1331bdd39a23..53e4015242b4 100644
--- a/arch/x86/include/asm/inat.h
+++ b/arch/x86/include/asm/inat.h
@@ -81,6 +81,7 @@
 #define INAT_EVEXONLY	(1 << (INAT_FLAG_OFFS + 7))
 #define INAT_NO_REX2	(1 << (INAT_FLAG_OFFS + 8))
 #define INAT_REX2_VARIANT	(1 << (INAT_FLAG_OFFS + 9))
+#define INAT_EVEX_SCALABLE	(1 << (INAT_FLAG_OFFS + 10))
 /* Attribute making macros for attribute tables */
 #define INAT_MAKE_PREFIX(pfx)	(pfx << INAT_PFX_OFFS)
 #define INAT_MAKE_ESCAPE(esc)	(esc << INAT_ESC_OFFS)
@@ -236,4 +237,9 @@ static inline int inat_must_evex(insn_attr_t attr)
 {
 	return attr & INAT_EVEXONLY;
 }
+
+static inline int inat_evex_scalable(insn_attr_t attr)
+{
+	return attr & INAT_EVEX_SCALABLE;
+}
 #endif
diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 95249ec1f24e..7152ea809e6a 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -215,6 +215,13 @@ static inline insn_byte_t insn_vex_p_bits(struct insn *insn)
 		return X86_VEX_P(insn->vex_prefix.bytes[2]);
 }
 
+static inline insn_byte_t insn_vex_w_bit(struct insn *insn)
+{
+	if (insn->vex_prefix.nbytes < 3)
+		return 0;
+	return X86_VEX_W(insn->vex_prefix.bytes[2]);
+}
+
 /* Get the last prefix id from last prefix or VEX prefix */
 static inline int insn_last_prefix_id(struct insn *insn)
 {
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 6126ddc6e5f5..5952ab41c60f 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -294,6 +294,10 @@ int insn_get_opcode(struct insn *insn)
 		m = insn_vex_m_bits(insn);
 		p = insn_vex_p_bits(insn);
 		insn->attr = inat_get_avx_attribute(op, m, p);
+		/* SCALABLE EVEX uses p bits to encode operand size */
+		if (inat_evex_scalable(insn->attr) && !insn_vex_w_bit(insn) &&
+		    p == INAT_PFX_OPNDSZ)
+			insn->opnd_bytes = 2;
 		if ((inat_must_evex(insn->attr) && !insn_is_evex(insn)) ||
 		    (!inat_accept_vex(insn->attr) &&
 		     !inat_is_group(insn->attr))) {
diff --git a/arch/x86/tools/gen-insn-attr-x86.awk b/arch/x86/tools/gen-insn-attr-x86.awk
index 3f43aa7d8fef..5770c8097f32 100644
--- a/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/arch/x86/tools/gen-insn-attr-x86.awk
@@ -83,6 +83,8 @@ BEGIN {
 	vexonly_expr = "\\(v\\)"
 	# All opcodes with (ev) superscript supports *only* EVEX prefix
 	evexonly_expr = "\\(ev\\)"
+	# (es) is the same as (ev) but also "SCALABLE" i.e. W and pp determine operand size
+	evex_scalable_expr = "\\(es\\)"
 
 	prefix_expr = "\\(Prefix\\)"
 	prefix_num["Operand-Size"] = "INAT_PFX_OPNDSZ"
@@ -332,6 +334,8 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 		# check VEX codes
 		if (match(ext, evexonly_expr))
 			flags = add_flags(flags, "INAT_VEXOK | INAT_EVEXONLY")
+		else if (match(ext, evex_scalable_expr))
+			flags = add_flags(flags, "INAT_VEXOK | INAT_EVEXONLY | INAT_EVEX_SCALABLE")
 		else if (match(ext, vexonly_expr))
 			flags = add_flags(flags, "INAT_VEXOK | INAT_VEXONLY")
 		else if (match(ext, vexok_expr) || match(opcode, vexok_opcode_expr))
diff --git a/tools/arch/x86/include/asm/inat.h b/tools/arch/x86/include/asm/inat.h
index 2e65312cae52..253690eb3c26 100644
--- a/tools/arch/x86/include/asm/inat.h
+++ b/tools/arch/x86/include/asm/inat.h
@@ -81,6 +81,7 @@
 #define INAT_EVEXONLY	(1 << (INAT_FLAG_OFFS + 7))
 #define INAT_NO_REX2	(1 << (INAT_FLAG_OFFS + 8))
 #define INAT_REX2_VARIANT	(1 << (INAT_FLAG_OFFS + 9))
+#define INAT_EVEX_SCALABLE	(1 << (INAT_FLAG_OFFS + 10))
 /* Attribute making macros for attribute tables */
 #define INAT_MAKE_PREFIX(pfx)	(pfx << INAT_PFX_OFFS)
 #define INAT_MAKE_ESCAPE(esc)	(esc << INAT_ESC_OFFS)
@@ -236,4 +237,9 @@ static inline int inat_must_evex(insn_attr_t attr)
 {
 	return attr & INAT_EVEXONLY;
 }
+
+static inline int inat_evex_scalable(insn_attr_t attr)
+{
+	return attr & INAT_EVEX_SCALABLE;
+}
 #endif
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 1a7e8fc4d75a..0e5abd896ad4 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -215,6 +215,13 @@ static inline insn_byte_t insn_vex_p_bits(struct insn *insn)
 		return X86_VEX_P(insn->vex_prefix.bytes[2]);
 }
 
+static inline insn_byte_t insn_vex_w_bit(struct insn *insn)
+{
+	if (insn->vex_prefix.nbytes < 3)
+		return 0;
+	return X86_VEX_W(insn->vex_prefix.bytes[2]);
+}
+
 /* Get the last prefix id from last prefix or VEX prefix */
 static inline int insn_last_prefix_id(struct insn *insn)
 {
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index f761adeb8e8c..a43b37346a22 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -294,6 +294,10 @@ int insn_get_opcode(struct insn *insn)
 		m = insn_vex_m_bits(insn);
 		p = insn_vex_p_bits(insn);
 		insn->attr = inat_get_avx_attribute(op, m, p);
+		/* SCALABLE EVEX uses p bits to encode operand size */
+		if (inat_evex_scalable(insn->attr) && !insn_vex_w_bit(insn) &&
+		    p == INAT_PFX_OPNDSZ)
+			insn->opnd_bytes = 2;
 		if ((inat_must_evex(insn->attr) && !insn_is_evex(insn)) ||
 		    (!inat_accept_vex(insn->attr) &&
 		     !inat_is_group(insn->attr))) {
diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tools/gen-insn-attr-x86.awk
index 3f43aa7d8fef..5770c8097f32 100644
--- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
@@ -83,6 +83,8 @@ BEGIN {
 	vexonly_expr = "\\(v\\)"
 	# All opcodes with (ev) superscript supports *only* EVEX prefix
 	evexonly_expr = "\\(ev\\)"
+	# (es) is the same as (ev) but also "SCALABLE" i.e. W and pp determine operand size
+	evex_scalable_expr = "\\(es\\)"
 
 	prefix_expr = "\\(Prefix\\)"
 	prefix_num["Operand-Size"] = "INAT_PFX_OPNDSZ"
@@ -332,6 +334,8 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 		# check VEX codes
 		if (match(ext, evexonly_expr))
 			flags = add_flags(flags, "INAT_VEXOK | INAT_EVEXONLY")
+		else if (match(ext, evex_scalable_expr))
+			flags = add_flags(flags, "INAT_VEXOK | INAT_EVEXONLY | INAT_EVEX_SCALABLE")
 		else if (match(ext, vexonly_expr))
 			flags = add_flags(flags, "INAT_VEXOK | INAT_VEXONLY")
 		else if (match(ext, vexok_expr) || match(opcode, vexok_opcode_expr))
-- 
2.34.1


