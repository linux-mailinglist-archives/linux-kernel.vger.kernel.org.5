Return-Path: <linux-kernel+bounces-20454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B51F3827F3C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5077A2863CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3A12575C;
	Tue,  9 Jan 2024 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Q0ItonQC"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2043.outbound.protection.outlook.com [40.107.215.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A60B21A11;
	Tue,  9 Jan 2024 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+txASSd7vjykcow3fzqDRmkQbp3i0TWSb2/wYAQuzXvWuoYDJahajVddt8NnZGCB76VSgYLbmmWjYJehlZDm+et+gQnEN4vvN/LdMKW12+0LlNfPErgNdUN+o6uV9fqlC7k6YKOUd6ZsDF2Yn2MmnqtuEVhwNBGiZgYT6/fEJxNl13d7oG3Wple4b5LUzPXb1yX+vjcpHvIe1Y5yWiEDybjmATlRJsicP75cSi9o0YMDoYGmMulBiGQYuDaZyPt+U6p48qNdXgr675EPwr4MkzNEvKKwWkc+SaEGX7ljecyLiPhoHgp05A678lv0EtyCLZPwoMuIzzJZ3r5vwj+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXS/IBxr+oV5K2cp3jW9e7qRwk8DHsYfz2fJN3Mk/J8=;
 b=jTNrDZCYMdUm/kBTS8cbOJxLX6pL0wh9geMoz0yvCoykhgeA5yybzngJ8UZfF3IUxLwHiU0CZN/TLeFnZnSzFYQEfWZ+ar2gooDNFzgHZ00XsvaOoRu1j+G7fHyOIvWQZFGpY772zZb3Nm73xl/dkgdMuotSAIFw0TMAs6M6pTgCLDYJxrsHauOfHPXsk3WBkxd1ICWgTujCJ2WD+55TYUWu8aXuXSj+aoPbt5GQk7RQx4XTq7ZHzHN1eZegsmdbYL6BUKu0GAE73F9jkZu4hNOi+eWR0FTtYnaEAF1bHU4ioSTqZAFRjQ6G4aQ7MrR59cpGLE9dOp32n0MMO/rT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXS/IBxr+oV5K2cp3jW9e7qRwk8DHsYfz2fJN3Mk/J8=;
 b=Q0ItonQCq8u1DO6c7xHcQoUoDZOHHhkNiW6EEopeIDW/w9puDDHFHHpaY41OfDXZVPl7mpQH8m9Qh+pzEcQ5qt5Q/jR3rZLKu4EsxHNQ2/S/wpXGjbymBgWCuWiqrBFytd4BALIz+eYo+KsLaMWIsFrUblp+lINh7bk4OqwuZOFgK6yIyCjZBJTb9P9wBN4yn7QOMkDgNF7yS8XmGdyTye6nyhB5vluh+v9Dnjj/J+zSy0ou4OI2yWK1geliOKFjGFlaBRIk1/uQXj8oXV0fpAYn7jt3+p1+JPHb5A8P6KERLOEgVV/URZ829sWEA35AjkgbEwrhJpxvHlcs5J7t3w==
Received: from PUZP153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::10)
 by SEYPR04MB6310.apcprd04.prod.outlook.com (2603:1096:101:b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 07:21:04 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:301:c2:cafe::4a) by PUZP153CA0009.outlook.office365.com
 (2603:1096:301:c2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.7 via Frontend
 Transport; Tue, 9 Jan 2024 07:21:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 07:21:03
 +0000
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
Subject: [PATCH v4 03/19] ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
Date: Tue,  9 Jan 2024 15:20:35 +0800
Message-Id: <20240109072053.3980855-4-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240109072053.3980855-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240109072053.3980855-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|SEYPR04MB6310:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d0dfec52-d1d5-4cc9-75d9-08dc10e38a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k2vbLPNPZjTFwa+Imbh6KP9T5KWyYUSnVQ9o5DvyCyb6IDTGxqM9axNuzpvaVzzLLCw9m8cR/CpzRH3QHQ27/dk5k3q/2XJh31wk2Yo71Pznl+BEKbIjRG7Dygr3p5jMWUWolVR0vTBYAwXyFRCwxFXWI0R4Ygi37yKi6a9VkMKmue704WRvHN11mMwyEwk5Zo2QYKyxHr6eIPzYPVfZFHinJ0h4vDt8p8BrQGVPfbIhW45HboXbwc2gKTkm9s+F2MNs0S7wk6njFOTl60eNR+hxBNs6kpTdP8QSvlgKw9rFvMaai8wovaRSOprr3J1dpRQNurirI9+FgwPtJs8WRPC0is49m80hQD7TsCDPjIs1tC1Mmj7AglwY0fvKCTO+zcqD+iFpfX0mXBBy7i/H9Bdews/17IkBgxQdNsY0dRHlHf/CNaDRtxs4poIg2mRXHbTv1KFR5SIpTqJuVQhIbMgAINld3NbDxZdCeOISxehAqhOwY/wLg9eYI90UxR2wesjIeQSTe7QZXuaF4jS0mRKzbl15wyFqdeU2wbD6wQyrnuQqmE0igohYaVJXjGaMGR132eYXrJICjksyV9eDB6CVeW7bzUDaWXuUyT8EZoIMYE23Bm70q8DZpjzYueAXYTpy8Sg0yt6g1sPru1HCZmjL6orlwGpw4HM6hHvEYuC8Yokn/0/gT1sW3mdtB3KWQIFkGtJRzEIcPAlmbIe92w==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(82310400011)(46966006)(36840700001)(9316004)(6512007)(956004)(82740400003)(7416002)(5660300002)(36860700001)(2906002)(36756003)(4326008)(41300700001)(356005)(81166007)(6486002)(336012)(86362001)(26005)(1076003)(2616005)(6506007)(8936002)(478600001)(6666004)(8676002)(47076005)(70586007)(110136005)(316002)(70206006)(36736006)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:21:03.9133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0dfec52-d1d5-4cc9-75d9-08dc10e38a26
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6310

enable spi-gpio setting for spi flash

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 6846aab893ad..ea8fd3ec0982 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -53,6 +53,24 @@ iio-hwmon {
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
 				<&adc1 0>, <&adc1 1>, <&adc1 7>;
 	};
+
+	spi_gpio: spi-gpio {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
+
+		tpmdev@0 {
+			compatible = "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
 };
 
 &uart1 {
-- 
2.25.1


