Return-Path: <linux-kernel+bounces-107363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E40C687FB7B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D054282C65
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8997E10C;
	Tue, 19 Mar 2024 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K2dcTbjs"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95BB5474B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843094; cv=none; b=C8ad32HitZ1gWAsRodehVR7wwfujoDA1a/rMx+1FqSI3KZNl/T/D2BMAMmLSkw3D+iPeEGovOWqQATG2X1mHoc8u3e/zPcFLJBk1a8DsmSE+T+FFVN8rEJdbzdWTFN3cd5x3sQwo/7wCPwoAra37TRFIvyudFJX76pLCTh587Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843094; c=relaxed/simple;
	bh=zgCeJHF5FoOhBFEVJpVKZMZcO+YaoM0+I6NDZolFmqs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AX/a09OioQodK3RyO/vL5NwQVBcU7n6aBogDTevO6bZBhyuIb0hSpZsL2/o3viDsc99BOUrwdA3AmbtVfBYmxIFqPOAbkJeEa+5bpxubPMUbPx3bcYtExmZboBc8JlR5dwFqX1Dvj7Kov845/LJZi3HQXTeLhTi+Y58dKaQVL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=K2dcTbjs; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513d3746950so6548654e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710843090; x=1711447890; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T9p36sU9HfMy7uSiKtuapYw6MauqlEAD2cg3Q3tKWI0=;
        b=K2dcTbjs8Db0lPRYmwp5Zn+8PIV2R5vIA0VyJWKo0MM/F+4kl+0bn5Kg+ZP7xFOmaR
         GS7noiLg+AVJVnUyrAOj/G1LBSDKsqkDd21RZ3GCIlijildnlqj06oAw/SxLHWzS8VJJ
         D20KpowX/C4yjFgwLINb2nwCxuD7sR3PCuKxeQb8OVudfvIGdrxt7qcG1e68QfusS8EU
         hnrOKCT8q1GfARMCp1gjBaU3mbm/fZ3maMmKMZ78EeXuaRoG9xd1WIPKbS7qMOLmFlpx
         a08Q8EJYIWkpmIZ5VEhOK8HFfntgDsu3iadS6Rra70wzof1zsg47u0CdMDzTpvmQoEjh
         8Bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843090; x=1711447890;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9p36sU9HfMy7uSiKtuapYw6MauqlEAD2cg3Q3tKWI0=;
        b=flzXq4C/9NB0hOXeyORe0BFSfT5Hd0ybJUyC2UZwp77mBx5H3Scc0O6WXbUWAaneOf
         jWdrd6+PGxpMY3t86BUoypqnUAYD7dJy+q6Y6o+cUUPo/t0gbm8IeQSNzW1mjnMqp48A
         EzbS36+Z2XCW6Mg0yux1+oorgbGAymKlxuLeM+xem9f8eSUR0xVIifVspG1wJ6cJkSjb
         iQmzeuz3CQrKs150o8gh82eW+jxqarZzrrNipb/hwmun1WMIIWZk0CcRCD2q9nKZ1p/x
         RPRA6lqgukVhdkYkbFSEaok178DfLlOcLXFJaFIOI63TMAq59U17Tuw4N6kFqUVWIrUh
         ZwNg==
X-Forwarded-Encrypted: i=1; AJvYcCXGzy3Sdy4aaunTyHwyJyziZRXvHZuLgSP7rhYNaaOWwrUL7Vtw5Fr4sSaC+X9aG0M64Jv264OHr4J75wXxDekuCDUcKVR4g2fjtfpL
X-Gm-Message-State: AOJu0Yw/7NGi4PdhdCoXVs7Z3i5Za4miwOG/BkXxuKjFDtg0tghxiZZv
	LNtuQ7pV0P63ooW+e0UqOGd89O9ZPj5i/x03DldXcVlLFlMLytWT0aF65zFTIjU=
X-Google-Smtp-Source: AGHT+IFpJU0YgpYwCnmZr0bTEPYbl+Zu3fDPo43qU14kvDppgqP2UfefknWvYQtpbHl42BVoD50eug==
X-Received: by 2002:ac2:5bcd:0:b0:513:b90f:f4dd with SMTP id u13-20020ac25bcd000000b00513b90ff4ddmr9314245lfn.49.1710843089944;
        Tue, 19 Mar 2024 03:11:29 -0700 (PDT)
Received: from [192.168.1.63] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id je2-20020a05600c1f8200b004133072017csm21096384wmb.42.2024.03.19.03.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:11:29 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v5 0/7] iio: adc: add new ad7380 driver
Date: Tue, 19 Mar 2024 11:11:21 +0100
Message-Id: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMlk+WUC/x2MSwqAMAwFryJZG/DT4ucq4kJtqtlUSUELxbsb3
 M0MvJchkjBFGIsMQjdHPoOKLQvYjiXshOzUoakaU7V1jYtzHHYM9Ch2bZ/QCd8kaP2wWqNt6wz
 o/BLynP7raX7fDxbjDINqAAAA
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Stefan Popa <stefan.popa@analog.com>
X-Mailer: b4 0.13.0

Taking over this series with David Lechner's aproval, to add some
fixes, proper handling of pseudo differential parts and 
some extra commits adding support for 4-channel compatible parts.

Here is David's cover letter:

This series is adding a new driver for the Analog Devices Inc. AD7380,
AD7381, AD7383, and AD7384 ADCs. These chips are part of a family of
simultaneous sampling SAR ADCs.

To keep things simple, the initial driver implementation only supports
the 2/4-channel differential chips listed above. There are also 4-channel
single-ended chips in the family that can be added later.

Furthermore, the driver is just implementing basic support for capturing
data. Additional features like interrupts, CRC, etc. can be added later.

This work is being done by BayLibre and on behalf of Analog Devices Inc.
hence the maintainers are @analog.com.

To: Lars-Peter Clausen <lars@metafoo.de>
To: Michael Hennerich <Michael.Hennerich@analog.com>
To: Nuno Sá <nuno.sa@analog.com>
To: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Changes in v5:
- make ad7380_regmap_config static
  Reported-by: kernel test robot <lkp@intel.com>
  Closes: https://lore.kernel.org/oe-kbuild-all/202401280629.5kknB57C-lkp@intel.com/
- don't use bool in FIELD_PREP
  Reported-by: kernel test robot <lkp@intel.com>
  Closes: https://lore.kernel.org/oe-kbuild-all/202401280629.5kknB57C-lkp@intel.com/
- fix rx/tx buffer for regmap access
- add datasheet links of supported parts
- move reading reference voltage to probe function
- removed DIFFERENTIAL from a few macro names

Adding the following commits on top of the v4
- add supplies for pseudo-differential chips
- prepare driver to add more compatible parts
- add support for 4-channel compatible parts

- Link to v4: https://lore.kernel.org/all/20240110-ad7380-mainline-v4-0-93a1d96b50fa@baylibre.com

Changes in v4:
- Dropped SPI bindings patch.
- Removed `spi-rx-bus-channels` from the adi,ad7380 bindings.
- Link to v3: https://lore.kernel.org/r/20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com

Changes in v3:
- dt-bindings:
    - Picked up Conor's Reviewed-By on the adi,ad7380 bindings
- driver:
    - Removed extra indent in DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL macro
    - Removed scan mask that included timestamp channel
    - Removed parent device assignment
    - Picked up Nuno's Reviewed-by
- Link to v2: https://lore.kernel.org/r/20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com

Changes in v2:
- dt-bindings:
    - Added new patch with generic spi-rx-bus-channels property
    - Added maxItems to reg property
    - Replaced adi,sdo-mode property with spi-rx-bus-channels
    - Made spi-rx-bus-channels property optional with default value of 1
      (this made the if: check more complex)
    - Changed example to use gpio for interrupt
- driver:
    - Fixed CONFIG_AD7380 in Makefile
    - rx_buf = st->scan_data.raw instead of rx_buf = &st->scan_data
    - Moved iio_push_to_buffers_with_timestamp() outside of if statement
    - Removed extra blank lines
    - Renamed regulator disable function
    - Dropped checking of adi,sdo-mode property (regardless of the actual
      wiring, we can always use 1-wire mode)
    - Added available_scan_masks
    - Added check for missing driver match data
- Link to v1: https://lore.kernel.org/r/20231208-ad7380-mainline-v1-0-2b33fe2f44ae@baylibre.com

---
Signed-off-by: Julien Stephan <jstephan@baylibre.com>

---
David Lechner (4):
      dt-bindings: iio: adc: Add binding for AD7380 ADCs
      iio: adc: ad7380: new driver for AD7380 ADCs
      dt-bindings: iio: adc: ad7380: add pseudo-differential parts
      iio: adc: ad7380: add support for pseudo-differential parts

Julien Stephan (3):
      iio: adc: ad7380: prepare for parts with more channels
      dt-bindings: iio: adc: ad7380: add support for ad738x-4 4 channels variants
      iio: adc: ad7380: add support for ad738x-4 4 channels variants

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 148 +++++
 MAINTAINERS                                        |  10 +
 drivers/iio/adc/Kconfig                            |  16 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad7380.c                           | 614 +++++++++++++++++++++
 5 files changed, 789 insertions(+)
---
base-commit: 1446d8ef48196409f811c25071b2cc510a49fc60
change-id: 20240311-adding-new-ad738x-driver-5f9b54ad7c74

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


