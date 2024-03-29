Return-Path: <linux-kernel+bounces-124417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCB989173E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3351F23E44
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EBD8612C;
	Fri, 29 Mar 2024 10:56:54 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FBD85659
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709814; cv=none; b=KtVBqFUkc6VPOGztUdBAQQrGO+3x6frZwSS4FxGUbd1lz8FMg9LgAr+ZNPvfqjYcDmd9ef3mBT3KnhllBX8rpP7xoh13JviyQhIlogU5kTbbDpPCpD31pliJlU9xuSoeOTZdmTzDSE+2JxUpk0zlMwNVhHvV2k9M3ppCApzWgQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709814; c=relaxed/simple;
	bh=Nu9sYchMYtdoAcYQDRWy92zX8RGluRxWCKF8EUIbUns=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVjIffOhxXkUr3uDzFrqccHfhRxx1qoIgthRaTGerZ8uc702QMsF95ryjxy+M8jxFRNn5QaqaQ4xfCqU7FSX3S/b3bGBRTqXSh0ZMA7iBE2fd9wIzDuYmft9NwC7YjXU31DOHkFj0yXwX7qViOfd97hTAjREJi3xB2J9u4szpVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 08e01b89-edbb-11ee-a9de-005056bdf889;
	Fri, 29 Mar 2024 12:56:46 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/11] pinctrl: aw9523: Remove redundant dependency to OF
Date: Fri, 29 Mar 2024 12:55:25 +0200
Message-ID: <20240329105634.712457-12-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329105634.712457-1-andy.shevchenko@gmail.com>
References: <20240329105634.712457-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver does not dependent on OF, remove it.
While here, add missing mod_devicetable.h.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pinctrl/Kconfig          | 2 +-
 drivers/pinctrl/pinctrl-aw9523.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index d45657aa986ae..c413109b1173b 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -129,7 +129,7 @@ config PINCTRL_AXP209
 
 config PINCTRL_AW9523
 	tristate "Awinic AW9523/AW9523B I2C GPIO expander pinctrl driver"
-	depends on OF && I2C
+	depends on I2C
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF
diff --git a/drivers/pinctrl/pinctrl-aw9523.c b/drivers/pinctrl/pinctrl-aw9523.c
index b5e1c467625ba..1d0ce78115da7 100644
--- a/drivers/pinctrl/pinctrl-aw9523.c
+++ b/drivers/pinctrl/pinctrl-aw9523.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/property.h>
-- 
2.44.0


