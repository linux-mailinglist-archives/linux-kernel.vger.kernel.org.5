Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0383D7E6418
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjKIHBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjKIHBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:01:00 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1263A2D51
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 23:00:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J69Wt9Lp1TSzC5yMvgDfPUcUclzil1s6qqxccuANlNpMaL5KnJ2HY1nKYfjkWr5tCuHUvGhdWouHE0+27fyTF7xsZuaFZx7dfNj4sHKY3vOeidJMZAP7g7W7wAex1IpAbJF+GJ+onnoAaLzaHpU1bfy6jOHHJAO6gCduZZ6p/XTvgrtu8yzjn8XKzH0+N1qpjMY8Ae9YaSv2h6ETMFntitZ4wUU2LnQPUNIWmlrA6tz0LQe8jRk6m4FPuYk1BYES+8G7HyMk32INYWUz+vY39V+ALWEWdxzFnnKG8VcaRvNL9sRa+TccBaWnQHtD9Qn/7a4bpSTO2F0dUaOwHIejmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37obLtJuRuEK9Xro89Nvw7nk7OgxJeR4+EnjoDg44Sw=;
 b=TGELslSe68VWtmLyVuCfK+44ma2hzOAjO6nMujWvxvXP4F1rWO71+eIf1KavQxPd83iDlmTgrqnREKIlvSJgYEiddaya+90j8ObGnhbYdf6YU8lMfcPqvpHn3G32AowX9Po5tKnCXeo4z3gDSNsS6xl8EZ+LrLUOHpSSmIpvnmo6fGUoQvjm8lV/osHVT/FywD7DHTv678LJu4TD5+JoIykrnn1nnvDvMrE0KhYZl1vNCWjllZCsJYgs8jq8jkQ+FYqc7oz2yxZCvG2L3zu6t3kmOVbKza7YxWb6YuY52m5/D59yieeFc7vXPL5uiE0Fi4tYoeWJ0/qVj20c+fvKMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37obLtJuRuEK9Xro89Nvw7nk7OgxJeR4+EnjoDg44Sw=;
 b=fWsW29sm0k/fyX/HeQUn/q/luaISdqdYPBfhJy/tUgNJshYp/xhRk4IJyDw+MgFGDHFwdD7kYzCucC0THfrOwmI9F80TgQTG03GeD1Sbp/o9FA6YEDnAlMYuth+CQwapIgM9wjvFs4OFImnI8h0gPPpUkbfnRVpearXbYxOlDlE=
Received: from MW4PR03CA0082.namprd03.prod.outlook.com (2603:10b6:303:b6::27)
 by PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 07:00:53 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::9a) by MW4PR03CA0082.outlook.office365.com
 (2603:10b6:303:b6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 07:00:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 07:00:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 01:00:51 -0600
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 9 Nov 2023 01:00:50 -0600
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <tanmay.shah@amd.com>, <mathieu.poirier@linaro.org>,
        <nava.kishore.manne@amd.com>, <ben.levinsky@amd.com>,
        <sai.krishna.potthuri@amd.com>, <marex@denx.de>, <robh@kernel.org>,
        <ruanjinjie@huawei.com>, <arnd@arndb.de>,
        <shubhrajyoti.datta@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
        Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
Subject: [PATCH v4 5/5] firmware: zynqmp: Add support to handle IPI CRC failure
Date:   Wed, 8 Nov 2023 23:00:21 -0800
Message-ID: <20231109070021.16291-6-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231109070021.16291-1-jay.buddhabhatti@amd.com>
References: <20231109070021.16291-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 9566ae2a-46db-435d-5077-08dbe0f19d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5sB7/Id1b25GEUIDe/tnuzdoDyhWK99qqOSL/xTM6TTAKJbl6aTjj/Fz4jDvIDDeygDFkKSZoA1a50bBjkI06M45KFBJhj4t588Qww2YRf94c5MS7tpCGNGB7e4ynuoTvbaQsE5/4O4iCdKSpsTjgHThqO9Dw9nkaBEW5OeGW4LX0ev06YG5bA3I1Kdjqj7f6gbD+I5+Clfn8qxiT6iwxTPIt/fokTlTJ71rzdLGej4IU/bixW/DK7X5g8mJ1hqIwdsOHrrdIPOpvBEslgC1OYdqGDdl4kBwxphrDuiGT1fLo0GVaT/z4F0MGgK43bxPs1S8Z9m5osEfPu2vFvbikyfHjVZBxTmhfVLv1a6aAaziXwprjMM4Zf/9ig8CuLcwtjEVNaFqHkKQa9uE3YZpdLkxB8Q4cV2R0nVkW5rNgk2W8NrkKaFibpu4BfqB4a28Ki3UKq2h5F8Kn+Awv3SjtvyBvEEPNcHUqEggNgfqmuzmobXUNXF2Z3+IPQ8ykjyPUiicoBEFu6q46WkPrRC7vXFes0ntd8/LazIc1W2XewGqizg5HDYf5UNjbhCuzxjRSiIMrAmxfyd/XMyniwY7Ee0Z6prloAO1rqtv0t/Xl9wlN37dNjTYFYmSnP0Uu8NRcKXeopmiVEBJKaTeZ/ePb9503Yb3U7IAdevb5rQbB2VMsvjXgg/XOgCFcCKih0RFeuQnJUYyTFVo66wZ5hyjYsDovZwEyfEfpTjbwkm+pJIWUdBPa6uUwZazZ5BOXjyZv91toEcY0PbRK6xysvPx3JTIi/1ZfX3deTvvh/TfU1RrPEhqNomYv/pnHh5brF/ukLpb9JNPyzYKb9ZwQaEH7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(1800799009)(451199024)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(6666004)(110136005)(2616005)(6636002)(316002)(1076003)(70586007)(54906003)(8936002)(40480700001)(4326008)(8676002)(40460700003)(83380400001)(70206006)(26005)(336012)(478600001)(426003)(921008)(36860700001)(36756003)(5660300002)(2906002)(47076005)(86362001)(81166007)(44832011)(41300700001)(356005)(82740400003)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 07:00:53.0555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9566ae2a-46db-435d-5077-08dbe0f19d32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817
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
index ff57dda669c7..06116a1cc62e 100644
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
index 815bef3f0bd9..f9af5ddface5 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -174,6 +174,7 @@ enum pm_ret_status {
 	XST_PM_SUCCESS = 0,
 	XST_PM_INVALID_VERSION = 4,
 	XST_PM_NO_FEATURE = 19,
+	XST_PM_INVALID_CRC = 301,
 	XST_PM_INTERNAL = 2000,
 	XST_PM_CONFLICT = 2001,
 	XST_PM_NO_ACCESS = 2002,
-- 
2.17.1

