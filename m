Return-Path: <linux-kernel+bounces-62657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB90852413
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CEB61C2346D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9E06166D;
	Tue, 13 Feb 2024 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdWSgsWp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388BD612F3;
	Tue, 13 Feb 2024 00:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783686; cv=none; b=mHSzWMglxswBxUybB2QAgwLtkwtJWYma8OEaYqIBde855i97B5zA6g1H8Br8r+a2HIPBYCtp37nfmaabbAJgc8ZMoRR1jLVxic4LahtMN3LbsL/e0Nl00cP+fjnDv3HKjzQpxcXlK0UfkDssEYV3thus9/APvaCg61aaG748Zr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783686; c=relaxed/simple;
	bh=EexVcFYTzTIkFx9LmSmDwv7HEO3oDUz1f0URm3EH9IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkanNLtlmnt2psxo36ZTE6AR4KpnG3AlOJsqHh1SCoYPT05go6tTy4V/3BjD7OHWQlrjANlYFmUkkEAlmbSF65AdsIMH2wZlarG6LSTLpa1wHOarhy44iqkQWDPJ1V/yz+ot7Kao7/iWq8CI2ikIL/HgS6n5PnrfHKeG3beTQTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdWSgsWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C089CC433A6;
	Tue, 13 Feb 2024 00:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783685;
	bh=EexVcFYTzTIkFx9LmSmDwv7HEO3oDUz1f0URm3EH9IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VdWSgsWpZUygKVRZmexrAIN7QmVKtIjJwzTzdrai3SbYtWOF/JIFtc+DOt1ubvROm
	 HZZiYdXUPkc/ipRHOAfyqAnd8keHr1HI1EShHZHY95tF+s00rq4ELTU7yV3Oh7r9Le
	 LbNBEFi92R4p+AZaZUW5GAusuaafhdRq4FyyQ5siJkBsUaviRGKgZy+11h7cEh9wg0
	 jPQQDYs0LWSZVCsA+rAzpFNYUI9jUNp4Qmp+kBhSUIUmcaZEvjKOOH9e8ByVllmEmk
	 42lkwdLZ1TOgMrSGFJNS7/6Om0CWJC7UuTxhtfeWyikmskXsIef3dkkdMIL4Vy7qdW
	 I2hiy/GgG0gQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 26/51] wifi: iwlwifi: do not announce EPCS support
Date: Mon, 12 Feb 2024 19:20:03 -0500
Message-ID: <20240213002052.670571-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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
index e3120ab893f4..878d9416a108 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -668,7 +668,6 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 			.has_eht = true,
 			.eht_cap_elem = {
 				.mac_cap_info[0] =
-					IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS |
 					IEEE80211_EHT_MAC_CAP0_OM_CONTROL |
 					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1 |
 					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE2,
@@ -792,7 +791,6 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 			.has_eht = true,
 			.eht_cap_elem = {
 				.mac_cap_info[0] =
-					IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS |
 					IEEE80211_EHT_MAC_CAP0_OM_CONTROL |
 					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1 |
 					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE2,
@@ -1003,8 +1001,7 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
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


