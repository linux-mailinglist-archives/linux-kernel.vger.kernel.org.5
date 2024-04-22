Return-Path: <linux-kernel+bounces-154080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8612E8AD72F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4F71F21BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9426D20330;
	Mon, 22 Apr 2024 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FdFLDAok";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N2ghb6XS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE05EAC7;
	Mon, 22 Apr 2024 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713824371; cv=none; b=UUHVDlhxvHobAu9lDrXj46qELyUYkdgSEmYF33KyafDFTH6MHtm5qMy/k01MVm0fLRlv6+SqQRCrUhR3lRxEZCYYrxutiRY9ak3nOKmPaqcUT86yMg5dyQXwd98RUK6PQIzJ7HV4ahUuKLAPBNnJpbJQtR5dsasRekKyD0UIu44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713824371; c=relaxed/simple;
	bh=ND5tqPbLHiRmqAq3seb/NtLicLiXO1QrqUysWJXwAgc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WY5WTRT2/dxJq2pvITuFlrqnCsCNIRmYAkJGV0mkrESeB4xCRfOtVmtATIlhWM1kQdbc79o2FtFC0/gMBib+nNklaPh2/bWi3tY1XsqBDoQfIkIXAqgoF5ljOO8Zszx3rrKvMkiqueX14Ixhe96i1I6gpufQFKwGFClGurskq6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FdFLDAok; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N2ghb6XS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 22:19:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713824368;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LswEfE44mEwAXWJoZftpskhklhezJOAQtEACpWEeju0=;
	b=FdFLDAokRv9uZfNHRV7ythB/y9kLqiNQykWHREWyjHBT9s7+wJoqp/1NGXhzoRTeOUGb1e
	Vt5TikLhFfUoEAJWo3ogtCx0Xr45PR18HVcD0BKyTvb9GF4DdDufai9mpyBERKSHG/FHVH
	I+pDi335MSvgUPgatEL7XIIx0ktqcneDi3MZTTfu1w4NyuOAnKvwEOa/5D9d0NLVaDbVVj
	gTqsgXT8rB7NLCjiFzyhsASVttcmKrP91wfDqJO6LSi5vKHxgolbH2HPB//BlV8G3sNsf4
	5Q/9m5X6oHttWNqBmiQvyGbS/lDy/m/yr3rD5d8FrFCZtZ2Xq8NCh+OZWHVxpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713824368;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LswEfE44mEwAXWJoZftpskhklhezJOAQtEACpWEeju0=;
	b=N2ghb6XS85DeGDg/SNer0gj+WYov0ThrPAcuDDfx6E+EuiHCykHL9J1xL/RZ0OY8iafh1F
	KoH0DBXRyBaxupAg==
From: "tip-bot2 for Jinjie Ruan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Simplify the checks for
 irq_set_percpu_devid_partition()
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240417085356.3785381-1-ruanjinjie@huawei.com>
References: <20240417085356.3785381-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171382436728.10875.7349999854043503567.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     bb58c1baa501e3d695d8e13a5bd955fd00e2e879
Gitweb:        https://git.kernel.org/tip/bb58c1baa501e3d695d8e13a5bd955fd00e2e879
Author:        Jinjie Ruan <ruanjinjie@huawei.com>
AuthorDate:    Wed, 17 Apr 2024 16:53:56 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 23 Apr 2024 00:17:07 +02:00

genirq: Simplify the checks for irq_set_percpu_devid_partition()

Since whether desc is NULL or desc->percpu_enabled is true, it returns
-EINVAL, check them together, and assign desc->percpu_affinity using a
ternary to simplify the code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240417085356.3785381-1-ruanjinjie@huawei.com

---
 kernel/irq/irqdesc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 3820931..f0d4b98 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -911,10 +911,7 @@ int irq_set_percpu_devid_partition(unsigned int irq,
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
-	if (!desc)
-		return -EINVAL;
-
-	if (desc->percpu_enabled)
+	if (!desc || desc->percpu_enabled)
 		return -EINVAL;
 
 	desc->percpu_enabled = kzalloc(sizeof(*desc->percpu_enabled), GFP_KERNEL);
@@ -922,10 +919,7 @@ int irq_set_percpu_devid_partition(unsigned int irq,
 	if (!desc->percpu_enabled)
 		return -ENOMEM;
 
-	if (affinity)
-		desc->percpu_affinity = affinity;
-	else
-		desc->percpu_affinity = cpu_possible_mask;
+	desc->percpu_affinity = affinity ? : cpu_possible_mask;
 
 	irq_set_percpu_devid_flags(irq);
 	return 0;

