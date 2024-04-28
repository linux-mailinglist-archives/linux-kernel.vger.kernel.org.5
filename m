Return-Path: <linux-kernel+bounces-161524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730F18B4D2D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48121C2096E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D3673506;
	Sun, 28 Apr 2024 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ed0LQV1E"
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA93BBCA;
	Sun, 28 Apr 2024 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714325127; cv=none; b=QOLADktJxRr6rjoqZU+C8sPhSrD2AfnGPhYeLnu9BOKTpwVBCi7GZGE89yBTLgRh3el+a8MSoQEKWJaFkuQX6nOYB3tOQs6r4kmX++sNWkqEKcVZGhReOXWg8nKFHJeJJU8nSQvNhhN/wMLud7LUn6AmtHbNS1esR8BnsOAVlCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714325127; c=relaxed/simple;
	bh=5Ie8qBiBobpvq91m8AfEjh4NgFLM5+PpWwD6L45jGsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLqtx6GSNl8U62BhwebXP5ETWVcoFFIywcYR+SVIhr8EOMc1JWEkYybtOGMVPTQOyjXeYlwPXf6y7V+AfHVqyLNVYgihis2vqXAIDjHWRIT35dUnsYnGX1xp/CjPnPxrUu6qo5geYDs8ocY/SvRDtB9Ifvnqo5Eaf271Ud5VoFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ed0LQV1E; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 187rso5aKhCCi187ysyVvo; Sun, 28 Apr 2024 19:15:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714324551;
	bh=5CZgwmjLxv43WMhGXX/Yzm0AcpGimpypUVeUw8u1ncs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ed0LQV1EVZScxldK46Qkqnyk6u95rniGUT3+SheeNMfBTOOE5RasW+Jy5QDMb3hYo
	 nhKlu4DH3YvdGfJZXDrHyyGdxA8k2mnJV+tWV55gqsWs1EbmaWdRS7Zo7KeiA81OYy
	 1HLwkDK4i2APklK5H5es5gr6MUFjwFBYrm0pHvKPhiqVLjMIMySIxLn6Oq9qWc2QGk
	 WCZK1jy73Itd31EFP6sbaxu3cGzUhQccKeyxnR8+MZMYriOCiuDkyYAbJqwJK6/3xy
	 IzTBAmmjjwYjBu/gKPq2u5kZDBNQHWtA/Bs2//pcV90GHaL4Gi6jLlqvQ3FvUc78K4
	 cd498XOTL1JjA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 28 Apr 2024 19:15:51 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-leds@vger.kernel.org
Subject: [PATCH 2/2] leds: lp50xx: Remove an unused field in struct lp50xx
Date: Sun, 28 Apr 2024 19:15:25 +0200
Message-ID: <a0d472ff587d13a2b91ec32c8776061019caab6a.1714324500.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <bc2e5e57b93ca0a33bcc84e9bdc89f26fc8f6d57.1714324500.git.christophe.jaillet@wanadoo.fr>
References: <bc2e5e57b93ca0a33bcc84e9bdc89f26fc8f6d57.1714324500.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct lp50xx", the 'num_of_banked_leds' field is only written and is
never used.
Moreover, storing such an information in the 'priv' structure looks
pointless.

So, remove it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/leds/leds-lp50xx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/leds/leds-lp50xx.c b/drivers/leds/leds-lp50xx.c
index 407eddcf17c0..175d4b06659b 100644
--- a/drivers/leds/leds-lp50xx.c
+++ b/drivers/leds/leds-lp50xx.c
@@ -278,7 +278,6 @@ struct lp50xx_led {
  * @dev: pointer to the devices device struct
  * @lock: lock for reading/writing the device
  * @chip_info: chip specific information (ie num_leds)
- * @num_of_banked_leds: holds the number of banked LEDs
  * @leds: array of LED strings
  */
 struct lp50xx {
@@ -289,7 +288,6 @@ struct lp50xx {
 	struct device *dev;
 	struct mutex lock;
 	const struct lp50xx_chip_info *chip_info;
-	int num_of_banked_leds;
 
 	/* This needs to be at the end of the struct */
 	struct lp50xx_led leds[];
@@ -403,8 +401,6 @@ static int lp50xx_probe_leds(struct fwnode_handle *child, struct lp50xx *priv,
 			return -EINVAL;
 		}
 
-		priv->num_of_banked_leds = num_leds;
-
 		ret = fwnode_property_read_u32_array(child, "reg", led_banks, num_leds);
 		if (ret) {
 			dev_err(priv->dev, "reg property is missing\n");
-- 
2.44.0


