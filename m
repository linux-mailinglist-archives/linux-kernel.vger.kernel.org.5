Return-Path: <linux-kernel+bounces-120908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D5088E065
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C6D1F362A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38971487F1;
	Wed, 27 Mar 2024 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/v8f+Ih"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46231482F5;
	Wed, 27 Mar 2024 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541553; cv=none; b=D/g22LrDrx/V3wfWHNHb3lMxbYjavPGIiafCMgC/bZPzcsWMB89euBLGxE2YScmEP0+eH7PBFC9X50KBrdhppy75w9/ANCFydzVt2QywoOcRtE4y0p5GGUoE+gmrKYrQ4wBf6DeG8aRbihH10RVVNh7qomXPst95/qKH/31p4is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541553; c=relaxed/simple;
	bh=meVdZ+I3Etmw9Ync3NQCCfPHAChryipvSKQ37gSv00Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EVQjkzPKvn6CIl5bhJaxW3YBY8xDqi8tIZrL9eDT7wTIwllORKyXiq0V+lGMorTNsP1sZCR6m7zsgKwVgEVyQ2wTierRsMMlm6CDE0En9stEx/JjMnQa/JGHqY1qLepOT2HvLz6Dw8Ma4gk5OXaf9dg+fnA84yjr5p2g/WOmvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/v8f+Ih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9649AC433F1;
	Wed, 27 Mar 2024 12:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541553;
	bh=meVdZ+I3Etmw9Ync3NQCCfPHAChryipvSKQ37gSv00Y=;
	h=From:To:Cc:Subject:Date:From;
	b=n/v8f+IhvsXodfwkAGsIdOMHmLtVhY/lOf/Cfm3LuVrqmZ/bi1BrlYf8/HROjKRrJ
	 +Zg+wrpKhN8mZnVVUZQ39Im1ETbgHIRLLAFxl8g9Dc/skDOni8OGUBXN0XoMADJIAb
	 sMfjEvBymSAiQc8XdT04L/ORLMSRUf1wH2SxRHWmdGfRqfMINTBEk8RnS+Um/XbCm9
	 EGmLt5+ocsbEgYxUTCR0M0+Gx5cqswXMG3K7LqtB0nC1fdOMzYQ45h1IzGBdSQBgIo
	 GVcR7xDZ+ahqn0Cp0wivH1Hlk0Y+xRmhR+tbxGRW92/Gpx0ulIxGE25McKz6mfOFqG
	 TfZdIn/TO/TIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	johannes.berg@intel.com
Cc: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "wifi: mac80211: track capability/opmode NSS separately" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:12:31 -0400
Message-ID: <20240327121231.2829578-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a8bca3e9371dc5e276af4168be099b2a05554c2a Mon Sep 17 00:00:00 2001
From: Johannes Berg <johannes.berg@intel.com>
Date: Wed, 28 Feb 2024 12:01:57 +0100
Subject: [PATCH] wifi: mac80211: track capability/opmode NSS separately

We're currently tracking rx_nss for each station, and that
is meant to be initialized to the capability NSS and later
reduced by the operating mode notification NSS.

However, we're mixing up capabilities and operating mode
NSS in the same variable. This forces us to recalculate
the NSS capability on operating mode notification RX,
which is a bit strange; due to the previous fix I had to
never keep rx_nss as zero, it also means that the capa is
never taken into account properly.

Fix all this by storing the capability value, that can be
recalculated unconditionally whenever needed, and storing
the operating mode notification NSS separately, taking it
into account when assigning the final rx_nss value.

Cc: stable@vger.kernel.org
Fixes: dd6c064cfc3f ("wifi: mac80211: set station RX-NSS on reconfig")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240228120157.0e1c41924d1d.I0acaa234e0267227b7e3ef81a59117c8792116bc@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         |  2 +-
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/rate.c        |  2 +-
 net/mac80211/sta_info.h    |  6 ++++-
 net/mac80211/vht.c         | 46 ++++++++++++++++++--------------------
 5 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 0744113f3535d..3aa96898a250d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1867,7 +1867,7 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 					      sband->band);
 	}
 
-	ieee80211_sta_set_rx_nss(link_sta);
+	ieee80211_sta_init_nss(link_sta);
 
 	return ret;
 }
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 4bec625a84d12..32b5ac8947bdd 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2153,7 +2153,7 @@ enum ieee80211_sta_rx_bandwidth
 ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta);
 enum ieee80211_sta_rx_bandwidth
 ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta);
-void ieee80211_sta_set_rx_nss(struct link_sta_info *link_sta);
+void ieee80211_sta_init_nss(struct link_sta_info *link_sta);
 enum ieee80211_sta_rx_bandwidth
 ieee80211_chan_width_to_rx_bw(enum nl80211_chan_width width);
 enum nl80211_chan_width
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 34e03b9522c8a..192c5f8b9e086 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -37,7 +37,7 @@ void rate_control_rate_init(struct sta_info *sta)
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 
-	ieee80211_sta_set_rx_nss(&sta->deflink);
+	ieee80211_sta_init_nss(&sta->deflink);
 
 	if (!ref)
 		return;
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index f03731a5bbee2..a52fb76386d01 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -3,7 +3,7 @@
  * Copyright 2002-2005, Devicescape Software, Inc.
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright(c) 2020-2023 Intel Corporation
+ * Copyright(c) 2020-2024 Intel Corporation
  */
 
 #ifndef STA_INFO_H
@@ -482,6 +482,8 @@ struct ieee80211_fragment_cache {
  *	same for non-MLD STA. This is used as key for searching link STA
  * @link_id: Link ID uniquely identifying the link STA. This is 0 for non-MLD
  *	and set to the corresponding vif LinkId for MLD STA
+ * @op_mode_nss: NSS limit as set by operating mode notification, or 0
+ * @capa_nss: NSS limit as determined by local and peer capabilities
  * @link_hash_node: hash node for rhashtable
  * @sta: Points to the STA info
  * @gtk: group keys negotiated with this station, if any
@@ -518,6 +520,8 @@ struct link_sta_info {
 	u8 addr[ETH_ALEN];
 	u8 link_id;
 
+	u8 op_mode_nss, capa_nss;
+
 	struct rhlist_head link_hash_node;
 
 	struct sta_info *sta;
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index 2c475c439ba9b..642891cafbaf2 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -4,7 +4,7 @@
  *
  * Portions of this file
  * Copyright(c) 2015 - 2016 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2023 Intel Corporation
+ * Copyright (C) 2018 - 2024 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -541,15 +541,11 @@ ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta)
 	return bw;
 }
 
-void ieee80211_sta_set_rx_nss(struct link_sta_info *link_sta)
+void ieee80211_sta_init_nss(struct link_sta_info *link_sta)
 {
 	u8 ht_rx_nss = 0, vht_rx_nss = 0, he_rx_nss = 0, eht_rx_nss = 0, rx_nss;
 	bool support_160;
 
-	/* if we received a notification already don't overwrite it */
-	if (link_sta->pub->rx_nss)
-		return;
-
 	if (link_sta->pub->eht_cap.has_eht) {
 		int i;
 		const u8 *rx_nss_mcs = (void *)&link_sta->pub->eht_cap.eht_mcs_nss_supp;
@@ -627,7 +623,15 @@ void ieee80211_sta_set_rx_nss(struct link_sta_info *link_sta)
 	rx_nss = max(vht_rx_nss, ht_rx_nss);
 	rx_nss = max(he_rx_nss, rx_nss);
 	rx_nss = max(eht_rx_nss, rx_nss);
-	link_sta->pub->rx_nss = max_t(u8, 1, rx_nss);
+	rx_nss = max_t(u8, 1, rx_nss);
+	link_sta->capa_nss = rx_nss;
+
+	/* that shouldn't be set yet, but we can handle it anyway */
+	if (link_sta->op_mode_nss)
+		link_sta->pub->rx_nss =
+			min_t(u8, rx_nss, link_sta->op_mode_nss);
+	else
+		link_sta->pub->rx_nss = rx_nss;
 }
 
 u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
@@ -637,7 +641,7 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 	enum ieee80211_sta_rx_bandwidth new_bw;
 	struct sta_opmode_info sta_opmode = {};
 	u32 changed = 0;
-	u8 nss, cur_nss;
+	u8 nss;
 
 	/* ignore - no support for BF yet */
 	if (opmode & IEEE80211_OPMODE_NOTIF_RX_NSS_TYPE_BF)
@@ -647,23 +651,17 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 	nss >>= IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
 	nss += 1;
 
-	if (link_sta->pub->rx_nss != nss) {
-		cur_nss = link_sta->pub->rx_nss;
-		/* Reset rx_nss and call ieee80211_sta_set_rx_nss() which
-		 * will set the same to max nss value calculated based on capability.
-		 */
-		link_sta->pub->rx_nss = 0;
-		ieee80211_sta_set_rx_nss(link_sta);
-		/* Do not allow an nss change to rx_nss greater than max_nss
-		 * negotiated and capped to APs capability during association.
-		 */
-		if (nss <= link_sta->pub->rx_nss) {
-			link_sta->pub->rx_nss = nss;
-			sta_opmode.rx_nss = nss;
-			changed |= IEEE80211_RC_NSS_CHANGED;
-			sta_opmode.changed |= STA_OPMODE_N_SS_CHANGED;
+	if (link_sta->op_mode_nss != nss) {
+		if (nss <= link_sta->capa_nss) {
+			link_sta->op_mode_nss = nss;
+
+			if (nss != link_sta->pub->rx_nss) {
+				link_sta->pub->rx_nss = nss;
+				changed |= IEEE80211_RC_NSS_CHANGED;
+				sta_opmode.rx_nss = link_sta->pub->rx_nss;
+				sta_opmode.changed |= STA_OPMODE_N_SS_CHANGED;
+			}
 		} else {
-			link_sta->pub->rx_nss = cur_nss;
 			pr_warn_ratelimited("Ignoring NSS change in VHT Operating Mode Notification from %pM with invalid nss %d",
 					    link_sta->pub->addr, nss);
 		}
-- 
2.43.0





