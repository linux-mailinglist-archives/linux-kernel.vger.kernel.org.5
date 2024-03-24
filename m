Return-Path: <linux-kernel+bounces-113656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDC98885E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51835284F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2591B1DBF2D;
	Sun, 24 Mar 2024 22:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mbarqa6P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1231D5F8F;
	Sun, 24 Mar 2024 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320576; cv=none; b=qfuaGONWgdJqnM4GPFSQU6CEhiEwAKJzq2HHEjGj3t+tyfRgpSbQlIznV8nsxYJSd17bSKO/82FMsokJWPKY+DKm7qbFVKShDB2hY1VHaxqfZI1CeLMvp4eQ0HxPwbPQ1XKI22elH79DAsLZ5uCrqVj3Y3fh8me59IubD6j0L8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320576; c=relaxed/simple;
	bh=G+hduV/IVdxX36FY9MOF6jITJo3Fxej2/2NW473H1lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAXPVqMF9SCh7fPqxIYKtc6XHS6Bpvk2Eastaba1Ex+WJ9RzLa8wlY1ab9xtr7T+H50CynVOoiBarD6zhNREGrkS0FYRgVR/lses9C4Mz34N+j8Nr8eulHSHffbiIPInFUHOs3uB0+D7Fai097tl34X7jjwImvbu/zcFysGHBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mbarqa6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5347C43601;
	Sun, 24 Mar 2024 22:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320575;
	bh=G+hduV/IVdxX36FY9MOF6jITJo3Fxej2/2NW473H1lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mbarqa6PXi1JBnqckkqHNGH8x9QG/NlM7VMZIY4x/+dOyuWWeYOrBhXIyT7dshDBI
	 13mdqxhwMOuGnPsOBBZej1HTbKv59ICi7WK0mdHMFBnnco4BQiGb6EWKNbj0SGRTbc
	 fk7jYLg6YZj1rqVWADtNhlWuOsclLN44IaVX8YqBbdmH58wXqGnR0vNoXyI9ryL03t
	 4QzKkOt6wc3hnbHSfOjvCHWKS+cIfAq331BrgMwKEOWXAUNnxzuJN9cU4ov1PyzuLA
	 23cT8QHAoceVeLwngitOYEEFftrWLgiKXcX/15tpdg+aKxBnK/raFqXS/rAcaojlZx
	 d/1yOtY5k24+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 136/713] wifi: wilc1000: fix declarations ordering
Date: Sun, 24 Mar 2024 18:37:42 -0400
Message-ID: <20240324224720.1345309-137-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


