Return-Path: <linux-kernel+bounces-38046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DB983BA34
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA2C1F239F3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA1410A29;
	Thu, 25 Jan 2024 06:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PRu1+rnH"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D574610A05;
	Thu, 25 Jan 2024 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164815; cv=fail; b=RGL1Tt42SYg54QKJJheGQhLh9ewCDx5rnu+wXIsZR5w5EtUDimvCC07Aj6m2kkdLw3lcRrGDk60uPu+v4+KfoJ+dOUT+nKnY4phUCmUYbcMxmNR0Gb2dSExGRcHih43/SdSoCvp5ac0udtQuhX1k8u6yZcawESJAlCzoJgekYkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164815; c=relaxed/simple;
	bh=STe1zyKkOhWtMBk412IJ7sbcdLzlILOZ32EnJSoJl7A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WryKfa+1fDnTO8aLt/uFnYTGAzrrX4lNtngrw8DEyaOReYtLf3KFI6VqxNfGtkr9wZZp+JDuqEcCLlMPl8/VKD2EkNk5S12ibBLsVydyuJt67/KqiMWTVfU/ZcPdcZv0Rx07v17tTFXjngCvvVk3SkXcwUKP3+lq1cXD8DlDw6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PRu1+rnH; arc=fail smtp.client-ip=40.107.20.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgx5kRBRHbsCgEy7AwXA5fjCNZ2KYgMWpMxU7Ge9cdHxXlP3r2GE08dsaypav4oERJpnVPrlU8Kt81Z7y4QX6S9bXLOJXnF66GY7UKOCI0MTvjTCYE3kscHWLgiVyw4FRACQMBcELqInBw1Dx/a6T48A64N7QZ1YPzwNwdeORCUP3FwgriwVrM8MPGH1bCPBZP43Mc6Sdf84aGwqMUXjaajH3v/F30Xvy22VVJoz+EILHibEvc6ygkx0VJEBMUQHPGifZha2rKWQljLOsLnpIyirYBcRJewCGe3NKleJuv20bmXugHEPcPIyQhqEIzgSmRtek+W8ddHPdaQSgeoxHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00OaK2bq1ZMI6b68LEWaHw2m1PvE4QbmJ8057FbOGNs=;
 b=Cu71lavENhhVHQgFU4Etu2WUT7egRj191uznuVJy18Abo36xzMJqn3evr++OhiBewg8ShDcN3OiQTevMaMdRspag78n5zci8BTf0sBGRqQxiSOnwt0CY0RaWKCI18hFdqAAJtZvSPo2imMZjAqYScsay/5qPx+x5NmAH3Roo5pyNgG4MoDOYRfcCQpL5prbIDgl/MrDUFpSOayZsZMz+arMxFbEbqGCcuX/gPMxNrLeIQS2ZI3u/aVh+2A+ta+QBFc0Q/Z66kcZwuYqzlRUg9T9eY3pljCiC55naAhzluivDyBWMHPGM5dDEs3JT6mAqkeuq7Dp2aY1zTJ1pb7QLEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00OaK2bq1ZMI6b68LEWaHw2m1PvE4QbmJ8057FbOGNs=;
 b=PRu1+rnHu+sJNCTJqZDMMP6ydMM2qqivGDWVwoLMu3EyXExLbQ3XR1DISFEKy7bolEpjz0xV82HBVbI1Xl17kkaHYS4F/Q5BBC8cgb2//lAVIezm5p//5XIIMOX35Ny/DqPgPmrMdypuh1SEAq9p7J3vkc0NpitR8Xc/H5sANkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6783.eurprd04.prod.outlook.com (2603:10a6:803:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 06:40:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 06:40:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: groeck7@gmail.com,
	sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	jdelvare@suse.com,
	linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3] hwmon: scmi-hwmon: implement change_mode for thermal zones
Date: Thu, 25 Jan 2024 14:44:22 +0800
Message-Id: <20240125064422.347002-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 270879a0-c2f5-4cd0-8431-08dc1d70793a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6NvQUM58TC+O8z+tH55VLPMiB0+ewCKWA9x9YT2fd30qIJNWGlVFUEY3udIV72dEds7SvhOkpMjTjoAiOaNrJ2Ik0JYuesENbEMPCsQypBn1/y1g7RStrQciLHoKjBLQa75nGp+JQ6TVFQePl9CHxnTZp8wGsbXSc9xgcpwGAtPT8/npzKaU47EYLOHFS7D/hm/XGWhW5RoOmCzDlUyPuVXN2/sL74Inq1aneNPXgoyhuR+OQadb2gtI3mQBEBfzqf7e136GeCPxRlH2Ju+0aZNK4bri3CbL3nVcWntKcc+L4kTBkjNAoTaQbiN+y1oWujznjtapQrxm0ktCKGyrdAkseY3Zu/91xw20k4nheC11uomUQO/BLE1dvRdhWqLVbf0SkzsrA2Vwj+VZTdWjD4sxfm28qOx+/pmoTO48K2Ic1MnYNKIBrY8+sXAy7lAHPykaKFgmuUkXth+s9a2PWTXExLEGEQdzgv8ZTKqF00ax8MHyisHVgCkcZgnKsDDYlKTF3CarcmhRIMOI16ZrYPdk/8kpoQKP1DQ6eaurdUlxeph0sPC21KHIl7ICaDV/NHPNBeaG8jWS8Qm3kbFzzGwpiAJviTwv+HONQHS37FgwP7bWmH7zp+exjt+etqUR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(4326008)(6512007)(6506007)(8676002)(8936002)(83380400001)(26005)(5660300002)(38100700002)(2906002)(66946007)(316002)(66556008)(66476007)(52116002)(6486002)(2616005)(41300700001)(478600001)(86362001)(6666004)(1076003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B+f1gx3nOXmkDM6VN3WIUUtaa3tLXPMNNNMJ3EO6lHALcCQ5NIXoF43wccjA?=
 =?us-ascii?Q?E7q4cwEhcjUiUbf0JGmi/rrAN66Afmrb/kIEGlZxnI/UnvBUkP/btR6VKw+m?=
 =?us-ascii?Q?pYXaE4YaPPYEnqelv038ckjPF/5tF5aqJ2scyab6QC8oW9Zq9cPe2vqZ83UV?=
 =?us-ascii?Q?tZ9tvthCbuFCVHuFWx/mt9QK8Zj2kMFKXEI+bcsQXT8QEi5nQBmPIx2Ww/Dm?=
 =?us-ascii?Q?UeH+d+h4wGYZRz0SF4yBEsuWd0CuD7uSX3ikwgMteKhFt10l5iayKa/SEpXB?=
 =?us-ascii?Q?MoVzuHjGRU8Cepg3nPOdAY28nHerT/UjRiDOI2VSjaIaktK3jQzk9mnVktwT?=
 =?us-ascii?Q?9OlfeEiAIPSfk7+2NEBfpuLj4KIYtupenRbCCYW2dwU+EiDtcWwBZeds/lda?=
 =?us-ascii?Q?ECHPJN7gSk704o+wYie/b7vIAmBaYhE2s1Up7tox3Hms6rzI3BsOXgKz4SM9?=
 =?us-ascii?Q?+hzsNZfgly7/SmxshPrxmfuPNPKfI7E+qXwgT4llrnUzXyNGWKb/t40dLJov?=
 =?us-ascii?Q?nUKxLj5r9wYCvAfDdC0RRE3Fc7MOQw9XLNsoqJVvGns9BVGdjEkp0toP05Sa?=
 =?us-ascii?Q?dsZIzUX5oFIjx0b/U+0U5SiKGQKclie1WMdKjQ6x233cTnVHyVVnbUwkalN7?=
 =?us-ascii?Q?EE6qZ7SnI1gQGwdZyqRerSFqX/g94XUvA5d3Lepc6YHKJYWP8qk9z0oMMweZ?=
 =?us-ascii?Q?rB0RFEmUMyuB3A8yMNl+YB53KYwK8KZVzG8tnGB04LatviddgmH/+QTzS0ZJ?=
 =?us-ascii?Q?Arr+uYhKdSubExWL2BkV4kcr/OO9rh2Se/xZI4cuWY6BEuxV5WUIg0FrO75a?=
 =?us-ascii?Q?7NBE8w9jJAPCTpOCRsPiC62OxQWwdd5oUJOl2PP65+BLJ/I79x8U1KG5e997?=
 =?us-ascii?Q?S7ARui5sqDfc+Q0fX8mS1dENhh6safk8kkscjlvFD1sacbLNt0MyQwBuZ9Wl?=
 =?us-ascii?Q?r73ShrEhlj8wIGOHF+lDddVokJV+KdxWnwS8OWuQqHgnZvcZiirLfZb5dnct?=
 =?us-ascii?Q?PkUL3+Zv1AtX4CzcUGfy1OfKP9yYr5IGNFn/KS+vXX5kes3jCAEUfdXldIOb?=
 =?us-ascii?Q?IQUVyCrcw49fXOAMuezDVstrYO9NW03Ew93k2pYBLcvUTUXmWKxosA3X4pGx?=
 =?us-ascii?Q?F6ErV5Yc0doyfX7XIgrdNQyAvRuTSip4kd7qXR0D7LkNLrhxstUq99EJ0y46?=
 =?us-ascii?Q?y3kVtk5cYb0L+jD1HdAVgRuQJHUMJOR8GUqF16l5yXbm+aV7SYa+Byd4ywcW?=
 =?us-ascii?Q?dWBXSEw9qe4Mnc1BCkz8Zvi678ea5BtQOYlFnnrCkJlGJ4Qo1UYUoVM2ywOZ?=
 =?us-ascii?Q?y1psZcjPlZm63RVxesi4xnuU1gOYUqZdr6NukpPcjiHksjfqNhgD5CO/mR2q?=
 =?us-ascii?Q?47SDd6GWfRecd8xTvf/YNyJgsTFR1H1eNzg84+OAci08ibMcVTg4oghsPfWD?=
 =?us-ascii?Q?7uEt7NdzLALXXQ9spz69/dj8YaXzHTlIPAe6PKhUrLWU41cSARmq3auQcQD8?=
 =?us-ascii?Q?nnE3T+0RFPBvhH4ouaKgtdKDliVtXo1cCDj04bWVD0Mo/+S3DcMdRNH99bmk?=
 =?us-ascii?Q?u2556Mp9wBma6LapITBSdv5vMUoy8R1YYD4VJ5Ut?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270879a0-c2f5-4cd0-8431-08dc1d70793a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 06:40:08.9276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPEyyimkaWkk3SM4l4xgA6hC20SLBeF36ZFFjaTpBsv1VGaCkuOAGv+azwCdRNwjkEkGnugvk900TE4uT3yHpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6783

From: Peng Fan <peng.fan@nxp.com>

The thermal sensors maybe disabled before kernel boot, so add change_mode
for thermal zones to support configuring the thermal sensor to enabled
state. If reading the temperature when the sensor is disabled, there will
be error reported.

The cost is an extra config_get all to SCMI firmware to get the status
of the thermal sensor. No function level impact.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 Update commit log to show it only applys to thermal
 Add comments in code
 Add R-b from Cristian

 Guenter, I Cced linux@roeck-us.net when sending V1/V2 
 Let me Cc Guenter Roeck <groeck7@gmail.com> in V3, hope you not mind

V2:
 Use SCMI_SENS_CFG_IS_ENABLED & clear BIT[31:9] before update config(Thanks Cristian)

 drivers/hwmon/scmi-hwmon.c | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index 364199b332c0..af2267fea5f0 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -151,7 +151,46 @@ static int scmi_hwmon_thermal_get_temp(struct thermal_zone_device *tz,
 	return ret;
 }
 
+static int scmi_hwmon_thermal_change_mode(struct thermal_zone_device *tz,
+					  enum thermal_device_mode new_mode)
+{
+	int ret;
+	u32 config;
+	enum thermal_device_mode cur_mode = THERMAL_DEVICE_DISABLED;
+	struct scmi_thermal_sensor *th_sensor = thermal_zone_device_priv(tz);
+
+	ret = sensor_ops->config_get(th_sensor->ph, th_sensor->info->id,
+				     &config);
+	if (ret)
+		return ret;
+
+	if (SCMI_SENS_CFG_IS_ENABLED(config))
+		cur_mode = THERMAL_DEVICE_ENABLED;
+
+	if (cur_mode == new_mode)
+		return 0;
+
+	/*
+	 * Per SENSOR_CONFIG_SET sensor_config description:
+	 * BIT[31:11] should be set to 0 if the sensor update interval does
+	 * not need to be updated, so clear them.
+	 * And SENSOR_CONFIG_GET does not return round up/down, so also clear
+	 * BIT[10:9] round up/down.
+	 */
+	config &= ~(SCMI_SENS_CFG_UPDATE_SECS_MASK |
+		    SCMI_SENS_CFG_UPDATE_EXP_MASK |
+		    SCMI_SENS_CFG_ROUND_MASK);
+	if (new_mode == THERMAL_DEVICE_ENABLED)
+		config |= SCMI_SENS_CFG_SENSOR_ENABLED_MASK;
+	else
+		config &= ~SCMI_SENS_CFG_SENSOR_ENABLED_MASK;
+
+	return sensor_ops->config_set(th_sensor->ph, th_sensor->info->id,
+				      config);
+}
+
 static const struct thermal_zone_device_ops scmi_hwmon_thermal_ops = {
+	.change_mode = scmi_hwmon_thermal_change_mode,
 	.get_temp = scmi_hwmon_thermal_get_temp,
 };
 
-- 
2.37.1


