Return-Path: <linux-kernel+bounces-85039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D235586AF7A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BCC3B21802
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2231C149DEC;
	Wed, 28 Feb 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kqOkEQje";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gm/t/JwN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B78145B3F;
	Wed, 28 Feb 2024 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709124805; cv=none; b=HwTM7icLyvg+32HNggbyoBmT9nYNMaBVYyBs4urpO6dv26xQ4w6fTMqegfgzA8eQRj6AVUuVDEno89Bg+YM7VAZdXqwe9bhbBaIxX5+8PM6ZLwsVXO+V82WRl7yzlZzDAULwdGIlAUXP5LL1DEcV4YVoeC2G8zoyNsqgaDeaKIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709124805; c=relaxed/simple;
	bh=6k+f8/0gP5Urva2n7YxmF16wMkG53s7JaD2SelmsFRc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RXyQ1EWjEK9znkXHN49pubjm/oL7CdiHM74Rqx0J95nV0iCBvrC2Qkwb/7GAdo9J3AxlX7GOdOrv9Zh8W0UCG7YjBNT4h7+UI6Uifb3EdDU09+EbqYLMhHPcwx2uCjszn3SuQhqSiq+okb6KCuzHWsnF/WVSC3EN2lDghruTBsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kqOkEQje; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gm/t/JwN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 12:53:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709124801;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Q7xoT5JrHZ8lCIiZEHNCxpQt53U9h/XuGMGzFwQLbQ=;
	b=kqOkEQje5dXWojyFmHDVoudsLXkouinjhHh/ONZ6M0zR2tRS/zReuXp26tn1Q362Q4SFfi
	DKqAK9Zzu8MZys1940RSZ/1aP4FZdJpREyIjoWe9JolgEIKbftWAJkH+yqezUl9hScx1ka
	MBO7sFElsFJMGv9PSJTmjQdSrlPIR5CYdSwQMioulpmKpk2TFTONb02e9Dl7Sn21RJZPGi
	N+EY/4KugaHXeCfSo+g4dsqGw0ZFayuvaXT/f/sXQuI2vJxTUHyzKMBv6g3mf4eqW1gpR8
	/vn0Jk6sUHcaREVOF5tE8jCm2CywNQbR+71U3vmgOdAjmR85c01shYbMmlloxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709124801;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Q7xoT5JrHZ8lCIiZEHNCxpQt53U9h/XuGMGzFwQLbQ=;
	b=Gm/t/JwNUX09726zt4hUHQryQMiJ07JvMhs/2IoD+m2KEjDxSzKSWpTj5VhrXoG8Zi2arX
	FKFt3giTD3fu2rAQ==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Make DEBUG_RWSEMS and PREEMPT_RT
 mutually exclusive
Cc: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240222150540.79981-5-longman@redhat.com>
References: <20240222150540.79981-5-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170912480104.398.12346476579749271464.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f22f71322a18e90e127f2fc2c11cc2d5191bc4c6
Gitweb:        https://git.kernel.org/tip/f22f71322a18e90e127f2fc2c11cc2d5191bc4c6
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 22 Feb 2024 10:05:40 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Feb 2024 13:08:38 +01:00

locking/rwsem: Make DEBUG_RWSEMS and PREEMPT_RT mutually exclusive

The debugging code enabled by CONFIG_DEBUG_RWSEMS=y will only be
compiled in when CONFIG_PREEMPT_RT isn't set. There is no point to
allow CONFIG_DEBUG_RWSEMS to be set in a kernel configuration where
CONFIG_PREEMPT_RT is also set. Make them mutually exclusive.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240222150540.79981-5-longman@redhat.com
---
 lib/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 975a07f..cb695bc 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1303,7 +1303,7 @@ config PROVE_LOCKING
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES if !PREEMPT_RT
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
-	select DEBUG_RWSEMS
+	select DEBUG_RWSEMS if !PREEMPT_RT
 	select DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_LOCK_ALLOC
 	select PREEMPT_COUNT if !ARCH_NO_PREEMPT
@@ -1426,7 +1426,7 @@ config DEBUG_WW_MUTEX_SLOWPATH
 
 config DEBUG_RWSEMS
 	bool "RW Semaphore debugging: basic checks"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && !PREEMPT_RT
 	help
 	  This debugging feature allows mismatched rw semaphore locks
 	  and unlocks to be detected and reported.

