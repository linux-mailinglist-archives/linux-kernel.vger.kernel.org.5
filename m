Return-Path: <linux-kernel+bounces-95892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B678754A4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C0E28650B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6175130AF3;
	Thu,  7 Mar 2024 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="MT220pCZ"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C495131E21;
	Thu,  7 Mar 2024 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830338; cv=none; b=OHe7scdsJDI0HzDGtAxWoaSAInxzPzAdUIYdvif+fM8vKP/8EPRrs6jJ/Tu3fS/J3dnNZDTMBB6rmyRv9+1+BXBWNwEIJA7HAYU8Jf2OGD2gvE8wprBEy/aLKeemEZSQKMxlAotvn9dS7HAcjBG1jqU/3oie790veMC9XcCr0OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830338; c=relaxed/simple;
	bh=fZ5DoPv6ZsNNd105bFo2nteLWD8VO0z5njwuVgjVDPc=;
	h=From:To:Cc:Date:Message-Id:MIME-Version:Subject; b=k68FZbAv/sQO/ny/joM+UTKvJn4ZQQLARnywkJu7JGXtccLG8tcW/2ETQOHfDjIr6IG/MI8kOaU39mxd169DIvL3oBWr4lNf5iZNOxSFo1sYXDcGWRn9Gfew7zDywvQjMC+5TziEDtGDg8eiub5Do5E33nTlGpkxyHtsWNFmXyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=MT220pCZ; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=MBrRtTOLIx2ABajnqtReIp0j0/jKR5mxRObP6W0lLHE=; b=MT220pCZw8qZouHzCDJihZn4+u
	hXMW5AWNxtdmWOIAbqYYJtFFzpJ8hT9xTfLzE8SHUUhC1VqIrlDtK9pxZRxDo+MyLeyhQP0zHgC1K
	T7EQnBcdwGo5RPe6bUYMRIc8G2BTirmIbcFZM4CtCPFG90tgA2x+VQyswwVLL5640bhg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57020 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1riGS3-0005lI-Mi; Thu, 07 Mar 2024 11:18:36 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu,  7 Mar 2024 11:18:24 -0500
Message-Id: <20240307161828.118495-1-hugo@hugovil.com>
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
Subject: [PATCH v2 0/4] serial: sc16is7xx: split into core and I2C/SPI parts
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

Changes for V2:
- Move port_registered[] init before the for loop to prevent bug if
  aborting probe when i = 0
- Since patch f7b487648986 ("lib/find: add atomic find_bit() primitives") has
  been dropped from linux-next/master, rework patch 2 (sc16is7xx_lines)
  without find_and_set_bit.

Hugo Villeneuve (4):
  serial: sc16is7xx: simplify and improve Kconfig help text
  serial: sc16is7xx: split into core and I2C/SPI parts (core)
  serial: sc16is7xx: split into core and I2C/SPI parts (sc16is7xx_lines)
  serial: sc16is7xx: split into core and I2C/SPI parts
    (sc16is7xx_regcfg)

 drivers/tty/serial/Kconfig         |  41 +++--
 drivers/tty/serial/Makefile        |   4 +-
 drivers/tty/serial/sc16is7xx.c     | 245 ++++++-----------------------
 drivers/tty/serial/sc16is7xx.h     |  41 +++++
 drivers/tty/serial/sc16is7xx_i2c.c |  74 +++++++++
 drivers/tty/serial/sc16is7xx_spi.c |  97 ++++++++++++
 6 files changed, 284 insertions(+), 218 deletions(-)
 create mode 100644 drivers/tty/serial/sc16is7xx.h
 create mode 100644 drivers/tty/serial/sc16is7xx_i2c.c
 create mode 100644 drivers/tty/serial/sc16is7xx_spi.c


base-commit: 801410b26a0e8b8a16f7915b2b55c9528b69ca87
-- 
2.39.2


