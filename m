Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FB07B7C7B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242096AbjJDJnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242051AbjJDJnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:43:07 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB96AC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:43:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yvoc1xMBhLVczYV6aHhFVGfVV6F4SFaSGAxwwlS7yBCXxQf1CRDZjOEKUme6VK/8wq75wKxWSkxCSlHFylgZ1MXWI2hlV7Wv8o8rlnX60nCB61l5wszqhA6Ms1JMkr6KXVnwkWSGpNIWDdCwsyMxMthyhX5LI/FKNnZtSDAWBlOXZDN/Gkm0+Hy1PadnzgSyyF15YbAUNf3Ante6IgmvYocaJ8u+h7oh+2NymwQssrbgxTggtKllPGiDtz25R0Cd5qTeSIa23QliwS8Aclm/LLA4V71CpwYkPhSzB+a523vpt096U5lXNNYstQbx9Pp6kZbIbNU53c9P/Jismlpq+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZE8g1kvoVq+w7u1BBdQcFf7ddk2hYdxtN69QARB7PL4=;
 b=nA3uL2j2PtLNWEZ3u9wvAFAumKEbxzJ3Ff87Ywzfo7CCf2+M7J4Ba8UMH0UQIgCE1G8CNqJkPEK4bOyaXQphe+o9KKw0bqvtCbNDOVZ71jfcyVpTNbLXz0bOnLT+1Zc2gSaLn2jUMkO0y3fNow95DIgth2QGZwWlPpdA3XoI5vecZtDvzgjnHVFuV5WKTzJaZHkJXryj6rcXPOEAE4JeiCqhspiqJ6xoBITB8KUZ+hwqpAN4nPsh9FmCXGRLJjzh3jeuEOGO85jqFowHaiW7lzvTyQLB9urfOHf41ByH/6+8iaCoDFMpR/H43Odi8Py9EbNuZvG/x5PkkPIQtvkUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZE8g1kvoVq+w7u1BBdQcFf7ddk2hYdxtN69QARB7PL4=;
 b=kG8texCwH54NvDx86Z2uzRZXcjvjKumk1bUHt1042z5Ql0+IjpScQhoPOq1vW1BlIy08eJW6Yg9/vzF7XsbSMfAffATR8U5SHwYJC7EWyumA/CYYqMBmrzox0TTrHbQyy29GvcC9p7OR3PsMY8O5D3cEhFkcmXOMW37lTElpO38=
Received: from MN2PR08CA0006.namprd08.prod.outlook.com (2603:10b6:208:239::11)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Wed, 4 Oct
 2023 09:43:01 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::18) by MN2PR08CA0006.outlook.office365.com
 (2603:10b6:208:239::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Wed, 4 Oct 2023 09:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 4 Oct 2023 09:43:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:42:59 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:42:58 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <tanmay.shah@amd.com>,
        <gregkh@linuxfoundation.org>, <nava.kishore.manne@amd.com>,
        <ben.levinsky@amd.com>, <robh@kernel.org>, <dhaval.r.shah@amd.com>,
        <marex@denx.de>, <izhar.ameer.shaikh@amd.com>, <arnd@arndb.de>,
        <ruanjinjie@huawei.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
        Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
Subject: [PATCH v2 5/6] firmware: zynqmp: Add support to handle IPI CRC failure
Date:   Wed, 4 Oct 2023 02:41:15 -0700
Message-ID: <20231004094116.27128-6-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
References: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: e5017f28-5474-412d-d37e-08dbc4be4ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9GjjZJnHfsQTkMC3d/H+1cBWEPJUvxp1riy2e7FJWgFmRpWZmjqxk3s8OqrnVG91lO7bHDCKwYdaEs21VW1dEHUvsBX23vGnGt+JJgayOlH6iIUJOooGpUX+xXy0vk6yIy1dpXa+DuoVygIActnlNcmLPpeG+nFr9f2tHYVWMaSFuyNBQ7SU2Yp+GiQDBcAIqxE6/g8fdpRmaJxcWM38+acVUCsT0LCJiU4KYzslXKw8fMtYQqi8cYe5L59bbfz0YwsUqgn63nMc6+3gTMUWIiHkYn6jGkJdwx0hJzAl7ZB3SVhQ5opcszOEHHNWJagE1jBRKUL3qTrDe2dq6vagBT49MonzmxyK5IV017/no11LPtogf1Jt5feYRg/KQc1l6ALoPDeOGWQObxtENEC7aV7QP/7+5kJO5fz0cl/wY/lvOnGewBzNyemkzfKBpF/vb8/NvltXPJ7T4J8WAxT/SI4R4Bp/nga5KKc9CWAbttNFOCPQdWjAM76vypCYkM8rkM0MLhPlgcKK8Jr+XZwIf6Bf2WVrHe8slPrSDQZe0f/jkXDCCW73qMIL/x75vfRp1Sf+7lQcBxACpxxdOkPqpd3R/hL9b46BoLWaVogNtO4CIOjsD8se15Wc5/1mZoSK6V1TOX8RkCpNN9/i8RNUDAJ51PKt0ZylJbMrZlGOhqbQevDEkugwkKXllstmBGL5brZQEQdsIPKbUauI3IxQRScmUElb6A2s4rZXBNwzoJ31Yx40/4V0P7wV666HpKhM86pBav4JU9V7swaR7GU0bTX3ihf3bhdt9ysStG4ZO4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(82310400011)(40470700004)(36840700001)(46966006)(5660300002)(40480700001)(40460700003)(6666004)(478600001)(26005)(36860700001)(356005)(82740400003)(921005)(81166007)(86362001)(2616005)(2906002)(4326008)(336012)(8936002)(83380400001)(36756003)(426003)(1076003)(70586007)(316002)(8676002)(41300700001)(110136005)(54906003)(47076005)(70206006)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:43:01.1354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5017f28-5474-412d-d37e-08dbc4be4ca5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added new PM error code XST_PM_INVALID_CRC to handle CRC validation failure
during IPI communication.

Co-developed-by: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
Signed-off-by: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 1 +
 include/linux/firmware/xlnx-zynqmp.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index de09d77cf1e4..515936497927 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -103,6 +103,7 @@ static int zynqmp_pm_ret_code(u32 ret_status)
 	case XST_PM_INTERNAL:
 	case XST_PM_CONFLICT:
 	case XST_PM_INVALID_NODE:
+	case XST_PM_INVALID_CRC:
 	default:
 		return -EINVAL;
 	}
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 4afd5d63177e..2fdda6086de2 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -162,6 +162,7 @@ enum pm_ret_status {
 	XST_PM_SUCCESS = 0,
 	XST_PM_INVALID_VERSION = 4,
 	XST_PM_NO_FEATURE = 19,
+	XST_PM_INVALID_CRC = 301,
 	XST_PM_INTERNAL = 2000,
 	XST_PM_CONFLICT = 2001,
 	XST_PM_NO_ACCESS = 2002,
-- 
2.25.1

