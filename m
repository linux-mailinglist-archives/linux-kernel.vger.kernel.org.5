Return-Path: <linux-kernel+bounces-82363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DF286833D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7B31F2D3D8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED4D131E2B;
	Mon, 26 Feb 2024 21:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="EbHd1cNx"
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D866B12C7F6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983476; cv=none; b=ILr7zEu3MRfj8ko8+afRwNSeA2+kK/fQ5YzVw/2wa/yT0tcF70d8PAPJ47wN62IO12Oou6A2W29rBp9qqlfn6AujvCphcPUulJjbszCy2jiQub1o6eGGzpN1Kt1jGMW3BQAt6Od54vdkILSoyICcm9/dybOzcI8IbnT0z/hiXMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983476; c=relaxed/simple;
	bh=ie89sVvbplEsqZ0131OZ4+yw637SSmyv+UFSLp8ibI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JsUPWhPeVvtBPaM2Do9lBYx8jSehv49quWzBdunPRm6iBWho/hFo/Y92D9ZgXoGn7R0nkMS078YzC5EQvSsf9Y09QEmS9LXVu3/iSXguKR7GmMhvKprmf/m6Vm4FA3MHVDkxHv0uQWrfxNXG7pLYt56xvhh3wwplULEvgj3VjIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=EbHd1cNx; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id eifMrgtXR2yuveifMrNhV5; Mon, 26 Feb 2024 22:37:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1708983464;
	bh=tmMG+U7Q36q6vKuwv+d+vvsnLJBFXkQVcXONSgONuqI=;
	h=From:To:Cc:Subject:Date;
	b=EbHd1cNxsqDB/7L7O3dFeESKpvfjpaziXl8cs2mYfQDbXQtoSYlkc22Wfa9TC+qde
	 VDI271L0tQe7rDZyDsTSjP+Ph2VjZW3/KXToNCR9LpfUmzBBqPQRvRoILYspKKuXDU
	 lh5HYbXGmnzqD36rGX30QVRAL9tGr5DjXJcVX0lVJfIjIbVOUJ1wCsbL0oMFiE9VUo
	 y02tan8z+AgeYwvAs7/0k0lKaaNb/YNXvzQJVIp7q9MtxC+0YzCpwkEWt8sia/ereP
	 krz6UXoVbwY5bZBaCYxESI0o4CSzfS1WfB5caVDfrNpGDRE16JnfY6DheVYoTiyPcQ
	 xdiytd6XxcL6g==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 26 Feb 2024 22:37:44 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: ulf.hansson@linaro.org,
	cjb@laptop.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mmc: wmt-sdmmc: remove an incorrect release_mem_region() call in the .remove function
Date: Mon, 26 Feb 2024 22:37:39 +0100
Message-ID: <bb0bb1ed1e18de55e8c0547625bde271e64b8c31.1708983064.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This looks strange to call release_mem_region() in a remove function
without any request_mem_region() in the probe or "struct resource"
somewhere.

So remove the corresponding code.

Fixes: 3a96dff0f828 ("mmc: SD/MMC Host Controller for Wondermedia WM8505/WM8650")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative. Review with care.
Compile tested only.
---
 drivers/mmc/host/wmt-sdmmc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 77d5f1d24489..860380931b6c 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -883,7 +883,6 @@ static void wmt_mci_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
 	struct wmt_mci_priv *priv;
-	struct resource *res;
 	u32 reg_tmp;
 
 	mmc = platform_get_drvdata(pdev);
@@ -911,9 +910,6 @@ static void wmt_mci_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->clk_sdmmc);
 	clk_put(priv->clk_sdmmc);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
 	mmc_free_host(mmc);
 
 	dev_info(&pdev->dev, "WMT MCI device removed\n");
-- 
2.43.2


