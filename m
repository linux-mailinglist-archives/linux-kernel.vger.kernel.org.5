Return-Path: <linux-kernel+bounces-45915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C0F8437CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875211F22EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AFC80BE4;
	Wed, 31 Jan 2024 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1q2Tt87w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0j3DzY//"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E767D41D;
	Wed, 31 Jan 2024 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685691; cv=none; b=pDkgrRmhdUKKln5FLl9jiXxGlNJ6x0hZwkRNxg58v1VPt8ySzb522O3Sq19hVsqjOwN/wc3wFVPnoGUDrc430sqsjlL+oitHOu3iiF7N2SENHK9T7ooNlJgMFLsM9ZAzmNT93f5Jq4H4sGRywrVR02Gi3o5v0sJRvfZp2qONoWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685691; c=relaxed/simple;
	bh=9K75qWrjl6fWNtI122ummM3PWcbH5thnyEjoCILfuwA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iFzGTVQ+28S6Nmi20PMhb8tY/Xngf2etQ4elV9dJv/F6eur6uo5BcpmQzievUjswUl1U64c1JZvSWdiga8jKQzkRwfqL6oy9PcYId59n5f4fjcwjVy8JMt8OpIm37k0+wZZJS5pOslNUM2/F2XoTNjyaMvI5cUVt3EFCEuR0luY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1q2Tt87w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0j3DzY//; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 07:21:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706685688;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYzIsKm6GzAF4BoeOIcGPmmIIBHYHiI9kmLDjdSJtwU=;
	b=1q2Tt87w/+CHJsUbsECj9Dm7TSUXd+73vjnbi44K/drhYvhMY650qJcm7HUeDGkcbvqWoC
	2tyMmyv4cUi3QpviXwySvXKDUsUhR8TCmdjppyUFIWeywYWu0O7dl0aUJlV+gGt8UKiRcu
	fMecEVpYtDjRLxyPLjCuClmtCHfe2jmbsyIbf+32xUAwTM4knSUnk5enlqHlK8zhF1YFek
	uxsuEeGcG9nHFpgXPVp6ej5OoZfs9LUywqaB4Ao+n5YAvNCowkCqWaNNDBl+Y6ladRwEW7
	rQKkx8hD2fUXznszompQDDDcUKNavl4VDRuyydu6GCfPGSI9VbAZv1am0pUbWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706685688;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYzIsKm6GzAF4BoeOIcGPmmIIBHYHiI9kmLDjdSJtwU=;
	b=0j3DzY//yetjbwtIluDYI9MWvQq4Emj+AYsR+e3dbrpexCfqryE/rGgyq0k1GPaqjusff9
	HsKJnaH/onmsAhCA==
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
Message-ID: <170668568727.398.15964471096297288131.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     379ae086a73c804df39866d28eb4ce693e7af486
Gitweb:        https://git.kernel.org/tip/379ae086a73c804df39866d28eb4ce693e7af486
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:49:59 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jan 2024 18:20:34 +01:00

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

