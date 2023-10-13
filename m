Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2607C7C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 05:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjJMDsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 23:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjJMDsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 23:48:15 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081FBC9;
        Thu, 12 Oct 2023 20:48:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c8a1541232so14877275ad.0;
        Thu, 12 Oct 2023 20:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697168893; x=1697773693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kr4Un2J3jt7fvFMVUktnjSzI1aZyjE49Ly+HVVoep3w=;
        b=QpoPuAuq3qCr5GDyQgYt4BgHhv4fCoS81f+FMt4gOjv5bzvib+UN7qq82x24e1WJMr
         0TFn4buPghbY0UgIIdOnQWrGT0/9XffXolSfpunrEha1aoLec6Kh8lmBTHHng6o9ffTj
         90JTlhpfEyATBpTJ0Q4MTHJLg8i2YOwMbpZrDjTWKhDLP/3D/MOAuC5R7cbKaPbQKWnd
         KtgychM+aOdmrQ9fL+/AvKwYqKhjdFZNkY7jyMtecwx+gFaxqNGIOImppsXpMan1bLll
         ysVzgUcwD+yhQjJQWStoCbpH0O/BLahno/e5V7u5mtReotIiZ6qgkomb9UKx5Kf9eXam
         Gpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697168893; x=1697773693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kr4Un2J3jt7fvFMVUktnjSzI1aZyjE49Ly+HVVoep3w=;
        b=Z8dlXvGyxXDN00u111AJNygtxTURJqcKjzmVaCKy/uECRZJMpYdeRn3l3u+QPqL0rk
         6pwFLK5htUF4jfoeBtd3k2gCsYcmGHozdbE4W+pGweFCTJDQlGrApbcO5O+IWRk/+5Hs
         MgXiq1IKQ4/pTIFGdSsns/GMfXCA6YURiI65VOw/lSbOtkaR1b0+GhVn5RJegdMNcaPI
         h2L4GG3J/y5jh11HSDTH8p5ElOMOMu69L70dQgQzspwBit5aHRKF1CiYzMUyU9a80+xM
         GJzFznXK4CJkBXsy+ytnYhSMuJj+5MeF1/S0JJrg+ISrcUT5ADJU+ONhs1pzdkFNcGPn
         9b1g==
X-Gm-Message-State: AOJu0YzqSksjXedWsGMjStR7mfI87Ac3KcfEFs9srgYIZjKnrXODDSfR
        ve0wD8idSz9Ot3qXMWHbSeE=
X-Google-Smtp-Source: AGHT+IFidRYlkEHqj1tWWtltBc02aHhD35+f5eTk/EM2t1ORycK4mmjOVTYMIFt5q6f+1oRjq4cIYw==
X-Received: by 2002:a17:902:d509:b0:1bd:d911:2a85 with SMTP id b9-20020a170902d50900b001bdd9112a85mr32617053plg.12.1697168893398;
        Thu, 12 Oct 2023 20:48:13 -0700 (PDT)
Received: from localhost.localdomain ([115.99.190.148])
        by smtp.gmail.com with ESMTPSA id h21-20020a170902f7d500b001b53c8659fesm2777023plw.30.2023.10.12.20.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 20:48:13 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: imu: Add driver and dt-bindings for BMI323
Date:   Fri, 13 Oct 2023 09:18:06 +0530
Message-Id: <20231013034808.8948-1-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings and IIO driver for Bosch BMI323 a 6 axis IMU.

Complete list of device sysfs files
.
├── buffer
│   ├── data_available
│   ├── direction
│   ├── enable
│   ├── hwfifo_enabled
│   ├── hwfifo_watermark
│   ├── length
│   └── watermark
├── buffer0
│   ├── data_available
│   ├── direction
│   ├── enable
│   ├── hwfifo_enabled
│   ├── hwfifo_watermark
│   ├── in_accel_x_en
│   ├── in_accel_x_index
│   ├── in_accel_x_type
│   ├── in_accel_y_en
│   ├── in_accel_y_index
│   ├── in_accel_y_type
│   ├── in_accel_z_en
│   ├── in_accel_z_index
│   ├── in_accel_z_type
│   ├── in_anglvel_x_en
│   ├── in_anglvel_x_index
│   ├── in_anglvel_x_type
│   ├── in_anglvel_y_en
│   ├── in_anglvel_y_index
│   ├── in_anglvel_y_type
│   ├── in_anglvel_z_en
│   ├── in_anglvel_z_index
│   ├── in_anglvel_z_type
│   ├── in_timestamp_en
│   ├── in_timestamp_index
│   ├── in_timestamp_type
│   ├── length
│   └── watermark
├── current_timestamp_clock
├── dev
├── events
│   ├── in_accel_gesture_doubletap_en
│   ├── in_accel_gesture_doubletap_reset_timeout
│   ├── in_accel_gesture_doubletap_tap2_min_delay
│   ├── in_accel_gesture_doubletap_tap2_min_delay_available
│   ├── in_accel_gesture_doubletap_value
│   ├── in_accel_gesture_singletap_en
│   ├── in_accel_gesture_singletap_reset_timeout
│   ├── in_accel_gesture_singletap_value
│   ├── in_accel_gesture_tap_reset_timeout_available
│   ├── in_accel_gesture_tap_value_available
│   ├── in_accel_gesture_tap_wait_dur
│   ├── in_accel_gesture_tap_wait_dur_available
│   ├── in_accel_gesture_tap_wait_timeout
│   ├── in_accel_mag_falling_en
│   ├── in_accel_mag_falling_hysteresis
│   ├── in_accel_mag_falling_period
│   ├── in_accel_mag_falling_value
│   ├── in_accel_mag_hysteresis_available
│   ├── in_accel_mag_period_available
│   ├── in_accel_mag_rising_en
│   ├── in_accel_mag_rising_hysteresis
│   ├── in_accel_mag_rising_period
│   ├── in_accel_mag_rising_value
│   ├── in_accel_mag_value_available
│   ├── in_steps_change_en
│   └── in_steps_change_value
├── in_accel_mount_matrix
├── in_accel_oversampling_ratio
├── in_accel_oversampling_ratio_available
├── in_accel_sampling_frequency
├── in_accel_sampling_frequency_available
├── in_accel_scale
├── in_accel_scale_available
├── in_accel_x_raw
├── in_accel_y_raw
├── in_accel_z_raw
├── in_anglvel_mount_matrix
├── in_anglvel_oversampling_ratio
├── in_anglvel_oversampling_ratio_available
├── in_anglvel_sampling_frequency
├── in_anglvel_sampling_frequency_available
├── in_anglvel_scale
├── in_anglvel_scale_available
├── in_anglvel_x_raw
├── in_anglvel_y_raw
├── in_anglvel_z_raw
├── in_steps_en
├── in_steps_input
├── in_temp_offset
├── in_temp_raw
├── in_temp_scale
├── name
├── of_node -> ../../../../../../../firmware/devicetree/base/soc/i2c@7e804000/i2c_bmi323@68
├── power
│   ├── autosuspend_delay_ms
│   ├── control
│   ├── runtime_active_time
│   ├── runtime_status
│   └── runtime_suspended_time
├── scan_elements
│   ├── in_accel_x_en
│   ├── in_accel_x_index
│   ├── in_accel_x_type
│   ├── in_accel_y_en
│   ├── in_accel_y_index
│   ├── in_accel_y_type
│   ├── in_accel_z_en
│   ├── in_accel_z_index
│   ├── in_accel_z_type
│   ├── in_anglvel_x_en
│   ├── in_anglvel_x_index
│   ├── in_anglvel_x_type
│   ├── in_anglvel_y_en
│   ├── in_anglvel_y_index
│   ├── in_anglvel_y_type
│   ├── in_anglvel_z_en
│   ├── in_anglvel_z_index
│   ├── in_anglvel_z_type
│   ├── in_timestamp_en
│   ├── in_timestamp_index
│   └── in_timestamp_type
├── subsystem -> ../../../../../../../bus/iio
├── trigger
│   └── current_trigger
├── uevent
└── waiting_for_supplier

Changes from RFC to v2

Review by Andy:
- Sorted header files and added unit.h
- Splitting macro
- Defined new macros and enums to use in place of magic numbers.
- Used KILO instead of large number
- Used guard and scoped_guard from cleanup.h
- Used ARRAY_SIZE() instead of value
- Replaced kstrtoint with kstrtobool
- Used min() and in_range() from minmax.h
- Used GENMASK instead of magic number
- Remove error print from interrupt handler
- Removed casting and le16_to_cpup, used sign_extend32 for getting final value
- Used while loop instead of for
- Remove the check for the return value of 0 from fwnode_irq_get_byname()
- Used dev_err_probe() in all probe paths
- Removed 0 from i2c_ids[]
- Used read_flag_mask for spi regmap configuration
- Dropped blank line
- Used regmap_read_poll_timeout() function instead of while loop
- Applied fixes as per review

Review by Jonathan
- Used oversampling instead of averaging
- Reverse the order of avail_scan_masks
- Use FIELD_PREP() directly in place of set_mask_bits
- Remove irq_type from devm_request_threaded_irq
- Use FIELD_GET() with mask
- Added comment for delay used for feature engine enable
- Use dev_err_probe in all probe paths
- For I2C regmap, allocated memory in device private data
- Use pad_bits=16 for spi regmap_configuration
- Added both interrupts in the dt-bindings

Review by Krzysztof Kozlowski
- Removed duplicated words from subject
- Removed '|'
- Added supplies
- Used generic node name "imu"
- Removed spi example node

Review by Uwe Kleine-König
- Use probe instead of probe_new
- Placed datasheet in driver

Jagath Jog J (2):
  dt-bindings: iio: imu: Add Bosch BMI323
  iio: imu: Add driver for BMI323 IMU

 Documentation/ABI/testing/sysfs-bus-iio       |   18 +
 .../bindings/iio/imu/bosch,bmi323.yaml        |   77 +
 MAINTAINERS                                   |    7 +
 drivers/iio/imu/Kconfig                       |    1 +
 drivers/iio/imu/Makefile                      |    1 +
 drivers/iio/imu/bmi323/Kconfig                |   33 +
 drivers/iio/imu/bmi323/Makefile               |    7 +
 drivers/iio/imu/bmi323/bmi323.h               |  209 ++
 drivers/iio/imu/bmi323/bmi323_core.c          | 2139 +++++++++++++++++
 drivers/iio/imu/bmi323/bmi323_i2c.c           |  121 +
 drivers/iio/imu/bmi323/bmi323_spi.c           |   92 +
 11 files changed, 2705 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
 create mode 100644 drivers/iio/imu/bmi323/Kconfig
 create mode 100644 drivers/iio/imu/bmi323/Makefile
 create mode 100644 drivers/iio/imu/bmi323/bmi323.h
 create mode 100644 drivers/iio/imu/bmi323/bmi323_core.c
 create mode 100644 drivers/iio/imu/bmi323/bmi323_i2c.c
 create mode 100644 drivers/iio/imu/bmi323/bmi323_spi.c

-- 
2.20.1

