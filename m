Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A077EE658
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345384AbjKPSFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKPSFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:05:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D18DAD;
        Thu, 16 Nov 2023 10:05:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813E2C433C8;
        Thu, 16 Nov 2023 18:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700157932;
        bh=BlH5ZmczaE3SUGZRI1eqsoVeJUUFt90pPqJagygBik8=;
        h=From:To:Cc:Subject:Date:From;
        b=jWxPBxjVjBk4q1WPFJ9KTMH6Rf8YbGwDaE7pcJIdiewrEWuWmE3gf6BIrd9AJKef+
         kpuy5TruY6tNhrTv4U2BlXZGrpKH+kHzl9jMYWUhlZ8VG9B+1TziSciGvHfALyInyN
         XdhXC1Ll24cnbBMJ8AGNBjCS75iCV9NwCug58zw1Jx5shaRpyAZKtYMz74D8+HaylR
         /5LG0yK9eujLWKE3ig4kMrxD86Vh9w5VB711pocUQOQZ7bjM65HBB27yT93FHq9M7L
         S8mrfuLOYqWHWhHa64NOxMrGm5mMa3rlTB3ZFq1ml4C7v6xqbzgJn/OtUMJxPH/D/m
         97C2w87XhlvxQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, Jian-Hong Pan <jhp@endlessos.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Bither <jonbither@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] wifi: rtlwifi: drop unused const_amdpci_aspm
Date:   Thu, 16 Nov 2023 12:05:29 -0600
Message-Id: <20231116180529.52752-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Remove the unused "const_amdpci_aspm" member of struct rtl_pci and
struct rtl_ps_ctl.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c          | 1 -
 drivers/net/wireless/realtek/rtlwifi/pci.h          | 1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c | 3 ---
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c | 3 ---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c | 3 ---
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c | 3 ---
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c | 3 ---
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c | 3 ---
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c | 3 ---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c | 3 ---
 drivers/net/wireless/realtek/rtlwifi/wifi.h         | 2 --
 11 files changed, 28 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 9886e719739b..b163a069660b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -70,7 +70,6 @@ static void _rtl_pci_update_default_setting(struct ieee80211_hw *hw)
 	ppsc->support_aspm = false;
 
 	/*Update PCI ASPM setting */
-	ppsc->const_amdpci_aspm = rtlpci->const_amdpci_aspm;
 	switch (rtlpci->const_pci_aspm) {
 	case 0:
 		/*No ASPM */
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.h b/drivers/net/wireless/realtek/rtlwifi/pci.h
index 866861626a0a..4725d43609fd 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.h
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.h
@@ -195,7 +195,6 @@ struct rtl_pci {
 	u32 reg_bcn_ctrl_val;
 
 	 /*ASPM*/ u8 const_pci_aspm;
-	u8 const_amdpci_aspm;
 	u8 const_hwsw_rfoff_d3;
 	u8 const_support_pciaspm;
 	/*pci-e bridge */
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c
index b77937fe2448..37bb59fa8bfa 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c
@@ -21,9 +21,6 @@ static void rtl88e_init_aspm_vars(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	/*close ASPM for AMD defaultly */
-	rtlpci->const_amdpci_aspm = 0;
-
 	/* ASPM PS mode.
 	 * 0 - Disable ASPM,
 	 * 1 - Enable ASPM without Clock Req,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c
index e452275d8789..e20f2bec45c4 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c
@@ -24,9 +24,6 @@ static void rtl92c_init_aspm_vars(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	/*close ASPM for AMD defaultly */
-	rtlpci->const_amdpci_aspm = 0;
-
 	/*
 	 * ASPM PS mode.
 	 * 0 - Disable ASPM,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c
index 11f319c97124..afd685ed460a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c
@@ -21,9 +21,6 @@ static void rtl92d_init_aspm_vars(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	/*close ASPM for AMD defaultly */
-	rtlpci->const_amdpci_aspm = 0;
-
 	/*
 	 * ASPM PS mode.
 	 * 0 - Disable ASPM,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c
index 011ce82efeff..7bde20fdbeab 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c
@@ -24,9 +24,6 @@ static void rtl92ee_init_aspm_vars(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	/*close ASPM for AMD defaultly */
-	rtlpci->const_amdpci_aspm = 0;
-
 	/**
 	 * ASPM PS mode.
 	 * 0 - Disable ASPM,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
index 30bce381c3bb..675bdd32feb1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
@@ -21,9 +21,6 @@ static void rtl92s_init_aspm_vars(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	/*close ASPM for AMD defaultly */
-	rtlpci->const_amdpci_aspm = 0;
-
 	/* ASPM PS mode.
 	 * 0 - Disable ASPM,
 	 * 1 - Enable ASPM without Clock Req,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c
index c821436a1991..dd7505e2f22c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c
@@ -26,9 +26,6 @@ static void rtl8723e_init_aspm_vars(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	/*close ASPM for AMD defaultly */
-	rtlpci->const_amdpci_aspm = 0;
-
 	/**
 	 * ASPM PS mode.
 	 * 0 - Disable ASPM,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
index 43b611d5288d..162c34f0e9b7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
@@ -26,9 +26,6 @@ static void rtl8723be_init_aspm_vars(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	/*close ASPM for AMD defaultly */
-	rtlpci->const_amdpci_aspm = 0;
-
 	/* ASPM PS mode.
 	 * 0 - Disable ASPM,
 	 * 1 - Enable ASPM without Clock Req,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c
index 0bca542e103f..7b911695db33 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c
@@ -23,9 +23,6 @@ static void rtl8821ae_init_aspm_vars(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	/*close ASPM for AMD defaultly */
-	rtlpci->const_amdpci_aspm = 0;
-
 	/**
 	 * ASPM PS mode.
 	 * 0 - Disable ASPM,
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 31a481f43a07..1b6824d06210 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2023,8 +2023,6 @@ struct rtl_ps_ctl {
 	u32 cur_ps_level;
 	u32 reg_rfps_level;
 
-	/*just for PCIE ASPM */
-	u8 const_amdpci_aspm;
 	bool pwrdown_mode;
 
 	enum rf_pwrstate inactive_pwrstate;
-- 
2.34.1

