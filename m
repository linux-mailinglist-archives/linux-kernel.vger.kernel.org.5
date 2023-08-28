Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089AC78B7C7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjH1TDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjH1TCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:02:44 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD52EC;
        Mon, 28 Aug 2023 12:02:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNabrBWlcuii4RQJzsprQfvnHXVR9MYx4UAUEhnCwY+MEjrcVJgSm1mq8AuUIFlfycgdUDDb9J824kauqZ8F2uoEm6zniPRdfkuUn1GVMcF1HXfGkwTUZF80CwTDPybkMxMIZAG4Fo1KWjeZDec8Br9uR529TyQv2HjITbc0znGjTJsvGwKOiYhpwVsUOMlC5ZXPRt6O11pxun7KHdhBcrXbyFQkUsouVoc9b3pzSGXAPCbd4dVs1DVTac6T9WBzjUq9uowuOj/wD5+/mTgmO9yrWlPXG+oAMg7jSAJ67T+1nDGWpDmIW2HczRyvuUBxAO6lx+SEIWgqm832kip2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BN4UyTF//1v34ikMap5IXmAYNpGZ0dTXnuozVuxOpqU=;
 b=X6hj6Nq1GV7h+A+467U/j2LzMxWX9i6JBvCjZheiS93Y/LuVJMnNXDpyVXBonpO0rDnuhaQdMJtpaWW1GwbNyjGRY9cGs7IuslwUugVDZUU3HAp5ah3V1zvltbMszohRG8Q6gcwcV/kLpTH1r8z2Q7KWh8x04gQjAqyanZc5bg5EypJ6oXcLH+XQdQGVhc4UvtB5d9c2DldzTPqEoWYSXVkPCj5lajnwKX1NOoy+OyiMVvUNttDaVVVo7T144nTSYPuyzHfRY1RcP1NfpIAJ3MEXM5T38D1T35dZG0iAm8rwwk88c+w61YPUDl96McAQTsN9maFAQWy+r4Ydc1XRGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BN4UyTF//1v34ikMap5IXmAYNpGZ0dTXnuozVuxOpqU=;
 b=m2Z1v1RTOngAeH2zABENUVp8seC/37t1heGTbV2Js2mLQIvwl3CVDj04WVOS3vsnEbtP3UPCS0dQQnq7UVABs8bpPAOhK/ivS6gxgXn/ZyOGwlt8zOeVxenHu3fvTV9P5x6D4fU1I3utrjKO9Db5jDJgYFo+VjPDWAXzOOjYgdc=
Received: from CY8PR10CA0043.namprd10.prod.outlook.com (2603:10b6:930:4b::8)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 28 Aug
 2023 19:02:36 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:4b:cafe::4b) by CY8PR10CA0043.outlook.office365.com
 (2603:10b6:930:4b::8) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH 3/3] crypto: ccp: Fix some unfused tests
Date:   Mon, 28 Aug 2023 14:02:00 -0500
Message-ID: <20230828190200.1598-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7cbb39-af47-439f-6ae4-08dba7f95805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vRRlHxDJCF5wXgQxj2Pad4F40M5w674at8oqS4YMEri2ZWsBfGZ8wsyrfISiYGtEC+bkfmcDwM3TDDoz9pFuC3x45YJr/nkA4gwQkVF/1qLnLFmGBtYXUKrunYdl9BxxOTKZlMt8ie1LeqWS6/UpUg6WMT1TJWKrl013C60jsC540FskeOnqnNFC9LS2/oAtTSqXDUZwMuI6w/ApGHwqNtErb7zqQWPi5IrMafkHWc11WVXKJAW9BdhASC203n14mYFcmJ9aKBAAL/7pAB5v81vhh03FzJNjbYarb9Q6JASfTwHQOi54FvuOoZ34ujfQf5rJ8icSDTadDlQZ6YQaO10rKgSZ7BRnln5v0zS2HUcR/xzQKj493Q7CktQe5PSFpdGKV7jaQ7WPCra2wcURNmj/DjY6LF6vdwZhCwob9hNeZlb+B0YklBDfBVulISnAi8ggyBoPolFKdd5CryxR4d1cYYItERNsb/JI+ZywH3SNaA1MxTreIVKX9DPhJYn5rgwuk6RWNUunfkpwbWPKV6fGL/BtulMVt6woVhxfDwEsAS0qSS4h2ZJWbZ1F1dzclfMuJTnLyNtWzxWGsOUbxs1/mPwA+9JHYf1qiWA9mrgZPFwV0zxbCT/xY3s1tPfbGL3ZGytH8wE9v+bcXic1L9bV88Kg4eFc/uJvdKJD6NAD/i9UXmR93q4L3l+5DUG8OGHMF6/qkVYGVg6H3qf/+4Y1tTtxF6sgh2hqmkxgqvS6Hu5hIosQ8Ma3W5viNy76uu+vVjvPrZVsh67BxQJ6eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(82310400011)(451199024)(1800799009)(186009)(46966006)(36840700001)(40470700004)(40480700001)(86362001)(110136005)(41300700001)(5660300002)(44832011)(54906003)(2906002)(70586007)(316002)(2616005)(4326008)(70206006)(478600001)(8936002)(8676002)(7696005)(6666004)(83380400001)(356005)(82740400003)(40460700003)(426003)(81166007)(47076005)(26005)(36756003)(336012)(36860700001)(16526019)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 19:02:36.7408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7cbb39-af47-439f-6ae4-08dba7f95805
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the tests for unfused parts referenced a named member parameter,
but when the test suite was switched to call a python ctypes library they
weren't updated.  Adjust them to refer to the first argument of the
process_param() call.

Fixes: 15f8aa7bb3e5 ("crypto: ccp - Add unit tests for dynamic boost control")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 tools/crypto/ccp/test_dbc.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/crypto/ccp/test_dbc.py b/tools/crypto/ccp/test_dbc.py
index a28a1f94c1d2..18df031aa5e1 100755
--- a/tools/crypto/ccp/test_dbc.py
+++ b/tools/crypto/ccp/test_dbc.py
@@ -192,12 +192,12 @@ class TestUnFusedSystem(DynamicBoostControlTest):
         # SOC power
         soc_power_max = process_param(self.d, PARAM_GET_SOC_PWR_MAX, self.signature)
         soc_power_min = process_param(self.d, PARAM_GET_SOC_PWR_MIN, self.signature)
-        self.assertGreater(soc_power_max.parameter, soc_power_min.parameter)
+        self.assertGreater(soc_power_max[0], soc_power_min[0])
 
         # fmax
         fmax_max = process_param(self.d, PARAM_GET_FMAX_MAX, self.signature)
         fmax_min = process_param(self.d, PARAM_GET_FMAX_MIN, self.signature)
-        self.assertGreater(fmax_max.parameter, fmax_min.parameter)
+        self.assertGreater(fmax_max[0], fmax_min[0])
 
         # cap values
         keys = {
@@ -208,7 +208,7 @@ class TestUnFusedSystem(DynamicBoostControlTest):
         }
         for k in keys:
             result = process_param(self.d, keys[k], self.signature)
-            self.assertGreater(result.parameter, 0)
+            self.assertGreater(result[0], 0)
 
     def test_get_invalid_param(self) -> None:
         """fetch an invalid parameter"""
@@ -226,17 +226,17 @@ class TestUnFusedSystem(DynamicBoostControlTest):
         original = process_param(self.d, PARAM_GET_FMAX_CAP, self.signature)
 
         # set the fmax
-        target = original.parameter - 100
+        target = original[0] - 100
         process_param(self.d, PARAM_SET_FMAX_CAP, self.signature, target)
         time.sleep(SET_DELAY)
         new = process_param(self.d, PARAM_GET_FMAX_CAP, self.signature)
-        self.assertEqual(new.parameter, target)
+        self.assertEqual(new[0], target)
 
         # revert back to current
-        process_param(self.d, PARAM_SET_FMAX_CAP, self.signature, original.parameter)
+        process_param(self.d, PARAM_SET_FMAX_CAP, self.signature, original[0])
         time.sleep(SET_DELAY)
         cur = process_param(self.d, PARAM_GET_FMAX_CAP, self.signature)
-        self.assertEqual(cur.parameter, original.parameter)
+        self.assertEqual(cur[0], original[0])
 
     def test_set_power_cap(self) -> None:
         """get/set power cap limit"""
@@ -244,17 +244,17 @@ class TestUnFusedSystem(DynamicBoostControlTest):
         original = process_param(self.d, PARAM_GET_PWR_CAP, self.signature)
 
         # set the fmax
-        target = original.parameter - 10
+        target = original[0] - 10
         process_param(self.d, PARAM_SET_PWR_CAP, self.signature, target)
         time.sleep(SET_DELAY)
         new = process_param(self.d, PARAM_GET_PWR_CAP, self.signature)
-        self.assertEqual(new.parameter, target)
+        self.assertEqual(new[0], target)
 
         # revert back to current
-        process_param(self.d, PARAM_SET_PWR_CAP, self.signature, original.parameter)
+        process_param(self.d, PARAM_SET_PWR_CAP, self.signature, original[0])
         time.sleep(SET_DELAY)
         cur = process_param(self.d, PARAM_GET_PWR_CAP, self.signature)
-        self.assertEqual(cur.parameter, original.parameter)
+        self.assertEqual(cur[0], original[0])
 
     def test_set_3d_graphics_mode(self) -> None:
         """set/get 3d graphics mode"""
-- 
2.34.1

