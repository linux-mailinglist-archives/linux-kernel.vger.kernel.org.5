Return-Path: <linux-kernel+bounces-112947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286D9887FF8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27C51F23D9F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C2282C6B;
	Sun, 24 Mar 2024 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlazJP5S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0AB82860;
	Sun, 24 Mar 2024 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319759; cv=none; b=uHgMOfSwPDm+PcuXxQHNag4FZZdx8p/JxLfJcZEEm8J7Fjm4oODYsaGS77fzi6q2PM0neBYZsJSmS0UdNNc1Ipwvboz+sDVmZZT9Ja/5u4FuftHj02/aHMoolMf/ObRh5x/MmfUSzHm2aVfK/9guRtwT0Q+2ttHUWDZ3IqdlPCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319759; c=relaxed/simple;
	bh=Qdef+ftIbJ1XbL9pjOrUZIcLWOBV/tvSiOqygjidF7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZUL5NiiFTAz2KQ/SuQoQxkdh3U5oyiY588Kb4Ejt8/8om9pXtj3NcLj8y1nBqjZldcPLwXFbPYzRIMPpwLvE3LNR72dYHTikspv+iCdisVSMYma9bafbaGuv/WU4XdGqSSTvTacpSe9eDLBPeECE7DT4IklglAWgqJKbZbekilE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlazJP5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02432C43390;
	Sun, 24 Mar 2024 22:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319759;
	bh=Qdef+ftIbJ1XbL9pjOrUZIcLWOBV/tvSiOqygjidF7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LlazJP5SCND32n8236YReX+yUTDwTUETuCOxfY1N6KppWMo65lbTVhUuNPEOjYbSe
	 QZh23neelBAJe6+Y0tlNcCs/xbPYekCt95mU855QLWYJskTx7J4TJ2WTdgrav1M5OI
	 myVupbKByrDiY9UJ0FCa4WHl7Is7ssA5q68Iylvv3Iwwz9epCK0Jqkgy/hBi4A8CZs
	 TbptapGh21O829LNicUrZXEaM6EatgK/5d/f2m8QHFvkGi4KfToQhjscoT0byHKeoL
	 n2ms4zWXhd0tm65f/iDgY8QfZwDVgL78n7vWEkupVXlShjbSr9H6aT3LAzlKOfhnta
	 5w3aWQ0Y4vtBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 060/715] wifi: wilc1000: fix declarations ordering
Date: Sun, 24 Mar 2024 18:23:59 -0400
Message-ID: <20240324223455.1342824-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 839f142663e86..6f1218a510610 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -377,13 +377,13 @@ struct wilc_join_bss_param *
 wilc_parse_join_bss_param(struct cfg80211_bss *bss,
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


