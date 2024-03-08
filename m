Return-Path: <linux-kernel+bounces-96933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCAA876355
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C979C1F21212
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A198255E71;
	Fri,  8 Mar 2024 11:27:58 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C84843ADD;
	Fri,  8 Mar 2024 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897278; cv=none; b=oGD+bT/M2QlnOWptuLdTjT7lxDadK4jTSN19m5fRhezzOxROacIjJxsHAWkwqoy8p3jHge/4gjZbzSt0bV21SVdUDEEnMoRIQLmhNQ+IF/lA5rj24RBJDfwKVDBrG+klL+hXpE4f/dFUSGvlvrVbHQ4hjah6hXRA72qI997d584=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897278; c=relaxed/simple;
	bh=VTPH+JNJ6CLElaJAbYKAkCfrHM9O2J1kjTRfhjSjd2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yhn9b9xymdgg67basWLTtntrD7hYrDqdKKmL+vtsJ8+Jr0Z0FZG6jGpDiNkhzrkWa4Jgmav8n/IzRDLfqJOejPw9B1/s9jVHCMzDsbtRtrJhJxs1t4O96984cZl/KEx+4K8seQzsmGbn6zW4Ps3c7UC4h1ZxqEzl7xvhLoGrk/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56682b85220so891521a12.1;
        Fri, 08 Mar 2024 03:27:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709897275; x=1710502075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qI+9EY7tzIYxs5Vpyz3cprJUSGJAHgHmPUUQiiDZ9PQ=;
        b=ODsEJ032NnZBoZdH7jGISAQEuQkpag8Dss+A27EalCe+wyv8HxLRAdNlJHFC4so+dX
         dZzbzEV8J1HTu8hSdGs6jMOMHJ2ixE9Mryef+eEzFM/IH4RU2hubq1xQ2Qfb1vn3+grX
         1h2TGIeuKNwLt1fH1Rm/pFlTPAm7dqz0DSEtJnsId906u95EGMlQZSDioEkXF3/RLAYt
         5P0dZuJRyC2lqSq+4FrS6nSw7AdTZn0w+YcBF+ss40DU0bPRsg/+D8OSk+W9VTkbzw9G
         kgIBEzkjtN+Go71LCkAi/kxmODZ836PSEnPTMPjrONnrhsx8DpgodWy9+8IAdu3hFvtl
         SzQA==
X-Forwarded-Encrypted: i=1; AJvYcCWr0Z+6p/7REFyjnaBZ6PPY2vL0FWBj+MluNKVLX9hJfOkf2NskTGiXvmWxg7S++MT7BvqM5AAxQA0S99rO+yMUJu+0U59+6b8na6ex
X-Gm-Message-State: AOJu0Ywu4y04BrynpkfvEphX1Adhx6wkYFR3a3elWpoDHaqni+oBKCq5
	qDHu+ZTsMwGqpH2ov+WEsepwdI2Q0FvDx6jp7CHSOmUYEbtes6Jt
X-Google-Smtp-Source: AGHT+IGdfwim53dOX/d0wdKqBpr8eVBgLopTYvjp5ZHw8PeZ2UdHS3kSBFamwUgpLKpuECK067aZsQ==
X-Received: by 2002:a17:907:11c1:b0:a44:1b9e:b977 with SMTP id va1-20020a17090711c100b00a441b9eb977mr14202779ejb.19.1709897274658;
        Fri, 08 Mar 2024 03:27:54 -0800 (PST)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id gb42-20020a170907962a00b00a441a7a75b5sm9146201ejc.209.2024.03.08.03.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:27:54 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	dsahern@kernel.org,
	wireguard@lists.zx2c4.com (open list:WIREGUARD SECURE NETWORK TUNNEL)
Subject: [PATCH net-next v2 1/2] wireguard: Leverage core stats allocator
Date: Fri,  8 Mar 2024 03:27:44 -0800
Message-ID: <20240308112746.2290505-1-leitao@debian.org>
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

Remove the allocation in the wireguard driver and leverage the network
core allocation instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
--
Changelog:

v2:
	* Setting dev->pcpu_stat_type was missing in v1 patch.
---
 drivers/net/wireguard/device.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index deb9636b0ecf..6aa071469e1c 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -262,7 +262,6 @@ static void wg_destruct(struct net_device *dev)
 	rcu_barrier(); /* Wait for all the peers to be actually freed. */
 	wg_ratelimiter_uninit();
 	memzero_explicit(&wg->static_identity, sizeof(wg->static_identity));
-	free_percpu(dev->tstats);
 	kvfree(wg->index_hashtable);
 	kvfree(wg->peer_hashtable);
 	mutex_unlock(&wg->device_update_lock);
@@ -297,6 +296,7 @@ static void wg_setup(struct net_device *dev)
 	dev->hw_enc_features |= WG_NETDEV_FEATURES;
 	dev->mtu = ETH_DATA_LEN - overhead;
 	dev->max_mtu = round_down(INT_MAX, MESSAGE_PADDING_MULTIPLE) - overhead;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	SET_NETDEV_DEVTYPE(dev, &device_type);
 
@@ -331,14 +331,10 @@ static int wg_newlink(struct net *src_net, struct net_device *dev,
 	if (!wg->index_hashtable)
 		goto err_free_peer_hashtable;
 
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		goto err_free_index_hashtable;
-
 	wg->handshake_receive_wq = alloc_workqueue("wg-kex-%s",
 			WQ_CPU_INTENSIVE | WQ_FREEZABLE, 0, dev->name);
 	if (!wg->handshake_receive_wq)
-		goto err_free_tstats;
+		goto err_free_index_hashtable;
 
 	wg->handshake_send_wq = alloc_workqueue("wg-kex-%s",
 			WQ_UNBOUND | WQ_FREEZABLE, 0, dev->name);
@@ -397,8 +393,6 @@ static int wg_newlink(struct net *src_net, struct net_device *dev,
 	destroy_workqueue(wg->handshake_send_wq);
 err_destroy_handshake_receive:
 	destroy_workqueue(wg->handshake_receive_wq);
-err_free_tstats:
-	free_percpu(dev->tstats);
 err_free_index_hashtable:
 	kvfree(wg->index_hashtable);
 err_free_peer_hashtable:
-- 
2.43.0


