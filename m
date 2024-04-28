Return-Path: <linux-kernel+bounces-161468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4645A8B4C69
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7D22818EC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C626F074;
	Sun, 28 Apr 2024 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="IXWH8xfg"
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C700A6EB7A;
	Sun, 28 Apr 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714318581; cv=none; b=nvcsnfOX6UTk8RU2IpnXuQcrjZFxpA9ezD8/qTveY9vf05UYwwhZ8WAvURJ+gPZtweIZy3t+HlmdcjMkPI3cT/cfSCUrFqiI5INV2vXDRVLtihf4xaaTfna+misAVc90sSBIz+W1rF2hQN4kfty9cVQgYuw5Q0IUAU5xUhB1Zdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714318581; c=relaxed/simple;
	bh=pH+9W97o7UGH4h29CTm7rSwQNCI2Ku73u5Nn6wkcv30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8B1wIxTzkta93SOu2GhYVwv84Om1ixYHBmjDb29kbM/DRwQp8KG/5FBUaArkjkozUhKCmTMq6XA14CiPcJ6Sih1gC25bRtggavgA3MfOEpwIfdk+HS07PpHx6fQLbaqpaihQdyxD8+0hnoarRJ7Js8K+L+1CFttcql+Dx6Z3dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=IXWH8xfg; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 16YWsTQrFuPiV16YWsibQ8; Sun, 28 Apr 2024 17:35:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714318509;
	bh=1gpd5ELJC1zLelEncmtXMoj1+Hn1p8lojfAwRP5/fus=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=IXWH8xfgTVGRyT2DCFddqdTlble52UnCPNXRABtgChyIVcuQJhTmLp43uwO3SZCKn
	 0alesarNZUfWo71w8tt0s2iCENFjr7BKWhAbWKhqsOcNpXegvOgI0H5eUDdK2+1nK2
	 LEr1umYSwvtaRV3iSOF5VWa6a+asGtJEui5MWnTVhR6Os63TU8diWZZO5cW9QSRHqv
	 78jwoK2rb2jGRxn/VGBwgT3GpzeHG/l5WLf4ffN8/BNRAf/U1lWxyRb34rCwNka8vP
	 G4U2u5Mpbv/WIq/V5zw5+44Gg5YzU5jE6uBOrKnapCJ4kAOhVt/U6tDwyPQ6cSmZb5
	 DaiB4PDsDMZuQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 28 Apr 2024 17:35:09 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-leds@vger.kernel.org
Subject: [PATCH] leds: aat1290: Remove an unused field in struct aat1290_led
Date: Sun, 28 Apr 2024 17:34:55 +0200
Message-ID: <f7c8c22242544b11e95d9a77d7d0ea17f5a24fd5.1714318454.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct aat1290_led", the 'torch_brightness' field is unused.
Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

It was added added in commit 49c34b8e0f43 ("leds: Add driver for AAT1290
flash LED controller") and its only user was removed in commit 269e92da8b07
("leds: aat1290: Remove work queue").
---
 drivers/leds/flash/leds-aat1290.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/leds/flash/leds-aat1290.c b/drivers/leds/flash/leds-aat1290.c
index 0195935a7c99..e8f9dd293592 100644
--- a/drivers/leds/flash/leds-aat1290.c
+++ b/drivers/leds/flash/leds-aat1290.c
@@ -77,8 +77,6 @@ struct aat1290_led {
 	int *mm_current_scale;
 	/* device mode */
 	bool movie_mode;
-	/* brightness cache */
-	unsigned int torch_brightness;
 };
 
 static struct aat1290_led *fled_cdev_to_led(
-- 
2.44.0


