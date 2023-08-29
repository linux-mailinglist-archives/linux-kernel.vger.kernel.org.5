Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A645D78CB54
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbjH2ReS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237821AbjH2Rdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:33:45 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12AEC9;
        Tue, 29 Aug 2023 10:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJJDejlcpBkKTj4LzOLMgrKMyCUaD8vL7RkPInTwnabH3UMODiXZRWn4YdVtLMOM0jAfL9i5aGnPA395J5XWpixXWO2QJqr5Ct3EceklqoRepAPYQAWKsvj7gQ3Vf9+FKqngz4WKwFE68XueX9G6LTWrHsJqPryfWYHho67lVT78HRIrCXkCLcTsMANmi2WeHzIV1OEu8Gid3DQ4IB9WYmtXFmnDV3a5GBkC4jF0I6Yu1/H+Hq8Zzh4CKp1/NMiUVZ2ZRRKkcP6jSNDOz7BRzDY3mNV3pNkrytoSCFJpGVibCjGtUtTA1mPnOB6BR/R5lLOaPwoRYhlOizCWkkTBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/udfMVaiLkdoezvhE/wsL8Gx9l3vvOCa2PztxMIapI=;
 b=VSn0nMl5j/77bGUhp5NBxRgXT1RWAtVthcE3XI1nEgozhmrjicsAnBlEBrwubF1AmZ0rhCbVBDGWh6Uo9QDZyTqlDWx8uVUOiXvhGidd6ZCwq9xZ504pS+8mbT+zQeLTa6Ihj6lDWyqmjqOByCbNSPkkDETuPD3fuYeEdtfL02ethWEkWDLhTZfdnorPnW2IDZTgppneQw8F/Z9+iz1d2fPEcccw2jEyCjOH2oFsMil0Qf+hysEchPzipF6KOejEAZlkYoSDYNS0E06qWd4os+3Bs8Q35z1W503dnJQt02iRUX/prIR4aPvsVOy0PgwVqwtmTojz53IC2tRtl4/Fag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/udfMVaiLkdoezvhE/wsL8Gx9l3vvOCa2PztxMIapI=;
 b=xH04YKIkRCggEKNGXLo+fHYK0qCMOcv0Z/q/Jwoo3CqdwPluF/c4acTJQa9gABajM3uNmrcUxcMw4m3DXQXWpd7p4jdAwu+ix534x6guF9380y8/1lMRL5Gv/NRBMk6FTNYf7t0qByo7cEE8I8T0Tr1TEZGi6Lj0YqBH6kQH+ro=
Received: from DS7PR03CA0055.namprd03.prod.outlook.com (2603:10b6:5:3b5::30)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 17:33:39 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::38) by DS7PR03CA0055.outlook.office365.com
 (2603:10b6:5:3b5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
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
 15.20.6745.16 via Frontend Transport; Tue, 29 Aug 2023 17:33:38 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 12:33:34 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <thomas.lendacky@amd.com>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v3 2/5] crypto: ccp: Fix ioctl unit tests
Date:   Tue, 29 Aug 2023 10:07:56 -0500
Message-ID: <20230829150759.156126-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af0acf9-95cc-4201-f411-08dba8b614d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E36LGOVOww/K0FPw9bnhzK0yl4UcKES3aQWLyJcfEayMA8kplQVRIRYilkqJD+BdBoEdyXvBINWOIPCZEtA0RLVWubadnoGfqgk8YGJye9Sw3cWG3bcXLOgieTAbKo3igwaBnloUIhKCNap3HBrnRcK+6kldP8JScD83cd+H44POnGBtmbReR0Hvu0nBeHN/YJPZ9U67XkNFP2xdFCXydNxqBJueZLzgItonAWAW8UMDxs6xMUdRYbxwLlMEYE3rOGjsMycsLbZyrn4U0TVg0RcCYugYeKfB5piDP3hnhOK79mNdFgHQILUbAVuuabjA82nkq9HsQRaOl1iZDdIPUrGHXa2tRjMDfVv6LcBdelmPvlf6QD3YQVoHTrEjw7wne0ULgZ8W2Fmn8LlBzjTR26X9/HxP+ksTYRFonnb4u0X/XbGO/7vASsk3VEzUYyfAidG7j5grk/BDEv80KeGFx0dMU8TFhVPR7r1TqIB6AZRMT/zMV2oolAqMssWJb7rJcawjjpyW8iiWw3sqrUSbSDuLYpBJWJf4IWNKw76+Lqdpjb2sa7chT1+1ukBD48zO5mjwmDhT3S88RXAVgiShzLfc/ih4/+6Kor6s5jZQ+EaB57c5CFEHKaGoERpoNBHBkrW5E7KpXn/eOM8VzyWBZtBnNYnlK9wZj+nT+9o4Y5+okkLFEp3AzRELXoeJ1ST7cZ3lQ12B4HpZlUP/vaIiDBGvnXIn+YmoFJnGm89gXfcFIxHTG1wrUo+B7hctFLbL7qgMYT1w3hbame55JV2nJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199024)(82310400011)(186009)(1800799009)(36840700001)(46966006)(40470700004)(82740400003)(6666004)(7696005)(81166007)(36756003)(86362001)(356005)(40480700001)(47076005)(36860700001)(1076003)(478600001)(426003)(110136005)(26005)(16526019)(2906002)(336012)(83380400001)(40460700003)(70586007)(8676002)(4326008)(44832011)(41300700001)(316002)(8936002)(5660300002)(70206006)(2616005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 17:33:38.9462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af0acf9-95cc-4201-f411-08dba8b614d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
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

