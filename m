Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C098812D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443747AbjLNKwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443752AbjLNKwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:52:47 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2709126
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:52:52 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so75230625e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702551171; x=1703155971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6tm42FF4c3bt5Gu3FnnyW38+ClAYR6mlbk3a/l087HU=;
        b=HJi4l5FUVWZi201yrhNpgWI99iIkM6pOcoM7CzCSKEPkDvNHWpNSNT0ZR/KHhTaISF
         wESC+4/r+Ybjw+AkvkCDzgaG4vVD/2Bnvi4517VN/rHXXai+aOFT8uAzS3dxYv4CLk3Q
         gaEFRdlWLaPsCn1iKejHyxQLrXxLMl65wEJQV+f93bYFnBesjO5IstdQ7ZEelICNo9Th
         Rkhil3WMNHvNmalQWaFkPcqAC1N4qacsyX6c4krlUTzLQ5QcqS5G14ulImXsRA2WvpjE
         76jt7Quqe0pdoQ41WM4H9my+JX+bE9eq5RjmTMU1sCgcDzvwgMKUVZm4tfoUTEWI61YJ
         VWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702551171; x=1703155971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6tm42FF4c3bt5Gu3FnnyW38+ClAYR6mlbk3a/l087HU=;
        b=BwMtmR7D00+wQiNLHn4jYOgNiG4dC37RxSjYonaJFmJOekfJZSHukwzb3e8W4gOnxq
         BGaWc6CGfkMVp8iYNCusTKozOkw+XgdzZqKannVUTJIlsu/yryv0xRCUlYw9zvpAkn6A
         4wyP7GPflNbFd+cpCmVxgnxCHvh4I0h3Pjyienf1Xp5ETdSntMxfRqFiyKKREILH47gU
         3jYGo0C374Uuh86tL1e2lja5gOVLPzUMqgL/znmZ35D/7T+RzOoZicwn97dhp0221Ui7
         CAARsNTd68jbYdGFG/fnhdASZqLGLR6321rEKOuEADoTjjsX45gqX32MfdGbSukjTvvz
         5ZIw==
X-Gm-Message-State: AOJu0YzrzCtWP3NkA6mdj+mboXvfFdla0B0VL7GScNkZxXWKVmo32G/N
        W6C7dDAJMrg2kn+kxibxDtgdOQ==
X-Google-Smtp-Source: AGHT+IFCKio55lZadUI3MBs5J+fZ9q8GCTSRx+SQFiZCVZbiGTTeCOe8TJ0CPUb0n+BSn7oBZ0NY0w==
X-Received: by 2002:a7b:cb92:0:b0:40c:3308:3b02 with SMTP id m18-20020a7bcb92000000b0040c33083b02mr5256825wmi.99.1702551171270;
        Thu, 14 Dec 2023 02:52:51 -0800 (PST)
Received: from ta2.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c468700b0040c420eda48sm17614854wmo.22.2023.12.14.02.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:52:50 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, semen.protsenko@linaro.org
Cc:     andre.draszik@linaro.org, saravanak@google.com,
        willmcvicker@google.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 00/13] GS101 Oriole: CMU_PERIC0 support and USI updates
Date:   Thu, 14 Dec 2023 10:52:30 +0000
Message-ID: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for PERIC0 clocks. Use them for USI in serial and I2C
configurations. Tested the serial at different baudrates (115200,
1M, 3M) and the I2C with an at24 eeprom, all went fine.

Apart of the DT and defconfig changes, the patch set spans through the tty
and clk subsystems. The expectation is that Krzysztof will apply the whole
series through the Samsung SoC tree. If the tty and clk subsystem
maintainers can give an acked-by or reviewed-by on the relevant patches
that would be most appreciated!

Thanks!
ta

Tudor Ambarus (13):
  dt-bindings: clock: google,gs101: fix CMU_TOP gate clock names
  dt-bindings: clock: google,gs101-clock: add PERIC0 clock management
    unit
  dt-bindings: i2c: exynos5: add google,gs101-hsi2c compatible
  dt-bindings: serial: samsung: gs101: make reg-io-width required
    property
  tty: serial: samsung: add gs101 earlycon support
  clk: samsung: gs101: add support for cmu_peric0
  clk: samsung: gs101: mark PERIC0 IP TOP gate clock as critical
  arm64: dts: exynos: gs101: enable cmu-peric0 clock controller
  arm64: dts: exynos: gs101: update USI UART to use peric0 clocks
  arm64: dts: exynos: gs101: define USI8 with I2C configuration
  arm64: dts: exynos: gs101: enable eeprom on gs101-oriole
  arm64: defconfig: sync with savedefconfig
  arm64: defconfig: make at24 eeprom builtin

 .../bindings/clock/google,gs101-clock.yaml    |  25 +-
 .../devicetree/bindings/i2c/i2c-exynos5.yaml  |   1 +
 .../bindings/serial/samsung_uart.yaml         |   4 +
 .../boot/dts/exynos/google/gs101-oriole.dts   |  18 +
 arch/arm64/boot/dts/exynos/google/gs101.dtsi  |  52 +-
 arch/arm64/configs/defconfig                  | 146 ++--
 drivers/clk/samsung/clk-gs101.c               | 748 ++++++++++++++++--
 drivers/tty/serial/samsung_tty.c              |  11 +
 include/dt-bindings/clock/google,gs101.h      | 230 ++++--
 9 files changed, 980 insertions(+), 255 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog

