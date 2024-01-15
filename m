Return-Path: <linux-kernel+bounces-26422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DD282E062
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEC01C22081
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4348B18658;
	Mon, 15 Jan 2024 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EYoFAnHK"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D544D18657;
	Mon, 15 Jan 2024 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=MwV1nlLRs/zdcFC+GsCWfD3zD/uMILfGMm+jraJw7W0=; b=EYoFAnHKkNJMmuVryhMBt74eTh
	+j4kTftzTZFwN4NFootNhBf06+xeaLuthgwlj3kjTuGhqNDMMeOcOWqtj54REAzNV21XN5f1AW80F
	/VCW7GvI2zoc3Yv6nRSYpRNMveDlt3x0B0fJ9ykvrCDXEKdQVk2NAwNBFUQY3K0cwQ5rOBYZmLPqb
	/HQ2dXzA6krTknFd5wRNR4Pmho1cygry/Uvy+OVqk0iOE/DB2Zxku6SZAfLT19zr430506m6VWT6o
	PHmdDGshQqkBsPziv18P9Oe98zgjS9xGumv7EYb1jNLyvParumvbS0/m26nTqP/oFuhBBiDr9UZR8
	9BECG3Cg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPS8f-00A0xV-2A;
	Mon, 15 Jan 2024 18:56:49 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	John Crispin <john@phrozen.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Felix Fietkau <nbd@nbd.name>,
	linux-gpio@vger.kernel.org
Subject: [PATCH v3] gpio: EN7523: fix kernel-doc warnings
Date: Mon, 15 Jan 2024 10:56:47 -0800
Message-ID: <20240115185647.30663-1-rdunlap@infradead.org>
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

Fixes: 0868ad385aff ("gpio: Add support for Airoha EN7523 GPIO controller")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: John Crispin <john@phrozen.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Felix Fietkau <nbd@nbd.name>
Cc: linux-gpio@vger.kernel.org
---
v2: Add commit text.
v3: add Fixes tag.

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

