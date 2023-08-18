Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0C7780AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376527AbjHRLLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376556AbjHRLKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:10:45 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2048.outbound.protection.outlook.com [40.107.14.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8FB3592;
        Fri, 18 Aug 2023 04:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jn3SUCJUmSkTxPpQlj0XwinygGKkiNf2RO2Gnz12VVGOGlvJLy8Cwo5H3g+C22Z2aXIQ9ik2Ls7Q03KZ8zcAkPrSsb1Uh9N+xaLFAeYvgI3dL2l37Imt4UL9IfquHgp7v2TIgOfFAPCIRklyLFbrsLIBau5fWgO/qWI1fS4T/+aMSDOkDmc3HmBu4VwMpfLkWnPnA/BMLMjvrngLvHkPUisPk1GWBvxcdn2id9XuZnplN+e/AqjqUI6i+lv31vBoHh8X9Qe8Fo6ArXl6qytHw4XQ5W262M//nN7x0+uT4cNFqYn7y1p1faJ0BUnHU0T5+ne2u02cQVPrOwSRiCNQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/oJK3L8/faPZKuS1naDiEV8EXazESuyl8z36nUpH5M=;
 b=Vge8Ye7PvE4E2kHvaIGGEhwqzeba0pwjwiU2kR1CIhHZA/bHJMvOTiPeLjkwfJOMgww3gOYGgzSkfP6z8JaD0DUpG4repzZUpoSUtvBg/1b3hoPAXmmdNQJsWLBw/o9sMxYw+YMlmga+O4QGo2U/rK1R9SrtI0UG4LRCG8AguBB8wSXkux1saJMsiFwsUlPHMxLtJJkrO2hRSYhZOI+X0H74MtLFw9lFqKsqzmO8EIK4l6XtO4sOgUVVh9314qd1zpchrDLkyHSJOLMVQYGOoe3LF7RJm27MPxbQ2c/HrmfeAeIRhRuPISYmwHy1KKCsy8hOVA5vyxQS2G7huFLjrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/oJK3L8/faPZKuS1naDiEV8EXazESuyl8z36nUpH5M=;
 b=dPlrzcLB4bPF9odAOrmE/mQGv3nKR0yfwdwzjYomikzC93V8UipkGZzuDH9rNOkmddr0gugt1Kvw4+utQWD+B/+pt2En3rZTGXWU3FMruAY2rl1A8V8ksQOmWPY2CXe6GjXlhF32Zoj8+a4k+/QUU9IAvbJ6LxDoxjAiePsHpXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DU0PR04MB9441.eurprd04.prod.outlook.com (2603:10a6:10:359::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 11:10:40 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b%4]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 11:10:40 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Josua Mayer <josua@solid-run.com>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v5 1/4] arm64: dts: lx2160a: describe the SerDes block #2
Date:   Fri, 18 Aug 2023 13:10:13 +0200
Message-Id: <20230818111016.11271-2-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818111016.11271-1-josua@solid-run.com>
References: <20230818111016.11271-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DO3P289CA0013.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:1f::16) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DU0PR04MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 6649ff36-3fc1-44ab-e02b-08db9fdbc1eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kvsw7qvVi4hbV5OnSv13eRDV6r/7FBXgzL9CxGdNsehc8TmwhdZWJw+8PFxpMOOr4F5oqJwiJMDzbtodF4L+GvEYAhAvSkuXftaV19KpiwW3KSV29Eu//zz/oWGQK5IJ/YscQUSt27Gkti13isX6km1+UBkBEKZK3nMxpcVzQhdZVyvX4sCNwQLv4Sw4pliw0nygJxv9doTP/pR+QoHEi1B4HJPV7Od+TM54imD9iwYjaITxMRc/wLXEuIYeVJA0dvefQzR6na61B/WOT7E1CH/J0jhmWQWiKH1tdhAPgN9dZ5xR76bwijIwvtWlJzXW4oLl6Wl+guB6D9OfatXJPQJn0c1aUpAIL7sw1CjczRYaKnuUsIFUInXhMSIr0C/EfRwbZ2AMjuHW5yz9nIWVhDVavj7kAmUV2WA+rVZaU7Ga+bcR1cpFj72MisXK0rBG2WAFzbEi/ukx7Uoi1PmLy4EiAI1liYbUE4ihRw2WnKhK+dR12V6UfEq/yIqslJG56d28wEgCsepsqwnbJkCCJ0UfzvDSrhdmRlJT3VoPUeevXmXFVz3KJM5yI4zwgftJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39830400003)(136003)(451199024)(1800799009)(186009)(316002)(2616005)(1076003)(6666004)(6486002)(6506007)(52116002)(6512007)(83380400001)(4326008)(5660300002)(8936002)(8676002)(2906002)(4744005)(478600001)(41300700001)(54906003)(66476007)(66556008)(66946007)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZdWM965hmJZUHThuoU3sSmQcQunaqqqEPxPk9GooDG9CFnXHzC903RJg6k5i?=
 =?us-ascii?Q?fQBnL69cFMkai8ydKouOcnagjkuSU+pyxqMQUsnb1cWWkU3ywDfjyFgH++Hz?=
 =?us-ascii?Q?CllIAbDqrJCr2HKpubojpCvrO3uRTxrcko6Vjzci4bbROtXWzGa/aPInaU+i?=
 =?us-ascii?Q?PDz8FcUnwmJ+Sg23n0ZcWkknAGGqsSlNhC2HZ1Lc6l+0hZi5G6ZdTo2BITSr?=
 =?us-ascii?Q?CTGIYR28lI32xVt/wVlLzVXonrH2bOTcmmu6og7yO3XcvZMnpZe+cbSuNm3u?=
 =?us-ascii?Q?VptyT+GqrAFRTMwAYtRjjjE6zZER2MVZEuTNZOIenjZmecxtr9L2FfySaYrq?=
 =?us-ascii?Q?ryHHx8PlX3BGY2L7mBZOmcyTD+ku/mJ6oXpdvhM4P22w0UHSKQeMElkhUZO7?=
 =?us-ascii?Q?s3azVhUu3F9SVsuXVWV+nlJxu6M1UbMhatIanPoD3lOXXL0lMn9Heo9cpuFs?=
 =?us-ascii?Q?nJV9ahSChBW87EOzR1uKXMpI9JqLOze4yJidhW08jwdvCUu6DJKJxfGBOTOh?=
 =?us-ascii?Q?wg3s3Zi+lU1vQXvuNFdccyfjDizR3ZBHtffxhDiOVFodJzOVJ3wjOOeaW4Uh?=
 =?us-ascii?Q?8AiuDTqKAbD0wEg6K2xkx/KLmQexPTfIkDzY7OWH1P8y575urk5GhE57561m?=
 =?us-ascii?Q?1vsLuWvIPlr7r/Dh8oG5Eaz/bMRW63DBKlD9AJb0A6aCRz1Kh96srjstLWmz?=
 =?us-ascii?Q?aTV+IYxVTftJkkQ3yGoysFQUi2IAu9kwRi3O99jZm70IuX6JX0ICvF6chHTj?=
 =?us-ascii?Q?p0JiP8kF83E1A5KkY+5Op4wW3tT8fR7SKwn7p6uSz6KSCHK2r0FN8HpScFqz?=
 =?us-ascii?Q?u6p8SJPqpOdjHzA6NmUb1nZrUwaYPLUnLorihB0+jcdadPTZCTNJON64vMUW?=
 =?us-ascii?Q?aimwFWPLhxzM2SwsGmq4tWzfSsDtbgVH/7l7VWkHx9+ILO+ZWprL5wVR/Ai0?=
 =?us-ascii?Q?WQ45NFzMNWM7UDIso1ipen/Sn/+XRSxhN8scGItRLsZaFRIPGTYgD6nPqWvK?=
 =?us-ascii?Q?MbPW//6RQgNjTkCQ0yuOKKXB6JoyW5YmM1KriSaveBmKyjIsleqCwwfF5bsg?=
 =?us-ascii?Q?V4YGWeyOfypYy+mr2085jPd1SYzjsXmgJH8T6IbGExh55BXVoxaWoueJbqYT?=
 =?us-ascii?Q?+xLLPzHEwI0ObHcxJKRAWLIpcxmsM+2iDYps52etdlWhvfIAwlPbU2WaxqmW?=
 =?us-ascii?Q?oEJYMD1l68u5DNfRXhnlpx2iVMu7OsDQRARxLScAQmKYnW8ekGvai/7kZSK5?=
 =?us-ascii?Q?ThvjNm9MYhARJNklqqHsmCK5C8apjlDPDVj5cKoCiMYlVpcbJ0MtCEJWGH4x?=
 =?us-ascii?Q?Xn7F4m8sSGNVSrC51Q6N2PlexRRCxvJ4UTFE+wQmLr82TVJ+75bb3/rDEP0Y?=
 =?us-ascii?Q?+0Jpsp1F+I2sw0VshZORvWz9B3GRwM+RtZzy2mlIdxBu05T5FAPTvLnXuZEn?=
 =?us-ascii?Q?hdlO4iIHF4+AXvpnUMCHKQRNXpo3UnSB+MVkaldMsN6WP6DVllnpEatKqOsN?=
 =?us-ascii?Q?gp5KXXAFalE+jhJaUUpdF9t4pvbVTvPzUwh8ndmGqbd/x9GkllrjXdwkW3ym?=
 =?us-ascii?Q?8esx/gaWrZyjCbrg39OOnLlXqvz1R8neu2ApmWHU04B7M7llnqlhk7HLt5W6?=
 =?us-ascii?Q?Vw6nvwIj5qzYgpjhCFAfK8A=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6649ff36-3fc1-44ab-e02b-08db9fdbc1eb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 11:10:40.5915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xx+p6iNx3xoN2m60ucv9YiK/xMbI/efRJNNr8Ajl0yRlWbiNCYuYubfOLQnzfUfPkijiMWaqTbXe7G5xj3dp0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9441
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for the LX2160A second SerDes block.
It is functionally identical to the first one already added in
commit 3cbe93a1f540 ("arch: arm64: dts: lx2160a: describe the SerDes
block #1").

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
V4 -> V5: expand commit hash reference in commit message

 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index ea6a94b57aeb..2e68c05181dd 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -626,6 +626,12 @@ serdes_1: phy@1ea0000 {
 			#phy-cells = <1>;
 		};
 
+		serdes_2: phy@1eb0000 {
+			compatible = "fsl,lynx-28g";
+			reg = <0x0 0x1eb0000 0x0 0x1e30>;
+			#phy-cells = <1>;
+		};
+
 		crypto: crypto@8000000 {
 			compatible = "fsl,sec-v5.0", "fsl,sec-v4.0";
 			fsl,sec-era = <10>;
-- 
2.35.3

