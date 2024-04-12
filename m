Return-Path: <linux-kernel+bounces-142934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B66B8A323F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DDBD1F2619A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319B8149018;
	Fri, 12 Apr 2024 15:19:46 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0559E148FEB;
	Fri, 12 Apr 2024 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935185; cv=none; b=QLUS2TzV625M2vi++EwCyHKZ3LnaVot6HS3PSuQ3yx3fTehIQLxIbcK2+99arpTynTNNpcQw/j215uMXq41+7RtDUkKky4ES8QPk/qpDmE83UexGHHbFXZo9ZazSYHI55goQ/PK6LiAOswjm5ZnOT7Y6R7BV4ookBKP7AuGQjW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935185; c=relaxed/simple;
	bh=FvqEqe3MTT50afwWaUsr48s47BsocIrCd/3V3OFcp9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nDWiMiWWylkQyqm999BGQGLSaH7oeezSo96AjSE2O8d1AM674ZHT5SjD+Zzn51t/KwRCcGWs7qjlUQAmC0FZJKR8H8a+pDendieSPjawsycmZGe/KNZ00E/XboIn5zSKoSSKshGnQ6jZvPYsb9ERU31Jb0lkbXkCBlq//6jIhGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a521fd786beso130655966b.3;
        Fri, 12 Apr 2024 08:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712935182; x=1713539982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Toy+6eJwj8m4A5nHvTu6+7St99Me1YSKR5Lk0IsG71I=;
        b=KzQg3u8Lg13SmWnHZo67LrOZBuNZUuuxvbB4E0jRL3z+nvMDvb6NORVnLBJtrqgj03
         Bmh6M42JH7VeTGvCjgZ8Pd7r3Yu031cRTpDJpNI/iqWbJ44TElBT8Gq+QgSrt5E91S9x
         k/shhsBtvz1uXqfmzCXuResX0O6NdAeeZgnrG/T9Zz2R9yMpoDHNv1JqaTrW/jjITrR+
         i6InVEswKKBEHxeNe2zBTdUDjQgAG0kyKyORqxSYmA4FBp7/oFQfWkeR1+gH2FRgNyH5
         M7wjXIwgOf45w5YjbpLBZ1UV99cGl0AmpXvJIDXw+/3gS9uh06UBDPq1vD+kPf8rSLTk
         O+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVCMD/ubU/iGZ9wHkb8noDIYfBESWeoKerC+dvJUtvm/Z543yv9a7DngUjtEpgEpCM3BwFnLJ9dNw5rt4pR4h20Ztg+b948JVQUl++K
X-Gm-Message-State: AOJu0YznYY4dkaS0bcbfhrffeUcFKBS8aH5IQJyGkXlFJz4263sNHIKg
	BqKQqELhiOP1iSFdd/Yuce0Ysy+HTWa72O/FsGxHK9ysovUWUhhd
X-Google-Smtp-Source: AGHT+IEk7l/ee2i5g6wDGH+J38stVV5NJ/nSwaYbDEoMIwN8scIhkT4LedWitUP6SSacIZp0eiYmrw==
X-Received: by 2002:a17:906:607:b0:a52:2e91:321e with SMTP id s7-20020a170906060700b00a522e91321emr1988820ejb.72.1712935182068;
        Fri, 12 Apr 2024 08:19:42 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id w17-20020a1709067c9100b00a4a396ba54asm1928145ejo.93.2024.04.12.08.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:19:41 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net-next 1/2] net: ipv6_gre: Do not use custom stat allocator
Date: Fri, 12 Apr 2024 08:19:25 -0700
Message-ID: <20240412151928.2895993-1-leitao@debian.org>
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

Remove the allocation in the ip6_gre and leverage the network
core allocation instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/ip6_gre.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 95fbdaf85711..b5b417902c0a 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1444,7 +1444,6 @@ static void ip6gre_dev_free(struct net_device *dev)
 
 	gro_cells_destroy(&t->gro_cells);
 	dst_cache_destroy(&t->dst_cache);
-	free_percpu(dev->tstats);
 }
 
 static void ip6gre_tunnel_setup(struct net_device *dev)
@@ -1453,6 +1452,7 @@ static void ip6gre_tunnel_setup(struct net_device *dev)
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = ip6gre_dev_free;
 
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	dev->type = ARPHRD_IP6GRE;
 
 	dev->flags |= IFF_NOARP;
@@ -1500,13 +1500,9 @@ static int ip6gre_tunnel_init_common(struct net_device *dev)
 	tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
-
 	ret = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
 	if (ret)
-		goto cleanup_alloc_pcpu_stats;
+		return ret;
 
 	ret = gro_cells_init(&tunnel->gro_cells, dev);
 	if (ret)
@@ -1530,9 +1526,6 @@ static int ip6gre_tunnel_init_common(struct net_device *dev)
 
 cleanup_dst_cache_init:
 	dst_cache_destroy(&tunnel->dst_cache);
-cleanup_alloc_pcpu_stats:
-	free_percpu(dev->tstats);
-	dev->tstats = NULL;
 	return ret;
 }
 
@@ -1893,13 +1886,9 @@ static int ip6erspan_tap_init(struct net_device *dev)
 	tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
-
 	ret = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
 	if (ret)
-		goto cleanup_alloc_pcpu_stats;
+		return ret;
 
 	ret = gro_cells_init(&tunnel->gro_cells, dev);
 	if (ret)
@@ -1921,9 +1910,6 @@ static int ip6erspan_tap_init(struct net_device *dev)
 
 cleanup_dst_cache_init:
 	dst_cache_destroy(&tunnel->dst_cache);
-cleanup_alloc_pcpu_stats:
-	free_percpu(dev->tstats);
-	dev->tstats = NULL;
 	return ret;
 }
 
@@ -1948,6 +1934,7 @@ static void ip6gre_tap_setup(struct net_device *dev)
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = ip6gre_dev_free;
 
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	netif_keep_dst(dev);
@@ -2250,6 +2237,7 @@ static void ip6erspan_tap_setup(struct net_device *dev)
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = ip6gre_dev_free;
 
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	netif_keep_dst(dev);
-- 
2.43.0


