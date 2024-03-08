Return-Path: <linux-kernel+bounces-96839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD69487620D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62CDA1F217BF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D4555777;
	Fri,  8 Mar 2024 10:34:34 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8821B54F8F;
	Fri,  8 Mar 2024 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894074; cv=none; b=ULgaw/L/yTOe0ck9+bYBJ4tzizbPlRPBn5ciDmGESV543w7Hrg2AI+f5ugsA57I1a9kKeTvUR7Uelo99Q3I/Ear5hXdZ14v90zlnPm4Mxwx5Xq6NLq4PhQpqprIQrQ0m42n4O6BgT0LJbmqPtZ/ALtuHtR9aen1WWrk/p/NJYW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894074; c=relaxed/simple;
	bh=fhMVTHMazCNZj07eMzDXJctYEUQY3FyCp3L4GcqhJ1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AsCEDplW2/hvV4O1/JGx1THwWI4xkZ83BmBTIsDxFYnLxHCeMEh0L1CGlbLxy1YZ8Y37NKLJjQqit+sRDOIaKqbuIOdAYBeBjuEKsrXr/FrLqokEkl/E9cw5NoTb5rsXrNLLMd+tIU7wYHfGSpUsACajnzPrRVmDcp4MxtL3Zys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so2239499a12.0;
        Fri, 08 Mar 2024 02:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709894071; x=1710498871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDoFAf/EWOLeF9600iXmBhzVjPZO0aaKJXl+GmInLQk=;
        b=VzgwqwwI6fly6XqqFR+Wdc6tm9WMFbtRaNZFYQO9PvCTHTQYc+YvpAB8/16650tuaa
         ff3Nrhfb+2fx7HCQWRjtzFgKlZ2VhBZpgfHs/0IaGkT1u3iGlBMMbQgxkOyTILrwudWI
         XClJp7sRuwqMBtZjJ649l9pj4sQLKP2fyH4/suKPwPnNwdIBUH+yeVgvCk4cUNyOj+eq
         YejAKEoTQt0A1JuXNl2xLmVevX8TV3J/hZ4v6RikpTEMuFzUeK+6iX0TQd8cqOL1fnH8
         4eoPU3/dbgBl/w2ZcLY1/k7SqMY+MdG+PAUHS1TXrd8FL6A6Tn75R80wuerV9McvKfHZ
         Wqcg==
X-Forwarded-Encrypted: i=1; AJvYcCXy/U/MF7WModL1N8IFUOu/zWyw3UNtB2bBdShgHcjxcKXgbrc1XfYj9uVO3ljQvi+CxxnVDo5JW3NI1935AEmdp9ogivAZ12tudE5T
X-Gm-Message-State: AOJu0YyLzYTmoLHpm9UcJsdrdmonkwRGFY8TpJOAa5KeSKu201jtX+9a
	jS9u8D1F5qXNbiL738353gZz/EB02r37TQsSOpcwEKF+p0+Y+BKC
X-Google-Smtp-Source: AGHT+IEJMBNjE1KzZZWYOZbl0RRbmyKgc2oj55yl0Ule29SisD4BdzhDEO1dS4GvHWr++b4B33BelQ==
X-Received: by 2002:a05:6402:5c4:b0:566:b2e1:58f with SMTP id n4-20020a05640205c400b00566b2e1058fmr1513116edx.41.1709894070654;
        Fri, 08 Mar 2024 02:34:30 -0800 (PST)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id o14-20020aa7c7ce000000b0056742460f68sm5716057eds.66.2024.03.08.02.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 02:34:30 -0800 (PST)
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
Subject: [PATCH net-next 1/2] wireguard: Leverage core stats allocator
Date: Fri,  8 Mar 2024 02:34:17 -0800
Message-ID: <20240308103419.1771177-1-leitao@debian.org>
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
---
 drivers/net/wireguard/device.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index deb9636b0ecf..cb025ba8f60d 100644
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
@@ -331,14 +330,10 @@ static int wg_newlink(struct net *src_net, struct net_device *dev,
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
@@ -397,8 +392,6 @@ static int wg_newlink(struct net *src_net, struct net_device *dev,
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


