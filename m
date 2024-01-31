Return-Path: <linux-kernel+bounces-47143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005728449CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919261F22CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4F046B9A;
	Wed, 31 Jan 2024 21:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ZrbO2EI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p/j1RQ3k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54813405FD;
	Wed, 31 Jan 2024 21:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735699; cv=none; b=owiV1w1Ph4XGsbrSwXcbPRCqZmab6NcXeQG0vWKxFK+TxJyxRM5lU8INY/Tip2OlhxITW7nAj/wWWGPm/OgrJfdGR4YKeE+nVJdXlEOQa0/iPwdSEDDFqIRLfoasTFGAralqkVy+VpREqEBO7brK9sd6x3xt3snMykLhM6kky/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735699; c=relaxed/simple;
	bh=9UqoNK4p1Eo6Br4W3h2CRkFwwf5VUKevNgEvCipUAws=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g2LssqklmvX+qjwRL5hSkoKIUyiQhGtq2c9LbnT2LR9oHNVcNbAEqlHH5y8a+9/BEsz2qnGnNM3Na4p2otP2uLrEsgKac6JzGzqG1x7uHxJkp96mS/NU3WswJFOxZXcwtj2LwJgjgQt4aUjaeDm4Rb+H+hJxqex6AY0/MA8uSDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ZrbO2EI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p/j1RQ3k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 21:14:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706735695;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CfsmkT4d9hzracoL/83eHyanX0UlSoWucI+dcAL15o=;
	b=2ZrbO2EIWSjQelMIf3dnUIgGJy1BT/WvU9XvxRBWCOyWG386H9nFWxL+BMolQAVnzfVIlc
	ov/IEkS4nYKpIfVfZRzG6odP0NvP9CW9He9aavprrazDm5IhpX15DSceISS5KBFYTTMhjS
	6/L13EcSMVLbq/mKcc1RZokiLsk9c+6ZoALbsk1efqFehUYwiatQ6HE7urW8O5Dx571WUA
	SS8VYoaew6RJEcV5yij9uoF00b1geho4dJ26/0nBML6aRZbcxUI8+HFGQwFAM7pB2YoFoj
	FVMO4lqFt12TQX3VU8JB6QH1vnmCYHP/l5l3lnqPQbTxvcG2cD7iHsOJ9bl1UQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706735695;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CfsmkT4d9hzracoL/83eHyanX0UlSoWucI+dcAL15o=;
	b=p/j1RQ3kdfpp+oxjuuBhhpuPY0H4UnOHK4tPbyCU645FtIDZGmisdMIGSXLmxE37J5xPPi
	h8AThWY/b1RR7eCw==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fred] x86/opcode: Add ERET[US] instructions to the x86 opcode map
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shan Kang <shan.kang@intel.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-10-xin3.li@intel.com>
References: <20231205105030.8698-10-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170673569473.398.4159947286110047892.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     0115f8b1a26ef49338cdb0bd98ad374b8586d0fd
Gitweb:        https://git.kernel.org/tip/0115f8b1a26ef49338cdb0bd98ad374b8586d0fd
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:49:58 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Jan 2024 22:00:18 +01:00

x86/opcode: Add ERET[US] instructions to the x86 opcode map

ERETU returns from an event handler while making a transition to ring 3,
and ERETS returns from an event handler while staying in ring 0.

Add instruction opcodes used by ERET[US] to the x86 opcode map; opcode
numbers are per FRED spec v5.0.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20231205105030.8698-10-xin3.li@intel.com
---
 arch/x86/lib/x86-opcode-map.txt       | 2 +-
 tools/arch/x86/lib/x86-opcode-map.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 1efe1d9..12af572 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -1052,7 +1052,7 @@ EndTable
 
 GrpTable: Grp7
 0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B) | WRMSRNS (110),(11B)
-1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B)
+1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B) | ERETU (F3),(010),(11B) | ERETS (F2),(010),(11B)
 2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
 3: LIDT Ms
 4: SMSW Mw/Rv
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index 1efe1d9..12af572 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -1052,7 +1052,7 @@ EndTable
 
 GrpTable: Grp7
 0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B) | WRMSRNS (110),(11B)
-1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B)
+1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B) | ERETU (F3),(010),(11B) | ERETS (F2),(010),(11B)
 2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
 3: LIDT Ms
 4: SMSW Mw/Rv

