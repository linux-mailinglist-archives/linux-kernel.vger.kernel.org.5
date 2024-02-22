Return-Path: <linux-kernel+bounces-77338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D58860401
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4CD289A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1EC7174C;
	Thu, 22 Feb 2024 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEO8GbkQ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAF914B81E;
	Thu, 22 Feb 2024 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635089; cv=none; b=FDLK24Emtj5WQjIJgNzuvpBHwKjQLMn4ncto9X3SRClHBaiCupCKnhOXNkLaVxa8O3Axdypc6hWyjXntgqoXIQMdzn30ezze6vA8xrRuGRCIUj8ibcvJswGXkbblw8EJLRrHC5mAbTdb8st+tctNexCI/vNtEOlH9BWaJD4ptD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635089; c=relaxed/simple;
	bh=b7+uHMUj2gcp+zIE9cIZoMRwuVWLu76/OjKqXpXLskM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=CSZjqTmPOumCKHSBCM3QW86FreZwJVc0Q7USpGjNY19j+xiO1GP1qyNMul4bzHnoTpHhYj52vIXtsnVHDnV919tqF8W6YjD8wWwO8v5rb3FaQtjYMmJ2+DScqM53jAMJYLZBxXhDx1PwUaWhAxLJAXQ0UUV39GIkgbjrK/SXgpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEO8GbkQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41241f64c6bso1433725e9.0;
        Thu, 22 Feb 2024 12:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708635086; x=1709239886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=guv65Bw2FKNAkGv/Wh3qjRvziyHipb80uH1upaj5asE=;
        b=SEO8GbkQjuSEdBpLf/tV39fpiOmeSMi5c19n32c17suUTKsxvziO4cvYptMAc2E8sT
         ZLkzDv8taGlNBoCu7uBb6+j/68ZVwihrpbet7D+h9FCM8xRC4oTZyVhXFHPqsHjS6T4q
         6ccUEi+vLkhA0I5lFEqcx6c5bfuPv0hXkohnstzQFW89bqiFFfCVaNaYh53XThXMnWbf
         t3StLNEcDF362NfJM0o+wUBKCme8jiymapMcrhIYTjvbhWE/yU9AHws1f0X7jM65C+yw
         3W0eMWP1K95oukyWpHMJyzUlFBWwDbPBoYG0aguyDwQ++fpqlBwytDmYSMC2QRe395gj
         PufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708635086; x=1709239886;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=guv65Bw2FKNAkGv/Wh3qjRvziyHipb80uH1upaj5asE=;
        b=rkEx4hdlc1qtX/oSQ5v+weq9Kr+595ZZp7hE5pLdmGZA4T5aYe2Uka+b9bPkfKb2eT
         7OCV3Z4HzNmWrizN0O7YNdHbGmVQYA4dyEx8GerUJ6lFSFT2Xck6R8jGkujjI70ebDzt
         wnr+tE2BikZBeGrcOeAQ5r32xFbAGbeJca+iwnQ+x/ASObwiAAU4hFRUVdoFpAJ8Q7Ng
         uHOUGe84ApmwoROF7HcvGOqmcKD1dW9GWs5xcovyoHjgguyamqNSPSnAmYcTPnelt7mY
         d2ofszX72FomCLwujaDGCCyIKoQVgCi4+rhCLYDpQwxlovfeeJwWGzkvYION3iMf6lKU
         EeKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7obJseBEHLIfz6h6+Rg60NtfxtaPN+9UNTDx2zwzxt3Y2pi4xmhHX43vT3GgCzmXa4QPG8Pkrd4TxTsjvVPq+CCeTjIn8DDF0hdyTL2YpSYXlsX6JDcL3Ye+mv5MApZmF8hAn
X-Gm-Message-State: AOJu0Yw6CmuIRhkBKvEvm3m1ehAaUZREQUplRq0KeJySwatqVRSFz8Ju
	PCNGuILYI0C3QnAACPxaVZhVaBU/EKiyF2nq05OiDoa0ouOUKr/n
X-Google-Smtp-Source: AGHT+IE0n6HgLNGjGpC3ZDTFWzOuU4YGgUV4uR5pCVv8QuVPQoewa8q/MLB34RVI3dgsLFURyluCEg==
X-Received: by 2002:a5d:6108:0:b0:33d:20ca:8415 with SMTP id v8-20020a5d6108000000b0033d20ca8415mr149778wrt.63.1708635085743;
        Thu, 22 Feb 2024 12:51:25 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id w17-20020adfcd11000000b0033cdbe335bcsm166783wrm.71.2024.02.22.12.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 12:51:25 -0800 (PST)
Message-ID: <a4cd1adb-74d4-4eea-9f74-0d0ac3d79e44@gmail.com>
Date: Thu, 22 Feb 2024 21:51:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next 1/2] net: vxlan: enable local address bind for vxlan
 sockets
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com, razor@blackwall.org,
 amcohen@nvidia.com, petrm@nvidia.com, jbenc@redhat.com, b.galvani@gmail.com,
 bpoirier@nvidia.com, gavinl@nvidia.com, martin.lau@kernel.org,
 daniel@iogearbox.net, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <df300a49-7811-4126-a56a-a77100c8841b@gmail.com>
In-Reply-To: <df300a49-7811-4126-a56a-a77100c8841b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This patch adds support for binding to a local address in vxlan sockets.
It achieves this by using vxlan_addr union to represent a local address
to bind to, and copying it to udp_port_cfg in vxlan_create_sock.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 16106e088c63..b5f3f946ebcd 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3479,8 +3479,9 @@ static const struct ethtool_ops vxlan_ethtool_ops = {
 	.get_link_ksettings	= vxlan_get_link_ksettings,
 };
 
-static struct socket *vxlan_create_sock(struct net *net, bool ipv6,
-					__be16 port, u32 flags, int ifindex)
+static struct socket *vxlan_create_sock(struct net *net, bool ipv6, __be16 port,
+					u32 flags, int ifindex,
+					union vxlan_addr addr)
 {
 	struct socket *sock;
 	struct udp_port_cfg udp_conf;
@@ -3493,8 +3494,15 @@ static struct socket *vxlan_create_sock(struct net *net, bool ipv6,
 		udp_conf.use_udp6_rx_checksums =
 		    !(flags & VXLAN_F_UDP_ZERO_CSUM6_RX);
 		udp_conf.ipv6_v6only = 1;
+		memcpy(&udp_conf.local_ip6.s6_addr32,
+		       &addr.sin6.sin6_addr.s6_addr32,
+		       sizeof(addr.sin6.sin6_addr.s6_addr32));
 	} else {
 		udp_conf.family = AF_INET;
+		udp_conf.local_ip.s_addr = addr.sin.sin_addr.s_addr;
+		memcpy(&udp_conf.local_ip.s_addr,
+		       &addr.sin.sin_addr.s_addr,
+		       sizeof(addr.sin.sin_addr.s_addr));
 	}
 
 	udp_conf.local_udp_port = port;
@@ -3512,7 +3520,8 @@ static struct socket *vxlan_create_sock(struct net *net, bool ipv6,
 /* Create new listen socket if needed */
 static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 					      __be16 port, u32 flags,
-					      int ifindex)
+					      int ifindex,
+					      union vxlan_addr addr)
 {
 	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 	struct vxlan_sock *vs;
@@ -3527,7 +3536,7 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 	for (h = 0; h < VNI_HASH_SIZE; ++h)
 		INIT_HLIST_HEAD(&vs->vni_list[h]);
 
-	sock = vxlan_create_sock(net, ipv6, port, flags, ifindex);
+	sock = vxlan_create_sock(net, ipv6, port, flags, ifindex, addr);
 	if (IS_ERR(sock)) {
 		kfree(vs);
 		return ERR_CAST(sock);
@@ -3591,7 +3600,7 @@ static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 	if (!vs)
 		vs = vxlan_socket_create(vxlan->net, ipv6,
 					 vxlan->cfg.dst_port, vxlan->cfg.flags,
-					 l3mdev_index);
+					 l3mdev_index, vxlan->cfg.saddr);
 	if (IS_ERR(vs))
 		return PTR_ERR(vs);
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.36.1

