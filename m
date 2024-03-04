Return-Path: <linux-kernel+bounces-91119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0BF8709BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E910E1C21D5F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721D97993F;
	Mon,  4 Mar 2024 18:38:51 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3489B78698;
	Mon,  4 Mar 2024 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577530; cv=none; b=PqLRCtP9qbPV7ay63POguJORqRX2ZxyDEHgoTm47hvXWb7GTsu/w/8YhZx/uYLmmbn138RnOeeh4p35IW9d47FYw0RFTZgd8P2iQpe0c2jsffD4/bsTcpBOe7j9ALJXC0lAQMlWSXvJSo3BSoPDaTj0h32Ea6CNu318nhP4bKKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577530; c=relaxed/simple;
	bh=+juVcYk4qeGIcuSKSQA26jTcPanFQBQTHQWtjYPzxQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H8ETk0RozXbSBtTGdk6pIVUQNs4Ymd/aXwd53u6BSKpluyiSMNu4NeE2heZYFTPCZSK1Io6Ocyv13Te3E7iH1lc/g5bTL1FSZ9bG24tu4zPThkqKfTNKDMZSQ+F+1bHUjMWU3qn2UR0nhbxjKou2b3PXW31BLowLrV6z1t1ObhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so6308666a12.0;
        Mon, 04 Mar 2024 10:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577527; x=1710182327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tpuyayzAPkavhecbPCeBqxZM5Q9OhC9n++6ENUjv9s=;
        b=w31KqUKVXA20UF2ClFMa3f1Wh5oD5X9LNZIwSkFjTtB/z81yTI7k1X4uvdeBSZGor2
         WLQ9wgmQ7c/uqx/LxVGJUBRJ6AK9KUQcT4qOSMEttzvx+vqi4kAs3dQQ39uorqnqYAWE
         reeqpeOtHnLjTqrF/EnuXHzau/ggjItI68JAzi6T9u8hCKyKbWWhxOkpvIYxIgsz1zM4
         Zfotc6775W0IZVJvnwAK5q5ng6ikAgL1x0C5/xdb5ePRdu2LE4ftrvGh2qckBDhn76zL
         JKRZ9mk0c5LOa6+/ErBeZ62Mvgc1krp0v6f87DLEP5YHquYC7B4Y8rxPB2cyA0xyvaFq
         ajKw==
X-Forwarded-Encrypted: i=1; AJvYcCVG2z96ERs7WkW2g5fuiA/7uNJynvRTfM2jfcRSMZBxteLXxh9Nqo+rOuTdDdyZhBh+5Q23sN6gTjxL4+bfcf+QIGI9h5MfjOrkm/Fo
X-Gm-Message-State: AOJu0YygjtWjNhDmxyejZKabVH06UiW4wJok8bYd/j/h4BUAL4G4TDxM
	LVYkcgTcwTg+s8//AtmBGRNTG8TxRXlky6ponKgdHhxn+dmiSPIquuNL/P6e
X-Google-Smtp-Source: AGHT+IH/N9zYpKg0OzMCx98jQwubycWmSZwlvoEFO/oPP5exY9QTBwAxb4AYOKyv/bSzSlcYagJpDw==
X-Received: by 2002:a05:6402:2032:b0:567:5d76:6ea2 with SMTP id ay18-20020a056402203200b005675d766ea2mr2193697edb.39.1709577527328;
        Mon, 04 Mar 2024 10:38:47 -0800 (PST)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id ev16-20020a056402541000b0055d333a0584sm4927405edb.72.2024.03.04.10.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:38:46 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	dsahern@kernel.org
Subject: [PATCH net-next 1/2] net: tuntap: Leverage core stats allocator
Date: Mon,  4 Mar 2024 10:38:07 -0800
Message-ID: <20240304183810.1474883-1-leitao@debian.org>
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

Remove the allocation in the tun/tap driver and leverage the network
core allocation instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/tun.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index be37235af55d..6c594a3c2c37 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -977,20 +977,15 @@ static int tun_net_init(struct net_device *dev)
 	struct ifreq *ifr = tun->ifr;
 	int err;
 
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
-
 	spin_lock_init(&tun->lock);
 
 	err = security_tun_dev_alloc_security(&tun->security);
-	if (err < 0) {
-		free_percpu(dev->tstats);
+	if (err < 0)
 		return err;
-	}
 
 	tun_flow_init(tun);
 
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	dev->hw_features = NETIF_F_SG | NETIF_F_FRAGLIST |
 			   TUN_USER_FEATURES | NETIF_F_HW_VLAN_CTAG_TX |
 			   NETIF_F_HW_VLAN_STAG_TX;
@@ -1008,7 +1003,6 @@ static int tun_net_init(struct net_device *dev)
 	if (err < 0) {
 		tun_flow_uninit(tun);
 		security_tun_dev_free_security(tun->security);
-		free_percpu(dev->tstats);
 		return err;
 	}
 	return 0;
@@ -2317,7 +2311,6 @@ static void tun_free_netdev(struct net_device *dev)
 
 	BUG_ON(!(list_empty(&tun->disabled)));
 
-	free_percpu(dev->tstats);
 	tun_flow_uninit(tun);
 	security_tun_dev_free_security(tun->security);
 	__tun_set_ebpf(tun, &tun->steering_prog, NULL);
-- 
2.43.0


