Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AE878CB56
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbjH2ReT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237816AbjH2Rdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:33:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFFF91;
        Tue, 29 Aug 2023 10:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpokTQaNDAiRRyIUTf6Bm3V8IobYb+6/4PAFUcYVTme95lCEH+kqyjVP9i3OHusfJ5jGcPKe2+2JEME2vVziwqADrrZDN1fraoxZyW4H8d673Z9kAXrEZTZU0fzMocGkwRGZRJbZEzF+LPu7sFvJgEXJ6mc6FNXehYK9NZg8yKJl4zpxlHu5c0wUvPJJCvzcEUkhWp9Lmsg2qI2ez4tMRkv0Mr9mDe0pLaZUdhCodKyupZHUBD4b9KQXJ1pZuZHLw+tP36QikDHSR8zxoRawqZLbkCHJ+vhwakaimnMjEkjzr+J5kThZ9oJ4vMjZ0tfq0Y7XseyYNT3wRJTKYrCmtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xQllGKglFv1LKUOFury9p1WWhzqcRJqzuC6eBDtfvw=;
 b=COt/DCvMkCx+IjJgD1JPU/cUHQcS+c3+C1szf2gi+i2OV9N4Hlo4GUtVNpaSkBKFNjX1zuX9BElXWjBtyeswms3qEl0KClFEPxBpSoI/wocoMT8/8JcdI+psPKkMG6pz00H7Ndo7dl3nsmI0S8TwxO5QH3JmEKAyznMibgsV8RG7M6Dp4ECgnahtksJnf5egF2S0fKDxbXLvHzXX0GkNZwjLTUl227Fi1Mlch/KVaz7tFPHfJDrvsoIp6YfKicWN9sCcre2pzQiQBX4Htq4YpI1JKnY8WThiOKJC8MJYNwvFvFRYKo9EkjU02n3SwxZZmkYLjGzFplw6ntQrMOiLgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xQllGKglFv1LKUOFury9p1WWhzqcRJqzuC6eBDtfvw=;
 b=WQgp5LnxuW9of9njgxdi4akxVy6r3DSnDAXCz1iZr0QFU8+90U79v30l6A+H0Lsanx8f9ohQVOLIIdXsjgeZPTrCQ6dcEKjRiBqUdAbQSps0ipL49DiyTzlT83g7pP8JY79ayXqfsxJczSPDbHCtJZKtiMNwL5oZ32PL0BPZjBc=
Received: from DS7PR03CA0044.namprd03.prod.outlook.com (2603:10b6:5:3b5::19)
 by DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.34; Tue, 29 Aug 2023 17:33:39 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::3f) by DS7PR03CA0044.outlook.office365.com
 (2603:10b6:5:3b5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 17:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Tue, 29 Aug 2023 17:33:39 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 12:33:35 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <thomas.lendacky@amd.com>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v3 4/5] crypto: ccp: Fix sample application signature passing
Date:   Tue, 29 Aug 2023 10:07:58 -0500
Message-ID: <20230829150759.156126-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829150759.156126-1-mario.limonciello@amd.com>
References: <20230829150759.156126-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a9f915-0a1c-4582-c73e-08dba8b6154e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xD053orUs0y8jiUFe7ZRnfsgnJTXqRJ2oxQ+o6guPol7WLWaAMKLXB6Gf0Z9b3l5Xeovmld0OFCERxkWOnnjK7w61ob57ESzDMiOE7diiI2loeMFsVWrWYea/mxgIL3lI43HwdiwTHUMFrh8jIU/dnbD0HKkzAjOvNLz205V0qrjaYDrCziCXGiyYZtpdcHPtbcW/1N8kWNeFs65QNYjh+D0234KAZza1mqwlqeI42Jp8g1PEHrbm7hR74KREVMSPOZ0OduwmeZagJdA2j9VzF+Y1iKIshZBV9GF1aZlwT2IG80ryQFjFgBPGWImc4zkmcqsbG2rQcGv6xJYGDU6EmeU5tL+r6aIy2+kMAV4bR8AH33Bv0POIC8pkDoa6KkjutDGwULljaQiuNuIqCaSZwTeEI+ZByvaxYsYoj/kLWcjMAUmQxO+tL2QQoOY07af0JUtFofVX6kdOURNEv6TdqVZ8fkmr3sHyUpmKov6emTVtX4BP1PWytoYY5FC+8k4oNXk/O98PUQM9wA/+MRHLbmFj+nd4ZcmxSqmLhIrDcerQUEROkTyKrhxThlQTy7VDkpI/2fBYd2ejQwSgj96HYK7rhpxxLs382tAq98xzRgacg3AYLZU/Bp2LM8jyQz1K2n87kkf3hqwfJkZDN0VbD0KbY+czDlJTfct4Gw3K1buliQ19a398HJiO5tN3EWS69PhZzUlOAomt1ONN23cRT8ZRYO7wO/o9afihJdifNvEdPNJaGHcRrV/Q2UCLKIMtBBotXC1Pi+ZDr8MOkP2Gw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(186009)(1800799009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(7696005)(1076003)(2616005)(86362001)(110136005)(6666004)(81166007)(478600001)(83380400001)(47076005)(426003)(336012)(36860700001)(26005)(16526019)(82740400003)(356005)(40460700003)(36756003)(4326008)(8936002)(8676002)(44832011)(5660300002)(316002)(70206006)(54906003)(70586007)(41300700001)(40480700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 17:33:39.6961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a9f915-0a1c-4582-c73e-08dba8b6154e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117
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

