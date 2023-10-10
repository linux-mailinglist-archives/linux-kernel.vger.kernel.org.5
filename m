Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5328C7BF6E3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjJJJKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjJJJKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:10:05 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324DEAF;
        Tue, 10 Oct 2023 02:10:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRdV+Cw653FxZ5HbjNfACkpyXv5229Mq0WycW5Whz3oV+7g56wrZMSbLRGFx+qUm1p1bQS+pNcbLlkPklNVzCnTCSbfgc/8KkkQhINLqtwNcLGRrrP9RZqm62sI/PsZZ+3aRf2dWhraKwKrUpE+3URdTCoGjDA1U0IMWKRUpVm0+mjoyfKeRtf6Ek17nm3gkJl7pUFD3CvFBQHXLV7A7N+uUoX+3K76QaF1kmukfN8nzSXHpi3MQKycz0C2km3nL2hS2Xb3XYHgA1uUzPgW1EOQs7yoZ/lCKb/sTCuYvy0bs0gRxGELaQm1rmLbjqYmvP1tIibc4s/GNASyB5lHRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZnE45PRDwBSn6WJdsVneYnerLDAT9Dwn56wCg5jqs4=;
 b=iqiVMEYFegZHGZzR3d4T2RCR/KaUzla85zx9p9Bczi4odc1XsqbA8IYlU/1RlQIhUJN8TMUTweubKq7eJhjv1aAAc5i5JwFUt+X+/WpWFCEY3nRiWt79WOC2x+43nmck1paTzJekzT4PyPGTsrV4kihmh4rMPKZedvFy2iW246GUs2p57jeUkl/9IcFvLKJgV4re3lurXVAV0wnJeic0SfacgVZ2nXbugeND0Oj6kRNVeW1dN/XG/6vVXiMNpTvBbsQuHUVo8/Pa7IinaUPwF44VPfqMOoTGCHvCfgZsgXUfUWBBaSbLjAQ7yyAlURbFoy+TCB813XeyrCAkH8YqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZnE45PRDwBSn6WJdsVneYnerLDAT9Dwn56wCg5jqs4=;
 b=hB+XaabICeWW3cBW2PRPsCjnVMSHZC3NDqpdFD7NZdQm/WkRUrLuI0+873VhcOUYpAIKu4VKPQAYYmZHC4eyME/Sbs114Z4DadzJiQ0jC1YrjVywZ+0+AQkPpCqdVfv7UgdoMHfEP8OJ4mo20Jqaa/5UGOMvEOa162I8f7KSf2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by PAXPR04MB9059.eurprd04.prod.outlook.com (2603:10a6:102:220::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 09:10:01 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 09:10:01 +0000
From:   "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Subject: [PATCH v3 2/2] arm64: dts: imx8mp: add reserve-memory nodes for DSP
Date:   Tue, 10 Oct 2023 12:09:29 +0300
Message-Id: <20231010090929.4371-3-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231010090929.4371-1-iuliana.prodan@oss.nxp.com>
References: <20231010090929.4371-1-iuliana.prodan@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0054.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::14) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|PAXPR04MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f223e8-63c9-4a67-79a4-08dbc970af1a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4xBLlZgincrbxggVIxp6JUNuoDOWVj0ikMjAIC/PuBMm+SZOb23yWYJnYUdWlTTq0V/V5YKiT1MIDFP5/gj4Qgd+0/g0UnX3+byvOqazFwQ/h8Q1yHNBNXAKsHX7k2fk3h0KhrQ8oSYT9YhDLurDnfmmgGTQypCnlHxs8Lwukqjt4tMzBXK5Bd4G8y1sa+FXpuoNGWdcMCLQbseQQ/xOtiZfyaOq0CnEGzfgbOMBUt9wRgNfQ6pwx7W+DLq77VqXfLRWt0YIzwkTWFfv7nPdRcGftkNTalE83aoKqnbiA1sNfL8EF4AYS9hSeOUjYzuMFvyqCcxx+Fu2AYiQrZ3fYSQ+G/y0nGxua5fAHnqUv9+5/A2nfJwiXnpP44WVy/uaWIpwzw9fEwTRdjutTolSzp07gVXDYpwyI1ZTnguoQ3x50Mi/Atq6IpGS5i2mVZ9QMvgP6mwIwTil0yqYyNqnQfJBme5DAm03BfLNE2ksITK95EZoOGdkqKRJjCFTIouqjocNJOIJES93vIRQbJXL7g8o+Mut6c6hYSgf0B9Zd5IB+FnnkfDDvtbl1q9iE+XikuyI7byU8ofx4PtTEr3ifUf/MPrtscEdboN0pLR9IrJ4Pl8k+iaawHIY9nl4H6Xz4IaUTLSUg3ZItJWccuHXKWlzGOiRqWAp94zKx3Q9bY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(921005)(86362001)(38100700002)(38350700002)(2906002)(52116002)(478600001)(6486002)(41300700001)(6512007)(4744005)(4326008)(6506007)(5660300002)(8936002)(316002)(2616005)(1076003)(66476007)(66556008)(66946007)(7416002)(8676002)(6666004)(110136005)(54906003)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3ElrJiU8sEUHNL4bpsm26LTgEEMfTFMSd4z0vZW27ptK4LwEW9D7np3mVmhP?=
 =?us-ascii?Q?PI1vRcskUslHId7+0fr1TtlWDW9q7ff1qX4A4nMe6jvDasmprhuX8injT1sS?=
 =?us-ascii?Q?VaLxdNOqeY2m4vdoHMihKVhcKtCjvNs7BvCQwqfTsQvyAnQ0r7AAC5ltBze0?=
 =?us-ascii?Q?Mpwy5REEs+URWYVm4pOg9R8mm8VYSm/UrGUzvVpjAMbfWhKOFx87eh2rAcqj?=
 =?us-ascii?Q?eQtoVPP0yRkF6/RsE8FuYUztBJ+o/8/JJDtWJngxvttyS8kzqagNVOxiRvHr?=
 =?us-ascii?Q?LyVPLEnfloc2ThBdv2dIkuwsypqLMZ/Wwe/1dbWFSZBeditdMJqdWMsMJNdw?=
 =?us-ascii?Q?7xkjypWnjX/AyuQaioRDECX3b7Bc9x9wZPn5irOf3jCFUX2a+kGr96fh+Aw+?=
 =?us-ascii?Q?PdMcUnbxlyO0y7KcrH4Y6sAy4nSNixaZDD380Pe7Ntd5lyvHF/weyRcyLZiJ?=
 =?us-ascii?Q?BjpuOuBDxjbPj/GjwKkvDl1G24w1I8O9PdyOFc5XqNNFsD4i+AYSEsQH9hlO?=
 =?us-ascii?Q?HPf6tU+UGKKjSurVSr8CTCii3bt+IbHToI/0AQwSzr8w00+PAB/vQGkDwK3I?=
 =?us-ascii?Q?XaJbSg6qtHiGh2ifqwdaFs1PYA2xSLfdOUop4av+LQ5cRtZEm0a9RszaZO83?=
 =?us-ascii?Q?jPOwQ3o6nTwxJSb0kUBi1HfXiyMOMajemB5cdTMK9PXIxOkRmQm+8JNFlWdQ?=
 =?us-ascii?Q?v9mjEt4lsxy1hYk5Qef+mFncaOvGElpLS2FaCgFddlCgo2cAeHHM3146aRP5?=
 =?us-ascii?Q?YWJ1hCdAq0ihgbdzEXkWyf+9EJ0iz1BmMX9n1KQvhMuhyd3hHTOJofPKie+o?=
 =?us-ascii?Q?spi4ZPy6EH0VgmP7rNVUBv5IC7VNqW8WvGpMG/6IxjVchCBMVKABehniJ7U1?=
 =?us-ascii?Q?qtvtqW+wThgEUiqFELsJXR8gAtATqVVtqdc9sOf9zow9AOCbmP1MiBgVzUyl?=
 =?us-ascii?Q?ssyelIxrYBC9Zo7KFvfyvkQ1CUep4HwTIOyqgYdX8nzbchSKU/yaxVe7mVCP?=
 =?us-ascii?Q?EQ/BLHIaAOLEFN5pOr57iZ2AaOHU468p2vqNaSJ7hnuziN+jzMiyMw/vEVqs?=
 =?us-ascii?Q?VP5w+d6eFy16soEzTlPWPubCSweQPJvzny+ni0KPcnWuAEGb/og0dO2mYrrj?=
 =?us-ascii?Q?fN71f2gDyFjnEiB+o12UWeujykTfE1f9+zlwFfhRu97SUVwSDkKP3C5VtrhP?=
 =?us-ascii?Q?QzvumE/edwoRKh95ttcbmAOHGQbR4/NqqA/b4O3/rUW6TPUSoD+c+pMtMr0G?=
 =?us-ascii?Q?yIhx3eI3CBODWZO5HEksNtBNmJuZkuCHEDOpJnI2HB1W0oYfx8tTPq0zZf9u?=
 =?us-ascii?Q?giM2bdBrMG1ifjYjpXTJ3gYd7ck2ROEB5IwarULZHtQONI+BofUh3ONdn/j3?=
 =?us-ascii?Q?ViGENv7CM43tT9C1bynJ9EB/XbiJ29GCh//Km3YlkuP936cfi/Jleg6+K3/+?=
 =?us-ascii?Q?ehN4e2SkUI67J2lUvVuGNZimJcvhna5emEcxIYxjFg+Muh4tg6Ex18/JHAlk?=
 =?us-ascii?Q?e2an05JF30tkz422uWCtblGqxp0BvshHNwiJ3ta2IjiYid5Rc3mBcnVrGSPc?=
 =?us-ascii?Q?mblBq1bbK8GC4inVeB80VziCibtQlyYD9CtJqFBArhDUpe6m4kwso5k7bxPL?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f223e8-63c9-4a67-79a4-08dbc970af1a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 09:10:01.6119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uc7gdiWdT3hnqZ9L7saUvPdiRCsCNF3O3f/6qhL9BC2gS214YCs54fYWCE8eUGLipcoxTKgJidgNzZOnhHJBDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9059
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iuliana Prodan <iuliana.prodan@nxp.com>

Add the reserve-memory nodes used by DSP when the rpmsg
feature is enabled.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index cc406bb338fe..22815b3ea890 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -211,6 +211,22 @@
 			reg = <0 0x92400000 0 0x2000000>;
 			no-map;
 		};
+
+		dsp_vdev0vring0: vdev0vring0@942f0000 {
+			reg = <0 0x942f0000 0 0x8000>;
+			no-map;
+		};
+
+		dsp_vdev0vring1: vdev0vring1@942f8000 {
+			reg = <0 0x942f8000 0 0x8000>;
+			no-map;
+		};
+
+		dsp_vdev0buffer: vdev0buffer@94300000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x94300000 0 0x100000>;
+			no-map;
+		};
 	};
 
 	pmu {
-- 
2.17.1

