Return-Path: <linux-kernel+bounces-157295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F399F8B0F70
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4B41C22CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660E016131C;
	Wed, 24 Apr 2024 16:11:57 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5B513D893;
	Wed, 24 Apr 2024 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975117; cv=none; b=FojNT8BKOfia4ENK6Ml6L9l5ijDovb9A1SVlkWWJJ3bLfWZZSSm+BKQPyWkxvwPuE2rFNq2Y5C/WPSu2bCGREqwv0TN/AYuUFIOTUc+NoVKGUqoNEq0PEzfEDqEJfvGXmxNCtOLQsgSVFAM1s8RUm2IzF+hm7f5SWk8FqIz8EEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975117; c=relaxed/simple;
	bh=GOoBxOlaIpmwICZK4WCVIt4VRYe8AudVtzbqmGtnuwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u1SoQF2cofIqJU24hAIp5cl6G9as/MzQn9h2GFXG2JMM5hn1GEWlHRd6UC63kdEe7SUElYEmsSXiSKXUNIdJQwyIIHdA0exG7dYMNK7n2/7ZRV9JCSkTPDqK62fP1GZxZIJ+jzyhu0m2oSb/R84OxNMFTyNPeGKPISVKobiGT+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57222fc625aso1969334a12.3;
        Wed, 24 Apr 2024 09:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713975113; x=1714579913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9Ytp1zYNtgWI9LiOFGXnBvOw75e8b/kBgDs3orvXtc=;
        b=qk34nm37Msi386mL3VHEXAM4vwraOAt7iB2UOt2z4cEHbA9n2jjoLFTFKD9vt0TF+4
         VubzmI/40jIlocpN0NTQPSI7tG5GLKV39Xz6m1/gPqulMHGhES61IVDWWSt4MEfubaNE
         ri2w9n7UoX2xoSREM/Ff5fT6MczlJzSt6HDMvy/s0Qxg6qcBow8BVygfO3yL1DwMm5yn
         N9JFJB076y/oAwYGEDke2kHO9UU215iBxqsPOwk3EtjjOthxlWuppIXae9gNynBYKhz1
         e5AnZRFN+pHkBqeU96LD4jMDd9ke71nFJVWcigf5xxgP+Wruf6VlKB1a7onNCZ4PmZ6+
         KXaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUki35BpZHdWSsjg8BA8ssSO2mzhYyw+/Jxef0xQ6JEZdVZEXypDFjFvM2qssq2/DhIEwlzj5XArRkZlNMw4Yj3K5VVI9srKC0xfZL7JiZz5hFESBFtDr6tNPmSwD9i6oMhIuxO
X-Gm-Message-State: AOJu0YxfRcDlSlHgBhYPkM9cvKCJB4F8z8Om8nLK+Yjd1MFRmai84VMC
	bAniZaohtlR+18pq2af+NKj1qldNUhgJfT7zNFmE3XT69ILIdR8d
X-Google-Smtp-Source: AGHT+IExvaCXYmWGV1a44vGm02+XchJsxnbF0StXY1lQmClYXTH6GQ+7+l/4M6FWk+LO0PHH5HLuOw==
X-Received: by 2002:a17:906:a114:b0:a55:b810:8678 with SMTP id t20-20020a170906a11400b00a55b8108678mr2700110ejy.23.1713975113289;
        Wed, 24 Apr 2024 09:11:53 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id ww4-20020a170907084400b00a51d88e6164sm8497371ejb.203.2024.04.24.09.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:11:52 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
	Liu Haijun <haijun.liu@mediatek.com>,
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leit@meta.com,
	netdev@vger.kernel.org (open list:MEDIATEK T7XX 5G WWAN MODEM DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: wwan: t7xx: Un-embed dummy device
Date: Wed, 24 Apr 2024 09:11:07 -0700
Message-ID: <20240424161108.3397057-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
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
--
PS: This was compile-tested only due to lack of hardware.
---
 drivers/net/wwan/t7xx/t7xx_netdev.c | 20 ++++++++++++++++----
 drivers/net/wwan/t7xx/t7xx_netdev.h |  2 +-
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_netdev.c b/drivers/net/wwan/t7xx/t7xx_netdev.c
index 3ef4a8a4f8fd..91fa082e9cab 100644
--- a/drivers/net/wwan/t7xx/t7xx_netdev.c
+++ b/drivers/net/wwan/t7xx/t7xx_netdev.c
@@ -253,22 +253,27 @@ static void t7xx_ccmni_wwan_setup(struct net_device *dev)
 	dev->netdev_ops = &ccmni_netdev_ops;
 }
 
-static void t7xx_init_netdev_napi(struct t7xx_ccmni_ctrl *ctlb)
+static int t7xx_init_netdev_napi(struct t7xx_ccmni_ctrl *ctlb)
 {
 	int i;
 
 	/* one HW, but shared with multiple net devices,
 	 * so add a dummy device for NAPI.
 	 */
-	init_dummy_netdev(&ctlb->dummy_dev);
+	ctlb->dummy_dev = alloc_netdev_dummy(0);
+	if (!ctlb->dummy_dev)
+		return -ENOMEM;
+
 	atomic_set(&ctlb->napi_usr_refcnt, 0);
 	ctlb->is_napi_en = false;
 
 	for (i = 0; i < RXQ_NUM; i++) {
 		ctlb->napi[i] = &ctlb->hif_ctrl->rxq[i].napi;
-		netif_napi_add_weight(&ctlb->dummy_dev, ctlb->napi[i], t7xx_dpmaif_napi_rx_poll,
+		netif_napi_add_weight(ctlb->dummy_dev, ctlb->napi[i], t7xx_dpmaif_napi_rx_poll,
 				      NIC_NAPI_POLL_BUDGET);
 	}
+
+	return 0;
 }
 
 static void t7xx_uninit_netdev_napi(struct t7xx_ccmni_ctrl *ctlb)
@@ -279,6 +284,7 @@ static void t7xx_uninit_netdev_napi(struct t7xx_ccmni_ctrl *ctlb)
 		netif_napi_del(ctlb->napi[i]);
 		ctlb->napi[i] = NULL;
 	}
+	free_netdev(ctlb->dummy_dev);
 }
 
 static int t7xx_ccmni_wwan_newlink(void *ctxt, struct net_device *dev, u32 if_id,
@@ -480,6 +486,7 @@ int t7xx_ccmni_init(struct t7xx_pci_dev *t7xx_dev)
 {
 	struct device *dev = &t7xx_dev->pdev->dev;
 	struct t7xx_ccmni_ctrl *ctlb;
+	int ret;
 
 	ctlb = devm_kzalloc(dev, sizeof(*ctlb), GFP_KERNEL);
 	if (!ctlb)
@@ -495,7 +502,12 @@ int t7xx_ccmni_init(struct t7xx_pci_dev *t7xx_dev)
 	if (!ctlb->hif_ctrl)
 		return -ENOMEM;
 
-	t7xx_init_netdev_napi(ctlb);
+	ret = t7xx_init_netdev_napi(ctlb);
+	if (ret) {
+		t7xx_dpmaif_hif_exit(ctlb->hif_ctrl);
+		return ret;
+	}
+
 	init_md_status_notifier(t7xx_dev);
 	return 0;
 }
diff --git a/drivers/net/wwan/t7xx/t7xx_netdev.h b/drivers/net/wwan/t7xx/t7xx_netdev.h
index f5ed6f99a145..b18312f49844 100644
--- a/drivers/net/wwan/t7xx/t7xx_netdev.h
+++ b/drivers/net/wwan/t7xx/t7xx_netdev.h
@@ -48,7 +48,7 @@ struct t7xx_ccmni_ctrl {
 	unsigned int			md_sta;
 	struct t7xx_fsm_notifier	md_status_notify;
 	bool				wwan_is_registered;
-	struct net_device		dummy_dev;
+	struct net_device		*dummy_dev;
 	struct napi_struct		*napi[RXQ_NUM];
 	atomic_t			napi_usr_refcnt;
 	bool				is_napi_en;
-- 
2.43.0


