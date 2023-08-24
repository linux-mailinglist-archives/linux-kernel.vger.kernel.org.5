Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62A0787B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243887AbjHXWUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243873AbjHXWUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:20:03 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3101BEF;
        Thu, 24 Aug 2023 15:20:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMErvuPanUBR9f4k/gXu/kcFeK+XyBTNaUQNXc0a/Mwd4khrvL9/51g6zDfU8N7UcZjqhT1cSOKShYAOhSs819vIdJRgisb2qOKAOd4dram8VcSoDn5yCPIWXnuDWYYXIwYKH6da2S3FGR6cP49DdFI0on//vo0iXX2vEczNFNnQQjtU3YESwCHPuZp/vqUOXZrdWlw2lAQq6oIBF8JqkhWJ9mCEStYkAjJdwbJfiSgcOIIigxtQAD1Guw9NqVsmPGan1F+2Poku2eAKXnEI+xL4wf+qYeHsGB1Xr/NEJcw6DaqykhIrnjlu5ZxMImNezw2mwFPuSGTsPZZBhsJ5HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/udfMVaiLkdoezvhE/wsL8Gx9l3vvOCa2PztxMIapI=;
 b=bvccOtEFBylmT4VibAeaJybtACjdFc4cvH6KQFzrrjimxyMBW6EVRbXBW9R0An5066SEylxm+Ek8efhGZodEVPwzhYXZT7Qj3QBY5ybzhC3a7M9U28ckIDG/6kKAm/JuVv8+bv8fi2juQEywIBW7O9YR3mahBXBrtLBsJDFDYWHzs2zWSpBNGrPUa9jVMPWbRp2UbPWM7Dqk2wUGZ6SSa3kTHtjI6b1+pqADCDO7trfszJfw9Ybcp4z52iajuGBaG5S5+oB46ySbY1yakaIFZCDzHHEMH+SY9iIfCpljTMPvWIFTDARYU+k5JELcuyYjSbvtRMLD4qFiEwrnT7AKbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/udfMVaiLkdoezvhE/wsL8Gx9l3vvOCa2PztxMIapI=;
 b=NzsauCTqecYPs74QKllZcBM7Y+gy8DNW1nN0JBTHaq9/8NpYuSs3cpfCOh1QGp+u56gmonQFtcSfPKFLEGbaZ9jtUiqMe6P6smPLLXC74Mf34N85h9WqNB1U+o354gFv8LLeCOQtF+NuOrpGQH7MmcQlJ5yh3fUP96wOg+w7+NU=
Received: from DM6PR06CA0027.namprd06.prod.outlook.com (2603:10b6:5:120::40)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 22:19:56 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:5:120:cafe::9f) by DM6PR06CA0027.outlook.office365.com
 (2603:10b6:5:120::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Thu, 24 Aug 2023 22:19:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 22:19:55 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 17:19:53 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <thomas.lendacky@amd.com>, <herbert@gondor.apana.org.au>
CC:     <john.allen@amd.com>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v2 1/2] crypto: ccp: Fix ioctl unit tests
Date:   Thu, 24 Aug 2023 17:19:31 -0500
Message-ID: <20230824221932.2807-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de14585-5568-4329-b9df-08dba4f03ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Upkm6eusoaMmJzN0+GwMvfSPfOpvXAtXEZQzC97tx2HaFVRbNBDVUEdIXgbBa87AEh/8y+EdJg5/Zn1l4NioW7yZ6pGH8O6/oPgUpl9/v9v3055JG2YdmUDSaYafHngHR0ymsOz65KH2QXCbzwl8eaYN8EYwi1sp8KqNCg1G4+B2w2qW7fUbCI7h0AL6bBheBjBJSs2SVTR0LyW172ivnGyH4sMPCE3Gmsw6YrObFAVYhGeVI8MIkRnbJbp1aXGvrnFtx045F5ynh+bC85lNAuk/N872IoiOpjV6FmzB6ukvr1KKs8ul+Gbiyq5i7cgbZMCSK3Fc12DtHvvlZ1nEpNZqgOUk6HaFs8bFNsf3j/Lzol3/CvgtzN6dsad0Kwl/QfWiJFO30s7hWcUxBWT9zmj/R9HfOqUkXtEqVKmepfJDXSEraf90QPBDQLrQniWbzwTQgJ2zjcS/DAMDWXcPpoCXn2pHRXdxtfErKDWwV6HudXga/HK4Hlbxg28vp5bOZQUAI2hw31AZ5+dLEg0qu35hd/hNJplaRblDuXxWdeEvurXU1KdLRagDHl6PPZosIg1JwlXJUk29841Qg91+YwOSt+oCcZ4l7tVF3bRLrN/h4xIv/Gp8lf3/Pa3QlsO15ydxdQ4qyYm8kSy+rKZ3YmcC1muUBJ0/5ro4kcV9WUq7/wtYZpgZlRkNMaxslk3ZIVce2YYOos0Z/NSl9sjq/dEf87g5jmJfD/9njjqJiLa9il+mBDS/UnIaL7wEO80wdsy51WSt5r8cqkShtqAXpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(1076003)(40460700003)(2616005)(5660300002)(8936002)(4326008)(8676002)(336012)(426003)(47076005)(36756003)(83380400001)(7696005)(44832011)(36860700001)(26005)(16526019)(40480700001)(82740400003)(356005)(6666004)(81166007)(70206006)(70586007)(54906003)(316002)(110136005)(478600001)(41300700001)(2906002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 22:19:55.4108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de14585-5568-4329-b9df-08dba4f03ec1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
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

