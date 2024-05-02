Return-Path: <linux-kernel+bounces-166396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA30B8B9A07
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD15B1C21E48
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD5D83CCB;
	Thu,  2 May 2024 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nax2Iv5W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JZHNfCeU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971676CDCC;
	Thu,  2 May 2024 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714649179; cv=none; b=UMSliqSPFJqR88OozpkAs8HMO/R6OHLxImYqmvWzymFAXmupeezlRfWhHxpog/8smeR5QNtaeUC78g7mcqHaA3d7WmeBJrtiYLbKOAYStwtpX6NT2cnW/TCbdBZ7awrXLc1zFmiQ7OARZyPP6aosw2OS5WEmrjb5FhMaT8FsaQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714649179; c=relaxed/simple;
	bh=JW2zkSNbgHf1VXOQdioPvmmkc6+qswPswIdkjjp8c0g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RTmetDiE9oau9l9Qx4qwwahD0CW75zIrgYq2qCrqEt4u3D6Av7E9q2dzcYVELAqLIWya6lSauWOGCxYgl84iyRXhIdG8yyr3fuw4+Gro4w4umNMvR6qDyRO765v2zDkqtDFRtZWQvAJlZdxH5PEX7v/FTDI03EJaWWYljil4tIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nax2Iv5W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JZHNfCeU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 02 May 2024 11:26:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714649173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kz4s3r+jO7Rk2SAq7H7SG5vHxaNY9tvOJsZqI1saFgs=;
	b=Nax2Iv5WwSSrr4aFj27TLjOONFGeercpPHAqB26tCx1GpQ5kafSa28jFekIWahQYTHVqX8
	epoO3HPBZ6u2JhtMtNuuuvZN9So3eWVY+tcSIU569unBgmFZsc5P5z65Jca3swJYttpoa+
	TyUp2CG8Jhc1u6h9Yb6y9wKj19OWk5o2Qim/f6dwhomg367kRxMqwsF5PTeXai/AAA5w48
	it4eL+KCqalnbQK9bHu1N6C/ZeincFKfnMvyStWu8OXiGGPQwQIdoYWyyuP0xPgds9kr+H
	B/aS/cF/lGpbkwTH8HFqbjhcJdZjfWbKIypxeQL5/L/d9BQ6AVluDlY0LtULGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714649173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kz4s3r+jO7Rk2SAq7H7SG5vHxaNY9tvOJsZqI1saFgs=;
	b=JZHNfCeUdoriJoWFk2yIkamjVH/G5U9kRWHVbWdW17OjSUr5APhKJvgI+o2DlZ0DggeMNL
	9M4vUrEJe3LCS+Bg==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] x86/insn: Add Key Locker instructions to the opcode map
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240502105853.5338-2-adrian.hunter@intel.com>
References: <20240502105853.5338-2-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171464917332.10875.16504274959451249472.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a5dd673ab7d269e4a5b6565fc2b5c6295a079605
Gitweb:        https://git.kernel.org/tip/a5dd673ab7d269e4a5b6565fc2b5c6295a079605
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 02 May 2024 13:58:44 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 02 May 2024 13:13:41 +02:00

x86/insn: Add Key Locker instructions to the opcode map

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
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/r/20240502105853.5338-2-adrian.hunter@intel.com
---
 arch/x86/lib/x86-opcode-map.txt       | 11 +++++++----
 tools/arch/x86/lib/x86-opcode-map.txt | 11 +++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 12af572..c94988d 100644
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
index 12af572..c94988d 100644
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

