Return-Path: <linux-kernel+bounces-92764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA928725A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8624F281F7E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB64171C4;
	Tue,  5 Mar 2024 17:30:12 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD115491;
	Tue,  5 Mar 2024 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659812; cv=none; b=E5jloKzt85V9CR7NMUAnEOpddMDpxX3ZcVZ+aapAWr35e3VQCqTWKNtpo8qQZhXSkfQ6cHWHJzhh9ShPeA6y19uL58TVR2aDKnv2BXT03ICt3zOIwQi5SVYs991GccVLosXEMVQzedHGaPnRBFR+4UEKt/s92KIaDcss7FHUG+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659812; c=relaxed/simple;
	bh=i83sIDjjKPudBFgdyqqnfQA7lkVycKfNiSKW8y4nc4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUHn6c8p6kN+Vw9hgGitNwAo3YJ0oq5ldy1IKwxSmCocTcXLEaLQhH7ted/nFQrJRZnI4RJOX86KuzpXe3YPTv/mEH4c2pXN0PcSS4alcwq1OUfsx/2LCciApXyoOHVHqqYqk/99AXsfJ2BRsTHF3P60N53JemN2wyz1nFvFjpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5133bd7eb47so4144106e87.3;
        Tue, 05 Mar 2024 09:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709659809; x=1710264609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8uCFGf8k6iLjyjQShlF3nE625Y2fqYIQwzjxO+ZKG5o=;
        b=mJaL0kSf+xn0VrUW9dAGNVnnon2jWOW4jXIZkdlidecIePhtX4lnskLeTTtlekUd9e
         +xrpqvrEm17zctKQWxcp/MZIDiJhveStLnwdhqLGyNGIKzAUbXXgRRMd0yB/9rM5uav/
         4QpA0oawtTKrjYmAsSOnLhS49Kb4z3THj4jyeDqsbUAqVSOaUMWLIi6aYAY7BKMik/Fi
         NsuxO19+SkXw61deFdce7m2OcpTJda82BFcU9jjWTe0QadvT/jNpglDGDwqjBaUlvzy+
         bN1ruKzAaCyK1u/SElfmf3qYuz2Id9xPkKbDDjxisFrQvkV+qVHoLerGWikGZZ//XqHn
         DlWw==
X-Forwarded-Encrypted: i=1; AJvYcCURDcNB/quMdFq2XR3XjcCBij97DiVhajDFTHRLsQJkb/5GjRGi1dMjRmkNnni1KF/WVlxGaFEtV6rmFJYS7Fe03zs61I12CWDZR9sg
X-Gm-Message-State: AOJu0YxfVtr8FmOA2Lv6Bx8s9D9hhbUN2Djj3/Pkb79OHVoQ2PoWnLk4
	OorLoiWyaxdGyAUamHBigzcuDjLZs2Sv/m2eJkLD912lm7YAcSK1
X-Google-Smtp-Source: AGHT+IFZpeJfO55mMWttk3T8zfrOq8xAiIXry2kEpSLswfmlu4R5RZBB+3tNJNVFKX2QNOkXGCv2xw==
X-Received: by 2002:a05:6512:b94:b0:513:5991:1481 with SMTP id b20-20020a0565120b9400b0051359911481mr701044lfv.29.1709659808351;
        Tue, 05 Mar 2024 09:30:08 -0800 (PST)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id lk11-20020a170906cb0b00b00a4577ffe69csm1910623ejb.78.2024.03.05.09.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 09:30:08 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	dsahern@kernel.org
Subject: [PATCH net-next 1/2] net: geneve: Leverage core stats allocator
Date: Tue,  5 Mar 2024 09:29:09 -0800
Message-ID: <20240305172911.502058-1-leitao@debian.org>
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
instead of in this driver.

With this new approach, the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc). This is core responsibility now.

Remove the allocation in the geneve driver and leverage the network
core allocation instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/geneve.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index e25e0a31126c..dc88d5600e2d 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -319,19 +319,12 @@ static int geneve_init(struct net_device *dev)
 	struct geneve_dev *geneve = netdev_priv(dev);
 	int err;
 
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
-
 	err = gro_cells_init(&geneve->gro_cells, dev);
-	if (err) {
-		free_percpu(dev->tstats);
+	if (err)
 		return err;
-	}
 
 	err = dst_cache_init(&geneve->cfg.info.dst_cache, GFP_KERNEL);
 	if (err) {
-		free_percpu(dev->tstats);
 		gro_cells_destroy(&geneve->gro_cells);
 		return err;
 	}
@@ -345,7 +338,6 @@ static void geneve_uninit(struct net_device *dev)
 
 	dst_cache_destroy(&geneve->cfg.info.dst_cache);
 	gro_cells_destroy(&geneve->gro_cells);
-	free_percpu(dev->tstats);
 }
 
 /* Callback from net/ipv4/udp.c to receive packets */
@@ -1189,6 +1181,7 @@ static void geneve_setup(struct net_device *dev)
 	dev->hw_features |= NETIF_F_RXCSUM;
 	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
 
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	/* MTU range: 68 - (something less than 65535) */
 	dev->min_mtu = ETH_MIN_MTU;
 	/* The max_mtu calculation does not take account of GENEVE
-- 
2.43.0


