Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808417E2076
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjKFLx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFLxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:53:53 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD0EEA;
        Mon,  6 Nov 2023 03:53:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j61vRowqoIzuBlZWrPl+lcan17UynL/8i7W8TMeUYk8R1XYTVQ7T+6oZ/NxZNlssNDtV8jWg0p3UBHWrgjX8tohj+wX5bxvh57OEahih6OvomhHPsKipkvmJYXU+m8D/mGgqYyKbL1AYM7vEOfCxWr6z9CX0JrliGykTBIk0KpseNAsBbiqt8MHxohmJ2dlF19GIEixYHsHpDLMzgSrBfRp2+VeNFWy1mFmvH09nVUtmBTFkeTb7jLBuKT+IccRyoHAYVnQ5s8NH3nmVZEDO2AyoqF0RKMRN2jBs+s6E1mu6cJqqAry/LKOUHICrj5feymVQG5AXUempYdDZVitcyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxztdKt2LTnu6rdoHzDmCD0NVqNKmqsjzMvrtfnihNQ=;
 b=fY19fIo6oDcSBijP+HHqbOjc7Afaj2Z7242LARO99Qpw0hb4m/HDYKJC8KTMvpL0AIg8/qS9ABFC/k6Kj+WTI0gUyPsPzsNX0Lv82Z11iE+SVeDOjkNPPDmqsYll5r9m7/ATZyMy9AILQi963hT64SQiDWwKhwBcgHF54jC82In07Y5XtWVbZ/grBRfAiBpMYkZWcrFuRTjdmACtDG5dT+zvDJ3CeAmIyMUuske6kQY2sGoNdPb9f/SSrk9ltE8LVMb0PHNPVGOpYSLjMrXvaL6dvp2+EuomdOjXBimyIQKflQO1L6WA54SlvQ32jGYgJ9VS+8sgyBxbryHnLVYeoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxztdKt2LTnu6rdoHzDmCD0NVqNKmqsjzMvrtfnihNQ=;
 b=mn3ahO2OYzAKEWxvpqrGGy6RjVJAxoBE6ySqZUU4Pt9QELKVT3vp4GZ9blMh4ai4mt8hmSZkWopDAn6Gk4DIDw6FOQRRNNiP2rvc0nA4HKVe/iC0uJIl9iXFnFQD8fbSHwjds+inHVYtXsgoxuM1bIKnxjpFJqqkC0EN3KbF8Qs=
Received: from BL0PR0102CA0041.prod.exchangelabs.com (2603:10b6:208:25::18) by
 BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 11:53:48 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:25:cafe::df) by BL0PR0102CA0041.outlook.office365.com
 (2603:10b6:208:25::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Mon, 6 Nov 2023 11:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Mon, 6 Nov 2023 11:53:48 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 6 Nov
 2023 05:53:46 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH] dt-bindings: soc: Add new board description for MicroBlaze V
Date:   Mon, 6 Nov 2023 12:53:40 +0100
Message-ID: <50c277c92c41a582ef171fb75efc6a6a4f860be2.1699271616.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1285; i=michal.simek@amd.com; h=from:subject:message-id; bh=rquOInBbWhUh7O0DOSCKM4I1RqSUPsURm6mD4B4bozY=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlSPy4d/aT+d8Mvw/ZTyuL9NZ2tn8YaGKKXKXr70sz1Ds Slu3sczHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAis5MY5hlPkmJee1VzNU/U 8y1MHvbcr28svc0wv0jum8fZ+hmfHuqucljzn/F0luY/IQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|BN9PR12MB5356:EE_
X-MS-Office365-Filtering-Correlation-Id: a83d6757-2cbe-4b5a-bd1c-08dbdebf096a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: psQ0QtdDWf2zXc9wP94+6EDOALotEt3DeciwDVSQ9oFk7GV80mzit2d8XBMuWwbQvXWuTkRki47oeUwOvAGMWEYlOqZ2lb0iYNmOX4p16YR7A77gUt+xvvcbC9xMXyfb4+N8ZMQ9TCo1S8KtStRvzvxOTzq/aY2yfwtf4rx7LByUFWOPVllc+TjTwrk4BMCkS1ZicLSpjkd3z1HV1rIqBLfPikoXCkRJhGuIJwRz5JNbcqTYBgxGEi3zHXGAeSbXnDxB7JsUclx4+4q5rOIR6p5jsEHsZfnTWVjudOF85m16tJhVxCcUWomVWIldQy9Y6Dzkt+SAjqSzod3i5UUs3pS1a7eJPMO6m0JqYKlZYVA90p4y2a1LmNCt5jluF4b5mENwTcwVA5zoxfj5lzAE2kxyVrWKtVqq06r6k1lnoZgVtJABQ2bCW3Xgd4ykGD8iopmlPoqg3mbLbJMyD2qjVnI1wh99S5KKEhjeBZXBjdpiZeIaPyGlBCE3t6RR1oYOttDoqpedEUK9obntjJp3mI45SI+UFGZUCCWF9cbPWO3RqqAZmmIN/ugHlG6aMV/587cecCDFTrJ7UbCW2W5WxQqoH/mrnLSvcNb4zjATk5H8/SChwylE20r7utbtfZ5tDA+B8kvp3BZqXGhr7hWYPK8WBd3fOFvkxHd5WYUh0m7wH3bhMjhH7LPzkx57SmGW5rTKiA4UEyDsiGm4amwvLtL4WpCLfsapQpvsDHDOe+CRaDB+5vjeq9XtnHbQ9Uh398I10EUBuVO031gksM/IrIeel+sCFzE3DLB+5wMXsuBajNDXo37h+Hg7pUdwOunH
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(2906002)(356005)(4326008)(8676002)(8936002)(41300700001)(5660300002)(36860700001)(81166007)(86362001)(47076005)(40460700003)(426003)(336012)(82740400003)(70206006)(70586007)(44832011)(2616005)(110136005)(316002)(54906003)(6666004)(26005)(966005)(16526019)(478600001)(36756003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 11:53:48.0698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a83d6757-2cbe-4b5a-bd1c-08dbdebf096a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5356
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
It is hardware compatible with classic MicroBlaze processor. Processor can
be used with standard AMD/Xilinx IPs including interrupt controller and
timer.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../devicetree/bindings/soc/amd/amd.yaml      | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amd/amd.yaml

diff --git a/Documentation/devicetree/bindings/soc/amd/amd.yaml b/Documentation/devicetree/bindings/soc/amd/amd.yaml
new file mode 100644
index 000000000000..21adf28756fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/amd/amd.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/amd/amd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Platforms
+
+maintainers:
+  - Michal Simek <michal.simek@amd.com>
+
+description: |
+  AMD boards with MicroBlaze V SOC
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: AMD MicroBlaze V
+        items:
+          - const: amd,mbv
+
+additionalProperties: true
+
+...
-- 
2.36.1

