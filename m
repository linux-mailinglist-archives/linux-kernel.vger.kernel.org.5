Return-Path: <linux-kernel+bounces-105338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB4D87DC6D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 07:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16563281C92
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 06:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56D1D512;
	Sun, 17 Mar 2024 06:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSmkugFQ"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B84C2F4A;
	Sun, 17 Mar 2024 06:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710656456; cv=none; b=Wuh/xWq3X4AoCslTJkf1fcEU+ErhdeG2qwEd21GNi54cOKsIUr1FZFg+Eg7AJxKWC6OGx5sOLxGCngxCti2YbGGgzPIMwXh23rNDX7VcjtHgXG/1jmLnsNs1UT4YIt1gbm8Iba2ZwxnttM3kkp40Xfry45NsuwaqOVDJ6s2PGGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710656456; c=relaxed/simple;
	bh=S+8671GCPoaRGv9Yjfms1gfadvaBDNAtlAAfwdoh+8M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m5WQTnISVwRqQ1Tu0UcLUZT9rX9t0ZX/8ZelcGYPn/kW52NSvTNWUHU31nUSq6Ko3KWzX5GsoinocvkU8dxyo3kYwh5wm0pSvZRMsdvuZIuTGAGTIy2X6L4IB8ojOzBxpuUr2xDYKFXH9hLK32funsNpVilh7LNryuyqvcpn5oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSmkugFQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6adc557b6so3190396b3a.2;
        Sat, 16 Mar 2024 23:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710656455; x=1711261255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljRI3GTvzq1j0VFwRuFGwbfCB3VhG+MDhaVSRJaVm0M=;
        b=PSmkugFQqSghggJ2w68XE84sAaLMUDetMfTct2l7MU9AYM8YKTIwv2b65hpXehgzWH
         dzJgx7M8vik6qX54S7C45oKm6Gs+xKAqXBQseoa0KabpyIULhh3PimWIYf5VwE48BzQa
         0n8tNjHJ4ML+s5tdfMyIpF1oMPTWlVPNcmMI5PI3BbyPi7/aVg2Y2f7SuMoeG08yPa0J
         wGOhMUyTfqcJsG+5gfw0ddIsPs9Mu991BsaIisElYDePljdVjBfXMyt3XnmGpAEL8P1D
         v//vzxEu6ovKBjvm2bEFXl5npgOCmL2SiUnv/MpIN+mnmXnAavnIIZiB4SD6lqCLD5jF
         NVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710656455; x=1711261255;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljRI3GTvzq1j0VFwRuFGwbfCB3VhG+MDhaVSRJaVm0M=;
        b=YOB6avyGMrMHryIP8OaYUD5SyVmOMqTAcg2Lze11axD7n0D6k+/vlfJJ1IP4F4nOCw
         ywJ/YoS+cuKFT8Jz4SJ0O6qTZmM4VKbw3iFURnSJLDUkiYw8JlyjHBpXTHlCegL3rXeI
         4wZgSJfIhk0DYM7vKqiVLMKELpjL6l5P7TofhII2FuGCYGEEYk6Ckc8OaL4IEblduIVC
         r2XFVc+cs4rHJ0kIFRZOL/P1zUqYMq+9vnGCwLdwxulzYfhYWPI+eiNJf2BAQmgZTPp2
         RU5OUFdWq3/MihP4m4gpjhXFTOnYeJBWDG9pRdI0bOM+mqc4krVRD/ZOLxF+B2x8scXO
         QHhA==
X-Forwarded-Encrypted: i=1; AJvYcCWKZpVCgnO0JCjxYhuaFfsSYdauLeiJk/RY6OfOmr4eHSJdn+Rn41IzmDyXwqWwfhFNQs51QlLGJcxnh0foLMiOXl4xEDYJskiJuSA=
X-Gm-Message-State: AOJu0YygyFRDFfEOKQV8CSWqOzd5yySCliZgVGSzKOG+6NREyB+ov6Pp
	NrBqw7FKTp9DhDeHaNT5Z86NUxgK6O0xK5HKdx42s3aaU5HM1A9950NGcQ2q
X-Google-Smtp-Source: AGHT+IH1uryWEsF5nT8ZNOCJm8zSHTse7QGHFCRmZk9K4P3CLxnBxzh5/IDl6gcl9Az6Wv0SQT6m7A==
X-Received: by 2002:a05:6a00:2da4:b0:6e7:2199:73be with SMTP id fb36-20020a056a002da400b006e7219973bemr738856pfb.14.1710656454555;
        Sat, 16 Mar 2024 23:20:54 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:e3a5:20fc:a5dc:3c2d])
        by smtp.gmail.com with ESMTPSA id fn24-20020a056a002fd800b006e6b415b405sm5793604pfb.36.2024.03.16.23.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 23:20:53 -0700 (PDT)
Date: Sat, 16 Mar 2024 23:20:51 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.9-rc0
Message-ID: <ZfaLw1CiHZDSXCLo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.9-rc0

to receive updates for the input subsystem. You will get:

- a new driver for Goodix Berlin I2C and SPI touch controllers

- support for IQS7222D v1.1 and v1.2 in iqs7222 driver

- support for IST3032C and IST3038B parts in Imagis touchscreen driver

- support for touch keys for Imagis touchscreen controllers

- support for Snakebyte GAMEPADs in xpad driver 

- various cleanups and conversions to yaml for device tree bindings

- assorted fixes and cleanups

- old Synaptics navpoint driver has been removed since the only board
  that used it (HP iPAQ hx4700) was removed a while ago.


Changelog:
---------

Bernhard Seibold (1):
      Input: leds - set default-trigger for mute

Brenton Simpson (1):
      Input: xpad - sort xpad_device by vendor and product ID

Christophe JAILLET (1):
      Input: remove usage of the deprecated ida_simple_xx() API

Colin Ian King (1):
      Input: ti_am335x_tsc - remove redundant assignment to variable config

Dharma Balasubiramani (1):
      dt-bindings: input: atmel,captouch: convert bindings to YAML

Dmitry Torokhov (3):
      Input: matrix_keypad - avoid repeatedly converting GPIO to IRQ
      Input: matrix_keypad - consolidate handling of clustered interrupt
      Input: matrix_keypad - switch to using managed resources

Duje Mihanović (5):
      Input: navpoint - remove driver
      Input: 88pm80x_onkey - add SPDX and drop GPL boilerplate
      Input: imagis - use FIELD_GET where applicable
      dt-bindings: input: imagis: Document touch keys
      Input: imagis - add touch key support

Heiner Kallweit (1):
      Input: leds - change config symbol dependency for audio mute trigger

Jeff LaBundy (1):
      Input: iqs7222 - add support for IQS7222D v1.1 and v1.2

Karel Balej (2):
      dt-bindings: input/touchscreen: imagis: add compatible for IST3032C
      input/touchscreen: imagis: add support for IST3032C

Krzysztof Kozlowski (3):
      dt-bindings: input: silead,gsl1680: do not override firmware-name $ref
      dt-bindings: input: allwinner,sun4i-a10-lrad: drop redundant type from label
      dt-bindings: input: samsung,s3c6410-keypad: convert to DT Schema

Kunwu Chan (1):
      Input: synaptics-rmi4 - fail probing if memory allocation for "phys" fails

Luca Ceresoli (1):
      dt-bindings: input: touchscreen: goodix: clarify irq-gpios misleading text

Luca Weiss (1):
      dt-bindings: input: melfas,mms114: add MMS252 compatible

Markuss Broks (3):
      input/touchscreen: imagis: Correct the maximum touch area value
      dt-bindings: input/touchscreen: Add compatible for IST3038B
      input/touchscreen: imagis: Add support for Imagis IST3038B

Matt Scialabba (1):
      Input: xpad - add support for Snakebyte GAMEPADs

Neil Armstrong (4):
      dt-bindings: input: document Goodix Berlin Touchscreen IC
      Input: add core support for Goodix Berlin Touchscreen IC
      Input: goodix-berlin - add I2C support for Goodix Berlin Touchscreen IC
      Input: goodix-berlin - add SPI support for Goodix Berlin Touchscreen IC

Ricardo B. Marliere (4):
      Input: gameport - make gameport_bus const
      Input: synaptics-rmi4 - make rmi_bus_type const
      Input: serio - make serio_bus const
      Input: make input_class constant

Ruan Jinjie (1):
      Input: bcm-keypad - remove redundant of_match_ptr()

Yang Li (1):
      Input: xilinx_ps2 - fix kernel-doc for xps2_of_probe function

Diffstat:
--------

 .../input/allwinner,sun4i-a10-lradc-keys.yaml      |   1 -
 .../devicetree/bindings/input/atmel,captouch.txt   |  36 -
 .../devicetree/bindings/input/atmel,captouch.yaml  |  59 ++
 .../bindings/input/samsung,s3c6410-keypad.yaml     | 121 ++++
 .../devicetree/bindings/input/samsung-keypad.txt   |  77 ---
 .../bindings/input/touchscreen/goodix,gt9916.yaml  |  95 +++
 .../bindings/input/touchscreen/goodix.yaml         |   5 +-
 .../input/touchscreen/imagis,ist3038c.yaml         |  21 +-
 .../bindings/input/touchscreen/melfas,mms114.yaml  |   6 +-
 .../bindings/input/touchscreen/silead,gsl1680.yaml |   2 +-
 .../devicetree/bindings/power/wakeup-source.txt    |   2 +-
 drivers/input/gameport/gameport.c                  |   4 +-
 drivers/input/input-leds.c                         |   8 +-
 drivers/input/input.c                              |  16 +-
 drivers/input/joystick/xpad.c                      |  14 +-
 drivers/input/keyboard/bcm-keypad.c                |   2 +-
 drivers/input/keyboard/matrix_keypad.c             | 170 ++---
 drivers/input/misc/88pm80x_onkey.c                 |  14 +-
 drivers/input/misc/iqs7222.c                       | 112 +++
 drivers/input/mouse/Kconfig                        |  12 -
 drivers/input/mouse/Makefile                       |   1 -
 drivers/input/mouse/navpoint.c                     | 350 ----------
 drivers/input/rmi4/rmi_bus.c                       |   2 +-
 drivers/input/rmi4/rmi_bus.h                       |   2 +-
 drivers/input/rmi4/rmi_driver.c                    |   6 +-
 drivers/input/serio/serio.c                        |   2 +-
 drivers/input/serio/xilinx_ps2.c                   |   3 +-
 drivers/input/touchscreen/Kconfig                  |  31 +
 drivers/input/touchscreen/Makefile                 |   3 +
 drivers/input/touchscreen/goodix_berlin.h          |  24 +
 drivers/input/touchscreen/goodix_berlin_core.c     | 755 +++++++++++++++++++++
 drivers/input/touchscreen/goodix_berlin_i2c.c      |  75 ++
 drivers/input/touchscreen/goodix_berlin_spi.c      | 178 +++++
 drivers/input/touchscreen/imagis.c                 | 118 +++-
 drivers/input/touchscreen/ti_am335x_tsc.c          |   1 -
 include/linux/input.h                              |   2 +-
 include/linux/input/navpoint.h                     |   8 -
 include/linux/serio.h                              |   2 +-
 38 files changed, 1669 insertions(+), 671 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/atmel,captouch.txt
 create mode 100644 Documentation/devicetree/bindings/input/atmel,captouch.yaml
 create mode 100644 Documentation/devicetree/bindings/input/samsung,s3c6410-keypad.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/samsung-keypad.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/goodix,gt9916.yaml
 delete mode 100644 drivers/input/mouse/navpoint.c
 create mode 100644 drivers/input/touchscreen/goodix_berlin.h
 create mode 100644 drivers/input/touchscreen/goodix_berlin_core.c
 create mode 100644 drivers/input/touchscreen/goodix_berlin_i2c.c
 create mode 100644 drivers/input/touchscreen/goodix_berlin_spi.c
 delete mode 100644 include/linux/input/navpoint.h

Thanks.


-- 
Dmitry

