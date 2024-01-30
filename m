Return-Path: <linux-kernel+bounces-45314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB73B842E63
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626C528699C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C99A762D8;
	Tue, 30 Jan 2024 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHaIw+OC"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B55762C1;
	Tue, 30 Jan 2024 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648813; cv=none; b=EttBKKuksbbHLi4IflV9fGW/YkzL1EZNnUn/3WuoqHNoZhL2KpajA0JF5iaJFJ+bum7XPzmQyLGWPrSbHr8mok8c9ixD1nfcYh8t2VaxZjaR8FkQB+laHvlnz3aH849NPxnS83yTUK70STavv1CO//f5stvNWhsRiDX/rYM4BKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648813; c=relaxed/simple;
	bh=G7oKuuUl6F/NZVDaLnFrLG+cVIgz6WY292NlMMKuYrQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cpNVkFdfP4GbVPfoDoZzLzdo0gxgwK34UzRTGvmIT0adBbv2MwwUg2kM6PM53l+mfZUpXRHdrVGe8HCU6VC5nxG7wDjw25RpOJVy4SFWU5ZZ1K/9rRHslRn2wjTb1eeapmoaMS8pdC8OymdK1KaCMkK3tvwYsXvim3xlMSbW2R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHaIw+OC; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a35e9161b8cso309418366b.3;
        Tue, 30 Jan 2024 13:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706648810; x=1707253610; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YZ8+EIN9jvWos6oJV0QHQ8FYXYo9RbLYxWqS1XhaSxU=;
        b=ZHaIw+OCDttx+teTxkSVg8NT01pN29dQ+3HccKkvuz4ZLQZ7YChljLAPsdCwNDpszp
         jWO0ZqcZ8dYGYMQfO7/h/EWvdSoqPDN/ChdVwHADRAv7NJwmdc4yTL/Y/FnK+eZBog3c
         TULNo2Z/Oq9haK7WBNMFVJS0xkpRmMPvWI5tLP1KM2FQYYONGdBtaNmINCeaALKCiEwI
         JEsmud2xUFphvanG7u+aYzJ6Si1eXjyAL29FxKczKuw4NYNqKiQHRkgjN5Kr1/Nb7e8K
         cEn6aQkA8HZZ8l9q57pKwaaZROvs8EHvfoWyw9GzukKfHsom/GPFKN8AAQtBGLgbeKBC
         5KHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706648810; x=1707253610;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZ8+EIN9jvWos6oJV0QHQ8FYXYo9RbLYxWqS1XhaSxU=;
        b=MBGGlBz3KABXa7xMGyrZ6D9bFLrqa+fHFhmBaqHlYSgCh7gKltrx8wmSdpp/BGvTvr
         5MDGuPxhfxUVSWRN0dg7wVcY1IvL78unYco5Tgdl7VG0Kp1E9ADzOXv8bo79dh3oPF67
         USuSKNZfvB8bt71nxqQckEyIsaIp4SueWfBwTxBChdlvHsfGj0T9K+sUd6iPk/XNz0Zj
         P6yNxhqZ+tr2bXxFYzOZdYSFsqPNzvrHlo3YdTdyOLOdqc9M/MUlKwgg/sAFGxXccPNp
         vi8WysDJ4jtGMeuRwqCF8Jwls6RCDv0473hxXfKuhe1Olkr1obILomD8FxJw9PK9jG7R
         0++A==
X-Gm-Message-State: AOJu0YzEMdOD+bASN7d7p/xZf4a8GCILeJ+YF4yW9R62ldaL2253fDvW
	KmZ4sT5q7Ko21d0CxMzklfCo9mXdaKiewSXgG5Nlhkwf5qE+dIpMfTySmC2fQsJYfg==
X-Google-Smtp-Source: AGHT+IGXu7ve4aWQ6lJGgiKjDUx3vSF47ChVsAhkYKh9f9p4hzolWAMdm/G+BjEl6t/yxqfbOVB17w==
X-Received: by 2002:a17:906:26d6:b0:a36:239:77a with SMTP id u22-20020a17090626d600b00a360239077amr2770367ejc.23.1706648809486;
        Tue, 30 Jan 2024 13:06:49 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7400-ff68-7ab4-4169.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7400:ff68:7ab4:4169])
        by smtp.gmail.com with ESMTPSA id vv9-20020a170907a68900b00a354a5d2c39sm4177658ejc.31.2024.01.30.13.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:06:49 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v6 0/5] hwmon: Add support for Amphenol ChipCap 2
Date: Tue, 30 Jan 2024 22:06:43 +0100
Message-Id: <20240130-topic-chipcap2-v6-0-260bea05cf9b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAONkuWUC/33Py2oDMQwF0F8JXtfFz3lk1f8oXciynDF0HtjDk
 BDm32sHCiWhs7wSRxfdWaYUKbPz6c4SbTHHeSqheTsxHGC6EI++ZKaE0lIowdd5ichxiAvCojg
 p3/WdNVqgYgU5yMRdggmHykbIK6W6WBKFeH00fX6VPMS8zun2KN5knf7bsUkuuOhaUtIbJ8l/X
 EaI3+84j6ye2tQxV4UHi1rZvmmCd89cH3NduHXaOSvABvHCzTE3hbe9ERigbaSGZ25/uRFS2hd
 u6++ILUgLREh/+b7vP4/mg+DBAQAA
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
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706648808; l=4466;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=G7oKuuUl6F/NZVDaLnFrLG+cVIgz6WY292NlMMKuYrQ=;
 b=Zu0HFbkr9fhRhf5eAsAfsGyZWgrC0dFdTdGmMg/sUhsyI+/JE7GFuPIybm7inWX4EvJ3yvQ2U
 3CrMyjPSEVpCeklxe4u2h/PwPD0montaLSpJ097f0MwJ0eImP8s9IIA
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This series adds support and documentation for the Amphenol ChipCap 2
humidity and temperature sensor in its digital version.

The Chipcap 2 is an I2C device that provides 14-bit humidity and
temperature measurements as well as low (minimum) and high (maximum)
humidity alarms. A ready signal is also available to reduce delays
while fetching data.

The proposed driver implements the logic to perform measurements with
and without ready signal, EEPROM configuration and alarm signaling.

The features this driver does not support (I2C address and command
window length modification) have been documented in the "Known Issues"
section.

The complete supported functionality has been tested with a CC2D33S
sensor connected to a Raspberry Pi Zero 2 w.
Different device tree node definitions (with and without ready and/or
alarm signals) have been positively tested.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v6:
- chipcap2.c: remove TODO about regulator delays (handled by the
  regulator core).
- chipcap2.c: add comment to clarify regularor enable checks (exclusive
  regulator).
- chipcap2.c: simplify irq handling (irqs disabled while the device is
  switched off).
- Link to v5: https://lore.kernel.org/r/20240115-topic-chipcap2-v5-0-0cc7a15aeece@gmail.com

Changes in v5:
- dt-bindings: add "amphenol,cc2d23" to "compatible" in the example.
- Link to v4: https://lore.kernel.org/r/20231020-topic-chipcap2-v4-0-7940cfa7613a@gmail.com

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
 drivers/hwmon/chipcap2.c                           | 816 +++++++++++++++++++++
 drivers/hwmon/hwmon.c                              |   2 +
 include/linux/hwmon.h                              |   4 +
 11 files changed, 1012 insertions(+)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20231020-topic-chipcap2-e2d8985430c2

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


