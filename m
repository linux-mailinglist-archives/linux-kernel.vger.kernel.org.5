Return-Path: <linux-kernel+bounces-20451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945E9827F2B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D53E285BA9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BFFB666;
	Tue,  9 Jan 2024 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="nh7BpVjz"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2046.outbound.protection.outlook.com [40.107.255.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BB59447;
	Tue,  9 Jan 2024 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvjGw4moZhGsI1ZMlAm1HZNE+QkAlq8VuBJuSpGfZVs2zuAxL521Mw0f12gD6ChgcrX/M4JVxMpHRRdZABOYsMGAVcsgHd5jBBTAHtSIEoqfoqspmS+QAQ6XLeOUpJecv1APF5IZHGU7BslfyU2Eg5O2s/RjtLpJYRZZ5VeSA4tLkQX4T2IoCZjRMXJQ+4/gYgZbeeGGF0D4SlEQEYsDI4nJd9NyARq2JQJsVaXIMqRzPksZnb+bnADwotam6iomw3pWc8uexZBqOJbIrAllwB8iIPNs4o9b3jImTb9Pkx0KFzSC3jNwhnRs1WJ3CmASN/BCVa6PT+vUgp4KxcmFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kCO11WdUiFDfGWanOnHA5fSAvcgtGuDJsJBtZQkii8=;
 b=fB3NFW3JFF9ObETBXx9m8Ipfkt2uRwlMx7QEljRqZb53X6TmA+Sl1jFMUvsH9POjVZTYsSBHh6gdgM3GtjWohObaTQWCA2HOjZ/72/5LWMf1n7ixeaX68iQYLsNkGBITJWkbo2Y3XPq5+tLTlkDMUc7zfr6FO7Y7YSkxsq18CbDWu5Fr+f4OBNP8/rrqHxp1zeLO5+CmFmvGOh6mU0Ckjs4WQRI1SJdXdyTPvxxfu3hq20tV6bLq5xPnPN420kMukJA6/040ena6OVzP1k1/rN6zAAtBJZL1OOGtDFyd7ZMpyUZKVRo80L/f+wMOwin7eaqFIVCFSACm/EkaI9m+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kCO11WdUiFDfGWanOnHA5fSAvcgtGuDJsJBtZQkii8=;
 b=nh7BpVjzCe+vXZCIKhsB2kifX2uSONrPPUX/rUdvnDm9FDgklE9JAdy7w9/t4wu6NpBeaSXI8yqKeM5/gl/ENlU6318PK2sJDyazAicVMRE3hZWYDvzPvGU+iJghv5lpVJKpjwJ7f3/miAuvRFBtbQssqJqy8mWhWuUZ6XP+EYekwtknAuJlDs5+zvbgga0uuDm4jy4MCKUaqR6QwreiazKl0oxGjc0bXdZJEu6wNXdL4CM0Ug6tjYzaS/gHnSQnTaFunJ9b/6PKFZCp1JyHLuLyK916VCzfkhT6vNgwuofFUG25SuhqYtzb13AMIlNugkl7vJY5tJ5ldngt2M83/Q==
Received: from PUZP153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::20)
 by KL1PR0401MB6380.apcprd04.prod.outlook.com (2603:1096:820:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 07:21:01 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:301:c2:cafe::89) by PUZP153CA0012.outlook.office365.com
 (2603:1096:301:c2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.6 via Frontend
 Transport; Tue, 9 Jan 2024 07:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 07:21:01
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
Subject: [PATCH v4 02/19] ARM: dts: aspeed: yosemite4: Enable adc15
Date: Tue,  9 Jan 2024 15:20:34 +0800
Message-Id: <20240109072053.3980855-3-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|KL1PR0401MB6380:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d6f4f89e-11d1-4fa6-d646-08dc10e38882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QOjmRsJjnvUZr3354P6D/SLiVTXLWaGsgN/QLjVbvl7xsz8+GMogSiZLOcUs+39srnmqDUaEwC/e2qubhBjVAzV2XrUozR1D6D+hXZiP4gpxKPVXOyOuat28MmUIKUlvbEe33eydnzoway8V9EgHyX5bQKw87djPQWTATkMFPjr54Czb5fImdxT/BYbOIAqNqIkJ8mNTTcAM7LHJKQFLeIFS8OSLpo1pBm/dxxSQRcN1bnJ5qyS9+w3KRH1RaLorkrxyHakoEMraiveKuhRrDc1EVs4mBroh4plugLW+FkCEwWvV49Eg/ItXByl0bmVugJZ+sDhoDShHib9mOCGyJmmQWuz4Mt3DnNRtpg+FcVX86jOVo7qyhSlGpRzgmq4R4miy9jcXVJyP2RKoyA0iOk/PCqdxoEyci7txGyaLJVuSOBtQUywJTS56IjFgEYiekbcplAVuc17T8gpGbxg/Pz8mFndSVv/fAg2u6o+G1JQW1aTCqOQK1LDh9Dc16qfwdjrrUTzViaWrfRYiAfOJuDF2BN3TR6CGPRhgw4EUNrZtwIYnzhTJYN197nHEN05USFNBUXgG7CFkxK6K3hda1adSz+ZoNTeWBo+Jrizo3GwknfQ+sWmAqJ+67vcCbKHjXtwi53JELgylFX73+3qufjQ880IPVHSSHPv1jRaz7ZZ2q4aZ/2FgZ40a0j1BUrtVZ26b7rzNN4G7dyg5u4VhPg==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799012)(36840700001)(46966006)(9316004)(5660300002)(8936002)(6486002)(8676002)(4326008)(7416002)(316002)(478600001)(36736006)(70206006)(70586007)(110136005)(2906002)(36756003)(36860700001)(86362001)(82740400003)(356005)(81166007)(6512007)(956004)(1076003)(336012)(26005)(2616005)(6506007)(47076005)(6666004)(83380400001)(41300700001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:21:01.1633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f4f89e-11d1-4fa6-d646-08dc10e38882
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6380

Enable Yosemite 4 adc15 config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index dac58d3ea63c..6846aab893ad 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -51,7 +51,7 @@ iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
-				<&adc1 0>, <&adc1 1>;
+				<&adc1 0>, <&adc1 1>, <&adc1 7>;
 	};
 };
 
@@ -920,10 +920,10 @@ &pinctrl_adc4_default &pinctrl_adc5_default
 &adc1 {
 	ref_voltage = <2500>;
 	status = "okay";
-	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>;
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+	    &pinctrl_adc15_default>;
 };
 
-
 &ehci0 {
 	status = "okay";
 };
-- 
2.25.1


