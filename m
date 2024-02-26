Return-Path: <linux-kernel+bounces-82422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19843868400
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9164289943
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D008013541A;
	Mon, 26 Feb 2024 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FMmsHU7b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1wr0HsCM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B824E1E878;
	Mon, 26 Feb 2024 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987817; cv=none; b=kvDh684bTl9eJsEq1bEmCVmOpKh6GUEbS7LDnJ2oFrgwzXtxZN/lqJe1wrkq8vUs6WevWr7RfhblZ/M2wH2GoHFdYe6rDte1LH53fcS4lQIW7xJfdMftjKhOVxYOJB6mjYOi9xgmjXEGwehClEROEy8n9BNo+IB22SafXi326xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987817; c=relaxed/simple;
	bh=o7Wcn1KDPwCffzlOKpbzPY01A2cadSqrF1Y1I3x4atI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KwOx/PqaaUz7PbiKn9wWqj343KGzTBwA/WOfPeyG3bUXTW9uyaOR2d5eP0iFynTVkMgSh6LbOkt1RTmTLN6ErxQ7vfuPIZ83aCmcBoqTggS0SjuXfPPdlaExVrQgcdt4TD+SqTCJs5H7Rx5cCaM8dz4MB0AQuMipOcd6xan5cBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FMmsHU7b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1wr0HsCM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 22:50:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708987814;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/h88iFjljQgpYh/U4AubUDEoroAqEk0EzYMiCox+oTM=;
	b=FMmsHU7b2w0cZ4Suf+UwrNN4XcWUMxmIuDyc/FW0SLky6Hq87YpApK36cwhHRTLrziWEV0
	y9GDly0itTTVGUdLRJ0Lo98ycFISfsLDmDDVVUYXdoTV3UIukSgFtTy1SwhnDjqx2rMz0I
	xrlC1++NgkaG+UwqUe2C9EthkbSJY0tr/Vx8fOSBq8s/jApp1OPfWcYpGYosgfNgiPmpp+
	VY33DkrHKnN7ebSgoR1kT5T9cMYDbegkmcob3DDwMjGSD5hS/stIBIJT4NZUuHgoumXM8x
	2fzH2ALK/TtmnRbZhho5e+JY4NzJSJLz6PbMLpaNXVozYSjZyfrwn6mtG2ntkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708987814;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/h88iFjljQgpYh/U4AubUDEoroAqEk0EzYMiCox+oTM=;
	b=1wr0HsCMJHsbM13Jqtnnzmz75H+tD7gmBC3SztS5navJlBxj08OGmqOeOFn6IlCygKcdRO
	oIsi4FgXZkHFDzCg==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/nmi: Fix the inverse "in NMI handler" check
Cc: Breno Leitao <leitao@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240207165237.1048837-1-leitao@debian.org>
References: <20240207165237.1048837-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170898781297.398.379688708307726561.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     d54e56f31a34fa38fcb5e91df609f9633419a79a
Gitweb:        https://git.kernel.org/tip/d54e56f31a34fa38fcb5e91df609f9633419a79a
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Wed, 07 Feb 2024 08:52:35 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Feb 2024 23:41:30 +01:00

x86/nmi: Fix the inverse "in NMI handler" check

Commit 344da544f177 ("x86/nmi: Print reasons why backtrace NMIs are
ignored") creates a super nice framework to diagnose NMIs.

Every time nmi_exc() is called, it increments a per_cpu counter
(nsp->idt_nmi_seq). At its exit, it also increments the same counter.  By
reading this counter it can be seen how many times that function was called
(dividing by 2), and, if the function is still being executed, by checking
the idt_nmi_seq's least significant bit.

On the check side (nmi_backtrace_stall_check()), that variable is queried
to check if the NMI is still being executed, but, there is a mistake in the
bitwise operation. That code wants to check if the least significant bit of
the idt_nmi_seq is set or not, but does the opposite, and checks for all
the other bits, which will always be true after the first exc_nmi()
executed successfully.

This appends the misleading string to the dump "(CPU currently in NMI
handler function)"

Fix it by checking the least significant bit, and if it is set, append the
string.

Fixes: 344da544f177 ("x86/nmi: Print reasons why backtrace NMIs are ignored")
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240207165237.1048837-1-leitao@debian.org

---
 arch/x86/kernel/nmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index d238679..c95dc1b 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -639,7 +639,7 @@ void nmi_backtrace_stall_check(const struct cpumask *btp)
 			msgp = nmi_check_stall_msg[idx];
 			if (nsp->idt_ignored_snap != READ_ONCE(nsp->idt_ignored) && (idx & 0x1))
 				modp = ", but OK because ignore_nmis was set";
-			if (nmi_seq & ~0x1)
+			if (nmi_seq & 0x1)
 				msghp = " (CPU currently in NMI handler function)";
 			else if (nsp->idt_nmi_seq_snap + 1 == nmi_seq)
 				msghp = " (CPU exited one NMI handler function)";

