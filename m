Return-Path: <linux-kernel+bounces-78962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F05861B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55022863F5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81DC141997;
	Fri, 23 Feb 2024 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="XFzrab5M"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C8482D75;
	Fri, 23 Feb 2024 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712230; cv=pass; b=OkJxv263ZRAWbMproUVprlHHCHnu5EwAnYDEsHSccyZZTGOsoGAk+K04s1fHznDX72JamH48za1XSn2XyjxW6q1hvtEhbxbTK29PA0DxIARQ45sKyXJUZAlJJwIDlXAu7FF1YKA1mseGgatacWhuxyzk30Ps9kNeESPn3a18v9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712230; c=relaxed/simple;
	bh=UnHO//zbQp3E0b+TWqlFBDpGy66PKnN0EYmZigyEM+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PewmwcL3xYZersz65CPt3ZX/vv6D0nQ0itAY4iIwolHUucFxcV3lMk20ZmGEyAXAIoAL5u09gMPm1bT1T4hEuW/MeKRD/dQUdFS5CSX0GkLueNNXzukDwyWvimZmomAjkw6RWLdoUmTf2J0Z6Gpq1V4wCTEtxF7nPyyQ4DTbC4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=XFzrab5M; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from darkstar.musicnaut.iki.fi (85-76-119-15-nat.elisa-mobile.fi [85.76.119.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ThJBT1xnsz49Q4F;
	Fri, 23 Feb 2024 20:17:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1708712225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4X1SqJRLoyVDpNjMCxttYG0uyN3HqAPjkorhRgIr6i8=;
	b=XFzrab5MLjJgERNjGb/7v+7tC7R864MSr8K9U0EoaKmWKWqlgugoLzYR/j2aPTLbFbbQZV
	nt8D4vUsS7ilBVju5rr9nyYCWWjsbSmOeb3bskm5j70Ywhu15M/EixMmZJuK7tC9zhcE2v
	9E5o/sCbWfxQttLsTuJpZhlsWVZP+EOJbWhK2CkU+lJk/HCOR3J7dCUlzWJMTyqrXAuu5t
	OB+8zUp+ucqIelYbSVejEDHwfuiG8RHFNNf1NEYVjb+0G6JeSDpAG4rX3C9cLayP4gaWFo
	aQtUa7cgvjT8AUCOiMP5W5J2B1yyZ0yBY8iTMP0/aa9Q010tUUvE2C75eNE6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1708712225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4X1SqJRLoyVDpNjMCxttYG0uyN3HqAPjkorhRgIr6i8=;
	b=PjUopxeefUJCPCHhylN3pUhQumHLSWZiuGsuSSdRjZBTx0kGqKCUeEbqJiU2N+uVtQ1MCB
	z71nVUrrFTdnOw6bq8YiCVwU/V1OhhOT2QLWKUX80T8WzjEtcUPu7S9O2cQaX8bR63gsRG
	OWwp9MXu109Tlq9iVuyQDBPcyCYGYaMWV1jeEU2/pqsslp71t75pisFexnj0op03PIXYkk
	ESyBxtM+7VNGtYp9V/MU9UF0FaTx4AgRU3mtyflY0xvWpoCc64BfGovOOHe80j/KK9F9hz
	UzY115uH8yHs5kv79ZzS6giuBS6FbjaX1C1USMiKfaihjFBIZRIKfbTsCN3CQA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1708712225; a=rsa-sha256;
	cv=none;
	b=lDvEB5ohlFJZSVYN1wLzL+HJKjBYup0AYxJJOhLcA/5XyotsLHy7C634HYjCDi7+40AVpk
	IUJ0YL2KG9SajHYEhwa9hZFv2Z+cx2cvb22Lpnyk4A/XthJhKtJp01NJOG4/2wRqN1GspX
	1SvAA04rMEZAc9OA38SagmV5OW5iUvcp64S/eP8NUth7TgGnDNOgEXYF1YI5onomSxEshr
	noxY880t77ryFaluAkE5tdkSqrro+6PeDKJOzY/Vz9RCwMYd1sHJqsJM6WWZnBWEYcyFoq
	cwlaEY4uhka4nJ7qFVMFt5c3LhRKQ6wd5sybOfAlsRwe3JHnrlyQbZPoXFSt8w==
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Tony Lindgren <tony@atomide.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ARM: OMAP: fix USB regression on Nokia N8x0
Date: Fri, 23 Feb 2024 20:16:56 +0200
Message-Id: <20240223181656.1099845-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GPIO chip labels are wrong for OMAP2, so the USB does not work. Fix.

Fixes: 8e0285ab95a9 ("ARM/musb: omap2: Remove global GPIO numbers from TUSB6010")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap2/board-n8x0.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 31755a378c73..2c91148c1b39 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -79,10 +79,8 @@ static struct musb_hdrc_platform_data tusb_data = {
 static struct gpiod_lookup_table tusb_gpio_table = {
 	.dev_id = "musb-tusb",
 	.table = {
-		GPIO_LOOKUP("gpio-0-15", 0, "enable",
-			    GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("gpio-48-63", 10, "int",
-			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-0-31", 0, "enable", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-32-63", 26, "int", GPIO_ACTIVE_HIGH),
 		{ }
 	},
 };
-- 
2.39.2


