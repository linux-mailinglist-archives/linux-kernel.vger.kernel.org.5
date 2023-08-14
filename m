Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF2E77BECF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjHNRTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjHNRTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:19:20 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB5210C1;
        Mon, 14 Aug 2023 10:19:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7S53tO1gTj/0RxdBKzOyJKbRPf1aBk0HLs2MhlzHAKB91ex8Drl+5gmL4QwbxaL1QqtN4TyPCrsE889Tgrfi9H0htSSRsoqlgEyBDZsG3IWVUgJEkjSanj4s0jQxTPSqAhelC61ZYhSQveKQWES+ykamorz8J/V21fyrbfUmgqG8yz//cRjLDLvESj+AtuTtRc0OzGVIp+g5uMmWNB+EeV0XFiyO/g8WcsVmJEGPXVTyUQaesFMi0gFqxI2xSe8TnserZ3K4zyKYNl84mVFp56z6da8EWR150KfEjr/fLASVdEp7S1d+B+vBHmS5MbqY48XhN1c+tjoXEZwGJMncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pq4YPk9nydhooGv5RPJtB0dcUvyoZqngaV5k8FJms+4=;
 b=j4lfjobRWIJe3Wd8rnjoEeIqrCd+2Ea8OUYmuuVPoyBiOoJPteuDlmBu9mli7mSVEdacGVbcNb4QC/z6GytX+PdfkSGMwTVLEXQULfmmHlkQYgBpKTtxJNJrCj0oBv7VPG+SLSJuQdJdezNXwdZmG252xy63HNKdeO5Bio0LY9dOV6Ee39HvEztE0fbjG9GDfdtPBPjzVf23XRb3y0+ptq6LeVftgTgHq5j1BzanM/LC84EIBITNoEg+aK4R2u83YRLOSjhHsvg5yd31Os/tyQbs2XVle7xno42uLM2pUj01/jmSYkxcgZ4gf56vZL8ZB8RuDCCupiUEon7f1lc8Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pq4YPk9nydhooGv5RPJtB0dcUvyoZqngaV5k8FJms+4=;
 b=VCnqWp4x/2thrFV92WhUCtNB1DO1+x0HJ9UCfEogZ2XX0pzqSyva/H2TXi8UjzPpj6isal1PVnGaknncPywocBbWYWAHGwoz5QkrYDOrc9uJhdZQlTWPCYN3D0HsLW9c0I27+EffQutuhpLJOxWLG1R5ulRZGevbE11eLjA171B6ZAFYqzMQXWGiYkRorpoNaRPMx3gJRqGOELm6JU7a5ppPEbXHycDJ4RPneoxrTzYs1NlPHSMcAXUsuWrcCKbk+5jVjXeFn1YoeYKZ04YDT08B3FbkFkbQnUmypwoUDPJQTMZsFvAjXSy4CIurZVDwP7rE+VX7RqpUBWqVr9Tp/g==
Received: from CH2PR03CA0007.namprd03.prod.outlook.com (2603:10b6:610:59::17)
 by CH0PR12MB5282.namprd12.prod.outlook.com (2603:10b6:610:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 17:19:15 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::5e) by CH2PR03CA0007.outlook.office365.com
 (2603:10b6:610:59::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 17:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 17:19:15 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 14 Aug 2023
 10:19:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 14 Aug 2023 10:19:04 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 14 Aug 2023 10:19:02 -0700
From:   Feng Liu <feliu@nvidia.com>
To:     <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Bodong Wang <bodong@nvidia.com>, "Feng Liu" <feliu@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net v1] virtio_net: Introduce skb_vnet_common_hdr to avoid typecasting
Date:   Mon, 14 Aug 2023 13:18:45 -0400
Message-ID: <20230814171845.65930-1-feliu@nvidia.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|CH0PR12MB5282:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eab1326-62dc-46e7-dc61-08db9cea95e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jgI8NVtwmqFYj1wSVKdDzOzrCwVsNgYFSXm5oLfnWcw9144bmg38AfF5DAB4bay0QVIWSyS/iEezp7JVHC8TCBb3+EQiPL0j1MbcNL++U6RjD/BsbpFiqa8LhEx4r2/+E2S3GeNiIO2MZfxo8FtQapcbR91HOC7llX3OzxAUIuuTKVc0wBrcUliUlfnGJSfR/f0KLZi/7WEIVJ/X0VNlMzDqwT/8sLu+OPH0abTyJhxN5CbSXqsQitZ3vUpZiSZOKNhyUvhE3I9dN5L3y/ab0imQ8YUzW71tz0cwGxD7gIyh9X4vw6DLB4XRMuA5NmKDAPZtzFTOp/Lurk3DCrhpmA6z+uUgrOwf9ncytfIQJI4kdgtU8lnQGhydpHxE7qhs1b93rFM8fKgEoM2zzT4510Jlxx00WiXi6Z8Vz2H/O1qn5jftE/MsGjtNmaa9i4QsKkh8WpLzq2g+nsyS+T2zQeKZbuBuvSetence/xNYi015+T077/F95obFaLoTlR5aI+lLOfWDpq0g9N/uoKQJQUBKqexpA9nuHh3uxIfhomvy1gpkVjRieQG1WiiYbWEasAMOfNlXC4yAf97Z1d/YQf9idaBl1OPns2EIOYxYwRiXy7METa7DLI36zgUN0BS5HdgI8QGV5/VB+s8dGIT+1lYQ9UfxBRP986/q/pl6D3ZoUXnfTngIPkqBXHWN9CmV7hsewaOidho63Ou2IZVtgekhDu5+TTAeRlRH57QTgDUs9NNnf8dWbo8ZSNKeJ1k
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(186006)(1800799006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(336012)(36756003)(426003)(47076005)(36860700001)(66899021)(86362001)(40480700001)(41300700001)(82740400003)(478600001)(7636003)(356005)(316002)(54906003)(70206006)(70586007)(8676002)(8936002)(5660300002)(4326008)(110136005)(40460700003)(2616005)(1076003)(107886003)(26005)(7696005)(6666004)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:19:15.2825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eab1326-62dc-46e7-dc61-08db9cea95e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5282
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

Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c        | 29 ++++++++++++++++-------------
 include/uapi/linux/virtio_net.h |  7 +++++++
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1270c8d23463..6ce0fbcabda9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -344,9 +344,10 @@ static int rxq2vq(int rxq)
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
@@ -469,7 +470,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 				   unsigned int headroom)
 {
 	struct sk_buff *skb;
-	struct virtio_net_hdr_mrg_rxbuf *hdr;
+	struct virtio_net_common_hdr *hdr;
 	unsigned int copy, hdr_len, hdr_padded_len;
 	struct page *page_to_free = NULL;
 	int tailroom, shinfo_size;
@@ -554,7 +555,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		give_pages(rq, page);
 
 ok:
-	hdr = skb_vnet_hdr(skb);
+	hdr = skb_vnet_common_hdr(skb);
 	memcpy(hdr, hdr_p, hdr_len);
 	if (page_to_free)
 		put_page(page_to_free);
@@ -966,7 +967,7 @@ static struct sk_buff *receive_small_build_skb(struct virtnet_info *vi,
 		return NULL;
 
 	buf += header_offset;
-	memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
+	memcpy(skb_vnet_common_hdr(skb), buf, vi->hdr_len);
 
 	return skb;
 }
@@ -1577,7 +1578,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 {
 	struct net_device *dev = vi->dev;
 	struct sk_buff *skb;
-	struct virtio_net_hdr_mrg_rxbuf *hdr;
+	struct virtio_net_common_hdr *common_hdr;
+	struct virtio_net_hdr_mrg_rxbuf	*mrg_hdr;
 
 	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
 		pr_debug("%s: short packet %i\n", dev->name, len);
@@ -1597,18 +1599,19 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
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
 
@@ -2105,7 +2108,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 	if (can_push)
 		hdr = (struct virtio_net_hdr_mrg_rxbuf *)(skb->data - hdr_len);
 	else
-		hdr = skb_vnet_hdr(skb);
+		hdr = &skb_vnet_common_hdr(skb)->mrg_hdr;
 
 	if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
 				    virtio_is_little_endian(vi->vdev), false,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 12c1c9699935..db40f93ae8b3 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -201,6 +201,13 @@ struct virtio_net_hdr_mrg_rxbuf {
 	struct virtio_net_hdr hdr;
 	__virtio16 num_buffers;	/* Number of merged rx buffers */
 };
+
+struct virtio_net_common_hdr {
+	union {
+		struct virtio_net_hdr_mrg_rxbuf	mrg_hdr;
+		struct virtio_net_hdr_v1_hash hash_v1_hdr;
+	};
+};
 #endif /* ...VIRTIO_NET_NO_LEGACY */
 
 /*
-- 
2.37.1 (Apple Git-137.1)

