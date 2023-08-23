Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD2078593F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbjHWN20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbjHWN2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:28:25 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355EC1729
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:27:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52a06f5f556so4552123a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797274; x=1693402074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YCofaFPB8TZ4d+srfDAO9nfB6vF95jvqecRuFt9D0xk=;
        b=vysf+LsIyhcUIe6xb+H3hRG5PmR5ylI4vHsoQYNZbcAGEEzN5IWhTF2CVqdlNrAHfp
         uH5WVyqOh2neCWyXsIdsnr6RZIOWud5y9ggor2ZZCphoHJ3KolmJYDer2Xj4/3h3rq3/
         nE5TusDZyXzq/inEAG7kfFvvT/S2PMR4wSqhTeLX6JH3DOq6bEePZUytaUo4e267sHkt
         xUl9P+rKUTrHuzDH5bF8dETzaziF8xsipvYpTm4FS8d2SWwLpmG/PuCWFwTf7FiqI0WZ
         f0ty2WAfZXjaH5s0QfJEo/o5zJlgyvomDQ3rUnPcwOa41AAVqPlj6TrDUiUwwTnLbgxT
         IGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797274; x=1693402074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCofaFPB8TZ4d+srfDAO9nfB6vF95jvqecRuFt9D0xk=;
        b=k9YGtIeCZjKPGV2d2TLXM0OhE9xSkliDyqaaqks6v9HxBiaS0+I0VP8LKdDe0wUOGN
         j8/YpL45In5M0ARJKyKPX/tPESGCmZmNQ4uHFbhHbB9gUJRs8F0sCb5k8aIPs/vv92M2
         8eQDDAFvdgDCyHozRjzk3EO2zgBQYBIW+EsjuAVGvN81vFtZ0zoFyQG7uctbCR79+VNQ
         UIZGvGoYCrgyMnlptPtExVqcdk0GjuYHoUCgQqClYiwLHevfV7OR0+WntZjpopAv+y4G
         TxO+2v3x/IRUYhpe3WgFCDa1l46d1rg7D2EYke1LjBqztSpaAsaXoD9k4AVTHbHkyBgp
         m1cA==
X-Gm-Message-State: AOJu0YzduOYUl+QC/4WgyhC0IFdw0fDpkzTtO7siJe384ZvtteznNPhZ
        GggKl3OwM+jd3wGC0vJbcVHvdIyisxKyrdCPIwM=
X-Google-Smtp-Source: AGHT+IHKShPG2fR1a7d9FL99fB6hte8fOQOpyCm8dffZJ/VBdnPBsdTEl5TXsogKaRw+UTZFHDTgoA==
X-Received: by 2002:a17:907:2cf7:b0:99c:825:6076 with SMTP id hz23-20020a1709072cf700b0099c08256076mr9421411ejc.35.1692797274458;
        Wed, 23 Aug 2023 06:27:54 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:27:53 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 00/22] nvmem: patches for v6.6
Date:   Wed, 23 Aug 2023 14:27:22 +0100
Message-Id: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4221; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=weMr26hGWL8lTVEa1w3PW2UC/djUm+2wB4zmL75dW6s=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5gk27SmLf+wnJM5eY3/0EHQ0IRh0FwDO9tcTf V+5jvYjWAGJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJNgAKCRB6of1ZxzRV N9KbB/0dklZHDJnwpGaC6GbyOm2wnxTdJZOsEQksvQgkmHD0oMoZ7JoH5Dkxro/FW2UTYe9/rcG X8VWqwyr8V0opiNdaQKDq8i8xx7Ur6eZ+GCRSNkKVnb+LuRAkOLrS1cowxGZyVejIZPYA6CxB22 gk3KAjbKE+Jeq/CoEmjP2duyehZvOjNQ1g9Vx2aj2etMUnQzurkI6FwXPKfYpsuOq+5c4UW7pRB c5BpnBcupbb6T8oHe7U3xCBhlwoB8f2dO9TFuiUjsnysFuQuZzf+H7zKSvtl0TGxpwGk50OEz+s Cpqodw195IZn6oO0/BZIHa5iRnxB5LVTlwgoJ8MUthUF9zOX
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Here are some nvmem patches slightly more than usual for 6.6 that includes

- Support for NXP eFuse, qcom secure qfprom, QCM2290 nvmem providers
- core level cleanup around error handling and layout creation.
- few minor cleanups across providers drivers to use better
  apis and a typo fix.

Can you please queue them up for 6.6.

Thanks,
Srini


MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes since v1:
- squashed a build error patch into sec-qfprom


Atul Raut (1):
  nvmem: u-boot-env:: Replace zero-length array with
    DECLARE_FLEX_ARRAY() helper

Diederik de Haas (1):
  nvmem: Kconfig: Fix typo "drive" -> "driver"

Komal Bajaj (2):
  dt-bindings: nvmem: sec-qfprom: Add bindings for secure qfprom
  nvmem: sec-qfprom: Add Qualcomm secure QFPROM support

Konrad Dybcio (1):
  dt-bindings: nvmem: Add compatible for QCM2290

Matti Lehtimäki (1):
  dt-bindings: nvmem: qfprom: Add compatible for MSM8226

Miquel Raynal (4):
  nvmem: core: Create all cells before adding the nvmem device
  nvmem: core: Return NULL when no nvmem layout is found
  nvmem: core: Do not open-code existing functions
  nvmem: core: Notify when a new layout is registered

Rafał Miłecki (1):
  dt-bindings: nvmem: fixed-cell: add compatible for MAC cells

Richard Alpe (2):
  dt-bindings: nvmem: Add t1023-sfp efuse support
  nvmem: add new NXP QorIQ eFuse driver

Rob Herring (1):
  nvmem: Explicitly include correct DT includes

Yangtao Li (8):
  nvmem: sunxi_sid: Convert to devm_platform_ioremap_resource()
  nvmem: brcm_nvram: Use devm_platform_get_and_ioremap_resource()
  nvmem: lpc18xx_otp: Convert to devm_platform_ioremap_resource()
  nvmem: meson-mx-efuse: Convert to devm_platform_ioremap_resource()
  nvmem: rockchip-efuse: Use devm_platform_get_and_ioremap_resource()
  nvmem: stm32-romem: Use devm_platform_get_and_ioremap_resource()
  nvmem: qfprom: do some cleanup
  nvmem: uniphier: Use devm_platform_get_and_ioremap_resource()

 .../bindings/nvmem/fsl,t1023-sfp.yaml         | 37 +++++++
 .../bindings/nvmem/layouts/fixed-cell.yaml    | 26 +++++
 .../bindings/nvmem/layouts/fixed-layout.yaml  | 12 +++
 .../devicetree/bindings/nvmem/nvmem.yaml      |  5 +-
 .../bindings/nvmem/qcom,qfprom.yaml           |  2 +
 .../bindings/nvmem/qcom,sec-qfprom.yaml       | 55 +++++++++++
 drivers/nvmem/Kconfig                         | 31 +++++-
 drivers/nvmem/Makefile                        |  4 +
 drivers/nvmem/bcm-ocotp.c                     |  1 -
 drivers/nvmem/brcm_nvram.c                    |  3 +-
 drivers/nvmem/core.c                          | 19 ++--
 drivers/nvmem/imx-iim.c                       |  1 -
 drivers/nvmem/imx-ocotp-ele.c                 |  2 +-
 drivers/nvmem/imx-ocotp-scu.c                 |  2 +-
 drivers/nvmem/imx-ocotp.c                     |  1 -
 drivers/nvmem/lpc18xx_otp.c                   |  5 +-
 drivers/nvmem/meson-mx-efuse.c                |  5 +-
 drivers/nvmem/qcom-spmi-sdam.c                |  2 +-
 drivers/nvmem/qfprom.c                        | 17 +---
 drivers/nvmem/qoriq-efuse.c                   | 78 +++++++++++++++
 drivers/nvmem/rave-sp-eeprom.c                |  2 +-
 drivers/nvmem/rockchip-efuse.c                |  3 +-
 drivers/nvmem/sc27xx-efuse.c                  |  1 -
 drivers/nvmem/sec-qfprom.c                    | 96 +++++++++++++++++++
 drivers/nvmem/snvs_lpgpr.c                    |  3 +-
 drivers/nvmem/sprd-efuse.c                    |  2 +-
 drivers/nvmem/stm32-romem.c                   |  3 +-
 drivers/nvmem/sunplus-ocotp.c                 |  2 +-
 drivers/nvmem/sunxi_sid.c                     |  5 +-
 drivers/nvmem/u-boot-env.c                    |  4 +-
 drivers/nvmem/uniphier-efuse.c                |  3 +-
 include/linux/nvmem-consumer.h                |  4 +-
 32 files changed, 378 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
 create mode 100644 drivers/nvmem/qoriq-efuse.c
 create mode 100644 drivers/nvmem/sec-qfprom.c

-- 
2.25.1

