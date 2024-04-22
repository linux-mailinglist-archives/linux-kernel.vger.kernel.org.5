Return-Path: <linux-kernel+bounces-153361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C318ACD1E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E621F23B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703FD14EC72;
	Mon, 22 Apr 2024 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="p2ZJCef2"
Received: from forward206b.mail.yandex.net (forward206b.mail.yandex.net [178.154.239.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDD61474B4;
	Mon, 22 Apr 2024 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789825; cv=none; b=pfT3WRvUVDrfSk4HgaOFJlhwHJo7UflouqcWP/9XXXrGcSCs98Nsol2yt6sG5gCfBFuDFcdkU15SEUKW+Ws9wv+DV35FGvROapKaTt7zw7YiaGOrWOF7MJhthORdmAVvyGT4kGhS29hzU+dC7cI0+wJ/cFoDe6QnjGT9l2vqC9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789825; c=relaxed/simple;
	bh=YpfQKbgNCqjlYBy190iX+Q24Ro3vJeC2ab2GwoUJck0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fZ7yIEwr35h4O+wfUFlrQk3Sh+QdnsL0PnzVl/17gu1NyeC3pGJLj6DLddkGuUND/uBl3ZsE02eNemD+6aAV3kfOsf4+hquFSXAYkUu6xpmOx9/8U3YJjtA6Cq2nIJgJoWIwwEa1/jqYzESUPtENaWgBX0ACwGqqOUQEUsBZCdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=p2ZJCef2; arc=none smtp.client-ip=178.154.239.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward206b.mail.yandex.net (Yandex) with ESMTPS id BB5DC65493;
	Mon, 22 Apr 2024 15:38:18 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3729:0:640:85f7:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id AB07660B4F;
	Mon, 22 Apr 2024 15:38:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6cIEH34oJ8c0-PxyYe3Sr;
	Mon, 22 Apr 2024 15:38:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713789488; bh=3FLkxqKrUkDIdaKldaE+ujoRy80Daa8M0af7nam/Qco=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=p2ZJCef2UWeVzSjHq1/OuORuF0Dm7pWZ/+xyhINd5Nf2fmhPVT0yjdFDI6RPsaN1h
	 ta3t+XLL+KbBCmIDmBOAgXQwg0XIb8Df4buZtfXOB5wo1UzaxHBRnNCiHScXXc9rby
	 9eQTQKwc4/AgoVKNytJpT3eZYYg0xmOOJllmTMOI=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Konstantin Pugin <rilian.la.te@ya.ru>
To: 
Cc: krzk@kernel.org,
	conor@kernel.org,
	lkp@intel.com,
	vz@mleia.com,
	robh@kernel.org,
	jcmvbkbc@gmail.com,
	nicolas.ferre@microchip.com,
	manikanta.guntupalli@amd.com,
	corbet@lwn.net,
	ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de,
	Maarten.Brock@sttls.nl,
	Konstantin Pugin <ria.freelander@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v6 0/3]  add support for EXAR XR20M1172 UART
Date: Mon, 22 Apr 2024 15:37:54 +0300
Message-Id: <20240422123801.2695129-1-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Pugin <ria.freelander@gmail.com>

EXAR XR20M1172 UART is mostly SC16IS762-compatible, but
it has additional register which can change UART multiplier
to 4x and 8x, similar to UPF_MAGIC_MULTIPLIER does. So, I used this
flag to guard access to its specific DLD register. It seems than
other EXAR SPI UART modules also have this register, but I tested
only XR20M1172.
Yes, in datasheet this register is called "DLD - Divisor Fractional"
or "DLD - Divisor Fractional Register", calling depends on datasheet
version.

I am sorry about too many submissions and top post reply. About second -
I do not know how to reply properly to this ML from GMail phone app. About first - I just
get very good feedback from Andy Shevchenko, and want to fix his review picks ASAP.

Changes in v2:
  - use full name in git authorship

Changes in v3:
  - change formatting of commit messages to unify width
  - rework commit messages according to code review
  - add XR20M117X namespace for EXAR-specific register
  - do not use UPF_MAGIC_MULTIPLIER for checking EXAR chip,
    use s->devtype directly
  - replace while loop to fls function and expanded check
  - sort compatibles
  - reformat multiline comment.

Changes in v4:
  - rebase onto tty-next branch
  - added Kconfig mention of the chip
  - used rounddown_power_of_two instead of fls and manual shift
  - used FIELD_PREP instead of custom macro
  - removed has_dld bit from common struct, replaced by check function,
    which checks directly by s->devtype
  - fixed tab count
  - properly apply Vladimir Zapolskiy's tag to patch 2 only

Changes in v5:
  - fixes for tty-next branch
  - address a new code review picks
  - send properly to all participants
  - added Ack tag

Changes in v6:
  - KConfig fixes
  - New code review fixes

Konstantin Pugin (3):
  serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
  dt-bindings: sc16is7xx: Add compatible line for XR20M1172 UART
  serial: sc16is7xx: add support for EXAR XR20M1172 UART

 .../bindings/serial/nxp,sc16is7xx.yaml        |  1 +
 drivers/tty/serial/Kconfig                    |  3 +-
 drivers/tty/serial/sc16is7xx.c                | 63 +++++++++++++++++--
 drivers/tty/serial/sc16is7xx_i2c.c            |  1 +
 drivers/tty/serial/sc16is7xx_spi.c            |  1 +
 5 files changed, 63 insertions(+), 6 deletions(-)


base-commit: f70f95b485d78838ad28dbec804b986d11ad7bb0
-- 
2.34.1


