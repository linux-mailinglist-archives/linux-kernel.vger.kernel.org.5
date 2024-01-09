Return-Path: <linux-kernel+bounces-20460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C79827F53
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E73A1F25C48
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22F9358B6;
	Tue,  9 Jan 2024 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="02eLfoLt"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2085.outbound.protection.outlook.com [40.107.215.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B6033CFA;
	Tue,  9 Jan 2024 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESiFtRbnyBN8GH4w0CxoIIedW7MXc5ZbLgeKJDftAElnh5Z+7i2xR/drDdasiZwMyaEEfOXyo78kFSJssOg+U6+rVDav7l36FekOdczLVlmW7E5Oh+E3ZBALveixAPOxDCoJ8sVn2vT5GzkeM/0mbrgxiGiSDlR6yjY8r93NJfLiGeUTgShifshwX7YTDJYt99b2EBGSWQQD/r9Gg5AR44Az8F+tRlJbHAh4uAf2z9CGZsa9WFx7JgauIBwwWDB9hXkWN/ied/1JrmMNf2cu2XrOMdpGpBdAlPyqAczQdnxoZISwbTSZ4Qf56RM+3neFcoh6hEO5dXzdqBZqzUwJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtqQUkvzpz5Gr8tpkdwXofht6Yc97OkbmG2K4Damyzo=;
 b=iVU02/v+RQ6jVAotAcxzASNx5Ic2UEi9nfnfdW6Fm4sFkx77d4lgfmRabr1dIM0gNWP/NN9nBw5L61zDcMt16x3zbs6m5m8VDEfVSlcYRZVODZYe9PcgAAbLsjiV965/MTHj81T/br3yO7Po14JWhl1LglfEuV1tEawmHpLyMw6Qzxa+S20xxGeIHV4Jve8lf+l+/YzWv42cVe14udBvhkPtIuBHecWp1m1qLjqBkVgLGMzszsbv8fm0MvI+6GoUMqlR/gIaeFlf2wTfl7ZigIm5IDvauvMa0NfdhHipwaSNHhWVwUPxo/UhsqTn06q43v0FGeYIIc4LO7lAje0eYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtqQUkvzpz5Gr8tpkdwXofht6Yc97OkbmG2K4Damyzo=;
 b=02eLfoLtcmRFGildhI5xfTf27N1n+2cA5Q+xpyNZGvh5QGkOCBptcmE4zXXFOrd6w5GEAEc+wJg3ir+mlgRdnMlITiSqw2OcBdz9Fb3NdQUMVUVBqCxkgCEGWRu/XvdgJiTusPXP5LgyRwilpKVoGfX8AUGYuHcvCQ5FiKsnjOGUo6edF1Zk+v6M++IEIZuLqkh9htbc8+2azwVwKeo60TWayad2GmcnFrjNLm/S/6PplDAslvwA0VfFl5iiMLvhbRIGJYkJhRo5GSGkK7bZQd5V4b3Zl9AHRjaB9O6fPC6zYDqnoYnMMSKejKTFq4k9dMPA15yVZPDtJdH5tiiRNA==
Received: from PUZP153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::17)
 by SEYPR04MB7474.apcprd04.prod.outlook.com (2603:1096:101:1dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 07:21:23 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:301:c2:cafe::bb) by PUZP153CA0013.outlook.office365.com
 (2603:1096:301:c2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.6 via Frontend
 Transport; Tue, 9 Jan 2024 07:21:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 07:21:22
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
Subject: [PATCH v4 10/19] ARM: dts: aspeed: yosemite4: Add power sensor for power module reading
Date: Tue,  9 Jan 2024 15:20:42 +0800
Message-Id: <20240109072053.3980855-11-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|SEYPR04MB7474:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 31b52847-e479-4cbd-2392-08dc10e39551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FvXzhsA07wE6vxgEbnbOx4OsrBP4MTfyMskwaCP3/gFL0j+vESbmmj5NGobQJPGchrNiXGSZvYFJSrLDTQHo1WneVQuKUQ4l0JDaYdR8UMUD+ZGW60L5471IWHsXVQ72RYwUq1qj6mzp98sVP7ZbLvnYkuhjaxdbsC4h9xqGtCAB04vgUFZ3tANy58BYuPKeGbHX/hwzLvUpRz69AvTCpKT4SIazDOLjUrN06wlwje2eDxvZcLSCDEveInAonpoB5JdYBHufQy4XObkmfRzL7u+A/4N9zfLpiYg3wqrCh8nCnxVqyhzW+URuUooazJsj5uEIC2kKH1vOJcUsfYoYi/RMXv1KSq59K+6ghtL5/1Shr0k+K4Z5V+0BCAeGqS0Qe/jtx7aEm6sAYEO1or99kIHAOAEVmklXmzybsmwuUhPYwadkYMWkpFFVI8K2JgkhJiIg4yPM3of0+6Hmiw5FCsDPXOP41VZ9NZCC7zCV7nRiVaqwjn45aXHNT8pHgzLoNJcBFS93fSuoRrjv/Bt7CpkGi7u/PqXaYEE3no0XAImuUuEXPN86/vHtRHWwq0NimzI11b6kKevga7XxOnAJ2Bz4GZBAkH1cx+snsrDB5XttM7xIRqGindq15VfJezKj3/Ryvv9op/0dAIsdmiYiC3zVySEiJJs0Hoa2lUJkv9KSxtiGktMbxrtjIXbDM8ph6/BoZwRDqOZngayR3kjVtw==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(36840700001)(46966006)(41300700001)(356005)(8936002)(86362001)(8676002)(6486002)(81166007)(40480700001)(1076003)(7416002)(2906002)(5660300002)(70586007)(956004)(36756003)(26005)(336012)(36860700001)(70206006)(2616005)(110136005)(36736006)(82740400003)(316002)(83380400001)(478600001)(6512007)(47076005)(6506007)(6666004)(4326008)(9316004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:21:22.6479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b52847-e479-4cbd-2392-08dc10e39551
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7474

Add power sensor for power module reading

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index dce413c99037..3028ba4ee815 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -906,6 +906,11 @@ gpio@23 {
 		"HSC7-ALERT2-R-N","HSC8-ALERT2-R-N";
 	};
 
+	power-sensor@40 {
+		compatible = "mps,mp5023";
+		reg = <0x40>;
+	};
+
 	temperature-sensor@48 {
 		compatible = "ti,tmp75";
 		reg = <0x48>;
@@ -930,6 +935,26 @@ eeprom@54 {
 		compatible = "atmel,24c256";
 		reg = <0x54>;
 	};
+
+	power-sensor@62 {
+		compatible = "pmbus";
+		reg = <0x62>;
+	};
+
+	power-sensor@64 {
+		compatible = "pmbus";
+		reg = <0x64>;
+	};
+
+	power-sensor@65 {
+		compatible = "pmbus";
+		reg = <0x65>;
+	};
+
+	power-sensor@68 {
+		compatible = "pmbus";
+		reg = <0x68>;
+	};
 };
 
 &i2c12 {
-- 
2.25.1


