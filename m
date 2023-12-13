Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DD1811246
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379089AbjLMNA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379076AbjLMNAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:00:41 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48671D0;
        Wed, 13 Dec 2023 05:00:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwdhcR/yW20/Av0XSgSvi0p8h5Hxq3gRyeaQE9OD5G4cAb0MpAzT/3UggRpFhoQl/OggIceHe4fMzDKq2KeKWf+nCyMeInOQNYqhmbRUHUanvk5PrOB262AF0TfHN4sTAU8C/Wzb2cnUv7p/haMebLnWayqy1FJj9gS79yyb/AtXYoK83TLFoPXIoZfXClHpC+ntPA1yW9mi1dylBIxRTS5ZdRLCh1kz0zhJ16RZhFnOi4jGn5aF4yXwi0W6d9i5s1MmFRNq70VSWz+Q62xjKIulkNOt+tPZ8i3mmg/zibIqW1FBWpYfaHVmmCgWdSaIY/zKK9IF5GB1Gn3mjYdp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35jqh8vE1almpzWeYtvjRI5IHuT/PnpdFJaNEJh40Oo=;
 b=k1nlHx7ZPvr//ab5t3N5C1U8aVXVNT8v0ZwTu78uqD3x/2X3YfU6Sg8FDV8n0ihkVNCaPe2bC9oPo0NWsHU2gL+8SNmJxnh3rrWY21IuUQC9lq1suOGDQxbwBzeT8/paD/f0lptoctwgkrBP6MCWuktDCvriXhUiAJrdalJBgoAIitD4vgtXqeicLFuk8UoUoTMnpiAAxG1m9eTOyxc1z+QCt4Fs8Sg4R5mPPiva5k7z/oVTwskYvNytpk43M/0lZHRcJ9kJABfH++xrsrDFCPKMcvbkKt8j6ty96f7DgokOCJMmJXrBYfF1wdutqXM6pcxLhuoODvTzl5tWPS+Qqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35jqh8vE1almpzWeYtvjRI5IHuT/PnpdFJaNEJh40Oo=;
 b=hnMFG6BHyRvF8RtbUJm+1ksjShBAGbLSAVvpVIBPyj0ieif/ge78BJ5bcLYLoDSpq8WjAt1e/jHx+JFNnz4s6MqfUKLrh4OedJEbOvxNBOa6GIZepwri21j7WzffsIaRRPSdxjSqAqn6BKdeg9XpFSCC4MLpYE3sScUgEvz0y44=
Received: from MW4PR03CA0009.namprd03.prod.outlook.com (2603:10b6:303:8f::14)
 by CH0PR12MB5347.namprd12.prod.outlook.com (2603:10b6:610:d6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 13:00:37 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::96) by MW4PR03CA0009.outlook.office365.com
 (2603:10b6:303:8f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 13:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 13:00:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 07:00:35 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 07:00:35 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 07:00:31 -0600
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
Subject: [PATCH V5 1/3] dt-bindings: Add reference to rs485.yaml
Date:   Wed, 13 Dec 2023 18:30:21 +0530
Message-ID: <20231213130023.606486-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231213130023.606486-1-manikanta.guntupalli@amd.com>
References: <20231213130023.606486-1-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|CH0PR12MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: 003624ba-8a9a-4049-f5d9-08dbfbdb8037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JntX/WxlC2zxLIWwVkDS78GvYixWDu6rpijdQfGw+4c7aGik1V6WSAIBgSMo+5wMuYaxJhcNos3tS/R9iWdFdFxWihu3fQYfrRl9d9zfy+TpUWeMN9RZiIZxqQScudZjL8d/mTlRE6xoSPrD8zuwzp7LZiUC4m5bgS4EdJePb0U5nDAVjqlGPovwTQtsE7xBqlgNKkDIWMebFy4J4l7rh9MC1XDigRyWBtbsWS++Pmc+7tWy6IskyIoDflcWekNbZPkntsHFLMSQxv9kqBxNdTdTUmpLyVhk7EEQdWEr4fQHBTaVKmx2FpC8dh84o7oUCSNY7wCpSIQxAOF9/UGEke+Zwp48xtmQUFDbSg/+tqYibFIPB7hY4yT+NbXCdwVeEoUJPPF9HQfhWDcjqrW9f2wYGVd4S7LXuYf+he4c0lpC202DgU2Bye+uLniH9/gxF4fxTQXS2+kKrNLHj2vKEGCTYBPJivffzoP5z2gbQZElGaZTfg6DAzUGqJqelVxR2l+HJyQaM3hhDPNWC0nCZcQc/F6QG6Tg5l3t6ExG4HxYnK6qGxlJdf6ggL5lrG6TMBqkT5xuekzJdmc1l/dWNoZ/FVxR3MxuaIaOdPz4zLt5BU4ILqbgaYM4BqIxmR8ZgxP7VGsEKAAaEVfcRLVt/xcfbdr3EcK5ZMFYhrCVhYfkJESzJPsy9PuV031b7NitcwzApJ+8FvH02d151LgUeF6PJWBIZf3F9frTsdMcoUVwZyQ+D7iD8+aQy9c/85OjRemEFkKinLP4MiPI0iM8H9ELpPQJm9ZNOWKHt+9UNQU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(921008)(40480700001)(40460700003)(110136005)(70586007)(70206006)(356005)(82740400003)(81166007)(36756003)(86362001)(47076005)(36860700001)(426003)(26005)(336012)(83380400001)(1076003)(2616005)(2906002)(4744005)(7416002)(54906003)(316002)(478600001)(6666004)(5660300002)(8936002)(8676002)(4326008)(44832011)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:00:36.8274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 003624ba-8a9a-4049-f5d9-08dbfbdb8037
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5347
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reference to rs485.yaml

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
Modify optional gpio name to xlnx,phy-ctrl-gpios.
Update commit description.

Changes for V3:
Modify optional gpio name to rts-gpios.
Update commit description.

Changes for V4:
Update rts-gpios description.

Changes for V5:
Remove rts-gpios description.
Update commit message and description.
---
 Documentation/devicetree/bindings/serial/cdns,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
index e35ad1109efc..2129247d7c81 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
@@ -55,6 +55,7 @@ required:
 
 allOf:
   - $ref: serial.yaml#
+  - $ref: rs485.yaml#
   - if:
       properties:
         compatible:
-- 
2.25.1

