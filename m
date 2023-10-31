Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACFF7DCDDA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344563AbjJaN3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344567AbjJaN3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:29:38 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2071.outbound.protection.outlook.com [40.92.99.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9504AEA;
        Tue, 31 Oct 2023 06:29:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdBTCmh94WVusy5Qr075QYtVThxPCxhBEPhWCJPWo/w3V7ZDm9y76pQeCxz42fX6prHcPOw/GOOMnEAhZoNeWDJ5HdMrdAdqZcMAwUA5d2MtFiUAfu97O13dMJSsOo07p4HaP2M8UySYyst0MiED7aMGgiAyoEyGqPJYxTo5TrITqI/aUr3U84PuGMoS+AZiVmi7kNr6tXoSTMAvBWeZEWQes7hZ/l5YU2qyOhtU94JqhI/bC7Sts2WOOy44bt2MTGqQkTkAJh+13luZrtQPzoh/7BQVjKdu/BejI4CzXPveJCSBbdzqOQzgkAs1/TlmbzzX0IfdBmhL/V/PpAy/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwXMo6ZId6UVaf3hdKPyTrvLK+kYzUVVgPWzrtFUXXU=;
 b=UD1B4+c2vyS3XlDTWcbDTKSCfE/OXS9qPfznhptTAUq/gSaI7WQA1u4ac7IaAf4mW4Lc/iOakm0z2sAeHdECpJHFwiIeiUFZn41Aqykc/fm618RDZqJGL9ZNCGIAglhcN8XH6LNkE0JKFM+vrrrNnym/5ym6Nvto5oezjJD8D/RUAxwCQi9TA1t8Wpmsla8iBkBoKLTCGMtPMcFvbmD4ke1boPQGGVY3vEtCJZghLoSAh1UtDfl1sgrVluFNZ8IKzRfsVmDf4jlEGwp4AQ+u1Dyt5Tu6dUoDdVErsA5OVf1aIeQ+EzW9ebdHtvUgaCmw+olN7XeAbz5poclOBE5rrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwXMo6ZId6UVaf3hdKPyTrvLK+kYzUVVgPWzrtFUXXU=;
 b=R0Ar1e8SP6/junEzxWeqUiJ99W0+wxmtc+sR6uYVsIvpUDLvCEHtWorkfXSU+2WZw8txQUzS+7JcZWuIuL9cAx4EWO3oZ8ypVxU+vEOLtNCFBQF8BtUC9rj/JQY4Vgdco5dgUIxCjQog9jsmO8CA6/LStLwBntorZPiKJDeHC76GWcr9AXENEmtQJisNNy4G+rOjfUY8RgAIEyidf6jLlBf/e9D3qhlWb1yN5+lpvEy4r07tQN5JASUGONXII/Lxf/9zvuI7K9zZ9Ck9PxUssQG8BmQJ+BWo4d4otbkuXCdh6ic8Ar4GSbIoMyJEeGHHzXMJo1bgQFvy2OZUvVzPIA==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYYP286MB1668.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:fc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 13:29:31 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 13:29:31 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     devicetree@vger.kernel.org, linux-leds@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olliver Schinagl <oliver@schinagl.nl>,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH v2 2/2] dt-bindings: leds: add "internet" and "rssi" function definitions
Date:   Tue, 31 Oct 2023 21:29:01 +0800
Message-ID: <TYAP286MB0315235C51DAC7905DE4573EBCA0A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031132901.11732-1-yangshiji66@outlook.com>
References: <20231031132901.11732-1-yangshiji66@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [1WwSHmcsM2WLHjyKHGIY9S0Q21neNg6zm51S1aDk/NU=]
X-ClientProxiedBy: TYCPR01CA0068.jpnprd01.prod.outlook.com
 (2603:1096:405:2::32) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231031132901.11732-3-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYYP286MB1668:EE_
X-MS-Office365-Filtering-Correlation-Id: 97bcd924-63f8-4404-564c-08dbda156a2a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: okbdMwrx3q7l+PeCKNsLHtbSic5iHW4LbPJkd7DxDGcKcM6cNSZCcT095agtSZWvTEKnbzOS63Oie/5VJPXe9FeQZLRrvJ1rBJAutMIeMq3f4lFOQElLIAsOhz2WGGpkUkSdtXnzaF6hmQYRFvSoNX4gMhyxCP9kt/7npg57GSSeHL+REH7ULkbogvU5fQlQgatEHZTlbqgRY3pNNlV4xTvbWN1r73eaJmIYecycHcaM9yrjs7dqvgHKInhlPxUzsQlFTRgjcJy7vBGbQ0n/7RkI0DFJb1Hy8lYUceVSQUiRikGUDzpuugmSVc3McjKOi+iKwzlCqYtYLneoqLwcqxGNpuph0OhjPNwbxofLsyuTZLXJMkc4RoUXueV5p9YLC8O0E9efcORgyiO7Pt6pnM9vHYnE+Lzu8LjYZA4NDmKKIB06utDXm4JgJJgU6TTcVflOU1G+NGumdo6g3XlyjHxv9W89YW/FdZVLB36kT5yHC5Jw0BK8mpuVKXqdHQSNznXd4K48Lh6SXnydqj5UmAyFRzRJpNaYOnvOUqQoJfBS6jXUADnQ9QojjbP0hrFnA7X5p7aUDCW+z89L9fRHubosaa9ZbrNCdc42JwSjgDDmEykdyfi19Go/piB1xGnO
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?90B4CQMclgvwap158wG6M8pW/vQrwsjOfatuT3LT9Y/DMoizbkkAoZfbbsG6?=
 =?us-ascii?Q?IO1fHA/AMv7xq7mmnOXXdo/oiYVblD9dC/GZs1aph/xE0UD72YUjmTYRaaZ4?=
 =?us-ascii?Q?d0voH1Jg8eZBydrkUwp65F5ESWXMsUljRLF5u3E3QHbAZgPbAnlek9Y1i2dk?=
 =?us-ascii?Q?qkaSTdM7RRYVJPV3bPmSh8od1IgTASECNw+UGjT+KJw83kkgrgpdFT/ZTRlJ?=
 =?us-ascii?Q?TfhxKtZVjIE2HoQaGqPlo/xtfA1XnLAaSZ5Y/g4AHs+ofykVbPmawDoQ+YwT?=
 =?us-ascii?Q?jdNcyYm4PuBE4yhI3GMN5ZKyRxrb3RjE24NIFh2WhXjCiNja1F0Yd9YcSTr7?=
 =?us-ascii?Q?kb6E3IEocaZY4AjHqqAUvHB3tRYVntHHUgjOO7utIXU9g5oRrqRtoHC7E4Xw?=
 =?us-ascii?Q?fXzKgy8qVIziGGj6KxFU7+iMQa1HXL3x5aJ2JivJ+rGS9bICGneO+m1/t8tE?=
 =?us-ascii?Q?COLr0Eby1X2EQVbffA+1UwthPXVRj566HPFLrkxsJYCjmqvJK4FUXE1MLK22?=
 =?us-ascii?Q?NbId9J0ephipCFVx9ns+9EszLB0HE//IdKsAodKuC4BvyKhsB6eOujkJGvLV?=
 =?us-ascii?Q?8+Qs8RDmpB8XnCPo+QpzdNoK4lDrkycHt953teHiN1tZaFIguVSBAZiwlvve?=
 =?us-ascii?Q?ABCjjXiTo50ojB3IEb7PIvduGARc94AFO2lciZGHuSa2sCkbZ/N57hyNlaRz?=
 =?us-ascii?Q?A8O3IC5M2e6GSFcCqYiNt06tPsnZfljJpyAhtU9DdP4H1DeMDy6B0AUsTbLi?=
 =?us-ascii?Q?DKEovDcXy1h/2ch/tAUQ2vq/HgYnd5YCvaSzlghGi8P50nns4JNmtSlp6YPM?=
 =?us-ascii?Q?RZ+KbGqXNdqKeFc3L1gq1WgoPZtw/8iHcMVL5fA+MF3/KFIm0rOJ7dJUCt96?=
 =?us-ascii?Q?4uSjHv++SM6TFLbnlvHdua9P7zaWweBHtHE2EmQvh2BLvZWNHNKcjm18pu0N?=
 =?us-ascii?Q?tV04AT3AendEQsD2zlKdP5E2AhmCo70GWWE+yzrX50fOY5zNlgU9a1zL0Hvl?=
 =?us-ascii?Q?aW8yEpaT0Z+jvKqgWlLodEEFpDvikImYjzZtNqMm8KdLIvns4ZHmdSLTxXqh?=
 =?us-ascii?Q?OelX97yFeAQtSkJQczNg1L5vCbxSVeuzYbup39gCRo73xFfOMORFOwC9dicA?=
 =?us-ascii?Q?DAIHZla8hJAfXn0tqT8U4KbrsvFZGqpD07LQnRbIr6uMsGi4M3Z5bYuG/sPs?=
 =?us-ascii?Q?B3y2JJ5XinKhZIJh1OzBZeMSvOoFiaFMZgi1T1TPJkhzGXoNfevw8N8RJrw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97bcd924-63f8-4404-564c-08dbda156a2a
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 13:29:31.6411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1668
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two types of LEDs are widely used in routers and NICs. The
RSSI (Received Signal Strength Indicator) LED is used to display
the Wi-Fi signal strength, and the Internet LED can indicate
whether the device can access a specific server.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 include/dt-bindings/leds/common.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index 9a0d33d02..55a426e39 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -88,11 +88,13 @@
 #define LED_FUNCTION_FLASH "flash"
 #define LED_FUNCTION_HEARTBEAT "heartbeat"
 #define LED_FUNCTION_INDICATOR "indicator"
+#define LED_FUNCTION_INTERNET "internet"
 #define LED_FUNCTION_LAN "lan"
 #define LED_FUNCTION_MAIL "mail"
 #define LED_FUNCTION_MTD "mtd"
 #define LED_FUNCTION_PANIC "panic"
 #define LED_FUNCTION_PROGRAMMING "programming"
+#define LED_FUNCTION_RSSI "rssi"
 #define LED_FUNCTION_RX "rx"
 #define LED_FUNCTION_SD "sd"
 #define LED_FUNCTION_STANDBY "standby"
-- 
2.39.2

