Return-Path: <linux-kernel+bounces-23929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEF782B401
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01CFF1F23340
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0809153E37;
	Thu, 11 Jan 2024 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jnWVSRFA"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4CD52F7B;
	Thu, 11 Jan 2024 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Io+5qOyDHbxOuRk3tl0Yvz1iQS646avmBAj3hL28wZtTE8P8wmV30fsL0HHw61NpuDHaCMnMpbVdCeb9+6MUOrrS06QCltk+PusGCPUPNRtIfe5hAKNUrIPOdEgc20h47JGN2PjLkB7RnnC7y7khha+vZyDiErZbfOGGa++Ks4kz45wl0Eda0W3aKcNE5RXmhK0IxHAwGNeSiZYavpgsS4nzNnG509h0DXcpZXKmJtgf+PJ4OyfklDOU4GINd4KdW2bvthgdd8HrL0S1OCkzQfUdmWgNslLYctrJswkIYOJw6OaZrUA9emDfib+oCYH4/bLTwd1PJozbbrAD1CgPoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7hjYKVewll6cWe/pWI6xUYo78ow+vkxPjGWO3wZ8Rw=;
 b=JCcyrSFGWy4oe6zdpAiKY+mbguYXEey3wKNiEikiqvKknZILwNSLYWON+adu+CQL5x+uL35eOJUtploEUFm5AasdnNaf+iT4Jy7WQXLFcg97a8tASmxvu9FTuP84sKGYzMpKp0mnjDYogohV2gzCsq515pj5oIjj9yx2FKeVindXqklecWtlo+MOw1qNkuC3XnDQbesKG9oixbIW4je2YFp4FD/bxZhbw1I+bOVKYKWmHpNLe2HzWWeGvvqZAtI9wWTewjtuJZDDBB5fnC1HuHePNe1AMLweNa1nK04xOw5ddDXLXVTxq/ZRGSdgwhpnoNVsPsJCwiebweiaKxpXTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7hjYKVewll6cWe/pWI6xUYo78ow+vkxPjGWO3wZ8Rw=;
 b=jnWVSRFAM98LvX62E1Mm/i6x+lKRz1jUkKb9q7cFIjRymI946wyLGePC3fo5l/S1KVQ6wZGyQ2XL4O6AJBH6exACtfY6DK591VthfaH6K69s/PEVm6KGnuwCnYyw4XfsGWHksaSZlpzZuGyak/6UDXy+Y8wurikPNrQuUoPGXls=
Received: from PA7P264CA0289.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:370::6)
 by CYYPR12MB8653.namprd12.prod.outlook.com (2603:10b6:930:c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 17:22:32 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10a6:102:370:cafe::9d) by PA7P264CA0289.outlook.office365.com
 (2603:10a6:102:370::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Thu, 11 Jan 2024 17:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 17:22:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 11:22:30 -0600
Received: from xsjblevinsk50.xilinx.com (172.19.2.206) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 11 Jan 2024 11:22:29 -0600
From: Ben Levinsky <ben.levinsky@amd.com>
To: <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <shubhrajyoti.datta@amd.com>,
	<jaswinder.singh@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ben.levinsky@amd.com>
Subject: [PATCH v2 3/3] mailbox: zynqmp: Enable Bufferless IPI usage on Versal-based SOC's
Date: Thu, 11 Jan 2024 09:22:26 -0800
Message-ID: <20240111172226.1816105-4-ben.levinsky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|CYYPR12MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: 4713882b-57dc-4ca0-5606-08dc12c9e44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MOSaXF+KDk4+fTNXTJv5fQwIJ6e4jKJzxsIljECdikpHadbQRKUSZIQhS5gU0h6oSQwpA1zFxtyxO1Fobea0yVnzMfDM3iQE7lhaPqSdTAcbYhDhH7IG/ViAWQ2u/rg9yRobILjOgfYgxF6C1942KYPRnEt9KcttkZiLtrrqal+ATSz7EPx3/z4CHGqWpEX6io/73hRBAVvfKUaKPHeAEAOPGuJdkI05SIjPnnu2d4d/VpWWf9zFO03fNX/1hJIdHCs0AFgAjDZlc/IHJUhxdOcVnrVh3dh1asKkYe8M9TnLiXAjDV9vIVVsEGAo6uTRsLzJzYcsAW6VZ4G8Pay3Y4AD7vpbk5piSm1TanB59dJ6l4F8mMtqSESrfwe1XAgz6tS6SFO9yl7YMEdRGhKq0AJKCons1k0SLTU+GDxePfwedrJbhWdFNlJLTMqDdE5kn+nxSCpmfjneeH5kjcGnBbIx7cJ+pX5316zXmNSKyKqLvMgTs4NbA+ygyh4rtVBke4TGIJdIW5IH4TLIHqdWNZO/cH4Iqw7QTR1yMsX2a2OJFfuw53V+Tw1ryQSJY92snlpEqxfn5Wp2+/cPKI1QmYjObPyXD4sIz6TCL7Uae19b7qayLVu36DaizlM5JdalespcpKWZ7E8jWKwf02tOf40GvaC6YbsU7miEpqfFee/aw+i7NlKo9P564JoQWTWhAxhty097+MBC6Be+B/4V09fW0dYA4x8eqUxdoCE0VWL+tEVEaFSfL1BNxLKyz16TbZx414dIbdzA/gF2PEbDgj2lxDM+T4Bqvg7aGdjPH8qOBnfCBlFE5KO9l92/Bh8r
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(83380400001)(26005)(43170500006)(336012)(54906003)(1076003)(2616005)(36860700001)(47076005)(426003)(82740400003)(15650500001)(44832011)(8676002)(8936002)(4326008)(2906002)(5660300002)(478600001)(110136005)(6666004)(41300700001)(70206006)(70586007)(81166007)(316002)(86362001)(36756003)(356005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 17:22:30.6946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4713882b-57dc-4ca0-5606-08dc12c9e44a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8653

On Xilinx-AMD Versal and Versal-NET, there exist both
inter-processor-interrupts with corresponding message buffers and without
such buffers.

Add a routine that, if the corresponding DT compatible
string "xlnx,versal-ipi-mailbox" is used then a Versal-based SOC
can use a mailbox Device Tree entry where both host and remote
can use either of the buffered or bufferless interrupts.

Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 130 +++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 720da91b9efd..d5092c9ed180 100644
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
@@ -639,6 +648,110 @@ static int zynqmp_ipi_setup(struct zynqmp_ipi_mbox *ipi_mbox,
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
+	}
+
+	return 0;
+}
+
 /**
  * zynqmp_ipi_free_mboxes - Free IPI mailboxes devices
  *
@@ -748,6 +861,9 @@ static const struct of_device_id zynqmp_ipi_of_match[] = {
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


