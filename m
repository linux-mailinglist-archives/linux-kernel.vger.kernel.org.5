Return-Path: <linux-kernel+bounces-29699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D23908311FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 05:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032461C21BC5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 04:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D419D79C4;
	Thu, 18 Jan 2024 04:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GnYMFa2v"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36386111;
	Thu, 18 Jan 2024 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705550473; cv=fail; b=SEB9dH0OEX3plBDIsrAu5Cvux3RDBcyVyWVwADcpBWw2qdF5aek2NL56oTM/ugztkOE/xEZ573FRwKU4QKwJ0CzdKiP0EK9hCKl97DBvGU4b4R95BvLLWtffzsyhk0pO4JQA5NtFcJlzPtbzBLq3BfjKv9stl/F+AHbE+tEkXeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705550473; c=relaxed/simple;
	bh=/3B5GQxi6kyJXmdGBYZfA0zJBp0RESQoLSu2+JR/11k=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=KohJEZ4sv1JwEo6e2/AtVN5XB/eK9Ya6TBRE3J9G2I6wQunp32IOb5dMLajV9TvqwR2A+2c5ghiLpGoBNbHfKRfsRI3QfDwlocpypkDYAh5e4Tj9KEhyH3hi2aY6W5N2Cq4hLxVdG4c2UGi4P+albMyEn+Qd1MCnxduN0q3aveQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GnYMFa2v; arc=fail smtp.client-ip=40.107.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaWARu+Z6M/87NjpMowfxBht7jIoVPTH43sVb4XRrO0kxRiXJb3aRjzKqEIN/L7RPZD8vYDOWC7mQBtrGaydjhIXLlHGSyYApe2277RTTfbXZqRX/s+mFgTZGmEn7jB3gNEmKS6EMvKo7GlOv1gsm4TnxZdW9hUEu2Rk3n+pM+DulTXY5Jxl46w8ggst/JFNVN4n7jwzVHdinEgz2C+LPf0kWzo7HT9aBOmPSsnF+Wvyrgra6iUfVWmWwGvrPb3mpOAQXFaqM4xFqkTep8NDSwQ6rVwHl/mWgsWjMd3Qxo++OQOBFXqGnMWi5kLJYBAX+WBkoZE0bEsmUCo3S2W9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmnHyybq5jsqamxD3vuNKJGim2MZV/OPnP61WiZFwVk=;
 b=gz/A5gm/MiLQO9arf7vsDRzFAUzul6XhkS3/c7OJJ1cgYwy/XDe6KGUrp64Btkk8XjOr5Icdgm2OadThT0YywnZOiK+2BMhHCDtSUWX1MjVfN5TTHFFVYUeoIgry7HqJh6AptBE10Mxqzm2IaIu9ZzQ2OkntV4IN2hMuS0F62OmzkHKb7Wyvk+5q8z7GrrBCvkxaBePLfqUXde8rqEpOXILco6oqgYCdYk22CVfqgaqyj9rNkd1d84fBbKUSRiJscBhga14U8vy8EIytTDDv7owlbtRGLtf/Ne207jAMvurEpEYNUT8TkBExHeGvCSvCuBcLN2qHBohr1GUdu8u+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmnHyybq5jsqamxD3vuNKJGim2MZV/OPnP61WiZFwVk=;
 b=GnYMFa2vuT7+4cxQuAWBK+BQnOZiSYl3XTAse8MMeV8vGVNlJpnbU6juzYMkrrNyZbPlbdj0779hhP1gbE0Co6rY4HemgIRG5KuJJ9S1U+GL0UZn+k6oqT4EOSg0NRWS75N0PyL9uglOVe/2glQpoqNXQqhLFeRbZQfanJ+GK/Wc8nnbAgkplqYUDRI61zH0R/ckihKXFMPDkxA+MOCib2k6LYdnsS1GF4p3Ke0sPZHz6QbmH6E1714zrxdkk/60sSX/S6egFgiw12LvhItp538U0DglFPF2CQRbaOZWIhKxDhDKRJz2TJYTAHtaysUPQ0xVkHODJZBHZIGpRmIrOA==
Received: from BY5PR20CA0025.namprd20.prod.outlook.com (2603:10b6:a03:1f4::38)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 04:01:05 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::39) by BY5PR20CA0025.outlook.office365.com
 (2603:10b6:a03:1f4::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 04:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 04:01:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Jan
 2024 20:00:48 -0800
Received: from e558209-lcelt.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 17 Jan 2024 20:00:45 -0800
From: Haotien Hsu <haotienh@nvidia.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Utkarsh Patel <utkarsh.h.patel@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sing-Han Chen <singhanc@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	Wayne Chang <waynec@nvidia.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, WK Tsai <wtsai@nvidia.com>, Haotien Hsu
	<haotienh@nvidia.com>
Subject: [PATCH v6] ucsi_ccg: Refine the UCSI Interrupt handling
Date: Thu, 18 Jan 2024 12:00:34 +0800
Message-ID: <20240118040034.2798629-1-haotienh@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: 40be2ec1-d512-4402-7dbc-08dc17da17eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EJ+5QC0CawdI0XYn12K8x0mPSKwPbdFgQd5GifCkyoltfWbasOphk+h5M6Uk9gRuaN5bCeY/uxz7Y6lNarMvxhCw4pB/e1uALN2hdXbRv3crUMl/p6Hsn/VBMQZR3IKzS9q1keC7CDutnuJTktzS6d+13kATdF1HCEOF2z0P8tLEEiutCzfK0FiCGg/XuSDPEeaKZUfU+3CkRA5iw2lEU9IpRqYCiUjtsXnkJDY5nt1j+gHEx/bN/PceKJkT1g735niiiiPqtFwgJ0X5GxLRQZSkJSXe/98sSILiwZqoaKsOKP7E+MnowW9RCzJtwEpivNremzo7Uz+YxlKLMT+PGmXO1JXgAe/LI43779tnpUC1g2tlrJi86fSQ3P8UYRvqmTMM97A5fmEOBzT3xkJKNG9omujzSYbvxI7ch6I+O0mO3UUb2bty589iNQpEBx4fUn257Lcket5+SEKkzP8JJ9LXMqqyLWy58P48arPNyk1XGYDQsTFppPn4PPNYLGDL6sT5mhXDNQatgLrXTyy9xDdhw5Jlmum/uCCgWNcAajnrea7QibTdL5v4Pio94NAzRHO6V2HQjQ6WSzD66hr4t7oZIr8+zNyjHktAfrmd/fJLbLGOxvcomzn2OYAvA22yqa0gPLX/WjFUJo66mANM/q/MiNGB3wEb1e+6eWp46o/Gm2COSJJdrCvYOFHBEQW7gkcXMebzEHpHqg2uBHKjJ+FpslFSMqPWca0MPW7RMdkueyWdMd/s4kMawYHieBbFckLi/PIFxXI2VgWDx26VKL8X/gyFKe9yXdXIvstAbQM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230273577357003)(230173577357003)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799012)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(86362001)(478600001)(36756003)(336012)(426003)(26005)(82740400003)(356005)(7636003)(107886003)(47076005)(36860700001)(2616005)(1076003)(83380400001)(16526019)(2906002)(8936002)(4326008)(316002)(5660300002)(8676002)(6666004)(7696005)(110136005)(41300700001)(70206006)(70586007)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 04:01:04.9980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40be2ec1-d512-4402-7dbc-08dc17da17eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294

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
v5->v6
- Fix sparse warning: incorrect type in assignment

Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 92 ++++++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 449c125f6f87..dda7c7c94e08 100644
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
+	data->cci = cpu_to_le32(cci);
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


