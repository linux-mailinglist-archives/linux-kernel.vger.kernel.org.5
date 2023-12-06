Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D050180711C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378539AbjLFNrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378494AbjLFNrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:47:03 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B902EC7;
        Wed,  6 Dec 2023 05:47:09 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-6ce26a03d9eso2945573b3a.0;
        Wed, 06 Dec 2023 05:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701870429; x=1702475229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=indVg3iJe1bUmDftGyXLEFS478Gs8luViEtcG78izGA=;
        b=Rqij4ofu6i9zykU6O7BNl06GG1qNAZD4LERI9AgfSiRY2vijCrtjYMSwZC+xJ0/XZN
         eBCUNl2FfvTD5Uq+8Oh1cRvRIHVp+1TcpzyThQjdqqV93HjyIls1WPY+7xS1EW0gbfmn
         apCzmIiegP9x7aAOi0zfy5HfZ6BtO86CEhWgA6B4BMoZebWTAGHd1YK44JSuZcikJHRu
         BWzvom9thHTaaP1REsWko1WXZ5S7TaDvWICT+9gDDS+JdgenNUQ4I1xJQJgFKPAm/Th7
         z41lWfQ23hkwVPwbu+zYLYVjzO8CYjBOqUHiIRoPROPtLMKTY0Ucvsmsv8HDSCxx8ddV
         LZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701870429; x=1702475229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=indVg3iJe1bUmDftGyXLEFS478Gs8luViEtcG78izGA=;
        b=FVLoJ3obHcQz134I2nKxOMTIUTl3Mt6Kuwue5xuWYbiLJxQTXDFSFVD/bcgv8T1Bh6
         DhtE2Bw49FA3iXP8G5dvrbQknpAp1tc8K6oj9zqsOLoi3Z7nOM4vRGC0T5vK+i/nzBYt
         UERfU8yxMxZTsNLQKwQh4qCFyD6xgQI4nC14wqxKO4Z154E5sMy4oirW7yOjcFAUBO9L
         mLQd+/WJ4prE0GPnXWYzucNiTiCvF8pgsMsiXU41MbBoYdZ4VbRO+nsLsJnwuByGLR9c
         HQdW/MsHypDSrrme20w6m3cjporgZpifIsv1iOmxCs6bo8pnE9e7N/z5BfAdQ6ZTsnOI
         PhaQ==
X-Gm-Message-State: AOJu0YyEMTjCTVfjIbC5WAhI1Bx7TiqP3U9gioFl3GNcYBNqGZ2/xb6Y
        A+sIVW9TiBjCnRyKdmCcAd0=
X-Google-Smtp-Source: AGHT+IE7Id75EsCrlMdTpxA69hAH3GctF3TfPfA9wGdP5BlXGfsKjpbKppHc7MbvOzUGiatKJFAK5A==
X-Received: by 2002:a05:6a00:6ca8:b0:6ce:4c5b:4c97 with SMTP id jc40-20020a056a006ca800b006ce4c5b4c97mr567521pfb.56.1701870428881;
        Wed, 06 Dec 2023 05:47:08 -0800 (PST)
Received: from dawn-virtual-machine.localdomain ([183.198.59.249])
        by smtp.gmail.com with ESMTPSA id f7-20020a056a0022c700b006cb574445efsm7287038pfj.88.2023.12.06.05.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:47:08 -0800 (PST)
From:   Li peiyu <579lpy@gmail.com>
To:     jic23@kernel.org
Cc:     javier.carrasco.cruz@gmail.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li peiyu <579lpy@gmail.com>
Subject: [PATCH v4 0/4] iio: humidity: Add driver for ti HDC302x humidity sensors
Date:   Wed,  6 Dec 2023 21:46:55 +0800
Message-Id: <20231206134655.559474-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for HDC302x integrated capacitive based relative
humidity (RH) and temperature sensor.
This driver supports reading values, reading the maximum and
minimum of values and controlling the integrated heater of
the sensor.

Signed-off-by: Li peiyu <579lpy@gmail.com>
---
changes in v4:
	iio core:
	  - Add an IIO_CHAN_INFO_TROUGH modifier for minimum values.
	iio ABI:
	  - Document the new _TROUGH modifier.
	sensor driver:
	  - Add MAINTAINERS.
	  - Use new IIO_CHAN_INFO_TROUGH modifier.
	  - Support the complete heater range.
	  - Remove measurement values from the data structure.
	  - Use guard(mutex)(...), make the code simpler
	  - Removed buffer mode and direct mode conversion code
	  - Minor coding-style fixes.
	dt-bindings:
	  - removed unnecessary example
	  - add vdd-supply to the example
changes in v3:
	sensor driver:
	  - Removed the custom ABI
	  - Give up calculating values in the driver
	  - Use read_avail callback to get available parameters
	  - Changed the scope of the lock to make the code more concise
	  - Fixed the code format issue
	dt-bindings:
	  - Use a fallback compatible
changes in v2:
	sensor driver:
	  - Added static modification to global variables
	  - change the methord to read peak value
	dt-bindings:
	  - change the maintainers to me.
	  - hdc3020,hdc3021,hdc3022 are compatible,I've changed the dirver.
	  - change the node name to humidity-sensor.

---
Javier Carrasco (2):
      iio: core: introduce trough modifier for minimum values
      iio: ABI: document temperature and humidity peak/trough raw attributes

Li peiyu (2):
      dt-bindings: iio: humidity: Add TI HDC302x support
      iio: humidity: Add driver for TI HDC302x humidity sensors

 Documentation/ABI/testing/sysfs-bus-iio            |  13 +-
 .../bindings/iio/humidity/ti,hdc3020.yaml          |  55 +++
 MAINTAINERS                                        |   8 +
 drivers/iio/humidity/Kconfig                       |  12 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/hdc3020.c                     | 468 +++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |   1 +
 include/linux/iio/types.h                          |   1 +
 8 files changed, 558 insertions(+), 1 deletion(-)
 ---
base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a

Best regards,
