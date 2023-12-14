Return-Path: <linux-kernel+bounces-118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D79813C66
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882491C21CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461E16D1A7;
	Thu, 14 Dec 2023 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IdbdtTni"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C6E2BCF9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5UQUG2tMLeBUuOTEZXgo9JHKCPkEP46+bZWricWtwRwlvwvvahflodAyZMVCZLxjBssQ+GXLtzKTfKS7vMa8d4awoO0S0eJV7iCMIemSYGOmhLYCYAcpsPDlFEu7GkntxfK78kSOqiteHeosh6rAUSpd/zf3ri7JMSVZyp1HbiSDyqWPJBcIxipekPRZWdhyZIkotHhKa2P500NF45wZ8QIDFJDfAHCvFU+JGefQ8bDQwuZF1d2lKK1kmZjiXVkdhrpff4aite+/e641+fHski7MAvSnVVCdhXlqZbGtxhz32mXDrqhep5YUZedWDwDCb4S89lZvNEjbd0mau3bYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsSAgkByxi1E/H41WVLR/a+MWiHNOG4RqH4g4/cMbPg=;
 b=WPY4J30UzvQuDQGoIRysDITIqkaH+Laaoz5qnp/L4mH/CSU8/gY7OB7eawdMFZ8C2e8fJ7X/S9vHNcfDWk9FIfyBWXgTY0GBOXRu3FRyvK8QmXXjP0LL2OLsgpDQ3y85EPYDVzYj5svk2kyvfCcMtILexgT2Q0FDc9qAUrzIvTMICcWe3NobBA9JAx8n97H/siB/+bs2KDD/uHF3fMqp7EV+RBt1HApUtiRPsJ+Jv9UnFx+Y6+uEL+gTQZG5w1F+qj8QaciiRf0SEXxFpWZI2svjT9A6PUS1xKppuevkKUdM+AI6rGqrSoH4rbHq14TnXx7hkeBO/DH6kJHRK8hVsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsSAgkByxi1E/H41WVLR/a+MWiHNOG4RqH4g4/cMbPg=;
 b=IdbdtTniUPcB/eW1MN02t3dtRuhaXwsyfAQj+kVOLLrMSPL5biKWsjASkMyZYAs9MVshe7648qa0fT2SlI4An+0YODQkl19AkxEW3FFxbDTZha7L1R7Fvds4r5cahAuUm3hWEFsl9+AZtyEyubwWzoEVmtdM/VlZ8mT5CGlmtuM=
Received: from BL1PR13CA0163.namprd13.prod.outlook.com (2603:10b6:208:2bd::18)
 by IA0PR12MB8973.namprd12.prod.outlook.com (2603:10b6:208:48e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Thu, 14 Dec
 2023 21:13:57 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::8a) by BL1PR13CA0163.outlook.office365.com
 (2603:10b6:208:2bd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.8 via Frontend
 Transport; Thu, 14 Dec 2023 21:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 21:13:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 15:13:57 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 15:13:57 -0600
Received: from xsjblevinsk50.xilinx.com (172.19.2.206) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 14 Dec 2023 15:13:56 -0600
From: Ben Levinsky <ben.levinsky@amd.com>
To: <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>
CC: <shubhrajyoti.datta@amd.com>, <tanmay.shah@amd.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/3] mailbox: zynqmp: Enable Bufferless IPI usage on Versal-based SOC's
Date: Thu, 14 Dec 2023 13:13:54 -0800
Message-ID: <20231214211354.348294-4-ben.levinsky@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|IA0PR12MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: ca005360-5db6-43bb-7ebf-08dbfce9960a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zAWpzFKYQ9IPyt3HH0GF7pJIGvuGA99D3H9LNqbRtPs+RpdydEp0uBG3t/t0s0U8A3LA72LFTWJOl2TUvtz8ktpy06PEvV5WJHWH6zF3Tr3hmRS+W5bHygk5XMusmAyUqLJIkdlToTtBhk8ZlWEnFAUGscuhZ9cLKR6GGhQ8anxNM66Ayo0afoPoJitzWepzGvAqCrcisbGjOSoAbue1y20e1CWAkIy91saVGN6g5Wf4hFYefXkUvikWJZS1lvDpsSjKPwWDbdGqnzW5Z1UBZmfG8Rj3eXWL0GqrgxpoQRrtniNeP/W9v2peCUuDDSokmHE6kG7J6afOExbMsyz5qnHTExOE9Dgwj3Hohc/8fjmgEJu9uQe33RsupulL+KDB2GO0dKyL94kPiwlxLMdWdn9Sa1igC8T60eFtGoatbqiOMynb3JQSKCYb4KBKQR20U3MkpiZpwr5ahjfJy6wA4/5Ayr7EAEibR3IRCZWKQ0YVbfREsAy2kkf70cBuRBVe1uc/1JbW9fnpT+Ox/+2s37W3MG0Wm/2b8vsxIwGgOHTwta0qoKJGQTjWhCJIBxelR5m1PtoNdP2g7n8JB4ECZ8raihINFa+Cq/A4Y8G1i3Xz6kLuGpSeTUC6cfwmgX6fbmzQAWLNgV3HO447IqImIMYCjRjS83a7L3leAqvs6qoRrD7y/IVcdxDU2q4a5mW6WINUHTKa2A3sAdbnVn3MLQn/a8OAPTFNETg4PItdOfx5+x7O+lU8g5bS2JEL/Vjg3FgEo6w7A3N8EBeqCJCektfaNGAjsvpXqnqTc9sUGUo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(41300700001)(15650500001)(2906002)(44832011)(5660300002)(40460700003)(36860700001)(82740400003)(81166007)(356005)(70206006)(70586007)(54906003)(6636002)(426003)(40480700001)(43170500006)(336012)(26005)(110136005)(83380400001)(316002)(2616005)(36756003)(1076003)(86362001)(966005)(478600001)(47076005)(8936002)(4326008)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 21:13:57.7438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca005360-5db6-43bb-7ebf-08dbfce9960a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8973

On Xilinx-AMD Versal and Versal-NET, there exist both
inter-processor-interrupts with corresponding message buffers and without
such buffers.

Add a routine that, if the corresponding DT compatible
string "xlnx,versal-ipi-mailbox" is used then a Versal-based SOC
can use a mailbox Device Tree entry where both host and remote
can use either of the buffered or bufferless interrupts.

Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
---
Note that the linked patch provides corresponding bindings.
Depends on: https://lore.kernel.org/all/20231214054224.957336-3-tanmay.shah@amd.com/T/
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 146 +++++++++++++++++++++++++--
 1 file changed, 139 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index edefb80a6e47..316d9406064e 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -52,6 +52,13 @@
 #define IPI_MB_CHNL_TX	0 /* IPI mailbox TX channel */
 #define IPI_MB_CHNL_RX	1 /* IPI mailbox RX channel */
 
+/* IPI Message Buffer Information */
+#define RESP_OFFSET	0x20U
+#define DEST_OFFSET	0x40U
+#define IPI_BUF_SIZE	0x20U
+#define DST_BIT_POS	9U
+#define SRC_BITMASK	GENMASK(11, 8)
+
 /**
  * struct zynqmp_ipi_mchan - Description of a Xilinx ZynqMP IPI mailbox channel
  * @is_opened: indicate if the IPI channel is opened
@@ -170,9 +177,11 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
 		if (ret > 0 && ret & IPI_MB_STATUS_RECV_PENDING) {
 			if (mchan->is_opened) {
 				msg = mchan->rx_buf;
-				msg->len = mchan->req_buf_size;
-				memcpy_fromio(msg->data, mchan->req_buf,
-					      msg->len);
+				if (msg) {
+					msg->len = mchan->req_buf_size;
+					memcpy_fromio(msg->data, mchan->req_buf,
+						      msg->len);
+				}
 				mbox_chan_received_data(chan, (void *)msg);
 				status = IRQ_HANDLED;
 			}
@@ -282,26 +291,26 @@ static int zynqmp_ipi_send_data(struct mbox_chan *chan, void *data)
 
 	if (mchan->chan_type == IPI_MB_CHNL_TX) {
 		/* Send request message */
-		if (msg && msg->len > mchan->req_buf_size) {
+		if (msg && msg->len > mchan->req_buf_size && mchan->req_buf) {
 			dev_err(dev, "channel %d message length %u > max %lu\n",
 				mchan->chan_type, (unsigned int)msg->len,
 				mchan->req_buf_size);
 			return -EINVAL;
 		}
-		if (msg && msg->len)
+		if (msg && msg->len && mchan->req_buf)
 			memcpy_toio(mchan->req_buf, msg->data, msg->len);
 		/* Kick IPI mailbox to send message */
 		arg0 = SMC_IPI_MAILBOX_NOTIFY;
 		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, &res);
 	} else {
 		/* Send response message */
-		if (msg && msg->len > mchan->resp_buf_size) {
+		if (msg && msg->len > mchan->resp_buf_size && mchan->resp_buf) {
 			dev_err(dev, "channel %d message length %u > max %lu\n",
 				mchan->chan_type, (unsigned int)msg->len,
 				mchan->resp_buf_size);
 			return -EINVAL;
 		}
-		if (msg && msg->len)
+		if (msg && msg->len && mchan->resp_buf)
 			memcpy_toio(mchan->resp_buf, msg->data, msg->len);
 		arg0 = SMC_IPI_MAILBOX_ACK;
 		zynqmp_ipi_fw_call(ipi_mbox, arg0, IPI_SMC_ACK_EIRQ_MASK,
@@ -640,6 +649,126 @@ static int zynqmp_ipi_setup(struct zynqmp_ipi_mbox *ipi_mbox,
 	return 0;
 }
 
+/**
+ * versal_ipi_setup - Set up IPIs to support mixed usage of
+ *				 Buffered and Bufferless IPIs.
+ *
+ * @ipi_mbox: pointer to IPI mailbox private data structure
+ * @node: IPI mailbox device node
+ *
+ * Return: 0 for success, negative value for failure
+ */
+static int versal_ipi_setup(struct zynqmp_ipi_mbox *ipi_mbox,
+			    struct device_node *node)
+{
+	struct zynqmp_ipi_mchan *tx_mchan, *rx_mchan;
+	struct resource host_res, remote_res;
+	struct device_node *parent_node;
+	int host_idx, remote_idx;
+	struct device *mdev, *dev;
+
+	tx_mchan = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
+	rx_mchan = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
+	parent_node = of_get_parent(node);
+	dev = ipi_mbox->pdata->dev;
+	mdev = &ipi_mbox->dev;
+
+	host_idx = zynqmp_ipi_mbox_get_buf_res(parent_node, "msg", &host_res);
+	remote_idx = zynqmp_ipi_mbox_get_buf_res(node, "msg", &remote_res);
+
+	/*
+	 * Only set up buffers if both sides claim to have msg buffers.
+	 * This is because each buffered IPI's corresponding msg buffers
+	 * are reserved for use by other buffered IPI's.
+	 */
+	if (!host_idx && !remote_idx) {
+		u32 host_src, host_dst, remote_src, remote_dst;
+		u32 buff_sz;
+
+		buff_sz = resource_size(&host_res);
+
+		host_src = host_res.start & SRC_BITMASK;
+		remote_src = remote_res.start & SRC_BITMASK;
+
+		host_dst = (host_src >> DST_BIT_POS) * DEST_OFFSET;
+		remote_dst = (remote_src >> DST_BIT_POS) * DEST_OFFSET;
+
+		/* Validate that IPI IDs is within IPI Message buffer space. */
+		if (host_dst >= buff_sz || remote_dst >= buff_sz) {
+			dev_err(mdev,
+				"Invalid IPI Message buffer values: %x %x\n",
+				host_dst, remote_dst);
+			return -EINVAL;
+		}
+
+		tx_mchan->req_buf = devm_ioremap(mdev,
+						 host_res.start | remote_dst,
+						 IPI_BUF_SIZE);
+		if (!tx_mchan->req_buf) {
+			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
+			return -ENOMEM;
+		}
+
+		tx_mchan->resp_buf = devm_ioremap(mdev,
+						  (remote_res.start | host_dst) +
+						  RESP_OFFSET, IPI_BUF_SIZE);
+		if (!tx_mchan->resp_buf) {
+			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
+			return -ENOMEM;
+		}
+
+		rx_mchan->req_buf = devm_ioremap(mdev,
+						 remote_res.start | host_dst,
+						 IPI_BUF_SIZE);
+		if (!rx_mchan->req_buf) {
+			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
+			return -ENOMEM;
+		}
+
+		rx_mchan->resp_buf = devm_ioremap(mdev,
+						  (host_res.start | remote_dst) +
+						  RESP_OFFSET, IPI_BUF_SIZE);
+		if (!rx_mchan->resp_buf) {
+			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
+			return -ENOMEM;
+		}
+
+		tx_mchan->resp_buf_size = IPI_BUF_SIZE;
+		tx_mchan->req_buf_size = IPI_BUF_SIZE;
+		tx_mchan->rx_buf = devm_kzalloc(mdev, IPI_BUF_SIZE +
+						sizeof(struct zynqmp_ipi_message),
+						GFP_KERNEL);
+		if (!tx_mchan->rx_buf)
+			return -ENOMEM;
+
+		rx_mchan->resp_buf_size = IPI_BUF_SIZE;
+		rx_mchan->req_buf_size = IPI_BUF_SIZE;
+		rx_mchan->rx_buf = devm_kzalloc(mdev, IPI_BUF_SIZE +
+						sizeof(struct zynqmp_ipi_message),
+						GFP_KERNEL);
+		if (!rx_mchan->rx_buf)
+			return -ENOMEM;
+	} else {
+		/*
+		 * If here, then set up Bufferless IPI Channel because
+		 * one or both of the IPI's is bufferless.
+		 */
+		tx_mchan->req_buf = NULL;
+		tx_mchan->resp_buf = NULL;
+		tx_mchan->rx_buf = NULL;
+		tx_mchan->resp_buf_size = 0;
+		tx_mchan->req_buf_size = 0;
+
+		rx_mchan->req_buf = NULL;
+		rx_mchan->resp_buf = NULL;
+		rx_mchan->rx_buf = NULL;
+		rx_mchan->resp_buf_size = 0;
+		rx_mchan->req_buf_size = 0;
+	}
+
+	return 0;
+}
+
 /**
  * zynqmp_ipi_free_mboxes - Free IPI mailboxes devices
  *
@@ -749,6 +878,9 @@ static const struct of_device_id zynqmp_ipi_of_match[] = {
 	{ .compatible = "xlnx,zynqmp-ipi-mailbox",
 	  .data = &zynqmp_ipi_setup,
 	},
+	{ .compatible = "xlnx,versal-ipi-mailbox",
+	  .data = &versal_ipi_setup,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, zynqmp_ipi_of_match);
-- 
2.25.1


