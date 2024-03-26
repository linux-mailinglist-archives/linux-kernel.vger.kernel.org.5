Return-Path: <linux-kernel+bounces-119290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0C688C6AD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4261C638F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9D313C8FC;
	Tue, 26 Mar 2024 15:19:25 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6A313C831;
	Tue, 26 Mar 2024 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466364; cv=none; b=gq9Nsj8QyeA7a952H3/8c+k0ZZTl27/ZM7tg0nqSwHeGnCIas3C1ASzSLO6jt/Y0FKT1xmW2OWLeNTFLoXRsVd9KFg1JaCIQLc9OzN3WFhzPv2syeVNz0u8Wh1FRkpz22B/aOGCopk9e6gSpfYFOB1aZs9zp+hcycBLBeUTwCsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466364; c=relaxed/simple;
	bh=t/j9B4d1DAJG+x0WZEKX9sM5rtk+d1CT8qkjyuhY0Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SrzJKHvPnf+QA8dMtc98YyWSqPAVhx6t1gzSKtu03KHRT9V0Fmurutd4ENB/zpWdZI5AOJQ7ZiF22exTOX1Xjwd8qYaUTDz3CmHHgi8kMheS03+uF1As3DAnN4CaEGCwIO2IVggkQ4YZi3bsyTet4tbRrROFvenZVAe11nPcgto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so4899242a12.0;
        Tue, 26 Mar 2024 08:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711466361; x=1712071161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tswsOTneScV35e8ze8rWgk0pT/EhtrIbNgyGirLZBUU=;
        b=rmcmEJ3zXU9nBLcvIa90ploL4bSOvIYEmp+9udi/U1GswxP9fON4zVd723mougbfQx
         K6sSp35jKMz7rAzkxDCSxI68Z0zlFAf2jbx6UuKI3w+tLHECeiVXW/cCjYJUD6PiZfw8
         pFYaBMdF7HkyViaVZMyhvbiq78FG8T3Cq3L1Yf81jwQbOO6paXzUmPBuOoKHL+dxjtgB
         phwjXDq0vHtsFAY+qjVqkiEOX6H3dewUz5n/jFUsl35cPwnMS8WhH/gQQb0PN+B3jdY/
         CQ63vD03OmhZTqLNz+O0WKKa/eSKsypgil9jjgVLck4dZjGiRQo4ukvBEE0IDCviNi7Z
         KpYA==
X-Forwarded-Encrypted: i=1; AJvYcCWVP1f1fhiDjdp4tMQvaxjrumT3gr5tzq6+B8SJ+IWefeI3fxZlYntioOUIbSLePniiLi7PGio2Svy3nHfwwgyPznGj6sViFFoTE2N6QRoe3Giy/xt5MTsgg4V1yZMmQJBu5Ihq
X-Gm-Message-State: AOJu0YyXOIIX/qFhv2wITcVhUXPsMTU61plnKD5K/3U9b4ZruDixRLvg
	RPTTXVIPpqvAgs9XZ0WqRrABW+TwOchl6TXJcUxWOARJrauuLuaw
X-Google-Smtp-Source: AGHT+IGDFkOEbOFg6NKy2/q2daPeK0G7VvTQ5PUqeGY5wLXijc72wcmqCJ4IBXYbih5UcuyivJHFvw==
X-Received: by 2002:aa7:ccd5:0:b0:56b:8d0e:1a08 with SMTP id y21-20020aa7ccd5000000b0056b8d0e1a08mr1222540edt.26.1711466361233;
        Tue, 26 Mar 2024 08:19:21 -0700 (PDT)
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id i23-20020a056402055700b00569731a1eb2sm4254328edx.46.2024.03.26.08.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:19:20 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: hengqi@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: rbc@meta.com,
	riel@surriel.com,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 1/2] virtio_net: Do not set rss_indir if RSS is not supported
Date: Tue, 26 Mar 2024 08:19:08 -0700
Message-ID: <20240326151911.2155689-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not set virtnet_info->rss_indir_table_size if RSS is not available
for the device.

Currently, rss_indir_table_size is set if either has_rss or
has_rss_hash_report is available, but, it should only be set if has_rss
is set.

On the virtnet_set_rxfh(), return an invalid command if the request has
indirection table set, but virtnet does not support RSS.

Suggested-by: Heng Qi <hengqi@linux.alibaba.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/virtio_net.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..c640fdf28fc5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3813,6 +3813,9 @@ static int virtnet_set_rxfh(struct net_device *dev,
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
+	if (rxfh->indir && !vi->has_rss)
+		return -EINVAL;
+
 	if (rxfh->indir) {
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
 			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
@@ -4729,13 +4732,15 @@ static int virtnet_probe(struct virtio_device *vdev)
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


