Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2DC78F0FD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjHaQPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbjHaQPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:15:01 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn20830.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04E0E54;
        Thu, 31 Aug 2023 09:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2u1+zCUHJ/YUsxEJNz4B4S+naZ5yULssZxdq4DEcO3JRFcoViIokvg4Q1JcEpHtFfHXNOmxifk/0TGAqSoe2sZMbo6Z0QkTYNylZcJHjEgOmBVjeNOavR8waZwEjLDZjKXAcHkdp73DnORr47MLouuoFMZbo1KzJ9u+fSb7ftAjAv7LJze1qbb9p/xuJZrSrCoAbkhiNdv5tmTKuzsJ5X2HQAo96kbSymPnqgZwyYIBf0KBnUUx7LGb/5q8ARCxTKfTy5F2NSh3vYP7Wyxca2k0SMaFrSxBXt9z4sZwTx80RDTT3L20yP+6xPO5iX+BakNAKa7rxbC3sQY3DqQx4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NI6ZsCi7u8wp/9RpTbdTEEqvSS8bCqJs6qWaxnLkSP0=;
 b=bilIZbuhSQwWZxqzNfrUSF0/nskoiJqW1nxFCxRA8triI0UCfo6W4OkjCm9rGP4MjewyoDGlDWbIFm8+A+5k5mj7uNaJ0vCt3REASL5ipNOjqaGEQ48OR3qUotYcF3fvdHf1pNJ6o7GfZGXlZeUBFK4T0VMFz8m6XyKehEPpbXA9pDHP8Ub9PwLrs9cyFWTCy2TrZw+/XuXdFiYQVL0qEDXS9ATmB/0ncHJRqMFBdl/FygFJe4wd3PAWJosdxFgNDarK73aQiKVpf5tyyRpWvv7dM6mJIgdmdQC9lFXbctLwx/BDgVpEBUfX/5qnr/qQJPqmexiIXqSZmb1NbffNSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NI6ZsCi7u8wp/9RpTbdTEEqvSS8bCqJs6qWaxnLkSP0=;
 b=tYCCvx5nYzlUJyQ/OVIF1u+ThxLwtj2U03jAYl7Xvh98ShBbjwBMUmWEog9SzYdRydrb/hsZimzQbAjm231KXeRhC1e5VW4KIHFDMj7EVG34wFpsAs0N3yg+YYuj6SVywjTjX7xvztluS45b2RzbG4OU5ZEeB1O7aKmXW+IchmaM9f/9Qdzr3Sdt4XzNF0rfuzYkNvS4ktq9ofIBRtVeYPg9fOiKEc8QKokMGSOEUOgK8gm9HXijHivKc+Em1F0oNbHGUQb47vz0Zri01L9zgmv7C5G0Avwbkja0npIn1JT6ztS74cla6EgrG4d0cdJHqGNtfFm1KZBvRJyMFbo2hg==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by SI2PR01MB3979.apcprd01.prod.exchangelabs.com
 (2603:1096:4:ec::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 16:14:49 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a40d:d453:3c29:577c]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a40d:d453:3c29:577c%4]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 16:14:49 +0000
From:   hzy <hzyitc@outlook.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_gokulsri@quicinc.com, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH 1/1] arm64: dts: ipq5018: Correct uart1_pins pinconf
Date:   Thu, 31 Aug 2023 16:03:13 +0000
Message-ID: <TYZPR01MB5556986C59761A5E7B057CA9C9E5A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [4BJq9U5NbH+gEKmEGmagbt4XGsADHS1/aDIulclQuM2Dz3DNhew2AQ==]
X-ClientProxiedBy: PH8PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::16) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20230831160313.1136641-1-hzyitc@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|SI2PR01MB3979:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dcfbf15-0916-431f-45a7-08dbaa3d6663
X-MS-Exchange-SLBlob-MailProps: dx7TrgQSB6fbW94R0lh08zY2i4OJd2lItBoAsJfVLJHJ6zabYk3VieAxWjt/MRvlclvRJt3qABpXSj1ysoGe5NsPmJRz9+FIexXBfMZaUImYEIYTZgHMBGJbwyCyCfmukLHxwPqZrTnoqlThnDDcLC9XDAAqfklkv7Q/gVK4rIdK2Cozd5ufvGFq5V+k0qEZqqbtoTTejUwj/Z1TX5ev457Z5QbM916fQg1QbwbX4ryCAeoIUdCfo5ZGSHd9Xn85Z6Vr1qJ340yQPz5S1Vmvnej5VA5T9L89XvyHgOVZRI34Is+Ag2g6IYy6q8C1Xxep2ba6b3CE4fIqV/8oZrUfM/gAByxp5nYhgVU9GYqqqiFc4LRa3YE9fm8h3cWyjh7WsWDwX5wUlndGHxtofuOoxN7rIZRlRnqPXtkHGxtrZBTdCP+Om+QHzOXhEE0YB3aBzFCL9gidbzK87LlNpTsj3UvPLl/ZPDpRKqXOaEwtwJnPvMMN24tIJxwdsULOImf+nuP1z7hXfWN64yFd7+wQ9aLWf2XYWcwa6h3SynvkwdtreoLFUxsYs/bRPgIF0la0DUhQH4dYeFmSdSHNXVe2nfDfLaMPWFJQR3wJh0XucL55YVQF2iVhiuDbujJC6vbT89SFbJHpANqvtcui4oP3QK7h7Uo57c7kB0oZO3FOyb3/AJTTQAD646aDOR+j7gqLX2eCEY6jIrM/rbEWXF9M6yK4/oQB4RaN2ivXHEKfM9XpntVh73kgkccTMPfth6ko1wK0QuuXMlU=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +eYqQctSK8r7KqLwyYdbckteZeTm0KsolB+gRNE2atNzvVATCeha56UgCO+kTXkxZi1Er9XykFp9HJgTutXRnHVDg9n4ARrGhsdomvL7Ew5it7O6xQUzp+Snke2bmWknfzoeMY7Oh8Q4/hg3xJAgM3ESzuicp9qJ7JRY+weJHrVw6FOlq4wrcrJeri+dHZ5qgag4q089RcZ+yd1iSM23skYIMKKeEdBqtw+XYqv0iXPVykvFszcVBwGwvuIzt5RYj2owxdefXj3WdG+cwot0w/IAEX95TVUWdG6WNCWmlAu/z7TluNht7AZK6TIXNPgmT1D9FJ/IpLxxO9tB2+/4Hs+vIEaTRM41YnnsR4h5GHJl392yoKWDLvRDxkRPnlLZayLdlwQmwXE6fUcLivfMZ4cG0n+78R4b7cYC0nTf8wKZsvjIRx9TqJ1lNGS7xMiIuLz85bOFEyTJc1gqr3Ojl2S+ePatDmxWcahl1L+4QQALMaOPcYrn+s/BojrbR2Fy/UtQSaMsiPmEP9mNtawN0Y9A8/oj786LoI/NX4ZVN27KMgeXZfYgKVfA47mMiStnPDUvDAMTW+zR6T69Ko3abFYCiRg4+YHXr1Oa4jFziQSit1aZTA4q0EQFvdhfN0aW
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I4ZTdOoY4/irnr4sbKO7fpw4UQrCJhSAcWgtLLLJVSPKka2UTkh6+rE2Zy9/?=
 =?us-ascii?Q?soEmPpqIX9VSnD8+DK3pCa67Rvw/HCIlUOm909DhDaxvCS7hSedliy0/P0AF?=
 =?us-ascii?Q?up1fCqHUlYwQcASQo7xBpQpgpH+45LtG/ougLWCd2pGlv8ZXNYXlGviRZsVu?=
 =?us-ascii?Q?GPSMrUGBrlgJYGP43QNAmhVWIBTl9UnehOiZS2qRZ0NkvV2b3+vgjpRAnIq+?=
 =?us-ascii?Q?KFuFW61jo9ICg/ztkbQ/yPQIxqLJksjKjxI0NCJBsxvwrIiwypASue2PafYQ?=
 =?us-ascii?Q?cGB+iWV/PQzIFZnrd62Clo59zx+cOEl4jNRiUvxnuYRtdEudVNnkA8LG4N0E?=
 =?us-ascii?Q?DgP0anFNurwPIzkVVey+4fapKiJYSmsqOh0bMlNksc28XdFJ0UIQUPu98yLA?=
 =?us-ascii?Q?6Q43k+9SAnld9bDKU7MQMsb168l3zIPbaJ1ROb0XYVr2cPkdAVVfJhvwqpvz?=
 =?us-ascii?Q?D2ej/nTgZNlorKvPCIYeydGQByu+UW660Ulk6OLqIQ/krK3+QhpRL+Aob4e7?=
 =?us-ascii?Q?iHO6u/b5yFzEYR+WsoPj1NJxsgyIn/cE4HySSJMcLTzMfsTFm8QLuvErErCE?=
 =?us-ascii?Q?1qbSpLQjt3WNnlU1N8q3pCb3VpCsIb/RhFluKYdiLoU+bKqDQ6fAWYvaZo0H?=
 =?us-ascii?Q?WpIJ3KypgotPn43URA1jmSAQCoKxVTZDxi4RKoSpKRqJZk/TF6gqAcnN7jky?=
 =?us-ascii?Q?dkjiVkrkzCI56QHKcargD+RVQRaMUrLIuPDQJVc0ZKauCVlCPibWpZbTgyGy?=
 =?us-ascii?Q?mbVUB+OZ1ZcwJOzBURhYGNxK7WZEVGiuKz4wYEHAtQLmLFG34629sMqHDHQv?=
 =?us-ascii?Q?dBwEE8xnHS3ikl/Kl4REiP0oGGwQWhBLbztpY3vVwBLtaijU4zA5jWuvq6mY?=
 =?us-ascii?Q?H5Q5rChqUGc7cmV69X0QGFbKoimT4SgLSvevDK04bbUW+v+9RW80iiU4/faE?=
 =?us-ascii?Q?M1gBph4mJ/zmvBlG329IaCTdciOtS6C5sbJuY+18y3vV6/GxaTaOc3iI2IAx?=
 =?us-ascii?Q?KaDMKmLKYqxV+kjEGWFJWD3Y1bmJHAFOVi5+uF77Av0GkVOT0ok5q/ISzy4Z?=
 =?us-ascii?Q?OD5OVufHBVhd4DQgyJ2VeUy1jk4laezvh/qh2jUxQ8aLHqmePijAYoinlxj0?=
 =?us-ascii?Q?iKFOknljupkFJYjA2tCyCjJk/8On22jqDsHZRp5qRqz/0wWtosCKk9HWd+VX?=
 =?us-ascii?Q?3FCErjaaElqmZoleKUFFBzwRcPHi54m8wvAa5AU6hj86zcWyMd/jQs9eE5bK?=
 =?us-ascii?Q?7Z9uRY2KwiVBrUvP3UWq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcfbf15-0916-431f-45a7-08dbaa3d6663
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 16:14:49.5754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB3979
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ziyang Huang <hzyitc@outlook.com>

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

