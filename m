Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F04F7BCF2B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 17:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344911AbjJHPt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 11:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344819AbjJHPtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 11:49:25 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A96DA6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 08:49:24 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690fa0eea3cso3400830b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 08:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1696780163; x=1697384963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iYS7MoI1k63KbmrP+8M3lV9Unyrhs9AyXw7eoZbGO5A=;
        b=MFitPYvXOmhvTtE5enDfG8jlOf1Pm9p+Qi5A6TE44ZgwRRdRWqCKhFFqZzftyFT5QF
         ZuYQy2Av7xbZD62XOQw3XCzWg4ZH05MSQPAPezBwex+t3QZgwe/oXNAdZUcBMPRF8a+t
         Rte5ZjKjEbgCdWW5DG49Y1E9KtyOlL0q/3SckkGqgFcFe6sNhGjGYxFLrNF5t3szERc3
         zTXmmSEuLVlsc+lKb3tKqsHhyBp4X7GcPZtdrSwLhDC4EefcoOHJ2PknUL1TLDVKcHvC
         sCg+b8pWA1ga3fjA1xIJdpHMQeQTl8B2aOytxIK/AhRPWw2DMv+1/BsZVS8i5KsUnXV6
         Jhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696780164; x=1697384964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYS7MoI1k63KbmrP+8M3lV9Unyrhs9AyXw7eoZbGO5A=;
        b=suW8wH9okAWDWZuOKEiJUbf3XMJ99atnj/3uXxufKAROxYR9Sg6gmQ2/+QolQ+8hxd
         WDPT7oDAKmJNtcFUzm6L5mv7jFvcPqCtaXc7eMo0mKvGwxucfOxSw1vc8R4TPihEa7eY
         oHZxE8xZF+QpZ4eCr5l6NNplA3NgGHZLe7gCYsneXREuM553EdeKKkBeEmq0tSGxg8Nn
         eLkvtLZJwTYvQIMMxEq6SXqaOuEjQ1dKTt7OFse8kP8zzvTFz7ae+nS/C1bi98CSwjkG
         /3kkzzYRke7icANEwfZ6vozRVSn0pNWNuC9JdlgCDRC5J+THQkqL10dsrCMF1blu3uog
         hKIg==
X-Gm-Message-State: AOJu0Yzsm1sKl4Bkv/zanR5vdlYMyIP8qR2buGgz9PyRtiW+2Md3pMbU
        yeWQDQtmDvTQHwtT0FtnXUTzcA==
X-Google-Smtp-Source: AGHT+IHBv1uJ2T2O11O5qVuv7fnj23BaWdObu5H/htxUpBcnMUZF1bgx2GW4f4nfVClcU6si0B1x7Q==
X-Received: by 2002:a05:6a00:14c8:b0:68f:dcc1:4bef with SMTP id w8-20020a056a0014c800b0068fdcc14befmr18442498pfu.7.1696780163627;
        Sun, 08 Oct 2023 08:49:23 -0700 (PDT)
Received: from localhost.localdomain (2403-580d-82f4-0-65d1-409f-dd8-4287.ip6.aussiebb.net. [2403:580d:82f4:0:65d1:409f:dd8:4287])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7905a000000b0068fc48fcaa8sm4723374pfo.155.2023.10.08.08.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 08:49:23 -0700 (PDT)
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Subject: [PATCH 0/2] Support for Avago APDS9306 Ambient Light Sensor
Date:   Mon,  9 Oct 2023 02:18:55 +1030
Message-Id: <20231008154857.24162-1-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Avago (Broadcom) APDS9306 Ambient Light
Sensor.

Datasheet: https://docs.broadcom.com/doc/AV02-4755EN

Following features are supported:
- I2C interface
- 2 channels - als and clear
- Raw data for als and clear channels
- Pocessed data (Lux) values for als channel
- Up to 20 bit resolution
- 20 bit data register for each channel
- Common Configurable items for both channels
    - Integration Time
    - Measurement Frequency
    - Scale
- High and Low threshold interrupts for each channel

- Selection of interrupt channels - als or clear
- Selection of interrupt mode - threshold or adaptive
- Level selection for adaptive threshold interrupts
- Persistence (Period) level selection for interrupts

Link: https://lore.kernel.org/all/20230411011203.5013-1-subhajit.ghosh@tweaklogic.com/
Link: https://patchwork.kernel.org/project/linux-iio/cover/20230411011203.5013-1-subhajit.ghosh@tweaklogic.com/

Sysfs structure:
root@stm32mp1:~# tree -I 'dev|name|of_node|power|subsystem|uevent' \
> /sys/bus/iio/devices/iio:device0/
/sys/bus/iio/devices/iio:device0/
|-- events
|   |-- in_illuminance_thresh_either_en
|   |-- in_intensity_clear_thresh_either_en
|   |-- thresh_adaptive_either_en
|   |-- thresh_adaptive_either_value
|   |-- thresh_adaptive_either_values_available
|   |-- thresh_either_period
|   |-- thresh_either_period_available
|   |-- thresh_falling_value
|   `-- thresh_rising_value
|-- in_illuminance_input
|-- in_illuminance_raw
|-- in_intensity_clear_raw
|-- integration_time
|-- integration_time_available
|-- sampling_frequency
|-- sampling_frequency_available
|-- scale
|-- scale_available
`-- waiting_for_supplier

RFC -> v0
 - DT binding review by Rob and Krzysztof:
  - Verified with dt_binding_check
  - Removed the last/redundant "bindings" word

 - Review by Andy:
  - Dropped blank line and reordered initial comments
  - Sorted header files
  - Added kernel-doc for the private structure
  - Removed regmap internal lock
  - Used regmap_read_poll_timeout() function instead of while loop
    in apds9306_read_data()
  - Applied fixes as per review

 - Review by Jonathan:
  - Updated apds9306_read_data() and apds9306_irq_handler() as per
    review. If interrupts are enabled together with userspace read
    of raw and processed adc values, then events can be pushed both
    by the interrupt handler and apds9306_read_data(). If the
    interrupt handler gets a data ready for read flag then it sets
    a flag in the private data structure which is used by 
    apds9306_read_data().
  - ABI update - In events, per cnannel enable for both
    channels, removing custom sysfs attributes for channel selection.
  - Added lux calculation. Page 4 of the datasheet has test results
    for only the default integration time at the default hardware gain.
    Normalized the values for all hardware gains and all supported
    integration times as per the part ID. I got consistent results
    when compared with a lux meter in the default range.
  - Other fixes as commented
  - Implemented IIO_GTS_HELPER
  - Shuffled functions for logical split and readability

Apologies for this huge delay in submitting this patch from RFC to v0.
I had a change of job and subsequent relocation.
Future revisions will not be delayed.

Subhajit Ghosh (2):
  dt-bindings: iio: light: Avago APDS9306
  iio: light: Add support for APDS9306 Light Sensor

 .../bindings/iio/light/avago,apds9306.yaml    |   49 +
 drivers/iio/light/Kconfig                     |   12 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/apds9306.c                  | 1381 +++++++++++++++++
 4 files changed, 1443 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml
 create mode 100644 drivers/iio/light/apds9306.c


base-commit: b9ddbb0cde2adcedda26045cc58f31316a492215
-- 
2.34.1

