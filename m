Return-Path: <linux-kernel+bounces-25635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 702C482D3D9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49BD281743
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E2D23C9;
	Mon, 15 Jan 2024 05:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZLUTKLgn"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB393C0B;
	Mon, 15 Jan 2024 05:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=D1nJEx0/AowVVAtrhWlb10WxQOmkj24eqK/IQEPifvU=; b=ZLUTKLgnJoFuTidcFqWWbGiwML
	TeRQXVKDvLz++FA43OJdWy23J8SZhCQrEnrDgpN8YUvAW2i34oyfa9IO4cPvEDtAqsqNj0DQ8TF30
	AH6bO0RzF5LAKTJYqSO6nY5T2ExlIrKY9m+oMfyytDXY7Z/TusWWSIElGGWMm/Fr5E5ZgW3FS4Ewl
	G43QA6AsX5rkA3BJZq2LiLzQw1x7ihiyzXWgvmcfVmR8+g+9iR/eLyPOk8Psnx/Pl888AyBZoYMsr
	ejZ7UqOrlRPQUjzm69wlI+T0QliFKSCZ4rmxBfdHHthYmYnzHUtzdITeQ8IVcBELRomlkNTv9zcdQ
	caK4Ztbg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPFNy-007nM3-0s;
	Mon, 15 Jan 2024 05:19:46 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	John Crispin <john@phrozen.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Felix Fietkau <nbd@nbd.name>,
	linux-gpio@vger.kernel.org
Subject: [PATCH] gpio: EN7523: fix kernel-doc warnings
Date: Sun, 14 Jan 2024 21:19:45 -0800
Message-ID: <20240115051945.6173-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


gpio-en7523.c:22: warning: cannot understand function prototype: 'struct airoha_gpio_ctrl '
gpio-en7523.c:27: warning: Function parameter or struct member 'dir' not described in 'airoha_gpio_ctrl'
gpio-en7523.c:27: warning: Excess struct member 'dir0' description in 'airoha_gpio_ctrl'
gpio-en7523.c:27: warning: Excess struct member 'dir1' description in 'airoha_gpio_ctrl'


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: John Crispin <john@phrozen.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Felix Fietkau <nbd@nbd.name>
Cc: linux-gpio@vger.kernel.org
---
 drivers/gpio/gpio-en7523.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/drivers/gpio/gpio-en7523.c b/drivers/gpio/gpio-en7523.c
--- a/drivers/gpio/gpio-en7523.c
+++ b/drivers/gpio/gpio-en7523.c
@@ -12,11 +12,11 @@
 #define AIROHA_GPIO_MAX		32
 
 /**
- * airoha_gpio_ctrl - Airoha GPIO driver data
+ * struct airoha_gpio_ctrl - Airoha GPIO driver data
  * @gc: Associated gpio_chip instance.
  * @data: The data register.
- * @dir0: The direction register for the lower 16 pins.
- * @dir1: The direction register for the higher 16 pins.
+ * @dir: [0] The direction register for the lower 16 pins.
+ * [1]: The direction register for the higher 16 pins.
  * @output: The output enable register.
  */
 struct airoha_gpio_ctrl {

