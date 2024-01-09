Return-Path: <linux-kernel+bounces-20461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBBF827F55
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7FE1C247DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1787BBA2B;
	Tue,  9 Jan 2024 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="dozQxrZ7"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2047.outbound.protection.outlook.com [40.107.117.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB49D358A4;
	Tue,  9 Jan 2024 07:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6bD0T0cjkrC3z9enLNpvkJ5pIqJttpHHqmTphi4jN4WJ5OblhevTqIdVH7U5ZXIsbuTqna4aMvL9s/SrGEHiFFl6rURR2RBW9lu7o01QEmrrCRczRkIlquTTjClR6nIBvlPPRqpUfXcFEJe6OVKOmx/dTRzQpzw6VuUFQUSVxnGcfC96aOaJgTbJiUYmCg5xvtSgqMWa2C4dlkvxnm8mq/iqFZplqdFuemPgPgiAbnc3i5fpGfn6mQOGLr0dlX7u21wj2eD7fmjGr55wqQer58zkwbS9wF4YsJ3ELbeQ3uRK8bd6pn5T+tDYz+aq9YfYrz50e/qKMCmw3Hbv8487w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4XxCcVdEp2P0YWI8o8HTw0x9V2iQ77kFJCgNzZVIeI=;
 b=W3fbb5mFe2kpfD3YpIT4w1dszsfU3NZQC9zL5mmIbw0J6Br8obs9hp6fS+uv7p3JdiJ13kpyyfJI/QMV65k6LHrfZTZ/3YoMd43d7iQhnN5aV3uRML1PhR2dTuzgQ3IW6Bi2iq658vVEvgtE9KS2bEshlSxo92opz5t3usPH+gp8oIGdY/721j11iU4pD7CIWOSzdsNYsNoRuU7+LZ/+rt/qF+qsGkYsV478rwogQP2fOBO4ltrXgi3JY2XoA3565r0RwtCFofB1P6BZVdc7WS+WFULoUhp/VhSNAoofsi4w3g8tl5BG9XsydWgdt7C91KtSyT0SUh065ZFzDnC2HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4XxCcVdEp2P0YWI8o8HTw0x9V2iQ77kFJCgNzZVIeI=;
 b=dozQxrZ7S4gpDyWYGfsmiNqhh5hcZbeycYt6BKDyYQ6jKfg6Zmy/9V9EmNLQXYILI2b+9XEdI2O8DRUqHqCzyMMJXErNRV1nI98yJAo22oZQLs1ERxSrwTQ80rtCDo1GlOqY0QBG0cPWKXZsxKO7BGy5TFn9cEuqXKnN/fEHSED1fUBk7ABkfehk6B1CxLnjz7/L2g2jU7L+w5WyjTiWchHHQ/c7zha5PzOUN48riH/BiewTUb3XRdC+yS124svUW8He2CwDfr3PWuTrR0sayDQws+tNyzZBddXCotWg8xOGz6UWvdsokpftLdnPgMlcafuC6V/Tjs5WVFQstLBeWQ==
Received: from PUZP153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::10)
 by OSQPR04MB7909.apcprd04.prod.outlook.com (2603:1096:604:291::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 07:21:25 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:301:c2:cafe::5) by PUZP153CA0009.outlook.office365.com
 (2603:1096:301:c2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.7 via Frontend
 Transport; Tue, 9 Jan 2024 07:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 07:21:25
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
Subject: [PATCH v4 11/19] ARM: dts: aspeed: yosemite4: Add eeprom for yosemite4 use
Date: Tue,  9 Jan 2024 15:20:43 +0800
Message-Id: <20240109072053.3980855-12-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|OSQPR04MB7909:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 15dc0cb9-2d8e-4c64-8a92-08dc10e396bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P+wRtKGUamqws8vFnSJ2XCT3KeLBtsoXOzfQYZAzx2H9kfAjqMMQFNAYUlAymzQwt5Ju2/vEKdimPWiNsfaDhjS41pSfcwDuMpnQ4C87FPYqFAv38j1uYfltuqRSohSuR97x2GlFlqRun3OpYNNnnuXLPiSba8xnPkNq5/cyes9S1jsdiXvMFkWXmExzsKUm6WxUzOyLnNiIdSCL3tGXHRazfEK24rYP9eM4WNvxvHReccRo/NjbcsmXCB2W3a0L5NzCzv+6bMaIVmNCYnLW6A9W5LxjxFDAC/MpGwr9KB8iFif8VB1tUaXZTKnLd1rdhpfBl3lLOVWi6jFv3Q2AHBU4W5X5yb6vR3fET9ZOKk0FS+PbO3HYUqgn8d5tjb4c8sQUJpRzU7nzh7r9at+J7sFaUiD69QjXs0T9HiFQjdicmIqKqOUHvscVrXId+a7h2xeaZsYNCztmRVXBBfqstecUPDvsNqL+PV7blg749XiVh3ql1rsPjgduS1Gr7i6dDbA1V88sBnKi7GalTREN6/+FUP5Akh8rvGmy4+m2L9R1lePRihzgUpkMjYYwctMXoECvEjl1C/Flf23Ebt1FZfJLh3aX+kMgrL1hqI3pdTI/2AtazGjEba4QNSONUCmEe5dzttUGff0C5WBFrmndwJCN0+ublbsfQZOmtsVwRkx8ibxdmK8yV5Z2oZFbf3urSVIAU4iiU+EgT5bcY8U4kA==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(46966006)(36840700001)(36756003)(5660300002)(36860700001)(6666004)(7416002)(4744005)(40480700001)(478600001)(82740400003)(2906002)(47076005)(4326008)(81166007)(356005)(336012)(2616005)(26005)(36736006)(8676002)(956004)(1076003)(8936002)(9316004)(110136005)(316002)(6506007)(6512007)(41300700001)(86362001)(6486002)(83380400001)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:21:25.0230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15dc0cb9-2d8e-4c64-8a92-08dc10e396bb
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB7909

Add eeprom for yosemite4 use

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 3028ba4ee815..32c602124033 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -932,7 +932,7 @@ temperature-sensor@4b {
 	};
 
 	eeprom@54 {
-		compatible = "atmel,24c256";
+		compatible = "atmel,24c128";
 		reg = <0x54>;
 	};
 
@@ -971,6 +971,11 @@ eeprom@50 {
 		reg = <0x50>;
 	};
 
+	eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+	};
+
 	rtc@6f {
 		compatible = "nuvoton,nct3018y";
 		reg = <0x6f>;
-- 
2.25.1


