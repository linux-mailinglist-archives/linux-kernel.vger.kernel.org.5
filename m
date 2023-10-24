Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99B67D544D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjJXOtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbjJXOtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:49:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504D9DC;
        Tue, 24 Oct 2023 07:49:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFrp0KDRTAoD4VAMtz+eRLKF4VGdVw5hNP2n1ZRfTK792wtQ9dgKUnBH8ovTiVd4CCyodQLH8QIrf/6OD8ZOo7A07sOepqfAIUWt+SwXwolno4ll3QkaufLDG3xMPpOZNfd8T67s6IWAU8eS570XZ1I/t+/fQ3YtV7Hyfp59CW4PWGIYr8mufIPpcM//zsMXRmAM9sGRhTHOic4dCxbnEIx/RTVAtPzLY7EaDyvl9Dn5daVvcWY/JMSGLINjgiZHeVJ9B48pvqMYPNld2z+y2DdLzrlszz7Or8Va1IRbWV3xodB+ZoHKmSdiMiZPel3yW7xxeffChFpXcT4l3EGbHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3P8x4kobXF5DqFDQVj07ztq3Gt7D4PMH0G+qH95Moo=;
 b=Vr4clNpZ6bnI0ztmwDaPbTIH/ZXitCGGrCZQTNECP1Brz+m27CbNF/eF56nhIZGQYmCpQSrdzgeiR5SgT8juu2Sx37Uf04b6X91ueZdRvsjmLuJphD0DCnbUZ3xO/YJX+w8eR/Z5ysrkIxrjruJiw7jZRIOr3q0lixaowYFIPoQFxiiNR9zKP7Ur6bJzF+t9cuTlL1SjuNaeI68xCLcIfrRQyl5QkWuq4va6ghtV+MV7ngSUJVkJbTsvjLtFAzZS7gyGpp5l5Uxr8UUKGNixD7dAk4VQiavySL+b4Ni0+GkhK74Vvl0A69iO86vkIfwbYTCWhSoHAteGlyGPjJjjfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3P8x4kobXF5DqFDQVj07ztq3Gt7D4PMH0G+qH95Moo=;
 b=uQsFN8Vc2iDWVo6ODclKn/wYEUIbwv4f2qvbvIgCfVWAFFvxhOuS5klxFPuLQVtYPhqgKkdIEMtlF+GZxrOfUwTYKqcsZcj8vSNCxiZ5V3iBXY5c759sPr6MPn6uaCln3LPxmFh8s2c9YZw5Y+VABdGNhXG8lYa4Cdu7vKwOlsY=
Received: from CY5P221CA0085.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::41) by
 IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 24 Oct
 2023 14:49:01 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::e0) by CY5P221CA0085.outlook.office365.com
 (2603:10b6:930:9::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Tue, 24 Oct 2023 14:49:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 14:49:01 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 09:49:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 07:49:00 -0700
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 24 Oct 2023 09:48:56 -0500
From:   Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To:     <git@amd.com>, <michal.simek@amd.com>,
        <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jirislaby@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
        <shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH V3 1/2] dt-bindings: Add optional gpio property to uartps node to support rs485
Date:   Tue, 24 Oct 2023 20:18:46 +0530
Message-ID: <20231024144847.2316941-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231024144847.2316941-1-manikanta.guntupalli@amd.com>
References: <20231024144847.2316941-1-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|IA0PR12MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: e958edec-5d50-41b5-c5f9-08dbd4a05caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQfnZ3wvLhziTK9Ra/ev9u6jKLIxi9xHY4Xd0qL7ZZi7TE+ykbLN3iWfoPoaDTfK9DTfIwR+ycpn7mRO/XYRHNrqJ/4UgSvO0j1JBc/EYUH9TH3iYY9GOnTI8pydjIMLLYRz9WpTZLdGEoTly5Q2td6EcVaIAekx/r/isn15csuLrmO0SuDXCMXDzK8Bkm+gPQDc6rwENuxpGdbJaTaI/z7+Lme8zVDzeiWr70j325Fm8JsFUlkS+iIKVwiuJ8TRszmAV7ITKF37KDyKnLV7omyfvLwBPpZFZvIe03IKF0mvnhTjz4KkrLbxQnqVnN+ZHyU2iRi21Z1w2azXOXZE7NyziuvDJkBy5E3+HvXzQX07Tt+iOgzm+iOefDf+rdjrK/pGMSAJnHN3NV28HUYKTsA2M+Gd58fEYBHJFnhqWPpm9ZwV+UTpf0KEvH1Aoz68+ZFVJWpFrNXceTMgN9wY3p3dLlDJtpVzd92KsvJjp/fVt1DapL8EccbLy4H/37lX4aiJXnl+8PPXTyqiW0RuKgFg9DRrNI01j4ac+Mc2nrckfkN81hp5KLz3tx23YXHPZmMt1gNTpbS+UcdbSc9EiQDHv9sdEblu9gQStTaFKt9xQNch/5tRPPRWbvqoguCrSb9FjiqOC42s0TxCFsqiOtZ4ustsLukuHKZJGOUbovNWfps6+9kuqEfXI4hViWWkMkArikzFU8Y0cKxj/cwD+8Q8rB1sa/Izdi1TfZcyTDHK4KgNS03D1bnRuEkC+2YVfRbAIfTs4jp9FcPrcIrXgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(82310400011)(64100799003)(1800799009)(451199024)(186009)(36840700001)(46966006)(40470700004)(2906002)(7416002)(8676002)(8936002)(4326008)(44832011)(83380400001)(966005)(81166007)(356005)(82740400003)(41300700001)(5660300002)(47076005)(6666004)(86362001)(40480700001)(316002)(110136005)(336012)(426003)(1076003)(26005)(478600001)(921008)(2616005)(36756003)(70586007)(70206006)(40460700003)(54906003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 14:49:01.6671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e958edec-5d50-41b5-c5f9-08dbd4a05caa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional gpio property to uartps node and reference to rs485.yaml

On Xilinx/AMD Kria SOM KD240 board rs485 connects via TI ISOW1432
Transceiver device, where one GPIO is used for driving DE/RE signals.
With rs485 half duplex configuration, DE and RE are shorted to each other,
and at a time, any node acts as either a driver or a receiver.

Here,
DE - Driver enable. If pin is floating, driver is disabled.
RE - Receiver enable. If pin is floating, receiver buffer is disabled.

For more deatils, please find below link which contains Transceiver
device(ISOW1432) datasheet
https://www.ti.com/lit/ds/symlink/isow1432.pdf?ts=1682607122706&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FISOW1432%252Fpart-details%252FISOW1432DFMR%253FkeyMatch%253DISOW1432DFMR%2526tisearch%253Dsearch-everything%2526usecase%253DOPN

rts-gpios is optional property, because it is not required
for uart console node.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
Modify optional gpio name to xlnx,phy-ctrl-gpios.
Update commit description.
Changes for V3:
Modify optional gpio name to rts-gpios.
Update commit description.
---
 Documentation/devicetree/bindings/serial/cdns,uart.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
index e35ad1109efc..7ee305f9a45f 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
@@ -46,6 +46,11 @@ properties:
   power-domains:
     maxItems: 1
 
+  rts-gpios:
+    description: Optional GPIO to control transmit/receive on RS485 phy
+      in halfduplex mode.
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -55,6 +60,7 @@ required:
 
 allOf:
   - $ref: serial.yaml#
+  - $ref: rs485.yaml#
   - if:
       properties:
         compatible:
-- 
2.25.1

