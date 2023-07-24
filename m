Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB86375EE3A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjGXIre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjGXIrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:47:31 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A8DE67;
        Mon, 24 Jul 2023 01:47:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOpnpNL7mWIuOT/SyRjzKEqROSx39Pf22m02gmnk/SzPbTPvobANAvfmriJIlitnWRWD/pKTuSjc6a+MQa8hJRjztWFzOZd6oGvIlEZ0ySS6MUo9r0IMGLFmxlCUuOWipfHIsPPTfB8I+5tNUWUv+qveEb2wSwg1ds0b02JZG9jWJg4vafe3dZcWBfh16QFbTl3vKAkEKfzO1d0GZH/6xJMTKtgJUhReXyfrW3MfQ0JCtYZ0lfXTd9cEfRVPbBYivV2HxjJZ/2thxTIYNKkE3b4EYfNFKiJaK7K4pi3p+c1qth201ERPQnx1r/yCQNYLHoKs8ZEaOwii8LjR1XsxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOUXFZ2fh6HfnylylmEOHS+AdxbgHvY4dnmAq80H97c=;
 b=Wh89lYu0orJqrRcAIbxs1Vmt0598JzuLXknnv6cfcAfeexgp4M+tjfFX/XTWMlyMJmwYQZSyLqo8opIoOwHfoC3xNVE6ZFTJZIhKzm6sDYrArOwqJOA9tsYHPGywGfaOIT/GJnhwBu3ATE8NExHH6UTIwYvsPmq/LwQ5aLCWNcpIepaFjOQEUVPfhYpX24OHYjAWoi0gIR7yhRSDLck8neO2WcjlJaHPfEGLkeRmME242AEKxw6D78Fncbbz9wjEFhaqExgQkhGvxLqhh9LyhGuINTOpfEbC2ubMbYx3TAfai1V0SilO8iD/yhDyP+jMMYfZn6SBX0fq10m/QjUEkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOUXFZ2fh6HfnylylmEOHS+AdxbgHvY4dnmAq80H97c=;
 b=d5jcvNTlTmeoNYihDQtZlqUVGMHF33wgKrWr1WG6CkpH3O0o16RI0s31Y42fz9qIReWefb+Vb+kA4ZGk6KBAyAHF1Z4R/0obJNRtqWajhX66IKvql13dQSzaQ2hIvGLCzb4LhV7Lc3kqUHsd+9igmSE6ERv9bznumKjVd84oKd0=
Received: from DS7PR05CA0072.namprd05.prod.outlook.com (2603:10b6:8:57::7) by
 CYYPR12MB8923.namprd12.prod.outlook.com (2603:10b6:930:bc::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 08:47:19 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::63) by DS7PR05CA0072.outlook.office365.com
 (2603:10b6:8:57::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.24 via Frontend
 Transport; Mon, 24 Jul 2023 08:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 08:47:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 03:46:53 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 24 Jul 2023 03:46:21 -0500
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
Subject: [PATCH v2 3/4] dt-bindings: pinctrl-zynqmp: Add output-enable configuration
Date:   Mon, 24 Jul 2023 14:15:53 +0530
Message-ID: <20230724084554.1924378-4-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230724084554.1924378-1-sai.krishna.potthuri@amd.com>
References: <20230724084554.1924378-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT068:EE_|CYYPR12MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e740adb-c6a0-46e6-2837-08db8c2296ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i5o6sdA1SIhGWU+ECrX7X5jcnjHakfEUg8FD0TPDLRbfBLVUmyghoejPCHMZijvs9aKRdGnEUjDj4sCEtY1bXst76/RkDyESXWFcOY6tFflbAAcsQQasOMuADnk9PJstCkbc6eKn3A6rLXCKYjiBnTtLQ4DAYXr3s8rzVcD1gxiO10OJuwTwK10kdOd/gru5kCcJmIr/ehEikSM5qcOuakK4ogEYz8zfjxB55x2JTIKv/fvARm/xPIg5hHmIcJbTFQg5zcii4+bQW8DzULvW9odD9rZe5E6l/2Z2MCaKNmGFW3AajZTie1z6ehOjRT5GxSx2oj9bk1KBfgk9JA0OU+diOL/OG5J28pOkRuvA8aPDTFNx8AZU006Y5d9nJhZcHjLTmieo5xq+OlXBYzIZqAQPlw1Yv9WaKoE/2I92L6zIMS1HYOPooBlxJVw9FqKMvkA5dN8V4/9+OqUrQMCpmyUyXjT30hqPJHLMZk12vO308fxe2wkZwYd9RIPnCiRynlJ7LnzguM+m1KWZlah6K+my2djgilw0KkmkVa5ErG6CIfsA1rU/st+k7gA8FdKLeLpVNQv4x1h0EcV0lF6uIVOQFEmjEQV+DncJNe21RRpQrXG49bK+2zV/VoPqkq4Gmli3bdBWDOfJQBPSAZILZs+TPfRWpoqDEwuFO1CowpqH+Dqjm45WRdmS77VflzLcjvQvtIL76K1m1AlBfh2czYYzHYm67djKpPF12X891priwRAIQAJVzIcy5rQ2jY+SIapcJqUWtvupiu27jy4opcqvXjk0aaSR9U2b0j7e5jc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(86362001)(82740400003)(110136005)(478600001)(54906003)(316002)(41300700001)(103116003)(70586007)(70206006)(4326008)(5660300002)(7416002)(8676002)(8936002)(6666004)(2906002)(26005)(186003)(336012)(1076003)(81166007)(356005)(921005)(40480700001)(40460700003)(83380400001)(36756003)(36860700001)(47076005)(2616005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 08:47:18.9302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e740adb-c6a0-46e6-2837-08db8c2296ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8923
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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

Support for configuring these properties added in Xilinx ZynqMP Platform
Management firmware(PMUFW) Configuration Set version 2.0. Linux firmware
driver checks if the configuration is supported by the PMUFW when it gets
request for TRISTATE configuration from pinctrl driver. If it supports,
then calls will be made otherwise it returns error.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

