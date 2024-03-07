Return-Path: <linux-kernel+bounces-95920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B70E18754F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447C7284666
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B114131E4E;
	Thu,  7 Mar 2024 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/rd3jjB"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C23B130AC4;
	Thu,  7 Mar 2024 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831588; cv=none; b=gBL5PqzqidceyNF55HH+8HDbLRZyktdk4z9UScpfXfH7ygfxUgLD8rQGEn/b/q07q25ITGMgIq6zndmTBHw+2uDufbhngfuwsOTlmPlXTg2UrG4XdMSWp6hY1IQYeUdbyjMmHWoKJqhrGvfyYMBO1HpfKEBc4Ak/1Eq75A5fdig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831588; c=relaxed/simple;
	bh=PtLOwCHLlTAzbMf7251shxdmMMOElsEIhRqA7JC8pYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HRY18uRC8p+LnmQ3mV+NLWGyvzuTpnnPvmhl4DYglNZ+H7kt+D38qmLYa76VcXShScjWCrXHC9Jd3glwqkAa4HjvmBY16VOPwFM/FbrfC2di5ek646R6pnZHZTIL7/UpqHjyuwBUAQKuP5Q2BdHsfBHCdxgn9870SXQH3KJeX4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/rd3jjB; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512e39226efso1251036e87.0;
        Thu, 07 Mar 2024 09:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709831585; x=1710436385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlLAkx6BGPSMrfEX1YwLiPgRw7CCQllxnOfSxuGrg1U=;
        b=O/rd3jjBQWQuND1ct79ZMKaN5PM8j0GP/ZlEgqziBvYeu9pJx9CRXodAZm5hzBzhT3
         UgdQlgxksRk7H0kbfieRcO4jqC2IqC5UipaC/Wvzk3CciSBYorKrOPScJ3fp4EwKACvg
         /fEh3ra7kt1gn1RK5YsWs+PLiAAHxonvVJ4rfl0umuz25KixYH9IYnJJKLB2k8AhQ1gv
         dw5/rtaPtTViVVXWUv/ZWT7u0znsNsBo3en+TNttsjnR7kVbILPrPsBw/IBj1MbFuxIa
         vvGjytGYGpcPfMZH1LtDurZklD5mavN9koyWGqUBvrir3LAUO9M+ts5wFbHDrT3oOUeG
         zKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709831585; x=1710436385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlLAkx6BGPSMrfEX1YwLiPgRw7CCQllxnOfSxuGrg1U=;
        b=KI17dWqOxS7G9cBd6VMUdWgaezasI35TJo6fgeNZ42Un/aiBo/d//7aYdtWw+XuS6X
         KUFZaX2obY7dl2L1f26kRT7qDzsx7yWRZINqOxZCGb9eNcbtX4nogIok/CHZxWLnNWli
         GtqFGQ/+cTvlTbzreBx2a0l+5rGK+/dezjEBAu3az/mccXnAwZp6DObvOqNR24G5tp4A
         L//eYycGYCs4mlR59NvdXXSTi1FccFZoAuibbi2FD/yx9hCFKYWKMnaD9rZWvpmPXnTK
         OkggPsu0oiuCfhMZZj7kbzDoQWuV26Sjz5saAobh52dRONy9qZ1kdlsmeWJj3mxNbCI9
         HiYg==
X-Forwarded-Encrypted: i=1; AJvYcCXTjvwbn2+O2xH4s0CKWM6aPw9RBF6j7s1EoyyRzu8S4KaPJJNLJyALxas8s3/Il9i6kBdgGcG5t/T0wS7Fn4aTVtib9UOdAByk9j0H
X-Gm-Message-State: AOJu0Yzq+bEwoOhidOf+WO5/y5lpG9SraXonIsG8TnAVgBF5JedrFUuL
	GBadnRHOuOWabYyYKoce5WYCRp75sDeHx0pEnMd2mN8hNm0/Qn/NBXvkY2+u
X-Google-Smtp-Source: AGHT+IEqPObYa1kS6aGlTmdFk9vHzeUCUGuJxtbdfurvIv/uOBHM8l/nwaa05S4aIs3i3fgxSwFE+A==
X-Received: by 2002:ac2:4113:0:b0:513:6363:dc74 with SMTP id b19-20020ac24113000000b005136363dc74mr1925893lfi.9.1709831584362;
        Thu, 07 Mar 2024 09:13:04 -0800 (PST)
Received: from localhost ([45.130.85.5])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b004122b7a680dsm3356839wmo.21.2024.03.07.09.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 09:13:04 -0800 (PST)
From: Leone Fernando <leone4fernando@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leone Fernando <leone4fernando@gmail.com>
Subject: [PATCH net-next 3/4] net: route: always compile dst_cache
Date: Thu,  7 Mar 2024 18:12:01 +0100
Message-Id: <20240307171202.232684-4-leone4fernando@gmail.com>
In-Reply-To: <20240307171202.232684-1-leone4fernando@gmail.com>
References: <20240307171202.232684-1-leone4fernando@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

make dst_cache always compile, delete all relevant ifdefs

Signed-off-by: Leone Fernando <leone4fernando@gmail.com>
---
 drivers/net/Kconfig        | 1 -
 include/net/dst_metadata.h | 2 --
 include/net/ip_tunnels.h   | 2 --
 net/Kconfig                | 4 ----
 net/core/Makefile          | 3 +--
 net/core/dst.c             | 4 ----
 net/ipv4/Kconfig           | 1 -
 net/ipv4/ip_tunnel_core.c  | 4 ----
 net/ipv4/udp_tunnel_core.c | 4 ----
 net/ipv6/Kconfig           | 4 ----
 net/ipv6/ip6_udp_tunnel.c  | 4 ----
 net/netfilter/nft_tunnel.c | 2 --
 net/openvswitch/Kconfig    | 1 -
 net/sched/act_tunnel_key.c | 2 --
 14 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 8ca0bc223b30..1be1ec8368b6 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -78,7 +78,6 @@ config WIREGUARD
 	depends on IPV6 || !IPV6
 	depends on !KMSAN # KMSAN doesn't support the crypto configs below
 	select NET_UDP_TUNNEL
-	select DST_CACHE
 	select CRYPTO
 	select CRYPTO_LIB_CURVE25519
 	select CRYPTO_LIB_CHACHA20POLY1305
diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
index 1b7fae4c6b24..c41a857bf0ed 100644
--- a/include/net/dst_metadata.h
+++ b/include/net/dst_metadata.h
@@ -165,7 +165,6 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
 
 	memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
 	       sizeof(struct ip_tunnel_info) + md_size);
-#ifdef CONFIG_DST_CACHE
 	/* Unclone the dst cache if there is one */
 	if (new_md->u.tun_info.dst_cache.cache) {
 		int ret;
@@ -176,7 +175,6 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
 			return ERR_PTR(ret);
 		}
 	}
-#endif
 
 	skb_dst_drop(skb);
 	skb_dst_set(skb, &new_md->dst);
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 5cd64bb2104d..2fe04edc23b9 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -84,9 +84,7 @@ struct ip_tunnel_encap {
 struct ip_tunnel_info {
 	struct ip_tunnel_key	key;
 	struct ip_tunnel_encap	encap;
-#ifdef CONFIG_DST_CACHE
 	struct dst_cache	dst_cache;
-#endif
 	u8			options_len;
 	u8			mode;
 };
diff --git a/net/Kconfig b/net/Kconfig
index 3e57ccf0da27..21caffd1758d 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -438,10 +438,6 @@ config LWTUNNEL_BPF
 	  Allows to run BPF programs as a nexthop action following a route
 	  lookup for incoming and outgoing packets.
 
-config DST_CACHE
-	bool
-	default n
-
 config GRO_CELLS
 	bool
 	default n
diff --git a/net/core/Makefile b/net/core/Makefile
index 821aec06abf1..53582fef633b 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -13,7 +13,7 @@ obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
 			neighbour.o rtnetlink.o utils.o link_watch.o filter.o \
 			sock_diag.o dev_ioctl.o tso.o sock_reuseport.o \
 			fib_notifier.o xdp.o flow_offload.o gro.o \
-			netdev-genl.o netdev-genl-gen.o gso.o
+			netdev-genl.o netdev-genl-gen.o gso.o dst_cache.o
 
 obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
@@ -32,7 +32,6 @@ obj-$(CONFIG_CGROUP_NET_PRIO) += netprio_cgroup.o
 obj-$(CONFIG_CGROUP_NET_CLASSID) += netclassid_cgroup.o
 obj-$(CONFIG_LWTUNNEL) += lwtunnel.o
 obj-$(CONFIG_LWTUNNEL_BPF) += lwt_bpf.o
-obj-$(CONFIG_DST_CACHE) += dst_cache.o
 obj-$(CONFIG_HWBM) += hwbm.o
 obj-$(CONFIG_GRO_CELLS) += gro_cells.o
 obj-$(CONFIG_FAILOVER) += failover.o
diff --git a/net/core/dst.c b/net/core/dst.c
index 95f533844f17..f035c39be104 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -291,10 +291,8 @@ EXPORT_SYMBOL_GPL(metadata_dst_alloc);
 
 void metadata_dst_free(struct metadata_dst *md_dst)
 {
-#ifdef CONFIG_DST_CACHE
 	if (md_dst->type == METADATA_IP_TUNNEL)
 		dst_cache_destroy(&md_dst->u.tun_info.dst_cache);
-#endif
 	if (md_dst->type == METADATA_XFRM)
 		dst_release(md_dst->u.xfrm_info.dst_orig);
 	kfree(md_dst);
@@ -326,10 +324,8 @@ void metadata_dst_free_percpu(struct metadata_dst __percpu *md_dst)
 	for_each_possible_cpu(cpu) {
 		struct metadata_dst *one_md_dst = per_cpu_ptr(md_dst, cpu);
 
-#ifdef CONFIG_DST_CACHE
 		if (one_md_dst->type == METADATA_IP_TUNNEL)
 			dst_cache_destroy(&one_md_dst->u.tun_info.dst_cache);
-#endif
 		if (one_md_dst->type == METADATA_XFRM)
 			dst_release(one_md_dst->u.xfrm_info.dst_orig);
 	}
diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 8e94ed7c56a0..189f716b03e8 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -185,7 +185,6 @@ config NET_IPGRE_DEMUX
 
 config NET_IP_TUNNEL
 	tristate
-	select DST_CACHE
 	select GRO_CELLS
 	default n
 
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 80ccd6661aa3..f060d55dc249 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -682,13 +682,11 @@ static int ip_tun_build_state(struct net *net, struct nlattr *attr,
 		return err;
 	}
 
-#ifdef CONFIG_DST_CACHE
 	err = dst_cache_init(&tun_info->dst_cache, GFP_KERNEL);
 	if (err) {
 		lwtstate_free(new_state);
 		return err;
 	}
-#endif
 
 	if (tb[LWTUNNEL_IP_ID])
 		tun_info->key.tun_id = nla_get_be64(tb[LWTUNNEL_IP_ID]);
@@ -720,11 +718,9 @@ static int ip_tun_build_state(struct net *net, struct nlattr *attr,
 
 static void ip_tun_destroy_state(struct lwtunnel_state *lwtstate)
 {
-#ifdef CONFIG_DST_CACHE
 	struct ip_tunnel_info *tun_info = lwt_tun_info(lwtstate);
 
 	dst_cache_destroy(&tun_info->dst_cache);
-#endif
 }
 
 static int ip_tun_fill_encap_opts_geneve(struct sk_buff *skb,
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 860aff5f8599..ecc0990d8cab 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -215,13 +215,11 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 	struct rtable *rt = NULL;
 	struct flowi4 fl4;
 
-#ifdef CONFIG_DST_CACHE
 	if (dst_cache) {
 		rt = dst_cache_get_ip4(dst_cache, saddr);
 		if (rt)
 			return rt;
 	}
-#endif
 
 	memset(&fl4, 0, sizeof(fl4));
 	fl4.flowi4_mark = skb->mark;
@@ -244,10 +242,8 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 		ip_rt_put(rt);
 		return ERR_PTR(-ELOOP);
 	}
-#ifdef CONFIG_DST_CACHE
 	if (dst_cache)
 		dst_cache_set_ip4(dst_cache, &rt->dst, fl4.saddr);
-#endif
 	*saddr = fl4.saddr;
 	return rt;
 }
diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
index 08d4b7132d4c..093c768d41ab 100644
--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -124,7 +124,6 @@ config IPV6_MIP6
 config IPV6_ILA
 	tristate "IPv6: Identifier Locator Addressing (ILA)"
 	depends on NETFILTER
-	select DST_CACHE
 	select LWTUNNEL
 	help
 	  Support for IPv6 Identifier Locator Addressing (ILA).
@@ -203,7 +202,6 @@ config IPV6_NDISC_NODETYPE
 config IPV6_TUNNEL
 	tristate "IPv6: IP-in-IPv6 tunnel (RFC2473)"
 	select INET6_TUNNEL
-	select DST_CACHE
 	select GRO_CELLS
 	help
 	  Support for IPv6-in-IPv6 and IPv4-in-IPv6 tunnels described in
@@ -291,7 +289,6 @@ config IPV6_SEG6_LWTUNNEL
 	bool "IPv6: Segment Routing Header encapsulation support"
 	depends on IPV6
 	select LWTUNNEL
-	select DST_CACHE
 	select IPV6_MULTIPLE_TABLES
 	help
 	  Support for encapsulation of packets within an outer IPv6
@@ -333,7 +330,6 @@ config IPV6_IOAM6_LWTUNNEL
 	bool "IPv6: IOAM Pre-allocated Trace insertion support"
 	depends on IPV6
 	select LWTUNNEL
-	select DST_CACHE
 	help
 	  Support for the insertion of IOAM Pre-allocated Trace
 	  Header using the lightweight tunnels mechanism.
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index c99053189ea8..de92aea01cfc 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -145,13 +145,11 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 	struct dst_entry *dst = NULL;
 	struct flowi6 fl6;
 
-#ifdef CONFIG_DST_CACHE
 	if (dst_cache) {
 		dst = dst_cache_get_ip6(dst_cache, saddr);
 		if (dst)
 			return dst;
 	}
-#endif
 	memset(&fl6, 0, sizeof(fl6));
 	fl6.flowi6_mark = skb->mark;
 	fl6.flowi6_proto = IPPROTO_UDP;
@@ -173,10 +171,8 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 		dst_release(dst);
 		return ERR_PTR(-ELOOP);
 	}
-#ifdef CONFIG_DST_CACHE
 	if (dst_cache)
 		dst_cache_set_ip6(dst_cache, dst, &fl6.saddr);
-#endif
 	*saddr = fl6.saddr;
 	return dst;
 }
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index f735d79d8be5..02cbd7f3f6dc 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -508,13 +508,11 @@ static int nft_tunnel_obj_init(const struct nft_ctx *ctx,
 		return -ENOMEM;
 
 	memcpy(&md->u.tun_info, &info, sizeof(info));
-#ifdef CONFIG_DST_CACHE
 	err = dst_cache_init(&md->u.tun_info.dst_cache, GFP_KERNEL);
 	if (err < 0) {
 		metadata_dst_free(md);
 		return err;
 	}
-#endif
 	ip_tunnel_info_opts_set(&md->u.tun_info, &priv->opts.u, priv->opts.len,
 				priv->opts.flags);
 	priv->md = md;
diff --git a/net/openvswitch/Kconfig b/net/openvswitch/Kconfig
index 29a7081858cd..b7a5ab6374b8 100644
--- a/net/openvswitch/Kconfig
+++ b/net/openvswitch/Kconfig
@@ -13,7 +13,6 @@ config OPENVSWITCH
 	select LIBCRC32C
 	select MPLS
 	select NET_MPLS_GSO
-	select DST_CACHE
 	select NET_NSH
 	select NF_CONNTRACK_OVS if NF_CONNTRACK
 	select NF_NAT_OVS if NF_NAT
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index 1536f8b16f1b..1da69fa82512 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -476,11 +476,9 @@ static int tunnel_key_init(struct net *net, struct nlattr *nla,
 			goto err_out;
 		}
 
-#ifdef CONFIG_DST_CACHE
 		ret = dst_cache_init(&metadata->u.tun_info.dst_cache, GFP_KERNEL);
 		if (ret)
 			goto release_tun_meta;
-#endif
 
 		if (opts_len) {
 			ret = tunnel_key_opts_set(tb[TCA_TUNNEL_KEY_ENC_OPTS],
-- 
2.34.1


