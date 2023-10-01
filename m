Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B78A7B46EE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbjJAKeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbjJAKed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:34:33 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2049.outbound.protection.outlook.com [40.107.14.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B031103;
        Sun,  1 Oct 2023 03:34:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIFINtJc4JWq+CZtmg37ZFiC51oIq+nXSELeftjL9GuGUCiWKNZ80XvHwa99DXDl5JFRP1R6MaAY8eyp8JBOln1vtP8UKBrikIZbhitEgmBsidEwaAuPZYr1Ip+IlL/gMnJxZ5TS/ACdnOXWmvET7maiOoil9ITnAVvO/rRXSI8s7YWAI+VWMhbVFEb7uOJZh7yDY5m7+KjdH/CB7Lqto/M1kCGLW/aEmZG2lZntzU5jtdJWTWxKoPTw25ijTnqaZgTZdIislsVXOxGipAKiQJHlp2RlDnF1eRTvELrIxLM9dfyYNfdfnhvSULVz4kKA/M/aTj2Gypdzer2gK5yx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCidCsCnAfr5ei5K0UOQ36OqMvouTZeaxqOFkQ9gYQs=;
 b=EJw6ZdYFselaLFEUXuwpQb9YTsW3Anr4vxUv778NjRRJ687jZq1t1CLBIkl2I5FlyfJjhsnifl9k0nP2mmM8JKUp1aQ/ahptOOf6qY4xZhi6DQ4G0qRphieVzvqZKsBOhaMawOQuEkY/u2D6Df+R9cUtiAtIvVNkdqh3hdlpOBmqp5XCAdj7d6sTrtS5taVqRP9lapOsy/pH+7K/vELC0b1vft2PyuZaZnIfQ4CMS2vcOwk/GDW4IMxJ0S+nipQreDl2TPpW1vDcq8fUB9vgOGZM4UkJSdAbsGSRNNtSLmytp99AaGYOdu9prznkep5E26VoqWFvKLgbajjLrAhXxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCidCsCnAfr5ei5K0UOQ36OqMvouTZeaxqOFkQ9gYQs=;
 b=HFtCdSe4Z1FBO++M+H2UEZ4MyxHBLA/XFHQ6UGOxkxRowdRzsqt++4ln3n/l3NshKLruQUG7UonlTLWcElHlobfoUC0kffS/buWzVSkoyRzz45jnGj0DglxFV25A08lSf2iHAvUspuOWnnuzsD5C0fgGxW8oCXS5KVyOkr6j15g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by PA4PR04MB7584.eurprd04.prod.outlook.com (2603:10a6:102:ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 1 Oct
 2023 10:34:26 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::cc84:fc7a:cffe:985a]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::cc84:fc7a:cffe:985a%7]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 10:34:26 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Josua Mayer <josua@solid-run.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [v6 4/4] arm64: dts: freescale: Add support for LX2162 SoM & Clearfog Board
Date:   Sun,  1 Oct 2023 12:32:59 +0200
Message-Id: <20231001103259.11762-5-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231001103259.11762-1-josua@solid-run.com>
References: <20231001103259.11762-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0151.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::12) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|PA4PR04MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 6357c5a3-a684-4b16-a5b5-08dbc269fc5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6MzcLXjdlZT2MdGOjrdKwa8SodAAxKtaH3Ebx2GjJLysk5+9T0Cy27jozWsRubgkbhlXKF+fDUE2latGoeABegBZilQWA09ebA9GaExkk8l7BCdYZxsU487iLMMAIFQOEKmGHuqIVkcEnCvtu1cPNnow27Q3pvUDXHI7Pf2h2Ap66O7XXk0feFiSv1a9waLl9J9aq0i651a/bIvu4eeNJVCa5qZ7MobWwmrhLM9N/JFNg/5dzGBJz+Q2uG+fUOac8Vj9PWQEyzR5eVQs5jB67t41/XhVUjPSERuJvtOwS5Ci9vBGCG1eyIAFf1bDw8f3/xrAbCHvJhZl+CsvhkzUTl5DsSU0HrxvNHG2THhX+1M7DMZ9fimDWHRKDeQJ+73pcjXvHjwxhteH92zajv+WpHiXikYsUoRsLDpSwhTo8u/s7ZmboT6kVCHRxHrtjPiJno9QbmOwM7EpgIKF5iZfS6LxkW663edEj42+7/RZrBiGBwlVvPvKozSlt04QuQRtxbw14IJNcw/qyRXjuCzUvieOR37+nOH0iGo+u0djTFFx/zFOw9+E9kp5EFV+BGcTB0T5ZmgyV/XdrpZT5D4O+dDbvamJiKeMkQlind7r7lqLrBL8CTk55KHYFGBMc0H+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39840400004)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(41300700001)(52116002)(6506007)(26005)(5660300002)(8936002)(30864003)(54906003)(7416002)(2906002)(8676002)(4326008)(316002)(36756003)(86362001)(1076003)(83380400001)(6512007)(6486002)(2616005)(66946007)(66556008)(478600001)(38350700002)(38100700002)(6666004)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uF5kJFw8Xxjb8mZku/OJq8XOVCXnky3/jtWxsgY0ya22Ty42WT9D0FdbKSmK?=
 =?us-ascii?Q?d0DB6HmQBQx2IkejD/q4lEsXCF4PTxN1pgPuTwh7TpKljOZn1EQ5CKJ2uklP?=
 =?us-ascii?Q?n7oNlTvUyhugkFgUvfmK4RhOKVwEHYZPUXk/d+HkWTgbyqGc8fw9G8gJdyFP?=
 =?us-ascii?Q?utDvvv2XoHQwg6dtum5SBJOS7CBC/p/0rOGZKRu+bAm6RSVi/sI8pj4nx8/O?=
 =?us-ascii?Q?ptal1xDev9cP+zD2K3IyvNGlHIz2KZG/tTbeLAjRTglC8XdNdOMVJ7PhmMPY?=
 =?us-ascii?Q?W8qlGx7hFWwXmEjWlIjpkgiJN/xzX1pjFWinB6r7NuY1rqVPEPZpDscWIqop?=
 =?us-ascii?Q?F7XreTFl+q+g5GKLidFLNnnL/9z14LG4JRZ8GuY9hFb/uaTKAkY54821CEW8?=
 =?us-ascii?Q?Deq1tu1tapKM5o5xJhkaLS0NGiKMy6Tc1HxmeFxOJD0W8gb8V37dW9fn5ckA?=
 =?us-ascii?Q?LW48gYh2gMO62ke4UN84fVC0rnI0M/Fz1by6uqXmS+7XFPiMdeAGpon8uh+m?=
 =?us-ascii?Q?pd/W/bjEJxehO2MQSzR1l0wlR+HSiYLDrzU71ce3pCQjxEmroK0DjNBe8CJ7?=
 =?us-ascii?Q?P0p6z3fGC9HwjQnSgLFiVttoKSjgrW1ZerkVP7U64H2mgnHwEacsY6MsDroD?=
 =?us-ascii?Q?uxhLT2G25AiObIvFfeKzy4RuR661Mi6DISIZzdMAIGd79j8adFjbdPlD5Yu7?=
 =?us-ascii?Q?054ZNvPIDrWwi/Eat/G/vPObJL7UVcMgIgavn3Aqf906P5Jn1WweTPoFh4xL?=
 =?us-ascii?Q?YG5KiQYGktZLFc6bkXtUtSzdXawODc8gpjp7MXks78h5x+tXO6b65rZ8ERwr?=
 =?us-ascii?Q?G3QbARCqikgEPlLQ+bROfLaDdkqtOuIGgn7m5ftyNv7OYRL/r3w76JtN4GuG?=
 =?us-ascii?Q?7YC1JJCAP2uTxZyM+U/sK+7fVNUdiMy4/31tOEN+aQXdo6RmB2x6NzSARA8A?=
 =?us-ascii?Q?SA1MaWmhOqktVjWv+rQyIR9T2Jqu3bKKdp2WeaGmEZk84igxk4yMJM+NW2lW?=
 =?us-ascii?Q?aw487xI/AI3wIu1nLQfEt5rxWSkHonuhDd7GmXOxJWou1dGAQkAQqsPzeYUY?=
 =?us-ascii?Q?FnodAwwo+YkUh5z5jjNQz1yj3A2H6cWS+geryeKt7r1dOJYvy0l19HUAmYEn?=
 =?us-ascii?Q?PN3W4iq39YCfAiAGcOLTiGIpwUg6RqXzCFRmkk2KkarsrFVVeRwBnOsBdZHE?=
 =?us-ascii?Q?78afqDFI5h7Aa5/MwiwSXkNORphC1M/Bm/yjvOaN0Qhh27yjKWYRArGWSpHk?=
 =?us-ascii?Q?NCuwUitwlIghlvlJFTXE9rAeNO7MsCeE8mjqtNLEeiwpUtPjpWE2L+ruQrI6?=
 =?us-ascii?Q?q7AiNoz9tE08bRi9csVKioKZncdSGFlvVilF+WASXhnQ5eCw3zPtRk2piChr?=
 =?us-ascii?Q?5gtP+UqbwShoY9rXhS77Z+mtEKZzH9TSIeO7TwFCWF9CmjR6xjdR0c1lb+PR?=
 =?us-ascii?Q?/bsvgSino0JxKzzRIw9P6H3vPikmYnoUn62jko6RuA94C3MTRWj9NrnHpror?=
 =?us-ascii?Q?zqVPhFj3/t/VQfP1nqSMCWBtb32sEIbSAmEq9iVhbwnP4Cf15kE/R2AjpnYQ?=
 =?us-ascii?Q?m3xteTlppF4TI3Rn2HpYNCXAGv8AxYIRZU0r0Pb7?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6357c5a3-a684-4b16-a5b5-08dbc269fc5f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 10:34:26.6069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaztIviw9iaQOebKAZpZ0rclZnOZSSEL76yRypEDnr/72Gu2uRJ6R1NwLbjtArzQWPTaGeGoFbtZjMN7pyBxIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7584
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the SolidRun LX2162A System on Module (SoM), and the
Clearfog evaluation board.

The SoM has few software-controllable features:
- AR8035 Ethernet PHY
- eMMC
- SPI Flash
- fan controller
- various eeproms

The Clearfog evaluation board provides:
- microSD connector
- USB-A
- 2x 10Gbps SFP+
- 2x 25Gbps SFP+ with a retimer
- 8x 2.5Gbps RJ45
- 2x mPCI (assembly option / disables 2xRJ45)

The 8x RJ45 ports are connected with an 8-port PHY: Marvell 88E2580
supporting up to 5Gbps, while SoC and magnetics are limited to 2.5Gbps.

However 2500 speed is untested due to documentation and drivier
limitations. To avoid confusion the phy nodes have been explicitly
limited to 1000 for now.

The PCI nodes are disabled, but explicitly added to mark that this board
can have pci.
It is expected that the bootloader will patch the status property
"okay" and disable 2x RJ45 ports, according to active serdes configuration.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
V1 -> V2: reordered "compatible" and "reg" properties
V1 -> V2: replaced chip-specific DT node names with generic ones
V1 -> V2: removed dead code from fspi node
V2 -> V3: dropped deprecated address-cells, address-size props from flash node
V3 -> V4: reordered dt properties such that status is last
V3 -> V4: changed ethernet-phy on som from /delete-node/ to disabled
V5 -> V6: reordered status property in esdhc1 node
V5 -> V6: moved i2c2 node by alphabetical order
V5 -> V6: added empty lines between led nodes

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/fsl-lx2162a-clearfog.dts    | 376 ++++++++++++++++++
 .../dts/freescale/fsl-lx2162a-sr-som.dtsi     |  73 ++++
 3 files changed, 450 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index a750be13ace8..50574f711bec 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -33,6 +33,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-clearfog-cx.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-honeycomb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-clearfog.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
 
 fsl-ls1028a-qds-13bb-dtbs := fsl-ls1028a-qds.dtb fsl-ls1028a-qds-13bb.dtbo
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
new file mode 100644
index 000000000000..9f88583aa25e
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Device Tree file for LX2162A Clearfog
+//
+// Copyright 2023 Josua Mayer <josua@solid-run.com>
+
+/dts-v1/;
+
+#include "fsl-lx2160a.dtsi"
+#include "fsl-lx2162a-sr-som.dtsi"
+
+/ {
+	model = "SolidRun LX2162A Clearfog";
+	compatible = "solidrun,lx2162a-clearfog", "solidrun,lx2162a-som", "fsl,lx2160a";
+
+	aliases {
+		crypto = &crypto;
+		i2c0 = &i2c0;
+		i2c1 = &i2c2;
+		i2c2 = &i2c4;
+		i2c3 = &sfp_i2c0;
+		i2c4 = &sfp_i2c1;
+		i2c5 = &sfp_i2c2;
+		i2c6 = &sfp_i2c3;
+		i2c7 = &mpcie1_i2c;
+		i2c8 = &mpcie0_i2c;
+		i2c9 = &pcieclk_i2c;
+		mmc0 = &esdhc0;
+		mmc1 = &esdhc1;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led_sfp_at: led-sfp-at {
+			gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* PROC_IRQ5 */
+			default-state = "off";
+		};
+
+		led_sfp_ab: led-sfp-ab {
+			gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>; /* PROC_IRQ11 */
+			default-state = "off";
+		};
+
+		led_sfp_bt: led-sfp-bt {
+			gpios = <&gpio2 13 GPIO_ACTIVE_HIGH>; /* EVT1_B */
+			default-state = "off";
+		};
+
+		led_sfp_bb: led-sfp-bb {
+			gpios = <&gpio2 14 GPIO_ACTIVE_HIGH>; /* EVT2_B */
+			default-state = "off";
+		};
+	};
+
+	sfp_at: sfp-at {
+		compatible = "sff,sfp";
+		i2c-bus = <&sfp_i2c0>;
+		mod-def0-gpios = <&gpio2 16 GPIO_ACTIVE_LOW>; /* EVT4_B */
+		maximum-power-milliwatt = <2000>;
+	};
+
+	sfp_ab: sfp-ab {
+		compatible = "sff,sfp";
+		i2c-bus = <&sfp_i2c1>;
+		mod-def0-gpios = <&gpio2 1 GPIO_ACTIVE_LOW>; /* PROC_IRQ1 */
+		maximum-power-milliwatt = <2000>;
+	};
+
+	sfp_bt: sfp-bt {
+		compatible = "sff,sfp";
+		i2c-bus = <&sfp_i2c2>;
+		mod-def0-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>; /* PROC_IRQ10 */
+		maximum-power-milliwatt = <2000>;
+	};
+
+	sfp_bb: sfp-bb {
+		compatible = "sff,sfp";
+		i2c-bus = <&sfp_i2c3>;
+		mod-def0-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>; /* EVT3_B */
+		maximum-power-milliwatt = <2000>;
+	};
+};
+
+&dpmac3 {
+	sfp = <&sfp_at>;
+	managed = "in-band-status";
+	phys = <&serdes_1 7>;
+};
+
+&dpmac4 {
+	sfp = <&sfp_ab>;
+	managed = "in-band-status";
+	phys = <&serdes_1 6>;
+};
+
+&dpmac5 {
+	sfp = <&sfp_bt>;
+	managed = "in-band-status";
+	phys = <&serdes_1 5>;
+};
+
+&dpmac6 {
+	sfp = <&sfp_bb>;
+	managed = "in-band-status";
+	phys = <&serdes_1 4>;
+};
+
+&dpmac11 {
+	phys = <&serdes_2 0>;
+	phy-handle = <&ethernet_phy3>;
+	phy-connection-type = "sgmii";
+	status = "okay";
+};
+
+&dpmac12 {
+	phys = <&serdes_2 1>;
+	phy-handle = <&ethernet_phy1>;
+	phy-connection-type = "sgmii";
+	status = "okay";
+};
+
+&dpmac13 {
+	phys = <&serdes_2 6>;
+	phy-handle = <&ethernet_phy6>;
+	phy-connection-type = "sgmii";
+	status = "okay";
+};
+
+&dpmac14 {
+	phys = <&serdes_2 7>;
+	phy-handle = <&ethernet_phy8>;
+	phy-connection-type = "sgmii";
+	status = "okay";
+};
+
+&dpmac15 {
+	phys = <&serdes_2 4>;
+	phy-handle = <&ethernet_phy4>;
+	phy-connection-type = "sgmii";
+	status = "okay";
+};
+
+&dpmac16 {
+	phys = <&serdes_2 5>;
+	phy-handle = <&ethernet_phy2>;
+	phy-connection-type = "sgmii";
+	status = "okay";
+};
+
+&dpmac17 {
+	/* override connection to on-SoM phy */
+	/delete-property/ phy-handle;
+	/delete-property/ phy-connection-type;
+
+	phys = <&serdes_2 2>;
+	phy-handle = <&ethernet_phy5>;
+	phy-connection-type = "sgmii";
+	status = "okay";
+};
+
+&dpmac18 {
+	phys = <&serdes_2 3>;
+	phy-handle = <&ethernet_phy7>;
+	phy-connection-type = "sgmii";
+	status = "okay";
+};
+
+&emdio1 {
+	ethernet_phy1: ethernet-phy@8 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <8>;
+		max-speed = <1000>;
+	};
+
+	ethernet_phy2: ethernet-phy@9 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <9>;
+		max-speed = <1000>;
+	};
+
+	ethernet_phy3: ethernet-phy@10 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <10>;
+		max-speed = <1000>;
+	};
+
+	ethernet_phy4: ethernet-phy@11 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <11>;
+		max-speed = <1000>;
+	};
+
+	ethernet_phy5: ethernet-phy@12 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <12>;
+		max-speed = <1000>;
+	};
+
+	ethernet_phy6: ethernet-phy@13 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <13>;
+		max-speed = <1000>;
+	};
+
+	ethernet_phy7: ethernet-phy@14 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <14>;
+		max-speed = <1000>;
+	};
+
+	ethernet_phy8: ethernet-phy@15 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <15>;
+		max-speed = <1000>;
+	};
+};
+
+&esdhc0 {
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	sd-uhs-sdr25;
+	sd-uhs-sdr12;
+	status = "okay";
+};
+
+&ethernet_phy0 {
+	/*
+	 * SoM has a phy at address 1 connected to SoC Ethernet Controller 1.
+	 * It competes for WRIOP MAC17, and no connector has been wired.
+	 */
+	status = "disabled";
+};
+
+&i2c2 {
+	status = "okay";
+
+	/* retimer@18 */
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		sfp_i2c0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		sfp_i2c1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		sfp_i2c2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		sfp_i2c3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		mpcie1_i2c: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		mpcie0_i2c: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		pcieclk_i2c: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			/* clock-controller@6b */
+		};
+	};
+};
+
+&pcie3 {
+	status = "disabled";
+};
+
+&pcie4 {
+	status = "disabled";
+};
+
+&pcs_mdio3 {
+	status = "okay";
+};
+
+&pcs_mdio4 {
+	status = "okay";
+};
+
+&pcs_mdio5 {
+	status = "okay";
+};
+
+&pcs_mdio6 {
+	status = "okay";
+};
+
+&pcs_mdio11 {
+	status = "okay";
+};
+
+&pcs_mdio12 {
+	status = "okay";
+};
+
+&pcs_mdio13 {
+	status = "okay";
+};
+
+&pcs_mdio14 {
+	status = "okay";
+};
+
+&pcs_mdio15 {
+	status = "okay";
+};
+
+&pcs_mdio16 {
+	status = "okay";
+};
+
+&pcs_mdio17 {
+	status = "okay";
+};
+
+&pcs_mdio18 {
+	status = "okay";
+};
+
+&serdes_1 {
+	status = "okay";
+};
+
+&serdes_2 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
new file mode 100644
index 000000000000..0580ea30cfbc
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Device Tree file for LX2162A-SOM
+//
+// Copyright 2021 Rabeeh Khoury <rabeeh@solid-run.com>
+// Copyright 2023 Josua Mayer <josua@solid-run.com>
+
+&crypto {
+	status = "okay";
+};
+
+&dpmac17 {
+	phy-handle = <&ethernet_phy0>;
+	phy-connection-type = "rgmii-id";
+};
+
+&emdio1 {
+	status = "okay";
+
+	ethernet_phy0: ethernet-phy@1 {
+		reg = <1>;
+	};
+};
+
+&esdhc1 {
+	bus-width = <8>;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	status = "okay";
+};
+
+&fspi {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		m25p,fast-read;
+		spi-max-frequency = <50000000>;
+		/* The following setting enables 1-1-8 (CMD-ADDR-DATA) mode */
+		spi-rx-bus-width = <8>;
+		spi-tx-bus-width = <1>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	fan-controller@18 {
+		compatible = "ti,amc6821";
+		reg = <0x18>;
+	};
+
+	ddr_spd: eeprom@51 {
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x51>;
+		read-only;
+	};
+
+	config_eeprom: eeprom@57 {
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x57>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	variable_eeprom: eeprom@54 {
+		compatible = "st,24c2048", "atmel,24c2048";
+		reg = <0x54>;
+	};
+};
-- 
2.35.3

