Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892DB7F8A1D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 12:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjKYLQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 06:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKYLQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 06:16:13 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED7810D2;
        Sat, 25 Nov 2023 03:16:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkRxRgx7Sp18etOdAin2G6RjxOcBsW4HNk7EfYT6r8eoWSfhIbqiiq+9jtDL9zqRBWxBtAOs9mFXS42lVj+iZnLd5FLxhXWJEpPrgWdUkf6vcZMcz/pfftaykyV006ZCMSfuYMNHoFuWJgvNZF2AEH8OnfEWR5hYYehMGU5FrPfaeCmBvhjY+19LobGzGX0Wmu1cnKfs1yzzHtsSreaCgpCEJs0Zr+jUJS6VQ7qH6ktfcyTgzCmAHe+gmZkKQ1zbfVtbqtPPn1aXlB/djdzuuZPZpwbVJtTIPhuMZfuW8+wLGS4KQmqfgWTYGSUjM/7tW8tN94JK1eM4DAdMkyPGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrY08kOXEhF9FlCGqmeYvtnTdj0NWO6fQ/OJ+Kpc90Q=;
 b=PgffYNenz44mpRXz3HO3CeXb7nlhKVIZC9coj4/1eHdHEClxGNjZzleU/RukWJOWkaxwtBf5dQz8EEqDAODE5BXp+WoOErWQTNwN5p8iQkbn3EmC5MiW4Xh0y380VP7iPSA0OLTbdkt0hwDL29JytCDCyPPWKwWA2vvrr9p/NgzYkHC+C2PBselhKARbZTPnh/Own6oFlRik7zh9IxZcseQVMPnir7PQ4Jk9jeJNcfzOKTpgUv6OA/bv8ieYRVbgpnAIYVraURGGLqm8YKJSJGTqusBJmVGM0mxZybteBaBqvkc/AUTwsvtRH3ODBmZwh7Qg3Z1hXn4ZJ4r6X9SWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrY08kOXEhF9FlCGqmeYvtnTdj0NWO6fQ/OJ+Kpc90Q=;
 b=dN+7ntkg7DS01jUOI8LeqHAleLd39ParsjLcJnTWZnxxU6wNTZccimR7RPuYF7jTA2zX0XxUAsZ5O0ASjv0qByBylfZE2Xx6OsMS43GkODlGhk5KVMuobB1wpz2FvSHrtlkAw1JfSgnNlAlt79fIjBVr9EL62UF5JfwEXa5L7Cc=
Received: from CYZPR19CA0014.namprd19.prod.outlook.com (2603:10b6:930:8e::6)
 by DM4PR12MB6206.namprd12.prod.outlook.com (2603:10b6:8:a7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.24; Sat, 25 Nov 2023 11:16:15 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:8e:cafe::6) by CYZPR19CA0014.outlook.office365.com
 (2603:10b6:930:8e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.25 via Frontend
 Transport; Sat, 25 Nov 2023 11:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Sat, 25 Nov 2023 11:16:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 25 Nov
 2023 05:16:14 -0600
Received: from xhdvnc205.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Sat, 25 Nov 2023 05:16:09 -0600
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
        <naga.sureshkumar.relli@xilinx.com>,
        "Srinivas Goud" <srinivas.goud@amd.com>
Subject: [PATCH v6 1/3] dt-bindings: can: xilinx_can: Add 'xlnx,has-ecc' optional property
Date:   Sat, 25 Nov 2023 16:45:31 +0530
Message-ID: <1700910933-23868-2-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1700910933-23868-1-git-send-email-srinivas.goud@amd.com>
References: <1700910933-23868-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DM4PR12MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ecfe9cf-7efa-4b17-483e-08dbeda7f076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +omPfbOLwwKmVDBrOSJOmJJK1tWSHCZgUR6Ou0ZQir7YVg+XTdJZYSGA+cJxLU2EMv257Kr+saYXP7a0wImGfdZauzkWief36lu10mx3TF9/OBBatt8EEMt4A84IqEiLqsQ31ufYfAavdP9tlWkfY9eyztWILdWOSLxREqLVnB+KylyyTCsDkNWfCAwsZyXhv4EPJeqvgQrmV6gnSfKrhNALx3K22cB8fbcFJuz1vHjwdU/7KIZWDiRZlI92zGKOIHmQ25tUB58PUvZVOBwgnPzAooHMsGBBVKL5eSZ7EJyqbCgEwvAPTLPeYtZZKRmwqb13gsg3kSkuPyVcMQQJzzwd3mgA13BV7h/IAU1DeM0hVg9P2MQimNEQ5Pn1btNpHkCKDC2pRCTCYEcxEPu6AM4tfD+zjJzts1Iv9hfCWmv9JzBthMxjXJheRMBhMP+1nb8smEXBejprlE/kNbPR9eweOLji9eHu/Dg8txJnwqre0OXkIQdpxbRvHVKEk9cE6N8wlksYnUz/NhfvmL0TpQyThEtKa5IrqfiDhs/cQGl2wAhKq4+Z01Yx9pMhaYUO7rV4F7FD+cXItLB0mgYxANsv2rQocoHkfevXvgyREHvsXDLmr0z16bXxvOwJkW57//yp/+ErQWpvtqDPc4AyQiJmNGlIWVYvaiPxd10YSCF6Jk1oOsyBwxFZ65R+kJbx+sxi4SLAJ3lRXx9eRAtA19LV1mxKs4hqToRyiPYX2GlTlyw9D47YFtWWL5vv53m4po9YFhzOfkoWa99kqkFqQgZw34oFvwUa0iKBUjeAUsHP4nXefRpZmdMI3r6Euf76M2xtvSFXXpEHj5RRW+BQQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(316002)(110136005)(54906003)(70206006)(70586007)(478600001)(40460700003)(6666004)(7416002)(5660300002)(921008)(41300700001)(36756003)(2906002)(4326008)(8676002)(8936002)(44832011)(86362001)(426003)(336012)(82740400003)(83380400001)(356005)(2616005)(26005)(36860700001)(47076005)(81166007)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2023 11:16:15.1568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecfe9cf-7efa-4b17-483e-08dbeda7f076
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6206
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
Changes in v6:
Update commit description

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

