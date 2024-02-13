Return-Path: <linux-kernel+bounces-64192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 374FD853B96
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85539B289D9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E471060895;
	Tue, 13 Feb 2024 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dJOydb6/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iJMFGqFs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F146088D;
	Tue, 13 Feb 2024 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853748; cv=none; b=nahslyB9SSaHMBXvNjFoeqyHBxW5QLUg57NO6Mv0REIQbSIMNXyvkQ5hWVJGT/LqI6zPrCdaRfNCzqztACOPXqNmHzMQfs8pyHJkuxADSJ/lsq1Espq4IG78OyFYS3QmE8V7rDVLnNrQm+/4pBRKTKjG5ZSjTgyL3RPgVZUx67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853748; c=relaxed/simple;
	bh=pjKA3Ua1RKW2HGaRujVR/MwN9dtP60k5B2a26aztdr0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WZB3IpByvwcTDQAvuWOA2cJ39wDcIZawuHqQEz7INi1PkQAX/KFWY12IQcY4oy5qaS0Sxe54ThCedZvx7Eh4u54tYdWBFC2Qh1Esrj2RCiMzbZcaGLMyIcO+n2zseU2JqeFp0IQbqSUTUVCH7c/2BDYwp1r9VS2Xr5QKnLNlZ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dJOydb6/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iJMFGqFs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Feb 2024 19:49:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707853744;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eHdL9fwqzOFVunQ7aj6eAS3JJUQBeZz3a16vfCQiKHg=;
	b=dJOydb6/I8/1s9cl/MJu9k8XnaqWmXcrkwuWc3YU7l7m+lvFhdhkEq856HyjvYsVQV/j57
	k2tSZUFaBkmWNXaLceQV59m+NhGMM3DZ/ZECGX6woFXFLvavAZ4oShrcN2kWgfMZkO4Bof
	5aAK3cpTXIrBbje2eTxjMkqQhpJ/k4m6s9QqqfIebHXdP48g6f5vPg2kFDgBAS75uGMOQy
	7yIRrHDlreIL53o01ZkqP2HYLWu8tXdSeS0zXe3c4ezJSWgeQhqE5Dyjzb3VqUdy+T33Mk
	7KnjNhOFaZQvxI5rnJ6g9gaIaDIZIAA+SN5bggOuzrLjgwKHibNMk05gYnv3JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707853744;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eHdL9fwqzOFVunQ7aj6eAS3JJUQBeZz3a16vfCQiKHg=;
	b=iJMFGqFs1Q7mvG/X4gizrWDePP9YZQ/w69vEGUpvCEJuDLVw/FVQ1yIjaHgtakSp9ytf4Z
	2DuEoW3dbnrIF7Aw==
From: "tip-bot2 for Costa Shulyupin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Select housekeeping CPU during migration
Cc: Waiman Long <longman@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213164650.2935909-3-costa.shul@redhat.com>
References: <20240213164650.2935909-3-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170785374329.398.3918391631110866746.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     86342554e102b0d18d50abec43d40f4fc92f1993
Gitweb:        https://git.kernel.org/tip/86342554e102b0d18d50abec43d40f4fc92f1993
Author:        Costa Shulyupin <costa.shul@redhat.com>
AuthorDate:    Tue, 13 Feb 2024 18:46:51 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 Feb 2024 20:44:14 +01:00

hrtimer: Select housekeeping CPU during migration

During CPU-down hotplug, hrtimers may migrate to isolated CPUs,
compromising CPU isolation.

Address this issue by masking valid CPUs for hrtimers using
housekeeping_cpumask(HK_TYPE_TIMER).

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240213164650.2935909-3-costa.shul@redhat.com
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 7607939..438208a 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2221,8 +2221,8 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 
 int hrtimers_cpu_dying(unsigned int dying_cpu)
 {
+	int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping(HK_TYPE_TIMER));
 	struct hrtimer_cpu_base *old_base, *new_base;
-	int i, ncpu = cpumask_first(cpu_active_mask);
 
 	tick_cancel_sched_timer(dying_cpu);
 

