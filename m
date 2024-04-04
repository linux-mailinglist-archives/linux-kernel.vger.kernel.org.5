Return-Path: <linux-kernel+bounces-131341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FD689867B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A2528935D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A201292EE;
	Thu,  4 Apr 2024 11:50:02 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B89D12839F;
	Thu,  4 Apr 2024 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231401; cv=none; b=bSf7dWJanz5Zu9USlXwq1PBopA4IRaBg8fe+L37PH3+b7c+OqQzZj6OXpglntXYXNYtvZoQOCcRizzL+J0V2mvffG4zP6uXagFs0jnALU3Xdgb2Axq1nEKMs7CY/d//M8K8YyE0PTolWumyR4/OCDDsgq1OMuSxeHAvuQHnv+kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231401; c=relaxed/simple;
	bh=QtQ6sHpbu3QCkabgr6hTrp4OmZME1Hi0HLc2rVVa08A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mY23VSwh8p6vTIqfeYdvZF+53sYtEVlX57j8JSsCfE1mmDHi8H8hr0vPFtjlsL+Bv1jJNKx0uY6ZEBUMERP8cqiGnc8XiYjyo7gcvLNdQdsrMuvvlQNO9Ebnm6E+LxraMFbzNw18iEBzAdi/Gp9ungE2L3kzlLJIAo40Oi5uIRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so3550689a12.1;
        Thu, 04 Apr 2024 04:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712231398; x=1712836198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ui1DJxKv+GCSubTCimqVqNTb9BwhV0yVlSdcCwIQq1A=;
        b=seITlKkk4g9nvLJe99HoKLF5GSFigzdegoLtjQSk3uCS6fsRngi1cpl6Cpq0Pe9ber
         in6KCNMkDz888h7MYWHTi/W5eDzs87ds0pfAdYcvkZLJLPeHiwRDKuQxgD8pNifh/XJW
         FMwatScU8fRxt0YMIoteAvrV/0BoP18UexLHQK48BUHdyV6iTNyeOAU/VByIkUd2hAQW
         K0I/WgPgHLOHYBMBzjKRwFGOJhJNFUh/OFYAY5pH8Cmc639W56HCqsMLXHRY+tUw1WX/
         CR21F4pyRSi2WyJaFtENyhB5oIKDpPTAhm2NQknDhacOUzyik2Sb7YsFua7D4VwE49f8
         AD0w==
X-Forwarded-Encrypted: i=1; AJvYcCXSn8V0fmjxn/l7Jr1By7YcVSdSCWFgcOms943SX5H3vPONZn6Uk6n+91uTbazHrVSozYF16a78ULjc6tCVkotsSmiT/0668ky9zKzIQo6yg8JO1SCdGYVd0RvmXux/MxgnJZglILGUYbY6EjWcMVPHtsDHK8Q+tZLR
X-Gm-Message-State: AOJu0YxhWsolOl9+vOp5l22O4eOhuojdHJIcJsOsbuU+dOTuaeBefgMs
	1l73XBHSLCQcAWlFAqqrsb0GMPxJ2dQLrEIC5HQXUxUz+6/8Ipd3
X-Google-Smtp-Source: AGHT+IGR/2cl7VV3Nm0oPydh1R3stQjygMPvAFpJJaxHSUjjTaaXgqGOaWjKnswlTpZmIr4PxMZ4eA==
X-Received: by 2002:a17:906:d9c5:b0:a51:964f:c3e4 with SMTP id qk5-20020a170906d9c500b00a51964fc3e4mr178315ejb.5.1712231398570;
        Thu, 04 Apr 2024 04:49:58 -0700 (PDT)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id wk8-20020a170907054800b00a4e2d7dd2d8sm8166265ejb.182.2024.04.04.04.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:49:58 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: aleksander.lobakin@intel.com,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	elder@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org,
	taras.chornyi@plvision.eu
Cc: quic_jjohnson@quicinc.com,
	kvalo@kernel.org,
	leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 4/5] net: ipa: allocate dummy net_device dynamically
Date: Thu,  4 Apr 2024 04:48:44 -0700
Message-ID: <20240404114854.2498663-5-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404114854.2498663-1-leitao@debian.org>
References: <20240404114854.2498663-1-leitao@debian.org>
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
index 9a0b1fe4a93a..d70be15e95a6 100644
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
+	free_netdev(gsi->dummy_dev);
 	gsi_reg_exit(gsi);
 
 	return ret;
@@ -2399,6 +2402,7 @@ void gsi_exit(struct gsi *gsi)
 {
 	mutex_destroy(&gsi->mutex);
 	gsi_channel_exit(gsi);
+	free_netdev(gsi->dummy_dev);
 	gsi_reg_exit(gsi);
 }
 
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


