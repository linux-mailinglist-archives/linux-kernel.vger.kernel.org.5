Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D9A7EC155
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjKOLfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbjKOLev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:34:51 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2062.outbound.protection.outlook.com [40.107.255.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56682198
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 03:34:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSzme3dxTW0glTh9wgzW6SfPgnkbfEDSR/uqYSXdEVOtooHW1UUkGPBtPjwKV6qfgo7RULVj4t+LIsyUIgD0eKA5tX8wqQgbFFUoGH/t5wufX7zsnf28Rsvt7dad+lPO9WeBJ29F//J5e5OD3/k2bcBXfDulxpx8lbrUN1z5IMWrxbsVAWF+CmVtrhPVYVMaYIv+FVwMoBls+3kx2FBgGCIky3kVWdASNlHOJrtw6VJGFSw8YKxq9chNS9JqHFnElwn18so86WKr4uogygiCc8oDs7DESY2SbB3XeQZdJD6JVMz+QYt907h5mg5G/gVKVoKtvcMUxEKgQHrZsOcRJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsPU8LFkQUSiZIliRxzdRVFjlQcvLgvhMb63/+bN8w0=;
 b=AfCgtx4svv5vnlq4wYC1aKMrzcoJKGTfPmK6E26Ji33o548+jG/mKSlEHGAPNbDz4ydO+9i9+oDteuNxtkLee0ovN5yhv/G7bcc3II5Wu632tZRZepaw+VnQ/dqLV3/FkIeOBzXUPB0y34yHLo38lY1a35Sh2Yj2SeBxarIE6i3yPCkI+qapK/6qV2UnrmN2queF8a799aazGv5NY9V4ZP3mCJk1AcSPXXAyKJKo86Q24AWACEPk3ThNgOHDSbWAPxKNOVvB4H0ChzjtStsp3OJq8r3BFFlGJvumAXDJw9Lw0mFEt2Uvep2atwsv6G46sHBfXKrcUcOwTd8nswUssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=kernel.org smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsPU8LFkQUSiZIliRxzdRVFjlQcvLgvhMb63/+bN8w0=;
 b=jONBX3fdGdFjoS9n1+11sfJuMdRZl6EfQ3y0fVqoc+fFo4V8HwemJq4OIdwxNPyNbvMYq2hOOIMeXEpqNnosAbtUGpdt9BD6PEywyM9tRhp+Tga+A17niCNio/rm06NYJNfThCptkPYHwMVFHsrYcXwbkcbDgH0soCaoqIk7NOE=
Received: from PS2PR03CA0018.apcprd03.prod.outlook.com (2603:1096:300:5b::30)
 by SEZPR02MB7688.apcprd02.prod.outlook.com (2603:1096:101:1e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 11:34:39 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::c8) by PS2PR03CA0018.outlook.office365.com
 (2603:1096:300:5b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18 via Frontend
 Transport; Wed, 15 Nov 2023 11:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 11:34:38 +0000
Received: from PA80318969.adc.com (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 15 Nov
 2023 19:34:35 +0800
From:   huangzaiyang <huangzaiyang@oppo.com>
To:     <tj@kernel.org>, <jiangshanlai@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        huangzaiyang <huangzaiyang@oppo.com>,
        ZaiYang Huang <hzy0719@163.com>
Subject: [PATCH] workqueue: Make a warning when a pending delay work being re-init
Date:   Wed, 15 Nov 2023 19:34:27 +0800
Message-ID: <20231115113427.1420-1-huangzaiyang@oppo.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.16.40.118]
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw30.adc.com
 (172.16.56.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|SEZPR02MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: ed636b30-ef9b-4831-bdb5-08dbe5ceda31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pzqZKuVdH6wE+tk0xBuvrp7x6AcuvrN3K9ZC5x8osd8khazgIlTGVs8sunWK1bhAG688ekKiUfcRExLe3YGfPhiF3ePSwWqo9+Yc31de4MPE3RNkh2ldWLD3cLxaT/KgORtyaqyVppiGUBU0DBq2ywtGcymnS9777NQkppCA0JB/IlTUuJfAMyqNfHmF0HSbCWhmUOkGN19qCRNqXytQzGzsvKQDYDRgbZKzrAxe4+mbTYTPGMSC6uYvmCADCy75gxod4QxnOtPWoUqHt7QtB5B8y2yy5X49B0OwSw3y/EAiEJtGlK/vCYuyq7lnjsKHC/RZy8rIV7kOhvLORJh/w88TDsLrOhXJXIE9pLcAa0yemzSVxHG8f1zxaZGO3VzNTVQTA98LZcVRN/ni399msm7d+hHFc0Lqv8Rx4OEeKvnetxe92aTMnx04/21gCOa9d64kS0ASc/XvTD7Bw2ND9ATi8VHQ5RmpjjbQjIiRZq8/+wi2T9VWGO9UEVMeWJRp9N2gcEkFxaMQrEI6OAB6qW5GSEIymipVXNMNpdsYY0IzRsUu713/5Fz6qq4k4Nec+yAbET6fqvfOK8/dOiU7Yu+N+yh3c1lhxJMi/N1wBhIV7KWTBpnV1c7GgPUdGA+1Wb60i8mH2ddcunwgOWLnwS3sNJwDpJbLTW2RUJx/tpOahFdslDhrewyrofRHfvvG340Y+f0NEzcFbvnr8j1Z/9A2Pv8fJwJyjNH2LU9uhqmqd2YWFfkK4+uxH1s0F7LpyS6HltJ8ntvvVEqvXeNhdQweb7/YeR8ovgigmCWghuI=
X-Forefront-Antispam-Report: CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(230273577357003)(230173577357003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(36840700001)(46966006)(40470700004)(40460700003)(1076003)(41300700001)(26005)(2616005)(6666004)(83380400001)(4326008)(47076005)(8676002)(5660300002)(8936002)(2906002)(16526019)(336012)(478600001)(966005)(316002)(36860700001)(110136005)(54906003)(70586007)(36756003)(70206006)(86362001)(82740400003)(356005)(81166007)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 11:34:38.8055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed636b30-ef9b-4831-bdb5-08dbe5ceda31
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7688
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a timer_list race condition if a delay work is queued twice,
this usually won't happen unless someone reinitializes the task before perf=
orming the enqueue operation,like=C3=AF=C2=BC?
https://github.com/torvalds/linux/blob/master/drivers/devfreq/devfreq.c#L48=
7
A warning message will help developers identify this irregular usage.

Signed-off-by: ZaiYang Huang <hzy0719@163.com>
---
 include/linux/workqueue.h | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 24b1e5070f4d..54102ed794e5 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -266,6 +266,22 @@ static inline void destroy_delayed_work_on_stack(struc=
t delayed_work *work) { }
 static inline unsigned int work_static(struct work_struct *work) { return =
0; }
 #endif

+/**
+ * work_pending - Find out whether a work item is currently pending
+ * @work: The work item in question
+ */
+#define work_pending(work) \
+       test_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))
+
+/**
+ * delayed_work_pending - Find out whether a delayable work item is curren=
tly
+ * pending
+ * @w: The work item in question
+ */
+#define delayed_work_pending(w) \
+       work_pending(&(w)->work)
+
+
 /*
  * initialize all of a work item in one go
  *
@@ -310,6 +326,7 @@ static inline unsigned int work_static(struct work_stru=
ct *work) { return 0; }

 #define __INIT_DELAYED_WORK(_work, _func, _tflags)                     \
        do {                                                            \
+               WARN_ON(delayed_work_pending(_work));                   \
                INIT_WORK(&(_work)->work, (_func));                     \
                __init_timer(&(_work)->timer,                           \
                             delayed_work_timer_fn,                     \
@@ -318,6 +335,7 @@ static inline unsigned int work_static(struct work_stru=
ct *work) { return 0; }

 #define __INIT_DELAYED_WORK_ONSTACK(_work, _func, _tflags)             \
        do {                                                            \
+               WARN_ON(delayed_work_pending(_work));                   \
                INIT_WORK_ONSTACK(&(_work)->work, (_func));             \
                __init_timer_on_stack(&(_work)->timer,                  \
                                      delayed_work_timer_fn,            \
@@ -342,21 +360,6 @@ static inline unsigned int work_static(struct work_str=
uct *work) { return 0; }
 #define INIT_RCU_WORK_ONSTACK(_work, _func)                            \
        INIT_WORK_ONSTACK(&(_work)->work, (_func))

-/**
- * work_pending - Find out whether a work item is currently pending
- * @work: The work item in question
- */
-#define work_pending(work) \
-       test_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))
-
-/**
- * delayed_work_pending - Find out whether a delayable work item is curren=
tly
- * pending
- * @w: The work item in question
- */
-#define delayed_work_pending(w) \
-       work_pending(&(w)->work)
-
 /*
  * Workqueue flags and constants.  For details, please refer to
  * Documentation/core-api/workqueue.rst.
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
