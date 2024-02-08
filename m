Return-Path: <linux-kernel+bounces-58366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C3984E552
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6751C25600
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BF17EF1E;
	Thu,  8 Feb 2024 16:43:06 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C459C86AF0;
	Thu,  8 Feb 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410586; cv=none; b=J123tzO09e7sROD64Y7R9+XUGYrJmAPGq2rD6+Xx7uAo+Zw4jbsQHokOjDoKAwX7/jOp1ulwqnoEc3s+xAr9a8h5OwVyNyjocUoJoTYlBd0AivnR5fasYLEXHVDU9o/7ygNyzco1WyRhumkGFk1Ym5ieYmL3IEc0PNjHwp/hbg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410586; c=relaxed/simple;
	bh=nSp9x3DegQl47Vx6vL4/GreOzGEFnk9mLG4ow8Ve4k4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GzoK4a4U7omjJMRc4PDQsJJshc6t7fSimowtfBCYClFos2wly24s5NbUDLnLyKeGl0WTtg6cNE1TGjBL8R6v6AWCEaK6KXwqpoQeHLqaEZXJXF+tBxzlzI97v/L9+WgCkUMXVeNYYE3EpEth/tarpKNRpLXiHJdNDp9WqLG+AAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so102063a12.1;
        Thu, 08 Feb 2024 08:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707410583; x=1708015383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5rGyvWgigjr5l3jkgZ4WCQTEiDZw0dC/oo1virAX9U=;
        b=qkacIUUPL1DXG2OlhUl/u1WaziY+uDpgho6LlZQ+oCJylEmWEfGGxjBj07GsmyiPGZ
         /tR+sZZjNgsGmobERHBWtzGxV0oVcb3q9uboIJqp3Y6N5PWrZ9o7InipTsGMCLsPnHm0
         JzV0oncRFOP7BeBY1tRls146ZfLmBu0VNBecbYU9ls7wTb86FFMoSA6sbSOqGxhP1sSE
         tYm6rFm1VufyyjA1IAL//ysCbv0IqymBuBkvqS4sjdAoU68mEXVkE/DhcOQw8B44DLZC
         2bmfWPPPhino628N2METdUIwBa09c6VtlPCkWcFDKAFpdAgu9EVUE947PntOEG7oyMxF
         Y6/A==
X-Gm-Message-State: AOJu0Yxv851GctF2/acmE6c7apt7tmWJSa//rNKgfdMqpNRez/1i/vhg
	0jJpyp+3fyyDgJpE/W6vaufyAPG2ZkK2VYdewFZuJ0IE+WkJGgcc
X-Google-Smtp-Source: AGHT+IHIfUfw1faJyIR0MZ6Iv9nGNeI9SNkwcmkIa6SWrZkNYI6eLvfbbFQOYQOMxkjmBFiFA+D0rg==
X-Received: by 2002:a17:906:31c5:b0:a38:98ee:698b with SMTP id f5-20020a17090631c500b00a3898ee698bmr3017350ejf.66.1707410583112;
        Thu, 08 Feb 2024 08:43:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+OmD+hKAFFyq0wNfea9Zy2mLyX5YDu4WRSlHffWipGFe3hVJiN0miyuEm8hSG082vs6hqIMvQy9Fhr2ODyzzL3AhhtJQlJ7tHzIkPcbMcvBoi+Ty5iyQzTMI+M0r+tdetm9aKQCnU+y2ggOnFgPzwjk1K//qcBMZHll0uoSxdP7wqtxf+Ul9amcbR+4H+yFk+fLWjWOMq6rb4DeP/Zk0YoHlZesWXixHbFUkjvKjHAHsVdy6hWsDXUdNqY8+SveSCT2d8nK9iqRkJPl7VIvEeBuc6pWAd7z/+NPjqNfk1R9BVWrU+h6P792Gc1j5zfrA5imuF6CECY4tzgkyI4IcMdaGoCjGwfkFdx9ER6YqyDZ1ShlgN8URuhwLGhgts6njL5A==
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id y26-20020a17090668da00b00a382bcd9943sm219363ejr.145.2024.02.08.08.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:43:02 -0800 (PST)
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
Subject: [PATCH net v3 5/9] net: fill in MODULE_DESCRIPTION()s for ipv6 modules
Date: Thu,  8 Feb 2024 08:42:40 -0800
Message-Id: <20240208164244.3818498-6-leitao@debian.org>
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
Add descriptions to the IPv6 modules.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
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
index a7bf0327b380..c99053189ea8 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -182,4 +182,5 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(udp_tunnel6_dst_lookup);
 
+MODULE_DESCRIPTION("IPv6 Foo over UDP tunnel driver");
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


