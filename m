Return-Path: <linux-kernel+bounces-4276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CECE2817AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83891C231EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635485D753;
	Mon, 18 Dec 2023 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFwA6TEQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B14D5A843;
	Mon, 18 Dec 2023 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a236de428a5so43006566b.0;
        Mon, 18 Dec 2023 11:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702926635; x=1703531435; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FtV51mBA8Uop3abJyrVBwepRUDAnZ/VDxeYjqufsJYk=;
        b=jFwA6TEQp1GW1AuZXBXVcn6zuSvzLFifuoPUUjFhO9YLWOCvH1U4SK282Nk0P6N3E7
         Lr05moKMfucyYd/hsv7UuKCtMJe9UEMYYaTROAaBHiUiiFU0VSe9hQzBY77ME6uQEX8p
         U2130ORM5tZErgmBRyPxRmcKYamik5ygR3qrZMnYUmtURuFvXw9txvEm3EIMuc4DOLs8
         wpMQ9McX5ExCX2AdlZoAyTnht13es2ujMLslLm9ELSja7R+vJqoKoPgjiJynj+vtTU1d
         EGwWgL6XtmGyn1dS59vUQLO2xgj1gCGZeS3ZMYjFu/zKZ3ah/6KoNlXHOVxyJAkzK/kg
         V5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702926635; x=1703531435;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtV51mBA8Uop3abJyrVBwepRUDAnZ/VDxeYjqufsJYk=;
        b=rW2cXsgEE5S4nAO652lWBDig3RO12w3FpKSEGlwLQSoFhN8CTOhxNtMV40HzhxWiKf
         i2WVaybHQWs1Oy4Uwi0/NUNerUjjgCG3MHlbjoQE/Vf2n+gg+pjykwmhfZ4MEi4GoBMg
         Izpj9v1prJJ+LJZJEbLimyOVe/1mEHDwCd9fqMNRZLNiijjaTTL8wqZzWCtSXW874YJb
         6D5lF9DMqOAnJ5VnDax8aeodvL9JU8nqOW22sYwEBHIQbCt+MDK5kDxaBPhNJHfBdcRr
         bLSt/QCx9mvkk2pU/WwqozqVqj0h6BL7Shls1d+ymJDQV5Np/ByXa9EKz1gJ3b1DRAvT
         Y+Kg==
X-Gm-Message-State: AOJu0Yz2ZRON0IWd+ExbqsTGMQwi3vZk9MGVe6MZ19nz7R4KvdQ4vkAH
	a88Z9zadUhw0HIhJpm5ZFi0=
X-Google-Smtp-Source: AGHT+IF6+w0TlnnyW897EM+gfRDQl1yuQve6QfbfC+AbZqDjLH5tmyc6O7rAhSTRxsAjJPZDXafCbw==
X-Received: by 2002:a17:906:1009:b0:a23:5a00:326 with SMTP id 9-20020a170906100900b00a235a000326mr1129425ejm.0.1702926635279;
        Mon, 18 Dec 2023 11:10:35 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-339c-9917-d041-4030.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:339c:9917:d041:4030])
        by smtp.gmail.com with ESMTPSA id vw6-20020a170907a70600b00a1d80b665dfsm14398956ejc.26.2023.12.18.11.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 11:10:34 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v4 0/5] hwmon: Add support for Amphenol ChipCap 2
Date: Mon, 18 Dec 2023 20:10:28 +0100
Message-Id: <20231020-topic-chipcap2-v4-0-7940cfa7613a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACSZgGUC/33Nyw6CMBAF0F8hXVvTTimCK//DuOhjgEnkkZYQD
 eHfLew0keWdybl3YREDYWTXbGEBZ4o09Cnkp4y51vQNcvIpMxCgpADBp2Ekx11LozMjcARfVqX
 OlXDAErImIrfB9K7dWGfihGF7jAFreu1L90fKLcVpCO99eJbb9e/GLLngorwgSJ9bif7WdIaeZ
 zd0bKua4ZhD4rV2CnRVFLW3v1wdc5W4tspaLYyuxRdf1/UDMgOBHkMBAAA=
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702926633; l=3893;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=tUUetk6U5Qf1+ktWmLjw4LMYeWqB0v1Yz0I77M4Y3oo=;
 b=bvKuX7PYDfO4pxf6a2Tll1ongdh82ZJIkXOsz3f3nPjJG7YrRb5X9Fl0bMNbjeoN0yk61NWdE
 2yMVIStDm8LAeMUeQUPCbnciTNXSmSyOFGSDD5eqJ/wIPr6HEFxja1o
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This series adds support and documentation for the Amphenol ChipCap 2
humidity and temperature sensor in its digital version.

This I2C device provides 14-bit humidity and temperature measurements as
well as low (minimum) and high (maximum) humidity alarms. A ready signal
is also available to reduce delays while fetching data.

The proposed driver implements the logic to perform measurements with
and without the ready signal, EEPROM configuration and alarm signaling.

The features this driver does not support (I2C address and command
window length modification) have been documented in the "Known Issues"
section.

The complete supported functionality has been tested with a CC2D33S
sensor connected to a Raspberry Pi Zero 2 w.
Different device tree node definitions (with and without ready and/or
alarm signals) have been positively tested.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v4:
- chipcap2.c: require exclusive regulator to trigger command mode.
- chipcap2.c: keep the device off until a measurement is required.
  Because the device makes an automatic measurement after the power-up
  sequence, no differentiation between sleep and non-sleep modes is
  required anymore.
- chipcap2.c: retrieve alarm settings from the device instead of storing
  them locally.
- dt-bindings: add vdd-supply to required properties.
- dt-bindings: default to 'amphenol,cc2d23' compatible (same
  functionality for all compatibles).
- Link to v3: https://lore.kernel.org/r/20231020-topic-chipcap2-v3-0-5b3bb50a5f0b@gmail.com

Changes in v3:
- ABI: sysfs-class-hwmon: documented humidity min/max alarms.
- General: reorder patches (bindings first to remove checkpatch
  warnings).
- General: remove part number wildcards and use real part numbers.
- chipcap2.c: improve error path in probe function.
- chipcap2.c: fix error handling if regulator could not be registered.
- chipcap2.c: use absolute values for hysteresis (for both ABI
  compatibility and simplicity).
- chipcap2.c: minor code-style fixes and variable renaming.
- Link to v2: https://lore.kernel.org/r/20231020-topic-chipcap2-v2-0-f5c325966fdb@gmail.com

Changes in v2:
- vendor-prefixes: full company name in the vendor description (Krzystof
  Kozlowski)
- chipcap2.c: proper i2c_device_id table, coding style fixes, cleaner
  error path in the probe function (Krzystof Kozlowski)
- dt-bindings: per-item description and lowercase names (Krzystof
  Kozlowski)
- MAINTAINERS: fix manufacturer name (Krzystof Kozlowski)
- Link to v1: https://lore.kernel.org/r/20231020-topic-chipcap2-v1-0-087e21d4b1ed@gmail.com

---
Javier Carrasco (5):
      dt-bindings: vendor-prefixes: add Amphenol
      hwmon: (core) Add support for humidity min/max alarm
      ABI: sysfs-class-hwmon: add descriptions for humidity min/max alarms
      dt-bindings: hwmon: Add Amphenol ChipCap 2
      hwmon: Add support for Amphenol ChipCap 2

 Documentation/ABI/testing/sysfs-class-hwmon        |  18 +
 .../bindings/hwmon/amphenol,chipcap2.yaml          |  77 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 Documentation/hwmon/chipcap2.rst                   |  73 ++
 Documentation/hwmon/index.rst                      |   1 +
 MAINTAINERS                                        |   8 +
 drivers/hwmon/Kconfig                              |  10 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/chipcap2.c                           | 835 +++++++++++++++++++++
 drivers/hwmon/hwmon.c                              |   2 +
 include/linux/hwmon.h                              |   4 +
 11 files changed, 1031 insertions(+)
---
base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
change-id: 20231020-topic-chipcap2-e2d8985430c2

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


