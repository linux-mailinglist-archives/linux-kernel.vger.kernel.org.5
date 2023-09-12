Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EBA79CB4F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjILJPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjILJPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:15:14 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D57710D2;
        Tue, 12 Sep 2023 02:15:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANK43JnReoImUMIFzigkXjhWEs20j6+4rrcigr0XHqzymWnuIgpNERzrWnCejNkxOQs8HG10F6J5MUDAhl0126/3u5ohJNdt6XQa7kUn3lCuzHQiTszqUIqiWoWuRk9M3NCl2bUGcsOFFP+tSDMr2wN4seaB5NOlNP9LnwOOtrNS6bSpOzz+LOh/CJtOK6NmW3Az96Mn736FSHq6yrJ8R0ZNGxUGKQNuZDeLO7gb3CgIw3Z1b74yIkcS7dzJZI3WMLTReTPm+JLMVp8ChUyXfjCSUVRnbiDJrkFzhlltu0vKtuGibVkDaesvnlgWNtb8ghZ0XljQjmN6E7/0Uw2+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gtnd6pWCASdz/Xr+vURao0lJiPholEOlIJyGz+Gk9lA=;
 b=Kcx1YQVBgaN+XVzYj8iAWJxjxbgs2+jxKEO+2rvSt/NBBRxYfEW0yDkePec84sHNvKkE1vWL18fHNSXIlxMW38iDB2aB8BdIyoTFzn7VU6vFfWySmZHv95v0vM5G5WjC8i/J3KobL8Tm7iud1D6ayP6HyblHvSxeISgQuYkBcswI//QGxOSlkpN6EaDeiCnBpHqdkkad1r9Tp9ZhQMGam1gQh8hQgZAzMyVJsstdbhBkFHJ9zkYRrpzgnWbAeeIgf8wz2zX42s3tSoBT2RrvJlj6dYC8Dp/E0VQiBFyWMP9mdvy0EU9+/8GAQg7Tc9D5yzqnyq8KQn+gF4kLSp0Ulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gtnd6pWCASdz/Xr+vURao0lJiPholEOlIJyGz+Gk9lA=;
 b=WpIu0lb/07RI8yjqFW9QAqy/UX4tg4KLTNm3LZC0z1LNFzsYq1SryOkQkOoZmCLvqEkaBsfl6qYHgYZVmQ487xPk/gtmckZwgMWs/iJzAjnG+JUaf0Ij0CpwDssRopbR/kgGRt0qRrttB3qmOchuFMeYAt0Mnx+0hFjvyYWAsU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7652.eurprd04.prod.outlook.com (2603:10a6:20b:285::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 09:14:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 09:14:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Tue, 12 Sep 2023 17:19:03 +0800
Subject: [PATCH 5/7] clk: imx8: remove MLB support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-imx8-clk-v1-v1-5-69a34bcfcae1@nxp.com>
References: <20230912-imx8-clk-v1-v1-0-69a34bcfcae1@nxp.com>
In-Reply-To: <20230912-imx8-clk-v1-v1-0-69a34bcfcae1@nxp.com>
To:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694510362; l=3291;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=/kgTg1oPdo/WAsx0j/xnkO7IJZdijR7A8gWhop/DqmY=;
 b=tNAsJojuTOtIapGBP6VTbfwhi6FijlaE6ttYFj+6LBX4iPzX5l1v7RVjlEoIKn230vRvELQJ3
 zsEHim9nlgQD/zGhdNqDdnAUIHNjy2h1DR2Y3zeCOoFxR+2WNncwZW7
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be80d6f-5e6c-407f-e8be-08dbb370bc00
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NW/Eix5SWLjjDYsu+qaHUoXzeKHbSCdpOojYHSQUlX104it78i7/L3VTo0ib4WWTWqkJRHvj/n4rd6fH04XKkU7Ew4ywxkt1sxnwWIjH8YEdb6MIg6wRSokCDZeunsbQ7w3mk+ZaobCYwpurncJYsIdnKDGwVOxAPHcUz6fgPHORH3I0DO8t4DzQWmIGOLOozkLoKIWKLjMiWRB+EAot35lIPi44FlpMPkmmMc6icKM06dxxPGicCh0+0Oo8p+aGDZbczmuYU0MzY9uyz14g5M7lVtr3aKBhCGaq4wwsXqPZLwZnpMDKCv5PXOxgzfea8/Uzdpw9d0jM7YUgvFxM6Ja72/RTtxRdXbwJqBQI5IXJvR39MKDfGJdosmUbn+4Rz4a3AfO/9fYaQGRxnS84jvZuASokovCoOHvNerNyupXWtQzo+fd8WtT3Bs5DzJcmP+NwROfT9+ReuBcspkrnZ6SEvB5zftpOC5cs7JUQmLGyO6VTNLqNmRBhY4BN97YWLtvYi1Kd98tWodk9hmUd3Ruo3HZ/iLhqhuClItnz0htFycH9u1OfxxV3rtMsEGLkdlCg17ZcosAlUxbFH3H3X8RKOemPncZ+PxZhf30qez/oLIBQrztgfGHd6kJWxWo3sv3YvSy6+azx7cPc9KQC5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199024)(186009)(1800799009)(5660300002)(8676002)(8936002)(4326008)(83380400001)(6486002)(6666004)(9686003)(6512007)(6506007)(26005)(52116002)(478600001)(921005)(66946007)(316002)(110136005)(66476007)(41300700001)(66556008)(86362001)(2906002)(36756003)(38350700002)(38100700002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDQrb2NxdVV0M29RSmxla0lBY2dTNU4wcXFqKy9sdHdVNnVXZ082RFY5bmcr?=
 =?utf-8?B?ckdWcVpyM1haUHpkbGlYOEx0ZXZCOXR4OGZtckMyeWdHU3M2U0lnUGhJSE5N?=
 =?utf-8?B?VHdMeFIyUDZPODhGbzV4OHhXczlmODVMQ0hoTUt2MmVpa0lDZDZDZFJEb0Rv?=
 =?utf-8?B?NkNzejd6dnNMbWtxZjdqaisvVmJGbDIyeTV0QzZOMTI4NEF6Zkt1eHRFVFpz?=
 =?utf-8?B?L3NheC9jd2U0Yzk0b0NMSjVZOHBXcWtzL0dtb3dLbUxxQUhiZWNLZ3dHTHhr?=
 =?utf-8?B?T0pNQ3ZvaUJpaDBreTEwbTJEYWEyNXBRWVRWMkVsM1l0Ty9YUHRKV2hNSGFG?=
 =?utf-8?B?Q3J4YzZ1TkRBNzlvZFMvdnVhaC9LWG9WVnR5d1ExL2l3WElva0F1NkRPQTZx?=
 =?utf-8?B?SndGUTIxcldRSmtKN05DSE5uVngvMFE0dFVrL0ZDMHJ2UXRLWVBTTDZubis2?=
 =?utf-8?B?ZEpaY0RxZlhYWnd2eGh1a1d3bkpYaHBONXh0MUdEUnUxRmJUeVZFQTJpcFFi?=
 =?utf-8?B?WGt2Slc0ZVlwV2QzUUZqWHJnM1hRVWwwK0lMZExCcGQ4ZXl2dkZGbCtwUGZC?=
 =?utf-8?B?U0hPT1FIMkwvcUFZaUMvUzhvN1BPL2VhcFl6eldPZTM1Tnp2ZTQ2czE4SFpE?=
 =?utf-8?B?akJlUGlhK1hva3Z4VXp4VnVZbEJUQm0zb2xsV1JLejhwRXdGY1ZGTTBEbHVS?=
 =?utf-8?B?d2JiZkFSRzIrei92enBCeUd5S1JDdHJwUFYybXZNSHM3Mm5WMkZQd3ZDR3ZB?=
 =?utf-8?B?VjBKYnM5aitFTXI2R0RDMFhFVUs0S1ZqSTRCNzExWXVJL050aXEycU1SbEZG?=
 =?utf-8?B?WWZnYWd0WDRCaFZEejVRZjNUUEw1RmFSVGhqbFNmQUppL3ZsS2tFUVZKV09h?=
 =?utf-8?B?YjRSZklPOTQ3b1hDcnRnNkFnaVlzWndvQk84cS9zQzFQQTJxR01hbnJMaSt3?=
 =?utf-8?B?a3lGQ0F4ZzZFYS9wUlZlN2xQVWVwclp5SzZVamVEUVUzT0psNEMzL1hlNFZj?=
 =?utf-8?B?VEp4MmYrQmdLeDR5bmNuWnRKdG1ZQWJvMU9xdGh4c3dLTkZHL2lDYUdjVFN0?=
 =?utf-8?B?VE03NnFyZGlMTVpSZENiNGg4NnpEdithaXIybXkwM3g0ZGZDS0NVTHd5ZUhL?=
 =?utf-8?B?MkkyRGdyNWJRbXpJd1ZKenhta1N3TEd2VGVHMk5aU2tlcVFITWQvdHljOWlj?=
 =?utf-8?B?Tm96a3Z0ZWRYR3k3REhtOHNwaWlmVWpURzdmbWxldWk5UnM3ZHdSVU0zMDU1?=
 =?utf-8?B?RWU0My9QOHdrNTh6UlU5YUw0am1CYnVRYnZCS0NOSHhPOVJETTlvQnFBWW5p?=
 =?utf-8?B?eFIyYlFkeTlCTzBpelZ4cnNuTGJ6QWZwdGxDK29uZjV6SGxJRG5KT1FmKzdQ?=
 =?utf-8?B?UnY0YkZmc1BDMkdxYUY3VEZ3VmdNdjIwU2d1bEF2QWZQQ01SVi84VU50ODFx?=
 =?utf-8?B?eG1FMFo5ekFDT2s2Y2hhSjZGNnhBWTU4SHlRMzVWeStIWGVMTTE4c01FRmJK?=
 =?utf-8?B?bTR4TEFndHNENi9CbGNoVlZURUJ2RHorN1hVWCtNMnBnZFFKL3JIdjlvREc4?=
 =?utf-8?B?RmtrZ0Vna0swM0JSZkJBSmh3WjZMY0k3ZzZqcW9aOFMrdUZmOVc3N21sL0xN?=
 =?utf-8?B?ZWlwWHVIV3ZKRHZ1WlJwdTZRaWVmZWVrUXdCcjY4R1Q3WGFqRkp6ejZLc0FE?=
 =?utf-8?B?VEE2Y1FMQ3MrOXBkc1F5NjRMcHVNeTNhYzdLNzRudmliOXJNZ280dWFEUklV?=
 =?utf-8?B?Uk00VHFyeGhzUlhxODVjdXFjKzB1eVMrVVBZdXZIVUZZQXZzaWQxSmViR252?=
 =?utf-8?B?by9zdldkVjRnYTN1YUpPTURDQjFzN0Y3Ny9YV2dtdEVLRVVtUm95UElWcWEz?=
 =?utf-8?B?aFNic25zNEpvN2NvWnBQVS8weUdaWU91eWhWTDFrRlJBV0VKeld3Tm9zWjE0?=
 =?utf-8?B?VGlUc1htVWVoKzF2R0N3Um9BK2ZWbzVMb2lnSTFEbitxZG84ZURJa0xwSGYx?=
 =?utf-8?B?aWNIbEpMbHMvWnUrbFh5YlVFeXBGRDhFcG9ZZVBkc1pkT1lPMWVpRldSdEpM?=
 =?utf-8?B?bUxoL0wvcVl1Si9EWk0yMDhjeEJ3QmdzbHJhQWNzL3ZOZkRld2ZrYUpFNmxj?=
 =?utf-8?Q?8MQzBTutC8csfyOrAn2M6OliH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be80d6f-5e6c-407f-e8be-08dbb370bc00
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 09:14:57.6263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+D9L1INGBDDrzRrGq8XO/hNislRvAs01v7z6bjx9ORKDzsU3yMf1gPe77o2xT/PJykIHxU75KAbrMHseAPizg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7652
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

MLB was de-featured, so drop MLB clk for i.MX8QM/QXP/DXL

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8-acm.c     | 6 +++---
 drivers/clk/imx/clk-imx8dxl-rsrc.c | 1 -
 drivers/clk/imx/clk-imx8qm-rsrc.c  | 1 -
 drivers/clk/imx/clk-imx8qxp-lpcg.h | 1 -
 drivers/clk/imx/clk-imx8qxp-rsrc.c | 1 -
 5 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-acm.c
index 1e82f72b75c6..b96fdf5f84d0 100644
--- a/drivers/clk/imx/clk-imx8-acm.c
+++ b/drivers/clk/imx/clk-imx8-acm.c
@@ -77,7 +77,7 @@ struct imx8_acm_priv {
 static const struct clk_parent_data imx8qm_aud_clk_sels[] = {
 	{ .fw_name = "aud_rec_clk0_lpcg_clk" },
 	{ .fw_name = "aud_rec_clk1_lpcg_clk" },
-	{ .fw_name = "mlb_clk" },
+	{ .fw_name = "dummy" },
 	{ .fw_name = "hdmi_rx_mclk" },
 	{ .fw_name = "ext_aud_mclk0" },
 	{ .fw_name = "ext_aud_mclk1" },
@@ -103,7 +103,7 @@ static const struct clk_parent_data imx8qm_aud_clk_sels[] = {
 static const struct clk_parent_data imx8qm_mclk_out_sels[] = {
 	{ .fw_name = "aud_rec_clk0_lpcg_clk" },
 	{ .fw_name = "aud_rec_clk1_lpcg_clk" },
-	{ .fw_name = "mlb_clk" },
+	{ .fw_name = "dummy" },
 	{ .fw_name = "hdmi_rx_mclk" },
 	{ .fw_name = "spdif0_rx" },
 	{ .fw_name = "spdif1_rx" },
@@ -122,7 +122,7 @@ static const struct clk_parent_data imx8qm_asrc_mux_clk_sels[] = {
 	{ .fw_name = "sai4_rx_bclk" },
 	{ .fw_name = "sai5_tx_bclk" },
 	{ .index = -1 },
-	{ .fw_name = "mlb_clk" },
+	{ .fw_name = "dummy" },
 
 };
 
diff --git a/drivers/clk/imx/clk-imx8dxl-rsrc.c b/drivers/clk/imx/clk-imx8dxl-rsrc.c
index a36e821ba807..0f940335d83c 100644
--- a/drivers/clk/imx/clk-imx8dxl-rsrc.c
+++ b/drivers/clk/imx/clk-imx8dxl-rsrc.c
@@ -47,7 +47,6 @@ static u32 imx8dxl_clk_scu_rsrc_table[] = {
 	IMX_SC_R_SDHC_2,
 	IMX_SC_R_ENET_0,
 	IMX_SC_R_ENET_1,
-	IMX_SC_R_MLB_0,
 	IMX_SC_R_USB_1,
 	IMX_SC_R_NAND,
 	IMX_SC_R_M4_0_UART,
diff --git a/drivers/clk/imx/clk-imx8qm-rsrc.c b/drivers/clk/imx/clk-imx8qm-rsrc.c
index 8412fa349569..634bc3058657 100644
--- a/drivers/clk/imx/clk-imx8qm-rsrc.c
+++ b/drivers/clk/imx/clk-imx8qm-rsrc.c
@@ -65,7 +65,6 @@ static const u32 imx8qm_clk_scu_rsrc_table[] = {
 	IMX_SC_R_SDHC_2,
 	IMX_SC_R_ENET_0,
 	IMX_SC_R_ENET_1,
-	IMX_SC_R_MLB_0,
 	IMX_SC_R_USB_2,
 	IMX_SC_R_NAND,
 	IMX_SC_R_LVDS_0,
diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.h b/drivers/clk/imx/clk-imx8qxp-lpcg.h
index 2a37ce57c500..ebca8fa9268f 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.h
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.h
@@ -42,7 +42,6 @@
 #define CONN_ENET_0_LPCG		0x30000
 #define CONN_ENET_1_LPCG		0x40000
 #define CONN_DTCP_LPCG			0x50000
-#define CONN_MLB_LPCG			0x60000
 #define CONN_USB_2_LPCG			0x70000
 #define CONN_USB_3_LPCG			0x80000
 #define CONN_NAND_LPCG			0x90000
diff --git a/drivers/clk/imx/clk-imx8qxp-rsrc.c b/drivers/clk/imx/clk-imx8qxp-rsrc.c
index df09f2a7996d..29868e686921 100644
--- a/drivers/clk/imx/clk-imx8qxp-rsrc.c
+++ b/drivers/clk/imx/clk-imx8qxp-rsrc.c
@@ -54,7 +54,6 @@ static const u32 imx8qxp_clk_scu_rsrc_table[] = {
 	IMX_SC_R_SDHC_2,
 	IMX_SC_R_ENET_0,
 	IMX_SC_R_ENET_1,
-	IMX_SC_R_MLB_0,
 	IMX_SC_R_USB_2,
 	IMX_SC_R_NAND,
 	IMX_SC_R_LVDS_0,

-- 
2.37.1

