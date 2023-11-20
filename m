Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054877F0EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjKTJMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjKTJMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:12:22 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB0CEB;
        Mon, 20 Nov 2023 01:12:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZkOzOzeT2SOYOV2C2VpB+u4EYRb/v5zTyCg4fgWW1N8Iat4iqs9iDNEx4L5A9GMTnt6ltR9U0D7qJn6menS0JvuJVVHsqmmzyZKfYywCl6aOM6yoBHa3wFHxqEWmC+t7HwMN3KnOCkJBBHGZ1XZjV6LOwvMdpZuotpgFkbI/fhR9OOeiuUOfw/hysRBy0udqIui+tAU6gRTCqSEFRl+fQQAXu5tH16QIvyRmuGPtpLV0lbEa+yUqlW8CACIbd9mKtICcdiM+vFa6waHZKCvngC7OK+61IXiYo4UW+ND/nlzOeHtCgz5ASAx0ruZ1XhuXe14auAxWdC9ymXLqWy39A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fv1lp8KFh/WzeG+M9inHOlXHZqAlVQy7rT3f0Uzw1yc=;
 b=Y1j8IH8Kh2A/cNLpJOLzKFpx8hCrdO6Nx6g0wIzJUeGxz7J6BzkWyfhKm45V438VvOVjSVdvaYxGy2YWiOSFNTjHJH0Rp99pmZC30kevI1opZwSBidOAv70g+CQeDAPXUt/s3lYy63LOUaZYZOOLJU+03bSDHJMTI1qCO3sxuqhyVDGKReil+RqmyKjx9YJyUqMUZ836SgMMM/91ijY2lX9DkRAe3XFrwl2+udH7YtXqHehQM05anAmSrGHL9Sm/PCZUbLIrSFJm1ZawW8hZ3j7m8KXOJSmkKzX/ZsV/KsfJDb6uTCA5FI4xavb/s8cbWtRUc63RlPCzb9SNA1MsBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fv1lp8KFh/WzeG+M9inHOlXHZqAlVQy7rT3f0Uzw1yc=;
 b=IR/2WM5m3NLxxL766M/TbhG9va6Mvdi5Wa1k/7uCpakq382t74aIDyx4d1r0gu0PcXitgWGqDowgMuRBx8gXvaC1VzJVw6UbNjJ3IDnbEU61n+bkPbusvKp8v2SWbLXG7RB33aHTM8YlexJhZ45VhNZrx5tcH/n38pYNO0Uv3hw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by PAXPR04MB9399.eurprd04.prod.outlook.com (2603:10a6:102:2b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 09:12:05 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::dffc:1d:4398:7768]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::dffc:1d:4398:7768%6]) with mapi id 15.20.7025.015; Mon, 20 Nov 2023
 09:12:05 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [RESEND v2 2/3] arm64: dts: imx93: Configure clock rate for audio PLL
Date:   Mon, 20 Nov 2023 16:49:04 +0800
Message-Id: <20231120084905.664-3-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231120084905.664-1-chancel.liu@nxp.com>
References: <20231120084905.664-1-chancel.liu@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0052.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::24) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|PAXPR04MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 305851b7-b3d2-4b77-9250-08dbe9a8c3b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MXr3M9CcexVobr1lCsqmpciFq56lqIMMBUqoji0nGlXB7zrn8PuU0ElYIu1njbfakGTguOHfYvuKtcm7ArYd/5UlpiImY3BfaUbjT4TVnl/f6/VSPONVmZbtLRFhcgQqhkQFJuyJRSldLUsmi3liyZ5lTwhl4v5PsddLApMfiGSm8Wu9DW6J4RttctQaPGRcx5xVXl8yDlfOLG6VpFTiBZ+IVlAxhys6oluyyIGGAK5xHYtFTlMJDAQ/HLn5y4QJTMkZwJWMZz+PNVxdTAsU7ecUqxOAIKOf4PMVB7lc2dwW/m4ojeNK/seHpcF3bb0dYuEdT4LRX2TUHglCcHJJbU3v+kp6EiY/XkC1qPR/EA1O2sAhtNmCNXrzjSsot8DrRDdo3yGGAinfwHiPNg9UvgPxxQI6sGXjOqCGFAxSprP4CMYxJz9SG5i1gjSk5kRAy6CkQHdkzoO/GEFHFwQOTle7jGP7l0bUMG2bCLB0JzLDkO2v1mf7kk7vKAV3lRX8C9d2q19C3nhwzib4kyHneZ/pA8yeUSviVjvTrnnMYCcXF+5P+eKhMzztERD2s2hTd/6ezzp70/1Q7C37gvMCNzsL7hXKKoTU2ihfJzmaUwvF+NZxqu32N7i0SYUOj9rdtWxKui/lTqwmWoz2VoSikTV3OLpCg9HlxkwnmbV0oFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(36756003)(5660300002)(86362001)(7416002)(44832011)(4744005)(2013699003)(2906002)(38350700005)(921008)(6512007)(6506007)(52116002)(2616005)(1076003)(26005)(83380400001)(6486002)(478600001)(4326008)(8676002)(8936002)(38100700002)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UYxxIRzCjgpPTimOHWVZnC+d90C79zKRFoGIXJxN22BLhYBGCVeNrLAcrEx3?=
 =?us-ascii?Q?uj41vyiAGrzXnPfb3yjmalrcJUa7w7cZGT2nMqeANqd/+UawmZDWfc+G4/bK?=
 =?us-ascii?Q?HltoQ2Ph9HTwkBuWc5y3ZfH+ae3wpdNISjqhVzweXqu31eJ/0WvbIqI7ApV0?=
 =?us-ascii?Q?HrxSt/vFi3QS5OxldvTd9hXnVvb6BDbEYZbmzu05b0CgugP5U8LyEbRzPFl4?=
 =?us-ascii?Q?uu1RvqKWGchY6QMsBnrq+G15D1GlT/H7Dh7VLK8Esoi5qrs4UO6vIdBx/bpS?=
 =?us-ascii?Q?SbQbV1fS/+JxahYxiNg808qr3pBrcAcKtJavqd+uFSJctOoSBPc2s+iczfYm?=
 =?us-ascii?Q?rf4VhycOyxonkjF92Q+9mrmtuNorhPIJGSVT7qmilW3+Vs6Lbf9bTB00+6VY?=
 =?us-ascii?Q?fV2NQ3PZMxbVJBVmMJtoV38VRGxLhnXzKh/pIMEtck9KCqdhgDmqorE2bPT6?=
 =?us-ascii?Q?6uD3QnUcgx2Aw6HD1pCtEk5L3pi1vPNsz+JPkiRoato1wlfsFqRM8o0Z0gcD?=
 =?us-ascii?Q?K1Uxq2GcrZ5bEPsKmJYa1MmuSYV0zSbQhfaTc9vp5pqdDgc20bsWcoDgatxF?=
 =?us-ascii?Q?qo4F/zEEO8yaDEA/pVvCE6SLO6PEOQqs7DqE6SSCJvdFUCvXv4HQ9vW23OfA?=
 =?us-ascii?Q?HnAJ87rHdkmhHMOoACCfjWKx3xzo3VOJV5xNdjdqfc8N8kY6r/Yy1t1iRqhJ?=
 =?us-ascii?Q?bCXlwN0QG+N3gdPnk8kLFiBJUCLpMT0DpfDg+V9MFZA4G9y20gc1J7HDspXb?=
 =?us-ascii?Q?v9DVY0Q966zl32K3afT/GY+CG3PhvJI6tnCY42aUN04RKMbIHXT93a/aGOZO?=
 =?us-ascii?Q?Wtw7390C723TIyQ9+j5+wEa/WyORlhhcTvzqgblM8OOkP3rUhow8FAUIRALj?=
 =?us-ascii?Q?lNWlfZf9rhMpoPSD1U6vl2LIltEPyEfaq1BHWUMCp06hE8T7GsyJ86QZQxyp?=
 =?us-ascii?Q?UBl3verSlzY5D7LNSQY9QRr/De+B8DAi0oaWsPc2HOw7bStfMc+x1I5Bt8s9?=
 =?us-ascii?Q?igoxsliUvR8a+b9mOqj4/azDICs8d3+zN6hWequLVAD0CqPMzeJZ71pwKnCT?=
 =?us-ascii?Q?PdRoRQSqVB2fc4h73556796oS6tSlpSPlpE9QlsU7OlMENgEhLpO7Gn59le5?=
 =?us-ascii?Q?m2mNuRdJ1y7QtgM0X+LwLS2aC89uz9Vd8YEGJ2QyLBQtRxX2Yc+NFNPw6j9d?=
 =?us-ascii?Q?KfbG2v60Uwa5GUWN6JGbwXzqeutieS+pcnTwb0BCbd26WOXBVC8Upfc9jywS?=
 =?us-ascii?Q?ljecPN4BdxsYJUGXjcEOw77GVICjZqkZ92+VkpHI1N/t8gGAEYCursj5eGGu?=
 =?us-ascii?Q?W1sn5HPOFKsg7bRUjBjk1X74uB9b1iMFJWPlkArIDFdJ8ReVtqKNjTmSQB9M?=
 =?us-ascii?Q?EB1D+VBGhZTyBPlk7iqi8zLhnNSIU4Wrp5chHXlafXEU3xjSkPQ9w38Xus8E?=
 =?us-ascii?Q?b/+lkmJ6u0ksSj26S2r1JGu4+mYt+X/6+Q8C+zekdNZkLpFcF+2pvupVMFfE?=
 =?us-ascii?Q?//+LisjUt6G6O91Czc7/Gp2i3jVihSknZfzTxpmFo+oslGOkdoEJIMJvfSOB?=
 =?us-ascii?Q?si+vEWC4Q59ZBiQLH0BcBf1rfCfRzsy4zQBvbZLa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305851b7-b3d2-4b77-9250-08dbe9a8c3b6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 09:12:05.5017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgGiB35VcAEJFa6z7ToUs8/XPGAnFGXnORWPuHw1qZXYhkbAFXepTEcUZFZaly8sF5JCAcsd1/87NALod4pnwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9399
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure clock rate for audio PLL. There's one audio PLL on i.MX93. It
is used as parent clock for clocks that are multiple of 8kHz.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 9a7bff39519c..e6745801308e 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -420,6 +420,8 @@ clk: clock-controller@44450000 {
 				#clock-cells = <1>;
 				clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>;
 				clock-names = "osc_32k", "osc_24m", "clk_ext1";
+				assigned-clocks = <&clk IMX93_CLK_AUDIO_PLL>;
+				assigned-clock-rates = <393216000>;
 				status = "okay";
 			};
 
-- 
2.42.0

