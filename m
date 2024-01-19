Return-Path: <linux-kernel+bounces-31012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2E383278C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22A81C22D44
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099AA3CF59;
	Fri, 19 Jan 2024 10:22:31 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2061.outbound.protection.partner.outlook.cn [139.219.17.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8963C46D;
	Fri, 19 Jan 2024 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705659750; cv=fail; b=od8RM/0p4gUj35rf6EF373Gdhcjmxwcuj1RlgxIyJn+RJ4usPmrmJqk4gd/zmIZeFDstlgxFA+YX1KTbS8vWcbrj21za3Nj4X/3DP0vfxOyW4ec5Gqxk4Gq5zLdwGm7ivnU1J5CdGlGazJ2DH648oyETwxK641MCWmJJD650lc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705659750; c=relaxed/simple;
	bh=rhojD6LE0myUQztMgURDgIjTU8CozoBF2ZGuYE3u0bY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q+yyS1gPV6eRG3IaTd4B45LH+NGx+25jecXrYx7P5dK50iMVPvg/kdGn2eQf1G/cGL1+QSMv5vxYJ6mUSAdp62jh3KqK3vDnUEnys3cnVbEPnQZDWqi3zrIrSZ7AhQWklx6TOFEB6a9SAoqlbDBxHqyxXHGzVbM1AwwZNkajzvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEQq41WyyQ9IbdowWBCf4jA98V5oYpLaOezc31MC1kekdjjMeVmpUwIgLoQcPbLB07veu2vOKXoBHdqAiEeVaPe3gQ5vhhRmzNKlbC+tEM3JxtOCubPosecpR7mq6ACDjI8EpEiYHwHMpcfeBa5EnOw7q+IgRd6t+xUA2QhJqEWO5nIWv99BO+yqOvwloVCAlmKNhgoyzsD++94eeMt7Oxn4diqs3MgjikQWDvgAVCuUqCB4RP0em3tsyx8pDLcisrt36ZHt5P7ruyloagVGlbWF9AHMwB/9N1rByNGwvdSVPNTxAzYZdGomytAl3Ia75HgxSmpay+32Ak4hPp+4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQt+NPjW3aqssO2np4PS9UsVpWxFELpa4F/+LcEAmq0=;
 b=k/YdM4M38EUQJDQCN9R0HeXhJ7RYxG99DlWNZh4ZdL9DL8B7/jvFq5CeaoibYGiisqGwgfKnzqv1mNGW0ufeHRWbsb6faMRj7JwPGGwU8HjRdg1MCwE+O/iydcwhkYHPxVIG4OZtLOZqWMipkBi+ZJWz01S4uuAJN3kpYUPblNaLUrykRYMdx0//QySx4sPlUAG+Vgd5Oa5Mc1CCSc2qCP52+zR0cn3e2QhJ3o5ZkOGQPszJcsvvPRPpumIdKjLTGilUyM80kiD7+TPm85RNi3DWNMqMvEkv4VosCkfaRD03MngAF1JxQYEFjXCoweu6wlP14KNzQ6jKbmHaY/TZeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0558.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.32; Fri, 19 Jan
 2024 10:06:47 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::148c:e1dd:302a:196b]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::148c:e1dd:302a:196b%6])
 with mapi id 15.20.7135.033; Fri, 19 Jan 2024 10:06:47 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v1 2/2] riscv: dts: starfive: jh7110: Add camera subsystem nodes
Date: Fri, 19 Jan 2024 02:06:39 -0800
Message-Id: <20240119100639.84029-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119100639.84029-1-changhuang.liang@starfivetech.com>
References: <20240119100639.84029-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::9) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0558:EE_
X-MS-Office365-Filtering-Correlation-Id: fd94a6bb-5837-4038-29ee-08dc18d658c8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YjgWAaEPPV8IlB6k+fO7Ihtb6jUngTRJ6Te3iczEjxWGSE0q4gT4CVRej4vLPaO3ALQDTnzj4po6i8D3p2bwqK7ngKVsBMkddxggy9Y6CK2uTtx9nFqaGPbYBvZDNPoGDYPCzZIRWcNBtcwcRqaVRBrxLh5p+Ynej0b5pUGHyPbOrGjQDPi3s2mFwh4UqHO2rebhLb00e5W0QuPSw4bAcqDDz7560lqX/YDMzm73Oj0VzZosdOBx6HOLXIxIU8RdtsGeK4Qs1v05lcxxGYWfzFgPauVEJlqILYoUQ1BSJDE3MBN39XKU933xvAJ+WShAaXGFwBNlAEEZ7GRuQ4sR2GYpI2LFdjQxUWcBv0Y47Olo5dkZtdNPBmrBswKweeukM3ywJ3Z8+BfliJN6ZxZ6MJVTeCNGeyRs9ZyVUL1u9AIhv2YG7CW4At3VGhFmm6MafsrZoY1nBucOp+OgFZdfI+wChSI42IGghJxjoNiwBc5hWwpt8ESbZvYsll93YqQTUJOy3dDVs2hRlk+VOLx0sZISi1EAYTYW757mB6onUTJALL2W5otSA9nTDXdRefjr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(136003)(366004)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38350700005)(8676002)(6666004)(8936002)(83380400001)(5660300002)(4326008)(508600001)(66946007)(66476007)(110136005)(66556008)(54906003)(2616005)(44832011)(26005)(1076003)(52116002)(38100700002)(41320700001)(40160700002)(2906002)(7416002)(41300700001)(36756003)(86362001)(40180700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t0bHsBD12CT5wrNAR+ed4AwfycqLH8sHATnUNQR3RftN/+2HnSbJF14e30nT?=
 =?us-ascii?Q?G7bOADZ1h9MYSddZJTQIJRg4EgfqQ7DQXyE3O68L+YF4u9djQ8Emn1E3bu8O?=
 =?us-ascii?Q?eKbZwZZE2gBkl3HjhKtRAlgiGjYZM91/5fNWcVePKczAOypbefSjfO+9uvYr?=
 =?us-ascii?Q?PXOV/TsZmH9pdjQ+5Zm9drO36IUruZGrlx59BkpkRZUztE8gbUi9E4WR0z53?=
 =?us-ascii?Q?FU6kmGeoEz8+C3WCg6qoQlTIMMaTL5Zb+lobi7V9O100AYskk0y4APY8Z9/F?=
 =?us-ascii?Q?sC5RQ3X1Z7gJDS8gAZbcP8LSLKZAbzDg2gK4L+75H31s4VVeMuvic3Twsj/c?=
 =?us-ascii?Q?zvKNoclC6SbrRZ00amkjrDoVrDirK9SN2+SbYNLE2sREMnZVPh9Jksd4nc8I?=
 =?us-ascii?Q?LE4H2SHEhP942WWSjPexCJhd5r0jMtjNhFRInsvPkZV8NThy5DgKCaF4bIeQ?=
 =?us-ascii?Q?u3RzeSTneOC2VeXsotTTJxtEns6jaGUx93N+VmKdGQ9PQV5Yw28Z/iKXDy6Z?=
 =?us-ascii?Q?Ol/KtmUgzgJXYYid/qzOnYmlDJIP6AVp1XWbrV7v4wlqW4VqyRFSZLya4zny?=
 =?us-ascii?Q?Nkdq8EDMuU2x//t3R8XSHjZ66eT5D3BZJ6mLDV7dVhPRHPQGjO8YKk09qVfo?=
 =?us-ascii?Q?GI+iiNqz+mCHhYFXpegsLbJ7Gw4lVqL5YzECLews+wKIh5yQIuO2DLqdkSFH?=
 =?us-ascii?Q?DIf00dSUFb3mXSOogz7K9IOcmGpUteZe7O9prTUsc2z4Qh/VSDZ07bxQf0oy?=
 =?us-ascii?Q?tS0ET6GJLYrFxo5y8mw68F65tnTbSMIt6q8qDQXsntwRnRaVENjm5k/WS06s?=
 =?us-ascii?Q?ZXH98FAsDJJ7kZHkz22BZqNAf7K/gE+CYTpkevfkoVNyz601QRotTI84W0dq?=
 =?us-ascii?Q?KP8R0wZq3wYuluxH15Tld6h3TXo8eQjtTX2ijKtOShf59PYFE53divZTHoBp?=
 =?us-ascii?Q?/Q1cN8TJ424TKN5GZvE5b+BymEVA3MSSzUcJEEoWZ/D/9RxPylchWgN3rRZH?=
 =?us-ascii?Q?8qFgy13JXbkSRVBSIFsNOIft8hh/I/H074dCS4YH+/ye+ra8Ctyj36bdyj+r?=
 =?us-ascii?Q?Gd7YMxjC6NFWjJTJRh8lVThcZ3jAf8hEHw95xN/Waev0GiaK+CzKZVItZvIb?=
 =?us-ascii?Q?z/arG4sDpzqDw+UjdS4Ze45oQgN6neNLhNG80MrPRw0Z9n0H6ULJZTBscyLP?=
 =?us-ascii?Q?twgMQr4jZkeCl4ySCL97j3YjecslJgzqn8xgsrU+II/BL+lV2uRW4vZsEEne?=
 =?us-ascii?Q?HSjhsu7Vbsz5Nigs5nXELZLMUKtMpH9Eib1idQKPvp2cyOPhD39U75geFyPB?=
 =?us-ascii?Q?xhavQ44qRfREj5A8z1uYHAkLlcGra9D7e1pokQPU1wJM3XpbUCLui0Vsqbnd?=
 =?us-ascii?Q?AjSP7r3jBHxN2+o7ndh493ZyJAm0mp2l8PCo8Lc+J7Nh4oKicCf1B3p5Zhqn?=
 =?us-ascii?Q?NVG5Pz7FWMMBJturG4aAULPsQCHVKrXDt5l4h18kpLXxJ4J5NkgfigLWsV6T?=
 =?us-ascii?Q?z/zRzh7vrhW7fAiBZjrY0o70+D389MnAJFEB049PBQk6P4YvUdcXrOiG2KSc?=
 =?us-ascii?Q?v8AY/PK230u86SgCAh0x/3YxCYPiZ1gfE6qmwB5ohHUifR0X4u6f+KNvAjyS?=
 =?us-ascii?Q?weSc80bTcVLLEYFyMNj18rc=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd94a6bb-5837-4038-29ee-08dc18d658c8
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 10:06:47.2660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3R/qQR67wUh4NLhqWsIZOpEX4jqOkesZiGE2cCT83UOJILEHnTbn2yYJTjz27V9PXl8CeXW1kaAQNeYqISSZVALkifxO3LTF6l/W+/gzAvP8TMUPQ0id1k+LiSCn3hl3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0558

Add camera subsystem nodes for the StarFive JH7110 SoC. They contain the
imx219, dphy-rx, csi2rx, camss node.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 103 ++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  60 ++++++++++
 2 files changed, 163 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index b89e9791efa7..e0027bb379ef 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -30,6 +30,37 @@ cpus {
 		timebase-frequency = <4000000>;
 	};
 
+	imx219_clk: imx219-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "imx219_clk";
+		clock-frequency = <24000000>;
+		#clock-cells = <0>;
+	};
+
+	imx219_vana_2v8: 2p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vana";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		regulator-always-on;
+	};
+
+	imx219_vdig_1v8: 1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vdig";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-always-on;
+	};
+
+	imx219_vddl_1v2: 1p2v {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vddl";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+	};
+
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0x0 0x40000000 0x1 0x0>;
@@ -125,6 +156,59 @@ &tdm_ext {
 	clock-frequency = <49152000>;
 };
 
+&camss {
+	assigned-clocks = <&ispcrg JH7110_ISPCLK_DOM4_APB_FUNC>,
+			  <&ispcrg JH7110_ISPCLK_MIPI_RX0_PXL>;
+	assigned-clock-rates = <49500000>, <198000000>;
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+		};
+
+		port@1 {
+			reg = <1>;
+
+			camss_from_csi2rx: endpoint {
+				remote-endpoint = <&csi2rx_to_camss>;
+			};
+		};
+	};
+};
+
+&csi2rx {
+	assigned-clocks = <&ispcrg JH7110_ISPCLK_VIN_SYS>;
+	assigned-clock-rates = <297000000>;
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			csi2rx_from_imx219: endpoint {
+				remote-endpoint = <&imx219_to_csi2rx>;
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			csi2rx_to_camss: endpoint {
+				remote-endpoint = <&camss_from_csi2rx>;
+			};
+		};
+	};
+};
+
 &gmac0 {
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
@@ -228,6 +312,25 @@ &i2c6 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c6_pins>;
 	status = "okay";
+
+	imx219: sensor@10 {
+		compatible = "sony,imx219";
+		reg = <0x10>;
+		clocks = <&imx219_clk>;
+		reset-gpios = <&sysgpio 18 GPIO_ACTIVE_HIGH>;
+		VANA-supply = <&imx219_vana_2v8>;
+		VDIG-supply = <&imx219_vdig_1v8>;
+		VDDL-supply = <&imx219_vddl_1v2>;
+
+		port {
+			imx219_to_csi2rx: endpoint {
+				remote-endpoint = <&csi2rx_from_imx219>;
+				data-lanes = <1 2>;
+				clock-noncontinuous;
+				link-frequencies = /bits/ 64 <456000000>;
+			};
+		};
+	};
 };
 
 &i2srx {
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 45213cdf50dc..b4d1564c123c 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -1104,6 +1104,32 @@ pwrc: power-controller@17030000 {
 			#power-domain-cells = <1>;
 		};
 
+		csi2rx: csi@19800000 {
+			compatible = "starfive,jh7110-csi2rx", "cdns,csi2rx";
+			reg = <0x0 0x19800000 0x0 0x10000>;
+			clocks = <&ispcrg JH7110_ISPCLK_VIN_SYS>,
+				 <&ispcrg JH7110_ISPCLK_VIN_APB>,
+				 <&ispcrg JH7110_ISPCLK_VIN_PIXEL_IF0>,
+				 <&ispcrg JH7110_ISPCLK_VIN_PIXEL_IF1>,
+				 <&ispcrg JH7110_ISPCLK_VIN_PIXEL_IF2>,
+				 <&ispcrg JH7110_ISPCLK_VIN_PIXEL_IF3>;
+			clock-names = "sys_clk", "p_clk",
+				      "pixel_if0_clk", "pixel_if1_clk",
+				      "pixel_if2_clk", "pixel_if3_clk";
+			resets = <&ispcrg JH7110_ISPRST_VIN_SYS>,
+				 <&ispcrg JH7110_ISPRST_VIN_APB>,
+				 <&ispcrg JH7110_ISPRST_VIN_PIXEL_IF0>,
+				 <&ispcrg JH7110_ISPRST_VIN_PIXEL_IF1>,
+				 <&ispcrg JH7110_ISPRST_VIN_PIXEL_IF2>,
+				 <&ispcrg JH7110_ISPRST_VIN_PIXEL_IF3>;
+			reset-names = "sys", "reg_bank",
+				      "pixel_if0", "pixel_if1",
+				      "pixel_if2", "pixel_if3";
+			phys = <&csi_phy>;
+			phy-names = "dphy";
+			status = "disabled";
+		};
+
 		ispcrg: clock-controller@19810000 {
 			compatible = "starfive,jh7110-ispcrg";
 			reg = <0x0 0x19810000 0x0 0x10000>;
@@ -1121,6 +1147,40 @@ ispcrg: clock-controller@19810000 {
 			power-domains = <&pwrc JH7110_PD_ISP>;
 		};
 
+		csi_phy: phy@19820000 {
+			compatible = "starfive,jh7110-dphy-rx";
+			reg = <0x0 0x19820000 0x0 0x10000>;
+			clocks = <&ispcrg JH7110_ISPCLK_M31DPHY_CFG_IN>,
+				 <&ispcrg JH7110_ISPCLK_M31DPHY_REF_IN>,
+				 <&ispcrg JH7110_ISPCLK_M31DPHY_TX_ESC_LAN0>;
+			clock-names = "cfg", "ref", "tx";
+			resets = <&ispcrg JH7110_ISPRST_M31DPHY_HW>,
+				 <&ispcrg JH7110_ISPRST_M31DPHY_B09_AON>;
+			power-domains = <&aon_syscon JH7110_AON_PD_DPHY_RX>;
+			#phy-cells = <0>;
+		};
+
+		camss: isp@19840000 {
+			compatible = "starfive,jh7110-camss";
+			reg = <0x0 0x19840000 0x0 0x10000>,
+			      <0x0 0x19870000 0x0 0x30000>;
+			reg-names = "syscon", "isp";
+			clocks = <&ispcrg JH7110_ISPCLK_ISPV2_TOP_WRAPPER_C>,
+				 <&syscrg JH7110_SYSCLK_ISP_TOP_CORE>,
+				 <&syscrg JH7110_SYSCLK_ISP_TOP_AXI>;
+			clock-names = "wrapper_clk_c", "ispcore_2x", "isp_axi";
+			resets = <&ispcrg JH7110_ISPRST_ISPV2_TOP_WRAPPER_P>,
+				 <&ispcrg JH7110_ISPRST_ISPV2_TOP_WRAPPER_C>,
+				 <&ispcrg JH7110_ISPRST_VIN_P_AXI_WR>,
+				 <&syscrg JH7110_SYSRST_ISP_TOP>,
+				 <&syscrg JH7110_SYSRST_ISP_TOP_AXI>;
+			reset-names = "wrapper_p", "wrapper_c", "axiwr",
+				      "isp_top_n", "isp_top_axi";
+			power-domains = <&pwrc JH7110_PD_ISP>;
+			interrupts = <92>, <87>, <90>;
+			status = "disabled";
+		};
+
 		voutcrg: clock-controller@295c0000 {
 			compatible = "starfive,jh7110-voutcrg";
 			reg = <0x0 0x295c0000 0x0 0x10000>;
-- 
2.25.1


