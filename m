Return-Path: <linux-kernel+bounces-137255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 524D889DF8D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D02A29484D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D42313D526;
	Tue,  9 Apr 2024 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="hGq+3KrY"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14D013667F;
	Tue,  9 Apr 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677587; cv=none; b=EPMaKpP0lav7qrXiT7GiVkO3Q6/1OVzUMmQGPfmUlKnqDgZOoBWJt9r9GJk0b4QXxHZsOMDlKsPQQ8yDLRYpXChaHDMYXzawB8irG+6nEs75kL4QlyacAIi+E6ROGSOdNYWSAtRSejRzzRUPogdCYTjria3Br5ER184NBNimR90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677587; c=relaxed/simple;
	bh=xlXn1+20uTqx+W8MEQ4BJ+F8xH03zz0Ii3xHN9DpT3g=;
	h=From:To:Cc:Date:Message-Id:MIME-Version:Subject; b=eGmbu0wlsU+qYaC9Mk9/8pwQ0G2MwpXG87QTUyUCKkVm8AblDkjy7Iwu4pgNGOqNVgb3zP28WFRzpGTqz5XH+JGGOkrrnNIctXj1/CtSI63Np58Ww0r0nQfOE7Z8I4z+6QKoQ8CW5Wi830UIfIEjmSEDUPBL1o+bM1ajpV+9yOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=hGq+3KrY; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=I6gHj5ulVRplYdlxefeoXkzfjNeS/XzmKLr+AYiBZGc=; b=hGq+3KrYgOoqjpbO9/HK9WEvuY
	IJy5438s1SjyptudLQooRozl/aTnkR0MtnhnEscVjxP6hl/PCAx/sWy4iDZi1s/0L2rzowVdiAV6v
	RtX1Qu942UAbzKkXM6u/L/XNDUuSjjXTN9SJM58GqPQj3FwE2TrJ0HUemmtMlfdt/4Sk=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:44750 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1ruDfp-0002NM-14; Tue, 09 Apr 2024 11:46:13 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	peterz@infradead.org,
	mingo@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	andy.shevchenko@gmail.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue,  9 Apr 2024 11:42:48 -0400
Message-Id: <20240409154253.3043822-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH v4 0/5] serial: sc16is7xx: split into core and I2C/SPI parts
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series splits the SPI/I2C parts for the sc16is7xx driver into
separate source files (and separate I2C/SPI drivers).

These changes are based on suggestions made by Andy Shevchenko
following this discussion:

Link: https://lore.kernel.org/all/CAHp75VebCZckUrNraYQj9k=Mrn2kbYs1Lx26f5-8rKJ3RXeh-w@mail.gmail.com/

The changes are split into multiple patches to facilitate the review process.
In the end, some of them could be merged into a single patch.

I have tested the changes on a custom board with two SC16IS752 DUART over
a SPI interface using a Variscite IMX8MN NANO SOM. The four UARTs are
configured in RS-485 mode.

I did not test the changes on a real SC16is7xx using the I2C interface. But
I slightly modified the driver to be able to simulate an I2C device using
i2c-stub. I was then able to instantiate a virtual I2C device without
disturbing existing connection/communication between real SPI devices on
/dev/ttySC0 and /dev/ttySC2 (using a loopback cable).

Thank you.

Link: [v1] https://lore.kernel.org/lkml/20240206214208.2141067-1-hugo@hugovil.com
      [v2] https://lore.kernel.org/lkml/20240307161828.118495-1-hugo@hugovil.com
      [v3] https://lore.kernel.org/lkml/20240402174353.256627-1-hugo@hugovil.com

Changes for V2:
- Move port_registered[] init before the for loop to prevent bug if
  aborting probe when i = 0
- Since patch f7b487648986 ("lib/find: add atomic find_bit() primitives") has
  been dropped from linux-next/master, rework patch 2 (sc16is7xx_lines)
  without find_and_set_bit.

Changes for V3:
- Simplify sc16is7xx_lines allocation by using the IDA framework

Changes for V4:
Changes after Andy S. review comments:
- Fix commit description
- Fix includes for IWYU
- Add Reviewed-by tag (Andy) for patches 1 and 5
- Add exported symbols to SERIAL_NXP_SC16IS7XX namespace
- Fix Kconfig deps
- Keep Kconfig SERIAL_SC16IS7XX_CORE
- Convert to a single Kconfig entry and automatically selects
  I2C and SPI interfaces if available.
- Merge patches 2 and 3
- Add NXP and UART keywords to Kconfig description
- Remove __maybe_unused from of_device_id
- Simplify I2C init/exit with module_i2c_driver()
- Simplify SPI init/exit with module_spi_driver()

Hugo Villeneuve (5):
  serial: sc16is7xx: add proper sched.h include for sched_set_fifo()
  serial: sc16is7xx: unconditionally clear line bit in
    sc16is7xx_remove()
  serial: sc16is7xx: split into core and I2C/SPI parts (core)
  serial: sc16is7xx: split into core and I2C/SPI parts (sc16is7xx_lines)
  serial: sc16is7xx: split into core and I2C/SPI parts
    (sc16is7xx_regcfg)

 drivers/tty/serial/Kconfig         |  47 ++----
 drivers/tty/serial/Makefile        |   2 +
 drivers/tty/serial/sc16is7xx.c     | 261 +++++++----------------------
 drivers/tty/serial/sc16is7xx.h     |  41 +++++
 drivers/tty/serial/sc16is7xx_i2c.c |  67 ++++++++
 drivers/tty/serial/sc16is7xx_spi.c |  90 ++++++++++
 6 files changed, 277 insertions(+), 231 deletions(-)
 create mode 100644 drivers/tty/serial/sc16is7xx.h
 create mode 100644 drivers/tty/serial/sc16is7xx_i2c.c
 create mode 100644 drivers/tty/serial/sc16is7xx_spi.c


base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
-- 
2.39.2


