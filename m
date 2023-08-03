Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D39B76ED8E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbjHCPFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236864AbjHCPEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:04:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E1A3AA6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:04:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ul95NLkSZK9hUpkEAEEddyq5wdjxZPemAqWMONN0lbNKbgMLSmKE5N4c8cKqu5zSQCIu3yCiU4HplChjQvr5AxwGCvm+tRWWt+evuNkCHtvWh/ztPHR9awC42lNF6HNDNTIr3Lr6QSDiJ+xu5dJ+my/90Tsl8SZq4qjnsk+mcXXvG/ehvCOatkCqVZq0qW3Fm5CrCmBSaXgf1Le9bw+fUf1WovKQY9NlnEUaOM7NnAjL3zDqJIvNTCvDaCZBUSzEExPWWjAlWhrqYR+MbVtvtdVLFw64WoFYBuscUvvO3X7T+Z7Y+X3mwg/8etKuJVmcHQwEHex/kxabGCFW9lBdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7acyCzOBxOYKxt+a5KNBxcWARZNDscNkMg4n+nmadQ=;
 b=GPy59vXLJpW9RYaBC9GA/IY7CveZePB7q0vO57F7f2tUbUdd9OU3QaiV5zeAXHmfX2QBHXJSaEcU5BeSc8SpK2eYu/1AjrybPEXcvgvLBAs1XzHGO3SEcvOxmRs1sIYmVp34OHJolf8hZE0NM2sxqi8UiEaF17MHLO4turRkdf97BZ9AUVUHzAlm59nWzjIBSx+EYjlvkEUrBGB+AJsOoPLS80CJhEtqZtp0VhUWH2yRiT0Qm9dnXu4xUlCk2bH4yotD+Fl8DX101MqMkXVIw4vgTllnfGskB+1lxU/q81wSNiV54qsjD0ft+xlnfDueR5o4Z+pIkFpkWAoesdF9JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7acyCzOBxOYKxt+a5KNBxcWARZNDscNkMg4n+nmadQ=;
 b=SjvcLYcMZvQPTkGyhOrFsHOM5tzQVqM4NAPrTn7UR68/OmmF1uIJ4k1hU5/ZHAMKE/ZCkWUa1O5x8Ar0f/j++hNs9hQK87aCe6ZjYLO+4HG+2Z2P+ip+uMWOXTGYE3rcVrFTiYxdje0yXfl02TT/bQ2HB3rr/1JISAUy9/2x8KA=
Received: from CY8PR22CA0020.namprd22.prod.outlook.com (2603:10b6:930:45::17)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 15:04:42 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:45:cafe::b) by CY8PR22CA0020.outlook.office365.com
 (2603:10b6:930:45::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 15:04:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 15:04:41 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 10:04:41 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mario.limonciello@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] x86/amd_nb: Use Family 19h Models 60h-7Fh Function 4 IDs
Date:   Thu, 3 Aug 2023 10:04:30 -0500
Message-ID: <20230803150430.3542854-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f640126-1ee2-451d-4e44-08db9432f739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NxSHNo2IoVPBbGsilDHO3JQFvitnOalDMZ3tAZzf+bvHQ6bYRZO4fEYyAbgNfs0kHBQ1PMF44t5HGCn2Smi1pC21eqBQ+ZxGs2t3CRBfKq1yw5GcQmWWZg672bOWjBt14SVw2fitVKFOmHfw6ymd66TB0ZfveNdqx1r6/LqwHyQ0an9Q0SZ/LMTQefDU9KQmoUqGwHTTy1aDlFuhNvY44GLhEdx6FQhjAGz0wcVzf+SNfiD6SZ1QuUrc9d0MWbfonYMgwH+cIiHXp+ktfmnbY1TPe6/evHUNPp1VMooDQLDhvzS3aBbt3k5Wy5mGypISsTz8RybFGG/fKk92PYUmSwQhkCZJiBzACVRTGdMIDgFA4nyeBpfjLfUsX1KDObcBqlGNO+xtn8frFUXVeDNOV4cGaKHkz1psQq8EIekIgt4ptHeFNo+aKw6lOK8+IAY/ENNh5WpA/DouvdhP51KARZe+JJB+XmHWLi/GmMfnSBJn8qWN6/QAEvM6zhvCjl4Wlk5HRZZ9OqBOjvo1UBA4PndGqTgF3+s7H9dJQgW3QUtgZoS00ief/l0mqYgM7z06AHTMtIzwIV0tuL7UheBOTGg2ELf9MzTLX93vKd3/s3P1yeR4CbDMkvF3z5+Vweyr79Gm6whekhLc8U1FqLsAK6l+WhVZApMFixpj96R+sdQGacQxu9FAmsE/qSDzpe0xKb6JQ2jXOPuMDypCLA3j/A3fIPGM7R7Kvn7fgWlPwC8Xg1LDdbH7RLCdHs2UgLoBFJpPxoKXbmXwyQTtrj+IhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(40460700003)(16526019)(426003)(2616005)(1076003)(336012)(186003)(26005)(47076005)(8676002)(316002)(36860700001)(2906002)(4326008)(70206006)(70586007)(5660300002)(6916009)(41300700001)(44832011)(8936002)(6666004)(7696005)(54906003)(478600001)(40480700001)(356005)(81166007)(86362001)(36756003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 15:04:41.9123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f640126-1ee2-451d-4e44-08db9432f739
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three PCI IDs for DF Function 4 were defined but not used.

Add them to the "link" list.

Fixes: f8faf3496633 ("x86/amd_nb: Add AMD PCI IDs for SMN communication")
Fixes: 23a5b8bb022c ("x86/amd_nb: Add PCI ID for family 19h model 78h")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/amd_nb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 035a3db5330b..4857aaf6f38a 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -105,6 +105,9 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
 	{}
-- 
2.34.1

