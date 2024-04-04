Return-Path: <linux-kernel+bounces-131065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 827908982A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EDA1C21AC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7946CDCA;
	Thu,  4 Apr 2024 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="BTPeoF04"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF37D5EE76;
	Thu,  4 Apr 2024 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217485; cv=none; b=EK/RNrizCWs41WI4wEMFo0J8g1dmeyV4V1mUJtHNNu/ta+W+1/TGLHPNBjWUYjR6Ngn3yN23WXIy0dEjzWWrbfgrdgq3bOs5MQ/P6KdzX7AHXYSf5Q7L+MSOf41UDaKCQMUuy6TiKewRTStM4dPbgP7OfFdIzYrvbYcuXFjw9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217485; c=relaxed/simple;
	bh=jtzhrMLdZ8BM8eIGM+1HCvFVB4kJmRbapmmThq4pMyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eRoAsRyiv8Sv9c6uN/T/JWa8V8vDPecPICp4HZvCVWIrfKXwX2afX/uk51ASA3QNDNViSlWlwAfJcALQp30311o4ZwiPmVTYWPiMLKQcytgRIxogfdtYZMe++xCRS43zWLPnoXde8gjgRkAFQy66oKqoTrLx0ctOnuix9OHfPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=BTPeoF04; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 8F4C41BF132;
	Thu,  4 Apr 2024 09:58:00 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1712217480; bh=ZeTrjHj8R8/GGeNF/M+NaL7fhHhYqCIgj0CVkk8KzLg=;
	h=From:To:Cc:Subject:Date:From;
	b=BTPeoF04gCPLsFsx12CG+rAV9sdx737J25fCkK4oVXJMrnTAYLFOVoe9YGkgvUJ5a
	 ZaecnVh3gxT7Jv+5bhR21nxMu9PW665iI1as0B7z7AdpzqIpn3BGIWCXT/WXYzn14m
	 wk1rHGeajIUNtm4tSVYi6rkuskfibzSZ/uLWF9bxqkfYS/vAvpxwQ5Lvxxj/0K/IR0
	 JHqfOlGD2ANKdmjHhku5afPml/bH3lFSXtr9rP9cMZMHtAsQwz3+3mEI0y8byw+aBK
	 23epvw7DbQe6b/SvEei8yLjTFA+OmFQukCEfKwZxIJtxNSwYN6bgQ4ZnrLd2mFF+3F
	 Yg5dhg7dHhJdw==
From: Petr Tesarik <petr@tesarici.cz>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org (open list)
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-kernel@vger.kernel.org (open list),
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	Petr Tesarik <petr@tesarici.cz>
Subject: [PATCH net] u64_stats: fix u64_stats_init() for lockdep when used repeatedly in one file
Date: Thu,  4 Apr 2024 09:57:40 +0200
Message-ID: <20240404075740.30682-1-petr@tesarici.cz>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix bogus lockdep warnings if multiple u64_stats_sync variables are
initialized in the same file.

With CONFIG_LOCKDEP, seqcount_init() is a macro which declares:

	static struct lock_class_key __key;

Since u64_stats_init() is a function (albeit an inline one), all calls
within the same file end up using the same instance, effectively treating
them all as a single lock-class.

Fixes: 9464ca650008 ("net: make u64_stats_init() a function")
Closes: https://lore.kernel.org/netdev/ea1567d9-ce66-45e6-8168-ac40a47d1821@roeck-us.net/
Signed-off-by: Petr Tesarik <petr@tesarici.cz>
---
 include/linux/u64_stats_sync.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index ffe48e69b3f3..457879938fc1 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -135,10 +135,11 @@ static inline void u64_stats_inc(u64_stats_t *p)
 	p->v++;
 }
 
-static inline void u64_stats_init(struct u64_stats_sync *syncp)
-{
-	seqcount_init(&syncp->seq);
-}
+#define u64_stats_init(syncp)				\
+	do {						\
+		struct u64_stats_sync *__s = (syncp);	\
+		seqcount_init(&__s->seq);		\
+	} while (0)
 
 static inline void __u64_stats_update_begin(struct u64_stats_sync *syncp)
 {
-- 
2.44.0


