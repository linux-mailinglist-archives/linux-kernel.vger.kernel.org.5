Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15EA7F9362
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjKZPby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZPbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:31:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717ABE1;
        Sun, 26 Nov 2023 07:31:59 -0800 (PST)
Date:   Sun, 26 Nov 2023 15:31:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701012717;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wZDQzpYPwIXy7ZkVo94d38dNrCZu2lgYfd/Ae+T13JE=;
        b=l/Yx75me2qv9uPm3StKp3F84Dn2i8AowPa8+JsxlC3s9edMt5atCTVjrEp6c5EzrH2dJdo
        RpOurV3ySaU3588fje6EFa67L1jskBMafPdCgwWdzEHip7c8R/nbH5cgVEtlv0X0OtaeZs
        Sklo9TBFsxj22BT6fxDlzOilWKKpVWr34bx0THYH1ZpJ0Ab0Magm4I1B1aB3lVEqr52Rp2
        HdB01gibNdoSdktp4snx3dI0aDCCctHnOSvdABqPSCQA+CVjXgfstMGmJimeRz54uAc2vV
        EGciTPfub7Fvda7Rj0p2e2/JKTj/+xszgze3ZQrPT/4wGVP9qipl/Un2adq5lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701012717;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wZDQzpYPwIXy7ZkVo94d38dNrCZu2lgYfd/Ae+T13JE=;
        b=e/EcHhnRCGvYrYbIo3jmGMMPG3AxIpanaE4d/2wYSEJzyJzIlDorsIsBExT2kj5EwRgztk
        ClWKIlXJpE2tD2Bg==
From:   "tip-bot2 for Wenyu Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/doc: Update documentation after renames and
 synchronize Chinese version
Cc:     Wenyu Huang <huangwenyu5@huawei.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
MIME-Version: 1.0
Message-ID: <170101271629.398.13171090108678818524.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0257e5a3c26b3810831359d39c0821397af8bf29
Gitweb:        https://git.kernel.org/tip/0257e5a3c26b3810831359d39c0821397af=
8bf29
Author:        Wenyu Huang <huangwenyu5@huawei.com>
AuthorDate:    Sat, 25 Nov 2023 02:05:27=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 26 Nov 2023 16:24:48 +01:00

sched/doc: Update documentation after renames and synchronize Chinese version

Update the documentation after these changes, which didn't entirely
propagate the changes:

 e23edc86b09d ("sched/fair: Rename check_preempt_curr() to wakeup_preempt()")
 03b7fad167ef ("sched: Add task_struct pointer to sched_class::set_curr_task")
 2f88c8e802c8 ("sched/eevdf/doc: Modify the documented knob to base_slice_ns =
as well")

[ mingo: Reworked the changelog. ]

Signed-off-by: Wenyu Huang <huangwenyu5@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 Documentation/scheduler/sched-design-CFS.rst                    | 8 +++----
 Documentation/translations/zh_CN/scheduler/sched-design-CFS.rst | 8 +++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/scheduler/sched-design-CFS.rst b/Documentation/sch=
eduler/sched-design-CFS.rst
index f689198..6cffffe 100644
--- a/Documentation/scheduler/sched-design-CFS.rst
+++ b/Documentation/scheduler/sched-design-CFS.rst
@@ -180,7 +180,7 @@ This is the (partial) list of the hooks:
    compat_yield sysctl is turned on; in that case, it places the scheduling
    entity at the right-most end of the red-black tree.
=20
- - check_preempt_curr(...)
+ - wakeup_preempt(...)
=20
    This function checks if a task that entered the runnable state should
    preempt the currently running task.
@@ -189,10 +189,10 @@ This is the (partial) list of the hooks:
=20
    This function chooses the most appropriate task eligible to run next.
=20
- - set_curr_task(...)
+ - set_next_task(...)
=20
-   This function is called when a task changes its scheduling class or chang=
es
-   its task group.
+   This function is called when a task changes its scheduling class, changes
+   its task group or is scheduled.
=20
  - task_tick(...)
=20
diff --git a/Documentation/translations/zh_CN/scheduler/sched-design-CFS.rst =
b/Documentation/translations/zh_CN/scheduler/sched-design-CFS.rst
index 3076402..abc6709 100644
--- a/Documentation/translations/zh_CN/scheduler/sched-design-CFS.rst
+++ b/Documentation/translations/zh_CN/scheduler/sched-design-CFS.rst
@@ -80,7 +80,7 @@ p->se.vruntime=E3=80=82=E4=B8=80=E6=97=A6p->se.vruntime=E5=
=8F=98=E5=BE=97=E8=B6=B3=E5=A4=9F=E5=A4=A7=EF=BC=8C=E5=85=B6=E5=AE=83=E7=9A=
=84=E4=BB=BB=E5=8A=A1=E5=B0=86=E6=88=90=E4=B8=BA=EF=BF=BD
 CFS=E4=BD=BF=E7=94=A8=E7=BA=B3=E7=A7=92=E7=B2=92=E5=BA=A6=E7=9A=84=E8=AE=A1=
=E6=97=B6=EF=BC=8C=E4=B8=8D=E4=BE=9D=E8=B5=96=E4=BA=8E=E4=BB=BB=E4=BD=95jiffi=
es=E6=88=96HZ=E7=9A=84=E7=BB=86=E8=8A=82=E3=80=82=E5=9B=A0=E6=AD=A4CFS=E5=B9=
=B6=E4=B8=8D=E5=83=8F=E4=B9=8B=E5=89=8D=E7=9A=84=E8=B0=83=E5=BA=A6=E5=99=A8=
=E9=82=A3=E6=A0=B7
 =E6=9C=89=E2=80=9C=E6=97=B6=E9=97=B4=E7=89=87=E2=80=9D=E7=9A=84=E6=A6=82=E5=
=BF=B5=EF=BC=8C=E4=B9=9F=E6=B2=A1=E6=9C=89=E4=BB=BB=E4=BD=95=E5=90=AF=E5=8F=
=91=E5=BC=8F=E7=9A=84=E8=AE=BE=E8=AE=A1=E3=80=82=E5=94=AF=E4=B8=80=E5=8F=AF=
=E8=B0=83=E7=9A=84=E5=8F=82=E6=95=B0=EF=BC=88=E4=BD=A0=E9=9C=80=E8=A6=81=E6=
=89=93=E5=BC=80CONFIG_SCHED_DEBUG=EF=BC=89=E6=98=AF=EF=BC=9A
=20
-   /sys/kernel/debug/sched/min_granularity_ns
+   /sys/kernel/debug/sched/base_slice_ns
=20
 =E5=AE=83=E5=8F=AF=E4=BB=A5=E7=94=A8=E6=9D=A5=E5=B0=86=E8=B0=83=E5=BA=A6=E5=
=99=A8=E4=BB=8E=E2=80=9C=E6=A1=8C=E9=9D=A2=E2=80=9D=E6=A8=A1=E5=BC=8F=EF=BC=
=88=E4=B9=9F=E5=B0=B1=E6=98=AF=E4=BD=8E=E6=97=B6=E5=BB=B6=EF=BC=89=E8=B0=83=
=E8=8A=82=E4=B8=BA=E2=80=9C=E6=9C=8D=E5=8A=A1=E5=99=A8=E2=80=9D=EF=BC=88=E4=
=B9=9F=E5=B0=B1=E6=98=AF=E9=AB=98=E6=89=B9=E5=A4=84=E7=90=86=EF=BC=89=E6=A8=
=A1=E5=BC=8F=E3=80=82
 =E5=AE=83=E7=9A=84=E9=BB=98=E8=AE=A4=E8=AE=BE=E7=BD=AE=E6=98=AF=E9=80=82=E5=
=90=88=E6=A1=8C=E9=9D=A2=E7=9A=84=E5=B7=A5=E4=BD=9C=E8=B4=9F=E8=BD=BD=E3=80=
=82SCHED_BATCH=E4=B9=9F=E8=A2=ABCFS=E8=B0=83=E5=BA=A6=E5=99=A8=E6=A8=A1=E5=9D=
=97=E5=A4=84=E7=90=86=E3=80=82
@@ -147,7 +147,7 @@ array=EF=BC=89=E3=80=82
    =E8=BF=99=E4=B8=AA=E5=87=BD=E6=95=B0=E7=9A=84=E8=A1=8C=E4=B8=BA=E5=9F=BA=
=E6=9C=AC=E4=B8=8A=E6=98=AF=E5=87=BA=E9=98=9F=EF=BC=8C=E7=B4=A7=E6=8E=A5=E7=
=9D=80=E5=85=A5=E9=98=9F=EF=BC=8C=E9=99=A4=E9=9D=9Ecompat_yield sysctl=E8=A2=
=AB=E5=BC=80=E5=90=AF=E3=80=82=E5=9C=A8=E9=82=A3=E7=A7=8D=E6=83=85=E5=86=B5=
=E4=B8=8B=EF=BC=8C
    =E5=AE=83=E5=B0=86=E8=B0=83=E5=BA=A6=E5=AE=9E=E4=BD=93=E6=94=BE=E5=9C=A8=
=E7=BA=A2=E9=BB=91=E6=A0=91=E7=9A=84=E6=9C=80=E5=8F=B3=E7=AB=AF=E3=80=82
=20
- - check_preempt_curr(...)
+ - wakeup_preempt(...)
=20
    =E8=BF=99=E4=B8=AA=E5=87=BD=E6=95=B0=E6=A3=80=E6=9F=A5=E8=BF=9B=E5=85=A5=
=E5=8F=AF=E8=BF=90=E8=A1=8C=E7=8A=B6=E6=80=81=E7=9A=84=E4=BB=BB=E5=8A=A1=E8=
=83=BD=E5=90=A6=E6=8A=A2=E5=8D=A0=E5=BD=93=E5=89=8D=E6=AD=A3=E5=9C=A8=E8=BF=
=90=E8=A1=8C=E7=9A=84=E4=BB=BB=E5=8A=A1=E3=80=82
=20
@@ -155,9 +155,9 @@ array=EF=BC=89=E3=80=82
=20
    =E8=BF=99=E4=B8=AA=E5=87=BD=E6=95=B0=E9=80=89=E6=8B=A9=E6=8E=A5=E4=B8=8B=
=E6=9D=A5=E6=9C=80=E9=80=82=E5=90=88=E8=BF=90=E8=A1=8C=E7=9A=84=E4=BB=BB=E5=
=8A=A1=E3=80=82
=20
- - set_curr_task(...)
+ - set_next_task(...)
=20
-   =E8=BF=99=E4=B8=AA=E5=87=BD=E6=95=B0=E5=9C=A8=E4=BB=BB=E5=8A=A1=E6=94=B9=
=E5=8F=98=E8=B0=83=E5=BA=A6=E7=B1=BB=E6=88=96=E6=94=B9=E5=8F=98=E4=BB=BB=E5=
=8A=A1=E7=BB=84=E6=97=B6=E8=A2=AB=E8=B0=83=E7=94=A8=E3=80=82
+   =E8=BF=99=E4=B8=AA=E5=87=BD=E6=95=B0=E5=9C=A8=E4=BB=BB=E5=8A=A1=E6=94=B9=
=E5=8F=98=E8=B0=83=E5=BA=A6=E7=B1=BB=EF=BC=8C=E6=94=B9=E5=8F=98=E4=BB=BB=E5=
=8A=A1=E7=BB=84=E6=97=B6=EF=BC=8C=E6=88=96=E8=80=85=E4=BB=BB=E5=8A=A1=E8=A2=
=AB=E8=B0=83=E5=BA=A6=E6=97=B6=E8=A2=AB=E8=B0=83=E7=94=A8=E3=80=82
=20
  - task_tick(...)
=20
