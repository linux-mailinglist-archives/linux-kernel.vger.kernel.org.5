Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB5478F15F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbjHaQe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjHaQez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:34:55 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2018.outbound.protection.outlook.com [40.92.107.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A493112D;
        Thu, 31 Aug 2023 09:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFzjcftqeHpIvoFME8V3ijA84zhI4ywPH9e8Di1+WJ7Dm5kFv9Lf2dcWOInurYD+Jb1hKn8Rv0SreL87uy3A/J8Yq1CC+2MATU2iC7iAwH2457gpTac0HyCE7oo6MuERO2rfaYTR8majwRVhb5uisDMN4cV/RDFAHFudvodPLaKegpdggJjBkIC8moCqYcrawbJFjV2J6LEWjatwntUlJcbf5UJUmQPvw+UNSL7cJSJlC3Zhc9snbxqbdghb48aoGH5okRxFdwNiytXPZk4Bk1S1+jaz/D4KWLvszpn8Tdjck50vXV+DsWzJICUuII+q8QeT4uH54LhqioJDGWzfwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9Ybkavbx3D4Q/c30zUNm0cNx73cdS5Hv/sdrA421Rs=;
 b=IkckEsT4J/Ymew2WybNdPAHz4YkjJf0y95M2fJwEQ19spTVUmhedD8UQy4IeI+2uL3upUHlIkL294byvjbmhd68fTx5jewI7O1tYwB3/qxq/1Z3K0Zi19Dc7kEc0SGPK3OKl+YOYFIIQvpSDxSjV0FBZyqnYdkBDr2ERbASeI0MQD25CBiS1iA914dIoHD4XubPMRpl5+WCJ2Q13kb93NDJ4+0elIUPy5UeAvajZOZ3Ilg1dOHfF0j6SHhleDn6umrtaJJmTNfrelG6b6Qzg7idYAA17w2dxeyZp1qAhOwT0VPk2kXxhYtnjrObFbh73AeOgNsOJV5Yobj2qG36tZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9Ybkavbx3D4Q/c30zUNm0cNx73cdS5Hv/sdrA421Rs=;
 b=YFGzjk/SgVyyB2k0oovgfxhcRXXZMcBQ9T2H17oVQBHxV7XRHvT2w3uwaOxtWu1dsymOU4AJ9guLGRBQNGssD9L70b3OqhH0dvCXFNMlKEN7kvIF8NkZlWo8xmTS1qOEbKj3jW2K/gZeH60PVwVjGCqkZacUWP5H0NRuuHCo4FMzLj2QytbfJIuhFaNInjsFNHIXsjA+J4RsJArPcnMoqrF8nIgfdXW01/JSKHlNqofoPPlfS5Ztyer09OvGYwj/g0IYQxrsjYco5NjFcymTWZXUrcQ4VJ8POj+0jdrpicMmxo02VXOMOquuiWFxUQDqqizg2X8PlKMJvF0w1nsGJQ==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by SG2PR01MB4411.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 16:34:45 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a40d:d453:3c29:577c]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a40d:d453:3c29:577c%4]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 16:34:44 +0000
From:   Ziyang Huang <hzyitc@outlook.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_gokulsri@quicinc.com, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH v2] arm64: dts: ipq5018: Correct uart1_pins pinconf
Date:   Fri,  1 Sep 2023 00:34:15 +0800
Message-ID: <TYZPR01MB5556F902BF64AF857C3ABD44C9E5A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [L568jpMYFgUzfXmVnz3GJK/bJlLvqHwjB5NaQ/MmBDaHU9dW/GZ5uA==]
X-ClientProxiedBy: SJ0PR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:a03:333::11) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20230831163415.1137690-1-hzyitc@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|SG2PR01MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: ee308674-1a52-4fd1-1341-08dbaa402ef2
X-MS-Exchange-SLBlob-MailProps: znQPCv1HvwVFYtSO87k/Yw3hvgb2vP4kqTfKBHaYaCc5hs0Uhsc4cm9siZINbfJNlkVkOn86oaR4J6ByL0erAe7WfF6+vK2uTISr94rulXwcYixChUeqqIgAkwJmSc6mrBxK5bqpdg9A4TxeGoaerb08w4BuY3TO4UPY02ZwvrojAoC34+wGnONy/SQxcfC/YtyAZP8/zMLm8P8SAGj4QYPCQR/pg3VXso36WgKuQCw77e/26kyl/XnDWH8Bbsgs6RKThyP2jzKIL6MxsRv5QKKlg8AENI5lHffYq4klWIkjhJPHLxpm55lZAOYu3tjjCYbRizGSov0AxG2iPydc6B04FtF23uFRG00UQoQbnRmafFrkSkuqw8EA0BwAl1tZk3UNuf3p4mera91TqaWo3EB1uDBalYc5ze5L9J42qNBD4S6WAsQKZNyPWpMRt4n5Y9xcHMGmf4a1DHyoRgMRtQnwa0HuokQzE3jWW0Ilr9bTaW+19IUyxUWG0tUoooyGYL4ZviQU7bM+f0Q/eCcBUa89dPAwpLFEyrIh+A4MpVG+sQmAz1mQK6xxxTiEl7c+YhosWxiOG8vXSOqgs8KPe2HjWn0QIKCp47y9+eAmEYSSDWs2Hy+3JYxyBBD+WSm5hIauyk2jKmBomFC+2GcFfxZFXOq8bkzjuxgajbyPYvCTL8jutxT/F0Ok48xC3ShKHzs5uHZETb9lJVwln9y98ybUOmM0SO96I7I1Qbdct9bsNKivSnrS0CMPu34IYWvUP8xJFfXFblc=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZ1SoxHx2rsbR1meU1oI6VkKcuHytSlWG55KhRhEhoZlrvhvcRWPZSKDUW9S7m9IQcKs0E2pC1x/kbeYXiBF/FLi3+MKLk9esNVSHeeLzFJwZuwQ74PSc6OcyJtWzM7oEvcjXXpWOBZ5mz8VDYNK8l3APcgrKZfMbgeK93jCNYLFCj6HK5ggJKpmBUCbuXmG0aSVZ27y+p+sj4rwNLOX0vYUTrImUjEhJvZkBn5XKm2Gs5rfIOdDbokeO8U9SJYWwQrWISmZc/+JqJAvbm9hDwP6bBHNRqxIn2vDbrkpqhRNjVh8IEoFzig4ESZ6REWH9rGIHjC3RdMmeapgBH9J/weBiPeyThdmMcSEwoZAAWjJ5oXUQU4BFlWa5Bw9Wf2v3qoto7I+zcBVVgPpTZPCX6gOO2odsmzZUv3fdwswtjwGreQIukowyS2iRcFXY518kUADYFVrhBOO2uSeI9KimtsyRBQlM+A5baXg8Lp5BNZulpqFt9AytCSV0S5QUbmNX/JtFXXx4ceqS6qV/kYDW5FHWclSIp+Yf1K60FoNS7JhlSGPrFe7Uxf02ZECIGHTXvO1zyMF0ArHfR9FJQvsnCTNvTUwaj3mU12sVVY2p7Pn+YsRUbNLSunNCIAQCbsz
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tNSTszad32IDlvyAwjdBCOuSVieiQz6CDN9+SneS3i5Z9Dt8dePXRxxX2SoP?=
 =?us-ascii?Q?AOAEkhpKp98v5WH28/cF/KWW8HLxCvJjV7jT3CGjjhWPcnIIQ7g7yAuBEoXH?=
 =?us-ascii?Q?8Dxe4uDx575O7iQGlmY/4X4EEV+46WikhHmM4jS5JU4L7t7ozifcUFOfCDpy?=
 =?us-ascii?Q?Dfd35oFTxGNppQfRhLNgrm1sSPduztqvUF+FFO1SlWVZIkoB9U2ugNbX9iXj?=
 =?us-ascii?Q?pVWy/UmmLqtdy4JC53zoVyuPlDjt2EPmBQ4/9cfgNiWusHuoywefugV/u0vH?=
 =?us-ascii?Q?V2mIvIcMDXOasE0jyIghXE4sL5dR5fzf7DMqC97CulrPlumpZ7JoBvQ+8XN/?=
 =?us-ascii?Q?Mou1dn1GeMPnc1d1WNc/+B2/HV0Wb9gQ/Wa84RZxLl4Mq+OqHum9orpRQNgt?=
 =?us-ascii?Q?STv8UCK/R9oryQIdlxF0B866JTSLUdwc4krtZbDL9rr7z1FgJHWsYm7w4uZQ?=
 =?us-ascii?Q?J0Vz5lxtZxgwbQPISq66Uc2c26r8keffKL8PeJUkN4HWcKUpDoXGLK9pgfX6?=
 =?us-ascii?Q?INIw7JW+e1EHqNSL1YdtBaagJ7Bf+t3AwQW/fXsW7hqw8mgpgTVSpEO2wuOF?=
 =?us-ascii?Q?14XJPlQR16OC1N3rW9lOFVtGNxcoZossOYE2fsRn6DvBj2Z59MeB1sQQyBu6?=
 =?us-ascii?Q?wPFrAwGc/4XR5gRW6FJHvRzK7nhljcOtGI2LaeCZRFSNjVJD5K4rqR3cm6lf?=
 =?us-ascii?Q?zjgerg8WAvw9ALjJ8aUvkSBbKaGEL1HZHlLDamBWQ1QkwDVG3RUoFGQ135HG?=
 =?us-ascii?Q?V0C7dgz0MTjLspW2enXut7SO9ju5CT49p4p+CezEYt03jaiUvnXjzwhw7BIA?=
 =?us-ascii?Q?cDZQF5ZpqK5MPpC/bm9lQyBvEONPvMijt7Eov3C+LDn6chAcLFg3b7lAiicb?=
 =?us-ascii?Q?0pnUXexvv00zTBPjbTWoMMk+/GiGZUet9w6qiJ7qeGYc/pFOeP/PL3kqWLHf?=
 =?us-ascii?Q?u8jgUszQOD43JTHdwUI08bbY5EpFBjFfmCj4JbwMdLeLWwyzL+bQnTuBoRpx?=
 =?us-ascii?Q?1vrEux3srIND7uGqHtcMC5B/uXHamHsQUycrC4n2bA+4fx+goKmK5Kexzw8P?=
 =?us-ascii?Q?/QIMVuC7Ir0nbOuAU182S2v8Lr5LTBEB4wsYqQp37fvTynS9j0Q09vpKfbHq?=
 =?us-ascii?Q?kDsuhejIk3XHqYiQkS53eh7bgkc7Bjxf8G/yzQsTafbpNAZ9+0dmB7KAQxvY?=
 =?us-ascii?Q?68pOaJTbWkQpSE0elIVY9fi4GkWfqodfxic6hnzt4hQm5GTGxd6BoOegt5TZ?=
 =?us-ascii?Q?cYe5iGXr6P34a48mjuiP?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee308674-1a52-4fd1-1341-08dbaa402ef2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 16:34:44.9555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB4411
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pinctrl, the pinconfigs for uart are named "blspX_uartY".
  X is the UART ID. Starts from 1.
    1-6 are in BLSP Block 1.
    7-12 are in BLSP Block 2.
  Y is the index of mux config. Starts from 0.

In dts, the serials are also named "blspX_uartY", but with different logic.
  X is the BLSP Block ID. Starts from 1.
  Y is the uart id inside block.
    In "ipq6018.dtsi" and "ipq8074.dtsi", it starts from 1.
    But in "ipq5332.dtsi" and "ipq9574.dtsi", it starts from 0.

+-----------------+-----------------+-------------+-----------------+
|     Block ID    | ID inside Block |  dts name   | pinconfig name  |
| (Starts from 1) | (Starts from 1) |             |                 |
+-----------------+-----------------+-------------+-----------------+
|        1        |        1        | blsp1_uart1 |   blsp0_uartY   |
|        1        |        2        | blsp1_uart2 |   blsp1_uartY   |
|        1        |        6        | blsp1_uart6 |   blsp5_uartY   |
|        2        |        1        | blsp2_uart1 |   blsp6_uartY   |
|        2        |        6        | blsp2_uart6 |   blsp12_uartY  |
+-----------------+-----------------+-------------+-----------------+

In "ipq5018.dts", "blsp1_uart1" (dts name) is the first serial (confimed
by the address), So its pinconfig should be "blsp0_uart0" (pinconfig name,
use GPIO 20 and 21) or "blsp0_uart1" (pinconfig name, use GPIO 28 and 29).

Fixes: 570006756a16 ("arm64: dts: Add ipq5018 SoC and rdp432-c2 board support")
Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
Changes since v1
- Use corrent name in From

 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 9f13d2dcdfd5..91b98020e1c6 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -104,10 +104,10 @@ tlmm: pinctrl@1000000 {
 			#interrupt-cells = <2>;
 
 			uart1_pins: uart1-state {
-				pins = "gpio31", "gpio32", "gpio33", "gpio34";
-				function = "blsp1_uart1";
+				pins = "gpio28", "gpio29";
+				function = "blsp0_uart1";
 				drive-strength = <8>;
-				bias-pull-down;
+				bias-disabled;
 			};
 		};
 
-- 
2.40.1

