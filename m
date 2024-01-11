Return-Path: <linux-kernel+bounces-23928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BF282B3FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48B1AB22D58
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E449537F2;
	Thu, 11 Jan 2024 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D5YrtaqD"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D54D524A9;
	Thu, 11 Jan 2024 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myCGBSkbqAQyqb5jiyOKnr2HkNTfCJbO2eS/RtnimoOKZjpLIEcgVekx+enA/1H1IBE+WijBZGgFw7GNx4ofxkhcAy+4xfgLopJGe+vRreK7huQL472c4j1ykvD19yBVBELlZn6Tvis+7BHv9um+WsdjNQ/IoZY9CK1Pai4F7Lnq03416/LK9gHfaJYuxjDCXPct2NWuJ8Gd0qNAhxk4SftbJafMklQageNijlxMxOBe1zCs7yutnjpEAfCAKo5uqdO1iwFtwIajzobQD8xEwfKeKN8z1KlfgBRNx3XpwMzbeP3Pz9cios+6sYiNTVq6WQWhtOG0YFIG/WTFDjSDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUXrcMYy4vwQm8cydCbjmiK9RdRAzCAl1eZ03Tf+x9U=;
 b=Tj2FatBUT4DFgJrtNXT6v7gilnAkf4xCK8bcBS+zjulng1zkY45lKVy8+EcLpdOYUrRXq2cucsIummmtS45Dnpe4GmtzG9hJ//YGvstR9jVRKkkvT/Hju2h27HjfQJ/k59PTHLbSDZttHZegEmr8ppd1jKGy9o6LH2yvRx/hAWkBtk+k61IPiBBqmp1VG+nxdyeou52cw9EAk9jOMW6UqK4f8TujC3h3tpT9KgtBUi07JVuxBu/CUdx8C4M9n7UY+sAbm1G6P+fmVN6tigh9vj1IO4z9RRaW/IMG21FoObX8AeLTwg3uSUxC17WmIIKin8hgwFLUlFraheWcfBPWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUXrcMYy4vwQm8cydCbjmiK9RdRAzCAl1eZ03Tf+x9U=;
 b=D5YrtaqDHPpNGetzgL9GPD4soqz7fhyYmNGtI2iZ4P0L8MT/ay4/fNtxDA1N5UDgG91A3uSQ1TJrjydzxfLdWja3uhXyqgzP25x69VAmVyap20uPkdPZp8vcg9ClI0gE4DUvGNeCoERAUqpDyfyV/rq5f9i1UE9lKKXa6NC03PE=
Received: from SA1PR03CA0022.namprd03.prod.outlook.com (2603:10b6:806:2d3::27)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 17:22:29 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::2f) by SA1PR03CA0022.outlook.office365.com
 (2603:10b6:806:2d3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Thu, 11 Jan 2024 17:22:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 17:22:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 11:22:29 -0600
Received: from xsjblevinsk50.xilinx.com (172.19.2.206) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 11 Jan 2024 11:22:28 -0600
From: Ben Levinsky <ben.levinsky@amd.com>
To: <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <shubhrajyoti.datta@amd.com>,
	<jaswinder.singh@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ben.levinsky@amd.com>
Subject: [PATCH v2 2/3] mailbox: zynqmp: Move buffered IPI setup to of_match selected routine
Date: Thu, 11 Jan 2024 09:22:25 -0800
Message-ID: <20240111172226.1816105-3-ben.levinsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111172226.1816105-1-ben.levinsky@amd.com>
References: <20240111172226.1816105-1-ben.levinsky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba1eb12-242b-4774-0256-08dc12c9e392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8v9q4U2d/EfUqNhVJdBv2T+2ZHb3qO0is34aU9/37WKKDyQVxWGykdGWby2ptkZYhYotI5/vB2ohR4klHVWCXIjWw9Yfvm88d+SMk6Rk8f/w4etoV+Wmr+e/IjV0yf0yWSia9w8g7i1R3pAj7i2hL+NBu+I16kvZp4fAZs/LJQFpBfHYQXFO6qKgSmPWGJ7UjhjFcZENjl3kLiqR+wCVTClNr69fWXcdUuM2axVCKC+V4KbDrrrZHSFOF5ZymrIRZLzUPPhkholMIwhcff2UTZfF3VZ2I5rv8WTUP4+/8oWJDrlcEJuQwMH5OQMsGfiwBqJL0gq4N4dZgtQlTlVlTfvjxvUxk2z5inOgM4SIc/QEMNfTWvD07nJA7srUOiaB+hv4umvPJ09TSrkGd2ySVgc1fSiHFS/ezTXQCHw4Glqc6+70SSm3kmzBzzGES9s/2X9+MndKnDtlJ5plSelxanWzQf0SNRecfUZ0DblbTOcnKYY8RPu4rB2LZ1aIjrSM+o9IgRuoy6BJfta6AKiVFtRbaimzFvCCXhbYuJW2O/lRoR7uP8dIuf6vzn9xTEwH6dKfJnsmHfHhlc5YdOkAmfdUmp/MR3kjzanuQb231GDqpKYmLopX5UAGnjNBbY86o7lzG5Lqy2cSInJcP49DMBYGeJH8uj5sNxiCugIp00tKN48FNJlqXZ1xvVBlr3ZPP1SK15Zu6qlcAHaCOg+Z/vYzEXyQyGQt1+AyZOW0B18pZHn1XHkBsaj/OlATMUb8EEcgeyLKLSNdE/tZmODCWw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(82310400011)(64100799003)(1800799012)(451199024)(186009)(40470700004)(36840700001)(46966006)(40480700001)(83380400001)(40460700003)(8676002)(54906003)(44832011)(4326008)(8936002)(70206006)(2616005)(316002)(70586007)(36756003)(110136005)(82740400003)(478600001)(47076005)(26005)(336012)(1076003)(426003)(81166007)(356005)(36860700001)(6666004)(86362001)(15650500001)(2906002)(5660300002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 17:22:29.4866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba1eb12-242b-4774-0256-08dc12c9e392
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382

Move routine that initializes the mailboxes for send and receive to
a function pointer that is set based on compatible string.

Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 123 +++++++++++++++++++--------
 1 file changed, 88 insertions(+), 35 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 951389f0b90c..720da91b9efd 100644
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
+ * @setup_ipi_fn:          Function Pointer to set up IPI Channels
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
@@ -491,6 +494,74 @@ static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
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
+	struct device *mdev, *dev;
+	struct resource res;
+	const char *name;
+	int ret;
+
+	mdev = &ipi_mbox->dev;
+	dev = ipi_mbox->pdata->dev;
+
 	mchan = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
 	name = "local_request_region";
 	ret = zynqmp_ipi_mbox_get_buf_res(node, name, &res);
@@ -565,37 +636,7 @@ static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
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
@@ -626,6 +667,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 	struct zynqmp_ipi_pdata *pdata;
 	struct zynqmp_ipi_mbox *mbox;
 	int num_mboxes, ret = -EINVAL;
+	setup_ipi_fn ipi_fn;
 
 	num_mboxes = of_get_available_child_count(np);
 	if (num_mboxes == 0) {
@@ -646,9 +688,18 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
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
@@ -694,7 +745,9 @@ static int zynqmp_ipi_remove(struct platform_device *pdev)
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


