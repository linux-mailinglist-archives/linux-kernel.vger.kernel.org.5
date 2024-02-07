Return-Path: <linux-kernel+bounces-56304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F58584C87E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182C12874C9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C261433CD6;
	Wed,  7 Feb 2024 10:19:55 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D84C3309E;
	Wed,  7 Feb 2024 10:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301195; cv=none; b=CDu00j6c3fxyE2JQiLiHOM8mzLehRBvXVU46Pj2tpAKQdNWQN6aHbQ/g/1yX6oc4NwviX6qF4HJXSGKOm6Tpo846uwnzICQXukRdM1VLQyataYO6QkQbQCvwkOWCXhLRzJMmlNVCRnUqWUWFduWdnmKHVPWtSzkNprtCtcvxLis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301195; c=relaxed/simple;
	bh=W6KlQKg2EC6X1aI/xA/IxqkxjQwT7md+JO4Y2Zr+qCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=feQ4WLpbYRQJSVBGHcYCFXXhn8/p5bok/vVJzKAC5/+bXKUw14n2XTCTjB1MBepbWsw7qt5SroyQ7RkdyBXlsDFOqWASOkrufTjjyZQQXtS+n7Y+sTikXb93k4ntTDZgrH2A+QRLOiEQGt0H0Qjvk8MvVtrlDqnn4vKSHCfi3dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5600c43caddso461975a12.2;
        Wed, 07 Feb 2024 02:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707301191; x=1707905991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8l79dN7m7635sdHvq/lpX7AW4sSG46cJgSqykJ9bWN4=;
        b=mYa2cxSZ83KppifFJkEQJV8hdoznCKPh7GwlFK3XccvVC0Cug41uNkhWx1im6cAiOW
         PUU7D55nztqEG3CYI8vAz40D0DyeLDRajTNFWIB3yyBLQAXGYN1uXVsgVXAp0sT/l8L4
         RI4xAIDepSHpa+7EDZHeyNNs8u8q5hiFq037JRkX1JXX0bzdedbrOnGhho9PuW0jpHC5
         YviZGLQqihff6tjiz1YhYZmCaMV1iGah2/xcJvY56+La/dPeZBHeV526AeLxgFMyyffm
         WNBEI/ww19BXWAhlgEBiCt3pt/csrApfeAY8E4fjHhhyWlWbPcuCa47PNecVBn4/3PDC
         Vw5Q==
X-Gm-Message-State: AOJu0YxTB6j1U/pi1PS1/cYiO72a0i7hd8on4GG4+Q7IEt5FQpIAksqD
	ZH6i+bPz2QfptpXNPnYe7xRvPKYL1rp5tNIDREsVyMB2CZY8P4N2
X-Google-Smtp-Source: AGHT+IFhj9C6cant8bCTFy6JUwZAmRI+Uh31DMmc3mojWjfdU8o2Qa47gTjnX4l777dSA+CqDJzbJg==
X-Received: by 2002:aa7:c991:0:b0:560:535:864c with SMTP id c17-20020aa7c991000000b005600535864cmr3899489edt.12.1707301191566;
        Wed, 07 Feb 2024 02:19:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSrp6rJdLiv3JgG5Pnj4NzDQBkYNJdg+ZKwDsgLRBxXShlCwtfX5i6ksQA2dKJVQ0Le1cUjtOts5koTRqJGDaqKSF6fHTmaroWS6wAvo4YTq0O9JMw3BmO6JTrMMvuP5eoJNx2el4DGriY6/rgZsqWvDXPy0qX9WRilWJOle1nkGMYldbWvMQE+rMuaecJWZkw/bwIJ/pmkLEVbrb3JpEnG2ds7sUmtXLaAu2GqJh7+CowrWyNVzr4a3KayVRH9ZLbaVeIzaHFdF4iNwZP+NO0l4lr89Ja8xI6kYRHCFOGPv7Uy0gUwB0qr2hCOaBj54IaJFr6L2YEIEU+
Received: from localhost (fwdproxy-lla-112.fbsv.net. [2a03:2880:30ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id y10-20020a056402134a00b0056020849adfsm507849edw.26.2024.02.07.02.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 02:19:51 -0800 (PST)
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
Subject: [PATCH net v2 6/9] net: fill in MODULE_DESCRIPTION()s for ipv4 modules
Date: Wed,  7 Feb 2024 02:19:25 -0800
Message-Id: <20240207101929.484681-7-leitao@debian.org>
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


