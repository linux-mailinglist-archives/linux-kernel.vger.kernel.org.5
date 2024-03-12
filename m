Return-Path: <linux-kernel+bounces-100209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86903879390
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1285D1F215D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA897C09C;
	Tue, 12 Mar 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ze3uIRQD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2MZYE/Si"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B557AE52;
	Tue, 12 Mar 2024 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244828; cv=none; b=Nh0C5Sx2t1hHUeYv4zl8WDTaEB9Wk603CMxh++IkloadLsF6EdzIlulTb/YvcTkcSWZtEYH6DZqTht5XQcLQZyOhkk+qL/+zknM048rafSYt7lGSrvmmdDJsY9ebCLE0KUqSl6gBh1Rqcfr8NPjaibMbIrPd9yZ0Kc/t3PRr9KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244828; c=relaxed/simple;
	bh=U6qYQvqMl+XRFzUVhnXHJKBaxZHmCxNdPpYHm4YGrug=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z8tiTfQ97Me/p/or48g9q9rzdeXo97q9XjcxQyu12uCXM6ovKcYlclNrkHJY+a7V5E3T3mkH6QHSbFm2O5c3/HgP1MQmwCzuUO4JiuaGj789osOE7EpLSXRZ4StddrLWLNfSi5osb0m4Om9ym0yjGAN3KzGUcNT3fOnYLrNQDrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ze3uIRQD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2MZYE/Si; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244824;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4ZKzWYIIM4yr/m3aj6K/eqDcwgml3M/R9QbdUnTisg=;
	b=ze3uIRQD5650pnr81+FeJqlyuzkHcDVAvupq/u7IokrgDCRRJCJHWMC2FZ7tLZhbxxAJnI
	rSq3XTyip+3rVMrKXdGw9wXC6vtJI1YAJzRbK3WUSuRyqKCf8pMaKi6/y01U5Z67cmJMxq
	lQsZDr3i+33iJC9MSQjQcQUrJOKfz0dw7DmMXE7IQvCpQl+w1jmZAfda/1G/phWIpAw1JN
	4FTHApLhntGCSfjkyVVb9+3spFpoF5v2o4cqpKQiQ9emdiORKZzr+ZtgMY5Q0AUVRV9mDk
	4ZP6BeqJPkXfcFFjXBYbL4QH4swbRVZptnTyq00kJOS3n7ifwTt5Mha0A9Y+bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244824;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4ZKzWYIIM4yr/m3aj6K/eqDcwgml3M/R9QbdUnTisg=;
	b=2MZYE/SiQkTKkYfu3JM3zChp8vyXuzZC6BxlclNrYr4oBDzI3CV1/zCHraeoOH5Y0IpSzZ
	s8ZIc1TeXbCSpDDQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balancing: Rename load_balance() =>
 sched_balance_rq()
Cc: Ingo Molnar <mingo@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240308111819.1101550-6-mingo@kernel.org>
References: <20240308111819.1101550-6-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024482322.398.1290264485360162017.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4c3e509ea9f249458e8692f8298cceac73105948
Gitweb:        https://git.kernel.org/tip/4c3e509ea9f249458e8692f8298cceac731=
05948
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 08 Mar 2024 12:18:11 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 12:00:00 +01:00

sched/balancing: Rename load_balance() =3D> sched_balance_rq()

Standardize scheduler load-balancing function names on the
sched_balance_() prefix.

Also load_balance() has become somewhat of a misnomer: historically
it was the first and primary load-balancing function that was called,
but with the introduction of sched domains, it's become a lower
layer function that balances runqueues.

Rename it to sched_balance_rq() accordingly.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://lore.kernel.org/r/20240308111819.1101550-6-mingo@kernel.org
---
 Documentation/scheduler/sched-domains.rst                    |  4 +-
 Documentation/scheduler/sched-stats.rst                      | 32 +++----
 Documentation/translations/zh_CN/scheduler/sched-domains.rst |  4 +-
 Documentation/translations/zh_CN/scheduler/sched-stats.rst   | 30 +++----
 include/linux/sched/topology.h                               |  2 +-
 kernel/sched/fair.c                                          | 10 +-
 6 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/schedu=
ler/sched-domains.rst
index 5d8e8b8..5e996fe 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -41,11 +41,11 @@ The latter function takes two arguments: the runqueue of =
current CPU and whether
 the CPU was idle at the time the sched_tick() happened and iterates over all
 sched domains our CPU is on, starting from its base domain and going up the =
->parent
 chain. While doing that, it checks to see if the current domain has exhauste=
d its
-rebalance interval. If so, it runs load_balance() on that domain. It then ch=
ecks
+rebalance interval. If so, it runs sched_balance_rq() on that domain. It the=
n checks
 the parent sched_domain (if it exists), and the parent of the parent and so
 forth.
=20
-Initially, load_balance() finds the busiest group in the current sched domai=
n.
+Initially, sched_balance_rq() finds the busiest group in the current sched d=
omain.
 If it succeeds, it looks for the busiest runqueue of all the CPUs' runqueues=
 in
 that group. If it manages to find such a runqueue, it locks both our initial
 CPU's runqueue and the newly found busiest one and starts moving tasks from =
it
diff --git a/Documentation/scheduler/sched-stats.rst b/Documentation/schedule=
r/sched-stats.rst
index 73c4126..7c2b16c 100644
--- a/Documentation/scheduler/sched-stats.rst
+++ b/Documentation/scheduler/sched-stats.rst
@@ -77,53 +77,53 @@ domain<N> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 1=
6 17 18 19 20 21 22 23=20
=20
 The first field is a bit mask indicating what cpus this domain operates over.
=20
-The next 24 are a variety of load_balance() statistics in grouped into types
+The next 24 are a variety of sched_balance_rq() statistics in grouped into t=
ypes
 of idleness (idle, busy, and newly idle):
=20
-    1)  # of times in this domain load_balance() was called when the
+    1)  # of times in this domain sched_balance_rq() was called when the
         cpu was idle
-    2)  # of times in this domain load_balance() checked but found
+    2)  # of times in this domain sched_balance_rq() checked but found
         the load did not require balancing when the cpu was idle
-    3)  # of times in this domain load_balance() tried to move one or
+    3)  # of times in this domain sched_balance_rq() tried to move one or
         more tasks and failed, when the cpu was idle
     4)  sum of imbalances discovered (if any) with each call to
-        load_balance() in this domain when the cpu was idle
+        sched_balance_rq() in this domain when the cpu was idle
     5)  # of times in this domain pull_task() was called when the cpu
         was idle
     6)  # of times in this domain pull_task() was called even though
         the target task was cache-hot when idle
-    7)  # of times in this domain load_balance() was called but did
+    7)  # of times in this domain sched_balance_rq() was called but did
         not find a busier queue while the cpu was idle
     8)  # of times in this domain a busier queue was found while the
         cpu was idle but no busier group was found
-    9)  # of times in this domain load_balance() was called when the
+    9)  # of times in this domain sched_balance_rq() was called when the
         cpu was busy
-    10) # of times in this domain load_balance() checked but found the
+    10) # of times in this domain sched_balance_rq() checked but found the
         load did not require balancing when busy
-    11) # of times in this domain load_balance() tried to move one or
+    11) # of times in this domain sched_balance_rq() tried to move one or
         more tasks and failed, when the cpu was busy
     12) sum of imbalances discovered (if any) with each call to
-        load_balance() in this domain when the cpu was busy
+        sched_balance_rq() in this domain when the cpu was busy
     13) # of times in this domain pull_task() was called when busy
     14) # of times in this domain pull_task() was called even though the
         target task was cache-hot when busy
-    15) # of times in this domain load_balance() was called but did not
+    15) # of times in this domain sched_balance_rq() was called but did not
         find a busier queue while the cpu was busy
     16) # of times in this domain a busier queue was found while the cpu
         was busy but no busier group was found
=20
-    17) # of times in this domain load_balance() was called when the
+    17) # of times in this domain sched_balance_rq() was called when the
         cpu was just becoming idle
-    18) # of times in this domain load_balance() checked but found the
+    18) # of times in this domain sched_balance_rq() checked but found the
         load did not require balancing when the cpu was just becoming idle
-    19) # of times in this domain load_balance() tried to move one or more
+    19) # of times in this domain sched_balance_rq() tried to move one or mo=
re
         tasks and failed, when the cpu was just becoming idle
     20) sum of imbalances discovered (if any) with each call to
-        load_balance() in this domain when the cpu was just becoming idle
+        sched_balance_rq() in this domain when the cpu was just becoming idle
     21) # of times in this domain pull_task() was called when newly idle
     22) # of times in this domain pull_task() was called even though the
         target task was cache-hot when just becoming idle
-    23) # of times in this domain load_balance() was called but did not
+    23) # of times in this domain sched_balance_rq() was called but did not
         find a busier queue while the cpu was just becoming idle
     24) # of times in this domain a busier queue was found while the cpu
         was just becoming idle but no busier group was found
diff --git a/Documentation/translations/zh_CN/scheduler/sched-domains.rst b/D=
ocumentation/translations/zh_CN/scheduler/sched-domains.rst
index e6590fd..0636316 100644
--- a/Documentation/translations/zh_CN/scheduler/sched-domains.rst
+++ b/Documentation/translations/zh_CN/scheduler/sched-domains.rst
@@ -42,9 +42,9 @@ CPU=E5=85=B1=E4=BA=AB=E3=80=82=E4=BB=BB=E6=84=8F=E4=B8=A4=
=E4=B8=AA=E7=BB=84=E7=9A=84CPU=E6=8E=A9=E7=A0=81=E7=9A=84=E4=BA=A4=E9=9B=86=
=E4=B8=8D=E4=B8=80=E5=AE=9A=E4=B8=BA=E7=A9=BA=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=
=98=AF=E8=BF=99=EF=BF=BD
 =E5=90=8E=E4=B8=80=E4=B8=AA=E5=87=BD=E6=95=B0=E6=9C=89=E4=B8=A4=E4=B8=AA=E5=
=85=A5=E5=8F=82=EF=BC=9A=E5=BD=93=E5=89=8DCPU=E7=9A=84=E8=BF=90=E8=A1=8C=E9=
=98=9F=E5=88=97=E3=80=81=E5=AE=83=E5=9C=A8sched_tick()=E8=B0=83=E7=94=A8=E6=
=97=B6=E6=98=AF=E5=90=A6=E7=A9=BA=E9=97=B2=E3=80=82=E5=87=BD=E6=95=B0=E4=BC=
=9A=E4=BB=8E
 =E5=BD=93=E5=89=8DCPU=E6=89=80=E5=9C=A8=E7=9A=84=E5=9F=BA=E8=B0=83=E5=BA=A6=
=E5=9F=9F=E5=BC=80=E5=A7=8B=E8=BF=AD=E4=BB=A3=E6=89=A7=E8=A1=8C=EF=BC=8C=E5=
=B9=B6=E6=B2=BF=E7=9D=80parent=E6=8C=87=E9=92=88=E9=93=BE=E5=90=91=E4=B8=8A=
=E8=BF=9B=E5=85=A5=E6=9B=B4=E9=AB=98=E5=B1=82=E7=BA=A7=E7=9A=84=E8=B0=83=E5=
=BA=A6=E5=9F=9F=E3=80=82=E5=9C=A8=E8=BF=AD=E4=BB=A3
 =E8=BF=87=E7=A8=8B=E4=B8=AD=EF=BC=8C=E5=87=BD=E6=95=B0=E4=BC=9A=E6=A3=80=E6=
=9F=A5=E5=BD=93=E5=89=8D=E8=B0=83=E5=BA=A6=E5=9F=9F=E6=98=AF=E5=90=A6=E5=B7=
=B2=E7=BB=8F=E8=80=97=E5=B0=BD=E4=BA=86=E5=86=8D=E5=B9=B3=E8=A1=A1=E7=9A=84=
=E6=97=B6=E9=97=B4=E9=97=B4=E9=9A=94=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=98=AF=EF=
=BC=8C=E5=AE=83=E5=9C=A8=E8=AF=A5=E8=B0=83=E5=BA=A6=E5=9F=9F=E8=BF=90=E8=A1=8C
-load_balance()=E3=80=82=E6=8E=A5=E4=B8=8B=E6=9D=A5=E5=AE=83=E6=A3=80=E6=9F=
=A5=E7=88=B6=E8=B0=83=E5=BA=A6=E5=9F=9F=EF=BC=88=E5=A6=82=E6=9E=9C=E5=AD=98=
=E5=9C=A8=EF=BC=89=EF=BC=8C=E5=86=8D=E5=90=8E=E6=9D=A5=E7=88=B6=E8=B0=83=E5=
=BA=A6=E5=9F=9F=E7=9A=84=E7=88=B6=E8=B0=83=E5=BA=A6=E5=9F=9F=EF=BC=8C=E4=BB=
=A5=E6=AD=A4=E7=B1=BB=E6=8E=A8=E3=80=82
+sched_balance_rq()=E3=80=82=E6=8E=A5=E4=B8=8B=E6=9D=A5=E5=AE=83=E6=A3=80=E6=
=9F=A5=E7=88=B6=E8=B0=83=E5=BA=A6=E5=9F=9F=EF=BC=88=E5=A6=82=E6=9E=9C=E5=AD=
=98=E5=9C=A8=EF=BC=89=EF=BC=8C=E5=86=8D=E5=90=8E=E6=9D=A5=E7=88=B6=E8=B0=83=
=E5=BA=A6=E5=9F=9F=E7=9A=84=E7=88=B6=E8=B0=83=E5=BA=A6=E5=9F=9F=EF=BC=8C=E4=
=BB=A5=E6=AD=A4=E7=B1=BB=E6=8E=A8=E3=80=82
=20
-=E8=B5=B7=E5=88=9D=EF=BC=8Cload_balance()=E6=9F=A5=E6=89=BE=E5=BD=93=E5=89=
=8D=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E6=9C=80=E7=B9=81=E5=BF=99=E7=9A=84=
=E8=B0=83=E5=BA=A6=E7=BB=84=E3=80=82=E5=A6=82=E6=9E=9C=E6=88=90=E5=8A=9F=EF=
=BC=8C=E5=9C=A8=E8=AF=A5=E8=B0=83=E5=BA=A6=E7=BB=84=E7=AE=A1=E8=BE=96=E7=9A=
=84=E5=85=A8=E9=83=A8CPU
+=E8=B5=B7=E5=88=9D=EF=BC=8Csched_balance_rq()=E6=9F=A5=E6=89=BE=E5=BD=93=E5=
=89=8D=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E6=9C=80=E7=B9=81=E5=BF=99=E7=9A=
=84=E8=B0=83=E5=BA=A6=E7=BB=84=E3=80=82=E5=A6=82=E6=9E=9C=E6=88=90=E5=8A=9F=
=EF=BC=8C=E5=9C=A8=E8=AF=A5=E8=B0=83=E5=BA=A6=E7=BB=84=E7=AE=A1=E8=BE=96=E7=
=9A=84=E5=85=A8=E9=83=A8CPU
 =E7=9A=84=E8=BF=90=E8=A1=8C=E9=98=9F=E5=88=97=E4=B8=AD=E6=89=BE=E5=87=BA=E6=
=9C=80=E7=B9=81=E5=BF=99=E7=9A=84=E8=BF=90=E8=A1=8C=E9=98=9F=E5=88=97=E3=80=
=82=E5=A6=82=E8=83=BD=E6=89=BE=E5=88=B0=EF=BC=8C=E5=AF=B9=E5=BD=93=E5=89=8D=
=E7=9A=84CPU=E8=BF=90=E8=A1=8C=E9=98=9F=E5=88=97=E5=92=8C=E6=96=B0=E6=89=BE=
=E5=88=B0=E7=9A=84=E6=9C=80=E7=B9=81=E5=BF=99=E8=BF=90=E8=A1=8C
 =E9=98=9F=E5=88=97=E5=9D=87=E5=8A=A0=E9=94=81=EF=BC=8C=E5=B9=B6=E6=8A=8A=E4=
=BB=BB=E5=8A=A1=E4=BB=8E=E6=9C=80=E7=B9=81=E5=BF=99=E9=98=9F=E5=88=97=E4=B8=
=AD=E8=BF=81=E7=A7=BB=E5=88=B0=E5=BD=93=E5=89=8DCPU=E4=B8=8A=E3=80=82=E8=A2=
=AB=E8=BF=81=E7=A7=BB=E7=9A=84=E4=BB=BB=E5=8A=A1=E6=95=B0=E9=87=8F=E7=AD=89=
=E4=BA=8E=E5=9C=A8=E5=85=88=E5=89=8D=E8=BF=AD=E4=BB=A3=E6=89=A7=E8=A1=8C
 =E4=B8=AD=E8=AE=A1=E7=AE=97=E5=87=BA=E7=9A=84=E8=AF=A5=E8=B0=83=E5=BA=A6=E5=
=9F=9F=E7=9A=84=E8=B0=83=E5=BA=A6=E7=BB=84=E7=9A=84=E4=B8=8D=E5=9D=87=E8=A1=
=A1=E5=80=BC=E3=80=82
diff --git a/Documentation/translations/zh_CN/scheduler/sched-stats.rst b/Doc=
umentation/translations/zh_CN/scheduler/sched-stats.rst
index c5e0be6..09eee25 100644
--- a/Documentation/translations/zh_CN/scheduler/sched-stats.rst
+++ b/Documentation/translations/zh_CN/scheduler/sched-stats.rst
@@ -75,42 +75,42 @@ domain<N> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 1=
6 17 18 19 20 21 22 23=20
 =E7=B9=81=E5=BF=99=EF=BC=8C=E6=96=B0=E7=A9=BA=E9=97=B2=EF=BC=89=EF=BC=9A
=20
=20
-    1)  =E5=BD=93CPU=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Cload_balance()=E5=9C=
=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=B0=83=
=E7=94=A8=E4=BA=86#=E6=AC=A1
-    2)  =E5=BD=93CPU=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Cload_balance()=E5=9C=
=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=B0=83=
=E7=94=A8=EF=BC=8C=E4=BD=86=E6=98=AF=E5=8F=91=E7=8E=B0=E8=B4=9F=E8=BD=BD=E6=
=97=A0=E9=9C=80
+    1)  =E5=BD=93CPU=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Csched_balance_rq()=
=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=
=B0=83=E7=94=A8=E4=BA=86#=E6=AC=A1
+    2)  =E5=BD=93CPU=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Csched_balance_rq()=
=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=
=B0=83=E7=94=A8=EF=BC=8C=E4=BD=86=E6=98=AF=E5=8F=91=E7=8E=B0=E8=B4=9F=E8=BD=
=BD=E6=97=A0=E9=9C=80
         =E5=9D=87=E8=A1=A1#=E6=AC=A1
-    3)  =E5=BD=93CPU=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Cload_balance()=E5=9C=
=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=B0=83=
=E7=94=A8=EF=BC=8C=E8=AF=95=E5=9B=BE=E8=BF=81=E7=A7=BB1=E4=B8=AA=E6=88=96=E6=
=9B=B4=E5=A4=9A
+    3)  =E5=BD=93CPU=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Csched_balance_rq()=
=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=
=B0=83=E7=94=A8=EF=BC=8C=E8=AF=95=E5=9B=BE=E8=BF=81=E7=A7=BB1=E4=B8=AA=E6=88=
=96=E6=9B=B4=E5=A4=9A
         =E4=BB=BB=E5=8A=A1=E4=B8=94=E5=A4=B1=E8=B4=A5=E4=BA=86#=E6=AC=A1
-    4)  =E5=BD=93CPU=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Cload_balance()=E5=9C=
=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=B0=83=
=E7=94=A8=EF=BC=8C=E5=8F=91=E7=8E=B0=E4=B8=8D=E5=9D=87=E8=A1=A1=EF=BC=88=E5=
=A6=82=E6=9E=9C=E6=9C=89=EF=BC=89
+    4)  =E5=BD=93CPU=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Csched_balance_rq()=
=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=
=B0=83=E7=94=A8=EF=BC=8C=E5=8F=91=E7=8E=B0=E4=B8=8D=E5=9D=87=E8=A1=A1=EF=BC=
=88=E5=A6=82=E6=9E=9C=E6=9C=89=EF=BC=89
         #=E6=AC=A1
     5)  =E5=BD=93CPU=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Cpull_task()=E5=9C=A8=
=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=B0=83=E7=
=94=A8#=E6=AC=A1
     6)  =E5=BD=93CPU=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8C=E5=B0=BD=E7=AE=A1=
=E7=9B=AE=E6=A0=87=E4=BB=BB=E5=8A=A1=E6=98=AF=E7=83=AD=E7=BC=93=E5=AD=98=E7=
=8A=B6=E6=80=81=EF=BC=8Cpull_task()=E4=BE=9D=E7=84=B6=E8=A2=AB=E8=B0=83=E7=94=
=A8#=E6=AC=A1
-    7)  =E5=BD=93CPU=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Cload_balance()=E5=9C=
=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=B0=83=
=E7=94=A8=EF=BC=8C=E6=9C=AA=E8=83=BD=E6=89=BE=E5=88=B0=E6=9B=B4=E7=B9=81=E5=
=BF=99=E7=9A=84
+    7)  =E5=BD=93CPU=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Csched_balance_rq()=
=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=
=B0=83=E7=94=A8=EF=BC=8C=E6=9C=AA=E8=83=BD=E6=89=BE=E5=88=B0=E6=9B=B4=E7=B9=
=81=E5=BF=99=E7=9A=84
         =E9=98=9F=E5=88=97#=E6=AC=A1
     8)  =E5=BD=93CPU=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8C=E5=9C=A8=E8=B0=83=
=E5=BA=A6=E5=9F=9F=E4=B8=AD=E6=89=BE=E5=88=B0=E4=BA=86=E6=9B=B4=E7=B9=81=E5=
=BF=99=E7=9A=84=E9=98=9F=E5=88=97=EF=BC=8C=E4=BD=86=E6=9C=AA=E6=89=BE=E5=88=
=B0=E6=9B=B4=E7=B9=81=E5=BF=99=E7=9A=84=E8=B0=83=E5=BA=A6=E7=BB=84
         #=E6=AC=A1
-    9)  =E5=BD=93CPU=E7=B9=81=E5=BF=99=E6=97=B6=EF=BC=8Cload_balance()=E5=9C=
=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=B0=83=
=E7=94=A8=E4=BA=86#=E6=AC=A1
-    10) =E5=BD=93CPU=E7=B9=81=E5=BF=99=E6=97=B6=EF=BC=8Cload_balance()=E5=9C=
=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=B0=83=
=E7=94=A8=EF=BC=8C=E4=BD=86=E6=98=AF=E5=8F=91=E7=8E=B0=E8=B4=9F=E8=BD=BD=E6=
=97=A0=E9=9C=80
+    9)  =E5=BD=93CPU=E7=B9=81=E5=BF=99=E6=97=B6=EF=BC=8Csched_balance_rq()=
=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=
=B0=83=E7=94=A8=E4=BA=86#=E6=AC=A1
+    10) =E5=BD=93CPU=E7=B9=81=E5=BF=99=E6=97=B6=EF=BC=8Csched_balance_rq()=
=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=
=B0=83=E7=94=A8=EF=BC=8C=E4=BD=86=E6=98=AF=E5=8F=91=E7=8E=B0=E8=B4=9F=E8=BD=
=BD=E6=97=A0=E9=9C=80
         =E5=9D=87=E8=A1=A1#=E6=AC=A1
-    11) =E5=BD=93CPU=E7=B9=81=E5=BF=99=E6=97=B6=EF=BC=8Cload_balance()=E5=9C=
=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=B0=83=
=E7=94=A8=EF=BC=8C=E8=AF=95=E5=9B=BE=E8=BF=81=E7=A7=BB1=E4=B8=AA=E6=88=96=E6=
=9B=B4=E5=A4=9A
+    11) =E5=BD=93CPU=E7=B9=81=E5=BF=99=E6=97=B6=EF=BC=8Csched_balance_rq()=
=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=
=B0=83=E7=94=A8=EF=BC=8C=E8=AF=95=E5=9B=BE=E8=BF=81=E7=A7=BB1=E4=B8=AA=E6=88=
=96=E6=9B=B4=E5=A4=9A
         =E4=BB=BB=E5=8A=A1=E4=B8=94=E5=A4=B1=E8=B4=A5=E4=BA=86#=E6=AC=A1
-    12) =E5=BD=93CPU=E7=B9=81=E5=BF=99=E6=97=B6=EF=BC=8Cload_balance()=E5=9C=
=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=B0=83=
=E7=94=A8=EF=BC=8C=E5=8F=91=E7=8E=B0=E4=B8=8D=E5=9D=87=E8=A1=A1=EF=BC=88=E5=
=A6=82=E6=9E=9C=E6=9C=89=EF=BC=89
+    12) =E5=BD=93CPU=E7=B9=81=E5=BF=99=E6=97=B6=EF=BC=8Csched_balance_rq()=
=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=
=B0=83=E7=94=A8=EF=BC=8C=E5=8F=91=E7=8E=B0=E4=B8=8D=E5=9D=87=E8=A1=A1=EF=BC=
=88=E5=A6=82=E6=9E=9C=E6=9C=89=EF=BC=89
         #=E6=AC=A1
     13) =E5=BD=93CPU=E7=B9=81=E5=BF=99=E6=97=B6=EF=BC=8Cpull_task()=E5=9C=A8=
=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=B0=83=E7=
=94=A8#=E6=AC=A1
     14) =E5=BD=93CPU=E7=B9=81=E5=BF=99=E6=97=B6=EF=BC=8C=E5=B0=BD=E7=AE=A1=
=E7=9B=AE=E6=A0=87=E4=BB=BB=E5=8A=A1=E6=98=AF=E7=83=AD=E7=BC=93=E5=AD=98=E7=
=8A=B6=E6=80=81=EF=BC=8Cpull_task()=E4=BE=9D=E7=84=B6=E8=A2=AB=E8=B0=83=E7=94=
=A8#=E6=AC=A1
-    15) =E5=BD=93CPU=E7=B9=81=E5=BF=99=E6=97=B6=EF=BC=8Cload_balance()=E5=9C=
=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=B0=83=
=E7=94=A8=EF=BC=8C=E6=9C=AA=E8=83=BD=E6=89=BE=E5=88=B0=E6=9B=B4=E7=B9=81=E5=
=BF=99=E7=9A=84
+    15) =E5=BD=93CPU=E7=B9=81=E5=BF=99=E6=97=B6=EF=BC=8Csched_balance_rq()=
=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=
=B0=83=E7=94=A8=EF=BC=8C=E6=9C=AA=E8=83=BD=E6=89=BE=E5=88=B0=E6=9B=B4=E7=B9=
=81=E5=BF=99=E7=9A=84
         =E9=98=9F=E5=88=97#=E6=AC=A1
     16) =E5=BD=93CPU=E7=B9=81=E5=BF=99=E6=97=B6=EF=BC=8C=E5=9C=A8=E8=B0=83=
=E5=BA=A6=E5=9F=9F=E4=B8=AD=E6=89=BE=E5=88=B0=E4=BA=86=E6=9B=B4=E7=B9=81=E5=
=BF=99=E7=9A=84=E9=98=9F=E5=88=97=EF=BC=8C=E4=BD=86=E6=9C=AA=E6=89=BE=E5=88=
=B0=E6=9B=B4=E7=B9=81=E5=BF=99=E7=9A=84=E8=B0=83=E5=BA=A6=E7=BB=84
         #=E6=AC=A1
-    17) =E5=BD=93CPU=E6=96=B0=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Cload_balanc=
e()=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=
=E8=B0=83=E7=94=A8=E4=BA=86#=E6=AC=A1
-    18) =E5=BD=93CPU=E6=96=B0=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Cload_balanc=
e()=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=
=E8=B0=83=E7=94=A8=EF=BC=8C=E4=BD=86=E6=98=AF=E5=8F=91=E7=8E=B0=E8=B4=9F=E8=
=BD=BD=E6=97=A0=E9=9C=80
+    17) =E5=BD=93CPU=E6=96=B0=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Csched_balan=
ce_rq()=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=
=AB=E8=B0=83=E7=94=A8=E4=BA=86#=E6=AC=A1
+    18) =E5=BD=93CPU=E6=96=B0=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Csched_balan=
ce_rq()=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=
=AB=E8=B0=83=E7=94=A8=EF=BC=8C=E4=BD=86=E6=98=AF=E5=8F=91=E7=8E=B0=E8=B4=9F=
=E8=BD=BD=E6=97=A0=E9=9C=80
         =E5=9D=87=E8=A1=A1#=E6=AC=A1
-    19) =E5=BD=93CPU=E6=96=B0=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Cload_balanc=
e()=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=
=E8=B0=83=E7=94=A8=EF=BC=8C=E8=AF=95=E5=9B=BE=E8=BF=81=E7=A7=BB1=E4=B8=AA=E6=
=88=96=E6=9B=B4=E5=A4=9A
+    19) =E5=BD=93CPU=E6=96=B0=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Csched_balan=
ce_rq()=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=
=AB=E8=B0=83=E7=94=A8=EF=BC=8C=E8=AF=95=E5=9B=BE=E8=BF=81=E7=A7=BB1=E4=B8=AA=
=E6=88=96=E6=9B=B4=E5=A4=9A
         =E4=BB=BB=E5=8A=A1=E4=B8=94=E5=A4=B1=E8=B4=A5=E4=BA=86#=E6=AC=A1
-    20) =E5=BD=93CPU=E6=96=B0=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Cload_balanc=
e()=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=
=E8=B0=83=E7=94=A8=EF=BC=8C=E5=8F=91=E7=8E=B0=E4=B8=8D=E5=9D=87=E8=A1=A1=EF=
=BC=88=E5=A6=82=E6=9E=9C=E6=9C=89=EF=BC=89
+    20) =E5=BD=93CPU=E6=96=B0=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Csched_balan=
ce_rq()=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=
=AB=E8=B0=83=E7=94=A8=EF=BC=8C=E5=8F=91=E7=8E=B0=E4=B8=8D=E5=9D=87=E8=A1=A1=
=EF=BC=88=E5=A6=82=E6=9E=9C=E6=9C=89=EF=BC=89
         #=E6=AC=A1
     21) =E5=BD=93CPU=E6=96=B0=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Cpull_task()=
=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=E8=
=B0=83=E7=94=A8#=E6=AC=A1
     22) =E5=BD=93CPU=E6=96=B0=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8C=E5=B0=BD=
=E7=AE=A1=E7=9B=AE=E6=A0=87=E4=BB=BB=E5=8A=A1=E6=98=AF=E7=83=AD=E7=BC=93=E5=
=AD=98=E7=8A=B6=E6=80=81=EF=BC=8Cpull_task()=E4=BE=9D=E7=84=B6=E8=A2=AB=E8=B0=
=83=E7=94=A8#=E6=AC=A1
-    23) =E5=BD=93CPU=E6=96=B0=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Cload_balanc=
e()=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=AB=
=E8=B0=83=E7=94=A8=EF=BC=8C=E6=9C=AA=E8=83=BD=E6=89=BE=E5=88=B0=E6=9B=B4=E7=
=B9=81=E5=BF=99=E7=9A=84
+    23) =E5=BD=93CPU=E6=96=B0=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8Csched_balan=
ce_rq()=E5=9C=A8=E8=BF=99=E4=B8=AA=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E8=A2=
=AB=E8=B0=83=E7=94=A8=EF=BC=8C=E6=9C=AA=E8=83=BD=E6=89=BE=E5=88=B0=E6=9B=B4=
=E7=B9=81=E5=BF=99=E7=9A=84
         =E9=98=9F=E5=88=97#=E6=AC=A1
     24) =E5=BD=93CPU=E6=96=B0=E7=A9=BA=E9=97=B2=E6=97=B6=EF=BC=8C=E5=9C=A8=
=E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E6=89=BE=E5=88=B0=E4=BA=86=E6=9B=B4=E7=
=B9=81=E5=BF=99=E7=9A=84=E9=98=9F=E5=88=97=EF=BC=8C=E4=BD=86=E6=9C=AA=E6=89=
=BE=E5=88=B0=E6=9B=B4=E7=B9=81=E5=BF=99=E7=9A=84=E8=B0=83=E5=BA=A6=E7=BB=84
         #=E6=AC=A1
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 18572c9..c8fe9ba 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -110,7 +110,7 @@ struct sched_domain {
 	unsigned long last_decay_max_lb_cost;
=20
 #ifdef CONFIG_SCHEDSTATS
-	/* load_balance() stats */
+	/* sched_balance_rq() stats */
 	unsigned int lb_count[CPU_MAX_IDLE_TYPES];
 	unsigned int lb_failed[CPU_MAX_IDLE_TYPES];
 	unsigned int lb_balanced[CPU_MAX_IDLE_TYPES];
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 330788b..0d2753c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6866,7 +6866,7 @@ dequeue_throttle:
=20
 #ifdef CONFIG_SMP
=20
-/* Working cpumask for: load_balance, load_balance_newidle. */
+/* Working cpumask for: sched_balance_rq, load_balance_newidle. */
 static DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
 static DEFINE_PER_CPU(cpumask_var_t, select_rq_mask);
 static DEFINE_PER_CPU(cpumask_var_t, should_we_balance_tmpmask);
@@ -11242,7 +11242,7 @@ static int should_we_balance(struct lb_env *env)
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
  */
-static int load_balance(int this_cpu, struct rq *this_rq,
+static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 			struct sched_domain *sd, enum cpu_idle_type idle,
 			int *continue_balancing)
 {
@@ -11647,7 +11647,7 @@ out_unlock:
 static atomic_t sched_balance_running =3D ATOMIC_INIT(0);
=20
 /*
- * Scale the max load_balance interval with the number of CPUs in the system.
+ * Scale the max sched_balance_rq interval with the number of CPUs in the sy=
stem.
  * This trades load-balance latency on larger machines for less cross talk.
  */
 void update_max_interval(void)
@@ -11727,7 +11727,7 @@ static void sched_balance_domains(struct rq *rq, enum=
 cpu_idle_type idle)
 		}
=20
 		if (time_after_eq(jiffies, sd->last_balance + interval)) {
-			if (load_balance(cpu, rq, sd, idle, &continue_balancing)) {
+			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
 				/*
 				 * The LBF_DST_PINNED logic could have changed
 				 * env->dst_cpu, so we can't know our idle
@@ -12353,7 +12353,7 @@ static int newidle_balance(struct rq *this_rq, struct=
 rq_flags *rf)
=20
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
=20
-			pulled_task =3D load_balance(this_cpu, this_rq,
+			pulled_task =3D sched_balance_rq(this_cpu, this_rq,
 						   sd, CPU_NEWLY_IDLE,
 						   &continue_balancing);
=20

