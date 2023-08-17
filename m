Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544BA77FA9B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353116AbjHQPUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353134AbjHQPUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:20:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE9B2724;
        Thu, 17 Aug 2023 08:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0KiH7C3b6RGGTUJElSSqL/l6QQI6LMUpNliftsZTh4iCd5x+W0f/1HcyQj7lAaHHcwpxBLOitHZ2M7NNrDwXDSA8LhQmpUM7J2aDlUxFq/HwW2hzhJmejbuj8KQQpUvJOFniGa/TvYwwGevnJomZK5TZYGL2mKWYnUHOEz2NDbO+Fxr7eMVs35H3L/IkEKLKMhQ0kjoPmrlQUxvxGkxRyJ5EPXorObmE9cVs5nGzrtp/2dbDnd7fAfk/DGe7eWOIo1IJPSmhRy1bQ2sFJwwof0sB/08b55qk0Qu2Ryaxq3ypOGAifvf1pRhykPRxo00k9lIhJsbZx3vjF3KwG/k+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mt/Xj65PR+YIPfDNvgLmk8G3xBlGhdtyCxeS78iYbpE=;
 b=VUsBJLXOU9woZsEajgH1spawEQVf8SamWwstg8fX6jNxWPih7fnsx2miPV9YHyXWa7xQMPIaNV89C2JVqt4HsiAsVkTr8UGH5QRozcsAq6IqEuxdnC+1yVDcz5FxUNhRYukZjnsyyielxgBaOv7hzf2WxZ4SdvLqA9ajP9y+GXnGS0tJwAJmxOo1bL9YWSGuRrK7jCmYcpN6WCabQQEGTOoMr3GFfWo/zTRCYrI2rAdkgx/5VM2pqOAf5Bkyu7OW/AWONgjpalk1WrKhPQqDT39kGN1cbQCvymvwRX5jkhnVdWcTFufkpsO72sUUotFMM8+pvH0J5xhnzTaWZeQ4Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mt/Xj65PR+YIPfDNvgLmk8G3xBlGhdtyCxeS78iYbpE=;
 b=HdIxqAR+qRKUJlz7AEDtYNfDh+DMvsAoHMgBCssd++9Eo00gbMPEja3Hj50HoiekvuCChLqgySsLouc3Mw2AOZ4FS4vcOHUBU1bJM3tlgTVrocxvR7lTmPsVJLUOziLAIUGwqZAcM3S31l6GmEirAMeSOSA83dsFdeIhg7TP++csSNfzFh06G3GmFV0GvoaK0dwQB5Bp8s2SWdUSj6staCDSYzJeVUXjSBgch1JsH+sQ+MlzKk4XoLCiOXnZjslLtXuoH3drebPvSleiEuQCRXXflbHVxu8UF9RebP2ixFLxdUAkLj5EvzpCmXU80jnH9ggDL++eCpe+cOh8v1K0og==
Received: from MW4PR04CA0061.namprd04.prod.outlook.com (2603:10b6:303:6b::6)
 by DS0PR12MB6558.namprd12.prod.outlook.com (2603:10b6:8:d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 15:20:08 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::79) by MW4PR04CA0061.outlook.office365.com
 (2603:10b6:303:6b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Thu, 17 Aug 2023 15:20:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 15:20:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 08:19:45 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 17 Aug
 2023 08:19:45 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 17 Aug
 2023 08:19:43 -0700
From:   Feng Liu <feliu@nvidia.com>
To:     <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Simon Horman <horms@kernel.org>,
        "Bodong Wang" <bodong@nvidia.com>, Feng Liu <feliu@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next v2] virtio_net: Introduce skb_vnet_common_hdr to avoid typecasting
Date:   Thu, 17 Aug 2023 11:19:41 -0400
Message-ID: <20230817151941.18692-1-feliu@nvidia.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|DS0PR12MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: a38757b1-86e9-4cb4-921b-08db9f357100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2N4X2I3BADtDpGtKDzEjbqQSQ/HgyU991D0Vsnz7QBPCgtLQ3X6LSUoe2Rp1EzagTbbPy7wDxNZzryw7ueteGOXq1Mhqm0sEBL4vvHLlYxr6uv+xvEUkCioBLPLeC59QDfS4EUb3uTbTK7b4/1G2HfHOPw1mXvWIJFze774vtL6jO32HVka54MnUq/qUrzEBQ1YDMDY72Jf23rUI4Wp/Fzp8hh5F0NQAoGbSIUzmeucGsT8IHwn5ILU8aRhuysyYBlO7Z5a/w6tfdzmoFh7gka9LTO8ByVEiVoUS4H4jGXZrbO+gZA8YZlZVyjcr/9SGuW2aG/Ax2rvF3ZIq8IBPhgItBzC9Y3xFvgRssfhRi4hf9I3z4pfkvP34nOjaEWjj5ry8FlGKdBwuhKR7pAZLdWe+vgBwi5MhixyD590Rjvq9wfectFWRMN4QpE0x/P8WbnYEO0sGJVBIY2xH99ngSrp4uiyyFsBGE/05vzRF/t2aNWOKRWZ095uh0qLI0vB/3EupyPRw5zyoJmW2aenQYOGLUXQrPrnc/3QS1jwqiqZBfi4YkpcXsh8a+E4Hp9fYr6IHV4rjJFWJtgR4F0iVzMCHircxRHbISMAIopch4eeAbHtBkrn6Lzb9effbiEkSzFcfFyJEuvjdpLMT58+IYO58Hc1sogPTMWLolZVIZq0lxiKmex22NyPvU4Y07ULnHEOJZoxhdLt6oMTuqNyLPKFGSUx8cuLTz2izwku2tOeP+a4zeqNekT3D+LBZS+28
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(86362001)(36756003)(82740400003)(356005)(7636003)(40480700001)(478600001)(5660300002)(107886003)(2616005)(110136005)(70206006)(70586007)(316002)(26005)(7696005)(54906003)(1076003)(4326008)(8676002)(41300700001)(8936002)(40460700003)(47076005)(66899024)(336012)(36860700001)(7416002)(426003)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 15:20:07.9440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a38757b1-86e9-4cb4-921b-08db9f357100
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6558
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The virtio_net driver currently deals with different versions and types
of virtio net headers, such as virtio_net_hdr_mrg_rxbuf,
virtio_net_hdr_v1_hash, etc. Due to these variations, the code relies
on multiple type casts to convert memory between different structures,
potentially leading to bugs when there are changes in these structures.

Introduces the "struct skb_vnet_common_hdr" as a unifying header
structure using a union. With this approach, various virtio net header
structures can be converted by accessing different members of this
structure, thus eliminating the need for type casting and reducing the
risk of potential bugs.

For example following code:
static struct sk_buff *page_to_skb(struct virtnet_info *vi,
		struct receive_queue *rq,
		struct page *page, unsigned int offset,
		unsigned int len, unsigned int truesize,
		unsigned int headroom)
{
[...]
	struct virtio_net_hdr_mrg_rxbuf *hdr;
[...]
	hdr_len = vi->hdr_len;
[...]
ok:
	hdr = skb_vnet_hdr(skb);
	memcpy(hdr, hdr_p, hdr_len);
[...]
}

When VIRTIO_NET_F_HASH_REPORT feature is enabled, hdr_len = 20
But the sizeof(*hdr) is 12,
memcpy(hdr, hdr_p, hdr_len); will copy 20 bytes to the hdr,
which make a potential risk of bug. And this risk can be avoided by
introducing struct virtio_net_hdr_mrg_rxbuf.

Change log
v1->v2
feedback from Willem de Bruijn <willemdebruijn.kernel@gmail.com>
feedback from Simon Horman <horms@kernel.org>
1. change to use net-next tree.
2. move skb_vnet_common_hdr inside kernel file instead of the UAPI header.

Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1270c8d23463..03cf744de512 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -303,6 +303,13 @@ struct padded_vnet_hdr {
 	char padding[12];
 };
 
+struct virtio_net_common_hdr {
+	union {
+		struct virtio_net_hdr_mrg_rxbuf	mrg_hdr;
+		struct virtio_net_hdr_v1_hash hash_v1_hdr;
+	};
+};
+
 static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 
@@ -344,9 +351,10 @@ static int rxq2vq(int rxq)
 	return rxq * 2;
 }
 
-static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_buff *skb)
+static inline struct virtio_net_common_hdr *
+skb_vnet_common_hdr(struct sk_buff *skb)
 {
-	return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
+	return (struct virtio_net_common_hdr *)skb->cb;
 }
 
 /*
@@ -469,7 +477,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 				   unsigned int headroom)
 {
 	struct sk_buff *skb;
-	struct virtio_net_hdr_mrg_rxbuf *hdr;
+	struct virtio_net_common_hdr *hdr;
 	unsigned int copy, hdr_len, hdr_padded_len;
 	struct page *page_to_free = NULL;
 	int tailroom, shinfo_size;
@@ -554,7 +562,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		give_pages(rq, page);
 
 ok:
-	hdr = skb_vnet_hdr(skb);
+	hdr = skb_vnet_common_hdr(skb);
 	memcpy(hdr, hdr_p, hdr_len);
 	if (page_to_free)
 		put_page(page_to_free);
@@ -966,7 +974,7 @@ static struct sk_buff *receive_small_build_skb(struct virtnet_info *vi,
 		return NULL;
 
 	buf += header_offset;
-	memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
+	memcpy(skb_vnet_common_hdr(skb), buf, vi->hdr_len);
 
 	return skb;
 }
@@ -1577,7 +1585,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 {
 	struct net_device *dev = vi->dev;
 	struct sk_buff *skb;
-	struct virtio_net_hdr_mrg_rxbuf *hdr;
+	struct virtio_net_common_hdr *common_hdr;
+	struct virtio_net_hdr_mrg_rxbuf	*mrg_hdr;
 
 	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
 		pr_debug("%s: short packet %i\n", dev->name, len);
@@ -1597,18 +1606,19 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	if (unlikely(!skb))
 		return;
 
-	hdr = skb_vnet_hdr(skb);
+	common_hdr = skb_vnet_common_hdr(skb);
 	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
-		virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash *)hdr, skb);
+		virtio_skb_set_hash(&common_hdr->hash_v1_hdr, skb);
 
-	if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
+	mrg_hdr = &common_hdr->mrg_hdr;
+	if (mrg_hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
-	if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
+	if (virtio_net_hdr_to_skb(skb, &mrg_hdr->hdr,
 				  virtio_is_little_endian(vi->vdev))) {
 		net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
-				     dev->name, hdr->hdr.gso_type,
-				     hdr->hdr.gso_size);
+				     dev->name, mrg_hdr->hdr.gso_type,
+				     mrg_hdr->hdr.gso_size);
 		goto frame_err;
 	}
 
@@ -2105,7 +2115,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 	if (can_push)
 		hdr = (struct virtio_net_hdr_mrg_rxbuf *)(skb->data - hdr_len);
 	else
-		hdr = skb_vnet_hdr(skb);
+		hdr = &skb_vnet_common_hdr(skb)->mrg_hdr;
 
 	if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
 				    virtio_is_little_endian(vi->vdev), false,
-- 
2.37.1 (Apple Git-137.1)

