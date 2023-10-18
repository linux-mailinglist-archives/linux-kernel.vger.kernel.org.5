Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8867CE62F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjJRSTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjJRSTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:19:38 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2084.outbound.protection.outlook.com [40.107.215.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7994710F;
        Wed, 18 Oct 2023 11:19:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELH0ckixq+UEbimdYMlearFefulH3hf/iOxgewC7kCPx0JoLXu4msKF2sod5LbbCiPGikCHBUj3WxbygusZ7+ZwCH08BrxLY/An87lAEjySiZUghGC473diSkj4Zt3V3ktTyMxIMQDJJQXrH76mKKdiTuLU+b8ioxAet00vTbvta3VCvBr0XLYIxSy4WgocirP8nLd5S2neDXtxG8QwhIEEDEL/2xO9Sev4RiyEcTcE4JAdCu6HRoukZmRCwuzFVKZ7GF8XWPSWinLRTkPcvIy/urqKss7buV4J7da8Ck5PZAgK8/qdS1b/+5qLUw6fsK4YUWSsEO2D4y+HBII3xEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GTbCPg1a6KW0sKyEcuX1XZKVpW9lN1Uc6yebFbrP/g=;
 b=EHTKA1u5ZldPZnJG7mhVOJpH8t1NX81KOArnMAThD65zW7w/5hnnG11qMi1tTdkZTWcRg8Uupmdm0HUwgKivq78Khq7fAd3K7b5/03fS8auhje4rIwuLkgiDw1dwxvChIZW8YLFOAbkJPq/NNvNNR5aNiqQe0iuFdlIwLaTeJ1t36lNGqyoGP+QsLoyvEVXU3J7DpjyixTRL0qfDRb75Yzq6ZJ6GUHOIqeivai/HADctfDDWIoRrOWMqP4ggilaSuhW2W7O4g2Z9Swz+G/ukne6ku9onRGOyBKlEWgTq03BhzfojudCR2XN1taAXCAmGHNSQiJ9VUgVnxst1ZhuEsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nuvoton.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GTbCPg1a6KW0sKyEcuX1XZKVpW9lN1Uc6yebFbrP/g=;
 b=O4gCA5chvAKpER0t0ugPnLzRq+cs7mYwRzszvEPH00x7+J0Xf19I/dxYdqYcQvxi642Nhzgec2r0JxMWmaqQYEUrWJOW1xQZ/8EM4YXC8fdjWfEuvzfhowLqg18eoGvb8EgUQwaJEu8YwMfOWeo4P8bZ/N/G9I9gU87/T3wyi5Y=
Received: from SI1PR02CA0058.apcprd02.prod.outlook.com (2603:1096:4:1f5::9) by
 SEZPR03MB6812.apcprd03.prod.outlook.com (2603:1096:101:67::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.24; Wed, 18 Oct 2023 18:19:30 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:1f5:cafe::45) by SI1PR02CA0058.outlook.office365.com
 (2603:1096:4:1f5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 18:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 18:19:30 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Thu, 19
 Oct 2023 02:19:29 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 19 Oct 2023 02:19:29 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id 2B5B768E7C;
        Wed, 18 Oct 2023 21:19:28 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 22D4221CFCF4; Wed, 18 Oct 2023 21:19:28 +0300 (IDT)
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
Subject: [PATCH v2 2/2] hwmon: npcm750-pwm-fan: Add NPCM8xx support
Date:   Wed, 18 Oct 2023 21:19:25 +0300
Message-ID: <20231018181925.1826042-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231018181925.1826042-1-tmaimon77@gmail.com>
References: <20231018181925.1826042-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|SEZPR03MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5f5903-d66d-4da1-3d14-08dbd006c56b
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mljt7T7HJBzO2TTItfooDgYb/GuNuG7m3goRugzBENr7dwvHg4lRkW7I194DG4llb2kB7CPejGBK8vwM4srdiDZoQ/+o5NCUUdgMpPUAlnNDDNA4a5Q+YF+0d8j8AGz1XEtDVH5shc6iRHFzVeuG4a6kbHvM8R31l2nt4U4FuaRa+dGRZP7eN9RR6DboGTbEPoYeXKgjgPPkTpn1YLQGMpxi0SaSEn5jULIbETJCuF3OcPIpaXS3H4jMhBjb7azH5FcnsQd5TXuaT7XxKZSa4v3XZcqI0xXnEFWnY+6kX0nyZ3yEzYwec/j9/sz2yVPqe7FlEetkNI7F7yMARSFT6IMNaQbns6ZRdR7R0s7ss3l1H+mDx9Kp0j3sVtMZK3Vyn/8E+kNbvJSjSuuLE/GbqudgafQrMHMAnl0JCkCDekHyhWZ1QqN0QBmya9eQ5+hg4V1eOo2UBWtYzMpWwwL1PSYz33Wq0oCJMmNBSSwQg5rETQttyX3dq4KiCejFgsq3hmANvD9hvCc8y4McKd7dGrqckqj/l8vAr1BZeyOft76soPL2U2K+1jk+P0qyq7aR/b3Q4eyKTm107GihLbr+A3QnRobycV3jbfSdAyvAQtO05lyUPxAhBUEVfwZL3/avCWWd18LA31VuCNG5GXiAfsEXw1SfQNSPc1yT/Upfy3l6QFKUweMNtsm2b72cwf3LCkus83pD93x7Ft49fif3miMe6JOJylDgd+DqWTIZ0gRB8sbqxvehvMTv/Phrx7xQoYUhEgNKGQSrdjWDXfi3Kkn7XKNSTKqcW2dR/LLSyCTweIjwidZAdt1N4V2OOLleAHziJiC6Fjvty95Pvcuc6WWfqJm6IzdMRK1w7/+bigo85MFnuz19HGNu83L7OFSLk/nLUpBTs8NH+7hljv3QGz7iK4UjdGAropxYKwI2LPE=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(84050400002)(230922051799003)(82310400011)(186009)(451199024)(48200799006)(64100799003)(61400799006)(36840700001)(40470700004)(46966006)(40480700001)(36756003)(40460700003)(110136005)(316002)(42186006)(54906003)(70206006)(70586007)(55446002)(83170400001)(82740400003)(356005)(921005)(81166007)(83380400001)(36860700001)(6266002)(42882007)(26005)(73392003)(1076003)(2616005)(82202003)(6666004)(336012)(2906002)(8936002)(76482006)(478600001)(41300700001)(7416002)(47076005)(5660300002)(4326008)(8676002)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 18:19:30.2484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5f5903-d66d-4da1-3d14-08dbd006c56b
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6812
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

