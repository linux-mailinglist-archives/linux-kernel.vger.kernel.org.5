Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D5C7A43DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbjIRIEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240785AbjIRIDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:03:48 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF88010E;
        Mon, 18 Sep 2023 01:03:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf1935f6c2so29574505ad.1;
        Mon, 18 Sep 2023 01:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695024200; x=1695629000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1h0mfMJN8y2Fpx6TXWBnY89WoQ3bNceAgBMQh6Df+ag=;
        b=BKGppC06v2V4qMLCVRSGzSDW5CFPqHW6OOBawFOzMQZo4JRb5yfSUUZm9uHDK3xZHb
         cdM7+6p+h4CG9ODZlU/1ucBsy9VMQeVRYNcXEsmqW1SkHsUnGBHaa3r1ON68U2elT3gd
         /GD9wHYjHnrYiPOJ3Teh+eOATEM/AJD/RbPSNGUi33jRJkBLOA4iXxtulrL1UtZXjGOv
         uJ9wfwpDT/TWh3Q/x49ZuxFBmk5BRKyPJ11na1jCNx5LSkh6RhPS+BbldGw8JmT88POe
         +Sh6nBITR7yvo9WUlR0+meFaYa/2WJjk6yN47iVUg7f6rzdguyh9ZGNpxRDNWcL160bk
         iGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695024200; x=1695629000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1h0mfMJN8y2Fpx6TXWBnY89WoQ3bNceAgBMQh6Df+ag=;
        b=q0opHk8+efDLhRTqtC92pD/z/KcSbz9+9KA+aFC4N9h7hw+uRIAAvOHTrihrRDFODI
         cp9N2KR9i+r/zavwmu46CzMRRK6vlt64D1eHpLIXQ2HEN6GRj2oqINwYqd8WAyHMqQUH
         Gc2/Hf7QcLFNKjztmLkAs6wZYuT4z2lkjSVQUAhiOFuCKDGjeR0ti4Eep+dirqHlbp7C
         YzfUhiuoYg9DvJME0+n/XIPi8QPJok70JclCb4KiASdfN6mm4PpUJ0nG1WEe5fp60+TF
         lsk5De0/PiZFO/SSDn5wpz3eHvPS1omj0l+EOakB6kmMkkNkSM1a95OWrrrJTa7ec93g
         /AfA==
X-Gm-Message-State: AOJu0YytOmKm8TNTHNlhtC7HAjVbVBlJC9TS9evHyPoc2Jh1MUtQlGWj
        zcPLUcRU+FZMPngGeOzwgZ2ox54ZPNrYMw==
X-Google-Smtp-Source: AGHT+IHKtvVlH0zspuk4ofmIKuRksz9pBIv0SaZIRH7QIKbwc54ZE0KsSgm4ClMv3uecaQoIdKjIeA==
X-Received: by 2002:a17:902:d2c1:b0:1bb:d586:d29a with SMTP id n1-20020a170902d2c100b001bbd586d29amr17077910plc.34.1695024199947;
        Mon, 18 Sep 2023 01:03:19 -0700 (PDT)
Received: from localhost.localdomain ([115.96.179.37])
        by smtp.gmail.com with ESMTPSA id w18-20020a1709029a9200b001bde877a7casm7716161plp.264.2023.09.18.01.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 01:03:19 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, andriy.shevchenko@linux.intel.com,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 0/2] iio: imu: Add driver and dt-bindings for BMI323
Date:   Mon, 18 Sep 2023 13:33:12 +0530
Message-Id: <20230918080314.11959-1-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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

Jagath Jog J (2):
  dt-bindings: iio: imu: Add DT binding doc for BMI323
  iio: imu: Add driver for BMI323 IMU

 .../bindings/iio/imu/bosch,bmi323.yaml        |   81 +
 MAINTAINERS                                   |    7 +
 drivers/iio/imu/Kconfig                       |    1 +
 drivers/iio/imu/Makefile                      |    1 +
 drivers/iio/imu/bmi323/Kconfig                |   33 +
 drivers/iio/imu/bmi323/Makefile               |    7 +
 drivers/iio/imu/bmi323/bmi323.h               |  198 ++
 drivers/iio/imu/bmi323/bmi323_core.c          | 2260 +++++++++++++++++
 drivers/iio/imu/bmi323/bmi323_i2c.c           |  115 +
 drivers/iio/imu/bmi323/bmi323_spi.c           |  106 +
 10 files changed, 2809 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
 create mode 100644 drivers/iio/imu/bmi323/Kconfig
 create mode 100644 drivers/iio/imu/bmi323/Makefile
 create mode 100644 drivers/iio/imu/bmi323/bmi323.h
 create mode 100644 drivers/iio/imu/bmi323/bmi323_core.c
 create mode 100644 drivers/iio/imu/bmi323/bmi323_i2c.c
 create mode 100644 drivers/iio/imu/bmi323/bmi323_spi.c

-- 
2.20.1

