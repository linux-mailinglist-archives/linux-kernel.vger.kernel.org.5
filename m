Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666707523F7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjGMNgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjGMNgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:36:23 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2166.outbound.protection.outlook.com [40.92.63.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673502117;
        Thu, 13 Jul 2023 06:36:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxNQClUl2kkYypFC0l5TDFnohK2hKE1Mnje9xn/cA8pZGyAT719dYmPRpC8EBudzbzn6DwP4Eauh2ATQG1gcO7dq5HHt4TBsW9Lia+9Y03cBQcnC2sHARBCDfo1CtKaYBSqXfArwvIQ5CeN29SYhGY98fZJKuL6S1rUO4SNL79hQi6kabtBEleRZ3sLYN9colDk6H9AXN9e+2mY2hyK8R0ia2dUkxGu8F4/aT991btPGhTcfgaVi6+jGbz5Evy70WtOSBPeLIToZo7PtKl7yBLVOMfPndZaGJv/GEHG9XUTNPV4hnDOPZ/tfgMWw4ovdcB6kJjHxZCpM65vaLo3L3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2R7AIAXQSBoQ4lD/ydBuXX+CA6cPmpgWbd2F7HkpDs=;
 b=Y35v8hi8okQLGZ+KDmnQMJBk8t81fqP/JZEiVmNf9FVlJTZw1gD+ypiN6RBY0CNyDzvNF+I+HLztMvj6Zk6oxFfkOOvsHdmQ1vbw38paiSrdptVAnRL10hEHzQu0aGtKPnoViwzRh/K7wKPFmDoItDsGkbkeRCLL0usBCcnP1gQVhlHL9h5oNWk0JakCgDTkSii7TTWVuGB4WvlG9PIp/obUbc4TC+PG1DT5KlnEmtf0H43BYRDEoSnU6RTwwmclvJP9S+4EE5RHy1nUhoAP07mxZ+Imz8m08ZRG3tzZ9d8ckFZQTwJ6FuWxyJqDRMEmPzIp65ASfm5EZ7M8kK9XoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2R7AIAXQSBoQ4lD/ydBuXX+CA6cPmpgWbd2F7HkpDs=;
 b=e8EC7YTqHMpkgYEowCfTYz4JL+Jnjy4o6gTj5BuAlakX4eapofEfEmAU6i6/BSQYKsdbWQS2WK+Ssd4fUV1mm+e6lwGRcYTeJoOHq05L+PX6Mmey0ptvQSRSok3kTr/FC2Y7Vb9dVO4g3SQACNK7DK5VnVWkGbaHtCYFPJyyiIHP4uHIG337rGE4Ie30ilR6AtdJzc6VGnpTduzL0mZd+qc9+k0VAvDzE4tVaqYJr35fEAOl+wKWPpRPG9VX2bkF31ImXFGknpAGmX/DuvrQ5yxoC28NhwlsMmMXZ2waSGIZgAkM96LWBvy4f47TSbX8maO7C936KCczPPmaLGqkpg==
Received: from SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:c2::7) by
 ME4P282MB0935.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:9f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.26; Thu, 13 Jul 2023 13:36:06 +0000
Received: from SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8302:9e75:933d:b45]) by SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8302:9e75:933d:b45%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 13:36:06 +0000
From:   David Xu <xuwd1@hotmail.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuwd1@hotmail.com
Subject: [PATCH] platform/x86: serial-multi-instantiate: Auto detect IRQ resource for CSC3551
Date:   Thu, 13 Jul 2023 21:35:28 +0800
Message-ID: <SY4P282MB18350CD8288687B87FFD2243E037A@SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [0ECX7ySrbZC4lACPEPl/5jGvP22+Zf0V]
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:c2::7)
X-Microsoft-Original-Message-ID: <20230713133528.6017-1-xuwd1@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB1835:EE_|ME4P282MB0935:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c175c4-a2f9-4fba-cdea-08db83a61c2a
X-MS-Exchange-SLBlob-MailProps: 0wLWl8rLpvs46l3gX9vBVjaw7zgiAvRIH1VTORd8VCBR1gHLX7V+zWcUNNbEde0wEuErj9FJTnPThz4rNSVhMOHwd0yOwLN8B/jGZp/oB3qA0CGgtciLDNDxjE1WVIfkrs2Zcx74KMavVZvrhUODuKaQFp80OWZV0TVpT8Ne7SbI7AZwjuvGwnLQenKwYK9Jm9NTuKQyHk5onr8DXncY4cTNyJPxODASbiivLO0sYy1lFQxVjI15tdoQZF9uXAnCW3wBVOL6e31xsnksU/PpSgqP/81dKIFND3gfbnUOk3ePmqiZddQlO9JtbHCi3CFbnVLt3w4xHw3a/4Mg47XDFlqXui2aqZpr3JOWLEsCcRNYQJlFznF3D8aHbYUXiyTSNmeriV4+kWL62gApfGtp2a91dJa8YcArOdHLCgRvDNSkZ1bCsbQNzCWW0TSABcolxdUXO6WLApjb8bs9PMiEaNkmxiQQKQQ3+AuWHDtFHeO+6OXZDAm+egS05e/8EnbSbKrkNN7SuqlC4T4/9yMA/w5o/wdZEj7J/tMRKQr4NB9RPqNs0Sqdi0YZ8iNDvWPzCQ+zdj3QC8Rt41RGzjK1InhxHokbF/rs+yOVdDWOMAZRJhEXfYrR4vgGj8YmatXeac50puqpko4PecYsKYw6gt2MogQjx0pkuMI3D5MfSFTI2YJAm5e6BW3HYQQDmbVYgvKt0jPHfsDKp27CvzOhDAIg3gz1lpEG6Sm4FtNpnP+4Woju0jDOYnumVkv4dpbkSZRTt3apayQ=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phOGmUPF5W41DhpTMidTRmZaP3jhEk4lAkZJG8xOLRl7wDlSkVu8Gu+V1ul5ncKVmv34WSVpocS/+swpBu+l/Gu/VgGOXs8tdCg9/PJTBMIYxwvunRLvXXSHiwUvV5PrwJ8ooh/WJ39ANWsLMYdkEmGPjzJWIN+7nZ9W7/ee37CYzWMtipq/Fj1qMTlXOQtc8rgzewPQkMVMaiKuwFZT3CJtGoPDmMCkYnc+7X90k9n+MMXHdUDD7OtL17zO4v7qK7Q2ZMsYycRWtYdYPGEUBeCySIzazn/aKJQwsNlLZ8oBb50tMgrgcWYEo0zKCgplgxDr2MpMc/DRvhT24qRcxTb6rvxNq54/klRaYjq+QP521H2dbxYpcxVZLKYTgssEREjCJfp6m8cCNRnL+VIU9vsLvQDs7dr1UNIgk8LwGx+dd6Sl9Upo1Ft0fYRL/fCnvT2ztwTLvoIUZeuu5egN7F8kxw078hB/NGk3kQBcZOkGTAbU3vHp344/BNbZxptscnYt+L0NemL7yZDCSRcxoa4nJIWAI/koH7qo0ABKQINzhfGfqHc5b9+eXGirdcdAM/+E9dsxOQFNJ/m5zB7WRYEnfCUzm7LxX7KiDfDWaOGCPzzlEMp6DgXTsVcObsKT
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/PI96fxpFggyMQf/vtpcloupuqrybSXNQ32OHtw/+b4YutwDtKXQqss+Jqm0?=
 =?us-ascii?Q?y9ac2m+8CKDwpkLOJr1qdnukVVWT8MROQUkIMtH7rjFFZtdFP2r52+v7b0F7?=
 =?us-ascii?Q?5iOH8dCyAC+P0QrgDg/5RkxpeyFZWMS7MPgmtHn5dhuBOYdzvZSPb2W7Cziy?=
 =?us-ascii?Q?ITOveHceWy6oo9aLNpuU9KCiCWmcA83AYceV1a0Qtm4izilJjuzW8IZLJ4ux?=
 =?us-ascii?Q?Ak0yvou7dLuCeR6Qq321J3jYXrDCSlJPWWvzipZ4YgdiiJFPNHWgMotWqYLD?=
 =?us-ascii?Q?5avG5kQuaUU7zvLvoRADLtzF8aUUW9EYwoeNulxS6rQUzmIUBt6sCmbXNlUp?=
 =?us-ascii?Q?4jYghuFeoCMeLdjtlW20XqwkAESrEv/C3Z96PKsKZTooJWI8fM0SEly0/ijy?=
 =?us-ascii?Q?02myyJgfCaKfNSFFbyd8GkpBlc9HDbiKgbiSi//y/vsMsRLjEM3T3D7Db+LD?=
 =?us-ascii?Q?52oowJJyf7zj4S4NK/cyxRBYT8smowNddJygO2JQT84TirZ+B3x/ix7F+qXq?=
 =?us-ascii?Q?hEWTBoVblexZxJ6zYxCQhTCLTlu41a8WBztm7J8nmT5WJuuH+IL1xsSOvy47?=
 =?us-ascii?Q?E2L5+qYODc1XDFQ794DhskoyRBFGQnIxYPt4RxxRX3EC/bzByRpd1kifX/Qf?=
 =?us-ascii?Q?SrbYQujxDrB0zlvoyV6yKBkIDCLLS9zNft35I8RZvyJUpJAmjwP7V7MJu0bT?=
 =?us-ascii?Q?/qtoG0DWnLlhBcMjHxwGYm+LigwQP9BspZxkr9aG/ga4uQyqISN7kF5ISCaV?=
 =?us-ascii?Q?Y8Gwm0SvY6xxMsEiA1KCKUECW7/d6/e+S5z+VykIBnBOqYsjNPDM2GgbERt6?=
 =?us-ascii?Q?dNa4zf7R775HBSOoklk2fFmZ1iJUyoS/3xWDJfcipA7BT+lS9/DN9Wn2KLml?=
 =?us-ascii?Q?86xZWeEwqE9drdZWfXn4UwVaYpc+Jv7GDtvdMBI/eSV5mo+8K3Y93a6GzOLv?=
 =?us-ascii?Q?6vY0Xdpj8ugI6PbZFDRwzpw2SPQrO/800xxzLupFcYkx7A8U+nXR6HaXiYbf?=
 =?us-ascii?Q?X+TZeD1q+SkuI5fQA9asxq+dIzxhS2taTFfm5uWDNT5dK8acEI0et0DY2wWw?=
 =?us-ascii?Q?Cp8T20OBxZzrOvxWfJLJ6Eg+WfffVxI/LZdeKEXhK+Ftmzz+v4ALrpHM0D9y?=
 =?us-ascii?Q?DRn9QW+g1RHDhGTdL8At7EP+pMUH1OcTPuIAXRRJTfLy8Z/BaxetCZDhAVU2?=
 =?us-ascii?Q?xk20PvIo1jum3GgQjegSiNikTfg1PBvX6Xa0Cg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c175c4-a2f9-4fba-cdea-08db83a61c2a
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 13:36:06.5433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB0935
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

The current code assumes that the CSC3551(multiple cs35l41) always have
its interrupt pin connected to GPIO thus the IRQ can be acquired with
acpi_dev_gpio_irq_get. However on some newer laptop models this is no
longer the case as they have the CSC3551's interrupt pin connected to
APIC. This causes smi_i2c_probe to fail on these machines.

To support these machines, a new macro IRQ_RESOURCE_AUTO was introduced
for cs35l41 smi_node, and smi_get_irq function was modified so it tries
to get GPIO irq resource first and if failed, tries to get
APIC irq resource for cs35l41.

This patch affects only the cs35l41's probing and brings no negative
influence on machines that indeed have the cs35l41's interrupt pin
connected to GPIO.

Signed-off-by: David Xu <xuwd1@hotmail.com>
---
 .../platform/x86/serial-multi-instantiate.c   | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index f3dcbdd72fec..2c2abf69f049 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -21,6 +21,7 @@
 #define IRQ_RESOURCE_NONE	0
 #define IRQ_RESOURCE_GPIO	1
 #define IRQ_RESOURCE_APIC	2
+#define IRQ_RESOURCE_AUTO   3
 
 enum smi_bus_type {
 	SMI_I2C,
@@ -52,6 +53,18 @@ static int smi_get_irq(struct platform_device *pdev, struct acpi_device *adev,
 	int ret;
 
 	switch (inst->flags & IRQ_RESOURCE_TYPE) {
+	case IRQ_RESOURCE_AUTO:
+		ret = acpi_dev_gpio_irq_get(adev, inst->irq_idx);
+		if (ret > 0) {
+			dev_dbg(&pdev->dev, "Using gpio irq\n");
+			break;
+		}
+		ret = platform_get_irq(pdev, inst->irq_idx);
+		if (ret > 0) {
+			dev_dbg(&pdev->dev, "Using platform irq\n");
+			break;
+		}
+		break;
 	case IRQ_RESOURCE_GPIO:
 		ret = acpi_dev_gpio_irq_get(adev, inst->irq_idx);
 		break;
@@ -307,10 +320,10 @@ static const struct smi_node int3515_data = {
 
 static const struct smi_node cs35l41_hda = {
 	.instances = {
-		{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
-		{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
-		{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
-		{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
+		{ "cs35l41-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "cs35l41-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "cs35l41-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "cs35l41-hda", IRQ_RESOURCE_AUTO, 0 },
 		{}
 	},
 	.bus_type = SMI_AUTO_DETECT,
-- 
2.41.0

