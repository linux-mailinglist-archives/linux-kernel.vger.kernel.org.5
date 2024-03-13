Return-Path: <linux-kernel+bounces-102660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985A387B572
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3969CB2255F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EFC604B0;
	Wed, 13 Mar 2024 23:54:40 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA65F546
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710374080; cv=none; b=la9NksIeAIfGt2A04lo6x3fKK0AvD3fjS2Yiaer2z5Mli6Z6EsfKtYEjv0xI8qE5KbL6jWz3Ve3abzh1nQfG/NuIryy9QcWL1gbjJENb6jSbn4f1EmnFoasBZpwimqC+F6oe6DHVKC6H31Y9kDuk8qdwfnh3SBKJhfSc8Mf1J34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710374080; c=relaxed/simple;
	bh=zeBdlgwqgx5wxRWTKXs76tXPrMlAR3YEbWfVlts1pHk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXFQyoM49LUy7p18O1amzQcSyuD5NdBhQAuouHgxgebBZRzgrXy3E4q7T1mhHH1b/x1Wd8AgYThtan8nBwDg/g7yVmjj+ha6margcsnOMZ/es06gUv0YSIGY+P3yuEfCF3NRMiL1KgBnQlyaEDXltUaGVoEha4edj8GBXvUDXt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 0b3b6ec2-e195-11ee-abf4-005056bdd08f;
	Thu, 14 Mar 2024 01:54:35 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 10/11] pinctrl: aw9523: Fix indentation in a few places
Date: Thu, 14 Mar 2024 01:52:13 +0200
Message-ID: <20240313235422.180075-11-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313235422.180075-1-andy.shevchenko@gmail.com>
References: <20240313235422.180075-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the comment, function prototype, and array of strings indentation
is kinda broken. Reindent that.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pinctrl/pinctrl-aw9523.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-aw9523.c b/drivers/pinctrl/pinctrl-aw9523.c
index 50e2a94f59892..7299b5bb6d52f 100644
--- a/drivers/pinctrl/pinctrl-aw9523.c
+++ b/drivers/pinctrl/pinctrl-aw9523.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Awinic AW9523B i2c pin controller driver
- * Copyright (c) 2020, AngeloGioacchino Del Regno
- *                     <angelogioacchino.delregno@somainline.org>
+ * Copyright (c) 2020, AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
  */
 
 #include <linux/bitfield.h>
@@ -139,9 +138,10 @@ static const struct pinctrl_ops aw9523_pinctrl_ops = {
 };
 
 static const char * const gpio_pwm_groups[] = {
-	"gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio5",
-	"gpio6", "gpio7", "gpio8", "gpio9", "gpio10", "gpio11",
-	"gpio12", "gpio13", "gpio14", "gpio15"
+	"gpio0", "gpio1", "gpio2", "gpio3",		/* 0-3 */
+	"gpio4", "gpio5", "gpio6", "gpio7",		/* 4-7 */
+	"gpio8", "gpio9", "gpio10", "gpio11",		/* 8-11 */
+	"gpio12", "gpio13", "gpio14", "gpio15",		/* 11-15 */
 };
 
 /* Warning: Do NOT reorder this array */
@@ -388,8 +388,8 @@ static int aw9523_get_pin_direction(struct regmap *regmap, u8 pin, u8 n)
  *
  * Return: Zero for success or negative number for error
  */
-static int aw9523_get_port_state(struct regmap *regmap, u8 pin,
-				   u8 regbit, unsigned int *state)
+static int aw9523_get_port_state(struct regmap *regmap, u8 pin, u8 regbit,
+				 unsigned int *state)
 {
 	u8 reg;
 	int dir;
@@ -984,8 +984,7 @@ static int aw9523_probe(struct i2c_client *client)
 	}
 
 	mutex_init(&awi->i2c_lock);
-	lockdep_set_subclass(&awi->i2c_lock,
-			     i2c_adapter_depth(client->adapter));
+	lockdep_set_subclass(&awi->i2c_lock, i2c_adapter_depth(client->adapter));
 
 	pdesc = devm_kzalloc(dev, sizeof(*pdesc), GFP_KERNEL);
 	if (!pdesc)
-- 
2.44.0


