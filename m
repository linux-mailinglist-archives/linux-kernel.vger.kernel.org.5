Return-Path: <linux-kernel+bounces-6943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D634E819F96
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C183287964
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0567034CD6;
	Wed, 20 Dec 2023 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Aqykr9mY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F195B2CCB4;
	Wed, 20 Dec 2023 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlfatQFvJuUBQGpO7TgbBjnJuI3x5F8hOX1TSdCD8MgW4Cuk49ynOMPSXd7D3Ydku1Bd+owz7r+PRos/0E+nVdaqapWHvulXbeZKJzivWKeWyCsfChgvuDFQD77mLmYjNhnnuuUsiaCFUMNpJwn159V2azUeoZq2aK6AEORfmzuaHKlIeeEqDP17/BgFnPw2F1mbe0nqt+mB9sgHOHkh77ky7RWVp2SrK9GAX7vkNQfsH9GHCTrNAlpyMPXYosgxa66QB/aKJ/wHI6rfeZWC1TUw07b9xusPHe5IOEf0hAiVyQkvcbu3ZhHqfQEERMhON+07jbNwu5XWv9u6VX/aJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36a0wC6j/901i+TqhCzzKRPz/x4zYo/zsmSKuo6wRKg=;
 b=NPYd5DiYQxMz3OXc58XK8tzlyttTZxx9ONIsj0KVS1lqV6kCyS9p4Wk2qbg5maxcJKMWYDnt6/eEp5k3JtUdpfyOJPgJPuGkbs4daHmkvM0UZHwb0r5G9puzkCV5VJ4fD1g4bc7aHhV39nBMWvDAGeiJx8gZIs3xyYdLBmEYmLyBkfOTsWyssDbEdCrku/uNzyyA+Oz5OvFcUtTayLlT7ddAbqteGTw+EQRWl1m+4ZdaK1ROytFdmdrmvMx162xgM23uwNxFZ4/oLn1ZtehQojXnEzFayxc3/5HRddpldDV8ZO4cpsobHX95Kv4BPCg/AWQvOPaID5ZSVOKzqw6qbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36a0wC6j/901i+TqhCzzKRPz/x4zYo/zsmSKuo6wRKg=;
 b=Aqykr9mYc6AksGs+MCn2m+MCCEs7KLNchZABOj0BuzrgIpB96rLEosZGxJZR58mjOHRloXquTDBZZYKMXCVZsZMiitxnoKW0lzqlLplJJi4IeTpHgt4lamMYZ3BcfufH3jO8rZN5bnYnk34BV6s0lU5OVTZJsoBlduZFgPO2W4A=
Received: from SJ0PR05CA0097.namprd05.prod.outlook.com (2603:10b6:a03:334::12)
 by PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 13:12:22 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::aa) by SJ0PR05CA0097.outlook.office365.com
 (2603:10b6:a03:334::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 13:12:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 13:12:22 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 07:12:19 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
Subject: [PATCH 2/2] dt-bindings: hwmon: ina2xx: Describe #io-channel-cells property
Date: Wed, 20 Dec 2023 14:12:14 +0100
Message-ID: <aa303b9fe3116e7f98d6b72822f7f57694366db3.1703077926.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <6f3c57d08984c1978569d3918cb38eb295c0c67d.1703077926.git.michal.simek@amd.com>
References: <6f3c57d08984c1978569d3918cb38eb295c0c67d.1703077926.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=michal.simek@amd.com; h=from:subject:message-id; bh=mYIwEpNjWemfe0sYi3/Kl0a/ENCHVsvLOLesvpN3/dI=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSmF1pVS55cOHSP9cm3tJdT27280uO46pZxa+VHLV+p9 9Hb9qNuRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZhIlxnD/Ljd4hMN9727lNwU ZsL0+td/K3bbhQxzBeJE9uYs23vwofO2A3+OCiy0OXC7FAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|PH8PR12MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b9dbbf-30d8-40b2-b88e-08dc015d4d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7rvpxOAxpnBvXSDGyijKbhaCKfigfX4FlYBDS+csGDamCOqhM8UD8V9pLnp8hjGYLI9MznkQPWQIpFiQYVLm4xgs7lTslWK5j0gbOWIrXqbn3OTCinHVB3vxntw+lBdkI4mQ0zgHajSjAFG2/LGihv4a5Xdq0plxyOKWq8Qk3qoL071ahzvbzLyBfJc1YnEpLU0ENdeoTJ17ePzJJbqnG2RKnfLYJDsqjvuuByKHmZ5QfhCGskQO2PFIdfxOMFPFbaGbBBo708tmTHBIJqkAB8EbAVq3H83KGmo5vMmAOmGqAoH2Mt9+CEsA9o+h7d3OEkw8NwIUZxk0iljKLeFBIqKJwVBNBKguRWDAHfQiqsnnoxTgPAWtar9y3PhrA6tZJ+riA+Yl587uJD8rIeKhnLfDEcfwjpKF9OTpSCzEXCONZ+3M3W97uEeSKri2efQM1rwmaATYPt0BMHd/H5iJ8VTbACP3lyLE26GD8FCOVEi4ax3B9d7mKS580JHtrE/1DgqW+bU/6dqJ26NQL3rCQDX1SoaUjurkYeCh1L7KwM7dejJkVFX8bEtOWyFao38QeJvoMUNa9dfuewPHwVCe1IqGBDAwGIKyN9Dmn+TQHu7MpyqQLaCcZ/25cbz/sQzwxohdgIKbhsU7DW3ut1PaMrh1BJSMqMwuQUefL9BGW/IDMMirAfd4HHalC5sqX/d6Byp0nPmMrjOb/pB0+yiRdmb6c7CtQ9VgT9H0FvLnyaL1IYP0qwc6Nv2nXelJIP3oMlEWAcgGHZhB1JLlBdF2sbndTm0l8q3oxu1/wFSlcxI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(36840700001)(40470700004)(46966006)(40480700001)(6666004)(336012)(16526019)(426003)(2616005)(26005)(40460700003)(81166007)(82740400003)(356005)(36756003)(86362001)(47076005)(5660300002)(44832011)(7416002)(36860700001)(8936002)(8676002)(54906003)(70206006)(70586007)(4326008)(316002)(110136005)(41300700001)(478600001)(4744005)(2906002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 13:12:22.1568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b9dbbf-30d8-40b2-b88e-08dc015d4d6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6939

There are two drivers in the Linux kernel. One is hwmon based and second
IIO. IIO version requires to define #io-channel-cells to operate.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

zynqmp zcu102 uses this feature too.

---
 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
index 8e5c1935b5f4..f324b627bf9c 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
@@ -32,6 +32,9 @@ properties:
   reg:
     maxItems: 1
 
+  "#io-channel-cells":
+    const: 1
+
   label:
     description: A descriptive name for this device.
 
@@ -80,6 +83,7 @@ examples:
         power-sensor@44 {
             compatible = "ti,ina220";
             reg = <0x44>;
+            #io-channel-cells = <1>;
             label = "vdd_3v0";
             shunt-resistor = <1000>;
             vs-supply = <&vdd_3v0>;
-- 
2.36.1


