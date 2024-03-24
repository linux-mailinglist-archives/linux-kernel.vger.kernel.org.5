Return-Path: <linux-kernel+bounces-116016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF218894FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F291F2F81C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E50C17CF7E;
	Mon, 25 Mar 2024 03:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQ3Rwf9N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CF421955A;
	Sun, 24 Mar 2024 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323356; cv=none; b=Ev5TAV+pc/BEiEvuAp0zCsDfYGheUMUc3pALEytyJc1tZjUkE3els7oifmfNRAcW5Afd3XSn6q+LNXQJgYp+9vF8ZT1aUOOmgA4jaN/grm/TvF1RAenRTlT2AcWqwNhpUBb79QbkauFmaV/qFd4RNncH+JP8fyKOZVGT+B5crTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323356; c=relaxed/simple;
	bh=eeE4eirE6rYXh0hPl5NvtThXQHpMfWfr+Z/2hnUr1nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qY0LNMfz6hksFyTwUEVIUjP8tIuM+9UyDKiYm+hdjbhgxKyeAJBg+flAaNwThjd2oNbYw9+16nlqndqPFAjgp+qR4P5f5926L+z+YAjrzaKaAiweHeHri+i9V+vOAxf6Me1AjodtJ/ZB1mhSDx4usahT7/6iXzQgXdu5NhkDsTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQ3Rwf9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDC2C433C7;
	Sun, 24 Mar 2024 23:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323355;
	bh=eeE4eirE6rYXh0hPl5NvtThXQHpMfWfr+Z/2hnUr1nA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQ3Rwf9NsaRt5j7Q/MhdDeSDed2m9m6oFhY/8ON2BPj6wFX6iOr2oV4Aa159Dh7UL
	 jzZgKeMQptzGKKoJVa7DpxtlhrbQbfnOPuRlg0FqmWg3Y6DMyi7op3MgFvNOU6Ft4E
	 cpAzkGrImTYAMcHQVbU3wqG/8j+6VcCTC3m8vhGig6rZaMcVA+xGjviCiXdAeJjxRh
	 D6N0YVI2COEzH6mWnQQ8PaldVNk8a7uIwJN5rDPJpideh6y5LqBRnhP33Ed1ckd50c
	 /VGXBOX2WxwNIF7EnOXTFf6obfku+WcrOO/QzuGlKlDp40EbbyA5W4/Mxl3fCvoq81
	 RVxayimi4nlBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 055/317] wifi: wilc1000: fix declarations ordering
Date: Sun, 24 Mar 2024 19:30:35 -0400
Message-ID: <20240324233458.1352854-56-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index a7bca0475e1ee..edd51592a82da 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -359,13 +359,13 @@ static void handle_connect_timeout(struct work_struct *work)
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


