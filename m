Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E627DBC41
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjJ3PBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjJ3PBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:01:53 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01hn2210.outbound.protection.outlook.com [52.100.223.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C286F9;
        Mon, 30 Oct 2023 08:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFFI43Z4Yfd7FNq7v2zIFfAh+PiT+Yebd7aH6eYLM16+J5UtH/iVQTJQ3fV4gSvybzq5TMbF3kMYD82vFAI+rHKWd9YP90VcPG6k51eEypxQgo1w2wY6NJjRO3RohoEeExCFwPL6r9uh0n3+oi5TnY6TMnX7lB3ROoJoSQkzzlRLkj6rMm35ntpvJZ0gRvDLGVow336Xo6k/hHNDmr8OlaNtOoQSh98KyFw5Sop+MgAWbxUjFLsVw4ocGNdgR//i6xpxQC34D0zDUHZLjCthAAj6cZFHfH3HBtWjl5CaRRZetOoIFKBqfBTvBK4+nn0/TtQDkG0QWgthNeJla08JUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DcOkzYAnP/pAIeqFzW4V9WEm2jSJlKpL3YPuOuMM+g=;
 b=d4IJNqCTuc6kHwX5ohY9eMY8qFpCYpXH9QWpK2jL8qUgaH/leX+Wde0ZfBTgTHShBA/R2QG5DwjADqmjSTcHhteVtgrI6/yQwu9akw4Lpaxxh0aL416XA97DUCjLz0nKtOaViR1mj1mddbr9Mk6dD1Q0SWvL33QSHJaXfdgUuhUOexsu4tV3pzzOGA/2+4jEYQCmZohvEB1sallyC9uCImPRlTgzDBZ+qf3boiugSVGTCdXEghej6Au0PRhiErkSrYf8Ic0aE/5wJHpANSXQOry34T+HsHmvTV8wKh04OPvj2kZCyZr6n6WhkQv0/Zda8ttl6Hu2dbiyS6EA+AWINg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nuvoton.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DcOkzYAnP/pAIeqFzW4V9WEm2jSJlKpL3YPuOuMM+g=;
 b=jj08UbWFeN2iPTpVkeHVZLLam36ev2bDqgUXwTvSR3Re/PeHXLQ48GHmw6debJPEUWcTikwPTcFet5cAEm/X4TSRWvpeT1tCC9bpljQS3QSknJWuvejOVOh4rPDVEKgE6ZutJIp6K3DLpE90JMwWanAS6NL7MLE8H2lF4uSoDp0=
Received: from PS2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::18) by KL1PR03MB5917.apcprd03.prod.outlook.com
 (2603:1096:820:82::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.25; Mon, 30 Oct
 2023 15:01:45 +0000
Received: from HK2PEPF00006FB5.apcprd02.prod.outlook.com
 (2603:1096:300:58:cafe::6e) by PS2PR01CA0030.outlook.office365.com
 (2603:1096:300:58::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27 via Frontend
 Transport; Mon, 30 Oct 2023 15:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FB5.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 30 Oct 2023 15:01:44 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Oct
 2023 23:01:23 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 30 Oct
 2023 23:01:22 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 30 Oct 2023 23:01:22 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id 975BA5F5D4;
        Mon, 30 Oct 2023 17:01:21 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 90B9A235CE0F; Mon, 30 Oct 2023 17:01:21 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <linux@roeck-us.net>, <jdelvare@suse.com>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
        <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v3 1/1] hwmon: npcm750-pwm-fan: Add NPCM8xx support
Date:   Mon, 30 Oct 2023 17:01:19 +0200
Message-ID: <20231030150119.342791-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231030150119.342791-1-tmaimon77@gmail.com>
References: <20231030150119.342791-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[211.75.126.7];domain=NTHCCAS01.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB5:EE_|KL1PR03MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a7ac6b-15c7-4b4f-8532-08dbd95921ae
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wolQr3X3s1jLBydIADsnO0CNx7bBaUQNM6DHhOJTot3TwwUopfxTefSIhUBF?=
 =?us-ascii?Q?gH+f9uJI9sErdod5rvKUxL/yB/PxwJc89dTnDeBy/X733xGtqDQeFbTl2DOu?=
 =?us-ascii?Q?aBkU7B6V2y46HsjAAbc2DEgCZB3WS7H7O34A5z2tVt+/rsb1Vppu+oUlAEmy?=
 =?us-ascii?Q?tVy3rmG074az04kPr61MV7VOEDEjMrMfNlsI5UEmSyIBfOuruwKdx4Ljvnqy?=
 =?us-ascii?Q?EgjwqD4VqVMWcf+Cd1i0yxeAEPEeR1ruTWJA7xB6hlO6FATP4QlVM3u2+W31?=
 =?us-ascii?Q?Z91djMGCrtorRFDiQSW9u8yPgUnTBNoy37/VMxIrvOf7U2C6XEurZffGiuRB?=
 =?us-ascii?Q?f8w1grV/pNVVpx5smH5+nLJ4WHBAzZGwrX9pz3CpKizzzRjFBpR+WpHX/NIZ?=
 =?us-ascii?Q?K3eNEI99+H7AGxb5RTTgPDoQ1vlDHm9sf8JTyqKRvfgpPV882dpudykOG3Pl?=
 =?us-ascii?Q?XP9KeZJ4ujkAO+7c22s3Rq7IWc4+dtbteK9rtRqKuLnQy7Tt8YCFCkDYa2lZ?=
 =?us-ascii?Q?aN/Be0f051gGeXtn2pQUQjOHMtnUagLBGiJH5sqZj1D5+GpR6JKcQtzbRgdc?=
 =?us-ascii?Q?Hm/A+xaQierCPF8+cAGikhilYKfTCDK10066WkW8qNiHQvEN6KVWCZiQHcT5?=
 =?us-ascii?Q?V5rFQ3NzDUeOOxSgpKP0nmureMwS8Up1N+0nIoFXdmGQSbp4PSzmB9p51atn?=
 =?us-ascii?Q?FW5yCyi/EYGW+ksi+Q/OMF3FfrW3yCWnTW53jjdwJaRybgdfoUj8DVOYvQeV?=
 =?us-ascii?Q?PzdfOnD3jTFinfyH+rAB2wVbt+L3ZpbZqGh6sIy7ZUd7GOw2eu07E2gjL62E?=
 =?us-ascii?Q?XzlfdgkIkrsUWdroG/JCZFCsfjoU59E8s+0I9NU5Q31UJeHNNhiHp0j5W7Bv?=
 =?us-ascii?Q?0CLOfOGuVfA5YB93fY2u5QBfuENV7zmvoaqYq4PhF9ErtrPcQra1r+DIDJvi?=
 =?us-ascii?Q?gpnVQnmDu8RmqKFHSAM5vyravIGT99Xrsz4+ydC9qqrZIFvKmNdCkxzWMYPQ?=
 =?us-ascii?Q?xn0PZ13Ybwu8sGm+WF43ZINc4w=3D=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(84050400002)(230922051799003)(61400799006)(48200799006)(82310400011)(186009)(64100799003)(5400799018)(451199024)(40470700004)(46966006)(36840700001)(2906002)(40480700001)(40460700003)(316002)(36860700001)(76482006)(34020700004)(42186006)(81166007)(54906003)(47076005)(82740400003)(356005)(110136005)(26005)(478600001)(83170400001)(83380400001)(73392003)(6266002)(42882007)(70206006)(5660300002)(70586007)(2616005)(336012)(1076003)(82202003)(41300700001)(7416002)(4326008)(921008)(55446002)(8936002)(36756003)(8676002)(45356006)(32563001)(35450700002)(84790400001)(12100799048);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 15:01:44.2990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a7ac6b-15c7-4b4f-8532-08dbd95921ae
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5917
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Pulse Width Modulation (PWM) and fan tacho NPCM8xx support to
NPCM PWM and fan tacho driver.
NPCM8xx uses a different number of PWM devices.

As part of adding NPCM8XX support:
- Add NPCM8xx specific compatible string.
- Add data to handle architecture-specific PWM and fan tacho parameters.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/hwmon/npcm750-pwm-fan.c | 34 +++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index 10ed3f4335d4..765b08fa0396 100644
--- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -46,9 +46,9 @@
 #define NPCM7XX_PWM_CTRL_CH3_EN_BIT		BIT(16)
 
 /* Define the maximum PWM channel number */
-#define NPCM7XX_PWM_MAX_CHN_NUM			8
+#define NPCM7XX_PWM_MAX_CHN_NUM			12
 #define NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE	4
-#define NPCM7XX_PWM_MAX_MODULES                 2
+#define NPCM7XX_PWM_MAX_MODULES                 3
 
 /* Define the Counter Register, value = 100 for match 100% */
 #define NPCM7XX_PWM_COUNTER_DEFAULT_NUM		255
@@ -171,6 +171,10 @@
 #define FAN_PREPARE_TO_GET_FIRST_CAPTURE	0x01
 #define FAN_ENOUGH_SAMPLE			0x02
 
+struct npcm_hwmon_info {
+	u32 pwm_max_channel;
+};
+
 struct npcm7xx_fan_dev {
 	u8 fan_st_flg;
 	u8 fan_pls_per_rev;
@@ -204,6 +208,7 @@ struct npcm7xx_pwm_fan_data {
 	struct timer_list fan_timer;
 	struct npcm7xx_fan_dev fan_dev[NPCM7XX_FAN_MAX_CHN_NUM];
 	struct npcm7xx_cooling_device *cdev[NPCM7XX_PWM_MAX_CHN_NUM];
+	const struct npcm_hwmon_info *info;
 	u8 fan_select;
 };
 
@@ -619,9 +624,13 @@ static umode_t npcm7xx_is_visible(const void *data,
 				  enum hwmon_sensor_types type,
 				  u32 attr, int channel)
 {
+	const struct npcm7xx_pwm_fan_data *hwmon_data = data;
+
 	switch (type) {
 	case hwmon_pwm:
-		return npcm7xx_pwm_is_visible(data, attr, channel);
+		if (channel < hwmon_data->info->pwm_max_channel)
+			return npcm7xx_pwm_is_visible(data, attr, channel);
+		return 0;
 	case hwmon_fan:
 		return npcm7xx_fan_is_visible(data, attr, channel);
 	default:
@@ -638,6 +647,10 @@ static const struct hwmon_channel_info * const npcm7xx_info[] = {
 			   HWMON_PWM_INPUT,
 			   HWMON_PWM_INPUT,
 			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
 			   HWMON_PWM_INPUT),
 	HWMON_CHANNEL_INFO(fan,
 			   HWMON_F_INPUT,
@@ -670,6 +683,14 @@ static const struct hwmon_chip_info npcm7xx_chip_info = {
 	.info = npcm7xx_info,
 };
 
+static const struct npcm_hwmon_info npxm7xx_hwmon_info = {
+	.pwm_max_channel = 8,
+};
+
+static const struct npcm_hwmon_info npxm8xx_hwmon_info = {
+	.pwm_max_channel = 12,
+};
+
 static u32 npcm7xx_pwm_init(struct npcm7xx_pwm_fan_data *data)
 {
 	int m, ch;
@@ -923,6 +944,10 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	data->info = device_get_match_data(dev);
+	if (!data->info)
+		return -EINVAL;
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm");
 	if (!res) {
 		dev_err(dev, "pwm resource not found\n");
@@ -1015,7 +1040,8 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id of_pwm_fan_match_table[] = {
-	{ .compatible = "nuvoton,npcm750-pwm-fan", },
+	{ .compatible = "nuvoton,npcm750-pwm-fan", .data = &npxm7xx_hwmon_info},
+	{ .compatible = "nuvoton,npcm845-pwm-fan", .data = &npxm8xx_hwmon_info},
 	{},
 };
 MODULE_DEVICE_TABLE(of, of_pwm_fan_match_table);
-- 
2.33.0

