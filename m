Return-Path: <linux-kernel+bounces-62600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BFD85237F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A8E1F21AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85B053378;
	Tue, 13 Feb 2024 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMCxd4wG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E62D52F92;
	Tue, 13 Feb 2024 00:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783559; cv=none; b=YrtiRKDsA9w8iUqnN1vVodApgrbieqkQTfAAfCzexEEvssf696MthYyC4gBclfwtYItJsdBYSNROF/nUkyarQs8T557XrMqqRK2sw+i8gYD//s5AlAEibHpMAPd0T9JxNv9vaYMfr4wG11msjo17IwDb8l89Pz0rPXItFqCS58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783559; c=relaxed/simple;
	bh=uVHzwgSKzY/3Tmm6JxcNU/AAvfLOdgaM57QwPSLF0bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lv7Y4yWBFwc6TQ73Gqi7oOuVQz8lud903vGOCWdo7AMQg4iPH0M0xy8c93dhzUDDCyF1cKTUjTUQM4rjC5xpsMNu2rYzZxVCZsB8A0Y2QMZPhn5HhbiY6jfKhIwFlESMaq3UPrx1tXcrJKB20zna+nOD6DGOt10BVVMcTxT7EBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMCxd4wG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E84C43399;
	Tue, 13 Feb 2024 00:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783558;
	bh=uVHzwgSKzY/3Tmm6JxcNU/AAvfLOdgaM57QwPSLF0bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tMCxd4wGcwE1SILJX++2Wy+R4bMFuScR2st3jSen4EA1ayZDilEuvRtTHyr9leR87
	 AX65FaoqivCDKUNUwdfYfwjB0L6rhuEGJRosX0WwOFHyjQh5GdK2cz6BiNZJq9Gfdh
	 PGc5XQL+q50pqFMjjdnKcfq46gUr3C0PrGsPy2EbWOQ5RL4qnzZNgTCPVR389tNkEP
	 +RDDQ72zC6aj2aoR6Kl9Ld2OUtCu6mlHuAv87VadTV02/GkDmdiPJ9T5hHzZm5UUr/
	 h4WlDYyf7IW99rLS4lNciSHBLW7+2P3HvztOrFAXoZvwKWh4p2u+dRsls9NI0DTEz1
	 ZLwK2nC4nPnsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 31/58] wifi: iwlwifi: do not announce EPCS support
Date: Mon, 12 Feb 2024 19:17:37 -0500
Message-ID: <20240213001837.668862-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit a23c0af103e184bb1252dddddda040f6641bea7b ]

mac80211 does not have proper support for EPCS currently as that would
require changing the ECDA parameters if EPCS (Emergency Preparedness
Communications Service) is in use. As such, do not announce support for
it in the capabilities.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240201155157.59d71656addc.Idde91b3018239c49fc6ed231b411d05354fb9fb1@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 480f8edbfd35..678c4a071869 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -668,7 +668,6 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 			.has_eht = true,
 			.eht_cap_elem = {
 				.mac_cap_info[0] =
-					IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS |
 					IEEE80211_EHT_MAC_CAP0_OM_CONTROL |
 					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1 |
 					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE2 |
@@ -793,7 +792,6 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 			.has_eht = true,
 			.eht_cap_elem = {
 				.mac_cap_info[0] =
-					IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS |
 					IEEE80211_EHT_MAC_CAP0_OM_CONTROL |
 					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1 |
 					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE2,
@@ -1020,8 +1018,7 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 	if (CSR_HW_REV_TYPE(trans->hw_rev) == IWL_CFG_MAC_TYPE_GL &&
 	    iftype_data->eht_cap.has_eht) {
 		iftype_data->eht_cap.eht_cap_elem.mac_cap_info[0] &=
-			~(IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS |
-			  IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1 |
+			~(IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1 |
 			  IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE2);
 		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[3] &=
 			~(IEEE80211_EHT_PHY_CAP0_PARTIAL_BW_UL_MU_MIMO |
-- 
2.43.0


