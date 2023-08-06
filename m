Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054F7771409
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 10:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjHFIvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 04:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjHFIvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 04:51:12 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2105.outbound.protection.outlook.com [40.92.98.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20A419AB;
        Sun,  6 Aug 2023 01:51:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L70oV5c2C72gsALVeqCIXgCTSPkq76R+EIeo9X49vuuoKxLmErVmXBOUCAtiZmYH4iE06tc2VxF87yRMEI1INw3J0Z/Y/lM4KWVAwQAllyGFOkfiwpBv8x5rFmZJmz6zpIY6TTHJcVZ+8pwbyelCHBUlRxWmvJF0OuCpkinJ6cPDe1Kqf1s6cUzj9wOqewroZD8RbmYUuMmQIZz8RFAWScl+L65JUr9AjXkHYbCy7tkwKFAP9d3ow4qFsTLxssVfNbQmKgLiok8NL8Oar5kCs3pqsu60EPGpfwi9zicpchRORscxpo3okxcrFXq87wygCxZxo0sqMbllSstSHSVg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Khh81vYBKAaFr7jdyAXoN0n0+VShZktqdwggVFOv0Q=;
 b=O2GUDX7eGYxzm/DwYvcs6cAoI1RFIQ/0iJFbEOWnd6QKIhu3TH5tK0iPde1GOxBsqPomRA3seMv17iU1g5QY8HcSzj/4i5rIJCODtnnX5NEGxJx4TR7feKmiTeUUxjwDuS57Dqrv9UzH5krwFqXuYrCFCb/oIgW9oVH2jOVslGqRh+8gM4oDeOlAb3MxB1XGUA/DflaSVPdI88mDbXh8wIOwX8TOWIMXdqfoVZ9/sO+fApaMC+3lt/D6Ubd4a493BOT6X8MdOAqjZBstCtRynJ9BaqRUJ4pDXbtWQN7XcjlH/imVuDmVVVLvSHWGsndQtN5pJl2uCSAkInxS7kBFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Khh81vYBKAaFr7jdyAXoN0n0+VShZktqdwggVFOv0Q=;
 b=ZkbKG4c215fNU+BVr5WdVNuy+rxcppMXNXyl8CSWps3nMc9m9C5urD50y8tF7LBXxiVwnzWGs0nqSAkR+dp9q974sblM7TJsykaXsMtuG/anGi+J9p00UTeGGhKgdBJj9LWQaAWMnj0HBHOXf1BFM84LEFrnSHfjETEEDSKBtPVABQeHbkWbEIV0SXeJLFJ8C1jjT24oGP7MERTEy4sRlYYnOYmYM4FECmpZjKNMSkIf3bLi3lBvbzJiAOgwPxcPP/a+TFDNX0eyJb1OPJJVU/cpHwb63zunLrzuF1pGisdibC3m6G/7NRdJ72MSL4yQ2AjVgbQIgaP8GqI05Gba8w==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by OS3P286MB2744.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Sun, 6 Aug
 2023 08:51:07 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e67d:f61a:b248:f597]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e67d:f61a:b248:f597%3]) with mapi id 15.20.6652.025; Sun, 6 Aug 2023
 08:51:07 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH v2 2/2] ARM: dts: am335x-bone-common: Add GPIO PHY reset on revision C3 board
Date:   Sun,  6 Aug 2023 16:50:44 +0800
Message-ID: <TY3P286MB26113797A3B2EC7E0348BBB2980FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806085044.1917-1-wiagn233@outlook.com>
References: <20230806085044.1917-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [VtcDqVYiCXUdq5keDeYzGRdxgwbdzdYv]
X-ClientProxiedBy: TY2PR06CA0024.apcprd06.prod.outlook.com
 (2603:1096:404:42::36) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230806085044.1917-3-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OS3P286MB2744:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9b87c8-e33d-4ef6-6e19-08db965a45fe
X-MS-Exchange-SLBlob-MailProps: cn60g5V53KP4aUvNHKWy0hRLxv0NStfyR6wGQg6pdK9lxGBOmfRxubC2bJSr+c/nLqtgVHsGfAH8D3tOjkZlDOtyCQAKmgU+bq9mN+RPeU7mcotpHd10auiTDd3Hr3yTL3maBcj07lZONVvLnKUFSs7Bj+znE5i0i9KPiTZaUXWlHosN5nDWRdZ/d4pjj1i+iILoKabsZPD7ObzTVaw9Ligryx9q60bXOEuNhJvRC5VrMNre1YwXIBoIXNPlSLIvWPz5YYKaBpjWzQFUQ6Xlwxz4GmDPkKBccKPgZApzIbS34l5G6PWK07FGmTtFOdTl0eDvK1lEkcqk8/05gQaTS2Xd+BR4VAHsb4VrfP86tzDTGUhwpTJUqOKnPEFGRD7tWOE48VKIHzc+QIHFj/1rQAXg8Ji7V+PKMFRErj4rAF3gBgQIvmviV/q2AE9zLVWzvK80KYzlNEplkleNgh4Ig6Y/4r9HzV3IluSwY6aSGWnIkAavVHS0tZlNisBpxnwr9rj83YtrfDfUqy7mPmZ00tyTzLjHOqblVuauhvAyzh2ARnEGlOhwLz3mSL0uxqLkogJfzE22y+9njuuoYWEWOYphRNIIrJaOROPZnskJme3T+39kh309merTKwVwkb8rWsGSkDNiNPQkpKTVLdy9DaufhUwn59KhoRV5cvf27GDG9hSg3Lj3k5UuFnwwtQLxMNUccMQhWBwM8iuA7MHVlVMP2N5XJmHcD3XzMfiSDo7xNHGRx77FddfThIhv71clrNxRPNZCrduTpi9SNr15iegjhFStpGEN7p3cqheX5doS/qY5/cTjDSUFZZyKy1Wu5/gnBprrF6hUYLa5RGrrDh43kt5KrHMhfgmM2P48nqKuXTFDlDwJug==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gZniCwfN5Y6wv9YynI6MlVO3eZAOlMkto3LJMEZuS51V0qBGMNATpL3Pw4bTpeIQ0ikz45zCHc3NrjNf665dot/zwnVeAzArmeu51VyzGbW2NJDl1iv0RMFKvnebNGpHOSTvPSYCR0ffNbmDOctmcZNp/EHePtcYE5vIREa2GxQOYMir4G7poxLbjdJi6RzPgter2rU0poBFnvvulC5LFXtB2Zc4C5gcZD7s7G3DiHkzNfvT/C1Ne5xUsX2uoNcT8wsFHvPH3fBPadvrLU9fMcz7iXlejRASjHycAvVYL0FkSUX6Hz7N5/HCAPYq+tcU7bvYdCgsO3HFgqIkJiUNmGCyXAiG+zk2jFwdsaj01j62ye2E8X2pnykz4eD1TfgY+9JpnDTT5atTRLBrNTcOhr6sgx2HE/5n0ZseWz9Eaj5mR/Z1u1UiqfsPoxY8l4/Kq5olMqBSZfAjBTDReNBUMLcq/AXXwL+fFkH21FNQjmMaYVKLlZ3dpZm7Fv24BLm48FvtYUjJFfZ9neFr5HLfvQUsU655CG6warnVrBF83fmpbBSPs8NSWnbOgPKPYzCq5MaB+sz9T625twUPB46R3nZt2QuW4Ng1xewq4uRap+wtdw78V7u9TRqwMyjUC6h6
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fkww3DAIYD/vx8F2DFSRejEzeNaPjTI3UdQzuwzHGVhWFwquRNP9hTJ3Zlzf?=
 =?us-ascii?Q?ToAZ5SP1x8dhD29bxpF+ESzwe5b25iRzbvSgOawbP84/ZuvFUtyIhEW72YCt?=
 =?us-ascii?Q?nU5YlzefM+qnm1PFmrD8U2j00uYzfpRgD+SuZXtHKk9+quRP/PyVrTF4m4lR?=
 =?us-ascii?Q?RDGLrtaAmg0SmZGiDVI0EbQjZVTi8SWswrioyl+UVOcBwRM07sAaEvfNagO2?=
 =?us-ascii?Q?M1o1U5XPh3ebdDvugWEN/Nq3HRAWnQgM02nyc55tEyxS0EhY6Il2tCCResFb?=
 =?us-ascii?Q?dpBKGVI1Ksii4i56LFvyAC6LZGl0odILP0ZLQsmZJyaLV9XQzLbVFfO1a7il?=
 =?us-ascii?Q?6pcqBt0iYnNICGBw7H01MkUh/1hkzOiTV/e4SNbIOclyuq/caHTWkuPVEsZZ?=
 =?us-ascii?Q?TMdz0TsKsLtcQUcPto/eLyfirhezQ6MVJA3sAJwjE6sf8FGdBQlulwG/hjQy?=
 =?us-ascii?Q?pjiLM4afwk0S6riaJIiwF9/ktmtXGb83QGi1FmH0JpRWOe8qQRPSOinIk7YV?=
 =?us-ascii?Q?jUKH2vp0/3dKLzEfLYhs3AcPJYszjb1ClXX10hI750q4smoQCntChnGrchMf?=
 =?us-ascii?Q?RcakNk9oVrwlffk4Q9zfiSONRMH6LYctvUmutE9veAm1Ph9vkpmhT01fw4Tt?=
 =?us-ascii?Q?Yp8DakFqH+MAPRn8s2rUSB93glUt6N+fD96QLFKhR1cn+R40bOIN/Ns5EmQE?=
 =?us-ascii?Q?gPCVagYX4o4MqIV+Ncdn2Xv+guKugaQUvvgR6KJp/KLrxUyKMCoyh3KunBPv?=
 =?us-ascii?Q?ka6u4iGIcD2NOjAlNi2uWvFy+6r8fHZ7GcluuPUS/k6sEGrMGhhOR072cOR6?=
 =?us-ascii?Q?8mM5+jTwJYiOUnnvR2M6y03m/g/pfUXL2b/F04srhzZ0E4JAGLPMxJ0pfwQP?=
 =?us-ascii?Q?aTEvQAvNmUoRvVKm5gtCrRK3d5uyTnY6QPu8FQgYnpIU6w7Yz6EYGhQcs5Ma?=
 =?us-ascii?Q?/dzm2eg/YCpYKk4ImSHqvldLKyFxFbO9BWyT3d1xTnSmMyi9B81P6Eiugd/j?=
 =?us-ascii?Q?RGjJ5TIvPWhM9swjwqaYs19b859d3Jts6dGGEYMSaiCQ5gO1I0pPWzWLzG4J?=
 =?us-ascii?Q?9xip8AnfyH9alGn/fggRL8oQXtjfIyQsjo7l8faIfTMMwOB3gbiSEBTT+lM4?=
 =?us-ascii?Q?oDzjwjzeGV4GAaL+PWb/Y4pI8c4eLI2eNUj10CFw4aQVl+VAKHstL4QUFAXW?=
 =?us-ascii?Q?BldGLeIol3j+UCY4hgTD6cuhEAfVsAPPmfqFew=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9b87c8-e33d-4ef6-6e19-08db965a45fe
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2023 08:51:07.1951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2744
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds ethernet PHY reset GPIO config for Beaglebone Black
series boards with revision C3. This fixes a random phy startup failure
bug discussed at [1]. The GPIO pin used for reset is not used on older
revisions, so it is ok to apply to all board revisions. The reset timing
was discussed and tested at [2].

[1] https://forum.digikey.com/t/ethernet-device-is-not-detecting-on-ubuntu-20-04-lts-on-bbg/19948
[2] https://forum.beagleboard.org/t/recognizing-a-beaglebone-black-rev-c3-board/31249/

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
Changes since v1:
 - Using /**/ rather than // to comment
---
 arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
index 7b784a87efc6..96451c8a815c 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
@@ -145,6 +145,8 @@ davinci_mdio_default: davinci-mdio-default-pins {
 			/* MDIO */
 			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)
 			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)
+			/* Added to support GPIO controlled PHY reset */
+			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_OUTPUT_PULLUP, MUX_MODE7)
 		>;
 	};
 
@@ -153,6 +155,8 @@ davinci_mdio_sleep: davinci-mdio-sleep-pins {
 			/* MDIO reset value */
 			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			/* Added to support GPIO controlled PHY reset */
+			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
@@ -378,6 +382,10 @@ &davinci_mdio_sw {
 
 	ethphy0: ethernet-phy@0 {
 		reg = <0>;
+		/* Support GPIO reset on revision C3 boards */
+		reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <300>;
+		reset-deassert-us = <6500>;
 	};
 };
 
-- 
2.41.0

