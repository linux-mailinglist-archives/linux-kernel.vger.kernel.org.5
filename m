Return-Path: <linux-kernel+bounces-92348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD2F871EE4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCBD1C22C93
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33D05D476;
	Tue,  5 Mar 2024 12:15:40 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76435CDCE;
	Tue,  5 Mar 2024 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640940; cv=none; b=UcUYVP6vWpSMeufg1YwFDZbSE1v/jx0GXx2FxiZ0LeNGBVnerSLM1V60S7085bQN4/EKYyzyBuwnwoFHxwwdnCcYtYSMHVA5yzW5SsnuznZdt/lj7U4Yow3uQyPOMLhRAMzz+golTdxZoRQclMBKETb4FUM7GtQSykYG9HL/1eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640940; c=relaxed/simple;
	bh=BbqzQ7FR84wGJYSQkkFifd7v2CBPk8tXqQd8kQ9d8zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMbcaWhURERLVWnIVDeVcrzEIZLd3Sotc2Psgxe+Y/8NioOo/R/hxVuMoxd0N5skk1RY+jjRuWEnmmskoKkE2Ntkd5Au5RzxJgBiA8KOx6yS894lO8TdycIetgRyfizMFmQ9I8e20NykCzZgsXsUWNAPm49adLo/d6+nEqNia9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513382f40e9so3944731e87.2;
        Tue, 05 Mar 2024 04:15:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709640937; x=1710245737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlRgBsvkdB1uk+pnCPMDoR/KGnekNC9DXpehVtGRALc=;
        b=s8216JggPEnr9p9Y0ToNwMHMXOVt6A1JGD45Mi1o4j6m+N9rYSV03LgFfvyzbwCmVG
         2ExXXruENzxEwib+IouXF845EtezlLfazGNDf3GaVux6HYP9+Y+S8Kumez5h3b4ynGM6
         0ZhXKQTkoDapV0/YxF5OgVkNXUTUUxS2rtLU5ZGgcvjDbNismQTYAMzCbmiYFjPsg05O
         kJdL/KD3DKoCVN+qEyJJbHu+HiudBs9f2Vpad2ggLmI6xjul0j2+ZRYDvl8eMIgBzZ3X
         8Bq44yah+JTFr5bwbZwPnv3N94oL/sBR+2hYa87XNqBatr5hv7Kh+opiB/eRoEXWlmYe
         dPVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYgIj+Qo/BzbAeiF3rUna9Q3HQsM3/hSc6oeWG3InFTJMFqTscvT+X28+5/quONm7kjRXbGQL3EYDw47JOs0ArW1gEkI+kBtN4qVMJ
X-Gm-Message-State: AOJu0YwxswJCbCMFe2HFVvoSJQLf444S2HZnTTmZzZ8gBSrZWF35LU41
	kwZsMQrBakMhrI+GsNa2JqBPiJbBt94K3WUz5jxOo8RfnGJlt3+J
X-Google-Smtp-Source: AGHT+IEXK9I278PFM2NIiTH6L6oGJxrYG3KEfyvFvNNFUTa2taVG6i2Re3nVRx86yMtHAooJDKZ7FA==
X-Received: by 2002:ac2:4186:0:b0:512:f59d:7612 with SMTP id z6-20020ac24186000000b00512f59d7612mr1122169lfh.57.1709640936735;
        Tue, 05 Mar 2024 04:15:36 -0800 (PST)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id k3-20020a17090646c300b00a3fbca02e17sm5935394ejs.75.2024.03.05.04.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 04:15:36 -0800 (PST)
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
Subject: [PATCH net-next 3/3] net: gtp: Move net_device assigned in setup
Date: Tue,  5 Mar 2024 04:15:23 -0800
Message-ID: <20240305121524.2254533-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305121524.2254533-1-leitao@debian.org>
References: <20240305121524.2254533-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assign netdev to gtp->dev at setup time, so, we can get rid of
gtp_dev_init() completely.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/gtp.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index a279f0cd1b4d..ba4704c2c640 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -711,15 +711,6 @@ static int gtp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	return ret;
 }
 
-static int gtp_dev_init(struct net_device *dev)
-{
-	struct gtp_dev *gtp = netdev_priv(dev);
-
-	gtp->dev = dev;
-
-	return 0;
-}
-
 static void gtp_dev_uninit(struct net_device *dev)
 {
 	struct gtp_dev *gtp = netdev_priv(dev);
@@ -937,7 +928,6 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 }
 
 static const struct net_device_ops gtp_netdev_ops = {
-	.ndo_init		= gtp_dev_init,
 	.ndo_uninit		= gtp_dev_uninit,
 	.ndo_start_xmit		= gtp_dev_xmit,
 };
@@ -951,6 +941,7 @@ static void gtp_link_setup(struct net_device *dev)
 	unsigned int max_gtp_header_len = sizeof(struct iphdr) +
 					  sizeof(struct udphdr) +
 					  sizeof(struct gtp0_header);
+	struct gtp_dev *gtp = netdev_priv(dev);
 
 	dev->netdev_ops		= &gtp_netdev_ops;
 	dev->needs_free_netdev	= true;
@@ -970,6 +961,7 @@ static void gtp_link_setup(struct net_device *dev)
 	netif_keep_dst(dev);
 
 	dev->needed_headroom	= LL_MAX_HEADER + max_gtp_header_len;
+	gtp->dev = dev;
 }
 
 static int gtp_hashtable_new(struct gtp_dev *gtp, int hsize);
-- 
2.43.0


