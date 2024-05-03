Return-Path: <linux-kernel+bounces-168052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091E68BB31D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3FBD1F222DF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE4A158A09;
	Fri,  3 May 2024 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uPyhr+Ia";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TzxsqJJV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E07A15357D;
	Fri,  3 May 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761009; cv=none; b=qmtTDpOrOpaXsL6ZsQ0g866Qtx7EPJ44yG0t4Y/H3t2EhUx01raROrzoZPJfQrwdrdE35RjK+17GyHndSmyD5A5BR87Flpnh3FFatZ6LDQzE5+waxHYBoG7a821pUlWYFMoYuQnYUnU6p5JQEuTWquCcmr/OLkiLGuQbDCp+ask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761009; c=relaxed/simple;
	bh=ls6qSExaMi9oGHo1aKY5TnxWHp62QkOustRT2dJ8ZUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1Oydp2MVPTFXmOaEFVm1HFJMJPxQ8mJdmcfNSHc+3F4VsbrycNj6sIVwgnOL95Phq8ldFy8GCfUn4/CU4HrZwPpjFWRlwD+9iDe4w7d7Tal6zGd6D7AvahA/Bs9q5xfZEcJeM7ufkJhTHCqfClTS4Wmr+JxnpWcoPiXC8ur/Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uPyhr+Ia; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TzxsqJJV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714761006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kqOsZwjUVyamGiYcxy8jPtVsK2vi9nUiJ6gwIp5xpHA=;
	b=uPyhr+IaM4TTXkpfS4mUaGcqxwypUDiHODx7u6SXINmsWn+64+hp45pu/amaaEV8pA2KNh
	WpGRWIPkUenotXnlxXT345XXgx6hPo2L6YSRVoSVhbVUst3qxUgwtT3TVmOhQGhmfJT5DX
	dQD+TaJjYiy2Z4/c0NdLbXvJShXKu/rrhSc7DbEUQcYoKTbsfgSzlxK2gYPCCP5/jvur48
	xr9C8vIKY2hyvPAbw0GW0umz/MNu8Ws/EWwhD5zqd5tDI9+08cTdjtqiME3l1XD5jrByZ4
	2WbPQHeA3kcqKc1urEr038R5i7ba8qb9ahYfYztbxCq3GntzUwfABJYhtipyrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714761006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kqOsZwjUVyamGiYcxy8jPtVsK2vi9nUiJ6gwIp5xpHA=;
	b=TzxsqJJVhweJyXxUPRML+Ux+ypJAEkV6+koJ8uMBvRS1T+Ul9ZGb/CIquFUPe7QK3dCnQI
	eRe7iPTAAZ2NZ6Aw==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 01/15] locking/local_lock: Introduce guard definition for local_lock.
Date: Fri,  3 May 2024 20:25:05 +0200
Message-ID: <20240503182957.1042122-2-bigeasy@linutronix.de>
In-Reply-To: <20240503182957.1042122-1-bigeasy@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Introduce lock guard definition for local_lock_t. There are no users
yet.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/local_lock.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index e55010fa73296..82366a37f4474 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -51,4 +51,15 @@
 #define local_unlock_irqrestore(lock, flags)			\
 	__local_unlock_irqrestore(lock, flags)
=20
+DEFINE_GUARD(local_lock, local_lock_t __percpu*,
+	     local_lock(_T),
+	     local_unlock(_T))
+DEFINE_GUARD(local_lock_irq, local_lock_t __percpu*,
+	     local_lock_irq(_T),
+	     local_unlock_irq(_T))
+DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t __percpu,
+		    local_lock_irqsave(_T->lock, _T->flags),
+		    local_unlock_irqrestore(_T->lock, _T->flags),
+		    unsigned long flags)
+
 #endif
--=20
2.43.0


