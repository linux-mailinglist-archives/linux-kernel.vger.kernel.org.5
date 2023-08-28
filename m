Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A8278B3DC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjH1O77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjH1O7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:59:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABACBF;
        Mon, 28 Aug 2023 07:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgVXz6eMQ/T443Dt28hC81At+98+MZU4+uJoXtqQameLLB7OBp7nje7P5sy8/CzZK3uQ3RVARvN8U2alOR3odE8tEFBjSJrkfgDpqw+FlW5G4EuG4y7XuwjoccwVh0Q/WgJLfmEFjL5q3ORjULS1ApwuOXIGMUO8I/8VmYrvAAcX3S6wHCRiDTEI01jaauuS9PwT2uv1VGucN0xvpkl9ppNCUA306OlCWbz5jgO30sw7P92C+6f2MbXTd/HbdDdW/wRf72pMFzjWVRdgWMj2thTHWdw9hsU5McOdc35b+uMP7j8CBFbpQRT4TmpkIzL1QO++qRsl8N7l65+zespxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uEC8oJizXCfQmDSTLK5WRvnkKk52Rnj8gQ4cTGvBRs=;
 b=gT4bmZDipri8lE0Dp/8zCk0Z0JpMdmRxFsIfsyr1jLwSWyDPOIwF8vdg5myXIjEtHMoOGKmMK4m7EbxAiuBNJ1IkA1vdnY1jjRv0DAWhxvXuRDhcOnrQYRLVt9hkDt+fS8+JecypmPKDjRLkZ+TMnr7TkGszaqVlQwEQ5DX5vrBGglUh4bZLqhcdS75lkn/DM7CgalHmiaXn4Wljpr8OUJbQOEAwaqP/vXfGZu4jWZlflGIvHS4WwOPCbZXNeikGXZ3E59ugUN+RiO3sJpXvJuWogCF9s3m67QTBcCf8d736aIMDD+kD3PP/4mu4eT0ceFdnJzDMyE2ullWZjw20dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uEC8oJizXCfQmDSTLK5WRvnkKk52Rnj8gQ4cTGvBRs=;
 b=cmCOExfyAaVWSHghGEgHjUccGpMclh2MO0LDvulXmMxlSnf2U0bG59bE1nMvjPJK2X5SPYJbEpXCSMxLI6mzMO6lsCd6un86f4rX0+IyiFUfgjIgH6LAEjJ3QsjGQaWEaM3joqx2aiMBoWIBmHaiXaiH1kNZWOAHGIAsbrwNewo=
Received: from SA0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:806:130::34)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 14:59:44 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::9c) by SA0PR13CA0029.outlook.office365.com
 (2603:10b6:806:130::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.17 via Frontend
 Transport; Mon, 28 Aug 2023 14:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Mon, 28 Aug 2023 14:59:43 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 09:59:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 07:59:25 -0700
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 28 Aug 2023 09:59:20 -0500
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
Subject: [PATCH v3 1/3] dt-bindings: can: xilinx_can: Add ECC property 'xlnx,has-ecc'
Date:   Mon, 28 Aug 2023 20:28:43 +0530
Message-ID: <1693234725-3615719-2-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1693234725-3615719-1-git-send-email-srinivas.goud@amd.com>
References: <1693234725-3615719-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 97274339-79f2-4f0c-7ac3-08dba7d769e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m3d8k262wmPZtG/KERrPKi2QbR3m2X9QCHnVfV0TesQKHqSUgI9OfvzF4QWdhHrGqa8vBzP+8qsl6kKeW9sh8Qy6+imhq1fS6nj+ODSPsg/S54NTeCSAQtcArHqVKC17dwToDuxk8frR2LjUiZD+GfUM3y/WDkSmbOpcj2bpmOMrg0Vn3AqE7bobScGsC7k9YQL3IG07dLFKzEa9ntX5VzDLM6a/k24cW5n5G07i+ckSVM3qK6XTLJxi/fZoPM3jjJpVnao4z6QFwlCaGcI0HR7aaGaGXU9zF2ArZT8v1gVLyRRTMI8/lkWtsR5aYdipKywgyZnrpgIPdmRGnFQsB1LT2IKyqrqqr9wZxeBRAFQJqa+dJ+2bUlt5lF+3k5aGCZJ2tXcI1tQJDKanwFuyx5P/Bfslc6E0m8mXYqjxte8zQgmO0D0/MQrTuHpoD9ze1nzZAMfKj32IyOUflZ+pi+kM9HeC6HJrpYvIgSCPutTD4Da6D+89j7Qco5nPAOoOtjhpEjFS/2ha/rfWhAmZ/xPkXT5FxdHDIfDkXaP6Yzxm796mYlv8wT733J+La2Z+AVx7LIgM0OSacgmHo7QXTV9caiBu8wEHzf/5/X0W6TGSMwr8C9+vwmH612YPhZNTQ6JgHsb6hjk7we1hoAruR1MvYwqjAP6G2BqSgxX3CGHnHDw5/bUfMk6jK1AFtzTnWC2RzspfIJnQT07d1N+MX8eJVhaGejOG1eqLWbrRukmbXSlsBYcq3JVFja8wUzUyjK/xIGlCJJNQyXCFEnGVg3O1ZVg+z7AA7dJFB+858+o=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199024)(1800799009)(82310400011)(186009)(36840700001)(40470700004)(46966006)(356005)(478600001)(921005)(81166007)(83380400001)(82740400003)(26005)(426003)(336012)(47076005)(36860700001)(2616005)(40480700001)(110136005)(6666004)(86362001)(5660300002)(2906002)(44832011)(7416002)(316002)(8936002)(4326008)(70206006)(36756003)(41300700001)(54906003)(8676002)(70586007)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 14:59:43.8951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97274339-79f2-4f0c-7ac3-08dba7d769e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836
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
Changes in v3:
Update commit description

Changes in v2:
None

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

