Return-Path: <linux-kernel+bounces-152347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C958ABCB8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 20:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF3F1C20ABD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 18:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DA33D555;
	Sat, 20 Apr 2024 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="Vbkthjpq"
Received: from forward200a.mail.yandex.net (forward200a.mail.yandex.net [178.154.239.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A0E625;
	Sat, 20 Apr 2024 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713637732; cv=none; b=ptq2mb3YTWbxmUq8jRaWWkwU8mFlnVoNLYRUgxyfFlRp0poQm4cIHIPMh3fpaV/H6eSF5PTq7KbrC2IWuGy27NVqFA0R+i9844uNabQdxoLgQRDU/BBddzb7YuKi0vuyP5IKk3EGk/uSGL98jKYKe1vf96pmlbmoYv9u7rjjozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713637732; c=relaxed/simple;
	bh=pG4Ijf8DkiaTFtOBiAhASDucruDum0mw3xKepkVYn/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=modIm82Mv6NUz/a6zOBjwIpiIKVX7QO9XAHQ4PMDjblQUxlP/u4V74aP8Xlp5QvMovQdYi+UA3LZGrtAsP1cKd99huR0MzoZ56OrdhYVGKFtHEz6ZjGVwaW7yUxsuSk+4FwA9r1L0yMc+N6xtGvXxzDjgEyrasTSQk1rntQooJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=Vbkthjpq; arc=none smtp.client-ip=178.154.239.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward200a.mail.yandex.net (Yandex) with ESMTPS id 2F94F60E19;
	Sat, 20 Apr 2024 21:22:45 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:60f:0:640:4965:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id C6228608C5;
	Sat, 20 Apr 2024 21:22:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id WMMqk3Bj1a60-PZk3C2Iw;
	Sat, 20 Apr 2024 21:22:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713637355; bh=33UBdqcP595C65pAcKcIwfasCnlVAcHEBUGywhm9LCg=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Vbkthjpq0c4ZNdGFi+nMlqd5l9VrF/4hr891vpFHcl+xummAryxmp4YwDFUaYwVO2
	 k8IStj0vxvSiDRCsPPj312LnN1GtWCBYioySegoGcaUqLEkEW/kj35rmDpPV8cBwcg
	 K2Dbt+WoiZJ39KGG7TMlFV8yycX9MktdMj6bHGdg=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
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
Subject: [PATCH v5 0/3] add support for EXAR XR20M1172 UAR
Date: Sat, 20 Apr 2024 21:22:03 +0300
Message-ID: <20240420182223.1153195-1-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.44.0
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

Konstantin Pugin (3):
  serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
  dt-bindings: sc16is7xx: Add compatible line for XR20M1172 UART
  serial: sc16is7xx: add support for EXAR XR20M1172 UART

 .../bindings/serial/nxp,sc16is7xx.yaml        |  1 +
 drivers/tty/serial/Kconfig                    | 18 +++---
 drivers/tty/serial/sc16is7xx.c                | 62 +++++++++++++++++--
 drivers/tty/serial/sc16is7xx.h                |  1 +
 drivers/tty/serial/sc16is7xx_i2c.c            |  1 +
 drivers/tty/serial/sc16is7xx_spi.c            |  1 +
 6 files changed, 71 insertions(+), 13 deletions(-)


base-commit: f70f95b485d78838ad28dbec804b986d11ad7bb0
-- 
2.44.0


