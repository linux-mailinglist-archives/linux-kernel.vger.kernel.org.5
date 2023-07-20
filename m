Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB7575AED5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjGTMzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjGTMy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:54:57 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965E1269D;
        Thu, 20 Jul 2023 05:54:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRCsIOlvmHNQNP548AaXrk0lQhTrEDdCchVBWN+cSByzaGmRuUkAw6UgYqEweNtPjzuKNhBV04u1WAx9sKLqv7gtwm/pAIUH7VmbuNYK5N26kgQNDdin91fJGJdq5F2umiXul8oFCfM/FUhFPZKwhWpN/OIJQRAGAWo+Oh57P8Esg7o/FyySkBwTsqbrOPK6DoYrSNIITfNJ17Nscu0UJpXmk4FgRIZqdYYyohttZ1Z0vPuOBttEtKjzil0DZ6r7zaAsHSQUYULLSNqag58bE1W2Swn/FlizSiYSh3uKims7RRZ2GQDaC1uNhBeF8i+Cga6sdadBo+Gw4zdQjo3Azg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubSJl4XH8IAHWE4V1QuESlkZ/80QZTf1OxwqloJtUik=;
 b=ZzJaQvg4RyEL7QpHO3SG618Se0AWwzgRaylo2PVyGdKLXbeDM7H3lMtCNFC7BReln77s5fnqMJKCtNCPHWapNXTqO6bnwTQwUkOqT5LoFPDcDR1NFHqC3nxsd+f3kemN7rIds84Dh/BZgg8Wvrh/IN96n/5Q6Z6kxKh9ktMsCZ3gVYnquYNBFI52vuyovQP5FCXE+aJ3BqWnzPPbMzHzjYu6Pgbh/Mme3YTlNw38Zmh9UXH7Nm7THjCYPIYCAXD+FDlCaUrQf1cvzE25uRkw7E+YPYYf0y+r32bJXQmBEU7qmIyUQrdzbN/FKq8PU1jEFsVvAx2frhHZFvdw5UNulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubSJl4XH8IAHWE4V1QuESlkZ/80QZTf1OxwqloJtUik=;
 b=ryWQw0rCoGKi2kdot+6w2f2WrOV1bTACKjLDhzdgxUoqzyhXqxoaRn5K3080Tc225j+1Q0yTZqIrw6P3HoiXB9DRY1DjEmKq/ND97Xl23dUNdDGYTw1mKk76us68scohHHkoJEcMFwEFup537ytcYPq/y/0QKXBzEOC13UGHzGA=
Received: from BN9PR03CA0855.namprd03.prod.outlook.com (2603:10b6:408:13d::20)
 by CH3PR12MB8911.namprd12.prod.outlook.com (2603:10b6:610:169::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Thu, 20 Jul
 2023 12:54:51 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::ac) by BN9PR03CA0855.outlook.office365.com
 (2603:10b6:408:13d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Thu, 20 Jul 2023 12:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Thu, 20 Jul 2023 12:54:51 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 07:54:48 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <nchatrad@amd.com>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH 3/7] x86/MCE/AMD: Add new MA_LLC, USR_DP, and USR_CP bank types
Date:   Thu, 20 Jul 2023 12:54:21 +0000
Message-ID: <20230720125425.3735538-4-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720125425.3735538-1-muralimk@amd.com>
References: <20230720125425.3735538-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|CH3PR12MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff9f69a-d7c8-44ed-31f2-08db89208209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htF42f9xts8VgYaAfmS/WpwuD63Mn07j2cHdBXHSw5iTSvmfCRdO55r6rNRC4HNcdh/Lxx6Mnh3PvXO5KDvQ+Rq5cmpgx7tHbjorIIgiJkpsdJ7BDbTK2bzB6Y/94J5B4av3G5y1uK0OvRq5xOqAmVtnaNch/+WZnyGWfmZzRvP9k3nAX0eoZ+8cKFk5Gv1mzn4g440h2OlDbLy1evhi8APIT4mG+pg9v8bH1poPq8gAigaoxwzYm+eiZT+RZatJRSS847odmklhlwjbeKCV+URTJOq5YOT6vAqyA06NZJgEGKPfSp5o8phJYKTs5u/7QnGdz1oRycFPN8P69HD4A8DXN02nMif7GFtAW/XtXhx24qz15q7+tB3qxTP0QQRZ/9MQIVnCoSCt1Vrw4d5eRf8EdtCQwx7ac9W1sIPR/ggqvKCXNNNnaKM99RwJiN9roi2oy5Niyx4ztpb0/yLHWZUXA2gZah5AcwXfmyZWwXmyAQd003YVz2S/hJ7rbHkrzwX5skuFCxXqYRnYxsKvSwL2o/QkYcjFJggOYYsmv/RqAc7w7TiJcoCktMAhutIO6Jn6oyajciVfzrlhCoXsUUDEeRd7n9/vgHh75D0yPCu7Uks3IZ4W0EZwFYGgOu+0O+ac00FZZo0bXBwYz/G2t9nqQ1/WWfCp8xqgVHJnl0eDxCRa7f64ndAb8XNbkRGYd8+xY5/5GwY5i+viryCdy8X03qfly+ydOl4vHtYNibjffyyMwceZrke9FEJVPGEs16lXkrYv9IaC1IVdbyLfwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(41300700001)(15650500001)(110136005)(40480700001)(478600001)(54906003)(2906002)(316002)(5660300002)(70586007)(8936002)(8676002)(70206006)(4326008)(6666004)(26005)(1076003)(7696005)(40460700003)(186003)(356005)(82740400003)(81166007)(16526019)(426003)(47076005)(336012)(2616005)(83380400001)(36860700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 12:54:51.6187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff9f69a-d7c8-44ed-31f2-08db89208209
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8911
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

Add HWID and McaType values for new SMCA bank types.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 arch/x86/include/asm/mce.h    | 3 +++
 arch/x86/kernel/cpu/mce/amd.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 180b1cbfcc4e..8e0ed4b86e29 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -311,6 +311,7 @@ enum smca_bank_types {
 	SMCA_PIE,	/* Power, Interrupts, etc. */
 	SMCA_UMC,	/* Unified Memory Controller */
 	SMCA_UMC_V2,
+	SMCA_MA_LLC,	/* Memory Attached Last Level Cache */
 	SMCA_PB,	/* Parameter Block */
 	SMCA_PSP,	/* Platform Security Processor */
 	SMCA_PSP_V2,
@@ -326,6 +327,8 @@ enum smca_bank_types {
 	SMCA_SHUB,	/* System HUB Unit */
 	SMCA_SATA,	/* SATA Unit */
 	SMCA_USB,	/* USB Unit */
+	SMCA_USR_DP,	/* Ultra Short Reach Data Plane Controller */
+	SMCA_USR_CP,	/* Ultra Short Reach Control Plane Controller */
 	SMCA_GMI_PCS,	/* GMI PCS Unit */
 	SMCA_XGMI_PHY,	/* xGMI PHY Unit */
 	SMCA_WAFL_PHY,	/* WAFL PHY Unit */
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5e74610b39e7..cf8b4616fd31 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -107,6 +107,7 @@ static struct smca_bank_name smca_names[] = {
 	/* UMC v2 is separate because both of them can exist in a single system. */
 	[SMCA_UMC]			= { "umc",		"Unified Memory Controller" },
 	[SMCA_UMC_V2]			= { "umc_v2",		"Unified Memory Controller v2" },
+	[SMCA_MA_LLC]			= { "mall",		"Memory Attached Last Level Cache" },
 	[SMCA_PB]			= { "param_block",	"Parameter Block" },
 	[SMCA_PSP ... SMCA_PSP_V2]	= { "psp",		"Platform Security Processor" },
 	[SMCA_SMU ... SMCA_SMU_V2]	= { "smu",		"System Management Unit" },
@@ -119,6 +120,8 @@ static struct smca_bank_name smca_names[] = {
 	[SMCA_SHUB]			= { "shub",		"System Hub Unit" },
 	[SMCA_SATA]			= { "sata",		"SATA Unit" },
 	[SMCA_USB]			= { "usb",		"USB Unit" },
+	[SMCA_USR_DP]			= { "usr_dp_pcs",	"Ultra Short Reach Data Plane Controller" },
+	[SMCA_USR_CP]			= { "usr_cp_pcs",	"Ultra Short Reach Control Plane Controller" },
 	[SMCA_GMI_PCS]			= { "gmi_pcs",		"Global Memory Interconnect PCS Unit" },
 	[SMCA_XGMI_PHY]			= { "xgmi_phy",		"Ext Global Memory Interconnect PHY Unit" },
 	[SMCA_WAFL_PHY]			= { "wafl_phy",		"WAFL PHY Unit" },
@@ -178,6 +181,7 @@ static const struct smca_hwid smca_hwid_mcatypes[] = {
 	{ SMCA_CS,	 HWID_MCATYPE(0x2E, 0x0)	},
 	{ SMCA_PIE,	 HWID_MCATYPE(0x2E, 0x1)	},
 	{ SMCA_CS_V2,	 HWID_MCATYPE(0x2E, 0x2)	},
+	{ SMCA_MA_LLC,	 HWID_MCATYPE(0x2E, 0x4)	},
 
 	/* Unified Memory Controller MCA type */
 	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0)	},
@@ -212,6 +216,8 @@ static const struct smca_hwid smca_hwid_mcatypes[] = {
 	{ SMCA_SHUB,	 HWID_MCATYPE(0x80, 0x0)	},
 	{ SMCA_SATA,	 HWID_MCATYPE(0xA8, 0x0)	},
 	{ SMCA_USB,	 HWID_MCATYPE(0xAA, 0x0)	},
+	{ SMCA_USR_DP,	 HWID_MCATYPE(0x170, 0x0)	},
+	{ SMCA_USR_CP,	 HWID_MCATYPE(0x180, 0x0)	},
 	{ SMCA_GMI_PCS,  HWID_MCATYPE(0x241, 0x0)	},
 	{ SMCA_XGMI_PHY, HWID_MCATYPE(0x259, 0x0)	},
 	{ SMCA_WAFL_PHY, HWID_MCATYPE(0x267, 0x0)	},
-- 
2.25.1

