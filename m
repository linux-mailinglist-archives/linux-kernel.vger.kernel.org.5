Return-Path: <linux-kernel+bounces-161518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2624E8B4D19
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D555F281429
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FBF73194;
	Sun, 28 Apr 2024 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="EhAuTmf2"
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19A11DFC5;
	Sun, 28 Apr 2024 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714324554; cv=none; b=YHPAg5L4Y+nfuecd8PQeMZ5gpG0eC2N3DMBMLtDNJDp/CuhsDi26ZqEAqTXA4+HcdSi2k438t9JlqtVSPo9LX36oL+rbFpdHTKql+1jp26DKE42zmKQHFgjYKak5x34BOM78vBA2rsY9EjtAwueL4Dn+niv9pgPzm4XeBsQlEBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714324554; c=relaxed/simple;
	bh=2KHTn+gBnvvbtZfhLE6uBJkjWrOqKvIQgnSHQYp8Vvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cbej6UZVwW/S1Odz8/5je5dKAZy7Z/Y/MYJsT/TNJjByOkoNmP2g2IuMqRGngQjQypJ42PzRSwHO994Vc4yA/SW9xyX7bmAO5sO3u4dAh+hWURbNAx1Nx9am4RLU4m15C6nzxHgHFsTKPr18pTongFJTSH78tYdA4RYxghkYEXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=EhAuTmf2; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 187rso5aKhCCi187rsyVv2; Sun, 28 Apr 2024 19:15:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714324544;
	bh=BK7RPti6UkUvOmAIkmd/9QNpbw8XpoHnN+HqRtfulTg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=EhAuTmf2or+j6lTj88rnGXo2YukhSn7MMNKI/e9G4bdE47O+60stWBz3C8JiZNlL0
	 51PPkwi33sCMpgxr31fHyK0kb21yMQ3k3jeLwyjB77OwmxTiYnlvF0flg51V6i84pS
	 Vd7vl+7Wg/F6x8B8KMm9GNwQL+Tzzg3hbQfZmTH7jxF1cspmCb7YviZDoFxVK5+RCW
	 T4FDurAq2boUSy0Ap4jcKnWtTIyYQChPvD60A4boXJWi/aMwbPyTPC6LwY7zp8DjJx
	 bPOIpGLnXD1UIrE3NLYpy4DjNaAL7JrKNi4lTPbcwij5tchLaIRZVzJ2GVSB72LJQl
	 o8qU2/I4B46wg==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 28 Apr 2024 19:15:44 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-leds@vger.kernel.org
Subject: [PATCH 1/2] leds: lp50xx: Remove an unused field in struct lp50xx_led
Date: Sun, 28 Apr 2024 19:15:24 +0200
Message-ID: <bc2e5e57b93ca0a33bcc84e9bdc89f26fc8f6d57.1714324500.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct lp50xx_led", the 'bank_modules' field is unused.
Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

It was added added in the initial commit 242b81170fb8 ("leds: lp50xx: Add
the LP50XX family of the RGB LED driver") but was never used.
---
 drivers/leds/leds-lp50xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/leds/leds-lp50xx.c b/drivers/leds/leds-lp50xx.c
index 68c4d9967d68..407eddcf17c0 100644
--- a/drivers/leds/leds-lp50xx.c
+++ b/drivers/leds/leds-lp50xx.c
@@ -265,7 +265,6 @@ static const struct lp50xx_chip_info lp50xx_chip_info_tbl[] = {
 struct lp50xx_led {
 	struct led_classdev_mc mc_cdev;
 	struct lp50xx *priv;
-	unsigned long bank_modules;
 	u8 ctrl_bank_enabled;
 	int led_number;
 };
-- 
2.44.0


