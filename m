Return-Path: <linux-kernel+bounces-88406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C4686E12B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FD8287CB3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FCF210E6;
	Fri,  1 Mar 2024 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F3hhs45w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LbjSABXx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5D03FB84;
	Fri,  1 Mar 2024 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296733; cv=none; b=FcoRPlqzpp/WnaQ4GjzvmraLcKVYSOCi/2yCupRw3Oj6cV2GgqpFD1bOfgEy3iMKkOk5cuW5FK805eOn6PcLsvjK5PfsD04FyT7fCtAIaLV5AdKkPcQRifJ6Yqjqz9Px/Ss6un27RDx0Vvwood3SqVfELmBvhuU+0pC0pZ/zqVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296733; c=relaxed/simple;
	bh=qSeqRDVTN9dpiUTvX40r7xH4MdiIS3SY62kiEFe6taU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QMI+nZm5OsU3aWY/SdmMh6/rgKULQWYW6Yhzgrdnu9PluEWhvQpXcWF4ARNTt5aYLQNrkibY7j68tSF8RjsGk9JwGJ06Bp+OYgv8VWjgLKnnptzVJxTAFja5AWwhHqv0uiQGV5RDIjOuOdh5yETQIU9i7afcvCdclYcrLaokPd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F3hhs45w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LbjSABXx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 Mar 2024 12:38:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709296729;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGBPuh9xFafhzrpJQWBTrjACe5BJAQKU5ZVCsVAxxOM=;
	b=F3hhs45wcVeznJ/JyywwwVaFb3zeOWqGuhI7ENKPLFww1zlHlM4mdtgmqRbpdkLhX+lxmx
	6ueGkVjsxVBy47X7r8I9RDAjVqxwUqhIqLhIHiK56lfJc323/fbxrFyRLCqfqb1CEpyvdc
	/T+BUIQj2YuXJ3/OFCp4qrNw2pPR5JfWj7+llV4Trq95tTC7hoA6nO43mPDVTrgJKvWC9d
	2F8Mgw+XZtYCXbvrJb/XL1meYzXZ45UrmahJ05ljDrGCL+bMOpfnCdKUh/Mc+nPsXc0fEi
	OjVW4UOZXzkJHeRuByNl3DLOeIunu2EDXCiAt0/QfUzOXkJLzfUjtx0NYqt2ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709296729;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGBPuh9xFafhzrpJQWBTrjACe5BJAQKU5ZVCsVAxxOM=;
	b=LbjSABXxLR9vJzYEFeJeuTSCLot5dQ81SLuVKiWtkr/kMXA3alXERY3XwX0Oo7O5oFrcgk
	4eceQRnGdF2sAmBw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/x86: Implement local_xchg() using CMPXCHG
 without the LOCK prefix
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240124105816.612670-1-ubizjak@gmail.com>
References: <20240124105816.612670-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170929672897.398.5127033798711557434.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e807c2a37044a51de89d6d4f8a1f5ecfb3752f36
Gitweb:        https://git.kernel.org/tip/e807c2a37044a51de89d6d4f8a1f5ecfb3752f36
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 24 Jan 2024 11:58:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 01 Mar 2024 12:54:25 +01:00

locking/x86: Implement local_xchg() using CMPXCHG without the LOCK prefix

Implement local_xchg() using the CMPXCHG instruction without the LOCK prefix.
XCHG is expensive due to the implied LOCK prefix.  The processor
cannot prefetch cachelines if XCHG is used.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20240124105816.612670-1-ubizjak@gmail.com
---
 arch/x86/include/asm/local.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/local.h b/arch/x86/include/asm/local.h
index 73dba8b..59aa966 100644
--- a/arch/x86/include/asm/local.h
+++ b/arch/x86/include/asm/local.h
@@ -131,8 +131,20 @@ static inline bool local_try_cmpxchg(local_t *l, long *old, long new)
 				 (typeof(l->a.counter) *) old, new);
 }
 
-/* Always has a lock prefix */
-#define local_xchg(l, n) (xchg(&((l)->a.counter), (n)))
+/*
+ * Implement local_xchg using CMPXCHG instruction without the LOCK prefix.
+ * XCHG is expensive due to the implied LOCK prefix.  The processor
+ * cannot prefetch cachelines if XCHG is used.
+ */
+static __always_inline long
+local_xchg(local_t *l, long n)
+{
+	long c = local_read(l);
+
+	do { } while (!local_try_cmpxchg(l, &c, n));
+
+	return c;
+}
 
 /**
  * local_add_unless - add unless the number is already a given value

