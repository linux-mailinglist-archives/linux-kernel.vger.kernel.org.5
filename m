Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F99077086D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjHDTBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjHDTBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:01:32 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2047.outbound.protection.outlook.com [40.92.99.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3441149F8;
        Fri,  4 Aug 2023 12:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZCfkP2+gH+7TRu8jZ2aw7c60uG8Vktsg1Q7cnG4Qg4k5ubsNgv5Ir+DrrmIzCKlg7+S6QT80TqjNoV1PF2I5ifpPTc14A5IXiwEx+BIAXitE6mKTeHS87UQSZD/w6gTfBUsuUDZ/rUb2kggExXN/P+HxHsx/A3FSCeIXoYjsrqZ+h4zGzVe1YnHNPiwHDyenCssAUwKN7TJB0g/rcXfKgMXB1fVUkMwKvNSAEZVvkBplUjF6KDVgLQeUCvN8EoPKWHvABQc3/HrspUKVM4chui691gIz9c7wTh7raKRNACheCA3BKtHbJ7NeKunhEdqPjQlfFBM3l1xPdesVq6iAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8TI+tvlhNrVHsn+FD1ijhrN3b/IZnhW7occY6VAdho=;
 b=ZVrNrgf9izbfN0WyXwbH444kWz0mp6Fbo253hsTat9tftQgwezMAIHTPs0WWydtnXKsyQ9SAJrB4xgSWK3tAEBl3hcmX3v222urGh1bhQetVMyspx7J/bSISRSgCOlMaUgpZSoH9y50+LlvwdrqlSdH+6kwGogDl9/LcB/JMVoicsoTUACSTBOc+BPF2hMvzx9OhMhzhaH+1v88/FRRf6gfE72cPRtBnHsNu6iPMkTj3B6tyolVyqazDlw+PatTH9AaHTMgAHfl8Es8lnko9X+UnUJsScPzhKLjICYjQNoPtDaU+4UI4Y3yJHlEWNDaXPkNOC6cmThgmgr0gCov7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8TI+tvlhNrVHsn+FD1ijhrN3b/IZnhW7occY6VAdho=;
 b=RLqvnn5MKJbhefv87UiPQDrA21ow9x6Y/YzR5YV2eZNdzCa6TMaAamAzx6y+fVlZjpPN4kjk85SsKyXupZDrnmd/vFkdgdr3b8aMkX5JjaU9zcb5q5JOIOMrCjDSllqNeHrd3MFWKGJjXbffLOJtf4W+rJkyLOYRxlw9V8wxwdSew8PU6orBj36nCA0KgkVtk4x6Z2NNkCJm1h+lQtA+v/yGridbiESeZXtCo6QoaxJ8PM+0OE5QAn7PSfTXbbNyeJKkiayf19O2AvCtnTH63MVSiVyUksRd0OiMcZ/1XfP0UAWNiqEdOqXO7NcqZSy08/rLhNmSO8R/LJIqSO1Jqg==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TY3P286MB3567.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 19:01:26 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e67d:f61a:b248:f597]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e67d:f61a:b248:f597%3]) with mapi id 15.20.6652.022; Fri, 4 Aug 2023
 19:01:26 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH v1 2/2] ARM: dts: am335x-bone-common: Add GPIO PHY reset on revision C3 board
Date:   Sat,  5 Aug 2023 03:00:43 +0800
Message-ID: <TY3P286MB2611D3E4A26463392868F6849809A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804190042.2529-2-wiagn233@outlook.com>
References: <20230804190042.2529-2-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [r5pGem7VIyW+eYsyHYRfShvE+tAeVVCy]
X-ClientProxiedBy: TYCP286CA0110.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::17) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230804190042.2529-4-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TY3P286MB3567:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5da0d8-48c7-46ce-c764-08db951d3409
X-MS-Exchange-SLBlob-MailProps: m1FWN9UA3JLuNowzViqllKXmXhrH/oplBgeKe00ICNr7HlZtIRPckprOc1kF8R8MUKAW9q3lPNuQcOCjDpqbU1Mlnj/lxDni/74g+W7OYlzBM+a3bBO5hz0rRKSpVKSw75RMa3Ck1YXTDN6h0V+NFRx4Wo9NexgN7eP0djaUB7iSnPfWNeA2he2ZND9xm8dhi5aCQkJQI5USS8i3w2Op9bT145Dgx0lm8yzaf/wxKTFhEN35yZtBMgY+rqXZ0C+zrieRUhoBCzlogu7AR5iZtWpv7WtAwHD2LcGDgacGMrmW+a3Hztp2wHQOksgV0qIZeaX8gese6Og507ek/0nAmWtfFU1ysaEqIsgLWMBqodiNUv7bTua6NgJWl3egYOKQfjUt2qn+ACf/GWvjbz/oOVJyOWYC3E6N2yzA+g7t1EDuKzAEvtyZrUuVDj0hG6RIy2s4KcabiEHjUfLTXFhvvTJlvdVo9GgZzf/iX5NKCdshNPdVlQWyuejGK05p58YNjywqYPZWwDxUDoVbvN+1nq0g+oEwSkOucD2cJojThthTOI5+uMEcbnv+av+fRA5d86dLHrQ9VJaoyarLcvHvRUDEY6YuzIyvKW4xkvVcKERjnHBlJ73JiTJ6r0hLM46fZ2LMyQlJEBcYoffy1rG9g+7oPeH6phmBFVIJO0KgPCJn4tx6XJZgW4CQ8g4myMW9rMRYw/pEvtA9lYgAZtfO37FAhhEkAqGyfdk+9WpWfH0S8eLgoMafpANZOE0q5ZA/kOIYfSjFmSm0DC2NyuNMHDJmoVvTOSfnwE5Dki+cpXqYWS7PZDhS1pTqriHS+lrdOPFgHZy1UMef1BB09Jrb34WXFN9v2FSaQVQNiFV6TcKSW1PK6ApokDx8e9AlemHQ
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iw4srVbFZ3IIaHJeHXvwfl1IEKu6ejLlt/VUclV7SpT920hxbv8xTHbW5aZwCYPP9MsQFDJ9CToarMUaQuB5hyKoW5Uwq3LhVduU8VZBuhM9n6UKAuvcjk3tD727KxQan8qw6oN5ljRSdMwHmy6stQn8Xv6AEeJR7Vwre4Av1T/p2GiXvS0e4rQsNNpzu0/U96Xt4qiv2KMgIuGqjKCWaq9sZMi8bxxlgM4GZyizaDxRpszRyr09B48yNeWYbYX9t//4UQP8BuJXgWyADzL136FEUFqETcJ87mkrTp7jKFQaxT74NEflbaj/ZF4Mq+2xMRFK51mCJ3YKrQNvTzaVYmRw6BiNmc03u4rt0V14QIcSwp9X4hzer4+TpTWuv34ZdWGivgTgAvvVUtAmS50lOE1DnFJy0b7ytrY+UncUOFp261z2m40nMPxQN2avW8X2e8QDrrM36Z1uCK21uCi+EXubruEVCSiR2Y9B4thW7BhSOJ/TFbUsgkyeUceyvhWhGa9qYcXMYAms+OTeFIpPOwlkDVUF5sgLNdYtjjxKnQOvkTnreuQ5bT2zZYfcd0t0Nn4I/kw+fsN4HWbGlTk9NcYkWiqDqt2Hy/OUejvdoCo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8IECvoZ9gRW2W06tYOqRkmcz8UYYjR203PQzKK92eBg/VfSv1lw1YczG4AjW?=
 =?us-ascii?Q?IhsL7LIPGaanDXfewju+UF04kRI8pVjnbA66NBdDqHm96vBKBuLL0NK9JA4X?=
 =?us-ascii?Q?uqD450rh3NSMLt8KxY3jZRnE+ngcnI2R+LhIrESIVV0xk1M/LSSWKQ9ZRKM9?=
 =?us-ascii?Q?RLQG1H8Kl9R2qKZG170rjusq7Qh4FtBlC2m50LwSG0mv/Xk92AwHhoVwjEKK?=
 =?us-ascii?Q?LCFatxjrVtpmQsaoDFpzf2GiMlmrfg5+3lu4SylT7JFrYxu37f1jmm/LTbzS?=
 =?us-ascii?Q?mhl/Zbar+7Kj8OKvM45Dd/nnbBI08Lfbc6SFBYnuW4DJ/zSzrlGn365zcPnM?=
 =?us-ascii?Q?YnLqoyOUKiuuGIwiJT71bEbKYAyTMCUmFY++1U36T8uCek/nTjzInhClS6RQ?=
 =?us-ascii?Q?IO8Uf1GdckxhEAiid9559s3MGzPg+/ynnqB9Nygoc+Yk4XGBa5C5NRvg98dV?=
 =?us-ascii?Q?/s/FI69kQXZIUaeDbw5k3hnbHOtWZJdo7OYTf/UXvjDw6X//2ARA//6+zWPv?=
 =?us-ascii?Q?F5PML18ICHdxi+OHe0wKG/hJMqWnJglEq5J+s3em0UEPXzMiORISBWo1afhj?=
 =?us-ascii?Q?tkEIigiyOwO2gw+dXiyw7OPkJFKDXBk6O9cKBAc/3VqNVfVsLEEGH5Cwrqr+?=
 =?us-ascii?Q?ZjMFxoPdQ/jp+iYTksSCp6yr4ax35PggiQ0k1cXWhzT4Y2NyY7QihCLmx3lc?=
 =?us-ascii?Q?A4gCPGAGBVu26Yb45M3PYVLR+TBGBxQhQKMfogBjSORyHtkteYku7wywT9oI?=
 =?us-ascii?Q?oxjxqUPme0sscXdNAeN93ogFUTduv4DbyT5z1GBFF/Q85W0rhXcO/yBnCpYR?=
 =?us-ascii?Q?sQ+q5xl0scj0o3BDJSDdLNzjhtUNuPgwDTMneforyS/pPll559Rx/gF2aGVb?=
 =?us-ascii?Q?EwZETKsnH0BUe8WuyMxEmg7FEoBOfswo9eXh5JNS35qP9n0KyCK5P7QvbUeF?=
 =?us-ascii?Q?9/pSb7v/vCA3h2C7yNMQQ5vqPHDNxqvamPrOoiU3tSOUu0wPAItFp88mkPrK?=
 =?us-ascii?Q?aTgvZowWoKWxfaEEl81hLn0DBBe9rUcKcEJJ/RfKGntupz9QisPsMvPGFdyU?=
 =?us-ascii?Q?d6cHuam8Xdmocm+Bvm1qC6yzpZ9Oo1t929mFSdwiiE57f9KToBAOJkDBEtCs?=
 =?us-ascii?Q?15HlPr8cZ0C2vkOSO/fE+K3xBFIb9gcxIlsB8eHLYOoRxU8Bbv6QtTD2LiIY?=
 =?us-ascii?Q?A6mINhA9PqMFq+qB9wXSJ/EJEp3EIXxRsne8BQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5da0d8-48c7-46ce-c764-08db951d3409
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 19:01:26.5744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3567
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
index 7b784a87efc6..943d40fe2272 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
@@ -145,6 +145,8 @@ davinci_mdio_default: davinci-mdio-default-pins {
 			/* MDIO */
 			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)
 			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)
+			/* added to support GPIO controlled PHY reset */
+			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_OUTPUT_PULLUP, MUX_MODE7)
 		>;
 	};
 
@@ -153,6 +155,8 @@ davinci_mdio_sleep: davinci-mdio-sleep-pins {
 			/* MDIO reset value */
 			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			/* added to support GPIO controlled PHY reset */
+			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
@@ -378,6 +382,10 @@ &davinci_mdio_sw {
 
 	ethphy0: ethernet-phy@0 {
 		reg = <0>;
+		// Support GPIO Reset on Rev C3 boards
+		reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <300>;
+		reset-deassert-us = <6500>;
 	};
 };
 
-- 
2.41.0

