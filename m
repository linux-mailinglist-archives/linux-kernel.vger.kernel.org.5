Return-Path: <linux-kernel+bounces-52397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0740D84978B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D091F23C80
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F8518E27;
	Mon,  5 Feb 2024 10:14:26 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EB818B04;
	Mon,  5 Feb 2024 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128065; cv=none; b=ufmny9QsM5466S3xqeCuxMraYXjz/n2qwQJyiuw+xeW/YKLgdNxPdPiTvUWroKRUS6PoXNoLUX/D1+OyWH7HySzuxWWruB6kJd1JmBtSxo2STSfIIApgwn4WbL4wlviTERbUs9lwEUUhIXuIA/PTotcGeMujGtXwofxpZ3SM7rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128065; c=relaxed/simple;
	bh=W6KlQKg2EC6X1aI/xA/IxqkxjQwT7md+JO4Y2Zr+qCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RBbKArPBVhwWa9Dr4VQK/CpIjsU4Bf+n+b2E+dXpFJRL5fb8kLTm3WBnvDBBELFs9IfKFTra6rey1DFeUff7q9UehUp+emTDT9FaRwKmpwpQhiMwo3RGPlGUgVVeEd8K71epyiZAdLIuAUY6K8XqB7IUjxPiZSZVKSMs6O4dmfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a372a3773a5so228826166b.3;
        Mon, 05 Feb 2024 02:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707128062; x=1707732862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8l79dN7m7635sdHvq/lpX7AW4sSG46cJgSqykJ9bWN4=;
        b=pKCCzHIfS8mOpsvkAC+SDEeg7PmwG8BzwmqMs3eYGUBGK119n0qvxMtuNWzVoWoyAy
         T+deM9fWwKUkNMdvyP0u9Fnjlb9rTzGvjyRQkI1RMoTiCJjnU1boUayB+aP8jp45wqMM
         ED+xeHIp7iXVjcb37wueUk7u9w+BjlL6xWsAPnknxZUNa3OtmPp+++SKPEqeXKf2Hdt+
         00G2/exeQL/xnaKr2rDqGo2c7ve8TlloezdTysDH5TOn9GpHl/BTBO13fO4KAgSmh0Ph
         YCJAEllpjD9of2zgDdI+uBk3MZxECaoU3ykweR55yf0MD8veZoYHu7CWQpUBr1wG/kq6
         pMiw==
X-Gm-Message-State: AOJu0Yz83oUKE5qf8oAVunImyn/49odMFZefE2re+zTKFNb8Iql/M8rR
	NZVMwLcppX06CZGfgn1vP7pCcXjoLZpH91wB2DsuAcqwR5O9cB8b
X-Google-Smtp-Source: AGHT+IGRO5UzrX00ebdPyeVPuZXgLSEc4ba/B9OB9HRhdsbxi8rYXaITInAjdS97Nst0s5VMLy/vJA==
X-Received: by 2002:a17:906:328a:b0:a37:a267:e2ea with SMTP id 10-20020a170906328a00b00a37a267e2eamr1796337ejw.61.1707128062269;
        Mon, 05 Feb 2024 02:14:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUoPBfT1O5gusef+4CY1LHZC/J2S1tpzvvHbYBWzftem8V3uQ0XQISQez+W6heOgsVv0ZnPCCXl0PJ6dK6/sy5kDe/UMnJCq907gKQIZ02w17HGkRjaJ2QtlGj9F/NY2afNcyq7cLAnYNI633NHiQyf89UavT7Z62hY4KDUSbel6NLRuv71Lq3/0B96NldxP6N+eIC1GnhX64EYhNUPIWrZW6r91oxA+Z0GEIMpM/GNP56pJTm8G74alJWpUj+tYVDmjY6zbObfHh5jTCczbkbI5Zn3MRDn/bJukxtLkfcGgzTviUoYCNl9BLjaPRNCoi4oKmXyv7tumvFP
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906640d00b00a35d7b6cb63sm4115527ejm.28.2024.02.05.02.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:14:21 -0800 (PST)
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
Subject: [PATCH net 06/10] net: fill in MODULE_DESCRIPTION()s for ipv4 modules
Date: Mon,  5 Feb 2024 02:13:55 -0800
Message-Id: <20240205101400.1480521-7-leitao@debian.org>
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
Add descriptions to the IPv4 modules.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv4/ah4.c             | 1 +
 net/ipv4/esp4.c            | 1 +
 net/ipv4/ip_gre.c          | 1 +
 net/ipv4/ip_tunnel.c       | 1 +
 net/ipv4/ip_vti.c          | 1 +
 net/ipv4/ipip.c            | 1 +
 net/ipv4/tunnel4.c         | 1 +
 net/ipv4/udp_tunnel_core.c | 1 +
 net/ipv4/xfrm4_tunnel.c    | 1 +
 9 files changed, 9 insertions(+)

diff --git a/net/ipv4/ah4.c b/net/ipv4/ah4.c
index a2e6e1fdf82b..64aec3dff8ec 100644
--- a/net/ipv4/ah4.c
+++ b/net/ipv4/ah4.c
@@ -597,5 +597,6 @@ static void __exit ah4_fini(void)
 
 module_init(ah4_init);
 module_exit(ah4_fini);
+MODULE_DESCRIPTION("IPv4 AH transformation library");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_XFRM_TYPE(AF_INET, XFRM_PROTO_AH);
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 4ccfc104f13a..4dd9e5040672 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -1247,5 +1247,6 @@ static void __exit esp4_fini(void)
 
 module_init(esp4_init);
 module_exit(esp4_fini);
+MODULE_DESCRIPTION("IPv4 ESP transformation library");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_XFRM_TYPE(AF_INET, XFRM_PROTO_ESP);
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 5169c3c72cff..6b9cf5a24c19 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1793,6 +1793,7 @@ static void __exit ipgre_fini(void)
 
 module_init(ipgre_init);
 module_exit(ipgre_fini);
+MODULE_DESCRIPTION("IPv4 GRE tunnels over IP library");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_RTNL_LINK("gre");
 MODULE_ALIAS_RTNL_LINK("gretap");
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index beeae624c412..a4513ffb66cb 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1298,4 +1298,5 @@ void ip_tunnel_setup(struct net_device *dev, unsigned int net_id)
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_setup);
 
+MODULE_DESCRIPTION("IPv4 tunnel implementation library");
 MODULE_LICENSE("GPL");
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 9ab9b3ebe0cd..d1d6bb28ed6e 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -721,6 +721,7 @@ static void __exit vti_fini(void)
 
 module_init(vti_init);
 module_exit(vti_fini);
+MODULE_DESCRIPTION("Virtual (secure) IP tunneling library");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_RTNL_LINK("vti");
 MODULE_ALIAS_NETDEV("ip_vti0");
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 27b8f83c6ea2..03afa3871efc 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -658,6 +658,7 @@ static void __exit ipip_fini(void)
 
 module_init(ipip_init);
 module_exit(ipip_fini);
+MODULE_DESCRIPTION("IP/IP protocol decoder library");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_RTNL_LINK("ipip");
 MODULE_ALIAS_NETDEV("tunl0");
diff --git a/net/ipv4/tunnel4.c b/net/ipv4/tunnel4.c
index 5048c47c79b2..4c1f836aae38 100644
--- a/net/ipv4/tunnel4.c
+++ b/net/ipv4/tunnel4.c
@@ -294,4 +294,5 @@ static void __exit tunnel4_fini(void)
 
 module_init(tunnel4_init);
 module_exit(tunnel4_fini);
+MODULE_DESCRIPTION("IPv4 XFRM tunnel library");
 MODULE_LICENSE("GPL");
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index a87defb2b167..b0a073ed590a 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -253,4 +253,5 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_dst_lookup);
 
+MODULE_DESCRIPTION("IPv4 UDP tunnel driver");
 MODULE_LICENSE("GPL");
diff --git a/net/ipv4/xfrm4_tunnel.c b/net/ipv4/xfrm4_tunnel.c
index 8489fa106583..8cb266af1393 100644
--- a/net/ipv4/xfrm4_tunnel.c
+++ b/net/ipv4/xfrm4_tunnel.c
@@ -114,5 +114,6 @@ static void __exit ipip_fini(void)
 
 module_init(ipip_init);
 module_exit(ipip_fini);
+MODULE_DESCRIPTION("IPv4 XFRM tunnel driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_XFRM_TYPE(AF_INET, XFRM_PROTO_IPIP);
-- 
2.39.3


