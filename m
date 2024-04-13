Return-Path: <linux-kernel+bounces-143739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C2C8A3CDA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E6828262E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A87B44375;
	Sat, 13 Apr 2024 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="GMbop/sH"
Received: from msa.smtpout.orange.fr (smtp-80.smtpout.orange.fr [80.12.242.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44A93FBA0;
	Sat, 13 Apr 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713015979; cv=none; b=pAVHqT8DvGJFdTRFbUiTEQ884jEyM/jH46iBH2ZejNgVAQVENGMxxEYCJCBSlo8L8jxFEKegYt+iG+p3yozsEBF40eG4MY0DVJ4IYCWnKdmT++381KXyXVocCKOo2pAgeFLvFyN4kKWOeReaFV7yVc7pxuNkWs25/7hP8f9Uw7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713015979; c=relaxed/simple;
	bh=OnfiB35imdR5sMCWt1WqIeixbXaY6poAeu8FP6exU1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jz5n42Wg0B9vJpfAVRGnPgOxEIoU9e9WVKL2cFR0HRgh0pF56xxbGp7Ands9mMv1opTbqWqCsEqiXao5VSWy6dCMxz58nwk3fPLXsR20u0zv9vivJ/JZ75RiGln66xo/4nozfOJ1WXpV4iEndJsOLgDHq84VltbBhIXByOKhqvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=GMbop/sH; arc=none smtp.client-ip=80.12.242.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id vdhtrWcZRReGpvdhtrWXe3; Sat, 13 Apr 2024 15:46:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713015974;
	bh=BzFLQk0tc7nJvHnWglQM8Su6e2Fg7qKNxgdXMkLp/P0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=GMbop/sHZEveuJhJRAEk17EMiI2jmrjk4CNgRAxP9QZNm1yXLqzck4InmZvXp0JWy
	 SjrG2/6/uNj/tuIqDwnngzKO1spPwNNtqZW0mWwVFfMWT+x04rIaPWD+0DyvfKKEAP
	 aykpC77FC4okV0InidXb+Tjzc/b72kEctRBhlxFnWLtlJpvdCJgDFVoXvCX6QptqJ/
	 eN/3UXvaXUSQf4dl6oZN9p/v7+YueowTZPbY9cq+8sh6ikBbU80GQLaqB67vP7fbc0
	 TnQ1qJVv8thydkwIvu8Fo3nz5bAvTuxdxoavFrScjqxXh+jPGBlJiHSPlgMF/GUDM0
	 a/BeDnOkI+PDg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 13 Apr 2024 15:46:14 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-clk@vger.kernel.org
Subject: [PATCH] clk: gemini: Remove an unused field in struct clk_gemini_pci
Date: Sat, 13 Apr 2024 15:46:09 +0200
Message-ID: <556770c7701868f9f1c0569674903bee3eff30cb.1713015940.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct clk_gemini_pci", the 'rate' field is unused.

Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

Apparently, it has never been used. It is not a left-over from a
refactoring.
---
 drivers/clk/clk-gemini.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/clk-gemini.c b/drivers/clk/clk-gemini.c
index ba0ff01bf4dc..856b008e07c6 100644
--- a/drivers/clk/clk-gemini.c
+++ b/drivers/clk/clk-gemini.c
@@ -67,12 +67,10 @@ struct gemini_gate_data {
  * struct clk_gemini_pci - Gemini PCI clock
  * @hw: corresponding clock hardware entry
  * @map: regmap to access the registers
- * @rate: current rate
  */
 struct clk_gemini_pci {
 	struct clk_hw hw;
 	struct regmap *map;
-	unsigned long rate;
 };
 
 /**
-- 
2.44.0


