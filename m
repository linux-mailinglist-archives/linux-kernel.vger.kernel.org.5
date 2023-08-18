Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02AC780AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376546AbjHRLLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376548AbjHRLLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:11:06 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2049.outbound.protection.outlook.com [40.107.14.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9573590;
        Fri, 18 Aug 2023 04:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xy7cg65FXcomaWs13rZYQqw+wzTGRY1RTBP/PFtKMPRWAYpxn1jvq/0HuEgPoyoJEhkKIVvrBFEQS1YSj6x1jbDZ9pQR6V9fX28NngwfpUFwPgHOEJ2256ygRN6rTJgLHVg+MBtvihaDatju++GISHk32ZS/TIfZ++dedSM7MPV40xKtnrCVgfR5aM7xvB8F/yVB7Ro+Ks7iHA3V8MThVf4p+p8ixsMcbu3Lv0kFo+QlCclk5bWJ5aDIjFpSiZjyLqYtuT/DKJ5oDOLWLvcu1YrlSxUFIRJkrvgmWBfoOJ1kx3tIZY3NHuglfCOCcOoPV0U83Kfl85R5k8J8mfx7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iloZxpRrqZ7sfbifm6n+C4drdnqyDKME1+p5lsCQpU=;
 b=JwFbV3mctEkaBKYZ93jt49+UpC4tIWnpwscLCW8rY009qD5hORzEuvagzgU29M1Tar0xw3rYXD3lSQcVdDZOEY6z67oEZ2Z3sGASH3zaGiV2bMsp/0QpHRG2gngOMfrunfnR0QTzKxS/wECVrFfw7RbS+rwuQOAEI4umm2ddHV0AxjtFHmXPKQRNODyvR8VJCdwthPcIBaLwl8V1oJ7f3vIJKIeSgivp2H+WnOZ7C1zuz5P+UUdvs+PxRKfkd28JEh5/UFqYpUVcv4Oad8K4nG4SqYbqJl8EI5VEHcdyPcRqKLIGnA9OnzC/OawUVX1Z/F95B/6i41+rZj+bkiRH2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iloZxpRrqZ7sfbifm6n+C4drdnqyDKME1+p5lsCQpU=;
 b=NC0K2JbtDTAknBWNEG1Kn5lL2JHTVCrMyfjDCICHRngSZg9fr1eBHBgEbd3+P7lVyFNLGl1n9tPBk1LgN1v1j6k+K6h9f/91myi7TonAzwBCypzD+9UzuS+vsHB9Kf0IZb3WFBlnkfwMHsBUXpzOWivsXEqPEK5sD2SK7pHpsiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DU0PR04MB9441.eurprd04.prod.outlook.com (2603:10a6:10:359::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 11:11:01 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b%4]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 11:11:01 +0000
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
        Tim Harvey <tharvey@gateworks.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marek Vasut <marex@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v5 4/4] arm64: dts: freescale: Add support for LX2162 SoM & Clearfog Board
Date:   Fri, 18 Aug 2023 13:10:16 +0200
Message-Id: <20230818111016.11271-5-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818111016.11271-1-josua@solid-run.com>
References: <20230818111016.11271-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DO3P289CA0013.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:1f::16) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DU0PR04MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: f062980e-f54b-4492-5461-08db9fdbce80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89xv5jmKFaXZTKYpmDDbteM4EeYTxvzmjm6RnCmmIec+j7JhH4dVBcBpAoT4PSr0Gus9fMxVUgTSQzqEQd1bF8maWHjLMayxTiegXwJtYoXe6jIUurNHAGcuTqMTbLYQ+RjHVyhAyTQ3av9rL+bJq397OO2WvKd2cEVo3/5A1CD3yPv2vpCAObi+lwG5wEOafGQoH8pPfBf9UOYOLR8U6EjrFuNvhh7FcTbkyuNX4J7hgQQfoAu4LvyRj9HBMJ77CxVxHDAGsXFyGEoevuLSKWwdmqIKdQSeBPDaeGZAAeu+X6FaWHNXsIzt/WkMLpRFh6WylrjAnPUykONri7uFzVU+ERMNL+S3qh8T5nTU6RgubVPrinHrjQHffh63wpthAewQNdOFm6G2GrkNTSWq4IqHve+8i5xmMHdv9/22UzGkuZPmRWHUCKXna7hVEoK7ExUIpoLe5vsMh3m1xyDYN2RJurkmyvSfj7Dul48DtxvqbBkOFAUwKi1mbehlivjnvVxieSweWUAYtIu3YWVU9B5vOVRZ7e2UQ9A2wNHfLTFlgfCThtsOGKwDcx55bGs3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39830400003)(136003)(451199024)(1800799009)(186009)(316002)(2616005)(1076003)(6666004)(6486002)(6506007)(52116002)(6512007)(30864003)(83380400001)(4326008)(5660300002)(8936002)(8676002)(2906002)(7416002)(478600001)(41300700001)(54906003)(66476007)(66556008)(66946007)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6zsCjG65/fXrfrILPhLzX0hI6lSoksx3ExHsvnyB9HFLuIlgXPOQ+ZnzO/TV?=
 =?us-ascii?Q?7W6m5JXu0VCRstqqNheHfSwLuergWtafBVC/a3962nk1b+yw5I8gt4e5rS3O?=
 =?us-ascii?Q?+nQBtWCItTY7til1nSkpwGjL0dbZoxBBiyMfu0tsBP98bTc1L7kS5SxMuBhg?=
 =?us-ascii?Q?7bU+H8CumjbWwTK0gPyktPXGmC14V17PELBnNliXsc5pIpPgrcPF/q4ljIV1?=
 =?us-ascii?Q?C8Gc+YhEXyI/CXSZ6d5xRfO8eW3hjo8t/EFqAtqFch9lpS4zc7wZdhkshJ8d?=
 =?us-ascii?Q?7ac8WjMX7eRmND7Wz4Y9FKyyKsbN3p/xl25R0WII2zCk2sTsSb3MbTwcjALr?=
 =?us-ascii?Q?IljQcHg074KsJ6oPxDYi1FEUWI1mTMASW+eMkeLg2FUzgSo3CeVIslnDUfDv?=
 =?us-ascii?Q?1Z6FhKZCwyj/hTMsg9x0OQuZC6Y+7u9BTNWV4P6TTvQ1huSbLgVJh2eWsXb8?=
 =?us-ascii?Q?72hc+TAxES3OfrTUDQAIJH0bx5SsK1bM6VprnQGWHCGSyYErRfJd0YubEimq?=
 =?us-ascii?Q?+nXC7SlBcr9c4HfpBTijBJPvABauooCfeBeCOI1apK0kF/Of9onX2v+lIYbL?=
 =?us-ascii?Q?qYd1On9XVNq/Gg/LqwlXmmdXoJ6NZ7Hv1t3Ihpag7R3+QkDF5KO8M2vzoTRQ?=
 =?us-ascii?Q?CMHe684LxPfBDQfOtAdEDx7Mg/0hOrlIWjVxONXZza1n++/TA3rz8brYNSXz?=
 =?us-ascii?Q?JOtaeaIJJnU9mZ6Y+FqivyeIVXRkzTzzAAv9niJo890kgpIiukIJew6FeXHN?=
 =?us-ascii?Q?X70jOZbQ1PaBchiQYq24LjtMRVAyl1IFDs6MzCP9PzohupmwytzsKerG8q9d?=
 =?us-ascii?Q?mKEJlY+NGxtG6CV+mBU1eJSEN81jXCj2NldanizP/MmoUUdd/0iMv8SVVloM?=
 =?us-ascii?Q?/95L8gajGHhGbXd8+lIse30IaNIq6Z4t7s9sDEQE+4YhDcINM8VvjvrITX9r?=
 =?us-ascii?Q?nJmg5gLV3fFsW6S4ucsZmd+TzW3xGYjaMbPUWwwMOc1SrBcYD+SsZosmN+51?=
 =?us-ascii?Q?eLTDLOYVDxfcfCp0Sz1PxNABQg6khyfn5yBiHm8F35OHVyoRaWEPyAYoLm9w?=
 =?us-ascii?Q?W/vJqm/SzdiFNbGEUmf3LGLyHXWWbW7HFx0P4KbDXNV0NZNGkv4fAZdNqWOI?=
 =?us-ascii?Q?XuGOnpriD4KdRAGJcCj0hQe2YZrha99UKtBRsizERBrwRHqCtXZ7XRpdm5So?=
 =?us-ascii?Q?zZXs8G9UsE6Q30vcK7eeRPHP3lNts6Krhl76Gc66cMRw55WmwMD1gXCwGr1M?=
 =?us-ascii?Q?ShpBZhKtmXYXDTtYE4p4/zpDu51sSBNw/lcQzRk3xbxtAEmun+RtluAkg3qf?=
 =?us-ascii?Q?WHfEL1b51zrbOnRJbz8pIJTx3w6UFYP88Ch7qW36/tEhxBI1SUnrZdHMlq4E?=
 =?us-ascii?Q?npsJMohFQaTQ/DHTJJoBwhIz/1HHglFFU1WiM+6QaiHDXX2lqFt6jv0SRGm4?=
 =?us-ascii?Q?pcpvCzGzC6S+1tkJt5NXcBrw4j1r1YoymZ2dki6PIqo1CqRznLZmnfzvHQz3?=
 =?us-ascii?Q?n/ykuF1u4MCJieMIkmj+I6ZquiFnxTmAtoRKhA9bZfosNDTA0MJQO+ePiiZT?=
 =?us-ascii?Q?TyPOBVAB5B4UNUYwirG8hwD40YWAb5GxvGLWp4Imitp5qtQcsL+QtzrJcfbE?=
 =?us-ascii?Q?8oDH3IMBwQSKUt5yIUr+6fQ=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f062980e-f54b-4492-5461-08db9fdbce80
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 11:11:01.8330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BclpNKbuRGQqziXO9A7XZCtcjW1t8Fa4bw5kBoA3Ti9vHC0KxhB8KGkNKpOXFbbZ/UM0bC2vCmhgvUCvhIfkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9441
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/fsl-lx2162a-clearfog.dts    | 373 ++++++++++++++++++
 .../dts/freescale/fsl-lx2162a-sr-som.dtsi     |  73 ++++
 3 files changed, 447 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index a750be13ace8..9448d2effd8a 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -34,6 +34,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-honeycomb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-clearfog.dtb
 
 fsl-ls1028a-qds-13bb-dtbs := fsl-ls1028a-qds.dtb fsl-ls1028a-qds-13bb.dtbo
 fsl-ls1028a-qds-65bb-dtbs := fsl-ls1028a-qds.dtb fsl-ls1028a-qds-65bb.dtbo
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
new file mode 100644
index 000000000000..ad57f4cca62d
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
@@ -0,0 +1,373 @@
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
+		led_sfp_ab: led-sfp-ab {
+			gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>; /* PROC_IRQ11 */
+			default-state = "off";
+		};
+		led_sfp_bt: led-sfp-bt {
+			gpios = <&gpio2 13 GPIO_ACTIVE_HIGH>; /* EVT1_B */
+			default-state = "off";
+		};
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
index 000000000000..ac3f9bc60265
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
+	status = "okay";
+	bus-width = <8>;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
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

