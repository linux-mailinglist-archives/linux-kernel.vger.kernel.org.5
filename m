Return-Path: <linux-kernel+bounces-38832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 881C783C6AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17366B24E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C1F6EB71;
	Thu, 25 Jan 2024 15:32:07 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A09E6EB79;
	Thu, 25 Jan 2024 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196726; cv=none; b=qV2FzvXfP8qoF58uj8aX3YFOSHQ0kJW8bIDhvovC2ENnlcg/DLWY2xxtDNBaaVc/VfGy98/b+GnRmqNWMsTYE7fhpDrmHcfabx8NkLwOnh8b7c3cwdO8n2STU3Jy3kW4tI7iy3agTdpFauzprqq7VivzhnYIoybKk9HOg/HQHFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196726; c=relaxed/simple;
	bh=+6Yd/SIY7+PpoZIiO/j9Pbc8AItxvrchumutM14SXOo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s58SOc8mJN0UpPK4X/LncfdrVp2PNX9B3pMau++ZY4K/jA0sbN6DViSC/kbAAg5WM6Q0BSgJCQHfuVtvS28OILvq4ai3SBeNdDUwfEJhQnhYguBAKmoXfsgszDF+rp2nFnjZx5AHx2yTJAIBao6CFodcGUjF2SOQRlJiTO+R/IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 4ADD2861F8;
	Thu, 25 Jan 2024 16:31:55 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH v5 0/4] Kinetic ExpressWire library and KTD2801 backlight
 driver
Date: Thu, 25 Jan 2024 16:30:52 +0100
Message-Id: <20240125-ktd2801-v5-0-e22da232a825@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKx+smUC/13MQQrCMBCF4atI1lYmM0lNXXkPcdGkExsUK4kUR
 Xp300JtcfmG+f6PSBwDJ3HYfETkPqTQ3fPQ241wbX2/cBGavAUCkgRQxfXZoAFZgCdjyFldNSD
 y9yOyD6+pdDrn3Yb07OJ7CvdyvM4N/Wv0OVMoco3RFkqs6mO6djfetVGMiR5npkBKszAcGWrnC
 Rn2ZfXHaMUQFkaZeUZna++9RfnH1JrhwlRmRK4yZU1sS7NiwzB8ASrIhqBCAQAA
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2989;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=+6Yd/SIY7+PpoZIiO/j9Pbc8AItxvrchumutM14SXOo=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlsn7Di/IlWPx9bZ3kSn1YnOKO3WrECmW3I7iXf
 gobDA2cbVKJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZbJ+wwAKCRCaEZ6wQi2W
 4X93EACnJQIcXvBW6lLq4WJK8I9wJTw1VyaMQ4WpvjEB1nYu0xtAKDUAYQ6Af4h+2ywhOud0dh5
 SE1/phuGpGx09pj+30prB+dFAG0gi43i9zKq9nhfweHkzZc/czT4nUsls6PBRqPLTik8UQvcS7P
 jdiYywa2hDFeIvZoPVU3gKI3eGpJz3jlrL2tVk+B3c7n5SlXMowbMA4G5Ojsgt9kc9xWc1TgTRY
 5qywnZeBjIAh3q9OuIzNy8ydRy1Vy7IihL68i1l5yy9elAt3Y/n0BOTnwLrBQ/woKEn8JPuRg69
 90wJKtseCFeDuq5osAAXBt4Xf+ejKnhgpw2NMnnDy7QbGZ1gKm1lbXVihvXzl8Ix3uBQAcO46Wh
 jYnUo62isYmQp5br7shCNG+proeAA6MFHRR0ljd/PhM9qQ/uRLGy/02GYfKKU3l5Ti42A1sZt0/
 x4nVY1S59h4KaEsJ78hSqCUsxCbhvl7vpG3ad43CGjnONlaEclps90Wn0o2JXmiHFfQChAZtK5t
 6dyXwAU/5U/Z2mlaaX7VfMlpspe85H6I9nPZ7Vz0RK7tFlqex53sGzp5k9myp6F3HbDro1PDgYL
 S4laPVQf0GXN/8XH1uSFkXkVBQWTpgLqkEO++HosHDR31QciRvIxJGbPztVVoU/glxODCLuTrDn
 bwOyLvdVYfrN4ow==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Hello,

This series adds support for the Kinetic KTD2801 LED backlight driver
IC found in samsung,coreprimevelte.

Support is already upstream for the somewhat similar KTD2692 flash
driver, and this series since v3 also moves its ExpressWire code into a
separate library and converts the KTD2692 driver to use that library.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Changes in v5:
- Split up ExpressWire library and KTD2692 conversion
- Rebase on v6.8-rc1
- Link to v4: https://lore.kernel.org/r/20240122-ktd2801-v4-0-33c986a3eb68@skole.hr

Changes in v4:
- Drop 'extern' keywords in leds-expresswire.h
- Add 'expresswire_write_u8' to leds-expresswire.c and use it in the two
  drivers
- Move GPIOLIB dependency to LEDS_EXPRESSWIRE instead of letting clients
  handle it
- Drop time constant macros
- Drop delay.h include in ktd2692
- Drop bits.h and delay.h includes in ktd2801
- Link to v3: https://lore.kernel.org/r/20240120-ktd2801-v3-0-fe2cbafffb21@skole.hr

Changes in v3:
- Split ExpressWire code into library (and convert KTD2692 to use this
  library)
- Rewrite commit messages
- Add link to datasheet
- Drop of.h include in ktd2801
- Use _cansleep and usleep_range when powering off
- Clean up bitwise operation in update_status
- Link to v2: https://lore.kernel.org/r/20240118-ktd2801-v2-0-425cf32e0769@skole.hr

Changes in v2:
- Address maintainer comments:
  - Drop MODULE_ALIAS
  - Rename enable-gpios to ctrl-gpios
  - Rename ktd2801_backlight->desc to ktd2801_backlight->gpiod
  - Give time constants more descriptive names and note their origins in
    Samsung driver
  - Convert to GPIO_ACTIVE_HIGH
- Update trailers
- Link to v1: https://lore.kernel.org/r/20231005-ktd2801-v1-0-43cd85b0629a@skole.hr

---
Duje Mihanović (4):
      leds: introduce ExpressWire library
      leds: ktd2692: convert to use ExpressWire library
      dt-bindings: backlight: add Kinetic KTD2801 binding
      backlight: Add Kinetic KTD2801 backlight support

 .../bindings/leds/backlight/kinetic,ktd2801.yaml   |  46 ++++++++
 MAINTAINERS                                        |  13 +++
 drivers/leds/Kconfig                               |   4 +
 drivers/leds/Makefile                              |   3 +
 drivers/leds/flash/Kconfig                         |   2 +-
 drivers/leds/flash/leds-ktd2692.c                  | 116 +++++--------------
 drivers/leds/leds-expresswire.c                    |  68 +++++++++++
 drivers/video/backlight/Kconfig                    |   7 ++
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/ktd2801-backlight.c        | 128 +++++++++++++++++++++
 include/linux/leds-expresswire.h                   |  36 ++++++
 11 files changed, 334 insertions(+), 90 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20231004-ktd2801-0f3883cb59d0

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>



