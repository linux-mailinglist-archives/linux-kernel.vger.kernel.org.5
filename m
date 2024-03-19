Return-Path: <linux-kernel+bounces-107912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABE888036E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD511F23232
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DB7381C2;
	Tue, 19 Mar 2024 17:26:54 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1CB374C2;
	Tue, 19 Mar 2024 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869214; cv=none; b=QTyG8TryBsnrZ2E6WyD8fzux1NpCSjiS8YGbtu3NAcAZsyV6IWABPO5sSh7fotksmYzDkH1O1++/SNoNN5ItzTQYStZ/gY4JKQQL93CRKsuMH3FwyBBNfutSruubIC7gwAQ2WyMOEF+iK8WLRACedv3j4yRUki5piq4YPFoS9kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869214; c=relaxed/simple;
	bh=eU+P2/MBs13nPLBXxxwA/HXUg83uLjebvsfj9Z0uxdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EsZvhL2jXhdRKY3S1umykL08YNxi6RDoI5LmhdaB4S5bsuE98fmvFyCZCfQMnc6GWCgQa3Omhgizn+cz9DAQhRXYznxevu0l9cTQd54LKOHiaRdSNlJTSWyUKO95HoP22RSHhA+8VHxMKPkcmd+usGwtnDfRE3YkAhNzSMTCefY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56a0c0a7ebcso3159186a12.1;
        Tue, 19 Mar 2024 10:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710869210; x=1711474010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nj6gp724uOW1KD+nqa2YBsagOiwdMbhIpU0FKvAx1ns=;
        b=nQJ4iiSLXTJayno7rrFpdhYqHenWmQZa9iIVj3bs/PaQPEWITWdBBOSciAp0QK4Jmh
         TXxkpv7F4NwUfzRkA5AFEIGhAnG7rZ0Go/mYSbPJWhDcNhX2TXcyHTd+rB7/yQmFx3II
         IGXiMHf39TmxabyC192jnR6DOvT4p76q/PX9hdQDG2V/ctNu0ph4GjjBeMFkc2AUQOPl
         Gzt5Ri8nKcczeFX1+XS7dL+9LgJ+ajKcVVS2JmDkyGJIslq8iO2x4VGyuZTkL3L+NDuo
         4K6cHcXHVuvR6XQlEjECwdeL2n6b2m6f90l+ceSxqjCzj/Ek92oA1BKxZNQPHcgFQD31
         bi/g==
X-Forwarded-Encrypted: i=1; AJvYcCVlU5aIXJbRQwa7EqM4xJuVl8JfOUUv/Bw5vm5BY+K9XCRVolsEq9urqlelsraUFJp+zX5enjzwweZETvfpIcUfw9bDn10nIa1lAEXwXIybt80XvqPS5cGhq39jaMLIJhRp3f6j83b2rOZ8acY=
X-Gm-Message-State: AOJu0YzAOiEnl9B2z7gWcATnBcR7DwgZJki6TqM1BNZ/0eOaSu5VpDK2
	hW8itRUtRYuSU4Sv9SrIA3SgLIZC+TISXFJzu6pM2NdjV1TCBOGK
X-Google-Smtp-Source: AGHT+IGqPYzi15ZClAe7ZRvWRK4D8R06KTDHnSa4SAjBsmYlJhc8mVkjl3dB57nGoQKb81uTgBRkNA==
X-Received: by 2002:a17:906:a88c:b0:a46:adab:dd75 with SMTP id ha12-20020a170906a88c00b00a46adabdd75mr6086510ejb.11.1710869210439;
        Tue, 19 Mar 2024 10:26:50 -0700 (PDT)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id di9-20020a170906730900b00a462e166b9bsm6263067ejc.112.2024.03.19.10.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:26:49 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: kuba@kernel.org,
	keescook@chromium.org,
	linux-wireless@vger.kernel.org (open list:QUANTENNA QTNFMAC WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] wifi: qtnfmac: allocate dummy net_device dynamically
Date: Tue, 19 Mar 2024 10:26:19 -0700
Message-ID: <20240319172634.894327-1-leitao@debian.org>
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

Un-embed the net_device from struct qtnf_bus by converting it
into a pointer. Then use the leverage alloc_netdev() to allocate the
net_device object at qtnf_pcie_probe(). The free of the device occurs at
qtnf_pcie_remove().

[1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wireless/quantenna/qtnfmac/bus.h        |  2 +-
 drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c  | 13 +++++++++++--
 .../wireless/quantenna/qtnfmac/pcie/pearl_pcie.c    |  6 +++---
 .../wireless/quantenna/qtnfmac/pcie/topaz_pcie.c    |  6 +++---
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/bus.h b/drivers/net/wireless/quantenna/qtnfmac/bus.h
index 3334c45aac13..7f8646e77ee0 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/bus.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/bus.h
@@ -59,7 +59,7 @@ struct qtnf_bus {
 	struct qtnf_qlink_transport trans;
 	struct qtnf_hw_info hw_info;
 	struct napi_struct mux_napi;
-	struct net_device mux_dev;
+	struct net_device *mux_dev;
 	struct workqueue_struct *workqueue;
 	struct workqueue_struct *hprio_workqueue;
 	struct work_struct fw_work;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
index 9ad4c120fa28..f8f55db2f454 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
@@ -372,7 +372,13 @@ static int qtnf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto error;
 	}
 
-	init_dummy_netdev(&bus->mux_dev);
+	bus->mux_dev = alloc_netdev(0, "dummy", NET_NAME_UNKNOWN,
+				    init_dummy_netdev);
+	if (!bus->mux_dev) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
 	qtnf_pcie_init_irq(pcie_priv, use_msi);
 	pcie_priv->sysctl_bar = sysctl_bar;
 	pcie_priv->dmareg_bar = dmareg_bar;
@@ -381,11 +387,13 @@ static int qtnf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	ret = pcie_priv->probe_cb(bus, tx_bd_size_param, rx_bd_size_param);
 	if (ret)
-		goto error;
+		goto error_free;
 
 	qtnf_pcie_bringup_fw_async(bus);
 	return 0;
 
+error_free:
+	free_netdev(bus->mux_dev);
 error:
 	destroy_workqueue(pcie_priv->workqueue);
 	pci_set_drvdata(pdev, NULL);
@@ -417,6 +425,7 @@ static void qtnf_pcie_remove(struct pci_dev *dev)
 	netif_napi_del(&bus->mux_napi);
 	destroy_workqueue(priv->workqueue);
 	tasklet_kill(&priv->reclaim_tq);
+	free_netdev(bus->mux_dev);
 
 	qtnf_pcie_free_shm_ipc(priv);
 	qtnf_debugfs_remove(bus);
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c b/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
index 8c23a77d1671..c1a53e1ba3be 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
@@ -761,12 +761,12 @@ static int qtnf_pcie_pearl_rx_poll(struct napi_struct *napi, int budget)
 				napi_gro_receive(napi, skb);
 			} else {
 				pr_debug("drop untagged skb\n");
-				bus->mux_dev.stats.rx_dropped++;
+				bus->mux_dev->stats.rx_dropped++;
 				dev_kfree_skb_any(skb);
 			}
 		} else {
 			if (skb) {
-				bus->mux_dev.stats.rx_dropped++;
+				bus->mux_dev->stats.rx_dropped++;
 				dev_kfree_skb_any(skb);
 			}
 		}
@@ -1146,7 +1146,7 @@ static int qtnf_pcie_pearl_probe(struct qtnf_bus *bus, unsigned int tx_bd_size,
 	}
 
 	tasklet_setup(&ps->base.reclaim_tq, qtnf_pearl_reclaim_tasklet_fn);
-	netif_napi_add_weight(&bus->mux_dev, &bus->mux_napi,
+	netif_napi_add_weight(bus->mux_dev, &bus->mux_napi,
 			      qtnf_pcie_pearl_rx_poll, 10);
 
 	ipc_int.fn = qtnf_pcie_pearl_ipc_gen_ep_int;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c b/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
index d83362578374..ef5c069542d4 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
@@ -667,12 +667,12 @@ static int qtnf_topaz_rx_poll(struct napi_struct *napi, int budget)
 				netif_receive_skb(skb);
 			} else {
 				pr_debug("drop untagged skb\n");
-				bus->mux_dev.stats.rx_dropped++;
+				bus->mux_dev->stats.rx_dropped++;
 				dev_kfree_skb_any(skb);
 			}
 		} else {
 			if (skb) {
-				bus->mux_dev.stats.rx_dropped++;
+				bus->mux_dev->stats.rx_dropped++;
 				dev_kfree_skb_any(skb);
 			}
 		}
@@ -1159,7 +1159,7 @@ static int qtnf_pcie_topaz_probe(struct qtnf_bus *bus,
 	}
 
 	tasklet_setup(&ts->base.reclaim_tq, qtnf_reclaim_tasklet_fn);
-	netif_napi_add_weight(&bus->mux_dev, &bus->mux_napi,
+	netif_napi_add_weight(bus->mux_dev, &bus->mux_napi,
 			      qtnf_topaz_rx_poll, 10);
 
 	ipc_int.fn = qtnf_topaz_ipc_gen_ep_int;
-- 
2.43.0


