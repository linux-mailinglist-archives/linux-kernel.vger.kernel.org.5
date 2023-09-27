Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038C47B0B31
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjI0RjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjI0RjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:39:04 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01hn2210.outbound.protection.outlook.com [52.100.223.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE3610A;
        Wed, 27 Sep 2023 10:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNppdX/AbenypGYvlz97QBYDuLHAPJTlvNWMqfkumNN0s1VxN3kEYjyOdcez/Oyb/rGI7rYx5PBrTm9UKQl7n4FX7+3rOt4aesY45The46JddYl9YHFnfbYTVQ42w9t7jTht1/SVPu/nNPGK6bcDbdwVYMqv1r5463JDtF2awgC+0HSpAiTw69vsy0Qm0a9v+Wdg1TsO9d49AU2UlqMaes4Kl6EtFOwNO5NR2TRJVa1sUbngDZBtJZ3qL8KnPIyRnSaRORyJp4Olba2BA+yHXSuy2mUUT9Gr4rSzR0+Q2VRBVnBXeVQWfEXRfeCXMYRptJp7ntfXHW1uPoVaFIZCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GTbCPg1a6KW0sKyEcuX1XZKVpW9lN1Uc6yebFbrP/g=;
 b=apCM7vfs+twAko/WT1dgAv6960SSv7YLGXBIjAQqpEqqnIo0+PMTo82aJeyMPyAspnj9nywyLqq95dqOSvADHA4pfqfznT3olOIKakc4d38777JP42OZVpUqXjyurl7j4QGNtvO0BG0XHV61JVIjMCoQDVyajFgItFY+ACECpQBKji3AQgVMCviR6X/xH6dDd+F87AOJiCoBZxjSVk9H1WtfHJjes4tLjcoNrfZqGeSXNc6O12s8WorQFz1VXttT+HKWI3x0Xm5XVcJLIx0O6FTnooP6AZPF5vmzL1qcjQDcb17HjVlFpybt+CtSfw0gOJdUqyDGd+xtYeYIlFKQMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nuvoton.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GTbCPg1a6KW0sKyEcuX1XZKVpW9lN1Uc6yebFbrP/g=;
 b=McjZXOjzyNYUxXPmctJs+9LQ3XoWZQVUdx82n9mcDUslTn7zV1DBfS8gCMwjxwtO2nmOIX7W933QTnqeENIIT+7v/DtXJ8+b3azVVtok6fB8rai+Z6WkGhlJHBu9eWmG1grncpjIyxgiltz5Da1jRZ2flbzIVKZOw7Qh+6p8avM=
Received: from SI1PR02CA0057.apcprd02.prod.outlook.com (2603:1096:4:1f5::10)
 by TY0PR03MB6292.apcprd03.prod.outlook.com (2603:1096:400:144::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 27 Sep
 2023 17:38:59 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:4:1f5:cafe::cb) by SI1PR02CA0057.outlook.office365.com
 (2603:1096:4:1f5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 17:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 17:38:57 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Thu, 28
 Sep 2023 01:38:56 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Thu, 28 Sep
 2023 01:38:56 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 28 Sep 2023 01:38:56 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 4D1ED64742; Wed, 27 Sep 2023 20:38:54 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <linux@roeck-us.net>, <jdelvare@suse.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <avifishman70@gmail.com>,
        <tali.perry1@gmail.com>, <joel@jms.id.au>,
        <andrew@codeconstruct.com.au>, <venture@google.com>,
        <yuenn@google.com>, <benjaminfair@google.com>,
        <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 2/2] hwmon: npcm750-pwm-fan: Add NPCM8xx support
Date:   Wed, 27 Sep 2023 20:38:50 +0300
Message-ID: <20230927173850.103435-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230927173850.103435-1-tmaimon77@gmail.com>
References: <20230927173850.103435-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[175.98.123.7];domain=NTHCCAS04.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|TY0PR03MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 7114734f-ed42-4373-bb75-08dbbf80a0a1
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rzdT+TcYBOhH8/2nzkl9OnjYEwg3Ame4xM/JWJkUjZ1I+hrwzvlTJTRjlaQR?=
 =?us-ascii?Q?KU2GgPhY/G+PyZ/dvfH36B3nDDUaR4Sfq9sIInDDfcHll02JRvsa/CO6dFRi?=
 =?us-ascii?Q?p+Na7s9XtaEAaAz9hjJWBbZ44Rwu76yCP1m2LiWfDJW7QIsZVKvOt+VHT8Ge?=
 =?us-ascii?Q?I2pcq55pN1hpPqfHCVBS5f/uZ0yIEIO7gXGcYAimrQwNg/KiQsliRPopbfmm?=
 =?us-ascii?Q?MnADlVAySMHIRGTjJJwoTdPKVT6qEn44GcG6ShljM4V6+XJ/huEAuNCANNgW?=
 =?us-ascii?Q?n2RazYxVPjV1MdUPfi8xlhIk6nB7p9Pa0yWF7UoYi+IX3uE72k+/l7X/2sRj?=
 =?us-ascii?Q?Z2/1WncXPSusRLvS5n42vnz+f7Aai8I1JW2g2zf8lE07uGWTr8aJtSZVry9Z?=
 =?us-ascii?Q?PxZKOorgoDzoiVt36TodNLtxD+8Vn+vCzfNt5FV7ysomL1B1wa3PXtEPLLU3?=
 =?us-ascii?Q?urYpzlXxFqr5tiZAp2yRvwav2mVKni62keFV6D7+6LzK4D0Bc0ZwFZwcEAmL?=
 =?us-ascii?Q?n/odG3r7LrYOxbt0Ul3tV78kN4uPKgkou6kTU/wtjL+fF6LqA4lNaJzRy9xT?=
 =?us-ascii?Q?6DEc81K9YVVKHHQ5UAmDMJklV8BAYyVLju4pJFXTUwDZIQlEwYZye5tgVzp3?=
 =?us-ascii?Q?qc5x/Z4uZMPIABAPW+hRY1cD3SLxAxc21ky6KmIB/ZTnh52j5tKwzoZujPRM?=
 =?us-ascii?Q?PZ7rLL9tyDhVkDFIu8WQK5d2zl+nEIwjAy+oTMFhboIQtFHfiTHttCKRdKda?=
 =?us-ascii?Q?iCZ/yJrkcZPu1vRpyYHWRIC0u2AticPMVJ5H3+3ZO54W6FFuuhxb9w99QTN3?=
 =?us-ascii?Q?7jXk0KoJRiJYKFsHwuXqOE7n43foV0h/lMEcBJ5i5IkWKmEVFS3cuOO49Lkt?=
 =?us-ascii?Q?MUDKJn5Bq/+MsGo3U4U/P86PA6RGiKGG1I5Jh8o8hysJJSWScRXOuffDGiKU?=
 =?us-ascii?Q?WYDLBduAEL1/79NFzN6ZIoJ48wyVFqUBV274onsXQkbh2fsmq5+2aChToidd?=
 =?us-ascii?Q?oDgDWCn7xMGfLgAvD57ZuMb4Fg=3D=3D?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(84050400002)(230922051799003)(61400799006)(451199024)(82310400011)(5400799018)(48200799006)(186009)(40470700004)(36840700001)(46966006)(921005)(7416002)(8936002)(5660300002)(4326008)(41300700001)(8676002)(2906002)(6266002)(336012)(54906003)(82202003)(110136005)(42186006)(70586007)(42882007)(40460700003)(76482006)(26005)(70206006)(34020700004)(81166007)(316002)(478600001)(83170400001)(6666004)(2616005)(40480700001)(83380400001)(73392003)(82740400003)(47076005)(356005)(36860700001)(55446002)(36756003)(1076003)(45356006)(32563001)(35450700002)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 17:38:57.4105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7114734f-ed42-4373-bb75-08dbbf80a0a1
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6292
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/hwmon/npcm750-pwm-fan.c | 161 +++++++++++++++++++++++++++-----
 1 file changed, 136 insertions(+), 25 deletions(-)

diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index 10ed3f4335d4..324de4482e71 100644
--- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -45,11 +45,6 @@
 #define NPCM7XX_PWM_CTRL_CH2_EN_BIT		BIT(12)
 #define NPCM7XX_PWM_CTRL_CH3_EN_BIT		BIT(16)
 
-/* Define the maximum PWM channel number */
-#define NPCM7XX_PWM_MAX_CHN_NUM			8
-#define NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE	4
-#define NPCM7XX_PWM_MAX_MODULES                 2
-
 /* Define the Counter Register, value = 100 for match 100% */
 #define NPCM7XX_PWM_COUNTER_DEFAULT_NUM		255
 #define NPCM7XX_PWM_CMR_DEFAULT_NUM		255
@@ -138,11 +133,9 @@
 #define NPCM7XX_FAN_TCPCFG_CPASEL	BIT(0)
 
 /* FAN General Definition */
-/* Define the maximum FAN channel number */
-#define NPCM7XX_FAN_MAX_MODULE			8
+/* Define the PWM and FAN in a module */
+#define NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE	4
 #define NPCM7XX_FAN_MAX_CHN_NUM_IN_A_MODULE	2
-#define NPCM7XX_FAN_MAX_CHN_NUM			16
-
 /*
  * Get Fan Tach Timeout (base on clock 214843.75Hz, 1 cnt = 4.654us)
  * Timeout 94ms ~= 0x5000
@@ -171,6 +164,15 @@
 #define FAN_PREPARE_TO_GET_FIRST_CAPTURE	0x01
 #define FAN_ENOUGH_SAMPLE			0x02
 
+struct npcm_hwmon_info {
+	u32 pwm_max_modules;
+	u32 pwm_max_ch;
+	u32 fan_max_modules;
+	u32 fan_max_ch;
+	const struct hwmon_chip_info *hinfo;
+	const char *name;
+};
+
 struct npcm7xx_fan_dev {
 	u8 fan_st_flg;
 	u8 fan_pls_per_rev;
@@ -195,15 +197,16 @@ struct npcm7xx_pwm_fan_data {
 	unsigned long fan_clk_freq;
 	struct clk *pwm_clk;
 	struct clk *fan_clk;
-	struct mutex pwm_lock[NPCM7XX_PWM_MAX_MODULES];
-	spinlock_t fan_lock[NPCM7XX_FAN_MAX_MODULE];
-	int fan_irq[NPCM7XX_FAN_MAX_MODULE];
-	bool pwm_present[NPCM7XX_PWM_MAX_CHN_NUM];
-	bool fan_present[NPCM7XX_FAN_MAX_CHN_NUM];
+	struct mutex *pwm_lock;
+	spinlock_t *fan_lock;
+	int *fan_irq;
+	bool *pwm_present;
+	bool *fan_present;
 	u32 input_clk_freq;
 	struct timer_list fan_timer;
-	struct npcm7xx_fan_dev fan_dev[NPCM7XX_FAN_MAX_CHN_NUM];
-	struct npcm7xx_cooling_device *cdev[NPCM7XX_PWM_MAX_CHN_NUM];
+	struct npcm7xx_fan_dev *fan_dev;
+	struct npcm7xx_cooling_device **cdev;
+	const struct npcm_hwmon_info *info;
 	u8 fan_select;
 };
 
@@ -333,7 +336,7 @@ static void npcm7xx_fan_polling(struct timer_list *t)
 	 * Polling two module per one round,
 	 * FAN01 & FAN89 / FAN23 & FAN1011 / FAN45 & FAN1213 / FAN67 & FAN1415
 	 */
-	for (i = data->fan_select; i < NPCM7XX_FAN_MAX_MODULE;
+	for (i = data->fan_select; i < data->info->fan_max_modules;
 	      i = i + 4) {
 		/* clear the flag and reset the counter (TCNT) */
 		iowrite8(NPCM7XX_FAN_TICLR_CLEAR_ALL,
@@ -659,6 +662,40 @@ static const struct hwmon_channel_info * const npcm7xx_info[] = {
 	NULL
 };
 
+static const struct hwmon_channel_info * const npcm8xx_info[] = {
+	HWMON_CHANNEL_INFO(pwm,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT),
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT),
+	NULL
+};
+
 static const struct hwmon_ops npcm7xx_hwmon_ops = {
 	.is_visible = npcm7xx_is_visible,
 	.read = npcm7xx_read,
@@ -670,6 +707,29 @@ static const struct hwmon_chip_info npcm7xx_chip_info = {
 	.info = npcm7xx_info,
 };
 
+static const struct hwmon_chip_info npcm8xx_chip_info = {
+	.ops = &npcm7xx_hwmon_ops,
+	.info = npcm8xx_info,
+};
+
+static const struct npcm_hwmon_info npxm7xx_hwmon_info = {
+	.pwm_max_modules = 2,
+	.pwm_max_ch = NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE * 2,
+	.fan_max_modules = 8,
+	.fan_max_ch = NPCM7XX_FAN_MAX_CHN_NUM_IN_A_MODULE * 8,
+	.hinfo = &npcm7xx_chip_info,
+	.name = "npcm7xx_pwm_fan",
+};
+
+static const struct npcm_hwmon_info npxm8xx_hwmon_info = {
+	.pwm_max_modules = 3,
+	.pwm_max_ch = NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE * 3,
+	.fan_max_modules = 8,
+	.fan_max_ch = NPCM7XX_FAN_MAX_CHN_NUM_IN_A_MODULE * 8,
+	.hinfo = &npcm8xx_chip_info,
+	.name = "npcm8xx_pwm_fan",
+};
+
 static u32 npcm7xx_pwm_init(struct npcm7xx_pwm_fan_data *data)
 {
 	int m, ch;
@@ -693,7 +753,7 @@ static u32 npcm7xx_pwm_init(struct npcm7xx_pwm_fan_data *data)
 	/* Setting PWM Prescale Register value register to both modules */
 	prescale_val |= (prescale_val << NPCM7XX_PWM_PRESCALE_SHIFT_CH01);
 
-	for (m = 0; m < NPCM7XX_PWM_MAX_MODULES  ; m++) {
+	for (m = 0; m < data->info->pwm_max_modules  ; m++) {
 		iowrite32(prescale_val, NPCM7XX_PWM_REG_PR(data->pwm_base, m));
 		iowrite32(NPCM7XX_PWM_PRESCALE2_DEFAULT,
 			  NPCM7XX_PWM_REG_CSR(data->pwm_base, m));
@@ -716,7 +776,7 @@ static void npcm7xx_fan_init(struct npcm7xx_pwm_fan_data *data)
 	int i;
 	u32 apb_clk_freq;
 
-	for (md = 0; md < NPCM7XX_FAN_MAX_MODULE; md++) {
+	for (md = 0; md < data->info->fan_max_modules; md++) {
 		/* stop FAN0~7 clock */
 		iowrite8(NPCM7XX_FAN_TCKC_CLKX_NONE,
 			 NPCM7XX_FAN_REG_TCKC(data->fan_base, md));
@@ -905,6 +965,49 @@ static int npcm7xx_en_pwm_fan(struct device *dev,
 	return 0;
 }
 
+static int npcm_pwm_fan_alloc_data(struct device *dev,
+				   struct npcm7xx_pwm_fan_data *data)
+{
+	data->pwm_lock = devm_kcalloc(dev, data->info->pwm_max_modules,
+				      sizeof(*data->pwm_lock), GFP_KERNEL);
+	if (!data->pwm_lock)
+		return -ENOMEM;
+
+	data->fan_lock = devm_kcalloc(dev, data->info->fan_max_modules,
+				      sizeof(*data->fan_lock), GFP_KERNEL);
+	if (!data->fan_lock)
+		return -ENOMEM;
+
+	data->fan_irq = devm_kcalloc(dev, data->info->fan_max_modules,
+				     sizeof(*data->fan_irq), GFP_KERNEL);
+	if (!data->fan_irq)
+		return -ENOMEM;
+
+	data->pwm_present = devm_kcalloc(dev, data->info->pwm_max_ch,
+					 sizeof(*data->pwm_present),
+					 GFP_KERNEL);
+	if (!data->pwm_present)
+		return -ENOMEM;
+
+	data->fan_present = devm_kcalloc(dev, data->info->fan_max_ch,
+					 sizeof(*data->fan_present),
+					 GFP_KERNEL);
+	if (!data->fan_present)
+		return -ENOMEM;
+
+	data->fan_dev = devm_kcalloc(dev, data->info->fan_max_ch,
+				     sizeof(*data->fan_dev), GFP_KERNEL);
+	if (!data->fan_dev)
+		return -ENOMEM;
+
+	data->cdev = devm_kcalloc(dev, data->info->pwm_max_ch,
+				  sizeof(*data->cdev), GFP_KERNEL);
+	if (!data->cdev)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -923,6 +1026,13 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	data->info = device_get_match_data(dev);
+	if (!data->info)
+		return -EINVAL;
+
+	if (npcm_pwm_fan_alloc_data(dev, data))
+		return -ENOMEM;
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm");
 	if (!res) {
 		dev_err(dev, "pwm resource not found\n");
@@ -960,10 +1070,10 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
 	output_freq = npcm7xx_pwm_init(data);
 	npcm7xx_fan_init(data);
 
-	for (cnt = 0; cnt < NPCM7XX_PWM_MAX_MODULES  ; cnt++)
+	for (cnt = 0; cnt < data->info->pwm_max_modules  ; cnt++)
 		mutex_init(&data->pwm_lock[cnt]);
 
-	for (i = 0; i < NPCM7XX_FAN_MAX_MODULE; i++) {
+	for (i = 0; i < data->info->fan_max_modules; i++) {
 		spin_lock_init(&data->fan_lock[i]);
 
 		data->fan_irq[i] = platform_get_irq(pdev, i);
@@ -988,15 +1098,15 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
 		}
 	}
 
-	hwmon = devm_hwmon_device_register_with_info(dev, "npcm7xx_pwm_fan",
-						     data, &npcm7xx_chip_info,
+	hwmon = devm_hwmon_device_register_with_info(dev, data->info->name,
+						     data, data->info->hinfo,
 						     NULL);
 	if (IS_ERR(hwmon)) {
 		dev_err(dev, "unable to register hwmon device\n");
 		return PTR_ERR(hwmon);
 	}
 
-	for (i = 0; i < NPCM7XX_FAN_MAX_CHN_NUM; i++) {
+	for (i = 0; i < data->info->fan_max_ch; i++) {
 		if (data->fan_present[i]) {
 			/* fan timer initialization */
 			data->fan_timer.expires = jiffies +
@@ -1015,7 +1125,8 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
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

