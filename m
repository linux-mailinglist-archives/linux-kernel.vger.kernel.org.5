Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C73797C44
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344333AbjIGStr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344322AbjIGSth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:49:37 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CFCA8;
        Thu,  7 Sep 2023 11:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJbVfnUJ8szoEwwxXYhecxR4jN1ZrGVw1DdWtIWwhi9lStzWq9oIcAzcEEYiDPsY/XS17J079O8mHD8l+opsZJbSR/PhsrJk/dmxLaOnc4cc2PmT3ze/dhw608lXEnhC033xIGU8oOLn4CyDO1GP6TqCV83ArPCD52cBIzr2RJ7k4pFbT8gBufaHxssdh7xjL96lHwMtCfmV+WBeCd5b+5sOCS7/1R4Pu47DjfZ0f+Kx5RSJ1YxMs/xO3po1UIZu+MAZ9N89hOGIP00vsQgZyp6ddk1mz3Tl8MTYzPxGfxxOijQxeDcyFwuGkr1dlyOUefS/Oq+OmE8VVYb5C1hn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2IQE27SmdlUxxU+s78EsdDT5y+56ChsQ7AYlGt0Jao=;
 b=UFOMba9tcJIeOKVgkeJHjbwpH5BKfX/0/srD01Ajy3ZcxJxL892CWP91c14Sl3VY8DuMMhyuvpLL20+bbhSbk8l7aZPKHgSeq/DgQUkN9yzBZPFfRfx5/mjWgRqPwyeqHDePab0HrlRQKCUoR0Ibt51FAUrFaCYT+w0HUu2W54ZpEy7FjoeuiPs1QhOlb4hbWFGw7fjUBIrk3w0yfHxbcp6C+A93zkA+XL5xkQj0mAGwZsVRPTVTZx9hYMs7l5UR0Zm0xRfxf8IR7vEmCu2Ddc1YSUag1/nrKNoSd/5Hr07H977m7ZMHn2gAhi4IA7Z8kgFJgLdQJGHc2nubT3RqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2IQE27SmdlUxxU+s78EsdDT5y+56ChsQ7AYlGt0Jao=;
 b=IycHoL5Gaq34cdKO5xsL1cZtoldQfsRiVhfXoVw8JY+5KNYLrj4/mx+l8yUctt6YZ5/bvwBT8DuHE8mA40WvC+JG9nQLtidWGA0LCXLe4gjhZAHkhsriMAy/agHsQOSzQI8jjaFCF9E7wEfNo8vWamTUMX4UXsiBzt59at3Wc9s=
Received: from CH2PR12CA0017.namprd12.prod.outlook.com (2603:10b6:610:57::27)
 by CY8PR12MB7100.namprd12.prod.outlook.com (2603:10b6:930:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 18:49:30 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::8a) by CH2PR12CA0017.outlook.office365.com
 (2603:10b6:610:57::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 18:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 18:49:29 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 13:49:27 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <thomas.lendacky@amd.com>, <john.allen@amd.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Rijo-john.Thomas@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/5] crypto: ccp: Add a communication path abstraction for DBC
Date:   Thu, 7 Sep 2023 13:48:44 -0500
Message-ID: <20230907184846.47598-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|CY8PR12MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 489059d0-98cf-4002-c71d-08dbafd32b1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBhQi5c4VK+LV+fCthf51tVLSnwPFiAkj2/qoB4PLgC/EQmfxinhlgWJoxVQ+3Nl9I9IZS1pcaeOp81V3+aD4EHGpZDSzYaAB0oU9NnnrTGjVb78ORh1mZkylmhH4Y9IFuSEL7SzihW96ImQITiIoxKQasvxu/U/L1e2MHUa9T6IgElTEB0MxolZoQkAi9mERUY0n85kEXwg0V6GpKI4+i/BEWX1UA5mD6fVNw8UmXDv1EynWOFxAGS/kvlhxd3Hmb5bKpGa3IlLJZwCXkB7D+td1zk6Jv7SHqo8A/cUoH7t0HifOlnDm6hfgL/SX9ZLH0a1+BN6xKrEbClqVD+GMj7knM5tTvGN2U0RN5V+BcjaKaomWmmlsvu4GAIOoVKGNzGcQnX6E5uurxZTx3OY1nJ6NE34A1HH7z/5YYVPkR7jDg2AokkZjuLw/oJwEJ+73V5gSqnedChUCaNNZz14wVbkyR7igyFUctBrG6J2SSMUnTcVmGsjXbvJuybyqY/myEKdLimFVRebucj+DGOlPHOQp6+ECUkt8OXcOgOP9zzoxg6umV5U6YR85nt24hfRbXuB69BeHgvjDAytB6cdFgFXjbAXJZ8cuisgtM1Rs6pq5ry4TS8/i/BY+MNwoJ30tHrJZ4Aqqk0pvnro8jk9pH6O73NnCdsRlp0SQKP5kSeMnQK2aLqt8rBrJDw83lkjJTbN5Yp3BJVAUzYvLUWzMTvPWWAqPvJH+HDaEMT9pf2/pPc8t6w99vURUZOAa8gdVyGoEdDvMWjqzN4WaDQoSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(83380400001)(1076003)(16526019)(26005)(6666004)(44832011)(5660300002)(2616005)(426003)(4326008)(336012)(47076005)(36860700001)(86362001)(8936002)(40480700001)(40460700003)(8676002)(7696005)(41300700001)(81166007)(478600001)(82740400003)(70586007)(36756003)(54906003)(356005)(110136005)(316002)(2906002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 18:49:29.8673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 489059d0-98cf-4002-c71d-08dbafd32b1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7100
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DBC is currently accessed only from the platform access mailbox and
a lot of that implementation's communication path is intertwined
with DBC. Add an abstraction layer for pointers into the mailbox.

No intended functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/dbc.c | 37 ++++++++++++++++++-------------------
 drivers/crypto/ccp/dbc.h | 27 ++++++++-------------------
 2 files changed, 26 insertions(+), 38 deletions(-)

diff --git a/drivers/crypto/ccp/dbc.c b/drivers/crypto/ccp/dbc.c
index 6f33149ef80d..ebd7279d4001 100644
--- a/drivers/crypto/ccp/dbc.c
+++ b/drivers/crypto/ccp/dbc.c
@@ -42,17 +42,17 @@ static int send_dbc_cmd(struct psp_dbc_device *dbc_dev,
 {
 	int ret;
 
-	dbc_dev->mbox->req.header.status = 0;
+	*dbc_dev->result = 0;
 	ret = psp_send_platform_access_msg(msg, (struct psp_request *)dbc_dev->mbox);
 	if (ret == -EIO) {
 		int i;
 
 		dev_dbg(dbc_dev->dev,
 			 "msg 0x%x failed with PSP error: 0x%x\n",
-			 msg, dbc_dev->mbox->req.header.status);
+			 msg, *dbc_dev->result);
 
 		for (i = 0; error_codes[i].psp; i++) {
-			if (dbc_dev->mbox->req.header.status == error_codes[i].psp)
+			if (*dbc_dev->result == error_codes[i].psp)
 				return error_codes[i].ret;
 		}
 	}
@@ -64,7 +64,7 @@ static int send_dbc_nonce(struct psp_dbc_device *dbc_dev)
 {
 	int ret;
 
-	dbc_dev->mbox->req.header.payload_size = sizeof(dbc_dev->mbox->dbc_nonce);
+	*dbc_dev->payload_size = dbc_dev->header_size + sizeof(struct dbc_user_nonce);
 	ret = send_dbc_cmd(dbc_dev, PSP_DYNAMIC_BOOST_GET_NONCE);
 	if (ret == -EAGAIN) {
 		dev_dbg(dbc_dev->dev, "retrying get nonce\n");
@@ -76,9 +76,9 @@ static int send_dbc_nonce(struct psp_dbc_device *dbc_dev)
 
 static int send_dbc_parameter(struct psp_dbc_device *dbc_dev)
 {
-	dbc_dev->mbox->req.header.payload_size = sizeof(dbc_dev->mbox->dbc_param);
+	struct dbc_user_param *user_param = (struct dbc_user_param *)dbc_dev->payload;
 
-	switch (dbc_dev->mbox->dbc_param.user.msg_index) {
+	switch (user_param->msg_index) {
 	case PARAM_SET_FMAX_CAP:
 	case PARAM_SET_PWR_CAP:
 	case PARAM_SET_GFX_MODE:
@@ -125,8 +125,7 @@ static long dbc_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	switch (cmd) {
 	case DBCIOCNONCE:
-		if (copy_from_user(&dbc_dev->mbox->dbc_nonce.user, argp,
-				   sizeof(struct dbc_user_nonce))) {
+		if (copy_from_user(dbc_dev->payload, argp, sizeof(struct dbc_user_nonce))) {
 			ret = -EFAULT;
 			goto unlock;
 		}
@@ -135,43 +134,39 @@ static long dbc_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (ret)
 			goto unlock;
 
-		if (copy_to_user(argp, &dbc_dev->mbox->dbc_nonce.user,
-				 sizeof(struct dbc_user_nonce))) {
+		if (copy_to_user(argp, dbc_dev->payload, sizeof(struct dbc_user_nonce))) {
 			ret = -EFAULT;
 			goto unlock;
 		}
 		break;
 	case DBCIOCUID:
-		dbc_dev->mbox->req.header.payload_size = sizeof(dbc_dev->mbox->dbc_set_uid);
-		if (copy_from_user(&dbc_dev->mbox->dbc_set_uid.user, argp,
-				   sizeof(struct dbc_user_setuid))) {
+		if (copy_from_user(dbc_dev->payload, argp, sizeof(struct dbc_user_setuid))) {
 			ret = -EFAULT;
 			goto unlock;
 		}
 
+		*dbc_dev->payload_size = dbc_dev->header_size + sizeof(struct dbc_user_setuid);
 		ret = send_dbc_cmd(dbc_dev, PSP_DYNAMIC_BOOST_SET_UID);
 		if (ret)
 			goto unlock;
 
-		if (copy_to_user(argp, &dbc_dev->mbox->dbc_set_uid.user,
-				 sizeof(struct dbc_user_setuid))) {
+		if (copy_to_user(argp, dbc_dev->payload, sizeof(struct dbc_user_setuid))) {
 			ret = -EFAULT;
 			goto unlock;
 		}
 		break;
 	case DBCIOCPARAM:
-		if (copy_from_user(&dbc_dev->mbox->dbc_param.user, argp,
-				   sizeof(struct dbc_user_param))) {
+		if (copy_from_user(dbc_dev->payload, argp, sizeof(struct dbc_user_param))) {
 			ret = -EFAULT;
 			goto unlock;
 		}
 
+		*dbc_dev->payload_size = dbc_dev->header_size + sizeof(struct dbc_user_param);
 		ret = send_dbc_parameter(dbc_dev);
 		if (ret)
 			goto unlock;
 
-		if (copy_to_user(argp, &dbc_dev->mbox->dbc_param.user,
-				 sizeof(struct dbc_user_param)))  {
+		if (copy_to_user(argp, dbc_dev->payload, sizeof(struct dbc_user_param)))  {
 			ret = -EFAULT;
 			goto unlock;
 		}
@@ -213,6 +208,10 @@ int dbc_dev_init(struct psp_device *psp)
 
 	psp->dbc_data = dbc_dev;
 	dbc_dev->dev = dev;
+	dbc_dev->payload_size = &dbc_dev->mbox->pa_req.header.payload_size;
+	dbc_dev->result = &dbc_dev->mbox->pa_req.header.status;
+	dbc_dev->payload = &dbc_dev->mbox->pa_req.buf;
+	dbc_dev->header_size = sizeof(struct psp_req_buffer_hdr);
 
 	ret = send_dbc_nonce(dbc_dev);
 	if (ret == -EACCES) {
diff --git a/drivers/crypto/ccp/dbc.h b/drivers/crypto/ccp/dbc.h
index e963099ca38e..184646ee55bb 100644
--- a/drivers/crypto/ccp/dbc.h
+++ b/drivers/crypto/ccp/dbc.h
@@ -26,28 +26,17 @@ struct psp_dbc_device {
 	struct mutex ioctl_mutex;
 
 	struct miscdevice char_dev;
-};
-
-struct dbc_nonce {
-	struct psp_req_buffer_hdr	header;
-	struct dbc_user_nonce		user;
-} __packed;
 
-struct dbc_set_uid {
-	struct psp_req_buffer_hdr	header;
-	struct dbc_user_setuid		user;
-} __packed;
-
-struct dbc_param {
-	struct psp_req_buffer_hdr	header;
-	struct dbc_user_param		user;
-} __packed;
+	/* used to abstract communication path */
+	bool	use_ext;
+	u32	header_size;
+	u32	*payload_size;
+	u32	*result;
+	void	*payload;
+};
 
 union dbc_buffer {
-	struct psp_request		req;
-	struct dbc_nonce		dbc_nonce;
-	struct dbc_set_uid		dbc_set_uid;
-	struct dbc_param		dbc_param;
+	struct psp_request		pa_req;
 };
 
 void dbc_dev_destroy(struct psp_device *psp);
-- 
2.34.1

