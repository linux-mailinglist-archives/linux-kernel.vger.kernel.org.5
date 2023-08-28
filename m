Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37F878B7C1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjH1TDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbjH1TCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:02:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E00FC;
        Mon, 28 Aug 2023 12:02:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qcl98gN2QQSX5nX9VNWbUxtbnZqYFKzfWBTRUlCbx9VSll9LPbLngJ3Zja53zef1leAT46Yn+fz3aPdvUDrm6cXsNGfYa93n3DzJy5qPASvY3CFHiHQESTWnuAbM2Ao9uHZtduXclGsVIi1ZNiS4z7R1qOHt1PUnKFZf2bJEsv2tjy/CXSLxPiZmBEZ2zOpIeB/Utdswi5WtuBXU54jf+/499Uz6gB/ggnARXbPTl6GnJQRcHTpaWIq7xaOtjqkGwUqZy5XjKU+3nOQyLwCGEC62m7mrVGQpPbKef70wbb0kWQq3p+zgSbMyOQ4vXYMPag8gVSkHFwOO+FrXavhg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YI8lHO+7BvVObYlNycuuR5Y81uIHEpIvq8tgjj5vwLo=;
 b=Mb3La7iL5QLq6wniYptA8+61MgxQDmJJuYet2FUBa5AmAStV99F0F5AycYWrRnlZit69PzT8hddMK3JJPu0Fj2ckxljPddfI/ppkz5SMMBaGsW/4uAVs9GflxKGL7Q0QO2BRLIhnfZGX16GeTXPqSrUjSbqKVp99AbcNWuKlJ+yM+/viHpY1Hm+iuxRUQHhTmThU4HMATMQmt3xk39GFOlQ+mH6bB8o0TidbWQ8BzVp05Y+rteQXuWdRRE5wQuDhH1hk4QWjReTDFNeBIxdwHLW/Vy9gGguwXCsqQKstLvgh7cHjOC67AHVR0R1FRL4sD/c4f1ze7S6ZqB5F/X5hvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YI8lHO+7BvVObYlNycuuR5Y81uIHEpIvq8tgjj5vwLo=;
 b=tx1wmx+4wPbf8a6yBSQIxBJVOqYYsD97hDysNQn6Vi0eJdVdbOU+1kwVRI3UG0RXUiSko9wN8ydMLZ162eRBPgM28r9HwRzRJ3XZOrUpZzVJj6iGL/fL7fqUgBpcLmFA2lNWp9F0QkmeGvw06EF+Y8DrhWJgfK78wrYFPZ84hZo=
Received: from CY8PR10CA0039.namprd10.prod.outlook.com (2603:10b6:930:4b::26)
 by CH3PR12MB8259.namprd12.prod.outlook.com (2603:10b6:610:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 19:02:35 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:4b:cafe::82) by CY8PR10CA0039.outlook.office365.com
 (2603:10b6:930:4b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Mon, 28 Aug 2023 19:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 19:02:35 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 14:02:33 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <thomas.lendacky@amd.com>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 1/3] crypto: ccp: Fix DBC sample application error handling
Date:   Mon, 28 Aug 2023 14:01:58 -0500
Message-ID: <20230828190200.1598-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CH3PR12MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3e054f-d5a2-4de2-4d1b-08dba7f95725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqFzYM/KBevENe99YqOBbGd8Un+NY8+VFdFtkiItHGoN1vsUEAf+ej9YLdzELpIE4jmZ6lJB9+VwsZype+i2Ab5STPAzm+p5oSVkWLbsSV/FzDr02JO58/S5L9WjoNCkrK4qLngTaewEEusrIqhZYZ1I9dqwmWS78zE+fl0KZi6/95LZDn+QOk2OtyEziDlpprV/2zhIFRz5wTkGO5koiVQmU7nz6j8ZmMqZZ9gB+Et3BIjZMvSRHPTDJJI/ViBqRXsMiNQKkkiqDipBu8OwL8V4hTX1Q66s4LqtAuVfO8QPQDayfCbhCSBMIj+WKSB8Cs4b0bkwNt2/nygjami4WgEGPZn18eMv4XMJ34aOJ/EbDmrjSXpuMvSMrcXbDyiMJ2okptcPWT1mGrS6U5IvPqlJA0cuLW2fpB75HYRCS4NxIV4BGjuISPwoS3MpxMe4EfSJntyu/t7+WlItuoBQ825V8c5+1jqbd3equwMYmT5sUxJRDvefrCxSCgZ2IqbbQh6PN+DN1p4eE9K6lw6wZle8kBFRuV3HNZZIO2sfSKacr9j4qepRP0Q2c2vRdALKLaUdxMDNFqPI4D8jvGHEK5sk3zJ1LnOVPNSnqmyonostfH8TMr0hmmCZDn2ks0NMfA/m4NgGNNaQb5VIX3dC19rMTcnqpANKwJK5z3ciKqU+oKQuGUGzSQigkpgGQ9qOKFmGq+o14EXzlqMNnFCt+BHkLXQZ0GAh0DDmim7xBznxwsfbzy39qCi1g8f50oHFYWvS7Q3qgUitiE8U2IRbXBLrO0cJMMhXanM9+17IGlk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(186009)(82310400011)(451199024)(1800799009)(46966006)(40470700004)(36840700001)(40460700003)(41300700001)(356005)(81166007)(82740400003)(6666004)(86362001)(478600001)(47076005)(83380400001)(2616005)(26005)(336012)(16526019)(426003)(1076003)(40480700001)(7696005)(36860700001)(70586007)(70206006)(36756003)(54906003)(110136005)(316002)(2906002)(5660300002)(8676002)(8936002)(4326008)(44832011)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 19:02:35.2721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3e054f-d5a2-4de2-4d1b-08dba7f95725
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8259
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sample application was taking values from ioctl() and treating
those as the error codes to present to a user.

This is incorrect when ret is non-zero, the error is stored to `errno`.
Use this value instead.

Fixes: f40d42f116cf ("crypto: ccp - Add a sample python script for Dynamic Boost Control")
Fixes: febe3ed3222f ("crypto: ccp - Add a sample library for ioctl use")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 tools/crypto/ccp/dbc.c  | 16 ++++++++--------
 tools/crypto/ccp/dbc.py |  3 +--
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/crypto/ccp/dbc.c b/tools/crypto/ccp/dbc.c
index 37e813175642..7774e981849f 100644
--- a/tools/crypto/ccp/dbc.c
+++ b/tools/crypto/ccp/dbc.c
@@ -8,6 +8,7 @@
  */
 
 #include <assert.h>
+#include <errno.h>
 #include <string.h>
 #include <sys/ioctl.h>
 
@@ -22,16 +23,14 @@ int get_nonce(int fd, void *nonce_out, void *signature)
 	struct dbc_user_nonce tmp = {
 		.auth_needed = !!signature,
 	};
-	int ret;
 
 	assert(nonce_out);
 
 	if (signature)
 		memcpy(tmp.signature, signature, sizeof(tmp.signature));
 
-	ret = ioctl(fd, DBCIOCNONCE, &tmp);
-	if (ret)
-		return ret;
+	if (ioctl(fd, DBCIOCNONCE, &tmp))
+		return errno;
 	memcpy(nonce_out, tmp.nonce, sizeof(tmp.nonce));
 
 	return 0;
@@ -47,7 +46,9 @@ int set_uid(int fd, __u8 *uid, __u8 *signature)
 	memcpy(tmp.uid, uid, sizeof(tmp.uid));
 	memcpy(tmp.signature, signature, sizeof(tmp.signature));
 
-	return ioctl(fd, DBCIOCUID, &tmp);
+	if (ioctl(fd, DBCIOCUID, &tmp))
+		return errno;
+	return 0;
 }
 
 int process_param(int fd, int msg_index, __u8 *signature, int *data)
@@ -63,9 +64,8 @@ int process_param(int fd, int msg_index, __u8 *signature, int *data)
 
 	memcpy(tmp.signature, signature, sizeof(tmp.signature));
 
-	ret = ioctl(fd, DBCIOCPARAM, &tmp);
-	if (ret)
-		return ret;
+	if (ioctl(fd, DBCIOCPARAM, &tmp))
+		return errno;
 
 	*data = tmp.param;
 	return 0;
diff --git a/tools/crypto/ccp/dbc.py b/tools/crypto/ccp/dbc.py
index 3f6a825ffc9e..3956efe7537a 100644
--- a/tools/crypto/ccp/dbc.py
+++ b/tools/crypto/ccp/dbc.py
@@ -27,8 +27,7 @@ lib = ctypes.CDLL("./dbc_library.so", mode=ctypes.RTLD_GLOBAL)
 
 
 def handle_error(code):
-    val = code * -1
-    raise OSError(val, os.strerror(val))
+    raise OSError(code, os.strerror(code))
 
 
 def get_nonce(device, signature):
-- 
2.34.1

