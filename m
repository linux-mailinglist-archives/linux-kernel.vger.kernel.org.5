Return-Path: <linux-kernel+bounces-157650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9F48B1404
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA091C22BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3F41BF37;
	Wed, 24 Apr 2024 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DkF1Gjnk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bDEGy2Ay"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD40143C48;
	Wed, 24 Apr 2024 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989056; cv=none; b=INEuHoTt+kCJboz0EDsWpRKlCSnrSzY+z7rgrpRiyrwJT7WNYQF5Owpc/ccWxJDDw023YoJp3/kKCPfs+FBQiwtKLitCQOX1dtAICpEHezW5raEO/gk8ETh+pg2ZwQKq/0vILCDN6mA8OAIzLTqesMlbtpdHz3qPEo50O5Domk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989056; c=relaxed/simple;
	bh=nRrJjkRg9drFuw+i0mwrXAj2xhqmaRL/Kk4egBHMizk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ssoWMO15h5QlirZuLtgMMhExNSLAuT/miZhNS/6btreeGatIUqcHIBbyPK5VXpYSM8PU2q/ft3zRlIWUz+XeqKEMrzdm5QydCTe16BjHWs+i/Ql/tGhZy6hcNQoPBkOTb//XhTSwjbT5p5GARa21rh+EbYGbYKUeIkVQcoSX0a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DkF1Gjnk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bDEGy2Ay; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 20:04:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713989048;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjzLpE1/cqs0qycpsxIJJenSTyqFNcqpEmV2e7YahJg=;
	b=DkF1GjnkQfEAfVa/kzDCFxHGFIHWlRQPa//jv1BV4Fd9BUxQSyPtzN9bhQJxW07rXOUJQw
	uaEdMK3LdxjcBFrlDmPoS/D22HWLKeNsSydZoeVENJwpQtQwkq9Skquot+Z9+gb+8X6Pmb
	ACj6Orhaz9vPjmDbx+kTRyTWVV6e+KqgMENDQLW4im4+2nsFQbuPhUMMykkJFKkSqHjF9a
	8AqxzYKvoyNZoiwR7uE8BwH+GyL8NJdAAluWknB74/zNWOfLO1+ut0+rHRwzNIEjR4kSKR
	VbT7PmJLY9G1oWxzfNBKYm79sZGRtNYPMStfo9IQpI7UfgluLj0u+AAW8YmNPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713989048;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjzLpE1/cqs0qycpsxIJJenSTyqFNcqpEmV2e7YahJg=;
	b=bDEGy2Ayn6wIBxANmbWUNR7zUip48G2aGl6I5ObCw/yWVNzFi3TT2/usSXUqAOzsR0yoFT
	ZMxvocS3H5nGZvCg==
From: "tip-bot2 for Dongli Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/cpuhotplug: Retry with cpu_online_mask when
 migration fails
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240423073413.79625-1-dongli.zhang@oracle.com>
References: <20240423073413.79625-1-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171398904802.10875.14416916087679634264.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     88d724e2301a69c1ab805cd74fc27aa36ae529e0
Gitweb:        https://git.kernel.org/tip/88d724e2301a69c1ab805cd74fc27aa36ae529e0
Author:        Dongli Zhang <dongli.zhang@oracle.com>
AuthorDate:    Tue, 23 Apr 2024 00:34:13 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Apr 2024 20:42:57 +02:00

genirq/cpuhotplug: Retry with cpu_online_mask when migration fails

When a CPU goes offline, the interrupts affine to that CPU are
re-configured.

Managed interrupts undergo either migration to other CPUs or shutdown if
all CPUs listed in the affinity are offline. The migration of managed
interrupts is guaranteed on x86 because there are interrupt vectors
reserved.

Regular interrupts are migrated to a still online CPU in the affinity mask
or if there is no online CPU to any online CPU.

This works as long as the still online CPUs in the affinity mask have
interrupt vectors available, but in case that none of those CPUs has a
vector available the migration fails and the device interrupt becomes
stale.

This is not any different from the case where the affinity mask does not
contain any online CPU, but there is no fallback operation for this.

Instead of giving up, retry the migration attempt with the online CPU mask
if the interrupt is not managed, as managed interrupts cannot be affected
by this problem.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240423073413.79625-1-dongli.zhang@oracle.com
---
 kernel/irq/cpuhotplug.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 43340e0..75cadbc 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -130,6 +130,22 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	 * CPU.
 	 */
 	err = irq_do_set_affinity(d, affinity, false);
+
+	/*
+	 * If there are online CPUs in the affinity mask, but they have no
+	 * vectors left to make the migration work, try to break the
+	 * affinity by migrating to any online CPU.
+	 */
+	if (err == -ENOSPC && !irqd_affinity_is_managed(d) && affinity != cpu_online_mask) {
+		pr_debug("IRQ%u: set affinity failed for %*pbl, re-try with online CPUs\n",
+			 d->irq, cpumask_pr_args(affinity));
+
+		affinity = cpu_online_mask;
+		brokeaff = true;
+
+		err = irq_do_set_affinity(d, affinity, false);
+	}
+
 	if (err) {
 		pr_warn_ratelimited("IRQ%u: set affinity failed(%d).\n",
 				    d->irq, err);

