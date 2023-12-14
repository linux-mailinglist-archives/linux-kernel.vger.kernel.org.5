Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E442B812709
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443198AbjLNFnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443185AbjLNFnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:43:00 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDFDAC;
        Wed, 13 Dec 2023 21:43:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1SGACpJ9ZO3Dnr50H6rubkWsNMXxEIZvLzvaXBYQ/VXOWq2EUXP/whkQJCZvNs+Vq54UEaG5OTX1QyEcdJIlR6ULEPTUfMKCvUHawW1nYo6pymclJgQeTI6n4esAN2CrLRDiZM9uAa5JcEQzh3YKIrsdb5hFF5Q1iH9T2EMH9f4a51G12dySbZObAuD3UoBwndkbac/FalJzH+7JVTMPr/WH1/DN7/xxtbWwsJqqDtMG8zeSwg8wNga43x/RaVik3y9reREnUnKRXOaerVj41n7LlmpLKTmHlMxeKBIVEJHGhc909su+fD/kTzGPfizGjY6P2OYkoGu+qy/kSMUFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVLROPzv5+ocNkpztqk6gXOLbbYZ/XJj+0LnpY6o3Qk=;
 b=XBBLjkF0viaNupkEVACn/+wRQmOoMCVriI/VfHds1AHdEZF+x3jhRvnIbULhvfh+HV6cpt/5DNET+xF+0Ax4Eg0jTkGUF/Y86jpsCnisdakHx6n9X7ho2evXVj2VG7dYLthlZ2wMJaxIusTSHS/DPZFguFH8hxT/ZgA7Uywa92KIDihUxQBf2vHONeavUurrkckZFPIMRbhlU41N4iGCCg0ddtjDd+28+tF0FfmQ1EqSDgHDcxBxnX6SmlU+WzdXEvlevliIx0ILUyAqTlXRg0OzMtj5QyaK6GxaSd6RD2Gr43OoU7UGs/tYGJkdgayq5qILdH5dssXy1LJ/owCfHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVLROPzv5+ocNkpztqk6gXOLbbYZ/XJj+0LnpY6o3Qk=;
 b=GjwFw6XX+H//vTS8BUxmDTdeRKj6CapFbpZFirYbNuuoCaL9EZ8Be/jjX+EQiRhFZDGF28xYAEQe5vtBSJhk6yCMZObzb/82UqSblYIoeHBNb8o45bcieWorYSGihI1WrrYt6LOAtDvBz2vdtB34XHPo29oqOk9rcaH4zSjxPJM=
Received: from DM6PR06CA0072.namprd06.prod.outlook.com (2603:10b6:5:54::49) by
 CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.28; Thu, 14 Dec 2023 05:43:04 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:54:cafe::53) by DM6PR06CA0072.outlook.office365.com
 (2603:10b6:5:54::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Thu, 14 Dec 2023 05:43:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 05:43:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 23:43:03 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 23:43:03 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 23:43:02 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <shubhrajyoti.datta@amd.com>,
        <shubhrajyoti.datta@xilinx.com>
CC:     <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <ben.levinsky@amd.com>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v3 1/2] dt-bindings: mailbox: zynqmp: extend required list
Date:   Wed, 13 Dec 2023 21:42:25 -0800
Message-ID: <20231214054224.957336-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214054224.957336-1-tanmay.shah@amd.com>
References: <20231214054224.957336-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|CH2PR12MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f960bdc-abd8-44ab-4b9f-08dbfc678a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dis1RbaFqj1mAUTvfwjQTKEBke95jyDhAX1nKDO64k2kD+dzi5U8FwqvOy8KJq8z1R5G5IslxeJZfWDNmuRq3P4SriaxqveXnyWFyateX9or/XaOZiOLk4LkLHye5GdpU9aVIAmKKEJEm+6ODIKOjp8/1mHvWptKHt79FArC0Cxz2FM33bv+H0t8J9xuVKup5re4rC065irBC1DQoWUZ+aMjrAOC8p0cXyItV1nSa1XkeDTaHnVuzY7QBWlnQ6E74libtXKrN3n5Vz37QRDmDJ/qV5ip2Hll5v9SIo8VMEH8eBoor1Wdz/QvjJL7zG7aypw1rL1nBQYEiVOqqLI+msWDKCAHNn4HJpHUj7EOxtngv6UEHnqYHyjE+4VTauRahVb1q/VNQ/eXWNPSqI4D7cbcLWY21qaru/ymbjqXOpJallUMFIjWofO9bCfLPkZinGixS72aXeFiK+fnnjDDTb0gv68r2A4qECluJsoG7ukCwRtdf8u17GBREAF1UbXwGdpu4zaX75OHVNKTV0qiHvpVmLE8DBfqD82BT88qY31TvKd0uxmAHd54WjlJnOVEW/HRo3aiPtb3OyOT2RQF/7EiFK43uJe/o0jq1PYBcpga0SlgmMoZFtq9124QpOyRL1PMOO3asCisRJ+gQPJlCQwQl//bsa3tdemfn9Fns93UimASdHlDgcNfzaO2bVMixRIRQGjrj0VlnPb0ufVfovZITgjLIWUb6yalR6QufaiSpV/uRpJ8ims2evnaSMgBujBc9KgAAFwVbetwGzeuYDE6zHVT7QUbSN2818nupfg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(86362001)(356005)(36756003)(81166007)(54906003)(316002)(110136005)(70586007)(70206006)(26005)(336012)(426003)(1076003)(2616005)(83380400001)(5660300002)(15650500001)(4326008)(44832011)(8676002)(8936002)(6666004)(478600001)(36860700001)(41300700001)(2906002)(4744005)(47076005)(40460700003)(40480700001)(82740400003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 05:43:03.9671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f960bdc-abd8-44ab-4b9f-08dbfc678a9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"xlnx,ipi-id" is handled as required property but is
missing from binding doc required list of mailbox child node.
Add that to required list. This does not break backward
compatibility but bug in bindings document.

Fixes: 4a855a957936 ("dt-bindings: mailbox: zynqmp_ipi: convert to yaml")

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 .../devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
index 8b15a0532120..73c180871605 100644
--- a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
@@ -103,6 +103,7 @@ patternProperties:
       - reg
       - reg-names
       - "#mbox-cells"
+      - xlnx,ipi-id
 
 additionalProperties: false
 
-- 
2.25.1

