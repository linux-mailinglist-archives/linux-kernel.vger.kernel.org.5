Return-Path: <linux-kernel+bounces-92297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51C1871E12
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A331C229B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F196257333;
	Tue,  5 Mar 2024 11:38:07 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B7F54908;
	Tue,  5 Mar 2024 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638687; cv=none; b=d9mRPE0VhkO2vwPtTALzAf7QAYKGekwVO9KmLoyDoda3Zf2yKk6nRCB90Bme10s0OSjfH4WPj84BO7ZaSLgiKaSU99EmtCqiHWkaUtYeUBtg9XpNW+BbgyhOXwDdDrwL6BfWZABkQc4DE0fau/U7rSpDGt34yAXhqByIwRJjxsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638687; c=relaxed/simple;
	bh=an0mJ4yI+Taqndo6C5ZxyINal5TwXXDiYE/eX/dyfXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ebkBXAazRcjaoia3Z416CeH2i79ASP3hhVw4ik7PVtuoe8laacfcErPNTyzWUJFlTVgiJtnQZkO4u8xFdC/JNbmxecd1HcSry0KfHOEKbT5rLH2PLqfVsVJNo5e5dsJZJW/whtWbzP7Xcc2IPAAL/ncI9a2Dl8p0FKsh/eX8K4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so1090130866b.0;
        Tue, 05 Mar 2024 03:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709638684; x=1710243484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZcy/13YPJy/Q8JEq2MiymPPGsNdrglf5cJPZckjBCg=;
        b=lKcJOcUevr9rztc+PQ7gzAo4I8r9yNwKmuwzzaDIj0Af93HCG7vEOk4WVec4IOSr8v
         iyr/0pbZvo4u+yiNG6zLMcF5ksNnPk5xi/yXqBH4gdpBKAyMaV6kbvYiqiF4t1XixyPj
         LMb5GmYStYz97CJu+TzTBGFKO/oFKBSz+DdySmowE/YU29deFz+DS3gU6w2+IxwKYGC2
         xfGa19yVSNdZ8S7DAw3yxsDLYf6yyTSxjpMbJ1Fy9hRjQcplKBdE2xxfO4+bIS1QRQh7
         5FUftRkCH02zTFVs0E+moYSoI2yEknTL0XddbKjR904W5vOO2dOQDOZbCd+dH977L67K
         YP8g==
X-Forwarded-Encrypted: i=1; AJvYcCWEVsvSD9vwpQvl+sasR7f2HaDZEmdkxPzUZ/1K9nldQcvXbQHcHEy1UL0UI+mFeXI9PK70Tgeb7W6pkiiZNs40DVbeYGKs0gKrdXDV
X-Gm-Message-State: AOJu0Yy+exG89NmNFGqGAeWGH97KD9HFHTwwwEY5dSd74rdcIVOiruIV
	WPtgsJNa246iZAHf/SRK6+y736rkCCZJEjtVRMMiCXaj5nllUPLY
X-Google-Smtp-Source: AGHT+IGTkQxVbnlou2GMNYIIuskCZMU5vmsYsWmRfmFLbTSF1PvqcFQlaiCgE+UViH0KdyBtPT4Ztw==
X-Received: by 2002:a17:906:340b:b0:a45:74fb:f5c3 with SMTP id c11-20020a170906340b00b00a4574fbf5c3mr2319199ejb.28.1709638683891;
        Tue, 05 Mar 2024 03:38:03 -0800 (PST)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id rp25-20020a170906d97900b00a3d665c6778sm6038509ejb.12.2024.03.05.03.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:38:03 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	dsahern@kernel.org
Subject: [PATCH net-next] net: macsec: Leverage core stats allocator
Date: Tue,  5 Mar 2024 03:37:27 -0800
Message-ID: <20240305113728.1974944-1-leitao@debian.org>
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

Remove the allocation in the macsec driver and leverage the network
core allocation instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/macsec.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 4b5513c9c2be..0206b84284ab 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3519,18 +3519,13 @@ static int macsec_dev_init(struct net_device *dev)
 	struct net_device *real_dev = macsec->real_dev;
 	int err;
 
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
-
 	err = gro_cells_init(&macsec->gro_cells, dev);
-	if (err) {
-		free_percpu(dev->tstats);
+	if (err)
 		return err;
-	}
 
 	dev->features = real_dev->features & MACSEC_FEATURES;
 	dev->features |= NETIF_F_LLTX | NETIF_F_GSO_SOFTWARE;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	macsec_set_head_tail_room(dev);
 
@@ -3550,7 +3545,6 @@ static void macsec_dev_uninit(struct net_device *dev)
 	struct macsec_dev *macsec = macsec_priv(dev);
 
 	gro_cells_destroy(&macsec->gro_cells);
-	free_percpu(dev->tstats);
 }
 
 static netdev_features_t macsec_fix_features(struct net_device *dev,
-- 
2.43.0


