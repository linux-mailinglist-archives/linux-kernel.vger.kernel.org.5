Return-Path: <linux-kernel+bounces-47142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B978449CA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4471F21900
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED5D3B290;
	Wed, 31 Jan 2024 21:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s8UGGbq8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1+gExA+4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A713FE47;
	Wed, 31 Jan 2024 21:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735698; cv=none; b=OyXu4j7PLtjcScMIf1Q1/S/3mst5fhyXC9BsYElmjElLqPjeLJ6zNs7YuldH/HH0q8KEAwwZvYouagEIe6Saz94oo11gpncksvgI/f9mrPFiRsXSkTSSrE8IFQ6UYKuRZTnLrFzDFNJ5tW0oLqizTqj2pjUqRqx8qMtlqfNi6A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735698; c=relaxed/simple;
	bh=Zulj1UKkBRVCZq/QUr2QDhJGliff45VcvSbzuao2OF0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qsgjcbhITYA/tTLTGUsX/UxrAQAWEOf/0U6pCR9271r//rI8tIF2F4xz+ixesRHyXWM6Rp+j8cfsP5OAJb4ZzOLLLr2Lp7/sAXqmAnhC1wHa353E4Fo/7g09qh7xHSZmshKRGlfnnc/cXj0MDTBr85gkg/5Gui7xHAMKi419iFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s8UGGbq8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1+gExA+4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 21:14:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706735694;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6d9iScv9hfMuzggOjaVTLY+ka2oOlb74y4ycaCmZ5A=;
	b=s8UGGbq8csxVkFEu/wFNP0U9QNiHVUGXmzbf+af6YP79Vdy/Zd+5SclejMamGgXS35FeXG
	MdH5ZfQUE8vWbxW2ZYs+gdWFM3lyPRSEh8gtxVDvEPbJqpU6w0ztJF0Z/wx5qENW0+A5S6
	GDQ62TcNF4WZV+P/FPorJ1ZPTKfnlnJHKLfZnHPeWHck6P0k2GFsKDIZ8Y6kTT3x614ex1
	rbMshpsMADyMXoDtq8PzmJLk9hvgTDKIgkGZme9lszkoLTQtkWNuuZ2UUg+z0A6mfGrRMp
	YGs5/zr7etNWME3q7yvGpnwh02pZl1TlX0sTi/PmvkqAZbrqgU0WABJlPinxPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706735694;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6d9iScv9hfMuzggOjaVTLY+ka2oOlb74y4ycaCmZ5A=;
	b=1+gExA+4xNYrb1uUL/eNlGRlUvWpKDZcTMMqko/xI+2PVKBUohNRilhnAAUncdFu5m69mD
	z3SQfTB+reOpuZAw==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/objtool: Teach objtool about ERET[US]
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shan Kang <shan.kang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-11-xin3.li@intel.com>
References: <20231205105030.8698-11-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170673569415.398.15283813681779613232.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     cd19bab825bda5bb192ef1d22e67d069daf2efb8
Gitweb:        https://git.kernel.org/tip/cd19bab825bda5bb192ef1d22e67d069daf2efb8
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:49:59 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Jan 2024 22:00:30 +01:00

x86/objtool: Teach objtool about ERET[US]

Update the objtool decoder to know about the ERET[US] instructions
(type INSN_CONTEXT_SWITCH).

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
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

