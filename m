Return-Path: <linux-kernel+bounces-97293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F8387685C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42BCE1C21486
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA7657867;
	Fri,  8 Mar 2024 16:26:16 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7925E3BBE0;
	Fri,  8 Mar 2024 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915175; cv=none; b=H85KSAJa/OXBROqrah7rsV9gRj6m1yBMs45J6tW8yTuCCweCalry6AqFMxu5coBT4axfV8AtUQsjCL9dqTcyJvqJCKqBbqADCG9SJo7OIgDMNZ+yj4QMki14ygLQPx9co8aidLKVW/aNFKDw7xZesWDzcq9z6cT52lzf51YbhxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915175; c=relaxed/simple;
	bh=ok5+BLxSyUMuLr8tfGG2vplVrLRe276RtWSLWqYOvUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F+Nj2AwDsgmAckN716mVePVGcMMoqwdUqqjxzR7zT4MCtmEoMtEHcPdWQshw+n+xyIDSpxfmFLp1UyK1cJbDhbWL9uu1oWzdZvC5wB2jk9v6RO2nn02grX9e8fByStZmxLKGemm9SiCMI80I5OdLOgDy6pnbra2oTHq6hV5pctg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso2575827a12.3;
        Fri, 08 Mar 2024 08:26:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709915171; x=1710519971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChQHrGeHJWy8Gflyxs1kBU5l/y5oaijGtHOVZvY1p18=;
        b=FDUUbX5q1WoPQ0nXFmdzzPASFaRDT5gvHxQGj2H02verVIT7TsE2wDEIaAEixVP1Nd
         X6j2ZLAxOPBCZDfJqv0XiomVrK+Qgn3dbS5ep3ZAvj4J6xdIHvLcFbq9PqcjIwJPplKH
         0/KlburneNkn+4OLeA9Q+npuSS7/B5taCTUE6nzI4MBkqZdjMLOI/4hwuFcxFzVyTB95
         5SZwxoPUpG67IFis9j91JYLtobkofFSyqWTuxDAkSMZ0XMbI42rWxvtzyPUSkIktOoyx
         E5CfO8fOR7BHllmVaUrSYK/khrwczCJ8f+QrByFQ7/Z2Gputnax7BQtCgiaQ1Ep5soLt
         HOkg==
X-Forwarded-Encrypted: i=1; AJvYcCVIvP7Ja+A5zZ1j7HbJSMTQq5MrqINrfCiZKMoEUI0YdurpwP8ZMjJg7EzWK0X2vyib+iEcVhecLHjZCGmK3Q9R5EVZb37FjkBpKclo
X-Gm-Message-State: AOJu0YxO4ZKc0QCGOWUO3bkIf73EpkY/HhhpMwPuqvxmG1aIuXMFd7aS
	HmVz7jOeHSVXBBx9J5wLNuxxv4fUbPZtnvnGWaOFf1IKVTALvSxq
X-Google-Smtp-Source: AGHT+IEyZiDNnfZQPy2YwGf3tNh95lYoIFf4NpsdjHMWmDuu7Yb6CP/Duir28KZxKG7jtrS56NQ9Pw==
X-Received: by 2002:a50:d6de:0:b0:566:f3d:c0b6 with SMTP id l30-20020a50d6de000000b005660f3dc0b6mr2366541edj.8.1709915171401;
        Fri, 08 Mar 2024 08:26:11 -0800 (PST)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id v17-20020a50d591000000b0056835320f76sm265725edi.8.2024.03.08.08.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 08:26:11 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: Taehee Yoo <ap420073@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	dsahern@kernel.org
Subject: [PATCH net-next 1/2] net: amt: Move stats allocation to core
Date: Fri,  8 Mar 2024 08:26:04 -0800
Message-ID: <20240308162606.1597287-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
convert veth & vrf"), stats allocation could be done on net core instead
of this driver.

With this new approach, the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc). This is core responsibility now.

Move amt driver to leverage the core allocation.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/amt.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 68e79b1272f6..cb31d1990660 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3063,15 +3063,10 @@ static int amt_dev_init(struct net_device *dev)
 	int err;
 
 	amt->dev = dev;
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
 
 	err = gro_cells_init(&amt->gro_cells, dev);
-	if (err) {
-		free_percpu(dev->tstats);
+	if (err)
 		return err;
-	}
 
 	return 0;
 }
@@ -3081,7 +3076,6 @@ static void amt_dev_uninit(struct net_device *dev)
 	struct amt_dev *amt = netdev_priv(dev);
 
 	gro_cells_destroy(&amt->gro_cells);
-	free_percpu(dev->tstats);
 }
 
 static const struct net_device_ops amt_netdev_ops = {
@@ -3111,6 +3105,7 @@ static void amt_link_setup(struct net_device *dev)
 	dev->hw_features	|= NETIF_F_SG | NETIF_F_HW_CSUM;
 	dev->hw_features	|= NETIF_F_FRAGLIST | NETIF_F_RXCSUM;
 	dev->hw_features	|= NETIF_F_GSO_SOFTWARE;
+	dev->pcpu_stat_type	= NETDEV_PCPU_STAT_TSTATS;
 	eth_hw_addr_random(dev);
 	eth_zero_addr(dev->broadcast);
 	ether_setup(dev);
-- 
2.43.0


