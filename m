Return-Path: <linux-kernel+bounces-165614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7E28B8E9C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518B41C2272B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5A41B947;
	Wed,  1 May 2024 16:56:08 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49591168BD;
	Wed,  1 May 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582568; cv=none; b=lRnzSlGEXzYFBXUAVarqV2yhRApp3CktdYSxASDIYXfDtRYBvDhFk82DgIWpH9CCPffJYAEIzBqrq4WbcHgOa205kXidW763v/Tq9myyp4nAHS+L5uAZaLYiwWHBzylUN2XVYvEpLmesnSB0OkOsE+xAq1CFgPr8HIaPhlwdi3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582568; c=relaxed/simple;
	bh=TcDzC1URqfIGLzJLPDLTzwckLUr9NbwS3Ma6ukNQrZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kIEIG7G4vgMk0xr7k30lt2IoqX7+m+xFgDOApSRuxPvEeKe2/MZ3J3uyfSkd8iA9zaJOUn0D8uMaPtGyUGKQ6PHbNBlopbj8vw1Rg18Cxo8PsLVPk8F794WUI2dhp0ajh09biTKUlgKx83P/HxIit+5aEiItCdXkv7dKNcPuD+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso8981039a12.2;
        Wed, 01 May 2024 09:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714582564; x=1715187364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZyGPQjH8Nh0r2HrUHxBLid/Ouu1r0VmzmfrZnEPyNs=;
        b=R8o6HvZCcCP2SyIJF4k6fpRr1tlsoP+AhXrIeupjmRFZbnOx7tZqQtNWME6TXoTEsg
         6MS5wnaJfJbMsEFg/X2pQVwvwPGXjSsptHWXDq7cGxtuPV4kvtU+7l6zRGMLT1Ny7lQu
         1wBkjJyQNq9YkjA45vUoG4aPd5z0FHAeSjQMTFfTuMGaFhYsFx033KJhWjrdaRVwWbyy
         cz4FTz4ckHEBjxQTwjy39U1YdSjwb91ESB50c3xq7Vb9qWDD6c7qakp7bO2zePvPq9zo
         peNyuQOlHv9z6oIcFvCvn/Csrlx93X8pXp8LGyOBfGRl3okFQH92eovrXDqmj9lKypPF
         LFlg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ/c6EP+1kPDhotGI+1t/7fKAqi3pu88Q5SxrFyD+kMq51G82PV4BCTvcevVm7c2dzIrGcvJawDQvbVpOyR5o5Da7/rYrWJNicwA9F5dT66vxEQ5FNILn/VasLn/VIwv8kT+T8gRIZmviHgsg=
X-Gm-Message-State: AOJu0YytyKgzXDngrZpJRTTlWjx/nJ8P83OZfzzq0PBzXubTt4jaRhEq
	9qCZVw70B3KP/m3oeB+jgiNy8xGj77PImYpCYs+D3pcVnNa4dTzn
X-Google-Smtp-Source: AGHT+IFiNeAXFLvqrJqj/JpJnaQ1VuTj5HIQczid62EJDQa/xpeqnynka7fbVfl2mZvp0wxYEEevxA==
X-Received: by 2002:a50:8adb:0:b0:572:42ac:9b19 with SMTP id k27-20020a508adb000000b0057242ac9b19mr2532186edk.0.1714582564313;
        Wed, 01 May 2024 09:56:04 -0700 (PDT)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 15-20020a508e0f000000b005726e5e8765sm5205429edw.3.2024.05.01.09.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:56:03 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Alon Giladi <alon.giladi@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Avraham Stern <avraham.stern@intel.com>,
	linux-wireless@vger.kernel.org (open list:INTEL WIRELESS WIFI LINK (iwlwifi)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless-next v2] wifi: iwlwifi: pcie: allocate dummy net_device dynamically
Date: Wed,  1 May 2024 09:54:04 -0700
Message-ID: <20240501165417.3406039-1-leitao@debian.org>
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

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changelog:

v2:
 * replaced the alloc_netdev() with the proper dummy allocator
   alloc_netdev_dummy().

v1:
 * https://lore.kernel.org/all/20240307174843.1719130-1-leitao@debian.org/

---
 .../wireless/intel/iwlwifi/pcie/internal.h    |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 11 +++++---
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 27 ++++++++++++-------
 3 files changed, 27 insertions(+), 13 deletions(-)


PS: This is compiled-tested only due to lack of hardware.

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
index 6c76b2dd6878..d5a887b3a4bb 100644
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
@@ -2074,6 +2067,8 @@ void iwl_trans_pcie_free(struct iwl_trans *trans)
 		iwl_pcie_free_ict(trans);
 	}
 
+	free_netdev(trans_pcie->napi_dev);
+
 	iwl_pcie_free_invalid_tx_cmd(trans);
 
 	iwl_pcie_free_fw_monitor(trans);
@@ -3594,7 +3589,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 			       const struct pci_device_id *ent,
 			       const struct iwl_cfg_trans_params *cfg_trans)
 {
-	struct iwl_trans_pcie *trans_pcie;
+	struct iwl_trans_pcie *trans_pcie, **priv;
 	struct iwl_trans *trans;
 	int ret, addr_size;
 	const struct iwl_trans_ops *ops = &trans_ops_pcie_gen2;
@@ -3623,6 +3618,18 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
+	/* Initialize NAPI here - it should be before registering to mac80211
+	 * in the opmode but after the HW struct is allocated.
+	 */
+	trans_pcie->napi_dev = alloc_netdev_dummy(sizeof(struct iwl_trans_pcie *));
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
@@ -3637,7 +3644,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 						   WQ_HIGHPRI | WQ_UNBOUND, 0);
 	if (!trans_pcie->rba.alloc_wq) {
 		ret = -ENOMEM;
-		goto out_free_trans;
+		goto out_free_ndev;
 	}
 	INIT_WORK(&trans_pcie->rba.rx_alloc, iwl_pcie_rx_allocator_work);
 
@@ -3757,6 +3764,8 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
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


