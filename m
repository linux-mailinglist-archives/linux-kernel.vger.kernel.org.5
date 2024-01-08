Return-Path: <linux-kernel+bounces-20224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31948827C2D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF63A1F24259
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FF4646;
	Tue,  9 Jan 2024 00:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="Qze6DUv0"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01rlnn2054.outbound.protection.outlook.com [40.95.54.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E3017C3;
	Tue,  9 Jan 2024 00:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4Bo27UZ1MiHpAh4ubPAjIM9QPtfatKtiv+KN5b1cSID4PikMDt5wO+gaN1hBU6IaIMpqKG3YP4glNV2FY8OfX9Rzl0k3nBFsSnaYsY2JqpJuQckXkGrLd6UYkB548P0ah0zLLaBP1/Ppl52+ABKyyipo92x+QRdqIrMOSVoKJX1MNikkaxM/sxac4ycpA8yPGh7tj+pmDrptTvXJ+puN+ESoo7qUk/Abq9xi3B65pTbyDmb5fDmIfv+CW62Uieh/3/Ob0/em39cA8cU6f+HogosWq2pSJyZnMz59Jr/IdZq8Ligm5W/5mB3x1iVEgb77Z5KJF4o6eHZMiWbnq5s4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lk/t4Je0EhRYfDFXarUnqdP29sWrNaQHRiZiggUIAgA=;
 b=YYd2oxWLn3dWftqjml6Z3M01QmicZnVZHzck5MgUoTEzszLcO9dkpLJ+jrLitNbNMhnvx2yvjC2k88mX+F+LWlrVXOwBST2Bd3/xNqAZA5t648zYN8leNaMLyoRpxFya6rfSfl6xydtADjlZFNW6XxrlNT42mMacHgchSUHifEdLyio4sOospUlZeZIMgXF3YZsNXt3KcMh5whzCK/g/0KIMk5BD5VwNMF2dGUDrd4NtSNlzQoYymb2c6YWbg2ZkuwU67syMky8Pr88sWuVWuZY1+ghVwDEoCHHiiD2MqUyI1psCwJGMqTQBlQvD9hzqqRgHeXaXfjeg9psuuEjdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lk/t4Je0EhRYfDFXarUnqdP29sWrNaQHRiZiggUIAgA=;
 b=Qze6DUv0HpeH2mC5ciuebWHQiFfwDg3Lk3T9wUY1qNExJVw0HiYqL+GqVA9Xh3SSjMYQNkGEtoMAGjUiF6JhTivT5dbSQQWgXNnV/GJ9tDHSL6TRbEZECTsp4OsI834QA0f7XyIPb5Q2S4KRWiWWptExTIRyfeJBLj0KxdyxGIg=
Received: from PS2PR02CA0086.apcprd02.prod.outlook.com (2603:1096:300:5c::26)
 by TYSPR03MB8852.apcprd03.prod.outlook.com (2603:1096:405:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 13:54:28 +0000
Received: from HK2PEPF00006FB5.apcprd02.prod.outlook.com
 (2603:1096:300:5c:cafe::83) by PS2PR02CA0086.outlook.office365.com
 (2603:1096:300:5c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 13:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 211.75.126.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FB5.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 13:54:27 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 8 Jan
 2024 21:54:24 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 8 Jan 2024 21:54:24 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 778625F642;
	Mon,  8 Jan 2024 15:54:23 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 770EDDC0047; Mon,  8 Jan 2024 15:54:23 +0200 (IST)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <tali.perry1@gmail.com>,
	<joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
	<benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v22 2/8] arm64: dts: nuvoton: npcm8xx: add refernace clock
Date: Mon, 8 Jan 2024 15:54:15 +0200
Message-ID: <20240108135421.684263-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108135421.684263-1-tmaimon77@gmail.com>
References: <20240108135421.684263-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB5:EE_|TYSPR03MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: 87758586-9d7f-4fb2-3165-08dc1051544b
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 aC49QO1L1Get/v+jkfNxmxI6+a+ehKj77SdXAKIYI/AfQAHZlA57WyAnp0kVOtNvAsm95KcUGNxL3GNlbDMfy18enKyrsr4y+cNVvrh/okzDEiOF1S+sT4+FnZOZ9QtqVK/TOPqvuO9cv6yE3XLoSNx/1yp09xcGtm512HiBnUvkG152SQ4EVx3SasHlfTTrdTab55bWrl5KmLrpwFZLEgxH//pQvC80CO4JnuE1DKSGztBF2tyTbwbk3VcK9ApjiYtpK+t7wcTb7lIAu3LXjGexdrfPC4HzDcrvkywWtBU78NBHKCgvmziBCpnPMYSv0aVMWZJR09Z0h/e5aCqNrNBpyq/Xg7QuToJQKUAR0rWsI1Sh7Y74JqaPiN+DDtstQ7Zt3gjTRmZAgYJsCU/+mvWqYU2Xf1eGCm3y6G3D0Ajv1hr2uYUIszg6q6c+F8uPcTyDFjajzHqAjdInNR62IApkYkYOv3we/JrIMamM//lxk8L/bRnVnoypg7AncmqS8qCpUYRCz1QiRNp0Zi7WnSMpMipWc7GVa5ysnHZdrik6AFofkxQOxIcwO64fcbUEStMmDv1zJiMzVJgfI5LR4ANQC0Og4Gga5vyszJlOEho3x3TDpvr2i0xpKN+qPmTOY2oTKCXtMsyePc/2x9VceC7mA6vuu7hWi2NB3H+NCiwR3gKpskyoM8JJXR4EPsYQjDscQK/YHHrTNrA4RHc1oz2+0cfThJnioALQsqiPTiE9FFUO5bxv6+IzFk1sPEeV/jatTTAHPRtk3gH+kUEOVS+azXpsuSdHnxJ3B3F6sZV70TVmhgZLyD9GInLpbnnm8cR31sxfGo0L0g09BIyvnM7FReWHEaLjGbrWvk5IqVEsWy5Mr26/Iiox0+8GIi1u
X-Forefront-Antispam-Report:
 CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(82310400011)(64100799003)(451199024)(61400799012)(48200799006)(40470700004)(46966006)(40460700003)(40480700001)(2616005)(1076003)(6266002)(336012)(498600001)(6666004)(26005)(82740400003)(36756003)(55446002)(356005)(81166007)(83170400001)(47076005)(7416002)(2906002)(41300700001)(35950700001)(83380400001)(42882007)(82202003)(73392003)(70586007)(5660300002)(42186006)(110136005)(4326008)(76482006)(316002)(70206006)(54906003)(8936002)(8676002)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1022;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 13:54:27.1908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87758586-9d7f-4fb2-3165-08dc1051544b
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
 HK2PEPF00006FB5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8852
X-OriginatorOrg: nuvoton.com

Add 25Mhz reference clock since the reference clock in not a part of
Nuvoton BMC NPCM8XX SoC.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi | 10 ++++++----
 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts    |  6 ++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
index ecd171b2feba..9c4df91031e7 100644
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
@@ -58,6 +58,8 @@ clk: clock-controller@f0801000 {
 			compatible = "nuvoton,npcm845-clk";
 			#clock-cells = <1>;
 			reg = <0x0 0xf0801000 0x0 0x1000>;
+			clocks = <&refclk>;
+			clock-names = "refclk";
 		};
 
 		apb {
@@ -81,7 +83,7 @@ timer0: timer@8000 {
 				compatible = "nuvoton,npcm845-timer";
 				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x8000 0x1C>;
-				clocks = <&clk NPCM8XX_CLK_REFCLK>;
+				clocks = <&refclk>;
 				clock-names = "refclk";
 			};
 
@@ -153,7 +155,7 @@ watchdog0: watchdog@801c {
 				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x801c 0x4>;
 				status = "disabled";
-				clocks = <&clk NPCM8XX_CLK_REFCLK>;
+				clocks = <&refclk>;
 				syscon = <&gcr>;
 			};
 
@@ -162,7 +164,7 @@ watchdog1: watchdog@901c {
 				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x901c 0x4>;
 				status = "disabled";
-				clocks = <&clk NPCM8XX_CLK_REFCLK>;
+				clocks = <&refclk>;
 				syscon = <&gcr>;
 			};
 
@@ -171,7 +173,7 @@ watchdog2: watchdog@a01c {
 				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0xa01c 0x4>;
 				status = "disabled";
-				clocks = <&clk NPCM8XX_CLK_REFCLK>;
+				clocks = <&refclk>;
 				syscon = <&gcr>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
index a5ab2bc0f835..722a46d78d23 100644
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
@@ -19,6 +19,12 @@ chosen {
 	memory {
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
+
+	refclk: refclk-25mhz {
+		compatible = "fixed-clock";
+		clock-frequency = <25000000>;
+		#clock-cells = <0>;
+	};
 };
 
 &serial0 {
-- 
2.34.1


