Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B887A3034
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 14:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239159AbjIPMjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 08:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239076AbjIPMjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 08:39:07 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AC1CEF;
        Sat, 16 Sep 2023 05:39:01 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-502984f5018so4972452e87.3;
        Sat, 16 Sep 2023 05:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694867940; x=1695472740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=deTi1Guggd/Xlo7tslrIxsKkXafXPX/y4YTeng0/oLo=;
        b=Gumd6iygLLsDtSalHMAVsOEtC/anQ2sBz4NSeaSGBp9iHbgU7AfSBgvJul0xYchOD5
         Rb0f7Ihe+Evim0kFkbhP1bNvbhVJjDUykZfAZamhilYKZzfTDODw63gucF/IKUeygsKR
         RIj0y9uDd6bmqotR24Un7bbcQMfxoZ78rAEQin0LVLGRocdljvKSmZq8rB6WmAVPcQYD
         P9akuT9Mv81EqJE0aBo0egwkJWWeGjMzWXcGKTBM7mKecpNFAXivdHZKeLagCugoxJWd
         1RBz28V9cpZh+D54QbIs4ov5vpDoe/eBKJAV+ont0fmbh7+stM7f0My3VJWncYyY5WR6
         Rsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694867940; x=1695472740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=deTi1Guggd/Xlo7tslrIxsKkXafXPX/y4YTeng0/oLo=;
        b=OQiLKF+S9MLgUgxp4d4ivuwxJS2fu7SztmhG8FXLrcfymZ8GUVnEpKZM87dQH+PB9O
         aKDX9uZB0ssty7rXOulMy+QlQFkN6LNYAzz0Qt8wWSySxTM5H5av/6axIcFlzo8skj3C
         Qr/7xWkPoIyW7/e29XkLjPoUa6uKIBaaho/2lkmPl/e2gDTpEq57nIsnt9OZfQqQQp5r
         XiUIB45eVZFBdro4B1FTtQRwNp2nTJ9vAGgdo/jI7E47QXZtv20QmLwHTBXr+hc9c9qH
         n++5fcGcAYlpL5WHJZ9Y+B+IU1Z6StiV6YCImfF9vEIQ9GpNnxNI8skUHkHYUT3SMgUt
         7l5w==
X-Gm-Message-State: AOJu0YyB1e7nhC8c1FmmhGanB6yl9hF6FnXtxmbr/BZeO5shnybu2Squ
        /0tp9F3+5tx6bs8FCUxnL88=
X-Google-Smtp-Source: AGHT+IH6bkTERuW1huhfAqQ5KLQ5M8x89qgmlo3RJKhHK2TjK3O01jblUwAp2m16jRYxx30F9nyNGw==
X-Received: by 2002:a19:6750:0:b0:4fe:82a7:814f with SMTP id e16-20020a196750000000b004fe82a7814fmr3117739lfj.37.1694867939654;
        Sat, 16 Sep 2023 05:38:59 -0700 (PDT)
Received: from localhost.localdomain ([77.134.181.150])
        by smtp.gmail.com with ESMTPSA id bo6-20020a0564020b2600b0052284228e3bsm3474064edb.8.2023.09.16.05.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 05:38:59 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v9 0/7] iio: accel: Add support for Kionix/ROHM KX132-1211 accelerometer
Date:   Sat, 16 Sep 2023 14:38:46 +0200
Message-Id: <cover.1694867379.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Version 9 for adding support for the kx132-1211 accelerometer

KX132-1211 accelerometer is a sensor which:
	- supports G-ranges of (+/-) 2, 4, 8, and 16G
	- can be connected to I2C or SPI
	- has internal HW FIFO buffer
	- supports various ODRs (output data rates)

The KX132-1211 accelerometer is very similar to the KX022A. 
One key difference is number of bits to report the number of data bytes that 
have been stored in the buffer: 8 bits for KX022A vs 10 bits for
KX132-1211.

Changes in v9:
- used i2c_get_match_data
- changed the name and description of the function to get available data
  in HW fifo buffer
- changed the description in the Kconfig file

Changes in v8:
- replaced min_t by min and kmalloc by kmalloc_array as suggested by Andy

Changes in v7:
- added a min_t in kx132_get_fifo_bytes to ensure that we don't that the
  fifo_bytes is never bigger than the 
  fifo_length * KX022A_FIFO_SAMPLES_SIZE_BYTES - no matter what we read from I2C
  as suggested by Matti

Changes in v6:
- check for availability of chip_info for the SPI case
- changed the order of elements in the kx022a_data struct to save memory

Changes in v5:
- moved the "kfree" call to match the reverse of what happens in 
  kx022a_fifo_enable() as suggested by Matti and Jonathan
- used min_t, checked for availability of chip_info and moved the
  position of u16 buf_smp_lvl_mask as suggested by Andy
- introduced buf_smp_lvl_mask in Patch 7 as suggested by Jonathan

Changes in v4:
- moved the allocation of the fifo_buffer to kx022a_fifo_enable and
  kx022a_fifo_disable
- some fixes to the regmap ranges of kx132-1211 

Changes in v3:
- added two new patches by separating the addition of the 
  i2c_device_id table and the removal of blank lines from other
  unrelated changes
- fixes a warning detected by the kernel test robot
- made all the changes related the chip_info in one patch

Changes in v2:
- added a new patch for warning when the device_id match fails in the
  probe function
- added a new patch for the function that retrieves the number of bytes
  in the buffer
- added a change to the Kconfig file in the patch adding the support
  for the kx132-1211
- various fixes and modifications listed under each patch

Mehdi Djait (7):
  dt-bindings: iio: Add KX132-1211 accelerometer
  iio: accel: kionix-kx022a: Remove blank lines
  iio: accel: kionix-kx022a: Warn on failed matches and assume
    compatibility
  iio: accel: kionix-kx022a: Add an i2c_device_id table
  iio: accel: kionix-kx022a: Refactor driver and add chip_info structure
  iio: accel: kionix-kx022a: Add a function to retrieve number of bytes
    in buffer
  iio: accel: Add support for Kionix/ROHM KX132-1211 accelerometer

 .../bindings/iio/accel/kionix,kx022a.yaml     |  12 +-
 drivers/iio/accel/Kconfig                     |  10 +-
 drivers/iio/accel/kionix-kx022a-i2c.c         |  20 +-
 drivers/iio/accel/kionix-kx022a-spi.c         |  15 +-
 drivers/iio/accel/kionix-kx022a.c             | 315 ++++++++++++++----
 drivers/iio/accel/kionix-kx022a.h             | 112 ++++++-
 6 files changed, 409 insertions(+), 75 deletions(-)

-- 
2.30.2

