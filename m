Return-Path: <linux-kernel+bounces-55680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FC384BFE3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE673286280
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A301C692;
	Tue,  6 Feb 2024 22:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Y8OaEty5"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC421BF40;
	Tue,  6 Feb 2024 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257678; cv=none; b=d2qiAfpQgWpfL820MxCoNMjmkgVpfNPXG4k0WSi7GYuD8bIbdqeOfEoFRdjCI08gdmy+8FfkjHbtRNNSgj/9L8JCsJTzXkodfvDfTNFN27t4IpVu9du8PEbQ8jPJZSJbU+ntgv2JyeHEZ0or/O80JyGkMpLkgghm2NWHwPzGf6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257678; c=relaxed/simple;
	bh=Q5I7J+08Nn3BO065gykwRL7HeIo0M74BEk0jB9ySsjY=;
	h=From:To:Cc:Date:Message-Id:MIME-Version:Subject; b=dtIu7cezhxDQvsieDmr7LuS6LILQqj7uDyIEb3oLH4GC5ZBTgbZauuCm3afE3MN2k1jvGUeCI55rEG1ZlfYzwFCF5ql9jIwKyewqYMV+dnjvaTmv0WXSiUcNnpa5XXdB0BALeA6gqKnc09onPlRmqROcnXNaq4vFLy3ttLF/1gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Y8OaEty5; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=t5ACsjfeWK+CXyvqFoni4DQqe1wDkuuTlLq8NUvOmK4=; b=Y8OaEty5rF4Tg1UH3gzkNe7TQG
	3BvhE5zyzLlkgREzpTzKZ0llCrBfiGp6f5Cn4h5/zl7SbgC8XdnqEaoH+HVsfFgE5+LtGNlBgXFnE
	fG83F1ReDum9YicGrv3UjI3uxTB0otfWt7pthjfLKBYNLjE6N7YdhwcKDwjbkRkvAgI8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41434 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rXTCl-0006XX-2N; Tue, 06 Feb 2024 16:42:11 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue,  6 Feb 2024 16:42:04 -0500
Message-Id: <20240206214208.2141067-1-hugo@hugovil.com>
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
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH 0/4] serial: sc16is7xx: split into core and I2C/SPI parts
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series splits the SPI/I2C parts for the sc16is7xx driver into
separate source files (and separate I2C/SPI drivers).

These changes are based on suggestions made by Andy Shevchenko
following this discussion:

Link: https://lore.kernel.org/all/CAHp75VebCZckUrNraYQj9k=Mrn2kbYs1Lx26f5-8rKJ3RXeh-w@mail.gmail.com/

The patches are multiple, simply to facilitate the review process. In the end,
they could be merged into a single patch.

This patch series depends on the the following patch (in linux-next/stable):
    commit f7b487648986 ("lib/find: add atomic find_bit() primitives")

I have tested the changes on a custom board with two SC16IS752 DUART over
a SPI interface using a Variscite IMX8MN NANO SOM. The four UARTs are
configured in RS-485 mode.

I did not test the changes on a real SC16is7xx using the I2C interface. But
I slighly modified the driver to be able to simulate an I2C device using
i2c-stub. I was then able to instantiate a virtual I2C device without
disturbing existing connection/communication between real SPI devices on
/dev/ttySC0 and /dev/ttySC2 (using a loopback cable).

Thank you.

Hugo Villeneuve (4):
  serial: sc16is7xx: simplify and improve Kconfig help text
  serial: sc16is7xx: split into core and I2C/SPI parts (core)
  serial: sc16is7xx: split into core and I2C/SPI parts (sc16is7xx_lines)
  serial: sc16is7xx: split into core and I2C/SPI parts
    (sc16is7xx_regcfg)

 drivers/tty/serial/Kconfig         |  41 +++--
 drivers/tty/serial/Makefile        |   4 +-
 drivers/tty/serial/sc16is7xx.c     | 242 ++++++-----------------------
 drivers/tty/serial/sc16is7xx.h     |  41 +++++
 drivers/tty/serial/sc16is7xx_i2c.c |  74 +++++++++
 drivers/tty/serial/sc16is7xx_spi.c |  97 ++++++++++++
 6 files changed, 279 insertions(+), 220 deletions(-)
 create mode 100644 drivers/tty/serial/sc16is7xx.h
 create mode 100644 drivers/tty/serial/sc16is7xx_i2c.c
 create mode 100644 drivers/tty/serial/sc16is7xx_spi.c


base-commit: 52b56990d214c7403b20f691ac61861a37c0f0db
-- 
2.39.2


