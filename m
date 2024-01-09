Return-Path: <linux-kernel+bounces-20455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB77827F43
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37891F251CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276D029427;
	Tue,  9 Jan 2024 07:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="xO9tzI/V"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2051.outbound.protection.outlook.com [40.107.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80D25554;
	Tue,  9 Jan 2024 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXCMk1c2gdB4OUB0JB6F2s2lIaNb/AXjWROQ3tqfE6d63fbW6nYzYCqs+UcgCnj73vpoeJIyuUbYfVovwR/7mSx8Ra7Gw8eWLCsDCZ9AiDdPk0m4yE1N7QkeZsoiHx2QE112Ee6RiBKXjLXeBuumNOs2zQNKAImcliHpcETZIEXVV0UJQT4pbi1aT3oT0/PHrxGt86qHA1n9PoJHkqmQ463rcyPZPx9H33qq/19IFU9RmDd/0H0uEmOzEKvAyddXRGNMighmOXrbOhvCYewTpJ9c5rHiFF3p8bpA9/s/r8Gup1ifg2FUuNH6eph40QDY5tdceoKrOyyYPr2gZehuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+rCbKa980zvtFSL+aiZSLIdHmQc5ZtQwhUuhOWMtss=;
 b=YOdO0lhs1cTu2QRKXic/P8op4T2XrJw7JQxqHRY7TfEpSeobfkqQYqy2E+IVMMy6GC8gpFoBxgfu3ftcQhztrrygPd9bmNtlM54gjbYkIvM0J6i12atytIexp5mMNwB2lI/wdDpouwkRUX0gk+aj77CrAIKtW/Yb+gJAOpA4aOMoN5tRFaOz/mWlIK4QexbRUMEbmppr2mcVMJSiy6UzJ6a3JCG7cNq01wXSGgomoO9VT0MVmRSjBCSjTWET1lqpBYpFGoHxTzSXmuthL7RSYh8/2SwmPj6vvjaCK+bMqxfds2aY9MeWIi1w7cMecWyUmTfozE3n32rCrNYpSj1LXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+rCbKa980zvtFSL+aiZSLIdHmQc5ZtQwhUuhOWMtss=;
 b=xO9tzI/Vz2o7L1yDGUc9PT3H2naqXIJ4L8yxi1Qv2wjY5T18/CQIZYNTT1ho9ej2/9LOehB8XRXaT0T1ApCQcwUldY7FgTDh67GjHsQOThiOJk85gDyV1r72WFeqeaApkJ5n7zsvapkMO/HS44P/Y2zRsJl0EJpGOJGPnlaG93JnAONOkS+82TCCUL/w7aWEg49HjumuOaMgrGwcPF0P4raRdlJ+/WVtR/4xClVjx4NVxBf4obPlnD/OHa+fXEGSVZtNyGWKj6n+LF4HYoHD9J845VjwMzhAOxCD5j9Icee1KU64xZCA6NLIVzFsX8k9jFmOAsb/gw1NuOgdeL5v2w==
Received: from PUZP153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::6) by
 TYSPR04MB7424.apcprd04.prod.outlook.com (2603:1096:400:47e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 07:21:09 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:301:c2:cafe::b7) by PUZP153CA0001.outlook.office365.com
 (2603:1096:301:c2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.6 via Frontend
 Transport; Tue, 9 Jan 2024 07:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 07:21:08
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
Subject: [PATCH v4 05/19] ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
Date: Tue,  9 Jan 2024 15:20:37 +0800
Message-Id: <20240109072053.3980855-6-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|TYSPR04MB7424:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 23f1a44d-2146-443f-a449-08dc10e38d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XnzpoUQmxwfK2BawIv7F7C2b3KgrnZiazidnbUqcxZW0x3FAFkl9OjMfvHvLIvHSkdQzzLvLE8KQV+bCBoCaDHBVaBcgXFRA/uq1PoyL+tBBL2XoZBwbB550EpThb/blRPrg6PE7nKrxD4RUyde22GmUOyTex20GDsm1fSNTJwu7yptORd0SvuCIvQvO6WOqws4EuzlzTxGwLLJ8PvPyKuhXqPqrnbtc1DpxDHYkh3XJkDDAv5zIUGbMfWImvMk9xU1qZhcYrYiGu9ZDkfQmWQM2x/xPuBwC3OUQZqI7Y1JQx20nwftOtCQWI4/z7WGrZ68GBvptxgZzkI+t5l5ZtYhJbxWiV6Mwy47GVDxGUPWoSm9Y/Y07A31Jbr0ezX7AmXsgcTe5QFSGi2Y5PpkGXofCveeihrRtoSUHjptMMFJWUDMoxs1OhJlnHlcj1A5WgMwBVper3B1/Jq4A4MAWvUb+K1OimjF/AXNcag3WkcXR5sXN2M+RbaZrxyqsehVLbJC+rTyokN6p9D9kJs2amtFwZdzAYqBVZHXfYQJINFIKSjZY7sBqiD1Wn/MyxiyPZLTO5EZVWGZYAODMIIHjvP8QYbKJcLIwgluv2tjHS4j8+L3HhVEENOdCOS5KN0EQb5hAtsTp4nyZfZ8wIoBcVTSw0JP+dgi6bq4j28NzsqHZB56iNP3+tsHo73KVCOIPIRKsSLj492DxmKaKS80xBw==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(82310400011)(186009)(1800799012)(451199024)(64100799003)(36840700001)(46966006)(40480700001)(2906002)(36860700001)(478600001)(6666004)(5660300002)(7416002)(81166007)(4326008)(356005)(41300700001)(70206006)(70586007)(36756003)(316002)(110136005)(36736006)(6486002)(8936002)(6512007)(6506007)(8676002)(9316004)(86362001)(956004)(2616005)(336012)(26005)(1076003)(83380400001)(82740400003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:21:08.8821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f1a44d-2146-443f-a449-08dc10e38d1c
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7424

Revise quad mode to dual mode to avoid WP pin influnece the SPI

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index f8bfdefbefc6..23006dca5f26 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -149,15 +149,17 @@ flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
-#include "openbmc-flash-layout-64.dtsi"
+#include "openbmc-flash-layout-128.dtsi"
 	};
 	flash@1 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc2";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
 	};
 };
-- 
2.25.1


