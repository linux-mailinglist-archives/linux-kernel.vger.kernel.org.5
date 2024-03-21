Return-Path: <linux-kernel+bounces-110609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FAE886140
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83EE7281C78
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEA6134424;
	Thu, 21 Mar 2024 19:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mN6OH1DH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NpTtFjFd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746AE1339AB;
	Thu, 21 Mar 2024 19:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711050319; cv=none; b=RTj2U8u29kF7FUuLYuexOcxCFcGApNg7JkldVlRs+9pc5WZxfsPMEVqBjuIEXQoZVWFtX4VBcAduXSwTB58rLG/2IyAxXPMCm15BYQcz1x4gSLsGvnsEEv/0SFbVtat3XrAsHP4hz813s0ZzQ2JyF3z/IvqjFvxAm/KCWHia7rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711050319; c=relaxed/simple;
	bh=NObd3l5CfBnBCW6AFvUHVZaPNsnb1nk94JtsLxVskHc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=us3qRRe5luz14i3nflYfbif180nK5eaGnySVsEKtoIOwBwbYL0bmiEsUPOBSPazuLFu1uVMmuHTcZ/apU0Dv+F25f0K+/54iqIotSe6eUN4UF7l6Mz0OQg2/7tJublJj8Dboqy7wUOhIkp/0Yt5aQdQpVtR/X8W0n0+XhbASh+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mN6OH1DH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NpTtFjFd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 21 Mar 2024 19:45:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711050315;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EI5/D8ujKIfjCzHQQXS5t7nEm6z7SaRdD7RwSveBEMA=;
	b=mN6OH1DHLaxiPL9+rlByUQii1iYgcy94mKkM4SuvUsc4aELxrsp3GuYUzpK0pr0DJtLWE+
	gLFF5n7yONrdbqaAagTAv9qNyDstpBkFCWmQiFaT+9TenTvrVPB4En5UmoAKgg/9GW9P23
	aC9J4wCTXi2V7JsXPxnbVrVYdL/yIaKmHasqIocuAlVZMRl8miaUN4FEIHTRxXjTR1Ja5E
	E3JpnWWfqRnxstZtMq0UydSxllJruo24ddOitE5oqbP6/HRCatZTzv+BVHydwf9kMYHOFR
	saJf1JF0/5acM8gAziRbawp1xQc4fgxAnD63cCRQ16CA2BPN1xZJUSWsS9fkcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711050315;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EI5/D8ujKIfjCzHQQXS5t7nEm6z7SaRdD7RwSveBEMA=;
	b=NpTtFjFdncR6T7n9qjZDbYiNDyDrBf9TBAGvDqtHxWbhmMQTBCTT1bJK3ZrkhyDKbR6Lps
	5hm/n8YgafOfleBw==
From: "tip-bot2 for Mukesh Kumar Chaurasiya" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/doc: Update documentation for base_slice_ns
 and CONFIG_HZ relation
Cc: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
 Ingo Molnar <mingo@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240320173815.927637-2-mchauras@linux.ibm.com>
References: <20240320173815.927637-2-mchauras@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171105031473.10875.823907471048599597.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     a26979377bf34534ce5ee2712d2a46157ec61498
Gitweb:        https://git.kernel.org/tip/a26979377bf34534ce5ee2712d2a46157ec61498
Author:        Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
AuthorDate:    Wed, 20 Mar 2024 23:08:16 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Mar 2024 20:34:16 +01:00

sched/doc: Update documentation for base_slice_ns and CONFIG_HZ relation

The tunable base_slice_ns is dependent on CONFIG_HZ (i.e. TICK_NSEC)
for any significant performance improvement. The reason being the
scheduler tick is not frequent enough to force preemption when
base_slice expires in case of:

           base_slice_ns < TICK_NSEC

The below data is of stress-ng:

	Number of CPU: 1
	Stressor threads: 4
	Time: 30sec

	On CONFIG_HZ=1000

	| base_slice | avg-run (msec) | context-switches |
	| ---------- | -------------- | ---------------- |
	| 3ms        | 2.914          | 10342            |
	| 6ms        | 4.857          | 6196             |
	| 9ms        | 6.754          | 4482             |
	| 12ms       | 7.872          | 3802             |
	| 22ms       | 11.294         | 2710             |
	| 32ms       | 13.425         | 2284             |

	On CONFIG_HZ=100

	| base_slice | avg-run (msec) | context-switches |
	| ---------- | -------------- | ---------------- |
	| 3ms        | 9.144          | 3337             |
	| 6ms        | 9.113          | 3301             |
	| 9ms        | 8.991          | 3315             |
	| 12ms       | 12.935         | 2328             |
	| 22ms       | 16.031         | 1915             |
	| 32ms       | 18.608         | 1622             |

	base_slice: the value of base_slice in ms
	avg-run (msec): average time of the stressor threads got on cpu before
	it got preempted
	context-switches: number of context switches for the stress-ng process

Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/20240320173815.927637-2-mchauras@linux.ibm.com
---
 Documentation/scheduler/sched-design-CFS.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/scheduler/sched-design-CFS.rst b/Documentation/scheduler/sched-design-CFS.rst
index 6cffffe..e030876 100644
--- a/Documentation/scheduler/sched-design-CFS.rst
+++ b/Documentation/scheduler/sched-design-CFS.rst
@@ -100,6 +100,9 @@ which can be used to tune the scheduler from "desktop" (i.e., low latencies) to
 "server" (i.e., good batching) workloads.  It defaults to a setting suitable
 for desktop workloads.  SCHED_BATCH is handled by the CFS scheduler module too.
 
+In case CONFIG_HZ results in base_slice_ns < TICK_NSEC, the value of
+base_slice_ns will have little to no impact on the workloads.
+
 Due to its design, the CFS scheduler is not prone to any of the "attacks" that
 exist today against the heuristics of the stock scheduler: fiftyp.c, thud.c,
 chew.c, ring-test.c, massive_intr.c all work fine and do not impact

