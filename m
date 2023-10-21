Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D637D1D1A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 14:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjJUMU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 08:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUMUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 08:20:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9E6E9
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 05:20:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53ebf429b4fso2538917a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697890820; x=1698495620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jztvdmnKoOtDyJYeFAxJUdIntr9a0/M0DmdO1ZKQ78A=;
        b=Ds8gbkYtxLLexj0dL0oS5D1Pe+gqA90XVqe9kxMfk3gQRxleGIBfoTRXCegtavBoqJ
         5/sCA0bjkZjh5OA0IIbpk0koQQhfNpeI/spoMCbCogWNbcZJ4bx2lnt1hnILgDYph8a4
         gVKRCdwfC0JRgD9s0EdqNUpstCwwlc2PYi7em1OVU8Uvmy6GWYSVbTdmxjIg2+wItCYB
         sx/n/9v6DMC97Ly5HNOkRAdZCZsdQklbdgGkFDH1NOloa8vsj7SHt2ixO0K7IkPo4hdt
         BP7s+3n/1NzK8EYggi122oPdu3UwRmtRa6el/P6Oo62fHUQDw6qMA/rLlogP5SfEcLQF
         C22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697890820; x=1698495620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jztvdmnKoOtDyJYeFAxJUdIntr9a0/M0DmdO1ZKQ78A=;
        b=ATL+6+9gzMtFP+tvqFkc+Gn9QTuR1y3avoMiIf1fFNkz2eUiBy9Tsa4EZuow65EOfU
         uRExS8Wj8W0WtaUOCE4qBSNaNTJ88R5FqGSlCoE60GnjJMMkKw/qoHFfBVsP8V0Ebvbi
         wwZFQa/bNZvjkbi2ENqcfWbOFuiCpDHKJJCtdcLZWJVSCyYQe7ieSM8pegwgfLK7hUmP
         DuzpfJkVR8hp5/Gj0lZ4ZhwP+7ldmD+2h9hXJeWidLMTkGXoNzKfqY6BuABdrcnk5J1V
         9BvpDLGMlmxAY5ruW8/0eqvNnHUvxli01nfOEg7npUz3g5cpRGqyVmHNX261pLWQwMwV
         1d3w==
X-Gm-Message-State: AOJu0YzRNcp1lqFr6mTzrGFTSgpD6ql66vKIsjb8ddCLQPu6xptzgTs+
        whkAHkUsgthLqgagMGBFE1YJvgs1/Mg=
X-Google-Smtp-Source: AGHT+IEC/lG+OEjTX4Vx47WpGn3R4YbPATipUADElGWndBe7ClSTRN3E4GjKuH9Ft0Svnff5EVQq/A==
X-Received: by 2002:a05:6402:5243:b0:530:e2e3:28af with SMTP id t3-20020a056402524300b00530e2e328afmr3784577edd.31.1697890819904;
        Sat, 21 Oct 2023 05:20:19 -0700 (PDT)
Received: from localhost.localdomain (ip-77-25-34-72.web.vodafone.de. [77.25.34.72])
        by smtp.gmail.com with ESMTPSA id c21-20020a50d655000000b00537963f692esm3450568edj.0.2023.10.21.05.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 05:20:19 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8192e: clean up comparisons to NULL
Date:   Sat, 21 Oct 2023 14:19:47 +0200
Message-ID: <20231021121947.14516-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up comparisons to NULL to improve readability.
Reported by checkpatch.

if (x == NULL) -> if (!x)
if (x != NULL) -> if (x)

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
Compile tested only, due to missing hardware.

 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c   |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |  2 +-
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c  |  2 +-
 drivers/staging/rtl8192e/rtllib_crypt_wep.c   |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c          | 24 +++++++++----------
 drivers/staging/rtl8192e/rtllib_softmac.c     |  2 +-
 7 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index bc06c2cab35d..a5e16bf99cd6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -513,7 +513,7 @@ static u8 _rtl92e_phy_set_sw_chnl_cmd_array(struct net_device *dev,
 {
 	struct sw_chnl_cmd *pCmd;
 
-	if (CmdTable == NULL) {
+	if (!CmdTable) {
 		netdev_err(dev, "%s(): CmdTable cannot be NULL.\n", __func__);
 		return false;
 	}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
index 9b280cee0ac1..76ec4ed967c4 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
@@ -112,7 +112,7 @@ void rtl92e_set_key(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
 			rtl92e_writel(dev, WCAMI, TargetContent);
 			rtl92e_writel(dev, RWCAM, TargetCommand);
 		} else {
-			if (KeyContent != NULL) {
+			if (KeyContent) {
 				rtl92e_writel(dev, WCAMI,
 					      (u32)(*(KeyContent + i - 2)));
 				rtl92e_writel(dev, RWCAM, TargetCommand);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index ec8e7d5fe634..4371ab1239ee 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -805,7 +805,7 @@ static int _rtl92e_wx_get_gen_ie(struct net_device *dev,
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rtllib_device *ieee = priv->rtllib;
 
-	if (ieee->wpa_ie_len == 0 || ieee->wpa_ie == NULL) {
+	if (ieee->wpa_ie_len == 0 || !ieee->wpa_ie) {
 		data->data.length = 0;
 		return 0;
 	}
diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index 5621261d66b9..cbb8c8dbe9b0 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -52,7 +52,7 @@ static void *rtllib_ccmp_init(int key_idx)
 	struct rtllib_ccmp_data *priv;
 
 	priv = kzalloc(sizeof(*priv), GFP_ATOMIC);
-	if (priv == NULL)
+	if (!priv)
 		goto fail;
 	priv->key_idx = key_idx;
 
diff --git a/drivers/staging/rtl8192e/rtllib_crypt_wep.c b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
index 062285e4d939..21c2b7666d6f 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_wep.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
@@ -35,7 +35,7 @@ static void *prism2_wep_init(int keyidx)
 		return NULL;
 
 	priv = kzalloc(sizeof(*priv), GFP_ATOMIC);
-	if (priv == NULL)
+	if (!priv)
 		return NULL;
 	priv->key_idx = keyidx;
 
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 124c1651856b..ecaa4dec3f94 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -63,7 +63,7 @@ rtllib_frag_cache_find(struct rtllib_device *ieee, unsigned int seq,
 
 	for (i = 0; i < RTLLIB_FRAG_CACHE_LEN; i++) {
 		entry = &ieee->frag_cache[tid][i];
-		if (entry->skb != NULL &&
+		if (entry->skb &&
 		    time_after(jiffies, entry->first_frag_time + 2 * HZ)) {
 			netdev_dbg(ieee->dev,
 				   "expiring fragment cache entry seq=%u last_frag=%u\n",
@@ -72,7 +72,7 @@ rtllib_frag_cache_find(struct rtllib_device *ieee, unsigned int seq,
 			entry->skb = NULL;
 		}
 
-		if (entry->skb != NULL && entry->seq == seq &&
+		if (entry->skb && entry->seq == seq &&
 		    (entry->last_frag + 1 == frag || frag == -1) &&
 		    memcmp(entry->src_addr, src, ETH_ALEN) == 0 &&
 		    memcmp(entry->dst_addr, dst, ETH_ALEN) == 0)
@@ -130,7 +130,7 @@ rtllib_frag_cache_get(struct rtllib_device *ieee,
 		if (ieee->frag_next_idx[tid] >= RTLLIB_FRAG_CACHE_LEN)
 			ieee->frag_next_idx[tid] = 0;
 
-		if (entry->skb != NULL)
+		if (entry->skb)
 			dev_kfree_skb_any(entry->skb);
 
 		entry->first_frag_time = jiffies;
@@ -145,7 +145,7 @@ rtllib_frag_cache_get(struct rtllib_device *ieee,
 		 */
 		entry = rtllib_frag_cache_find(ieee, seq, frag, tid, hdr->addr2,
 						  hdr->addr1);
-		if (entry != NULL) {
+		if (entry) {
 			entry->last_frag = frag;
 			skb = entry->skb;
 		}
@@ -184,7 +184,7 @@ static int rtllib_frag_cache_invalidate(struct rtllib_device *ieee,
 	entry = rtllib_frag_cache_find(ieee, seq, -1, tid, hdr->addr2,
 					  hdr->addr1);
 
-	if (entry == NULL) {
+	if (!entry) {
 		netdev_dbg(ieee->dev,
 			   "Couldn't invalidate fragment cache entry (seq=%u)\n",
 			   seq);
@@ -276,7 +276,7 @@ rtllib_rx_frame_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 	struct ieee80211_hdr *hdr;
 	int res, hdrlen;
 
-	if (crypt == NULL || crypt->ops->decrypt_mpdu == NULL)
+	if (!crypt || !crypt->ops->decrypt_mpdu)
 		return 0;
 
 	if (ieee->hwsec_active) {
@@ -316,7 +316,7 @@ rtllib_rx_frame_decrypt_msdu(struct rtllib_device *ieee, struct sk_buff *skb,
 	struct ieee80211_hdr *hdr;
 	int res, hdrlen;
 
-	if (crypt == NULL || crypt->ops->decrypt_msdu == NULL)
+	if (!crypt || !crypt->ops->decrypt_msdu)
 		return 0;
 	if (ieee->hwsec_active) {
 		struct cb_desc *tcb_desc = (struct cb_desc *)
@@ -998,8 +998,7 @@ static int rtllib_rx_get_crypt(struct rtllib_device *ieee, struct sk_buff *skb,
 	/* allow NULL decrypt to indicate an station specific override
 	 * for default encryption
 	 */
-	if (*crypt && ((*crypt)->ops == NULL ||
-		      (*crypt)->ops->decrypt_mpdu == NULL))
+	if (*crypt && (!(*crypt)->ops || !(*crypt)->ops->decrypt_mpdu))
 		*crypt = NULL;
 
 	if (!*crypt && (fc & IEEE80211_FCTL_PROTECTED)) {
@@ -1171,7 +1170,7 @@ static void rtllib_rx_indicate_pkt_legacy(struct rtllib_device *ieee,
 	u16 ethertype;
 	int i = 0;
 
-	if (rxb == NULL) {
+	if (!rxb) {
 		netdev_info(dev, "%s: rxb is NULL!!\n", __func__);
 		return;
 	}
@@ -1369,7 +1368,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	rtllib_rx_check_leave_lps(ieee, unicast, nr_subframes);
 
 	/* Indicate packets to upper layer or Rx Reorder */
-	if (!ieee->ht_info->cur_rx_reorder_enable || ts == NULL)
+	if (!ieee->ht_info->cur_rx_reorder_enable || !ts)
 		rtllib_rx_indicate_pkt_legacy(ieee, rx_stats, rxb, dst, src);
 	else
 		RxReorderIndicatePacket(ieee, rxb, ts, SeqNum);
@@ -2510,8 +2509,7 @@ static inline void rtllib_process_probe_response(
 		if (is_same_network(target, network,
 		   (target->ssid_len ? 1 : 0)))
 			break;
-		if ((oldest == NULL) ||
-		    (target->last_scanned < oldest->last_scanned))
+		if (!oldest || (target->last_scanned < oldest->last_scanned))
 			oldest = target;
 	}
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index ff98b41c94e0..42d652fe8601 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -918,7 +918,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 	int len = 0;
 
 	crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
-	if (crypt != NULL)
+	if (crypt)
 		encrypt = crypt && crypt->ops &&
 			  ((strcmp(crypt->ops->name, "R-WEP") == 0 ||
 			  wpa_ie_len));
-- 
2.42.0

