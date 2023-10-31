Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A965A7DC7C6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjJaH6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjJaH6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:58:21 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01hn2242.outbound.protection.outlook.com [52.100.223.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97A9102;
        Tue, 31 Oct 2023 00:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJo0nD1V/U1HIJnRyqT2VEgIeZtWtn6p0b2J5rofS6a0zrgRwhR2Ze/0E9B8RjvheP+Yuz6nxAZwD+0WJ4M76VAs8nIAfMv873krc8QQ9Ugr6MdBINhYXkN8Ua47aY3/hBvrvHDGM6jgrrqQrlWHxshnCdhvuOR5iqM3gqH6z2K7tuWY3jMOjaGiVgmGVDNcoPKxHY2CoduRplzOIFl8trQxxC31PAzubJl2kgySjegcAvCmnmTx2eVjg0lBd1+6QYXacvLO3iV+LqA9hJ4AbL1Mpuwgi5pO+W71ids8uLiplPhhcCXY33IIZU24zXe2nmbtCDCdJSKU+z/NSrrPBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97ZjtvTUd7vys+mjvLFEZUqcZXuY977xL1Zij6OQjh4=;
 b=UsaEqEn4D9BiOv2U/I9VScH9+SRDhx6GKz0UGb2zkSydh4IpCwqjnfSaE98YqvfKCQqoWkpd5PNcf9ccZsdKQlt8dYHBx2rPq7K4U3Pxo1zXjLJBZTIyBXUlQKzwvs+756O7EybSzedEY55sKuaMY+NNv0oG4FhKQ33etHez5iftFZCk9K4+hQ3G0YiOOp00MoZRBn3IKBX+GUAyQ58CwoDP1Vo2tkSvl4PDsSoZQtU9Ff9Atq1hbcD3VOkgQsfx0287HzTHz16s87vT/k9Pn5s7Lg25loFtpOvQjTaqfORtB4UqQjTPErcBIydEZ8xtAtgS/t1PSxPXYwJl0rQA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nuvoton.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97ZjtvTUd7vys+mjvLFEZUqcZXuY977xL1Zij6OQjh4=;
 b=qY2r9Cg/XuDQEAXLOVRGHgfG3FwuwSVv5qlXw8OXYVL8/8RdqqJruM5tHqcdwxhqkHfdFd5UiSsevvNB+KI7/bwEDQhs019uJld+2q99C2UkQ28SO29W8kPHFdBNKrr3VY8x8HYB5wmre2IdGVG1MDFE09Rwq7/1EhcE5cgq3rA=
Received: from SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8) by
 PUZPR03MB6214.apcprd03.prod.outlook.com (2603:1096:301:ba::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.23; Tue, 31 Oct 2023 07:58:12 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:c7:cafe::3b) by SG2P153CA0021.outlook.office365.com
 (2603:1096:4:c7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.2 via Frontend
 Transport; Tue, 31 Oct 2023 07:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 31 Oct 2023 07:58:12 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 31
 Oct 2023 15:58:11 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 31 Oct 2023 15:58:10 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id 375405F5BB;
        Tue, 31 Oct 2023 09:58:10 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 2F083235CE0F; Tue, 31 Oct 2023 09:58:10 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <linux@roeck-us.net>, <jdelvare@suse.com>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
        <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v4 1/1] hwmon: npcm750-pwm-fan: Add NPCM8xx support
Date:   Tue, 31 Oct 2023 09:58:06 +0200
Message-ID: <20231031075806.400872-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231031075806.400872-1-tmaimon77@gmail.com>
References: <20231031075806.400872-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|PUZPR03MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8db875-9ad7-430b-08b2-08dbd9e72169
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FwCbfl5m3t9ZxWCZ7laSW8thEFgFSyRLPi5Gdw1f24mtgEZfuV3pk8deOfLc?=
 =?us-ascii?Q?J0hJH0XY31jh4b+IvRSOdHGmFVTV97aHxKMRSF4RlqkupH7xS29SZ0Nzp6yV?=
 =?us-ascii?Q?qJvzPpyh2T2a5M3vn6pCBcCTHpL34V/SohI2mnY+SHt1AtMpiVAxOYVQQXJ+?=
 =?us-ascii?Q?isL3SXmQNiD6TU6UDxjob+JgAKPcrvOfxJ0lDcIe9hpbPrI5pEfDscp0lSWE?=
 =?us-ascii?Q?Rk0vdswLF0klb3GdTHIufBLQIhkjV/Vtwu+XfpLOqiGJnaJk891EP2Hv7lLJ?=
 =?us-ascii?Q?FudAg3hoVSZ3K+sUoYt0aCfO/DLzUMKQlDt5T30cP1VsBlQ7Pz9g1u72x0IO?=
 =?us-ascii?Q?TB92aExlzrST6nGkuhUZeUKsWRdU7xTtF7vEPSSfh8I1TpJ0cOexHS71PUG/?=
 =?us-ascii?Q?K2RRyI+VmCOOZq051pVSDsU4qRiXHJZ24bmrLinF9kBl+FJkk9NxO/ZQpuM7?=
 =?us-ascii?Q?t0l0ysYFCzLkRhMbxtQo76/xqEvCecF/zrKcJbeY6E21PQKwP/TE3k4QMWIW?=
 =?us-ascii?Q?bowerPnILT3GCGSAFyAl3dQtEndl/JylJEWiBBQlGCf91cTjHZOs7OYRsxKt?=
 =?us-ascii?Q?s1RzUXS1mlEWi0uoaSbgLUptrI/pFyVNB7fIVUvDupKtge6XvLi7mEN6r711?=
 =?us-ascii?Q?1ta2xphqyAtMWXHwhqw7wReBET4KCLvMsDt0xtqS0GXHNYEW1GzbZ2ejWbIR?=
 =?us-ascii?Q?9IpiV2Wl8wKIdVSo5IH+fHMrH1QThKRxIDdOPogfu94DucdGD+ggJ5cdPU9z?=
 =?us-ascii?Q?UboGKYxlD1izCnIO6l1Bu6rHKVWymmKh/UBf11/aPQZmwG4EGJ07AkvmsFvS?=
 =?us-ascii?Q?YzjnRRaxEsjJCTzY6r2inL+DRBgxHGY+gqGQkA/jNEXahQ3LRDjLgut6gGCU?=
 =?us-ascii?Q?TQuGx/4H3XgR4wOIvrELsHlKGuOsB1rTHZ6S7r8cfA3U5raz+krJh/By+elw?=
 =?us-ascii?Q?L/+9eZMXf92CziKvN9K++jvj6Mkh3iZFEHNYUnFH2Ogkddtcb5FqMZCgKrU9?=
 =?us-ascii?Q?uMOct48tJbapd76ZPn59LywBHQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(84050400002)(230922051799003)(82310400011)(186009)(5400799018)(61400799006)(451199024)(48200799006)(64100799003)(36840700001)(46966006)(40470700004)(40480700001)(6666004)(42186006)(70206006)(110136005)(316002)(54906003)(81166007)(83170400001)(70586007)(356005)(76482006)(82740400003)(40460700003)(4326008)(7416002)(8936002)(8676002)(921008)(47076005)(26005)(5660300002)(55446002)(2906002)(73392003)(34020700004)(478600001)(336012)(6266002)(36756003)(83380400001)(42882007)(2616005)(1076003)(36860700001)(82202003)(41300700001)(45356006)(32563001)(35450700002)(84790400001)(12100799048);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 07:58:12.3792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8db875-9ad7-430b-08b2-08dbd9e72169
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6214
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
- Add data to handle architecture-specific PWM parameters.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/hwmon/npcm750-pwm-fan.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index 10ed3f4335d4..d99b24c23d25 100644
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
 
@@ -542,7 +547,7 @@ static umode_t npcm7xx_pwm_is_visible(const void *_data, u32 attr, int channel)
 {
 	const struct npcm7xx_pwm_fan_data *data = _data;
 
-	if (!data->pwm_present[channel])
+	if (!data->pwm_present[channel] || channel >= data->info->pwm_max_channel)
 		return 0;
 
 	switch (attr) {
@@ -638,6 +643,10 @@ static const struct hwmon_channel_info * const npcm7xx_info[] = {
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
@@ -670,6 +679,14 @@ static const struct hwmon_chip_info npcm7xx_chip_info = {
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
@@ -923,6 +940,10 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	data->info = device_get_match_data(dev);
+	if (!data->info)
+		return -EINVAL;
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm");
 	if (!res) {
 		dev_err(dev, "pwm resource not found\n");
@@ -1015,7 +1036,8 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
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

