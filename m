Return-Path: <linux-kernel+bounces-88507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0227F86E289
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC67F28ABC6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B9B6EB73;
	Fri,  1 Mar 2024 13:42:26 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733ED6EB64;
	Fri,  1 Mar 2024 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300546; cv=none; b=S5GkJkHgb4GZLRrN0gWfOtQK+1S5nZH0UkTpqG/hxVERdbvZrrYhHK6dfXNrRMiNqPmgcbIXHkU5rhy6jgqvANwzzJNvu1uTf3fvFvrJ/a439XmBbR5jJfzQt/oXlWhp5P02DO9hiRKQsZUB4M580VP5RKYVlsqw2RsnRZrfXxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300546; c=relaxed/simple;
	bh=YcuzT144GY5Gzx8E8bB8mn4dTvPZBIq4nVBHbYj/FEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fy46HnJqApxGbc0400NYo8PatsrCTSVk6FTMp6zLY4WZ8W0jVYkufDDlTOfQJP/PSiEVPVcpQqnRofV3akWoa/HsicdsCp3XBKaUZ/wmZUJvpoQdkqpTYLhtzKmddkaQtPm5F7Js1XwWLZ4uVACSdqrwv7+asHfQkeSY8D7bizU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso1173724f8f.0;
        Fri, 01 Mar 2024 05:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709300543; x=1709905343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=meK2UlP/dm3hH3i+lg2G+YANY+IJ/fxWJMq8pj0EJNc=;
        b=X5oTSm82ftlIosrqcYRnZMnzIDsXqCiTAks3BQH43zQXrcO3KDMiaMJsZmkBVnYjeU
         Z6YVZMSGPkB25DUq2gQpTN0DGainUpHHyvl86nzb98ZBbDVsBnukZ29aeVfB4c2vW2nY
         Ju6fYfJMjZtneXOSxgvhaYsOg1nxdaOqLtLb1CYTPKh6bT/MQQyjxBGpXtSDZ6ZUXdkT
         JL8j4YZW15oGaGGw8svfPZMVkqsnT/gmcQIFQGCIumjLoXO1/JPYfGgWiZzIdrkyAChv
         d2TTfI2cKDekePyCNBjS9zf4pGakZbEvBUZlQruY4TBUd8UnkyMgISbRj+8nmeSynfyJ
         pYUA==
X-Forwarded-Encrypted: i=1; AJvYcCUw2KVGj2EYYchDAsS3a3dN6dSpXy27I2NmlVxNfXAI3v5dhuNfwEBIrSLIRgTIGaPns9U4gW4k+n7+J9jY6oHroWyWdbZnPhgRJE8s
X-Gm-Message-State: AOJu0Yz6Rw3IHAufX60ivzK3ruONBUzbW057o3ftPYR/OYcBXaAev3Qb
	1XckXRsFssntrupf4Mjao9DW3+uTGE6CRIzs8aaZd96InRnjo3CV7fr54wch
X-Google-Smtp-Source: AGHT+IHA2bQQZ2GyP4Xhw2j53/S311aykXnT/ePV7fBI4MRv1/AUAM+Ld26zx3KCPkJ2SEN+x19G+w==
X-Received: by 2002:adf:cd8b:0:b0:33d:7ec9:f5d0 with SMTP id q11-20020adfcd8b000000b0033d7ec9f5d0mr1980963wrj.2.1709300542465;
        Fri, 01 Mar 2024 05:42:22 -0800 (PST)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id y10-20020adff14a000000b0033e1be7f3d8sm2148066wro.70.2024.03.01.05.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 05:42:22 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	daniel@iogearbox.net
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	dsahern@kernel.org
Subject: [PATCH net-next 1/2] net: nlmon: Remove init and uninit functions
Date: Fri,  1 Mar 2024 05:42:13 -0800
Message-ID: <20240301134215.1264416-1-leitao@debian.org>
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

Remove the allocation in the nlmon driver and leverage the network
core allocation.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/nlmon.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/nlmon.c b/drivers/net/nlmon.c
index 5e19a6839dea..e026bfc83757 100644
--- a/drivers/net/nlmon.c
+++ b/drivers/net/nlmon.c
@@ -17,17 +17,6 @@ static netdev_tx_t nlmon_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static int nlmon_dev_init(struct net_device *dev)
-{
-	dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
-	return dev->lstats == NULL ? -ENOMEM : 0;
-}
-
-static void nlmon_dev_uninit(struct net_device *dev)
-{
-	free_percpu(dev->lstats);
-}
-
 struct nlmon {
 	struct netlink_tap nt;
 };
@@ -72,8 +61,6 @@ static const struct ethtool_ops nlmon_ethtool_ops = {
 };
 
 static const struct net_device_ops nlmon_ops = {
-	.ndo_init = nlmon_dev_init,
-	.ndo_uninit = nlmon_dev_uninit,
 	.ndo_open = nlmon_open,
 	.ndo_stop = nlmon_close,
 	.ndo_start_xmit = nlmon_xmit,
@@ -92,6 +79,7 @@ static void nlmon_setup(struct net_device *dev)
 	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST |
 			NETIF_F_HIGHDMA | NETIF_F_LLTX;
 	dev->flags = IFF_NOARP;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_LSTATS;
 
 	/* That's rather a softlimit here, which, of course,
 	 * can be altered. Not a real MTU, but what is to be
-- 
2.43.0


