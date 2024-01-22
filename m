Return-Path: <linux-kernel+bounces-32742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DCA835F90
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FFD31F27A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC8B3A278;
	Mon, 22 Jan 2024 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmPYIvEs"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31F73A1DC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918988; cv=none; b=oN/NRi1+6zGBafKbMkbacAIUazpJOOOhaER266Yhi52yiu6eOc1yi6KAC8uZw9JtywVJTQOB9i/AfJBl+p/ZflllQ6btwtrcTmvR2VL2h54iSXwcOWrjuC/+iKVl819dXzIF6J/hWc8KowMrmjPqqKTJAO090J5L6Ecyulsi77g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918988; c=relaxed/simple;
	bh=Ock7B69XdGIXdbkP3Pl3P871KHNB5YiSNiJc9wfXg6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ixoCc0FcJHpWk5yplSj2GjAD+rm5Fhm8ywp3xHLxuOwYCw3/KJ5OAYbDFzkd64tOSHMkzhrY7IY/pDNIarquQzYZbfOe2T8alVu2Gh/ZAluXODqLbwUs2rU4C/RIAZj6Mdo0avJQ6oFawTIgFsFeVCTMM3uclKpT64IBlKw/qCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmPYIvEs; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5c66b093b86so2822453a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705918986; x=1706523786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dcV0b9EAD7cikX7TBR9d3JnFTgh+L0e81zNYPrMvnxA=;
        b=DmPYIvEs4y8Lagauk/ShNunR7GnBj8IK2830u1xLhj9VU2tW6A0OEdNuXw0izz//fN
         DIh2scwXWSQhKIhF2SwPgsj8uBJ9mCf6ewWZAIzKD4huZbZ/27W2pzrjTnwtvU6L7Frf
         APSmjCl8gi+vGCAqDa5nkKZ7B1hzr4IbQ8ju6UQ94gJbpiiQ45zIaMKSDv/we2uggjh+
         cyFxMDEVRoKTBAHtkIhGnlo7xmI/emYQyGtRa3au6AwHzk1kDSjG4hiaxKjWMF4Dsauq
         EbDLK4U7EUwWUV9agy2BNt0iC1ZJ/1+xBeIwm0UsAtIyVZJZmMos/S7usRSn2w2wW1hl
         8vGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705918986; x=1706523786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcV0b9EAD7cikX7TBR9d3JnFTgh+L0e81zNYPrMvnxA=;
        b=btSgfqB1x3HheM6LjiBLTyw2DYyZ1Yyn1M1daKQgn/Ay0fc+636QoAwn6/IHnbbGX0
         y1NLVMa2reJZD5G2NjSgYa9lmEeIp9CNKVxtCZieOI4pUD6qRTG+8mHA47m/eHEJqYVH
         LaOlkdT8ZXY8Y2OS6T2W2QV33aY8eWpnUc3Slh8Ca/PjJablehzrsf69kVQsvQD2wr2q
         XNNcZ4rq0EdaxkV13Vxx6E1zJiZ+j1BTJjxF/DPODHyrchAosHwq4+SvyNnL0m9Rlen8
         iHZBkSfkhHvic0UK+U9gaSJSt4lURML9v/XygMm1wLEQ78Xa7BdtR7ZJZ5IqzDBkxpYi
         533Q==
X-Gm-Message-State: AOJu0YzTMuy9KcqTnLzLyTv5KkL/bTXhOEJ5N0DXQgUjcPZvx8FoqWKo
	4sDnE7zGHWRRcLn2lYAH01PA0x6hy7wR+3XEvtACivEcI6jzmVdF
X-Google-Smtp-Source: AGHT+IHVwosNjjzlFduyjv9cVRyks0refrlWsNmXZ/WWUafu5XgUkYbq7SH7UpuFcqAkCnZT5Hmizw==
X-Received: by 2002:a17:90a:1041:b0:290:2405:aee7 with SMTP id y1-20020a17090a104100b002902405aee7mr6720307pjd.11.1705918986114;
        Mon, 22 Jan 2024 02:23:06 -0800 (PST)
Received: from dell.. ([111.192.196.252])
        by smtp.googlemail.com with ESMTPSA id su7-20020a17090b534700b0028d29d837c7sm9099697pjb.36.2024.01.22.02.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:23:05 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH] virtio_net: Support RX hash XDP hint
Date: Mon, 22 Jan 2024 18:22:56 +0800
Message-Id: <20240122102256.261374-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RSS hash report is a feature that's part of the virtio specification.
Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
(still a work in progress as per [1]) support this feature. While the
capability to obtain the RSS hash has been enabled in the normal path,
it's currently missing in the XDP path. Therefore, we are introducing XDP
hints through kfuncs to allow XDP programs to access the RSS hash.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 drivers/net/virtio_net.c | 56 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d7ce4a1011ea..1463a4709e3c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4579,6 +4579,60 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
 	}
 }
 
+static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
+			   enum xdp_rss_hash_type *rss_type)
+{
+	const struct xdp_buff *xdp = (void *)_ctx;
+	struct virtio_net_hdr_v1_hash *hdr_hash;
+	struct virtnet_info *vi;
+
+	if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
+		return -ENODATA;
+
+	vi = netdev_priv(xdp->rxq->dev);
+	hdr_hash = (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hdr_len);
+
+	switch (__le16_to_cpu(hdr_hash->hash_report)) {
+		case VIRTIO_NET_HASH_REPORT_TCPv4:
+			*rss_type = XDP_RSS_TYPE_L4_IPV4_TCP;
+			break;
+		case VIRTIO_NET_HASH_REPORT_UDPv4:
+			*rss_type = XDP_RSS_TYPE_L4_IPV4_UDP;
+			break;
+		case VIRTIO_NET_HASH_REPORT_TCPv6:
+			*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP;
+			break;
+		case VIRTIO_NET_HASH_REPORT_UDPv6:
+			*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP;
+			break;
+		case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
+			*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP_EX;
+			break;
+		case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
+			*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP_EX;
+			break;
+		case VIRTIO_NET_HASH_REPORT_IPv4:
+			*rss_type = XDP_RSS_TYPE_L3_IPV4;
+			break;
+		case VIRTIO_NET_HASH_REPORT_IPv6:
+			*rss_type = XDP_RSS_TYPE_L3_IPV6;
+			break;
+		case VIRTIO_NET_HASH_REPORT_IPv6_EX:
+			*rss_type = XDP_RSS_TYPE_L3_IPV6_EX;
+			break;
+		case VIRTIO_NET_HASH_REPORT_NONE:
+		default:
+			*rss_type = XDP_RSS_TYPE_NONE;
+	}
+
+	*hash = __le32_to_cpu(hdr_hash->hash_value);
+	return 0;
+}
+
+static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
+	.xmo_rx_hash			= virtnet_xdp_rx_hash,
+};
+
 static int virtnet_probe(struct virtio_device *vdev)
 {
 	int i, err = -ENOMEM;
@@ -4613,6 +4667,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 	dev->ethtool_ops = &virtnet_ethtool_ops;
 	SET_NETDEV_DEV(dev, &vdev->dev);
 
+	dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
+
 	/* Do we support "hardware" checksums? */
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_CSUM)) {
 		/* This opens up the world of extra features. */
-- 
2.40.1


