Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D207C578C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjJKO4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjJKO4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:56:24 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C730A90;
        Wed, 11 Oct 2023 07:56:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnjP0eLsjLYooMCOQdvJGMwPU2fE3uovKYMMySuuzLJgmmU5YYuqjssa4/FH67dKWgN9SCXEJ6/FDqGeiHr4AWTstT8ZNBrpvt36KKupGsd9/CUCYECT4v8xTxslbRTiO+WmKic62+RbOT0+NAMCdSlJkXNCNLNOAJ2Aj5b5Xf9Hs2Mj6g+IeLibxvDoWA2xXjiJSm52ldy4nvTZXTlfLGTZ/m2Cu78/MI01vr/giwZcGlyOklNIzHVzfWTDQ+WLCgEXaKGWTYGgEuShyn7ZfpuK0QOqWYxu1F3Y8xL+xW0ek+qsA66LnBTt+YPNCsJnF4tSYgUauMRi+SJ71IE6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIqnVPhdVQ7bH8+KM/ZR860Oq4QIHGQCrIpK1UWXbUY=;
 b=oTPsy4rgYC9mHE97tkqqApjkydXhpADT2uWOItUGgIAUrm5OGzYUiV7jEhq1QW9uAJvWFAVwyOTrQBcucLISL2KMB3pmx5CxA4iTe9931gm7e/zRsCgt4PsmUFCygvCSxIx0TXHf+iCRf/woeJ2hxcPhSMChDQz/3IwMSEFeRHng1ld5PHpVsXAHubZC0eOW4X84xwnm3hOyEbOjHHQnVcmgII1fVZUd7g3wrdDa584+3tL5FK+fHLYTb5G0NlMEz13dze0hQOPXYZrr8gARGpdIGdwJ88JXWW3yAGcsDrQk8A8VK41+KJ0jeZIJqKUoW1PZ+ZqOeO8kXVUpkAk96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIqnVPhdVQ7bH8+KM/ZR860Oq4QIHGQCrIpK1UWXbUY=;
 b=neIK02MP8Qx/6yQYZFz4u1voZqOP9Jm1T1POjxyFKJr5nxTX0ht+YIsO0vkG/98qOMpNTnSO4kXaAOC99442jh/x761AY8iL2uDyV5J7YIuu1vFFpvsGMIo9ctqjs2aAkFJ/ubP+NO64nbJUCgBKAk/tJ+PwXqRL0dIT0v+GUFs=
Received: from SA9PR03CA0006.namprd03.prod.outlook.com (2603:10b6:806:20::11)
 by IA1PR12MB8518.namprd12.prod.outlook.com (2603:10b6:208:447::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 14:56:19 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::65) by SA9PR03CA0006.outlook.office365.com
 (2603:10b6:806:20::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Wed, 11 Oct 2023 14:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 14:56:18 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 09:56:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 07:56:17 -0700
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 11 Oct 2023 09:56:13 -0500
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
Subject: [PATCH V2 1/2] dt-bindings: Add optional gpio property to uartps node to support rs485
Date:   Wed, 11 Oct 2023 20:26:01 +0530
Message-ID: <20231011145602.3619616-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231011145602.3619616-1-manikanta.guntupalli@amd.com>
References: <20231011145602.3619616-1-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|IA1PR12MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: 912856ee-f516-46e3-151c-08dbca6a39c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWy2MMyHC2NzBkqyPVgv28qKoeRsRbPETvryD7o/IHAsEQXUinyWSy/aSkD+VKzLBi9F+D9Ve/+q0gwKa0oReVK8YEn0lCq04GiBGESAzST11by3p8FnqAwcg+qe0FpnD/B76lgp5jw593NHbdR2vQ6D1EG+W2t3wT3cB+t48+rhiEViJ5li5M86iro8DKV6qJQTGJkbf77A9SaIbBoGG27PuKxVYPW7tp7I2FpVBqhB1REXtS8HKm1whrhQjsyx5pyOPs6oiksgJhi9x7sFo6Xkq1hB3bj5rrAuLt5d4E+lU5xUDwvzy1098lbfLkI/4WDrU1W7L+xkknq//lEn/3qE7zwp8GypF4bFGdtyh8WK8VKoJMWLzyd2ePCx3d5yZNjIDsH+fhhxuCW86Zc8MAAHD4o5EkhgLvO6Us4ACDNTd7XrawFVVNGuArN2N7jYtFaLDlEq+wOJI5ve9O3FD6L/hjZe+7fvT0weRQMX3lXOc8BfAKk2AuTMcAvvEtjyjgx2YXNclOrPSFivfdT1uUfC6xOY5jPEMiwt0fhkOnniz+FE0Nux04Jzi0Q2IqL0fulgOMbreSpYGma5U2OlXi1kpbEOx1/KLsUJ+27GfW6NGrSrpoxFuKJxLPu6yXdxElV8t6Z4ZEd72IsBEZRMRB2e7H295Sj+thxCntHcg3N9aH+4+YqysWHW3gsj6dz6ZlENrMm7D9DNMTdA0Z0HJ9Br+c3IksSLgKJ/s82p2bDY5sCKnj3jeoDFYysvVNH2xKi4QNinc1ZUsemcENX+5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(64100799003)(46966006)(36840700001)(40470700004)(82740400003)(1076003)(2616005)(426003)(336012)(47076005)(7416002)(966005)(2906002)(70206006)(8676002)(110136005)(5660300002)(70586007)(54906003)(4326008)(8936002)(26005)(83380400001)(40460700003)(921005)(316002)(36860700001)(44832011)(356005)(36756003)(86362001)(40480700001)(81166007)(478600001)(6666004)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 14:56:18.6902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 912856ee-f516-46e3-151c-08dbca6a39c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8518
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional gpio property to uartps node and reference to rs485.yaml

On Xilinx/AMD Kria SOM KD240 board rs485 connects via TI ISOW1432
Transceiver device, where one GPIO is used for driving DE/RE signals.
With rs485 half duplex configuration, DE and RE shorts to each other,
and at a time, any node acts as either a driver or a receiver.

Here,
DE - Driver enable. If pin is floating, driver is disabled.
RE - Receiver enable. If pin is floating, receiver buffer is disabled.

For more deatils, please find below link which contains Transceiver
device(ISOW1432) datasheet
https://www.ti.com/lit/ds/symlink/isow1432.pdf?ts=1682607122706&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FISOW1432%252Fpart-details%252FISOW1432DFMR%253FkeyMatch%253DISOW1432DFMR%2526tisearch%253Dsearch-everything%2526usecase%253DOPN

xlnx,phy-ctrl-gpios is optional property, because it is not required
for uart console node.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
Modify optional gpio name to xlnx,phy-ctrl-gpios.
Update commit description.
---
 Documentation/devicetree/bindings/serial/cdns,uart.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
index a8b323d7bf94..cf8ef55ba210 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
@@ -46,6 +46,11 @@ properties:
   power-domains:
     maxItems: 1
 
+  xlnx,phy-ctrl-gpios:
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

