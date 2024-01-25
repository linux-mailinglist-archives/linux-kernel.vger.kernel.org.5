Return-Path: <linux-kernel+bounces-39106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D7B83CAEC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0BFA1C25F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F6113DBA1;
	Thu, 25 Jan 2024 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cSfjDHE1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cC9wotL/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BA613B786;
	Thu, 25 Jan 2024 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206898; cv=none; b=G13u98RU2KCeCa1hNHbw2mVY0tr1VHqYfBd8Zq4t625z2yrosZGGhf99FXpr7f8flQtQFkHRQRg/qdaDAx6ihZg846wGCmOO7wUAidD135WPqaf+zoDXLeHYVLto65Ze+yQveaDZgxWaK9FPc56doL+zFJGn5ubAxYTI+j2SVao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206898; c=relaxed/simple;
	bh=/aaKbGn19uI0EKDnx/0AbnQIYzj5YEJT7IeUUVLhT2U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AqY9+HgYtm/jRi9k1hkRjATO2nL9GhKh/38PtfgLCKvEOnT2iCZ/s1xlgHw0c9jZioLoszB+jjLU1ws3URGos01p6/V8RFtNsCF44xAGP/gfx6adlDxisaee+vrnM5mWeZ5YxZPxhEiF+z50S5agajYMEDokj65hKRqyhre2u6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cSfjDHE1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cC9wotL/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206894;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WAns/H3cdr5O84K7fAoURzvtY40Ehfid4EFVStwf8qs=;
	b=cSfjDHE1JqHdZOCmzJFi8oRxKiRzXAzGDK7qAq3U9Qpk/sztIkiZXoA8ZmQTXwwFe8Ea6y
	07HUUL/7xXy5McDC2zZZq9nXSjJxiRBg9T3hzjU4gj+8Yv8MlbmAUZ65GKsHBMBhvYXVGH
	oCA4Heata1xZk4R+S8ZLpY9STkdJ1KX4vbf0cmxQ+lZ/QwDmI33AlBGnIIParAg0/62xR6
	uyjaoAXom1Ygo/JFoNpS8l51AUfFLb7xTtVfdg9mH/dZVEdb0ajdaFizTpgnHsqn/GwBrd
	DmWf8eMZQLCE0/uhgh3UuWPTvzxrrYM/bVSH75Dd01kW7PXJMoJRr0ZsPcHffQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206894;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WAns/H3cdr5O84K7fAoURzvtY40Ehfid4EFVStwf8qs=;
	b=cC9wotL/QnYmII0LAHIIW/362bxawSdqTBcQGwbevp21PEP1EFc9oUNaxeXWk3sVbl7FPy
	NKY0pbqdcbQ2ehCA==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/objtool: Teach objtool about ERET[US]
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-11-xin3.li@intel.com>
References: <20231205105030.8698-11-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620689420.398.17722955062117352928.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     12c4be1f0ed9bcdc2f2f578f6101e6f4af2ee039
Gitweb:        https://git.kernel.org/tip/12c4be1f0ed9bcdc2f2f578f6101e6f4af2ee039
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:49:59 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:30 +01:00

x86/objtool: Teach objtool about ERET[US]

Update the objtool decoder to know about the ERET[US] instructions
(type INSN_CONTEXT_SWITCH).

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-11-xin3.li@intel.com

---
 tools/objtool/arch/x86/decode.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index e327cd8..3a1d80a 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -509,11 +509,20 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 
 		if (op2 == 0x01) {
 
-			if (modrm == 0xca)
-				insn->type = INSN_CLAC;
-			else if (modrm == 0xcb)
-				insn->type = INSN_STAC;
-
+			switch (insn_last_prefix_id(&ins)) {
+			case INAT_PFX_REPE:
+			case INAT_PFX_REPNE:
+				if (modrm == 0xca)
+					/* eretu/erets */
+					insn->type = INSN_CONTEXT_SWITCH;
+				break;
+			default:
+				if (modrm == 0xca)
+					insn->type = INSN_CLAC;
+				else if (modrm == 0xcb)
+					insn->type = INSN_STAC;
+				break;
+			}
 		} else if (op2 >= 0x80 && op2 <= 0x8f) {
 
 			insn->type = INSN_JUMP_CONDITIONAL;

