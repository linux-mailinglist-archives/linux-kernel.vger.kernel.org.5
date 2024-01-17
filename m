Return-Path: <linux-kernel+bounces-29491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 151F3830F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE381F264B1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562E6288D7;
	Wed, 17 Jan 2024 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="jdd2dh2F"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8131E87D;
	Wed, 17 Jan 2024 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531158; cv=none; b=q3PXoWborpOS5JOgx3+hteDBObJXRoKs0XCFWLTkZ81lWZ2+WFnvsYwNAkK0juef5IsCRo2fcGsZBeDfNvrr9ODVaavwrYfy8+3UeNGweEWi738utB/83iElx5aGlErkAD8XKPh3LQ+ZPZ2OShTTFJF01fpgopp2+p4FMyUw8mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531158; c=relaxed/simple;
	bh=jcXPWpuBViIPrInrIbH787AisZ276JYAwQJ51q6uOZA=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=XLFPNsgNeXJ7ZlmlOK4NzfWnGXUniQf8AueOEaVHpsh4GxdSEouFyV2sKHx1c2QxtdCvqt68qIkf/6nQAo00doNHdrzb1uI+gukVG7vphOAUeaxvUriSJjLngL/qvVc535s3ujR+0qz81j7Eju92hnmCbzK6HoYS4T26UcD6NNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=jdd2dh2F; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=dcyVdN9WA3+WFCV7YIJB59g4OBoAZCr5zwdM42OYOy8=; b=jdd2dh2Fr93hclXghX4rnXy21m
	tX3tPkjxD/BgYHsmTINsNtQNFUr9SwaP83zt9Dk+e66tzkvX0fvdHmAmtYPGnUXw6fd3GVx9S4m10
	fbk5wVuNpM3gNAkaMyOacicx7O8JTc0IG6BipozBx0nxhu6FyHmseLPyTHp4wbAPHTh8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52924 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQEYn-000155-S3; Wed, 17 Jan 2024 17:39:02 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	cosmin.tanislav@analog.com,
	andy.shevchenko@gmail.com,
	shc_work@mail.ru
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 17 Jan 2024 17:38:38 -0500
Message-Id: <20240117223856.2303475-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH 00/18] serial: max310x: cleanups and improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series brings a few clean-ups and improvements to the max310x
driver.

Some of these changes are based on suggestions for the sc16is7xx driver by
Andy Shevchenko following this dicussion:

Link: https://lore.kernel.org/all/CAHp75VebCZckUrNraYQj9k=Mrn2kbYs1Lx26f5-8rKJ3RXeh-w@mail.gmail.com/

The changes have been tested on a custom board using a max14830 in SPI
mode, with an external oscillator (not crystal). Tests included a simple
communication test with a GPS connected to UART0.

They also have been tested by using i2c-stub to simulate the four ports on a
virtual I2C max14830 device, but with obvious limitations as this cannot
simulate all the hardware functions.

Thank you.

Hugo Villeneuve (18):
  serial: max310x: fix NULL pointer dereference in I2C instantiation
  serial: max310x: add I2C device table for instantiation from userspace
  serial: max310x: use i2c_get_match_data()
  serial: max310x: use spi_get_device_match_data()
  serial: max310x: fix syntax error in IRQ error message
  serial: max310x: remove holes in struct max310x_devtype
  serial: max310x: add macro for max number of ports
  serial: max310x: use separate regmap name for each port
  serial: max310x: simplify probe() and remove() error handling
  serial: max310x: add explicit return for some switch default cases
  serial: max310x: use dev_err_probe() instead of dev_err()
  serial: max310x: replace hardcoded masks with preferred GENMASK()
  serial: max310x: use common detect function for all variants
  serial: max310x: use common power function for all variants
  serial: max310x: replace ENOTSUPP with preferred EOPNOTSUPP
    (checkpatch)
  serial: max310x: replace bare use of 'unsigned' with 'unsigned int'
    (checkpatch)
  serial: max310x: reformat and improve comments
  serial: max310x: fix indentation

 drivers/tty/serial/max310x.c | 329 ++++++++++++++++++-----------------
 1 file changed, 165 insertions(+), 164 deletions(-)


base-commit: 0c84bea0cabc4e2b98a3de88eeb4ff798931f056
-- 
2.39.2


