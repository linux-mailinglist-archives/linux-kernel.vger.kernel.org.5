Return-Path: <linux-kernel+bounces-107729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B578800D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53EF528321C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CE8657C7;
	Tue, 19 Mar 2024 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="arHKAD1F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8GBMOv7A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="arHKAD1F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8GBMOv7A"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6771EEE8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862809; cv=none; b=jNx2QQtz8EDEr8O5CB70+FILKrU1aKIG4jbG7/TCTIc/Xu9F2hVD8a/EvxEB7lot7iBJtTMTFdusdhLotx4OjhvNOPDYds46uXDFI88mNC+d73Ky0SveHK2N8NLx8sGv8ERVm6jA7I5ZtJYZE3ArsNGsUm8H369ByCGSJ/JVyKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862809; c=relaxed/simple;
	bh=ZmshkXkVpth1oyAN7ZxeVKxK2bjkL6LqUopCpsCcVi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bt1gLEhj0TLONB2P+kXrKHIhY/FAImqxYNiyxmT2p3+/V+1iZ2y21E09rYKzE56g8XYve1jMYN1Df+PQfmaW548+CAXt8qzFpqvKJnY1b8kkuGolorh6pBCAhIqck4hUi4LWj3GCaOY9eurEWmMuEfNQuXXAHcoamHsXqrfN6jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=arHKAD1F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8GBMOv7A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=arHKAD1F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8GBMOv7A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out1.suse.de (Postfix) with ESMTP id 69C7137A2C;
	Tue, 19 Mar 2024 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710862805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=TZWTavSqBaUZhtUPGIn6VRcLs9MngZ5lHHdh7u0xSfg=;
	b=arHKAD1FkoFGB6DuKK/caMfG/tbgO7uis+wBO1AHhMEaAbAwMnCpJYVOzzUlQuYQnw+UXv
	fd40OS3Al0K6+OMdWIHNIoY78nFTaTzGWDiv33nsPP/8i0xROZrUA2l74HPpoXcvwQGKf9
	v3Bfos+N1AFuSLKsgplKn1wrw5xjIr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710862805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=TZWTavSqBaUZhtUPGIn6VRcLs9MngZ5lHHdh7u0xSfg=;
	b=8GBMOv7AI2fiiopC4Bpxd2hpDZONoE47VCPtAqpU8eOsUan3108BL72gjTDkSYOddADQ6c
	h+hYJVqHaYR5RPDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710862805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=TZWTavSqBaUZhtUPGIn6VRcLs9MngZ5lHHdh7u0xSfg=;
	b=arHKAD1FkoFGB6DuKK/caMfG/tbgO7uis+wBO1AHhMEaAbAwMnCpJYVOzzUlQuYQnw+UXv
	fd40OS3Al0K6+OMdWIHNIoY78nFTaTzGWDiv33nsPP/8i0xROZrUA2l74HPpoXcvwQGKf9
	v3Bfos+N1AFuSLKsgplKn1wrw5xjIr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710862805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=TZWTavSqBaUZhtUPGIn6VRcLs9MngZ5lHHdh7u0xSfg=;
	b=8GBMOv7AI2fiiopC4Bpxd2hpDZONoE47VCPtAqpU8eOsUan3108BL72gjTDkSYOddADQ6c
	h+hYJVqHaYR5RPDw==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id 59FBA4AA2BF; Tue, 19 Mar 2024 16:40:05 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Yunhui Cui <cuiyunhui@bytedance.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: use KERN_INFO in do_trap
X-Yow: Dehydrated EGGS are STREWN across ROULETTE TABLES..
Date: Tue, 19 Mar 2024 16:40:05 +0100
Message-ID: <mvmy1aegrhm.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -1.19
X-Spamd-Result: default: False [-1.19 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.995];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.06)[-0.291];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.03)[56.71%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

Print the instruction dump with info instead of emergency level.  The
unhandled signal message is only for informational purpose.

Fixes: b8a03a634129 ("riscv: add userland instruction dump to RISC-V splats")
Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
v2: clarify commit message
---
 arch/riscv/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index a1b9be3c4332..142f5f5168fb 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -121,7 +121,7 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
 		pr_cont("\n");
 		__show_regs(regs);
-		dump_instr(KERN_EMERG, regs);
+		dump_instr(KERN_INFO, regs);
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
-- 
2.44.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

