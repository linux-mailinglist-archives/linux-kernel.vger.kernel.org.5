Return-Path: <linux-kernel+bounces-87143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA8586D023
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46FF928468E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25BA6CC01;
	Thu, 29 Feb 2024 17:04:57 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D17160636;
	Thu, 29 Feb 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226297; cv=none; b=pBPNk/BA1L58cOusmqkHAzLWQ+K5KoRqsHfJXuOoadoZCLbGiaWPEUE0UA9zmm03/xEvpAjvp12LbroNKuygUAB3nAC/Vv4/gxuyDbKKJZFZx2HGFWzkJgcWBLhet/Mp2ZhqmWQJzCB00aRQLlFFzC8WVwtcouFJh9mGbThcwns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226297; c=relaxed/simple;
	bh=tTf5DGA4/EdGbxqRxWUdMDKOzj/3epteLSgwhMqPiA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POAuBOu6rUa2fJVeEGfVdAM0DtGH24OmVZjI8OiZ2XgvJDF2U/F/VMgS0WO0UhMBx82/QKyHffJRBYKnyMz7quUeFwJlI3X7sxaVO3bhHIUqHWOO9V0++lHrAiz8P+OPeFC9H3S1uHrwMxRnbftbGGsB2s9CJlwMOx23K8qNuas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d2fad80eacso11622911fa.2;
        Thu, 29 Feb 2024 09:04:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709226294; x=1709831094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7eSu5LAngYuG4yyZo6XzjOmxDsHUKU5MZ0QDXjzOq8=;
        b=hnqgUKFqH7cbMuRutH5//i0o1Mym0Vf++S1Zf+x8nmZPdLdGq4TkO9aWtgFWAW3vpf
         hPlcjLQvAIVb9DAn1yBwQpjGrvzQaocDaEPzioFYmrf4+w3bzVvFfjT4o21NexDRo3op
         Ml1DaiP1veK4iW8aQETg/kunJjduuir1oM6sR+d3rtfqpEoX/c4pEX5WZwhxFtWkuMXP
         Hn+6icMQDB5k7vh9t7fLaNu6sU+EswADkdfzzUbusU9oXytCVQccsmsRCCqnDiswcgpJ
         P1HYRMmE2+iVxB1JxkVcavlofhqyTYv9+foy56IKt6y71it1HOthsbp6Cztq28U5Bmfw
         UP7w==
X-Forwarded-Encrypted: i=1; AJvYcCV7UUdIlJBuvkqSy8Jkqy6u2NDm6cM7nuI8BPr4HG7vK/UBjoj1h/1fCIlZFtwCfnOdvjJiKWJYHRVr70dieOre8NIbxyhnY0+188gt
X-Gm-Message-State: AOJu0Yx1D7ccwsgJmyTnF63ZLdp3oa2d/wIiNv/czPLocl4iDpN/wT2x
	PW+JhI7qWMLo7xQ+PXwJcalc17S3a2r6ciUsCs6n6qhWzL0Xu+0a
X-Google-Smtp-Source: AGHT+IHVvv37XKBHxeMbPUTK+oooXHJhgULZY/r3t3cWxLlVISuKpQHZmbVYY3b2qOjj9jRkkqXl1A==
X-Received: by 2002:a2e:8194:0:b0:2d2:c937:6fea with SMTP id e20-20020a2e8194000000b002d2c9376feamr1960270ljg.6.1709226293467;
        Thu, 29 Feb 2024 09:04:53 -0800 (PST)
Received: from localhost (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id y16-20020a05600c365000b00412656ba919sm5599122wmq.20.2024.02.29.09.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 09:04:53 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	dsahern@kernel.org
Subject: [PATCH net-next 1/2] net: bareudp: Do not allocate stats in the driver
Date: Thu, 29 Feb 2024 09:04:23 -0800
Message-ID: <20240229170425.3895238-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
convert veth & vrf"), stats allocation could be done on net core
instead of this driver.

With this new approach, the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc). This is core responsibility now.

Remove the allocation in the bareudp driver and leverage the network
core allocation.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/bareudp.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 4db6122c9b43..27408f0b93d6 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -194,15 +194,10 @@ static int bareudp_init(struct net_device *dev)
 	struct bareudp_dev *bareudp = netdev_priv(dev);
 	int err;
 
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
-
 	err = gro_cells_init(&bareudp->gro_cells, dev);
-	if (err) {
-		free_percpu(dev->tstats);
+	if (err)
 		return err;
-	}
+
 	return 0;
 }
 
@@ -211,7 +206,6 @@ static void bareudp_uninit(struct net_device *dev)
 	struct bareudp_dev *bareudp = netdev_priv(dev);
 
 	gro_cells_destroy(&bareudp->gro_cells);
-	free_percpu(dev->tstats);
 }
 
 static struct socket *bareudp_create_sock(struct net *net, __be16 port)
@@ -567,6 +561,7 @@ static void bareudp_setup(struct net_device *dev)
 	netif_keep_dst(dev);
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 }
 
 static int bareudp_validate(struct nlattr *tb[], struct nlattr *data[],
-- 
2.43.0


