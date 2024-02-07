Return-Path: <linux-kernel+bounces-56303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5069C84C87D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDD71F221AE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEC12E854;
	Wed,  7 Feb 2024 10:19:52 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F7E2E858;
	Wed,  7 Feb 2024 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301192; cv=none; b=DOzaexKgUJ1mGdpwOFnyCN1ohD3v24mVW1Z0UVGWGVJDdMDNr5iD9q46Hss4oVW7cI+IVLKl9s6rplvgP3q+3LtYlKl3YEQK6QOe+/zF9ri4lUQschNTvB9PWVtkTAa5mCFKHqeD0pYE2650RgVfaAaf4mpyi6bVwdshqyMQ6Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301192; c=relaxed/simple;
	bh=jRFPDAk/oRrYnOW7NdTn3npS5DuzTjtheyphHgcniJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q98hsgDaoXavxwLVn8ixpi9qVEz2cA0REC5xklI/F2IXvW3sHVJIbBpVc+N7zftQfWHoTocvsUT3x/q4mCMgXv9FrXjwqx/4RGNnatkh5JqxrzvEx/Yuw7xlCl5enNrgPHYt5U7Wq6y0e/IeDVrVwWURE/9SgJIz/UfDRFAUEKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-511490772f6so453265e87.2;
        Wed, 07 Feb 2024 02:19:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707301189; x=1707905989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBJavVPmHQHYb3K98XCbdGtcHKQwgfH8S8Etz7uBoR0=;
        b=CrLjt9v6ctOjqQ1VykyvxZ6XcNpRFuWYGeO7uL+5K2qMS/TGMr7QxIUwfVKqEmoigX
         lJsE2gptX++TMAPS4OZQoEAJwXL/bwTLn+qnx9q2oGzwNBDC4jU6F0MNMUL/zjODtfsm
         TZDfEMCzOdC/82cZ4b6nbZ03PE3Xyl7rKfIdWZ0G++X2qU35Bx0pdw1jY8DVXhWqqeO5
         VNiF6zgss4BLx0TiigUt3gIRFZNe6tE6ov4BpLkbmxB0YkdjOxelIGYxFOc0IOYZC+d0
         Bx+lk5iTU2ku7ZValNlNeJnN+ZtT5x4L/J/Yp+sRrpvBp162RdRCbRRIyTL/8AfKqkVy
         kkFA==
X-Gm-Message-State: AOJu0YxpYMx2+nK2serVEzRRRvUB4IVVLEO+E1zMKQdPkNxb9pfmBYEg
	rAUtJEqoSwPrzRKVytgsdKLu0By6MFPTa5Si7X0e0jNcl9BjZj7k
X-Google-Smtp-Source: AGHT+IFqYOMm+mGtQUAq22Mio6DGmbjXzNPkZl4o72OdZjdszCiaj+NtpfkMveu1CP+i27wyqApMgw==
X-Received: by 2002:ac2:4c30:0:b0:510:569:4f4e with SMTP id u16-20020ac24c30000000b0051005694f4emr3146324lfq.63.1707301188684;
        Wed, 07 Feb 2024 02:19:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJoEJ7SCM65h4sWgux80zxDAm/aw0gefhCqELO3Ys7R+ukXRUGeLvD+flYpHGjbmj4G0vkk1NTqLFFwFuPLzYXNX+xn/FHoK5KFjqS4qfPjabLxCrpSce/BuuIhI5LkfeW937ubfdQXUbduKVOZY0v9UXhj+IGb0OlMPAiicLTnSP8ng6WoJnuJCpJ71SaKb25YQfOKSuSC5hv+9eqHqs3QHYJJUv0a0/bP9mEEQvC02gIpl7h5x8PX0H2dxd0gMrkjubxpcUieq6kNvbF7rb4cFgrrvMXnSdtVbSto//FQ3DolnF8G8P4NaVIGUyRI5b+oERC1CtxZSAP
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id f5-20020a170906084500b00a372132718esm588883ejd.90.2024.02.07.02.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 02:19:48 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch
Subject: [PATCH net v2 5/9] net: fill in MODULE_DESCRIPTION()s for ipv6 modules
Date: Wed,  7 Feb 2024 02:19:24 -0800
Message-Id: <20240207101929.484681-6-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240207101929.484681-1-leitao@debian.org>
References: <20240207101929.484681-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the IPv6 modules.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/ah6.c            | 1 +
 net/ipv6/esp6.c           | 1 +
 net/ipv6/ip6_udp_tunnel.c | 1 +
 net/ipv6/mip6.c           | 1 +
 net/ipv6/sit.c            | 1 +
 net/ipv6/tunnel6.c        | 1 +
 net/ipv6/xfrm6_tunnel.c   | 1 +
 7 files changed, 7 insertions(+)

diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index 2016e90e6e1d..eb474f0987ae 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -800,5 +800,6 @@ static void __exit ah6_fini(void)
 module_init(ah6_init);
 module_exit(ah6_fini);
 
+MODULE_DESCRIPTION("IPv6 AH transformation helpers");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_XFRM_TYPE(AF_INET6, XFRM_PROTO_AH);
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 2cc1a45742d8..6e6efe026cdc 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -1301,5 +1301,6 @@ static void __exit esp6_fini(void)
 module_init(esp6_init);
 module_exit(esp6_fini);
 
+MODULE_DESCRIPTION("IPv6 ESP transformation helpers");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_XFRM_TYPE(AF_INET6, XFRM_PROTO_ESP);
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index a7bf0327b380..8820bf5b101a 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -182,4 +182,5 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(udp_tunnel6_dst_lookup);
 
+MODULE_DESCRIPTION("IPv6 UDP tunnel driver");
 MODULE_LICENSE("GPL");
diff --git a/net/ipv6/mip6.c b/net/ipv6/mip6.c
index 83d2a8be263f..6a16a5bd0d91 100644
--- a/net/ipv6/mip6.c
+++ b/net/ipv6/mip6.c
@@ -405,6 +405,7 @@ static void __exit mip6_fini(void)
 module_init(mip6_init);
 module_exit(mip6_fini);
 
+MODULE_DESCRIPTION("IPv6 Mobility driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_XFRM_TYPE(AF_INET6, XFRM_PROTO_DSTOPTS);
 MODULE_ALIAS_XFRM_TYPE(AF_INET6, XFRM_PROTO_ROUTING);
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index cc24cefdb85c..5e9f625b76e3 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1956,6 +1956,7 @@ static int __init sit_init(void)
 
 module_init(sit_init);
 module_exit(sit_cleanup);
+MODULE_DESCRIPTION("IPv6-in-IPv4 tunnel SIT driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_RTNL_LINK("sit");
 MODULE_ALIAS_NETDEV("sit0");
diff --git a/net/ipv6/tunnel6.c b/net/ipv6/tunnel6.c
index 00e8d8b1c9a7..dc4ea9b11794 100644
--- a/net/ipv6/tunnel6.c
+++ b/net/ipv6/tunnel6.c
@@ -302,4 +302,5 @@ static void __exit tunnel6_fini(void)
 
 module_init(tunnel6_init);
 module_exit(tunnel6_fini);
+MODULE_DESCRIPTION("IP-in-IPv6 tunnel driver");
 MODULE_LICENSE("GPL");
diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
index 1323f2f6928e..f6cb94f82cc3 100644
--- a/net/ipv6/xfrm6_tunnel.c
+++ b/net/ipv6/xfrm6_tunnel.c
@@ -401,5 +401,6 @@ static void __exit xfrm6_tunnel_fini(void)
 
 module_init(xfrm6_tunnel_init);
 module_exit(xfrm6_tunnel_fini);
+MODULE_DESCRIPTION("IPv6 XFRM tunnel driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_XFRM_TYPE(AF_INET6, XFRM_PROTO_IPV6);
-- 
2.39.3


