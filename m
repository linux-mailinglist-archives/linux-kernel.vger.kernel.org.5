Return-Path: <linux-kernel+bounces-100213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4BD879396
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225541F2116E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94977CF15;
	Tue, 12 Mar 2024 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xh82bQGs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9OgPXBfz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9C17C09D;
	Tue, 12 Mar 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244831; cv=none; b=LCh1atI5dB0mzt0iNazeCXPHvmkZcsh0qYUOgNQyARb2yqE7GaLbE8EgYALbwMtxYmYzWv9ATo7unj4jdWoRz+GdmWBxcyzyCFdQoLvsoJkmbtlE0QP0ecF7DNnuhevNy162EVHLGQEv6JjAyNK6GEsRHyBZ2oxP5ejOrxV7eAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244831; c=relaxed/simple;
	bh=M+zmmFhkwXVItkJPQOI8V1Yhs+QIiDjZ4rXJsBYNOS0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EDLKzAceDhHm/wIxYgQcVZb16JHEtFhdt5PjMUiVl5s//WJl8Pm8xgZ4avLjSm7GJ+uBis0ztXmQYodImoJtPH1zUG0Q8FHPnXxMRwiWjeuvx7Tpxs72GYoBgyZt/UlKrg3AgJgId0XyTi9mLWXoDhNx7NdJgbPt2gpaReNvAVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xh82bQGs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9OgPXBfz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gjb3Tb+F/2cJ2Vyi2YEvYcaNZ/OpFLTHxakK6zsGQWE=;
	b=Xh82bQGs/TOd0wgBID7RmPKBr83Odw2i6k7Lnh95IWxW6qznKQKYAWLrY/dAB+B8P0YdMG
	y6JJvC/uOXF0iIf/aVEeiX+gmN4bGk9E5mtPqyqy6aUuiMtKIzaQio4HfffjUmKmOYxA3A
	CYmfnFxaeDhMYrnX3hC0zzISVbonmnMu0r4t6ITTT2x/DwTEEFG/yH7cr1D/c6o5KDjJ9H
	tQnLo/+C7z3MxmK4byggDl22OacptFU+JjWWgwk+sU5Cm6+IOvE+pc25a2KKdlskou0I39
	wh/sZaZIibtY0h2nG5sYXfNNoeK89WrgeA4F+XbN501A68syOFCWm/+OAdG/bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gjb3Tb+F/2cJ2Vyi2YEvYcaNZ/OpFLTHxakK6zsGQWE=;
	b=9OgPXBfzJl6kmxjeYh54yKiMPmcjcizPl60lfno02m+Gm7MZdgzvkwCM/3Ph3S3fyBXEUg
	ezX8Vxt0B8giA7Cg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balancing: Rename run_rebalance_domains() =>
 sched_balance_softirq()
Cc: Ingo Molnar <mingo@kernel.org>, Valentin Schneider <vschneid@redhat.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240308111819.1101550-2-mingo@kernel.org>
References: <20240308111819.1101550-2-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024482792.398.1227132875419804153.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     70a27d6d1b19392a23bb4a41de7788fbc539f18d
Gitweb:        https://git.kernel.org/tip/70a27d6d1b19392a23bb4a41de7788fbc53=
9f18d
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 08 Mar 2024 12:18:07 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 11:59:59 +01:00

sched/balancing: Rename run_rebalance_domains() =3D> sched_balance_softirq()

run_rebalance_domains() is a misnomer, as it doesn't only
run rebalance_domains(), but since the introduction of the
NOHZ code it also runs nohz_idle_balance().

Rename it to sched_balance_softirq(), reflecting its more
generic purpose and that it's a softirq handler.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://lore.kernel.org/r/20240308111819.1101550-2-mingo@kernel.org
---
 Documentation/scheduler/sched-domains.rst                    | 2 +-
 Documentation/translations/zh_CN/scheduler/sched-domains.rst | 2 +-
 kernel/sched/fair.c                                          | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/schedu=
ler/sched-domains.rst
index e57ad28..6577b06 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -34,7 +34,7 @@ out of balance are tasks moved between groups.
 In kernel/sched/core.c, trigger_load_balance() is run periodically on each C=
PU
 through scheduler_tick(). It raises a softirq after the next regularly sched=
uled
 rebalancing event for the current runqueue has arrived. The actual load
-balancing workhorse, run_rebalance_domains()->rebalance_domains(), is then r=
un
+balancing workhorse, sched_balance_softirq()->rebalance_domains(), is then r=
un
 in softirq context (SCHED_SOFTIRQ).
=20
 The latter function takes two arguments: the runqueue of current CPU and whe=
ther
diff --git a/Documentation/translations/zh_CN/scheduler/sched-domains.rst b/D=
ocumentation/translations/zh_CN/scheduler/sched-domains.rst
index e814d4c..fbc3266 100644
--- a/Documentation/translations/zh_CN/scheduler/sched-domains.rst
+++ b/Documentation/translations/zh_CN/scheduler/sched-domains.rst
@@ -36,7 +36,7 @@ CPU=E5=85=B1=E4=BA=AB=E3=80=82=E4=BB=BB=E6=84=8F=E4=B8=A4=
=E4=B8=AA=E7=BB=84=E7=9A=84CPU=E6=8E=A9=E7=A0=81=E7=9A=84=E4=BA=A4=E9=9B=86=
=E4=B8=8D=E4=B8=80=E5=AE=9A=E4=B8=BA=E7=A9=BA=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=
=98=AF=E8=BF=99=EF=BF=BD
=20
 =E5=9C=A8kernel/sched/core.c=E4=B8=AD=EF=BC=8Ctrigger_load_balance()=E5=9C=
=A8=E6=AF=8F=E4=B8=AACPU=E4=B8=8A=E9=80=9A=E8=BF=87scheduler_tick()
 =E5=91=A8=E6=9C=9F=E6=89=A7=E8=A1=8C=E3=80=82=E5=9C=A8=E5=BD=93=E5=89=8D=E8=
=BF=90=E8=A1=8C=E9=98=9F=E5=88=97=E4=B8=8B=E4=B8=80=E4=B8=AA=E5=AE=9A=E6=9C=
=9F=E8=B0=83=E5=BA=A6=E5=86=8D=E5=B9=B3=E8=A1=A1=E4=BA=8B=E4=BB=B6=E5=88=B0=
=E8=BE=BE=E5=90=8E=EF=BC=8C=E5=AE=83=E5=BC=95=E5=8F=91=E4=B8=80=E4=B8=AA=E8=
=BD=AF=E4=B8=AD=E6=96=AD=E3=80=82=E8=B4=9F=E8=BD=BD=E5=9D=87=E8=A1=A1=E7=9C=
=9F=E6=AD=A3
-=E7=9A=84=E5=B7=A5=E4=BD=9C=E7=94=B1run_rebalance_domains()->rebalance_domai=
ns()=E5=AE=8C=E6=88=90=EF=BC=8C=E5=9C=A8=E8=BD=AF=E4=B8=AD=E6=96=AD=E4=B8=8A=
=E4=B8=8B=E6=96=87=E4=B8=AD=E6=89=A7=E8=A1=8C
+=E7=9A=84=E5=B7=A5=E4=BD=9C=E7=94=B1sched_balance_softirq()->rebalance_domai=
ns()=E5=AE=8C=E6=88=90=EF=BC=8C=E5=9C=A8=E8=BD=AF=E4=B8=AD=E6=96=AD=E4=B8=8A=
=E4=B8=8B=E6=96=87=E4=B8=AD=E6=89=A7=E8=A1=8C
 =EF=BC=88SCHED_SOFTIRQ=EF=BC=89=E3=80=82
=20
 =E5=90=8E=E4=B8=80=E4=B8=AA=E5=87=BD=E6=95=B0=E6=9C=89=E4=B8=A4=E4=B8=AA=E5=
=85=A5=E5=8F=82=EF=BC=9A=E5=BD=93=E5=89=8DCPU=E7=9A=84=E8=BF=90=E8=A1=8C=E9=
=98=9F=E5=88=97=E3=80=81=E5=AE=83=E5=9C=A8scheduler_tick()=E8=B0=83=E7=94=A8=
=E6=97=B6=E6=98=AF=E5=90=A6=E7=A9=BA=E9=97=B2=E3=80=82=E5=87=BD=E6=95=B0=E4=
=BC=9A=E4=BB=8E
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 116a640..953f39d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12415,7 +12415,7 @@ out:
  * - indirectly from a remote scheduler_tick() for NOHZ idle balancing
  *   through the SMP cross-call nohz_csd_func()
  */
-static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
+static __latent_entropy void sched_balance_softirq(struct softirq_action *h)
 {
 	struct rq *this_rq =3D this_rq();
 	enum cpu_idle_type idle =3D this_rq->idle_balance;
@@ -13216,7 +13216,7 @@ __init void init_sched_fair_class(void)
 #endif
 	}
=20
-	open_softirq(SCHED_SOFTIRQ, run_rebalance_domains);
+	open_softirq(SCHED_SOFTIRQ, sched_balance_softirq);
=20
 #ifdef CONFIG_NO_HZ_COMMON
 	nohz.next_balance =3D jiffies;

