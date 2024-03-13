Return-Path: <linux-kernel+bounces-102661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 652DA87B574
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA201F22E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CFB604CF;
	Wed, 13 Mar 2024 23:54:41 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE6A5FBAE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710374080; cv=none; b=DgftPhGgoV2UNAAOa3ue4zTYZilKOYqzt/zwO5vC0zdElERZffSdJ1XbrDGcFKGohqU4paWIoSJtcr4C/TM589o163xJUfejrte/foGshuSxNRwqThvOPAFBmyZ5l/8UPxOb336i0zN4ZUE6zEw7/t6ATFrlgQI9LOvL2uYivNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710374080; c=relaxed/simple;
	bh=fo5pTpAUaSEiV9SCl+Yms4vQWIJjKj9xKfNuTuMVb7E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DI+PmO0n2q+1ZDVFchubrJR5Zk+Mv1JdB1LfTxszEXkDqHml/kxaD3egvzp9zSDdTz072v6h1g1ZG154TAwAsByfZSf+Hbx3qGV9oZEFysOjo2/H7qsw9xGFPwEsXAsLLRe6lusRbs0pOCYiL91Bd/ZDIxpd+FZAZfpbH95l3XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 0c28349c-e195-11ee-a9de-005056bdf889;
	Thu, 14 Mar 2024 01:54:36 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 11/11] pinctrl: aw9523: Remove redundant dependency to OF
Date: Thu, 14 Mar 2024 01:52:14 +0200
Message-ID: <20240313235422.180075-12-andy.shevchenko@gmail.com>
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
index 7299b5bb6d52f..43285e6d0e5b7 100644
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


