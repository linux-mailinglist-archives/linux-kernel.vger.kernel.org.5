Return-Path: <linux-kernel+bounces-16833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C34982449D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825971C22155
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9386224B28;
	Thu,  4 Jan 2024 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cUp25mOO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD1B24A0C;
	Thu,  4 Jan 2024 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtEiR9O1tmGyHDRc4GrYRkKWN0wIPtxm1VDZWghKIjlXZLBHxeQx3qWpnzKleANoSaLJKqGq9jkqT6md4SPUR0sCXPeLFGGuTPtVzedOAd0m+tecs7mEs38YxrArnIF2E3gjqsbbsDIWNVJRp4tRvn9TKhvhPahAlm42rNgfvbJHadnHNXC4OKxFj54T/K3QAmy6aq1BxVXdev1cdzIFjFbAERg+ZvdKmnerZ6zrqj6EoiNqTY+rrLpO2Y/0iwgQsfyBEENmTQxqSYMWbB7p+zvarE31U7m1Cz4ABGn5ZUVhauR5v6+RkaKE2zN8Ff6EGMfYgQBlbVqG88QLZg8rGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsVr28K7bOlt8PeqfFwv/0qZReEWmvOWBUHvqgYZKhA=;
 b=CFj6R+tZUIvtykPlkM1pH4dA5o5LwxmqsHmK5xarNpDm6oEOdYpHffIE9FUEWw2l1eTjo/8BbnGTe4AoWTuLywV9wm6WwocdA3Z0il7ZylI/4CRGHP+tCunoZYA9vxo1wrxNXzovesy19DdHkoYXoiiOhai4YagiY1nF0WZ+ENvkr52N+t7hNO06WdsoC0oiWSjCWOygF21IfbJL611C54RlIVEk3oKCKjKeKh6xP8cWB4MGXwlrasEg7cMzfLLoJvhyq7BCkYiAug7qOII2dgrDP49r0N/bGCDQjFVX02pmEws7TOjZNwxoWPG3KqitDn0by1NWemeNZL/as8MVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsVr28K7bOlt8PeqfFwv/0qZReEWmvOWBUHvqgYZKhA=;
 b=cUp25mOOxtpiegJjTGJTAyUK/Dpp3nQ76qvr6GIpQc0M7e5pZ1cekEcxfxG3XRVwADxIQ4+a9miziVqXtJPPhEqUeWwrkFpAwN6pFBCfK3NfaH7XDCtlTAC/MkmF9lPCzBGec9GJfP204DEcoBc883bbUvyIHnztUmR6xJrAwTSCo+PTcI50c8PfLaa1Bp8mrzuOgAxnAMyg/auA+tcHwlExArKJHUfKO/fkgNFG4uBCdsepWHpw2wFuFKK4+CJSOMyCtgiIdYBj6PMsgz8qhU0djfx2Hmj8l/fhn6hFueFGJvMgvDMspFPaq6njnYDYinkJIrNeBXmaAjgad2LQAQ==
Received: from BL1PR13CA0096.namprd13.prod.outlook.com (2603:10b6:208:2b9::11)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.23; Thu, 4 Jan
 2024 15:04:53 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::98) by BL1PR13CA0096.outlook.office365.com
 (2603:10b6:208:2b9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 15:04:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 15:04:53 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Jan 2024
 07:04:33 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 4 Jan 2024 07:04:33 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 4 Jan 2024 07:04:32 -0800
From: Liming Sun <limings@nvidia.com>
To: Vadim Pasternak <vadimp@nvidia.com>, David Thompson
	<davthompson@nvidia.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross
	<markgross@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
CC: Liming Sun <limings@nvidia.com>, <platform-driver-x86@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] Drop Tx network packet when Tx TmFIFO is full
Date: Thu, 4 Jan 2024 10:04:24 -0500
Message-ID: <f250079635da4ba75c3a3a1d7c3820f48cfc3f06.1704380474.git.limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db26d72-499a-4127-e203-08dc0d3681de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iSA0GOAjE8kJ1Db2M5kILSXDY6DzbqrXBer5Pw6K6VFTe4kfDAKBxafCrrP//IQThfw/4MZQKU7Afp1ZPMw9tGHiCJVz+1YT4yTBbN0GSJf6nBtPXg2ioH1WRKBTi/9fpSeeL+xu+wajKFL/fFdJHRqlwXTvJdgMEhR4EPCoACY81yHEqZgGPLXKCI12DPC3X31LEcxw7xzeQcXiBVkEecw9c0Zrby/s1aT2RrbSPiZlRJqHKkLNvxjE7YYR8OychfU3WfGLwMpwnojozrBTVtWb/4IWANkbHNK2cjA590ke2l3AaHeIukFdCnuecZOHxEGGtK6PSbj7P2XmGW8Wl1dMSlYd4kxbJydH7pxPf4Abu/6vn9lT00Tf6O9ZqyhCREuBdhBCyxZXZY3sj6tAEun1WI2z2BvMkx0dy2/rj9xdnDR1b5xdJ6ANLA8cFEESAMtrKmkqzSBoGeeQiapyHcVZ3cnsQwS9TYL1HUwFsjtuN45Yfe7Wva5FM/jmJDmN8fRMGD8GVPhsgYIzPw0VMP0GnCwPmUzuwvjP1cMWpBd8SEuBWJhTCJjsUs9g+xLmlAF3eh1NmJoZPHh67tpZnJWZtWiGU36aov5g21qKFSpuMXtvWAmC+jOXQRwKzItv9caAw/QmuY6xQYKegFKkwFeacJmqBKxB0RubUUuJQFXQbyEUKS++ZoHNDtJvPjsMCViQZU1jMPSc+4wCPFk9nYKxfY6+/Zy/bQh70kosHysfj79zsIaDEjTVybd2HtiopootZWijFHqyAiSt8Xzh6VxwjGDGaa27iaSFlYwSamNFMvyWIgYorw2cbhH03cPP
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230273577357003)(230173577357003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(36840700001)(46966006)(40470700004)(47076005)(40480700001)(316002)(7696005)(7636003)(110136005)(86362001)(54906003)(4326008)(40460700003)(8936002)(70206006)(70586007)(36756003)(356005)(8676002)(6666004)(36860700001)(5660300002)(478600001)(26005)(2616005)(41300700001)(336012)(426003)(2906002)(83380400001)(82740400003)(21314003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 15:04:53.6155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db26d72-499a-4127-e203-08dc0d3681de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671

Starting from Linux 5.16 kernel, Tx timeout mechanism was added
into the virtio_net driver which prints the "Tx timeout" message
when a packet is stuck in Tx queue for too long which could happen
when external host driver is stuck or stopped and failed to read
the FIFO.

Below is an example of the reported message:

"[494105.316739] virtio_net virtio1 tmfifo_net0: TX timeout on
queue: 0, sq: output.0, vq: 0×1, name: output.0, usecs since
last trans: 3079892256".

To avoid such "Tx timeout" messages, this commit adds a timeout
mechanism to drop and release the pending Tx packet if not able to
transmit for two seconds due to Tx FIFO full.

This commit also handles the special case that the packet is half-
transmitted into the Tx FIFO. In such case, the packet is discarded
with remaining length stored in vring->rem_padding. So paddings with
zeros can be sent out when Tx space is available to maintain the
integrity of the packet format. The padded packet will be dropped on
the receiving side.

Signed-off-by: Liming Sun <limings@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 67 ++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 5c683b4eaf10..47ed2a6027a6 100644
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
+         * Drop the packet after timeout. The outstanding packet is
+         * released and the remaining bytes will be sent with padding byte 0x00
+         * as a recovery. On the peer(host) side, the padding bytes 0x00 will be
+         * either dropped directly, or appended into existing outstanding packet
+         * thus dropped as corrupted network packet.
+         */
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


