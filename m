Return-Path: <linux-kernel+bounces-3089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE11816737
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B2E8B21904
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C884A79EE;
	Mon, 18 Dec 2023 07:16:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3F579D9;
	Mon, 18 Dec 2023 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4Strcz2sVgzB022w;
	Mon, 18 Dec 2023 15:12:51 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 18 Dec
 2023 15:16:17 +0800
Date: Mon, 18 Dec 2023 15:16:16 +0800
From: Wang Jinchao <wangjinchao@xfusion.com>
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
	<brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <stone.xulei@xfusion.com>, <wangjinchao@xfusion.com>
Subject: [PATCH v2] gpiolib: cleanup for duplicated including
Message-ID: <202312181513+0800-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: wuxshcsitd00603.xfusion.com (10.32.134.231) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)

Remove second `#include <linux/err.h>`.
Remove `#include <asm/errno.h>`.
As they are guaranteed by the global `err.h`.

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
V2:
    Revise the comment per Andy's suggestion.
V1: https://lore.kernel.org/all/202312151645+0800-wangjinchao@xfusion.com/

 include/linux/gpio/driver.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 0aed62f0c633..df6857e579a1 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -701,7 +701,6 @@ int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
 #else
 
 #include <asm/bug.h>
-#include <asm/errno.h>
 
 static inline int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
 					      struct irq_domain *domain)
@@ -789,8 +788,6 @@ int gpio_device_get_base(struct gpio_device *gdev);
 
 #else /* CONFIG_GPIOLIB */
 
-#include <linux/err.h>
-
 #include <asm/bug.h>
 
 static inline struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc)
-- 
2.40.0


