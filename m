Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72F1784646
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjHVPx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjHVPx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:53:58 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2084.outbound.protection.outlook.com [40.107.249.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E0010F;
        Tue, 22 Aug 2023 08:53:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+x6h6jP9bAJQ+Nskr58ma7rpX/+HQ0LnYbm/YTh3wUzCZQnmCa8NY/bALIl8ShMGjBKY7HqRJXvoicO+d4laE8rJWKOqOnJqLito87+KIlD3SzhhcNts4fWLCC8nJBh57XcQ9ZQZSn6yODBOUYBEcn18N+Huv07BQX6PkgOSOPvlMSSc6hyLLQHG0fJAFP+4wlnSUt7ig9kK7E9iouEfoLKjGFWFt6wWVti8mbQTg4qjg5jtiEXeaDrC+aAvt2+5EzthC7jy2YyxW5XMKE/yrItm4uVGMd0X/S/bpfw97SjAknmtDMKIqb4zM9PwQMqhOnDKyIMN9YJMMfg5bDm3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bccfioVVypjE98a6pkbIiuO8PgGE7odGpO7RZf/lAAA=;
 b=A+mG0rfqxWxq+8l6tQFx8d60sLF8nXdisazpNI8HFc9ZmPzagkTY3mvPnT2nouAj4fLLBOekAOtVYPn4sX8LejNnZQjxZ0wFb1nCoQ6nRIlXYFggkXy7Jb94KKafLazXP9+1WBcFzftCUNjOUezXcONIdDHWHFoeGw4eH7ZQLT+lZfUM2a5Ij9kpwJveW+tz9RhJU495J0ISfQTWJUd1fz9K7Nzs+j/q1CXUdt6V8xKIAVThjqYSwhsoE4AeC0jdlE9nrYBiUA/8QTNR/dSybt2AelFbKveiWBn7543YELqhTFtFgr8Bx4cEnS8BQpFWq5lZ7f+5XfrgeXmiljDGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bccfioVVypjE98a6pkbIiuO8PgGE7odGpO7RZf/lAAA=;
 b=JynTIQzfohe7nInc83MvzOSDswGzVxAvUagNc5K+rTTfbHnBYfzVZRWxhFwbQcOn9iJD8slwKcUCZB4Fx6sNIqgsZhPucwzKscJacICJDmFgGAwE2NszpCOD2Qd58V9+3g5J8PirTORZFOE+x+rKAplidEr+3igrdaZM6U5J4OY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9444.eurprd04.prod.outlook.com (2603:10a6:10:35c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 15:53:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 15:53:53 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, shawnguo@kernel.org, joy.zou@nxp.com,
        shenwei.wang@nxp.com, sherry.sun@nxp.com
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        pierre.gondois@arm.com, robh+dt@kernel.org, s.hauer@pengutronix.de
Subject: [PATCH 0/5] arm64: dts: imx8qxp add emda support
Date:   Tue, 22 Aug 2023 11:53:28 -0400
Message-Id: <20230822155333.2261262-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU0PR04MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec9cb75-3781-4941-6695-08dba327fc47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PfxPv7kBBcnP9H83LnQVbCG+MTHV0fS34mLY7cOeC5w5aRmr7rbQpL2kescvU4lo7+DRjmzAUG8ENel/gcVwqcrYW84YtiP8u0Q0Z+nLG6hmTKwv5HmmzMzdlAWhRZ9SeztdnK+df35IB52Fl0a0S9PFWFvHvI1t96wtCAPtUeoRkbldWkveHvRHtrMVJgqB/Kmpo01K9zHgnWzfWF8HOY1gBAyAKwmiFG6AUi/MuUK0lHyi5RskrOFrUrdKiVwLKqlBMuVo60h8paD9PnHWN2Mqs2wH91a99WqR02zRC2PXmQtGrwpLrX1+W8/ehmpZuKmjnBI9nmL4u+ufrVPu+5brEZ1jMX5u29M3OXLHNLeTzvHerNcBavWjtg0N5epoLVH942svQVqF70pv1+9/tkY0gY0AaBPnpG31w23uCGTvice0UnHwRXfVoOq+/tS3PzmGRybm6bL+EHJY9OolxOwcR2PY8CDtv6xU6LrAzLmmEm4dk7iLnGfLXvmNeYlXs1HP8fle6dHdpKtQSmlgEE4at2E1qMuiSQmx3OsTWvkQ1VispY/zUqjLeusdJVfkgNyMrDV5UJaClWEP9nbmlyQyCTn6RX9iLMtU1CHLEfJXF+cqpeLKkMOXRIXHDjrE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(1800799009)(186009)(451199024)(66476007)(66556008)(6512007)(316002)(66946007)(966005)(8676002)(8936002)(2616005)(4326008)(6636002)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(38350700002)(52116002)(6486002)(6506007)(83380400001)(4744005)(2906002)(7416002)(86362001)(5660300002)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n0WZfcXh5QkT50nDcpwngjmy5USjmNUFWGQ05aBqFtVcO6HQ5uQVAIwu66rR?=
 =?us-ascii?Q?SD9UUhXNgYup4kzWcdFDQsGfbjxeJIh1u1x7h6MWnad29OKWo7zu2hgFyWQf?=
 =?us-ascii?Q?/Yh9KJlAzOPEGS6j+XqrWK2QIRTwBYFKGP/GQ59WGo5tGEFMf4ZHZ5haUcYV?=
 =?us-ascii?Q?Il/Il+tYxtIGqBUiFA23nlxYKToeOPit5lzo1lqCxwK6ZfRczYMp9rCYBHxf?=
 =?us-ascii?Q?iy11uXMcz+32I61xO7T/4QFXb1fWpCdoD66ZyvGdKQwckinh4bTvsEaeDCHQ?=
 =?us-ascii?Q?vVgMdXehHRRoQ1WXYSm/EgPtcIJrErDxt30aco0XBIkcmQQ3Ms3ShuA6GWx+?=
 =?us-ascii?Q?lPccm8MItEMTmEkB5jWzyM+IC4J8xgDujyk83CyJp9zWY9da0QQAdN7RPezs?=
 =?us-ascii?Q?tHX3LocF4oq17Jbf1duufMGHoT3qm95Z925nAjR2gO2g7m9TLCfvC+JLNDEP?=
 =?us-ascii?Q?zBFc7fsg8rsRF6gf6A+LPYBm2qAkZzfowdgpT7a+WO7yced2wQP1qYwWhW15?=
 =?us-ascii?Q?B02bS3icr8G2b5bFyr5A1UmLXofeEAdY1Xh0o1ciFz6Qoqv9iOkWnsCcNuoL?=
 =?us-ascii?Q?efPxM/5VBeopZkEGPWRlDbM897E+KbGaa6Yz7Yq1IBO+AoZr+ZuB+tQ9Jyd3?=
 =?us-ascii?Q?zKmXCZ8FyvBfVVWUVoKuxUZtmbb0Wn2qkCCcqqZHEg+LsHxODYMi5siHVPkv?=
 =?us-ascii?Q?YKMLRVCSYpvDSOv3ydyCdSOdLOFRwusZYdAGTzc/S5Q0ysV996FZdlSHNmez?=
 =?us-ascii?Q?DYXdGrroEVZL+Aw1RApcf8xNfljxZeNkhURA+Wj2Xt4iArqn5/qtGVAIQTPL?=
 =?us-ascii?Q?gjRW/0ASFOb+RJKVSQ85QWjTV7cez15Iuf8i3ZroMaojjyNR5FXEfhjQ5Dts?=
 =?us-ascii?Q?vUtwVX5G90U6uQSvIvtIVWQTCbpFJlus3DRJ6D+XmF2FkPqt4Y9oYkX/HZBc?=
 =?us-ascii?Q?kJVBp4AKdRwvIgK8bIVR3kHc8yzNjDeCwWuSx5zjDlgp9IUNRCFchUKRMlVY?=
 =?us-ascii?Q?9p4EXKRNAXiIktBvdXb4uMMsu8ew7L/rVF1HmZ5R4tSy270EpIYhVwbf4Er9?=
 =?us-ascii?Q?yegKuYmtwSGw3VOgb+VCfT+3+efsFBZ8XaLGIYP6KX7jk7mQ9doGBivHkTGX?=
 =?us-ascii?Q?S6l3ElCsVhQorRaN1B7g76ZqbjmZV77MnO+TfBLgT1nhhkxI75Isf5Ycj6xu?=
 =?us-ascii?Q?UNMAJLM1LWYyTAMgCbfB4/jQnkbBYnrSFtzEE+juoY2YcHmoxnuSurvnpcp5?=
 =?us-ascii?Q?gu57rDpb/PbLzG9zzhnLzrYuuw+aRgVjGE+5wJJjwCIVBTCCS7VExiQIHYHa?=
 =?us-ascii?Q?K6UIizKVxpMRwE5Dm3diE6LK1g7Rw6KYenDahwaSb8ybCsLklNk218KmTXJ9?=
 =?us-ascii?Q?T0zOASxisiVqRB3/8+h0WSQDA5TRIMbG8QnYPpyGUbmdiYwxItV4QJVJseDT?=
 =?us-ascii?Q?kHB7NWNuBZI+Iaz42tsNbG0WfSPo/uJ/13yJ236GzFVhLW6pJquKj12JsRkq?=
 =?us-ascii?Q?S+P/TOE4wnbZlCJeemX3wk3oHOIzbUgXr8lo6QjfGw6u/XWsPKI3Hqv7BazV?=
 =?us-ascii?Q?qwNTA3sE/itka3DPmo/3S7NkpvbFIz+Kzzl7RMKJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec9cb75-3781-4941-6695-08dba327fc47
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:53:53.7837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7B8NsyLyIlEyybhGzs8lL/WrJqSqhsFCF+IUzAxkxhkXy+S6S2Vm60o7n06XWQyf5uGlcZ4LIK4c8JI143Exg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9444
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eDMAv3 patch was accepted.
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?h=next

This is dts parts.

Add 8qxp edma support and enable lpuart1..3 dma support.

Frank Li (5):
  firmware: imx: scu-pd: added missing edma channel power domain
  arm64: dts: imx8: add edma[0..3]
  arm64: dts: imx8: Add edma for uart[1..3]
  arm64: dts: imx8: update lpuart[0..3] irq number
  arm64: dts: imx8qxp-mek: enable 8qxp lpuart2 and lpuart3

 .../boot/dts/freescale/imx8-ss-audio.dtsi     | 88 +++++++++++++++++++
 .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 76 +++++++++++++++-
 .../boot/dts/freescale/imx8dxl-ss-adma.dtsi   | 30 +++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 26 ++++++
 drivers/firmware/imx/scu-pd.c                 |  6 +-
 5 files changed, 220 insertions(+), 6 deletions(-)

-- 
2.34.1

