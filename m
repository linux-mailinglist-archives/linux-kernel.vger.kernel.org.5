Return-Path: <linux-kernel+bounces-166392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586338B9A00
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD7E1C204DB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E807A7580A;
	Thu,  2 May 2024 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FHcwcq2b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QbxzdTk2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAC86217D;
	Thu,  2 May 2024 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714649176; cv=none; b=SM2SgS3unQNwA2jUx1INIDqkw9tbmkUHz4ycZBbVedMDOMowPQALIq95LQmq6tJDCr3OaM+bX1y4O1NQyprhlU7EbMnayw1mfEO93Bfn7XTE2VUhHPUjqs90+DmyVmtpMITH59LSdjL/MEl39mvF0hR3JRDJXFqKdhiRO5PEeRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714649176; c=relaxed/simple;
	bh=qxxfRLtdK350YmmRHNaDyLqC4+L8Z2uSdrMi9vsYzco=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=amNXkY1CsnO/e4FxV4XfvfM+WYL00Rc8gvSoV3Oblsz/+ZnM/Q4l3hnNg2m8xJfEQv3wv6cpVrd3iN2eHOODRceHdJazz3TLGh0N9H10S+KysotcG8QEDXkPakkje6wRnbHjfXE540E3KzO+p1V7yYsR8wd6IjGf1XuUsc4Z4yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FHcwcq2b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QbxzdTk2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 02 May 2024 11:26:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714649173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3aTZZU5/cT4g4PBMeMl7jGbRN/Txr9TxLFSY6Ty+PU=;
	b=FHcwcq2bXoPl3IVAVwwysP1Rp4qwnFXKvORQkagFrsySxzxc1IUeCtY5ioHe/vzsFRxshj
	ayK8OHFYhFBYz0VmMF6lRs6+cczMaWHHnWaxmteKKX/JQ4fbbtKRjiYzHT33iBlkhXTWyx
	cXyYFc0roP1oxnp04XGx3mQXWx1ThU96TqtQgG6Q5MJIzdYTDNcBdiL8QUNb18BOT/iLUF
	EirYA6wzGZtPq796hxm1jdeidwy9PrpjRl6Ej96nFOD8P7VJH0H11OEITBT91mOyZJWxFu
	k8yc5ar6rz8mHTNAVOqrYuBXToxyD+JJfnS/NgUSP72jJYOYEJwvxFC6UuZ+dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714649173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3aTZZU5/cT4g4PBMeMl7jGbRN/Txr9TxLFSY6Ty+PU=;
	b=QbxzdTk2mTnIo9cRmmgzaEIoOtlp7FxeNN/hWiKBoHPwcjxEiuaWHFkQO0WvgN3J0GAubS
	W/5DIKA4VBlo0ODg==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/insn: Add misc new Intel instructions
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240502105853.5338-5-adrian.hunter@intel.com>
References: <20240502105853.5338-5-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171464917275.10875.4280124834639186610.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9dd3612895de3d967ebd607423571bd6b0854ccc
Gitweb:        https://git.kernel.org/tip/9dd3612895de3d967ebd607423571bd6b0854ccc
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Thu, 02 May 2024 13:58:47 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 02 May 2024 13:13:43 +02:00

x86/insn: Add misc new Intel instructions

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240502105853.5338-5-adrian.hunter@intel.com
---
 arch/x86/lib/x86-opcode-map.txt       | 57 ++++++++++++++++++++------
 tools/arch/x86/lib/x86-opcode-map.txt | 57 ++++++++++++++++++++------
 2 files changed, 90 insertions(+), 24 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 24941b9..4e9f535 100644
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
index 24941b9..4e9f535 100644
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

