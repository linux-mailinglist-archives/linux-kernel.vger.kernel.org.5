Return-Path: <linux-kernel+bounces-50000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D988472D4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 984D1B20F08
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A4C145B0F;
	Fri,  2 Feb 2024 15:13:43 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E44477654;
	Fri,  2 Feb 2024 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886823; cv=none; b=B8Lw4ByN5lgNymubxU82nL8WvxY55fLNeEY0UAGYkmoIbbqAQYkAa1nFh3PkUceqiItei+bOPXkTtcZ3mpamjaNY2L+mH/iEycjDW+fitOacQlKGOXY8NJNDiSfK66PKYAVqSkN3Qe7A8rnr/B8ojpsvE3hYjNpV8CoThAMHXRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886823; c=relaxed/simple;
	bh=6kdyWk3zE7pklDpacOf7W4hSCKaBNcyUHwuQesYEe6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ePmLS4McgTJodiMR+7TA8MweVRGi1FgaLu9UVmQJgg/ihsZcU4i7UYAYBXj3LdYP774ZgOiygulQR7otqE67UcGiZ5PTzt7snYcOaqUqUMWqRhiJf+F7zN/XyXFqn+CPleF9DMShvDbX6Lsj9+gmPgKe6CimVemWk7a5bp8/Hxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3510d79ae9so290618166b.0;
        Fri, 02 Feb 2024 07:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706886819; x=1707491619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6+toLXFWmacB/oERly47/fdYHBg/T4DXmrWMTNM2KI=;
        b=iOnD9PCXqmZZ1kS/5pAjT33u9tgaiQ8kvXv1qRO/fNqqiQlI5gkCjFO78+iQx7uxcv
         DiTwNem2xq3f7nyoXWldKVRcjsiIUgXf3TevRKQgnJeg8YOxL5uoHXXR4rvHucgmNbYQ
         SyjAKr/gVo+tjPO3yFXgt5LU1vxC6m458W50kZ/Qr6JGOmy7vHNssU+jHaP3BgDN80q3
         AY2zPI3/G26DZnSDTn+v9EhCxo/uARP4sOLd3joCX975S1n8ylVyMUnFohrakUYZbc4V
         wixWIvhtS2G9XHK4i8wj3PgIHHHEb91k08dKVjsG6An8wzJJY80YkkybnfmrtnwEOWrZ
         i4xg==
X-Gm-Message-State: AOJu0YxeBNu8OaGyyl7qk2tF9/wqKOTUTPu8vQQMgViwGdkdx5t/Vhm1
	thS+rxPCjRUqudfIv3HvLCZTXHILK8E2b2T4hA1yn8Ti4RaNc2es
X-Google-Smtp-Source: AGHT+IHfXgYxdzDn3N39tlXGGtXzhYMxV58iocjRYE+xUHH9m2qvjP5qvPdNUQevXLJ9NH7DWvE07w==
X-Received: by 2002:a17:906:f9d6:b0:a36:47d8:f929 with SMTP id lj22-20020a170906f9d600b00a3647d8f929mr5607185ejb.65.1706886819388;
        Fri, 02 Feb 2024 07:13:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWCjBGCTB/A2fg8wOQZElwKINdp+HCfzL+kK8/iCUWXYQcl0fn2oy30DMnG2C4irNBKwpvyBYdO/LSft4vxadFR8rSYPuvZYOEuylNpRd2bzgVJmOxPctYkYhxrsR0L64n6d7Js10mPdH6JHP818UfiJw8KugY8sTfkqi6S3lR6+B6x1OBLTznLmXY2a4XrnaHlbUicjTWA04OIKGFeVTtGTRYeEa4TsW282yxrvCAiZrv2xXJXyfOlxFgIAP7WljtWe0kmEN0vDZfOvVCd4UBv9T6R+mh86BGvVZ30vUQheap2pm3Q6X987tzUHvbDVooCuBLSyrJklp1ok+cP4uh95Ic/
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906180c00b00a356c0fdd2csm962486eje.26.2024.02.02.07.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:13:39 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Mahesh Bandewar <maheshb@google.com>
Cc: weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next] net: blackhole_dev: fix build warning for ethh set but not used
Date: Fri,  2 Feb 2024 07:13:29 -0800
Message-Id: <20240202151329.878029-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lib/test_blackhole_dev.c sets a variable that is never read, causing
this following building warning:

	lib/test_blackhole_dev.c:32:17: warning: variable 'ethh' set but not used [-Wunused-but-set-variable]

Remove the variable struct ethhdr *ethh, which is unused.

Fixes: 509e56b37cc3 ("blackhole_dev: add a selftest")
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 lib/test_blackhole_dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/test_blackhole_dev.c b/lib/test_blackhole_dev.c
index 4c40580a99a3..f247089d63c0 100644
--- a/lib/test_blackhole_dev.c
+++ b/lib/test_blackhole_dev.c
@@ -29,7 +29,6 @@ static int __init test_blackholedev_init(void)
 {
 	struct ipv6hdr *ip6h;
 	struct sk_buff *skb;
-	struct ethhdr *ethh;
 	struct udphdr *uh;
 	int data_len;
 	int ret;
@@ -61,7 +60,7 @@ static int __init test_blackholedev_init(void)
 	ip6h->saddr = in6addr_loopback;
 	ip6h->daddr = in6addr_loopback;
 	/* Ether */
-	ethh = (struct ethhdr *)skb_push(skb, sizeof(struct ethhdr));
+	skb_push(skb, sizeof(struct ethhdr));
 	skb_set_mac_header(skb, 0);
 
 	skb->protocol = htons(ETH_P_IPV6);
-- 
2.39.3


