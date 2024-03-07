Return-Path: <linux-kernel+bounces-95976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 044AE87558B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6C3286FF9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7884213173E;
	Thu,  7 Mar 2024 17:51:07 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1EA130E23;
	Thu,  7 Mar 2024 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833866; cv=none; b=XHpslKcu+3+b4kyLLeYHZl7Py3DikNHvdQIoIqOrNVHRDgU2So3CJwvgeXNRBIZf4QkOpKqYvsubQSxT8mihq9seclMFHaWAgxbT3bKVf7jc3q/AzILlFQFDL28utSaQHBjBPj8nezHqL5hS186ji+oJlfz+okTIHUzvkMjhl1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833866; c=relaxed/simple;
	bh=LrT0NGCNxkZ932L/HfzGFxMUYmyWozRwxheB5aYJdCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o15maJymv9odab9+gk5iTZIwhIVV2UNqI02CyxXb+TJrn46f6RuKIyKnNc7tun5iXWr+K9oBl+0sutRSzql6TkluilBj+AjoOyV1hnJaA33tkqDPNiguIizVu7meP0hFxwaZIcM0boQ7X1TleamIsXyMMFOYnJckVVyWuQxuz+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so1486313a12.0;
        Thu, 07 Mar 2024 09:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709833863; x=1710438663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3MIfGO3k7f6zIfDg/I6OeKxvIxDh2bPbWHKtpIBemM=;
        b=TSSaT7Osyqy6syYf1g/Aq4HF6sA21gCcvytFHapndtZ6Y+v03AW/QKliVmFDzv/kBv
         JQqSaRDBDX78FKJMlsOAXF77nubzRd3+SJ+YWN3iZIWuAL5qNPOTVkzCyKzr153lAjVg
         okRtyMOYvXkYh9JW9j+PLm+sr4D3UocT4ZFIo/L9+g6kLQ9Jvg0HQ4uo9Pk562DrGdyH
         11cSsP+1ZllMU8IAWnn1fVfsEej+YBt7fLJZ71aqn8Qvh/hHxu+1aOy+FldHIbbur/OO
         wyxJNyxxULZHMqAIzayknj0CT2s2lyfohJw5yRFo2E508o0eUHNl0Eq97sThmV0aJ5Nf
         GWKA==
X-Forwarded-Encrypted: i=1; AJvYcCWNu4temoYKwY67DR12KcPcCJl5cMOnKnZJOqU7M5S90Ib2k3MWUxxWGa1ANfdopMu0WblAkLXSBXQc2hHLd6GnKwQmnJ+Bcezd6PnA
X-Gm-Message-State: AOJu0Yww/QXZF+DL0KcJ5Drb3gXMNrbhNZUFAfGCwZBtR5+z2fNxk7fj
	jcfvgGvn8KCuztB1BPxG8wprW5go374leucs1SPyBpWdRFWE5uDFFH6JUKk5
X-Google-Smtp-Source: AGHT+IGE7COA8LXHVdLL1oQMQdLJNzQLRVSrWgARCGiG2GDbuK/vK1S4PhIbtrctYJhuaa4usFoVsg==
X-Received: by 2002:a50:8e56:0:b0:568:2149:329a with SMTP id 22-20020a508e56000000b005682149329amr355169edx.19.1709833862825;
        Thu, 07 Mar 2024 09:51:02 -0800 (PST)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id d8-20020a50fe88000000b005673e29cc0fsm5116984edt.54.2024.03.07.09.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 09:51:02 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: linux-wireless@vger.kernel.org,
	johannes.berg@intel.com,
	gregory.greenman@intel.com,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: kuba@kernel.org,
	keescook@chromium.org,
	Alon Giladi <alon.giladi@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] wifi: iwlwifi: pcie: allocate dummy net_device dynamically
Date: Thu,  7 Mar 2024 09:48:31 -0800
Message-ID: <20240307174843.1719130-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct net_device shouldn't be embedded into any structure, instead,
the owner should use the priv space to embed their state into net_device.

Embedding net_device into structures prohibits the usage of flexible
arrays in the net_device structure. For more details, see the discussion
at [1].

Un-embed the net_device from struct iwl_trans_pcie by converting it
into a pointer. Then use the leverage alloc_netdev() to allocate the
net_device object at iwl_trans_pcie_alloc.

The private data of net_device becomes a pointer for the struct
iwl_trans_pcie, so, it is easy to get back to the iwl_trans_pcie parent
given the net_device object.

[1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../wireless/intel/iwlwifi/pcie/internal.h    |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 11 +++++--
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 29 +++++++++++++------
 3 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 7805a42948af..a7eebe400b5b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -386,7 +386,7 @@ struct iwl_trans_pcie {
 	dma_addr_t iml_dma_addr;
 	struct iwl_trans *trans;
 
-	struct net_device napi_dev;
+	struct net_device *napi_dev;
 
 	/* INT ICT Table */
 	__le32 *ict_tbl;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 9c2461ba13c5..984d7bcd381f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1000,6 +1000,11 @@ void iwl_pcie_rx_init_rxb_lists(struct iwl_rxq *rxq)
 
 static int iwl_pcie_rx_handle(struct iwl_trans *trans, int queue, int budget);
 
+static inline struct iwl_trans_pcie *iwl_netdev_to_trans_pcie(struct net_device *dev)
+{
+	return *(struct iwl_trans_pcie **)netdev_priv(dev);
+}
+
 static int iwl_pcie_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct iwl_rxq *rxq = container_of(napi, struct iwl_rxq, napi);
@@ -1007,7 +1012,7 @@ static int iwl_pcie_napi_poll(struct napi_struct *napi, int budget)
 	struct iwl_trans *trans;
 	int ret;
 
-	trans_pcie = container_of(napi->dev, struct iwl_trans_pcie, napi_dev);
+	trans_pcie = iwl_netdev_to_trans_pcie(napi->dev);
 	trans = trans_pcie->trans;
 
 	ret = iwl_pcie_rx_handle(trans, rxq->id, budget);
@@ -1034,7 +1039,7 @@ static int iwl_pcie_napi_poll_msix(struct napi_struct *napi, int budget)
 	struct iwl_trans *trans;
 	int ret;
 
-	trans_pcie = container_of(napi->dev, struct iwl_trans_pcie, napi_dev);
+	trans_pcie = iwl_netdev_to_trans_pcie(napi->dev);
 	trans = trans_pcie->trans;
 
 	ret = iwl_pcie_rx_handle(trans, rxq->id, budget);
@@ -1131,7 +1136,7 @@ static int _iwl_pcie_rx_init(struct iwl_trans *trans)
 			if (trans_pcie->msix_enabled)
 				poll = iwl_pcie_napi_poll_msix;
 
-			netif_napi_add(&trans_pcie->napi_dev, &rxq->napi,
+			netif_napi_add(trans_pcie->napi_dev, &rxq->napi,
 				       poll);
 			napi_enable(&rxq->napi);
 		}
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 6c76b2dd6878..e5af3d7dfbb1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1986,13 +1986,6 @@ static void iwl_trans_pcie_configure(struct iwl_trans *trans,
 	trans->command_groups = trans_cfg->command_groups;
 	trans->command_groups_size = trans_cfg->command_groups_size;
 
-	/* Initialize NAPI here - it should be before registering to mac80211
-	 * in the opmode but after the HW struct is allocated.
-	 * As this function may be called again in some corner cases don't
-	 * do anything if NAPI was already initialized.
-	 */
-	if (trans_pcie->napi_dev.reg_state != NETREG_DUMMY)
-		init_dummy_netdev(&trans_pcie->napi_dev);
 
 	trans_pcie->fw_reset_handshake = trans_cfg->fw_reset_handshake;
 }
@@ -2057,6 +2050,8 @@ void iwl_trans_pcie_free(struct iwl_trans *trans)
 		iwl_pcie_tx_free(trans);
 	iwl_pcie_rx_free(trans);
 
+	free_netdev(trans_pcie->napi_dev);
+
 	if (trans_pcie->rba.alloc_wq) {
 		destroy_workqueue(trans_pcie->rba.alloc_wq);
 		trans_pcie->rba.alloc_wq = NULL;
@@ -3594,7 +3589,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 			       const struct pci_device_id *ent,
 			       const struct iwl_cfg_trans_params *cfg_trans)
 {
-	struct iwl_trans_pcie *trans_pcie;
+	struct iwl_trans_pcie *trans_pcie, **priv;
 	struct iwl_trans *trans;
 	int ret, addr_size;
 	const struct iwl_trans_ops *ops = &trans_ops_pcie_gen2;
@@ -3623,6 +3618,20 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
+	/* Initialize NAPI here - it should be before registering to mac80211
+	 * in the opmode but after the HW struct is allocated.
+	 */
+	trans_pcie->napi_dev = alloc_netdev(sizeof(struct iwl_trans_pcie *),
+					    "dummy", NET_NAME_UNKNOWN,
+					    init_dummy_netdev);
+	if (!trans_pcie->napi_dev) {
+		ret = -ENOMEM;
+		goto out_free_trans;
+	}
+	/* The private struct in netdev is a pointer to struct iwl_trans_pcie */
+	priv = netdev_priv(trans_pcie->napi_dev);
+	*priv = trans_pcie;
+
 	trans_pcie->trans = trans;
 	trans_pcie->opmode_down = true;
 	spin_lock_init(&trans_pcie->irq_lock);
@@ -3637,7 +3646,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 						   WQ_HIGHPRI | WQ_UNBOUND, 0);
 	if (!trans_pcie->rba.alloc_wq) {
 		ret = -ENOMEM;
-		goto out_free_trans;
+		goto out_free_ndev;
 	}
 	INIT_WORK(&trans_pcie->rba.rx_alloc, iwl_pcie_rx_allocator_work);
 
@@ -3757,6 +3766,8 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	iwl_pcie_free_ict(trans);
 out_no_pci:
 	destroy_workqueue(trans_pcie->rba.alloc_wq);
+out_free_ndev:
+	free_netdev(trans_pcie->napi_dev);
 out_free_trans:
 	iwl_trans_free(trans);
 	return ERR_PTR(ret);
-- 
2.43.0


