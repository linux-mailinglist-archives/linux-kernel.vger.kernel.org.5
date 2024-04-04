Return-Path: <linux-kernel+bounces-131473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C42F898851
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2ED81C2171A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F3B8528F;
	Thu,  4 Apr 2024 12:55:15 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5704F74C00;
	Thu,  4 Apr 2024 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235315; cv=none; b=RDfE4SjrbG7ECTxWbZDM5bXfcnI6qjYKnM9IVt8awJ7uxHtdhFhURWQxYN+7eEYOqbcHdBCjvhqOe4q5BjWsZaLbhbeFQ2+njELt8bZRLhV0bXj4/7mBOB2ZYrO0xXhuMiQX3fcA58kSsqruzFPLShUqmer7YSEinO5I0ua0YnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235315; c=relaxed/simple;
	bh=dPN1XIYZHMHhh9RnEpKeMSKeOJTNh6ZnfxvHKWA1TH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DSB0ROu7HwKDpVxKkiecrxqhCZAj25hrSnlgKoSJT4KY82MBuQmLrlxfGrMpAzMHl4Rkhw7HPyo+6QmeWNcK2dPxevyAYOTyZwIcyUXCPmsYMu1bb3DXV1i/c6ZZ9yfj7GyIRTGV3tN4jwm8/Ox14bTxSRLxqu2PbyzAbcl8kqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e0acaf69aso1159802a12.1;
        Thu, 04 Apr 2024 05:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712235312; x=1712840112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3466ZjMjskIJftqg4f5cHcLCev2A3jUv1Ffxs6nlINg=;
        b=ZwAnZ9QVT7UvtTRTQe/5eAEInX6iD2guDyPlR4v+io7HjRL5hLdI29IjRHwGtb/Ftt
         W4OAM6H+LQJj/YzYt+QYDbcA/3u4DkdWrdW8eHT/nnt1c4hejBjYybTayuebqXlgCfAw
         DCBZgfdr/FL6y267iD+TUCD+HGLdnHDpXl3MAyMjmChzAE975OHiT9D+uwlvuzehmU7f
         hrZ9QG8UHhON5v1JDH/HnYbTLwBQr5HY5WwF2S1ihhsjCDc2Rl+IPWONFT6Cri82p8Rd
         JMrE3Z4HupYMWX6StPY3JE9nFHANOn0VYzCrj8SEm1/Ct70SbFTzDLbRwOhpRJ1HRLSW
         RN3A==
X-Forwarded-Encrypted: i=1; AJvYcCUS0eQnSMxdmzERDNY8lOOfmCEAbe1ajUxAOWXlTGokr7DaQhG+ymcucu2ep12xr57QaCKq0fDRrNr1cXRmJcpNkLhByUj6
X-Gm-Message-State: AOJu0Yw+0Nt61uuMgE8tOtpc1VsU2pcFH5Y06o6shvWvaYOJxTmSJw24
	2syTvRXjS824xnKt68KhtbzSSOKBZJtuGMa7Ab7/jo+J5n2RocUf
X-Google-Smtp-Source: AGHT+IGDrrFb5siytOmMVsdz8V3PBOY6CDdruFwkN0bRzC0kWY2xIbrlaz1+6c8++jg1SSd+v4b23A==
X-Received: by 2002:a50:9b5a:0:b0:568:32cc:f808 with SMTP id a26-20020a509b5a000000b0056832ccf808mr1550610edj.15.1712235311336;
        Thu, 04 Apr 2024 05:55:11 -0700 (PDT)
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id fe8-20020a056402390800b0056c522d014esm9078701edb.57.2024.04.04.05.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:55:11 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/2] ip6_vti: Do not use custom stat allocator
Date: Thu,  4 Apr 2024 05:52:51 -0700
Message-ID: <20240404125254.2978650-1-leitao@debian.org>
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

Remove the allocation in the ip6_vti and leverage the network
core allocation instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/ip6_vti.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 7f4f976aa24a..71c749bb4b3e 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -174,11 +174,6 @@ vti6_tnl_unlink(struct vti6_net *ip6n, struct ip6_tnl *t)
 	}
 }
 
-static void vti6_dev_free(struct net_device *dev)
-{
-	free_percpu(dev->tstats);
-}
-
 static int vti6_tnl_create2(struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
@@ -907,9 +902,8 @@ static void vti6_dev_setup(struct net_device *dev)
 {
 	dev->netdev_ops = &vti6_netdev_ops;
 	dev->header_ops = &ip_tunnel_header_ops;
-	dev->needs_free_netdev = true;
-	dev->priv_destructor = vti6_dev_free;
 
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	dev->type = ARPHRD_TUNNEL6;
 	dev->min_mtu = IPV4_MIN_MTU;
 	dev->max_mtu = IP_MAX_MTU - sizeof(struct ipv6hdr);
@@ -931,9 +925,6 @@ static inline int vti6_dev_init_gen(struct net_device *dev)
 
 	t->dev = dev;
 	t->net = dev_net(dev);
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
 	netdev_hold(dev, &t->dev_tracker, GFP_KERNEL);
 	netdev_lockdep_set_classes(dev);
 	return 0;
-- 
2.43.0


