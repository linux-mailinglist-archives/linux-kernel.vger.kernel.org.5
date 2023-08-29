Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E146F78CB5B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbjH2ReX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237826AbjH2Rdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:33:46 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A91FD;
        Tue, 29 Aug 2023 10:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOqxKVLLm9/WJ89D66rMIQOFBlRW+b9uOrXGU0ESAkh0Pb09rpKyWmtZVjzNbD3utZcKdya7JDwZRZhZgzni9frfrKjGp3J/W5ez5pHT4yvMx92Wmj5HoLsBxByRQdeHAokxnOf9g+kPALvPU1YJ+ETkKvJp4qSkcX9LlBZ3LfAeMBGSgQnF8SAsZoDWZSve9g5H38Hzv2C/CLQe436wP6kATER4Ez4FSvQ+lzzdNsOEcIbt7JCjKH/cXFrcM7sbmCqXhow0fxRe6nTOssmZ3YuCmKiT3fdfBX3G4gzOKymaBdR3vGpLfaqgyLQ51QfpitwnGeAheclESwB7XtH0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YI8lHO+7BvVObYlNycuuR5Y81uIHEpIvq8tgjj5vwLo=;
 b=gaLOCqf4EepmM5HcxkF/b73fIh4YcXv0DyQE57tCC443DdreedoH4SjFw/0DRF3qcvyBXZ2DzQ8Dvf95iQPQVeUEZIkTS67d080Z4TJRwwJ/jf8eDYI8h3M3srj9MMJzha0bB04CL6YXVvTNMmMRsTrFqWsix1yTpBbArt98/G8XVYA02nUbImPZ0sa8r6L5PLwm3hEcMiamQdG5bsW58vbR3Nn1t++LW0sKs1Zpm8yTVXnrXeurvVk22EVFD80V0aS8yd8kmS+ToJxPTqZLVjnE75oRrGL8m9nLaEInyCEK1EZsLugTaAqpJ/Hb1zUfXQWc5tftS8yoR+dQPwQM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YI8lHO+7BvVObYlNycuuR5Y81uIHEpIvq8tgjj5vwLo=;
 b=FXlfwCcw2+kc+l9/sttm8KRGM4La1CWuDRwstA6GxfHExK19BcXAMIO+zI54uXbJrcVIDKZgWIYJRGoQGAvjxMQ1uZZNVqEJ7T3bhOsF4RBU5n0G404Ach2zGjakLhMPUWJZQsgTW9eqga3F1iEeFdqssaOcvsOhiCkqUSHpYbA=
Received: from CY5PR22CA0040.namprd22.prod.outlook.com (2603:10b6:930:1d::16)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 17:33:40 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:1d:cafe::c7) by CY5PR22CA0040.outlook.office365.com
 (2603:10b6:930:1d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Tue, 29 Aug 2023 17:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 17:33:39 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 12:33:35 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <thomas.lendacky@amd.com>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v3 3/5] crypto: ccp: Fix DBC sample application error handling
Date:   Tue, 29 Aug 2023 10:07:57 -0500
Message-ID: <20230829150759.156126-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a763936-a0fe-417a-a8ec-08dba8b61508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RlGAX3whTr0ip1EwcBAJhNXqFE8Ddrqkbc8U6O1UEXCxzX0MkEXdUiDPqtsjeUviFvbpzkDKIl/Xxmh17GAVH0LDyl9LYrEskKp2awTWa2lFII6Vsu2rZIqmt3U67NfYYYvjvAQK4Ko+OkjD0cFr2Bx6N1fM2ZwCETfZdTdfYkGpG5aBJzY3QOTqP5E70URHR5Lvpa0YtLTGHPHwTjxHxwHvO2oT1o88cAkynudip6EhmE76I7SzzoyB2XFcD3asTvjfdjT90rph+jZFnMu19ghKtETcNS22mSlgp9O9lEQDqXCaNfn1l+YbT3mtR9PDRh5NNqth0nagr9H/3BV97qpLGSnupalTWpu7c+PT1ewFF4eH2os4wU6OIAgqwMic94JxDHrZs9AoI+VAEUKOjMrq0Zd0f1gdivr/sdvtvTDTO07ueFQ57AKURU5H/sNgIsItLllJDNEikLjrsVcdxuYekb8m5hgo9z3TdQZKKslqfV4CxlZl5HPg+FC9AtQJaoPsDRZ/49cKL2xSZ0xBg5dhujuVd/9o9lxCm+eJT/srpTliv8mIuvb5QPSASHM+JrdF9H6mDC0VK1Njdcx7MgKmPZOtJ94wyzrEnpQNXUQrwcbLE4ONGkUFjhJ/Lq0osPH6mxQn4Cqj/Vm5oOCbe5fz6GoPrdWfiDMtQqYBB6Dj+sT83hx2tpRol74do07XeXUTzUcNWBB7NUe4Zpxvyv0n4ya+lpy1nyIkGorzx9XsuJR30IqA8iIoL9q6IPcvIl+XAsDLVD+oRNsLFo7IpFNToBvzuqCfr8kPfN9ttLg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(186009)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(41300700001)(336012)(2616005)(82740400003)(81166007)(6666004)(86362001)(47076005)(83380400001)(478600001)(356005)(16526019)(1076003)(26005)(36860700001)(7696005)(426003)(40480700001)(70586007)(70206006)(54906003)(36756003)(110136005)(316002)(2906002)(5660300002)(4326008)(8676002)(8936002)(44832011)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 17:33:39.2366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a763936-a0fe-417a-a8ec-08dba8b61508
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508
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

