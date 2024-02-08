Return-Path: <linux-kernel+bounces-58367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 284F584E554
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75681F2173A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFCF127B6A;
	Thu,  8 Feb 2024 16:43:09 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817F71272CE;
	Thu,  8 Feb 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410589; cv=none; b=R5Skf1Y+z2lWPOqqLqJbMkmUAGCyBJgPuyll5QEe/SLjWoqTlsM8SlfU4Hxy14r9NQPOizcHelpp7J2xH9NUq3m0JS1v/Hv/UEN2FGMnpCuRKhJjKRiIx8oY9oucLkoyqxUSNCLQdZA3QVHNjLBZrywATQoKDPgMk3Nu0P2n6sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410589; c=relaxed/simple;
	bh=AU+Ff17VdELqLSB1NXtX4pi1y8sm5S0ea2gID7NuWCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cXefcRyaJ3Ltg4PtTk4I7DqdjCgUlnqBl8bF4MxxSzceUfEl9Y31sUMyc+eUJKywinaE/XxLsWqgoX5yqYTRs09MmJHArjYVYoxyMWNN8WFKuKI9qhLwqQhkYFMAMSWeI5OWvPlup7Hw8p+hqRCV6lEiqn7kWfGoTZGHiNh8axU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5600d950442so86947a12.1;
        Thu, 08 Feb 2024 08:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707410586; x=1708015386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jIvNhRVy8liHsgbLYNbyFAfpdbZvFGUm4/B6XI426g=;
        b=tM0VB+LReGSfJkyDPMB81j43mfb3wfHjE8KI4b65M6KdKndwyOlLK+TxwKrSFWLH25
         ylEH1IXU4187DONfOxoQqLNb2VrD78/LCELXbEVn5HPcGYyumXCNZFmf0t39bT9NjyLL
         5sntEeSiiXSXzD0HEI8GilgSJWIHf1pxZcpqsI8IgHjauzvg+SwZdojrySZ2TYWEh081
         DZ/XYeDt+XSu+DPwaQ5tD94mmbdChPNBeL8Iy+NqiVF5yHS0/KXMVGeyXOoo9NNKpz8Q
         n5C2R6A8hDTHeungZeerHAhzWKlirUGVvtwONHRU+/yuI1kJDEXoHkgWDi44Cwy+7DpP
         XIVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKfFd58n24jJHyerYJKgUkHT4Z5Aheg5b8HD9W1HuVQYMPh+qrOfT7MGXtTB8Adxl1QkgLRM8h6jexhVgOeZR/fj8OR4CrqHwPy4w+
X-Gm-Message-State: AOJu0Yxq7PJ5dE0nEqBVim+Avwkg7xdwLG3mmCcPakZU2Ybm2LZH0xgl
	fho843owgOpugpKrr5yP83V6oAWXsj6fbFpVnvVlutpRbZT+x+mT
X-Google-Smtp-Source: AGHT+IElA6dql78zinAem07qXq5zxdNkEW9QCA78lnc+FfG46EkxkDf+xF3ZDRUvG/oXS0AXEx18Qg==
X-Received: by 2002:a05:6402:69a:b0:560:1c3:e23d with SMTP id f26-20020a056402069a00b0056001c3e23dmr6850354edy.16.1707410585829;
        Thu, 08 Feb 2024 08:43:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+F0VJRyFFB+VKxLpfHv8jGO4HY0S60SLwJzPh4brlECbgfm6+mzZ1oEvhf07tWQXvbM5zmK9VPBWHn4df816bfXlOg1MSgqctheU9UgrplCRxZBB/c+k/nP8GLVeV6Hjq2VRe8Efpc4+lpo+B9QtywljlzsitSiFPmcev/VlVZa3tcrIbVOSNScedHoLZUIFQfKOcO7qpAFh9PXgeQ0wBYvSihp2ZDitUmKeaIAM3JoHlkE6qnJpeFJPN/U9epJQ260142cNavdT79jIVf3LuDP4KisrDKoskEOak+8P8yBW8IMmkQUlE3OulPKk41Tg9tG23yMdlmQAQDDL9quAmrhCJaSkH2VjdjIr7f//j3UywjrM53wzAb7EG3JSKHCLssQ==
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id u4-20020a50a404000000b005603dea632esm1031750edb.88.2024.02.08.08.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:43:05 -0800 (PST)
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
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	jhs@mojatatu.com
Subject: [PATCH net v3 6/9] net: fill in MODULE_DESCRIPTION()s for ipv4 modules
Date: Thu,  8 Feb 2024 08:42:41 -0800
Message-Id: <20240208164244.3818498-7-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240208164244.3818498-1-leitao@debian.org>
References: <20240208164244.3818498-1-leitao@debian.org>
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
Reviewed-by: Simon Horman <horms@kernel.org>
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
index a87defb2b167..860aff5f8599 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -253,4 +253,5 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_dst_lookup);
 
+MODULE_DESCRIPTION("IPv4 Foo over UDP tunnel driver");
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


