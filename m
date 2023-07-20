Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C2075B424
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjGTQ0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjGTQ0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:26:45 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3391114;
        Thu, 20 Jul 2023 09:26:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbfcc6daa9so7987235e9.3;
        Thu, 20 Jul 2023 09:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689870402; x=1690475202;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MBatkB8B/7dmkT4jPYHcJtlNDAH8uob1P4AD84IQBw=;
        b=kNKqgGmtprt4qVSwqwHfSKWodkj79lkZACHQcW+pBUqWcLuiLpZ/Lfuubuo/n0gTFr
         XY9FH1XmRsoA7/3CANPSADWBTawkBFncc+N9G4zI1HxYeNfUxY3oVyyoiS7smgFQ7vAj
         2izo2C6Is2xVjTTm2sS3XPY4ioPz7v/Y9h1GUZWfhydqsSJy6woyHwxXOqiDoE2TV7OR
         JE/AeJm32yAWABs1siajP6FOvgGZOptfMOtepkaCFuNwfe73pqY8KLBcCO3p8d6zvXaK
         78jHlijrvdXVXVCZji3kGU+TYTn5xaCP96TNg13U+gIuk06MJcPJBp2ZKssoGKLlm5yu
         Wurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689870402; x=1690475202;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MBatkB8B/7dmkT4jPYHcJtlNDAH8uob1P4AD84IQBw=;
        b=YYucT2ipe/hc1mhl5RJ1lqWSQSMRvBRluor78A5KpjHzhVKZCgAN42I3ZYaZH2QKee
         jLikX+PZpbr73rnT2YZvVD/227eGn9fy1VNinYahnsLKxl/3uDQA4dfq3PcQtpgpnuM7
         EUWIjqDy3K7/T7S7nbrq+28yTOOMMxNdweFtDbf+I1eT/0czsV5OJsiq3KGey8IAGi2c
         2TX/3Dklq66IoUciMwjQR328w4JPcZVZ9H0mv8NM2xFgmoaOH9qTVDA3zA2sGLMvbcfF
         OYA9DNS/T4XuCkRotKF6M1PJa3kdA8S5NMRpwz/GfcJjkgvksYkQyWhhY5N5jmFT6JtF
         NvLA==
X-Gm-Message-State: ABy/qLYaTMGTDhUXOwFTD3y+7LxR+/nQw6w43mVe14h+P2uMsdJ7zlkh
        D8iDBfpwlu3l+HRklMOCzY0=
X-Google-Smtp-Source: APBJJlE4NNXje+fLTPJ3D3Np2ydW4a+kn24RXNVE7EER6t80YS8KUag+iXNCYxs8aYJvK2neo9UQBw==
X-Received: by 2002:a7b:c84c:0:b0:3fc:8a:7c08 with SMTP id c12-20020a7bc84c000000b003fc008a7c08mr4873507wml.35.1689870401973;
        Thu, 20 Jul 2023 09:26:41 -0700 (PDT)
Received: from debian ([89.238.191.199])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c210900b003fbcdba1a52sm4294282wml.3.2023.07.20.09.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 09:26:41 -0700 (PDT)
Date:   Thu, 20 Jul 2023 18:26:27 +0200
From:   Richard Gobert <richardbgobert@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        dsahern@kernel.org, tom@herbertland.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gal@nvidia.com
Subject: [PATCH v2 1/1] net: gro: fix misuse of CB in udp socket lookup
Message-ID: <20230720162624.GA16428@debian>
References: <20230720161322.GA16323@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720161322.GA16323@debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a misuse of IP{6}CB(skb) in GRO, while calling to
`udp6_lib_lookup2` when handling udp tunnels. `udp6_lib_lookup2` fetch the
device from CB. The fix changes it to fetch the device from `skb->dev`.
l3mdev case requires special attention since it has a master and a slave
device.

Fixes: a6024562ffd7 ("udp: Add GRO functions to UDP socket")
Reported-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/udp.h      |  2 ++
 net/ipv4/udp.c         | 28 ++++++++++++++++++++++++++--
 net/ipv4/udp_offload.c |  7 +++++--
 net/ipv6/udp.c         | 29 +++++++++++++++++++++++++++--
 net/ipv6/udp_offload.c |  7 +++++--
 5 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index 4d13424f8f72..48af1479882f 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -299,6 +299,7 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		       sockptr_t optval, unsigned int optlen,
 		       int (*push_pending_frames)(struct sock *));
+void udp4_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif);
 struct sock *udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport,
 			     __be32 daddr, __be16 dport, int dif);
 struct sock *__udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport,
@@ -310,6 +311,7 @@ struct sock *udp6_lib_lookup(struct net *net,
 			     const struct in6_addr *saddr, __be16 sport,
 			     const struct in6_addr *daddr, __be16 dport,
 			     int dif);
+void udp6_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif);
 struct sock *__udp6_lib_lookup(struct net *net,
 			       const struct in6_addr *saddr, __be16 sport,
 			       const struct in6_addr *daddr, __be16 dport,
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 8c3ebd95f5b9..85eb9977db2c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -550,15 +550,39 @@ static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
 				 inet_sdif(skb), udptable, skb);
 }
 
+/* This function is the alternative to 'inet_iif' and 'inet_sdif'
+ * functions in case we can not rely on fields of IPCB.
+ *
+ * The caller must verify skb_valid_dst(skb) is false and skb->dev is initialized.
+ * The caller must hold the RCU read lock.
+ */
+inline void udp4_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif)
+{
+	*iif = inet_iif(skb) ?: skb->dev->ifindex;
+	*sdif = 0;
+
+#if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
+	if (netif_is_l3_slave(skb->dev)) {
+		struct net_device *master = netdev_master_upper_dev_get_rcu(skb->dev);
+
+		*sdif = *iif;
+		*iif = master ? master->ifindex : 0;
+	}
+#endif
+}
+
 struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
 				 __be16 sport, __be16 dport)
 {
 	const struct iphdr *iph = ip_hdr(skb);
 	struct net *net = dev_net(skb->dev);
+	int iif, sdif;
+
+	udp4_get_iif_sdif(skb, &iif, &sdif);
 
 	return __udp4_lib_lookup(net, iph->saddr, sport,
-				 iph->daddr, dport, inet_iif(skb),
-				 inet_sdif(skb), net->ipv4.udp_table, NULL);
+				 iph->daddr, dport, iif,
+				 sdif, net->ipv4.udp_table, NULL);
 }
 
 /* Must be called under rcu_read_lock().
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 75aa4de5b731..70d760b271db 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -603,10 +603,13 @@ static struct sock *udp4_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
 {
 	const struct iphdr *iph = skb_gro_network_header(skb);
 	struct net *net = dev_net(skb->dev);
+	int iif, sdif;
+
+	udp4_get_iif_sdif(skb, &iif, &sdif);
 
 	return __udp4_lib_lookup(net, iph->saddr, sport,
-				 iph->daddr, dport, inet_iif(skb),
-				 inet_sdif(skb), net->ipv4.udp_table, NULL);
+				 iph->daddr, dport, iif,
+				 sdif, net->ipv4.udp_table, NULL);
 }
 
 INDIRECT_CALLABLE_SCOPE
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index b7c972aa09a7..6dbcadc3bf8f 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -295,15 +295,40 @@ static struct sock *__udp6_lib_lookup_skb(struct sk_buff *skb,
 				 inet6_sdif(skb), udptable, skb);
 }
 
+/* This function is the alternative to 'inet6_iif' and 'inet6_sdif'
+ * functions in case we can not rely on fields of IP6CB.
+ *
+ * The caller must verify skb_valid_dst(skb) is false and skb->dev is initialized.
+ * The caller must hold the RCU read lock.
+ */
+inline void udp6_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif)
+{
+	/* using skb->dev->ifindex because skb_dst(skb) is not initialized */
+	*iif = skb->dev->ifindex;
+	*sdif = 0;
+
+#if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
+	if (netif_is_l3_slave(skb->dev)) {
+		struct net_device *master = netdev_master_upper_dev_get_rcu(skb->dev);
+
+		*sdif = *iif;
+		*iif = master ? master->ifindex : 0;
+	}
+#endif
+}
+
 struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
 				 __be16 sport, __be16 dport)
 {
 	const struct ipv6hdr *iph = ipv6_hdr(skb);
 	struct net *net = dev_net(skb->dev);
+	int iif, sdif;
+
+	udp6_get_iif_sdif(skb, &iif, &sdif);
 
 	return __udp6_lib_lookup(net, &iph->saddr, sport,
-				 &iph->daddr, dport, inet6_iif(skb),
-				 inet6_sdif(skb), net->ipv4.udp_table, NULL);
+				 &iph->daddr, dport, iif,
+				 sdif, net->ipv4.udp_table, NULL);
 }
 
 /* Must be called under rcu_read_lock().
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index ad3b8726873e..88191d79002e 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -119,10 +119,13 @@ static struct sock *udp6_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
 {
 	const struct ipv6hdr *iph = skb_gro_network_header(skb);
 	struct net *net = dev_net(skb->dev);
+	int iif, sdif;
+
+	udp6_get_iif_sdif(skb, &iif, &sdif);
 
 	return __udp6_lib_lookup(net, &iph->saddr, sport,
-				 &iph->daddr, dport, inet6_iif(skb),
-				 inet6_sdif(skb), net->ipv4.udp_table, NULL);
+				 &iph->daddr, dport, iif,
+				 sdif, net->ipv4.udp_table, NULL);
 }
 
 INDIRECT_CALLABLE_SCOPE
-- 
2.36.1

