Return-Path: <linux-kernel+bounces-20467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F059827F66
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A35B2881E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14160EAC8;
	Tue,  9 Jan 2024 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="GqX9yYMr"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2040.outbound.protection.outlook.com [40.107.255.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C180037144;
	Tue,  9 Jan 2024 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcCJLMor4KWc994Il8iz8g58IS+dWIqDWRMy2qYHMXKN1vuS4/cmBIzJNUiOcZggt94Y1xVn8/Jw9ToMKU3IO4980EeLWzfDWSBNbkkg6u6M7qPal3KPujAKxQR+6jqsIoy84fNZW04tU2P6yOOzN72czQ8dhJhuS4wZ2c1/wfgHTDjh9t5jy7tUD2HQtn82fdzWBzlHQMyzv51C8dOsXfEUuD4W0nou+xojHFuI6cyGwDO4LAeLcyKDzzKEuzplM3lWrBg4iwVrOYPvLnas2RgX/bl/Zf3AXdaP87j+D0ICV9JRuBmCELnT7R+JZ7PVjzNrA0mOQLvkjREaVRaorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBTSEJaDMhAEKSGaohrRxSGM4W+RCgnOs+FBNlaJsUc=;
 b=n3f1V/fmHz7S9I7nbqQ89HX6NOFSvjfTYXlOrQRAqnon5pqnLDNo4ScRealXhYwm4VTEHGSK0prUUW/xoAGJmtFLrbhw1CfTfOmDmtVmI2tfQST6vrSll7SvJVTn/RVtbYfeWJ5v8+BnO47d1DBTcxjdodAmolvlMPJaDCOvuaEae+P4oOPb4O+pLXM563PPipwoOuneKL64MRbJ8Oen2mlCKejLcfaEMhD0H+Fuch2WZoL+7WH/MDB1QqNKXiAZOd3Dec11itZi9tQUmuM+r61CERv3A2GyLqWfF3RN4BU3NXMJa/1oVmhUgVQnwrfFOaM0OzI83//nxtb/DO7WUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBTSEJaDMhAEKSGaohrRxSGM4W+RCgnOs+FBNlaJsUc=;
 b=GqX9yYMrBw8uNnQB3L5aLDOJ6vZTi5pwfkf2ciiQDG8c58qWFapzYLzvfhaCONM37eUX6ybEje7Rq1LP6bFgncSJpzBY0RHTdkjCW+dc70YXJWIui/ehvFeMGInjHDzxBvqvaOBhxzeYCxl1161ZkLKErhAUEXiuKqAQyEKq6FG2g2DfskAiMjAAb49paNQgofnIUO7PclEVcz5PIFiDPHGYcgG0fotv4gOL33Em2S2W1UC/rSI4rCwXjVNsz3sRVRfP+Mzp2ioiAseY4eAg6iuWIOauEJk7M1xGT3tsfwPmpj7lNrq9czeKUXInRolkNzQPRJbP1yMmpxcyYmO6dw==
Received: from PUZP153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::23)
 by PUZPR04MB6090.apcprd04.prod.outlook.com (2603:1096:301:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 07:21:41 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:301:c2:cafe::94) by PUZP153CA0008.outlook.office365.com
 (2603:1096:301:c2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.6 via Frontend
 Transport; Tue, 9 Jan 2024 07:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 07:21:41
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
Subject: [PATCH v4 17/19] ARM: dts: aspeed: yosemite4: Revise mx31790 fan tach config
Date: Tue,  9 Jan 2024 15:20:49 +0800
Message-Id: <20240109072053.3980855-18-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|PUZPR04MB6090:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 17836793-dee1-4cc9-e49f-08dc10e3a08e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ykFP8eJa3WUu/nipU8xveI2nO812jJTjLE+19syor9kY0Le5jWkfMhimoneYtSTVF5uloK72dxcdLZ64vS+p72xcII85AZqZoUD52a9AksKVLD0X8C8lwgz0sHGr3pGYk4kPue5Zzt963KtadtVI7oQmhPPWwc+dBAeZxDICgveHDNHJlnSFZ5Ian5MU+vdaxoxlFOcnjMDpC7DXMfZThvzEY0EQGbJ7JA52SZBhAAxbZ7q84ZcKUHi/aD1CWzyrctOWCmePJcWV2yrTo9+8RBgKF6gAssJz9WmA9Uwa2FiEwWtflMJZBirLYFpSnLAw0TEt2PzNP0EJ0srIlPM2jg9i8u2FiR+T1wXN3TWrH6AcBY4FqhtTaTnTenanN9BNqJr+XqU+tD8mv+S875tyq9FyHUK5DOGMKF99PyHg7U9yeYtn6qvFz52FPlXFMT9AUAXCctndxJgpGZAoEc5sNuD1BpyI4Dr1nGTII3aFTlqWZE4DWHJj6JUqmOJTjGvxCbKn0aSOZCiV+5bbuJ7994JRQGqJ86p8T8O9FlXF/YLHTtzEHUPtm+etLwXjHfHsdRAUrJ1zybjJrtJgtphYQZWkc7ncjOj3cGB4WuDeo+N0oG6KDJ3FpmoV1JO47mhyddblYSX+alENTM30uA2IlR4Yy0st8ca77rsPLS3EwZBwSKaV6K8toFl/vcm6VTc8twzhvtsrKSaClYUsCzRHwQ==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(46966006)(36840700001)(41300700001)(83380400001)(4326008)(478600001)(36736006)(316002)(110136005)(36860700001)(6506007)(8676002)(8936002)(40480700001)(86362001)(6486002)(47076005)(36756003)(82740400003)(336012)(6512007)(7416002)(1076003)(26005)(70206006)(70586007)(2906002)(956004)(2616005)(81166007)(5660300002)(356005)(9316004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:21:41.5076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17836793-dee1-4cc9-e49f-08dc10e3a08e
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6090

Revise fan tach config for max31790 driver change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 48 +++++++++++++++++--
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 0691c09b6e74..ea36d61423a6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1095,8 +1095,18 @@ adc@1f {
 
 			pwm@20{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x20>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			gpio@22{
@@ -1108,8 +1118,18 @@ gpio@22{
 
 			pwm@2f{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x2f>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			adc@33 {
@@ -1145,8 +1165,18 @@ adc@1f {
 
 			pwm@20{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x20>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			gpio@22{
@@ -1158,8 +1188,18 @@ gpio@22{
 
 			pwm@2f{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x2f>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			adc@33 {
-- 
2.25.1


