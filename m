Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0F87ECAFE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjKOTIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjKOS5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:57:34 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9FCDC;
        Wed, 15 Nov 2023 10:57:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WibMDIKWkPz6BVNmHVnFugUMFIkG81Vc8z1OqJOBpYzG2jrpUmIsopuT427g6wo8rGuv2+/It7e2+2fRJoctNHlvSLPyme92uNKRbmjmSSFejMrTV23pjgT8JAGuxy4BpRuFj/TBL/osn73kb3yXMz+1FnXGOJEzWODOexEOlYTFAmILi3A+IVR31KhTxP628JHv8YjiZNFQDnEbw7hLrdNKfmrqXrR4VRtHPLs4DNj9Kx2W3bzc9tXOXe8ky/uKf/kBvoAC1rhGVVbTOEgRLt2bO991MqwgJx5OseWkyxatH1I/EpVvxXttUxOGI/tMSQwsS5APi+rIzCFSLj0knw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UMcTflwaSmjLaYRDQePXOhsnGSlfZHfbgmKzKtUays=;
 b=NQjrumRXFXMNeecZAXbrhMVCd7Zk0bGIUHw/RK/W8r6086pXVmXuz5udsefUbZkZOP90Q4td3NlqGO7OQFoP+nICfUWa3EugFBLfAsYHArGvaNEqzsA6Lli6I6Keb/21WqcFwEd9CjJAfw6aP7L/yeME59Ripl5P9fs2LvT/ypmfhnnMoALlanVyAyxCIyKK02QT+PTrG0H3jMo8Z1y1ofSIulsAdfG1nYsfttGeiYFFAxlNf9jiRbEtLtPXx8YmXgm+VQU2z6arxCH6+zqEo+5FFpCV/eQZ5xmmSVJZUdWQ7wC+lZbyNYXmMd4dblj5w0n9O2ZO6pieH4XBjlYJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UMcTflwaSmjLaYRDQePXOhsnGSlfZHfbgmKzKtUays=;
 b=3YKviFB3DwXGjchqR2rh9eZyxyDSn1mzrYsMViQCfNdzEKeyOnpsA/N09vwo6Cvwza/35wMVHSz90U/2kDYuYpwCFM3U0tH3QgJW1iaaflVhWSpSUaDWuCoxAkExeKdFXtEg+aGSevWgU/GIIZ09NVRbsBhUoJk2VskmN13Uh5Y=
Received: from BL1PR13CA0310.namprd13.prod.outlook.com (2603:10b6:208:2c1::15)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 18:57:23 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::ae) by BL1PR13CA0310.outlook.office365.com
 (2603:10b6:208:2c1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 15 Nov 2023 18:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 18:57:22 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 12:57:22 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 10:57:22 -0800
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Wed, 15 Nov 2023 12:57:18 -0600
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <radhey.shyam.pandey@amd.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <linux@armlinux.org.uk>, <anirudha.sarangi@amd.com>,
        <harini.katakam@amd.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH net-next v9 3/3] net: axienet: Introduce dmaengine support
Date:   Thu, 16 Nov 2023 00:26:53 +0530
Message-ID: <1700074613-1977070-4-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1700074613-1977070-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1700074613-1977070-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f53490c-1991-4219-552b-08dbe60cb38e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eiay+HLxfaogu3eLWDS0SDq5s9OIMkwZJejqAsyacJBdaVLzEmt4y/rz8VnXco8ngD+hnvloV6lJenkvDdlFWKwGX0GGxpC+d4QN+SuPCPfpHH1ZNvxRyzvo16oDRwk/nBFxXMzV/uDSQgS5wAkCcdJa3HBr1NZxgH/nsnXZH+ZltWaKImpEhe88yhRZB16ZpxVSJQtRio6he2G/k8D8p7gCiWqM1tyUbPQl7Qjy8jzP9wRi1/NH2yf93WLFLojvtZte30+QqBX1IQcbV8hRmu/1bD4oVdRN6kNxwQ7xjmWu+OrwGQk8fGfv661XB0e/aHOHP6mnnlFd0Ac7QtQpgrzL5c5POvMwDsOwiPofD0INEf5/nCULrFUunAuM+vH8HiNqp93PD+LGunLZ2FlLWG94ldR+gRqHC+Rh+wy7Aod2rvYFztHuh5Jidilt2pXdrTklpOX3qnjOiLkWoJEpCEixV6Mmt2qx/LZidGZXhMKog6f/PBqG2S/kwodrjFX/f1GZPUf0F996LLVcd08sSF+YwQf6C7ze/R5HwcLiIqRMkKqNMwX+9FIkZqAWePHfwC6CIpbeRGWGRSzz9pgEZeHPRLqc+rOdiuybCRGEkpNzxlW7EePUF1jfJjDxJZNjEOJq7Ey0C5xYpTzF4JZy4GfENkoBehPZYMHtK95EA9D5OmLGUEvBWJdQu6KbMqoCAYnpxDBZshVqQ3toz8Dz1/0rZTPo+pEwU08m0hpydsBpJUZwuKAT9hQ+6lybmQ1uXOKyITiAp3TWGCKFgM5HWqzwi682hREw7P98hac916M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(356005)(40460700003)(921008)(36756003)(426003)(336012)(2906002)(30864003)(26005)(83380400001)(81166007)(82740400003)(47076005)(36860700001)(86362001)(41300700001)(7416002)(2616005)(5660300002)(478600001)(40480700001)(70586007)(6636002)(316002)(54906003)(70206006)(110136005)(6666004)(8676002)(8936002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 18:57:22.8565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f53490c-1991-4219-552b-08dbe60cb38e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dmaengine framework to communicate with the xilinx DMAengine
driver(AXIDMA).

Axi ethernet driver uses separate channels for transmit and receive.
Add support for these channels to handle TX and RX with skb and
appropriate callbacks. Also add axi ethernet core interrupt for
dmaengine framework support.

The dmaengine framework was extended for metadata API support.
However it still needs further enhancements to make it well suited for
ethernet usecases. The ethernet features i.e ethtool set/get of DMA IP
properties, ndo_poll_controller,(mentioned in TODO) are not supported
and it requires follow-up discussions.

dmaengine support has a dependency on xilinx_dma as it uses
xilinx_vdma_channel_set_config() API to reset the DMA IP
which internally reset MAC prior to accessing MDIO.

Benchmark with netperf:

xilinx-zcu102-20232:~$ netperf -H 192.168.10.20 -t TCP_STREAM
MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET
to 192.168.10.20 () port 0 AF_INET
Recv   Send    Send
Socket Socket  Message  Elapsed
Size   Size    Size     Time     Throughput
bytes  bytes   bytes    secs.    10^6bits/sec

131072  16384  16384    10.02     886.69

xilinx-zcu102-20232:~$ netperf -H 192.168.10.20 -t UDP_STREAM
MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET
to 192.168.10.20 () port 0 AF_INET
Socket  Message  Elapsed      Messages
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

212992   65507   10.00       15851      0     830.66
212992           10.00       15851            830.66

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v9:
- Use the reverse x-mas tree order.
- In axienet_start_xmit_dmaengine() create drop_skb label to reuse exit
  error handling.
- Implement advance stopping and waking netdev queues and update perf
  numbers in commit description.
- Make axienet_start_xmit_dmaengine() return void.

Changes for v8:
- Use dev_consume_skb_any() in transmit callback.
- Fix queue stop logic in _xmit_dmaengine().
- Fix skb leak in _xmit_dmaengine() error path.
- In dmaengine tx path use dma_device pointer to call prep_slave_sg.
- In rx submit use rate limiting for mapping errors and fix error
  handling.
- Revert dev_err_probe from _init_dmaengine().
- Remove unnecessary new line after call to _init_dmaengine().
- Move free_irq(lp->eth_irq) to error path.
- Have separate netdev_ops for dmaengine flow.
- Improve axienet_dma_tx_cb and axienet_rx_submit_desc documentation.

Changes for v7:
- Fix comment spaces.
- In xmit use correct XAE_FEATURE_PARTIAL_TX_CSUM define.
- Rename app to app_metadata.
- Switch to __netif_rx.
- In axienet_rx_submit_desc() add mapping error handling.

Changes for v6:
- Rename struct axi_skbuff to skbuf_dma_descriptor and removed
  __packed attribute.
- Drop kmem_cache implementation and switch to using ring buffers.
- Remove __inline from axienet_init_dmaengine().
- Name labels after the target.
- Add error check for platform_get_irq_optional().
- Fix double space and no empty lines between call and its error check.

Changes for v5:
- Switch to amd.com email
- Modified commit description. Remove lore link, mention reset API,
  add performance numbers.
- Fix kmem_cache resource leak on stop.
- Use dmaengine_terminate_sync instead of deprecated
  dmaengine_terminate_all API.

Changes for v4:
- Remove the AXIENET_USE_DMA.
- Add dev_err_probe for dma_request_chan error handling.
- Add kmem_cache_destroy for create in axienet_setup_dma_chan.
- Add XILINX_DMA dependency in ethernet drier Kconfig file.
- move setup_dma_channel to init_dmaengine func
- Remove unlikely
	if (unlikely(ret < 0))
- if (ret == 0) to if (!ret)
- Rename DMA_MEM_TO_DEV to DMA_TO_DEVICE
- Remove else check for lp->use_dmaengine = 1; in the probe.

Changes in V3:
- New patch for dmaengine framework support.
---
 drivers/net/ethernet/xilinx/Kconfig           |   1 +
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  33 ++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 393 +++++++++++++++++-
 3 files changed, 425 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
index 0014729b8865..35d96c633a33 100644
--- a/drivers/net/ethernet/xilinx/Kconfig
+++ b/drivers/net/ethernet/xilinx/Kconfig
@@ -26,6 +26,7 @@ config XILINX_EMACLITE
 config XILINX_AXI_EMAC
 	tristate "Xilinx 10/100/1000 AXI Ethernet support"
 	depends on HAS_IOMEM
+	depends on XILINX_DMA
 	select PHYLINK
 	help
 	  This driver supports the 10/100/1000 Ethernet from Xilinx for the
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 3ead0bac597b..807ead678551 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/if_vlan.h>
 #include <linux/phylink.h>
+#include <linux/skbuff.h>
 
 /* Packet size info */
 #define XAE_HDR_SIZE			14 /* Size of Ethernet header */
@@ -378,6 +379,22 @@ struct axidma_bd {
 
 #define XAE_NUM_MISC_CLOCKS 3
 
+/**
+ * struct skbuf_dma_descriptor - skb for each dma descriptor
+ * @sgl: Pointer for sglist.
+ * @desc: Pointer to dma descriptor.
+ * @dma_address: dma address of sglist.
+ * @skb: Pointer to SKB transferred using DMA
+ * @sg_len: number of entries in the sglist.
+ */
+struct skbuf_dma_descriptor {
+	struct scatterlist sgl[MAX_SKB_FRAGS + 1];
+	struct dma_async_tx_descriptor *desc;
+	dma_addr_t dma_address;
+	struct sk_buff *skb;
+	int sg_len;
+};
+
 /**
  * struct axienet_local - axienet private per device data
  * @ndev:	Pointer for net_device to which it will be attached.
@@ -436,6 +453,14 @@ struct axidma_bd {
  * @coalesce_count_tx:	Store the irq coalesce on TX side.
  * @coalesce_usec_tx:	IRQ coalesce delay for TX
  * @use_dmaengine: flag to check dmaengine framework usage.
+ * @tx_chan:	TX DMA channel.
+ * @rx_chan:	RX DMA channel.
+ * @tx_skb_ring: Pointer to TX skb ring buffer array.
+ * @rx_skb_ring: Pointer to RX skb ring buffer array.
+ * @tx_ring_head: TX skb ring buffer head index.
+ * @tx_ring_tail: TX skb ring buffer tail index.
+ * @rx_ring_head: RX skb ring buffer head index.
+ * @rx_ring_tail: RX skb ring buffer tail index.
  */
 struct axienet_local {
 	struct net_device *ndev;
@@ -501,6 +526,14 @@ struct axienet_local {
 	u32 coalesce_count_tx;
 	u32 coalesce_usec_tx;
 	u8  use_dmaengine;
+	struct dma_chan *tx_chan;
+	struct dma_chan *rx_chan;
+	struct skbuf_dma_descriptor **tx_skb_ring;
+	struct skbuf_dma_descriptor **rx_skb_ring;
+	int tx_ring_head;
+	int tx_ring_tail;
+	int rx_ring_head;
+	int rx_ring_tail;
 };
 
 /**
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 188b03e86263..7d8e22929385 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -38,6 +38,11 @@
 #include <linux/phy.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma/xilinx_dma.h>
+#include <linux/circ_buf.h>
+#include <net/netdev_queues.h>
 
 #include "xilinx_axienet.h"
 
@@ -47,6 +52,9 @@
 #define TX_BD_NUM_MIN			(MAX_SKB_FRAGS + 1)
 #define TX_BD_NUM_MAX			4096
 #define RX_BD_NUM_MAX			4096
+#define DMA_NUM_APP_WORDS		5
+#define LEN_APP				4
+#define RX_BUF_NUM_DEFAULT		128
 
 /* Must be shorter than length of ethtool_drvinfo.driver field to fit */
 #define DRIVER_NAME		"xaxienet"
@@ -55,6 +63,8 @@
 
 #define AXIENET_REGS_N		40
 
+static void axienet_rx_submit_desc(struct net_device *ndev);
+
 /* Match table for of_platform binding */
 static const struct of_device_id axienet_of_match[] = {
 	{ .compatible = "xlnx,axi-ethernet-1.00.a", },
@@ -120,6 +130,16 @@ static struct axienet_option axienet_options[] = {
 	{}
 };
 
+static struct skbuf_dma_descriptor *axienet_get_rx_desc(struct axienet_local *lp, int i)
+{
+	return lp->rx_skb_ring[i & (RX_BUF_NUM_DEFAULT - 1)];
+}
+
+static struct skbuf_dma_descriptor *axienet_get_tx_desc(struct axienet_local *lp, int i)
+{
+	return lp->tx_skb_ring[i & (TX_BD_NUM_MAX - 1)];
+}
+
 /**
  * axienet_dma_in32 - Memory mapped Axi DMA register read
  * @lp:		Pointer to axienet local structure
@@ -727,6 +747,128 @@ static inline int axienet_check_tx_bd_space(struct axienet_local *lp,
 	return 0;
 }
 
+/**
+ * axienet_dma_tx_cb - DMA engine callback for TX channel.
+ * @data:       Pointer to the axienet_local structure.
+ * @result:     error reporting through dmaengine_result.
+ * This function is called by dmaengine driver for TX channel to notify
+ * that the transmit is done.
+ */
+static void axienet_dma_tx_cb(void *data, const struct dmaengine_result *result)
+{
+	struct skbuf_dma_descriptor *skbuf_dma;
+	struct axienet_local *lp = data;
+	struct netdev_queue *txq;
+	int len;
+
+	skbuf_dma = axienet_get_tx_desc(lp, lp->tx_ring_tail++);
+	len = skbuf_dma->skb->len;
+	txq = skb_get_tx_queue(lp->ndev, skbuf_dma->skb);
+	u64_stats_update_begin(&lp->tx_stat_sync);
+	u64_stats_add(&lp->tx_bytes, len);
+	u64_stats_add(&lp->tx_packets, 1);
+	u64_stats_update_end(&lp->tx_stat_sync);
+	dma_unmap_sg(lp->dev, skbuf_dma->sgl, skbuf_dma->sg_len, DMA_TO_DEVICE);
+	dev_consume_skb_any(skbuf_dma->skb);
+	netif_txq_completed_wake(txq, 1, len,
+				 CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX),
+				 2 * MAX_SKB_FRAGS);
+}
+
+/**
+ * axienet_start_xmit_dmaengine - Starts the transmission.
+ * @skb:        sk_buff pointer that contains data to be Txed.
+ * @ndev:       Pointer to net_device structure.
+ *
+ * Return: NETDEV_TX_OK on success or any non space errors.
+ *         NETDEV_TX_BUSY when free element in TX skb ring buffer
+ *         is not available.
+ *
+ * This function is invoked to initiate transmission. The
+ * function sets the skbs, register dma callback API and submit
+ * the dma transaction.
+ * Additionally if checksum offloading is supported,
+ * it populates AXI Stream Control fields with appropriate values.
+ */
+static netdev_tx_t
+axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct dma_async_tx_descriptor *dma_tx_desc = NULL;
+	struct axienet_local *lp = netdev_priv(ndev);
+	u32 app_metadata[DMA_NUM_APP_WORDS] = {0};
+	struct skbuf_dma_descriptor *skbuf_dma;
+	struct dma_device *dma_dev;
+	struct netdev_queue *txq;
+	u32 csum_start_off;
+	u32 csum_index_off;
+	int sg_len;
+	int ret;
+
+	dma_dev = lp->tx_chan->device;
+	sg_len = skb_shinfo(skb)->nr_frags + 1;
+	if (CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX) <= sg_len) {
+		netif_stop_queue(ndev);
+		if (net_ratelimit())
+			netdev_warn(ndev, "TX ring unexpectedly full\n");
+		return NETDEV_TX_BUSY;
+	}
+
+	skbuf_dma = axienet_get_tx_desc(lp, lp->tx_ring_head);
+	if (!skbuf_dma)
+		goto xmit_error_drop_skb;
+
+	lp->tx_ring_head++;
+	sg_init_table(skbuf_dma->sgl, sg_len);
+	ret = skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
+	if (ret < 0)
+		goto xmit_error_drop_skb;
+
+	ret = dma_map_sg(lp->dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
+	if (!ret)
+		goto xmit_error_drop_skb;
+
+	/* Fill up app fields for checksum */
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (lp->features & XAE_FEATURE_FULL_TX_CSUM) {
+			/* Tx Full Checksum Offload Enabled */
+			app_metadata[0] |= 2;
+		} else if (lp->features & XAE_FEATURE_PARTIAL_TX_CSUM) {
+			csum_start_off = skb_transport_offset(skb);
+			csum_index_off = csum_start_off + skb->csum_offset;
+			/* Tx Partial Checksum Offload Enabled */
+			app_metadata[0] |= 1;
+			app_metadata[1] = (csum_start_off << 16) | csum_index_off;
+		}
+	} else if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
+		app_metadata[0] |= 2; /* Tx Full Checksum Offload Enabled */
+	}
+
+	dma_tx_desc = dma_dev->device_prep_slave_sg(lp->tx_chan, skbuf_dma->sgl,
+			sg_len, DMA_MEM_TO_DEV,
+			DMA_PREP_INTERRUPT, (void *)app_metadata);
+	if (!dma_tx_desc)
+		goto xmit_error_unmap_sg;
+
+	skbuf_dma->skb = skb;
+	skbuf_dma->sg_len = sg_len;
+	dma_tx_desc->callback_param = lp;
+	dma_tx_desc->callback_result = axienet_dma_tx_cb;
+	dmaengine_submit(dma_tx_desc);
+	dma_async_issue_pending(lp->tx_chan);
+	txq = skb_get_tx_queue(lp->ndev, skb);
+	netdev_tx_sent_queue(txq, skb->len);
+	netif_txq_maybe_stop(txq, CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX),
+			     MAX_SKB_FRAGS + 1, 2 * MAX_SKB_FRAGS);
+
+	return NETDEV_TX_OK;
+
+xmit_error_unmap_sg:
+	dma_unmap_sg(lp->dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
+xmit_error_drop_skb:
+	dev_kfree_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
 /**
  * axienet_tx_poll - Invoked once a transmit is completed by the
  * Axi DMA Tx channel.
@@ -893,6 +1035,42 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	return NETDEV_TX_OK;
 }
 
+/**
+ * axienet_dma_rx_cb - DMA engine callback for RX channel.
+ * @data:       Pointer to the skbuf_dma_descriptor structure.
+ * @result:     error reporting through dmaengine_result.
+ * This function is called by dmaengine driver for RX channel to notify
+ * that the packet is received.
+ */
+static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
+{
+	struct skbuf_dma_descriptor *skbuf_dma;
+	size_t meta_len, meta_max_len, rx_len;
+	struct axienet_local *lp = data;
+	struct sk_buff *skb;
+	u32 *app_metadata;
+
+	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_tail++);
+	skb = skbuf_dma->skb;
+	app_metadata = dmaengine_desc_get_metadata_ptr(skbuf_dma->desc, &meta_len,
+						       &meta_max_len);
+	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
+			 DMA_FROM_DEVICE);
+	/* TODO: Derive app word index programmatically */
+	rx_len = (app_metadata[LEN_APP] & 0xFFFF);
+	skb_put(skb, rx_len);
+	skb->protocol = eth_type_trans(skb, lp->ndev);
+	skb->ip_summed = CHECKSUM_NONE;
+
+	__netif_rx(skb);
+	u64_stats_update_begin(&lp->rx_stat_sync);
+	u64_stats_add(&lp->rx_packets, 1);
+	u64_stats_add(&lp->rx_bytes, rx_len);
+	u64_stats_update_end(&lp->rx_stat_sync);
+	axienet_rx_submit_desc(lp->ndev);
+	dma_async_issue_pending(lp->rx_chan);
+}
+
 /**
  * axienet_rx_poll - Triggered by RX ISR to complete the BD processing.
  * @napi:	Pointer to NAPI structure.
@@ -1126,6 +1304,144 @@ static irqreturn_t axienet_eth_irq(int irq, void *_ndev)
 
 static void axienet_dma_err_handler(struct work_struct *work);
 
+/**
+ * axienet_rx_submit_desc - Submit the rx descriptors to dmaengine.
+ * allocate skbuff, map the scatterlist and obtain a descriptor
+ * and then add the callback information and submit descriptor.
+ *
+ * @ndev:	net_device pointer
+ *
+ */
+static void axienet_rx_submit_desc(struct net_device *ndev)
+{
+	struct dma_async_tx_descriptor *dma_rx_desc = NULL;
+	struct axienet_local *lp = netdev_priv(ndev);
+	struct skbuf_dma_descriptor *skbuf_dma;
+	struct sk_buff *skb;
+	dma_addr_t addr;
+
+	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_head);
+	if (!skbuf_dma)
+		return;
+
+	lp->rx_ring_head++;
+	skb = netdev_alloc_skb(ndev, lp->max_frm_size);
+	if (!skb)
+		return;
+
+	sg_init_table(skbuf_dma->sgl, 1);
+	addr = dma_map_single(lp->dev, skb->data, lp->max_frm_size, DMA_FROM_DEVICE);
+	if (unlikely(dma_mapping_error(lp->dev, addr))) {
+		if (net_ratelimit())
+			netdev_err(ndev, "DMA mapping error\n");
+		goto rx_submit_err_free_skb;
+	}
+	sg_dma_address(skbuf_dma->sgl) = addr;
+	sg_dma_len(skbuf_dma->sgl) = lp->max_frm_size;
+	dma_rx_desc = dmaengine_prep_slave_sg(lp->rx_chan, skbuf_dma->sgl,
+					      1, DMA_DEV_TO_MEM,
+					      DMA_PREP_INTERRUPT);
+	if (!dma_rx_desc)
+		goto rx_submit_err_unmap_skb;
+
+	skbuf_dma->skb = skb;
+	skbuf_dma->dma_address = sg_dma_address(skbuf_dma->sgl);
+	skbuf_dma->desc = dma_rx_desc;
+	dma_rx_desc->callback_param = lp;
+	dma_rx_desc->callback_result = axienet_dma_rx_cb;
+	dmaengine_submit(dma_rx_desc);
+
+	return;
+
+rx_submit_err_unmap_skb:
+	dma_unmap_single(lp->dev, addr, lp->max_frm_size, DMA_FROM_DEVICE);
+rx_submit_err_free_skb:
+	dev_kfree_skb(skb);
+}
+
+/**
+ * axienet_init_dmaengine - init the dmaengine code.
+ * @ndev:       Pointer to net_device structure
+ *
+ * Return: 0, on success.
+ *          non-zero error value on failure
+ *
+ * This is the dmaengine initialization code.
+ */
+static int axienet_init_dmaengine(struct net_device *ndev)
+{
+	struct axienet_local *lp = netdev_priv(ndev);
+	struct skbuf_dma_descriptor *skbuf_dma;
+	int i, ret;
+
+	lp->tx_chan = dma_request_chan(lp->dev, "tx_chan0");
+	if (IS_ERR(lp->tx_chan)) {
+		dev_err(lp->dev, "No Ethernet DMA (TX) channel found\n");
+		return PTR_ERR(lp->tx_chan);
+	}
+
+	lp->rx_chan = dma_request_chan(lp->dev, "rx_chan0");
+	if (IS_ERR(lp->rx_chan)) {
+		ret = PTR_ERR(lp->rx_chan);
+		dev_err(lp->dev, "No Ethernet DMA (RX) channel found\n");
+		goto err_dma_release_tx;
+	}
+
+	lp->tx_ring_tail = 0;
+	lp->tx_ring_head = 0;
+	lp->rx_ring_tail = 0;
+	lp->rx_ring_head = 0;
+	lp->tx_skb_ring = kcalloc(TX_BD_NUM_MAX, sizeof(*lp->tx_skb_ring),
+				  GFP_KERNEL);
+	if (!lp->tx_skb_ring) {
+		ret = -ENOMEM;
+		goto err_dma_release_rx;
+	}
+	for (i = 0; i < TX_BD_NUM_MAX; i++) {
+		skbuf_dma = kzalloc(sizeof(*skbuf_dma), GFP_KERNEL);
+		if (!skbuf_dma) {
+			ret = -ENOMEM;
+			goto err_free_tx_skb_ring;
+		}
+		lp->tx_skb_ring[i] = skbuf_dma;
+	}
+
+	lp->rx_skb_ring = kcalloc(RX_BUF_NUM_DEFAULT, sizeof(*lp->rx_skb_ring),
+				  GFP_KERNEL);
+	if (!lp->rx_skb_ring) {
+		ret = -ENOMEM;
+		goto err_free_tx_skb_ring;
+	}
+	for (i = 0; i < RX_BUF_NUM_DEFAULT; i++) {
+		skbuf_dma = kzalloc(sizeof(*skbuf_dma), GFP_KERNEL);
+		if (!skbuf_dma) {
+			ret = -ENOMEM;
+			goto err_free_rx_skb_ring;
+		}
+		lp->rx_skb_ring[i] = skbuf_dma;
+	}
+	/* TODO: Instead of BD_NUM_DEFAULT use runtime support */
+	for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
+		axienet_rx_submit_desc(ndev);
+	dma_async_issue_pending(lp->rx_chan);
+
+	return 0;
+
+err_free_rx_skb_ring:
+	for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
+		kfree(lp->rx_skb_ring[i]);
+	kfree(lp->rx_skb_ring);
+err_free_tx_skb_ring:
+	for (i = 0; i < TX_BD_NUM_MAX; i++)
+		kfree(lp->tx_skb_ring[i]);
+	kfree(lp->tx_skb_ring);
+err_dma_release_rx:
+	dma_release_channel(lp->rx_chan);
+err_dma_release_tx:
+	dma_release_channel(lp->tx_chan);
+	return ret;
+}
+
 /**
  * axienet_init_legacy_dma - init the dma legacy code.
  * @ndev:       Pointer to net_device structure
@@ -1216,7 +1532,19 @@ static int axienet_open(struct net_device *ndev)
 
 	phylink_start(lp->phylink);
 
-	if (!lp->use_dmaengine) {
+	if (lp->use_dmaengine) {
+		/* Enable interrupts for Axi Ethernet core (if defined) */
+		if (lp->eth_irq > 0) {
+			ret = request_irq(lp->eth_irq, axienet_eth_irq, IRQF_SHARED,
+					  ndev->name, ndev);
+			if (ret)
+				goto err_phy;
+		}
+
+		ret = axienet_init_dmaengine(ndev);
+		if (ret < 0)
+			goto err_free_eth_irq;
+	} else {
 		ret = axienet_init_legacy_dma(ndev);
 		if (ret)
 			goto err_phy;
@@ -1224,6 +1552,9 @@ static int axienet_open(struct net_device *ndev)
 
 	return 0;
 
+err_free_eth_irq:
+	if (lp->eth_irq > 0)
+		free_irq(lp->eth_irq, ndev);
 err_phy:
 	phylink_stop(lp->phylink);
 	phylink_disconnect_phy(lp->phylink);
@@ -1243,6 +1574,7 @@ static int axienet_open(struct net_device *ndev)
 static int axienet_stop(struct net_device *ndev)
 {
 	struct axienet_local *lp = netdev_priv(ndev);
+	int i;
 
 	dev_dbg(&ndev->dev, "axienet_close()\n");
 
@@ -1263,6 +1595,21 @@ static int axienet_stop(struct net_device *ndev)
 		free_irq(lp->tx_irq, ndev);
 		free_irq(lp->rx_irq, ndev);
 		axienet_dma_bd_release(ndev);
+	} else {
+		dmaengine_terminate_sync(lp->tx_chan);
+		dmaengine_synchronize(lp->tx_chan);
+		dmaengine_terminate_sync(lp->rx_chan);
+		dmaengine_synchronize(lp->rx_chan);
+
+		for (i = 0; i < TX_BD_NUM_MAX; i++)
+			kfree(lp->tx_skb_ring[i]);
+		kfree(lp->tx_skb_ring);
+		for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
+			kfree(lp->rx_skb_ring[i]);
+		kfree(lp->rx_skb_ring);
+
+		dma_release_channel(lp->rx_chan);
+		dma_release_channel(lp->tx_chan);
 	}
 
 	axienet_iow(lp, XAE_IE_OFFSET, 0);
@@ -1365,6 +1712,18 @@ static const struct net_device_ops axienet_netdev_ops = {
 #endif
 };
 
+static const struct net_device_ops axienet_netdev_dmaengine_ops = {
+	.ndo_open = axienet_open,
+	.ndo_stop = axienet_stop,
+	.ndo_start_xmit = axienet_start_xmit_dmaengine,
+	.ndo_get_stats64 = axienet_get_stats64,
+	.ndo_change_mtu	= axienet_change_mtu,
+	.ndo_set_mac_address = netdev_set_mac_address,
+	.ndo_validate_addr = eth_validate_addr,
+	.ndo_eth_ioctl = axienet_ioctl,
+	.ndo_set_rx_mode = axienet_set_multicast_list,
+};
+
 /**
  * axienet_ethtools_get_drvinfo - Get various Axi Ethernet driver information.
  * @ndev:	Pointer to net_device structure
@@ -1897,7 +2256,6 @@ static int axienet_probe(struct platform_device *pdev)
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 	ndev->flags &= ~IFF_MULTICAST;  /* clear multicast */
 	ndev->features = NETIF_F_SG;
-	ndev->netdev_ops = &axienet_netdev_ops;
 	ndev->ethtool_ops = &axienet_ethtool_ops;
 
 	/* MTU range: 64 - 9000 */
@@ -2118,8 +2476,39 @@ static int axienet_probe(struct platform_device *pdev)
 		}
 		netif_napi_add(ndev, &lp->napi_rx, axienet_rx_poll);
 		netif_napi_add(ndev, &lp->napi_tx, axienet_tx_poll);
+	} else {
+		struct xilinx_vdma_config cfg;
+		struct dma_chan *tx_chan;
+
+		lp->eth_irq = platform_get_irq_optional(pdev, 0);
+		if (lp->eth_irq < 0 && lp->eth_irq != -ENXIO) {
+			ret = lp->eth_irq;
+			goto cleanup_clk;
+		}
+		tx_chan = dma_request_chan(lp->dev, "tx_chan0");
+		if (IS_ERR(tx_chan)) {
+			ret = PTR_ERR(tx_chan);
+			dev_err_probe(lp->dev, ret, "No Ethernet DMA (TX) channel found\n");
+			goto cleanup_clk;
+		}
+
+		cfg.reset = 1;
+		/* As name says VDMA but it has support for DMA channel reset */
+		ret = xilinx_vdma_channel_set_config(tx_chan, &cfg);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Reset channel failed\n");
+			dma_release_channel(tx_chan);
+			goto cleanup_clk;
+		}
+
+		dma_release_channel(tx_chan);
+		lp->use_dmaengine = 1;
 	}
 
+	if (lp->use_dmaengine)
+		ndev->netdev_ops = &axienet_netdev_dmaengine_ops;
+	else
+		ndev->netdev_ops = &axienet_netdev_ops;
 	/* Check for Ethernet core IRQ (optional) */
 	if (lp->eth_irq <= 0)
 		dev_info(&pdev->dev, "Ethernet core IRQ not defined\n");
-- 
2.34.1

