Return-Path: <linux-kernel+bounces-166390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A8D8B99FD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DDF1F21569
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902276A8AC;
	Thu,  2 May 2024 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0jc0pwHj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BbEuJrjL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F75604C8;
	Thu,  2 May 2024 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714649176; cv=none; b=CsOVmBlDMDTV/2kLDvu67LiUUE3g4PIcmvK4FiF4K7iwjDftZ8GjgJJkHsaLM8Agt2EBSj6zlMifn99nQQdb/SZGCER75mnPmUn19yQBEbheRv2kqzJUC3HnOAzlFttWgpvg/AbTznbBnuz9QJjQoFMU0bI56o8LysoOJ12lPpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714649176; c=relaxed/simple;
	bh=byDbO1GGy45RU5AgUCvh5G+Sftd7hly3RcndRKNWrA4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pyfpmRuzQIAwnhzxJWQfttK2P5mSaXH4Pa4tn9OtzSKbdwLJypuwWRNvDN5a7VcsKxZQf0o7PwCIZ/wO8hvTKMOTKnSmTlb6a+SaKjasN/0Yy6cJgWZPGdFTexZx/e9f8KIN9Lj0WHxjt/9vJZkHbpYhIPrTbrSScLwA64/7PGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0jc0pwHj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BbEuJrjL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 02 May 2024 11:26:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714649172;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KrmiZthoFSDlaA0G0Cgrt4krGHIhV/l7pAo87Ld38sk=;
	b=0jc0pwHjnwaelx+mHSExdnwxQ1QlSCLnwfkk31AJG92GKh44WmlaHqhN2iTy19nVNilfK5
	wmB9qNHUDkU/cVhEGWjXmcYF8czn/1BWDjOOikpwU8UKEHYjTizqGM82aGObtFCqEKoiYE
	Exk0Tc+G84xDOOReVUIxW8oMXKVAqSnkOqSj9O0TcxBfoSbaCIjPcUNwNMqVBK+1BGSEj9
	Xrkqzpym/6qEpCAxSy3zPXLK7JlVx5TkCXxG7oELhHHP2BP69f84Xp6g8ZvHtQ4d7BMKYe
	fyRsUj2gITMJJxNwAoi6zfWbIEExdz4FAh4ZAo94S23z7IGlh1dCC8KssvARMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714649172;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KrmiZthoFSDlaA0G0Cgrt4krGHIhV/l7pAo87Ld38sk=;
	b=BbEuJrjL+yZFKuziJuWo3qop5WMmBWruDY1nvgXBggygFze3zHCawt0uWDkFRMTw7/VOQR
	V2F8fInZDK7QcnCw==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/insn: Add support for APX EVEX instructions to
 the opcode map
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240502105853.5338-9-adrian.hunter@intel.com>
References: <20240502105853.5338-9-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171464917184.10875.2417762161530362294.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     690ca3a3067f760bef92ca5db1c42490498ab5de
Gitweb:        https://git.kernel.org/tip/690ca3a3067f760bef92ca5db1c42490498ab5de
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Thu, 02 May 2024 13:58:51 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 02 May 2024 13:13:46 +02:00

x86/insn: Add support for APX EVEX instructions to the opcode map

To support APX functionality, the EVEX prefix is used to:

 - promote legacy instructions
 - promote VEX instructions
 - add new instructions

Promoted VEX instructions require no extra annotation because the opcodes
do not change and the permissive nature of the instruction decoder already
allows them to have an EVEX prefix.

Promoted legacy instructions and new instructions are placed in map 4 which
has not been used before.

Create a new table for map 4 and add APX instructions.

Annotate SCALABLE instructions with "(es)" - refer to patch "x86/insn: Add
support for APX EVEX to the instruction decoder logic". SCALABLE
instructions must be represented in both no-prefix (NP) and 66 prefix
forms.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240502105853.5338-9-adrian.hunter@intel.com
---
 arch/x86/lib/x86-opcode-map.txt       | 93 ++++++++++++++++++++++++++-
 tools/arch/x86/lib/x86-opcode-map.txt | 93 ++++++++++++++++++++++++++-
 2 files changed, 186 insertions(+)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 240ef71..caedb3e 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -23,6 +23,7 @@
 #
 # AVX Superscripts
 #  (ev): this opcode requires EVEX prefix.
+#  (es): this opcode requires EVEX prefix and is SCALABALE.
 #  (evo): this opcode is changed by EVEX prefix (EVEX opcode)
 #  (v): this opcode requires VEX prefix.
 #  (v1): this opcode only supports 128bit VEX.
@@ -929,6 +930,98 @@ df: VAESKEYGEN Vdq,Wdq,Ib (66),(v1)
 f0: RORX Gy,Ey,Ib (F2),(v) | HRESET Gv,Ib (F3),(000),(11B)
 EndTable
 
+Table: EVEX map 4
+Referrer:
+AVXcode: 4
+00: ADD Eb,Gb (ev)
+01: ADD Ev,Gv (es) | ADD Ev,Gv (66),(es)
+02: ADD Gb,Eb (ev)
+03: ADD Gv,Ev (es) | ADD Gv,Ev (66),(es)
+08: OR Eb,Gb (ev)
+09: OR Ev,Gv (es) | OR Ev,Gv (66),(es)
+0a: OR Gb,Eb (ev)
+0b: OR Gv,Ev (es) | OR Gv,Ev (66),(es)
+10: ADC Eb,Gb (ev)
+11: ADC Ev,Gv (es) | ADC Ev,Gv (66),(es)
+12: ADC Gb,Eb (ev)
+13: ADC Gv,Ev (es) | ADC Gv,Ev (66),(es)
+18: SBB Eb,Gb (ev)
+19: SBB Ev,Gv (es) | SBB Ev,Gv (66),(es)
+1a: SBB Gb,Eb (ev)
+1b: SBB Gv,Ev (es) | SBB Gv,Ev (66),(es)
+20: AND Eb,Gb (ev)
+21: AND Ev,Gv (es) | AND Ev,Gv (66),(es)
+22: AND Gb,Eb (ev)
+23: AND Gv,Ev (es) | AND Gv,Ev (66),(es)
+24: SHLD Ev,Gv,Ib (es) | SHLD Ev,Gv,Ib (66),(es)
+28: SUB Eb,Gb (ev)
+29: SUB Ev,Gv (es) | SUB Ev,Gv (66),(es)
+2a: SUB Gb,Eb (ev)
+2b: SUB Gv,Ev (es) | SUB Gv,Ev (66),(es)
+2c: SHRD Ev,Gv,Ib (es) | SHRD Ev,Gv,Ib (66),(es)
+30: XOR Eb,Gb (ev)
+31: XOR Ev,Gv (es) | XOR Ev,Gv (66),(es)
+32: XOR Gb,Eb (ev)
+33: XOR Gv,Ev (es) | XOR Gv,Ev (66),(es)
+# CCMPSCC instructions are: CCOMB, CCOMBE, CCOMF, CCOML, CCOMLE, CCOMNB, CCOMNBE, CCOMNL, CCOMNLE,
+#			    CCOMNO, CCOMNS, CCOMNZ, CCOMO, CCOMS, CCOMT, CCOMZ
+38: CCMPSCC Eb,Gb (ev)
+39: CCMPSCC Ev,Gv (es) | CCMPSCC Ev,Gv (66),(es)
+3a: CCMPSCC Gv,Ev (ev)
+3b: CCMPSCC Gv,Ev (es) | CCMPSCC Gv,Ev (66),(es)
+40: CMOVO   Gv,Ev (es) | CMOVO   Gv,Ev (66),(es) | CFCMOVO   Ev,Ev (es) | CFCMOVO   Ev,Ev (66),(es) | SETO   Eb (F2),(ev)
+41: CMOVNO  Gv,Ev (es) | CMOVNO  Gv,Ev (66),(es) | CFCMOVNO  Ev,Ev (es) | CFCMOVNO  Ev,Ev (66),(es) | SETNO  Eb (F2),(ev)
+42: CMOVB   Gv,Ev (es) | CMOVB   Gv,Ev (66),(es) | CFCMOVB   Ev,Ev (es) | CFCMOVB   Ev,Ev (66),(es) | SETB   Eb (F2),(ev)
+43: CMOVNB  Gv,Ev (es) | CMOVNB  Gv,Ev (66),(es) | CFCMOVNB  Ev,Ev (es) | CFCMOVNB  Ev,Ev (66),(es) | SETNB  Eb (F2),(ev)
+44: CMOVZ   Gv,Ev (es) | CMOVZ   Gv,Ev (66),(es) | CFCMOVZ   Ev,Ev (es) | CFCMOVZ   Ev,Ev (66),(es) | SETZ   Eb (F2),(ev)
+45: CMOVNZ  Gv,Ev (es) | CMOVNZ  Gv,Ev (66),(es) | CFCMOVNZ  Ev,Ev (es) | CFCMOVNZ  Ev,Ev (66),(es) | SETNZ  Eb (F2),(ev)
+46: CMOVBE  Gv,Ev (es) | CMOVBE  Gv,Ev (66),(es) | CFCMOVBE  Ev,Ev (es) | CFCMOVBE  Ev,Ev (66),(es) | SETBE  Eb (F2),(ev)
+47: CMOVNBE Gv,Ev (es) | CMOVNBE Gv,Ev (66),(es) | CFCMOVNBE Ev,Ev (es) | CFCMOVNBE Ev,Ev (66),(es) | SETNBE Eb (F2),(ev)
+48: CMOVS   Gv,Ev (es) | CMOVS   Gv,Ev (66),(es) | CFCMOVS   Ev,Ev (es) | CFCMOVS   Ev,Ev (66),(es) | SETS   Eb (F2),(ev)
+49: CMOVNS  Gv,Ev (es) | CMOVNS  Gv,Ev (66),(es) | CFCMOVNS  Ev,Ev (es) | CFCMOVNS  Ev,Ev (66),(es) | SETNS  Eb (F2),(ev)
+4a: CMOVP   Gv,Ev (es) | CMOVP   Gv,Ev (66),(es) | CFCMOVP   Ev,Ev (es) | CFCMOVP   Ev,Ev (66),(es) | SETP   Eb (F2),(ev)
+4b: CMOVNP  Gv,Ev (es) | CMOVNP  Gv,Ev (66),(es) | CFCMOVNP  Ev,Ev (es) | CFCMOVNP  Ev,Ev (66),(es) | SETNP  Eb (F2),(ev)
+4c: CMOVL   Gv,Ev (es) | CMOVL   Gv,Ev (66),(es) | CFCMOVL   Ev,Ev (es) | CFCMOVL   Ev,Ev (66),(es) | SETL   Eb (F2),(ev)
+4d: CMOVNL  Gv,Ev (es) | CMOVNL  Gv,Ev (66),(es) | CFCMOVNL  Ev,Ev (es) | CFCMOVNL  Ev,Ev (66),(es) | SETNL  Eb (F2),(ev)
+4e: CMOVLE  Gv,Ev (es) | CMOVLE  Gv,Ev (66),(es) | CFCMOVLE  Ev,Ev (es) | CFCMOVLE  Ev,Ev (66),(es) | SETLE  Eb (F2),(ev)
+4f: CMOVNLE Gv,Ev (es) | CMOVNLE Gv,Ev (66),(es) | CFCMOVNLE Ev,Ev (es) | CFCMOVNLE Ev,Ev (66),(es) | SETNLE Eb (F2),(ev)
+60: MOVBE Gv,Ev (es) | MOVBE Gv,Ev (66),(es)
+61: MOVBE Ev,Gv (es) | MOVBE Ev,Gv (66),(es)
+65: WRUSSD Md,Gd (66),(ev) | WRUSSQ Mq,Gq (66),(ev)
+66: ADCX Gy,Ey (66),(ev) | ADOX Gy,Ey (F3),(ev) | WRSSD Md,Gd (ev) | WRSSQ Mq,Gq (66),(ev)
+69: IMUL Gv,Ev,Iz (es) | IMUL Gv,Ev,Iz (66),(es)
+6b: IMUL Gv,Ev,Ib (es) | IMUL Gv,Ev,Ib (66),(es)
+80: Grp1 Eb,Ib (1A),(ev)
+81: Grp1 Ev,Iz (1A),(es)
+83: Grp1 Ev,Ib (1A),(es)
+# CTESTSCC instructions are: CTESTB, CTESTBE, CTESTF, CTESTL, CTESTLE, CTESTNB, CTESTNBE, CTESTNL,
+#			     CTESTNLE, CTESTNO, CTESTNS, CTESTNZ, CTESTO, CTESTS, CTESTT, CTESTZ
+84: CTESTSCC (ev)
+85: CTESTSCC (es) | CTESTSCC (66),(es)
+88: POPCNT Gv,Ev (es) | POPCNT Gv,Ev (66),(es)
+8f: POP2 Bq,Rq (000),(11B),(ev)
+a5: SHLD Ev,Gv,CL (es) | SHLD Ev,Gv,CL (66),(es)
+ad: SHRD Ev,Gv,CL (es) | SHRD Ev,Gv,CL (66),(es)
+af: IMUL Gv,Ev (es) | IMUL Gv,Ev (66),(es)
+c0: Grp2 Eb,Ib (1A),(ev)
+c1: Grp2 Ev,Ib (1A),(es)
+d0: Grp2 Eb,1 (1A),(ev)
+d1: Grp2 Ev,1 (1A),(es)
+d2: Grp2 Eb,CL (1A),(ev)
+d3: Grp2 Ev,CL (1A),(es)
+f0: CRC32 Gy,Eb (es) | INVEPT Gq,Mdq (F3),(ev)
+f1: CRC32 Gy,Ey (es) | CRC32 Gy,Ey (66),(es) | INVVPID Gy,Mdq (F3),(ev)
+f2: INVPCID Gy,Mdq (F3),(ev)
+f4: TZCNT Gv,Ev (es) | TZCNT Gv,Ev (66),(es)
+f5: LZCNT Gv,Ev (es) | LZCNT Gv,Ev (66),(es)
+f6: Grp3_1 Eb (1A),(ev)
+f7: Grp3_2 Ev (1A),(es)
+f8: MOVDIR64B Gv,Mdqq (66),(ev) | ENQCMD Gv,Mdqq (F2),(ev) | ENQCMDS Gv,Mdqq (F3),(ev) | URDMSR Rq,Gq (F2),(11B),(ev) | UWRMSR Gq,Rq (F3),(11B),(ev)
+f9: MOVDIRI My,Gy (ev)
+fe: Grp4 (1A),(ev)
+ff: Grp5 (1A),(es) | PUSH2 Bq,Rq (110),(11B),(ev)
+EndTable
+
 Table: EVEX map 5
 Referrer:
 AVXcode: 5
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index 240ef71..caedb3e 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -23,6 +23,7 @@
 #
 # AVX Superscripts
 #  (ev): this opcode requires EVEX prefix.
+#  (es): this opcode requires EVEX prefix and is SCALABALE.
 #  (evo): this opcode is changed by EVEX prefix (EVEX opcode)
 #  (v): this opcode requires VEX prefix.
 #  (v1): this opcode only supports 128bit VEX.
@@ -929,6 +930,98 @@ df: VAESKEYGEN Vdq,Wdq,Ib (66),(v1)
 f0: RORX Gy,Ey,Ib (F2),(v) | HRESET Gv,Ib (F3),(000),(11B)
 EndTable
 
+Table: EVEX map 4
+Referrer:
+AVXcode: 4
+00: ADD Eb,Gb (ev)
+01: ADD Ev,Gv (es) | ADD Ev,Gv (66),(es)
+02: ADD Gb,Eb (ev)
+03: ADD Gv,Ev (es) | ADD Gv,Ev (66),(es)
+08: OR Eb,Gb (ev)
+09: OR Ev,Gv (es) | OR Ev,Gv (66),(es)
+0a: OR Gb,Eb (ev)
+0b: OR Gv,Ev (es) | OR Gv,Ev (66),(es)
+10: ADC Eb,Gb (ev)
+11: ADC Ev,Gv (es) | ADC Ev,Gv (66),(es)
+12: ADC Gb,Eb (ev)
+13: ADC Gv,Ev (es) | ADC Gv,Ev (66),(es)
+18: SBB Eb,Gb (ev)
+19: SBB Ev,Gv (es) | SBB Ev,Gv (66),(es)
+1a: SBB Gb,Eb (ev)
+1b: SBB Gv,Ev (es) | SBB Gv,Ev (66),(es)
+20: AND Eb,Gb (ev)
+21: AND Ev,Gv (es) | AND Ev,Gv (66),(es)
+22: AND Gb,Eb (ev)
+23: AND Gv,Ev (es) | AND Gv,Ev (66),(es)
+24: SHLD Ev,Gv,Ib (es) | SHLD Ev,Gv,Ib (66),(es)
+28: SUB Eb,Gb (ev)
+29: SUB Ev,Gv (es) | SUB Ev,Gv (66),(es)
+2a: SUB Gb,Eb (ev)
+2b: SUB Gv,Ev (es) | SUB Gv,Ev (66),(es)
+2c: SHRD Ev,Gv,Ib (es) | SHRD Ev,Gv,Ib (66),(es)
+30: XOR Eb,Gb (ev)
+31: XOR Ev,Gv (es) | XOR Ev,Gv (66),(es)
+32: XOR Gb,Eb (ev)
+33: XOR Gv,Ev (es) | XOR Gv,Ev (66),(es)
+# CCMPSCC instructions are: CCOMB, CCOMBE, CCOMF, CCOML, CCOMLE, CCOMNB, CCOMNBE, CCOMNL, CCOMNLE,
+#			    CCOMNO, CCOMNS, CCOMNZ, CCOMO, CCOMS, CCOMT, CCOMZ
+38: CCMPSCC Eb,Gb (ev)
+39: CCMPSCC Ev,Gv (es) | CCMPSCC Ev,Gv (66),(es)
+3a: CCMPSCC Gv,Ev (ev)
+3b: CCMPSCC Gv,Ev (es) | CCMPSCC Gv,Ev (66),(es)
+40: CMOVO   Gv,Ev (es) | CMOVO   Gv,Ev (66),(es) | CFCMOVO   Ev,Ev (es) | CFCMOVO   Ev,Ev (66),(es) | SETO   Eb (F2),(ev)
+41: CMOVNO  Gv,Ev (es) | CMOVNO  Gv,Ev (66),(es) | CFCMOVNO  Ev,Ev (es) | CFCMOVNO  Ev,Ev (66),(es) | SETNO  Eb (F2),(ev)
+42: CMOVB   Gv,Ev (es) | CMOVB   Gv,Ev (66),(es) | CFCMOVB   Ev,Ev (es) | CFCMOVB   Ev,Ev (66),(es) | SETB   Eb (F2),(ev)
+43: CMOVNB  Gv,Ev (es) | CMOVNB  Gv,Ev (66),(es) | CFCMOVNB  Ev,Ev (es) | CFCMOVNB  Ev,Ev (66),(es) | SETNB  Eb (F2),(ev)
+44: CMOVZ   Gv,Ev (es) | CMOVZ   Gv,Ev (66),(es) | CFCMOVZ   Ev,Ev (es) | CFCMOVZ   Ev,Ev (66),(es) | SETZ   Eb (F2),(ev)
+45: CMOVNZ  Gv,Ev (es) | CMOVNZ  Gv,Ev (66),(es) | CFCMOVNZ  Ev,Ev (es) | CFCMOVNZ  Ev,Ev (66),(es) | SETNZ  Eb (F2),(ev)
+46: CMOVBE  Gv,Ev (es) | CMOVBE  Gv,Ev (66),(es) | CFCMOVBE  Ev,Ev (es) | CFCMOVBE  Ev,Ev (66),(es) | SETBE  Eb (F2),(ev)
+47: CMOVNBE Gv,Ev (es) | CMOVNBE Gv,Ev (66),(es) | CFCMOVNBE Ev,Ev (es) | CFCMOVNBE Ev,Ev (66),(es) | SETNBE Eb (F2),(ev)
+48: CMOVS   Gv,Ev (es) | CMOVS   Gv,Ev (66),(es) | CFCMOVS   Ev,Ev (es) | CFCMOVS   Ev,Ev (66),(es) | SETS   Eb (F2),(ev)
+49: CMOVNS  Gv,Ev (es) | CMOVNS  Gv,Ev (66),(es) | CFCMOVNS  Ev,Ev (es) | CFCMOVNS  Ev,Ev (66),(es) | SETNS  Eb (F2),(ev)
+4a: CMOVP   Gv,Ev (es) | CMOVP   Gv,Ev (66),(es) | CFCMOVP   Ev,Ev (es) | CFCMOVP   Ev,Ev (66),(es) | SETP   Eb (F2),(ev)
+4b: CMOVNP  Gv,Ev (es) | CMOVNP  Gv,Ev (66),(es) | CFCMOVNP  Ev,Ev (es) | CFCMOVNP  Ev,Ev (66),(es) | SETNP  Eb (F2),(ev)
+4c: CMOVL   Gv,Ev (es) | CMOVL   Gv,Ev (66),(es) | CFCMOVL   Ev,Ev (es) | CFCMOVL   Ev,Ev (66),(es) | SETL   Eb (F2),(ev)
+4d: CMOVNL  Gv,Ev (es) | CMOVNL  Gv,Ev (66),(es) | CFCMOVNL  Ev,Ev (es) | CFCMOVNL  Ev,Ev (66),(es) | SETNL  Eb (F2),(ev)
+4e: CMOVLE  Gv,Ev (es) | CMOVLE  Gv,Ev (66),(es) | CFCMOVLE  Ev,Ev (es) | CFCMOVLE  Ev,Ev (66),(es) | SETLE  Eb (F2),(ev)
+4f: CMOVNLE Gv,Ev (es) | CMOVNLE Gv,Ev (66),(es) | CFCMOVNLE Ev,Ev (es) | CFCMOVNLE Ev,Ev (66),(es) | SETNLE Eb (F2),(ev)
+60: MOVBE Gv,Ev (es) | MOVBE Gv,Ev (66),(es)
+61: MOVBE Ev,Gv (es) | MOVBE Ev,Gv (66),(es)
+65: WRUSSD Md,Gd (66),(ev) | WRUSSQ Mq,Gq (66),(ev)
+66: ADCX Gy,Ey (66),(ev) | ADOX Gy,Ey (F3),(ev) | WRSSD Md,Gd (ev) | WRSSQ Mq,Gq (66),(ev)
+69: IMUL Gv,Ev,Iz (es) | IMUL Gv,Ev,Iz (66),(es)
+6b: IMUL Gv,Ev,Ib (es) | IMUL Gv,Ev,Ib (66),(es)
+80: Grp1 Eb,Ib (1A),(ev)
+81: Grp1 Ev,Iz (1A),(es)
+83: Grp1 Ev,Ib (1A),(es)
+# CTESTSCC instructions are: CTESTB, CTESTBE, CTESTF, CTESTL, CTESTLE, CTESTNB, CTESTNBE, CTESTNL,
+#			     CTESTNLE, CTESTNO, CTESTNS, CTESTNZ, CTESTO, CTESTS, CTESTT, CTESTZ
+84: CTESTSCC (ev)
+85: CTESTSCC (es) | CTESTSCC (66),(es)
+88: POPCNT Gv,Ev (es) | POPCNT Gv,Ev (66),(es)
+8f: POP2 Bq,Rq (000),(11B),(ev)
+a5: SHLD Ev,Gv,CL (es) | SHLD Ev,Gv,CL (66),(es)
+ad: SHRD Ev,Gv,CL (es) | SHRD Ev,Gv,CL (66),(es)
+af: IMUL Gv,Ev (es) | IMUL Gv,Ev (66),(es)
+c0: Grp2 Eb,Ib (1A),(ev)
+c1: Grp2 Ev,Ib (1A),(es)
+d0: Grp2 Eb,1 (1A),(ev)
+d1: Grp2 Ev,1 (1A),(es)
+d2: Grp2 Eb,CL (1A),(ev)
+d3: Grp2 Ev,CL (1A),(es)
+f0: CRC32 Gy,Eb (es) | INVEPT Gq,Mdq (F3),(ev)
+f1: CRC32 Gy,Ey (es) | CRC32 Gy,Ey (66),(es) | INVVPID Gy,Mdq (F3),(ev)
+f2: INVPCID Gy,Mdq (F3),(ev)
+f4: TZCNT Gv,Ev (es) | TZCNT Gv,Ev (66),(es)
+f5: LZCNT Gv,Ev (es) | LZCNT Gv,Ev (66),(es)
+f6: Grp3_1 Eb (1A),(ev)
+f7: Grp3_2 Ev (1A),(es)
+f8: MOVDIR64B Gv,Mdqq (66),(ev) | ENQCMD Gv,Mdqq (F2),(ev) | ENQCMDS Gv,Mdqq (F3),(ev) | URDMSR Rq,Gq (F2),(11B),(ev) | UWRMSR Gq,Rq (F3),(11B),(ev)
+f9: MOVDIRI My,Gy (ev)
+fe: Grp4 (1A),(ev)
+ff: Grp5 (1A),(es) | PUSH2 Bq,Rq (110),(11B),(ev)
+EndTable
+
 Table: EVEX map 5
 Referrer:
 AVXcode: 5

