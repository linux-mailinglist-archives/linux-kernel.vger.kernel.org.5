Return-Path: <linux-kernel+bounces-757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 511B981459F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DC81F225C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF1E1A711;
	Fri, 15 Dec 2023 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pkQhqyuf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5EE1C684
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c580ba223so6150635e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 02:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702636330; x=1703241130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jhaWMxJt5l6q4FIsRW2fysiTs2S/n3S9lW9qDaXU97Y=;
        b=pkQhqyufAR2HAIKVFRE9z9E3MTab6pp/4zEwcQtkH0jcnTuqUlkjMVU+vgLdWm9Fyb
         /rlyqdq9LOB12MpdSOKGiqBbXReow8Fen/X6a2Y6JkN9W+vRWROFb01pB8G1/rD1XCi/
         PaR0glyxPARtkALjHG9f7EyWDVOfTA/sXoETar4Uw158Aybl7tn+53C14/mgfC2yOPcf
         zx0GZmvNTXVnRT2Gb+GfdIHs+ymhfuEJiy8DzPb1I/HD9eR/5ZUuuMzY08/TXwG+6OKV
         5wsXwWRy2usu/pwHjc59O35IHdaIva6BnrAIA+xCPoNvIn1hlf207C5n5I1Igx8Z34x1
         bVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702636330; x=1703241130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhaWMxJt5l6q4FIsRW2fysiTs2S/n3S9lW9qDaXU97Y=;
        b=e/4Y9EIpzvCauqpP3/yI59rlexiBGO8pqGOWC+/a29BKWX/YbX1Us3eXPJDP3GbJ61
         6Ov08FUzjArbjMJKL4f9Ef+M23ITBmF/7KN5PeuCjAeyYJbw39m/w7QB0YFdYN0Dndem
         jTj7TXvvLR/TdrmEEiXmQ/tCAMcdHimlQIgtiDNeEas8VXCFsBkaxy/ROlUJjbx56j5x
         9Q8Q/iDLJYq3ZydkPKEsyPGopLixxUAdpM4ZWeaYrMr+22iqMk3zAUaBxyq3xvpefkVW
         VuUqj4/WUO1bwDyf3lknZRulqrl91pJM8nHE9R0zP7NBSYG/P4OCnbgk6LpdpoR7GGLW
         283Q==
X-Gm-Message-State: AOJu0Yw5hIHEGxZmHtqrPy5oqXrAVo15CTKagZ1B4pjFd7tj2bOIrK4T
	RkcvBNwzwiJbp/E05NotREydhg==
X-Google-Smtp-Source: AGHT+IG7urKWjWUg8y89hKTSC8KawPNu3wHwDble3mtMje6XhbiGEHUoNara2tSed5io3NdqWOwjPA==
X-Received: by 2002:a05:6000:235:b0:336:4a69:aaa1 with SMTP id l21-20020a056000023500b003364a69aaa1mr1463431wrz.93.1702636329903;
        Fri, 15 Dec 2023 02:32:09 -0800 (PST)
Received: from localhost.localdomain (abordeaux-655-1-152-60.w90-5.abo.wanadoo.fr. [90.5.9.60])
        by smtp.gmail.com with ESMTPSA id q11-20020adffecb000000b003332db7d91dsm18421015wrs.39.2023.12.15.02.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 02:32:09 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH v3 0/3] iio: adc: add new ad7380 driver
Date: Fri, 15 Dec 2023 04:32:01 -0600
Message-Id: <20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This series is adding a new driver for the Analog Devices Inc. AD7380,
AD7381, AD7383, and AD7384 ADCs. These chips are part of a family of
simultaneous sampling SAR ADCs.

One quirk of these chips is that since they are simultaneous sampling,
they have multiple SPI data output lines that allow transferring two
data words (one for each input channel) at the same time. So a new
generic devicetree binding is added to describe this sort of SPI bus
configuration.

To keep things simple, the initial driver implementation only supports
the 2-channel differential chips listed above. There are also 4-channel
differential chips and 4-channel single-ended chips in the family that
can be added later.

Furthermore, the driver is just implementing basic support for capturing
data. Additional features like interrupts, CRC, etc. can be added later.

Also, FYI, this driver will also be used as the base for an upcoming
series adding AXI SPI Engine offload support for these chips along with
[1].

This work is being done by BayLibre and on behalf of Analog Devices Inc.
hence the maintainers are @analog.com.

[1]: https://lore.kernel.org/linux-spi/20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com/

---
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
David Lechner (3):
      dt-bindings: spi: add spi-rx-bus-channels peripheral property
      dt-bindings: iio: adc: Add binding for AD7380 ADCs
      iio: adc: ad7380: new driver for AD7380 ADCs

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 107 +++++
 .../bindings/spi/spi-peripheral-props.yaml         |  12 +
 MAINTAINERS                                        |  10 +
 drivers/iio/adc/Kconfig                            |  16 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad7380.c                           | 462 +++++++++++++++++++++
 6 files changed, 608 insertions(+)
---
base-commit: 18f78b5e609b19b56237f0dae47068d44b8b0ecd
change-id: 20231208-ad7380-mainline-e6c4fa7dbedd

