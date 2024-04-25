Return-Path: <linux-kernel+bounces-158291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C918B1DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91321C235FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B0E12C49B;
	Thu, 25 Apr 2024 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="SQCW1HKM"
Received: from msa.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C8A12C463;
	Thu, 25 Apr 2024 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036940; cv=none; b=EsUNzV2Lgbqbbb6iTblvpl4lEB76nihqxMpC9KAreIaaeiPzQ6taeZfehpuiNXkYoMCMz/VDJYrTjJjdKFud75jy8ffy+7QbcKj7Ns9Xgls4QXjv/jTU3ZaPYCVDE3VkO2a7gZ6Eir1X0Q50tSSdbHO32GTY27MwXIk6lDqpI/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036940; c=relaxed/simple;
	bh=RYYr6S3bqZ2+QnlX4wSrGo/4TtP3354taVowvs3jNII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UXCCymyVtN+oKJSaA9La/8H2Csi6N+Dz6Cf6RP/b9HG49l3aLPJRNs36jhIegvMuVkF1Cr37YWjMzVdbn1suafCWvj2nXq/4tZF8G2KpfGJ7u++QXTWs/E+DUzgWVZ3N9Rledc5tN2/sPkZrkouK+SjkE4if8Zp0mnhv7OHuBZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=SQCW1HKM; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id zvJ0rM6x8hCCizvJ0ro486; Thu, 25 Apr 2024 11:22:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714036935;
	bh=0dK7ZlaT22HaVkIUWpHsgyaYXot/beEkT5cEKEbeojE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=SQCW1HKMP2RBYzYCQ9nkbddK3Vl/LthtQ7dKCnfdETna+aKi4FfaaUqhjWm6ayYGY
	 NyQ4QSZgttrMpJaFgSiNKL/EO/xWEOt/dxiqX1HjBzOp9mgMzBQRTx5LAOUTWNGDfp
	 9hRD7JheJKT0+eIUYLv715wKaiAbiHbJO3bL8Uzvekczvv1mCZPRYH73c+yZg8ry+c
	 dHtgpWcG/bksAZVi5Mhx7jcle7xYOxdY4O74umVekR1zqmvvIsjqxw0fPQ1kuM9FvG
	 FVgrGw8kwGuqIw29mw9A5Zwes+wur4j6leRnzax6zFgSo2riqMmOpz6862PPva/e1K
	 YJLdTPqn8H7rQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 25 Apr 2024 11:22:15 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH] wifi: brcmsmac: ampdu: remove unused cb_del_ampdu_pars struct
Date: Thu, 25 Apr 2024 11:22:03 +0200
Message-ID: <fa3b190b6e9cba65ecc36fc93121c6ed8704f704.1714036681.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct cb_del_ampdu_pars was added in the initial commit 5b435de0d7868
("net: wireless: add brcm80211 drivers") and its only usage was removed in
commit e041f65d5f00 ("brcmsmac: Remove internal tx queue").

Remove the structure definition now. This saves a few lines of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
index e859075db716..c3376f887114 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
@@ -143,12 +143,6 @@ struct ampdu_info {
 	struct brcms_fifo_info fifo_tb[NUM_FFPLD_FIFO];
 };
 
-/* used for flushing ampdu packets */
-struct cb_del_ampdu_pars {
-	struct ieee80211_sta *sta;
-	u16 tid;
-};
-
 static void brcms_c_scb_ampdu_update_max_txlen(struct ampdu_info *ampdu, u8 dur)
 {
 	u32 rate, mcs;
-- 
2.44.0


