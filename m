Return-Path: <linux-kernel+bounces-114100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0630F88885E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ADD51F26D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB14C23A771;
	Sun, 24 Mar 2024 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFmIRHhq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D0D200A58;
	Sun, 24 Mar 2024 23:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321395; cv=none; b=MWkheitlE3C5o+3/Hmlg5foIVkuN1WrqM5xFfqjpmoFGPbrs+TJSQJLWI2/0OzZO0BQ3/QyHa4LOjKjeKk6fn7J9fogx/vBmOw1UJ0Elo9BCWrM25FKNS4s2c+rV3zNLKVBTJt/BfuMn80gQ3Nb/GGK6XsSMay76k3OTpJjE8LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321395; c=relaxed/simple;
	bh=G+hduV/IVdxX36FY9MOF6jITJo3Fxej2/2NW473H1lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EmK8JvvXgF8H22Uc8fmJAVtK+GI3P7rD8LM2x3MQ7Ppeg9NRSw6c3vuNvd53H9pFXu2Tre4S84rVrdvOvDaymUBfDojFqng6ModH1zov2jR4GZvSM9GM2AUNzYmXxGb/Phfj4NMDpY/ZDp2lCGiDg3lcDAmNGfOnnx/n9rx9mpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFmIRHhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00560C43394;
	Sun, 24 Mar 2024 23:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321394;
	bh=G+hduV/IVdxX36FY9MOF6jITJo3Fxej2/2NW473H1lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hFmIRHhq9IypNpoIwRHyEpVG2tGdYTeJgMTdtbVeFLOhrAJWbNZC+OAhYF9HyEjzh
	 bd/ZrKwALiNrTKlBR5Kw2s9fZOy+TOsP5KVsKBLbyIKBFl2DhkhaFUzApj9Y63FJIH
	 ukN25RqAQ3ZPjic2hSHgZV2tgaAPW5f5DLbMuafBxJeH3/hw1wk4ftgKhOPoomoW2f
	 bzhQxxSG0gKqQLdzsdgqyKfoMuem8+6RVR80A5086agFuqF8kK4ZFdy37Pi4l+5xtW
	 8AITE8Q2YNa9HgyoFSv/kERHeJZjYLf0xDx23jgZpk8FNLd7xZaj/mAI9EwOErs+5l
	 qNJGlQ1CgZFfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 118/638] wifi: wilc1000: fix declarations ordering
Date: Sun, 24 Mar 2024 18:52:35 -0400
Message-ID: <20240324230116.1348576-119-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index a28da59384813..2f8b9e9c393ce 100644
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


