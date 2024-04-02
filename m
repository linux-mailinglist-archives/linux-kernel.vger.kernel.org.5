Return-Path: <linux-kernel+bounces-128448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4916A895AFB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EDE280F94
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4955215AABE;
	Tue,  2 Apr 2024 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="AWApqeI1"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F326A159910;
	Tue,  2 Apr 2024 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079906; cv=none; b=IvaXIynZ8ERpdUUw1ZDyOe3EutpEudOCIGUjNKx9b+uxFnqFBrIDZ+noFhNMyOgj4sug2hQxh41/KfDLGHxjdIZLcBHp4eoxyf+i2y9jQPmFUth5vZgyw7avf00BjPF+KKXJ7BF6qI/u2Xl3M+yYeH0cNaCWuk/3Y//UcUTE2RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079906; c=relaxed/simple;
	bh=AbpB2KHSXA2Gd4ST+SXTe7OHQwyZ+KzWtYnbWX18qYk=;
	h=From:To:Cc:Date:Message-Id:MIME-Version:Subject; b=Q8/bolCLIZQeW6gkscKkw95h/IrXz9q78mwOmluqCsBhSoBpcD/BCxeWnvWyLEa+nhFc65POyHxGMU6Q/s0yrzdIUBCQpp0HyC+tnaybti522Qc097jUOACWpAi7n467mNPLvDM6YXjLhr9TE00gct9LNkC79bTlx2cwbq4XXKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=AWApqeI1; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=4rrp6ETByzdIBJA25gHZc6tDZQp+n0yfQSvoQtvDxQE=; b=AWApqeI1n5Vww7rSVLD1Bh+WM/
	kVNwusjnrs8FY7M8UIJ1csnrv4pSvCtrjgjEEQfF1ykzfC55EwqSR+kYUNhXdYuAhHuH5sZFEV7Wm
	UQidp5wdC1yzZqgmHG9v1wS1Io8L66bUy4REcvGOfBHOZZZHagWILgXSSP1yVnwMQ/Ac=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:56268 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rriBy-0008FF-3O; Tue, 02 Apr 2024 13:45:02 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	andy.shevchenko@gmail.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue,  2 Apr 2024 13:43:48 -0400
Message-Id: <20240402174353.256627-1-hugo@hugovil.com>
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
Subject: [PATCH v3 0/5] serial: sc16is7xx: split into core and I2C/SPI parts
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
I slighly modified the driver to be able to simulate an I2C device using
i2c-stub. I was then able to instantiate a virtual I2C device without
disturbing existing connection/communication between real SPI devices on
/dev/ttySC0 and /dev/ttySC2 (using a loopback cable).

Thank you.

Link: [v1] https://lore.kernel.org/lkml/20240206214208.2141067-1-hugo@hugovil.com
      [v2] https://lore.kernel.org/lkml/20240307161828.118495-1-hugo@hugovil.com

Changes for V2:
- Move port_registered[] init before the for loop to prevent bug if
  aborting probe when i = 0
- Since patch f7b487648986 ("lib/find: add atomic find_bit() primitives") has
  been dropped from linux-next/master, rework patch 2 (sc16is7xx_lines)
  without find_and_set_bit.

Changes for V3:
- Simplify sc16is7xx_lines allocation by using the IDA framework

Hugo Villeneuve (5):
  serial: sc16is7xx: unconditionally clear line bit in
    sc16is7xx_remove()
  serial: sc16is7xx: simplify and improve Kconfig help text
  serial: sc16is7xx: split into core and I2C/SPI parts (core)
  serial: sc16is7xx: split into core and I2C/SPI parts (sc16is7xx_lines)
  serial: sc16is7xx: split into core and I2C/SPI parts
    (sc16is7xx_regcfg)

 drivers/tty/serial/Kconfig         |  41 +++--
 drivers/tty/serial/Makefile        |   4 +-
 drivers/tty/serial/sc16is7xx.c     | 255 ++++++-----------------------
 drivers/tty/serial/sc16is7xx.h     |  41 +++++
 drivers/tty/serial/sc16is7xx_i2c.c |  74 +++++++++
 drivers/tty/serial/sc16is7xx_spi.c |  97 +++++++++++
 6 files changed, 288 insertions(+), 224 deletions(-)
 create mode 100644 drivers/tty/serial/sc16is7xx.h
 create mode 100644 drivers/tty/serial/sc16is7xx_i2c.c
 create mode 100644 drivers/tty/serial/sc16is7xx_spi.c


base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
-- 
2.39.2


