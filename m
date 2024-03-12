Return-Path: <linux-kernel+bounces-100211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B16879392
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1151C208DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7CE7C0BE;
	Tue, 12 Mar 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d9GsDhDg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m5cboKN+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2BB7BB03;
	Tue, 12 Mar 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244830; cv=none; b=KEXOkTC2mUTqpyQiAcLYlB4MycQx3QIWzJ2rTX7cFY3v5BvpafZlt69qZvL+GG/HZdg5Uhs5muDHg3kN6ft0QCwxca/nqqgb98eka74YuUBSsjI0BMbMVwl/UNPuVQJh5SMArKShSIlI4h48fRm5EsvNADJEAAJQzUHN4rx1b9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244830; c=relaxed/simple;
	bh=giHmKvDsWcqEJ7c0Fg5xY3yX+fxvR3SyDiBRLZ+XlZI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=t4KPQnxQCgmQSldwFpXw0WkA0iMM33LJR3fUa113JVHco30G9tvhv98d1TYQoxNAqomI/3REM0mtjFtcZOTqTOu0/fMyAsOYXaubbOJzBJvBiCJO9pmvkdARW1CNl3hVBr9s35ZL0VS2feQKGdXk0brwSVwuRb0mQlaxrU3y9Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d9GsDhDg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m5cboKN+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244827;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=21U9axGQNCf/rimKXOLzd02b+8VPexc/dAGO3cO4fuQ=;
	b=d9GsDhDgf7NiulBZhkFXZcgpwi3w7tZqKkjHXxN4K1PM36hVpxNJ7zgAeZiU6I4QJ6Bn7e
	gs3cWYUhhJU68wnBCgEirUwU4Z1q4mokQPelXoeB+UA79ByVcfBTavnd/HBf+KNOOQcrTg
	h/WEnisXKVV3uGgQLXdWolIIBTIGwTbUF2VbhG3AHHOzMzvPpkx5cUAWx1l7SkpvEaOk2u
	A2r6hTUI7UI1SWW/le7HzFaksN6CdGNE0nYTlwkEmZBg9XcJil1pjOaFUX9CZPUtRSM46D
	EYL416ZKY1MDVhCyFVd1+FUwH5M0IMuQmANygeRZUID4CnQbYc2pmTgnwZ8nAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244827;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=21U9axGQNCf/rimKXOLzd02b+8VPexc/dAGO3cO4fuQ=;
	b=m5cboKN+ZiHSunZ/vIKXBpYFoIIt7ED7/JEbatDyA+4xBs71/QTRU28m70l0l+pYDzWDlv
	mkgcurcmEE6pLIBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balancing: Rename trigger_load_balance() =>
 sched_balance_trigger()
Cc: Ingo Molnar <mingo@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240308111819.1101550-4-mingo@kernel.org>
References: <20240308111819.1101550-4-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024482574.398.13291073080106604126.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     983be0628c061989b6cc175d2f5e429b40699fbb
Gitweb:        https://git.kernel.org/tip/983be0628c061989b6cc175d2f5e429b406=
99fbb
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 08 Mar 2024 12:18:09 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 11:59:59 +01:00

sched/balancing: Rename trigger_load_balance() =3D> sched_balance_trigger()

Standardize scheduler load-balancing function names on the
sched_balance_() prefix.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://lore.kernel.org/r/20240308111819.1101550-4-mingo@kernel.org
---
 Documentation/scheduler/sched-domains.rst                    | 2 +-
 Documentation/translations/zh_CN/scheduler/sched-domains.rst | 2 +-
 kernel/sched/core.c                                          | 2 +-
 kernel/sched/fair.c                                          | 2 +-
 kernel/sched/sched.h                                         | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/schedu=
ler/sched-domains.rst
index 541d6c6..c7ea05f 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -31,7 +31,7 @@ is treated as one entity. The load of a group is defined as=
 the sum of the
 load of each of its member CPUs, and only when the load of a group becomes
 out of balance are tasks moved between groups.
=20
-In kernel/sched/core.c, trigger_load_balance() is run periodically on each C=
PU
+In kernel/sched/core.c, sched_balance_trigger() is run periodically on each =
CPU
 through sched_tick(). It raises a softirq after the next regularly scheduled
 rebalancing event for the current runqueue has arrived. The actual load
 balancing workhorse, sched_balance_softirq()->rebalance_domains(), is then r=
un
diff --git a/Documentation/translations/zh_CN/scheduler/sched-domains.rst b/D=
ocumentation/translations/zh_CN/scheduler/sched-domains.rst
index fa0c0bc..1a8587a 100644
--- a/Documentation/translations/zh_CN/scheduler/sched-domains.rst
+++ b/Documentation/translations/zh_CN/scheduler/sched-domains.rst
@@ -34,7 +34,7 @@ CPU=E5=85=B1=E4=BA=AB=E3=80=82=E4=BB=BB=E6=84=8F=E4=B8=A4=
=E4=B8=AA=E7=BB=84=E7=9A=84CPU=E6=8E=A9=E7=A0=81=E7=9A=84=E4=BA=A4=E9=9B=86=
=E4=B8=8D=E4=B8=80=E5=AE=9A=E4=B8=BA=E7=A9=BA=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=
=98=AF=E8=BF=99=EF=BF=BD
 =E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E7=9A=84=E8=B4=9F=E8=BD=BD=E5=9D=87=E8=
=A1=A1=E5=8F=91=E7=94=9F=E5=9C=A8=E8=B0=83=E5=BA=A6=E7=BB=84=E4=B8=AD=E3=80=
=82=E4=B9=9F=E5=B0=B1=E6=98=AF=E8=AF=B4=EF=BC=8C=E6=AF=8F=E4=B8=AA=E7=BB=84=
=E8=A2=AB=E8=A7=86=E4=B8=BA=E4=B8=80=E4=B8=AA=E5=AE=9E=E4=BD=93=E3=80=82=E7=
=BB=84=E7=9A=84=E8=B4=9F=E8=BD=BD=E8=A2=AB=E5=AE=9A=E4=B9=89=E4=B8=BA=E5=AE=83
 =E7=AE=A1=E8=BE=96=E7=9A=84=E6=AF=8F=E4=B8=AACPU=E7=9A=84=E8=B4=9F=E8=BD=BD=
=E4=B9=8B=E5=92=8C=E3=80=82=E4=BB=85=E5=BD=93=E7=BB=84=E7=9A=84=E8=B4=9F=E8=
=BD=BD=E4=B8=8D=E5=9D=87=E8=A1=A1=E5=90=8E=EF=BC=8C=E4=BB=BB=E5=8A=A1=E6=89=
=8D=E5=9C=A8=E7=BB=84=E4=B9=8B=E9=97=B4=E5=8F=91=E7=94=9F=E8=BF=81=E7=A7=BB=
=E3=80=82
=20
-=E5=9C=A8kernel/sched/core.c=E4=B8=AD=EF=BC=8Ctrigger_load_balance()=E5=9C=
=A8=E6=AF=8F=E4=B8=AACPU=E4=B8=8A=E9=80=9A=E8=BF=87sched_tick()
+=E5=9C=A8kernel/sched/core.c=E4=B8=AD=EF=BC=8Csched_balance_trigger()=E5=9C=
=A8=E6=AF=8F=E4=B8=AACPU=E4=B8=8A=E9=80=9A=E8=BF=87sched_tick()
 =E5=91=A8=E6=9C=9F=E6=89=A7=E8=A1=8C=E3=80=82=E5=9C=A8=E5=BD=93=E5=89=8D=E8=
=BF=90=E8=A1=8C=E9=98=9F=E5=88=97=E4=B8=8B=E4=B8=80=E4=B8=AA=E5=AE=9A=E6=9C=
=9F=E8=B0=83=E5=BA=A6=E5=86=8D=E5=B9=B3=E8=A1=A1=E4=BA=8B=E4=BB=B6=E5=88=B0=
=E8=BE=BE=E5=90=8E=EF=BC=8C=E5=AE=83=E5=BC=95=E5=8F=91=E4=B8=80=E4=B8=AA=E8=
=BD=AF=E4=B8=AD=E6=96=AD=E3=80=82=E8=B4=9F=E8=BD=BD=E5=9D=87=E8=A1=A1=E7=9C=
=9F=E6=AD=A3
 =E7=9A=84=E5=B7=A5=E4=BD=9C=E7=94=B1sched_balance_softirq()->rebalance_domai=
ns()=E5=AE=8C=E6=88=90=EF=BC=8C=E5=9C=A8=E8=BD=AF=E4=B8=AD=E6=96=AD=E4=B8=8A=
=E4=B8=8B=E6=96=87=E4=B8=AD=E6=89=A7=E8=A1=8C
 =EF=BC=88SCHED_SOFTIRQ=EF=BC=89=E3=80=82
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 71b7a08..929fce6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5700,7 +5700,7 @@ void sched_tick(void)
=20
 #ifdef CONFIG_SMP
 	rq->idle_balance =3D idle_cpu(cpu);
-	trigger_load_balance(rq);
+	sched_balance_trigger(rq);
 #endif
 }
=20
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 953f39d..e377b67 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12438,7 +12438,7 @@ static __latent_entropy void sched_balance_softirq(st=
ruct softirq_action *h)
 /*
  * Trigger the SCHED_SOFTIRQ if it is time to do periodic load balancing.
  */
-void trigger_load_balance(struct rq *rq)
+void sched_balance_trigger(struct rq *rq)
 {
 	/*
 	 * Don't need to rebalance while attached to NULL domain or
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d224267..5b0ddb0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2397,7 +2397,7 @@ extern struct task_struct *pick_next_task_idle(struct r=
q *rq);
=20
 extern void update_group_capacity(struct sched_domain *sd, int cpu);
=20
-extern void trigger_load_balance(struct rq *rq);
+extern void sched_balance_trigger(struct rq *rq);
=20
 extern void set_cpus_allowed_common(struct task_struct *p, struct affinity_c=
ontext *ctx);
=20

