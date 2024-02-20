Return-Path: <linux-kernel+bounces-73642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273F685C567
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5420AB210FC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B311414AD0E;
	Tue, 20 Feb 2024 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kPqXlR7U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="olvqMdKM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8619E14A0A4;
	Tue, 20 Feb 2024 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459470; cv=none; b=XhA6WZ4q9lIaLSijih6RfnH/phTIt8f5j2pduqKtIRCFRrt/2Zlylo6RqnP2bxiL9/1roheHh2BnAD0S7JzhaYMfrm1Dtrf+nnmpwzwTlFG2E/s7iSptAKk/QJhfKij2aLWOE37R6aBebn5s6EK+sI0sDr80VN/rFa1/sqQ9IEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459470; c=relaxed/simple;
	bh=J1hNe9Q6O5piXzU51bjk5hAZt2yPmaITciZkXXP7w48=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mpv3NgsMPejINofew3/62PhmeB7oJmNy8dUsdNA/IGDh8WXnVRm9ftPRgJi/smK0Bru3OD8wOJTxrJxdw4XEzhGhnMffYSPa2R6asF4LdndTc3takx73Ziq0kVgtxmTlfj5T9IoT3G7oLLcN8G3Z+sj6oiaJXc2LAt9/TLN6Z3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kPqXlR7U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=olvqMdKM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 20:04:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708459466;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dih5Ol5ME+gvYsSWqt4Fn6k78efib70N4hSsFrQ9iQY=;
	b=kPqXlR7US3gK68bg0lwOQvHw9F6D1xT3Y0Qr1n8Ue2nYd9NzpiMCk2hi5vZqVZ++ddJdIa
	5j/czl0P/eUK6n/iGV0mso8ey1sA8auBaBQCX8RcOE06mcxe+SBOR3LCl58XAu8z2+pJlB
	uh0CVXwHjWc2lLW83U9VobyVC84a2MVP3qqRZhTeAogjVGc3ZrL1eGwwS/bsPSra/3sqVE
	IOrU1nF1gJ/zhvV32Xk8Mn35/JXneoccn4pLUALL0xXmBVpS/k7D6V7ivbBEXttYJrZUZF
	BXqpGnpTYnKhH2MJHtIx+RmqM4QR5Tc1XOdEspf359eZaJUoD7Fxt4LBmbU6fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708459466;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dih5Ol5ME+gvYsSWqt4Fn6k78efib70N4hSsFrQ9iQY=;
	b=olvqMdKMdw0fvy7X0nhbQjwk1b7BgZ/98CXcQZwGlINg46jznzqnHyn3gZrKvaowtPEFkn
	8YNVu/QSwDJnE7BQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] MIPS: vdso: Use generic union vdso_data_store
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Kees Cook <keescook@chromium.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240219153939.75719-10-anna-maria@linutronix.de>
References: <20240219153939.75719-10-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170845946609.398.5280601387697735244.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d697a9997a0dfd1fcb26144f383c38e371b191b0
Gitweb:        https://git.kernel.org/tip/d697a9997a0dfd1fcb26144f383c38e371b191b0
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 19 Feb 2024 16:39:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Feb 2024 20:56:01 +01:00

MIPS: vdso: Use generic union vdso_data_store

There is already a generic union definition for vdso_data_store in the vdso
datapage header.

Use this definition to prevent code duplication.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20240219153939.75719-10-anna-maria@linutronix.de

---
 arch/mips/include/asm/vdso.h | 5 -----
 arch/mips/kernel/vdso.c      | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/vdso.h b/arch/mips/include/asm/vdso.h
index cc7b516..afb03d4 100644
--- a/arch/mips/include/asm/vdso.h
+++ b/arch/mips/include/asm/vdso.h
@@ -50,9 +50,4 @@ extern struct mips_vdso_image vdso_image_o32;
 extern struct mips_vdso_image vdso_image_n32;
 #endif
 
-union mips_vdso_data {
-	struct vdso_data data[CS_BASES];
-	u8 page[PAGE_SIZE];
-};
-
 #endif /* __ASM_VDSO_H */
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index f6d40e4..dda36fa 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -24,7 +24,7 @@
 #include <vdso/vsyscall.h>
 
 /* Kernel-provided data used by the VDSO. */
-static union mips_vdso_data mips_vdso_data __page_aligned_data;
+static union vdso_data_store mips_vdso_data __page_aligned_data;
 struct vdso_data *vdso_data = mips_vdso_data.data;
 
 /*

