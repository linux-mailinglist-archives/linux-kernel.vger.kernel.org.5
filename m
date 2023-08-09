Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65675776AD3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjHIVOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjHITLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:11:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9362133;
        Wed,  9 Aug 2023 12:11:49 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-317c3ac7339so190113f8f.0;
        Wed, 09 Aug 2023 12:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691608307; x=1692213107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jPPGQ+wxlHFewcUApvejhQsm3EbyLhFjPmLUIYs1mIA=;
        b=djWxn2JjLwROEob8+9JyYpTjDkWtbmUQyNNl3HfTJ2i3fFrnnAFOZYPUgUSVFPbOAn
         ALOz4d3oHu4VkQRqYTllD1OuV7sfSeKB5Qtj3+2QIEsCOwndDe+sht+8xkwmAuifbA9I
         MB5cr7boOpT82wMZWor2Hi45Ex9nr8tv+t6giTu57G6QSU3J7XQDllvme8I6XA34qobO
         ALOLIwbLgeOe7bYRdXL5CA+kTk+XF1LbTTriTCIEuL8H0SEJqrK742X68Cor5WCoNxH5
         S81K4iwdmeZF3FEufiSmtga2EO6ekbcZi0DzZ7ma0EjVOlw3gBKmj0gkk82sxSEcSiZb
         rl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608307; x=1692213107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jPPGQ+wxlHFewcUApvejhQsm3EbyLhFjPmLUIYs1mIA=;
        b=e3t7p/2LwuDSv8jO1kno+a4CeVJy/yTQb4vK94wfr59noEam7TwCoDv/ItVPl4DZMY
         PsGJvsK+lzhppjW1tDejXemXvqY5CsSltcT9io7pWFHhcFdqk+ElQMTvofHqGwrtk7T8
         wq1xMeDCQ4w3hFb+CDt/elOm/4bp9M8h4YxYcxlYVNR01tyAC+ejTUZZjgk0AQSQwchn
         wf9g/Fpryeui1do189UQgIDKBxkpzoBGXD+9ldmmghvhQeL4TpOObFmW4E8HaE3EHhu7
         sCirHYVgHG40GTSs8AkvopYGK1F3f0ovooMJNTvcnph3fpa7OrQGp2KZj26nmK0RUyK9
         50RA==
X-Gm-Message-State: AOJu0Yx21U/3QSNKfHkq8XLSGQYptxPCYfbNeiW5+EaEFZdYHpbMgu+F
        06PvM4t1FLUQZwa2nBPckcA=
X-Google-Smtp-Source: AGHT+IHkjpXkhylg3BaqrFnmYqDxUaYLxq1NqvN7XsX+7ewJZzzW2BxkLeQFGluMKnhFlV2OpxGTzQ==
X-Received: by 2002:adf:e8d0:0:b0:314:2e95:1ec9 with SMTP id k16-20020adfe8d0000000b003142e951ec9mr294333wrn.10.1691608307346;
        Wed, 09 Aug 2023 12:11:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:bb2:6df0:64ae:3840:3a64:b26a])
        by smtp.gmail.com with ESMTPSA id f6-20020adfdb46000000b003177074f830sm17582681wrj.59.2023.08.09.12.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:11:46 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v7 0/7] iio: accel: Add support for Kionix/ROHM KX132-1211 accelerometer
Date:   Wed,  9 Aug 2023 21:11:31 +0200
Message-Id: <cover.1691607526.git.mehdi.djait.k@gmail.com>
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

Version 7 for adding support for the kx132-1211 accelerometer

KX132-1211 accelerometer is a sensor which:
	- supports G-ranges of (+/-) 2, 4, 8, and 16G
	- can be connected to I2C or SPI
	- has internal HW FIFO buffer
	- supports various ODRs (output data rates)

The KX132-1211 accelerometer is very similar to the KX022A. 
One key difference is number of bits to report the number of data bytes that 
have been stored in the buffer: 8 bits for KX022A vs 10 bits for
KX132-1211.

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
 drivers/iio/accel/Kconfig                     |   8 +-
 drivers/iio/accel/kionix-kx022a-i2c.c         |  24 +-
 drivers/iio/accel/kionix-kx022a-spi.c         |  15 +-
 drivers/iio/accel/kionix-kx022a.c             | 314 ++++++++++++++----
 drivers/iio/accel/kionix-kx022a.h             | 110 +++++-
 6 files changed, 408 insertions(+), 75 deletions(-)

-- 
2.30.2

