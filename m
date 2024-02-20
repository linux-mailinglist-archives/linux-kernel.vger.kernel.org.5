Return-Path: <linux-kernel+bounces-73083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C55185BD5B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2FD1C22D2F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975876A348;
	Tue, 20 Feb 2024 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D0wVH8Zx"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE384C60;
	Tue, 20 Feb 2024 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436399; cv=none; b=sT6n54azLk5rQuURgA8PyR1VIW8iRE//RDEMoIAEfV55s4I/Vlsfs3zouF/2gS+kx9Ia3+3lGpBnRYvKAzjSK+SRBUhxnUb6R1YLpwjMmr4u/Falqj2uIo2nG1bxlAAe3QsZB5V4ltTKyHqlR4hlnUurIVcSAem22FJgWhjj8Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436399; c=relaxed/simple;
	bh=maUOB1I/kGF7pxO+VAjAEbO4lZcaywIU34qr1xonNlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l0IMDBQv6nIZbI1FIpsSp2FQyVf80i4yQHkfMroHCz3lAmrfin4viRvoxSuiPTuJ/P7e+boJQf9r7NlNy+UUP+QQHrO0TjFh59AqIOEybXjEVEjRDiTQwvBhzwpCi99oMvrKvkBxfk6S0un534QnX0S1wHrsNbiluwmj7j2EEdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D0wVH8Zx; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id D42FF20004;
	Tue, 20 Feb 2024 13:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708436395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JR5bxG1GSyiF5ERk11qYZtMLEqsuYC3EasEln4G35iQ=;
	b=D0wVH8ZxwoErTe+VqwqvA29q5zZjYHP66v8cKgfbdKh70MIQBuqFMtf1xTc9Bcyf9i+wT5
	vFvkzyHA8FdGvsppHWxBjlVYwDEFbOvEV/Ew3H68t4aVwwVbECf0uGX/c1RrMkGId8aL3U
	YNkEkee0IPomt0KwmWaPdTPign4o/Ds85GxDvmAW88LTWiWY8Ye1UJHyR2GEsJ+S034PjA
	+1dIqXA5f3yKos+E54FvA5r/DSe9XV3msVL2TiqAqFNfK8K3KAm9eH1bmHjZAN/3uq0b7u
	ZcQCZ0FPn9DermON9GYt9tW+fjnKm0G1bkoTrzUPc6w4UnNdNvyW8wWK0RuHIA==
From: Herve Codina <herve.codina@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH RESEND 0/2] leds: gpio: Add devlink between the leds-gpio device and the gpio used.
Date: Tue, 20 Feb 2024 14:39:47 +0100
Message-ID: <20240220133950.138452-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

Note: Resent this series with Saravana added in Cc.

When a gpio used by the leds-gpio device is removed, the leds-gpio
device continues to use this gpio. Also, when the gpio is back, the
leds-gpio still uses the old removed gpio.

A consumer/supplier relationship is missing between the leds-gpio device
(consumer) and the gpio used (supplier).

This series adds an addionnal devlink between this two device.
With this link when the gpio is removed, the leds-gpio device is also
removed.

Best regards,
Hervé Codina

Herve Codina (2):
  gpiolib: Introduce gpiod_device_add_link()
  leds: gpio: Add devlinks between the gpio consumed and the gpio leds
    device

 drivers/gpio/gpiolib.c        | 32 ++++++++++++++++++++++++++++++++
 drivers/leds/leds-gpio.c      | 15 +++++++++++++++
 include/linux/gpio/consumer.h |  5 +++++
 3 files changed, 52 insertions(+)

-- 
2.43.0


