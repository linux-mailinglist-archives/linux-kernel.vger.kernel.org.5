Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A7B80B0A6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 00:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjLHXlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 18:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLHXlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 18:41:11 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2053.outbound.protection.outlook.com [40.107.14.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A608010E0;
        Fri,  8 Dec 2023 15:41:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O45cJYr4E2HrdHGbp3tFixdJzNtpCTSro61dyRrzIIVW9Rpid9lnDf2X5tRPN3pKNt3szH519b5D2+3id8aCz32gr36NbpvhmLSIp1jvWWxDrTQvSJKe4bk4mSh6jsObViBPWCO4B37MEYt1VAdsrAkx2yhYhezUBbQDjlGNoFy5XE1+oTZQSM/5qmP2Mjm6frs9m/ub+VRonA5nitmW0zpFrfyqzauP4AhJCKpkCqPRd+dRo2l0pG1utz/jf4xB+DY04azjYazRfJWpMGEG9ueR9lSHEgId+LgC5husxQeNYaQG7qPk+6NQ98m1H9H60WprOI8JuVhemkzpocS7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DR1rn44KwcYXOYpJqRYa7zWKHZEwQzhEqlpGKNVlX6s=;
 b=fSfHVbF7vHU4AzbiYaDEKR2anO3X028z7j0xIJiYhNGYl6VvSE4GcdJ9kh3oRDtdJdAtGPYIXYEAgQRiCfZpWE/4KPbIzubMFVcIo5QcvFHXLdSA5eRjo6Hli1Y/MwLvKqFi0fRRfATuwC1LVxQ01Aso5Usb7wwfnmisnXF23IdHktFAZRagRZD8jNHKEwh0cyhKOeWgJjmZLz1n1anwgupu7drhAYGt5zGnWPdE/Es7NRuWucZisC8U94MhhaJEcIM/s/hRtHdZ/QT0zAb8ajfmf892IP7Em7i8rla2mslznpW4B2FjtxUMI1S8pLARwKjMmzYo454+fWnpHjPFtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR1rn44KwcYXOYpJqRYa7zWKHZEwQzhEqlpGKNVlX6s=;
 b=FnYLnPA3tjoCyobLZkqO29E/ZW3wOtCOkyVrQZOmmTNvPftcgyrwyNmoj98i6jlfxueHeK9JZNaX6coRskBC+/JWEq9+Y96RyPUv5WMGqMhk4eig3Lc2IyQPHBuHjYO5sC8/5eep9t/rKIy/yk7VNqywJGHdyqEnvsYLlm5sFJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB9110.eurprd04.prod.outlook.com (2603:10a6:20b:449::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Fri, 8 Dec
 2023 23:41:14 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 23:41:13 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, briannorris@chromium.org,
        kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
        David Lin <yu-hao.lin@nxp.com>, stable@vger.kernel.org
Subject: [PATCH v3] wifi: mwifiex: add extra delay for firmware ready
Date:   Sat,  9 Dec 2023 07:40:29 +0800
Message-Id: <20231208234029.2197-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0193.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::12) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS8PR04MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: d1bf8d0b-8475-4d0d-c11d-08dbf84729f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5anYdaRs6HSyOEtzce5tr7TWcorZHWBBWuHJuYlAIn2pEd6QkwqYoJ+ASDBZ6bZ8RE5c/CHBraf2PsjobTKHZCpCPYF1dY69A/e1yKDD++Sz0I9fD8EHdelGeOPzaMANWEA47vQoBuqhivdLV5RqbvNlQYaJs7x1QvlPSDleDVtenLuTa/0a8zU8rUeKpl/zZmAHjJeh5SCApFl5t7QgOyYsUBrYM5KvoZ6YaZnpplBghAOaBtnSMMWCq5cQOEkW+aDYDB2ErYUztSTeUQaZfcjAKogWBCVyBsIPV1FfYv7Xt3ifYdfwhCX/luWtney3snZumTBhy5uFWPwjINX9vd1f2xrGOMtMU1zOGJkl3Zvc5axFcYPZed/E77rxfvTw76dsX+lyWkbJi2Izl3PXUH+HRbnObSsP5fxyXuUG53TZaK0HkSDohKCW7hQWMZWTv2p704ZvP+VLT9bHX/upXtPeMW96eDq/IAuv4IJ1AfzgBIyroaxtz0KBxJm1H4Umty5rM4jGSMJWipiA16NluNmfisnf0c+C50Ekssk/y9GZPjUO11fOzZoXiW8gfrPk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(1076003)(6486002)(6512007)(2616005)(478600001)(6506007)(52116002)(6666004)(2906002)(5660300002)(66946007)(66476007)(66556008)(8676002)(4326008)(8936002)(316002)(6916009)(38100700002)(86362001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y6oc3ppIp/X5Adpyupe5XDpO55tdrDt8mouH5WkzkjKqc0PF7BL6H3JQwljl?=
 =?us-ascii?Q?48D/QdX1fjUT/GuZ2JngzF1oYIZuSwkC4A48XS1baRrbx2pdTkG69bNAx7Xc?=
 =?us-ascii?Q?G2umBFYbDnbi/osLUXUJcfARX/ICJF/vf0cDpClORyF91WqEul5YCc0KWaoY?=
 =?us-ascii?Q?PkhQTsOCTG7QElFMVFEBRSslU899I2rTvxyIjB7mFxgCi45ejTr7aMcFaqc1?=
 =?us-ascii?Q?grlCgqWMqPrsJFBKlGh6zhnvGYUAHYCIgKJag65R62XbWpJtvOl/uYhdxq98?=
 =?us-ascii?Q?FmRRPlgqg1n+rt5fgOXbmQ91bzB5ximVZjZKw+rGQfaWOtlpP85SepilwOjU?=
 =?us-ascii?Q?Wo5VMks2GwHmyTz8IZ5On3/dVsG/NTPM++VjRnTKzNHp59FBGqAOwGrV4l+/?=
 =?us-ascii?Q?f2BQgRDKc91i5FovRPdbT7aMejhbNL07akOvDV/n2BJiowYRvUYip+F4L9TZ?=
 =?us-ascii?Q?vjv1QT6QXemLJJtVddQT9zyvVaktV0N+DrgV1BYGrlaJhF/Jx79B9cPRbqxZ?=
 =?us-ascii?Q?bAn1LiVRRwF5Ip4aJWdNn1Fz0X5SLZxyk1MupLGdpCUVbjkgiCkamoyT7oON?=
 =?us-ascii?Q?d9m8TxiRgDIs/8GYtqFuxfB+2H4/wAtTap+EaP/xxXTZLAtRtucTBzjthESI?=
 =?us-ascii?Q?qJTF7v2FlcQIYqa9SHqmuV9mxbeLGGDmuuq1zDfUoc9FCXRjO2a+jUtqyOtF?=
 =?us-ascii?Q?dO/LYHnBbNhafeQ+tDyEIM2DYAcA5KzpwYPASPps8Ns6JTDjz4vpBFnDVHQR?=
 =?us-ascii?Q?qToSFvj0+z8Iu406ha6pPh+2P1Au1s2qT3zfJTvY+g0OjXe5iRJjwWZCkOIK?=
 =?us-ascii?Q?8e6elL5lJU0WUaD6Zjnw02Hqi/QkUamQouJem03+OxAfm523UTyEqupNnm2D?=
 =?us-ascii?Q?z3paOcW8vfKXoEphTHZO2iwRGYC41NSakHdO9mgll4f6qUApduszhV6Gu/KG?=
 =?us-ascii?Q?daNH5stWae3B7Ikz+rfU6gJq5QZxDIjfpIGjtUG9VGPw/zPnNw2ZOsmp4feA?=
 =?us-ascii?Q?DwX4UqW78BbPku0kBvwJbpBieuzwps3g+YNBpNJV+oG3p+zGEFFFwBZ978oi?=
 =?us-ascii?Q?V7LaEgR7HZ91kry2QFoNjxWqwSXj9BlrRpuClSMlYb8neWEAWlxZ53N7vjYL?=
 =?us-ascii?Q?+XF2cLat3jkIQHD0ad0wazKDCvzqBqOhJWHmxMjhgEnoiSUU+YTHStMJqY1v?=
 =?us-ascii?Q?a3v7hJ8NIX+ZNIixUVRm6VVUfjuBW2Yl/AA59P61aVq1ltbNPip4336zRU6a?=
 =?us-ascii?Q?A5JUsXNRjmre7NDOJITzin0CHylc9pB7Lf/RLEMCULt9c1yOcLQHmClMXWka?=
 =?us-ascii?Q?ZzSscZsT0GEK/0UCGjfMEOUiBxFE5e/qv+hpxAvyGLqOr9BtWciCAILCrKhb?=
 =?us-ascii?Q?r2jklCMo/jRsDVLLZ0o8+qHWb1NP9UkhJ5TnAlgAjKFEpE2XKXLcq7twPPtA?=
 =?us-ascii?Q?jmHJc1qb+huJjGvPpN+VzmkMz2L1amVF57FfhMu6ryMp1ueLb0MWHGxudZnF?=
 =?us-ascii?Q?wpG7lFPxwpPFJkNJHZLCrlZUPlGYmLWSG5fDrkeSYNF7t//HaaUImUarU8EV?=
 =?us-ascii?Q?Ay2Bv7EfbETuOlIJgtaEe2herNkZk4zynzIiq98rKMmOtXIdQ5sl8Sh/zfW3?=
 =?us-ascii?Q?ILH9TzkxezFCQWQ8jwT1LVkBuUZ0Q3jHlBTrOOM/5UCN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bf8d0b-8475-4d0d-c11d-08dbf84729f2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 23:41:13.6338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcgLjePETBjdD2V3dX230j0LDkAhrPSxFpzsjCNpPARGaGVQgMx58xa9X5xTtmkGYkN0HE44QAT8fhFPMwTbrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SDIO IW416, due to a bug, FW may return ready before complete
full initialization.
Command timeout may occur at driver load after reboot.
Workaround by adding 100ms delay at checking FW status.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
Cc: stable@vger.kernel.org

---

v3:
   - v2 was a not finished patch that was send to the LKML by mistake
   - changed check condition for extra delay with clear comments.
   - added flag to struct mwifiex_sdio_device / mwifiex_sdio_sd8978 to
     enable extra delay only for IW416.
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 19 +++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/sdio.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 6462a0ffe698..ef3e68d1059c 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -331,6 +331,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8786 = {
 	.can_dump_fw = false,
 	.can_auto_tdls = false,
 	.can_ext_scan = false,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8787 = {
@@ -346,6 +347,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8787 = {
 	.can_dump_fw = false,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8797 = {
@@ -361,6 +363,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8797 = {
 	.can_dump_fw = false,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8897 = {
@@ -376,6 +379,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8897 = {
 	.can_dump_fw = true,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8977 = {
@@ -392,6 +396,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8977 = {
 	.fw_dump_enh = true,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8978 = {
@@ -408,6 +413,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8978 = {
 	.fw_dump_enh = true,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = true,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 = {
@@ -425,6 +431,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 = {
 	.fw_dump_enh = true,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 = {
@@ -440,6 +447,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 = {
 	.can_dump_fw = false,
 	.can_auto_tdls = true,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8987 = {
@@ -456,6 +464,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8987 = {
 	.fw_dump_enh = true,
 	.can_auto_tdls = true,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8801 = {
@@ -471,6 +480,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8801 = {
 	.can_dump_fw = false,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static struct memory_type_mapping generic_mem_type_map[] = {
@@ -563,6 +573,7 @@ mwifiex_sdio_probe(struct sdio_func *func, const struct sdio_device_id *id)
 		card->fw_dump_enh = data->fw_dump_enh;
 		card->can_auto_tdls = data->can_auto_tdls;
 		card->can_ext_scan = data->can_ext_scan;
+		card->fw_ready_extra_delay = data->fw_ready_extra_delay;
 		INIT_WORK(&card->work, mwifiex_sdio_work);
 	}
 
@@ -766,6 +777,7 @@ mwifiex_sdio_read_fw_status(struct mwifiex_adapter *adapter, u16 *dat)
 static int mwifiex_check_fw_status(struct mwifiex_adapter *adapter,
 				   u32 poll_num)
 {
+	struct sdio_mmc_card *card = adapter->card;
 	int ret = 0;
 	u16 firmware_stat;
 	u32 tries;
@@ -783,6 +795,13 @@ static int mwifiex_check_fw_status(struct mwifiex_adapter *adapter,
 		ret = -1;
 	}
 
+	if (card->fw_ready_extra_delay &&
+	    firmware_stat == FIRMWARE_READY_SDIO)
+		/* firmware might pretend to be ready, when it's not.
+		 * Wait a little bit more as a workaround.
+		 */
+		msleep(100);
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wireless/marvell/mwifiex/sdio.h
index b86a9263a6a8..cb63ad55d675 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.h
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
@@ -255,6 +255,7 @@ struct sdio_mmc_card {
 	bool fw_dump_enh;
 	bool can_auto_tdls;
 	bool can_ext_scan;
+	bool fw_ready_extra_delay;
 
 	struct mwifiex_sdio_mpa_tx mpa_tx;
 	struct mwifiex_sdio_mpa_rx mpa_rx;
@@ -278,6 +279,7 @@ struct mwifiex_sdio_device {
 	bool fw_dump_enh;
 	bool can_auto_tdls;
 	bool can_ext_scan;
+	bool fw_ready_extra_delay;
 };
 
 /*

base-commit: 783004b6dbda2cfe9a552a4cc9c1d168a2068f6c
-- 
2.25.1

