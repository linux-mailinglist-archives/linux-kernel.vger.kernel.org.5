Return-Path: <linux-kernel+bounces-10489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D5A81D4FB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4C6283E69
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E9A15EAE;
	Sat, 23 Dec 2023 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J6SQmNo/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PcYiDIOl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF4310979;
	Sat, 23 Dec 2023 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 23 Dec 2023 16:09:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703347790;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbEZ1iVGY75WmscmXb7jsncGYd8lmWYfGGMLg7Bnu0U=;
	b=J6SQmNo/bet+kp4d1PA1yDVvorGaLxTx6aoJAwL4Wh8UnJoY3oB/lREpJAFpkT6sBX1coD
	BDMHpKRMU0pTGXWDpmXHSQwIjW5dtlGV2G8Fdm6N9fyHTaUkm5iD6kJYC2zFqAMm3+FPKE
	Yj0nBK6z9n2g2BiSPIW4AC5TgLdLfeALv0qAF7YL7/Jo69gKD51Af+SQ6BrwwWLs152dyz
	3+vcRR+awbWsnPU0LYHW2U9OX9nDxSRz2l9bBbNYbVA+dtr+/8zFpsRPrrY5Zn02XQKptj
	oPaP3komIKFSWBQezMcPena/myDgvv/0wK4um7jdxgdmN7GM5moWLc8BrauVaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703347790;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbEZ1iVGY75WmscmXb7jsncGYd8lmWYfGGMLg7Bnu0U=;
	b=PcYiDIOlZpmXSbeWMWRIzk3+07yJCbFBKR0Nf+0gppsbC2ALhEMcvpawG4mOTB3om3zAro
	nnxGxnJKqouG5UDQ==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Remove SCHED_FEAT(UTIL_EST_FASTUP, true)
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Hongyan Xia <hongyan.xia2@arm.com>, Tang Yizhou <yizhou.tang@shopee.com>,
 Yanteng Si <siyanteng@loongson.cn>, Alex Shi <alexs@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231201161652.1241695-2-vincent.guittot@linaro.org>
References: <20231201161652.1241695-2-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170334779013.398.12671460952572863426.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7736ae5572eb344c090fbef9621a228e7e3d6276
Gitweb:        https://git.kernel.org/tip/7736ae5572eb344c090fbef9621a228e7e3=
d6276
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Fri, 01 Dec 2023 17:16:51 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 23 Dec 2023 15:59:56 +01:00

sched/fair: Remove SCHED_FEAT(UTIL_EST_FASTUP, true)

sched_feat(UTIL_EST_FASTUP) has been added to easily disable the feature
in order to check for possibly related regressions. After 3 years, it has
never been used and no regression has been reported. Let's remove it
and make fast increase a permanent behavior.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
Reviewed-by: Tang Yizhou <yizhou.tang@shopee.com>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn> [for the Chinese translation]
Reviewed-by: Alex Shi <alexs@kernel.org>
Link: https://lore.kernel.org/r/20231201161652.1241695-2-vincent.guittot@lina=
ro.org
---
 Documentation/scheduler/schedutil.rst                    | 7 +++----
 Documentation/translations/zh_CN/scheduler/schedutil.rst | 7 +++----
 kernel/sched/fair.c                                      | 8 +++-----
 kernel/sched/features.h                                  | 1 +-
 4 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/Documentation/scheduler/schedutil.rst b/Documentation/scheduler/=
schedutil.rst
index 32c7d69..803fba8 100644
--- a/Documentation/scheduler/schedutil.rst
+++ b/Documentation/scheduler/schedutil.rst
@@ -90,8 +90,8 @@ For more detail see:
  - Documentation/scheduler/sched-capacity.rst:"1. CPU Capacity + 2. Task uti=
lization"
=20
=20
-UTIL_EST / UTIL_EST_FASTUP
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+UTIL_EST
+=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Because periodic tasks have their averages decayed while they sleep, even
 though when running their expected utilization will be the same, they suffer=
 a
@@ -99,8 +99,7 @@ though when running their expected utilization will be the =
same, they suffer a
=20
 To alleviate this (a default enabled option) UTIL_EST drives an Infinite
 Impulse Response (IIR) EWMA with the 'running' value on dequeue -- when it is
-highest. A further default enabled option UTIL_EST_FASTUP modifies the IIR
-filter to instantly increase and only decay on decrease.
+highest. UTIL_EST filters to instantly increase and only decay on decrease.
=20
 A further runqueue wide sum (of runnable tasks) is maintained of:
=20
diff --git a/Documentation/translations/zh_CN/scheduler/schedutil.rst b/Docum=
entation/translations/zh_CN/scheduler/schedutil.rst
index d1ea680..7c8d87f 100644
--- a/Documentation/translations/zh_CN/scheduler/schedutil.rst
+++ b/Documentation/translations/zh_CN/scheduler/schedutil.rst
@@ -89,16 +89,15 @@ r_cpu=E8=A2=AB=E5=AE=9A=E4=B9=89=E4=B8=BA=E5=BD=93=E5=89=
=8DCPU=E7=9A=84=E6=9C=80=E9=AB=98=E6=80=A7=E8=83=BD=E6=B0=B4=E5=B9=B3=E4=B8=
=8E=E7=B3=BB=E7=BB=9F=E4=B8=AD=E4=BB=BB=E4=BD=95=E5=85=B6=E5=AE=83CPU=E7=9A=
=84=E6=9C=80
  - Documentation/translations/zh_CN/scheduler/sched-capacity.rst:"1. CPU Cap=
acity + 2. Task utilization"
=20
=20
-UTIL_EST / UTIL_EST_FASTUP
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+UTIL_EST
+=3D=3D=3D=3D=3D=3D=3D=3D
=20
 =E7=94=B1=E4=BA=8E=E5=91=A8=E6=9C=9F=E6=80=A7=E4=BB=BB=E5=8A=A1=E7=9A=84=E5=
=B9=B3=E5=9D=87=E6=95=B0=E5=9C=A8=E7=9D=A1=E7=9C=A0=E6=97=B6=E4=BC=9A=E8=A1=
=B0=E5=87=8F=EF=BC=8C=E8=80=8C=E5=9C=A8=E8=BF=90=E8=A1=8C=E6=97=B6=E5=85=B6=
=E9=A2=84=E6=9C=9F=E5=88=A9=E7=94=A8=E7=8E=87=E4=BC=9A=E5=92=8C=E7=9D=A1=E7=
=9C=A0=E5=89=8D=E7=9B=B8=E5=90=8C=EF=BC=8C
 =E5=9B=A0=E6=AD=A4=E5=AE=83=E4=BB=AC=E5=9C=A8=E5=86=8D=E6=AC=A1=E8=BF=90=E8=
=A1=8C=E5=90=8E=E4=BC=9A=E9=9D=A2=E4=B8=B4=EF=BC=88DVFS=EF=BC=89=E7=9A=84=E4=
=B8=8A=E6=B6=A8=E3=80=82
=20
 =E4=B8=BA=E4=BA=86=E7=BC=93=E8=A7=A3=E8=BF=99=E4=B8=AA=E9=97=AE=E9=A2=98=EF=
=BC=8C=EF=BC=88=E4=B8=80=E4=B8=AA=E9=BB=98=E8=AE=A4=E4=BD=BF=E8=83=BD=E7=9A=
=84=E7=BC=96=E8=AF=91=E9=80=89=E9=A1=B9=EF=BC=89UTIL_EST=E9=A9=B1=E5=8A=A8=E4=
=B8=80=E4=B8=AA=E6=97=A0=E9=99=90=E8=84=89=E5=86=B2=E5=93=8D=E5=BA=94
 =EF=BC=88Infinite Impulse Response=EF=BC=8CIIR=EF=BC=89=E7=9A=84EWMA=EF=BC=
=8C=E2=80=9C=E8=BF=90=E8=A1=8C=E2=80=9D=E5=80=BC=E5=9C=A8=E5=87=BA=E9=98=9F=
=E6=97=B6=E6=98=AF=E6=9C=80=E9=AB=98=E7=9A=84=E3=80=82
-=E5=8F=A6=E4=B8=80=E4=B8=AA=E9=BB=98=E8=AE=A4=E4=BD=BF=E8=83=BD=E7=9A=84=E7=
=BC=96=E8=AF=91=E9=80=89=E9=A1=B9UTIL_EST_FASTUP=E4=BF=AE=E6=94=B9=E4=BA=86II=
R=E6=BB=A4=E6=B3=A2=E5=99=A8=EF=BC=8C=E4=BD=BF=E5=85=B6=E5=85=81=E8=AE=B8=E7=
=AB=8B=E5=8D=B3=E5=A2=9E=E5=8A=A0=EF=BC=8C
-=E4=BB=85=E5=9C=A8=E5=88=A9=E7=94=A8=E7=8E=87=E4=B8=8B=E9=99=8D=E6=97=B6=E8=
=A1=B0=E5=87=8F=E3=80=82
+UTIL_EST=E6=BB=A4=E6=B3=A2=E4=BD=BF=E5=85=B6=E5=9C=A8=E9=81=87=E5=88=B0=E6=
=9B=B4=E9=AB=98=E5=80=BC=E6=97=B6=E7=AB=8B=E5=88=BB=E5=A2=9E=E5=8A=A0=EF=BC=
=8C=E8=80=8C=E9=81=87=E5=88=B0=E4=BD=8E=E5=80=BC=E6=97=B6=E4=BC=9A=E7=BC=93=
=E6=85=A2=E8=A1=B0=E5=87=8F=E3=80=82
=20
 =E8=BF=9B=E4=B8=80=E6=AD=A5=EF=BC=8C=E8=BF=90=E8=A1=8C=E9=98=9F=E5=88=97=E7=
=9A=84=EF=BC=88=E5=8F=AF=E8=BF=90=E8=A1=8C=E4=BB=BB=E5=8A=A1=E7=9A=84=EF=BC=
=89=E5=88=A9=E7=94=A8=E7=8E=87=E4=B9=8B=E5=92=8C=E7=94=B1=E4=B8=8B=E5=BC=8F=
=E8=AE=A1=E7=AE=97=EF=BC=9A
=20
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bcea3d5..e94d65d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4870,11 +4870,9 @@ static inline void util_est_update(struct cfs_rq *cfs_=
rq,
 	 * to smooth utilization decreases.
 	 */
 	ue.enqueued =3D task_util(p);
-	if (sched_feat(UTIL_EST_FASTUP)) {
-		if (ue.ewma < ue.enqueued) {
-			ue.ewma =3D ue.enqueued;
-			goto done;
-		}
+	if (ue.ewma < ue.enqueued) {
+		ue.ewma =3D ue.enqueued;
+		goto done;
 	}
=20
 	/*
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index a3ddf84..143f55d 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -83,7 +83,6 @@ SCHED_FEAT(WA_BIAS, true)
  * UtilEstimation. Use estimated CPU utilization.
  */
 SCHED_FEAT(UTIL_EST, true)
-SCHED_FEAT(UTIL_EST_FASTUP, true)
=20
 SCHED_FEAT(LATENCY_WARN, false)
=20

