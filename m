Return-Path: <linux-kernel+bounces-27032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B3382E968
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6B41C22CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEE3101F7;
	Tue, 16 Jan 2024 06:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="APLA+PRi"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814313AC0;
	Tue, 16 Jan 2024 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2mVWKWeZChwv+6tAtcHT9GEc92pB2XrsEcgBKlGf9fzHRy/banlXdGKth5eVY12JLI+O7hJ0u+8sked982NQ5PbnETWNqmGdEOyhFIUPn/cMVfxdqlTaECiZikOyvjuCYebMRGAJ1v2vbMcxEiXFgeqmhArVDpvBe1sOXok7nDqxk/AVSk/gc7KROBZ0y+E2Q5kB2jegwK+CZ9wQUmX+unFSMnnsS9+vIyWaiHr6siqu1Zk9ZXS7Bi+D4KVyk/wfrFOzEwBshER3c1Eyk9vVJUYs5WnDPdPo6TrfKTOEEkN/pLL6L2aG8A/u35fKvawqjdkX2OVljzUi0CQyL2wEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23qfJyyQElZ/W2BCyaMzcwLb7JV0O1JD8VgDz1zSepk=;
 b=mfwNxSnekOpnixyW/MBP6x4DaCnfZeRsE+1w0BPTmxW4emIKp73mYQeDMv2pSA6WF4k01kJA64/sUtogBXNwh/BhBGHrfl1n75RnwSi3iShYX+SEb2s4S/x72nHDFC14TCqi+/mA3NPxJix1JlkgMmJ/uHcCEfWb6EnHjYBYmiwvVh6VEUTnthLD7WZQCM6cxLDIhEdYOGf++XjwNKwS5QmWEQhUXfRTDp7HpaFrETjqge+wtY1cKdAewr+vIyFeP2P0bVBrmH+QdsGvlxREve3fTz+nAc3T9nzpmG3WDYle8NgZifJx6FiYoJUvZNwrs3aS3Hlb9PKKRw6Y3BNZkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23qfJyyQElZ/W2BCyaMzcwLb7JV0O1JD8VgDz1zSepk=;
 b=APLA+PRi3oSZGEtWvp4xFkuqrdvVUJUmVf7dFFBHwvj/90vWcgQ1hGm1IwH4StFReTrOhEcm74U2cbLfe8qtaHIJwEUiZjrvP9PO6e2WID1Q4g6finSjJLjjq8YSdHdy9YbxqUGeGjxVDzob2ZpK9V6q84eQEroZogzhEHhK/OdxfFssljvPyQD9vCh1xINpQEav2lVp47LTIZwS49oaCIVp1/MT4vvRy45DkyywQ1mep/tIA0SvuuqrDJk51Qujp7bc7VcpoJImMLZa1hHc8r1AbSErIUBzV2sEp47pGznDZCgcYuriAQrQXe0uUOgRHR6rjMDPKzeie5274mmB/g==
Received: from MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14) by
 IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Tue, 16 Jan
 2024 06:04:30 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::3d) by MW2PR16CA0001.outlook.office365.com
 (2603:10b6:907::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Tue, 16 Jan 2024 06:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 06:04:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Jan
 2024 22:04:14 -0800
Received: from e558209-lcelt.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 15 Jan 2024 22:04:12 -0800
From: Haotien Hsu <haotienh@nvidia.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Utkarsh Patel <utkarsh.h.patel@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sing-Han Chen <singhanc@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	Wayne Chang <waynec@nvidia.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, WK Tsai <wtsai@nvidia.com>, Haotien Hsu
	<haotienh@nvidia.com>
Subject: [PATCH v5] ucsi_ccg: Refine the UCSI Interrupt handling
Date: Tue, 16 Jan 2024 14:03:23 +0800
Message-ID: <20240116060323.844959-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|IA1PR12MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: 469c6bbc-4f24-4983-bff9-08dc16590105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7XIA0RxEsQc2+GNPe0DsplQXFi7Xknv0MnxYpouKrhPFRU2GFecRqvrfYOkKL22Gb4OKOlpTU1Aq9KmmQU6mh0sNzdZu0amIq0ObyI8GnfXQQ+naheY8UsuVqc7M2Q1vrB1vlxaFmHlgxY7k7iwAjNtYPY16C37v+f2wrPJK8DU3M6+/KSdOIX+u8JvcChkkUz117FQyrQGqzlxryMrvbwxJn7MtKI7uk2hn8/iEnN9uWlw4v77bDEQEyEUlz4bGNFayOWSpGdMZHzMPHT+Be5DPvZ2YLt4vu4CpKi52HAbxgZBwYDl/o+/6vyYu0nfVrvQuxku+z22+7nx/PfSDg9ml0SfJKd/B1orx+4tiLLdZxCdupKSfJxl6nx365QlKDGwYSC320jN4CkbKCHgoB/1pDn7fCf4IYLdo3y9HeLGR56Eqpjn+wqV9rLZ8jvcTMzZOdJej0uFpS6m2LAaATA4e43qzFfjxxcdP7T0GXdIlSmC9LGLTJbRhpLeThWwOatr4OJWhwFzje0SWr7HcCktFHjiorLHnl9wP4YUr1cUrjnELaAkTrsYhs014eUBr+sj8HkHCiaB+89Obu6VxtrJk6UAIRWdffHumnZcnMWlccKCiGMkLXWXGvvkd24FtUpb54tgByOZNrznGwaSQLM1qqtlTqAWUyixGFsDtF0ee8GKwxH+V686vzgBIbAQi+XOi3w19WBPcb9Pb7m3VgIFZAD4vZds4OCMQMpto9x7CCjRshxn68IikTDNOlO2d
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(2906002)(5660300002)(41300700001)(36756003)(8936002)(110136005)(316002)(54906003)(107886003)(8676002)(426003)(26005)(336012)(2616005)(478600001)(86362001)(7696005)(70586007)(70206006)(1076003)(6666004)(47076005)(16526019)(7636003)(356005)(83380400001)(82740400003)(36860700001)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 06:04:30.4041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 469c6bbc-4f24-4983-bff9-08dc16590105
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029

With the Cypress CCGx Type-C controller the following error is
sometimes observed on boot:
[   16.087147] ucsi_ccg 1-0008: failed to reset PPM!
[   16.087319] ucsi_ccg 1-0008: PPM init failed (-110)

When the above timeout occurs the following happens:
1. The function ucsi_reset_ppm() is called to reset UCSI controller.
   This function performs an async write to start reset and then
   polls for completion.
2. An interrupt occurs when the reset completes. In the interrupt
   handler, the OPM field in the INTR_REG is cleared and this clears
   the CCI data in the PPM. Hence, the reset completion status is
   cleared.
3. The function ucsi_reset_ppm() continues to poll for the reset
   completion, but has missed the reset completion event and
   eventually timeouts.

In this patch, we store CCI when handling the interrupt and make
reading after async write gets the correct value.

To align with the CCGx UCSI interface guide, this patch updates the
driver to copy CCI and MESSAGE_IN before they are reset when UCSI
interrupt acknowledged.

When a new command is sent, the driver will clear the old CCI to avoid
ucsi_ccg_read() getting wrong CCI after ucsi_ccg_async_write() when
the UCSI interrupt is not handled.

Finally, acking the UCSI_READ_INT interrupt before calling complete()
in ISR to ensure that the ucsi_ccg_sync_write() would wait for the
interrupt handling to complete.

---
V1->V2
- Fix uninitialized symbol 'cci'
v2->v3
- Remove misusing Reported-by tags
v3->v4
- Add comments for op_lock
v4->v5
- Specify the endianness of registers in struct op_region
- Replace ccg_op_region_read() with inline codes
- Replace ccg_op_region_clean() with inline codes
- Replace stack memory with GFP_ATOMIC allocated memory in ccg_op_region_update()
- Add comments for resetting CCI in ucsi_ccg_async_write()

Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 92 ++++++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 449c125f6f87..cd92fae485d0 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -192,6 +192,12 @@ struct ucsi_ccg_altmode {
 	bool checked;
 } __packed;
 
+#define CCGX_MESSAGE_IN_MAX 4
+struct op_region {
+	__le32 cci;
+	__le32 message_in[CCGX_MESSAGE_IN_MAX];
+};
+
 struct ucsi_ccg {
 	struct device *dev;
 	struct ucsi *ucsi;
@@ -222,6 +228,13 @@ struct ucsi_ccg {
 	bool has_multiple_dp;
 	struct ucsi_ccg_altmode orig[UCSI_MAX_ALTMODES];
 	struct ucsi_ccg_altmode updated[UCSI_MAX_ALTMODES];
+
+	/*
+	 * This spinlock protects op_data which includes CCI and MESSAGE_IN that
+	 * will be updated in ISR
+	 */
+	spinlock_t op_lock;
+	struct op_region op_data;
 };
 
 static int ccg_read(struct ucsi_ccg *uc, u16 rab, u8 *data, u32 len)
@@ -305,12 +318,42 @@ static int ccg_write(struct ucsi_ccg *uc, u16 rab, const u8 *data, u32 len)
 	return 0;
 }
 
+static int ccg_op_region_update(struct ucsi_ccg *uc, u32 cci)
+{
+	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(UCSI_MESSAGE_IN);
+	struct op_region *data = &uc->op_data;
+	unsigned char *buf;
+	size_t size = sizeof(data->message_in);
+
+	buf = kzalloc(size, GFP_ATOMIC);
+	if (!buf)
+		return -ENOMEM;
+	if (UCSI_CCI_LENGTH(cci)) {
+		int ret = ccg_read(uc, reg, (void *)buf, size);
+
+		if (ret) {
+			kfree(buf);
+			return ret;
+		}
+	}
+
+	spin_lock(&uc->op_lock);
+	data->cci = cci;
+	if (UCSI_CCI_LENGTH(cci))
+		memcpy(&data->message_in, buf, size);
+	spin_unlock(&uc->op_lock);
+	kfree(buf);
+	return 0;
+}
+
 static int ucsi_ccg_init(struct ucsi_ccg *uc)
 {
 	unsigned int count = 10;
 	u8 data;
 	int status;
 
+	spin_lock_init(&uc->op_lock);
+
 	data = CCGX_RAB_UCSI_CONTROL_STOP;
 	status = ccg_write(uc, CCGX_RAB_UCSI_CONTROL, &data, sizeof(data));
 	if (status < 0)
@@ -520,9 +563,20 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
 	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(offset);
 	struct ucsi_capability *cap;
 	struct ucsi_altmode *alt;
-	int ret;
+	int ret = 0;
+
+	if (offset == UCSI_CCI) {
+		spin_lock(&uc->op_lock);
+		memcpy(val, &(uc->op_data).cci, val_len);
+		spin_unlock(&uc->op_lock);
+	} else if (offset == UCSI_MESSAGE_IN) {
+		spin_lock(&uc->op_lock);
+		memcpy(val, &(uc->op_data).message_in, val_len);
+		spin_unlock(&uc->op_lock);
+	} else {
+		ret = ccg_read(uc, reg, val, val_len);
+	}
 
-	ret = ccg_read(uc, reg, val, val_len);
 	if (ret)
 		return ret;
 
@@ -559,9 +613,18 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
 static int ucsi_ccg_async_write(struct ucsi *ucsi, unsigned int offset,
 				const void *val, size_t val_len)
 {
+	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
 	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(offset);
 
-	return ccg_write(ucsi_get_drvdata(ucsi), reg, val, val_len);
+	/*
+	 * UCSI may read CCI instantly after async_write,
+	 * clear CCI to avoid caller getting wrong data before we get CCI from ISR
+	 */
+	spin_lock(&uc->op_lock);
+	uc->op_data.cci = 0;
+	spin_unlock(&uc->op_lock);
+
+	return ccg_write(uc, reg, val, val_len);
 }
 
 static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
@@ -615,13 +678,18 @@ static irqreturn_t ccg_irq_handler(int irq, void *data)
 	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(UCSI_CCI);
 	struct ucsi_ccg *uc = data;
 	u8 intr_reg;
-	u32 cci;
-	int ret;
+	u32 cci = 0;
+	int ret = 0;
 
 	ret = ccg_read(uc, CCGX_RAB_INTR_REG, &intr_reg, sizeof(intr_reg));
 	if (ret)
 		return ret;
 
+	if (!intr_reg)
+		return IRQ_HANDLED;
+	else if (!(intr_reg & UCSI_READ_INT))
+		goto err_clear_irq;
+
 	ret = ccg_read(uc, reg, (void *)&cci, sizeof(cci));
 	if (ret)
 		goto err_clear_irq;
@@ -629,13 +697,21 @@ static irqreturn_t ccg_irq_handler(int irq, void *data)
 	if (UCSI_CCI_CONNECTOR(cci))
 		ucsi_connector_change(uc->ucsi, UCSI_CCI_CONNECTOR(cci));
 
-	if (test_bit(DEV_CMD_PENDING, &uc->flags) &&
-	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
-		complete(&uc->complete);
+	/*
+	 * As per CCGx UCSI interface guide, copy CCI and MESSAGE_IN
+	 * to the OpRegion before clear the UCSI interrupt
+	 */
+	ret = ccg_op_region_update(uc, cci);
+	if (ret)
+		goto err_clear_irq;
 
 err_clear_irq:
 	ccg_write(uc, CCGX_RAB_INTR_REG, &intr_reg, sizeof(intr_reg));
 
+	if (!ret && test_bit(DEV_CMD_PENDING, &uc->flags) &&
+	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
+		complete(&uc->complete);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.34.1


