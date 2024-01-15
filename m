Return-Path: <linux-kernel+bounces-25636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5F082D3DC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E7E1F21498
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6756023DE;
	Mon, 15 Jan 2024 05:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ne+vLaVp"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D62E20E6;
	Mon, 15 Jan 2024 05:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=OjPujY9C7yIfcDizEUGwzzY/IAFfDqfo9kY2VXYu5tA=; b=Ne+vLaVpzuwxD8aut76rvc+dej
	Kg/zX+Tx2tikxB7MXjsA6LiVh0Un6gv6w1DXmoB7peuA18r8TzABTdkDg3Yvy8G65cMAuqpNOkWXn
	kZYIt0N0/DSZOVhDZmGFAHJQ8TheFHiM3nPfCwkrDXWhGl3MlLrvv+FRw7I21FlTYpy0tYKszy2hD
	306utSDRslEbdpdxWtuBfTUhZtS8GuRPg9fIzsa4OgFcfR6QVXehN2Wp/61WO/jilZX59o/TaOu0s
	IAc7snEZqxoCo8hxtm+FSqV7ptZOd9ej42b/5P7V7xkCUXIdU6nEHg9UAvT/qC3ptTCLOJpHapjQv
	oV+0/u2w==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPFPo-007nTR-28;
	Mon, 15 Jan 2024 05:21:40 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	John Crispin <john@phrozen.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Felix Fietkau <nbd@nbd.name>,
	linux-gpio@vger.kernel.org
Subject: [PATCH v2] gpio: EN7523: fix kernel-doc warnings
Date: Sun, 14 Jan 2024 21:21:40 -0800
Message-ID: <20240115052140.18858-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "struct" keyword and explain the @dir array differently to
prevent kernel-doc warnings:

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
v2: Add commit text.

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

