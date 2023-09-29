Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD86D7B30F2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjI2K5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjI2K5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:57:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DF211F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTx1+cmdFutP8tsNMGg+lrfNWaoCqJSyov5Bn1WHg4TOmiyh3T3kNxOcwPqBA8KH+8auyG2cx/V/FOUbLtaYNAvsY4g4pazLjQTNvQfKnzhKCdGeG7BJEjzkyJr8mN9uj6lAiZO9DlNSourjUBU14KGl2MMmkHJd6g5vNg3F0SS2L4YV0hA2Q9ekRtKZ1iffGj502xPo3W6balHWNVIzCeDO8Oi3+E8TsKIn/PcCps+oLI+Dgph8DwJGuqViRDlyDOck2afq3UGiiZDfXSlXCHv7koTEk/fEOOFAZASeqUDBw4I7X/mC6/2MGG6l3zMW0PlW2eHMjxolnlpXZ0Zo7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KyZeer0+O9IJCYIfYBm2aTpBVbpw6pEzNjZY9ptrM0=;
 b=D/Mv+E6l8P5AuYTZz021avbRMKNRdYgLAUnA3USuk3Au3NYp1OF3LTjSvA+r0PN28OehFYb7jaAGymp8dMk9P5PlQqUx0wySjAuF3xYHLkSxg8TXb5T6cClOjAPIQu0IAv8+vuKueM9xxdYUK9PVgAXRah4+idsnDQkj/zACHTnbhT4WJlT9z7ohjVHnGHJ18ZZcpNxI1Sc+HASM0AMe5k/OWynCRyAJOeUWvYnKgxqjzBMtPNZuJQPkfXWfyb31TJszdUNk5tQhFLKoSTTnZt9imfccXGIe91t9fp7VZsbBH1SaGS4wdqm5TwPIxACv9xf6thwe7fxORLdN0hiQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KyZeer0+O9IJCYIfYBm2aTpBVbpw6pEzNjZY9ptrM0=;
 b=tXDJOczfAv9zS/j0+/MI1t/6B6c4fjTLC8x5KAjhpC4rECov7uNQRDgCu9iNzlKZVNOl4M0m5cjryq/jyg6p95SHDa+T1XyeiIqJBOS6Eh6Oi9eNjkA06cagyCBQV8iha8JbQFV20xxNEQCVuxaOOu/tthzz7rWmzwZmAReDwCI=
Received: from DM6PR11CA0060.namprd11.prod.outlook.com (2603:10b6:5:14c::37)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Fri, 29 Sep
 2023 10:57:32 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::85) by DM6PR11CA0060.outlook.office365.com
 (2603:10b6:5:14c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Fri, 29 Sep 2023 10:57:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 10:57:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 05:57:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 03:57:29 -0700
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 29 Sep 2023 05:57:28 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <tanmay.shah@amd.com>, <sai.krishna.potthuri@amd.com>,
        <nava.kishore.manne@amd.com>, <ben.levinsky@amd.com>,
        <dhaval.r.shah@amd.com>, <marex@denx.de>, <robh@kernel.org>,
        <arnd@arndb.de>, <izhar.ameer.shaikh@amd.com>,
        <ruanjinjie@huawei.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
        Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
Subject: [PATCH 6/7] firmware: zynqmp: Add support to handle IPI CRC failure
Date:   Fri, 29 Sep 2023 03:55:57 -0700
Message-ID: <20230929105558.11893-7-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230929105558.11893-1-jay.buddhabhatti@amd.com>
References: <20230929105558.11893-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: cc97f218-2ea4-4b37-68aa-08dbc0dae196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bwS9aEKb0fG3ZafKfI9q9FnzbUsAnKa6wBuNA4waxC55RkbCechs3GUTBYTdvvSaNOieD9hg/pdwnnMAfNL8MjTzRgPFVYENWuDMAPRcEaP89XRGp/Ssy6KppCtev0iqgQn+OfmJHU9nHfjX5RDPpBlOzGIGZYiXFsl9cSZK9CesNgwRlvkUj3l43rArm27IYLxp+ak5jHxp5lFVZ94s0KMYrSYT9lHxtJM5urlLyuWtFbthLRz4iRgnhTchnfOrmTdPxsTsxtLVVFX/C14QuRuCyVYCQRfH0aliD/l0qwlsWbkkD5W2OA2NA/GmXRDyuBejhyFf5f8LFbBO83v0kPggnMhBDCGhskjUUEfXR+wVsRGvQ+4C80rmbwzrfkgoPzVNqnmWrc0tfkBsjX5q7IfHdcdG0E/0mYhPuOZd0oINH43SdztvuOGHfDG1cy6BXR4ErfE9y0ImnaBPox6DaJS7oMKhyy43Bi5AZJJwd6uI+z16Csk0727r6/8uESB9Dp56qPNFR3kDFIf2oAWqW9OfpH4WF74KXYX98ESl+vdTtB0kuma+f5uEs+AtIy1saLAkDtFiGtaeDY/ogBkWOXEo0aYmYh2uevkNkawkDbtxExR7pAx73NG1ViyPzWsJ3YKxzE9tkXp+cLsE7EnAh7PXPyapWUh4jqyDy/1z68D9fyfTYiRbQkdN2k0Y8AWxRuSpCxXg9JrGpn0IWoR2wQJXqGILN2q6rsPQzNC1UxuLJrYWT89j+HunVd7wA6AyFWcVcZbyNB3/l3LZNYUrFFWeS6dOAR5M2khyt8gCFik=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(6666004)(83380400001)(356005)(82740400003)(86362001)(81166007)(921005)(47076005)(36860700001)(1076003)(36756003)(2616005)(40480700001)(26005)(2906002)(336012)(426003)(5660300002)(478600001)(8676002)(8936002)(44832011)(41300700001)(70206006)(110136005)(316002)(4326008)(54906003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:57:32.2253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc97f218-2ea4-4b37-68aa-08dbc0dae196
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 0316db03fa51..5e497a8ea7e8 100644
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
index 880c3b17571b..1aadcd2dc34c 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -170,6 +170,7 @@ enum pm_ret_status {
 	XST_PM_SUCCESS = 0,
 	XST_PM_INVALID_VERSION = 4,
 	XST_PM_NO_FEATURE = 19,
+	XST_PM_INVALID_CRC = 301,
 	XST_PM_INTERNAL = 2000,
 	XST_PM_CONFLICT = 2001,
 	XST_PM_NO_ACCESS = 2002,
-- 
2.17.1

