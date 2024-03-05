Return-Path: <linux-kernel+bounces-92346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F43C871EDE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FD7286E98
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B535C8F5;
	Tue,  5 Mar 2024 12:15:37 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326BA5A7A5;
	Tue,  5 Mar 2024 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640936; cv=none; b=Ax5ubWXLUmHC7Nkz/R+p4IAuNh7bWlV1tgLGCJaYZO6IKtxHVxRhOmkwtKW27mJfdbeozdsrcfo4GFbHJLS25mBtPeFw/PDP60i86AfcMf7B4F34ezbK/kF41en2j90e5z2PxGGSkEyei81zsgYlclzPbmqWVH+dxI2WalOobks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640936; c=relaxed/simple;
	bh=yrysr5iWvnRVbt2xL/EIfqttzTX5rUTHYqNzaLx5qcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pXrtShTFtWFEtZlmXpNo6hoolrRtA+o/8w3d52LO2vKdNdlMlzlLreIZQEJRD//XlefSwgLmfsAPCyD6ty6Ij0t5RMrqeR6kZHSMmdfTbHF7ZE+fcE28Ei1dN9F2vYfea/BAUyH2TfqL5JOiAjoXM7yaUAN/tv2YRPlycV6+MWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so89482166b.0;
        Tue, 05 Mar 2024 04:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709640933; x=1710245733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JG3VSpSBId+LffdzAqb7pqYBWbcN1uLse2eKNRmus5E=;
        b=pkevkpGKzBqWRHEwmigNroyoSZQy0DS4ru68UxJJhuND2vh7NWcg5h9IudToeGth2o
         j9EaLo8qR8wiskgK3yOw3OsVoOJcL24unwlJT/5DeaiHczfztV1wd4kTfGGFGEYHrQh1
         bo/eLXYgBM9VwqKs7LOATIMuV7Ib/0Sk9R2oyhkoIPkSwTdX0ostvk/yE2YEBzbN13Gx
         R9nXxE7mYpja+b2Hk66zNnm/rb2F1zlf/LMHuEXxmgL51mXHmf66NQ6w5wgfF6sa6E4x
         8ojmVLKYABx6QoSGgrKrNn/1V3jnug9vkr80+iAmIib6mxCrxXcBlVAoDaxVBdxYafmn
         vXhg==
X-Forwarded-Encrypted: i=1; AJvYcCWs9pBtAvHlyCC5pkfl5aVdEWzJnR7wxf8oGuD7LFNNiJXh48mcfABC83owp9CC9c/6OcpgGPnZAycBrpaPb85lF+Hzrm5pkQ8KYNEL
X-Gm-Message-State: AOJu0YylXMaw6da+wnNuRqmghLAoU2P4zr7UGhsuaL13XQv/7oRXV6Wp
	SxsFRV8gNhrUj5qg7mY8krtfNiVZlsDFp4u9BgtHZpQNP7kPXsVM
X-Google-Smtp-Source: AGHT+IFR3WGZuebyFFvq/51EnY9cTbsjkK/kx7Ilk++87zUVxhXQMBrOMecLr6eR2TSNRBaf4SPz1Q==
X-Received: by 2002:a17:906:6954:b0:a45:8f10:50c6 with SMTP id c20-20020a170906695400b00a458f1050c6mr2209901ejs.57.1709640933320;
        Tue, 05 Mar 2024 04:15:33 -0800 (PST)
Received: from localhost (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id am19-20020a170906569300b00a44cb0bf11bsm4027184ejc.79.2024.03.05.04.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 04:15:32 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	dsahern@kernel.org,
	osmocom-net-gprs@lists.osmocom.org (open list:GTP (GPRS Tunneling Protocol))
Subject: [PATCH net-next 1/3] net: gtp: Leverage core stats allocator
Date: Tue,  5 Mar 2024 04:15:21 -0800
Message-ID: <20240305121524.2254533-1-leitao@debian.org>
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

Remove the allocation in the gtp driver and leverage the network
core allocation instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/gtp.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 2b46b7398ade..facbfba5d77f 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -717,10 +717,6 @@ static int gtp_dev_init(struct net_device *dev)
 
 	gtp->dev = dev;
 
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
-
 	return 0;
 }
 
@@ -729,7 +725,6 @@ static void gtp_dev_uninit(struct net_device *dev)
 	struct gtp_dev *gtp = netdev_priv(dev);
 
 	gtp_encap_disable(gtp);
-	free_percpu(dev->tstats);
 }
 
 static inline void gtp0_push_header(struct sk_buff *skb, struct pdp_ctx *pctx)
@@ -970,6 +965,7 @@ static void gtp_link_setup(struct net_device *dev)
 	dev->type = ARPHRD_NONE;
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	dev->priv_flags	|= IFF_NO_QUEUE;
 	dev->features	|= NETIF_F_LLTX;
 	netif_keep_dst(dev);
-- 
2.43.0


