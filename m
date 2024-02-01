Return-Path: <linux-kernel+bounces-48238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB048458F2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0C31C2217C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17755B678;
	Thu,  1 Feb 2024 13:32:45 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620465336C;
	Thu,  1 Feb 2024 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794365; cv=none; b=AAqDFENJNRwgRP7ZZCtf8sd9lZbTEUZzHwRFluhGrI49wgw16vUnCC13lq6gM7P+mCrGbBoOPyg+TB4D7u5vVKg9bSpz4vE3JZ+xkr0NwAqMMH2uhQUNOSSSTB0L8s+jT02iS1hknQPjB1juLEVplK5ORhpkjF2L2r02nzgI6G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794365; c=relaxed/simple;
	bh=L9ncuNlPiuhV+Tgp8aiHz1A9CHSswt3CwCdzJSUYnwg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fauhy/asduVuvb58vmRBLff1vlW9Y3ymPmqCVh65HzTgKAgKFSssHxC32vJ5wUnCAsLHJ8+cg2pSKBJ9X7DAxmLeqMzbIOR9xLqbbNw4o5KN6iiuJ6kkCRe3KupCvGdhpvDD1+rDoS8dtKsXiF9cwP7PcGu9LJIBD1NSSj3MWZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a26fa294e56so127092466b.0;
        Thu, 01 Feb 2024 05:32:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706794361; x=1707399161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPawFIAhtjEptx34yN1DVcCgpO4g27vMV7ZWuCSE18o=;
        b=UsA98u0BkPo6EiFB1Scle1NOjTIXCjWvMoe+9lN8Q9C6WdHGrfciKI+tWOLWg9zMtO
         EmKmZ+/l9Xu06JE7fjuMawVK8gzLQ+N10zZ67OQVrE9xTjzD+xCFYM4BBUL0SjF+pEsd
         bNAOgzpl9UB60FME4XSI3AHBRuYsyaln7IoocOT3qy5IB6NIJzPpOp1E47jruMw+1Sb6
         p7QH8DIYT3kHm6xrbCAXX7njUbNmztXQxf0s169jF/OzO0T3nciSYsFKo50AbtSBlqHO
         Ik0S9osIpXK8ck9xec3kMlVz5zdqvOsnNyl13g3xZtMaV4k+Ga9K1sLXjX1+yGVPZUaH
         Pa0A==
X-Gm-Message-State: AOJu0YxPCXiE9ADlN4e7I6a7qHO4q5EyQ4nkUFwFEhg1WqFQTEiSrXiB
	xwz2Zcu2NUS99tUEw/80GNNJ2zhqWXsS2KvnbMlX7aQB9Uh+JUBy
X-Google-Smtp-Source: AGHT+IE2dqeAMP8WIUzJIlbbIjKkCCC+rcdNuODnsW0z5TlRFolwBryDbWLYHthiNGKd+lFKmkWA8Q==
X-Received: by 2002:a17:906:5053:b0:a35:32ae:e0c0 with SMTP id e19-20020a170906505300b00a3532aee0c0mr3578892ejk.3.1706794361382;
        Thu, 01 Feb 2024 05:32:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVVG+qynyiJ0xto/6fL4lOt2J9jSM0ooLDXIVE1W5u7WlW6jISxS3h/er5GCZ4hVxQh2lgMpZv+7KFUy6/DnIMFRSS+qg/Tw8Pw5gojN/cI9zssWtqsnkFS8xxRinjAsk4zcVpDdzAq3Q6FO6meBdMaV/jVLgrHcpWit4+yeGSTK4Y2hqj9TCVaaqo8Z0WBmSsFQ4aZ+/O5dLR8Qg833nBbX6WOi2vzSqH2/1kyXrlLdNDA3bMAAQFSgMswy27dH4k6etXdWRcTBnRQn0xaPzWiqFN25BP5mOyjZ3uoxrml704sPBlIQzDe5iJFmumFXak0iuPIpH3BgsWyeFISbW4=
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id f14-20020a170906494e00b00a3681468567sm1474795ejt.81.2024.02.01.05.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 05:32:41 -0800 (PST)
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
	leit@fb.com
Subject: [PATCH] blackhole_dev: Fix buil warning
Date: Thu,  1 Feb 2024 05:32:37 -0800
Message-Id: <20240201133238.3089363-1-leitao@debian.org>
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


