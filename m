Return-Path: <linux-kernel+bounces-100210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B068B87938F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28EB1C218DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BFA7C09F;
	Tue, 12 Mar 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s9ajIQw1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="39c86fmi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664AD7B3D5;
	Tue, 12 Mar 2024 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244829; cv=none; b=iqmU2yKxjrH5ORkTlTscuqby1pa+LAE54/Srg3M3Y6fst8KW1pSjf4+UM2sItrJlk127oE04oelvHlQy9B9FBr9I1jPTEmoVRRtNsV/HUzLj8Cn27Pb1BDkqeaE8sau2W8XXBbkL9XHFNK3LNUbcmRw5NMlpnJgRIm6/R2GYdY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244829; c=relaxed/simple;
	bh=OnJGH04dr6GQSgdPP41bmGK1hj8+Xh47+yG6OgJwSOY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BFOIXOI/dD3ixqfSojXJWkQZWYH/CP6MYLwOeIsPqaCDvnC4QDbRlUl8cd9uWHKkRqJaz9duvndgKoU+nkLyHrOlac4QXZ6Q+FEGadEVklTYw1GvJHq5a2YrIcSKS5UJzviKTmJrDC21WSGkgAducwaX9wfBGXugrox3cvnu40c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s9ajIQw1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=39c86fmi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244825;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BEOJb6YYLFPYL08m4z9G00ynRN5ky9TSOKYt4X+HnAE=;
	b=s9ajIQw1GqWNriV53x8kFzJEnP8f7ts0QCpKqkBuGMpQhMqhb0U13j/O73Cp0d4rvyqezk
	7stBh5mmlagSjxfhxS0VenNDVDhOX7ddQ1osgufUTVwg5Nb8SRUwBi7T8ZWw3QWjcxhdYB
	qHMgS3hn22Puaif81bY3ZWlJsWS9YPIT1M6n8CDksBFgYBJUiRMcRP33MD4t9/va3MdNFN
	lbsdMvSammoOJC7cMXNPk93MOZ5gngFHtfRSyfIq+uZvaitlx/62j4AztZxw0Q/N4tnVBb
	NvnW698bqUtZ1xMH3iA1E6BILEXReu8/knHfMCVWCgaV+wR6Q7nMX9kA6ZJvUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244825;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BEOJb6YYLFPYL08m4z9G00ynRN5ky9TSOKYt4X+HnAE=;
	b=39c86fmiICD6XN26uCJpyJ3cTpVH6n/TNuc9QhHGOdGIQYqqpgF4Sqy0nq2/d3BnKF+5Ec
	J6VF9BUqZdJqhXCA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balancing: Rename rebalance_domains() =>
 sched_balance_domains()
Cc: Ingo Molnar <mingo@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240308111819.1101550-5-mingo@kernel.org>
References: <20240308111819.1101550-5-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024482461.398.1827297595057907989.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     14ff4dbd34f46cc6b6105f549983321241ccbba9
Gitweb:        https://git.kernel.org/tip/14ff4dbd34f46cc6b6105f549983321241c=
cbba9
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 08 Mar 2024 12:18:10 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 11:59:59 +01:00

sched/balancing: Rename rebalance_domains() =3D> sched_balance_domains()

Standardize scheduler load-balancing function names on the
sched_balance_() prefix.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://lore.kernel.org/r/20240308111819.1101550-5-mingo@kernel.org
---
 Documentation/scheduler/sched-domains.rst                    | 2 +-
 Documentation/translations/zh_CN/scheduler/sched-domains.rst | 2 +-
 arch/arm/kernel/topology.c                                   | 2 +-
 kernel/sched/fair.c                                          | 8 +++----
 kernel/sched/sched.h                                         | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/schedu=
ler/sched-domains.rst
index c7ea05f..5d8e8b8 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -34,7 +34,7 @@ out of balance are tasks moved between groups.
 In kernel/sched/core.c, sched_balance_trigger() is run periodically on each =
CPU
 through sched_tick(). It raises a softirq after the next regularly scheduled
 rebalancing event for the current runqueue has arrived. The actual load
-balancing workhorse, sched_balance_softirq()->rebalance_domains(), is then r=
un
+balancing workhorse, sched_balance_softirq()->sched_balance_domains(), is th=
en run
 in softirq context (SCHED_SOFTIRQ).
=20
 The latter function takes two arguments: the runqueue of current CPU and whe=
ther
diff --git a/Documentation/translations/zh_CN/scheduler/sched-domains.rst b/D=
ocumentation/translations/zh_CN/scheduler/sched-domains.rst
index 1a8587a..e6590fd 100644
--- a/Documentation/translations/zh_CN/scheduler/sched-domains.rst
+++ b/Documentation/translations/zh_CN/scheduler/sched-domains.rst
@@ -36,7 +36,7 @@ CPU=E5=85=B1=E4=BA=AB=E3=80=82=E4=BB=BB=E6=84=8F=E4=B8=A4=
=E4=B8=AA=E7=BB=84=E7=9A=84CPU=E6=8E=A9=E7=A0=81=E7=9A=84=E4=BA=A4=E9=9B=86=
=E4=B8=8D=E4=B8=80=E5=AE=9A=E4=B8=BA=E7=A9=BA=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=
=98=AF=E8=BF=99=EF=BF=BD
=20
 =E5=9C=A8kernel/sched/core.c=E4=B8=AD=EF=BC=8Csched_balance_trigger()=E5=9C=
=A8=E6=AF=8F=E4=B8=AACPU=E4=B8=8A=E9=80=9A=E8=BF=87sched_tick()
 =E5=91=A8=E6=9C=9F=E6=89=A7=E8=A1=8C=E3=80=82=E5=9C=A8=E5=BD=93=E5=89=8D=E8=
=BF=90=E8=A1=8C=E9=98=9F=E5=88=97=E4=B8=8B=E4=B8=80=E4=B8=AA=E5=AE=9A=E6=9C=
=9F=E8=B0=83=E5=BA=A6=E5=86=8D=E5=B9=B3=E8=A1=A1=E4=BA=8B=E4=BB=B6=E5=88=B0=
=E8=BE=BE=E5=90=8E=EF=BC=8C=E5=AE=83=E5=BC=95=E5=8F=91=E4=B8=80=E4=B8=AA=E8=
=BD=AF=E4=B8=AD=E6=96=AD=E3=80=82=E8=B4=9F=E8=BD=BD=E5=9D=87=E8=A1=A1=E7=9C=
=9F=E6=AD=A3
-=E7=9A=84=E5=B7=A5=E4=BD=9C=E7=94=B1sched_balance_softirq()->rebalance_domai=
ns()=E5=AE=8C=E6=88=90=EF=BC=8C=E5=9C=A8=E8=BD=AF=E4=B8=AD=E6=96=AD=E4=B8=8A=
=E4=B8=8B=E6=96=87=E4=B8=AD=E6=89=A7=E8=A1=8C
+=E7=9A=84=E5=B7=A5=E4=BD=9C=E7=94=B1sched_balance_softirq()->sched_balance_d=
omains()=E5=AE=8C=E6=88=90=EF=BC=8C=E5=9C=A8=E8=BD=AF=E4=B8=AD=E6=96=AD=E4=B8=
=8A=E4=B8=8B=E6=96=87=E4=B8=AD=E6=89=A7=E8=A1=8C
 =EF=BC=88SCHED_SOFTIRQ=EF=BC=89=E3=80=82
=20
 =E5=90=8E=E4=B8=80=E4=B8=AA=E5=87=BD=E6=95=B0=E6=9C=89=E4=B8=A4=E4=B8=AA=E5=
=85=A5=E5=8F=82=EF=BC=9A=E5=BD=93=E5=89=8DCPU=E7=9A=84=E8=BF=90=E8=A1=8C=E9=
=98=9F=E5=88=97=E3=80=81=E5=AE=83=E5=9C=A8sched_tick()=E8=B0=83=E7=94=A8=E6=
=97=B6=E6=98=AF=E5=90=A6=E7=A9=BA=E9=97=B2=E3=80=82=E5=87=BD=E6=95=B0=E4=BC=
=9A=E4=BB=8E
diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index ef0058d..2336ee2 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -42,7 +42,7 @@
  * can take this difference into account during load balance. A per cpu
  * structure is preferred because each CPU updates its own cpu_capacity field
  * during the load balance except for idle cores. One idle core is selected
- * to run the rebalance_domains for all idle cores and the cpu_capacity can =
be
+ * to run the sched_balance_domains for all idle cores and the cpu_capacity =
can be
  * updated during this sequence.
  */
=20
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e377b67..330788b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11685,7 +11685,7 @@ static inline bool update_newidle_cost(struct sched_d=
omain *sd, u64 cost)
  *
  * Balancing parameters are set up in init_sched_domains.
  */
-static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
+static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 {
 	int continue_balancing =3D 1;
 	int cpu =3D rq->cpu;
@@ -12161,7 +12161,7 @@ static void _nohz_idle_balance(struct rq *this_rq, un=
signed int flags)
 			rq_unlock_irqrestore(rq, &rf);
=20
 			if (flags & NOHZ_BALANCE_KICK)
-				rebalance_domains(rq, CPU_IDLE);
+				sched_balance_domains(rq, CPU_IDLE);
 		}
=20
 		if (time_after(next_balance, rq->next_balance)) {
@@ -12422,7 +12422,7 @@ static __latent_entropy void sched_balance_softirq(st=
ruct softirq_action *h)
 	/*
 	 * If this CPU has a pending NOHZ_BALANCE_KICK, then do the
 	 * balancing on behalf of the other idle CPUs whose ticks are
-	 * stopped. Do nohz_idle_balance *before* rebalance_domains to
+	 * stopped. Do nohz_idle_balance *before* sched_balance_domains to
 	 * give the idle CPUs a chance to load balance. Else we may
 	 * load balance only within the local sched_domain hierarchy
 	 * and abort nohz_idle_balance altogether if we pull some load.
@@ -12432,7 +12432,7 @@ static __latent_entropy void sched_balance_softirq(st=
ruct softirq_action *h)
=20
 	/* normal load balance */
 	update_blocked_averages(this_rq->cpu);
-	rebalance_domains(this_rq, idle);
+	sched_balance_domains(this_rq, idle);
 }
=20
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5b0ddb0..41024c1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2904,7 +2904,7 @@ extern void cfs_bandwidth_usage_dec(void);
 #define NOHZ_NEWILB_KICK_BIT	2
 #define NOHZ_NEXT_KICK_BIT	3
=20
-/* Run rebalance_domains() */
+/* Run sched_balance_domains() */
 #define NOHZ_BALANCE_KICK	BIT(NOHZ_BALANCE_KICK_BIT)
 /* Update blocked load */
 #define NOHZ_STATS_KICK		BIT(NOHZ_STATS_KICK_BIT)

