Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE72C809873
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444218AbjLHBNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHBNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:13:04 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670841708;
        Thu,  7 Dec 2023 17:13:10 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6d9ac148ca3so1028940a34.0;
        Thu, 07 Dec 2023 17:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701997989; x=1702602789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O9CqMmARklhu+aWShYkB4W+scqzZcjMk/LYLPQHxTpw=;
        b=NTgI7d2I3C8uvqfvt2ycDIYukTvSDBOsVUWuo94JUP8wZfDsIGCpi/FiYIr7dPP99p
         o5iVu+50Jd0nFuZKDZ8PYiZ+iPRhWE0QFV8EMPt4V9jjn2YT4zGL8FQwUz7uKWXdG7l3
         PlKl8Ia+iV9cApKyyAn/WujprouqJg0KjQ4L0aEcA0OiW92NrHHq7Fi1GJi5r4XvbDO3
         +GLcGOfmQSPb/NO3gBWF3TJjBhRfzD9OUFYTNLrLJOixxXQtCusNauR4ELN6RP6/JsKd
         LJkC/JH+rDNvHyT9pr3lPN4szmts9Uv1Vt9pNkziED7bi1ljT07x/ZhC7VmGyJm47zX+
         IDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701997989; x=1702602789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9CqMmARklhu+aWShYkB4W+scqzZcjMk/LYLPQHxTpw=;
        b=UI9OgkM2RjaFxnb8Kzx+Z3d219MWcE8ofw1ZW3O13LhhU4zdwPInXOj/6imjkcsqrq
         SWZQBEXykK2ufn1/55GEAHCVPjfdv/F1v0dPme0jfUEeDnUnAXYE9AvqqI9PPnWh8FrX
         DzSHlxUHCHIjc3NVKGPrmWJ1LalL0D4mBfvgHAlwxijviTt9HoRjQ4Z44byF8a5ENEVx
         D/cBCyU3seOo5nKHkF1z6+dldiYyYg06CciYFTVXk7+kQvSVPJuoSUvI6YJn+7GWQfn6
         Mq1vwr9p7si++TNT1TQ8bJKX0taBtP0Mg4pwDr2vk0Kq5z5ol7QwfIXgwP38iuXH8Ij/
         N4kA==
X-Gm-Message-State: AOJu0YwHq2kFgwBRSbm1jWw/qqwsKGbHKuza2/M/ovjMrJbJqdWgwLNh
        HXp3GtFzuL6FbJicWpU3EmY=
X-Google-Smtp-Source: AGHT+IHj76UivPYn5LBdsNNyN1HlcikxOqd5/9AFXqCLTbYyAnf/YPa+czn5QHTd0NUlupNDAZmDYg==
X-Received: by 2002:a05:6870:b68b:b0:1fb:3700:ee1b with SMTP id cy11-20020a056870b68b00b001fb3700ee1bmr3537230oab.47.1701997989445;
        Thu, 07 Dec 2023 17:13:09 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id pq15-20020a0568709c8f00b001fa24002089sm206570oab.30.2023.12.07.17.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 17:13:09 -0800 (PST)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com
Cc:     Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v6 0/4] riscv: sophgo: add clock support for sg2042
Date:   Fri,  8 Dec 2023 09:13:00 +0800
Message-Id: <cover.1701997033.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Wang <unicorn_wang@outlook.com>

This series adds clock controller support for sophgo sg2042.

Thanks,
Chen

---

Changes in v6:
  The patch series is based on v6.7-rc1. You can simply review or test the
  patches at the link [7].
  - fixed some warnings/errors reported by kernel test robot <lkp@intel.com>.

Changes in v5:
  The patch series is based on v6.7-rc1. You can simply review or test the
  patches at the link [6].
  - dt-bindings: improved yaml, such as:
    - add vendor prefix for system-ctrl property for clock generator.
    - Add explanation for system-ctrl property.
  - move sophgo,sg2042-clkgen.yaml to directly under clock folder.
  - fixed bugs for driver Makefile/Kconfig
  - continue cleaning-up debug print for driver code.

Changes in v4:
  The patch series is based on v6.7-rc1. You can simply review or test the
  patches at the link [5].
  - dt-bindings: fixed a dt_binding_check error.

Changes in v3:
  The patch series is based on v6.7-rc1. You can simply review or test the
  patches at the link [3].
  - DTS: don't use syscon but define sg2042 specific system control node. More
    background info can read [4].
  - Updating minor issues in dt-bindings as per input from reviews.

Changes in v2:
  The patch series is based on v6.7-rc1. You can simply review or test the
  patches at the link [2].
  - Squashed the patch adding clock definitions with the patch adding the
    binding for the clock controller.
  - Updating dt-binding for syscon, remove oneOf for property compatible;
    define clock controller as child of syscon.
  - DTS changes: merge sg2042-clock.dtsi into sg2042.dtsi; move clock-frequency
    property of osc to board devicethree due to the oscillator is outside the
    SoC.
  - Fixed some bugs in driver code during testing, including removing warnings
    for rv32_defconfig.
  - Updated MAINTAINERS info.

Changes in v1:
  The patch series is based on v6.7-rc1. You can simply review or test the
  patches at the link [1].

Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v1 [1]
Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v2 [2]
Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v3 [3]
Link: https://lore.kernel.org/linux-riscv/MA0P287MB03329AE180378E1A2E034374FE82A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM/ [4]
Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v4 [5]
Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v5 [6]
Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v6 [7]

---

Chen Wang (4):
  dt-bindings: soc: sophgo: Add Sophgo system control module
  dt-bindings: clock: sophgo: support SG2042
  clk: sophgo: Add SG2042 clock generator driver
  riscv: dts: add clock generator for Sophgo SG2042 SoC

 .../bindings/clock/sophgo,sg2042-clkgen.yaml  |   53 +
 .../soc/sophgo/sophgo,sg2042-sysctrl.yaml     |   34 +
 MAINTAINERS                                   |    7 +
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |    4 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   79 +
 drivers/clk/Kconfig                           |    1 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/sophgo/Kconfig                    |    8 +
 drivers/clk/sophgo/Makefile                   |    2 +
 drivers/clk/sophgo/clk-sophgo-sg2042.c        | 1356 +++++++++++++++++
 drivers/clk/sophgo/clk-sophgo-sg2042.h        |  226 +++
 .../dt-bindings/clock/sophgo,sg2042-clkgen.h  |  169 ++
 12 files changed, 1940 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
 create mode 100644 drivers/clk/sophgo/Kconfig
 create mode 100644 drivers/clk/sophgo/Makefile
 create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.c
 create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.h
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h


base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.25.1

