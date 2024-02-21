Return-Path: <linux-kernel+bounces-75089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED93E85E2E4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B8A2874FE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4650281735;
	Wed, 21 Feb 2024 16:18:09 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2235D446D9;
	Wed, 21 Feb 2024 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532288; cv=none; b=UZuFggm8Nhatr06MlmOyVu4lfkRjXSnNt2t1G9xmrhyr7dB1vHHxVfetVv1kM71T6nxa6rKYsEPpBSrqrfVwUHeTwmvLg1+C7jOVHRY3mSdNWkqYluVK3xRQrZqLttENhpvRfPIFK+mhFgzWDLTHNgNwJIX0pVf/qUHryqX/qKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532288; c=relaxed/simple;
	bh=/kpFXS2EwZl6WC5jy5PmXQiF+/eQUFkgRYhkxKfh0kE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k/kC6FL56p3PLsKZXbg+sfADq0awWBbcw1pCY1ng4rfnqy4aPYmvHGLNBt3p6IETgNAiYNZKWwMxujmVBHbMttleWbUkNxsh1V/V4y7DyxZDpIDBe5STV5IXVuBiKCOg5wcPrVUVgrovw/M2I9FcVdq+xiidv7g+krRVDHvm4Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso10916511fa.2;
        Wed, 21 Feb 2024 08:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708532285; x=1709137085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Sihn+OQP2RXoSGGMUwVUZ2ON16ouXq3GovfkSaPw3Y=;
        b=WsxQmUFHcBzBi+Iz9i+0KUWpWu6LEsOFcazJUHVooXa9oywIZ/5mC3vznvngobOGgn
         2+e357V1BD6WNPmJmWVlPE/MmR+/MNNOtfUNeXXfs9sdEhQ9u3GnVrusqY/i4i7VM/lS
         OoJVfBesLNs2bzsTEBFfDD25951HyuSXKT4/4uKRz/ovwSI9PLA3Fs5/XFkKeUQpCJbE
         RVFEPAL8QUDRw6KxNO0HFG63NSihVslUMKWqiyd4trG+7haTuFwKdDwxZmiylweYqphC
         vm/SnLr8Yqm9TxK8YB3oblynaO+EuNfTnZBs5RllWrU2nqcOKtjgsISdWwe7ilR/PmP0
         Fnng==
X-Forwarded-Encrypted: i=1; AJvYcCVIjMKFDMBwiOBjENwVu9tAypW2sLnhFPzCGwUekTu8iMynViDn7d3ibFqC4SVBGejKttRKNVAYzLiB19aMBNMdELU6a4voXx6MzFqp
X-Gm-Message-State: AOJu0YzX7yw2Q4QyeudY56vOdcQhK8BT/azlKvU67B7GV8yUw+DA4K60
	OHMYC+twHXs+pL4vHPoxS/uEju7rj9PYuY7ampYW83bfvtrDQ9clsuLjsbHErQ0=
X-Google-Smtp-Source: AGHT+IHt4rZ/meSl1g3jJEI+lEUS+n3f2D8JDvU7nz30+XQJU73eFFId6Dc8DKReF9u/kRtR9m3oBw==
X-Received: by 2002:a2e:9201:0:b0:2d2:37ff:f54a with SMTP id k1-20020a2e9201000000b002d237fff54amr6803294ljg.41.1708532284991;
        Wed, 21 Feb 2024 08:18:04 -0800 (PST)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id u6-20020aa7d546000000b0056503299e26sm557848edr.88.2024.02.21.08.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 08:18:04 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net-next] ipv6/sit: Do not allocate stats in the driver
Date: Wed, 21 Feb 2024 08:17:32 -0800
Message-Id: <20240221161732.3026127-1-leitao@debian.org>
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

Remove the allocation in the ipv6/sit driver and leverage the network
core allocation.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/sit.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index ed3a44aa1e9d..5ad01480854d 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1408,7 +1408,6 @@ static void ipip6_dev_free(struct net_device *dev)
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 
 	dst_cache_destroy(&tunnel->dst_cache);
-	free_percpu(dev->tstats);
 }
 
 #define SIT_FEATURES (NETIF_F_SG	   | \
@@ -1437,6 +1436,8 @@ static void ipip6_tunnel_setup(struct net_device *dev)
 	dev->features		|= NETIF_F_LLTX;
 	dev->features		|= SIT_FEATURES;
 	dev->hw_features	|= SIT_FEATURES;
+	dev->pcpu_stat_type	= NETDEV_PCPU_STAT_TSTATS;
+
 }
 
 static int ipip6_tunnel_init(struct net_device *dev)
@@ -1449,16 +1450,11 @@ static int ipip6_tunnel_init(struct net_device *dev)
 	strcpy(tunnel->parms.name, dev->name);
 
 	ipip6_tunnel_bind_dev(dev);
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
 
 	err = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
-	if (err) {
-		free_percpu(dev->tstats);
-		dev->tstats = NULL;
+	if (err)
 		return err;
-	}
+
 	netdev_hold(dev, &tunnel->dev_tracker, GFP_KERNEL);
 	netdev_lockdep_set_classes(dev);
 	return 0;
-- 
2.39.3


