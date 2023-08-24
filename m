Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E52787B2D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243824AbjHXWFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243840AbjHXWF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:05:28 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105351BFB;
        Thu, 24 Aug 2023 15:05:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7ER10vR8oISvv4s6qYGCogEMVggFapfxIymSYoyRdNpnyC/B0OHUENPlQib5/MU/0PWzN+Gq99oJmjVViqo4SJdNnJzdRTVRC5b25tOlDjrWIQauwjDRf+CQYPj1L+dZNdqf0sqr8ycUiAeIeSz1p/hZdeoBcgJ6f//28w8eyoRyJsAOcU93bYg00aUuA/hB+XvoOmPAp3tnsulzY3w3tulEwiYK6b1jfKNugNLHDQY6V5mITTOBlD6sVwE5/blSvD4lSF2gD4BJm5mmBx8hunRrKv3bWTV8SVH3NwmlKVFwp4huc1llHp3nJ7qz+uFN1qFlbru8v4Sp3171e07tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/udfMVaiLkdoezvhE/wsL8Gx9l3vvOCa2PztxMIapI=;
 b=VKVL6rkpO7H02tt2pDn4a9C04xCDDZ7Uf2zuRU8LWMn1ZLDjF+jCoq0uvEle37pqsKcwBFXQhNBsZrYGfPcO5/+jYIBUOnkKId8aZUSLjA1Jmkc2uobKmE7vVfueHZM7ZTghRkRxZI3A1VQJCbf8Qbmb1KFNFqkKT9S1lca0LMt9z0ZNkd8usyvkT9E3/QBHjBFBEaBuJz2sL9hjMmv0P0BNGPwNzo048VDg9zWV1xm+PpqbGCzAyONr2SCx29zTXz+kuJH+m1J5xZDR6LqVnJPOGJFJJZGk9Ip2hsVs5/s9326qIyeSY06wOM6c9zimETSDlvFCzh6AufeU6/4fWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/udfMVaiLkdoezvhE/wsL8Gx9l3vvOCa2PztxMIapI=;
 b=QqH790zl6xeK4eI0+big3y5SaqOCmrxXKB/vDhhmaBt6vB383WgvLrE/b+tgryIJ1T3SSPSsSEYgJaEy4Gx7YyF4RtRs60hSa4PQcNkVWa+ZkLFEdrs9P0hPClTg3m/BsY9lRY7G1iRgXBb0XII0U8L+NtowhfLzGG4NvvdGS4Y=
Received: from PH7PR17CA0056.namprd17.prod.outlook.com (2603:10b6:510:325::17)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 22:05:21 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::9b) by PH7PR17CA0056.outlook.office365.com
 (2603:10b6:510:325::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 22:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 22:05:19 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 17:05:19 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <thomas.lendacky@amd.com>, <herbert@gondor.apana.org.au>
CC:     <john.allen@amd.com>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 1/2] crypto: ccp: Fix ioctl unit tests
Date:   Thu, 24 Aug 2023 17:04:58 -0500
Message-ID: <20230824220459.2723-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|MW3PR12MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c7ebb38-4b47-434a-c11f-08dba4ee34f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qd4VotPGi7XKWh58NI0Ply4wk1/ttIvjazDvy4G8NOFLZJ8niQF4t6VakR8vWNFxTU1ZALQcvg6vH1zYdluAwEzpnl+VKNjIyxU9gIUWKndWxO8ldpgKwrWKFHifk8IgBm4uilhFfI9UsDQLPZTr+FGTbT4ZKMAOWKacN/nH/Zro4OpYjtPWr1P5+A6YdnhaoFZBZsxncZx8ismttVotx0gKmr7kjeolgsjIb25zrGwJKCZH5gbler5KLRS3yW6AL0GawrQCK8jY11gT1JPHS2qxnduzDwzAYZYK9BlSZhPpn7WKwbp+KwXCzd6umdOBj4luisFB26Qd81LZ3kLW57TtFH38SPfkD9FyZEQx14IYbkH/Cp5J58704pchJzXFEUFWxXqo8/FWajiEbk4maf9ymthHWNtTnLjbjULvjirMDERs3oZcIhiegz+vNxzcgLHs5ncwCANfRhxIZxNy/yqcp+l7NH91flpBCuqwJ32SEgNXrwxLLXT8461oJlFo6WoAqD8e457Ly5SlML5eUykRwFGGBrafWT0n5jqm6qRwe7c6QTixxGyg2xPo4zoegqkotyR6eb9S7o5o2ccEKT1MKifOPJZLxVj/BrvzkyYJHULDs5/ts/3x9UFecVmlIC679YIh1bz3GDlB3PTf2I39vXrTdCLFJr5jE7FlxpIa1FwDe3cI9aTH5wQVwec2o9kuzz/GS9WLXGYsmYPie8o3Spj0h4IBqk1/3IKHLpK6Vyu+jFXIHdont4CYN8CVIYqDK6fy08JRmotMjulkaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(1076003)(40460700003)(2616005)(5660300002)(8936002)(4326008)(8676002)(336012)(426003)(47076005)(36756003)(83380400001)(7696005)(44832011)(36860700001)(26005)(16526019)(40480700001)(82740400003)(356005)(6666004)(81166007)(70206006)(70586007)(54906003)(316002)(110136005)(478600001)(41300700001)(2906002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 22:05:19.9384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7ebb38-4b47-434a-c11f-08dba4ee34f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A local environment change was importing ioctl_opt which is required
for ioctl tests to pass.  Add the missing import for it.

Fixes: 15f8aa7bb3e5 ("crypto: ccp - Add unit tests for dynamic boost control")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 tools/crypto/ccp/test_dbc.py | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/crypto/ccp/test_dbc.py b/tools/crypto/ccp/test_dbc.py
index 998bb3e3cd04..a28a1f94c1d2 100755
--- a/tools/crypto/ccp/test_dbc.py
+++ b/tools/crypto/ccp/test_dbc.py
@@ -4,6 +4,12 @@ import unittest
 import os
 import time
 import glob
+import fcntl
+try:
+    import ioctl_opt as ioctl
+except ImportError:
+    ioctl = None
+    pass
 from dbc import *
 
 # Artificial delay between set commands
@@ -64,13 +70,16 @@ class TestInvalidIoctls(DynamicBoostControlTest):
     def setUp(self) -> None:
         if not os.path.exists(DEVICE_NODE):
             self.skipTest("system is unsupported")
+        if not ioctl:
+            self.skipTest("unable to test IOCTLs without ioctl_opt")
+
         return super().setUp()
 
     def test_invalid_nonce_ioctl(self) -> None:
         """tries to call get_nonce ioctl with invalid data structures"""
 
         # 0x1 (get nonce), and invalid data
-        INVALID1 = IOWR(ord("D"), 0x01, invalid_param)
+        INVALID1 = ioctl.IOWR(ord("D"), 0x01, invalid_param)
         with self.assertRaises(OSError) as error:
             fcntl.ioctl(self.d, INVALID1, self.data, True)
         self.assertEqual(error.exception.errno, 22)
@@ -79,7 +88,7 @@ class TestInvalidIoctls(DynamicBoostControlTest):
         """tries to call set_uid ioctl with invalid data structures"""
 
         # 0x2 (set uid), and invalid data
-        INVALID2 = IOW(ord("D"), 0x02, invalid_param)
+        INVALID2 = ioctl.IOW(ord("D"), 0x02, invalid_param)
         with self.assertRaises(OSError) as error:
             fcntl.ioctl(self.d, INVALID2, self.data, True)
         self.assertEqual(error.exception.errno, 22)
@@ -88,7 +97,7 @@ class TestInvalidIoctls(DynamicBoostControlTest):
         """tries to call set_uid ioctl with invalid data structures"""
 
         # 0x2 as RW (set uid), and invalid data
-        INVALID3 = IOWR(ord("D"), 0x02, invalid_param)
+        INVALID3 = ioctl.IOWR(ord("D"), 0x02, invalid_param)
         with self.assertRaises(OSError) as error:
             fcntl.ioctl(self.d, INVALID3, self.data, True)
         self.assertEqual(error.exception.errno, 22)
@@ -96,7 +105,7 @@ class TestInvalidIoctls(DynamicBoostControlTest):
     def test_invalid_param_ioctl(self) -> None:
         """tries to call param ioctl with invalid data structures"""
         # 0x3 (param), and invalid data
-        INVALID4 = IOWR(ord("D"), 0x03, invalid_param)
+        INVALID4 = ioctl.IOWR(ord("D"), 0x03, invalid_param)
         with self.assertRaises(OSError) as error:
             fcntl.ioctl(self.d, INVALID4, self.data, True)
         self.assertEqual(error.exception.errno, 22)
@@ -104,7 +113,7 @@ class TestInvalidIoctls(DynamicBoostControlTest):
     def test_invalid_call_ioctl(self) -> None:
         """tries to call the DBC ioctl with invalid data structures"""
         # 0x4, and invalid data
-        INVALID5 = IOWR(ord("D"), 0x04, invalid_param)
+        INVALID5 = ioctl.IOWR(ord("D"), 0x04, invalid_param)
         with self.assertRaises(OSError) as error:
             fcntl.ioctl(self.d, INVALID5, self.data, True)
         self.assertEqual(error.exception.errno, 22)
-- 
2.34.1

