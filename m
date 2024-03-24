Return-Path: <linux-kernel+bounces-116257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B8F889DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368451F370BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A66A2893D7;
	Mon, 25 Mar 2024 03:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJrARb+f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F9F1802CE;
	Sun, 24 Mar 2024 23:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324036; cv=none; b=Y6gWrDa9+wEJYzLrESmloKhP1btuxQ9kQzM8o/J5rkMbi6ObfHB6CDgN6hM0XXXk0ZLmpwxnFJ/3ngiTCmq+bNX3buPcIOxx4JIYqH8YpBXHv74lU9M1ibzwK168SDjJX61d2tjxc5RajlvNPxZXtSp4YBWd0mhwCOS7psXGXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324036; c=relaxed/simple;
	bh=myX2+tAmhFIBAAXFLdRpZctMsZOAIV46IPbeD/+7xpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbT/wMY/wfJggoLhsbzmgkeu4hCqkoZL+X5zFN/y+0UlohTPor+EWnpm0VL7tAuT/KkTk0oTTjwWJ6hGZzsoM9JM6JoFUEQXAOaMhbfdCNgk9m8o90eYYi68qpiWSO8YSH1bCq8Z4dxgzM94OVXUJUAZ5ztiwdxLQSIbr5BOAs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJrARb+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A62C433C7;
	Sun, 24 Mar 2024 23:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324035;
	bh=myX2+tAmhFIBAAXFLdRpZctMsZOAIV46IPbeD/+7xpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FJrARb+fNEBtB+kl5yCef2xPKCDyb2ROGPsP1SgB/VZOa4KY3+5DwukIN0PaVO5i7
	 UYGa6cCum5q0sf/TgWEy09LcTQJ+H0Tj17Db/yRhryWDKD94gKvARytQdJobTXf3lh
	 K2oq9U3JgVd+MWOb1I7BJ+1oy9Bi8PBD+GKHzeIKhaIXbkSSS+JSdUFuBU2oA8m3s7
	 +/gkkxYe8j2233ahCJuO+HCj80pApDUuvNPbttptrEp1PSEb+f+V7Jmmrzz19Hlg6p
	 kp4hjD7x7NdgWU7oaqaUCKRGhqWH6+jxWMPfwtw63psjlnveGiexHv60Mn2AK2q/L+
	 jPpiDtK8AWPZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 036/183] wifi: wilc1000: fix declarations ordering
Date: Sun, 24 Mar 2024 19:44:09 -0400
Message-ID: <20240324234638.1355609-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
 drivers/staging/wilc1000/wilc_hif.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_hif.c b/drivers/staging/wilc1000/wilc_hif.c
index 221e3d93db148..b9c21315a403a 100644
--- a/drivers/staging/wilc1000/wilc_hif.c
+++ b/drivers/staging/wilc1000/wilc_hif.c
@@ -441,13 +441,13 @@ static void handle_connect_timeout(struct work_struct *work)
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


