Return-Path: <linux-kernel+bounces-85042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4444A86AF82
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3878287C06
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8453B14EFE4;
	Wed, 28 Feb 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jL2HWUs5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eypl/HHr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D07149E01;
	Wed, 28 Feb 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709124807; cv=none; b=rJjKNI52mXJ3RBfqiXmnc4B8t+KfD0X0J9yhL+SJAeGiz+FoJsFZscng9yrdt31H+sHRAdbXaIt0xsot8Ml6Vn5T4yazcrabo3EEadglcgi7mFii8MI3nqZENrLijiP9i+tbl7ihGX47KDFRGmIR71QpbAa1cvksMmV1M3FKsuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709124807; c=relaxed/simple;
	bh=unfqZidumn24iXVPy4auOrLTeuT97RoLN9DRHqzjL9c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XzrTNyF6IcFFcnUlFAwkZuKOOvNk7j0I+FBvNs14mk7vQH/bUdEWHViuOWy+nNHnsEWfX0Lkf0vgwDn7anUloUGpUv7apU4WK9XFHxgO4N45qXMA8Q+h98+jF1k+LlLLMTp0JbJMq1wBoIFGgrq2T408idrJKIfhbU7H2+rGamw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jL2HWUs5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eypl/HHr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 12:53:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709124804;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zx4JZGkklQTdrU2XSkaUDyw5tTHTirZv7mYq6dRHUI=;
	b=jL2HWUs5ijgUGFqYIavQ/ekelFWFTRDjE4gvsH56h3yothgcrIofjKFlyEf0JjPrE3OV4i
	mx4b7ch0dEbT1Ah9tOGNZk1O72TYqBmkGFm6x74ir4D/izyz+xyFDj0Ml8gCQDuX7Fon0a
	NlFY/zZa5hy/2RRoFqgUqSJBvwvWNv4F+GYQBcUcweEKCgCKTtX5RaJCeLRONDc/QlBF78
	ubH0Z1KAUeK5zIdBxfva1i4aJrJRmdlRg/Qz6kxPvB5NVGKbvCfkYFWTWJfS2K7q1yKyQ4
	YoIUH/R/3UdOpoogCdjgwNaCdsdHSMxVuZKWuA4hEpOJznrnKgrVx3WpSt1pyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709124804;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zx4JZGkklQTdrU2XSkaUDyw5tTHTirZv7mYq6dRHUI=;
	b=eypl/HHrp9IBmlcd80AcazRYuvW4Y5LadDMazyBcPZy5Za9eN5Z8BggF2Rp+kIhDRXuWAB
	9WrcQQZbJqjAfODA==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/qspinlock: Fix 'wait_early' set but not
 used warning
Cc: kernel test robot <lkp@intel.com>, Waiman Long <longman@redhat.com>,
 Ingo Molnar <mingo@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240222150540.79981-2-longman@redhat.com>
References: <20240222150540.79981-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170912480380.398.9234775487451824502.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ca4bc2e07b716509fd279d2b449bb42f4263a9c8
Gitweb:        https://git.kernel.org/tip/ca4bc2e07b716509fd279d2b449bb42f4263a9c8
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 22 Feb 2024 10:05:37 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Feb 2024 13:08:37 +01:00

locking/qspinlock: Fix 'wait_early' set but not used warning

When CONFIG_LOCK_EVENT_COUNTS is off, the wait_early variable will be
set but not used. This is expected. Recent compilers will not generate
wait_early code in this case.

Add the __maybe_unused attribute to wait_early for suppressing this
W=1 warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240222150540.79981-2-longman@redhat.com

Closes: https://lore.kernel.org/oe-kbuild-all/202312260422.f4pK3f9m-lkp@intel.com/
---
 kernel/locking/qspinlock_paravirt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 6a0184e..ae2b12f 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -294,8 +294,8 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 {
 	struct pv_node *pn = (struct pv_node *)node;
 	struct pv_node *pp = (struct pv_node *)prev;
+	bool __maybe_unused wait_early;
 	int loop;
-	bool wait_early;
 
 	for (;;) {
 		for (wait_early = false, loop = SPIN_THRESHOLD; loop; loop--) {

