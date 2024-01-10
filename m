Return-Path: <linux-kernel+bounces-22728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9102E82A23C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3CD1F2300E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F90B4E1DC;
	Wed, 10 Jan 2024 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mWK7Xu/u"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004324D13B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6de95fd8767so221132a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704918559; x=1705523359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wmasepeUIVGINgX80ch0uKoodtVGM10JCn3vTAsD2eM=;
        b=mWK7Xu/u+9eZX6Bv8uibnLueQmN722J2CdfNJ+T5STt8tPpAWvyYOufCMrg/RwjKI7
         NcTUEFnUiuiADIJZegkw0v6YXdr/FqgTXEC8aofoX98PZ9nqpoxQp7vBJ8ZcteINszW/
         DliVGCUwmpimd5VnRUukN/uYHYZqNuot3ZC/WYCywus7oAri/PvsH5jq53Gw+oT8cH8i
         zEwaV49kF3hITFFjFvnMm2dXjh4yhcd76Milj9XdIcU762n+Nu1OT0lkDQF/mq8OfzKG
         DFlxkBeIF6YkVGiQCc7Xm6QMCjF3rkOpi1QPgilwrsAhk+6MLeGwTjNlF8e2R6dDIkFj
         bNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704918559; x=1705523359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmasepeUIVGINgX80ch0uKoodtVGM10JCn3vTAsD2eM=;
        b=CF53lNeCp4S0HXpSe36gdKccnNOLkmCEF99EGgsvsTjdFDcj7ZzAin8J4IOGwZx503
         CkWEljCxTo0BS85Xupq7ZLXxT1dVOJaEBfLrJefOeQ53vj3PNl7Vw+7h6qqbj435e59Y
         ms34XdRF7Q/a38dz5ihZ97djbY30g9opzaYY0w3JbFM0WHn9JZtSs356bYyWTOiJd9/5
         inIppCWDEj9SRISt4xa2PvzrmphAJLDAO1HB4lIka5Qe8PVx0cF/vzVIAL0M7H+UqR+C
         MlqdkgT+lJiA0caIxP7VZ/I6I97r31AsZ5xfrPgu9dpNuVCD5O3gWOJrWhXguhS3m4vk
         fCyA==
X-Gm-Message-State: AOJu0YyZAlacEvxkBWb5eBOJVNhXY9lmgGAkXpJraf7bivZdT0zya+q+
	XI3unkPavgp2gwxONML7bHvJ9cw+0T/h6Q==
X-Google-Smtp-Source: AGHT+IGO773mFT1Oa8UU9rpBHeEIs6wZ8dYmCjs922fKrI+TvTVbihyouZhCpVw2cYJW8SQ8aefV+w==
X-Received: by 2002:a9d:4e8c:0:b0:6dc:1cf0:529a with SMTP id v12-20020a9d4e8c000000b006dc1cf0529amr213889otk.8.1704918559022;
        Wed, 10 Jan 2024 12:29:19 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id l33-20020a0568302b2100b006dbf5ca14b9sm852502otv.47.2024.01.10.12.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 12:29:18 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-iio@vger.kernel.org,
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
	Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH v4 0/2] iio: adc: add new ad7380 driver
Date: Wed, 10 Jan 2024 14:28:39 -0600
Message-ID: <20240110-ad7380-mainline-v4-0-93a1d96b50fa@baylibre.com>
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
David Lechner (2):
      dt-bindings: iio: adc: Add binding for AD7380 ADCs
      iio: adc: ad7380: new driver for AD7380 ADCs

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |  86 ++++
 MAINTAINERS                                        |  10 +
 drivers/iio/adc/Kconfig                            |  16 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad7380.c                           | 462 +++++++++++++++++++++
 5 files changed, 575 insertions(+)
---
base-commit: 18f78b5e609b19b56237f0dae47068d44b8b0ecd
change-id: 20231208-ad7380-mainline-e6c4fa7dbedd

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


