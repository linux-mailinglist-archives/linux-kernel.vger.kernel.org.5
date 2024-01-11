Return-Path: <linux-kernel+bounces-23853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C5B82B2D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E521C239DB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C660551C48;
	Thu, 11 Jan 2024 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="tybnatGY"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2100.outbound.protection.outlook.com [40.107.247.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394735025A;
	Thu, 11 Jan 2024 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWc/uJYrOhlCJ30ixQ+q3HDyvHImT8ftNjUXMxAAf/HNDE8Rcc0+AZKg+nK3ngx+ALCizTq7ChVLcA3S6VSRLcdDwJl4PvHecVw4+ZqZm4+S8n4wKQAOIWAeLFk7RefpMlyOPg/h2HV3APioGd1e75jAppl1rTQ5hYkhwzt7ZiYKLriWHwZRM6QxhMce4qFmQIdzB4KODuuhsSN885Pu+zPYmJgtEC0w57jZbPYu+SQiX247RIqN1f5iWqGT2Z9YE/yJHlz9Ay5Z7Caa5PozY8dR/xxyqTuVq/0f/r2kDkOEBtncfli+QFQkPzmKlJMCVbh+ALJZpBKHymLpfsFWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aQqe5Pbmg9/g7Hqzu5M8uFwCumDkHgty4VSR4lSNjk=;
 b=ZPlZE0Qo4Ws+4fEHeyeOI8vsKHG/54YCgyLnjW7MLLFz5yJ46lJtkdPZSKJewJAIMFkTcnWj2eb2ulJ5/3VIqHdn47SziJGOt9Ao6xuixn1zKP90dAl2q5ameou/GY/V19ellYfOlfiv6oH+GWYifwKhg8u8a4rg/1ZVhqmCJjJyd04Rss3nGy5Gx71lTT8Knle1VgKhuVN8TP5adps2eF53yJU29P6WzmoVTRmyZW9elusk56R+BYOEqe9BT8xEwCoAsh2yfzpdwNPnGomAqpSqT4yDtA54pV7XmfA4UqdzlmB0/WLE+xWTqSIMVVcCB813bXh4XoXHX1g1oaU+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=temperror action=none
 header.from=leica-geosystems.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aQqe5Pbmg9/g7Hqzu5M8uFwCumDkHgty4VSR4lSNjk=;
 b=tybnatGYYYeeQTPjki7liG8Cpdw+tv1vVDkF6rXGw5L3vSKl50++9tORhDqtA4RV//P/g61VLIeqtB/yV6CgNM9bLGx84nm2ljm3DlplQu3CDtPada/yj74CPZ8pCCUPg22Peb3x13PypFE/nqsh13mfEz9OwIxNO11u6cUbIow=
Received: from DU2P251CA0022.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::20)
 by AM8PR06MB6867.eurprd06.prod.outlook.com (2603:10a6:20b:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 16:20:20 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::9b) by DU2P251CA0022.outlook.office365.com
 (2603:10a6:10:230::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Thu, 11 Jan 2024 16:20:20 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=leica-geosystems.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of leica-geosystems.com: DNS Timeout)
Received: from hexagon.com (193.8.40.94) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 16:20:19 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Thu, 11 Jan 2024 17:20:19 +0100
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
Subject: [PATCH 1/3] dt-bindings: net: dp83826: add ti,cfg-dac-minus binding
Date: Thu, 11 Jan 2024 17:19:25 +0100
Message-Id: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Jan 2024 16:20:19.0199 (UTC) FILETIME=[11A4C0F0:01DA44AA]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|AM8PR06MB6867:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 21d94795-6ee9-4970-5c92-08dc12c13481
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NqlWwgovF6YMwSXVrG7JlijejGgjyCIknlQVU/HkMjug1QPSVkMMQZTyppkApvSbQzPcLM+7N08lTXsHhdutd03iukkyhHy3WfnZxNh6/cDWxllq1XTSQE524/IGNIlrchubwpOTGlado1b86R43xYCo3kXhOK6axE33ux6zT1ADlASMU6rH39d1EZ7lQlqhT3X9CWHAh3SVoN7fnV1GkAQr8TuEtc6WzZZDASTikkcaAP7JqlkSVAuoGISiXLsmwlKwpkWx4e87bC2vOl8Zn0TyPomASX1oPtqDxrn1YWLegSQzz59TzMkJR7I0EASWe8qun2QH3tybHYm5tKgdevCfzG3KjdZS+cH+rWBQ5eKTWKqd1IySx32nPDi07dr2siQVMrJZqc3H9IW/aexgsHbE5DG7eIjy2CKRMLGFBBlZELooPPJFkXC2dmr/Goh18jqcq8llP7YU6XNbf3KH6w6me9Dv8F/wuZRi1+jguWpBY+hyc7grQ9d8AvVbUbpKrJgxgT4yO2EQMiIfb6uhwEkNivfbDnEe1C6qkgm05VP3IV6xvKdacWCKLyoBIbRCCsyYO+TPmPpZe5RZteJP99vVSuvm4FQomg2huS/F5dtqUrvzc8h9tMDVIcvnMo1guf4GMXIpJiCYW3JQU9HRiSM2gFb2Su+6W95vrAh2mwzjOcQ6SuSGt+shJjbbT0Q6LeDyCdKspnR+1iFhxeieVftTxms4qDIzBdzDM1rTBDsjwilYVRAppmf69NT9wE6X2Kc5HEKl+5+tf+zwU8OF6A==
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(921011)(70586007)(336012)(36756003)(81166007)(86362001)(356005)(41300700001)(36860700001)(63350400001)(63370400001)(2616005)(82740400003)(1076003)(107886003)(26005)(47076005)(2906002)(6666004)(70206006)(8936002)(316002)(450100002)(478600001)(5660300002)(4326008)(44832011)(8676002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 16:20:19.6617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d94795-6ee9-4970-5c92-08dc12c13481
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB6867

Add property ti,cfg-dac-minus to allow for voltage tuning
of logical level -1 of the MLT-3 encoded data.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
 Documentation/devicetree/bindings/net/ti,dp83822.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
index db74474207ed..2f010333be49 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
@@ -62,6 +62,15 @@ properties:
        for the PHY.  The internal delay for the PHY is fixed to 3.5ns relative
        to transmit data.
 
+  ti,cfg-dac-minus:
+    description: |
+       DP83826 PHY only.
+       Sets the voltage ratio of the logical level -1 for the MLT-3 encoded data.
+       0 = 50%, 1 = 56.25%, 2 = 62.50%, 3 = 68.75%, 4 = 75%, 5 = 81.25%, 6 = 87.50%,
+       7 = 93.75%, 8 = 100%, 9 = 106.25%, 10 = 112.50%, 11 = 118.75%, 12 = 125%,
+       13 = 131.25%, 14 = 137.50%, 15 = 143.75%, 16 = 150%.
+    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
+
 required:
   - reg
 
-- 
2.34.1


