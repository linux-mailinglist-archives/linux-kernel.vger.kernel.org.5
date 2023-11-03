Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571A17DFDC5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 02:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377785AbjKCBb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 21:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377663AbjKCBb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 21:31:26 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2011.outbound.protection.outlook.com [40.92.98.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9899B1A4;
        Thu,  2 Nov 2023 18:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1739Jj2e3owu15uoK/5Of9tVCgUkGCIbxUe6LU/gc56RvKfdYtzyAhGAl2JHuuaEk1/N48kuzJjQ8hhi450ffLgcMen9LyX/g0zQzPRMbSwUNw5Cfyl5NDE6IShsqtId4zltr2l0Jh78xUr/oxFASeniqRfcPyDssJH5CfW1lEa2Hc7hQRg+jtrezVc5ep2EAKnPURzn+t03Qod5e1I3BZb3G+ZCZ+hfZnO5S5p/zEH/GxVmU5pDAw3Gx8oaqa/u96uj9A6d8c1/n70pNiBLBwgo3+KTNBlu1cFoNcB3ByN/FKjyNf+vflip1w5VuYC8k1S3EsgFq7aIBCO4TivvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyD8tGt069pWXz7NSDkgYMS5MXvQRRKeuJlO5vmgTWY=;
 b=CQR2GnIHWCxyOtsGvpALD0mxxlilsWDBzOn1kktdUKcB2cwXdt84A9LZU+ToyZkVz1TeOK1cOExXEMJ5XKTNp9FRlclAlUDjF8/GZoKr9hxmIXUjG/W+NeXy3KmY+SDo5JGzNOCzEGMebltOtRFTJFyPC6OBrcSdnEk0e0knFFaVB+zMnIURo03i8WbeFK+Dto6QzeWq6tKfCA1o3fMoINOkIvIb6o7A6vVL+zPJdf+OMaCgxlJJHmyjxTvlO1d8dXvauRYhQgY1znGQuPpQ3WNYR4NkcMNiKq/x60FkU561xXEdMfYYLxb3rQaGXadJCZYJVr27z/dUddF/mqrvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyD8tGt069pWXz7NSDkgYMS5MXvQRRKeuJlO5vmgTWY=;
 b=IPyiseMHdO3bj/djQi3y/93irEs3UjBCjGeukmcf+vNeK9anzC+9pzTG3LiPHM0FR3XJkmseVUKI5m2iwyMm24No8B1IA8bE8sRx+REz2LL4KCwnDZtOICqAg3jyOJ7B30VP3vsSZnbU9IkZ5WWDLVm6/zmyeyb4DDIBrVIeG432WYuqhiOrf01yVWbLmtOP4wfzq5EFrjE10Ep4APP4UI58QoAwL7dGFoseumPbbIIa5K+bq4H2nVgMBeRDIsLfBgq2UiIM7EQdi/IiNucsQQ0WIHIhHu7G5vTOQVLzUyGv8NCXN1qx4c2oN3cOazqvxlzGlwNV/jG01krooo+Yhw==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYWP286MB3126.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 01:31:19 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6954.022; Fri, 3 Nov 2023
 01:31:19 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH v3] dt-bindings: leds: add 'internet' and 'signal' function definitions
Date:   Fri,  3 Nov 2023 09:30:58 +0800
Message-ID: <TYAP286MB0315AE8F62E6AB48E3F9A0DDBCA5A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [pinm7NMrVH0X7bFV4bSovBDD9JLP8xvW]
X-ClientProxiedBy: TYCP286CA0351.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::20) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231103013058.13089-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYWP286MB3126:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1a5da0-2e8b-4398-b391-08dbdc0c9424
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HYCTO5mRe60s8S6JROEdiMnqF0qNgAztmCDD56Jh/wAHk1TkWejkr8Torrl4oWyLbgIw2i5LGXVzsgNVog9ONbv8h+wpT9nIsipJUbVE5siu1PFgJ3JPINS1Iaa6SZlZyGjiZdEPtIWNUJVQEMvnBQttnXV1ZRcqSpOoz8Wxp+8CJ2ag95BTMbYNpZqaKu8TekuoVFktHskb7tZAsi2GbIM13Bmx6yVy5Cb3oOJn8jXxaxVue1MnHtRaGsGkdl46jef2i1p/6CtDa/IQw2EUvFEF8jpyOsYmI1uen32p+zk+ChVcFOur6PtJ1RdG+p5EuAn21G2FdhPmwOU86W9BGIpnmFX8QoSHlG7aYFqi32mvuY16Siq6IGCSHYj2p6V3DvjKTjjPgEy2UH4amQj/BEB9KXfScCOEKnLz/0pZib+7+xXxnBDqwWns2sRuGXdRqLLPPth9sZdYmNI0AfGJmdAiDfqD01993f+e4mZ6NH4VtMc7/Go1jNesBPsau97KI7B02vZWr+FAebRH0sKFor1UsGPt85jyNnjeX2ganvtJDm384i9L7TWqhkuU1H9Z9L5bPPtQ0WJsNhrjwphFCceihmkUotFuVyUooEnIE4H1W5Tk8/pMOeNru95HP4pum498HrSN9TjR1z57RP92Ew==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lGb5snMdjF20b7RgHYvQHpaw8Hm3xiNgG+cB+6yXeV9gGE+VmzVDjgNqyvlA?=
 =?us-ascii?Q?xCxjDKEXp8B+VID5eOqirKnj0Ln5D2JTvURQleRGVAQRDej5DqzPPeY5M5Rj?=
 =?us-ascii?Q?aKo7jgkHAZZ6Dqtm6m6gFk6hOsA45ic8L19VoAbTN0geAH0UfKm99JAwvzMm?=
 =?us-ascii?Q?DziW6TtIJ5WpYIvL9U/pklsssn6OLaWhwFsV21FXNC00kqjBO949d6rJ5fwE?=
 =?us-ascii?Q?dt2QXqCOPMgRsqfoPYF7kQf1YDfTw9O3wo/N/rgR5+z4DskJ7QW9Kr9lSzyZ?=
 =?us-ascii?Q?JC8Ca4VJfTFXm7rTLTiFfNk7k1yWNw1C+wthr8uZW5lZqkxqyw90J9kdmTaJ?=
 =?us-ascii?Q?oWGo7GBuUv6edHO1mM1AuwH6SsaNna0G4Q33OyQTFsJJ49xSIRBlTWoiGvIL?=
 =?us-ascii?Q?p88TbTxfMSvZ5/TtkvfOf7hkNQFkrgTfCoSFdxflvmsoFixtgHF1yD1kmLWH?=
 =?us-ascii?Q?BWCfpkz46vNUbrtYZdv7WQ051FraCqnsLabEk+TuwPQhGIDx6N1LoOToSQ3M?=
 =?us-ascii?Q?Z7AX7/aWtnBa68TB3TMQW0zzwqFcYJeg2DbClp8Tm6664xGUSht9jxyVqs28?=
 =?us-ascii?Q?Tbhgr/127IJ/jAJwX9tvJaR4jT92Z0MYPbO/ml0Tc77AXFnOCrFuCPmh6xtV?=
 =?us-ascii?Q?MXt/anBuOzQv3mKTnpBj3aXM8n4Rt2Oi6g80fi6B0EJ0hi0n89nluU/243vV?=
 =?us-ascii?Q?b2FUUIaQciPiMi5kRHmEFrR3DfZiTdTJ3U55H7bHajevfJIVIrfLHyAUEbMm?=
 =?us-ascii?Q?Xy///+imES3cuhXiAiyYVVcms6otTrVMmGj/qi957mj67g4eIsatgAkBdnCZ?=
 =?us-ascii?Q?tqDlSenGNasJPOzpIWEHLUmMmeH1lR8fuQ3I6WgrWTZPRoYQnta3+QtF7Vce?=
 =?us-ascii?Q?alA855+3o/jaqLH3O8hEySUVMc8grplaImg/KHPzbrVYUaEQxUBRrDJVhVW/?=
 =?us-ascii?Q?MLxMBH7C8cR4s/tKVJQp75GnO1Eo9aSA/sncIWFXnYFUd4EC2MOE4M4EwyH2?=
 =?us-ascii?Q?LUUVtK4mukAmwAoc6KcdCrHEUa3J0v7RhgSGnKrUKvFKKpKCVC8mbI+Cxscu?=
 =?us-ascii?Q?lA22MRogkSbc7dXDuE3e06IWo/12sLtC0fiUl+SqRDS9TiAeznvaim5FPwfM?=
 =?us-ascii?Q?DNem5gjqq8qsMQ+80pq6rOFtiY5Si+oXAW+qij7QWNSnAOE3123NPFJomsMq?=
 =?us-ascii?Q?w2+iyy+/hi+jU/Ue6uTmRg/Y6hTDIY6adXD/rl/cYVTx2iqTuEE8m7T83ms?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1a5da0-2e8b-4398-b391-08dbdc0c9424
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 01:31:19.5337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3126
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

These two types of LEDs are widely used in routers and NICs.

The 'signal' LED is used to display the wireless signal strength.
Usually, there are 3~4 LEDs in one group to indicate the signal
strength, similar to the signal icon on a mobile phone.

The 'internet' LED can indicate whether the device can access a
specific server. It's different from 'wan'. 'wan' usually indicates
whether the WAN port is connected to the modem (internet services
may still be unavailable). But the 'internet' shows if the device
can successfully ping servers such as 8.8.8.8 to detect the internet
connection status. When the router is running in AP only mode, we
can even connect LAN port to the AC/modem to connect to the internet.
In this case, the 'internet' LED should be on. On some routers, both
'internet' and 'wan' are available and can be controlled separately.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---

Changes in v2:
* Remove the LED name sorting patch as it changes the ABI.
* Add "devicetree@vger.kernel.org" to '--to' list.
  Thanks to Rob Herring and Krzysztof Kozlowski for letting me know I
  can send patch to multiple mailing list at once.

Changes in v3:
* Add more information about the new added LEDs.
* Remove the missing LED fix as Jisheng Zhang has already sent a
  similar one. I should search the mailing list first...

v1:
https://lore.kernel.org/all/TYAP286MB0315FE921FF113BF76F7B700BCA0A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/

v2:
https://lore.kernel.org/all/TYAP286MB03159A83A77E6FD59F271D9BBCA0A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/

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

