Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F487A358E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 14:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjIQMjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 08:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjIQMja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 08:39:30 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EF2186;
        Sun, 17 Sep 2023 05:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pu/cWJslb/TKOaQLaByCVNSEZ6h0uu45ONNp7ZLwr6v0ryASXIk4unaFBKCrJarLoUrYT9sBtCvm7jt6qB9MMJKiD+Al4ksGc2gcNg4kyLzlPx7TW8HG1pQ0SA/lnfiADmhEnaxnS05xSo4/ceHHleJg4kynaJYxoxvAhWN86JvkQUKoM8wB830f1zeIj3Mnu8pAt5s/Rp76OnsStgHr09Gud1CXLel4/5QmWguNqzOukyHc5EvoFfmBvIGAikTOeLB6Cgk638JD5lQDnBctqRt2zMB4X4wHu4OHK0GXm4+8ELi6cSY5TB/tXr6xWwGaHCk+y0bxs2NhmnGkZzTC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DY6QVPJC/JetWcsFl7H8Aar/2lMjxonTEiOUMmgDHVg=;
 b=cb1AqEPtmtxbvH+4fpWkThhDT9tZqrNQGJFvjI9Z6GoDNmuN5jdjl7UY0vY+NsrbW1DTRpkJY1iUAPEkPuu5IGHOQqFFr5tK4B/4F8y/yNW+mvczdgReZYHB9CUpHG0KUAWAxXej7WqkQrqhRKN2aGqh3d1vAaNZyt/OTXwIgIphTSc1WMvs2F7wCf3GVZZISqf8l6ABc5b4q3Snw+REeCAajb9JixWZvnqGE8UGmTBZg42rRu7XZQO5HJ+2KrIZgJgrt1BkrrPLfb2f5wDhkk5LxzPbJgUI4bz7dIJptfB9n9GXazLix7Bb+9oHE7rosvlJS6wvOA2fIXXxxG5nAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DY6QVPJC/JetWcsFl7H8Aar/2lMjxonTEiOUMmgDHVg=;
 b=CuiGdYVa513taMzd0hh5AD4L25jN5g4jL6jbRE5nCgqZbcLo+tQJ44V8nnuGH4Kmfkq/9Y80uSjgfvO8SiIvNceq2vLtjaTVXOG14rkqZkFF55xtYDFzfkIqh4kT0xGFex3Kdn0B2rrG1pIGLLiDO/mts+1kHcvqJEJWf6Z6/1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8928.eurprd04.prod.outlook.com (2603:10a6:102:20f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Sun, 17 Sep
 2023 12:39:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.024; Sun, 17 Sep 2023
 12:39:21 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Sun, 17 Sep 2023 20:43:51 +0800
Subject: [PATCH 2/2] mailbox: imx: support channel type tx doorbell v2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230917-imx95-mbox-v1-2-440245287356@nxp.com>
References: <20230917-imx95-mbox-v1-0-440245287356@nxp.com>
In-Reply-To: <20230917-imx95-mbox-v1-0-440245287356@nxp.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694954643; l=3536;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=IpDDsV2srMT5yXNKgZuFQNd3N7MPTACoYyXGGcM5Up8=;
 b=zusOE48DuB03Zn5FyRzsggOAEAgjgJx4w9mBwAMvdpmP4uO9l1bcePGwpNiCXBpff7ua8Z7Ty
 ZSIgzYWbLX2ByC1Msb3v0BoXSZfrRCcIKqIolIQt6mCuZILpIK8H3ci
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: e7236897-b78b-40f6-a41b-08dbb77b1db4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tE1PFlLS9bFYpn6WK/WCD+btfL89DPof9bk082bCa9QWJTDcx6rtFQg1aEhhERIIsTbGYM4wl5srfOr5j8WHDKwicCOTHqJRBflQqTFHCF8jEq/5yOVffcXMtONf319K7qvJjzEBRW3xqDQcu/HdlDseeKMbVqRWBnEPieM1pnmif1kf591gl4VJ5DyAwQ0+hXKqSTw8NIlABT4GS/A4rxBRnZ0W8l3SUaXUt1HmquFKGknfOywq858jPctkLMRhxf4yUeUS3ujCNECPdYZx5nmdOMn+G4LQZ6PyWMHYmE8jLAAHH1MCulUyb/cMK8EggH47Ep0ToPQEqLlsGFNl4LJFDIr0etN+XwpyZp3W0uxoKhK4kwgudPvCUwtkeXpPGOdc73LDS95rhElLZXHaNFXG2tLDeGYdaJi3NVof/jU9bX5Fr5Oc7gU4BDBlgi6skxUBJPHWWUgrcRggjqfeAdA/S5/4aWSoFcT04je3gq0yIhI/Y1cC5deiI0xF85RRuMiqkv2YpG+wo/x9dntlCTd11wOXIvJ/bNeZeix3L5gXpgiq5kkBEWHFJuG8/Q1dhE863PnqUVPiAZSr857EovRuwMXxS84qxhyK+22fyQZIIpC/JyqEGH2q15i+aYkLiDZ9Xhueco9lhdgAaSKOcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(366004)(346002)(186009)(1800799009)(451199024)(921005)(36756003)(38350700002)(86362001)(38100700002)(6486002)(6506007)(52116002)(478600001)(66946007)(66476007)(5660300002)(66556008)(2906002)(6666004)(8676002)(4326008)(8936002)(9686003)(6512007)(83380400001)(41300700001)(7416002)(110136005)(15650500001)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUdUdTBpRVdlR2lXWFo5Z3ZUN2Q4SWlJSEZMR3hwYTVURll3NVk1ek9kc2VV?=
 =?utf-8?B?MC84MVlJLzQ5dnRUblVxWDQ5Ui8razFleGd1MGxoYXIrWmRINkF3QnBlcCtM?=
 =?utf-8?B?Vmg4MFFBV2FVRE93K1BvcUx0NW5yQ01MV0tvQkRHZ3M4bzZ2K1FuZDg3M2pp?=
 =?utf-8?B?Vk90Zi9lbUlINEcyTnIwVHNmQmdJMEVtU3VwNGF0VzlVTnlidklhMXFHZnUy?=
 =?utf-8?B?Uytha1NycjI4RHVVUE5zdVlpeTFMTWR3aFdjWjRHaW1FSGVnMlVLYWhlQTFF?=
 =?utf-8?B?OVd1ZVFJeGdkY3FYdHpjYVdrV0FPcTNyamh1bG91MktHM2FzU3IxK3hudFRZ?=
 =?utf-8?B?OW5GYTVDREZORmRhbjJBaWkvRm1TTWl3Mzc2T1Vmd21JaFNSRjcramdGU3pj?=
 =?utf-8?B?dmN2TXU3KzFrOWs2TytsdCtLdGxvUVlEdSt3RXhEeXJsS3NvL0ZSajcyRjJv?=
 =?utf-8?B?bjlEZ2R3cXZNQ3VYaDhuVmZYWlRvMmhlQm8xenpORUVnVHZydkt0bDJyS1VY?=
 =?utf-8?B?c2hhcWx3Y2wwS1QrZmtkdWxSYXhBdmhEdHBONEo0YldBWkIybVZXZ3ZWdFpP?=
 =?utf-8?B?Ync0TGRldDNla1BLckE3QUd2V0o4TVBQTGpNUXBTcnBIeW5ZdmJBQjJjb1pW?=
 =?utf-8?B?TkZSL1gvei9VRnBOc2xNc1Z1THBVaFArWkQ0UkNrUk1CU2VNU2k4dm05SnhI?=
 =?utf-8?B?MldicmxKeHJlK0VyVnFBaitVek5ra2NQRkZHc1Q1Mk5SQU5ERENkbWhHV2F3?=
 =?utf-8?B?ZnNpUGpsVmhKdURuSVdrQ2xqaThVU0g5bE9YQ0FVVHBSTzNFM056Q21ncFY2?=
 =?utf-8?B?aWs4S1BHRCt0bXE3VGhkRnc5cVBpS0Y3RDM4VUQvSlI5NWd4MFBES2lpb1Rm?=
 =?utf-8?B?K2V0dVJweEw2Und0M3NKMzBrUW1EN0NaMGFhK0piczlNd1MrTmFlQThBeHZj?=
 =?utf-8?B?UVlVQlpJcXZJYTNCVFc4eWxOM3VGQ01sVHFZd0U5MGE2cllqSXE2c0JrS2Nh?=
 =?utf-8?B?OUtGVzJKYmZ4UXNCUWJWQWRZcHlYQUJBazJiUHpXUk1EVkxhOG5KVm1wRnFQ?=
 =?utf-8?B?akRMT2d2VFJNVEFqbzZwM3BmUVJPaXNwTTRIZzUzRDBiZWYrL0pYUkpYS1Zp?=
 =?utf-8?B?dzJ2eFZSbDZkTkdrUG1BRkhmdk9qUmZzNVFlSVFFM2F2ZG9pYXZrVkp5UGs1?=
 =?utf-8?B?M1ljNWw5M3FYWnd4eDMxbmYyanJuNjByY2g4UHc1dU42aEJiTFJFdGF1S3B5?=
 =?utf-8?B?WDQ0NzVJQjBtUm5BamZsMFhoVzFZQlZtc0dxaEd1L1FKaHBHK3U1OC80Wmpt?=
 =?utf-8?B?UG14bGE2Q1JSL3I2VUR1b0t4SndIZ3N3MnNNdHBmQXVWRFZlcnZoay8zQnJm?=
 =?utf-8?B?OW9CcUhUV1ZoL2lWMktNOXRKNC9hZVNaeGwvNXcwWE9EaUdiMDR4dGVFc0pY?=
 =?utf-8?B?aG5td0Vkc2IwdTBodlFiZjdnbVFvU1cxT3BaUWVacWJydTBlOE5tRXFFZW5X?=
 =?utf-8?B?UU40d3UwUlFFUDVKYU9EUkRtbEZvV05ZODkxNlpZWUFNQVlZT2IwWThwWUI4?=
 =?utf-8?B?akhOdnhBNHkrWGpyUlIrOWorMldnY2JJb25jZ0tKUHpsbDdZQXJGWm5ScEhp?=
 =?utf-8?B?RGd2a0tmMmkrU2Z5RlI0Sk5rTzBWbThyLzVvZ1RrT2Vka09zVTBvOE5vZjVN?=
 =?utf-8?B?RThPK3RZVkRsMFZBMC9mdTBsZ1hwVEdhNlg2b1NQQUgwbnZkRnVWMkd3RFE1?=
 =?utf-8?B?TUFaY21SSUF4Vm44Vk1TaDlxNWFIUHZZTW5zWjdsVlJoSy9BS013QUIzNk5p?=
 =?utf-8?B?VStjSUNpUDBjanVveXo4czA4UWZ5YklZZy91SnRLY3d6eDlMbHkwZGRtR3pO?=
 =?utf-8?B?VStJVXF1cGNmd2JiaEpLc1NkaXRJUVhLbm1MdDNzWittWUw3TVJSRzZzVWFF?=
 =?utf-8?B?QlIybWFobzlKQ29Qd3VocVdYWmF4WXZ6OUs2NTlST3RGeHFmMGVGc3I3bmNJ?=
 =?utf-8?B?UzhLYlpwWGVpd0FlODRHM0tXQXF2blZncG5ZamdaT0tHK1NYdEpHVFpDbFFO?=
 =?utf-8?B?aTVrdTRvTndhcytHTTQ4S3huTStCSDBhV0c5aEsxN01SNGRyV2tDS3hxV0FT?=
 =?utf-8?Q?/BTX6hteGGOlqw+LHEk62t/Yl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7236897-b78b-40f6-a41b-08dbb77b1db4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2023 12:39:21.1178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdL2BZcfDVug8GuP8rVjndzkqIeOFz33eUhV1xnz3Z8qWkeuMgJqvJQYJ2qTgTZDViMVZF6ykvtVldKBU9/KTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8928
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The Message Unit(MU) General Purpose Control registers are used for
TX doorbell, but there is no hardware ACK support.

The current TX doorbell channel is using tasklet to emulate hardware
ACK support to kick the TX tick from controller driver side.

The new added TX doorbell channel V2 not using tasklet to emulate the
hardware ACK support. The behavior for the channel is just writing the
GCR register, and no else. This will be used for SCMI mailbox.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 3ef4dd8adf5d..0af739ab571c 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -20,7 +20,9 @@
 #include <linux/suspend.h>
 #include <linux/slab.h>
 
-#define IMX_MU_CHANS		17
+#include "mailbox.h"
+
+#define IMX_MU_CHANS		24
 /* TX0/RX0/RXDB[0-3] */
 #define IMX_MU_SCU_CHANS	6
 /* TX0/RX0 */
@@ -39,6 +41,7 @@ enum imx_mu_chan_type {
 	IMX_MU_TYPE_TXDB	= 2, /* Tx doorbell */
 	IMX_MU_TYPE_RXDB	= 3, /* Rx doorbell */
 	IMX_MU_TYPE_RST		= 4, /* Reset */
+	IMX_MU_TYPE_TXDB_V2	= 5, /* Tx doorbell with S/W ACK */
 };
 
 enum imx_mu_xcr {
@@ -226,6 +229,9 @@ static int imx_mu_generic_tx(struct imx_mu_priv *priv,
 		imx_mu_xcr_rmw(priv, IMX_MU_GCR, IMX_MU_xCR_GIRn(priv->dcfg->type, cp->idx), 0);
 		tasklet_schedule(&cp->txdb_tasklet);
 		break;
+	case IMX_MU_TYPE_TXDB_V2:
+		imx_mu_xcr_rmw(priv, IMX_MU_GCR, IMX_MU_xCR_GIRn(priv->dcfg->type, cp->idx), 0);
+		break;
 	default:
 		dev_warn_ratelimited(priv->dev, "Send data on wrong channel type: %d\n", cp->type);
 		return -EINVAL;
@@ -554,6 +560,9 @@ static int imx_mu_startup(struct mbox_chan *chan)
 	int ret;
 
 	pm_runtime_get_sync(priv->dev);
+	if (cp->type == IMX_MU_TYPE_TXDB_V2)
+		return 0;
+
 	if (cp->type == IMX_MU_TYPE_TXDB) {
 		/* Tx doorbell don't have ACK support */
 		tasklet_init(&cp->txdb_tasklet, imx_mu_txdb_tasklet,
@@ -595,6 +604,11 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
 	int ret;
 	u32 sr;
 
+	if (cp->type == IMX_MU_TYPE_TXDB_V2) {
+		pm_runtime_put_sync(priv->dev);
+		return;
+	}
+
 	if (cp->type == IMX_MU_TYPE_TXDB) {
 		tasklet_kill(&cp->txdb_tasklet);
 		pm_runtime_put_sync(priv->dev);
@@ -671,6 +685,7 @@ static struct mbox_chan *imx_mu_specific_xlate(struct mbox_controller *mbox,
 static struct mbox_chan * imx_mu_xlate(struct mbox_controller *mbox,
 				       const struct of_phandle_args *sp)
 {
+	struct mbox_chan *p_chan;
 	u32 type, idx, chan;
 
 	if (sp->args_count != 2) {
@@ -680,14 +695,25 @@ static struct mbox_chan * imx_mu_xlate(struct mbox_controller *mbox,
 
 	type = sp->args[0]; /* channel type */
 	idx = sp->args[1]; /* index */
-	chan = type * 4 + idx;
 
+	/* RST only supports 1 channel */
+	if ((type == IMX_MU_TYPE_RST) && idx) {
+		dev_err(mbox->dev, "Invalid RST channel %d\n", idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	chan = type * 4 + idx;
 	if (chan >= mbox->num_chans) {
 		dev_err(mbox->dev, "Not supported channel number: %d. (type: %d, idx: %d)\n", chan, type, idx);
 		return ERR_PTR(-EINVAL);
 	}
 
-	return &mbox->chans[chan];
+	p_chan = &mbox->chans[chan];
+
+	if (type == IMX_MU_TYPE_TXDB_V2)
+		p_chan->txdone_method = TXDONE_BY_ACK;
+
+	return p_chan;
 }
 
 static struct mbox_chan *imx_mu_seco_xlate(struct mbox_controller *mbox,

-- 
2.37.1

