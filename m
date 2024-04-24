Return-Path: <linux-kernel+bounces-156693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00038B06E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8DAE28412E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2DF159575;
	Wed, 24 Apr 2024 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cFQmGRIp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5Y+hEnB9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0C2158DCF;
	Wed, 24 Apr 2024 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953080; cv=none; b=UPbzilYj1uUheU68xn2EH0oHI8K3qn5UHv9KA2oEg28QV6zc3v8wLzrsAydThrK8X/2fu52rBpbzEHQMnf/DwLB8lz9u5u3UCqAfK/urc7Tj0S9SSdDL/zmzZr+zFkL4pcnY7zXowAidwy0QJ58p15+2iGlDpory9A0XuugNdkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953080; c=relaxed/simple;
	bh=Pt+ikqjMihr41akyixDZQDvJ8C9xur0ISNFhUmtxRH4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Yk7pS51gUO2jmeRNMT2CZadbp+zY0jDQh7FDbZIXzqZx51pl2fyOAwTFWthHZs04dwrQyDJnIb3wHUEzvQ9Q53EZDiloDmXd+YoOn+Y8JZzVxNxMS90877v+/rFild8afvXJZ44AhqhNVwcbtXKxUsOBX6f97F1HnylL6wPeIVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cFQmGRIp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5Y+hEnB9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 10:04:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713953066;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpYLdxswfRinuIfUuHAJy334gxe5DEtnR6tvbyjiaBo=;
	b=cFQmGRIpbiDhFYbQaCSc/vV2CGHuO/Hs/UL2kMu/UFu4eQvw4sDed0usahY9IOKdLDSQZ5
	5qdHM6+gPl5TwxTRqiGA854IGUo9h73DQbEXLKGJparzRSH9WpE/ZUm48XOfZwJEbUsPIE
	L2ufx+j6b8zJnkXihzUb3DUn9yQcBzK9EbmPw7cL51Z7waT9m8znsAzWyqGvr6adXiB2Nh
	FVfOb6rhblUQfsugEtffPoZLA+x3o1lA1JFY/J0KPn6N7hfZcFo+zLBfPJyvwhrHxfCO+o
	qu2tn01Zd1xIc8NfLToPpu2ZRaZVwwXA5wi6Ri7T0X6Qi5dq6fGiPJZB8fdO3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713953066;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpYLdxswfRinuIfUuHAJy334gxe5DEtnR6tvbyjiaBo=;
	b=5Y+hEnB963wosLsRS+xSgyshGKqTpEPeNJ9LSn14huxWL2ws6skJpt/w4WqvvYUPVO+zJJ
	ycVuOxM35hTpNpAQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/pvqspinlock/x86: Use _Q_LOCKED_VAL in
 PV_UNLOCK_ASM macro
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240422151752.53997-1-ubizjak@gmail.com>
References: <20240422151752.53997-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171395306551.10875.10282096733098701784.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     532453e7aa78f3962fb4d86caf40ff81ebf62160
Gitweb:        https://git.kernel.org/tip/532453e7aa78f3962fb4d86caf40ff81ebf62160
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 22 Apr 2024 17:17:35 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 24 Apr 2024 11:48:08 +02:00

locking/pvqspinlock/x86: Use _Q_LOCKED_VAL in PV_UNLOCK_ASM macro

Use _Q_LOCKED_VAL instead of hardcoded $0x1 in PV_UNLOCK_ASM macro.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240422151752.53997-1-ubizjak@gmail.com
---
 arch/x86/include/asm/qspinlock_paravirt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 466af57..0a98578 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -40,7 +40,7 @@ __PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text");
 #define PV_UNLOCK_ASM							\
 	FRAME_BEGIN							\
 	"push  %rdx\n\t"						\
-	"mov   $0x1,%eax\n\t"						\
+	"mov   $" __stringify(_Q_LOCKED_VAL) ",%eax\n\t"		\
 	"xor   %edx,%edx\n\t"						\
 	LOCK_PREFIX "cmpxchg %dl,(%rdi)\n\t"				\
 	"jne   .slowpath\n\t"						\

