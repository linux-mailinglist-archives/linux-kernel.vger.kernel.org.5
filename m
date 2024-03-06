Return-Path: <linux-kernel+bounces-94373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6B2873E38
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912B01C20297
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FACF14290C;
	Wed,  6 Mar 2024 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="lLtgrr+L"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F451428FE;
	Wed,  6 Mar 2024 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709748282; cv=fail; b=cDtbHzEJkOXth9I5YFiKscO/26cZVMEXq9SQ4xE+xAVG6ig2f5gGDAVM93oBaYGRP0UwMDLNzU7Yy/HrKJyPRytcYysfSKqp+PY+VD60jjku+U44isG7YlOUJ/UT3iCr6u4JNPaqhyQP7UH01jj57gUpZ4TQLWwomiz04hrR4iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709748282; c=relaxed/simple;
	bh=UsKa7tIHLMp1wTklpMNWN3DRQsBwbxmdf8XPj5b9WYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tkhS1hx0tNdDghswLnz5TxjI1jKcmVru/h42DXHa+iMtLJwQ+mWAY6qaG/+qPgm/uOLjGBSSNnF2ESFMiqaYP8jvB5b0WqIn8vTuVvx9l6Ldwku31UewXtP2WhV/oGG3ndknFOilhGZFLWb6KPL4AJF1jq/+3DXmcwCPtQ3DIvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=lLtgrr+L; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIPK5qfm8EkJWWrcthuDRCUo1p103UON4IEXI5NZRyT2iXIyrsb+InW/kIEdYmC5SOo6qfm4Yr+2K39hsDMbq4iBllgWl6UKj2nvbFl5Lloo0xburunreei0YAWov3ZHi1Z+Cm0Se04bHk0NlwhAPfX7RjooMa5FBir1XP1y2N/iDMdvY7wmRDJDKsuzsHAtfiLptIbbD+mB6qj8/6L0vhZL+vVWMmW6uMquL7X/IdS7C+pPq+Keo9AT3NgBViGzqnIjQX6ZS2yt/UAHesJqfRYydfAyhKBdI/yc5y7LZFvmHhTKRNUA4I8Irar8lAd38BHp2jEOQU5mpnWhFgIelA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6v2HbHcgkKbexa8oZfX/H/QR+qOB904iEZZ7iuZxbk=;
 b=PHElU38tAsXhSsDadAwWMhP4yZ8M/kkY4KHGXS5iDkZhxXkXYdZrCV4np4Sfe4y8UJ36tNIAUcvoEFocAVWR28HGIuCD0IqOvAGZWV2jfidd7eAWq4qdqY0pNgxNScXmC4vse6jbA8sWbHQ3sLifIhr0KR+nse5pYrRT03fpCgJ/oRwGyMsA9dyMkBOaODSAP5cSUYOpSGTIaq2nYKX1hErFt6gbYAz0j8tDKjnXSy2FBvem8WGyj2HojqgqPlEc2WfJcal+s1Xzpe5KZjL2uZo1bBOxqyU6Vukanc9zmTWKrvux3pheE6+KdgDaNXumfEGL46XzAlcrEUSYITuX6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6v2HbHcgkKbexa8oZfX/H/QR+qOB904iEZZ7iuZxbk=;
 b=lLtgrr+L13E+XDA0O9wy/lsXNdlD25TWZg7T4m54q1U/MReQnFK563TB3rRI4hevcl5q5bK85vVv81R58dsF4F80+GBfMA1WAFPdrkvDlr3fDj/9XXOWiiGwqMS3/SOm26ermoCR8D/xwYd6+mN9+MxG8OFbSuHlqqXb/ezEVjM=
Received: from DB9PR02CA0015.eurprd02.prod.outlook.com (2603:10a6:10:1d9::20)
 by DB9PR06MB7467.eurprd06.prod.outlook.com (2603:10a6:10:262::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 18:04:37 +0000
Received: from DB5PEPF00014B99.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9:cafe::2c) by DB9PR02CA0015.outlook.office365.com
 (2603:10a6:10:1d9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Wed, 6 Mar 2024 18:04:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB5PEPF00014B99.mail.protection.outlook.com (10.167.8.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 18:04:37 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 6 Mar 2024 19:04:36 +0100
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com,
	m.felsch@pengutronix.de,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH next] clk: rs9: fix wrong default value for clock amplitude
Date: Wed,  6 Mar 2024 19:04:35 +0100
Message-Id: <20240306180435.1033052-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 06 Mar 2024 18:04:36.0986 (UTC) FILETIME=[C04B85A0:01DA6FF0]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B99:EE_|DB9PR06MB7467:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 74e5f93b-8c9d-4df6-b236-08dc3e07e306
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sOgseA4eA+1GlG18A/OgliOyuig5TC036hdusGnYimHE1dR7nVfflki90lYu09JuHhAuhFcV+nVjMJlPLIX67JE7IHnF3zMLIaoAtUJNlp4N9kr21X9fe7GAS39EltsUK1bV51F2oeikLX/KWOpHM9cEoBWATH8cSa5XeJ7dntG6tw8+SUJBNx7ZG33EncfmpVp1hK6C/bvgsGqXf0PK2fkFFd9i31Ctkjv426WdgmdEZeXvOyjlz46f/WEuCLJdFe1mvROeDUH59JKRnDRKJRnvD19HHDKSUi2xeOSqSmQEYyGWq7SvPMXijJZ+h+3FHJ5/FMMQO/BXuI9TN7nfkvA6hLjjiCKlMMzNIUkU4oSh5gB1uJbHRqf66sCHNpyDrnOyfcCpyZp2IsM+tr1KJ4Aq7t8Q4uAIJS5Zg5WPuUfHU22H9XSD9eDyoLOPpBPDC3lqo+QsBMLVIOzNaiHct5SQyQIz6p82fuCEwkIx3KdHZzjBW8Wq3q3HM5zgnDnCRXcLk9AU+l20M6pAvUPGlYfC7ueqFeGfWNkc+svjN4cYKb/KBCwam2x3RS5dlmHuDPByFYvi8hv+o66W5g8A9I+W+feNaRr8xvFgAC18Wox4/l1wvpn+vUnezoX9WE0v0kRewGlu5wY/vb+Yo9HM253GUkUN/qRvRl8la9jOXhMMdZRfYEXQOa79mogl8DZLvADHoh4bhs1foGlXI5pfLRjE2RcCLCV0MwxayVFghy4YcGpeo16JGuPeUANqklab
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 18:04:37.3077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e5f93b-8c9d-4df6-b236-08dc3e07e306
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B99.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7467

According to 9FGV0241 & 9FGV0441 datasheets, the default value
for the clock amplitude is 0.8V, while the driver was assuming
0.7V.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
 drivers/clk/clk-renesas-pcie.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-renesas-pcie.c b/drivers/clk/clk-renesas-pcie.c
index 53e21ac302e6..4c3a5e4eb77a 100644
--- a/drivers/clk/clk-renesas-pcie.c
+++ b/drivers/clk/clk-renesas-pcie.c
@@ -25,10 +25,12 @@
 #define RS9_REG_SS_AMP_0V7			0x1
 #define RS9_REG_SS_AMP_0V8			0x2
 #define RS9_REG_SS_AMP_0V9			0x3
+#define RS9_REG_SS_AMP_DEFAULT			RS9_REG_SS_AMP_0V8
 #define RS9_REG_SS_AMP_MASK			0x3
 #define RS9_REG_SS_SSC_100			0
 #define RS9_REG_SS_SSC_M025			(1 << 3)
 #define RS9_REG_SS_SSC_M050			(3 << 3)
+#define RS9_REG_SS_SSC_DEFAULT			RS9_REG_SS_SSC_100
 #define RS9_REG_SS_SSC_MASK			(3 << 3)
 #define RS9_REG_SS_SSC_LOCK			BIT(5)
 #define RS9_REG_SR				0x2
@@ -205,8 +207,8 @@ static int rs9_get_common_config(struct rs9_driver_data *rs9)
 	int ret;
 
 	/* Set defaults */
-	rs9->pll_amplitude = RS9_REG_SS_AMP_0V7;
-	rs9->pll_ssc = RS9_REG_SS_SSC_100;
+	rs9->pll_amplitude = RS9_REG_SS_AMP_DEFAULT;
+	rs9->pll_ssc = RS9_REG_SS_SSC_DEFAULT;
 
 	/* Output clock amplitude */
 	ret = of_property_read_u32(np, "renesas,out-amplitude-microvolt",
@@ -247,13 +249,13 @@ static void rs9_update_config(struct rs9_driver_data *rs9)
 	int i;
 
 	/* If amplitude is non-default, update it. */
-	if (rs9->pll_amplitude != RS9_REG_SS_AMP_0V7) {
+	if (rs9->pll_amplitude != RS9_REG_SS_AMP_DEFAULT) {
 		regmap_update_bits(rs9->regmap, RS9_REG_SS, RS9_REG_SS_AMP_MASK,
 				   rs9->pll_amplitude);
 	}
 
 	/* If SSC is non-default, update it. */
-	if (rs9->pll_ssc != RS9_REG_SS_SSC_100) {
+	if (rs9->pll_ssc != RS9_REG_SS_SSC_DEFAULT) {
 		regmap_update_bits(rs9->regmap, RS9_REG_SS, RS9_REG_SS_SSC_MASK,
 				   rs9->pll_ssc);
 	}

base-commit: 61996c073c9b070922ad3a36c981ca6ddbea19a5
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.34.1


