Return-Path: <linux-kernel+bounces-22671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF8182A13D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A2B1F22A14
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6454EB41;
	Wed, 10 Jan 2024 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rlV+Lv/2"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0874E1D2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5988e55ede0so817032eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704916268; x=1705521068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YMKckuP8XGsuDmaIXHNVROp60ZPbWd85oO+z2O6Q+eU=;
        b=rlV+Lv/2M46E5d57/s7svXRFPO1G/yjLF1CGfoZ9zySL6EyZTS62oCxYdCPqWGFQGe
         pwnoGlP67EdxJUtmX1OWNeFkku/W8km3nhLUFQGWkWlJjWRPonuTm8r8E+NUgTd9j+SH
         M7mnrdu6obv0fI8Qw5VN9mDZa44rrjrxsg6BspL8BhtD2iZC5RjqyWJQBFHJUKFXOlg9
         +DRCLCfNE6av2Jk0WheJa5Aj8Lmef6uGLnkTGi4qCUt69UF4+Qq/t4at5yUAbTtnbrCo
         tmQf3vMwecQEhjpVaCieOxKjLCAZs8c6TDUxEW/AY5SQLp/gLOcCNFw6s5C57ehij/9P
         wyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704916268; x=1705521068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YMKckuP8XGsuDmaIXHNVROp60ZPbWd85oO+z2O6Q+eU=;
        b=IENA+7KYa33IT8hTRFCWq//eYFFOxVE3W+FI/cLx1QP45QKdtibrtR4gLQ+o9jI9DY
         RAyxn7yXPvEwZGDUAE1kjrxQBcAQ3Dvy53jfmxImiuulCL8yRiOjixHVvmImAZYtiUIl
         AOFsFJzzkYUK1DHAFVegzDlRAorxeUCar1OHrow+fAsLWH1r5bu/52JSWFPjulvqbI0Q
         MHWh4RGolVVH7bHvgadUJbbE3eA36aRNO6EDaqBkcOPv/RhN2Grp5JVfmRdHk7UUsDUS
         7WvVFvyr2cHgo0WxpnwJSz7YwPCdjN1PhueQoW9t6tTcnUwYhNTf2GCe34oUrJRdI0C7
         rTsA==
X-Gm-Message-State: AOJu0YzuWEHz9GeL//oyGJ/e2BuiAFt8noB4OD0eSvnyUcPU5mpPcmaE
	buZ4jyh7G3r1r+xUK2Stio8g0W4MKs4ApQ==
X-Google-Smtp-Source: AGHT+IFoWmtz9bWO7VnnQScDOXIo/P6RzNPrDSxSQhS3I9XZeWyQUSus9HfRsN+aQncWLIqgoG29dA==
X-Received: by 2002:a05:6820:22a1:b0:596:1270:cb9 with SMTP id ck33-20020a05682022a100b0059612700cb9mr115534oob.12.1704916268482;
        Wed, 10 Jan 2024 11:51:08 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 187-20020a4a0dc4000000b00595b35927a3sm938513oob.39.2024.01.10.11.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 11:51:08 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Frank Rowand <frowand.list@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 00/13] spi: axi-spi-engine: add offload support
Date: Wed, 10 Jan 2024 13:49:41 -0600
Message-ID: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This is the culmination of the previous AXI SPI Engine improvement
series [1] and [2] where we made fixes and improvements to prepare
for adding offload support.

Simply put, "offload" support is defined as a capability of advanced
SPI controllers to record a series of SPI transactions and then play
them back using a hardware trigger. This allows operations to be
performed, possibly repeating many times, without any CPU intervention.

The offload hardware interface consists of a trigger input and a data
output for the RX data. These are connected to other hardware external
to the SPI controller.

To record one or more transactions, commands and TX data are written
to FIFOs on the controller (RX buffer is not used since RX data gets
piped to external hardware). This sequence of transactions can then be
played back when the trigger input is asserted.

This series includes core SPI support along with the first SPI
controller (AXI SPI Engine) and SPI peripheral (AD7380 ADC) that use
them. This enables capturing analog data at 2 million samples per second
with virtually no jitter.

The hardware setup looks like this:

+-------------------------------+   +------------------+
|                               |   |                  |
|  SOC/FPGA                     |   |  AD7380 ADC      |
|  +---------------------+      |   |                  |
|  | AXI SPI Engine      |      |   |                  |
|  |      SDO/SDI/SCK/CS ============ SDI/SDO/SCK/CS   |
|  |                     |      |   |                  |
|  |  +---------------+  |      |   |                  |
|  |  | Offload 0     |  |      |   +------------------+
|  |  |   RX DATA OUT > > > >   |
|  |  |    TRIGGER IN < < <  v  |
|  |  +---------------+  | ^ v  |
|  +---------------------+ ^ v  |
|  | AXI PWM             | ^ v  |
|  |                 CH0 > ^ v  |
|  +---------------------+   v  |
|  | AXI DMA             |   v  |
|  |                 CH0 < < <  |
|  +---------------------+      |
|                               |
+-------------------------------+

This series adds support in three phases.

1. Adding support in the SPI subsystem.

    This is broken down into two parts.

    1. Adding offload support to the SPI core.

        * "spi: add core support for controllers with offload capabilities"

    2. Implementing the new offload interface in the AXI SPI Engine
       controller driver.

        Prerequisites to avoid errors with new DT bindings:
        * "scripts: dtc: checks: don't warn on SPI non-peripheral child
          nodes"
        * "spi: do not attempt to register DT nodes without @ in name"

        DT bindings and corresponding driver changes:
        * "spi: dt-bindings: adi,axi-spi-engine: add offload bindings"
        * "spi: axi-spi-engine: add SPI offload support"

    RFC question for this part: I have made the device tree bindings
    specific to the controller. Would it be better to make them generic
    SPI bindings since offload is intended to be a generic SPI feature?
    Or should we require each controller to have its own bindings?

2. Adding a new offload hardware trigger buffer driver in the IIO
   subsystem.

    Since offloads are generic, we need to specify what is attached to
    the trigger input and the data output. This is modeled as a platform
    device that uses a compatible string to specify what is connected.

    In this case, we have a PWM that is used to periodically trigger
    the offload to read a sample from the ADC. The received data is then
    piped to a DMA channel that transfers it to an IIO buffer.

    This is broken down into two parts.

    1. Adding a generic interface/helper functions for hardware
       triggered hardware buffers.

        * "iio: buffer: add hardware triggered buffer support"
        * "iio: buffer: dmaengine: add INDIO_HW_BUFFER_TRIGGERED flag"
        * "iio: buffer: add new hardware triggered buffer driver"

    2. Adding a specific implementation of this interface for this
       particular hardware configuration.

        Prerequisites for new driver:
        * "bus: auxiliary: increase AUXILIARY_NAME_SIZE"
        * "iio: buffer: dmaengine: export devm_iio_dmaengine_buffer_alloc()"

        DT bindings and corresponding new driver:
        * "dt-bindings: iio: offload: add binding for PWM/DMA triggered
          buffer"
        * "iio: offload: add new PWM triggered DMA buffer driver"

3. Adding offload support to the AD7380 ADC driver.

    Once the two components above are in place, we can add offload
    support to the AD7380 ADC driver.

    * "iio: adc: ad7380: add SPI offload support"

Build and runtime dependencies:
* The "spi: axi-spi-engine:" patch depends on the previous to series
  [1] and [2] to apply cleanly (these have been applied to spi/for-6.8).
* The "iio: adc: ad7380:" patch depends on the driver introduced in [3]
  (accepted but not applied yet).
* The "iio: buffer:" patches have a runtime dependency on [4] to
  function properly.
* A branch with all dependencies and additional patches for a full
  working system can be found at [5].

[1]: https://lore.kernel.org/linux-spi/20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com
[2]: https://lore.kernel.org/linux-spi/20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com
[3]: https://lore.kernel.org/linux-iio/20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com
[4]: https://lore.kernel.org/linux-iio/20240108200647.3916681-1-dlechner@baylibre.com
[5]: https://github.com/analogdevicesinc/linux/tree/dlech/spi-engine-offload-ad7980

---
David Lechner (13):
      spi: add core support for controllers with offload capabilities
      scripts: dtc: checks: don't warn on SPI non-peripheral child nodes
      spi: do not attempt to register DT nodes without @ in name
      spi: dt-bindings: adi,axi-spi-engine: add offload bindings
      spi: axi-spi-engine: add SPI offload support
      iio: buffer: add hardware triggered buffer support
      iio: buffer: dmaengine: add INDIO_HW_BUFFER_TRIGGERED flag
      iio: buffer: add new hardware triggered buffer driver
      bus: auxiliary: increase AUXILIARY_NAME_SIZE
      iio: buffer: dmaengine: export devm_iio_dmaengine_buffer_alloc()
      dt-bindings: iio: offload: add binding for PWM/DMA triggered buffer
      iio: offload: add new PWM triggered DMA buffer driver
      iio: adc: ad7380: add SPI offload support

 .../adi,spi-offload-pwm-trigger-dma-buffer.yaml    |  59 +++++
 .../spi/adi,axi-spi-engine-peripheral-props.yaml   |  24 ++
 .../bindings/spi/adi,axi-spi-engine.yaml           |  49 +++-
 .../bindings/spi/spi-peripheral-props.yaml         |   1 +
 Documentation/driver-api/driver-model/devres.rst   |   2 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/adc/Kconfig                            |   1 +
 drivers/iio/adc/ad7380.c                           |  84 ++++++-
 drivers/iio/buffer/Kconfig                         |   7 +
 drivers/iio/buffer/Makefile                        |   1 +
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   5 +-
 .../iio/buffer/industrialio-hw-triggered-buffer.c  | 105 ++++++++
 drivers/iio/industrialio-buffer.c                  |  43 +++-
 drivers/iio/offload/Kconfig                        |  21 ++
 drivers/iio/offload/Makefile                       |   2 +
 drivers/iio/offload/iio-pwm-triggered-dma-buffer.c | 212 ++++++++++++++++
 drivers/spi/spi-axi-spi-engine.c                   | 270 +++++++++++++++++++++
 drivers/spi/spi.c                                  |  43 +++-
 include/linux/iio/buffer-dmaengine.h               |   2 +
 include/linux/iio/hw_triggered_buffer.h            |  14 ++
 include/linux/iio/hw_triggered_buffer_impl.h       |  16 ++
 include/linux/iio/iio.h                            |  16 +-
 include/linux/mod_devicetable.h                    |   2 +-
 include/linux/spi/spi.h                            | 123 ++++++++++
 scripts/dtc/checks.c                               |   4 +
 26 files changed, 1092 insertions(+), 16 deletions(-)
---
base-commit: 036589475658287626a9bb78bcb8538a33d3ed34
prerequisite-patch-id: a57defd70c3f6e806bdff12d940a1c1d3f1ec78f
change-id: 20231215-axi-spi-engine-series-3-1c6a584d408d


