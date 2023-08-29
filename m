Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394FC78CB5C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237985AbjH2ReY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237834AbjH2Rdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:33:46 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1E6113;
        Tue, 29 Aug 2023 10:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq04zIIPY8ognuYg/Ha7KrHcwJ1jU7Ani6IHNwlW2u2eWrkJDxcds2ZeNk+edEU7oPixwY85Yh+kNOg3NvcJVJm8ADkJGMVl+QdCorOR/H5D3lr1LTlqXjYAC7kdGYRY7xLJuTGeA3cQQo6u9RYbb8DbcBFhPGw5S7qUZViRvLUBihbPkXNxsnV0/dZ6sANA52bc/LBQZW7rAhrHoS7MUUZKKeic+rt7LnjkXKJOzrHaN6Bb8vKFXr1VeXfoSvizAgQfqhSIY8wVIIfhL/5odBixNqB+HaRGYDdRnFIHBytywv9DvkzjwmpgMzn5+AQR7Yahkop/0ALqLjJXSYQwaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swMK4AS+xNOzeidT5UnOauIodF3UBtnQjuO95XkmML4=;
 b=O2/oaw6RF1o/g31GgOBJCti6b30DFN9Ouzxh4XhKnnDziNZuu0O1Cbd3Rb6IfQn28UzVzi+lAY5gCgo0bt2+ZN8z3S0Q6zyr74TOHgXXskjRAgHefEh58Q9SWgcDSGZk7iuDJkxQcdqpERrcqsFYxztvOTh9PyiN+ytVFv2etgnUYXbe4Tp+NE2mGV70aHW2iF03Ai5r8Ea90CtuoNnOglk2LcraaM2Uw3EuaL6LfSx0tLP5ZdwPmoEWwgt2JNPRA/1NVUNlsc00VF3QjaojD27uBIzpe+BSJ2ICgRvERXrsuI6vi88mLSRqfOjChTyMvWJjo4/uIhb/gN2tcPdI6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swMK4AS+xNOzeidT5UnOauIodF3UBtnQjuO95XkmML4=;
 b=nUf05RF0JcQcN5iZjYZOiOK9zfwIZ7w9ahhil9xx9yxMPLrICm68ccPbp2IhbNHEOv3b2PcP+Pk81hutIrVpjpHNdXt1WDYWMzFukyi+5xBE2p0VkvF4WmFyAsVNyVx+Q0Yp7vBj2BiOVL02Ny4EEOzDmuM2USET4jnWrUt4Bww=
Received: from DS7PR03CA0057.namprd03.prod.outlook.com (2603:10b6:5:3b5::32)
 by BY5PR12MB4887.namprd12.prod.outlook.com (2603:10b6:a03:1c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 17:33:41 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::cb) by DS7PR03CA0057.outlook.office365.com
 (2603:10b6:5:3b5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Tue, 29 Aug 2023 17:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Tue, 29 Aug 2023 17:33:40 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 12:33:35 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <thomas.lendacky@amd.com>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v3 5/5] crypto: ccp: Fix some unfused tests
Date:   Tue, 29 Aug 2023 10:07:59 -0500
Message-ID: <20230829150759.156126-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|BY5PR12MB4887:EE_
X-MS-Office365-Filtering-Correlation-Id: 08bf8b95-dd42-406e-7057-08dba8b615fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9vDmygP/u8buQ+cNU+m1L5TifdcoT1i2fgniYJ1smA3bDYC1JoGKrpAPH7xWUqQBatOgtOMpMJCMm3RH6T1G0eEG+652wjrHLy8eqKXodWCOqFasR8tW8xf+wS9Ryl9AefBEQl3AJt0EicANTjBcrDRlhW4OHLCD8qWw+zT8EXxqnmSapau2YoWdeYFsxVDjTzyA4dlMUdcigdlhcFyTOeDNyetRfr9JUdsmyGpm5L2lViF3FC+0N7GTYevAOxrI7FHfolKblabsog0wnodJFWgXKtqKJMyQqUp/Z9+J/kI9Uziw0jjsm2BwGs9ktbp3Ey2blYrdF33ioiR2BJ50k15TAD3hvvfL+SBuqyM+OpcMlyxmzosR3Tjyahpt8ixYDom9h1K9h/DRwVwe0LUaui9GBDjagG948Agxw9ZG9mx9E1i72sm2EF5sZ8KWMh5Tl1B7aPior6XJfOyNsPM00CEMD1tc9+uG2F0Y5TiNRB7uijpTaTlDc7GOKvfmy8OWpM9v4vWE+e/Ogy21i9Sjfnl8heAGHssRbRakvQb/k7wC/+2xdBu8LPHmrlxq1sw3aeLoqglxnOcfQaNexB0FpsBLjDjJAUwYxHuK37cvoUSWBPKgsjksXCATb6LffHlaHPaAfqmin5jh9Vjfg2KH1OP3yAzkOTCK7QY8tdGt4Pg1XNswv35cs7YIE2anvWIEWcYLPwAdsMkTTsrSO7pRkRvx2dqGIwZ3Buhc1E+hB2PAnT9SoNrgxhROhP/i+Xz9qvp1pI2rFu/L/yEJ3b3Uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(1800799009)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(356005)(81166007)(82740400003)(8936002)(6666004)(70206006)(110136005)(70586007)(478600001)(7696005)(54906003)(316002)(41300700001)(40460700003)(16526019)(36756003)(26005)(44832011)(8676002)(1076003)(5660300002)(83380400001)(2906002)(2616005)(47076005)(86362001)(40480700001)(36860700001)(336012)(426003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 17:33:40.8211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bf8b95-dd42-406e-7057-08dba8b615fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4887
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
process_param() call and set the data type of the signature appropriately.

Fixes: 15f8aa7bb3e5 ("crypto: ccp - Add unit tests for dynamic boost control")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 tools/crypto/ccp/test_dbc.py | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/crypto/ccp/test_dbc.py b/tools/crypto/ccp/test_dbc.py
index a28a1f94c1d2..79de3638a01a 100755
--- a/tools/crypto/ccp/test_dbc.py
+++ b/tools/crypto/ccp/test_dbc.py
@@ -33,8 +33,8 @@ def system_is_secured() -> bool:
 class DynamicBoostControlTest(unittest.TestCase):
     def __init__(self, data) -> None:
         self.d = None
-        self.signature = "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"
-        self.uid = "1111111111111111"
+        self.signature = b"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"
+        self.uid = b"1111111111111111"
         super().__init__(data)
 
     def setUp(self) -> None:
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

