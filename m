Return-Path: <linux-kernel+bounces-122049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF7C88F132
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B3A29E9C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D1C153BDC;
	Wed, 27 Mar 2024 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GrhrOBZR"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B528153821
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575932; cv=none; b=CLboUB1IFzigfUN7Md6FyjHFcFF2QOYxYCSHJf/rvuVwpf8VR/ztoDriB/NzpI6T7j2Okzf1feMHmYtNQKPUCRgwp2l67FQQk65bz+rBJTW4M8Sf8e0rOk4Np2DUxp8K5LJFE16Y0wZqcsd5SxgjLg1qhqdHMUIJt8rKhJWBzww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575932; c=relaxed/simple;
	bh=Rak+tbVGAvFieKkSB/eo4ljeZ0A/D+7QGjSJN/aq218=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Km0/W46bD2JdeFY3tqp6kMtVkR+ArP6p/SA3oDA2Fw8Oz30k4DdGggmww3ctPZyc6xac5h53YjLcCgsKrQt7q1B4ti2O3Rp0ga/Wcij2UkifH2ZRlZeUD2yDfdH/HRL3uNlhiCWM0QIWwtlBxStmrtLhRCmWfYZoolexyPzb0Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GrhrOBZR; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc4563611cso425873276.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711575929; x=1712180729; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldINoU5VYJkv9i5GCH5hBaOnA51dgNGBQpx4IgBlUR8=;
        b=GrhrOBZRdAzZjM2pRpFpgQNYPUUO/NpseZ3Yu/cTyKuzS+mk327o61FrScxQ4FgS0o
         RsqqkNr7aaYDslM5vtOCc3LUbGUyUIuVayNS+cqU3qUJtKqkvYPU4WPxcrzN2U5jAsXF
         PtaUKjkI4xS6vR+z8UUI2GBDAAWtC6wu4Q3bir6E+h1YRs2kQEA0dj0paHMAR+1T21NK
         ZtB92L6t+xOT7xdcZgHpcVY15U37y2556KjuF3xG6ng9sdXlL6/Q84uxJwUxggTHmXdD
         b9IwhxHJIApPdtKJCBF8jHuEqak9NZVnBHRJQqbGVXSvksyxiKye8qR8f4+ckdfKZRJg
         TDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575929; x=1712180729;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldINoU5VYJkv9i5GCH5hBaOnA51dgNGBQpx4IgBlUR8=;
        b=wtsvWN6UzvlPsh/eHDiydvvr+88qeUDGCorTxx/vOqcgosestzZu0b+J6PGpGcjpm+
         9tMsaW4e5Oc5OJc0wcrQOgD5VMZ4xvPJKXgLLPjNe4w1YLaUlGo9zGyG6iiMIRyVbylx
         /1wPJzHvsGXvYyZ/6r5YruSJrtEDfGFG+U/fMwO6yP2ws1a0+Nj3v8KiLlWimB3f8hHU
         J6+Y641VNhHxp5Bq886ghFUNzSJMkfGj9MQ6UUFboXkCAVSGjD7rXspF52iUf5Y2Fkdx
         zoJseI0Tu/d+iH7V9+Qg/ib+tH50uD1eAV8TtQ39bX49spPu9kYlO2nAghz8DBkrokzO
         X7lA==
X-Forwarded-Encrypted: i=1; AJvYcCX6flqAjnSzGeP8phLaBpwLFyH1LX/D5Yvalkw9MitXB1F/3YrN6fV4JlfXllOlxw+Sm77NA5ubjS9rZR6vO4OusPJRjQkYbtWW1tL3
X-Gm-Message-State: AOJu0YyqHHUHUREhF5BAfJgCzXVbbIM6L6gOHepKR7jdKysxPz+1s7fe
	tPoL4QVxH0DJnGhZgTcBylxpPTXm45bkJjKyjOCwa5wQYgECumljpOjpReltCGSbw0mQP0TDRbH
	UYn8JZWt2JSS/paTcPuQrpw==
X-Google-Smtp-Source: AGHT+IEKtADRvlkxc7YGEqMlczMA9y2zeZF2AgXSBclUgkSzZX00m5c+R1YQNQRHKujGk4eQyKgrO2GZQNQ7f1pkaQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b757:6e7b:2156:cabc])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:110c:b0:dcc:f01f:65e1 with
 SMTP id o12-20020a056902110c00b00dccf01f65e1mr341668ybu.8.1711575929627; Wed,
 27 Mar 2024 14:45:29 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:45:19 -0700
In-Reply-To: <20240327214523.2182174-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327214523.2182174-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327214523.2182174-2-almasrymina@google.com>
Subject: [PATCH net-next v2 1/3] net: make napi_frag_unref reuse skb_page_unref
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mirko Lindner <mlindner@marvell.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

The implementations of these 2 functions are almost identical. Remove
the implementation of napi_frag_unref, and make it a call into
skb_page_unref so we don't duplicate the implementation.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/linux/skbuff.h | 12 +++---------
 net/ipv4/esp4.c        |  2 +-
 net/ipv6/esp6.c        |  2 +-
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b945af8a6208..bafa5c9ff59a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3524,10 +3524,10 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 bool napi_pp_put_page(struct page *page, bool napi_safe);
 
 static inline void
-skb_page_unref(const struct sk_buff *skb, struct page *page, bool napi_safe)
+skb_page_unref(struct page *page, bool recycle, bool napi_safe)
 {
 #ifdef CONFIG_PAGE_POOL
-	if (skb->pp_recycle && napi_pp_put_page(page, napi_safe))
+	if (recycle && napi_pp_put_page(page, napi_safe))
 		return;
 #endif
 	put_page(page);
@@ -3536,13 +3536,7 @@ skb_page_unref(const struct sk_buff *skb, struct page *page, bool napi_safe)
 static inline void
 napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
 {
-	struct page *page = skb_frag_page(frag);
-
-#ifdef CONFIG_PAGE_POOL
-	if (recycle && napi_pp_put_page(page, napi_safe))
-		return;
-#endif
-	put_page(page);
+	skb_page_unref(skb_frag_page(frag), recycle, napi_safe);
 }
 
 /**
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index d33d12421814..3d2c252c5570 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -114,7 +114,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			skb_page_unref(skb, sg_page(sg), false);
+			skb_page_unref(sg_page(sg), skb->pp_recycle, false);
 }
 
 #ifdef CONFIG_INET_ESPINTCP
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 7371886d4f9f..4fe4f97f5420 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -131,7 +131,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			skb_page_unref(skb, sg_page(sg), false);
+			skb_page_unref(sg_page(sg), skb->pp_recycle, false);
 }
 
 #ifdef CONFIG_INET6_ESPINTCP
-- 
2.44.0.396.g6e790dbe36-goog


