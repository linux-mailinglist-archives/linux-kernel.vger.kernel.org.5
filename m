Return-Path: <linux-kernel+bounces-76717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F6885FB73
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEFE31C23B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DD51482FB;
	Thu, 22 Feb 2024 14:41:29 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4009131720;
	Thu, 22 Feb 2024 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612888; cv=none; b=PGygAs33xKdHYIfQUBlGgbA8m+dABwhIipbGbxTkNsllwHKC/cqrIdzREI1OoJRea/yxCPMEFhAISXyp+QWoS04vz/zBcijtBbPKtQ8BXSNciW8NFgS0HCxVOKgTlbKu9hesEVloVRdbkekzrdMKcv1sWvJgde0F80cB3OvDvQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612888; c=relaxed/simple;
	bh=Dh6zs2Kg5ny/Fs0knD5Ran/0OjSXvnBAh0w6XIv3o9o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DSEnuXD9rWrpOSDYsS6DvkeCt2LR1iQAQD5rnN3t5SuHAtM/vRXUAhaNcLrR0WA41g69xd2+AL19ucHMtegvzy2hYJjjxJ3rGMMigjczXz34Z2jk9vxJzPBNrP7yW/yPvsMu0RUDa66k+jzeIarMFhOHe4NceimxeuOSnXAjkNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so1107173366b.2;
        Thu, 22 Feb 2024 06:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708612885; x=1709217685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYMQtEKjt0kzQOUifzkf8vblM5DsGEnUyHabUP9ToJk=;
        b=tKQbfjy/JlkAxbYGGiqcwRUQponHdX3jaSps+OuXvEPKx57GbgdSWuHCUQVMjT0UOf
         tJKHcQs8+8Nxwd3xmQM032HPB/rTE4bjyqSSw/gMmR5zLS3BGtdex2YEdJ9eZpXPDUH1
         TzAn3WB2rv08jINr0nRb5szhJ5PnBBFveh83kWa2nBdHzj0VA3GW2deecH1rW7DCWtRB
         LCySEd3a1eRnEdY2DcyRmr38mhIZ3j4HGcQoq0yCZ0WIc0BM6+oIvS3sx7jTD5chL0ic
         GaoAmajIH9KcpNBU+opi76qpiF2dAsiNt5Q07qpYgJk4DKSc2/s8Ik5auBrVK3hrZEx4
         tNVw==
X-Forwarded-Encrypted: i=1; AJvYcCX1DObZAs8iGnHYjq7T/PH3ggH5Nutfg6DTSxKHqLJr9hLPQ3+a3JNAmd5/I2CY4GGHRH/YItOBDK4HEX1UG5ZZkXIrFprsLpelYlcN
X-Gm-Message-State: AOJu0YwqTTR2lvHJxc2GO430CffGYNgDUSf0mfpDqNyKCjaeAIdE7IUA
	NgtROfCNQQPKTCjYrk1/c6iBMtu4TLSxLthrFmkKYojbWiOfPuyW
X-Google-Smtp-Source: AGHT+IGj3MI75zu42johqwAAkq+37E/uOirM4qBhtwLOTanuJlhYSjcSNsJcGr6EE4H0gCD+wCB9pA==
X-Received: by 2002:a17:906:d7b0:b0:a3e:549f:eeff with SMTP id pk16-20020a170906d7b000b00a3e549feeffmr8985316ejb.7.1708612885039;
        Thu, 22 Feb 2024 06:41:25 -0800 (PST)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id an3-20020a17090656c300b00a3e77f93ea9sm4533954ejc.98.2024.02.22.06.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 06:41:24 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net-next] xfrm: Do not allocate stats in the driver
Date: Thu, 22 Feb 2024 06:41:17 -0800
Message-Id: <20240222144117.1370101-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
convert veth & vrf"), stats allocation could be done on net core
instead of this driver.

With this new approach, the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc). This is core responsibility now.

Remove the allocation in the xfrm driver and leverage the network
core allocation.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/xfrm/xfrm_interface_core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index dafefef3cf51..cc19aa7fdc11 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -240,7 +240,6 @@ static void xfrmi_dev_free(struct net_device *dev)
 	struct xfrm_if *xi = netdev_priv(dev);
 
 	gro_cells_destroy(&xi->gro_cells);
-	free_percpu(dev->tstats);
 }
 
 static int xfrmi_create(struct net_device *dev)
@@ -749,6 +748,7 @@ static void xfrmi_dev_setup(struct net_device *dev)
 	dev->flags 		= IFF_NOARP;
 	dev->needs_free_netdev	= true;
 	dev->priv_destructor	= xfrmi_dev_free;
+	dev->pcpu_stat_type	= NETDEV_PCPU_STAT_TSTATS;
 	netif_keep_dst(dev);
 
 	eth_broadcast_addr(dev->broadcast);
@@ -765,15 +765,9 @@ static int xfrmi_dev_init(struct net_device *dev)
 	struct net_device *phydev = __dev_get_by_index(xi->net, xi->p.link);
 	int err;
 
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
-
 	err = gro_cells_init(&xi->gro_cells, dev);
-	if (err) {
-		free_percpu(dev->tstats);
+	if (err)
 		return err;
-	}
 
 	dev->features |= NETIF_F_LLTX;
 	dev->features |= XFRMI_FEATURES;
-- 
2.39.3


