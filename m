Return-Path: <linux-kernel+bounces-107999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E314E8804A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F63D1F24C78
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99622381DE;
	Tue, 19 Mar 2024 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="srB+PmBn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PRmO38DY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C63A37708
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872455; cv=none; b=L56rEYDozhPohtXjrYDyivRPqKGj5pH3DX3OprK96uo3EORI0o7AqeZT2vs020ezTVVOznVxJS+l9Vg7si0vKNBgGyapWxHhbAqpV0lwXBh06Bv/TOdFSzs8T1FecLwrXMdtq3oi8QC9fz19EiDGqpNppAwyHqx36V7XBqqjMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872455; c=relaxed/simple;
	bh=IrD2CsLAg6bFdA1QgBrkSTZ7IAePgyDy6PNGrvKkQ5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/t8ugUdysdqzu6uvG0aRnb324UEr/qeVzfyZtTvBpuU085GauI5E/GuEfXqVw3ZhoPUq3aI5usQbpgushSMttuvs0uwwiKPnrKMtntqkg9Mx9acW9rKLiyGDM3g7l7dEA3FgV1BFwa/zFF5JpV953nPnG+Gv1ZS7oUF5h2k20k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=srB+PmBn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PRmO38DY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Mar 2024 19:20:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710872452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtVORP2D/yTcCKSC2Tvz8uV5u/k11YR540YQz7tn4pQ=;
	b=srB+PmBnxzXy8ZoSiCPd/hElVynFSEAsATjBwvSfjC/U6bEIunoYgeFHdH3iKGyabf5j5t
	MTCea0q+KOVYpNT1ch92M/eLvoyJh/6AhV3jH0YqazADzR0wlrBJAc6maxDMKm2nb9K2eR
	QeHuOgptvYnSXmPvD2V55uih02NP5nPIJ+xsdm02TKHdVAepX5IlZR/UENuJ0PdrzIS/U3
	/8hG9Os0GfxyLKYcABgUsoM+eYLJiNNhkEGrp5BMVOS6aTXEcfO24iTYRaBgmuuiqm8IA6
	1Yl1sl6iWLYsNVU9Sbq5QjjPPYQ+JoDLoe8/MeLpVdAc38LxOs+ayxpYfHErJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710872452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtVORP2D/yTcCKSC2Tvz8uV5u/k11YR540YQz7tn4pQ=;
	b=PRmO38DY4V9A8MKEbL2FJVNUqnTHc+JU6QY2BVmOjyWMhpd1qqYGukRHY3eXDacFTSpliP
	qEtNFaxH+WI706BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <longman@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH v2] Locking: Let PREEMPT_RT compile again with new rwsem
 asserts.
Message-ID: <20240319182050.U4AzUF3I@linutronix.de>
References: <20240319070550.ws_uO21-@linutronix.de>
 <ZfmVPid-d7cpf6Yt@casper.infradead.org>
 <20240319141506.DUd9NKl4@linutronix.de>
 <9b4f3dac-779a-4eef-945b-3ca1455c0dfe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9b4f3dac-779a-4eef-945b-3ca1455c0dfe@redhat.com>

The commit cited below broke the build for PREEMPT_RT because
rwsem_assert_held_write_nolockdep() passes a struct rw_semaphore but
rw_base_assert_held_write() expects struct rwbase_rt. Fixing the type
alone leads to the problem that WARN_ON() is not found because bug.h is
missing.

In order to resolve this:
- Keep the assert (WARN_ON()) in rwsem.h (not rwbase_rt.h)
- Make rwsem_assert_held_write_nolockdep() do the implementation
  specific (rw_base) writer check.
- Replace the "inline" with __always_inline which was used before.

Fixes: f70405afc99b1 ("locking: Add rwsem_assert_held() and rwsem_assert_he=
ld_write()")
Reported-by: Clark Williams <williams@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2:
  - Merge rwsem_held_write() into rwsem_assert_held_write_nolockdep() as
    per Waiman Long / Matthew Wilcox.

 include/linux/rwbase_rt.h | 4 ++--
 include/linux/rwsem.h     | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
index 29c4e4f243e47..f2394a409c9d5 100644
--- a/include/linux/rwbase_rt.h
+++ b/include/linux/rwbase_rt.h
@@ -31,9 +31,9 @@ static __always_inline bool rw_base_is_locked(const struc=
t rwbase_rt *rwb)
 	return atomic_read(&rwb->readers) !=3D READER_BIAS;
 }
=20
-static inline void rw_base_assert_held_write(const struct rwbase_rt *rwb)
+static __always_inline bool rw_base_is_write_locked(const struct rwbase_rt=
 *rwb)
 {
-	WARN_ON(atomic_read(&rwb->readers) !=3D WRITER_BIAS);
+	return atomic_read(&rwb->readers) =3D=3D WRITER_BIAS;
 }
=20
 static __always_inline bool rw_base_is_contended(const struct rwbase_rt *r=
wb)
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 4f1c18992f768..c8b543d428b0a 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -167,14 +167,14 @@ static __always_inline int rwsem_is_locked(const stru=
ct rw_semaphore *sem)
 	return rw_base_is_locked(&sem->rwbase);
 }
=20
-static inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *=
sem)
+static __always_inline void rwsem_assert_held_nolockdep(const struct rw_se=
maphore *sem)
 {
 	WARN_ON(!rwsem_is_locked(sem));
 }
=20
-static inline void rwsem_assert_held_write_nolockdep(const struct rw_semap=
hore *sem)
+static __always_inline void rwsem_assert_held_write_nolockdep(const struct=
 rw_semaphore *sem)
 {
-	rw_base_assert_held_write(sem);
+	WARN_ON(!rw_base_is_write_locked(&sem->rwbase));
 }
=20
 static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)
--=20
2.43.0


