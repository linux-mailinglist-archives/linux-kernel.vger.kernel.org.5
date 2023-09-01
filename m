Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FBE78FA1A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245528AbjIAIlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbjIAIlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:41:14 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656B0E7C;
        Fri,  1 Sep 2023 01:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzArM55kQmclFJjMNtCG7VSIP1GFpO6lt57nS4DtjvBYHp9p1zThLrOOy4bkHlT4OYxFXm/eL/PL05nMSXCLUWAVGEraLxT8bZmOVdKzR647/e2R60S/btP4DPhA/iyWqmOk3UVEPEBQ9VPTLM8W6+DmKkEfdeJJkllmnIS5eU3fvfXZ5Kzj+J9ROm47N2UvS94J9tDq9414Kl8sujanGqWKYfi7TrH0uUuwHQgawGAkljUt1z4AnECi2rnxao3cUUUxisIXRZhMXvstJBkuoHipwbiXQ+iPEus5EswcZn34wNd3QbjkFylRyT0V4hhmOE/PlfAbfLlRlcHu5+2Adw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8O+YruClalkfqIllSd+qhdDpqACJTqHb/oVdM+BnYI=;
 b=F8hmkokeZBHPvwkbJs6sKYvSK64K7QZjsvbRsgVLUY/7QHvhCwm8zm58y5sGJwmQuypSUn+QBijlidBxW0JDX9pwb8uLUSt6oBimD1xoLmji90DQUf4Nb3cB1V+Yx/zO/Nwwmwcleppz7UvTI8TNxyOlprRT/4NtCkKVlMBrL8F/UbVwRweTI/mUfnwVYRD6koGRcl7WgscDphQ1UvZ43GgQ4SV1n2ZzAOEqjf+Xb/5OiyRlEcoOVz2cAocgbJATQZLOyOpfMb4N6oqGJ6IW9Y1q2GyWdl9VDQhM6ZbIF1+hHJpDjNyP7btiAS0wN0WGZHYxQ4ORe85hnQh/rVsQcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8O+YruClalkfqIllSd+qhdDpqACJTqHb/oVdM+BnYI=;
 b=gI6Xh+vK62iFqRGI6ibizwK5iJhysaBXKAFA3jiUVrd2zyoUtygXvR0ouEQawTW34uJkVK4OS/3t5JMDUR2XaJjYU3WBHfinV7Gv1Onuh7DRy54Jub98XSyEiNHFLDfJ8uGL+2VN6KTINvfCEqf9ol7AYzypsH+F7SYSWK7NEOE=
Received: from MN2PR08CA0017.namprd08.prod.outlook.com (2603:10b6:208:239::22)
 by DS0PR12MB7769.namprd12.prod.outlook.com (2603:10b6:8:138::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Fri, 1 Sep
 2023 08:41:09 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:239:cafe::9f) by MN2PR08CA0017.outlook.office365.com
 (2603:10b6:208:239::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27 via Frontend
 Transport; Fri, 1 Sep 2023 08:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.20 via Frontend Transport; Fri, 1 Sep 2023 08:41:08 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 03:41:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 01:41:08 -0700
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 1 Sep 2023 03:41:03 -0500
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-can@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <appana.durga.rao@xilinx.com>,
        <naga.sureshkumar.relli@xilinx.com>,
        "Srinivas Goud" <srinivas.goud@amd.com>
Subject: [PATCH v4 1/3] dt-bindings: can: xilinx_can: Add ECC property 'xlnx,has-ecc'
Date:   Fri, 1 Sep 2023 14:10:43 +0530
Message-ID: <1693557645-2728466-2-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1693557645-2728466-1-git-send-email-srinivas.goud@amd.com>
References: <1693557645-2728466-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|DS0PR12MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a60b809-52c0-47fb-6e1b-08dbaac73062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/SRXZwxN4qn337hC3o9Q6OjnWzIribHHxIUDni8Q7cakiKYaY8kN1ozbmUIBgac3MD32RxYRBHo9jCB9Q0XGBzJARCJ8uB2yX2Gggxx4zZz5JcGMWoG0OkiQSbJo7L8QE/JOUPNVtVEJ5mw/jx2Yy/37T0wojSCi0DeociOLDrcjCVr2OEKhkU8dRIsIPM6x9api96NTGciqqCaO+foVKUuReSj3Kr3Ez5Og4pMjzWXh/ldDijwAv5yfzXUjCXOJTLgFLDl9Tv1vFQFYh1qnlxj3t7am7fdw60F4+DQsYIlLVsEr9EEhPk2bagLh64JpMRZKoZOSgzscSYVheRZ+EmpDv9britJJTHBvLkTYkLW74kodypkRcsZZv1N1UJjkeGu48Je/DW9fmYCmEL8UDvCE7xCu/DrJeXRliI88gY4FPfL5P016wLebC7G21BN+gcw711n4C1lDEtVallz1Z+dqOIwM+10JrGlf0Ak/AIcqEKj44Z7xOGa7eWg7ia5/31o7TA4jja0tPi8dCdMteFVBlFDb09NhFNiRw8Oaxh1NHve/qWKQgLUA1ClJNSzSyL/Jm2LVY0DIg3xxWg4twh3RK4fP47GQ0ZY1fuo/q92g9WVKXL0SmRMCx4Bd2nCD0pPmwGoJTy+VDosDF1XB6uMMrbeVgZmemkRjMgmwEJtSqIMSOFc2PRKHLhQvCErzzEY8QRuQWw6L9afn2zY4aqdLgHrfsGC5QYF5qopcEJ06RMeLmh/kMkhv5/hk5SHvccRszfgsBrtOTauzyoNS65XRJX68RaNW8YyiNBa+n8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(186009)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(478600001)(40460700003)(41300700001)(336012)(26005)(356005)(921005)(82740400003)(81166007)(86362001)(83380400001)(6666004)(47076005)(7416002)(36860700001)(40480700001)(2616005)(426003)(70206006)(316002)(110136005)(54906003)(36756003)(2906002)(5660300002)(4326008)(8676002)(8936002)(44832011)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 08:41:08.9715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a60b809-52c0-47fb-6e1b-08dbaac73062
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7769
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ECC feature added to Tx and Rx FIFOs for Xilinx AXI CAN Controller.
Part of this feature configuration and counter registers added in
IP for 1bit/2bit ECC errors.

xlnx,has-ecc is optional property and added to Xilinx AXI CAN Controller
node if ECC block enabled in the HW

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
---
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
index 64d57c3..50a2671 100644
--- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
+++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
@@ -49,6 +49,10 @@ properties:
   resets:
     maxItems: 1
 
+  xlnx,has-ecc:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: CAN Tx and Rx fifo has ECC (AXI CAN)
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

