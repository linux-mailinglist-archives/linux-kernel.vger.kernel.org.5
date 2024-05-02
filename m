Return-Path: <linux-kernel+bounces-166357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904FE8B9987
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38511C20E19
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D606604C8;
	Thu,  2 May 2024 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YylKf3Ma"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDCA54BCF;
	Thu,  2 May 2024 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647558; cv=none; b=BT4OJH8V4/gr148D2zRLatDwxv522QUcv5lvBbWcC+WH5PvIZe9BhTAa8HCcbjH5qkvQBy4yNHaq5ltnQ7iTcpFaZZDVG8LcbFR1FSk1xLrNa8jqRCCAyY3igTrLJLJSxce6Pn00AKjVOYv2v3Cn+HXRbo+6ifNBiZLGxXKUh0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647558; c=relaxed/simple;
	bh=Y5YX9kg+ODGEoBN60bkL/He4nPO4DwUsWL3sBMIgIQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AE7jqPaSqyN8QCKpaTAK92610y2y93RYl4PtrDz9vOhP8oh0Ihm6YDIIXLU7kd6HtXdjbE4exAN9enc/LuoCwASrUqJicBYVtr56Pyx+6h1ooyYtotEqhzRAM9kvxPA4qKTTmrzsZbi/URdbU3ZAZoU7Du2Venqx35pH25uF7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YylKf3Ma; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714647557; x=1746183557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y5YX9kg+ODGEoBN60bkL/He4nPO4DwUsWL3sBMIgIQ8=;
  b=YylKf3Manl4mv3Zjx+XQBjXhoh+/jfCeE3zGQHR7pAhY44MKRIf6ipw/
   IEaWnXHCxPOChPgdazjdrzvD7wzVzVs5ZOxo2jkwXfq7VNWvb1E3HrnCJ
   uEAhly1XqQnV6DVFE1IfjoNCEIb8+UPxlHps6uxnFs0gbUcPHEk1P9OmZ
   dcUZKU0iZ33nJa7M9so9aFNSdOoNriNCcD5hyw0PNsVinqrwgZyWJ2pkh
   p4U4aLMdJDCzSzEBNhfu2v/NC6m0iNYZIUekUbmp0eq9diuT3j0lqcSr5
   hJ1ulMppTi7T8S+7wraRtFT3oNg2EC0jcCvbTpWyuJvW1PLvOHQTUS8P9
   g==;
X-CSE-ConnectionGUID: LXMe54JJQVWYqii7EGrvPg==
X-CSE-MsgGUID: 8AnAb2CqRiGwwRwBGp6Rtg==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="14228558"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="14228558"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:59:16 -0700
X-CSE-ConnectionGUID: u7ce1+ubTFqyGopPfYt/pA==
X-CSE-MsgGUID: vvoLsr5cS9uqc6tHscOMBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="50278870"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.208.210])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:59:11 -0700
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
Subject: [PATCH 01/10] x86/insn: Add Key Locker instructions to the opcode map
Date: Thu,  2 May 2024 13:58:44 +0300
Message-Id: <20240502105853.5338-2-adrian.hunter@intel.com>
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

From: "Chang S. Bae" <chang.seok.bae@intel.com>

The x86 instruction decoder needs to know these new instructions that
are going to be used in the crypto library as well as the x86 core
code. Add the following:

LOADIWKEY:
	Load a CPU-internal wrapping key.

ENCODEKEY128:
	Wrap a 128-bit AES key to a key handle.

ENCODEKEY256:
	Wrap a 256-bit AES key to a key handle.

AESENC128KL:
	Encrypt a 128-bit block of data using a 128-bit AES key
	indicated by a key handle.

AESENC256KL:
	Encrypt a 128-bit block of data using a 256-bit AES key
	indicated by a key handle.

AESDEC128KL:
	Decrypt a 128-bit block of data using a 128-bit AES key
	indicated by a key handle.

AESDEC256KL:
	Decrypt a 128-bit block of data using a 256-bit AES key
	indicated by a key handle.

AESENCWIDE128KL:
	Encrypt 8 128-bit blocks of data using a 128-bit AES key
	indicated by a key handle.

AESENCWIDE256KL:
	Encrypt 8 128-bit blocks of data using a 256-bit AES key
	indicated by a key handle.

AESDECWIDE128KL:
	Decrypt 8 128-bit blocks of data using a 128-bit AES key
	indicated by a key handle.

AESDECWIDE256KL:
	Decrypt 8 128-bit blocks of data using a 256-bit AES key
	indicated by a key handle.

The detail can be found in Intel Software Developer Manual.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/lib/x86-opcode-map.txt       | 11 +++++++----
 tools/arch/x86/lib/x86-opcode-map.txt | 11 +++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 12af572201a2..c94988d5130d 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -800,11 +800,12 @@ cb: sha256rnds2 Vdq,Wdq | vrcp28ss/d Vx,Hx,Wx (66),(ev)
 cc: sha256msg1 Vdq,Wdq | vrsqrt28ps/d Vx,Wx (66),(ev)
 cd: sha256msg2 Vdq,Wdq | vrsqrt28ss/d Vx,Hx,Wx (66),(ev)
 cf: vgf2p8mulb Vx,Wx (66)
+d8: AESENCWIDE128KL Qpi (F3),(000),(00B) | AESENCWIDE256KL Qpi (F3),(000),(10B) | AESDECWIDE128KL Qpi (F3),(000),(01B) | AESDECWIDE256KL Qpi (F3),(000),(11B)
 db: VAESIMC Vdq,Wdq (66),(v1)
-dc: vaesenc Vx,Hx,Wx (66)
-dd: vaesenclast Vx,Hx,Wx (66)
-de: vaesdec Vx,Hx,Wx (66)
-df: vaesdeclast Vx,Hx,Wx (66)
+dc: vaesenc Vx,Hx,Wx (66) | LOADIWKEY Vx,Hx (F3) | AESENC128KL Vpd,Qpi (F3)
+dd: vaesenclast Vx,Hx,Wx (66) | AESDEC128KL Vpd,Qpi (F3)
+de: vaesdec Vx,Hx,Wx (66) | AESENC256KL Vpd,Qpi (F3)
+df: vaesdeclast Vx,Hx,Wx (66) | AESDEC256KL Vpd,Qpi (F3)
 f0: MOVBE Gy,My | MOVBE Gw,Mw (66) | CRC32 Gd,Eb (F2) | CRC32 Gd,Eb (66&F2)
 f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
 f2: ANDN Gy,By,Ey (v)
@@ -814,6 +815,8 @@ f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v) | WRSSD/Q My,
 f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
 f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3)
 f9: MOVDIRI My,Gy
+fa: ENCODEKEY128 Ew,Ew (F3)
+fb: ENCODEKEY256 Ew,Ew (F3)
 EndTable
 
 Table: 3-byte opcode 2 (0x0f 0x3a)
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index 12af572201a2..c94988d5130d 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -800,11 +800,12 @@ cb: sha256rnds2 Vdq,Wdq | vrcp28ss/d Vx,Hx,Wx (66),(ev)
 cc: sha256msg1 Vdq,Wdq | vrsqrt28ps/d Vx,Wx (66),(ev)
 cd: sha256msg2 Vdq,Wdq | vrsqrt28ss/d Vx,Hx,Wx (66),(ev)
 cf: vgf2p8mulb Vx,Wx (66)
+d8: AESENCWIDE128KL Qpi (F3),(000),(00B) | AESENCWIDE256KL Qpi (F3),(000),(10B) | AESDECWIDE128KL Qpi (F3),(000),(01B) | AESDECWIDE256KL Qpi (F3),(000),(11B)
 db: VAESIMC Vdq,Wdq (66),(v1)
-dc: vaesenc Vx,Hx,Wx (66)
-dd: vaesenclast Vx,Hx,Wx (66)
-de: vaesdec Vx,Hx,Wx (66)
-df: vaesdeclast Vx,Hx,Wx (66)
+dc: vaesenc Vx,Hx,Wx (66) | LOADIWKEY Vx,Hx (F3) | AESENC128KL Vpd,Qpi (F3)
+dd: vaesenclast Vx,Hx,Wx (66) | AESDEC128KL Vpd,Qpi (F3)
+de: vaesdec Vx,Hx,Wx (66) | AESENC256KL Vpd,Qpi (F3)
+df: vaesdeclast Vx,Hx,Wx (66) | AESDEC256KL Vpd,Qpi (F3)
 f0: MOVBE Gy,My | MOVBE Gw,Mw (66) | CRC32 Gd,Eb (F2) | CRC32 Gd,Eb (66&F2)
 f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
 f2: ANDN Gy,By,Ey (v)
@@ -814,6 +815,8 @@ f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v) | WRSSD/Q My,
 f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
 f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3)
 f9: MOVDIRI My,Gy
+fa: ENCODEKEY128 Ew,Ew (F3)
+fb: ENCODEKEY256 Ew,Ew (F3)
 EndTable
 
 Table: 3-byte opcode 2 (0x0f 0x3a)
-- 
2.34.1


