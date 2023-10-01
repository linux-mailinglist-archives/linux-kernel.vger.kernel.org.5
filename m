Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FE07B4752
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 14:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbjJAMWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 08:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjJAMV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 08:21:59 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2078.outbound.protection.outlook.com [40.107.15.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B89299;
        Sun,  1 Oct 2023 05:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRiZB9s3Ybc3U9hhS5zLrA0kjXautFSjmB0H/ssjGk4MrNmpDm5rTjADddS41UWy0iVsAQkku/32+Sg5k7KxboOE0rbvoth8Vu35c79mBmgrOGNbYbn7Xizx0PyqmlEbPP2SlpscS9UgSCg2RYIeG0nFw8XTii1exASSApoWkCXPPYImM5wzyQDcomwiWCai0s8evYLWc1bKpSNEHj2oMuVFNodIu/0t+1wCZxuAbutFfKWBvxQSqzu9ZC8KE6R5yl8LTRPRlhoNeHv/xEnGGNEW0yBEAZ7Q0e/eDL8sjmjx8/wn0XD6e9equzApPBjoYibnqyqAZuE3dVEi1MrRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfQJcy8EdHtsnc4jSS6xvYlLKrQT579jr+u3bNKwCv0=;
 b=ODJV5NmNJAtPU5LWOTef6Pbb7smymtp3Oegu0vSGY5k5FhzL4BTH5h2JSxg7rrVfr+iVRi7J+6QzrDSppciPyS/Z0uSxYxk3mz5rNc9obKIJWW1o5qO+J3QFlJgOS1F/npJhRdTOw1Bujd37eRi5TSwTD9kDGPgQBdLcV5x23Ky2YTSIxYJrgx6Ldgl3IQboiKbmbZRjD6cyFNjywnfNe+gy/uv8PtsLeV0hoqVZGG88P/r0RaI3T/VOTyfbqpb8nR1CxzpTHZA37XHeASXcV/rAEPOFEYNddeGOmF4AJv6vP/Y07iXBdvk5soi7GO7Zjvzr/Afu6zZzRyAKfl5cEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfQJcy8EdHtsnc4jSS6xvYlLKrQT579jr+u3bNKwCv0=;
 b=kURuGhevdE4Ii95ifUB10jc1tgCDQItFQLt9Aj4tffdPCnTb5bEQCyHV5fC/LERFDy+TrKp4TeB1hl1RJCXhq3KsCWsZNbbsjjWzAnBtKYvJTqvxe3VMTywHAn3j8M8ukSsg1uxhEcZcCLwxZ5aAfHjPnJiycNdWOCp6THdOwHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8959.eurprd04.prod.outlook.com (2603:10a6:102:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Sun, 1 Oct
 2023 12:21:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 12:21:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH] clk: imx: imx8mq: correct error handling path
Date:   Sun,  1 Oct 2023 20:26:18 +0800
Message-Id: <20231001122618.194498-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ada38fd-93af-4e1d-0faf-08dbc278febf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uWknrcYvpfL0435a6sGk47EZZXbh7IxXs28DU8azO6YInpIZp5fkYiKO0G8TgxcG6lfUswuEwV7zu+8x3oYUS72eXJaBfbMU/4F55Z5TJBaBIFDT+VhWwanpUpfN5TkfEVB6mPa63EobJVMTIKMokR4C7fzQyuEBAmuangn87iL+OOaK/jHdb+gTLesxkFuuIchGkOEI6QbsvTe9vmtdRBkovLZGVRhuxMvt87lie7E0q94sXJSXxvQprs+Wq3IJSCAZEFYon6WbBbJllDtAB2SoI2b4I5VYAPCZhH9prG2CYQ0Z30pShn/5jf6h/pnesDuwKLV1jIs21qMtExU+y8jrlIiR0dtHHdLy2p6ncWPAOLD2xKFSmvAeXGLs6ST1rfmOA/cwsopT8Lp+gY+RdPTSeOfYYqYY3cT8NoNYUzwb5MW0qqd//QcHYsZYQJX6eEAV7hcQ/42TJIUqtqA/D9DKnL/T4HwnEsZ5dunRbVVTeZctkPvoP6gOAKDDuevSUM/v2DYWPdUYfet+mIaCq9WaVihjZu8u21pQXQrn9rsnTw10NgV0ZBc7OSU0TBWAXA04FjZxETAoegXteibMIesr5u5iwU+H98DtagiUOYWuBMMJwpj0V4wfpXJAio2t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(316002)(966005)(54906003)(66556008)(66476007)(66946007)(8676002)(38350700002)(41300700001)(38100700002)(52116002)(26005)(6512007)(478600001)(4326008)(6486002)(6666004)(6506007)(83380400001)(8936002)(1076003)(5660300002)(7416002)(86362001)(2616005)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ehh+D3Q7taAe8SuihKpHi+VKWd4fXPu/oClLKyGZuapERDkhkN7vwOLZe7nr?=
 =?us-ascii?Q?74R7FC6n/KHopp3T1PgPeIr+R6Hn68/OPNb7xo2oMyB+uU3AKRVU8kV+oFNI?=
 =?us-ascii?Q?IcP1Zp7FmqnfpRuxeN6jcJYye45Bub8btpo4lJQ2RIS1GJ1ZY/6bzv4IOjxa?=
 =?us-ascii?Q?HmrgBWwpjBCOFSxhMUFaoFyCfDuN3SLdsW1B2N+pz8JaNRqZD2AQvPNh8vPZ?=
 =?us-ascii?Q?MKgrAzG4OosjUBYPjuQQf8sQI5zmnM1AOO0xZNNir8AK7GAQlRr9ILbHDhHA?=
 =?us-ascii?Q?orTycTJSW1JBREDu1C0NYNtf4QBPY8yzjW/zkLUuxhaC33CQLw/Q4upxU7uO?=
 =?us-ascii?Q?D5MYbUu62BSQLMvfs8NHgrafcJAsJBb72qVBKG/JvvGwWMSrQbGBdhwum/9H?=
 =?us-ascii?Q?ElrtmqYGzlP38vN/45CzaqIFRmZVsEhvX8JypnitFE/To9NK6O6Budew+NdR?=
 =?us-ascii?Q?ZP+gEM/Gs1nHlVUy45TW1dP/CiEkPX6NPbqDmOJF4LHWiKe0Xv9mlQSx3oPi?=
 =?us-ascii?Q?9Sw15rB/ITlSZGa5hkfon8M+ehdUjagsadR2feCD22G4FOu/+Qtq89goAOsf?=
 =?us-ascii?Q?eogHADAsp3yYfRgVvWGmiKbmbu9Rryrcn7FGSA953cJ8JCrQA8OUEwLUVHmB?=
 =?us-ascii?Q?Faw5mS6oFseZ5OAZCSliBHds4oWvQlh9XgCTYIyTgdyw7Z+7eLRy7/B2hnpw?=
 =?us-ascii?Q?y9tru5h5De4Qpj5pmR4knfI4czcNz6mf9ZlG8kP7vGCaIqrv2vL5dp/lMH4L?=
 =?us-ascii?Q?49DCtWr7Xr0zm7AQwm08XPJyVJPI3GFfGgQQ9VNLbkSO/JB3L5a0z0usQlLA?=
 =?us-ascii?Q?fn+3cS8unxHT/MvACLfJlalzIzuuJOMCwlG1OzvBp56g8r1ndC4rI4rnIK7Z?=
 =?us-ascii?Q?eFnyPa6b0lAeo1fxDO3b6ZqhmruV0dTULHnPzC0UqV/hY8sK8OTYBrFFQflp?=
 =?us-ascii?Q?9Ut+G/eJlLleAUA3K4wNvb/vwkHyB05onYKPdXaxPXULU/p1y8YtFrD/Wj3l?=
 =?us-ascii?Q?BOPe3sxYT2GOnDx+e+ZkDGNG269KwbErWRoBSAOODA/cgOg074FEwKA1gv1z?=
 =?us-ascii?Q?UQ92f6WvNmYVE1adz6s0mYyxp1yaQp9hBYRdkwkgO0stQp7XyUj5HB6FGbZY?=
 =?us-ascii?Q?MbpJap6dBq64WcE6MJWNO0MdWVo0RUcGfCY0OMG2dgAyhgJOSBE/XygCoXXD?=
 =?us-ascii?Q?PV6BDVvTHhlGtMxQbSSB3RYSRmz8HigugfzhaqZNlndzloicImRRRpiiMuYg?=
 =?us-ascii?Q?MUmBg/90en65aJXdqlteJhwkfaJ+ZNHU6UxYH9+IYWb8doR3hFZjxAkvjPtR?=
 =?us-ascii?Q?RVEVFEkI+2QvS2HAZTvq1FHBT//UuQ1odcyp9/ilAvBhJsOhrHVIItAfrsIT?=
 =?us-ascii?Q?nNPtzhsnm6fLl+j2+vIPHKwc4Wm8Pur51H2+gQQywnIGvLoSlZxkffF2t5nt?=
 =?us-ascii?Q?zTd34hLVp7ApI/yehA05KDCdTonM+uC2rPLF9f1EQcNNZkEh17cjhJcL48f4?=
 =?us-ascii?Q?Zf2LS5mYIf0LoY0UEld135YVH9dje/41phpen8HvTJIw2OlwXqC1M2NCNk0n?=
 =?us-ascii?Q?KjoT6eVKAf/rq6+1S+MWBTUt4lcFydHMmUz4XY7p?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ada38fd-93af-4e1d-0faf-08dbc278febf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 12:21:53.7599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DWzG5N+YPM9cU6KaCRRuF05G2iV1IEYTG1fdvdomHWdD1GHmS1Guo+lYkSpJbChovzfM5s5oxyoSPKqafmTDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8959
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Avoid memory leak in error handling path. It does not make
much sense for the SoC without clk driver, to make program behavior
correct, let's fix it.

Fixes: b80522040cd3 ("clk: imx: Add clock driver for i.MX8MQ CCM")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202309240551.e46NllPa-lkp@intel.com/
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mq.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 4bd65879fcd3..f70ed231b92d 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -288,8 +288,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int err;
 
-	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
-					  IMX8MQ_CLK_END), GFP_KERNEL);
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, IMX8MQ_CLK_END), GFP_KERNEL);
 	if (WARN_ON(!clk_hw_data))
 		return -ENOMEM;
 
@@ -306,10 +305,12 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MQ_CLK_EXT4] = imx_get_clk_hw_by_name(np, "clk_ext4");
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-anatop");
-	base = of_iomap(np, 0);
+	base = devm_of_iomap(dev, np, 0, NULL);
 	of_node_put(np);
-	if (WARN_ON(!base))
-		return -ENOMEM;
+	if (WARN_ON(IS_ERR(base))) {
+		err = PTR_ERR(base);
+		goto unregister_hws;
+	}
 
 	hws[IMX8MQ_ARM_PLL_REF_SEL] = imx_clk_hw_mux("arm_pll_ref_sel", base + 0x28, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MQ_GPU_PLL_REF_SEL] = imx_clk_hw_mux("gpu_pll_ref_sel", base + 0x18, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
@@ -395,8 +396,10 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 
 	np = dev->of_node;
 	base = devm_platform_ioremap_resource(pdev, 0);
-	if (WARN_ON(IS_ERR(base)))
-		return PTR_ERR(base);
+	if (WARN_ON(IS_ERR(base))) {
+		err = PTR_ERR(base);
+		goto unregister_hws;
+	}
 
 	/* CORE */
 	hws[IMX8MQ_CLK_A53_DIV] = imx8m_clk_hw_composite_core("arm_a53_div", imx8mq_a53_sels, base + 0x8000);
-- 
2.37.1

