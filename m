Return-Path: <linux-kernel+bounces-63293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 791D4852D58
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FA928982F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019E72260B;
	Tue, 13 Feb 2024 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aazcc5te";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="15BrQU++";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aazcc5te";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="15BrQU++"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5C9225A8
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818402; cv=none; b=CUFu2cHOUc8tGQNFdj/uvz+KKTCI/fE6NwsTKx+n/9GXwh4cdAdQtHhE0dTK9MVx3uk7poFiKVJC6WAjWWFq1e4ngNI0SfSkCEdoPo77uOHKPGWZygOBb8gLhGZGyCoK4zxKRYi+OUQ302+3PuLawWwpoeHhB1tq4y0o1zb+1jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818402; c=relaxed/simple;
	bh=E/IbOFAywgL9hGvboiVidh21zqG92M7SuaadVUy4GJw=;
	h=From:To:Subject:CC:Date:Message-ID:MIME-Version:Content-Type; b=Q5ABBMvQkQ7zr2nJ4CSosiXE5Wvpvv0egs0rVktKE1TGwLTI4ad0TtED7nm9UAZGWP3MypiD87MLSyVDK5EEEwRHDE3PjU7cs2SmiKHigenZo+/SVjZXT5Lm0N5dYF8kGg00mh4VMmOKuS/Mijqno0Tt+gR31m14rtjH6t/Gews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aazcc5te; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=15BrQU++; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aazcc5te; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=15BrQU++; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out1.suse.de (Postfix) with ESMTP id B674D22002;
	Tue, 13 Feb 2024 09:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707818398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=1ZWzJ3oPo3Ib0Ua7vx9StT0Wv7lYZFu4fgLyeQS1pes=;
	b=aazcc5tevLdTt0WjT8FzXkfjI+oKNQaGJ5R6n524YasDA1Q0fQAL0btyFuZCUz9PMvRpLb
	1gH3VuTwB16qrJlDFyYNHn0LSdzFez9QmuCeeFPdUu+ekkA3mmwg5k6i6eZPVkKafowYh9
	TgJbzB/XWnhXdbLEui9LXX1eOQLDr5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707818398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=1ZWzJ3oPo3Ib0Ua7vx9StT0Wv7lYZFu4fgLyeQS1pes=;
	b=15BrQU++xcqWxIGQDgUi/HLbUrr9JpnjDLv1l873/VEJjdCBaFEeRBl8WVQz9dFB5Px6p3
	PNjYQj5UX82yQZCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707818398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=1ZWzJ3oPo3Ib0Ua7vx9StT0Wv7lYZFu4fgLyeQS1pes=;
	b=aazcc5tevLdTt0WjT8FzXkfjI+oKNQaGJ5R6n524YasDA1Q0fQAL0btyFuZCUz9PMvRpLb
	1gH3VuTwB16qrJlDFyYNHn0LSdzFez9QmuCeeFPdUu+ekkA3mmwg5k6i6eZPVkKafowYh9
	TgJbzB/XWnhXdbLEui9LXX1eOQLDr5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707818398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=1ZWzJ3oPo3Ib0Ua7vx9StT0Wv7lYZFu4fgLyeQS1pes=;
	b=15BrQU++xcqWxIGQDgUi/HLbUrr9JpnjDLv1l873/VEJjdCBaFEeRBl8WVQz9dFB5Px6p3
	PNjYQj5UX82yQZCw==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id A038A4A03A6; Tue, 13 Feb 2024 10:59:58 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: use KERN_INFO in do_trap
CC: Palmer Dabbelt <palmer@dabbelt.com>, Yunhui Cui
 <cuiyunhui@bytedance.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>,
 linux-kernel@vger.kernel.org
X-Yow: What GOOD is a CARDBOARD suitcase ANYWAY?
Date: Tue, 13 Feb 2024 10:59:58 +0100
Message-ID: <mvmh6ic1y75.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.81
X-Spamd-Result: default: False [-1.81 / 50.00];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_SHORT(-0.17)[-0.842];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.54)[80.78%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com]
X-Spam-Flag: NO

Print the instruction dump with info instead of emergency level like the
rest of the output when printing the information for an unhandled signal.

Fixes: b8a03a634129 ("riscv: add userland instruction dump to RISC-V splats")
Signed-off-by: Andreas Schwab <schwab@suse.de>
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
2.43.1


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

