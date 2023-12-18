Return-Path: <linux-kernel+bounces-3264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E982A816A12
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A97B1C2254F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A52112B87;
	Mon, 18 Dec 2023 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PggktZv5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2661112B61;
	Mon, 18 Dec 2023 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIrgUHIoJWGHaeqNkxklYQsY8h54vd5qz+WAoJiuE+xAGhI4MMdr0o/IDN8Gaj2lLnZx5tTWr0H437CRNsIG3uwlCKTc7YxYRyfWmsaxU4R/zzBXDn2Sgtj6n1dihUQUP1xo3M528IeUPHXxRkXaa5kOOJEQimBUoZVlsaN55FZ8xoxj2iGKTxYbVYpB0C0cCHnKDy+lR6teQfyJBeg/iMBz4YXuzNR1AbrFdGLm7LwuTAvOd5hbSTSrmPF3MRqqffo/0hXIBm1BG2mkMOgPfFm91RLaj+SR3atPXtwnG2gBVEiCru6L97JOeEghyt2HU8l+qrNqA1khiH8E2JBYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbhj58mQcIKLIJVwk71Rk+CDCC+Wx+mOoWWWEqARXPY=;
 b=mubDorlsbJjSB4lRxuQHe7a4ZQzz+3xrhY49U+8Xf1+E6nYTdWVyMeOcLiixpZHAfu+QO7naGHw+ZFaOi+vq9T28War3wrU7s/GNuR9/aySreS68Ni3DHW6bRiqtCYNIWMh8DQFrxU4aj7TSY4mtw9ivsS1RjP7Cuy/mO2ckmIxHzuwOgll08jSpK54C0ucRGKslENW9erSW5uAPxbwHbT+4d/rzFIW0d2K3L8CJYfZmUcvEyHzktwUpMCqjpj6wbaSlnaUznP5vxa2eYNRCqxCqnWQe9OAU0OaO0Aje8eVpsOlZ279URaYQ49UF6fb0XjI0xV7YKDqrG2rc/znewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbhj58mQcIKLIJVwk71Rk+CDCC+Wx+mOoWWWEqARXPY=;
 b=PggktZv5IuHoBa8v8s9XLso55vKT5bDf3+RKxJGNptkFRmZp6pEjQzcQQYrTI4+M/7Yah8uFwMt/xwTtFUwBiCcRxH/gMIyDzP/7zTIyooJXow7Y6UIqv8yNbj4LMdECwoSi6zPjRqZGKjorbcbDsAtnZo9rv9A518HICfUslgg=
Received: from CY8P220CA0031.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::17)
 by CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 09:44:29 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:47:cafe::a7) by CY8P220CA0031.outlook.office365.com
 (2603:10b6:930:47::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Mon, 18 Dec 2023 09:44:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 09:44:28 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 03:44:28 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 18 Dec
 2023 01:44:27 -0800
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 18 Dec 2023 03:44:23 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH V7 1/3] dt-bindings: Add reference to rs485.yaml
Date: Mon, 18 Dec 2023 15:14:13 +0530
Message-ID: <20231218094415.2503672-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218094415.2503672-1-manikanta.guntupalli@amd.com>
References: <20231218094415.2503672-1-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|CH3PR12MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbff0aa-d96c-4cd1-3574-08dbffadede5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	szQoueUoGtnwpwaVmi+thzBuDKoOs3HfkpPrv0ez5MV4Y+3fLi1ffNtH/7+BsuBaKr8Yh/TsY6fPdafpFmq175GUcuH7bYOanJxBdO5Fibuc3k00/Pg6O48QZxLFhSVKAhdGRxamSf/9+GH0rSCH6R9PlAA9yJDYtcQngY7Igi2IBEJ+xADxnFWpfxNovdmNyk9GLd6CJk0AYzL+R93h/Hcqfw7Vx03uQo0uWDaZxorj4QwMbiGL9g5oBjX24n4ssY5+FOPl7M8BYiLS6k9sMBhhm79TPd7ZO/xIk7vt5HijarmAvZvBahflOCIyAY6YR7lrOmDt4qEu3vVKtP6+Sx7E/I0mKpKMwaKwIQy4Kxto2fIeJ7hqU3I8FKloZc/xQJXbH82CTEwxfwpUATOuoUoI4Gc9pHEYtH3W9pzQlZ2VJ4zpY7ppM9iHijbYpBKRN+rbJ91kodJcqtW5hT5WQ/8n1aTQyTGSOo+pT6s40CjVChska1zIexnlYXq396jan1rnRPGeZpzp0tlF1328qz1f++FiCeqvh+BFflFXuiS2bfhodkpQ6V1FTX6AlaL8a1cjWBQKO311vqIP78RjOFD9NzZ8MgelpXBTZ7myd7AJeNjaRiUcjMAacBVSZw+5/f5H+/9Ibel6fgnD62ac7GYpHwcgiqpWGIF2atY+jmHdexz9Z19KqhL6Yk5635rQd2JN64P/mQgl0xSJ0kR0dtQCepdvm3TrUTeX194l21xpfI8u7vSuqVkag1ca6FQE+FrIWsFHs0Mto61s1esBKlYsNEbBDn+ikE7euq4q1LU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(82740400003)(7416002)(356005)(81166007)(2906002)(40460700003)(36756003)(921008)(41300700001)(86362001)(70586007)(54906003)(70206006)(110136005)(316002)(426003)(336012)(6666004)(83380400001)(40480700001)(2616005)(1076003)(478600001)(26005)(36860700001)(44832011)(5660300002)(8936002)(8676002)(4326008)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 09:44:28.7766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbff0aa-d96c-4cd1-3574-08dbffadede5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252

Xilinx/AMD Kria SOM KD240 board has a rs485 compatible peripheral.
Update the binding to have rs485 support.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
Modify optional gpio name to xlnx,phy-ctrl-gpios.
Update commit description.

Changes for V3:
Modify optional gpio name to rts-gpios.
Update commit description.

Changes for V4:
Update rts-gpios description.

Changes for V5:
Remove rts-gpios description.
Update commit message and description.

Changes for V6:
Update commit description.

Changes for V7:
Update commit description.
---
 Documentation/devicetree/bindings/serial/cdns,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
index e35ad1109efc..2129247d7c81 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
@@ -55,6 +55,7 @@ required:
 
 allOf:
   - $ref: serial.yaml#
+  - $ref: rs485.yaml#
   - if:
       properties:
         compatible:
-- 
2.25.1


