Return-Path: <linux-kernel+bounces-123842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56261890EBB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0C51F23EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3338E13BC02;
	Thu, 28 Mar 2024 23:52:41 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0764A135A50;
	Thu, 28 Mar 2024 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711669960; cv=none; b=Odias0cIrcvM+4x3UIwzbKxumxpquInuxDto8ksUmCe2jjKw8Z9QuOYMIkTiydRidkK39Dhdd4hJDujv8g4aYjSXwdaoGJaVEPptwjmkdAF3ScROV0SZ2Cx9Y6HKSuWhHvIO/1dcudJBIwfdpAqjBb64/kJzc+GEjLB0riaS0Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711669960; c=relaxed/simple;
	bh=D7+iQui71zLLV25qjqnYnvfU20OL/oFQytH1hKUGxM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9uTyArZ/3WXxbWlVx3hlIebzJq5gFONwle8JaYEB5BK+ByKY7EyBRr4tLH9VdjhJnn49hjGNKhm2Z0SefPf13E13vH665b4uMPiCKjQl/MrBWMDJcHZfQFtCF2iOOJ7D2wMAS37moOb/if7uGXsaVHbmsorL0GzEx9sElgj5Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4e0e3ef357so202347566b.2;
        Thu, 28 Mar 2024 16:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711669957; x=1712274757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gm4luDqdlqxFoZt9BqFvd3z6MyUMpu16qpyJwCbfvYI=;
        b=wkIeERQQmK+PGTohs5TRxld7bmgr2E9KwC1erm2RzYbBUZklMLEp0HDkvT7l5CKfPk
         D34abQWjElnwvxZSsBhCE/XWez8eTsmodfzq/ZTDGN/VAesS/a2NT27sYgopfQe7CCnm
         a0XFgodfTkw2xOm+FHoaW/vMIyEaxmxFc0uSSyLdG3jBHOqlxrCncSy0viFWpa4niLW0
         Rsy6ZZuIvYskCXmddA8QyFim5jCmk6JrgESLGdMUg1eWXLboUUYDjn1p9MQlgyk2up4I
         AFqbJhI7gHzycKSLWk4JBrPUtddP5JoSeYkI05B55IdzralAuO5FpJhemllNBuuDrR2N
         PE7w==
X-Forwarded-Encrypted: i=1; AJvYcCUTx1HwRtCKPpi0nUNpAa5amKajo8JIlN9pYPb0ojzDmJXiUVq9IyXeE9DCyQw9mlec9zivUJEPD4tO4wIkJy8OAk2RQDUHr2kY5XnqyjnMzs9dI1loUt5KPgdBpPNnKPORNq6q
X-Gm-Message-State: AOJu0YwKgtBMN2Yy4JgxZBkE+tOC4faB9Py89gbEMZ1gzqwQlBwRd7fi
	wOh1qIuXZ4deuURsLthAveHqvK3IHMcqdFYPWKn7oHPuwhGJBbfi
X-Google-Smtp-Source: AGHT+IGlKueY1H7rKZKWZlzJ+BtfMjvVmEe4ACq3hfPV7Sw3iDr12k1nk/aQwalpo2q3Uabr3nCkOQ==
X-Received: by 2002:a17:906:118a:b0:a4a:35bc:2588 with SMTP id n10-20020a170906118a00b00a4a35bc2588mr492264eja.43.1711669957310;
        Thu, 28 Mar 2024 16:52:37 -0700 (PDT)
Received: from localhost (fwdproxy-lla-111.fbsv.net. [2a03:2880:30ff:6f::face:b00c])
        by smtp.gmail.com with ESMTPSA id x15-20020a170906b08f00b00a46a9cdcfa5sm1280710ejy.162.2024.03.28.16.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:52:36 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: aleksander.lobakin@intel.com,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Alex Elder <elder@kernel.org>
Cc: quic_jjohnson@quicinc.com,
	kvalo@kernel.org,
	leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 4/5] net: ipa: allocate dummy net_device dynamically
Date: Thu, 28 Mar 2024 16:52:04 -0700
Message-ID: <20240328235214.4079063-5-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328235214.4079063-1-leitao@debian.org>
References: <20240328235214.4079063-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embedding net_device into structures prohibits the usage of flexible
arrays in the net_device structure. For more details, see the discussion
at [1].

Un-embed the net_device from the private struct by converting it
into a pointer. Then use the leverage the new alloc_netdev_dummy()
helper to allocate and initialize dummy devices.

[1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ipa/gsi.c | 12 ++++++++----
 drivers/net/ipa/gsi.h |  2 +-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 9a0b1fe4a93a..d2db54cbd46d 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -1730,10 +1730,10 @@ static int gsi_channel_setup_one(struct gsi *gsi, u32 channel_id)
 	gsi_channel_program(channel, true);
 
 	if (channel->toward_ipa)
-		netif_napi_add_tx(&gsi->dummy_dev, &channel->napi,
+		netif_napi_add_tx(gsi->dummy_dev, &channel->napi,
 				  gsi_channel_poll);
 	else
-		netif_napi_add(&gsi->dummy_dev, &channel->napi,
+		netif_napi_add(gsi->dummy_dev, &channel->napi,
 			       gsi_channel_poll);
 
 	return 0;
@@ -2369,12 +2369,14 @@ int gsi_init(struct gsi *gsi, struct platform_device *pdev,
 	/* GSI uses NAPI on all channels.  Create a dummy network device
 	 * for the channel NAPI contexts to be associated with.
 	 */
-	init_dummy_netdev(&gsi->dummy_dev);
+	gsi->dummy_dev = alloc_netdev_dummy(0);
+	if (!gsi->dummy_dev)
+		return -ENOMEM;
 	init_completion(&gsi->completion);
 
 	ret = gsi_reg_init(gsi, pdev);
 	if (ret)
-		return ret;
+		goto err_reg_exit;
 
 	ret = gsi_irq_init(gsi, pdev);	/* No matching exit required */
 	if (ret)
@@ -2389,6 +2391,7 @@ int gsi_init(struct gsi *gsi, struct platform_device *pdev,
 	return 0;
 
 err_reg_exit:
+	kfree(gsi->dummy_dev);
 	gsi_reg_exit(gsi);
 
 	return ret;
@@ -2400,6 +2403,7 @@ void gsi_exit(struct gsi *gsi)
 	mutex_destroy(&gsi->mutex);
 	gsi_channel_exit(gsi);
 	gsi_reg_exit(gsi);
+	kfree(gsi->dummy_dev);
 }
 
 /* The maximum number of outstanding TREs on a channel.  This limits
diff --git a/drivers/net/ipa/gsi.h b/drivers/net/ipa/gsi.h
index 42063b227c18..6b7ec2a39676 100644
--- a/drivers/net/ipa/gsi.h
+++ b/drivers/net/ipa/gsi.h
@@ -155,7 +155,7 @@ struct gsi {
 	struct mutex mutex;		/* protects commands, programming */
 	struct gsi_channel channel[GSI_CHANNEL_COUNT_MAX];
 	struct gsi_evt_ring evt_ring[GSI_EVT_RING_COUNT_MAX];
-	struct net_device dummy_dev;	/* needed for NAPI */
+	struct net_device *dummy_dev;	/* needed for NAPI */
 };
 
 /**
-- 
2.43.0


