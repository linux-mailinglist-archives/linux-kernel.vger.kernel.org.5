Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A726786230
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbjHWVRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237598AbjHWVRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:17:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7D110F4;
        Wed, 23 Aug 2023 14:16:50 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fea0640d7aso59745915e9.0;
        Wed, 23 Aug 2023 14:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692825409; x=1693430209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l4CWoGjnRBIe/Yd0zSFfsBQ3gwH+gJPLctSjYv0zNW0=;
        b=H1yJsTISw+7GhYGxH8RepIaGFDZ7KDvukxUxxmuDG1vaCntKRS0LJiD/mOoyYF/o24
         JlKdFLiNo5JyoxmSngRGnCjNt8YBueVnckOlZm/kdpM3ezrbldgQftu1qjPRHwLDflZq
         vftOXQNcW8VgYeJTk4PaJ6z9ykmkU639iiPL8x9RM/GS1/K3lj+cnP7IC9/WGZ0OTmde
         URrC09xAm9q4fhdQ6Oxb3oCXb6TTqUoKNiduPNS8zlpON8fcH11NJwOtaUmuov3yIutv
         s+1Roze9uaJABbnAHb44te54NxfjERoajevoGgyq5A8rbozb+1CA1VJK7kWcmBpNfngO
         PqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692825409; x=1693430209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4CWoGjnRBIe/Yd0zSFfsBQ3gwH+gJPLctSjYv0zNW0=;
        b=Px0TnRxN6OXy0nzfDTlVt7oq6/lFY/5ZaUTUFq+S3tRdkPGTopoBTzgTLFoAIaXxsK
         k7eSdUbHR5mpoSgtyLCIQrxntjH9KsxCqjBmK373Zr9bxca55IuPb+kJeWCXQK+ve1ol
         VIOov96D8+IzQgxa9E+g5sZZCf4RELdxfzgR0gB+O9q31pKxbl1zUGlGVOnFy1xkMW25
         xpr15Hv31AxIccTH6PYIUe6+fojVqIOszCAiiyfmpK0sSaL6PyXrd1wdb5yC1tAVyEL9
         P0R+f+r5uUgzqd2tyVFnfNaXGd20XelEts+FRSjWf8VhMJ8Ut2xP3bCbUN+YKvNAk3wa
         s1ZA==
X-Gm-Message-State: AOJu0Yz14wUOIYhL3CrnVbwmlAzbYXocZFWi29qKja95JHIOuCM7b6kQ
        xKl3xD869wKaLDG/JvxWWz8=
X-Google-Smtp-Source: AGHT+IHPo8LRPmT0pGeQNQRir5ZoVmsM+/YBoPk/zG1pgNxGhsWBb19K1mKMTSld7esrmFKHP3tNPg==
X-Received: by 2002:a7b:ce91:0:b0:400:6b36:ee2a with SMTP id q17-20020a7bce91000000b004006b36ee2amr1657009wmj.26.1692825409024;
        Wed, 23 Aug 2023 14:16:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:bb2:6df0:64ae:3840:3a64:b26a])
        by smtp.gmail.com with ESMTPSA id p11-20020adfe60b000000b003176c6e87b1sm20193399wrm.81.2023.08.23.14.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 14:16:47 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v8 0/7] iio: accel: Add support for Kionix/ROHM KX132-1211 accelerometer
Date:   Wed, 23 Aug 2023 23:16:34 +0200
Message-Id: <cover.1692824815.git.mehdi.djait.k@gmail.com>
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

Version 8 for adding support for the kx132-1211 accelerometer

KX132-1211 accelerometer is a sensor which:
	- supports G-ranges of (+/-) 2, 4, 8, and 16G
	- can be connected to I2C or SPI
	- has internal HW FIFO buffer
	- supports various ODRs (output data rates)

The KX132-1211 accelerometer is very similar to the KX022A. 
One key difference is number of bits to report the number of data bytes that 
have been stored in the buffer: 8 bits for KX022A vs 10 bits for
KX132-1211.

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
 drivers/iio/accel/Kconfig                     |   8 +-
 drivers/iio/accel/kionix-kx022a-i2c.c         |  25 +-
 drivers/iio/accel/kionix-kx022a-spi.c         |  15 +-
 drivers/iio/accel/kionix-kx022a.c             | 315 ++++++++++++++----
 drivers/iio/accel/kionix-kx022a.h             | 110 +++++-
 6 files changed, 410 insertions(+), 75 deletions(-)

-- 
2.30.2

