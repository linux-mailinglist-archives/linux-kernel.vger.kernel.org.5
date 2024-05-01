Return-Path: <linux-kernel+bounces-164972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0A18B85A3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B38E283AAD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C423A1AB;
	Wed,  1 May 2024 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="WnkAf95+"
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B097F;
	Wed,  1 May 2024 06:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714545650; cv=none; b=FaNiP+gZTXL4W+RSZMEVeY8JzedGbXabUaPoPOLgomH4xL0zD7FDW6AY2kXCSOMpFs41/V6wFrZZV6wD8uXOfVawhkydRbPCydOro8VCYYOuX5HdJjH94g6oR7hZA6zpoFkP4XJVrf7hj80id3sxogSRlMbWpgPe1+C9VEA+OWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714545650; c=relaxed/simple;
	bh=jwpq3kwYkzSPEXjkj9TFl0nGYtXu+Uj8RtrpLHaLqKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qzaNPUo+t4gi1eua0loyVKJciYZoHWKhi2YdgWghVp7z8bytjDBUaCSPw2077mjbdW3nAbhCLoQ5UO+KqikFgQxiUvXtBcq83ak49Wc7K3LxZtHbnnzEnVXfuXzWfKOs8hpcTF0pih13oR97My6VWNy7yaSRNOEuO0Go5EvyIsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=WnkAf95+; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 23cpsg4WsiGtU23cpsV8pf; Wed, 01 May 2024 08:39:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714545574;
	bh=M+oQc6JbU4H5ILw/Gp3smalwG/kTbPKlBTcVS0kEisI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=WnkAf95+yRHSkMlpztZS8xaysBAf3t08wYpfMYHH0R9u0FbYZAvbG3PnynE9rdVQk
	 WvqVpb3yQNf7CLlwv/jv7ns7vvvBk+ew/R8YyN6QSKLKHU28ns1HpEQ0NKPHcB8Oql
	 a47Hil64smDlKkazEwBV4sH9ZtbOfB4fdRXtT1ekiY5D7HX1/gD08mYKZFiid/y6uz
	 KaRB+0tB5cF/FtJSmDdzK+FUBmdw7KlxHEXeK2SjmmDeb5b5v5ZZoCM4N1hEEJHWOr
	 U+7mcdbBu1wj8X3KnBvIivtJeO7h6mQ2mqXypTU3429ooU2ppu8W9Pae4O15liyPVB
	 Orh0/FQA/aNUg==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 May 2024 08:39:34 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] Input: lpc32xx-keys - Remove an unused field in struct lpc32xx_kscan_drv
Date: Wed,  1 May 2024 08:39:23 +0200
Message-ID: <e006dfb77e35762c6e4f8ba6ba792b0c52fde375.1714545542.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct lpc32xx_kscan_drv", the 'irq' field is unused.
Remove it.

Found with cppcheck, unusedStructMember.

While at it, move the 'row_shift' field in order to fill a hole in the
structure (at least on 64 bits arch).

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

It was added in the initial commit 69690bec400e ("Input: add support for
key scan interface of the LPC32xx SoC") but was never used.
---
 drivers/input/keyboard/lpc32xx-keys.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/lpc32xx-keys.c b/drivers/input/keyboard/lpc32xx-keys.c
index 322a87807159..423035be86fb 100644
--- a/drivers/input/keyboard/lpc32xx-keys.c
+++ b/drivers/input/keyboard/lpc32xx-keys.c
@@ -57,14 +57,13 @@ struct lpc32xx_kscan_drv {
 	struct input_dev *input;
 	struct clk *clk;
 	void __iomem *kscan_base;
-	unsigned int irq;
 
 	u32 matrix_sz;		/* Size of matrix in XxY, ie. 3 = 3x3 */
 	u32 deb_clks;		/* Debounce clocks (based on 32KHz clock) */
 	u32 scan_delay;		/* Scan delay (based on 32KHz clock) */
 
-	unsigned short *keymap;	/* Pointer to key map for the scan matrix */
 	unsigned int row_shift;
+	unsigned short *keymap;	/* Pointer to key map for the scan matrix */
 
 	u8 lastkeystates[8];
 };
-- 
2.44.0


