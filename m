Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0DC797C49
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344411AbjIGSuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344372AbjIGStr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:49:47 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11967E6B;
        Thu,  7 Sep 2023 11:49:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvGWJkUqJrT8ZnTsDcWizXVSH837owP4NZFROSizb/X0FPVVtGGt2WQSoakHA23IkRJDoIHPbgWdYhOLj/YiBXY9r8mkih7UH/oVWNuxGH3K8bxTiofvgaRlLvYpMfrOUcY/uT/arhuWZiWtppUYskFc3AFIOeBbLKfTj4cwGJaowjumSYNLdVBzfUMuWR5vvZPfuwiQgOSpwNcg7khCdBTIt90tAUBhclng8dRc176ZMNGb8Cm4mv5B0pY4iCKz5XLF0yW4fIb0gG94+A+uXCKyXzU0fX557HJJqEG3TZ8+NpefAXbmnHnu1jfpdt76/Fdqsv2es3LnsW6JpMHR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UP1pTXemuyVGairiicLP5kB3uzt703PKsAd2t4+44Qc=;
 b=HjCKoXuCKLlbNaHWmy1q61CVMQFazkvAnBT5C55WElo4aZBBTY3My6T5Y/4FCO+nhuXpG3IU148ilCUTeLFlsaBV2Ha6/YCXUfgYOICiVybl68KU1fjglQPvRon4yUd7PoGpZt8U1Cy0uf1UsvdzTeY+VO3tciud/tH1ffV4bssWgy68mgSSxqWg5NHh2pk5JYZNl5S9mM/y1/WsuDV++eG57vUTFzhyWC2sgFn7n8bRAEkW9PWkK0xvcOkyDNN71AGC6opehnNNuZFAUxtHB2RUvH7nKrPPrW5HmisRCA0u2D2xwstuV71nAsmvCRksNdjDXNIz5qqMEu3F5cUaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UP1pTXemuyVGairiicLP5kB3uzt703PKsAd2t4+44Qc=;
 b=rS0pu3BcLse/DJtOMwxf9ThEOEER6G2Vs/Pw74ROgVRKoYij5bvaIRrfuWmGWdKEDlqI0CIoTO+AKoT4MOh7DKVM7uGAEWu7XYcwNcEhQpzk25W/GrulkrnBXiF8KipeUQ0Cch0HOjfzL9uMokxkei+76C3Nn8bETObz24vDnPw=
Received: from CH2PR12CA0005.namprd12.prod.outlook.com (2603:10b6:610:57::15)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Thu, 7 Sep
 2023 18:49:32 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::68) by CH2PR12CA0005.outlook.office365.com
 (2603:10b6:610:57::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 18:49:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 18:49:31 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 13:49:28 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <thomas.lendacky@amd.com>, <john.allen@amd.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Rijo-john.Thomas@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 5/5] crypto: ccp: Add support for DBC over PSP mailbox
Date:   Thu, 7 Sep 2023 13:48:46 -0500
Message-ID: <20230907184846.47598-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907184846.47598-1-mario.limonciello@amd.com>
References: <20230907184846.47598-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: 818f923a-b8ed-4ff4-6e23-08dbafd32c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6OZOc1luKidcPZ2nlbqlfa4QYGQBDGb/Ey33/L3B04b+cemvn7DmZYZIoP4ekmOwX/o0qir177JFzk40iVNbPDBOaEI1tsXvlCTUwbyDJqy7L1F+CBa2tANaJ76ijOL6mi0xC/9y/jH8/WMcvi9LBSCMS304eWB+zT2PdYk4UA/vjU0K4xwXvjmcRczSdFVG9AHgqjJH/RUIgvOLU3cafrgVKcSEMLi4UlHRLO3BoehgKFUyNtllf2yuNou2k3RBNz1f2OUZ7rpW5gDDRIKBAmSiXlfL9E4RU8rUDN6CgW4oMw3WZLPojIPJ0Kq+CfnrJlEzYWUSb3ZiCojVaOafgUEPl2aTbJev7HGrsxNJkqj/XMGyBy37E4jAOLgtdiwcA6j7sO46CSfNfi5pE6qIYNWdpK+iBgjWpKRCkt0YMAt6VzzMvR+QK8NfdJJ7ZS0K7Z4pGNJzzL2IZ0JM8eu6dOtgkJWfIIw31M4FVZwC02ARhurnzVAHij1q8OV8CF6ccGzHbqHuVPQcWiN0q7sqbovWvBBDu3asC88agNeygWsPX19mBnm9Ek74s4CroHdkwbN77TeTdlo1C+C7MWSOon6u4TAKS93IUjIAvbnXbXXahOrIDzsoJbXtw+/wyG0eISH14mM33uvxcUj/fdX76neNZFu3GTR5BwOoMoGJC00u/WLc91tvsFxp8e1IDy7oHgFyanLo6YaV3uz+6P5NvSbv9r6hhw/Qt7Lk8ygCuQ26vTQCaxjfHTI5XRQsg7fit4txrE3sPZrt/0yXDphWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(186009)(1800799009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(41300700001)(356005)(478600001)(6666004)(82740400003)(336012)(81166007)(26005)(86362001)(2616005)(83380400001)(1076003)(40460700003)(7696005)(47076005)(15650500001)(36860700001)(40480700001)(16526019)(426003)(70206006)(54906003)(2906002)(316002)(110136005)(70586007)(36756003)(8676002)(5660300002)(8936002)(4326008)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 18:49:31.3986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 818f923a-b8ed-4ff4-6e23-08dbafd32c08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some SOCs DBC is supported through the PSP mailbox instead of
the platform mailbox. This capability is advertised in the PSP
capabilities register. Allow using this communication path if
supported.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/dbc.c     | 43 +++++++++++++++++++++++++++---------
 drivers/crypto/ccp/dbc.h     |  2 ++
 drivers/crypto/ccp/psp-dev.c | 32 +++++++++++----------------
 drivers/crypto/ccp/psp-dev.h | 16 ++++++++++++++
 4 files changed, 64 insertions(+), 29 deletions(-)

diff --git a/drivers/crypto/ccp/dbc.c b/drivers/crypto/ccp/dbc.c
index ebd7279d4001..d373caab52f8 100644
--- a/drivers/crypto/ccp/dbc.c
+++ b/drivers/crypto/ccp/dbc.c
@@ -9,6 +9,7 @@
 
 #include "dbc.h"
 
+#define DBC_DEFAULT_TIMEOUT		(10 * MSEC_PER_SEC)
 struct error_map {
 	u32 psp;
 	int ret;
@@ -37,13 +38,28 @@ static struct error_map error_codes[] = {
 	{0x0,	0x0},
 };
 
-static int send_dbc_cmd(struct psp_dbc_device *dbc_dev,
-			enum psp_platform_access_msg msg)
+static inline int send_dbc_cmd_thru_ext(struct psp_dbc_device *dbc_dev, int msg)
+{
+	dbc_dev->mbox->ext_req.header.sub_cmd_id = msg;
+
+	return psp_extended_mailbox_cmd(dbc_dev->psp,
+					DBC_DEFAULT_TIMEOUT,
+					(struct psp_ext_request *)dbc_dev->mbox);
+}
+
+static inline int send_dbc_cmd_thru_pa(struct psp_dbc_device *dbc_dev, int msg)
+{
+	return psp_send_platform_access_msg(msg,
+					    (struct psp_request *)dbc_dev->mbox);
+}
+
+static int send_dbc_cmd(struct psp_dbc_device *dbc_dev, int msg)
 {
 	int ret;
 
 	*dbc_dev->result = 0;
-	ret = psp_send_platform_access_msg(msg, (struct psp_request *)dbc_dev->mbox);
+	ret = dbc_dev->use_ext ? send_dbc_cmd_thru_ext(dbc_dev, msg) :
+				 send_dbc_cmd_thru_pa(dbc_dev, msg);
 	if (ret == -EIO) {
 		int i;
 
@@ -192,9 +208,6 @@ int dbc_dev_init(struct psp_device *psp)
 	struct psp_dbc_device *dbc_dev;
 	int ret;
 
-	if (!PSP_FEATURE(psp, DBC))
-		return 0;
-
 	dbc_dev = devm_kzalloc(dev, sizeof(*dbc_dev), GFP_KERNEL);
 	if (!dbc_dev)
 		return -ENOMEM;
@@ -208,10 +221,20 @@ int dbc_dev_init(struct psp_device *psp)
 
 	psp->dbc_data = dbc_dev;
 	dbc_dev->dev = dev;
-	dbc_dev->payload_size = &dbc_dev->mbox->pa_req.header.payload_size;
-	dbc_dev->result = &dbc_dev->mbox->pa_req.header.status;
-	dbc_dev->payload = &dbc_dev->mbox->pa_req.buf;
-	dbc_dev->header_size = sizeof(struct psp_req_buffer_hdr);
+	dbc_dev->psp = psp;
+
+	if (PSP_CAPABILITY(psp, DBC_THRU_EXT)) {
+		dbc_dev->use_ext = true;
+		dbc_dev->payload_size = &dbc_dev->mbox->ext_req.header.payload_size;
+		dbc_dev->result = &dbc_dev->mbox->ext_req.header.status;
+		dbc_dev->payload = &dbc_dev->mbox->ext_req.buf;
+		dbc_dev->header_size = sizeof(struct psp_ext_req_buffer_hdr);
+	} else {
+		dbc_dev->payload_size = &dbc_dev->mbox->pa_req.header.payload_size;
+		dbc_dev->result = &dbc_dev->mbox->pa_req.header.status;
+		dbc_dev->payload = &dbc_dev->mbox->pa_req.buf;
+		dbc_dev->header_size = sizeof(struct psp_req_buffer_hdr);
+	}
 
 	ret = send_dbc_nonce(dbc_dev);
 	if (ret == -EACCES) {
diff --git a/drivers/crypto/ccp/dbc.h b/drivers/crypto/ccp/dbc.h
index 184646ee55bb..e0fecbe92eb1 100644
--- a/drivers/crypto/ccp/dbc.h
+++ b/drivers/crypto/ccp/dbc.h
@@ -20,6 +20,7 @@
 
 struct psp_dbc_device {
 	struct device *dev;
+	struct psp_device *psp;
 
 	union dbc_buffer *mbox;
 
@@ -37,6 +38,7 @@ struct psp_dbc_device {
 
 union dbc_buffer {
 	struct psp_request		pa_req;
+	struct psp_ext_request		ext_req;
 };
 
 void dbc_dev_destroy(struct psp_device *psp);
diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index 5f61b23695d5..124a2e0c8999 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -187,23 +187,6 @@ static int psp_check_tee_support(struct psp_device *psp)
 	return 0;
 }
 
-static void psp_init_platform_access(struct psp_device *psp)
-{
-	int ret;
-
-	ret = platform_access_dev_init(psp);
-	if (ret) {
-		dev_warn(psp->dev, "platform access init failed: %d\n", ret);
-		return;
-	}
-
-	/* dbc must come after platform access as it tests the feature */
-	ret = dbc_dev_init(psp);
-	if (ret)
-		dev_warn(psp->dev, "failed to init dynamic boost control: %d\n",
-			 ret);
-}
-
 static int psp_init(struct psp_device *psp)
 {
 	int ret;
@@ -220,8 +203,19 @@ static int psp_init(struct psp_device *psp)
 			return ret;
 	}
 
-	if (psp->vdata->platform_access)
-		psp_init_platform_access(psp);
+	if (psp->vdata->platform_access) {
+		ret = platform_access_dev_init(psp);
+		if (ret)
+			return ret;
+	}
+
+	/* dbc must come after platform access as it tests the feature */
+	if (PSP_FEATURE(psp, DBC) ||
+	    PSP_CAPABILITY(psp, DBC_THRU_EXT)) {
+		ret = dbc_dev_init(psp);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
diff --git a/drivers/crypto/ccp/psp-dev.h b/drivers/crypto/ccp/psp-dev.h
index 396a80d846c0..ae582ba63729 100644
--- a/drivers/crypto/ccp/psp-dev.h
+++ b/drivers/crypto/ccp/psp-dev.h
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
 #include <linux/psp.h>
+#include <linux/psp-platform-access.h>
 
 #include "sp-dev.h"
 
@@ -56,6 +57,7 @@ struct psp_device *psp_get_master_device(void);
 
 #define PSP_CAPABILITY_SEV			BIT(0)
 #define PSP_CAPABILITY_TEE			BIT(1)
+#define PSP_CAPABILITY_DBC_THRU_EXT		BIT(2)
 #define PSP_CAPABILITY_PSP_SECURITY_REPORTING	BIT(7)
 
 #define PSP_CAPABILITY_PSP_SECURITY_OFFSET	8
@@ -108,6 +110,20 @@ struct psp_ext_request {
 	void *buf;
 } __packed;
 
+/**
+ * enum psp_sub_cmd - PSP mailbox sub commands
+ * @PSP_SUB_CMD_DBC_GET_NONCE:		Get nonce from DBC
+ * @PSP_SUB_CMD_DBC_SET_UID:		Set UID for DBC
+ * @PSP_SUB_CMD_DBC_GET_PARAMETER:	Get parameter from DBC
+ * @PSP_SUB_CMD_DBC_SET_PARAMETER:	Set parameter for DBC
+ */
+enum psp_sub_cmd {
+	PSP_SUB_CMD_DBC_GET_NONCE	= PSP_DYNAMIC_BOOST_GET_NONCE,
+	PSP_SUB_CMD_DBC_SET_UID		= PSP_DYNAMIC_BOOST_SET_UID,
+	PSP_SUB_CMD_DBC_GET_PARAMETER	= PSP_DYNAMIC_BOOST_GET_PARAMETER,
+	PSP_SUB_CMD_DBC_SET_PARAMETER	= PSP_DYNAMIC_BOOST_SET_PARAMETER,
+};
+
 int psp_extended_mailbox_cmd(struct psp_device *psp, unsigned int timeout_msecs,
 			     struct psp_ext_request *req);
 #endif /* __PSP_DEV_H */
-- 
2.34.1

