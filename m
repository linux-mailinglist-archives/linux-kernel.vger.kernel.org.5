Return-Path: <linux-kernel+bounces-23854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D7782B2D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912A11C23FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1302152F78;
	Thu, 11 Jan 2024 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="gJW4wtcL"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2130.outbound.protection.outlook.com [40.107.104.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF75025A;
	Thu, 11 Jan 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+tmRD4dXJ1B7VJ/aUa/Yerh/2ArUE0r/UtKsO9o86QESkqhBv1nogbDu25X0FLi2yd1oFjlt8P5OIWdIh3yyeAysTfPy4f4NenwB/bfNh7Sd5WZmB6AhWWm94hR5++IpvLanJ6pynvf9zAqq7wvijG7oRCoJRjb0c/8scMsGa04Krx2WxUvI1KuxLMkWJDSBqM1gty/w+TEWAalmx2Igz33TSk1EQlCF0RQZ4IcF5sZcaTlMIhlMBkzH7n94/G3lOa3qYEafPKREj98eida+zvMYHZbUDv4doyRzHqqMIVD7PPo1nANPmTBtmDjTCs4ew/la0RBUYtQK1yRUZ7JqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gC1seJZBwcuGR7ox2hJGmTyrtxhQ0BMKZoBjDabEJPE=;
 b=XSzyVxqqTnyUBYRvaQMBtfY2DdAfho6ddKms+aV4/plMUIvfkvzhivEi8wnUS690v1j4czRpr4M0PHjIRL3YEOfyWpV0fAyyvGxbqWUq5vDQHH32nHPyxJ17dKsAn2cPoYMY0zATIeCiiPiN4gbmykvrn9Km8TLRSQZjbjbNjlyzkcAnqu0ghO17y2xESWPxF1/z8pvcji2Uro+p5yizC4qeYQ5e9M8K6qF6WomTd92v4djQV6/7wOKanaPeCsuny1UbLOkTr2CPAJjvsRfj9oO+5R1hEz7hzGN7jD/LW7rahvy7NmoLF2OmsHcJ/tvXeJEk9ZZgpAqdAdMdlpkvOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gC1seJZBwcuGR7ox2hJGmTyrtxhQ0BMKZoBjDabEJPE=;
 b=gJW4wtcLkUAlFkH+tMjPh32Fk7ux/SIA5PdaQRo//02ekMdYSGq/utKb8jQ0M09L0f0sVti1PnrrEJa6nXqvOC+YTBNhFirAU6eIWkD3BbJGmc9Wnr5ZrYeEfIOMe8aqKxLUri3ujBO5OLg6kKaStdKTDh/PHNQaKeX+B7oEbmo=
Received: from DB8P191CA0025.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::35)
 by AS5PR06MB8655.eurprd06.prod.outlook.com (2603:10a6:20b:652::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 16:20:27 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::8b) by DB8P191CA0025.outlook.office365.com
 (2603:10a6:10:130::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Thu, 11 Jan 2024 16:20:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 16:20:27 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Thu, 11 Jan 2024 17:20:27 +0100
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	afd@ti.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH 2/3] dt-bindings: net: dp83826: add ti,cfg-dac-plus binding
Date: Thu, 11 Jan 2024 17:19:26 +0100
Message-Id: <20240111161927.3689084-2-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>
References: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Jan 2024 16:20:27.0433 (UTC) FILETIME=[168D2990:01DA44AA]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9C:EE_|AS5PR06MB8655:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 29fcc8cc-2aec-494f-3950-08dc12c1394b
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6JMLU9NOgxBy0fkYllbqnDfqR2RqoUawd+U6fyERKUTTT3xLmHKcIyb3M30w9T+Wl0TVI6RNgNDcRFRLeALTdUCyG9Q76P3Kh9FW0j27pM7WL0we6bxwMFr0wkD3a5Jis/db2fEb1WOUd97xg5HX0rmhhcPDDPAQc6PWeO8pmLKqWuyQj4r+s6pLXBX0ben4nM6xsA9xZAq+Ga63HWAdc6hA52547SAQIcqI4MhOKha4bP9imAZ2hkFrgE52KSmC4JAfW6kYBLFw4bugvoKwT8lRtiyl3if9nLo+jcbaMkdUlnbn9azVLg5tHWk2UMzNA77zFgFvNLgXmTS+IA5ht54IQmmLk70EucZ0ji6uL2Hl+mc4XK3Kl+RhXR6Yj4kDb8+Z5HipuPGx/f65grPdxaQzd1H7Zi1Xmu4gwOCttV8DpI7wRNS7atby7ijSa+dn6zMBNDNRxn9407m1Fp7BKDAa/B3B5AlxgYuOP+PnyTafTda0crAvZktpKYIhEw41eVM2t5ue0JepVbS095LlI40Ss95cF56Br4HdhRTiHEG6EKJwUt7ZJrD26WcwsWycULOfqnIJJ3S9YXia8TAUsqxL0rMRvILUUHaan46/CY67TsCAvsfT0qggS3D/tr22F4zSkx0bZAFZNoQDbSLtojwgmVzCGgSECFjceZWtRqn00mWVopLmYJVZip5Z3UPoSevHi1o33ZdnGZ6rvb+hhG1+PDVXFJkPz6/dFmP1aD8fVAKczDGLGqn+VXuD/afpmwkW+8r0fhTDhJuZrpbAVA==
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(336012)(41300700001)(356005)(36756003)(70206006)(86362001)(921011)(81166007)(2906002)(36860700001)(47076005)(82740400003)(107886003)(478600001)(2616005)(26005)(1076003)(316002)(70586007)(5660300002)(8936002)(4326008)(8676002)(44832011)(450100002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 16:20:27.7424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fcc8cc-2aec-494f-3950-08dc12c1394b
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB8655

Add property ti,cfg-dac-plus to allow for voltage tuning
of logical level +1 of the MLT-3 encoded data.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
 Documentation/devicetree/bindings/net/ti,dp83822.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
index 2f010333be49..f9b68bde57a4 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
@@ -71,6 +71,15 @@ properties:
        13 = 131.25%, 14 = 137.50%, 15 = 143.75%, 16 = 150%.
     enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
 
+  ti,cfg-dac-plus:
+    description: |
+       DP83826 PHY only.
+       Sets the voltage ratio of the logical level +1 for the MLT-3 encoded data.
+       0 = 50%, 1 = 56.25%, 2 = 62.50%, 3 = 68.75%, 4 = 75%, 5 = 81.25%, 6 = 87.50%,
+       7 = 93.75%, 8 = 100%, 9 = 106.25%, 10 = 112.50%, 11 = 118.75%, 12 = 125%,
+       13 = 131.25%, 14 = 137.50%, 15 = 143.75%, 16 = 150%.
+    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
+
 required:
   - reg
 
-- 
2.34.1


