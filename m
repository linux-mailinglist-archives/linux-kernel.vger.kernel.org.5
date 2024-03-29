Return-Path: <linux-kernel+bounces-124503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E718918FE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF0B286E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF96140370;
	Fri, 29 Mar 2024 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApMJep56"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A176A34B;
	Fri, 29 Mar 2024 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715254; cv=none; b=eykGhBsNn+UqxWTjAZSDThtW7jqh3m2UIThvNKCZ3AF0QiQh9SfIfDIlPYdeyyxFaoRzNkzqk+LcxVRYf290RbNuD8Z3mPCSMu+m1UjEbD+B+IRbOjj5JbVxw0umMYKsaA/Lo+GE8k1KaZSBNymA0W/+x3XFOv9S/6K4g5az7EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715254; c=relaxed/simple;
	bh=rfiHgtxB+G3gGz4Sw/ieS717VXReGc8gXFBYuuHJIHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYKQGEKTnblPbF0T2fhNjfHa/ByWKQqBKPIx63YtYVwYPTAp7TmdXYI6trrVV9lgOabqnpf6aopXrMF6DPYIeqBUmft47yJLFTEpvPliYtGC+B7PH4tjjZFh2UcTHxqPxi7wDKwYuRLkJHB8J19zna0ggc8V+wOqxf11urQTg9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApMJep56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A93C433F1;
	Fri, 29 Mar 2024 12:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715254;
	bh=rfiHgtxB+G3gGz4Sw/ieS717VXReGc8gXFBYuuHJIHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ApMJep56Ktav82bt8xDcO0KuyT/tTl6TZY6toy1Cm/x1H887+07mWML+GuoHWh80h
	 pJBxN7576QuPMTsYVex3B6p8FzqCL8wvtScepa4gPAZ7u9c9iMyqMvRNY114SB8LXe
	 uEy14NUTswPskYa8fsn29IVhRiebnAzeUG44yegF2sFql6CJkjtEcbGPZC1okzS1Px
	 PPI4b5eA3oeRw0MCJ6ao81PvB67yYKGmfAlsarRwc96Z9VU7mFWMAkcCgXBReHUnKK
	 2q+FzEsl9e8FZn2akoz/Rn+/suoxznraiawWEq8H2Ot4yYBHUebXHlDvWdh6K8o1Ka
	 ALCe0hOHqfVeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 22/68] wifi: iwlwifi: pcie: Add new PCI device id and CNVI
Date: Fri, 29 Mar 2024 08:25:18 -0400
Message-ID: <20240329122652.3082296-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

[ Upstream commit 5f4e0994996fa08d57711b5b247a0cb3085ec66a ]

Add the support for a new PCIE device-id 0x272E and a new CNVI
type.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240206175739.506db9b4a664.Ia2e3a77b880c449ac0e8d20b8cea25e6f07f1b81@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   | 38 +++++++++++++++++--
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  8 +++-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 15 +++++++-
 3 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 80eb9b4995389..156c428547497 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -33,6 +33,10 @@
 #define IWL_SC_A_GF_A_FW_PRE		"iwlwifi-sc-a0-gf-a0"
 #define IWL_SC_A_GF4_A_FW_PRE		"iwlwifi-sc-a0-gf4-a0"
 #define IWL_SC_A_WH_A_FW_PRE		"iwlwifi-sc-a0-wh-a0"
+#define IWL_SC2_A_FM_C_FW_PRE		"iwlwifi-sc2-a0-fm-c0"
+#define IWL_SC2_A_WH_A_FW_PRE		"iwlwifi-sc2-a0-wh-a0"
+#define IWL_SC2F_A_FM_C_FW_PRE		"iwlwifi-sc2f-a0-fm-c0"
+#define IWL_SC2F_A_WH_A_FW_PRE		"iwlwifi-sc2f-a0-wh-a0"
 
 #define IWL_SC_A_FM_B_FW_MODULE_FIRMWARE(api) \
 	IWL_SC_A_FM_B_FW_PRE "-" __stringify(api) ".ucode"
@@ -48,6 +52,14 @@
 	IWL_SC_A_GF4_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_SC_A_WH_A_FW_MODULE_FIRMWARE(api) \
 	IWL_SC_A_WH_A_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_SC2_A_FM_C_FW_MODULE_FIRMWARE(api) \
+	IWL_SC2_A_FM_C_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_SC2_A_WH_A_FW_MODULE_FIRMWARE(api) \
+	IWL_SC2_A_WH_A_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_SC2F_A_FM_C_FW_MODULE_FIRMWARE(api) \
+	IWL_SC2F_A_FM_C_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_SC2F_A_WH_A_FW_MODULE_FIRMWARE(api) \
+	IWL_SC2F_A_WH_A_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_sc_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
@@ -124,6 +136,9 @@ static const struct iwl_base_params iwl_sc_base_params = {
 
 #define IWL_DEVICE_SC							\
 	IWL_DEVICE_BZ_COMMON,						\
+	.uhb_supported = true,						\
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
+	.num_rbds = IWL_NUM_RBDS_SC_EHT,				\
 	.ht_params = &iwl_22000_ht_params
 
 /*
@@ -149,10 +164,21 @@ const char iwl_sc_name[] = "Intel(R) TBD Sc device";
 
 const struct iwl_cfg iwl_cfg_sc = {
 	.fw_name_mac = "sc",
-	.uhb_supported = true,
 	IWL_DEVICE_SC,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_SC_EHT,
+};
+
+const char iwl_sc2_name[] = "Intel(R) TBD Sc2 device";
+
+const struct iwl_cfg iwl_cfg_sc2 = {
+	.fw_name_mac = "sc2",
+	IWL_DEVICE_SC,
+};
+
+const char iwl_sc2f_name[] = "Intel(R) TBD Sc2f device";
+
+const struct iwl_cfg iwl_cfg_sc2f = {
+	.fw_name_mac = "sc2f",
+	IWL_DEVICE_SC,
 };
 
 MODULE_FIRMWARE(IWL_SC_A_FM_B_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
@@ -162,3 +188,7 @@ MODULE_FIRMWARE(IWL_SC_A_HR_B_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SC_A_GF_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SC_A_GF4_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SC_A_WH_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC2_A_FM_C_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC2_A_WH_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC2F_A_FM_C_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC2F_A_WH_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index ae6f1cd4d6605..e99d691362a86 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #ifndef __IWL_CONFIG_H__
 #define __IWL_CONFIG_H__
@@ -418,6 +418,8 @@ struct iwl_cfg {
 #define IWL_CFG_MAC_TYPE_BZ		0x46
 #define IWL_CFG_MAC_TYPE_GL		0x47
 #define IWL_CFG_MAC_TYPE_SC		0x48
+#define IWL_CFG_MAC_TYPE_SC2		0x49
+#define IWL_CFG_MAC_TYPE_SC2F		0x4A
 
 #define IWL_CFG_RF_TYPE_TH		0x105
 #define IWL_CFG_RF_TYPE_TH1		0x108
@@ -527,6 +529,8 @@ extern const char iwl_ax231_name[];
 extern const char iwl_ax411_name[];
 extern const char iwl_bz_name[];
 extern const char iwl_sc_name[];
+extern const char iwl_sc2_name[];
+extern const char iwl_sc2f_name[];
 #if IS_ENABLED(CONFIG_IWLDVM)
 extern const struct iwl_cfg iwl5300_agn_cfg;
 extern const struct iwl_cfg iwl5100_agn_cfg;
@@ -632,6 +636,8 @@ extern const struct iwl_cfg iwl_cfg_bz;
 extern const struct iwl_cfg iwl_cfg_gl;
 
 extern const struct iwl_cfg iwl_cfg_sc;
+extern const struct iwl_cfg iwl_cfg_sc2;
+extern const struct iwl_cfg iwl_cfg_sc2f;
 #endif /* CONFIG_IWLMVM */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 271be64ce19ae..ba3db601ab878 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -509,6 +509,9 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 
 /* Sc devices */
 	{IWL_PCI_DEVICE(0xE440, PCI_ANY_ID, iwl_sc_trans_cfg)},
+	{IWL_PCI_DEVICE(0xE340, PCI_ANY_ID, iwl_sc_trans_cfg)},
+	{IWL_PCI_DEVICE(0xD340, PCI_ANY_ID, iwl_sc_trans_cfg)},
+	{IWL_PCI_DEVICE(0x6E70, PCI_ANY_ID, iwl_sc_trans_cfg)},
 #endif /* CONFIG_IWLMVM */
 
 	{0}
@@ -1116,6 +1119,16 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc, iwl_sc_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SC2, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_sc2, iwl_sc2_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SC2F, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_sc2f, iwl_sc2f_name),
 #endif /* CONFIG_IWLMVM */
 };
 
-- 
2.43.0


