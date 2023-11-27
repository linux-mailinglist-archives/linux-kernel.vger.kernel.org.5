Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD39D7F9D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjK0K2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjK0K2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:28:33 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71645EA;
        Mon, 27 Nov 2023 02:28:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIu/lRHb8GQvnt9ccF1DDEUDl3qWJ0ozDzR0hr5oc0yZbPM7XHxxHvSy+5jkADoT3c1Su8TnK7oPvWz9Idbt1D+rnXTax1jGSjviFOniWt4Su1QTnPtKBZROuFp25xTMc5uqrSify3R1ET/cMtoRjGxpMDzM+zyXMoM04otD9aG5iMzo9ZCl+Wa5IvA0hdL05oImg8WMdGgIhICIzAI7RLDXT6Kk/mkkxkaSa+n9BrjA2TklAxp2gCPAK4WfGulTLYvCEu2l4xI760oqq3qTcH190UPGKxWW+GdPeDN8mzgL93e8sqWyd6Qku4mW1iAzBlxRdyx0NxEINoeyxC9s2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUw8NmZhAE6as0nSqZrE/GQBfjijsH7Y/gh1N9abdZA=;
 b=T1AwwRsoy98+wwPjKnxDSuypoFateZjgg51k3b1sVbbmvwLf/DcjywWZA4BtEK5iB5ZPJXekQ/63pHGADD90Ye4MTF6zieHU4HM4I1shsvA6yqBA7BJtKeE1LHWcg8rSF8jm/GUgo9VVGPKXQ4ZDRBcUvwSNk8C9TmkMs3IgT3OLGBfTh2J+sc8Auu1ijHIYStqVOy1buA/m3jl6om2azKGfG/zILP0wa+Q08uL1C6/yDzr8l+e8/7nfDwqjzRXrmPxNlM0hG47yrlHD6Sd3DysGliPcl/S3PsU7DrrlUcJP9oyHNNPcuiX3yyFz+sFl6HJGMcwcg9GYDZ7UnPUM7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUw8NmZhAE6as0nSqZrE/GQBfjijsH7Y/gh1N9abdZA=;
 b=y1W86/qeIK5QjmMldUFY2v6Yl+VyPEA2D+Zs/wGmF5zwU63+FjQ0u+/XrYHySl4pCYCPsohHYm1mZoII+6Xmi51WxJs7qBrA0XspOJ0xQsb0nFW5KYL7wJW1vOLUkyYhYKcCLFuZce1jvgIECE8RD0jKMzQ+eYFbqBPfI1NDdOI=
Received: from PH7PR13CA0017.namprd13.prod.outlook.com (2603:10b6:510:174::13)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 10:28:38 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::d4) by PH7PR13CA0017.outlook.office365.com
 (2603:10b6:510:174::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19 via Frontend
 Transport; Mon, 27 Nov 2023 10:28:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 10:28:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 27 Nov
 2023 04:28:36 -0600
Received: from xhdvnc205.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 27 Nov 2023 04:28:32 -0600
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC:     <git@amd.com>, <michal.simek@xilinx.com>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <appana.durga.rao@xilinx.com>,
        Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH v7 1/3] dt-bindings: can: xilinx_can: Add 'xlnx,has-ecc' optional property
Date:   Mon, 27 Nov 2023 15:58:13 +0530
Message-ID: <1701080895-1475-2-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1701080895-1475-1-git-send-email-srinivas.goud@amd.com>
References: <1701080895-1475-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|SA3PR12MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7ee6b7-59bf-468d-2084-08dbef339e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QHmpgadtLNddGyp76veOje5cKW6naobjg8omNRZKpYYmM3cxpTbXKoGs0c0ftaIcF5KQFUAiQTFZEw65UXmTWxWWaTC13nZWKzvFhqVGVBX2+FlQiSN7z2ca7+PFccRbYWwnoysEtm2qBjR89noOhzSonze+OMtgdNjRM8NZqpsMe/wn/prjgLPhNExGDOc90APXwzvJYXiGl0CsGE6YNJ0laadS7V5QWNSIPQ2SKCl+p3zvNleVC7EXfK6jU3TmxVtuBKm++z/S5mBZ000NOOGSDdXjStvEbVLDcPdJ6uIGwOIsgch6x8GUm4wRtbrWxYnrLsClH5TAMbIr0r+xhJ8oiLd+/UmymVTht18rUkNKB+m2K7pK80yRLFrEXPuaHTYryyJt/XcVmvjzZ4TN+dc8yEoVLCkWjL2tb1oluRoZOP0YhG2F420K48RQrQqrK7jnkXbM5gTGEJT/M6Y4sojT9qMElQ5eAJQbd5EUvarwWHiwsQOjxfodUOc4Tq/JppEmKvdRy/b1dymZqaL9Wn4NQuq2tQ8sHr9wSREDgN4O6cp5C9n+J84+NRBy1teWzGezMz5quOymt48O6ZLxGS/mvO6N9UFhsNxSsaPyEBwcpNihAi345pgQTz2DNvDIqJRoG3kE3wy3dU8kTi3ashyxCuuRkE4rlK31lLW1PYQJES2YuoVDfu55mfC8trLm1MlmWEsQl+FVZ01DIyMjeq46SYlIzuYTYQuv1S27vwr+OmXudMcJ/k9FNFJoT8zeZNju2im1RemGzAwHg6z8/7/XwJIhHakw2XP+M/jceJyyeHkXBnzUKqpDtRYo4/FqdGWYGgO56070KfmoQXO0XQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(41300700001)(36756003)(921008)(86362001)(81166007)(36860700001)(356005)(47076005)(2906002)(83380400001)(5660300002)(82740400003)(7416002)(426003)(336012)(26005)(44832011)(2616005)(40480700001)(6666004)(8676002)(4326008)(8936002)(40460700003)(478600001)(110136005)(70206006)(70586007)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 10:28:37.6135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7ee6b7-59bf-468d-2084-08dbef339e08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

