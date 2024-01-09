Return-Path: <linux-kernel+bounces-20463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85456827F59
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3076B214B4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C72364B8;
	Tue,  9 Jan 2024 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="n8xR1i1m"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2080.outbound.protection.outlook.com [40.107.215.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA4B3609F;
	Tue,  9 Jan 2024 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoVd2w7ch/4C3gwue7HBld8Y9eEjKUIm0XBgpimcN3Gio3zhmqBWbuDHo4czNx9k8scR4wG6NVtAqUX1PljOFsffVp8ZvoaNL1EiTrRXvdLCDT+qWH7932845AqGXZvNHtGPhd6/RDbLPHRIPl/ObxLzyImGNGmJbg1EgTXi2P1n27X1uML+JDcHi2A5ULlociwqMEqppfdKwTRw8R7gO3+bCv4BTJsF6WxgEdI36NLCeCpVQFIJAY/SQkCYZnmSzc2KuLCIdcxnb+fdbBa71robV1fcm9+b2piYuoTq5rGscVI5aV0cJj+epdONjbFFBSv+klI6XlHml/WCWhXX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AALHiwYYxM5kavG9Ao2yCDeGWSHTFtVZoM+1NRfYiig=;
 b=F9c9K/cRqIJ4Ff7yrS1F5h7c5F4pSNQzJkzmknSVw4ZQVQGwvmNxXP2s3vGk+QHIRnyE3emiR8ZrXHLju3dNBUZdoha4ckZIyp9LA0y1YfLHo/IM0DD/qpY9dOiw58S3SNzacHaj/oEdtc9+MCdrKmWFiE43mBCtW8RYIYcve8yqx4Y8/B+CmSoQqNFdfLZc0CNptg73s0c096C5AxxaE0lYK6c/nvwZWeGNFqCCHddUvuxiF87Wj/lgnVttYhnK/cuJIiokL9FLOi3ELb14D3CwYMLemmbgWmbX/oebUmTuycTsQKkgmpPeMZTvBxM8m8nWDgHTWksFY/6oN6r95w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AALHiwYYxM5kavG9Ao2yCDeGWSHTFtVZoM+1NRfYiig=;
 b=n8xR1i1mouKr5dkhaZv2hwoxpb+QcVkR/92thCESCVTTWMhk76gjZiqzFM//kR9G8FbGfyyilmYS5VkygYhikulCR/IykH9cyC4UtogwXNk3IrkZBMbf4IbkS5sfx3bZVH8TJAgzxlOPS9U28DGrWJhS6AYL4erF+Onn6fMpMDf7jkb7KfvUkDaoUH6ALznVq2hV1+Bj5inMb3A2G99+pkUZS5rJw7x2Fd1AMbSDFGcbrsaabG25t2P6b02cXRDHUDIDovKtzHXKt7py56ugc/WO1CuqT2e0aDZScdCmYIJgxrthEP7DHtu00B2uj1/QeB7Ge2vV2Zz+lxclgRPQ9Q==
Received: from PUZP153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::22)
 by KL1PR04MB8144.apcprd04.prod.outlook.com (2603:1096:820:143::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 07:21:30 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:301:c2:cafe::1a) by PUZP153CA0005.outlook.office365.com
 (2603:1096:301:c2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.6 via Frontend
 Transport; Tue, 9 Jan 2024 07:21:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 07:21:29
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
Subject: [PATCH v4 13/19] ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode for yosemite4 schematic change
Date: Tue,  9 Jan 2024 15:20:45 +0800
Message-Id: <20240109072053.3980855-14-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|KL1PR04MB8144:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: be13ff35-3eb0-4738-6c48-08dc10e39984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2Yr9CEIfIvIt60ln5ToHxh6ocjXF9m1wwTjRKjvExxIoy1ehGr7vU5yJBPCFTH5Ulvq5puuvjWjKftFfvfkZOcBtjChiFPREQNj+A1GHBnFIea3sxK9xUXx4C42F+OjQEUZvah8B3g8LSYiETRV0ORsDxkM5+gdUju2S1XKR9Lfs1OOEkYxxtYpP16mJvbmK+gKkj1xwzim73Re6Q3GinequI2oH/2PMubU9QvwFW5B0Akas7ashpONKXGKBLsMibkKLfOx2rCQpokEqfyx7XdRo2ltFCoHDH6IMNp/DObXup9K8JkEiHHF4JveFJE08a+C91uFcOwKNd3OmQ0DxOxK/wXdTuAYvBirwVETdLtjmq4spZZI5XHmrz1g9qLehfgN7uYPBbrzWA/pjO3NklcU3qw0yxLP1XwQ7MLJ9Pqcg7XFVZABUsscgUZSTdGBnsptfDf2eqOIpziZ1ZXFUi7fM5n5NfVqLhSu94KiEj9SRROe5chhtRuml1xrXIHfR7Zxck/YqPQRqcSpCaDfMHedvl//qOwpcgaT7UsahMMrhqoZKPcjM5yUmHLpXEcxT63BYuHVnRo4K/LceDG30/8v7zzLJTsPUKWAlLpZg4C4a8cd9uhYQVtWRHxG6qbswGymc+eg1UKBxT6yP2zgZb6uTDYG1kV3+E9h6ELDzHdLN+pQbr0fpEc7INa1c2W+cxnK6SNt/X9LtrR5O8bm/VA==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(186009)(451199024)(82310400011)(1800799012)(64100799003)(36840700001)(46966006)(70206006)(70586007)(47076005)(36736006)(316002)(8676002)(8936002)(478600001)(1076003)(26005)(956004)(336012)(2616005)(9316004)(83380400001)(2906002)(82740400003)(5660300002)(4326008)(41300700001)(4744005)(7416002)(81166007)(356005)(40480700001)(36860700001)(86362001)(6666004)(6506007)(6512007)(6486002)(36756003)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:21:29.6793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be13ff35-3eb0-4738-6c48-08dc10e39984
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB8144

Revise adc128d818 adc mode for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 4b227bd3982a..904c0ac0d8d2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1010,19 +1010,19 @@ &i2c14 {
 	adc@1d {
 		compatible = "ti,adc128d818";
 		reg = <0x1d>;
-		ti,mode = /bits/ 8 <2>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
-	adc@35 {
+	adc@36 {
 		compatible = "ti,adc128d818";
-		reg = <0x35>;
-		ti,mode = /bits/ 8 <2>;
+		reg = <0x36>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
 	adc@37 {
 		compatible = "ti,adc128d818";
 		reg = <0x37>;
-		ti,mode = /bits/ 8 <2>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
 	power-sensor@40 {
-- 
2.25.1


