Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D95E7B47AA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjJANop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjJANon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:44:43 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946B7FF
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:44:39 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ae3d7eb7e0so470698566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 06:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696167878; x=1696772678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WnFupUzVDS+wn/0FKIaw6slFldhEhqkX6Yuz2KNShag=;
        b=nsbgPsF+tnQuZDonWqGUCc45SddVkPpLbrjTFCwHo9VlnedYGKxFE0f87dnda1gZt3
         kGD76R9dqzer/616XzrAkXJfkTyTKfeOT6DC2w0iswV943uE+QLhXgJ2B+g6ZsEp6r9V
         3LgumzZT9XrUWdJ/lYmxI8Z2jGG3L7YnIEh65NAL/jCx8kzAsLKXyqIcFXLdw41ppiLi
         +icuM8Pu43XrCBtaKbOd0lHJTmS0KlqjzVQ7vt7ZqnD9a1uf+nzoV5TFgeZ5v4gkUkEv
         9D2LhN7ex4/CYIcXRwiyrLQgmL5dX5n5wpxmpaE+el2bJ/ZUE4eVVaRn7mO2Tx0kstak
         OmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696167878; x=1696772678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnFupUzVDS+wn/0FKIaw6slFldhEhqkX6Yuz2KNShag=;
        b=LcYb+2V8/lOxnhGAFzZYM0Vpud9hbZrVezzQ0hlL657n/0S2+YaGeGwTaJ3x+fkvbe
         LOXUPO8pIwTWRHYFR2dnZFuosPAahTGIPR2XZQ+n7PhgHzILCP/h+MiwMRKWEA87VDTj
         TGutFAE/fPFYpvPPa/VXVpX4VkPxVZtDJ6PcwlOt0D9taj8Hl3A54uuZvKruQBkm92nl
         eP+MIUfkpuwQvsXHV6J7MCDsjJTdEhGHOi5npNum+oPC7Ov4bkX5MbmnlsKFOLtmNx9Z
         mr6mFC8Y9TJuwFU+dQ+LocwTNgEDgSGZ4WlC8sSVNYlukV2AC0wlcMiR2ss4ZFsVidhE
         Eqsg==
X-Gm-Message-State: AOJu0YziBOQ3ANOc9QJG5wtXKus8HFMihYtpry1h7R3KGspkAmh1MmDG
        SqaHI4o5EahU1o0Gw7K7uCX4AX2OmT0=
X-Google-Smtp-Source: AGHT+IF2Zn4LT8sIx4V5cckExXaMAfCxsOzA/hk5qwE+A6GcFHq5VkMNGt4yIVr18tFuVsBkh84tdw==
X-Received: by 2002:a17:906:2ce:b0:9ae:3f76:1091 with SMTP id 14-20020a17090602ce00b009ae3f761091mr6843417ejk.0.1696167877810;
        Sun, 01 Oct 2023 06:44:37 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id bv13-20020a170906b1cd00b00993a37aebc5sm15451246ejb.50.2023.10.01.06.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 06:44:37 -0700 (PDT)
Date:   Sun, 1 Oct 2023 15:44:35 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] staging: rtl8192e: Remove unused variable rst_progress
Message-ID: <21f4ab4eff53cce0debcd113c2dc1718dc713aeb.1696165351.git.philipp.g.hortmann@gmail.com>
References: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

priv->rst_progress is set to RESET_TYPE_NORESET and never changed. All
equations are true. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 100 ++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |   1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |   1 -
 3 files changed, 47 insertions(+), 55 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 9ffa9305ff5e..6cfc2254487b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -485,10 +485,10 @@ bool rtl92e_start_adapter(struct net_device *dev)
 start:
 	rtl92e_reset_desc_ring(dev);
 	priv->rf_mode = RF_OP_By_SW_3wire;
-	if (priv->rst_progress == RESET_TYPE_NORESET) {
-		rtl92e_writeb(dev, ANAPAR, 0x37);
-		mdelay(500);
-	}
+
+	rtl92e_writeb(dev, ANAPAR, 0x37);
+	mdelay(500);
+
 	priv->fw_info->status = FW_STATUS_0_INIT;
 
 	ulRegRead = rtl92e_readl(dev, CPU_GEN);
@@ -518,21 +518,20 @@ bool rtl92e_start_adapter(struct net_device *dev)
 	}
 
 	priv->loopback_mode = RTL819X_NO_LOOPBACK;
-	if (priv->rst_progress == RESET_TYPE_NORESET) {
-		ulRegRead = rtl92e_readl(dev, CPU_GEN);
-		if (priv->loopback_mode == RTL819X_NO_LOOPBACK)
-			ulRegRead = (ulRegRead & CPU_GEN_NO_LOOPBACK_MSK) |
-				    CPU_GEN_NO_LOOPBACK_SET;
-		else if (priv->loopback_mode == RTL819X_MAC_LOOPBACK)
-			ulRegRead |= CPU_CCK_LOOPBACK;
-		else
-			netdev_err(dev, "%s: Invalid loopback mode setting.\n",
-				   __func__);
+	ulRegRead = rtl92e_readl(dev, CPU_GEN);
+	if (priv->loopback_mode == RTL819X_NO_LOOPBACK)
+		ulRegRead = (ulRegRead & CPU_GEN_NO_LOOPBACK_MSK) |
+			    CPU_GEN_NO_LOOPBACK_SET;
+	else if (priv->loopback_mode == RTL819X_MAC_LOOPBACK)
+		ulRegRead |= CPU_CCK_LOOPBACK;
+	else
+		netdev_err(dev, "%s: Invalid loopback mode setting.\n",
+			   __func__);
 
-		rtl92e_writel(dev, CPU_GEN, ulRegRead);
+	rtl92e_writel(dev, CPU_GEN, ulRegRead);
+
+	udelay(500);
 
-		udelay(500);
-	}
 	_rtl92e_hwconfig(dev);
 	rtl92e_writeb(dev, CMDR, CR_RE | CR_TE);
 
@@ -567,8 +566,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 
 	rtl92e_writeb(dev, ACK_TIMEOUT, 0x30);
 
-	if (priv->rst_progress == RESET_TYPE_NORESET)
-		rtl92e_set_wireless_mode(dev, priv->rtllib->mode);
+	rtl92e_set_wireless_mode(dev, priv->rtllib->mode);
 	rtl92e_cam_reset(dev);
 	{
 		u8 SECR_value = 0x0;
@@ -607,12 +605,10 @@ bool rtl92e_start_adapter(struct net_device *dev)
 		}
 	}
 
-	if (priv->rst_progress == RESET_TYPE_NORESET) {
-		rtStatus = rtl92e_config_rf(dev);
-		if (!rtStatus) {
-			netdev_info(dev, "RF Config failed\n");
-			return rtStatus;
-		}
+	rtStatus = rtl92e_config_rf(dev);
+	if (!rtStatus) {
+		netdev_info(dev, "RF Config failed\n");
+		return rtStatus;
 	}
 
 	rtl92e_set_bb_reg(dev, rFPGA0_RFMOD, bCCKEn, 0x1);
@@ -634,39 +630,37 @@ bool rtl92e_start_adapter(struct net_device *dev)
 	else
 		priv->rf_mode = RF_OP_By_SW_3wire;
 
-	if (priv->rst_progress == RESET_TYPE_NORESET) {
-		rtl92e_dm_init_txpower_tracking(dev);
-
-		if (priv->ic_cut >= IC_VersionCut_D) {
-			tmpRegA = rtl92e_get_bb_reg(dev, rOFDM0_XATxIQImbalance,
-						    bMaskDWord);
-			rtl92e_get_bb_reg(dev, rOFDM0_XCTxIQImbalance, bMaskDWord);
-
-			for (i = 0; i < TX_BB_GAIN_TABLE_LEN; i++) {
-				if (tmpRegA == dm_tx_bb_gain[i]) {
-					priv->rfa_txpowertrackingindex = i;
-					priv->rfa_txpowertrackingindex_real = i;
-					priv->rfa_txpowertracking_default =
-						 priv->rfa_txpowertrackingindex;
-					break;
-				}
+	rtl92e_dm_init_txpower_tracking(dev);
+
+	if (priv->ic_cut >= IC_VersionCut_D) {
+		tmpRegA = rtl92e_get_bb_reg(dev, rOFDM0_XATxIQImbalance,
+					    bMaskDWord);
+		rtl92e_get_bb_reg(dev, rOFDM0_XCTxIQImbalance, bMaskDWord);
+
+		for (i = 0; i < TX_BB_GAIN_TABLE_LEN; i++) {
+			if (tmpRegA == dm_tx_bb_gain[i]) {
+				priv->rfa_txpowertrackingindex = i;
+				priv->rfa_txpowertrackingindex_real = i;
+				priv->rfa_txpowertracking_default =
+					 priv->rfa_txpowertrackingindex;
+				break;
 			}
+		}
 
-			TempCCk = rtl92e_get_bb_reg(dev, rCCK0_TxFilter1,
-						    bMaskByte2);
+		TempCCk = rtl92e_get_bb_reg(dev, rCCK0_TxFilter1,
+					    bMaskByte2);
 
-			for (i = 0; i < CCK_TX_BB_GAIN_TABLE_LEN; i++) {
-				if (TempCCk == dm_cck_tx_bb_gain[i][0]) {
-					priv->cck_present_attn_20m_def = i;
-					break;
-				}
+		for (i = 0; i < CCK_TX_BB_GAIN_TABLE_LEN; i++) {
+			if (TempCCk == dm_cck_tx_bb_gain[i][0]) {
+				priv->cck_present_attn_20m_def = i;
+				break;
 			}
-			priv->cck_present_attn_40m_def = 0;
-			priv->cck_present_attn_diff = 0;
-			priv->cck_present_attn =
-				  priv->cck_present_attn_20m_def;
-			priv->btxpower_tracking = false;
 		}
+		priv->cck_present_attn_40m_def = 0;
+		priv->cck_present_attn_diff = 0;
+		priv->cck_present_attn =
+			  priv->cck_present_attn_20m_def;
+		priv->btxpower_tracking = false;
 	}
 	rtl92e_irq_enable(dev);
 end:
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 43533410f8d6..7ca6a04d034c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -754,7 +754,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->rfa_txpowertrackingindex = 0;
 	priv->rfc_txpowertrackingindex = 0;
 	priv->cck_pwr_enl = 6;
-	priv->rst_progress = RESET_TYPE_NORESET;
 	priv->force_reset = false;
 	memset(priv->rtllib->swcamtable, 0, sizeof(struct sw_cam_table) * 32);
 	priv->rx_ctr = 0;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index d6e924fc8011..855bee78c674 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -370,7 +370,6 @@ struct r8192_priv {
 	u8		framesync;
 	u32		reset_count;
 
-	enum reset_type rst_progress;
 	u16		tx_counter;
 	u16		rx_ctr;
 	bool		reset_in_progress;
-- 
2.42.0

