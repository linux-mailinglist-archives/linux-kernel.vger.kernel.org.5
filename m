Return-Path: <linux-kernel+bounces-161539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 422638B4D6E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 20:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703F41C2093F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83E074429;
	Sun, 28 Apr 2024 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ts6pYZW6"
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9C474404;
	Sun, 28 Apr 2024 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714328870; cv=none; b=TOtQ4pCvLIue8D1YvdJFrNnxcCOgqsZREXTXENpcHDVxlSUwL13Z82ailx1JAwkyW+uc0gLqLGiqemE29++njYt7uKAifCDl6c2n0XwqucldvpJOktoltyAGEyEUIOYnBothuA5MQ6ZuspfPSD1XOILuRUbhsfUkwh4sehUH44c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714328870; c=relaxed/simple;
	bh=i8dPY/8E/o3tPZjh6g3KMR1QwVM6zkUNIagiMZaI2VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=byE2vbsGLjUV9u4O3hOOcYXqRixgYFgARjD5N2hPVgbbX60JVbDvypq1qr9YPV/26x/aRo07vlKaFsifz+BZrpKrgIQxq76T96Qax5lJ7xeqPcSD/RLoNLFLKdh6th0L/8AwxUm03QQ+ultW/KmYLgHUB/uSLgB9BU6hoCjCaVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ts6pYZW6; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 19FXsdAPqjQGD19FXsx1n6; Sun, 28 Apr 2024 20:27:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714328864;
	bh=HfgwZeVvsF2i06wNeH1wK9xQEXXX0R93e8MR9OP26AA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ts6pYZW6eyTY9+PYyPZtO8/V1mVA5dSfT5RaTPQassuvTFAbgixwqR64lA8/9C+gW
	 mPqbE/pMf3nkUBkQCedwHTTUhG1BRKvOsxxcOPl1Z5FR9UrxaPKigF9UQj+brNaTt0
	 +htzQy8HiFLkGgm93WfMJsRiSQn9v2AjwiPAkbn2wv+7APMff584QDFmxloNUeu3fH
	 Ppb+3OD4uMK3X5xk8LMFu3X6JOxsgE2jbqypbJK4jgiOaIs5MJePNP+WdB86xMx7Nf
	 5+1WUXDfc6bZ38gk9zna2+5jPkPSISpIyM2hCuVA9PYsMUsoW3MzUZ7ipMQObdmUxd
	 Gi9L8nXV+m1ag==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 28 Apr 2024 20:27:44 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-leds@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] leds: mt6370: Remove an unused field in struct mt6370_priv
Date: Sun, 28 Apr 2024 20:27:31 +0200
Message-ID: <e389be5e1012dc05fc2641123883ca3b0747525a.1714328839.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct mt6370_priv", the 'reg_cfgs' field is unused.

Moreover the "struct reg_cfg" is defined nowhere. Neither in this file, nor
in a global .h file, so it is completely pointless.

Remove it.

Found with cppcheck, unusedStructMember.

So, remove it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/leds/rgb/leds-mt6370-rgb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/leds/rgb/leds-mt6370-rgb.c b/drivers/leds/rgb/leds-mt6370-rgb.c
index 448d0da11848..359ef00498b4 100644
--- a/drivers/leds/rgb/leds-mt6370-rgb.c
+++ b/drivers/leds/rgb/leds-mt6370-rgb.c
@@ -149,7 +149,6 @@ struct mt6370_priv {
 	struct regmap_field *fields[F_MAX_FIELDS];
 	const struct reg_field *reg_fields;
 	const struct linear_range *ranges;
-	struct reg_cfg *reg_cfgs;
 	const struct mt6370_pdata *pdata;
 	unsigned int leds_count;
 	unsigned int leds_active;
-- 
2.44.0


