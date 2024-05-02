Return-Path: <linux-kernel+bounces-166360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 665F58B998B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E39B2895D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E305FDC8;
	Thu,  2 May 2024 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evFpZ9Qr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3112D71747;
	Thu,  2 May 2024 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647571; cv=none; b=t1Wpx6/0O5LNGAU0yMaA4D9g68AgEyjF/nSwAlZcU3vKq8J5gcbOrMlqqIUs9PdLnvKpbbZfLEiDO+bxASzF9/5oV9kfrdOmFF/FvYvIjKHvmHceUeRKcFMr3s7Z9fwuAO+FUP3AXCkmZ+ECogqehj8W/QkgRjXA510Ud71m6gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647571; c=relaxed/simple;
	bh=raxt+KzHGHYDfpTZ+Z5KLKGre0VN8JRQC03tJKCyYtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YJkkqnEchNHlMwCO1tJ0z05yHsEyuFqzhkwkmfEOE720BzrDhvjnzjOPiGKHNjXXanMfhABOI0Nx1Xp4ewZY4gZZC0zAWzNGaFI7HhxNsHRiWCAY4DoGGr2zd1+KqsAtp0J5e5gfngDZxHH7h2Pwr37QIFt0ZpVrWDnEMoZ2EHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evFpZ9Qr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714647569; x=1746183569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=raxt+KzHGHYDfpTZ+Z5KLKGre0VN8JRQC03tJKCyYtw=;
  b=evFpZ9QrcwWczVwqRtA2M5ihngtf+NFUNaPcnqpRBsnt8QtIFXC4CqNs
   H4fviN3o6l88kbLuxZE6+KBOlLndeOtZiPfRH0/gsCwwBGHVgeUvbqpBQ
   NifX1W1JOiQGr1hNLSFV95D3eIwvPU1+BKuS4eqsdWw6sKSixHXmkR8RX
   5ZgyBczpNv5JBxjO2WRlaSSm5P1ifJmZ5kgASO5DWQkYqG/XoU2Wuw0/s
   WsVMA/T8kFisIrT75FYgguq688BEuLN3fZ3qWJirGJYpz2q5jzS0t53En
   5G06O8Lmnzn5hKDESGZbT6ErM2q8Mxy5X0WnurRwTxnI4YB/iP0YSD/9b
   w==;
X-CSE-ConnectionGUID: myNOcC5ZTAufEeFLEph5tQ==
X-CSE-MsgGUID: oZdfRYvpSSK3d2wiLgRzJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="14228607"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="14228607"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:59:28 -0700
X-CSE-ConnectionGUID: xrEhA9SxSBGe2Bd2M+T97A==
X-CSE-MsgGUID: TdQ9Qh1nRKaeG9ylTzhI7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="50278899"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.208.210])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:59:24 -0700
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
Subject: [PATCH 04/10] x86/insn: Add misc new Intel instructions
Date: Thu,  2 May 2024 13:58:47 +0300
Message-Id: <20240502105853.5338-5-adrian.hunter@intel.com>
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

The x86 instruction decoder is used not only for decoding kernel
instructions. It is also used by perf uprobes (user space probes) and by
perf tools Intel Processor Trace decoding. Consequently, it needs to
support instructions executed by user space also.

Add instructions documented in Intel Architecture Instruction Set
Extensions and Future Features Programming Reference March 2024
319433-052, that have not been added yet:

	AADD
	AAND
	AOR
	AXOR
	CMPccXADD
	PBNDKB
	RDMSRLIST
	URDMSR
	UWRMSR
	VBCSTNEBF162PS
	VBCSTNESH2PS
	VCVTNEEBF162PS
	VCVTNEEPH2PS
	VCVTNEOBF162PS
	VCVTNEOPH2PS
	VCVTNEPS2BF16
	VPDPB[SU,UU,SS]D[,S]
	VPDPW[SU,US,UU]D[,S]
	VPMADD52HUQ
	VPMADD52LUQ
	VSHA512MSG1
	VSHA512MSG2
	VSHA512RNDS2
	VSM3MSG1
	VSM3MSG2
	VSM3RNDS2
	VSM4KEY4
	VSM4RNDS4
	WRMSRLIST
	TCMMIMFP16PS
	TCMMRLFP16PS
	TDPFP16PS
	PREFETCHIT1
	PREFETCHIT0

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/lib/x86-opcode-map.txt       | 57 +++++++++++++++++++++------
 tools/arch/x86/lib/x86-opcode-map.txt | 57 +++++++++++++++++++++------
 2 files changed, 90 insertions(+), 24 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 24941b9d4e06..4e9f53581b58 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -698,8 +698,8 @@ AVXcode: 2
 4d: vrcp14ss/d Vsd,Hpd,Wsd (66),(ev)
 4e: vrsqrt14ps/d Vpd,Wpd (66),(ev)
 4f: vrsqrt14ss/d Vsd,Hsd,Wsd (66),(ev)
-50: vpdpbusd Vx,Hx,Wx (66)
-51: vpdpbusds Vx,Hx,Wx (66)
+50: vpdpbusd Vx,Hx,Wx (66) | vpdpbssd Vx,Hx,Wx (F2),(v) | vpdpbsud Vx,Hx,Wx (F3),(v) | vpdpbuud Vx,Hx,Wx (v)
+51: vpdpbusds Vx,Hx,Wx (66) | vpdpbssds Vx,Hx,Wx (F2),(v) | vpdpbsuds Vx,Hx,Wx (F3),(v) | vpdpbuuds Vx,Hx,Wx (v)
 52: vdpbf16ps Vx,Hx,Wx (F3),(ev) | vpdpwssd Vx,Hx,Wx (66) | vp4dpwssd Vdqq,Hdqq,Wdq (F2),(ev)
 53: vpdpwssds Vx,Hx,Wx (66) | vp4dpwssds Vdqq,Hdqq,Wdq (F2),(ev)
 54: vpopcntb/w Vx,Wx (66),(ev)
@@ -708,7 +708,7 @@ AVXcode: 2
 59: vpbroadcastq Vx,Wx (66),(v) | vbroadcasti32x2 Vx,Wx (66),(evo)
 5a: vbroadcasti128 Vqq,Mdq (66),(v) | vbroadcasti32x4/64x2 Vx,Wx (66),(evo)
 5b: vbroadcasti32x8/64x4 Vqq,Mdq (66),(ev)
-5c: TDPBF16PS Vt,Wt,Ht (F3),(v1)
+5c: TDPBF16PS Vt,Wt,Ht (F3),(v1) | TDPFP16PS Vt,Wt,Ht (F2),(v1),(o64)
 # Skip 0x5d
 5e: TDPBSSD Vt,Wt,Ht (F2),(v1) | TDPBSUD Vt,Wt,Ht (F3),(v1) | TDPBUSD Vt,Wt,Ht (66),(v1) | TDPBUUD Vt,Wt,Ht (v1)
 # Skip 0x5f-0x61
@@ -718,10 +718,12 @@ AVXcode: 2
 65: vblendmps/d Vx,Hx,Wx (66),(ev)
 66: vpblendmb/w Vx,Hx,Wx (66),(ev)
 68: vp2intersectd/q Kx,Hx,Wx (F2),(ev)
-# Skip 0x69-0x6f
+# Skip 0x69-0x6b
+6c: TCMMIMFP16PS Vt,Wt,Ht (66),(v1),(o64) | TCMMRLFP16PS Vt,Wt,Ht (v1),(o64)
+# Skip 0x6d-0x6f
 70: vpshldvw Vx,Hx,Wx (66),(ev)
 71: vpshldvd/q Vx,Hx,Wx (66),(ev)
-72: vcvtne2ps2bf16 Vx,Hx,Wx (F2),(ev) | vcvtneps2bf16 Vx,Wx (F3),(ev) | vpshrdvw Vx,Hx,Wx (66),(ev)
+72: vcvtne2ps2bf16 Vx,Hx,Wx (F2),(ev) | vcvtneps2bf16 Vx,Wx (F3) | vpshrdvw Vx,Hx,Wx (66),(ev)
 73: vpshrdvd/q Vx,Hx,Wx (66),(ev)
 75: vpermi2b/w Vx,Hx,Wx (66),(ev)
 76: vpermi2d/q Vx,Hx,Wx (66),(ev)
@@ -777,8 +779,10 @@ ac: vfnmadd213ps/d Vx,Hx,Wx (66),(v)
 ad: vfnmadd213ss/d Vx,Hx,Wx (66),(v),(v1)
 ae: vfnmsub213ps/d Vx,Hx,Wx (66),(v)
 af: vfnmsub213ss/d Vx,Hx,Wx (66),(v),(v1)
-b4: vpmadd52luq Vx,Hx,Wx (66),(ev)
-b5: vpmadd52huq Vx,Hx,Wx (66),(ev)
+b0: vcvtneebf162ps Vx,Mx (F3),(!11B),(v) | vcvtneeph2ps Vx,Mx (66),(!11B),(v) | vcvtneobf162ps Vx,Mx (F2),(!11B),(v) | vcvtneoph2ps Vx,Mx (!11B),(v)
+b1: vbcstnebf162ps Vx,Mw (F3),(!11B),(v) | vbcstnesh2ps Vx,Mw (66),(!11B),(v)
+b4: vpmadd52luq Vx,Hx,Wx (66)
+b5: vpmadd52huq Vx,Hx,Wx (66)
 b6: vfmaddsub231ps/d Vx,Hx,Wx (66),(v)
 b7: vfmsubadd231ps/d Vx,Hx,Wx (66),(v)
 b8: vfmadd231ps/d Vx,Hx,Wx (66),(v)
@@ -796,16 +800,35 @@ c7: Grp19 (1A)
 c8: sha1nexte Vdq,Wdq | vexp2ps/d Vx,Wx (66),(ev)
 c9: sha1msg1 Vdq,Wdq
 ca: sha1msg2 Vdq,Wdq | vrcp28ps/d Vx,Wx (66),(ev)
-cb: sha256rnds2 Vdq,Wdq | vrcp28ss/d Vx,Hx,Wx (66),(ev)
-cc: sha256msg1 Vdq,Wdq | vrsqrt28ps/d Vx,Wx (66),(ev)
-cd: sha256msg2 Vdq,Wdq | vrsqrt28ss/d Vx,Hx,Wx (66),(ev)
+cb: sha256rnds2 Vdq,Wdq | vrcp28ss/d Vx,Hx,Wx (66),(ev) | vsha512rnds2 Vqq,Hqq,Udq (F2),(11B),(v)
+cc: sha256msg1 Vdq,Wdq | vrsqrt28ps/d Vx,Wx (66),(ev) | vsha512msg1 Vqq,Udq (F2),(11B),(v)
+cd: sha256msg2 Vdq,Wdq | vrsqrt28ss/d Vx,Hx,Wx (66),(ev) | vsha512msg2 Vqq,Uqq (F2),(11B),(v)
 cf: vgf2p8mulb Vx,Wx (66)
+d2: vpdpwsud Vx,Hx,Wx (F3),(v) | vpdpwusd Vx,Hx,Wx (66),(v) | vpdpwuud Vx,Hx,Wx (v)
+d3: vpdpwsuds Vx,Hx,Wx (F3),(v) | vpdpwusds Vx,Hx,Wx (66),(v) | vpdpwuuds Vx,Hx,Wx (v)
 d8: AESENCWIDE128KL Qpi (F3),(000),(00B) | AESENCWIDE256KL Qpi (F3),(000),(10B) | AESDECWIDE128KL Qpi (F3),(000),(01B) | AESDECWIDE256KL Qpi (F3),(000),(11B)
+da: vsm3msg1 Vdq,Hdq,Udq (v1) | vsm3msg2 Vdq,Hdq,Udq (66),(v1) | vsm4key4 Vx,Hx,Wx (F3),(v) | vsm4rnds4 Vx,Hx,Wx (F2),(v)
 db: VAESIMC Vdq,Wdq (66),(v1)
 dc: vaesenc Vx,Hx,Wx (66) | LOADIWKEY Vx,Hx (F3) | AESENC128KL Vpd,Qpi (F3)
 dd: vaesenclast Vx,Hx,Wx (66) | AESDEC128KL Vpd,Qpi (F3)
 de: vaesdec Vx,Hx,Wx (66) | AESENC256KL Vpd,Qpi (F3)
 df: vaesdeclast Vx,Hx,Wx (66) | AESDEC256KL Vpd,Qpi (F3)
+e0: CMPOXADD   My,Gy,By (66),(v1),(o64)
+e1: CMPNOXADD  My,Gy,By (66),(v1),(o64)
+e2: CMPBXADD   My,Gy,By (66),(v1),(o64)
+e3: CMPNBXADD  My,Gy,By (66),(v1),(o64)
+e4: CMPZXADD   My,Gy,By (66),(v1),(o64)
+e5: CMPNZXADD  My,Gy,By (66),(v1),(o64)
+e6: CMPBEXADD  My,Gy,By (66),(v1),(o64)
+e7: CMPNBEXADD My,Gy,By (66),(v1),(o64)
+e8: CMPSXADD   My,Gy,By (66),(v1),(o64)
+e9: CMPNSXADD  My,Gy,By (66),(v1),(o64)
+ea: CMPPXADD   My,Gy,By (66),(v1),(o64)
+eb: CMPNPXADD  My,Gy,By (66),(v1),(o64)
+ec: CMPLXADD   My,Gy,By (66),(v1),(o64)
+ed: CMPNLXADD  My,Gy,By (66),(v1),(o64)
+ee: CMPLEXADD  My,Gy,By (66),(v1),(o64)
+ef: CMPNLEXADD My,Gy,By (66),(v1),(o64)
 f0: MOVBE Gy,My | MOVBE Gw,Mw (66) | CRC32 Gd,Eb (F2) | CRC32 Gd,Eb (66&F2)
 f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
 f2: ANDN Gy,By,Ey (v)
@@ -813,10 +836,11 @@ f3: Grp17 (1A)
 f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v) | WRUSSD/Q My,Gy (66)
 f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v) | WRSSD/Q My,Gy
 f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
-f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3)
+f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3) | URDMSR Rq,Gq (F2),(11B) | UWRMSR Gq,Rq (F3),(11B)
 f9: MOVDIRI My,Gy
 fa: ENCODEKEY128 Ew,Ew (F3)
 fb: ENCODEKEY256 Ew,Ew (F3)
+fc: AADD My,Gy | AAND My,Gy (66) | AOR My,Gy (F2) | AXOR My,Gy (F3)
 EndTable
 
 Table: 3-byte opcode 2 (0x0f 0x3a)
@@ -896,6 +920,7 @@ c2: vcmpph Vx,Hx,Wx,Ib (ev) | vcmpsh Vx,Hx,Wx,Ib (F3),(ev)
 cc: sha1rnds4 Vdq,Wdq,Ib
 ce: vgf2p8affineqb Vx,Wx,Ib (66)
 cf: vgf2p8affineinvqb Vx,Wx,Ib (66)
+de: vsm3rnds2 Vdq,Hdq,Wdq,Ib (66),(v1)
 df: VAESKEYGEN Vdq,Wdq,Ib (66),(v1)
 f0: RORX Gy,Ey,Ib (F2),(v) | HRESET Gv,Ib (F3),(000),(11B)
 EndTable
@@ -978,6 +1003,12 @@ d6: vfcmulcph Vx,Hx,Wx (F2),(ev) | vfmulcph Vx,Hx,Wx (F3),(ev)
 d7: vfcmulcsh Vx,Hx,Wx (F2),(ev) | vfmulcsh Vx,Hx,Wx (F3),(ev)
 EndTable
 
+Table: VEX map 7
+Referrer:
+AVXcode: 7
+f8: URDMSR Rq,Id (F2),(v1),(11B) | UWRMSR Id,Rq (F3),(v1),(11B)
+EndTable
+
 GrpTable: Grp1
 0: ADD
 1: OR
@@ -1054,7 +1085,7 @@ GrpTable: Grp6
 EndTable
 
 GrpTable: Grp7
-0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B) | WRMSRNS (110),(11B)
+0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B) | WRMSRNS (110),(11B) | RDMSRLIST (F2),(110),(11B) | WRMSRLIST (F3),(110),(11B) | PBNDKB (111),(11B)
 1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B) | ERETU (F3),(010),(11B) | ERETS (F2),(010),(11B)
 2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
 3: LIDT Ms
@@ -1140,6 +1171,8 @@ GrpTable: Grp16
 1: prefetch T0
 2: prefetch T1
 3: prefetch T2
+6: prefetch IT1
+7: prefetch IT0
 EndTable
 
 GrpTable: Grp17
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index 24941b9d4e06..4e9f53581b58 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -698,8 +698,8 @@ AVXcode: 2
 4d: vrcp14ss/d Vsd,Hpd,Wsd (66),(ev)
 4e: vrsqrt14ps/d Vpd,Wpd (66),(ev)
 4f: vrsqrt14ss/d Vsd,Hsd,Wsd (66),(ev)
-50: vpdpbusd Vx,Hx,Wx (66)
-51: vpdpbusds Vx,Hx,Wx (66)
+50: vpdpbusd Vx,Hx,Wx (66) | vpdpbssd Vx,Hx,Wx (F2),(v) | vpdpbsud Vx,Hx,Wx (F3),(v) | vpdpbuud Vx,Hx,Wx (v)
+51: vpdpbusds Vx,Hx,Wx (66) | vpdpbssds Vx,Hx,Wx (F2),(v) | vpdpbsuds Vx,Hx,Wx (F3),(v) | vpdpbuuds Vx,Hx,Wx (v)
 52: vdpbf16ps Vx,Hx,Wx (F3),(ev) | vpdpwssd Vx,Hx,Wx (66) | vp4dpwssd Vdqq,Hdqq,Wdq (F2),(ev)
 53: vpdpwssds Vx,Hx,Wx (66) | vp4dpwssds Vdqq,Hdqq,Wdq (F2),(ev)
 54: vpopcntb/w Vx,Wx (66),(ev)
@@ -708,7 +708,7 @@ AVXcode: 2
 59: vpbroadcastq Vx,Wx (66),(v) | vbroadcasti32x2 Vx,Wx (66),(evo)
 5a: vbroadcasti128 Vqq,Mdq (66),(v) | vbroadcasti32x4/64x2 Vx,Wx (66),(evo)
 5b: vbroadcasti32x8/64x4 Vqq,Mdq (66),(ev)
-5c: TDPBF16PS Vt,Wt,Ht (F3),(v1)
+5c: TDPBF16PS Vt,Wt,Ht (F3),(v1) | TDPFP16PS Vt,Wt,Ht (F2),(v1),(o64)
 # Skip 0x5d
 5e: TDPBSSD Vt,Wt,Ht (F2),(v1) | TDPBSUD Vt,Wt,Ht (F3),(v1) | TDPBUSD Vt,Wt,Ht (66),(v1) | TDPBUUD Vt,Wt,Ht (v1)
 # Skip 0x5f-0x61
@@ -718,10 +718,12 @@ AVXcode: 2
 65: vblendmps/d Vx,Hx,Wx (66),(ev)
 66: vpblendmb/w Vx,Hx,Wx (66),(ev)
 68: vp2intersectd/q Kx,Hx,Wx (F2),(ev)
-# Skip 0x69-0x6f
+# Skip 0x69-0x6b
+6c: TCMMIMFP16PS Vt,Wt,Ht (66),(v1),(o64) | TCMMRLFP16PS Vt,Wt,Ht (v1),(o64)
+# Skip 0x6d-0x6f
 70: vpshldvw Vx,Hx,Wx (66),(ev)
 71: vpshldvd/q Vx,Hx,Wx (66),(ev)
-72: vcvtne2ps2bf16 Vx,Hx,Wx (F2),(ev) | vcvtneps2bf16 Vx,Wx (F3),(ev) | vpshrdvw Vx,Hx,Wx (66),(ev)
+72: vcvtne2ps2bf16 Vx,Hx,Wx (F2),(ev) | vcvtneps2bf16 Vx,Wx (F3) | vpshrdvw Vx,Hx,Wx (66),(ev)
 73: vpshrdvd/q Vx,Hx,Wx (66),(ev)
 75: vpermi2b/w Vx,Hx,Wx (66),(ev)
 76: vpermi2d/q Vx,Hx,Wx (66),(ev)
@@ -777,8 +779,10 @@ ac: vfnmadd213ps/d Vx,Hx,Wx (66),(v)
 ad: vfnmadd213ss/d Vx,Hx,Wx (66),(v),(v1)
 ae: vfnmsub213ps/d Vx,Hx,Wx (66),(v)
 af: vfnmsub213ss/d Vx,Hx,Wx (66),(v),(v1)
-b4: vpmadd52luq Vx,Hx,Wx (66),(ev)
-b5: vpmadd52huq Vx,Hx,Wx (66),(ev)
+b0: vcvtneebf162ps Vx,Mx (F3),(!11B),(v) | vcvtneeph2ps Vx,Mx (66),(!11B),(v) | vcvtneobf162ps Vx,Mx (F2),(!11B),(v) | vcvtneoph2ps Vx,Mx (!11B),(v)
+b1: vbcstnebf162ps Vx,Mw (F3),(!11B),(v) | vbcstnesh2ps Vx,Mw (66),(!11B),(v)
+b4: vpmadd52luq Vx,Hx,Wx (66)
+b5: vpmadd52huq Vx,Hx,Wx (66)
 b6: vfmaddsub231ps/d Vx,Hx,Wx (66),(v)
 b7: vfmsubadd231ps/d Vx,Hx,Wx (66),(v)
 b8: vfmadd231ps/d Vx,Hx,Wx (66),(v)
@@ -796,16 +800,35 @@ c7: Grp19 (1A)
 c8: sha1nexte Vdq,Wdq | vexp2ps/d Vx,Wx (66),(ev)
 c9: sha1msg1 Vdq,Wdq
 ca: sha1msg2 Vdq,Wdq | vrcp28ps/d Vx,Wx (66),(ev)
-cb: sha256rnds2 Vdq,Wdq | vrcp28ss/d Vx,Hx,Wx (66),(ev)
-cc: sha256msg1 Vdq,Wdq | vrsqrt28ps/d Vx,Wx (66),(ev)
-cd: sha256msg2 Vdq,Wdq | vrsqrt28ss/d Vx,Hx,Wx (66),(ev)
+cb: sha256rnds2 Vdq,Wdq | vrcp28ss/d Vx,Hx,Wx (66),(ev) | vsha512rnds2 Vqq,Hqq,Udq (F2),(11B),(v)
+cc: sha256msg1 Vdq,Wdq | vrsqrt28ps/d Vx,Wx (66),(ev) | vsha512msg1 Vqq,Udq (F2),(11B),(v)
+cd: sha256msg2 Vdq,Wdq | vrsqrt28ss/d Vx,Hx,Wx (66),(ev) | vsha512msg2 Vqq,Uqq (F2),(11B),(v)
 cf: vgf2p8mulb Vx,Wx (66)
+d2: vpdpwsud Vx,Hx,Wx (F3),(v) | vpdpwusd Vx,Hx,Wx (66),(v) | vpdpwuud Vx,Hx,Wx (v)
+d3: vpdpwsuds Vx,Hx,Wx (F3),(v) | vpdpwusds Vx,Hx,Wx (66),(v) | vpdpwuuds Vx,Hx,Wx (v)
 d8: AESENCWIDE128KL Qpi (F3),(000),(00B) | AESENCWIDE256KL Qpi (F3),(000),(10B) | AESDECWIDE128KL Qpi (F3),(000),(01B) | AESDECWIDE256KL Qpi (F3),(000),(11B)
+da: vsm3msg1 Vdq,Hdq,Udq (v1) | vsm3msg2 Vdq,Hdq,Udq (66),(v1) | vsm4key4 Vx,Hx,Wx (F3),(v) | vsm4rnds4 Vx,Hx,Wx (F2),(v)
 db: VAESIMC Vdq,Wdq (66),(v1)
 dc: vaesenc Vx,Hx,Wx (66) | LOADIWKEY Vx,Hx (F3) | AESENC128KL Vpd,Qpi (F3)
 dd: vaesenclast Vx,Hx,Wx (66) | AESDEC128KL Vpd,Qpi (F3)
 de: vaesdec Vx,Hx,Wx (66) | AESENC256KL Vpd,Qpi (F3)
 df: vaesdeclast Vx,Hx,Wx (66) | AESDEC256KL Vpd,Qpi (F3)
+e0: CMPOXADD   My,Gy,By (66),(v1),(o64)
+e1: CMPNOXADD  My,Gy,By (66),(v1),(o64)
+e2: CMPBXADD   My,Gy,By (66),(v1),(o64)
+e3: CMPNBXADD  My,Gy,By (66),(v1),(o64)
+e4: CMPZXADD   My,Gy,By (66),(v1),(o64)
+e5: CMPNZXADD  My,Gy,By (66),(v1),(o64)
+e6: CMPBEXADD  My,Gy,By (66),(v1),(o64)
+e7: CMPNBEXADD My,Gy,By (66),(v1),(o64)
+e8: CMPSXADD   My,Gy,By (66),(v1),(o64)
+e9: CMPNSXADD  My,Gy,By (66),(v1),(o64)
+ea: CMPPXADD   My,Gy,By (66),(v1),(o64)
+eb: CMPNPXADD  My,Gy,By (66),(v1),(o64)
+ec: CMPLXADD   My,Gy,By (66),(v1),(o64)
+ed: CMPNLXADD  My,Gy,By (66),(v1),(o64)
+ee: CMPLEXADD  My,Gy,By (66),(v1),(o64)
+ef: CMPNLEXADD My,Gy,By (66),(v1),(o64)
 f0: MOVBE Gy,My | MOVBE Gw,Mw (66) | CRC32 Gd,Eb (F2) | CRC32 Gd,Eb (66&F2)
 f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
 f2: ANDN Gy,By,Ey (v)
@@ -813,10 +836,11 @@ f3: Grp17 (1A)
 f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v) | WRUSSD/Q My,Gy (66)
 f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v) | WRSSD/Q My,Gy
 f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
-f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3)
+f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3) | URDMSR Rq,Gq (F2),(11B) | UWRMSR Gq,Rq (F3),(11B)
 f9: MOVDIRI My,Gy
 fa: ENCODEKEY128 Ew,Ew (F3)
 fb: ENCODEKEY256 Ew,Ew (F3)
+fc: AADD My,Gy | AAND My,Gy (66) | AOR My,Gy (F2) | AXOR My,Gy (F3)
 EndTable
 
 Table: 3-byte opcode 2 (0x0f 0x3a)
@@ -896,6 +920,7 @@ c2: vcmpph Vx,Hx,Wx,Ib (ev) | vcmpsh Vx,Hx,Wx,Ib (F3),(ev)
 cc: sha1rnds4 Vdq,Wdq,Ib
 ce: vgf2p8affineqb Vx,Wx,Ib (66)
 cf: vgf2p8affineinvqb Vx,Wx,Ib (66)
+de: vsm3rnds2 Vdq,Hdq,Wdq,Ib (66),(v1)
 df: VAESKEYGEN Vdq,Wdq,Ib (66),(v1)
 f0: RORX Gy,Ey,Ib (F2),(v) | HRESET Gv,Ib (F3),(000),(11B)
 EndTable
@@ -978,6 +1003,12 @@ d6: vfcmulcph Vx,Hx,Wx (F2),(ev) | vfmulcph Vx,Hx,Wx (F3),(ev)
 d7: vfcmulcsh Vx,Hx,Wx (F2),(ev) | vfmulcsh Vx,Hx,Wx (F3),(ev)
 EndTable
 
+Table: VEX map 7
+Referrer:
+AVXcode: 7
+f8: URDMSR Rq,Id (F2),(v1),(11B) | UWRMSR Id,Rq (F3),(v1),(11B)
+EndTable
+
 GrpTable: Grp1
 0: ADD
 1: OR
@@ -1054,7 +1085,7 @@ GrpTable: Grp6
 EndTable
 
 GrpTable: Grp7
-0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B) | WRMSRNS (110),(11B)
+0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B) | WRMSRNS (110),(11B) | RDMSRLIST (F2),(110),(11B) | WRMSRLIST (F3),(110),(11B) | PBNDKB (111),(11B)
 1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B) | ERETU (F3),(010),(11B) | ERETS (F2),(010),(11B)
 2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
 3: LIDT Ms
@@ -1140,6 +1171,8 @@ GrpTable: Grp16
 1: prefetch T0
 2: prefetch T1
 3: prefetch T2
+6: prefetch IT1
+7: prefetch IT0
 EndTable
 
 GrpTable: Grp17
-- 
2.34.1


