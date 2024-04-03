Return-Path: <linux-kernel+bounces-130115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE87897440
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529201F220E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4662814A4EF;
	Wed,  3 Apr 2024 15:43:28 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EA214A0A8;
	Wed,  3 Apr 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159007; cv=none; b=ttx9kH3FgkAm5EG6sw/9pk2I+GOgaY9u/FnEDGTpil0A+U+IugAgGGsJKWjLofujEOkGi8+tEtJwSmVNzsTE8xoM27u7YlAgvQRMNR/Cknu4WmDxa+H+OyBc9oT64M6zOnR6dXdk5MndoOpy+380zewz41fO9xn/ieKEsdmdCEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159007; c=relaxed/simple;
	bh=X3a4pIGTWIkMI9v/XpREqOBl8ZhpS8U+c8nUeSNcENM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=udBWlt9LTjPBz/mMGq6rhWyrdAqiB4uZFbiKIQoVKTNwl9vsgk9PwTLlZHFezSN37IL8MNc1tO8yp/nQcPvqly/CIVO3Ja/j9JreZm1A66/PLdgM1uaKRO85XO//a+UkonXnVqhiPYWI8UxHOIqq7/FtYNnV78gBHqN0qUR4rik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a44665605f3so111266b.2;
        Wed, 03 Apr 2024 08:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712159003; x=1712763803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYy0xsk/6e7/EP3ZA06B/kwt1hnSoccxl0+aSYTRzhw=;
        b=Xi2a/O6o9nscxp/Q282pPlMx9MQjN5J8d2x6XYoDidEJT0rg6isayhqTnsv1PQDEDo
         yfVPzmKca8zqwfOMbEHEh+2YVlcinqVQYYhP13iC5ONQ0op618Zp3lg4Kl0CwcapNwaV
         jelLpQtbAxJECu8Q3GnxrCQWVpcBoESz3IvBYrJPzBtlg4N2EeSusYezkdMoXP1wHIZd
         Swk8El6gyKzdeKkMXrpxotQ6BuD187l6vaNvqgiTWh/NBwTK28AwJysxs6Bbm+qWjC7x
         6wkQWQxYCu21NgV+FVg2dKRmbh1oBR8miy1r/u4TXYYkQNTmWzH1Ka2wLYeisIypcYX9
         NTBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4OjfHJn1dWdEL+fDt3n3y18Q+TjBfukM7GQ2RFvDLP6JtKW1EpytLT2ds9rYZy1NwNRHKM4qOPgeiSZfif7a5EhYzUNcJHDuhNaB28Tr+VWCvwq50/4kWBAtsECl1QhvVYZTbPjHyrWA7bXxBDQo5X3pezDB2FnR4vIoV
X-Gm-Message-State: AOJu0Yx1OZwz3Ko389lUY1H5wUSTnPNcm5RjPDcGaF5YfaYEl5zx5rLR
	1nfWtq2C2wrlegTd+lTKUaUJVu8x7REeme0ku1Ehzi1tNzyRn6f+
X-Google-Smtp-Source: AGHT+IGjMXBqyqOYrFRXxpu0T86R9H2NUxfGQRZ7Sm1nQSfyM8IFBGndg+xpb3YMbBIoQ8iZBhCSaA==
X-Received: by 2002:a17:907:868d:b0:a51:7d1a:e10d with SMTP id qa13-20020a170907868d00b00a517d1ae10dmr503935ejc.32.1712159002989;
        Wed, 03 Apr 2024 08:43:22 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id wn2-20020a170907068200b00a4e781bd30dsm3029235ejb.24.2024.04.03.08.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 08:43:22 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: hengqi@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Melnychenko <andrew@daynix.com>
Cc: rbc@meta.com,
	riel@surriel.com,
	stable@vger.kernel.org,
	qemu-devel@nongnu.org,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v4] virtio_net: Do not send RSS key if it is not supported
Date: Wed,  3 Apr 2024 08:43:12 -0700
Message-ID: <20240403154313.1331319-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a bug when setting the RSS options in virtio_net that can break
the whole machine, getting the kernel into an infinite loop.

Running the following command in any QEMU virtual machine with virtionet
will reproduce this problem:

    # ethtool -X eth0  hfunc toeplitz

This is how the problem happens:

1) ethtool_set_rxfh() calls virtnet_set_rxfh()

2) virtnet_set_rxfh() calls virtnet_commit_rss_command()

3) virtnet_commit_rss_command() populates 4 entries for the rss
scatter-gather

4) Since the command above does not have a key, then the last
scatter-gatter entry will be zeroed, since rss_key_size == 0.
sg_buf_size = vi->rss_key_size;

5) This buffer is passed to qemu, but qemu is not happy with a buffer
with zero length, and do the following in virtqueue_map_desc() (QEMU
function):

  if (!sz) {
      virtio_error(vdev, "virtio: zero sized buffers are not allowed");

6) virtio_error() (also QEMU function) set the device as broken

    vdev->broken = true;

7) Qemu bails out, and do not repond this crazy kernel.

8) The kernel is waiting for the response to come back (function
virtnet_send_command())

9) The kernel is waiting doing the following :

      while (!virtqueue_get_buf(vi->cvq, &tmp) &&
	     !virtqueue_is_broken(vi->cvq))
	      cpu_relax();

10) None of the following functions above is true, thus, the kernel
loops here forever. Keeping in mind that virtqueue_is_broken() does
not look at the qemu `vdev->broken`, so, it never realizes that the
vitio is broken at QEMU side.

Fix it by not sending RSS commands if the feature is not available in
the device.

Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Cc: stable@vger.kernel.org
Cc: qemu-devel@nongnu.org
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
---
Changelog:

V2:
  * Moved from creating a valid packet, by rejecting the request
    completely.
V3:
  * Got some good feedback from and Xuan Zhuo and Heng Qi, and reworked
    the rejection path.
V4:
  * Added a comment in an "if" clause, as suggested by Michael S. Tsirkin.

---
 drivers/net/virtio_net.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..115c3c5414f2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3807,6 +3807,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
 			    struct netlink_ext_ack *extack)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	bool update = false;
 	int i;
 
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
@@ -3814,13 +3815,28 @@ static int virtnet_set_rxfh(struct net_device *dev,
 		return -EOPNOTSUPP;
 
 	if (rxfh->indir) {
+		if (!vi->has_rss)
+			return -EOPNOTSUPP;
+
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
 			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
+		update = true;
 	}
-	if (rxfh->key)
+
+	if (rxfh->key) {
+		/* If either _F_HASH_REPORT or _F_RSS are negotiated, the
+		 * device provides hash calculation capabilities, that is,
+		 * hash_key is configured.
+		 */
+		if (!vi->has_rss && !vi->has_rss_hash_report)
+			return -EOPNOTSUPP;
+
 		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
+		update = true;
+	}
 
-	virtnet_commit_rss_command(vi);
+	if (update)
+		virtnet_commit_rss_command(vi);
 
 	return 0;
 }
@@ -4729,13 +4745,15 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
 		vi->has_rss_hash_report = true;
 
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
 		vi->has_rss = true;
 
-	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_indir_table_size =
 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
 				rss_max_indirection_table_length));
+	}
+
+	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_key_size =
 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
 
-- 
2.43.0


