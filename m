Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC2C77BE66
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjHNQxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjHNQxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:53:01 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EFCD2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:00 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-523bf06f7f8so4495822a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692031978; x=1692636778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OWi0d8cnhJVkibcRL5KFFHF6LCpz+gwi/QiEBWBj8HE=;
        b=a8DpPzJ4p3U/l7P/pArfCzLwHCzw6bF4R+fnA6C2CjyMpInOEMUk3FNHca3jHnXmV6
         sTImF+qdv6e30Fc7jHrlCcpVBsFaFWNgs9wowZLMt11xTFu691sIUCPaMMIh8XnM6yNz
         6ErZe42aasUX154ywL8vaNXeqVeRBOb3SP1OjpQT4pCbX0zKkYpCdkho6HIh/8pZvl6u
         fnwtybj8VIYkTYicsr6qcOr339rAeoDON74uxh0600ATIa5wcBzyTnW74NklmhawomXL
         90X0/l8EMNN2M/a4vGbfTTiNX7AlKHGHNJXLh5Lc0ffnogbruT66+YPvDNHPZWs1h79K
         owxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692031978; x=1692636778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWi0d8cnhJVkibcRL5KFFHF6LCpz+gwi/QiEBWBj8HE=;
        b=N5sHasfQfhZPJVmodybd8gRhg9YsVWcTb7Ard/Vw84sokF6k9IVu2KAK+m9Hbjmv6p
         ucIIfx5pPCnTXcG56TaTC21hwZy7E9yHZEsLsi8CfRkKjNeisHfHUjVYhJmKgZtLjBIq
         4vprZnx3qKpMpLcu/8wekBn56A6gIrG2z43O6q0bviY/8KeyRDdk/qsyhJIcOjnkYRcB
         itR2Tbm38bWtQU78SprdIyUZvkB4eGgk2WRcELkhC35Lb+Uz5E+CNKLu2i5Kbdl2JL2d
         gHlBktvxYxi+gxdYOIOlZ7gNGa49oD5wqvrmHup/PT1v77I+jX8qFNMmo3vKDYEZcp8t
         nI7Q==
X-Gm-Message-State: AOJu0YxoS97kMnR5fxavT2IJTatHUYdspNxhmHgfN/rGr9qGb0mPZU8y
        lwzI6lBt2QtDppCRrkwFBC3JvhBLvWBuN1ODQWg=
X-Google-Smtp-Source: AGHT+IFWayDtV/5dE2776kwaZZ+6EIZwvBvDsOsK9OKMD8JThvKUeEJRE+iKEM+TR+BG12wKUpwI2A==
X-Received: by 2002:a05:6402:50a:b0:523:38ea:48bb with SMTP id m10-20020a056402050a00b0052338ea48bbmr8264216edv.24.1692031978458;
        Mon, 14 Aug 2023 09:52:58 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:52:57 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/22] nvmem: patches for v6.6
Date:   Mon, 14 Aug 2023 17:52:30 +0100
Message-Id: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/nvmem/sec-qfprom.c                    | 97 +++++++++++++++++++
 drivers/nvmem/snvs_lpgpr.c                    |  3 +-
 drivers/nvmem/sprd-efuse.c                    |  2 +-
 drivers/nvmem/stm32-romem.c                   |  3 +-
 drivers/nvmem/sunplus-ocotp.c                 |  2 +-
 drivers/nvmem/sunxi_sid.c                     |  5 +-
 drivers/nvmem/u-boot-env.c                    |  4 +-
 drivers/nvmem/uniphier-efuse.c                |  3 +-
 include/linux/nvmem-consumer.h                |  4 +-
 32 files changed, 379 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
 create mode 100644 drivers/nvmem/qoriq-efuse.c
 create mode 100644 drivers/nvmem/sec-qfprom.c

-- 
2.25.1

