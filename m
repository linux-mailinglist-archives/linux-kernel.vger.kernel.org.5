Return-Path: <linux-kernel+bounces-10493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2542481D502
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6771C21417
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3461D687;
	Sat, 23 Dec 2023 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qiv5nX7y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NUuPnOxH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DFE12E5B;
	Sat, 23 Dec 2023 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 23 Dec 2023 16:09:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703347794;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e1rv9KWAedXf+6MAE+TP7MgYC9JX0sCJ0CVk2+10yHE=;
	b=qiv5nX7yq8qw0Vvi3370RpMkVv5TJ0FU9jHoRs/E8RXSePVX7bNYqNsJgfNv6TTkyVusUm
	uYn9jIjekTXg6Ra52xPoVul3nkefXp6brD6Nj08cs0XUTrszXelaFA5JQcUHbYytzoABG7
	X2RgIEVECQwldYBbFet43WGg/7V8F368awmZWJoH8P3XpnPG02ude50xeNDaAqfpkTPvAD
	6Bcz8dwwm2Pmnmk4HleVIkDiSSCDTWAZ7dBfJDP8XbCCEMLdWFaWIp0OzRt+EkgT5WaNJY
	frjKugRbZilfpDTzSQT+TITZdv6xzZuHF7qXOQkuf/rjtNwG79p+sG2fJ3qbGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703347794;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e1rv9KWAedXf+6MAE+TP7MgYC9JX0sCJ0CVk2+10yHE=;
	b=NUuPnOxHgdPRlBc9j9feRVpirDY/GQ3UQQWND4SWudco3yVNkg2cblaG58qX43aoinZki0
	580XVmNthJ4EynBg==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] energy_model: Use a fixed reference frequency
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231211104855.558096-5-vincent.guittot@linaro.org>
References: <20231211104855.558096-5-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170334779328.398.1653649197000520195.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     15cbbd1d317e07b4e5c6aca5d4c5579539a82784
Gitweb:        https://git.kernel.org/tip/15cbbd1d317e07b4e5c6aca5d4c5579539a82784
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 11 Dec 2023 11:48:52 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 23 Dec 2023 15:52:35 +01:00

energy_model: Use a fixed reference frequency

The last item of a performance domain is not always the performance point
that has been used to compute CPU's capacity. This can lead to different
target frequency compared with other part of the system like schedutil and
would result in wrong energy estimation.

A new arch_scale_freq_ref() is available to return a fixed and coherent
frequency reference that can be used when computing the CPU's frequency
for an level of utilization. Use this function to get this reference
frequency.

Energy model is never used without defining arch_scale_freq_ref() but
can be compiled. Define a default arch_scale_freq_ref() returning 0
in such case.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lore.kernel.org/r/20231211104855.558096-5-vincent.guittot@linaro.org
---
 include/linux/energy_model.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index adec808..88d91e0 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -224,7 +224,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 				unsigned long max_util, unsigned long sum_util,
 				unsigned long allowed_cpu_cap)
 {
-	unsigned long freq, scale_cpu;
+	unsigned long freq, ref_freq, scale_cpu;
 	struct em_perf_state *ps;
 	int cpu;
 
@@ -241,10 +241,10 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 */
 	cpu = cpumask_first(to_cpumask(pd->cpus));
 	scale_cpu = arch_scale_cpu_capacity(cpu);
-	ps = &pd->table[pd->nr_perf_states - 1];
+	ref_freq = arch_scale_freq_ref(cpu);
 
 	max_util = min(max_util, allowed_cpu_cap);
-	freq = map_util_freq(max_util, ps->frequency, scale_cpu);
+	freq = map_util_freq(max_util, ref_freq, scale_cpu);
 
 	/*
 	 * Find the lowest performance state of the Energy Model above the

