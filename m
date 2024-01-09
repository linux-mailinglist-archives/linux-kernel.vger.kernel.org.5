Return-Path: <linux-kernel+bounces-20462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B24827F57
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301A41C248AC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE888364A3;
	Tue,  9 Jan 2024 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="a7HbmJsd"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2089.outbound.protection.outlook.com [40.107.255.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB59F3608A;
	Tue,  9 Jan 2024 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahqG3meiWAX609T6rELYf3NfKoaZ9n5xgezjZdzvI/6mjxOJxEpJs0diividnRsRSDNHmYG2sp8JYRAEONNpuw0vi5/ohU6Ro/or6CMN5v7nyqGkyK1/FtdAyDjwzsMNPiMYdgd/coFQA7MK95srKXAHsBavWXvYYt4uh7P3s0nNLuEXGgvQ1MJ2VmOrA4toBUGQskWi4Cz82vjA64orXybxSwBMv25JpM+4YfnWMVcbmm+yb6ldU//T/+IIC2ystkIM48o/fSe/VjT5P6A7+zoCI2uiT0GT/5Wk2qHV2EDdkboAsOB/rlVYmO/kV8jx+SVcMuJS/M2mhl5IqM3f0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6SBrC22pzYsy1098dJb+MNOSZHyygMA2V1d0CFPWng=;
 b=d4jxDQEMCDn66SXllB+0sqqpCy0GYYIKMUe6+yj0CZabOVdpjQaLempDJ4xtpzaa/0z2xy1GXy2WVFwa4CQUkQrJB/QTnXvKaqbu3imb9dIPO9glEZ9Q3gazp9urOD2bVTKGQk2XEKeDRSuUQtDHeSy52sbJ/crZz7/dApx4zHoqOluQpM4ZaOZRJLAkOCVfrwC0tOjljDjM0getEiGpVohz5BdiW0+rySO9l8AdifU2EsFaQuDQvD1EKUB3odJZtq0PYFCqxwbVZwfNfgtbn28VkruaVwCUWbvy6kkZGPKRxO1s32xbkqzbSuSMJcWAPQ7XP6rx3u7hV+TbaYHptw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6SBrC22pzYsy1098dJb+MNOSZHyygMA2V1d0CFPWng=;
 b=a7HbmJsdjv/5J4BTSLIne6EHxUzrjestCNMcVrm/+J7jOSCyzcFnNIOAbtgXQt0kITOFSHpgI0JZgtGK/giME8IUXJJ3yFx3bIiJEhtxq/ymvzg3NbZ3/zsxdfeNenZmpmibvZvurFUnnJQIZG/gUe8lzaQxxuIgU9ObC1jqUOYU6Y5ZkyJwLKlKvnv0RQGj0lQIALPgbWRJ41ABdTVUv9g0NEqWz4cFNv1kyQbzMifWWTZEA9ndzxsRE1wCOdefgIZE00bkwNm0EHxn+OkTqFRLOJklAmgUfEq6eup4YbrzF/xr31er6QBmKNj6OIfnWjmdgYCREXIHGry8BmXrXA==
Received: from PUZP153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::11)
 by SEYPR04MB7576.apcprd04.prod.outlook.com (2603:1096:101:1e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 07:21:27 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:301:c2:cafe::2c) by PUZP153CA0007.outlook.office365.com
 (2603:1096:301:c2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.6 via Frontend
 Transport; Tue, 9 Jan 2024 07:21:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 07:21:27
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
Subject: [PATCH v4 12/19] ARM: dts: aspeed: yosemite4: Remove temperature sensor for yosemite4 schematic change
Date: Tue,  9 Jan 2024 15:20:44 +0800
Message-Id: <20240109072053.3980855-13-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|SEYPR04MB7576:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b4afb2df-14cf-4a9f-67b7-08dc10e3981c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4TIHsDiwppZxkeL1N0T4Xi9BALJ5Xc8w5/bBuY9rCAcRHLV51pzTHterjcy4uHsefvAkJ4B+1O5nBOJrMSDIyuOSA0h/MBpD3sFvAsTOoWcVMhZak9BfOMD76pvRgUWS4yRKcRXz+jBlJZpRm+B7qkDSkVNEOlyPgs3odNyN+4tElB502mC3zBZ7zIpXLMqn2RtXfbCnvgbusN5SUVsA4cJFPKhZ0NFN60JtRV+pZxVnr6hHnDrDHZpRTWIg8A4qWkXB4Y7TJXXT+ob5PcRpCnsbxIq4nLzV+4zt3+Ls9sk+waHf+l6es2jIo/qjZdVu7IitF5ETvFTxB56u4kiTkJnSLkTo1I0nU7CYHZXTa+kPSszPG4U6pvK18adRj9pQqXKsfKUlcNiE/d3qu/QnAL/ZgunvH9s6JAdTA+JHcSWK7g393aUp4O6haiM8x0Co4G8ztQu9zbhwQZL4+ZzZiugNQA8x33qRb9X3DRzBq2kll5IZWUSVWQ6B7rAchDSObc6hax7y2fPgY+s3T1kmXuJ6NxMs9SA/xtmv9E/YjJt1DIUtjZadUQgH2MGzzEkT3QhiEEqVbxNmIdJjH/hXc8mUnuQoSOmnksgDHCduQhvq+Fz6rs+sEPTk8gcxAH0veYOCvLB/8BldV8cJnPk5ELzY/+s9RhQiadq2vGfrBoFr9RSwfSnds9qolQqAfozxYti+62An685TV12013bNHQ==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(46966006)(36840700001)(336012)(9316004)(83380400001)(82740400003)(36860700001)(2906002)(47076005)(41300700001)(86362001)(36756003)(356005)(81166007)(316002)(36736006)(110136005)(6506007)(70206006)(70586007)(6512007)(6666004)(6486002)(8676002)(478600001)(8936002)(7416002)(5660300002)(4744005)(4326008)(26005)(1076003)(956004)(2616005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:21:27.3355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4afb2df-14cf-4a9f-67b7-08dc10e3981c
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7576

Remove temperature sensor for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 32c602124033..4b227bd3982a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -921,16 +921,6 @@ temperature-sensor@49 {
 		reg = <0x49>;
 	};
 
-	temperature-sensor@4a {
-		compatible = "ti,tmp75";
-		reg = <0x4a>;
-	};
-
-	temperature-sensor@4b {
-		compatible = "ti,tmp75";
-		reg = <0x4b>;
-	};
-
 	eeprom@54 {
 		compatible = "atmel,24c128";
 		reg = <0x54>;
-- 
2.25.1


