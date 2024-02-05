Return-Path: <linux-kernel+bounces-52396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38248849787
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6718B1C23D78
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD2118645;
	Mon,  5 Feb 2024 10:14:23 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493B8182B5;
	Mon,  5 Feb 2024 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128063; cv=none; b=EoNlPBmYZv+LyvENJANCwvKgi5xQuQHQ5Xagnn/3i6zCE4+rh7xGH4xUPt7LPzkHlNKAoc5+cuGKSMwR/FK7Jk+wsSwisVrB3tC06w+ObYfsU/UckGr06Rx9uW2JywCe/trLh8x0A7E+yD7af2RV/bFINNrequDllnYNlL+Tqjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128063; c=relaxed/simple;
	bh=jRFPDAk/oRrYnOW7NdTn3npS5DuzTjtheyphHgcniJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bUXVItk0hAeq9p9xVxGnukQFiXI4D2nkm5KyDNFH5syIVjoAQ5ZcRBgq30s+bAxCcpaQmefHl7uiWYoSVRrqytnoUCiASyv4T346CwGkmnLAWTN8r3futbul2GwlqKf0HCT53TkwAfhqcxii0r3IZVdJNWe+pJZKgURCWX5cRVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5606f2107ebso986988a12.1;
        Mon, 05 Feb 2024 02:14:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707128059; x=1707732859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBJavVPmHQHYb3K98XCbdGtcHKQwgfH8S8Etz7uBoR0=;
        b=jcrIhp7zYI2UXax7TnzC6XnXQ7AkrX4LoS3u45hw2PY/mc59WRfA4bEI504a84nzti
         H+IqCkbMzO8mpydwYQg4ltomILPvm9rD98x5sEKGJGnpJm3fsWlEqIgUdPjofVvzh/Wv
         XTqOAGvjrDOCIHuDYN9/ZHr6ys+Gi/C4WGLzb9Iljz1W15JtOKgPmh6z6YZUDzHbONlh
         JgSC3ltdpXGii96s3Vkk1Oa8ZlEtoDOTaQIPhEKJvePWfopNupD2U9SZDF9TmAKaT4Bv
         m5j0sigWkQiBn433ZEWZGGWtQ7z0Shzjg3ttIwKyDANo2rHr98eDVRJOd37LxLsSDm28
         6Y0g==
X-Gm-Message-State: AOJu0Yz5a0URDtqsEPzGI0B4AENWKAerewj2ZFxcZvx3zYWqbpbvvuOk
	ZL1V+ljRc3g50vkrQRFlcp2lX0nYXwCyT4OpjVkE1RyHeJIhPsa+
X-Google-Smtp-Source: AGHT+IGeIFwBVndMxbApCrKWwkAyozvl+QT6+xbk/4j/mPgVPb6mpI4eUE73tlwq+XCazyVbs9T6dg==
X-Received: by 2002:a17:906:3c7:b0:a37:e054:4b83 with SMTP id c7-20020a17090603c700b00a37e0544b83mr791394eja.10.1707128059510;
        Mon, 05 Feb 2024 02:14:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUrywxw8F9Z2Ly+ROhLPLbv5kS5o0M273KtmCn/dWnrBD+j09yQ6Q2//2NLyOIoga75DvbNxrv/ZDmwefXFl+JUdwG4Eayr1Jdo3hlhtIibRoZfoDBWMF0OgXc0pNFdY1uWj9O95Eqnz+SHKkF900TryqK2VtDa4S+z30PxBJI+CN9fUFj+eUu3HB/VXALn2WtMToOb9ynvvnzr8gl3dHQiq9/UN8qY4pLKbrDAq3CTYPfF0nFQeax9qBrmiyS2p4F/BQ82dVKuzDl4Bi0VH4UyswY9ymTGenntN74r1RviTqOJgmIjUrH7wArssR2fMArOKN7EaO4gdZ03
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a370e130fc0sm3805961ejc.59.2024.02.05.02.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:14:19 -0800 (PST)
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
Subject: [PATCH net 05/10] net: fill in MODULE_DESCRIPTION()s for ipv6 modules
Date: Mon,  5 Feb 2024 02:13:54 -0800
Message-Id: <20240205101400.1480521-6-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240205101400.1480521-1-leitao@debian.org>
References: <20240205101400.1480521-1-leitao@debian.org>
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


