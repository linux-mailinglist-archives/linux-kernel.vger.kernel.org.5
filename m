Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B1F78B7C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjH1TDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjH1TCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:02:42 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3585E0;
        Mon, 28 Aug 2023 12:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSkEN01BaIohLz/N0oxHutYahJAqqZtyXhtfC30OfIk5rhWFa2Z5CnSc9sJtDFDtULpdZPAqUW4k8kOPlUduOONBhOSeqnSRWGJJtkvJ+JG/U+VGTiAUgix8UIq0nycnlqoiJ0KzVZQKn30N6EfbrUFvZ6+trIIJxyNwNmUMUt6py+lR+/VAobaz0Q3syQi56SpUsfFClufOVqBn2OkaAiTK5xfYdTUvQkxIIYhNqwYzuXfIOzVl8ZcJVmWfXrmU3z6rkHtKUXfqYQh50YNDeZDaUn3lbCPPTB2Ywh6A3f5t+KczZXmcqGnE0Ap8OtVXVxB/SlG5TevLxgy8cbXCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xQllGKglFv1LKUOFury9p1WWhzqcRJqzuC6eBDtfvw=;
 b=gWVXIC7fRu2KV3sIPqlWzC0eSFK8NqFJreoyP5/nXrGm/hzG+4nZXRhgTBlcoyRo2lWFe/CiMRfUQIbVm/etWn9tX55w9/eryfvPkDk2Qbcs2zpGGgxm3U75xkJpRTYQfFn5rCV86uuGECs962lKuTRyDCDPFwX4miCAxjnXS+Bc6AFKFYWHCZ3lu/wGsgoFzDiR0yn4C9Q11hLKYYtOlA9n4VQJk32tOMoa9YU92YI+zgzgegrzeE3MsOz9YyFq1CZ3tnSFS9tb8lHVq/iBmPhAwvGjPjKqcQQu0YjQ2crufwusdWqZE7RIasit6RHNnGGP/AC28F1cQX/JyNV3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xQllGKglFv1LKUOFury9p1WWhzqcRJqzuC6eBDtfvw=;
 b=aMDzB7LQ/9UEFdzkQf++EW4Q8DwpN77a6Zqwwtg130cIP7oZYJEDayKaLZIxrUAVzPto/drzbJTkTmFp8YjeWc9j2RQj6xmmi5G/hGCDz2nRdE5oFwEmF5JmsTlqzBtB95mCGxX9UCyyF/8xWI/kYxQu/uZhbjvFSQcRrpbTXHQ=
Received: from CY8PR10CA0037.namprd10.prod.outlook.com (2603:10b6:930:4b::9)
 by PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 19:02:36 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:4b:cafe::b3) by CY8PR10CA0037.outlook.office365.com
 (2603:10b6:930:4b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Mon, 28 Aug 2023 19:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 19:02:36 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 14:02:34 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <thomas.lendacky@amd.com>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 2/3] crypto: ccp: Fix sample application signature passing
Date:   Mon, 28 Aug 2023 14:01:59 -0500
Message-ID: <20230828190200.1598-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828190200.1598-1-mario.limonciello@amd.com>
References: <20230828190200.1598-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|PH7PR12MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c29dd86-51df-489b-bd0f-08dba7f957b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ntz6FYR7fZ/XfYmyWKVZFuCxU6QggyfwWYZd+k5PXtJOqgAeugagazQnpqnf3Lk7DTlGMH/qMnpm+mha38QEERn73EWS14YPSlc7rI0qnfc8tR8OwksIF9p3o3J3tZQpXw+Y/oen+/MrDS8O0h5aXA/Y7zlI94uG2NL7UNaBo7jqmQ/W1Ra7MKrphv1U6stbw+kWhFN5Mw5otva7styFxVC0VFzV+MFU4hOUYR4aiyusFAFym2TQe7T2qiILRriNAO8V/oewnvDreVmRJSLUGTDCDr49MyswLnzzSez7+Fi223vKXNGJ+6GczeAidhkwpDUDNp1D4kwguQGhSVKU6wnbwzXDcCWwDuMp0zWd0sIcpegAprS+C77jQQzYD3U3F8oCkxWmOciUHybgva6A7nC1/E9sdDrAQ8A2jsmRsPcfcw0NLk3346c5gOsksj+ackhF+Ph1r5uektpRq5H0nQ5gjgXsX1P/6rWaHrJ4kOrsW1Oud5JWriNNjTKVjLwqaQcncAqgpE8AqS4f7Gp5R65eiWeLYI3/RX01fDfCVQMeDNH1IdWouO4e7EdbiqcygUDkOdghifPUl/QEl/v7SQfgy/+b7lOklQgduw/yt8VWsFRaapiIJ4mT/6SymsKtwBtTEjGQFpzwl6UdF+Wa2i6ptW+Ioq6B0NVbZSzEuqUekLcvZW9/W3HUEMKEiXlotMoYK8khNx3nnu45z4S4hTulsjiW1zNUsT5DoRCwmmjTek97DBl1PeyPkzvmFzjfYv965QdX2OdM2A6eLAw51w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199024)(82310400011)(1800799009)(186009)(46966006)(40470700004)(36840700001)(8676002)(8936002)(4326008)(2906002)(36756003)(54906003)(110136005)(316002)(5660300002)(70206006)(70586007)(44832011)(41300700001)(40460700003)(7696005)(26005)(16526019)(2616005)(1076003)(336012)(426003)(40480700001)(82740400003)(356005)(81166007)(36860700001)(478600001)(47076005)(83380400001)(6666004)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 19:02:36.2408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c29dd86-51df-489b-bd0f-08dba7f957b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6905
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When parameters are sent the PSP returns back it's own signature
for the application to verify the authenticity of the result.

Display this signature to the caller instead of the one the caller
sent.

Fixes: f40d42f116cf ("crypto: ccp - Add a sample python script for Dynamic Boost Control")
Fixes: febe3ed3222f ("crypto: ccp - Add a sample library for ioctl use")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 tools/crypto/ccp/dbc.c  | 1 +
 tools/crypto/ccp/dbc.py | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/crypto/ccp/dbc.c b/tools/crypto/ccp/dbc.c
index 7774e981849f..a807df0f0597 100644
--- a/tools/crypto/ccp/dbc.c
+++ b/tools/crypto/ccp/dbc.c
@@ -68,5 +68,6 @@ int process_param(int fd, int msg_index, __u8 *signature, int *data)
 		return errno;
 
 	*data = tmp.param;
+	memcpy(signature, tmp.signature, sizeof(tmp.signature));
 	return 0;
 }
diff --git a/tools/crypto/ccp/dbc.py b/tools/crypto/ccp/dbc.py
index 3956efe7537a..2b91415b1940 100644
--- a/tools/crypto/ccp/dbc.py
+++ b/tools/crypto/ccp/dbc.py
@@ -57,7 +57,8 @@ def process_param(device, message, signature, data=None):
     if type(message) != tuple:
         raise ValueError("Expected message tuple")
     arg = ctypes.c_int(data if data else 0)
-    ret = lib.process_param(device.fileno(), message[0], signature, ctypes.pointer(arg))
+    sig = ctypes.create_string_buffer(signature, len(signature))
+    ret = lib.process_param(device.fileno(), message[0], ctypes.pointer(sig), ctypes.pointer(arg))
     if ret:
         handle_error(ret)
-    return arg, signature
+    return arg.value, sig.value
-- 
2.34.1

