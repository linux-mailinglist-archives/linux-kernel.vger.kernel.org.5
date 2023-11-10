Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E667E816B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345991AbjKJS1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346004AbjKJSZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:25:57 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2085.outbound.protection.outlook.com [40.107.215.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BD624C00;
        Fri, 10 Nov 2023 01:35:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Slg0cVZa1fTzWEWwO4X5Fnq3emMg70tKjDSl3sL2X6oNvogxVkfqvpqLge2PTRL1DTBPSACk6KUxdRRLgW1FhClL4olsZT2gVgOt8b3M1l0aX5Izq5Un2NqfhiMt1ov3DkGjU2o2nFA4hlW8urjoV3B0FVsUFa+hiNhpL3aqhnd7OPnx+GjkYysmZzb/C5SbDPFjuOwodTCTyMiY0vdcxG9c/gRnHfb7NZ8LSlVfpzxy5m7nUY1mHCkG4ezAK4SlcwVbuG/kSEmji/8gOivCPQ1WRZ429VUVd9QREfuOz7J3YAkYcr9BVFT7UNr3QBNr9Kl0mT5yD+00nXwsgpeYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rIgZQKlI39JsUvAuaI7JwqSRIZL5MrCi+ju84tLORE=;
 b=Olyai8WjkWDawtcJzb+mxn4LbxhG0K7u4qADDQmxbf7LiFkyxOcR8/Kf1tR6qCVfhEA89IVh83f2kLCSiDjxCOZu/U/E9w8ebI67y0mwTH9oB4CYtU4ShOLX0Kr+0JAmDe2KAoEtbhvhPMsH5JB3CHiZWkvNGFMvYU7lmf8Re8b2dc+q/A2fTNdWYJRPaZ1RugbSYF6KScRWUPfDezBSzEoZ/7e8xTovUSEpsvQK/WQeNq1VGoYPxYhnTlGL+BD2bd2tmBVKQs2aOvXrWjXS84AAvbG+yTc+5V4np1QH91mEYNWx0WpHURZOPLEZcmLqBK+uXhAOnpiin5sEgYHrHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=samsung.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rIgZQKlI39JsUvAuaI7JwqSRIZL5MrCi+ju84tLORE=;
 b=ENhX0PavWQ8cj0LS4AmB0Wi5+fFltiK6jciHJgIl800AortmfjFPhYDOx8bW5BSiv2nUnBGMzIy1D9rhqc++8UaQTJa2PA3tmjE1l5DxibFMF3hts73fHyRHxZQ1OV3CmZlYO2CA+vLObkqe7EKDzrDfO0a0zOf9eBEBwzLYtgQ=
Received: from SI1PR02CA0032.apcprd02.prod.outlook.com (2603:1096:4:1f6::12)
 by KL1PR02MB6661.apcprd02.prod.outlook.com (2603:1096:820:112::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 09:35:00 +0000
Received: from HK2PEPF00006FB3.apcprd02.prod.outlook.com
 (2603:1096:4:1f6:cafe::69) by SI1PR02CA0032.outlook.office365.com
 (2603:1096:4:1f6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Fri, 10 Nov 2023 09:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK2PEPF00006FB3.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.21 via Frontend Transport; Fri, 10 Nov 2023 09:35:00 +0000
Received: from PA80318969.adc.com (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 10 Nov
 2023 17:34:59 +0800
From:   huangzaiyang <huangzaiyang@oppo.com>
To:     <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
        <cw00.choi@samsung.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        huangzaiyang <joyyoung.wang@gmail.com>,
        ZaiYang Huang <huangzaiyang@oppo.com>
Subject: [PATCH] Performance: devfreq: avoid devfreq delay work re-init before
Date:   Fri, 10 Nov 2023 17:34:57 +0800
Message-ID: <20231110093457.458-1-huangzaiyang@oppo.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [172.16.40.118]
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw30.adc.com
 (172.16.56.197)
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB3:EE_|KL1PR02MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: e80324bc-0160-4372-35a4-08dbe1d04f57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aABVKdLdnNncB9neC9F93WzEv1cax5/sYTUtq6tQHknS7S74VexJzePb2yRH9cVKIskO5XdKEWIFvPU2sy/wan1G+Kf8qMoY9MQy9dlQXFTA5msCgooIbQcMVlpBppT7s373IjQk2GB5+vduLgtT9T2MlwS5L7+j/LxQOD8UnXaQp1X8FRF2pZu6h2QlWn4egSRDn2f0lO/S/l47GkLlz3m1iOj5mfz0BOT8ymvFd8Dm/Wz2vDf+KLTG6tRFULrGXOIXpUoUYH3gN/Dzq1lHKrgUzUAodCSIXsjR1FmSRfGeIlYMj/NLxgURoHyna/z0v3Vbq6D+XwmArq0nvXEvbRuM3tmn6KaM1vLcEZ8zg+yWplt1Ycu20xgP8lDYIz/SJM/+obMj30wA2exyw0sTUGNLPDGTdxL+cM/462LES4gSgjwBamQY8IIBJSGSFz4WqA24cOOCY1bd0Dc5/J213bVXI8b2thmpDEqvYfc4iTd4A7bWR6SJzRsM8RelZh6QgPDkeAKruVk9KcPlR51VuubnRV8J+MOjMmVD+k0eLVTE4Fy+c0PrR5GsTI8VL0CW0/mkf2Ozdy0MqTNEydYTisDpCjDHpFync4jfWnLhQBFoVOvPYsku/JrXmRjCc2Wgr/HcDeFai8gfJKH69NhcIds0d+SXth0+PSI8kqsMrXcCXtiHOxy1kkjlC2q1SJMJhr8hTrfzusTPMz1j9yyRHQbd96UznA0KKGYA7wIQ/Bd36XrrJDE2k3AedBrz1+Mj873fb/Z1W2ul9spRV4vDMQ==
X-Forefront-Antispam-Report: CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(30864003)(5660300002)(40480700001)(36756003)(81166007)(70206006)(54906003)(86362001)(356005)(316002)(26005)(107886003)(2616005)(1076003)(82740400003)(110136005)(16526019)(478600001)(83380400001)(70586007)(47076005)(336012)(41300700001)(4326008)(8936002)(36860700001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 09:35:00.1901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e80324bc-0160-4372-35a4-08dbe1d04f57
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6661
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: huangzaiyang <joyyoung.wang@gmail.com>

There is a timer_list race condition when executing the following test shel=
l script:
'''
while true
do
        echo "simple_ondemand" > /sys/class/devfreq/1d84000.ufshc/governor
        echo "performance" > /sys/class/devfreq/1d84000.ufshc/governor
done
'''

[13511.214366][    C3] Unable to handle kernel paging request at virtual ad=
dress dead00000000012a
[13511.214393][    C3] Mem abort info:
[13511.214398][    C3]   ESR =3D 0x96000044
[13511.214404][    C3]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[13511.214409][    C3]   SET =3D 0, FnV =3D 0
[13511.214414][    C3]   EA =3D 0, S1PTW =3D 0
[13511.214417][    C3] Data abort info:
[13511.214422][    C3]   ISV =3D 0, ISS =3D 0x00000044
[13511.214427][    C3]   CM =3D 0, WnR =3D 1
[13511.214432][    C3] [dead00000000012a] address between user and kernel a=
ddress ranges
[13511.214439][    C3] Internal error: Oops: 96000044 [#1] PREEMPT SMP
[13511.215449][    C3] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G S      W  O=
      5.10.168-android12-9-o-g63cc297a7b34 #1
[13511.215454][    C3] Hardware name: Qualcomm Technologies, Inc. Cape MTP,=
 Whiteswan (DT)
[13511.215460][    C3] pstate: 82400085 (Nzcv daIf +PAN -UAO +TCO BTYPE=3D-=
-)
[13511.215472][    C3] pc : expire_timers+0x9c/0x428
[13511.215478][    C3] lr : __run_timers+0x1f0/0x328
[13511.215483][    C3] sp : ffffffc00801bdd0
[13511.215487][    C3] x29: ffffffc00801bdf0 x28: ffffffdb87b31698
[13511.215493][    C3] x27: ffffffdb87999e58 x26: ffffffdb87966008
[13511.215499][    C3] x25: 0000000000000001 x24: ffffff8001734a00
[13511.215506][    C3] x23: 00000000000000e0 x22: dead000000000122
[13511.215512][    C3] x21: 000000010032658e x20: ffffff89f7a9ae80
[13511.215518][    C3] x19: ffffffc00801be50 x18: ffffffc00801d038
[13511.215525][    C3] x17: 0000000000000240 x16: 0000000000000201
[13511.215532][    C3] x15: ffffffffffffffff x14: ffffff89f7a9aef8
[13511.215538][    C3] x13: 0000000000000240 x12: ffffff89f7a9aea8
[13511.215544][    C3] x11: 0000000000000021 x10: 000000014032658e
[13511.215550][    C3] x9 : ffffffc00801be50 x8 : dead000000000122
[13511.215556][    C3] x7 : ffff71646c68735e x6 : ffffff89f7aaae58
[13511.215563][    C3] x5 : 0000000000000000 x4 : 0000000000000101
[13511.215569][    C3] x3 : ffffff89f7a9aef0 x2 : ffffff89f7a9aef0
[13511.215575][    C3] x1 : ffffffc00801be50 x0 : ffffff8045804428
[13511.215581][    C3] Call trace:
[13511.215586][    C3]  expire_timers+0x9c/0x428
[13511.215591][    C3]  __run_timers+0x1f0/0x328
[13511.215596][    C3]  run_timer_softirq+0x28/0x58
[13511.215602][    C3]  efi_header_end+0x168/0x5ec
[13511.215610][    C3]  __irq_exit_rcu+0x108/0x124
[13511.215617][    C3]  __handle_domain_irq+0x118/0x1e4
[13511.215625][    C3]  gic_handle_irq.31230+0x6c/0x250
[13511.215630][    C3]  el1_irq+0xe4/0x1c0
[13511.215638][    C3]  cpuidle_enter_state+0x3a4/0xa04
[13511.215644][    C3]  do_idle+0x308/0x574
[13511.215649][    C3]  cpu_startup_entry+0x84/0x90
[13511.215656][    C3]  secondary_start_kernel+0x204/0x274
[13511.215664][    C3] Code: d503201f a9402408 f9000128 b4000048 (f9000509)
[13511.215670][    C3] ---[ end trace 5100bad72a35d566 ]---
[13511.215676][    C3] Kernel panic - not syncing: Oops: Fatal exception in=
 interrupt

This is because when switching the governor through the sys node,
the devfreq_monitor_start function will re-initialize the delayed work task=
,
which will cause the delay work pending flag to become invalid, and the tim=
er pending judgment contained in the delayed work will also become invalid,
and then the pending interception will be executed when the queue is execut=
ed.

So we remove the delay work'initialization work to the devfreq_add_device a=
nd timer_store functions,
and the delay work pending judgment is performed before the devfreq_monitor=
_start function performs the queue operation.

Signed-off-by: ZaiYang Huang <huangzaiyang@oppo.com>
---
 drivers/devfreq/devfreq.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index b3a68d5833bd..8ae6f853a21e 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -483,18 +483,7 @@ void devfreq_monitor_start(struct devfreq *devfreq)
        if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
                return;

-       switch (devfreq->profile->timer) {
-       case DEVFREQ_TIMER_DEFERRABLE:
-               INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
-               break;
-       case DEVFREQ_TIMER_DELAYED:
-               INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
-               break;
-       default:
-               return;
-       }
-
-       if (devfreq->profile->polling_ms)
+       if (devfreq->profile->polling_ms && !delayed_work_pending(&devfreq-=
>work))
                queue_delayed_work(devfreq_wq, &devfreq->work,
                        msecs_to_jiffies(devfreq->profile->polling_ms));
 }
@@ -830,6 +819,17 @@ struct devfreq *devfreq_add_device(struct device *dev,
                goto err_dev;
        }

+       switch (devfreq->profile->timer) {
+       case DEVFREQ_TIMER_DEFERRABLE:
+               INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
+               break;
+       case DEVFREQ_TIMER_DELAYED:
+               INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
+               break;
+       default:
+               dev_err(dev, "%s: Target devfreq(%s)'s profile timer has no=
 settings \n", devfreq->governor_name,
+                       __func__);
+       }
        if (!devfreq->profile->max_state || !devfreq->profile->freq_table) =
{
                mutex_unlock(&devfreq->lock);
                err =3D set_freq_table(devfreq);
@@ -1860,6 +1860,18 @@ static ssize_t timer_store(struct device *dev, struc=
t device_attribute *attr,
        df->profile->timer =3D timer;
        mutex_unlock(&df->lock);

+       switch (df->profile->timer) {
+       case DEVFREQ_TIMER_DEFERRABLE:
+               INIT_DEFERRABLE_WORK(&df->work, devfreq_monitor);
+               break;
+       case DEVFREQ_TIMER_DELAYED:
+               INIT_DELAYED_WORK(&df->work, devfreq_monitor);
+               break;
+       default:
+               dev_err(dev, "%s: Target devfreq(%s)'s profile timer has no=
 settings \n", df->governor_name,
+                       __func__);
+       }
+
        ret =3D df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
        if (ret) {
                dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
--
2.17.1

________________________________
OPPO

=C2=B1=C2=BE=C2=B5=C3=A7=C3=97=C3=93=C3=93=C3=8A=C2=BC=C3=BE=C2=BC=C2=B0=C3=
=86=C3=A4=C2=B8=C2=BD=C2=BC=C3=BE=C2=BA=C2=AC=C3=93=C3=90OPPO=C2=B9=C2=AB=
=C3=8B=C2=BE=C2=B5=C3=84=C2=B1=C2=A3=C3=83=C3=9C=C3=90=C3=85=C3=8F=C2=A2=C2=
=A3=C2=AC=C2=BD=C3=B6=C3=8F=C3=9E=C3=93=C3=9A=C3=93=C3=8A=C2=BC=C3=BE=C3=96=
=C2=B8=C3=83=C3=B7=C2=B5=C3=84=C3=8A=C3=95=C2=BC=C3=BE=C3=88=C3=8B=C2=A3=C2=
=A8=C2=B0=C3=BC=C2=BA=C2=AC=C2=B8=C3=B6=C3=88=C3=8B=C2=BC=C2=B0=C3=88=C2=BA=
=C3=97=C3=A9=C2=A3=C2=A9=C3=8A=C2=B9=C3=93=C3=83=C2=A1=C2=A3=C2=BD=C3=BB=C3=
=96=C2=B9=C3=88=C3=8E=C2=BA=C3=8E=C3=88=C3=8B=C3=94=C3=9A=C3=8E=C2=B4=C2=BE=
=C2=AD=C3=8A=C3=9A=C3=88=C2=A8=C2=B5=C3=84=C3=87=C3=A9=C2=BF=C3=B6=C3=8F=C3=
=82=C3=92=C3=94=C3=88=C3=8E=C2=BA=C3=8E=C3=90=C3=8E=C3=8A=C2=BD=C3=8A=C2=B9=
=C3=93=C3=83=C2=A1=C2=A3=C3=88=C3=A7=C2=B9=C3=BB=C3=84=C3=BA=C2=B4=C3=AD=C3=
=8A=C3=95=C3=81=C3=8B=C2=B1=C2=BE=C3=93=C3=8A=C2=BC=C3=BE=C2=A3=C2=AC=C3=87=
=C3=90=C3=8E=C3=B0=C2=B4=C2=AB=C2=B2=C2=A5=C2=A1=C2=A2=C2=B7=C3=96=C2=B7=C2=
=A2=C2=A1=C2=A2=C2=B8=C2=B4=C3=96=C3=86=C2=A1=C2=A2=C3=93=C2=A1=C3=8B=C2=A2=
=C2=BB=C3=B2=C3=8A=C2=B9=C3=93=C3=83=C2=B1=C2=BE=C3=93=C3=8A=C2=BC=C3=BE=C3=
=96=C2=AE=C3=88=C3=8E=C2=BA=C3=8E=C2=B2=C2=BF=C2=B7=C3=96=C2=BB=C3=B2=C3=86=
=C3=A4=C3=8B=C3=B9=C3=94=C3=98=C3=96=C2=AE=C3=88=C3=8E=C2=BA=C3=8E=C3=84=C3=
=9A=C3=88=C3=9D=C2=A3=C2=AC=C2=B2=C2=A2=C3=87=C3=AB=C3=81=C2=A2=C2=BC=C2=B4=
=C3=92=C3=94=C2=B5=C3=A7=C3=97=C3=93=C3=93=C3=8A=C2=BC=C3=BE=C3=8D=C2=A8=C3=
=96=C2=AA=C2=B7=C2=A2=C2=BC=C3=BE=C3=88=C3=8B=C2=B2=C2=A2=C3=89=C2=BE=C2=B3=
=C3=BD=C2=B1=C2=BE=C3=93=C3=8A=C2=BC=C3=BE=C2=BC=C2=B0=C3=86=C3=A4=C2=B8=C2=
=BD=C2=BC=C3=BE=C2=A1=C2=A3
=C3=8D=C3=B8=C3=82=C3=A7=C3=8D=C2=A8=C3=91=C2=B6=C2=B9=C3=8C=C3=93=C3=90=C3=
=88=C2=B1=C3=8F=C3=9D=C2=BF=C3=89=C3=84=C3=9C=C2=B5=C2=BC=C3=96=C3=82=C3=93=
=C3=8A=C2=BC=C3=BE=C2=B1=C2=BB=C2=BD=C3=98=C3=81=C3=B4=C2=A1=C2=A2=C3=90=C3=
=9E=C2=B8=C3=84=C2=A1=C2=A2=C2=B6=C2=AA=C3=8A=C2=A7=C2=A1=C2=A2=C3=86=C3=86=
=C2=BB=C2=B5=C2=BB=C3=B2=C2=B0=C3=BC=C2=BA=C2=AC=C2=BC=C3=86=C3=8B=C3=A3=C2=
=BB=C3=BA=C2=B2=C2=A1=C2=B6=C2=BE=C2=B5=C3=88=C2=B2=C2=BB=C2=B0=C2=B2=C3=88=
=C2=AB=C3=87=C3=A9=C2=BF=C3=B6=C2=A3=C2=ACOPPO=C2=B6=C3=94=C2=B4=C3=8B=C3=
=80=C3=A0=C2=B4=C3=AD=C3=8E=C3=B3=C2=BB=C3=B2=C3=92=C3=85=C3=82=C2=A9=C2=B6=
=C3=B8=C3=92=C3=BD=C3=96=C3=82=C3=96=C2=AE=C3=88=C3=8E=C2=BA=C3=8E=C3=8B=C3=
=B0=C3=8A=C2=A7=C2=B8=C3=85=C2=B2=C2=BB=C2=B3=C3=90=C2=B5=C2=A3=C3=94=C3=B0=
=C3=88=C3=8E=C2=B2=C2=A2=C2=B1=C2=A3=C3=81=C3=B4=C3=93=C3=AB=C2=B1=C2=BE=C3=
=93=C3=8A=C2=BC=C3=BE=C3=8F=C3=A0=C2=B9=C3=98=C3=96=C2=AE=C3=92=C2=BB=C3=87=
=C3=90=C3=88=C2=A8=C3=80=C3=BB=C2=A1=C2=A3
=C2=B3=C3=BD=C2=B7=C3=87=C3=83=C3=B7=C3=88=C2=B7=C3=8B=C2=B5=C3=83=C3=B7=C2=
=A3=C2=AC=C2=B1=C2=BE=C3=93=C3=8A=C2=BC=C3=BE=C2=BC=C2=B0=C3=86=C3=A4=C2=B8=
=C2=BD=C2=BC=C3=BE=C3=8E=C3=9E=C3=92=C3=A2=C3=97=C3=B7=C3=8E=C2=AA=C3=94=C3=
=9A=C3=88=C3=8E=C2=BA=C3=8E=C2=B9=C3=BA=C2=BC=C3=92=C2=BB=C3=B2=C2=B5=C3=98=
=C3=87=C3=B8=C3=96=C2=AE=C3=92=C2=AA=C3=94=C2=BC=C2=A1=C2=A2=C3=95=C3=90=C3=
=80=C2=BF=C2=BB=C3=B2=C2=B3=C3=90=C3=85=C2=B5=C2=A3=C2=AC=C3=92=C3=A0=C3=8E=
=C3=9E=C3=92=C3=A2=C3=97=C3=B7=C3=8E=C2=AA=C3=88=C3=8E=C2=BA=C3=8E=C2=BD=C2=
=BB=C3=92=C3=97=C2=BB=C3=B2=C2=BA=C3=8F=C3=8D=C2=AC=C3=96=C2=AE=C3=95=C3=BD=
=C3=8A=C2=BD=C3=88=C2=B7=C3=88=C3=8F=C2=A1=C2=A3 =C2=B7=C2=A2=C2=BC=C3=BE=
=C3=88=C3=8B=C2=A1=C2=A2=C3=86=C3=A4=C3=8B=C3=B9=C3=8A=C3=B4=C2=BB=C3=BA=C2=
=B9=C2=B9=C2=BB=C3=B2=C3=8B=C3=B9=C3=8A=C3=B4=C2=BB=C3=BA=C2=B9=C2=B9=C3=96=
=C2=AE=C2=B9=C3=98=C3=81=C2=AA=C2=BB=C3=BA=C2=B9=C2=B9=C2=BB=C3=B2=C3=88=C3=
=8E=C2=BA=C3=8E=C3=89=C3=8F=C3=8A=C3=B6=C2=BB=C3=BA=C2=B9=C2=B9=C3=96=C2=AE=
=C2=B9=C3=89=C2=B6=C2=AB=C2=A1=C2=A2=C2=B6=C2=AD=C3=8A=C3=82=C2=A1=C2=A2=C2=
=B8=C3=9F=C2=BC=C2=B6=C2=B9=C3=9C=C3=80=C3=AD=C3=88=C3=8B=C3=94=C2=B1=C2=A1=
=C2=A2=C3=94=C2=B1=C2=B9=C2=A4=C2=BB=C3=B2=C3=86=C3=A4=C3=8B=C3=BB=C3=88=C3=
=8E=C2=BA=C3=8E=C3=88=C3=8B=C2=A3=C2=A8=C3=92=C3=94=C3=8F=C3=82=C2=B3=C3=86=
=C2=A1=C2=B0=C2=B7=C2=A2=C2=BC=C3=BE=C3=88=C3=8B=C2=A1=C2=B1=C2=BB=C3=B2=C2=
=A1=C2=B0OPPO=C2=A1=C2=B1=C2=A3=C2=A9=C2=B2=C2=BB=C3=92=C3=B2=C2=B1=C2=BE=
=C3=93=C3=8A=C2=BC=C3=BE=C3=96=C2=AE=C3=8E=C3=B3=C3=8B=C3=8D=C2=B6=C3=B8=C2=
=B7=C3=85=C3=86=C3=BA=C3=86=C3=A4=C3=8B=C3=B9=C3=8F=C3=AD=C3=96=C2=AE=C3=88=
=C3=8E=C2=BA=C3=8E=C3=88=C2=A8=C3=80=C3=BB=C2=A3=C2=AC=C3=92=C3=A0=C2=B2=C2=
=BB=C2=B6=C3=94=C3=92=C3=B2=C2=B9=C3=8A=C3=92=C3=A2=C2=BB=C3=B2=C2=B9=C3=BD=
=C3=8A=C2=A7=C3=8A=C2=B9=C3=93=C3=83=C2=B8=C3=83=C2=B5=C3=88=C3=90=C3=85=C3=
=8F=C2=A2=C2=B6=C3=B8=C3=92=C3=BD=C2=B7=C2=A2=C2=BB=C3=B2=C2=BF=C3=89=C3=84=
=C3=9C=C3=92=C3=BD=C2=B7=C2=A2=C2=B5=C3=84=C3=8B=C3=B0=C3=8A=C2=A7=C2=B3=C3=
=90=C2=B5=C2=A3=C3=88=C3=8E=C2=BA=C3=8E=C3=94=C3=B0=C3=88=C3=8E=C2=A1=C2=A3
=C3=8E=C3=84=C2=BB=C2=AF=C2=B2=C3=AE=C3=92=C3=AC=C3=85=C3=BB=C3=82=C2=B6=C2=
=A3=C2=BA=C3=92=C3=B2=C3=88=C2=AB=C3=87=C3=B2=C3=8E=C3=84=C2=BB=C2=AF=C2=B2=
=C3=AE=C3=92=C3=AC=C3=93=C2=B0=C3=8F=C3=AC=C2=A3=C2=AC=C2=B5=C2=A5=C2=B4=C2=
=BF=C3=92=C3=94YES\OK=C2=BB=C3=B2=C3=86=C3=A4=C3=8B=C3=BB=C2=BC=C3=B2=C2=B5=
=C2=A5=C2=B4=C3=8A=C2=BB=C3=A3=C2=B5=C3=84=C2=BB=C3=98=C2=B8=C2=B4=C2=B2=C2=
=A2=C2=B2=C2=BB=C2=B9=C2=B9=C2=B3=C3=89=C2=B7=C2=A2=C2=BC=C3=BE=C3=88=C3=8B=
=C2=B6=C3=94=C3=88=C3=8E=C2=BA=C3=8E=C2=BD=C2=BB=C3=92=C3=97=C2=BB=C3=B2=C2=
=BA=C3=8F=C3=8D=C2=AC=C3=96=C2=AE=C3=95=C3=BD=C3=8A=C2=BD=C3=88=C2=B7=C3=88=
=C3=8F=C2=BB=C3=B2=C2=BD=C3=93=C3=8A=C3=9C=C2=A3=C2=AC=C3=87=C3=AB=C3=93=C3=
=AB=C2=B7=C2=A2=C2=BC=C3=BE=C3=88=C3=8B=C3=94=C3=99=C2=B4=C3=8E=C3=88=C2=B7=
=C3=88=C3=8F=C3=92=C3=94=C2=BB=C3=B1=C2=B5=C3=83=C3=83=C3=B7=C3=88=C2=B7=C3=
=8A=C3=A9=C3=83=C3=A6=C3=92=C3=A2=C2=BC=C3=BB=C2=A1=C2=A3=C2=B7=C2=A2=C2=BC=
=C3=BE=C3=88=C3=8B=C2=B2=C2=BB=C2=B6=C3=94=C3=88=C3=8E=C2=BA=C3=8E=C3=8A=C3=
=9C=C3=8E=C3=84=C2=BB=C2=AF=C2=B2=C3=AE=C3=92=C3=AC=C3=93=C2=B0=C3=8F=C3=AC=
=C2=B6=C3=B8=C2=B5=C2=BC=C3=96=C3=82=C2=B9=C3=8A=C3=92=C3=A2=C2=BB=C3=B2=C2=
=B4=C3=AD=C3=8E=C3=B3=C3=8A=C2=B9=C3=93=C3=83=C2=B8=C3=83=C2=B5=C3=88=C3=90=
=C3=85=C3=8F=C2=A2=C3=8B=C3=B9=C3=94=C3=AC=C2=B3=C3=89=C2=B5=C3=84=C3=88=C3=
=8E=C2=BA=C3=8E=C3=96=C2=B1=C2=BD=C3=93=C2=BB=C3=B2=C2=BC=C3=A4=C2=BD=C3=93=
=C3=8B=C3=B0=C2=BA=C2=A6=C2=B3=C3=90=C2=B5=C2=A3=C3=94=C3=B0=C3=88=C3=8E=C2=
=A1=C2=A3
This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you ar=
e not the intended recipient, please do not read, copy, distribute, or use =
this information. If you have received this transmission in error, please n=
otify the sender immediately by reply e-mail and then delete this message.
Electronic communications may contain computer viruses or other defects inh=
erently, may not be accurately and/or timely transmitted to other systems, =
or may be intercepted, modified ,delayed, deleted or interfered. OPPO shall=
 not be liable for any damages that arise or may arise from such matter and=
 reserves all rights in connection with the email.
Unless expressly stated, this e-mail and its attachments are provided witho=
ut any warranty, acceptance or promise of any kind in any country or region=
, nor constitute a formal confirmation or acceptance of any transaction or =
contract. The sender, together with its affiliates or any shareholder, dire=
ctor, officer, employee or any other person of any such institution (herein=
after referred to as "sender" or "OPPO") does not waive any rights and shal=
l not be liable for any damages that arise or may arise from the intentiona=
l or negligent use of such information.
Cultural Differences Disclosure: Due to global cultural differences, any re=
ply with only YES\OK or other simple words does not constitute any confirma=
tion or acceptance of any transaction or contract, please confirm with the =
sender again to ensure clear opinion in written form. The sender shall not =
be responsible for any direct or indirect damages resulting from the intent=
ional or misuse of such information.
________________________________
OPPO

=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=E6=
=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=88=E5=8C=85=E5=90=
=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=89=E4=BD=BF=E7=94=A8=
=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=E7=
=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E5=
=88=87=E5=8B=BF=E4=BC=A0=E6=92=AD=E3=80=81=E5=88=86=E5=8F=91=E3=80=81=E5=A4=
=8D=E5=88=B6=E3=80=81=E5=8D=B0=E5=88=B7=E6=88=96=E4=BD=BF=E7=94=A8=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E4=B9=8B=E4=BB=BB=E4=BD=95=E9=83=A8=E5=88=86=E6=88=96=E5=
=85=B6=E6=89=80=E8=BD=BD=E4=B9=8B=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=EF=BC=
=8C=E5=B9=B6=E8=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=
=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=
=82
=E7=BD=91=E7=BB=9C=E9=80=9A=E8=AE=AF=E5=9B=BA=E6=9C=89=E7=BC=BA=E9=99=B7=E5=
=8F=AF=E8=83=BD=E5=AF=BC=E8=87=B4=E9=82=AE=E4=BB=B6=E8=A2=AB=E6=88=AA=E7=95=
=99=E3=80=81=E4=BF=AE=E6=94=B9=E3=80=81=E4=B8=A2=E5=A4=B1=E3=80=81=E7=A0=B4=
=E5=9D=8F=E6=88=96=E5=8C=85=E5=90=AB=E8=AE=A1=E7=AE=97=E6=9C=BA=E7=97=85=E6=
=AF=92=E7=AD=89=E4=B8=8D=E5=AE=89=E5=85=A8=E6=83=85=E5=86=B5=EF=BC=8COPPO=
=E5=AF=B9=E6=AD=A4=E7=B1=BB=E9=94=99=E8=AF=AF=E6=88=96=E9=81=97=E6=BC=8F=E8=
=80=8C=E5=BC=95=E8=87=B4=E4=B9=8B=E4=BB=BB=E4=BD=95=E6=8D=9F=E5=A4=B1=E6=A6=
=82=E4=B8=8D=E6=89=BF=E6=8B=85=E8=B4=A3=E4=BB=BB=E5=B9=B6=E4=BF=9D=E7=95=99=
=E4=B8=8E=E6=9C=AC=E9=82=AE=E4=BB=B6=E7=9B=B8=E5=85=B3=E4=B9=8B=E4=B8=80=E5=
=88=87=E6=9D=83=E5=88=A9=E3=80=82
=E9=99=A4=E9=9D=9E=E6=98=8E=E7=A1=AE=E8=AF=B4=E6=98=8E=EF=BC=8C=E6=9C=AC=E9=
=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E6=97=A0=E6=84=8F=E4=BD=
=9C=E4=B8=BA=E5=9C=A8=E4=BB=BB=E4=BD=95=E5=9B=BD=E5=AE=B6=E6=88=96=E5=9C=B0=
=E5=8C=BA=E4=B9=8B=E8=A6=81=E7=BA=A6=E3=80=81=E6=8B=9B=E6=8F=BD=E6=88=96=E6=
=89=BF=E8=AF=BA=EF=BC=8C=E4=BA=A6=E6=97=A0=E6=84=8F=E4=BD=9C=E4=B8=BA=E4=BB=
=BB=E4=BD=95=E4=BA=A4=E6=98=93=E6=88=96=E5=90=88=E5=90=8C=E4=B9=8B=E6=AD=A3=
=E5=BC=8F=E7=A1=AE=E8=AE=A4=E3=80=82 =E5=8F=91=E4=BB=B6=E4=BA=BA=E3=80=81=
=E5=85=B6=E6=89=80=E5=B1=9E=E6=9C=BA=E6=9E=84=E6=88=96=E6=89=80=E5=B1=9E=E6=
=9C=BA=E6=9E=84=E4=B9=8B=E5=85=B3=E8=81=94=E6=9C=BA=E6=9E=84=E6=88=96=E4=BB=
=BB=E4=BD=95=E4=B8=8A=E8=BF=B0=E6=9C=BA=E6=9E=84=E4=B9=8B=E8=82=A1=E4=B8=9C=
=E3=80=81=E8=91=A3=E4=BA=8B=E3=80=81=E9=AB=98=E7=BA=A7=E7=AE=A1=E7=90=86=E4=
=BA=BA=E5=91=98=E3=80=81=E5=91=98=E5=B7=A5=E6=88=96=E5=85=B6=E4=BB=96=E4=BB=
=BB=E4=BD=95=E4=BA=BA=EF=BC=88=E4=BB=A5=E4=B8=8B=E7=A7=B0=E2=80=9C=E5=8F=91=
=E4=BB=B6=E4=BA=BA=E2=80=9D=E6=88=96=E2=80=9COPPO=E2=80=9D=EF=BC=89=E4=B8=
=8D=E5=9B=A0=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B9=8B=E8=AF=AF=E9=80=81=E8=80=8C=
=E6=94=BE=E5=BC=83=E5=85=B6=E6=89=80=E4=BA=AB=E4=B9=8B=E4=BB=BB=E4=BD=95=E6=
=9D=83=E5=88=A9=EF=BC=8C=E4=BA=A6=E4=B8=8D=E5=AF=B9=E5=9B=A0=E6=95=85=E6=84=
=8F=E6=88=96=E8=BF=87=E5=A4=B1=E4=BD=BF=E7=94=A8=E8=AF=A5=E7=AD=89=E4=BF=A1=
=E6=81=AF=E8=80=8C=E5=BC=95=E5=8F=91=E6=88=96=E5=8F=AF=E8=83=BD=E5=BC=95=E5=
=8F=91=E7=9A=84=E6=8D=9F=E5=A4=B1=E6=89=BF=E6=8B=85=E4=BB=BB=E4=BD=95=E8=B4=
=A3=E4=BB=BB=E3=80=82
=E6=96=87=E5=8C=96=E5=B7=AE=E5=BC=82=E6=8A=AB=E9=9C=B2=EF=BC=9A=E5=9B=A0=E5=
=85=A8=E7=90=83=E6=96=87=E5=8C=96=E5=B7=AE=E5=BC=82=E5=BD=B1=E5=93=8D=EF=BC=
=8C=E5=8D=95=E7=BA=AF=E4=BB=A5YES\OK=E6=88=96=E5=85=B6=E4=BB=96=E7=AE=80=E5=
=8D=95=E8=AF=8D=E6=B1=87=E7=9A=84=E5=9B=9E=E5=A4=8D=E5=B9=B6=E4=B8=8D=E6=9E=
=84=E6=88=90=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=AF=B9=E4=BB=BB=E4=BD=95=E4=BA=A4=
=E6=98=93=E6=88=96=E5=90=88=E5=90=8C=E4=B9=8B=E6=AD=A3=E5=BC=8F=E7=A1=AE=E8=
=AE=A4=E6=88=96=E6=8E=A5=E5=8F=97=EF=BC=8C=E8=AF=B7=E4=B8=8E=E5=8F=91=E4=BB=
=B6=E4=BA=BA=E5=86=8D=E6=AC=A1=E7=A1=AE=E8=AE=A4=E4=BB=A5=E8=8E=B7=E5=BE=97=
=E6=98=8E=E7=A1=AE=E4=B9=A6=E9=9D=A2=E6=84=8F=E8=A7=81=E3=80=82=E5=8F=91=E4=
=BB=B6=E4=BA=BA=E4=B8=8D=E5=AF=B9=E4=BB=BB=E4=BD=95=E5=8F=97=E6=96=87=E5=8C=
=96=E5=B7=AE=E5=BC=82=E5=BD=B1=E5=93=8D=E8=80=8C=E5=AF=BC=E8=87=B4=E6=95=85=
=E6=84=8F=E6=88=96=E9=94=99=E8=AF=AF=E4=BD=BF=E7=94=A8=E8=AF=A5=E7=AD=89=E4=
=BF=A1=E6=81=AF=E6=89=80=E9=80=A0=E6=88=90=E7=9A=84=E4=BB=BB=E4=BD=95=E7=9B=
=B4=E6=8E=A5=E6=88=96=E9=97=B4=E6=8E=A5=E6=8D=9F=E5=AE=B3=E6=89=BF=E6=8B=85=
=E8=B4=A3=E4=BB=BB=E3=80=82
This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you ar=
e not the intended recipient, please do not read, copy, distribute, or use =
this information. If you have received this transmission in error, please n=
otify the sender immediately by reply e-mail and then delete this message.
Electronic communications may contain computer viruses or other defects inh=
erently, may not be accurately and/or timely transmitted to other systems, =
or may be intercepted, modified ,delayed, deleted or interfered. OPPO shall=
 not be liable for any damages that arise or may arise from such matter and=
 reserves all rights in connection with the email.
Unless expressly stated, this e-mail and its attachments are provided witho=
ut any warranty, acceptance or promise of any kind in any country or region=
, nor constitute a formal confirmation or acceptance of any transaction or =
contract. The sender, together with its affiliates or any shareholder, dire=
ctor, officer, employee or any other person of any such institution (herein=
after referred to as "sender" or "OPPO") does not waive any rights and shal=
l not be liable for any damages that arise or may arise from the intentiona=
l or negligent use of such information.
Cultural Differences Disclosure: Due to global cultural differences, any re=
ply with only YES\OK or other simple words does not constitute any confirma=
tion or acceptance of any transaction or contract, please confirm with the =
sender again to ensure clear opinion in written form. The sender shall not =
be responsible for any direct or indirect damages resulting from the intent=
ional or misuse of such information.
