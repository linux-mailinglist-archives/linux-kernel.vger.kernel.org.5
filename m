Return-Path: <linux-kernel+bounces-117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28BF813C65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B6C281CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7B66ABB7;
	Thu, 14 Dec 2023 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d9YxhpUp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A53B2BCF6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhMYMmMBCmZFR2vDN7Xmg3SNo8NHSO9QB2Qj1YFT3ufDVo3sqzfTgs1oQ78JChtQFYJcrc40pdZoAW8mWqZCmTIoKH3MAkUIzdLXyElZoQhhtm30hz8zmzCgO71Nykt6JkCsdp64jwR1eRJqQ59Gd/3Ivyr8tfobBUdxUqChaxrpFyJhVcwzQBAJydROrZaDQEoeBchrmHDflkotAdLqMdCpVnky4SdfCqcp/cxUejdPVbo8ms0Hmig/BVZ893tL6KKx07QrLkdUC3XA2Pfz+rc5VqRX7TUa9UpwX4k+0L6FTksyPRXIR5SaYHxvAmGn3yXBFLE2X72uWq1fmarFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyrNABH8i+zlt1Op3QBbr3feAzm1f1Qlzc1kvPCmUhQ=;
 b=HWvI7qvxVUv0eepl7y0a+EsdYuolc2bor7NF+D82E3UYne6dPFbf7pSr8xYpBUBhyUcTCnxR/NaJvuwp1+RmzXEm5karWf6WHOyZH9WDkcGOHtRgP9sSsOc9REFdoZG4PQp3lhjMst/LIMvIuM1YCn6XR0IRt55P7dKtwfIAvAIns8iCz8C0rVI2idM+SCDHcz0EaJu6jf+HNmbiLa+DE63pdI0BsS8kvs7XXsFKqw1Hk3MlE8jbpO/gtieEnR482WBmwOL8Bi2zFO1RmsfOufvhPUbhG+2OljwI/DPNnJGX2lIZ5GEq0FvCR7QzYxFJkexg69EemA20zQPDKO45hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyrNABH8i+zlt1Op3QBbr3feAzm1f1Qlzc1kvPCmUhQ=;
 b=d9YxhpUpVRfy9vmNzGjSsf3WuHkDss44B74U9uVQMEdc+xfVKWvEKi8rWpIzc5zNV95gGLCfFz3ra6wOjLHX5hoKp/gHEismuzUXQiql+vXOTtCIC8Wn40MamgTzM6Nm7zQ2JRYu/5JlRssOXeJHIxweQCWuz+p6Xy0DO2gYf1U=
Received: from SA1PR05CA0011.namprd05.prod.outlook.com (2603:10b6:806:2d2::13)
 by SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 21:13:57 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::71) by SA1PR05CA0011.outlook.office365.com
 (2603:10b6:806:2d2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.8 via Frontend
 Transport; Thu, 14 Dec 2023 21:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 21:13:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 15:13:56 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 15:13:56 -0600
Received: from xsjblevinsk50.xilinx.com (172.19.2.206) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 14 Dec 2023 15:13:55 -0600
From: Ben Levinsky <ben.levinsky@amd.com>
To: <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>
CC: <shubhrajyoti.datta@amd.com>, <tanmay.shah@amd.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/3] mailbox: zynqmp: Move buffered IPI setup to of_match selected routine
Date: Thu, 14 Dec 2023 13:13:53 -0800
Message-ID: <20231214211354.348294-3-ben.levinsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214211354.348294-1-ben.levinsky@amd.com>
References: <20231214211354.348294-1-ben.levinsky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: c7752571-ded2-49ae-9bd5-08dbfce995c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rXnJgyEVZnaW0yH2yol+BMhrhhAKApIOY7DqXsHC8hBkjNDJid1ukI4nqNKilW+ufgTGX1JTM9E+TfBswAkv+xYf61ncFQDmHLNmD+LL/JTOm0vCY5apln1WDZ1Kfuxk5Icvyv/5tin7z9KmbtX6NL76bf3ZTYtsnnf8hwkhBIQnfWMQSBpCfq67+cZv0D8jw4cb7k5+AUTEY2yAvsp9AZg7B92N2S8nd6cRzfhUIoAwNQdjVzqeMZNK0WeKDDP1GxRf10Zz8HMUUGbZuALGkf95+Usm7JoSnWLmSbq+G0buRlnAxj39kF9tlohtANCp2MyTg6vTmFjQ9l8M3d3sRx1dDgo+E+4y/S6oKM2KHOGVKp9VgOAX4m1cGQmWzAv/cmnVuBiNzioVBqW/S8vlFZbFhZ8VmZJ80FSP4+8ASiSuHftJbNX4JaFJzduD1cKz+P7UghVNWYN+bX/n4hAWc+uHqijRWY9iq7ItTtjr1vAdco8El4aRrjKQ2yegI/EjMg61rDVtRZ4lKAiFoxs43faHbrZ0DSwQW4VrwbydqDfmBDz8/f179Jf6LMuisCA8R90YqAHxknF1BNJs/S86oqy6xKMjLZUmXRxeL5WCHXXn4HeuDmk6PUotUuFkg3B2DNwNw8Q8Yi/n1uI2Be3Xp2VJXmV5hrnRoIe3g9WqoIvmn7mbzwcOhjdfh/45GptAoOW3nMffC8l9zqz05J8BRggyg9KNShgeA+Ibi8uICzR6Z6uM7Kfw4vhb1yLf1yMAX6aCmFHSidiRw2tCAekVBA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(41300700001)(1076003)(478600001)(2616005)(36860700001)(336012)(26005)(86362001)(70206006)(70586007)(40480700001)(426003)(54906003)(6636002)(356005)(81166007)(40460700003)(82740400003)(316002)(83380400001)(110136005)(36756003)(8676002)(4326008)(8936002)(2906002)(47076005)(44832011)(5660300002)(15650500001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 21:13:57.2636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7752571-ded2-49ae-9bd5-08dbfce995c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742

Move routine that initializes the mailboxes for send and receive to
a function pointer that is set based on compatible string.

Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 124 +++++++++++++++++++--------
 1 file changed, 89 insertions(+), 35 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 2c10aa01b3bb..edefb80a6e47 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -72,6 +72,10 @@ struct zynqmp_ipi_mchan {
 	unsigned int chan_type;
 };
 
+struct zynqmp_ipi_mbox;
+
+typedef int (*setup_ipi_fn)(struct zynqmp_ipi_mbox *ipi_mbox, struct device_node *node);
+
 /**
  * struct zynqmp_ipi_mbox - Description of a ZynqMP IPI mailbox
  *                          platform data.
@@ -82,6 +86,7 @@ struct zynqmp_ipi_mchan {
  * @mbox:                 mailbox Controller
  * @mchans:               array for channels, tx channel and rx channel.
  * @irq:                  IPI agent interrupt ID
+ * setup_ipi_fn:          Function Pointer to set up IPI Channels
  */
 struct zynqmp_ipi_mbox {
 	struct zynqmp_ipi_pdata *pdata;
@@ -89,6 +94,7 @@ struct zynqmp_ipi_mbox {
 	u32 remote_id;
 	struct mbox_controller mbox;
 	struct zynqmp_ipi_mchan mchans[2];
+	setup_ipi_fn setup_ipi_fn;
 };
 
 /**
@@ -466,12 +472,9 @@ static void zynqmp_ipi_mbox_dev_release(struct device *dev)
 static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
 				 struct device_node *node)
 {
-	struct zynqmp_ipi_mchan *mchan;
 	struct mbox_chan *chans;
 	struct mbox_controller *mbox;
-	struct resource res;
 	struct device *dev, *mdev;
-	const char *name;
 	int ret;
 
 	dev = ipi_mbox->pdata->dev;
@@ -491,6 +494,75 @@ static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
 	}
 	mdev = &ipi_mbox->dev;
 
+	/* Get the IPI remote agent ID */
+	ret = of_property_read_u32(node, "xlnx,ipi-id", &ipi_mbox->remote_id);
+	if (ret < 0) {
+		dev_err(dev, "No IPI remote ID is specified.\n");
+		return ret;
+	}
+
+	ret = ipi_mbox->setup_ipi_fn(ipi_mbox, node);
+	if (ret) {
+		dev_err(dev, "Failed to set up IPI Buffers.\n");
+		return ret;
+	}
+
+	mbox = &ipi_mbox->mbox;
+	mbox->dev = mdev;
+	mbox->ops = &zynqmp_ipi_chan_ops;
+	mbox->num_chans = 2;
+	mbox->txdone_irq = false;
+	mbox->txdone_poll = true;
+	mbox->txpoll_period = 5;
+	mbox->of_xlate = zynqmp_ipi_of_xlate;
+	chans = devm_kzalloc(mdev, 2 * sizeof(*chans), GFP_KERNEL);
+	if (!chans)
+		return -ENOMEM;
+	mbox->chans = chans;
+	chans[IPI_MB_CHNL_TX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
+	chans[IPI_MB_CHNL_RX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
+	ipi_mbox->mchans[IPI_MB_CHNL_TX].chan_type = IPI_MB_CHNL_TX;
+	ipi_mbox->mchans[IPI_MB_CHNL_RX].chan_type = IPI_MB_CHNL_RX;
+	ret = devm_mbox_controller_register(mdev, mbox);
+	if (ret)
+		dev_err(mdev,
+			"Failed to register mbox_controller(%d)\n", ret);
+	else
+		dev_info(mdev,
+			 "Registered ZynqMP IPI mbox with TX/RX channels.\n");
+	return ret;
+}
+
+/**
+ * zynqmp_ipi_setup - set up IPI Buffers for classic flow
+ *
+ * @ipi_mbox: pointer to IPI mailbox private data structure
+ * @node: IPI mailbox device node
+ *
+ * This will be used to set up IPI Buffers for ZynqMP SOC if user
+ * wishes to use classic driver usage model on new SOC's with only
+ * buffered IPIs.
+ *
+ * Note that bufferless IPIs and mixed usage of buffered and bufferless
+ * IPIs are not supported with this flow.
+ *
+ * This will be invoked with compatible string "xlnx,zynqmp-ipi-mailbox".
+ *
+ * Return: 0 for success, negative value for failure
+ */
+static int zynqmp_ipi_setup(struct zynqmp_ipi_mbox *ipi_mbox,
+			    struct device_node *node)
+{
+	struct zynqmp_ipi_mchan *mchan;
+	struct device *mdev;
+	struct resource res;
+	struct device *dev;
+	const char *name;
+	int ret;
+
+	mdev = &ipi_mbox->dev;
+	dev = ipi_mbox->pdata->dev;
+
 	mchan = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
 	name = "local_request_region";
 	ret = zynqmp_ipi_mbox_get_buf_res(node, name, &res);
@@ -565,37 +637,7 @@ static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
 	if (!mchan->rx_buf)
 		return -ENOMEM;
 
-	/* Get the IPI remote agent ID */
-	ret = of_property_read_u32(node, "xlnx,ipi-id", &ipi_mbox->remote_id);
-	if (ret < 0) {
-		dev_err(dev, "No IPI remote ID is specified.\n");
-		return ret;
-	}
-
-	mbox = &ipi_mbox->mbox;
-	mbox->dev = mdev;
-	mbox->ops = &zynqmp_ipi_chan_ops;
-	mbox->num_chans = 2;
-	mbox->txdone_irq = false;
-	mbox->txdone_poll = true;
-	mbox->txpoll_period = 5;
-	mbox->of_xlate = zynqmp_ipi_of_xlate;
-	chans = devm_kzalloc(mdev, 2 * sizeof(*chans), GFP_KERNEL);
-	if (!chans)
-		return -ENOMEM;
-	mbox->chans = chans;
-	chans[IPI_MB_CHNL_TX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
-	chans[IPI_MB_CHNL_RX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
-	ipi_mbox->mchans[IPI_MB_CHNL_TX].chan_type = IPI_MB_CHNL_TX;
-	ipi_mbox->mchans[IPI_MB_CHNL_RX].chan_type = IPI_MB_CHNL_RX;
-	ret = devm_mbox_controller_register(mdev, mbox);
-	if (ret)
-		dev_err(mdev,
-			"Failed to register mbox_controller(%d)\n", ret);
-	else
-		dev_info(mdev,
-			 "Registered ZynqMP IPI mbox with TX/RX channels.\n");
-	return ret;
+	return 0;
 }
 
 /**
@@ -626,6 +668,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 	struct zynqmp_ipi_pdata *pdata;
 	struct zynqmp_ipi_mbox *mbox;
 	int num_mboxes, ret = -EINVAL;
+	setup_ipi_fn ipi_fn;
 
 	num_mboxes = of_get_available_child_count(np);
 	if (num_mboxes == 0) {
@@ -646,9 +689,18 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ipi_fn = (setup_ipi_fn)device_get_match_data(&pdev->dev);
+	if (!ipi_fn) {
+		dev_err(dev,
+			"Mbox Compatible String is missing IPI Setup fn.\n");
+		return -ENODEV;
+	}
+
 	pdata->num_mboxes = num_mboxes;
 
 	mbox = pdata->ipi_mboxes;
+	mbox->setup_ipi_fn = ipi_fn;
+
 	for_each_available_child_of_node(np, nc) {
 		mbox->pdata = pdata;
 		ret = zynqmp_ipi_mbox_probe(mbox, nc);
@@ -694,7 +746,9 @@ static int zynqmp_ipi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id zynqmp_ipi_of_match[] = {
-	{ .compatible = "xlnx,zynqmp-ipi-mailbox" },
+	{ .compatible = "xlnx,zynqmp-ipi-mailbox",
+	  .data = &zynqmp_ipi_setup,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, zynqmp_ipi_of_match);
-- 
2.25.1


