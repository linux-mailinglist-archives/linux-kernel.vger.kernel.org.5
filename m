Return-Path: <linux-kernel+bounces-124416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FD1891769
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60471F233EB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751968594B;
	Fri, 29 Mar 2024 10:56:53 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569AC83A1C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709813; cv=none; b=p2w4eHhVz/TV9RIrwSPkkS/U5sb9RZkXVB3cy+WUhC5Rl/HXEUnQt2yzlEA40YMN/t5ebqMkTYtvAC1jKsligU41RAqKADytfeVJdMop3Rz1TNud2yPBZrhhYlIaSPVKN81tUNWRRkw62RoTHEPuHd7qCcE7WjkcSCmAHg/fLFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709813; c=relaxed/simple;
	bh=MntR2VoWY9d1UM+GLc/rVG7Vv1KYkGV3SbVUjUoYChA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEAEegulpRGIFdrDURGTPFNvoM3BsoD+n2bvevN6c8ulDdw6O5iaBX7uyFPucZuxoLcpwFYOWRuktyxFTTGcw0pPD4QMR5IZi1DQ7B5IODdssvNGkTLN59EME8XfCuj3dw2SWLOpsGMSJDiPRUk50vjwURYmXqL5yrfoy/jCB84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 080b5b1f-edbb-11ee-b3cf-005056bd6ce9;
	Fri, 29 Mar 2024 12:56:44 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/11] pinctrl: aw9523: Sort headers and group pinctrl/*
Date: Fri, 29 Mar 2024 12:55:23 +0200
Message-ID: <20240329105634.712457-10-andy.shevchenko@gmail.com>
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

One header was misplaced and group pinctrl/* ones to show the relation
with the pin control subsystem.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pinctrl/pinctrl-aw9523.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-aw9523.c b/drivers/pinctrl/pinctrl-aw9523.c
index fe398c59c2d11..49d5035899227 100644
--- a/drivers/pinctrl/pinctrl-aw9523.c
+++ b/drivers/pinctrl/pinctrl-aw9523.c
@@ -13,17 +13,18 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/mutex.h>
 #include <linux/module.h>
-#include <linux/pinctrl/pinconf.h>
-#include <linux/pinctrl/pinctrl.h>
-#include <linux/pinctrl/pinmux.h>
-#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
 #define AW9523_MAX_FUNCS		2
 #define AW9523_NUM_PORTS		2
 #define AW9523_PINS_PER_PORT		8
-- 
2.44.0


