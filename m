Return-Path: <linux-kernel+bounces-24625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A22682BF59
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35665286BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E906A035;
	Fri, 12 Jan 2024 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1+wPo49+"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDD76A022;
	Fri, 12 Jan 2024 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjPqlGYd2/tat9iuWgMuDKvB4wZy2uQOtWpt5nKqascJ/hQsNHRQoJ4bfRq7FHPNehuDtaEf6O74Y1W/BlDy/ttWdOeDqML+DFHriGnIUMHt26Xirf8y63ZfQoxVLdPWagyewzxjaLxMa9C36zAQ4ylXKhG09mVJtIOh5y88EETUg0Mbjy7nvgaxYOmOTJj3eCPJOu1lCpFxaPJEK/YjBntbG3RuKQz3B+nTH3i8+unaSejNvgS86KvHaMr2GGdpAR6jsxrs0GTSXBNgtnmvKNvt4j94DWP8a4oY+E0du86T7MjbarT/wKP7ThU9vLy4IQ3JpLwVtXHqtBq0XnebVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUw8NmZhAE6as0nSqZrE/GQBfjijsH7Y/gh1N9abdZA=;
 b=Jgev2XHrAeW36kGGx3ENwxTUiSYROITv8jii5Bws1bwAAwWoh6OBP2JS3njCom603AAoy7GQvuannroRlrl6zBF7Hw7nQcYecwhcnjSlj3M8Vq50dgqQvTok5WyGOOTPcWMXyB7ErhBvfLvwjjQ1GZCoIEdxq6O2cYiuvrWPOD+x5Pn4THe0j1BS5eAKHiyCiCw+yQOaT60C+CSUxaFV37WpYdt545vNCF7Ji1VD+ZQ94KryW+qUmatSb4nVXe8ibDEHOhk8TlXyeqBoJXsf6bo0LW6kvoCsooP5byDOcFDG+2hmsuWHW6FeAakWnfvOBf4vOF72avLzTQ0UutMSaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUw8NmZhAE6as0nSqZrE/GQBfjijsH7Y/gh1N9abdZA=;
 b=1+wPo49+vmOR6OQvPI6EG+0yrD+Kd6YHH0lIADolwZOAifOIJZi3zZLjlTwN3J048NUDLnppwWIWdyjtOMDgbiB6vdlm9gU5cAI9QEPBmaww7RfPuEjFWsTx23vcqMXgQh+VFKddU4E5jx4pYUSdOEHh5pNT2Mq8XxsK29rxUvk=
Received: from SN6PR2101CA0021.namprd21.prod.outlook.com
 (2603:10b6:805:106::31) by DS0PR12MB9397.namprd12.prod.outlook.com
 (2603:10b6:8:1bd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Fri, 12 Jan
 2024 11:40:56 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::63) by SN6PR2101CA0021.outlook.office365.com
 (2603:10b6:805:106::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.14 via Frontend
 Transport; Fri, 12 Jan 2024 11:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 11:40:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 05:40:55 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 05:40:54 -0600
Received: from xhdvnc205.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 12 Jan 2024 05:40:50 -0600
From: Srinivas Goud <srinivas.goud@amd.com>
To: <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC: <git@amd.com>, <michal.simek@xilinx.com>, <linux-can@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH RESEND v7 1/3] dt-bindings: can: xilinx_can: Add 'xlnx,has-ecc' optional property
Date: Fri, 12 Jan 2024 17:07:31 +0530
Message-ID: <1705059453-29099-2-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1705059453-29099-1-git-send-email-srinivas.goud@amd.com>
References: <1705059453-29099-1-git-send-email-srinivas.goud@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DS0PR12MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 5523c5c6-f365-4abe-8233-08dc136356eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i58WTts3x8YVFGn8+zeIG0HI7qsByNAR8k0/n8WhuT7upfmQDWGTS5pv0rNjuTwcioAmoD1DWddSyyspFFGgXHAk9LVAeTxzR8kJk+mpS7bB4tbDQ0DvnGMLK/RwmW2AIeDKmvClrfzQSvoMm2LL+EsadvkOB73+IqY5ejG+ZPak2Lk1GqDSVVWBytOiE+EC65as6cu7vL/Rj4+pUgVidQQVb4v47krTayK2TLdMYRQ+8Dk9eedzSYGPvKjFAxu+/YupqsrzNyXB8VAyczCX2ZD5bIajOXthwZG5QMFfQ+wk8r6UOB5HPnTXojgiB8YhHtKDyMYtjZ53GTIrWJfaj/SRJZNoZtKFTaFceWfDH4rLDZSdeDLa4C2zc3Q7zv8T83XDqG4hrto8xlpypf+j/Xowk62B0H8jrJdC0UAQ5TkBQ15QiTg9XHvKW/imXFzoCMwiMhhLGwUyk5sTlJtE20RZVmlA07EyIPRn712q5jeMgAb3u19+cb42B6FsNBo31CaUrgRCiQv6W+im+3MxPJxCNutmhX+COgQbXav0CmEhft36ugfTgCP1cj/ebsXd5E3HKMcnzJg/clcw4rj4m6nDTKm8uyLeFhO0AZCMKc4PFS1a1pSaZsKnb/3IA3BOgxXDtyrX/H446B+KQHMtWYUO2mLugKWCKYnKdd9tDdMmW3jQZ27DtRtK3komUfqDVbrvQJB7mvjRCDq6LDEnIPlqMwqbc9lZNWHBGe3yu9N+sw72F8R5NdoH6KPA5REqhjSRqdWjh+bKXnSiQHpUYoPh4zirLBEGoSp1KN2IV6N87r7hJpQDkS/gbOofkDXhatkNrGdGjoviLunZ24I5oQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(2906002)(40460700003)(8936002)(54906003)(5660300002)(7416002)(44832011)(70206006)(8676002)(41300700001)(47076005)(110136005)(921011)(316002)(70586007)(4326008)(356005)(478600001)(81166007)(36756003)(86362001)(6666004)(26005)(2616005)(36860700001)(82740400003)(336012)(83380400001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 11:40:55.9951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5523c5c6-f365-4abe-8233-08dc136356eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9397

ECC feature added to CAN TX_OL, TX_TL and RX FIFOs of
Xilinx AXI CAN Controller.
ECC is an IP configuration option where counter registers are added in
IP for 1bit/2bit ECC errors.

'xlnx,has-ecc' is an optional property and added to Xilinx AXI CAN Controller
node if ECC block enabled in the HW

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v7:
None

Changes in v6:
Update commit description
Add Acked-by tag

Changes in v5:
Update property description

Changes in v4:
Fix binding check warning
Update property description

Changes in v3:
Update commit description

Changes in v2:
None

 Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
index 64d57c3..8d4e5af 100644
--- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
+++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
@@ -49,6 +49,10 @@ properties:
   resets:
     maxItems: 1
 
+  xlnx,has-ecc:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: CAN TX_OL, TX_TL and RX FIFOs have ECC support(AXI CAN)
+
 required:
   - compatible
   - reg
@@ -137,6 +141,7 @@ examples:
         interrupts = <GIC_SPI 59 IRQ_TYPE_EDGE_RISING>;
         tx-fifo-depth = <0x40>;
         rx-fifo-depth = <0x40>;
+        xlnx,has-ecc;
     };
 
   - |
-- 
2.1.1


