Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373E9783E32
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjHVKqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbjHVKqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:46:00 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3D8CCD;
        Tue, 22 Aug 2023 03:45:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFJYCSc/PF7qeLhTRJMwTo+2MJnPMMzgo48i4llBo25FSrX2lU6zHCK3zGb4HUglFoKVzFGf5jooR7CYSJ4KdnwGvn4bV3zCPfXEH2jOOzNNZbDy2lU4rQB3E+PFx+72ZTRpfE1xfxKFmC+yDEDb3OyhkAZNWNIDTbXMIlro12uD8AGNh86hi2dlr87nhQQqLE0STp6Pi5RCQDWIjeLlmTn7dGRKHpVlJMP6iWrvantq7ViO4fGgaM2LP/Y4MTJQen5ocUcXy5wxIqBRj7d35AT05c55qHlf8iVlkmiW7U/RhX4VFLKWRWB4ADhjZARsQjtlpfxdsXfTIx+03DJ6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzD/UwfexFQ4lr1RfNQxDBWVxn5Buau5M2Cz8senYSM=;
 b=hhExCt1rTmmecH78LTS/PNXyQuQycGTLpYDOT5sf+GTMGwYx5XuBNgyh+fvAvc12xKrOq3oMUVY6RHhynW5kFRy6sxfNYHsxeycpVHNSrpKS7dPSYutRJxiYrr6vPv2WJFCc3tU34GZkFqzPDsisvDjLD8c+2UXJV7uJUhvQFeI3m53gRXScU6C4ePiItBgkFy2ytWjZy6tq0RgJyNLU7QKAcCZ0tMskFWk2AOmoeo/iL5GeCo3EIYdjSOx9GJbrhHJqMhpv4mcePQxb0KKMDl4otseaXsIPXuxMTqPG673MsCtf6rRnAwB8/2KLAV7yXjYFlGNt4oRnmEhWCciNdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzD/UwfexFQ4lr1RfNQxDBWVxn5Buau5M2Cz8senYSM=;
 b=TsqHklDnw5NQvThKlN0M7OZ4kX3S0ziq6F+M1Iru+QzAB/hXlxzvNf+/FuzJiQjkIXce5TuPiTB+/fohlyrfaEz24avvrCZO5MQNkJWcPIFlF+8luygOhfxff+/X3piWXsBFR/jigOhN7Ky+YNJxy/M0A9/NVnFdNWNjwHHtVos=
Received: from CY5PR22CA0048.namprd22.prod.outlook.com (2603:10b6:930:1d::29)
 by DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 10:45:54 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:1d:cafe::a5) by CY5PR22CA0048.outlook.office365.com
 (2603:10b6:930:1d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 10:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 22 Aug 2023 10:45:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 22 Aug
 2023 05:45:53 -0500
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 22 Aug 2023 05:45:48 -0500
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-can@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <gcnu.goud@gmail.com>,
        Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH v2 1/3] =?UTF-8?q?dt-bindings:=20can:=20xilinx=5Fcan:=20Ad?= =?UTF-8?q?d=20ECC=20property=20=E2=80=98xlnx,has-ecc=E2=80=99?=
Date:   Tue, 22 Aug 2023 16:15:34 +0530
Message-ID: <1692701136-1422086-2-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1692701136-1422086-1-git-send-email-srinivas.goud@amd.com>
References: <1692701136-1422086-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee6bd41-e451-480e-9d62-08dba2fcf5c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g69LKz1e18ZSk+aPLcZ1AzyQRD//mvn0b4Z7JCWFzK7VMHAKfx+d9xIhzIlL4QZjhpCD0OQrjUZYXp4oeL4hingnlZUk4V0Q1gZYUY1B8OuEV+vENdxKv8eej5+2AwP0jjACpPMYtU01YTlvwnjHjN0Je8ysdJjtdnl+n5oiQo38T358OD0ZfQo7e2egOFueyE3UZWppEbFk0lzziZrFRZoR+wH10AysHZv20GtV9yVGrqcilUn6CjacSZXceaekxx/VZUKx0979yH7qHO15a1+WMdDIYfxgDe2rDgcwqtdFT7+ea1+6X1ioIEQ3eW516iFbDAAaxes0pG0RudP9lR2SeLK1ALyWKBYTNvdiIrjB/HIzkspIF68VkOr/Uxzr/nQEebWvkBkSgauVffwOt7SYLO9IEONDCqNl5GuiFo4DvOu5dnjxftL0/qdqClgAzdcJOZf0TGKCc9PRryGi3eQbRnTybdA7o1HrHlETClUAmmWEnozR7TTjnDad90OLFFcOKXz/ObR43LmqM6HU7Wv7QDGHQZKpXpjwMFhkjas6P0iYRLFDLvxyrsUFeYbgoTKhBKIILBwl1YcU1JRXkUZGIeUO2ztp/Cf72vYLNPrqdz9e21sVLFn07aBnL+KASEdjTIP+b6tS1CtLPxlYewLkxRFNz98m/wdkr5LxKIa4xiuU/IIEhIOPWeSI0HQj5H9HSecXJ0CaJYGDl6i0hvtwJQSn3kQ49+pNQSm11U2MUN/tVBNIqPEw4uCr8CqGakgwKx2zOA1WWcC6lbT63T342iorn28vn6PSCSydZ6Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(1800799009)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(54906003)(70206006)(70586007)(316002)(110136005)(8936002)(2616005)(4326008)(40460700003)(36756003)(41300700001)(82740400003)(356005)(921005)(81166007)(478600001)(6666004)(40480700001)(83380400001)(2906002)(7416002)(86362001)(47076005)(36860700001)(336012)(44832011)(426003)(5660300002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 10:45:54.0856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee6bd41-e451-480e-9d62-08dba2fcf5c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ECC feature added to Tx and Rx FIFO’s for Xilinx CAN Controller.
Part of this feature configuration and counter registers added in
IP for 1bit/2bit ECC errors.

xlnx,has-ecc is optional property and added to Xilinx CAN Controller
node if ECC block enabled in the HW

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
---
 Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
index 64d57c3..c842610 100644
--- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
+++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
@@ -49,6 +49,10 @@ properties:
   resets:
     maxItems: 1
 
+  xlnx,has-ecc:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: CAN Tx and Rx fifo ECC enable flag (AXI CAN)
+
 required:
   - compatible
   - reg
@@ -137,6 +141,7 @@ examples:
         interrupts = <GIC_SPI 59 IRQ_TYPE_EDGE_RISING>;
         tx-fifo-depth = <0x40>;
         rx-fifo-depth = <0x40>;
+        xlnx,has-ecc
     };
 
   - |
-- 
2.1.1

