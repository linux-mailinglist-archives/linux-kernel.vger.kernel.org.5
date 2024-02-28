Return-Path: <linux-kernel+bounces-85499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AD086B6A7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2DC285947
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266FB79B7B;
	Wed, 28 Feb 2024 18:03:51 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E366479B66;
	Wed, 28 Feb 2024 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143430; cv=none; b=JH2/9lJ6hGr8GdmoHCV1M9qMzvV/tr9l6QxIN7j/rtdgSCP1waZekJFti6X0xfyyIj63p3nC+xE6o8hr1cjnKIYaj0fof7J84kWTPa+dayjm1TGzNZJImLZ0XtBM2AqF5X/2qgh6rdFQjLqKDEX3PIVnLKqITgk6JYNOJ36ITSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143430; c=relaxed/simple;
	bh=uLUoeG2p5PBWHl4cb3f0GiMwfiXFa/nQ44dA6pnXfrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iz37D0crGbeX0eGwCv/s+obpvNYaHVSOZbAjJv+IYVV2TpUDk+fKyTVaBcFcv9I50SzZl2ZbNdsD04AOA8EDKEqUc8pbY6AX8ToaZREJTMYCIvskQ0HRZG1+DY4pN/Vdwz49y4EIkBxHBXscXgz20YtrB0vLuuj6SXW87KT0C6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412b68d1a42so323945e9.0;
        Wed, 28 Feb 2024 10:03:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143427; x=1709748227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KMYCuXLMtP2VJuQAB3ZBbvwXsoOBDrgan9aFbDVxFnk=;
        b=PjUjBSZvlIJnNw8ppZnrnwztVA16Sh32y3hGhQCV3lcmC0Rk+kRFY4rXL5+HfsIVR8
         QpIlEnj2A8tXtCGyGxNL397VZPfPSKn6WzlLShG/NdK5qaDi/4Rfv3eKQ/6n/JyNozKx
         t/AxTJG9071GFkyI4GduEzVDhJ5BNV3SIQLOMItId5a6YHtd9EMFV1DIiRygKm8404UN
         V4oY90FXQYek4g6xbom8K7tYimJo2sP3SHIbb5zjTfOFAQi8sG37mLiHzr2UM8ingKql
         UgZ5zP95vP00rXudZgqK0O0TCRVt9o2RjsEDg7s0Izz4Lj4ggJPE29j1rrt85VSNjpDr
         lMrg==
X-Forwarded-Encrypted: i=1; AJvYcCX1nDY88PH+cr8RtXAK3z82UFood8qJIokfpMYvZJNEL941/Gf+viXFao4xjuQML/8paDlgLihUTUDDe+RyTu7MVJCq3o8/7WXSpCOJ
X-Gm-Message-State: AOJu0Yx3PER3soykVAgK/96rc+vbaaE0L9ZWFwPOtoXHJczgnBNJosbO
	E4TqzVMhADLLc55+gAZ9zIIVAgut0SdXV2LYhpG2O9l6W4jrwSta/2P0Ixm/
X-Google-Smtp-Source: AGHT+IGDCyDDpFXpcxY5/SqQkLBBH1y/2dz2ES/5aJsA7i822OJ6tS6CUn3zoE014dWL86vXjWdxoA==
X-Received: by 2002:a05:600c:46c7:b0:412:b4c:58da with SMTP id q7-20020a05600c46c700b004120b4c58damr2047wmo.9.1709143427108;
        Wed, 28 Feb 2024 10:03:47 -0800 (PST)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id y16-20020a05600c365000b00412656ba919sm2692111wmq.20.2024.02.28.10.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:03:46 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net-next] net: ip6_tunnel: Leverage core stats allocator
Date: Wed, 28 Feb 2024 10:03:17 -0800
Message-ID: <20240228180318.1650988-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
convert veth & vrf"), stats allocation could be done on net core
instead of in this driver.

With this new approach, the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc). This is core responsibility now.

Remove the allocation in the ip6_tunnel driver and leverage the network
core allocation instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/ip6_tunnel.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 5fd07581efaf..e9cc315832cb 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -247,7 +247,6 @@ static void ip6_dev_free(struct net_device *dev)
 
 	gro_cells_destroy(&t->gro_cells);
 	dst_cache_destroy(&t->dst_cache);
-	free_percpu(dev->tstats);
 }
 
 static int ip6_tnl_create2(struct net_device *dev)
@@ -1848,6 +1847,7 @@ static void ip6_tnl_dev_setup(struct net_device *dev)
 	dev->flags |= IFF_NOARP;
 	dev->addr_len = sizeof(struct in6_addr);
 	dev->features |= NETIF_F_LLTX;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	netif_keep_dst(dev);
 
 	dev->features		|= IPXIPX_FEATURES;
@@ -1873,13 +1873,10 @@ ip6_tnl_dev_init_gen(struct net_device *dev)
 
 	t->dev = dev;
 	t->net = dev_net(dev);
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
 
 	ret = dst_cache_init(&t->dst_cache, GFP_KERNEL);
 	if (ret)
-		goto free_stats;
+		return ret;
 
 	ret = gro_cells_init(&t->gro_cells, dev);
 	if (ret)
@@ -1903,9 +1900,6 @@ ip6_tnl_dev_init_gen(struct net_device *dev)
 
 destroy_dst:
 	dst_cache_destroy(&t->dst_cache);
-free_stats:
-	free_percpu(dev->tstats);
-	dev->tstats = NULL;
 
 	return ret;
 }
-- 
2.43.0


