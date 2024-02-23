Return-Path: <linux-kernel+bounces-78956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0F5861B50
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED861F2819A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF36143C7F;
	Fri, 23 Feb 2024 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="kV7Qq7QZ"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC8384FA6;
	Fri, 23 Feb 2024 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712114; cv=pass; b=qm2k5M8g8AmfH+VVnj3GdwSWoLQ9dJtcy+2x0MwnCUGvvPtzkn+ZFlvz+yAWxsrbGr3udcin3u8FcUTpJgTaaXDtajOMTpvxuusXvCTwvDPe4QX4RkFfZNSLp84a4qJDqaeXio/dYUenjdKzwL+mobCNjIys9eGLOmmjCzzh2y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712114; c=relaxed/simple;
	bh=DVQT8mx6aHoQZtSl3ApWVIvMP4rDyr8mAYJaMsZ94xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=itCZNvs1fL9uRjxtoAcFkzHe0sSYpJpPZw7UILN7ViOST49w1+bkYy5w3BMa+R5UpLk6gWlQljQLI01ZnzifGn8vhz/kNdkp61rt40e5zFx33TiGm0uCclTgvMWq+IdE4wWUx/ykF4tagFEyS3o3MMCT57CygYgg0UfaMk4Znak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=kV7Qq7QZ; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from darkstar.musicnaut.iki.fi (85-76-119-15-nat.elisa-mobile.fi [85.76.119.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ThJ8808HWzyxR;
	Fri, 23 Feb 2024 20:15:03 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1708712104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kT1h9facss0h5Q/m27As0W2i7G4ODNF3k2VDGvzk920=;
	b=kV7Qq7QZKS6AYXDAOCO0cOOpnce7vauAImPKOsPXC3DQmsvmC0h6Ic7gWaRewQbVYel1S2
	FhZf9dlxpaxYdYIh9mDwRjwWWKNZyB1qzL7kBpGG4xUHrxAKOgX7qLN02+x4a7rvlE64X/
	8MLteaHvIl1tpFUoSPkQsWbFowqCEvE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1708712104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kT1h9facss0h5Q/m27As0W2i7G4ODNF3k2VDGvzk920=;
	b=HIlUsDtGnF4l9ArAeFfLSepnCdnS0iNXtP+5CIUtqs1wC3uCuBdJ76fTvcy3dygLAzPmq+
	IGuf4laYdCoxn6Le8KcQxZfUTl2aXc3EvhmU7ar/ycwzLvQWHZzrc5PjSixD10jxNLMeFx
	wnhoddnpCEwvRpvbmNgRS7C3qvyo3Go=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1708712104; a=rsa-sha256; cv=none;
	b=q8C8NR/mkD9ylUtUeuVeKNuupZxIBP7EHdN43if27vDmRn52hXFpzUZ06/s0KU6mWS1KQj
	abfDRlrclAbApZQkcQ2OkDHdUDRK7AgiVO7F2IxOSjnFd+FvVu7IAID5IldZZqJcuOCUOl
	3M7fEQY3FjNX3vXKtU8cnmjSTWi8wyw=
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Tony Lindgren <tony@atomide.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/5] ARM: OMAP: fix N810 MMC gpiod table
Date: Fri, 23 Feb 2024 20:14:36 +0200
Message-Id: <20240223181439.1099750-3-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240223181439.1099750-1-aaro.koskinen@iki.fi>
References: <20240223181439.1099750-1-aaro.koskinen@iki.fi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trying to append a second table for the same dev_id doesn't seem to work.
The second table is just silently ignored. As a result eMMC GPIOs are not
present.

Fix by using separate tables for N800 and N810.

Fixes: e519f0bb64ef ("ARM/mmc: Convert old mmci-omap to GPIO descriptors")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap2/board-n8x0.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 3e48f34016c1..c933a91751e4 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -140,7 +140,7 @@ static int slot1_cover_open;
 static int slot2_cover_open;
 static struct device *mmc_device;
 
-static struct gpiod_lookup_table nokia8xx_mmc_gpio_table = {
+static struct gpiod_lookup_table nokia800_mmc_gpio_table = {
 	.dev_id = "mmci-omap.0",
 	.table = {
 		/* Slot switch, GPIO 96 */
@@ -152,6 +152,8 @@ static struct gpiod_lookup_table nokia8xx_mmc_gpio_table = {
 static struct gpiod_lookup_table nokia810_mmc_gpio_table = {
 	.dev_id = "mmci-omap.0",
 	.table = {
+		/* Slot switch, GPIO 96 */
+		GPIO_LOOKUP("gpio-96-127", 0, "switch", GPIO_ACTIVE_HIGH),
 		/* Slot index 1, VSD power, GPIO 23 */
 		GPIO_LOOKUP_IDX("gpio-0-31", 23, "vsd", 1, GPIO_ACTIVE_HIGH),
 		/* Slot index 1, VIO power, GPIO 9 */
@@ -412,8 +414,6 @@ static struct omap_mmc_platform_data *mmc_data[OMAP24XX_NR_MMC];
 
 static void __init n8x0_mmc_init(void)
 {
-	gpiod_add_lookup_table(&nokia8xx_mmc_gpio_table);
-
 	if (board_is_n810()) {
 		mmc1_data.slots[0].name = "external";
 
@@ -426,6 +426,8 @@ static void __init n8x0_mmc_init(void)
 		mmc1_data.slots[1].name = "internal";
 		mmc1_data.slots[1].ban_openended = 1;
 		gpiod_add_lookup_table(&nokia810_mmc_gpio_table);
+	} else {
+		gpiod_add_lookup_table(&nokia800_mmc_gpio_table);
 	}
 
 	mmc1_data.nr_slots = 2;
-- 
2.39.2


