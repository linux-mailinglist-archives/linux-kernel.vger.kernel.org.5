Return-Path: <linux-kernel+bounces-78955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF5F861B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EED128A693
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E11143C77;
	Fri, 23 Feb 2024 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="mhm9fG2I"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FE2140362;
	Fri, 23 Feb 2024 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712114; cv=pass; b=Gj56JcjHcl/dH/JPIqJKBNfDi6PJYIlt0qvX96u2vOowKlFao9kolaf7joQyU+7aX3Tc2TuYsebCA1HCTa2kdJMxpAvwDLqU8ws3tuFvzjoyhn545fmKlCABnVvrOA8ESVPHdiIuDnma/kQBc6NV2HoumWQg/DedVjVCCAs9BHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712114; c=relaxed/simple;
	bh=9HRYRnXfj6+3p6mGWDv0/h3ASIdvtbtBeqAitQNheMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rOpeE0SgE38ADe68/xpY6s8d05RMEzb2Sd0rBuwgd9rsX1rT+Gp0+reSgrGEeDTLo/FGJYzoujKO+WlxzEHbVnzWgr7x9DFNWNGNBxBQi/jeMLFTCzTuajc5BnZdBBqpDAUDfKuuqdjnnjt6p1Q7H+XeJG2TdHiihOpi6wRPzik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=mhm9fG2I; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from darkstar.musicnaut.iki.fi (85-76-119-15-nat.elisa-mobile.fi [85.76.119.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ThJ8847WBzyWT;
	Fri, 23 Feb 2024 20:15:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1708712104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgHYKl8nENz0zRcm1GC7MSy4sfSrbhDj/i7Fo3D2m+c=;
	b=mhm9fG2IuNW8DH94X2N/P0Dfw4dOPHGXvhIQIvqlTYTB3n6DNJ2BZ6GJc1w/J4RFSK8dxZ
	insFDKCeh/xXIKd32/+0NgfGD3rmFRsuWf5IbaQU95/OoJMikA8eQxkhvvseI8WVOUZ/gm
	ysYFG4OPoXU1nJFZm1loaTuMvUy8AgY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1708712104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgHYKl8nENz0zRcm1GC7MSy4sfSrbhDj/i7Fo3D2m+c=;
	b=rXrBNAPdjRL9OlYlelkn8jautSQcdYEGnyCYVe4R7fUn8UM3Z/jYlSTb1iKjkHOGEY1HVP
	ACpSEdXR3nppDl4ewHFLZeRCt5b+NFlGHsdWI7dbWe9msMREVJGMwevbmDYXTMeZ7YbsF3
	af5yBeOBKnkJjB8nlPH5ixGvGXjIxV0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1708712104; a=rsa-sha256; cv=none;
	b=Ahxz2dx8SaMjCL1c9kMHyJkveRGeC07+djb/HOFrcq+2oleDF+07QKYrEMVRA91jKEIc+C
	5tXgL0Uj6wLWQE/UowfUD1vv2SzWPbebssh+/KriZ8Vkq+SQgmsrVYuv4ipxCTZblECFi2
	mSgw0Mwbbq84+BrqH9lxaZgXAL94hFc=
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Tony Lindgren <tony@atomide.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 3/5] MMC: OMAP: fix broken slot switch lookup
Date: Fri, 23 Feb 2024 20:14:37 +0200
Message-Id: <20240223181439.1099750-4-aaro.koskinen@iki.fi>
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

The lookup is done before host->dev is initialized. It will always just
fail silently, and the MMC behaviour is totally unpredictable as the switch
is left in an undefined state. Fix that.

Fixes: e519f0bb64ef ("ARM/mmc: Convert old mmci-omap to GPIO descriptors")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/mmc/host/omap.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 9fb8995b43a1..aa40e1a9dc29 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1384,13 +1384,6 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	if (IS_ERR(host->virt_base))
 		return PTR_ERR(host->virt_base);
 
-	host->slot_switch = gpiod_get_optional(host->dev, "switch",
-					       GPIOD_OUT_LOW);
-	if (IS_ERR(host->slot_switch))
-		return dev_err_probe(host->dev, PTR_ERR(host->slot_switch),
-				     "error looking up slot switch GPIO\n");
-
-
 	INIT_WORK(&host->slot_release_work, mmc_omap_slot_release_work);
 	INIT_WORK(&host->send_stop_work, mmc_omap_send_stop_work);
 
@@ -1409,6 +1402,12 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	host->dev = &pdev->dev;
 	platform_set_drvdata(pdev, host);
 
+	host->slot_switch = gpiod_get_optional(host->dev, "switch",
+					       GPIOD_OUT_LOW);
+	if (IS_ERR(host->slot_switch))
+		return dev_err_probe(host->dev, PTR_ERR(host->slot_switch),
+				     "error looking up slot switch GPIO\n");
+
 	host->id = pdev->id;
 	host->irq = irq;
 	host->phys_base = res->start;
-- 
2.39.2


