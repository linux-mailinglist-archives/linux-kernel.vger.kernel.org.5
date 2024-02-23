Return-Path: <linux-kernel+bounces-78954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 382EB861B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE1D1F27784
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09619143C63;
	Fri, 23 Feb 2024 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="NVso89HF"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECB813DBA8;
	Fri, 23 Feb 2024 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712114; cv=pass; b=L0nwGLNAfjia6oJARfy47b1O032y76M3GAuviuWUEDC3EYsfyTFSSPbB2AvJ3kJCM2XDA7fcpOlTYThqE628bx2upsBq1pF1PEkhADbfnjZnrtDIbFwUcgQF78+fa5UANG5XoSdIjpT3ypbDI8xz+6R8rXRjj4ffMkeY9HfLKao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712114; c=relaxed/simple;
	bh=ohm1BuRwL5Vhi0zBQ+dOazp2gwS8tFvdQ1N8/JNAlQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YkPrZY4DyzBeuxAtqJEms3IeKe285vMqh8gj9TV5UZkLOEmRxbBPQWFF3a4zcZe0TUPjMFQR68xT7coJvD/uj0ZYNEQ54Rg56FcZa+JTG+K+WGzhPdW7eZftemHK5PwCCaxqcTfTdw1gDTxBqT+KTetCknIgDVnh5XWQaTt/HdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=NVso89HF; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from darkstar.musicnaut.iki.fi (85-76-119-15-nat.elisa-mobile.fi [85.76.119.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ThJ8710n8zym3;
	Fri, 23 Feb 2024 20:15:03 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1708712103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPdR1MvtktsAtCs1c7d+8gSeJSZYOv6Ob1/SOA8y6c8=;
	b=NVso89HFhmYxAQTs6SzwUfF9oiJnzLMvhDcWeAq8/1YsZrY/lWKd+23RloAOtVKQ3C3+Wq
	9hQ7zO4TunUfg0aCOUUoliZG/9D6U1GJx0n85sGaEvfMk4oL08xM3D1RD1JlO007vT7Dv1
	/X00tZusMiT/U9lB+eJ2wGtnW7H4tII=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1708712103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPdR1MvtktsAtCs1c7d+8gSeJSZYOv6Ob1/SOA8y6c8=;
	b=NxEM0iCWG34hq/UmByTWBnyjN9+FrrdWG/dk52OZ2MH84BsanTbnc+/dfc8XEOAe3dgdP5
	E2ZZmVLbDw/iiRcUaXu2nRrccum/7TVyDuGuKhv8nMkq/79OjlYNOfE49Q/JESNrehPTiQ
	r25OJm18Wg+G87nnFdKRIlVH58cTxOE=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1708712103; a=rsa-sha256; cv=none;
	b=zQRsAG/vUV1GLeW6lWXAiLigaSokm2uQUwUZbI540AwmaKyNioiOuwgpEZKk3Jtf1Ksrha
	2XB2IozW7ukcT9dCo4GrPO4JvLTRx/3cFFubn+5oV0qoXGCmRVcM+ThSIQ+qMMzIZ1n5PG
	EBAdGUpK8X8FRxsJKrY/Y/YvNyZRzsQ=
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Tony Lindgren <tony@atomide.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/5] ARM: OMAP: fix bogus MMC GPIO labels on Nokia N8x0
Date: Fri, 23 Feb 2024 20:14:35 +0200
Message-Id: <20240223181439.1099750-2-aaro.koskinen@iki.fi>
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

The GPIO bank width is 32 on OMAP2, so all labels are incorrect.

Fixes: e519f0bb64ef ("ARM/mmc: Convert old mmci-omap to GPIO descriptors")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap2/board-n8x0.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 31755a378c73..3e48f34016c1 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -144,8 +144,7 @@ static struct gpiod_lookup_table nokia8xx_mmc_gpio_table = {
 	.dev_id = "mmci-omap.0",
 	.table = {
 		/* Slot switch, GPIO 96 */
-		GPIO_LOOKUP("gpio-80-111", 16,
-			    "switch", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-96-127", 0, "switch", GPIO_ACTIVE_HIGH),
 		{ }
 	},
 };
@@ -154,11 +153,9 @@ static struct gpiod_lookup_table nokia810_mmc_gpio_table = {
 	.dev_id = "mmci-omap.0",
 	.table = {
 		/* Slot index 1, VSD power, GPIO 23 */
-		GPIO_LOOKUP_IDX("gpio-16-31", 7,
-				"vsd", 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-0-31", 23, "vsd", 1, GPIO_ACTIVE_HIGH),
 		/* Slot index 1, VIO power, GPIO 9 */
-		GPIO_LOOKUP_IDX("gpio-0-15", 9,
-				"vio", 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-0-31", 9, "vio", 1, GPIO_ACTIVE_HIGH),
 		{ }
 	},
 };
-- 
2.39.2


