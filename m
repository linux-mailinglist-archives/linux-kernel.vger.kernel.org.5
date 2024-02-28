Return-Path: <linux-kernel+bounces-85758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A341A86BA61
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD15287D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D879F15CD76;
	Wed, 28 Feb 2024 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xn7h1TLt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8H5y2ZWL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE5972926;
	Wed, 28 Feb 2024 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157620; cv=none; b=UwYCMG+h3eyIoXNFAf/+UWkvvMwc2GreeK2zx+WBqyVnHvQ3SOIx8qqVRexaTuBj0DBBNKGIzzpw6Dhu3DCP0RirN/84snNoSnqUXhX2HGATz2jHAkHdtuRp9XEYwwV/Qjxqnfsa8Puyb4EHswH0YXYpwrHRBcsidPO5l61iIB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157620; c=relaxed/simple;
	bh=HxvvFqnmA8souJOCgavYVWOgiTyC8Y/4qwwd2OIPr0E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nnjs8aEaGWS1uXvxmh2XlG51KZ9s6CRrKIDSuPsQgwR4mp0VvuCjQaDg6ZP9oDnTAycN1mXS6RgdAawBQNpC2NsQrrYo9VcRds/Maabziy+9znNw90Y8iHVB3pNedv8n1MnxPuyjnuLnfTRBRa/UklktmmvFRONZTrMB5DFexLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xn7h1TLt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8H5y2ZWL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 22:00:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709157609;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n1hUEJTNDyLbFNyv4Pvq7UoLFZ3E7ttyCUfoofWt/8o=;
	b=xn7h1TLt1nyaIrhTvV6DCuY9lLoHZxM4JuFMw+jrh5aMBqoCL+45XNXI4ko+4hZF/Tmn03
	Y9ajnOPN8eEmhxg1cX5HyQbdAtjzUHKFxxdBjbd71YCoWh2vx2qbVTk2/ULpQV6WOzhMNV
	3xAvfHbJh+QgqvZPOm2lH23k4LfDl3gx81A/+dpaQVsZPkQpdfLDl7D4uWP3IIyvljU6BE
	CEVnM/5S24skHGbbC4mfosxHOWZFDn6M/Fwlunh8ZOwZzap8QycjnEP8WHeZqIMF6oopcs
	w3vhMe8iy2xVd0KZ8AF0jEgQJGuCm7J6/PmY0Kme9VybVnmz0bJ6zEYmqXt9VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709157609;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n1hUEJTNDyLbFNyv4Pvq7UoLFZ3E7ttyCUfoofWt/8o=;
	b=8H5y2ZWL/WDBvcFEdBFt5YMckWlN5NYBp2cT6tD6AkzXjVaByrmJP3cPYG9zG4SkHIKb7h
	4po0/SEnjKoyUJAg==
From: "tip-bot2 for David Vernet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Simplify the update_sd_pick_busiest() logic
Cc: David Vernet <void@manifault.com>, Ingo Molnar <mingo@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240206043921.850302-4-void@manifault.com>
References: <20240206043921.850302-4-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170915760842.398.18217674203199461024.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7e9f7d17fe6c23432fda9a3648a858b7589cb4aa
Gitweb:        https://git.kernel.org/tip/7e9f7d17fe6c23432fda9a3648a858b7589cb4aa
Author:        David Vernet <void@manifault.com>
AuthorDate:    Mon, 05 Feb 2024 22:39:21 -06:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Feb 2024 15:19:26 +01:00

sched/fair: Simplify the update_sd_pick_busiest() logic

When comparing the current struct sched_group with the yet-busiest
domain in update_sd_pick_busiest(), if the two groups have the same
group type, we're currently doing a bit of unnecessary work for any
group >= group_misfit_task. We're comparing the two groups, and then
returning only if false (the group in question is not the busiest).

Otherwise, we break out, do an extra unnecessary conditional check that's
vacuously false for any group type > group_fully_busy, and then always
return true.

Let's just return directly in the switch statement instead. This doesn't
change the size of vmlinux with llvm 17 (not surprising given that all
of this is inlined in load_balance()), but it does shrink load_balance()
by 88 bytes on x86. Given that it also improves readability, this seems
worth doing.

Signed-off-by: David Vernet <void@manifault.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20240206043921.850302-4-void@manifault.com
---
 kernel/sched/fair.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 448520f..51fe17f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10010,9 +10010,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	switch (sgs->group_type) {
 	case group_overloaded:
 		/* Select the overloaded group with highest avg_load. */
-		if (sgs->avg_load <= busiest->avg_load)
-			return false;
-		break;
+		return sgs->avg_load > busiest->avg_load;
 
 	case group_imbalanced:
 		/*
@@ -10023,18 +10021,14 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 
 	case group_asym_packing:
 		/* Prefer to move from lowest priority CPU's work */
-		if (sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
-			return false;
-		break;
+		return sched_asym_prefer(sds->busiest->asym_prefer_cpu, sg->asym_prefer_cpu);
 
 	case group_misfit_task:
 		/*
 		 * If we have more than one misfit sg go with the biggest
 		 * misfit.
 		 */
-		if (sgs->group_misfit_task_load <= busiest->group_misfit_task_load)
-			return false;
-		break;
+		return sgs->group_misfit_task_load > busiest->group_misfit_task_load;
 
 	case group_smt_balance:
 		/*

