Return-Path: <linux-kernel+bounces-142904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591A98A31DD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66201F213BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE7B14830E;
	Fri, 12 Apr 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kGU8L1In";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kGU8L1In"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E751474C0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934800; cv=none; b=MR0EcCiHgKvluQnwrjSQFRY6oYX0VL8no5TVILNNhrZrphYQclnVP2DpLnROQj9iZE9j25fxdvVMzUCjN9csL7pAILoVqgbG3ExkkAgw0ykfgMtBUcR53ZzJPmswQ+qBzMiWPM/01mNVFI98O1sQebKqwYlwLnZKoiJUueKaZWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934800; c=relaxed/simple;
	bh=Zu3rFat9oWEwa27THa2x3ewitXdjVSlF/ryLxGZm5+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pdp8Hb22EL0s1HohRitO6uYOBmf1isn9ADnLW1oTZSvhT4+cbbc3iV2fXYGyJD91T0Ll8k20mZv5Alypclvjl96qCJHwguit90fkjr9XGbNHC5zPkWN0ffBgUmrzeSMaRlNZv0xOCV4Ny4G0NJiG1jlz3p8yQ0o74jU20WPW1uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kGU8L1In; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kGU8L1In; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 764B25FE6A;
	Fri, 12 Apr 2024 15:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712934797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wKKDrPuReVm9V7SbchYzGZK7Z61laQsoQLsr/aCN3lg=;
	b=kGU8L1InEJtWLSeDy83fLJejkrRi68RG3beqX7sB4+YWspDYdzlqufw+jyxCeNskpHvbvw
	l08CI1M0Jbvx2si7ufQzyQzOZpmLwZWwDjZqRZmqmCl3HzXdZp0BEPsRP6ScQogKd+y/He
	ynynti1EkFGAaznuSMmsraz1x3v+vV0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712934797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wKKDrPuReVm9V7SbchYzGZK7Z61laQsoQLsr/aCN3lg=;
	b=kGU8L1InEJtWLSeDy83fLJejkrRi68RG3beqX7sB4+YWspDYdzlqufw+jyxCeNskpHvbvw
	l08CI1M0Jbvx2si7ufQzyQzOZpmLwZWwDjZqRZmqmCl3HzXdZp0BEPsRP6ScQogKd+y/He
	ynynti1EkFGAaznuSMmsraz1x3v+vV0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AE781368B;
	Fri, 12 Apr 2024 15:13:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mQCxBYxPGWarAQAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 12 Apr 2024 15:13:16 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 2/4] x86/mm: use lookup_address_in_pgd_attr() in show_fault_oops()
Date: Fri, 12 Apr 2024 17:12:56 +0200
Message-Id: <20240412151258.9171-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240412151258.9171-1-jgross@suse.com>
References: <20240412151258.9171-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-2.99)[99.96%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[]

Fix show_fault_oops() to not only look at the leaf PTE for detecting
NX violations, but to use the effective NX value returned by
lookup_address_in_pgd_attr() instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- split off from V1 patch (Ingo Molnar)
---
 arch/x86/mm/fault.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 622d12ec7f08..6b2ca8ba75b8 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -514,18 +514,19 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
 
 	if (error_code & X86_PF_INSTR) {
 		unsigned int level;
+		bool nx, rw;
 		pgd_t *pgd;
 		pte_t *pte;
 
 		pgd = __va(read_cr3_pa());
 		pgd += pgd_index(address);
 
-		pte = lookup_address_in_pgd(pgd, address, &level);
+		pte = lookup_address_in_pgd_attr(pgd, address, &level, &nx, &rw);
 
-		if (pte && pte_present(*pte) && !pte_exec(*pte))
+		if (pte && pte_present(*pte) && (!pte_exec(*pte) || nx))
 			pr_crit("kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n",
 				from_kuid(&init_user_ns, current_uid()));
-		if (pte && pte_present(*pte) && pte_exec(*pte) &&
+		if (pte && pte_present(*pte) && pte_exec(*pte) && !nx &&
 				(pgd_flags(*pgd) & _PAGE_USER) &&
 				(__read_cr4() & X86_CR4_SMEP))
 			pr_crit("unable to execute userspace code (SMEP?) (uid: %d)\n",
-- 
2.35.3


