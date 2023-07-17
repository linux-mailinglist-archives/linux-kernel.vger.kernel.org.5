Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934BA755F6C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjGQJgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjGQJfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:35:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A59173E;
        Mon, 17 Jul 2023 02:34:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/2HFxZEuLPsbqPClX1QlhQNUUQkkw0LaQ7UMBmSitsUge9JIE5Cb9qz+RSTVeHjMSNLkE4T2x7nH1zEMVB+h0qtmEbZ6H++gPKkkxIDzOGVeuBBjvCs5iZhyZ3JastsLqqC/CNIqHWoizpCJLZ3jGQEua7y2p1tbLmmxPczBc1OS4v4Bjf1iHM6SST+RTjleth3FWFLdQREqVKa8heQbzopZjZ6V3B8KOauAMTM0qPahIp8oAaFtxd2CTEwN1lM1jYuFMhewvTjrrHJDJMcn0xZENsQwVIDShv8kDRMTqXCdtg0M/MEBEsY1RrVzF8EKekfIrpfy0GR6exuYX7E6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7NIx3YEvI4JhXMyS4rCQc94cOw7NRSAWPI58l3C+fE=;
 b=GWvhwQjuFmVymVOz8+S2bqCroW+RM7/PEQpafv91oECGKYDQfe3qBDjb7hkXoZCeInV65SE0WdbmtYl/tL2hRjJPyQGRpeAl6Y8jR0JGYXXSQA6/z2wbD8fbVsjYyNv1XYxYU6bM7MZsyc8AC/EBkEccpsXh1UPFriwL731SauIwyQtoWxpBYZhBm5bUtOqbgy0HqohAg+azmY7rXG3WxMKEUmOflR6wXTeynAm7t8ATCvAv7rWxJZhRD49uFqyBtTwIHlwo7kPAah1aYTgfS2/eRH7zKetOVl7glG6vRcAUHiFmWCtqAhawDcHNnAtmhBFxD7wJxtxpW5rqy6cHsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7NIx3YEvI4JhXMyS4rCQc94cOw7NRSAWPI58l3C+fE=;
 b=EC0gziFSYwwIkM2Vm6eG6UaPLOhlFGTlF+TLxj05mcdxBDD1ZDBltRtolVJySwDUBnAoP3OASXhoHGKOHkX523vEVVDJLdb/ec3f9f5RWmdy/WlGLYOQ2tEniMDgwhb4uYybukL2dck5VRVYXlp/Muaz3NtFgPClfQay4lbYfS4=
Received: from DS7PR03CA0083.namprd03.prod.outlook.com (2603:10b6:5:3bb::28)
 by DM4PR12MB6445.namprd12.prod.outlook.com (2603:10b6:8:bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 09:34:40 +0000
Received: from DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::a0) by DS7PR03CA0083.outlook.office365.com
 (2603:10b6:5:3bb::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 09:34:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT071.mail.protection.outlook.com (10.13.173.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 09:34:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 04:34:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 04:34:39 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 17 Jul 2023 04:34:35 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Ben Levinsky <ben.levinsky@amd.com>,
        Marek Vasut <marex@denx.de>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <saikrishna12468@gmail.com>,
        <git@amd.com>, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH 3/4] dt-bindings: pinctrl-zynqmp: Add output-enable configuration
Date:   Mon, 17 Jul 2023 15:03:46 +0530
Message-ID: <20230717093347.3869167-4-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717093347.3869167-1-sai.krishna.potthuri@amd.com>
References: <20230717093347.3869167-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT071:EE_|DM4PR12MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b711fda-810b-439d-0bbd-08db86a90b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c81D39jSVgsvV8WWOOPuJbi4KBywabx/nNOpgu6St3GJKe3K+mSO/sQn+G3+2Z+jlIronsY5x6y2UvbUqcZoyhbasbgtWIQud+nie0pUqmKu3rkRNB1oDo+ILZ+ivUYzs2prWyl4v9SRJWRErcpq0mpQOIJTr8Nh73Lke8TRMalCjUKH4cZ9RnmP3AIWocgDs8nx5cnZtqGLN4ItLcbzGItW2JxV4WlxdaV/U7EfoMw2BuTPRcBXR1xXCoIOvLtcLug6tqTJDoFP2Za9soWBiyVKZN0BWMFu+W9AxAF0M/Cf6gtiERUhQCbLPH5kYv8VG0MJ542xzPbgmwiMp4DLT2qeJmOh8Fzf9mGcI6crcQltUNsuVK/7vwmofaCAdDq6Vwo3tqpl/dIvoxyC0tqoqIgxPU365SOqjA5mu1GuDLMZvVzNpA3h8+OgR0+vS/10lJazrZF24HUDI9McT/bE8HlYcyEAJs6OnNBMcBSVv9jo0WFppii0Uxw4Kv5eCnSrDDbQnXJHdDgjppWn8IUUfoyzmnDv7AHtmyLh6qU/zmONlgzrI+gI+/Hv/Qvwv1GmWHbv/zKw3EL5TEwjP+M/FX0QpWJneFLPwOUf+BQiCcXnteN4vI5Bqb43s0VJGRBbWgv9c28Yac5uFQnyKWHKnPrQwoN/uKbnveVrEGu/G2JBil29/+WcYM0hyI/9JUaNpBnnjjXpgNmyBUWSir4346LzD+3TWWdEIR5zM/ZMKAk6JiJB5qa8VXdV6wu9GPWYBNlL6qwGDQqNdFjDBcOMqfJzlL788YPH6uTY+M02ycg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(2906002)(110136005)(54906003)(478600001)(6666004)(36756003)(8676002)(7416002)(41300700001)(316002)(70206006)(70586007)(4326008)(8936002)(82740400003)(426003)(336012)(47076005)(921005)(356005)(81166007)(103116003)(86362001)(5660300002)(40460700003)(26005)(1076003)(2616005)(186003)(40480700001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 09:34:40.4778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b711fda-810b-439d-0bbd-08db86a90b9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6445
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'output-enable' configuration parameter to the properties list.

Using these pinctrl properties observed hang issues with older Xilinx
ZynqMP Platform Management Firmware, hence reverted the patch previously.
Commit ff8356060e3a5e126abb ("Revert "dt-bindings: pinctrl-zynqmp: Add
output-enable configuration"").

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 .../devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
index 2722dc7bb03d..1e2b9b627b12 100644
--- a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
@@ -274,6 +274,10 @@ patternProperties:
           slew-rate:
             enum: [0, 1]
 
+          output-enable:
+            description:
+              This will internally disable the tri-state for MIO pins.
+
           drive-strength:
             description:
               Selects the drive strength for MIO pins, in mA.
-- 
2.25.1

