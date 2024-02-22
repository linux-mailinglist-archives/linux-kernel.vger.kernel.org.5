Return-Path: <linux-kernel+bounces-76411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E90F785F6F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1602D1C211D4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDAB46544;
	Thu, 22 Feb 2024 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="23gbb3FY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oQgyZtfU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE0222099;
	Thu, 22 Feb 2024 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601472; cv=none; b=emfVJPqLYPJP9lic2M3r7TcDPrX+uNY51+wmI6zlxEnaCqJsCgT7ssPcqdDAlf0ne9gfNlR9o0hdecFF4ol4LjeIM6uujHJaGLrhBo/mPSGUL4lUWvUoat3RTiDZOuqN74mFm4i1F3zsgh/EMePX6f+UtMqBSsasibLXJ2Qzuks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601472; c=relaxed/simple;
	bh=S5PpldvEfCWgMN5Vk/QEybamk2yANU02lkkVyahF9H8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V00gCegT7tY4Bu/7n41DMwm0DSJo098xagqMBnlfWLWr8UkyJyE6JWlF5pWMNYlJjGeKhNcQ1xXV7CL8a6Wu0P6J7Yxz6AVJSS0AnE6e1oee18HGsnsClagYa1v/CWXb4IXPRhHrXX0dYledwLvLy6iCNGTKcvI0wvgAE0vRqq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=23gbb3FY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oQgyZtfU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 11:31:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708601468;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gO8KPtxyUezMZfkFT2x7lO+VYm55SC6jTQTVdpKarbw=;
	b=23gbb3FY2Okqnwa51OCLMp98oNM7XaJs+67IUDxGI6bf3O69G2Iu4h0AUSPg/HI7z5OkJU
	Vp9/vkKa3E7prNauWU409vL+6uMptHXPTsOT82g3SzN+gqW8Sr/4a/QUSUm4Wo56vWPDGv
	WiJaCjMksOkBx8B6FVUG2rM6+Ll03btdjnWrZSO54DLUZ7DogsaBoIwv5zClArPrhL5e/k
	D84FVQ8KvZ0AdI621aHIijDShGOZG2ubkKH9+GVeh3FDTp06qAXiGnY0e8esVqM5Csvn3Z
	G5ElVWKCegntt6GjffSZ6TtU/r4sr7DfFxl2JoW1vSqvFoS3P9kLsQbzyuY4ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708601468;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gO8KPtxyUezMZfkFT2x7lO+VYm55SC6jTQTVdpKarbw=;
	b=oQgyZtfUY5PwFXMzbsxfGNbodNXTkiY+Gpj41D5g2n3VndHhP/2+Mb69eUAZQ5TjLCfT1A
	fG8A4747UahgtbBg==
From: "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/insn: Remove superfluous checks from instruction
 decoding routines
Cc: Nikolay Borisov <nik.borisov@suse.com>, Ingo Molnar <mingo@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240222111636.2214523-2-nik.borisov@suse.com>
References: <20240222111636.2214523-2-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170860146746.398.2924400958195588835.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     427e1646f1ef6c714a5bade30ca0302edc5d46a0
Gitweb:        https://git.kernel.org/tip/427e1646f1ef6c714a5bade30ca0302edc5d46a0
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Thu, 22 Feb 2024 13:16:35 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 22 Feb 2024 12:23:04 +01:00

x86/insn: Remove superfluous checks from instruction decoding routines

It's pointless checking if a particular part of an instruction is
decoded before calling the routine responsible for decoding it as this
check is duplicated in the routines itself. Streamline the code by
removing the superfluous checks. No functional difference.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240222111636.2214523-2-nik.borisov@suse.com
---
 arch/x86/lib/insn.c       | 56 ++++++++++++++------------------------
 tools/arch/x86/lib/insn.c | 56 ++++++++++++++------------------------
 2 files changed, 42 insertions(+), 70 deletions(-)

diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 55e371c..3946bdc 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -268,11 +268,9 @@ int insn_get_opcode(struct insn *insn)
 	if (opcode->got)
 		return 0;
 
-	if (!insn->prefixes.got) {
-		ret = insn_get_prefixes(insn);
-		if (ret)
-			return ret;
-	}
+	ret = insn_get_prefixes(insn);
+	if (ret)
+		return ret;
 
 	/* Get first opcode */
 	op = get_next(insn_byte_t, insn);
@@ -339,11 +337,9 @@ int insn_get_modrm(struct insn *insn)
 	if (modrm->got)
 		return 0;
 
-	if (!insn->opcode.got) {
-		ret = insn_get_opcode(insn);
-		if (ret)
-			return ret;
-	}
+	ret = insn_get_opcode(insn);
+	if (ret)
+		return ret;
 
 	if (inat_has_modrm(insn->attr)) {
 		mod = get_next(insn_byte_t, insn);
@@ -386,11 +382,9 @@ int insn_rip_relative(struct insn *insn)
 	if (!insn->x86_64)
 		return 0;
 
-	if (!modrm->got) {
-		ret = insn_get_modrm(insn);
-		if (ret)
-			return 0;
-	}
+	ret = insn_get_modrm(insn);
+	if (ret)
+		return 0;
 	/*
 	 * For rip-relative instructions, the mod field (top 2 bits)
 	 * is zero and the r/m field (bottom 3 bits) is 0x5.
@@ -417,11 +411,9 @@ int insn_get_sib(struct insn *insn)
 	if (insn->sib.got)
 		return 0;
 
-	if (!insn->modrm.got) {
-		ret = insn_get_modrm(insn);
-		if (ret)
-			return ret;
-	}
+	ret = insn_get_modrm(insn);
+	if (ret)
+		return ret;
 
 	if (insn->modrm.nbytes) {
 		modrm = insn->modrm.bytes[0];
@@ -460,11 +452,9 @@ int insn_get_displacement(struct insn *insn)
 	if (insn->displacement.got)
 		return 0;
 
-	if (!insn->sib.got) {
-		ret = insn_get_sib(insn);
-		if (ret)
-			return ret;
-	}
+	ret = insn_get_sib(insn);
+	if (ret)
+		return ret;
 
 	if (insn->modrm.nbytes) {
 		/*
@@ -628,11 +618,9 @@ int insn_get_immediate(struct insn *insn)
 	if (insn->immediate.got)
 		return 0;
 
-	if (!insn->displacement.got) {
-		ret = insn_get_displacement(insn);
-		if (ret)
-			return ret;
-	}
+	ret = insn_get_displacement(insn);
+	if (ret)
+		return ret;
 
 	if (inat_has_moffset(insn->attr)) {
 		if (!__get_moffset(insn))
@@ -703,11 +691,9 @@ int insn_get_length(struct insn *insn)
 	if (insn->length)
 		return 0;
 
-	if (!insn->immediate.got) {
-		ret = insn_get_immediate(insn);
-		if (ret)
-			return ret;
-	}
+	ret = insn_get_immediate(insn);
+	if (ret)
+		return ret;
 
 	insn->length = (unsigned char)((unsigned long)insn->next_byte
 				     - (unsigned long)insn->kaddr);
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 8fd63a0..5d81924 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -268,11 +268,9 @@ int insn_get_opcode(struct insn *insn)
 	if (opcode->got)
 		return 0;
 
-	if (!insn->prefixes.got) {
-		ret = insn_get_prefixes(insn);
-		if (ret)
-			return ret;
-	}
+	ret = insn_get_prefixes(insn);
+	if (ret)
+		return ret;
 
 	/* Get first opcode */
 	op = get_next(insn_byte_t, insn);
@@ -339,11 +337,9 @@ int insn_get_modrm(struct insn *insn)
 	if (modrm->got)
 		return 0;
 
-	if (!insn->opcode.got) {
-		ret = insn_get_opcode(insn);
-		if (ret)
-			return ret;
-	}
+	ret = insn_get_opcode(insn);
+	if (ret)
+		return ret;
 
 	if (inat_has_modrm(insn->attr)) {
 		mod = get_next(insn_byte_t, insn);
@@ -386,11 +382,9 @@ int insn_rip_relative(struct insn *insn)
 	if (!insn->x86_64)
 		return 0;
 
-	if (!modrm->got) {
-		ret = insn_get_modrm(insn);
-		if (ret)
-			return 0;
-	}
+	ret = insn_get_modrm(insn);
+	if (ret)
+		return 0;
 	/*
 	 * For rip-relative instructions, the mod field (top 2 bits)
 	 * is zero and the r/m field (bottom 3 bits) is 0x5.
@@ -417,11 +411,9 @@ int insn_get_sib(struct insn *insn)
 	if (insn->sib.got)
 		return 0;
 
-	if (!insn->modrm.got) {
-		ret = insn_get_modrm(insn);
-		if (ret)
-			return ret;
-	}
+	ret = insn_get_modrm(insn);
+	if (ret)
+		return ret;
 
 	if (insn->modrm.nbytes) {
 		modrm = insn->modrm.bytes[0];
@@ -460,11 +452,9 @@ int insn_get_displacement(struct insn *insn)
 	if (insn->displacement.got)
 		return 0;
 
-	if (!insn->sib.got) {
-		ret = insn_get_sib(insn);
-		if (ret)
-			return ret;
-	}
+	ret = insn_get_sib(insn);
+	if (ret)
+		return ret;
 
 	if (insn->modrm.nbytes) {
 		/*
@@ -628,11 +618,9 @@ int insn_get_immediate(struct insn *insn)
 	if (insn->immediate.got)
 		return 0;
 
-	if (!insn->displacement.got) {
-		ret = insn_get_displacement(insn);
-		if (ret)
-			return ret;
-	}
+	ret = insn_get_displacement(insn);
+	if (ret)
+		return ret;
 
 	if (inat_has_moffset(insn->attr)) {
 		if (!__get_moffset(insn))
@@ -703,11 +691,9 @@ int insn_get_length(struct insn *insn)
 	if (insn->length)
 		return 0;
 
-	if (!insn->immediate.got) {
-		ret = insn_get_immediate(insn);
-		if (ret)
-			return ret;
-	}
+	ret = insn_get_immediate(insn);
+	if (ret)
+		return ret;
 
 	insn->length = (unsigned char)((unsigned long)insn->next_byte
 				     - (unsigned long)insn->kaddr);

