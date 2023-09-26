Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD4B7AEA02
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjIZKKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjIZKKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:10:32 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2059.outbound.protection.outlook.com [40.107.6.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323CE97;
        Tue, 26 Sep 2023 03:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZsFXaY2vzYs9KY3uIgOfEvJ1itkXjF7+gdIiKagZgY+JGMYDFpY/eDOaY90UzX3yjpY5RHr7i76LKk1f+Ia5exBa5IZni1t8KvJCyT77imSDh5J/i5p9KQl8yMNNGoUfr4jCUbEL8uHfZnuRcpFPr8PD+qGVw4O7DMIwY3JKx9h9X12Iuof7rDUfUUQ1OZ2pjIWUUIaBzckCfpapgJ1qhRx7f+Oh4fsJCoHHXX/tSjiOUHXwTrr7a1ABYbedyV/LuapACwwXCBRO4EFqIL7/Hbyd7PGCb3LoC3CswACkg7abooXYv0rT9WjUXW1TjVoPpKp7IrdzsL8RUFFTlU5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSiaO2jgVQSVZZjDdSW0RixFyyXTmS/xSWR5m2cQI2g=;
 b=PsqObSkCDfa90NMofQ8fLMgn8adiibTBQNcbNmxVNpndZWSVcP+cAvy/ZwwZP7ZYY3I2zCPRW3jnQ6teN3h1Crk325vB50TIl74qJZ6fktpCqOu6KetxLnUOo+puRV9X5+FMPhi6gzYNBLKRR9qPWvNTB1qAz0/RU2rAPzP5IEysWNOt0FLJz5r3fMIvKD7nXYN4k3WC+O2QazCKIIEtUriJ0UiZX9suH/LhPsZkFjTdRtEQhC+rwEEsOZctgdaSozwqvzdmMD49C8XB8TacHmXm9kX72hWqwLVucMgYqjWcntutsvHPLtDQjITTAy/L9AxaPDNgfvkiX6cV3sxufQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSiaO2jgVQSVZZjDdSW0RixFyyXTmS/xSWR5m2cQI2g=;
 b=Xp9PSUwy96lcKPu0b9BdUeJea+muwNN4j3Xc+BsatAWCNr+hHLnbmjmpZg11ZGadFnx+YeDraHuH5LVkehuG9Olxtcw1epFPPwb/yC1TmvW5wYL935tYb4ThPHyWJt4D3sZhNw8C+HYh1j2qZEf0kKRVfXpC1l/4XGuQJVD1N2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB8142.eurprd04.prod.outlook.com (2603:10a6:102:1ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 10:10:21 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 10:10:21 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mirela.rabulea@oss.nxp.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/2] arm64: dts: imx8-ss-img: Assign slot for imx jpeg encoder/decoder
Date:   Tue, 26 Sep 2023 18:09:59 +0800
Message-Id: <20230926101000.13392-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0209.apcprd04.prod.outlook.com
 (2603:1096:4:187::12) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PAXPR04MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a54493-d165-453d-3fa3-08dbbe78cad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TFT1B/e5Ud5Uahy0HAPCcn1kUzDInYshDVx/UJ46j2rRqC1qEYL+q/SI+Wu9fJyo8MbXa4urNGShvXPq+eF/bB/0HOcdSxoT/MUhk0pVvEs2qmJvofVwoS6NW/oRR8iQnwTmuRZy+46Z70MsQrKiikqnxC2ddSKwrEvVd8xSkX6aUnWSNT47fQcSJjLno9hYMtjhM3CYqUS7CM7p7uJHvr02SGaQLqIgbWmDGEtkMAMuQ4OiETWFnRqqa+Ur/72+bYPqBW5Z4KOn1dFYdB9lPZkuR+i0NiZkQTVsTLDQxjDZvcIA3gNrtw5Vvh+ETdafbRGM6l/4JkRd8yxOAHcWVKvWKwOWm+eTgQLWXMEMyPydvW6ifpnkZVWntVdnIl5BR5QXgN0d++NDaaCVm2nTsL5RiBoXoZcmgDBlN0o+Tuew/gNH6thjaglr9JyY02s+5h1Fca2Ftdscb+J+hSr5+L0IXkVnJwhziK6Gl8pw1/KEZcBMWe4iyYKuBcuRvB6MEwBY36MWhatNCo1xkBlk6JbxgKe2bImHe39lJI30SpdgxaABn8I/pHlgXV1U1T1lYSTNKQevNRMNpHuhj3rXGSksZiHHGQK6OemfCfzhs9St7nIjXhUmK4IhCCa0XPmK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(186009)(2616005)(26005)(1076003)(52116002)(6506007)(6512007)(86362001)(38100700002)(38350700002)(36756003)(83380400001)(66476007)(316002)(41300700001)(4326008)(44832011)(8936002)(8676002)(5660300002)(66946007)(2906002)(7416002)(478600001)(6666004)(6486002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2V4/xGVvBxxEnbEHpKEIpvIJCGeF9b3QxPw1475x53247mnfgEe5ZePvI+a5?=
 =?us-ascii?Q?nS5ml/pHr6NwW3Mry2sVt/IEYhw8RfpGd8myh4FGOPrJ+5f5YiVbwbfbUIgF?=
 =?us-ascii?Q?bYIBPz8xjEx38qM3WQ+lj00eVpqWQXRMoFdaJsuJnVNqlrAEO8cO0CavLrzs?=
 =?us-ascii?Q?tSxgMvC01qtZeXC9Xz2w+SoxY7rXF0DD17JYzYlLYw5BvSKGxRHlDqIEgr/m?=
 =?us-ascii?Q?rgn2gDvkkgg8u2DEe/BjmAIjPK+9qpS+kfJ9AysK2vnD3KXWQExrTOItIgL7?=
 =?us-ascii?Q?PyEVccq9iWoO28lzd6iBrAZUgaNLQmP+8cocxJOaCN+WHn15uZrI7F2Z+yma?=
 =?us-ascii?Q?xd5eDIQsD5qgKq4q7iW8R/7TKuI9CfjKSzWoPW+pTSqJ+ZUNe29q/Q/Zh/1z?=
 =?us-ascii?Q?VR6G6kKpp22jkqkoyijEvP70eVFmykWh+YdXOcfMw0O8rnJo+BXxAaqUP0VR?=
 =?us-ascii?Q?qRzvSvPj1EOF9aJpH0OO9aP0WuzfYQsmkg/szwfO0OBLJX3Ln0ADrfjf3EwV?=
 =?us-ascii?Q?F943a8I13qVDl1NSjB+1bVr974aPrnkL40kENC+/Z6SBpmIq790zv11cq2Tb?=
 =?us-ascii?Q?ZuRShECoRxJ6A+nBHrliyvW4MOU6aSggw15Z4VbIFdyc/X1pqhHL+K+Lmvxq?=
 =?us-ascii?Q?B+XF56+KCnIn/XVKnp5Wgo6wwnW4+IgOMvkIDKdn3S6ZwQO0pFZUx2alnr5i?=
 =?us-ascii?Q?RGE+dl7u6sr3BbDsnrPH3GR4PeQqElaoFabSqvyvAB12kSqesz78EQw+jCUs?=
 =?us-ascii?Q?ZordgNKQKqU0W0NeSWxsKcvsh/1SJ3YwJbYUiLtJqUzCrdO/KBDfBf7a6zAu?=
 =?us-ascii?Q?JB5AAwVJz4DrA66/788kixiUY+W3QmP/QW1rWb7o97GfrwYrK6DsKxOj/CdC?=
 =?us-ascii?Q?hx/zy+zSEpyuTfzyEGQIQGKltz1FDigTjbkL5Fon3atbpfsEIS7riDFk50BW?=
 =?us-ascii?Q?WqnKpfdTDwjKPZIUvcDE6LLRn3+DgEhkO1DBjxg6h7AwfhFMBDA4i2DQSzif?=
 =?us-ascii?Q?3Yhoyb4XuhBx5gMSvxElCCb6ctGWTas8Dj8Gj5osqE1Fk0+5q6ALM3Jv2ULW?=
 =?us-ascii?Q?mfSigcneE4g1c1UgKJ00Vg2KL7pS9AOxGqPBO28q/1/CN6TuYnZp5U0Sj3Yp?=
 =?us-ascii?Q?+0rpelM5v5WNC+DY+g4xNeB8mVM7//O3QsnkDLMFIHjftor01xQlA9xrTVyr?=
 =?us-ascii?Q?BGhWLEO2XLt5MOBE/HFT4FS3wWdFj0eFDi8Gg1CGAhE3GZiruMuF7iejgO9R?=
 =?us-ascii?Q?N12SLSiMgkHKaHeZwQHktaMl7T/BH5UXYl4FAJRDp8puA5qdPci4Fc3KSpsf?=
 =?us-ascii?Q?8EBtRZzRxcucXquRN75362AxFc1npMJro+20cKPe5b44OvSGo5jUTegD71gu?=
 =?us-ascii?Q?Ji3zWoLTsF31arvuoe8z6hWugfgqg3UCWXXl5fWf2F99oDXgdsAjt2FuanHd?=
 =?us-ascii?Q?AeO8IH7Sy9C0U9C7iINRJQZXsmWyFFpvkPh8Dow0AtljuJc7kPctSZXjwHHE?=
 =?us-ascii?Q?03ZL4rYN5Ogmy8915bOAzn8y3t+RA6XYtoCj5J/ai68Vk1/GerElId7IPhjm?=
 =?us-ascii?Q?QOH63u7z/o84tm3UWc2gUK+Kd/lEqdqCYo7Z+fDl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a54493-d165-453d-3fa3-08dbbe78cad7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 10:10:21.3636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPTTC/seNWsPZB1NTyP6NEuwDyZoDHrOe95zwMsn9+1QQwZFYvKmm6CTQwIY41IVVx+zQPYetAYa93YOtp105A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are total 4 slots available in the IP, and we only need to use one
slot in one os, assign a single slot for imx jpeg device node, configure
interrupt and power domain only for 1 slot, not for the all 4 slots.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
v4
- improve the commit message
v3
- add vender prefix, change property slot to nxp,slot

 .../arm64/boot/dts/freescale/imx8-ss-img.dtsi | 22 +++++--------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
index a90654155a88..3043c416c43e 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
@@ -18,10 +18,7 @@ img_ipg_clk: clock-img-ipg {
 
 	jpegdec: jpegdec@58400000 {
 		reg = <0x58400000 0x00050000>;
-		interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&img_jpeg_dec_lpcg IMX_LPCG_CLK_0>,
 			 <&img_jpeg_dec_lpcg IMX_LPCG_CLK_4>;
 		clock-names = "per", "ipg";
@@ -29,18 +26,13 @@ jpegdec: jpegdec@58400000 {
 				  <&img_jpeg_dec_lpcg IMX_LPCG_CLK_4>;
 		assigned-clock-rates = <200000000>, <200000000>;
 		power-domains = <&pd IMX_SC_R_MJPEG_DEC_MP>,
-				<&pd IMX_SC_R_MJPEG_DEC_S0>,
-				<&pd IMX_SC_R_MJPEG_DEC_S1>,
-				<&pd IMX_SC_R_MJPEG_DEC_S2>,
-				<&pd IMX_SC_R_MJPEG_DEC_S3>;
+				<&pd IMX_SC_R_MJPEG_DEC_S0>;
+		nxp,slot = <0>;
 	};
 
 	jpegenc: jpegenc@58450000 {
 		reg = <0x58450000 0x00050000>;
-		interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&img_jpeg_enc_lpcg IMX_LPCG_CLK_0>,
 			 <&img_jpeg_enc_lpcg IMX_LPCG_CLK_4>;
 		clock-names = "per", "ipg";
@@ -48,10 +40,8 @@ jpegenc: jpegenc@58450000 {
 				  <&img_jpeg_enc_lpcg IMX_LPCG_CLK_4>;
 		assigned-clock-rates = <200000000>, <200000000>;
 		power-domains = <&pd IMX_SC_R_MJPEG_ENC_MP>,
-				<&pd IMX_SC_R_MJPEG_ENC_S0>,
-				<&pd IMX_SC_R_MJPEG_ENC_S1>,
-				<&pd IMX_SC_R_MJPEG_ENC_S2>,
-				<&pd IMX_SC_R_MJPEG_ENC_S3>;
+				<&pd IMX_SC_R_MJPEG_ENC_S0>;
+		nxp,slot = <0>;
 	};
 
 	img_jpeg_dec_lpcg: clock-controller@585d0000 {
-- 
2.38.1

