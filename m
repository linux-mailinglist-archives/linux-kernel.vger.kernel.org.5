Return-Path: <linux-kernel+bounces-27047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B76182E9AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41FF1F23A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149C610A21;
	Tue, 16 Jan 2024 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="LsOdtJrH"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2080.outbound.protection.outlook.com [40.107.215.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399ED10A05;
	Tue, 16 Jan 2024 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFLJ8dkCpZYm1Vs5i4Hm0zFdVuLldLl+0JAqNQlPN46+MAud/4ZK2XYBLbltg9u6GbDQw5m/lP7cPutf8cN97Dah9u0Zy67gASIysa4jcSQ1bxfgtpUj9VM/eZ9o6pQ/661UppZP4vI3siqRFUn2ZrMi2ozn7BzlnfVRfEsb5nmOio4ycVSnWdii+C4VFOyx4CayqX5EASd7HkUt5Y25EPLvM2f+1+6B2H0jTRxuumZVXami7mPq0msSIfn5Rk6yRd6Luu8i/IbGrzylMEm8FRLjcXVq1TuJXhfDjdblC9A5tiit+LsNwcGRjxJ99RvbRLuPO24UQuNiWE4Kf93I6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZVJ3RffjKNtjEyF9SPH85azrY49mwId68lPlv3KDCc=;
 b=CPWD6oISNC54tNwAaH/UsywukqOl0TKXM9nWuK7UJ/HH1zr8IPvx5y1w4qqGbrWQcOUChYFwp8QQB1vljuaDeXTXPYANQer0BE5Qh1xQCKl7vbyZ3TBYnmjcthN3CeUtBKSegSbfiS48bjKGODekA7QYzbPBvQEfnlakZi7hPMguCejI8Oqdfx0Mf1nHGnbgGJ8bpOV1gTD9zgDDLjCZxUifG2gVuNSSb9XCqDHc0eBOJjfymAgSCF7lUifdIosau6p7ETXeDXhBA2bgTFfOSIF0MM/9b4kCqzxlxzBxmbK4WCX32LdXMbpMoxuiejlcXqxugxIdrjcjJt1vRhCRXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZVJ3RffjKNtjEyF9SPH85azrY49mwId68lPlv3KDCc=;
 b=LsOdtJrHMkNdstkOQ+Z+r4opXW1I82HURnvDpvDxzrtdf3jHayNOI2qADgvvyWb+k7DeNJomkpaDsxNBkgu//ms6hvjbrhld2OSnvUyMDJYKjwqNnfQIKKc5L6CjfU5hEQ1K6pbIP9AMhGfBxi5vqMfRMTImtpBroptiPdDZgMJZYnT+DUPnkKapkznI74DabYZwjND1UsYVJzOOGT0eyZKxIUpgnWw9PvZPEAO1FzS1ZmqYq3EWlhP6rlt83rfQgHerTO/3/lUoy5WwZxfaWzoruHM86WeZoGncDaDMWoLbNt3op0viJoLWdpNpIPWN1ZZI15X8olDNPSUCTagtMA==
Received: from SG2PR01CA0159.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::15) by KL1PR0401MB4417.apcprd04.prod.outlook.com
 (2603:1096:820:2c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 06:50:53 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:28:cafe::69) by SG2PR01CA0159.outlook.office365.com
 (2603:1096:4:28::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23 via Frontend
 Transport; Tue, 16 Jan 2024 06:50:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server id 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024
 06:50:51 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: dts: aspeed-g6: Add I3C controller nodes
Date: Tue, 16 Jan 2024 14:50:49 +0800
Message-Id: <20240116065050.3657049-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|KL1PR0401MB4417:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 960d0c13-2eb4-4af5-6731-08dc165f7b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	71Evxm0J6B9miGKh1F2cdsRPGqPtppxP1E27FMOWO3goRaJYL42+gAMO2Gmzb99mJHNOM5Mxyt9LKYfEG2j/eg4fDxVEE5f7R2VUULnkqzIRHLNMYGH08s8SOisF8ylrXR2qh0dLw2U/UKgepAfr1+9B7TRyhD+e5cevMdRHMO0ldNHBcQAy9Xj7ckE9DOEsCKrLdbCjn0cnIE1vKLMZpay7reqTCd+0EB7Gmo6Nc5CDGdKK4eVQjSP56tyL1p4blQyQ5tT5LTs/u30e15fSAohrUA7bXAt9wQ5DppxkeJKU2GRtO4TDfwbNOyBBCgnKurkTQBVJ4Wsmc8Ot0th4dvxvWSVODgt/7p8mRtHgPxxTAW/zSz2tq5sMpwJAv03vDtDYMxOIM9CLlhfv+/a9CfZO+bcsCPSP0T0qY30Bunrm0/aekBv5/Xxdep4QzA09yeCtgYX0l7cQP8XgdKo+OrbDJP9NYjfqhEFs9/OV2cP6A9BE1xLuRFvZDnymoEvDKY5Te4Zplp1lKsmTS27LxMgsn3xnr/Uf62M5cJwahrtVrdmTl+nlQx2q9hMt3kkwbxz3tHHxS31680KiFLDtNYQqQKZt/bEJ6+D9XuiU6p5VUKxzmZtEYZc9tywd9svFs1z/0lob6Y5o3Sui4oe0wQCbjgPcrUYXoVAbE5SbNPgk7z6HTKsRHo7d2OGic6qDzTvH/JDpaoEdwXZsA0+vrA==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(46966006)(36840700001)(6506007)(956004)(2616005)(70586007)(36736006)(316002)(6512007)(6486002)(478600001)(47076005)(70206006)(83380400001)(36860700001)(26005)(9316004)(110136005)(41300700001)(5660300002)(2906002)(8676002)(7416002)(8936002)(4326008)(336012)(1076003)(36756003)(356005)(82740400003)(81166007)(86362001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 06:50:51.9554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 960d0c13-2eb4-4af5-6731-08dc165f7b4f
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4417

Add default device tree settings for the 6 I3C controllers embedded in
the aspeed-g6 family SOCs.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 148 ++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index c4d1faade8be..ed5021001e7f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -13,6 +13,12 @@ / {
 	interrupt-parent = <&gic>;
 
 	aliases {
+		i3c0 = &i3c0;
+		i3c1 = &i3c1;
+		i3c2 = &i3c2;
+		i3c3 = &i3c3;
+		i3c4 = &i3c4;
+		i3c5 = &i3c5;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
@@ -577,6 +583,13 @@ wdt4: watchdog@1e7850c0 {
 				status = "disabled";
 			};
 
+			i3c: bus@1e7a0000 {
+				compatible = "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x1e7a0000 0x8000>;
+			};
+
 			peci0: peci-controller@1e78b000 {
 				compatible = "aspeed,ast2600-peci";
 				reg = <0x1e78b000 0x100>;
@@ -1139,3 +1152,138 @@ i2c15: i2c-bus@800 {
 		status = "disabled";
 	};
 };
+
+&i3c {
+	i3c_global: i3cg@0 {
+		reg = <0x0 0x1000>;
+		compatible = "aspeed,ast2600-i3c-global", "syscon";
+	};
+
+	i3c0: i3c0@2000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x2000 0x1000>;
+		compatible = "aspeed,ast2600-i3c", "syscon";
+		clocks = <&syscon ASPEED_CLK_GATE_I3C0CLK>;
+		resets = <&syscon ASPEED_RESET_I3C0>, <&syscon ASPEED_RESET_I3C>;
+		reset-names = "core_rst", "global_rst";
+		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i3c1_default>;
+
+		i2c-scl-hz = <1000000>;
+		i3c-scl-hz = <12500000>;
+		aspeed,global-regs = <&i3c_global 0>;
+		sda-pullup-ohms = <2000>;
+
+		status = "disabled";
+	};
+
+	i3c1: i3c1@3000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x3000 0x1000>;
+		compatible = "aspeed,ast2600-i3c", "syscon";
+		clocks = <&syscon ASPEED_CLK_GATE_I3C1CLK>;
+		resets = <&syscon ASPEED_RESET_I3C1>, <&syscon ASPEED_RESET_I3C>;
+		reset-names = "core_rst", "global_rst";
+		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i3c2_default>;
+
+		i2c-scl-hz = <1000000>;
+		i3c-scl-hz = <12500000>;
+		aspeed,global-regs = <&i3c_global 1>;
+		sda-pullup-ohms = <2000>;
+
+		status = "disabled";
+	};
+
+	i3c2: i3c2@4000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x4000 0x1000>;
+		compatible = "aspeed,ast2600-i3c", "syscon";
+		clocks = <&syscon ASPEED_CLK_GATE_I3C2CLK>;
+		resets = <&syscon ASPEED_RESET_I3C2>, <&syscon ASPEED_RESET_I3C>;
+		reset-names = "core_rst", "global_rst";
+		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+
+		i2c-scl-hz = <1000000>;
+		i3c-scl-hz = <12500000>;
+		aspeed,global-regs = <&i3c_global 2>;
+		sda-pullup-ohms = <2000>;
+
+		status = "disabled";
+	};
+
+	i3c3: i3c3@5000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x5000 0x1000>;
+		compatible = "aspeed,ast2600-i3c", "syscon";
+		clocks = <&syscon ASPEED_CLK_GATE_I3C3CLK>;
+		resets = <&syscon ASPEED_RESET_I3C3>, <&syscon ASPEED_RESET_I3C>;
+		reset-names = "core_rst", "global_rst";
+		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+
+		i2c-scl-hz = <1000000>;
+		i3c-scl-hz = <12500000>;
+		aspeed,global-regs = <&i3c_global 3>;
+		sda-pullup-ohms = <2000>;
+
+		status = "disabled";
+	};
+
+	i3c4: i3c4@6000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x6000 0x1000>;
+		compatible = "aspeed,ast2600-i3c", "syscon";
+		clocks = <&syscon ASPEED_CLK_GATE_I3C4CLK>;
+		resets = <&syscon ASPEED_RESET_I3C4>, <&syscon ASPEED_RESET_I3C>;
+		reset-names = "core_rst", "global_rst";
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i3c5_default>;
+
+		i2c-scl-hz = <1000000>;
+		i3c-scl-hz = <12500000>;
+		aspeed,global-regs = <&i3c_global 4>;
+		sda-pullup-ohms = <2000>;
+
+		status = "disabled";
+	};
+
+	i3c5: i3c5@7000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x7000 0x1000>;
+		compatible = "aspeed,ast2600-i3c", "syscon";
+		clocks = <&syscon ASPEED_CLK_GATE_I3C5CLK>;
+		resets = <&syscon ASPEED_RESET_I3C5>, <&syscon ASPEED_RESET_I3C>;
+		reset-names = "core_rst", "global_rst";
+		interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i3c6_default>;
+
+		i2c-scl-hz = <1000000>;
+		i3c-scl-hz = <12500000>;
+		aspeed,global-regs = <&i3c_global 5>;
+		sda-pullup-ohms = <2000>;
+
+		status = "disabled";
+	};
+};
-- 
2.25.1


