Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC68D771408
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 10:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjHFIvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 04:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjHFIvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 04:51:11 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2105.outbound.protection.outlook.com [40.92.98.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B9710CE;
        Sun,  6 Aug 2023 01:51:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVoDHorg+LqPLNskyhm0UGt1UamGhqhhHEEBaXV2x+ErCtAHUR5qiYz8Px+T4Sd6t0i9ppDF3CvQ1l+xS1U2HX6IrnpiJzy2O9aqrGLZOT4dDAiuNapsSxV4HINJtnCaoGtX7HAuc5HbRXjzyBJbm+TG2vI/C1SEmlbm3sj6JwKn3iyMAYXWXv6x8ooIjt/hjJD4V/a2P4OAWIzIBzcJ1gfpvngbSVtd4xZJRPMNfvg4VeQ1yyLjYU+PtZPJrW990n+lSJ7CGp1JZsu1gWrDetf2Vf837BNRi18unQ6RklGdmXoBk7RriM4KvjZqrdVlKpoQTy2nuYTs+pRj1SvwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YsSN3S/rkfmLyFz51L4ArTDSWeX/owN6kSMYZtZ0q4=;
 b=ETOoqs5WjFrcK2vTHhme2GfcU5VWh82qZcQ0u4GcYl3axv+mSEbe8+VlNKrIpitcEZ3TYYNt1JJ/AFZIyQZ0P4/mj0zr6BZIgALy50gRfQTI3lPhkxqjuGM4lIQTUL4zbWHu857oh/Pp93omxd/vCGa0vYL+cTmDYiD74wUZ+59ipcLe1w7Ebz95W5+QQOPXtGfedKfZREHrOBbQ8ISb5kUcc4n7nwIXnfJpEHbO/caWDLrR7wCPwHOoOI4NushAt2M3qaxeF4Iwf+SCKA0slszVTbYgtdQLAapn/o8PB5YsqvjkaNZqeu9DWwr9MMUfaUyQGgvpzSVWVJHuG4U1og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YsSN3S/rkfmLyFz51L4ArTDSWeX/owN6kSMYZtZ0q4=;
 b=ur9zmO3u+9vBmDha/aLUllrKTyEzKCv41eCGKkXBgwkqyD8qTk/jKkuvsVwoL1IAIX/NJvwR1PN3w0PcXplAm5Dv/7JKqKn3tsYMolq9MciLGq8ToKgS96CrWI/cMq5wqypZzZCRT2E6xJS+T1Ove9PaPtIbEBmdWP3zBweOiCuZChECOwGek+UYOfzDn3DUlZj0M2Ka7tg2U5yR7VnuVpGECosO4S1KS5FO1iNLAAeKDSaKAqUEwK32ik2Boa2qTMGpp5pc6ljpsb2pTv//dG2jkfAvHzaIetk81SR2EeIXwVXjrLuxFe9tLbshgwt+YxxIMH/3961o30oEb0X9wA==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by OS3P286MB2744.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Sun, 6 Aug
 2023 08:51:05 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e67d:f61a:b248:f597]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e67d:f61a:b248:f597%3]) with mapi id 15.20.6652.025; Sun, 6 Aug 2023
 08:51:05 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v2 1/2] ARM: dts: am335x-bone-common: Add vcc-supply for on-board eeprom
Date:   Sun,  6 Aug 2023 16:50:43 +0800
Message-ID: <TY3P286MB2611CDC84604B11570B4A8D2980FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806085044.1917-1-wiagn233@outlook.com>
References: <20230806085044.1917-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [slYAALz8Vow7F5ZdxBITTfvzRfsM/j7I]
X-ClientProxiedBy: TY2PR06CA0024.apcprd06.prod.outlook.com
 (2603:1096:404:42::36) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230806085044.1917-2-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OS3P286MB2744:EE_
X-MS-Office365-Filtering-Correlation-Id: 9992d622-d407-4f20-84eb-08db965a4506
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmre2cOvxteVHTfiuSrHMX7ochXEB4wXr/dOcGeVsYuIeAx4LGPwAA/CKxI6NGmNm5GP2s+V+jzXRvxB7ca+UEHMhrYP1IT2ignp2mYjay22XrJZn53+Ljt5UknLvptNUtf1ti3GN15lk/CBgiSud5oH8CWa8lpYJhap5hgfENfZQA6Lr7UfMerOuhvsplmC3Mvy0R40q6myclzBIfEOQon+DhNpu5hbPRb7A7He+w0Ui+ysORyxA2W7lQSeRbAxMbJ9nNqzqj2gD7Txg7RXaZ91bhMW9Ee5JtPZ1Dj8VsWcOHfTmW2HYtOdp6Ym9//NROV5hD3kGPYsPW8cSv3kIWwt03FCUXMrD5uc2DFR3O35UBlvjV3sSBJ4kUACanK+7YwvuiIXYN64qS6wbS/6qKZLyGFND+C9LX6VfeE3NX9Di3vOulhkuRqOulLxp8++0hrn9vCZStL7vJLqzfaFk1OuKSIFbgQKMNto1OWyi4LDqPFqKk3RbeptaN6THiZwN/VsHC2dczZxzFJgnshzUabiaMHSjRebIAtGfquoxNsuqMv5j9Krzmj3oHfK84YOPxZIt8bZZTGA3aeOe3VJ6T8XrLXx9vSY3mAkqUbn1ZlhA87vEo/cALRCdeJAGemlE+ZFuOEOpRTMl4focLeiGtQuBiWvzI+9KK42IAC7DFfkaozyVKpwiWdPGgIpaQ7u24B6c7yB4oum+uv15w7xS/TWKUsX5qPuap6HhF7fwFd2DtivjOh4xfMk2lXXwrtthQM=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWASAhKkYu9Xm38jT6R1qKB71XPLnw5+nunnFtT2s0geUTQxRfebvzBT0cluEHP2cWV0Ma/T3mI6atXHRDQSsOTewZCU2YeQ+Nk7c4cwG5gidgMXZAs+VZ6dCvGoWEPr/Q2AzvEr2XGcpN2I/JClEzzzKxcY7/UVSAbM1gLq7F1iY9W3vQBWXeAvDJxQ+NcJcEehiDgkxYCk2rF474ax41xon1sLDikrTUt9Ok2Xcmq2ytm1B9cPImpSInytWmUwEKJYJES4U9fMJOXUbwZpmFc+sYkFeYbz216GwtEdLzIqfb6QDT4accmIanT0nDnfO9TFjEjgIcUW7BE8gaZV8IE7f4pO4wBS0pogWiVkHK3pBCKLaEJeYRbeTgD5x3FxCi0k3ojnIe/7T5SkCGbZu8BtUBtUk3pkk1eD492dAgSFpDUdC3sKUEl8FQ9VsqAPMfQB0L8PKvz3X/SsOZA89nRz0GIOzozb88QOO7KOguZZvYjZcZwfB2GtJ1zvhiU4MkabrsUe9wZDBVqmdjpY5bvODW+GVP/irrn15tJpcoICQgJqsjUvUf/Qxsfhly6Q5gI7O0ArRAw2jQDIRTudPeCqz7HT905yf1EDxcjF5CoDOe0aAbYmCEhp6Nf835gb
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C36DLzwHLDQ+RIc+Hwp1e0VCh6qeq7hdr/sZW+5qSwh2MoyvUEwMVRp+ya+y?=
 =?us-ascii?Q?E5u86bvkHFj7V8RofaOEynjZrcR0xEwAUjPUM0w6OHx13QxjWytyuwMECaUZ?=
 =?us-ascii?Q?mGXSrfxPmW2310iqdEHrMUznIVeQ9Wo9fkAmRZPnixxLzVIbGL6IryJN83wi?=
 =?us-ascii?Q?Zu+nwMyWI49WF5y9WbZgBTOj3hBMPuDDAcnW/j95oh9zj1+4po9LLZhTRcAj?=
 =?us-ascii?Q?ka6vMSQqjfWgqsGOizvqUwF80zLKM4DtD/mRrZ9vp3m3BM+618cYXZWm8Zk5?=
 =?us-ascii?Q?0i6Uqaunr8ITOTzM4d6/7HvFwkzElxbLwrjKGhmXEE9d4en+cF1vmk8H10xl?=
 =?us-ascii?Q?KLmVyBSvErbNPCUsEMwh6YM0BsYkoQA2V77I4oFv5liN1jqdoze7Ycbhk5cv?=
 =?us-ascii?Q?7PCjOIW6JNoyzynqZGib6tSRfxNuRXYr1gaPACbWZkEd9wdFbv3SBWOTawVm?=
 =?us-ascii?Q?lO/pa4eLZRYGvdDjGZAYWnGa9yFad/+BC1fxnMweJUKK9yfVeEhv5Ej5w8Iy?=
 =?us-ascii?Q?Ph+Dj8sHtSl96CqOTX/KctaOR9n2dU4fPifwBB7CkgS67xGuh31M4txngTgm?=
 =?us-ascii?Q?Fqdkk56f5qP+iT0r4B1imeAXv7AO49u+rtzZ/FGbSMRxaJiKWGvf5rxXh7mB?=
 =?us-ascii?Q?+vuD+ELBdPBL5l/Pyilh/VXzlIRtXfc4W9H1I12vySJJPhhw7LRLG+PxtyUL?=
 =?us-ascii?Q?4axLB3h9wFtkt7OfCV75XJ61zx3PCglUW7K+WU2h3kwDBQ6MwhFXo3f5awCZ?=
 =?us-ascii?Q?whgNhNdFGwlEKhFtYyVLTo9kpP2RarD2ZsnaWtt5fK0HL8BDoAX08iRN1JF/?=
 =?us-ascii?Q?fEakTChJQVYDNw4odbJjw+k9uyfbf4CqpQw2/RHZqwcghrUw4P4qGWklIWqZ?=
 =?us-ascii?Q?D5m0+/2MAfYuPJ/yl03cQtgwn8GQVu8vFCnxe/WNu3NeXsQShu5uG2DHiLL4?=
 =?us-ascii?Q?yCFpvujpu2hDVzHP3O6HJexJ1oGRB/MEpxWOsbe3NnfkD47HKGRXAKlHpybO?=
 =?us-ascii?Q?Z7pmJU7PtA48m/oG7XGLZSRfw95kmv7VM2SO+sxHqj4eH6BouHy31K55b4os?=
 =?us-ascii?Q?gpLsX+5VRT55QAOC7u5o0XHu+AqelnoKizyqj0emzNV9lBX93SmH/Rm4KiX3?=
 =?us-ascii?Q?OXpAWuk3nrh3FEfuBppwX8SvVWcEw41coxjC2cLsk7ppdWNXx1YdvSjMwnE4?=
 =?us-ascii?Q?yT4AP7Cy2NDI6RlUNR+ZYh5BtUtrADwvz5Iu8w=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9992d622-d407-4f20-84eb-08db965a4506
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2023 08:51:05.6025
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

The on-board eeprom on beaglebone series has a power supply from
VDD_3V3A, add that to dts to reduce dummy regulator warning.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
index b958607c71dc..7b784a87efc6 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
@@ -215,6 +215,7 @@ tps: tps@24 {
 	baseboard_eeprom: baseboard_eeprom@50 {
 		compatible = "atmel,24c256";
 		reg = <0x50>;
+		vcc-supply = <&ldo4_reg>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.41.0

