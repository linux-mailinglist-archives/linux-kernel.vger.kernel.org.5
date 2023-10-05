Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6747BA81D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjJERb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjJERba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:31:30 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1193C21;
        Thu,  5 Oct 2023 10:08:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJn9H12hm33qb8AfVsITpZagOpklg3iRgNWAsLj7PeiBeroO8dPzMKf/K6+99iqg7Z5EQxgjjtPU0UbmzVUq+I30F6vcjYIcgCZHM/ZSLKRJly0d/al4gNiB0+wKbKD0aChyQKSum7WLeamK4YeU+OrSICnvGY+vxRb4zVA9N0wPKVCLeomZK83fW7ovqCAfFwFeHpEg67vBDEQ51LWqJvXLPJD7wqXucli974HFtcxSomX6ZwdPivnlto18MZHqi3N5W1WGynq/lTvRvbLxKYj9NdAiTF6Boyb+Vtdfx7rlB/6ArKi7TZzuqyx1o3Ka7akJdcmHGLkzSLaC39/Ksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fARynZEkDekkmFowUCvsHCy4vqQHBcdF9dXBSZWAcc=;
 b=NEYupdgscCcWznXGJqFcWUjMSlS580aaTr7OsnPWLWLuiFAcUYWC/X8jQou2N/z4fGO/sXk9HNSUr5rsNmpsBdySKluY+ImHfdDQbvXO89rviMogxbB9dyKcUGMvcKk5lek+yHEq2yX/fiiNGmVfrqGP7lZlSFr35QdoVj28z5Q315KkrO52+nm8nUCyKBouQ3ev0XGC5gEbtB11vDUc3FBYAkXIZY9w7gVVyZTwvaJAmsxrYw6x1+S46amH0hnYhhu3WgAaC408eI5IPuHyEYn9DdYM1el/qnBt2ws1g9bYrzo9rLrL7QothEYf047Ot35H5ZYeDZfTCmZmfQ4WEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fARynZEkDekkmFowUCvsHCy4vqQHBcdF9dXBSZWAcc=;
 b=QFilA7SAyVWFgotkRAVbHmqBvFBi1nb80UyDfqjFOkqhaow7/yM9Gl02PrQ5SNNwFJSWwl9fEfmLtZJkh7qYWp1DQbyRDGz9sY/04aGs5wbxK4ViqgC9vWVbbFtulmZlF4wshsGsgpWKP4e9gcWyMCAeipwaDdDjzxrqSvj8DLk=
Received: from BL1PR13CA0196.namprd13.prod.outlook.com (2603:10b6:208:2be::21)
 by MN2PR12MB4517.namprd12.prod.outlook.com (2603:10b6:208:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 17:08:33 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::49) by BL1PR13CA0196.outlook.office365.com
 (2603:10b6:208:2be::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.11 via Frontend
 Transport; Thu, 5 Oct 2023 17:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 17:08:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 12:08:33 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 5 Oct 2023 12:08:32 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH 1/2] dt-bindings: zynqmp: add destination mailbox compatible
Date:   Thu, 5 Oct 2023 10:08:24 -0700
Message-ID: <20231005170825.3521669-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|MN2PR12MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: b256843d-ada8-46f5-fa25-08dbc5c5b4b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HiNnQ8++5pdIrvJTFM90/cZHRgg/wgg2Jz26VLIJ2bVAB0+ECdrkRGPFZLhbDVqwwLglN1RxQwEapWMAyzjkg1BZiwGbiJr8tB3GmmiC1TSF7Vve3EEyICm2Xt8mPxkM8kHuN6DFv9KyQTfmqQrLvHIjp3LxNeXK7R/OuEjjD6jqEuZG/VgVN2/2PcNuFvbV6vmtop5m/T1tEB7LmKfa8qwI/nBFnC5D586IEKl4+/WTmH9Eum1Nlp1ubSAsk0Rw7tgq7H9q9BFa5/jbqXol9QR63fVC6pSrviI6PYaUSjCR02vinswSZ4iRAIFdON6slCfK8rxJBZt09hUjG5i2j/MGnOlb42gH+WeSptDTxY31LecDLJKkwmQ7WbZy5jTjlkaRwxgH1fFSAIXvvsBOCYOzfLPeI/6qCJJiHCcxWiW/CsdDscl1B6EX+x8hE52iphHve7kDhhH64XYSJxWXHIsfyeUHkZe6XES5EtrriWtBbgER+jDUHUOozxwZdqSpPLUqbK6KKVR2ZCBF8gi6V81Sr/7fkyfqLeZxcSYL937WnNJ7xWmSP7ntswGXwC7eIg13F1nVy/LFCUEP2wpXfEp4H4UnrdpSNnDXRGmXYujZA3M+fthV0TiFSIimI6JZgq3/4dSw7fKt7/jMkjq3tpfY9OpaaJr94t8fdHc27VeYoAvQ5mI2pSgyjgyvonj8lez8sgfEkK0PQb98MAbDjsD6QDUUOTKarsrBfmem6hcxUzLKCNZ9BJSvGq9xz+hrhT5oQxZhyitN6wjR/OvuqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(8676002)(426003)(5660300002)(83380400001)(4326008)(336012)(8936002)(47076005)(6636002)(36860700001)(41300700001)(70586007)(70206006)(54906003)(316002)(478600001)(2616005)(6666004)(26005)(2906002)(1076003)(110136005)(15650500001)(82740400003)(356005)(81166007)(44832011)(86362001)(36756003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 17:08:33.3839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b256843d-ada8-46f5-fa25-08dbc5c5b4b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4517
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dt-bindings does not contain compatible property
for child mailbox node. Child mailbox nodes are used
to represent destination (remote) IPI agents. The compatible
property for all destination mailboxes must be required.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml           | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
index aeaddbf574b0..8b15a0532120 100644
--- a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
@@ -74,6 +74,10 @@ patternProperties:
     type: object  # DT nodes are json objects
     additionalProperties: false
     properties:
+
+      compatible:
+        const: xlnx,zynqmp-ipi-dest-mailbox
+
       xlnx,ipi-id:
         description:
           Remote Xilinx IPI agent ID of which the mailbox is connected to.
@@ -95,6 +99,7 @@ patternProperties:
           - const: remote_response_region
 
     required:
+      - compatible
       - reg
       - reg-names
       - "#mbox-cells"
@@ -124,6 +129,7 @@ examples:
         ranges;
 
         mailbox: mailbox@ff9905c0 {
+          compatible = "xlnx,zynqmp-ipi-dest-mailbox";
           reg = <0x0 0xff9905c0 0x0 0x20>,
                 <0x0 0xff9905e0 0x0 0x20>,
                 <0x0 0xff990e80 0x0 0x20>,

base-commit: 7d730f1bf6f39ece2d9f3ae682f12e5b593d534d
-- 
2.25.1

