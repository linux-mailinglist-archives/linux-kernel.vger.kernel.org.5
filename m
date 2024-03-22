Return-Path: <linux-kernel+bounces-111467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 007E2886CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82EC2B24782
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881AD45C04;
	Fri, 22 Mar 2024 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwsf1oQf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D244C89;
	Fri, 22 Mar 2024 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113730; cv=none; b=QcIJy0G+DahxS15b6TD6yZ4AtnTCyweWv0R38kFReTeOxAOIIxLbTmssKUvBVkWkp7MPgZ2jnz7R/6S1HNRSMqYCyixs4+GdlOobZq6SkOt1Jhia4frprfyYK8AkoqDOWNsNcvBQLwqu5i63xkNpKEHi9dlyYm1cEOABjM/np4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113730; c=relaxed/simple;
	bh=IzPTHowQ7Q8fkZRWBVgOGiKL0cLuf17w+dMOiWBxWCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PHpbWMd+p9SIQaLnpNrHOZR9N/PjuUwLu4hjYulTYcVxaMRdFgBLODS/Y5N29faqRDbUTER8LIGwMgGHEGziPO2wz52XM7rPOFN9xcW0CeI2O1RHRdB1H9CDNhwLFMm8GGgQUELEig4FxZZxvDu/6+popV19N86sh0FKH0J5OIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwsf1oQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A23CC433F1;
	Fri, 22 Mar 2024 13:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711113730;
	bh=IzPTHowQ7Q8fkZRWBVgOGiKL0cLuf17w+dMOiWBxWCE=;
	h=From:To:Cc:Subject:Date:From;
	b=bwsf1oQfGwbXiuRD/ayOVCS1o/ae5GOGvPWESUTJxMdacZpDXqJbT2qQ9Z1F6yntQ
	 20dBNe0GfWb+Tp+UO0brsa5VGl6UOj4Zk5rbQJUWsli5B1QLmGeqIDtwb6D/TtqxIf
	 SETrReK+bCI8kYJeRvOulTvXKCfxiQNXvfbcVvydQPoS/8mAL6QeRrAt09VLO9Bgf+
	 9801FH4sda4jihyWvc54W5Xzig8yIBtPHpE8UGdQRl86etjz+7HrFh3Hw6z5VxjeiA
	 n68a9OVkXH3/gsmFA1wulYQpL0JNBA03aBsV03AJ/Bh5nV2u5h7e+TUjLpv4WspXzk
	 gzcw9LDDW6flA==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: armada-37xx: remove an unused variable
Date: Fri, 22 Mar 2024 14:21:43 +0100
Message-Id: <20240322132205.906729-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This variable has never been used and can be removed to avoid a W=1 warning:

drivers/pinctrl/mvebu/pinctrl-armada-37xx.c:837:6: error: variable 'i' set but not used [-Werror,-Wunused-but-set-variable]
  837 |         int i = 0;

Fixes: 87466ccd9401 ("pinctrl: armada-37xx: Add pin controller support for Armada 37xx")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index c34719b7506d..4c4ada06423d 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -834,8 +834,6 @@ static int armada_37xx_gpiochip_register(struct platform_device *pdev,
 static int armada_37xx_add_function(struct armada_37xx_pmx_func *funcs,
 				    int *funcsize, const char *name)
 {
-	int i = 0;
-
 	if (*funcsize <= 0)
 		return -EOVERFLOW;
 
@@ -847,7 +845,6 @@ static int armada_37xx_add_function(struct armada_37xx_pmx_func *funcs,
 			return -EEXIST;
 		}
 		funcs++;
-		i++;
 	}
 
 	/* append new unique function */
-- 
2.39.2


