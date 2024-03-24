Return-Path: <linux-kernel+bounces-115850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D0A8894C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6718B1F29206
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA64226930;
	Mon, 25 Mar 2024 03:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2rVsagf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68850145B1A;
	Sun, 24 Mar 2024 23:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322016; cv=none; b=QM2SEbjgVmi5SYR/QO2M2yRKXyOMYQyr496vo9qD/p/G0jRWiOkwDfT+0JuuOAuq6iBFBXNTtTAiLVjBCNpw3eZG7X1rxgSzM44S2vhafou6lPWtOKvdAQiN6UZoTBDy9/vmSPdgfjUdIWJzrAb9SBsC9KJPBswmH1XseAeo+5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322016; c=relaxed/simple;
	bh=e3S7j0C5eISdqw4Fg5NN+8n0PP+t0wc7M4Hdhp4DL+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTXEq+YLoHCXziMnDfa/k1XjrzcBDT8FoSGDBps009wxZBjMPRE31d7/bOch1WUduW4tEns0ZhlPsRuEIh+48fJaIe6aqxWyUBgv5HjBt5g6vyZDr5q/N7xa79Ul72UqTWlVe67+NN98urxvVyTBXzm9j4L6tqkePeWBDgCM8nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2rVsagf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F48C433B1;
	Sun, 24 Mar 2024 23:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322016;
	bh=e3S7j0C5eISdqw4Fg5NN+8n0PP+t0wc7M4Hdhp4DL+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M2rVsagfC/MqfWPOWoy9bYKxN1unh4hnbfcxE+kOsIEkIcFFOzbw9R7TRYLr1hVoe
	 B3jvz0sDRw7dw9x6n0RXWIDcaQ5WUMoMNNSsU3Y0Cw4XtibCb+NYY4wfr0SO+3WrpC
	 kC4vsyBPp87FgEuQ2+bdVXsay3iF9vRCrRxmPCDyHZSbgzgftVh62S4L3Fb7+czqUf
	 bzsSlzKpzKv0wJhFlZT9J+cTfykgrpKjRCzBVLb8NblDcLCOunIUF6UefemLR90G5v
	 wsuiBjqWHYhT+2R8v+LrJL8eC3sdfkaY1GAGah+b2vGYZepKH9FirTTpE43fzUVnKC
	 YwyUA21BvLoPw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 088/451] wifi: wilc1000: fix declarations ordering
Date: Sun, 24 Mar 2024 19:06:04 -0400
Message-ID: <20240324231207.1351418-89-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Alexis Lothoré <alexis.lothore@bootlin.com>

[ Upstream commit 535733e90e5d8912ebeccebb05b354a2d06ff459 ]

Reorder parameters declaration in wilc_parse_join_bss_param to enforce
reverse christmas tree

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240105075733.36331-2-alexis.lothore@bootlin.com
Stable-dep-of: 205c50306acf ("wifi: wilc1000: fix RCU usage in connect path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/microchip/wilc1000/hif.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index a1b75feec6edf..00ecf14afab01 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -374,13 +374,13 @@ static void handle_connect_timeout(struct work_struct *work)
 void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 				struct cfg80211_crypto_settings *crypto)
 {
-	struct wilc_join_bss_param *param;
-	struct ieee80211_p2p_noa_attr noa_attr;
-	u8 rates_len = 0;
+	const struct cfg80211_bss_ies *ies = rcu_dereference(bss->ies);
 	const u8 *tim_elm, *ssid_elm, *rates_ie, *supp_rates_ie;
 	const u8 *ht_ie, *wpa_ie, *wmm_ie, *rsn_ie;
+	struct ieee80211_p2p_noa_attr noa_attr;
+	struct wilc_join_bss_param *param;
+	u8 rates_len = 0;
 	int ret;
-	const struct cfg80211_bss_ies *ies = rcu_dereference(bss->ies);
 
 	param = kzalloc(sizeof(*param), GFP_KERNEL);
 	if (!param)
-- 
2.43.0


