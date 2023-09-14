Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414F179F82D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjINCey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjINCex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:34:53 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2014.outbound.protection.outlook.com [40.92.53.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C92CE4;
        Wed, 13 Sep 2023 19:34:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEGyyA1Dl2iYvI0fiM4WkQQK1+8t2pSikwQQovA1VmVDUPLTwfLDxhVzFobitqIsYTMp+Amc/5u28d1Ze71/tlut6pdDlZDTXXC4g8ct4GTaoBJmBgVRNEjHwRJqYRv+UFJRmI+/itfOaTsOYovjZNa+IrkgJhVeLnV55fbOhvT6eimXZEgmKf+6CCVJ7oemgJYdRw5lrZDYn/O+5/iwZlVy39s4IWO/TxX3ztNcKrW6AE7gNlebrDkdihjV5psZZ+a2x+U7FW9xRQ0DwQKezX9xKu/4Cj7ztIx4IQ6bm9H/Xvx12L3UGcM/svkRQQ+3RgJ+zZ4N6oORZVUOGZJqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeuLeap8jPCG1UfUV2qhqMjqctK2pHmaxO9z8yJTCNw=;
 b=ex5+s7h2UPyFtYB1/+SqXYfkwoKte2e/Uc+ir3se2Kff+ZCYg9nERjix8rfJJRdpZlaKv7BGQkeOky6xRgO5QqFSktWKx2uaxjJlC+IoNtuJA+gjN2oXgg98wi4TtQ1UZJhOyHWBs/JNsDAbaIRYVJsh6JNwOFJDnnvSQyl2gc1UkmSwYaSsya3SxbztwncX1mBdUJbs4QHOqM5unPntoqDmWZLfiUtgCIrqzRIKEQnC07CvQaQu758Y3r4UKgTxferheUki3A1uvQDd8MHa1UQDDYJmyVwcurrrzYmWUH5oEoMsb4giWMGXFHJdThyqwuPFhcVDtBZen7DbJaH5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeuLeap8jPCG1UfUV2qhqMjqctK2pHmaxO9z8yJTCNw=;
 b=VwYvBxWq9w8/2LQMgcZy7RMMc/Fv9I1t4RM4R4BdPnPgQ0t/OQYRbUfXJeFADfJYsQF4irKd+YJyAQofCrtNgr9l1hHu35UHP0/GgPwiiCdQH4v1k29YWBvqQKgjzCxnf6UBf3P9eTgExwGWsy14LeV9pcvd+1NPN9TRcyWcgb1l477Gd1gzWkLXNqLf1j7TjtFGKRaBu/rCKU76wWF8CNThMfNo24b8Ii7VMe++bzh5mSnRmmNyp+Iyjzn9FANKEGLGAtbFfgtNkSR0Jy2lUcqW4r/GVXaPCOI00MAJOiqBGjXigqHaxNnV1B00fM2dM02LlL8i7rISxXtuDR/rCg==
Received: from KL1PR01MB3809.apcprd01.prod.exchangelabs.com
 (2603:1096:820:41::14) by SI2PR01MB4524.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1e3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 02:34:44 +0000
Received: from KL1PR01MB3809.apcprd01.prod.exchangelabs.com
 ([fe80::fa4e:3c3d:23cc:79b5]) by KL1PR01MB3809.apcprd01.prod.exchangelabs.com
 ([fe80::fa4e:3c3d:23cc:79b5%6]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 02:34:44 +0000
From:   Ken Lin <ken_lin5@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     groeck@chromium.org, Benson Leung <bleung@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Kevin Chiu <kevin.chiu.17802@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rory Liu <hellojacky0226@hotmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Zoey Wu <zoey_wu@wistron.corp-partner.google.com>,
        chrome-platform@lists.linux.dev, linux-media@vger.kernel.org
Subject: [PATCH] media: platform: cros-ec: Add Taranza to the match table
Date:   Thu, 14 Sep 2023 10:32:26 +0800
Message-ID: <SI2PR01MB38170C8A050C6541900EFE99AEF7A@SI2PR01MB3817.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [s0ATTfVbYG1oOwHO/UmNkoml8iSJRy3x]
X-ClientProxiedBy: PU1PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:803:2a::16) To SI2PR01MB3817.apcprd01.prod.exchangelabs.com
 (2603:1096:4:ee::5)
X-Microsoft-Original-Message-ID: <20230914103021.1.I407545b93a111516f5b73b8071e3b361ec20cb4d@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR01MB3809:EE_|SI2PR01MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: 649a75f2-10ec-44ef-b061-08dbb4cb2603
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dS3fEzoI/lsj9Cbab8X3eaKZU6eGMe/StyM2h2Bzc43qY86LCG7S6GwGozBBn4rtWUZ1DFv1/znHes+t+R1YnC4974Kv+SOevUVizDuXIoTbTXyxxrFFqwm+txtrxg7S44fGtrj6kQkILGQwQlM4WVUCIkrpj5LFyUHJHwAu90MUeWEJHwygdG29hyz3wIOse3Z8B+yGoIWX45mRmKWhFttdqN6yWXqo5sCbOzhQAbdJPX6nH+65yt5lTJOnxlpT9HfVl5FE4KLDPJ17NM92+wQLC6cbq+orhWgS/hvVAVvFRzn/6tI6MfbBQBdwBIOpOdHRlHP/9XvjDgW9yTGhVo80ew5ZO2sPdpvtyI8Et1J/mOHtokAIUgZS4fIF0Z9PGh3fmDCTXqy3HJR7xT9zIxZKD12nAtTjl6rs3EyiwJYUUC78uwZZ6bBE3lE8tQJgorfv7TsEuxVLtVeDlUnmGUEgjnRe5gnbV2O+59YCBkRUtUj/2atfzAfiY7pDpaxjEZUv5fFhtIfxGwLJ5cjz7lNhwyncgRyhNaKoKq0oo5O/mieIwUgs1kDuygFS82Vf
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RHUZ9JOAWbIxypUFy5y0VC8RG5HsyULFqeFAE3ZR64/StEfyXWZSD4ekix4I?=
 =?us-ascii?Q?K8m0HDkPzX9qQMPCxPUD+3VIH67bsluGbq3t13tvEuBsvdNI5bo3V2Iib+g0?=
 =?us-ascii?Q?el1J2WVff1kXgROTeJA/vYyJ4VJU74uJb3fqWOuVfKbm1KEWwclfwf/zUo+x?=
 =?us-ascii?Q?dweCPRJbkO5i1wt4ehTu8DvBKtw+5em7WK4KYEbw6koWXPC+hdzK7NWkczYu?=
 =?us-ascii?Q?vFuO4CmKIRnC/dDvoZ7m7gKrzzSUnhRk92OQdH5hncSbA608/tyz2phIjJtM?=
 =?us-ascii?Q?KH+YLDKV47tdQls9raN2Lc8SXGmiv8ROaPkXx3dgA3v5wCYnR+gZ4PQ6LBbH?=
 =?us-ascii?Q?zNYja4W8NK6X9aVdfMEjX7j6h6D5tOres00Lc7cC6imM61pwqubVAYGQ8WOM?=
 =?us-ascii?Q?7ecuNXfkLmtDtxTH4ie3t6ei9tw96QnAAuw/Nkx7DRcuvQd41cv7d3CSci5U?=
 =?us-ascii?Q?if/QSm5h9zt7RpPK29YPSCrAgbJe+ADkP57I417uLi+/8tTjGwcSGf1PNTwb?=
 =?us-ascii?Q?gN/XC956rmmu2fOjSFXR0zKh6f06muVmBdX3Q7WuwG4vcPUnbzWvAyiNBRaB?=
 =?us-ascii?Q?gA/MD9bvmQbvKeXr+AH7GTM4C/u1gm7Q3wRrgCjUndC0fbN+5C5lUEBdEPQ7?=
 =?us-ascii?Q?ikA7HEB7TGThv5dla01lZeX4356qXHVclZBzJJ154V5XFMEdRAgNCWUilMQd?=
 =?us-ascii?Q?l0NyELIpx4XwFHXE02FFE3RWYtqinB18W15gbp7tXqK1dxxS2dC1lF+tc3J9?=
 =?us-ascii?Q?jf7l0g/C+ZpteBYmgFTCKMCYOlprKILB4dgb0+u6vskcEP9eJ4dIxfYfA9KD?=
 =?us-ascii?Q?xGB2JJ1M6RygBJE5CxjfAlcgpYIOZBG+Mx4nbLM3hsjnL+hBvWeTwYsswLKe?=
 =?us-ascii?Q?PdfpPr8ojCrpssieNNJjywefcSx2e69cnUT0augvsIZOv4tk3JXYNboj69/j?=
 =?us-ascii?Q?6MlmFTylIR0oY8Ox7aC4EtOs9wKO+fFHc/Sv9E1eAdihJpcjC8r5H3qPBU6x?=
 =?us-ascii?Q?m0a41zL2F1OLot8lR6FKjn2fKzaWk1fXADfAGg8jWHPZNlv8/Sh1N2sPHsl9?=
 =?us-ascii?Q?KvKVCpg4qD7NBy4yVeFA9rCDeAcaHq3aOL+lHC2XL4pv2UWBbuo16qBoryRt?=
 =?us-ascii?Q?FfowdiEpoVHZdh04QBBGBQvkDjW3L8/6Js0vXiaoknAAj2qENKOP2Cv3myXB?=
 =?us-ascii?Q?PiQWIS32Q0MvIXbccZ/fpsG69xLYtOQIhhTH+A=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 649a75f2-10ec-44ef-b061-08dbb4cb2603
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB3817.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:34:44.2597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB4524
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Google Taranza device uses the same approach as the Google Brask
which enables the HDMI CEC via the cros-ec-cec driver.

Signed-off-by: Ken Lin <ken_lin5@hotmail.com>
---

 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index c17faf002877..a65da16c243d 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -231,6 +231,8 @@ static const struct cec_dmi_match cec_dmi_match_table[] = {
 	{ "Google", "Gladios", "0000:00:02.0", "Port B" },
 	/* Google Lisbon */
 	{ "Google", "Lisbon", "0000:00:02.0", "Port B" },
+	/* Google Taranza */
+	{ "Google", "Taranza", "0000:00:02.0", "Port D" },
 };
 
 static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
-- 
2.25.1

