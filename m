Return-Path: <linux-kernel+bounces-126910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB749894455
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541681F216F9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7EE4D5A1;
	Mon,  1 Apr 2024 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OG80Arm7"
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4574481BF;
	Mon,  1 Apr 2024 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992613; cv=none; b=FyRgy8WNezbvYgSi3hwg6nozeEuyXa1AHZ4yxWHX9ovJB7WU+TLz0TFMckJEC7uYf/p9NHJ/k2PIfwjHMqP/bZZfX7Gl1i41msw/5UyjcZxGzNFyCdtmAzdhTRSQlUOvWFYJ0OwMN1rD2PfeLabNkFFi7Q4y/4Q51jsjs5WEu8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992613; c=relaxed/simple;
	bh=2GW7LvQ/k+2zA/eFgtYcHdUDrylqo2s4FaCiIiR+q1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jo63Z29kUy1oflsReOHqan830Me+S4EmFp1x7ooG4uifM48VQQfzFYUW4wpsS/ySIETjMZpYbk9aTYCDOZVYx9LlOTSTDjtTEQwtwjC1MxBloMOXLJ0Hp5liK6Jdkl3WL5bvDGC7Gxsii0/FPTkD00eKNTE0G+iTfEKI09Bh8vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=OG80Arm7; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id rLTzrtoGMFDStrLTzrz7Im; Mon, 01 Apr 2024 19:30:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1711992607;
	bh=WCJsrsV8vLNvTZgdKOiZouZAVMrzQfL7VDSnh6ylrOM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=OG80Arm7XkLFOReigdtgBIMeqoplFDX7h5lDMj8uM1NwDNczTyYHPTp/YRjh5VRzs
	 p3KIJpL4p7UZWfPdhygxdo683/rcj3jdbd+ykhsimtneEKQ6o/d3bPgHVU2cgGdDyQ
	 sJ5Z0Ro/L3X1Y1me5JhzCCSpcFofViXmaGXYt9PxF9Z2qdSTLv5OC28zTekiwxlTxh
	 0VNzDHvGFXs5fBXRepu4yR72PPgpJOyohxEVdfGtgfj9wwXmSOpQfh6WSfu6Y27+eK
	 Fwu+zdUXpZNKpI5+L7XHeESdlg0wZjR5mgzHxzhUYN3/w0UdCYOWTlOJGqOv05x03j
	 GFB7+/YM3QIzA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 01 Apr 2024 19:30:07 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-gpio@vger.kernel.org
Subject: [PATCH] pinctrl: max77620: Remove an unused fields in struct max77620_pin_info and max77620_pctrl_info
Date: Mon,  1 Apr 2024 19:30:05 +0200
Message-ID: <60af8968864ae4a83a76e589b39a2b1e1f65c9db.1711992588.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct max77620_pin_info", the 'pull_config' field is unused.
In "struct max77620_pctrl_info", the 'pins_current_opt' field is unused.

Remove them.

On my x86_64 config, with allmodconfig, this shrinks the struct
max77620_pctrl_info from 360 bytes to 296.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/pinctrl/pinctrl-max77620.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-max77620.c b/drivers/pinctrl/pinctrl-max77620.c
index ab723ab4ec1d..d236daa7c13e 100644
--- a/drivers/pinctrl/pinctrl-max77620.c
+++ b/drivers/pinctrl/pinctrl-max77620.c
@@ -88,7 +88,6 @@ struct max77620_pingroup {
 
 struct max77620_pin_info {
 	enum max77620_pin_ppdrv drv_type;
-	int pull_config;
 };
 
 struct max77620_fps_config {
@@ -104,7 +103,6 @@ struct max77620_pctrl_info {
 	struct device *dev;
 	struct pinctrl_dev *pctl;
 	struct regmap *rmap;
-	int pins_current_opt[MAX77620_GPIO_NR];
 	const struct max77620_pin_function *functions;
 	unsigned int num_functions;
 	const struct max77620_pingroup *pin_groups;
-- 
2.44.0


