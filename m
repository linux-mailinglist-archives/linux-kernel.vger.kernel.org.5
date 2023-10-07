Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66B77BC4A9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 06:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343529AbjJGE10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 00:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343491AbjJGE1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 00:27:22 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9B0BD;
        Fri,  6 Oct 2023 21:27:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jq6nD4oo9OSJjA1mTr9P1g9I6vURRz7+TcB+kcvzBhzaSpueN7GXtBi/Fk6y8lX5nS3v/Rni8C9dMluK1Y5wfQi4pRzz1QdXylW3PYsm8NVkR5j1N78c81IOU4QmgFXA7QieTz11M3V6rimAXVlt+MfmFS+J/Kta+lx4GqgTA61X5LQu2vXuLw4GcHtlCy9BXbnOEEtRGwMOusIN3xVsCocX6D8f6ENKStANCtuTly5VaK97xmNFWNKa5DqKnMaabmpSKnnDghH1TmXSzpZvr6hFRzxe9/UUc3cshXTJ51EH1ySYL1a8ai3sFSk9PbDQvtzOcU6rVNw5lsj22gzDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGVxYOWR6gr0Oy+DI8MNlXJHHTnb1SuUIDEhjK7R7Ks=;
 b=lLqwQWYc6j9I/8HSNJPjsQJwOl4Bv6qHUsHPJ+yB3UOItdg9WK0tmA+qSg/h3Nka5+k00E2VWLqzgkJe9CnaVcisZU3hm7+Y/tkWfd8X/+EGM5yfNKnVpB0KvkB726wUoqMuOHLp55CBjeGZCANJJYlv8R3d4yAek6YCsEs4nHfyXkn46cfmUYsr7C2CHH3YByaMy874HsHKjTV2YNQc2ZWFXYh+DJn3P6G0cw8lkI46wGxx3xifRdoFbjwuiT0HYINAOJbomLVyeXYUvycP8Zobpde0O0lMP1Mekfg85ElQZiGhSXo4OfthMFUQyvfOVgYdQQ51hkx1lL+JUHyPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGVxYOWR6gr0Oy+DI8MNlXJHHTnb1SuUIDEhjK7R7Ks=;
 b=k/1rTXo5rjhdjtePcONPRwwgjexcK080wekf9eeZaVZWIRlQklrS9SCfVGSaossC7Tddum+WvydE4r4CfMe3XaIZs5LnvnhDalpeF47E+l8BSNMgoHI658Hnyo9prNq8xH5/oX+zkiW8IYYEdemkS0htDd1SURuNoaURSyDlUnQ=
Received: from DS7PR03CA0289.namprd03.prod.outlook.com (2603:10b6:5:3ad::24)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Sat, 7 Oct
 2023 04:27:18 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::89) by DS7PR03CA0289.outlook.office365.com
 (2603:10b6:5:3ad::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37 via Frontend
 Transport; Sat, 7 Oct 2023 04:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.19 via Frontend Transport; Sat, 7 Oct 2023 04:27:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 23:27:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 23:27:16 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 6 Oct 2023 23:27:15 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v2 1/2] dt-bindings: zynqmp: add destination mailbox compatible
Date:   Fri, 6 Oct 2023 21:27:01 -0700
Message-ID: <20231007042702.178028-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c59d80-9e3b-4dfa-03cb-08dbc6edb0c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GR8Ogtej7RQgsnMybs6s1dMtc7rvulKfEKEKTfTKvlFwXs4Ouy51ykLUSFFPam4t+WFCIkgTjgZlt7fxgGUolfN10loXL3u6v44awE7oZDTUgkzJtC9J7QrS/AxK6KNftvxF7BRMayRZOagHHke0mOSozkx87MW5alTrCwDxWF0STzXnairEHXGn30H0bBzszgYgkgzLR/NYMVb6+Ll7wwYysulxBuN3NPoaUoCFwk3gHTqITZgceNWGRHx7M33cfo3Ek+KNbIxgqSxkpU/dlY1JGgNfH6pikix9xjAORZ8EjW7CbH+CWlN+IuKx2chGvXyNKRcTZnfWGs4sO2ZQvqtR77j7UMDL0l5L1ECjT1xVAcM5dAidkg8o3pgEGW9z87jLeTiZbvE6g+qzOhRXOzPIRe6KE4xKtOmG64JOet/Ju0k3SyVuGJcYwt78gTKE0I+g9Qcmwl5Q4Q3WrHp9Seo3sFJIqOzQGC3gxdlEyIHOoZfbvw3i986FFRTlSd455ogMdfmBvK2/so0yl0YneQBRWvPXQhrcTWIY7D9kvaTUjTbfzONBLOjKUvVzgvQWFRlAm50TaNtrRw/HjpaoBKRQ7KzHxCxP12KmITMM6vg/QtaeSZimolKYBG8kmKl36tYcqVL08BglmdaGooxEngF9cPf/FGm/VzlHR1VWXiIqtMJ++IYFscfmU9ZRiLcKUGFliWvxJFaI63Qd/tiXj0mtJ2bJZ9M25rHKIGgOlcW8U+bKi8qN2XvG7ehpc6MLO9dd2+VoLgP8No8mzw0MOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(2616005)(70586007)(54906003)(36860700001)(316002)(6636002)(40460700003)(70206006)(41300700001)(1076003)(81166007)(26005)(426003)(36756003)(6666004)(86362001)(478600001)(356005)(82740400003)(83380400001)(47076005)(336012)(110136005)(40480700001)(15650500001)(44832011)(4326008)(2906002)(8936002)(5660300002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 04:27:17.7475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c59d80-9e3b-4dfa-03cb-08dbc6edb0c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dt-bindings does not contain compatible property
for child mailbox node. Child mailbox nodes are used
to represent destination (remote) IPI agents. The compatible
property for all destination mailboxes must be required to
identify the node.

This addition of new required property does not break ABI
as current driver does not use this compatible property
but, new features in driver should use this property.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v2:
  - Fix commit message about breaking ABI

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

