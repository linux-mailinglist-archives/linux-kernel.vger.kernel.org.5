Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1837E0E72
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 09:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjKDI67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 04:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjKDI6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 04:58:54 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2071.outbound.protection.outlook.com [40.92.98.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED82B10C3;
        Sat,  4 Nov 2023 01:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7gEJz9OLrKrJ4NXabR6B/HRDc9rJEpQ/s+b5MNWBVmOwIqhhIhoANJI7wUKg+yTqpyo+WUeix0imBE2q7/uH24djnPBLGaiNsNpbOW9ep8aPNZKDYUyvzFCN93YgkY87AJbM9bH18boCmf7BTEKo4Y5mu253jQ2sSgoKe2wtXeCgwo54JX1AdHgDSG9ObCZZLprrNJtKLDiqyK7m/cmvKtm+Rs2AnHK8mwiCOpScmEjGjXc+vMy8w7e7Dm0cQSuNdogYA3X07DcQzc0KI5X51b1E5cgq1A+yHrjQQZB/hm9XmT+GMgZy77kswuS5zN1/kOOsqpaC7kMCh84mLmIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ckt80JXpGB8R1BBajScypxfzDcInTJdPlUGN9F2/SAk=;
 b=FK8ERMJeJVwMV+YOIdKmxX+12yS+GvW9UeHqf6FAHsb5YdjDoAiQC09m5IA+0VmI+KyWTTqm/sXQy5cEnk8Q38WUTArgsukyRLOZgwyRFDiJBYb9AyzAXVhvgj0B8dafflnPOtIR2UybF2SDOj00baim6olk5EjSMhNzGNS2ko2/mQZamQQ/MsecDEhShppYzRcJFEhtMMSMhTF+Ky0v7ugnb0xSwKf5YzbWRBukvOHS+UQO9X/VHldrd7zJE4Q5p5zz2BH8kkqvrLQxYBDOW6u2EwICF+NWTSsYFJCJk5SnAeQ5qJsndUrSZS3ljkfQY0n42T1dzthfxDWfiaOJiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ckt80JXpGB8R1BBajScypxfzDcInTJdPlUGN9F2/SAk=;
 b=qDHAMvFIdahOkWUNtGTB1aoZkGM4N84klyoIvDyYibbRrzd1N9rQ7z6R+nGJ+kOS9v4pIYaExdP606XhKR+HzU/OkBSEobaiT1l9e2dbFJhdm3xxY7R6qyhlNV0SJjJQW3RQWpQYR37UjB7HZ2z6yQME0f9oZg/cyUAiJq4XPYfIKok1+LN1JQXh/iVpIAFWoxBnm3f4zzylmIpiUr8Mh51qfzT2UASxxT3mpJ1SoKftZE1S5TPvLKZph4lVz2km8eV1oo1QMCcBHCmh6jR5e3jG9ckb51k56qXa51GxPjrJxSnu+njzNVATxgHzMatZv0YK3Ua4iSxu1jpkHx9bhg==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYCP286MB2289.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Sat, 4 Nov
 2023 08:58:20 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6954.025; Sat, 4 Nov 2023
 08:58:19 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>, Kalle Valo <kvalo@kernel.org>,
        linux-kernel@vger.kernel.org, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH v2 2/3] wifi: rt2x00: disable RTS threshold for rt2800 by default
Date:   Sat,  4 Nov 2023 16:57:59 +0800
Message-ID: <TYAP286MB03155DDB953155B7A2DE849ABCA4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231104085800.17576-1-yangshiji66@outlook.com>
References: <20231104085800.17576-1-yangshiji66@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [6GqaJoIfJRJxobY0hzO5XyBv7iyUCwx7]
X-ClientProxiedBy: TYCP301CA0090.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::17) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231104085800.17576-3-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYCP286MB2289:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dea664b-c366-4fe4-ffe9-08dbdd14311a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GyHX3Db1voPLtn22fOuGBvitMwUs1MDmsd/jeVpoVpirXFJXQl4nez203+xYo4uXr+W5//3xcAFkpdxN/M2xbZdkDv4IyB3ZEKLHQd+Z2z1AokElZ8TogzRfeuavGcJ3UoQiWfgua2KF6kBNApg+IkITPZpaCFcPr/C6SZ5tdaWLOX3OyFjBeQy0DSYusIieKGi9wq4NIK7c35NcrgG84Sv2GJiOMM6acUJow1BXeYie/WXINAwQ2EQNxhIl3jZEDrunoCg8br3l1lT7wRACDoYy/LczmYuK5R6XXWBSf77px1tGVLWDkRc20XnWed5BUp8mIbVh50tIp0QgQq44PIW9FqmbGA0zGRWt1PiwOeVEH304egP+367uJpDmmdPUvXbpOu8XP4mSwOEslNPJqcN3qhzr7F9hXdYusZWekkGd6pxFVIncJbY51EmPG6qH2iZVt9WpU9SXYhvv91sdgKriA3JgswvA3wuah84PK+XFe5mfM/sdWupxcxAd194XNt1DN79vpT0sDGaa0KUmieNCvffWeGaX/t09MHxtGclhHGwXqGqao431QcqATe5j8inNysA3z8Dywg5KBMMJu+a2+U63oLIbR87cmPnVpHc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PDtZWTxrkAHhR+gURBg5TbpI8tlVwp+h/ezGL+db+i1CQyT4/yZcPpAL790e?=
 =?us-ascii?Q?U66kRLnSvk6FVlIYKOyYa3uFqQCN2gWVVsZyRB9uFDpMHOCIVzdk6xE07RKv?=
 =?us-ascii?Q?nPJfk76Cgf5//++l5PzgF33tcPIyJnk76aIWKkpIz/DSegqCwes+Mlr4f3o8?=
 =?us-ascii?Q?JCz6GyHCKirg6Yfz2gNw691dFvInjrCBaG51KDn+OhUlWBET6zyZXsYxD9R3?=
 =?us-ascii?Q?YE7ftHR0cZ7PqfvrhAitiXUKL43L2rL7x1+qF0QQIgv4C6C+eBaZQvwAtsL8?=
 =?us-ascii?Q?uc1JyZGEXa6WPpBuXLBzAIO979544c4DmcuPNUFAyv3Om32IM3YGkc6ro/Tv?=
 =?us-ascii?Q?8V7bjXv0SqWhu5IQ6YLcgRbACaZcEk9I2euxAYwrLv0B1Cclk2BThg87zyno?=
 =?us-ascii?Q?kHu502DG/jawoF92at/636eqF7dNLtVFC05XiDB9r/5AenyJF/n9i8m/oDaq?=
 =?us-ascii?Q?hvtmX5TfD5O6AlEg6P5sZP+vPTtpOCAwSyz/i5O+yDdH51pFkS2g5JSV4/2D?=
 =?us-ascii?Q?Zi2ugvQCnyIMSOtiCenQ+dROZZFSgkYmMnqX0tXv8rW/l5A4LGfhI3roFCJw?=
 =?us-ascii?Q?C4MumiflzBuwadqpakBUeGqMq2gCq8EODGdtc5HsSp+iRkolwGQ8moWcy4Rr?=
 =?us-ascii?Q?aQVPVwUW67Hkh+K8NqaWGFCFVwCC8NyuWsZvaTXycN4Fwr1InWC4ckdIGQsf?=
 =?us-ascii?Q?oRSLqK0iulVjtlb0ineQkVd9eTxUHimpdVVx4QUa7nYOH13SCDggJIwhye/S?=
 =?us-ascii?Q?zNkot3GZcSg4OH8zqlFkdE/Kc7hQdUah/+65UoI2womxjQJi0vAXRkSwI1EL?=
 =?us-ascii?Q?14kSv+Kc1eqWDSSXeJZ31fk8XVbc31+1F6mxR5XwlMWjYMFZFJD0AMdPrIbr?=
 =?us-ascii?Q?gWeOMtrERwMXzPJp0FRGy5PVwjLx5BoNNnHlbwl6m/tweyexYvbFXiluTF+L?=
 =?us-ascii?Q?GHxJNUuCOYY3RytmTFoKMWfLW/PzWHriq9r8cdPtB1xrgTpK2l4qmqUmLtmR?=
 =?us-ascii?Q?ek7rvAll1T6PXyrtdU9CWlPU60iBgPmIHC324AYO3WgauajhgCd5goFgoXen?=
 =?us-ascii?Q?W6Fv4fUAmu+vJlZxnioyA0qMrnLXJnW8UxiRSJp0o2axuNDZPHQLhNMmQ+ED?=
 =?us-ascii?Q?bFRXXuDBozAUUMk2OQVAIsh727AqVmvQUCRz4o1yR23FwQ6qkq8Tt14xe+wq?=
 =?us-ascii?Q?b18089OacVyh+YMwYm6JqLbJjFVxgyU4wYpZIzWlbDxQ0pNYaa6RE5thDNo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dea664b-c366-4fe4-ffe9-08dbdd14311a
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:58:19.9348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2289
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rt2800 has a lot of registers to control the RTS enable/disable
status for different rates. And the driver control them via
rt2800_set_rts_threshold(). When RTS was disabled in user
interface, this function won't be called at all. This means that
the RTS is still 'on' for CCK and OFDM rates. So we'd better to
disable them by default because it should be like this. The RTS
for HT20 and HT40 is already default off so we don't need to
touch them. If we toggle the RTS status, these register bits
will be enable/disable again by rt2800_set_rts_threshold().

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index be4f7c144..04855490f 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -6099,7 +6099,7 @@ static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
 	rt2x00_set_field32(&reg, CCK_PROT_CFG_TX_OP_ALLOW_MM40, 0);
 	rt2x00_set_field32(&reg, CCK_PROT_CFG_TX_OP_ALLOW_GF20, 1);
 	rt2x00_set_field32(&reg, CCK_PROT_CFG_TX_OP_ALLOW_GF40, 0);
-	rt2x00_set_field32(&reg, CCK_PROT_CFG_RTS_TH_EN, 1);
+	rt2x00_set_field32(&reg, CCK_PROT_CFG_RTS_TH_EN, 0);
 	rt2800_register_write(rt2x00dev, CCK_PROT_CFG, reg);
 
 	reg = rt2800_register_read(rt2x00dev, OFDM_PROT_CFG);
@@ -6112,7 +6112,7 @@ static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
 	rt2x00_set_field32(&reg, OFDM_PROT_CFG_TX_OP_ALLOW_MM40, 0);
 	rt2x00_set_field32(&reg, OFDM_PROT_CFG_TX_OP_ALLOW_GF20, 1);
 	rt2x00_set_field32(&reg, OFDM_PROT_CFG_TX_OP_ALLOW_GF40, 0);
-	rt2x00_set_field32(&reg, OFDM_PROT_CFG_RTS_TH_EN, 1);
+	rt2x00_set_field32(&reg, OFDM_PROT_CFG_RTS_TH_EN, 0);
 	rt2800_register_write(rt2x00dev, OFDM_PROT_CFG, reg);
 
 	reg = rt2800_register_read(rt2x00dev, MM20_PROT_CFG);
-- 
2.39.2

