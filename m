Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949C675ECD5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjGXHyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjGXHyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:54:02 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2084.outbound.protection.outlook.com [40.107.105.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC0919C;
        Mon, 24 Jul 2023 00:53:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQtntnlFY08pFj0Rlz5fHnNB9w20Yp6MQgGKEr888PXffVNe2J9J7Bbg+J0hg7RgQbDdm7NVDSWGgpS7nOZyTgLek4H07tiwq6vUn3GacxkPC4sOyOXP6YRROUoUxNaqsYtIss3pH0cFYBnJrzgGJoGzYXdRbELKvQt9d1/jU8NwpecGHNWiadcpuWnYNBq5p96jr88bj0Zq2cxVJz4/5gUcBcf5D4bBQDwM1dvWSoX3tuVbFSzix+4ppWaQLEtRP9re5N3E7rYzvfgnz8/A6mj8nt2hbEDcHV5wUhP9hUqYCqFBGJJK9hZk6AbjPRqA+isFdOmFnvKzE0LiDk79bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bs+XigU+rtJb52fiRS71eKGqcNcbSQSHMhvnyOvXCY=;
 b=cMKIQUD+C28SmNqzLPkf6Q4A1XUfRj7CrtrPalDgbkl/xFRFotU+rBcPEWsO38ZxweMoEdq2hntij1UbhCh6QtMa2lflXvcvg5uhhQWqiAC7kdt5RPKeac/9E2t6KYiB6uuH9GMDRdPrqFyZS5APrlHOayK9OaQ4mX7w5ce1XU0ynMD59qWZs/eysOFv2YTbt5xh4Y4Xm0sf/FJsLu6oN/cpV74u17zHbUmvBksKkNNJE7jjS9q4mXM8fdaVRb0giOiPgHqYdMkjqWCDHyCpZnrFsLh0vRi7duUBuWhfYnLjC2d6qT4+rRCKXdEsGD3Ka/ss60cHEm8QuuG9M+Ylrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bs+XigU+rtJb52fiRS71eKGqcNcbSQSHMhvnyOvXCY=;
 b=KLGjBG2obqNih5iImV/902kMYKlcuaG9CAMaJUaRFqVooECtzXWX6q2nUqdQ77MUgDNB1BqwdPcFiBAlVcLrEbjbOy3zx6arBfexwLb8xnj+R0i5XZSBVZDrq211PHzIAm6HKFlc+HaeYnGHmbJlZJmyAgzZ1iNXoxjxOS3Kvf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB9794.eurprd04.prod.outlook.com (2603:10a6:10:4e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 07:53:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 07:53:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 01/10] arm64: dts: imx8ulp: add cm33 node
Date:   Mon, 24 Jul 2023 15:58:24 +0800
Message-Id: <20230724075833.2763190-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724075833.2763190-1-peng.fan@oss.nxp.com>
References: <20230724075833.2763190-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: fe52de81-90cc-486c-8bf9-08db8c1b21e9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jsq68dTPSRs8a1M7jG2Vrduhy0JClVVKyI4j9G/NWEorNQPfMCBYJB48KCr6R/7n3Z7GT8VBJTS1gSJLVL1hLTcf1r088Nfcym6/PoALG9A1Zfx5ctNiFxsWBuOntMSbPxB45iKkBbYF0xNSOji8JwT2erEmRbJRe4+8MeekVypk7VwCthwFXy/0X+ocY8Wks05GP3gVdKNZK5dweam0TaiwBNbI+RHKazexbFd0rsBA8wQY9fgqTYK1xQuwMSPwXkzPLZfFBtBZGl0+TOeBlSuKbDUgRRTR9P6ipDQktqOQJLazxLUo657LDdfC9ETZAC1F2XCUp3hwGfXT+ZSB+oUEaOjf8kgPd2KmotC0m7fCn5QXw2dTNjE9V3SkPdH1uEp3ZfZ31Pqj155Zd4LlWPlWLMpetfItAG8jl1S9w9QBCz81hRB91G4TNi04rNgcgRvsRn0lSt/Ivz/A08R4+COpxvF7vXSSSs6VviB8O79mrfESkmRrh1+WT4NEetLaJtwqM8BGM8fEf+JFFu5Xnlw7MysPver6yIwzHSRY1Xx1c1Fxewj9hTZ3GeIM8qWbNY9WAeH3g8gmNeDp9R96wl71hzLLNGD0vDgMrMRzKKGIytmlN8wYV3Mec3LLI3s39znHHGKr1sGRjbS9cND7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(6512007)(6486002)(52116002)(6666004)(478600001)(186003)(2616005)(6506007)(1076003)(26005)(4744005)(2906002)(41300700001)(66556008)(4326008)(5660300002)(316002)(8676002)(8936002)(66946007)(66476007)(38350700002)(38100700002)(86362001)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N1bHnWgg25g+9Z3LXOKIy0J1COXj4Yv27bOaLrthXxeogKn2CA/8rX7Lov2U?=
 =?us-ascii?Q?m96rlQNJxKGkywe2cM/FomvCv4IrDeKEGBjK2obHt8cqmfkcKWMpEEJJH+fv?=
 =?us-ascii?Q?yKqjw1KAPS/Hb7GV7h2ls/ML0WHRSONTTKIOSJCZJgFM1QAoOFq1YCqMFOqh?=
 =?us-ascii?Q?WJWAk6oEwRjbm6ju67Wx1TMSu49cP38DvexWEyHmQvuUKNCjMMcYKDKrql5A?=
 =?us-ascii?Q?EkFMREHY4srGDq1bLliOfujH+/EmBQkRPTPXqv68/m95puHUgQ9nl8jxBrnt?=
 =?us-ascii?Q?0zlCOa042IIU4phsRHudSClUg/Cn9EGFipSlcVvgUmG1+2OO2fqS4JQVk4+U?=
 =?us-ascii?Q?vrJUyySjbKRkJRXiKvF4UqgIkGtx1QCoV6xzW9Wd13rdEloCOTsp8oeHoTCd?=
 =?us-ascii?Q?c3WmMbQrH9KMWELKFHMATP/y2xFsW6G9S0CUmT/eQVwLMF3Xar2zdPig/69k?=
 =?us-ascii?Q?BT2LmL2WdZynSajN0g4oftN6fkbxuWvfmSk2LgJPw4EgxEF/aLfz5vTzmTXp?=
 =?us-ascii?Q?0fzuoR8itI2RXhYUrvblAfwlUTrrv/+C72Vg6rqlSgXDHU+eAk8Cp/SDmVQh?=
 =?us-ascii?Q?idfhUOaJdY2g2RZB23grCZ7q4Z5W9feVPIR6IjalkJAUKQ+OAMrO9sCR1xyZ?=
 =?us-ascii?Q?k3wmm6NNyI+/q0/gEWLr8IAeBSfCwCjFuI3VMmP6QV8NdnqzObEtAehQ+t3j?=
 =?us-ascii?Q?zbjhlFFVHbdB6LiVgHXLMCf+JBNgB/2iIAcif/qK7MMgUiUk6JKycaFA42+S?=
 =?us-ascii?Q?fsqzReUoRp5uIqjbFYDv4Qxrs96529+1qVgDsxvn13y6LiyYf20pl2Yir3fr?=
 =?us-ascii?Q?9MaQ8/+5ctdvmeT6kFcQSqhmeqHkGdYZbMjSHajPEnmKjILRZJ35EEB6qI0I?=
 =?us-ascii?Q?o0l/GqLDZXOI2pdrljAIL3RxstFFJ+rdAUG30PUBZyoe89J0ERBoil632Uf/?=
 =?us-ascii?Q?NHW5msanmpG/9M03izfpCUJwgDPl+dzhQM4Zvcn3orOH6PpkWgaSkiA8ul7I?=
 =?us-ascii?Q?XUOpaMCQxJ23q3z1jWDK5VhRVrY+YL91iNtD8P40B+mHx4x9PD4Gv574phsj?=
 =?us-ascii?Q?Z/O8BgY0Vj8ijx7ej9QPqaeChKyGjcAFn3HVRQf/IYs1ThBTb4KmRXI3ayzj?=
 =?us-ascii?Q?adyBPger3hqsLHEb0NBdktvPuHY3GgTnjYSp9m6nybujbQGTTT9ekqLdwwQp?=
 =?us-ascii?Q?DSC7Yfo2LalPugI1WR26u3G2xY7Ft3eVKeb7k/ooiWzGdlfnGLhggEEHsqo4?=
 =?us-ascii?Q?dhw4B+Mm0XAf3rkFsB+D17Bc06NzjrTWCy/4Sd0LZL27Vn5LwjQ+Vf/xRhLi?=
 =?us-ascii?Q?Qo0Dqi76s+PmKojRh3aVd+5Gt2VXNNrv5HpKZGGU75TLdcHH3RhmINCPwbnt?=
 =?us-ascii?Q?lzEn9oD8O9o+c1cSDKLc7pj8zWj32RFtWLlj1pPFpOSaOmy4QoWMLIIOGakq?=
 =?us-ascii?Q?qwYTjIlpwPFdqBFPFTed6GgglpHmrE21yVHnxzogb9QpYZB900WLvKpalpoh?=
 =?us-ascii?Q?eGugqcTOJR9in//K/wk16M3UEZ105AV9pPLTL51G1JFSLGgic7ZhVaJnUdX1?=
 =?us-ascii?Q?Ai8PVHIUl++Fcch0cQ0h2vbNfIOppZo0+OEGNLsE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe52de81-90cc-486c-8bf9-08db8c1b21e9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:53:57.0207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqIv8ix1bMe/nbKtOf+TLLOpL1dCYO9G2GVIyZF7efYA5RiEr9SvGukWT85VifjfT3hXT814VQtXtz+R8YA+xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9794
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8ULP CM33 node.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 57627bdaa851..8116d6eeb738 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -148,6 +148,11 @@ scmi_sensor: protocol@15 {
 		};
 	};
 
+	cm33: remoteproc-cm33 {
+		compatible = "fsl,imx8ulp-cm33";
+		status = "disabled";
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.37.1

