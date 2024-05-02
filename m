Return-Path: <linux-kernel+bounces-166362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2B68B998D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7992BB2256B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2477E579;
	Thu,  2 May 2024 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLQMysAf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DB25FDDC;
	Thu,  2 May 2024 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647578; cv=none; b=sh5T5JNB5P822O/PD6qBUIVpi/IMokuvuu5HRJaL3TNzaRDv9TrqarMH1Fve64GGrTnHKcvf3/y+mHW2XsNQe5LYXCEDcOWlaB/5CJMvfHQpnif+bx6eLg4oz4VZ9q5+ekmAHizma4Q7svTFMzUNI8GmD4vmzoJSapUdq+0MT38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647578; c=relaxed/simple;
	bh=AQhM1MxPOigcJQBRO/cbOJQYibM4B34myV2uhMgYQwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ac+IVn+YjR9ehcDZcYIa0V9RHFsg9mgOcyNueoMzyAtoFSoGKy+BYl+e6NKavr7TZrsHPjNbV8KjjE4snFCMPKCc+9FFM0J43O/fvA6EfbhEimXb4yQUBnNuKZzKJPLuiSAfs7BGlG7EhQlLN5gNPTXALCLBGsFh3ATzZsezGVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLQMysAf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714647577; x=1746183577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AQhM1MxPOigcJQBRO/cbOJQYibM4B34myV2uhMgYQwg=;
  b=JLQMysAfe2kcaWAwLbc+52rbPf6Oyfcplh6BZ+zy7HVP5m1unWTdyh8N
   J1rt7leamp9UGyjzHBt63BfWDiB9ByNZEfvmymCJNTakGakF0ZFbPr2ME
   hCTCC7J/K1ws0+4312xK9fZndQGF4Uko4VQVgTWOcx6ul9QeZzuWJnYrM
   LwBgvmpE1APFDWspSQYGdr8DUsKOcm995po4mbxrs/lPAnOgPcYJqX/qP
   G+Ee7dpNGvGZcUsG3uHG8NkjawcYDuLYvJ+lXEX8k44neZIqhTwVWNUU7
   ON/XZclP57QwiiPyS0w8IJqODRuAvJseEVK+cp5Z7PF78S7XCBIZVIpIQ
   w==;
X-CSE-ConnectionGUID: 7FDJhy8OQJqee+taG3Vssw==
X-CSE-MsgGUID: KWx8/USOQC2DuQ1P1bMb1A==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="14228651"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="14228651"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:59:37 -0700
X-CSE-ConnectionGUID: HPSV3YY3S/WGrs8fAH6RBw==
X-CSE-MsgGUID: at6pwDcwTiyHWQY33fu3gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="50278928"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.208.210])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:59:32 -0700
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
Subject: [PATCH 06/10] x86/insn: x86/insn: Add support for REX2 prefix to the instruction decoder opcode map
Date: Thu,  2 May 2024 13:58:49 +0300
Message-Id: <20240502105853.5338-7-adrian.hunter@intel.com>
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

Support for REX2 has been added to the instruction decoder logic and the
awk script that generates the attribute tables from the opcode map.

Add REX2 prefix byte (0xD5) to the opcode map.

Add annotation (!REX2) for map 0/1 opcodes that are reserved under REX2.

Add JMPABS to the opcode map and add annotation (REX2) to identify that it
has a mandatory REX2 prefix. A separate opcode attribute table is not
needed at this time because JMPABS has the same attribute encoding as the
MOV instruction that it shares an opcode with i.e. INAT_MOFFSET.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/lib/x86-opcode-map.txt       | 148 +++++++++++++-------------
 tools/arch/x86/lib/x86-opcode-map.txt | 148 +++++++++++++-------------
 2 files changed, 152 insertions(+), 144 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 4e9f53581b58..240ef714b64f 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -33,6 +33,10 @@
 #  - (F2): the last prefix is 0xF2
 #  - (!F3) : the last prefix is not 0xF3 (including non-last prefix case)
 #  - (66&F2): Both 0x66 and 0xF2 prefixes are specified.
+#
+# REX2 Prefix
+#  - (!REX2): REX2 is not allowed
+#  - (REX2): REX2 variant e.g. JMPABS
 
 Table: one byte opcode
 Referrer:
@@ -157,22 +161,22 @@ AVXcode:
 6e: OUTS/OUTSB DX,Xb
 6f: OUTS/OUTSW/OUTSD DX,Xz
 # 0x70 - 0x7f
-70: JO Jb
-71: JNO Jb
-72: JB/JNAE/JC Jb
-73: JNB/JAE/JNC Jb
-74: JZ/JE Jb
-75: JNZ/JNE Jb
-76: JBE/JNA Jb
-77: JNBE/JA Jb
-78: JS Jb
-79: JNS Jb
-7a: JP/JPE Jb
-7b: JNP/JPO Jb
-7c: JL/JNGE Jb
-7d: JNL/JGE Jb
-7e: JLE/JNG Jb
-7f: JNLE/JG Jb
+70: JO Jb (!REX2)
+71: JNO Jb (!REX2)
+72: JB/JNAE/JC Jb (!REX2)
+73: JNB/JAE/JNC Jb (!REX2)
+74: JZ/JE Jb (!REX2)
+75: JNZ/JNE Jb (!REX2)
+76: JBE/JNA Jb (!REX2)
+77: JNBE/JA Jb (!REX2)
+78: JS Jb (!REX2)
+79: JNS Jb (!REX2)
+7a: JP/JPE Jb (!REX2)
+7b: JNP/JPO Jb (!REX2)
+7c: JL/JNGE Jb (!REX2)
+7d: JNL/JGE Jb (!REX2)
+7e: JLE/JNG Jb (!REX2)
+7f: JNLE/JG Jb (!REX2)
 # 0x80 - 0x8f
 80: Grp1 Eb,Ib (1A)
 81: Grp1 Ev,Iz (1A)
@@ -208,24 +212,24 @@ AVXcode:
 9e: SAHF
 9f: LAHF
 # 0xa0 - 0xaf
-a0: MOV AL,Ob
-a1: MOV rAX,Ov
-a2: MOV Ob,AL
-a3: MOV Ov,rAX
-a4: MOVS/B Yb,Xb
-a5: MOVS/W/D/Q Yv,Xv
-a6: CMPS/B Xb,Yb
-a7: CMPS/W/D Xv,Yv
-a8: TEST AL,Ib
-a9: TEST rAX,Iz
-aa: STOS/B Yb,AL
-ab: STOS/W/D/Q Yv,rAX
-ac: LODS/B AL,Xb
-ad: LODS/W/D/Q rAX,Xv
-ae: SCAS/B AL,Yb
+a0: MOV AL,Ob (!REX2)
+a1: MOV rAX,Ov (!REX2) | JMPABS O (REX2),(o64)
+a2: MOV Ob,AL (!REX2)
+a3: MOV Ov,rAX (!REX2)
+a4: MOVS/B Yb,Xb (!REX2)
+a5: MOVS/W/D/Q Yv,Xv (!REX2)
+a6: CMPS/B Xb,Yb (!REX2)
+a7: CMPS/W/D Xv,Yv (!REX2)
+a8: TEST AL,Ib (!REX2)
+a9: TEST rAX,Iz (!REX2)
+aa: STOS/B Yb,AL (!REX2)
+ab: STOS/W/D/Q Yv,rAX (!REX2)
+ac: LODS/B AL,Xb (!REX2)
+ad: LODS/W/D/Q rAX,Xv (!REX2)
+ae: SCAS/B AL,Yb (!REX2)
 # Note: The May 2011 Intel manual shows Xv for the second parameter of the
 # next instruction but Yv is correct
-af: SCAS/W/D/Q rAX,Yv
+af: SCAS/W/D/Q rAX,Yv (!REX2)
 # 0xb0 - 0xbf
 b0: MOV AL/R8L,Ib
 b1: MOV CL/R9L,Ib
@@ -266,7 +270,7 @@ d1: Grp2 Ev,1 (1A)
 d2: Grp2 Eb,CL (1A)
 d3: Grp2 Ev,CL (1A)
 d4: AAM Ib (i64)
-d5: AAD Ib (i64)
+d5: AAD Ib (i64) | REX2 (Prefix),(o64)
 d6:
 d7: XLAT/XLATB
 d8: ESC
@@ -281,26 +285,26 @@ df: ESC
 # Note: "forced64" is Intel CPU behavior: they ignore 0x66 prefix
 # in 64-bit mode. AMD CPUs accept 0x66 prefix, it causes RIP truncation
 # to 16 bits. In 32-bit mode, 0x66 is accepted by both Intel and AMD.
-e0: LOOPNE/LOOPNZ Jb (f64)
-e1: LOOPE/LOOPZ Jb (f64)
-e2: LOOP Jb (f64)
-e3: JrCXZ Jb (f64)
-e4: IN AL,Ib
-e5: IN eAX,Ib
-e6: OUT Ib,AL
-e7: OUT Ib,eAX
+e0: LOOPNE/LOOPNZ Jb (f64) (!REX2)
+e1: LOOPE/LOOPZ Jb (f64) (!REX2)
+e2: LOOP Jb (f64) (!REX2)
+e3: JrCXZ Jb (f64) (!REX2)
+e4: IN AL,Ib (!REX2)
+e5: IN eAX,Ib (!REX2)
+e6: OUT Ib,AL (!REX2)
+e7: OUT Ib,eAX (!REX2)
 # With 0x66 prefix in 64-bit mode, for AMD CPUs immediate offset
 # in "near" jumps and calls is 16-bit. For CALL,
 # push of return address is 16-bit wide, RSP is decremented by 2
 # but is not truncated to 16 bits, unlike RIP.
-e8: CALL Jz (f64)
-e9: JMP-near Jz (f64)
-ea: JMP-far Ap (i64)
-eb: JMP-short Jb (f64)
-ec: IN AL,DX
-ed: IN eAX,DX
-ee: OUT DX,AL
-ef: OUT DX,eAX
+e8: CALL Jz (f64) (!REX2)
+e9: JMP-near Jz (f64) (!REX2)
+ea: JMP-far Ap (i64) (!REX2)
+eb: JMP-short Jb (f64) (!REX2)
+ec: IN AL,DX (!REX2)
+ed: IN eAX,DX (!REX2)
+ee: OUT DX,AL (!REX2)
+ef: OUT DX,eAX (!REX2)
 # 0xf0 - 0xff
 f0: LOCK (Prefix)
 f1:
@@ -386,14 +390,14 @@ AVXcode: 1
 2e: vucomiss Vss,Wss (v1) | vucomisd  Vsd,Wsd (66),(v1)
 2f: vcomiss Vss,Wss (v1) | vcomisd  Vsd,Wsd (66),(v1)
 # 0x0f 0x30-0x3f
-30: WRMSR
-31: RDTSC
-32: RDMSR
-33: RDPMC
-34: SYSENTER
-35: SYSEXIT
+30: WRMSR (!REX2)
+31: RDTSC (!REX2)
+32: RDMSR (!REX2)
+33: RDPMC (!REX2)
+34: SYSENTER (!REX2)
+35: SYSEXIT (!REX2)
 36:
-37: GETSEC
+37: GETSEC (!REX2)
 38: escape # 3-byte escape 1
 39:
 3a: escape # 3-byte escape 2
@@ -473,22 +477,22 @@ AVXcode: 1
 7f: movq Qq,Pq | vmovdqa Wx,Vx (66) | vmovdqa32/64 Wx,Vx (66),(evo) | vmovdqu Wx,Vx (F3) | vmovdqu32/64 Wx,Vx (F3),(evo) | vmovdqu8/16 Wx,Vx (F2),(ev)
 # 0x0f 0x80-0x8f
 # Note: "forced64" is Intel CPU behavior (see comment about CALL insn).
-80: JO Jz (f64)
-81: JNO Jz (f64)
-82: JB/JC/JNAE Jz (f64)
-83: JAE/JNB/JNC Jz (f64)
-84: JE/JZ Jz (f64)
-85: JNE/JNZ Jz (f64)
-86: JBE/JNA Jz (f64)
-87: JA/JNBE Jz (f64)
-88: JS Jz (f64)
-89: JNS Jz (f64)
-8a: JP/JPE Jz (f64)
-8b: JNP/JPO Jz (f64)
-8c: JL/JNGE Jz (f64)
-8d: JNL/JGE Jz (f64)
-8e: JLE/JNG Jz (f64)
-8f: JNLE/JG Jz (f64)
+80: JO Jz (f64) (!REX2)
+81: JNO Jz (f64) (!REX2)
+82: JB/JC/JNAE Jz (f64) (!REX2)
+83: JAE/JNB/JNC Jz (f64) (!REX2)
+84: JE/JZ Jz (f64) (!REX2)
+85: JNE/JNZ Jz (f64) (!REX2)
+86: JBE/JNA Jz (f64) (!REX2)
+87: JA/JNBE Jz (f64) (!REX2)
+88: JS Jz (f64) (!REX2)
+89: JNS Jz (f64) (!REX2)
+8a: JP/JPE Jz (f64) (!REX2)
+8b: JNP/JPO Jz (f64) (!REX2)
+8c: JL/JNGE Jz (f64) (!REX2)
+8d: JNL/JGE Jz (f64) (!REX2)
+8e: JLE/JNG Jz (f64) (!REX2)
+8f: JNLE/JG Jz (f64) (!REX2)
 # 0x0f 0x90-0x9f
 90: SETO Eb | kmovw/q Vk,Wk | kmovb/d Vk,Wk (66)
 91: SETNO Eb | kmovw/q Mv,Vk | kmovb/d Mv,Vk (66)
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index 4e9f53581b58..240ef714b64f 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -33,6 +33,10 @@
 #  - (F2): the last prefix is 0xF2
 #  - (!F3) : the last prefix is not 0xF3 (including non-last prefix case)
 #  - (66&F2): Both 0x66 and 0xF2 prefixes are specified.
+#
+# REX2 Prefix
+#  - (!REX2): REX2 is not allowed
+#  - (REX2): REX2 variant e.g. JMPABS
 
 Table: one byte opcode
 Referrer:
@@ -157,22 +161,22 @@ AVXcode:
 6e: OUTS/OUTSB DX,Xb
 6f: OUTS/OUTSW/OUTSD DX,Xz
 # 0x70 - 0x7f
-70: JO Jb
-71: JNO Jb
-72: JB/JNAE/JC Jb
-73: JNB/JAE/JNC Jb
-74: JZ/JE Jb
-75: JNZ/JNE Jb
-76: JBE/JNA Jb
-77: JNBE/JA Jb
-78: JS Jb
-79: JNS Jb
-7a: JP/JPE Jb
-7b: JNP/JPO Jb
-7c: JL/JNGE Jb
-7d: JNL/JGE Jb
-7e: JLE/JNG Jb
-7f: JNLE/JG Jb
+70: JO Jb (!REX2)
+71: JNO Jb (!REX2)
+72: JB/JNAE/JC Jb (!REX2)
+73: JNB/JAE/JNC Jb (!REX2)
+74: JZ/JE Jb (!REX2)
+75: JNZ/JNE Jb (!REX2)
+76: JBE/JNA Jb (!REX2)
+77: JNBE/JA Jb (!REX2)
+78: JS Jb (!REX2)
+79: JNS Jb (!REX2)
+7a: JP/JPE Jb (!REX2)
+7b: JNP/JPO Jb (!REX2)
+7c: JL/JNGE Jb (!REX2)
+7d: JNL/JGE Jb (!REX2)
+7e: JLE/JNG Jb (!REX2)
+7f: JNLE/JG Jb (!REX2)
 # 0x80 - 0x8f
 80: Grp1 Eb,Ib (1A)
 81: Grp1 Ev,Iz (1A)
@@ -208,24 +212,24 @@ AVXcode:
 9e: SAHF
 9f: LAHF
 # 0xa0 - 0xaf
-a0: MOV AL,Ob
-a1: MOV rAX,Ov
-a2: MOV Ob,AL
-a3: MOV Ov,rAX
-a4: MOVS/B Yb,Xb
-a5: MOVS/W/D/Q Yv,Xv
-a6: CMPS/B Xb,Yb
-a7: CMPS/W/D Xv,Yv
-a8: TEST AL,Ib
-a9: TEST rAX,Iz
-aa: STOS/B Yb,AL
-ab: STOS/W/D/Q Yv,rAX
-ac: LODS/B AL,Xb
-ad: LODS/W/D/Q rAX,Xv
-ae: SCAS/B AL,Yb
+a0: MOV AL,Ob (!REX2)
+a1: MOV rAX,Ov (!REX2) | JMPABS O (REX2),(o64)
+a2: MOV Ob,AL (!REX2)
+a3: MOV Ov,rAX (!REX2)
+a4: MOVS/B Yb,Xb (!REX2)
+a5: MOVS/W/D/Q Yv,Xv (!REX2)
+a6: CMPS/B Xb,Yb (!REX2)
+a7: CMPS/W/D Xv,Yv (!REX2)
+a8: TEST AL,Ib (!REX2)
+a9: TEST rAX,Iz (!REX2)
+aa: STOS/B Yb,AL (!REX2)
+ab: STOS/W/D/Q Yv,rAX (!REX2)
+ac: LODS/B AL,Xb (!REX2)
+ad: LODS/W/D/Q rAX,Xv (!REX2)
+ae: SCAS/B AL,Yb (!REX2)
 # Note: The May 2011 Intel manual shows Xv for the second parameter of the
 # next instruction but Yv is correct
-af: SCAS/W/D/Q rAX,Yv
+af: SCAS/W/D/Q rAX,Yv (!REX2)
 # 0xb0 - 0xbf
 b0: MOV AL/R8L,Ib
 b1: MOV CL/R9L,Ib
@@ -266,7 +270,7 @@ d1: Grp2 Ev,1 (1A)
 d2: Grp2 Eb,CL (1A)
 d3: Grp2 Ev,CL (1A)
 d4: AAM Ib (i64)
-d5: AAD Ib (i64)
+d5: AAD Ib (i64) | REX2 (Prefix),(o64)
 d6:
 d7: XLAT/XLATB
 d8: ESC
@@ -281,26 +285,26 @@ df: ESC
 # Note: "forced64" is Intel CPU behavior: they ignore 0x66 prefix
 # in 64-bit mode. AMD CPUs accept 0x66 prefix, it causes RIP truncation
 # to 16 bits. In 32-bit mode, 0x66 is accepted by both Intel and AMD.
-e0: LOOPNE/LOOPNZ Jb (f64)
-e1: LOOPE/LOOPZ Jb (f64)
-e2: LOOP Jb (f64)
-e3: JrCXZ Jb (f64)
-e4: IN AL,Ib
-e5: IN eAX,Ib
-e6: OUT Ib,AL
-e7: OUT Ib,eAX
+e0: LOOPNE/LOOPNZ Jb (f64) (!REX2)
+e1: LOOPE/LOOPZ Jb (f64) (!REX2)
+e2: LOOP Jb (f64) (!REX2)
+e3: JrCXZ Jb (f64) (!REX2)
+e4: IN AL,Ib (!REX2)
+e5: IN eAX,Ib (!REX2)
+e6: OUT Ib,AL (!REX2)
+e7: OUT Ib,eAX (!REX2)
 # With 0x66 prefix in 64-bit mode, for AMD CPUs immediate offset
 # in "near" jumps and calls is 16-bit. For CALL,
 # push of return address is 16-bit wide, RSP is decremented by 2
 # but is not truncated to 16 bits, unlike RIP.
-e8: CALL Jz (f64)
-e9: JMP-near Jz (f64)
-ea: JMP-far Ap (i64)
-eb: JMP-short Jb (f64)
-ec: IN AL,DX
-ed: IN eAX,DX
-ee: OUT DX,AL
-ef: OUT DX,eAX
+e8: CALL Jz (f64) (!REX2)
+e9: JMP-near Jz (f64) (!REX2)
+ea: JMP-far Ap (i64) (!REX2)
+eb: JMP-short Jb (f64) (!REX2)
+ec: IN AL,DX (!REX2)
+ed: IN eAX,DX (!REX2)
+ee: OUT DX,AL (!REX2)
+ef: OUT DX,eAX (!REX2)
 # 0xf0 - 0xff
 f0: LOCK (Prefix)
 f1:
@@ -386,14 +390,14 @@ AVXcode: 1
 2e: vucomiss Vss,Wss (v1) | vucomisd  Vsd,Wsd (66),(v1)
 2f: vcomiss Vss,Wss (v1) | vcomisd  Vsd,Wsd (66),(v1)
 # 0x0f 0x30-0x3f
-30: WRMSR
-31: RDTSC
-32: RDMSR
-33: RDPMC
-34: SYSENTER
-35: SYSEXIT
+30: WRMSR (!REX2)
+31: RDTSC (!REX2)
+32: RDMSR (!REX2)
+33: RDPMC (!REX2)
+34: SYSENTER (!REX2)
+35: SYSEXIT (!REX2)
 36:
-37: GETSEC
+37: GETSEC (!REX2)
 38: escape # 3-byte escape 1
 39:
 3a: escape # 3-byte escape 2
@@ -473,22 +477,22 @@ AVXcode: 1
 7f: movq Qq,Pq | vmovdqa Wx,Vx (66) | vmovdqa32/64 Wx,Vx (66),(evo) | vmovdqu Wx,Vx (F3) | vmovdqu32/64 Wx,Vx (F3),(evo) | vmovdqu8/16 Wx,Vx (F2),(ev)
 # 0x0f 0x80-0x8f
 # Note: "forced64" is Intel CPU behavior (see comment about CALL insn).
-80: JO Jz (f64)
-81: JNO Jz (f64)
-82: JB/JC/JNAE Jz (f64)
-83: JAE/JNB/JNC Jz (f64)
-84: JE/JZ Jz (f64)
-85: JNE/JNZ Jz (f64)
-86: JBE/JNA Jz (f64)
-87: JA/JNBE Jz (f64)
-88: JS Jz (f64)
-89: JNS Jz (f64)
-8a: JP/JPE Jz (f64)
-8b: JNP/JPO Jz (f64)
-8c: JL/JNGE Jz (f64)
-8d: JNL/JGE Jz (f64)
-8e: JLE/JNG Jz (f64)
-8f: JNLE/JG Jz (f64)
+80: JO Jz (f64) (!REX2)
+81: JNO Jz (f64) (!REX2)
+82: JB/JC/JNAE Jz (f64) (!REX2)
+83: JAE/JNB/JNC Jz (f64) (!REX2)
+84: JE/JZ Jz (f64) (!REX2)
+85: JNE/JNZ Jz (f64) (!REX2)
+86: JBE/JNA Jz (f64) (!REX2)
+87: JA/JNBE Jz (f64) (!REX2)
+88: JS Jz (f64) (!REX2)
+89: JNS Jz (f64) (!REX2)
+8a: JP/JPE Jz (f64) (!REX2)
+8b: JNP/JPO Jz (f64) (!REX2)
+8c: JL/JNGE Jz (f64) (!REX2)
+8d: JNL/JGE Jz (f64) (!REX2)
+8e: JLE/JNG Jz (f64) (!REX2)
+8f: JNLE/JG Jz (f64) (!REX2)
 # 0x0f 0x90-0x9f
 90: SETO Eb | kmovw/q Vk,Wk | kmovb/d Vk,Wk (66)
 91: SETNO Eb | kmovw/q Mv,Vk | kmovb/d Mv,Vk (66)
-- 
2.34.1


