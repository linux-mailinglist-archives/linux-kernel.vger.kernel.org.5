Return-Path: <linux-kernel+bounces-23936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9032082B428
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9AB71C242F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFD8524DA;
	Thu, 11 Jan 2024 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r0la76U2"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7939B54673;
	Thu, 11 Jan 2024 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mel7SgFBo8wk5Gf5b4ZZLhEzaubLXQSS6GtOp3VCj9PZ/9sqIoJpI4/jYnAHj2RSQxIw+gYXRs1NzHyEO8XeKf8x+D+N+944phpK3D2MySDpFOaVBIF/RlEiPAOylREVbrw/tkbZWz7xjHh8He9IBz2x1DU5S9hoTdP7SslL8mgceybIz4t4kJXEY67rEMiHrfxmEWjW36kV4Lv5xgfMQyGSjxvNmgCZ1Hn2zMCMUCt/xLFasgNemagNfCJ6plO7wdCMojoK6PI8hrpcljYq8vltOJAc6W4CHsNfm5cqA0pFq6xuEWvzEKokqabOUbpRMM3NOHpbZmJfq4truX4tLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dywe+bq4oDsPA/32NleuX+z3bg1jFmBJvUu5snqjySk=;
 b=TPgvM07cpEc3SGJOkkFBd5NQxCkMvICt1D6KThAOEdpvB4wAJmJDcAevJNcwGoxQKXbdDXeY6lQF0D0ARZXWbf9dNy6IhdrKyB+NfMTXYU7ORnw0Hkpn/bB7CeRqWLZ2eWweaXml7S3ZF36wn4LFcHByqZ+sAux8nueYNxX8ee3tp7k/hiwBN5XmBObOOo+JtpF8m7yNqpRDUISVBHad5KzOfN1+GM8f7eJ1A+5nHA3pHGgVGfTypHm4UmCtt+zUC8km98KmwQ+NmsLhaHFU1H0AbtJ1NKzImqKCQ9uIb1VgcFKECZcaBB+nyJ9JI8CGWIH8goyPQYkc5S0zLKxtgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dywe+bq4oDsPA/32NleuX+z3bg1jFmBJvUu5snqjySk=;
 b=r0la76U23tl7iW4EwWNRMxRETQn57Gma2OOLDk1/ctW7hyTfWAg0Of7ZcfrFc/gSIjhcRb3UE6wivZ2kB8YOILr4Uvn7+VznK7lU+OgnoULQ3j5B8n6Ay0SoKezww36kfcKIyxdtnhJh+VBWKVCbG7UsGc9RtVV98EhJvWvXGyJ4eeHDzekhOnJkigjojEYaUJNScyOBKgw9G9mmIk+7TIibNB0thZ73m51C/XpHFfgaMvrExOPTdR0YZKPdM242ymjS9SqoF7j/h9ul8JaUiTAFv9m2cJCgXB31WX+9fW+M5IopsJmYhHKWCBzYxDxsLhZtPkpcO6yPx4gq3Z8y9g==
Received: from PH0PR07CA0067.namprd07.prod.outlook.com (2603:10b6:510:f::12)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 17:31:29 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::95) by PH0PR07CA0067.outlook.office365.com
 (2603:10b6:510:f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Thu, 11 Jan 2024 17:31:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 17:31:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 11 Jan
 2024 09:31:10 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 11 Jan
 2024 09:31:09 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Thu, 11 Jan
 2024 09:31:08 -0800
From: Liming Sun <limings@nvidia.com>
To: Vadim Pasternak <vadimp@nvidia.com>, David Thompson
	<davthompson@nvidia.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross
	<markgross@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
CC: Liming Sun <limings@nvidia.com>, <platform-driver-x86@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3] Drop Tx network packet when Tx TmFIFO is full
Date: Thu, 11 Jan 2024 12:31:06 -0500
Message-ID: <20240111173106.96958-1-limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <f250079635da4ba75c3a3a1d7c3820f48cfc3f06.1704380474.git.limings@nvidia.com>
References: <f250079635da4ba75c3a3a1d7c3820f48cfc3f06.1704380474.git.limings@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f92c33c-9a3d-4722-049e-08dc12cb2526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8dH7riuGLApHzVl1Egf/N6XYGec/lU0NIVEFeJaKWSQEt+KqRDuEEdqP7B6OmHRPEePX6iwO249VuvUxbqdFGM2zUCFilw5sZJ7oYK5FXKxnvkMFxyugfBsnA8nH9hF5VllVeYh0E68vztYwLE6sxdU2mphhBx79mEoxcKeokaQ1wgx/7qdE3Sv1DhoZ+CpISR7VFPCsoTZhicvDhTisgT2LBGnUR6TNA/NbXtUaAnt4sNYDegIR6wFNHuWDkjCa5GYMA7wMICWHDyKi+k9nZpgnzfw+i1a3uyqxXnbd332Y0FpzE7uBH9RKSyPZm/qp3ukw0AjSKF/GrFe03wgRpz3VOYCC7YYNWIhvx6hzKKvQbxbrpfRF1G5O27aDNQ6CeXd3EnYGfJHuHykeduimXfU3rhrGP6dbys6cOnd86Fq8CiArHfaxHbTNYwxiO6yL3sSrq9sIMOgAwUFqUkMuz1JvsBr4AjWOSRRnUCXSVzTpbD580Y+A+A5DYFQPYH55pXx8TVLoHVDjR123WXFHTMtF4+BXCdSkNkJySSGDYX28CVU9VksP4XeX3l+xsP/bJOgi8AEf6CUJKXA2in9z8YHo5I3gKRdCB3+OHGbrwMoDNx3vaCl9uTMjJxIsfdxHBywqq/mdSUc5SisHRRc/M/nB9BZv2MXTZ2VriLUkCxDPuarHiR0v68sS8rzC0n3RsIl/Z7aWJnQRrSx4C8tFoJ6JaNr8BuseRk5VRGEgg5775EVfuwZgGbRmHE+yahZCOep1LB2Ijzr2lq+M3PcSHNwTK+Ymq2p5Ncl/dijEh9yu4V96YUnYkk9Vyt0z3ZiS
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230273577357003)(230173577357003)(230922051799003)(82310400011)(64100799003)(451199024)(1800799012)(186009)(46966006)(36840700001)(40470700004)(41300700001)(2616005)(26005)(336012)(426003)(478600001)(7696005)(36756003)(7636003)(86362001)(82740400003)(356005)(83380400001)(47076005)(36860700001)(2906002)(1076003)(40460700003)(8936002)(70586007)(110136005)(70206006)(54906003)(316002)(5660300002)(8676002)(4326008)(40480700001)(21314003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 17:31:28.9271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f92c33c-9a3d-4722-049e-08dc12cb2526
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601

Starting from Linux 5.16 kernel, Tx timeout mechanism was added
in the virtio_net driver which prints the "Tx timeout" warning
message when a packet stays in Tx queue for too long. Below is an
example of the reported message:

"[494105.316739] virtio_net virtio1 tmfifo_net0: TX timeout on
queue: 0, sq: output.0, vq: 0×1, name: output.0, usecs since
last trans: 3079892256".

This issue could happen when external host driver which drains the
FIFO is restared, stopped or upgraded. To avoid such confusing
"Tx timeout" messages, this commit adds logic to drop the outstanding
Tx packet if it's not able to transmit in two seconds due to Tx FIFO
full, which can be considered as congestion or out-of-resource drop.

This commit also handles the special case that the packet is half-
transmitted into the Tx FIFO. In such case, the packet is discarded
with remaining length stored in vring->rem_padding. So paddings with
zeros can be sent out when Tx space is available to maintain the
integrity of the packet format. The padded packet will be dropped on
the receiving side.

Signed-off-by: Liming Sun <limings@nvidia.com>
---
v2->v3:
  Updates for Ilpo's comments:
  - Revises commit message to avoid confusion.
v2: Fixed formatting warning
v1: Initial version
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 67 ++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 5c683b4eaf10..f39b7b9d2bfe 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -47,6 +47,9 @@
 /* Message with data needs at least two words (for header & data). */
 #define MLXBF_TMFIFO_DATA_MIN_WORDS		2
 
+/* Tx timeout in milliseconds. */
+#define TMFIFO_TX_TIMEOUT			2000
+
 /* ACPI UID for BlueField-3. */
 #define TMFIFO_BF3_UID				1
 
@@ -62,12 +65,14 @@ struct mlxbf_tmfifo;
  * @drop_desc: dummy desc for packet dropping
  * @cur_len: processed length of the current descriptor
  * @rem_len: remaining length of the pending packet
+ * @rem_padding: remaining bytes to send as paddings
  * @pkt_len: total length of the pending packet
  * @next_avail: next avail descriptor id
  * @num: vring size (number of descriptors)
  * @align: vring alignment size
  * @index: vring index
  * @vdev_id: vring virtio id (VIRTIO_ID_xxx)
+ * @tx_timeout: expire time of last tx packet
  * @fifo: pointer to the tmfifo structure
  */
 struct mlxbf_tmfifo_vring {
@@ -79,12 +84,14 @@ struct mlxbf_tmfifo_vring {
 	struct vring_desc drop_desc;
 	int cur_len;
 	int rem_len;
+	int rem_padding;
 	u32 pkt_len;
 	u16 next_avail;
 	int num;
 	int align;
 	int index;
 	int vdev_id;
+	unsigned long tx_timeout;
 	struct mlxbf_tmfifo *fifo;
 };
 
@@ -819,6 +826,50 @@ static bool mlxbf_tmfifo_rxtx_one_desc(struct mlxbf_tmfifo_vring *vring,
 	return true;
 }
 
+static void mlxbf_tmfifo_check_tx_timeout(struct mlxbf_tmfifo_vring *vring)
+{
+	unsigned long flags;
+
+	/* Only handle Tx timeout for network vdev. */
+	if (vring->vdev_id != VIRTIO_ID_NET)
+		return;
+
+	/* Initialize the timeout or return if not expired. */
+	if (!vring->tx_timeout) {
+		/* Initialize the timeout. */
+		vring->tx_timeout = jiffies +
+			msecs_to_jiffies(TMFIFO_TX_TIMEOUT);
+		return;
+	} else if (time_before(jiffies, vring->tx_timeout)) {
+		/* Return if not timeout yet. */
+		return;
+	}
+
+	/*
+	 * Drop the packet after timeout. The outstanding packet is
+	 * released and the remaining bytes will be sent with padding byte 0x00
+	 * as a recovery. On the peer(host) side, the padding bytes 0x00 will be
+	 * either dropped directly, or appended into existing outstanding packet
+	 * thus dropped as corrupted network packet.
+	 */
+	vring->rem_padding = round_up(vring->rem_len, sizeof(u64));
+	mlxbf_tmfifo_release_pkt(vring);
+	vring->cur_len = 0;
+	vring->rem_len = 0;
+	vring->fifo->vring[0] = NULL;
+
+	/*
+	 * Make sure the load/store are in order before
+	 * returning back to virtio.
+	 */
+	virtio_mb(false);
+
+	/* Notify upper layer. */
+	spin_lock_irqsave(&vring->fifo->spin_lock[0], flags);
+	vring_interrupt(0, vring->vq);
+	spin_unlock_irqrestore(&vring->fifo->spin_lock[0], flags);
+}
+
 /* Rx & Tx processing of a queue. */
 static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
 {
@@ -841,6 +892,7 @@ static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
 		return;
 
 	do {
+retry:
 		/* Get available FIFO space. */
 		if (avail == 0) {
 			if (is_rx)
@@ -851,6 +903,17 @@ static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
 				break;
 		}
 
+		/* Insert paddings for discarded Tx packet. */
+		if (!is_rx) {
+			vring->tx_timeout = 0;
+			while (vring->rem_padding >= sizeof(u64)) {
+				writeq(0, vring->fifo->tx.data);
+				vring->rem_padding -= sizeof(u64);
+				if (--avail == 0)
+					goto retry;
+			}
+		}
+
 		/* Console output always comes from the Tx buffer. */
 		if (!is_rx && devid == VIRTIO_ID_CONSOLE) {
 			mlxbf_tmfifo_console_tx(fifo, avail);
@@ -860,6 +923,10 @@ static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
 		/* Handle one descriptor. */
 		more = mlxbf_tmfifo_rxtx_one_desc(vring, is_rx, &avail);
 	} while (more);
+
+	/* Check Tx timeout. */
+	if (avail <= 0 && !is_rx)
+		mlxbf_tmfifo_check_tx_timeout(vring);
 }
 
 /* Handle Rx or Tx queues. */
-- 
2.30.1


