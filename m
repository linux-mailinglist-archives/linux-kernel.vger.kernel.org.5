Return-Path: <linux-kernel+bounces-76392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5134685F69B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63371F243B0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A17446DE;
	Thu, 22 Feb 2024 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XLibcITl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XLibcITl"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3FC405D4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708600613; cv=none; b=DXdkYPi0koPT+Rx2WznXqPCS8Ubqf8fVME777TsM4oHEtDC6ZvCS67ZkF1vih53jx55+FxldLQtHrz0kwoUSkGRCdUBaD2aEWwNCPy/LqZ24O/fMd2b/ygA+gc5c6gEJdPDX150hxXnbPSfVf0xhJJI8Ha5/Wy2/+Pw1L94fJlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708600613; c=relaxed/simple;
	bh=rxtY7H0wM9qx+Z0fjosj7tqZaxRDqcbDj1LTjD9zRNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RF85Xdm/pETk8fzEqMwi88wDIoMrPttz4kSN3BnZWRADjSQfkc+HJk5Hu2Yr1WNEYSWiuZM9Rp8l7dCIzRQF8xuoNrlAxc6XDpjuEzk4w5bX6g3cCRroEMgaHeuC901jMwR8+tZO8B+LaORzbu2/RvzGblXucmz/C8oMsigrDqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XLibcITl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XLibcITl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4311D222B0;
	Thu, 22 Feb 2024 11:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708600610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KjgXYrHVvwADgI5kTKZFgaMxkaodrMCR2ZZQJa+QmU=;
	b=XLibcITlVhR+Y+l1qkAS5iRuNT5Orwn94ePgaAe51uiCgaYEOb2m6Dc8FuvB9XbOUxGI0z
	k6Y6N2x1SGBC5P7YyNYCOSZ736GXFkVFyEgZiEmGbhgXiNQZN2obAKey1ifobTl13NN+W0
	gIEeMBxQxxAz1S87iZtL4u0ZGS/+jZo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708600610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KjgXYrHVvwADgI5kTKZFgaMxkaodrMCR2ZZQJa+QmU=;
	b=XLibcITlVhR+Y+l1qkAS5iRuNT5Orwn94ePgaAe51uiCgaYEOb2m6Dc8FuvB9XbOUxGI0z
	k6Y6N2x1SGBC5P7YyNYCOSZ736GXFkVFyEgZiEmGbhgXiNQZN2obAKey1ifobTl13NN+W0
	gIEeMBxQxxAz1S87iZtL4u0ZGS/+jZo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0452A13ADA;
	Thu, 22 Feb 2024 11:16:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GFUhOiEt12VrGgAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Thu, 22 Feb 2024 11:16:49 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: bp@alien8.de
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 1/2] x86/insn: Remove superfluous checks from instruction decoding routines
Date: Thu, 22 Feb 2024 13:16:35 +0200
Message-Id: <20240222111636.2214523-2-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222111636.2214523-1-nik.borisov@suse.com>
References: <20240222111636.2214523-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [6.00 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: ******
X-Spam-Score: 6.00
X-Spam-Flag: NO

It's pointless checking if a particular part of an instruction is
decoded before calling the routine responsible for decoding it as this
check is duplicated in the routines itself. Streamline the code by
removing the superfluous checks. No functional difference.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/lib/insn.c       | 56 +++++++++++++++------------------------
 tools/arch/x86/lib/insn.c | 56 +++++++++++++++------------------------
 2 files changed, 42 insertions(+), 70 deletions(-)

diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 55e371cc69fd..3946bdc75087 100644
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
index 8fd63a067308..5d81924478d9 100644
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
-- 
2.34.1


