Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71873772374
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjHGMKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjHGMKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:10:13 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2085.outbound.protection.outlook.com [40.107.13.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF57E40
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:10:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7PZQ0kJsM+U5tydS8ITpxYbrUs6Ix7+kCemnmmdA/z5FX/c5p0Q8mf6HaHeIV7lBQoqx9qqVvuMDp4mmaZO2qOhedovw0yNUy9sKoPKOJ5jggRR8/oKJSH1vK7BBVRwVT/zy7P/VkXl+2AQLoz7qPq4I3KSV0Jrzmw8HX4NF/4NqilRcxqZ5Tw+pjcO3EQfVJOSY139UEdSUDnqxYR30HtawDqnrMPSlgAgmBadLHQtaUvJY6XbFtncYmpK8Gns9AfF//cOWnoaANn44Q/TwVbUmtTMhzo/vA0zFd7NNGhEqyglmGVUXR/VfHhIQtO+tma/KLXiTJBvX4nlx27xcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owtlCSHE0pv7sJqAQSFA622fQZA5HRdQPwaW4Xv/N3I=;
 b=irQjASHHxNgRlTm0hPSvz+xwOV6ejmLCDxy23BC26vyhy06ZepVDak6HOL0wKTQ2whOPZ8fHgYrvpXlz8SpLSOJIA130oecByZkMi3XoEwgP3ZJzi6dH8h4LzdV0AMOq7dz9G2BH/P0mYToiPcyi3PzVkfnz+PKar/DuZ+6SGLX7EwDMMtmDkwe0uU7WBF7BIyzqQ6t+ogKF8QM1gPKSdAxvN5Wukauwad4IYybg76zPngA+tGQaNvfUkuHjH/GdV5GuzXaCoMyU0hv4ZM8j8HqU/YJxAHK3/pdoNpn0w7DXW3C9muuXPqGldKz8rn6nXmhs8qWoh5RmWBxsmWHX7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owtlCSHE0pv7sJqAQSFA622fQZA5HRdQPwaW4Xv/N3I=;
 b=FKzhg3+w/iiQgCC84yXO3Idrnb7gY4Tu/T7FZ1DMtQfjrJnomLu8r33QzkHs9DdluK2Q099HXx4BuR69yXQErF0sCjbOh21E8mtY8Eppk2l2h4ZzVpixI+HoJ9s0fXJ/rSr+fxulPsjM6hjmNYsQiSeKbcLSjJBZQLXYp1sVlNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7261.eurprd04.prod.outlook.com (2603:10a6:800:1a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 12:10:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 12:10:04 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 3/8] firmware: imx: scu: use soc name for soc_id
Date:   Mon,  7 Aug 2023 20:14:27 +0800
Message-Id: <20230807121432.3970610-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230807121432.3970610-1-peng.fan@oss.nxp.com>
References: <20230807121432.3970610-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d814bdb-169a-47b6-9d40-08db973f3bc4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BUvalHzviW4cbZu4Kv68dVTmd9xqOSD0DjJcR5QJjBkjKHWMLyQb29nhaYRHgTcKI35Mrm3GCg0CxgO2W3Yta/bv8pAENRmW++0fASk7hjSz4DyvOi6dkTGP2Pr/2POy9ekFckLt2nvckGoMpj5s0Q73swDmUvkIdN7xQIct8dw7jnE9LYDMIKJTMdsZzJhrFsgkllcroOlcfO6qpgQUFqlU2w1nu3OjxF2Whs/3xJ53TjKQ6AgKR1pbpAZ5c7ink8IqSBEbfWG85WobAhSeiZK57OlMByXiE7zAVOX+Gw4lvzrsxJPqFT3NVpQrW2LQy4jBLVuFL4T6z2WcpBbjvQBUgDei8PoQjJFFSSOdkMTL08Zdm6VGPSNOof0YwMTIjxgd8ga5z52mURZhcECz+nBNXmxaCBws2PImkDhhEGE/jObGMnqEK4t5W8f/wz5w/QU4wQMiMIIbbfV1yNGL01Aa3UEbk/UUskTa6uWsN+5Uu+50TPmEITY6suTXBg+TF/gUUFYBd3A0brRvC/dzrJELQ3f3ECasqgUiZdWfUMf6KpRyZqcwz373aNioFFARXUjBv9rEbmnyQazQM4EWUQnBad8p++55hxrs6QX629AzK7naC5UIq9tqhjytnPos
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(1800799003)(186006)(6512007)(26005)(6506007)(1076003)(38350700002)(38100700002)(5660300002)(86362001)(4326008)(2906002)(66476007)(66556008)(66946007)(41300700001)(316002)(8936002)(8676002)(6666004)(52116002)(478600001)(2616005)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LYJhXqNs04++QnDWKRxpPpROv6y7dYps8K9ytZBaFvn3szNz3bAHnum3usTx?=
 =?us-ascii?Q?5Fdc40y0rhGwVo20LI0lacUSXrk82v8ROooShPJ7HTY9C29XzLb2o2hbD9AL?=
 =?us-ascii?Q?uTwNyl0qXqPXJRX4k0W8GobTG5NuMQowlQSi9ImM5E5hcziV7t2ek8x82C69?=
 =?us-ascii?Q?f08cBXmWz5jjqwqRdNfL37zVoSNDUniV8hfe/Jt3Kyhl8aeC3USV5l0THhAx?=
 =?us-ascii?Q?epN6jlQikVhO857hZXmt/7vhd+pVwN62gG0Uhdxsyv14gjsKavtw8QtDRF63?=
 =?us-ascii?Q?MgLaNsIRFwlbF9OI2Py+nI3s6PqdFVdWKKU9RFYXyW95Bc/wKtDao9IRg4aD?=
 =?us-ascii?Q?5zClro+W/YotFxIWSVGn2/3Eq5cEXeJcQp+92xMhLz4sKyJKxRSsyScUrXKZ?=
 =?us-ascii?Q?Bl8tKObrjPLqYyK9/OfK9aEY5CKzK0hE9j7h4vhMhSkwCkuOsumpaoiujBH0?=
 =?us-ascii?Q?p3b7CCy9+B3LhiA54OhFhlxHdAJPv+eo8g3bSaUf5vGNCvL8Ku4qil0TgQWY?=
 =?us-ascii?Q?1z1iNIMjAnYITvUIYMCyGOmcRcDQq2DlHeWxu1vrynimEziHVsS+Ab5VCo6S?=
 =?us-ascii?Q?/OmSxi5p8hCGo8IQGYGJUNkDQ6fYkiPz/ikdhLUCOhCo4KpupHiBxgujjJlE?=
 =?us-ascii?Q?9R1SdF5t/jSUONted1nsGuUpBko3imxwz2AtpctzgKnDC6Nx4wn/kYldatXc?=
 =?us-ascii?Q?lJMAZ8datjLiozy8oQwaz4hqFwn7qkBGkqn/lfYlDd63ibVZuzE62/to3Ofq?=
 =?us-ascii?Q?rCSjT5thSv8CHR2bCnEeRLfVWCl7kAP8ggnIxKXCEozJCLY/FUBpWUD65FBe?=
 =?us-ascii?Q?rvr9r+tN5PVaaW8w0AKt0SYJEGUlySBu9s9vTR/D4KV05uErspN6Hn6L4La8?=
 =?us-ascii?Q?tLIdYq8EKhWYCuyPPSfceCBvdhUxxSrQC/rVHNktizICwTIRVrNEGuKxYRcG?=
 =?us-ascii?Q?161TmxZz5NpzbOV4PBvhzHzBruT6CWSsijeu71q/VJA/7z7MYUDYY9VuOZze?=
 =?us-ascii?Q?KJGRpxyMxGcnxquFLU/8AANwlEtOrvsOaoOyfmY/gTVJU3XDebADv3QqlhvR?=
 =?us-ascii?Q?xvpObCKQ9UCsuBqPuKdsrhxEorsUn1efJ4yd5NhrYpKUci0HeXi7B5sjoQxB?=
 =?us-ascii?Q?UP0aV8F7z41RdUxUcmmWiObmKa9gJne2eZUXFWU1ZkAcTvM1JOhXkJtPInVS?=
 =?us-ascii?Q?tFe7MuPG+E60qb0dI+SKnD5bQGAAsx8IHhtjGyC74AvCsG036RyQnTNq7CCl?=
 =?us-ascii?Q?UZGemgz68SwcZYYr+IEonV7i8VsdxRm6vMk0QzbVU2/JEuCXOWkvQ3rilZeK?=
 =?us-ascii?Q?goN8NYi2NWaEabuOvhz9JVe8eP+z5Km3kOzeqgEQGcTZ6zW7LW287998Mwkc?=
 =?us-ascii?Q?jyVA93hJEbkBTHZizc/+5ZG2DuA/nR/SZ4A+vECVrR7dpn5Fl6jI3iahaOdp?=
 =?us-ascii?Q?norYHB2/nSCK6kyNwy1dDm8zW1XuS1u7vWJnoL1Wlc4+qXn54JJkd1ltnkJs?=
 =?us-ascii?Q?cfRNw92ZvMvEwDH5iL02Kl2Frq7xsw+Jfsp+42Ahj5G2d/41c5huEU9mc6ZN?=
 =?us-ascii?Q?RfgzpuM7AXRbZF/Q5sclt6Xz2M7UHQ4n6Kh3opOx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d814bdb-169a-47b6-9d40-08db973f3bc4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 12:10:04.7917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+i31C1ZMP1wKVqQ6ddNF0Yowp4rDjxjlxMMGeJuL1SDDpCIt7p5bvDmRlwZXvUNuHZgtXiiExyQ31do2eUIlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7261
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Same as soc-imx8m and soc-imx driver, use soc name for soc_id which is
user friendly.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-soc.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-soc.c b/drivers/firmware/imx/imx-scu-soc.c
index 2f32353de2c9..497192320562 100644
--- a/drivers/firmware/imx/imx-scu-soc.c
+++ b/drivers/firmware/imx/imx-scu-soc.c
@@ -78,6 +78,22 @@ static int imx_scu_soc_id(void)
 	return msg.data.resp.id;
 }
 
+static const char *imx_scu_soc_name(u32 id)
+{
+	switch (id) {
+	case 0x1:
+		return "i.MX8QM";
+	case 0x2:
+		return "i.MX8QXP";
+	case 0xe:
+		return "i.MX8DXL";
+	default:
+		break;
+	}
+
+	return "NULL";
+}
+
 int imx_scu_soc_init(struct device *dev)
 {
 	struct soc_device_attribute *soc_dev_attr;
@@ -113,9 +129,7 @@ int imx_scu_soc_init(struct device *dev)
 
 	/* format soc_id value passed from SCU firmware */
 	val = id & 0x1f;
-	soc_dev_attr->soc_id = devm_kasprintf(dev, GFP_KERNEL, "0x%x", val);
-	if (!soc_dev_attr->soc_id)
-		return -ENOMEM;
+	soc_dev_attr->soc_id = imx_scu_soc_name(val);
 
 	/* format revision value passed from SCU firmware */
 	val = (id >> 5) & 0xf;
-- 
2.37.1

