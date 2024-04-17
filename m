Return-Path: <linux-kernel+bounces-148452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0582E8A82C8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 632F9B22720
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5694913D610;
	Wed, 17 Apr 2024 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EzCrzDBe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZpBEDS2F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3788913D24C;
	Wed, 17 Apr 2024 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355646; cv=none; b=k3JN5xgG1TSOuHDBtilWIcx2qCFs1xh4Qrfj8ZTb77rpy57z9Mkeut7L7vTuijQbqMFcvMAnZlWuwiD8YmbORun4ctiBPQnMj3PWV3rgr1kqkkjityLD5XkqphsATYfsQ/fi5EOtSwEoLKAlbT1/bxk2VUoul9zhVL60SMHQTko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355646; c=relaxed/simple;
	bh=2LSFomZ5YH0mZ7tF9v1gYpe9X3F6uiBV9cobj0d9JLo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mug+hqpWnu8yJoxI2hsucawxBeWOAB1y1Zi1tO37KhPabEJzpPYccNGi3GpaSZxjZgQy9trXh4pDgYf8tI2p9ZzGJweM16J9tkBzPHLuOHigh0brzB6gXxhJmTTKm0p1YcR2aPZEIbKKc2RMJGFSs1RcbM5VjMTWWBq3IcVkCAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EzCrzDBe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZpBEDS2F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Apr 2024 12:07:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713355643;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bDg0AQ7iLhbY6WRISSDqH3iEf4kNvq149hne7wdH6g4=;
	b=EzCrzDBeg8D0eWVPtKAHgPT5voXsVtmtVVa8wxby8w8VOCAEjYpG9ZkuaeG1GLe2U/ju1H
	EejWOG7b//K4hp1Nd5jl48bILd3ot+DNFkxqYy1m8SZAGQlaYpvcorVi/rJlmArz1hakoJ
	KBs1FIuLbuA6IweTMlutgZlSpFPxdq9GVcRBipgnfelcbXabhAdfmH78JVMBI0dh6HqAVq
	2wfcS4/03kveMqirHucAlIfhA9PMLOOk14ZX80KQu/rKkJqAovKvcgBv9t3gWwQRIkE9Of
	BCc7iTajlwBpeMrDleKTTfNO+MZ+QLaXTH9+2s2yt7J81yNAw1vaZkXjdSriaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713355643;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bDg0AQ7iLhbY6WRISSDqH3iEf4kNvq149hne7wdH6g4=;
	b=ZpBEDS2FEdEcJd6kcEFYmZjFdHs+T1jTP12invCxoQJwvJUfmnovgOnT2KbCCcwINd1tQy
	PuomW3DnMEbojtDQ==
From: "tip-bot2 for Alexander Gordeev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/vtime: Remove confusing
 arch_vtime_task_switch() declaration
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C783d7c611864f82b0fb9edf01890b9396f3a549a=2E17127?=
 =?utf-8?q?60275=2Egit=2Eagordeev=40linux=2Eibm=2Ecom=3E?=
References: =?utf-8?q?=3C783d7c611864f82b0fb9edf01890b9396f3a549a=2E171276?=
 =?utf-8?q?0275=2Egit=2Eagordeev=40linux=2Eibm=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171335564280.10875.644727821317856682.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     37f36cab53c9e903823b327f964227563766071a
Gitweb:        https://git.kernel.org/tip/37f36cab53c9e903823b327f964227563766071a
Author:        Alexander Gordeev <agordeev@linux.ibm.com>
AuthorDate:    Wed, 10 Apr 2024 17:09:44 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Apr 2024 13:37:19 +02:00

sched/vtime: Remove confusing arch_vtime_task_switch() declaration

Callback arch_vtime_task_switch() is only defined when
CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is selected. Yet, the
function prototype forward declaration is present for
CONFIG_VIRT_CPU_ACCOUNTING_GEN variant. Remove it.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Link: https://lore.kernel.org/r/783d7c611864f82b0fb9edf01890b9396f3a549a.1712760275.git.agordeev@linux.ibm.com
---
 include/linux/vtime.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 3684487..593466c 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -18,7 +18,6 @@ extern void vtime_account_idle(struct task_struct *tsk);
 #endif /* !CONFIG_VIRT_CPU_ACCOUNTING */
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
-extern void arch_vtime_task_switch(struct task_struct *tsk);
 extern void vtime_user_enter(struct task_struct *tsk);
 extern void vtime_user_exit(struct task_struct *tsk);
 extern void vtime_guest_enter(struct task_struct *tsk);

