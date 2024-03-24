Return-Path: <linux-kernel+bounces-116131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB50889981
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59EDA1F2904A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AE73AE293;
	Mon, 25 Mar 2024 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKdXb2cx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5564C2811AF;
	Sun, 24 Mar 2024 23:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323672; cv=none; b=kdAwj4WFRomK413DI0unjq2y5v69fOzMWjEZdUKT3YTyuGIAcLuMNWFEpuKw6M19opJlMkJFyOEZ6z57vmCZ5EuXAZxQHndUGdINTmMnMAQ1JfWzxSUMr46jdPpInsOSFpLu84lA9CMpdMzUKZllzcz0tnBCDooLwYEPdHL5uUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323672; c=relaxed/simple;
	bh=tYtOBFKTlqrPpFgpD2Kj2tZ5+ElxGQzIPYLeyxXO1KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9zZ74JBmu89fVH38j29/jv0iCMkaBh1c/308Bf9dH139iCMR7W9DXHQihwtmmai0++WJJ3p5eTIUlqW6T4KhnjTIgFGXnLhWBIBIDjrhNQ/KS6L6MN292o2P+VAr85gN1RVRyxl8LA+TP3+/8Q5ZGB1ywuxQAemzICWlEVbMIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKdXb2cx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9718FC43390;
	Sun, 24 Mar 2024 23:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323672;
	bh=tYtOBFKTlqrPpFgpD2Kj2tZ5+ElxGQzIPYLeyxXO1KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LKdXb2cxG62UMFKo3wogKJLn2ammcD96g+ZhqNQQT4puO66u5q5TIavxajOU7EjCA
	 QXwy1IR6kbB+fhSVKVv/ru8eXGblpNoa+tG/I/flBKRLvMEh5xXj+eCcn7Hf1NGoL+
	 tzQrnG0JnwVo8Z1Kq9txJamvnfvJaxBudMG9hFLKFB/09II5cCJtiF4oAVuR/l4W7S
	 j9bCj5/r2nKPO6lVq2jJPuf53gkvaLkpU/NH6cGPxjHgW/gBdl5moasPQIpbDqRmwx
	 EuRTKCOTAHpzzgUeJwgJTLyChsg1qkRIRi1iX1PVdXAZLCAFEFgd09UmakRn74VXOu
	 /y3LjoqwtqEoQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 044/238] wifi: wilc1000: fix declarations ordering
Date: Sun, 24 Mar 2024 19:37:12 -0400
Message-ID: <20240324234027.1354210-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 884f45e627a72..bff33f39605b9 100644
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


