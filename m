Return-Path: <linux-kernel+bounces-88572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 992A586E39E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E901C21378
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344B039FCE;
	Fri,  1 Mar 2024 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xxNTTc97"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D25023DE;
	Fri,  1 Mar 2024 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304232; cv=none; b=JwvZxssYQxsBiA9JeswHDZY/eDCLjxfPk5aUL/tx2dwZy5D4tNIikDogMJS0EBfdtr2Kh6QfTV1KUmHesPorLXbPe2UNBIIcDr4I52t0shU5pZBdT/isbJdtRjxEnHahCt4ylvvBlXLjrrWkmTUAYPvWZwNWjX5HrlrIvhcL+KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304232; c=relaxed/simple;
	bh=g/5FdFmANw8vfKyQblOhb3dPtLnfPxgu5rTqDPLM/k0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N0YwpXMTVpndVfdr3MT5PaLTfpjWhMaYtr0U/Ml+huNrkJO9XZvJ5DzfR1RgEy6NCZvjQR2US6saFSAo3ft3bDUacpQz7or+qeWdABv6nka7xPeFXsqDqLOJZ7usE7ooiA99qzXNkGzI7C8mFKZgti1mRQa42T+zL+UwNN0fu/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=xxNTTc97; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709304229;
	bh=g/5FdFmANw8vfKyQblOhb3dPtLnfPxgu5rTqDPLM/k0=;
	h=From:To:Cc:Subject:Date:From;
	b=xxNTTc97xWYp4JHtRwbQppAyuiFMXatZr52S8x9U/4TFPZ1ascmVK8vAU4mjYEzBq
	 Ykt+7E/MR8BSvG9PeoGYfiaOMmtqXUhN/4DXG6vrhD+soagLQbiuEmmdy+4r0lrAZO
	 RAkqLMeNDa2bZHflQJJ6NLEfW2xGoyaR/9g0V7Ag1l3STfFDbmhVYpNDer3cyPAwAX
	 pxzr8htRsrWFkVP7HF37kkPIkduT3wUHBMbuyru+2XH4Qwl94k/OkkvE6cjznHaxCa
	 be6nP4OuhB7n7xer/eWCg3+KKmNflNZMbl9Xo6uoH8Ej7o265Ya7KFGXe+NvmujkLp
	 7TQEbUwPHkSdg==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A6DB837803EE;
	Fri,  1 Mar 2024 14:43:42 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	kernel-janitors@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] wifi: mt76: connac: check for null before dereferencing
Date: Fri,  1 Mar 2024 19:44:06 +0500
Message-Id: <20240301144406.2808307-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wcid can be NULL. It should be checked for validity before
dereferencing it to avoid crash.

Fixes: 098428c400ff ("wifi: mt76: connac: set correct muar_idx for mt799x chipsets")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index af0c2b2aacb00..7af60eebe517a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -283,7 +283,7 @@ __mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
 	};
 	struct sk_buff *skb;
 
-	if (is_mt799x(dev) && !wcid->sta)
+	if (is_mt799x(dev) && wcid && !wcid->sta)
 		hdr.muar_idx = 0xe;
 
 	mt76_connac_mcu_get_wlan_idx(dev, wcid, &hdr.wlan_idx_lo,
-- 
2.39.2


