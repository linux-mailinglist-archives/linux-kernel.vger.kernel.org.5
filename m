Return-Path: <linux-kernel+bounces-124189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 382018913A7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87201F22B47
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1CF3F9EA;
	Fri, 29 Mar 2024 06:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjYWp65O"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1AE2AF0D;
	Fri, 29 Mar 2024 06:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711693168; cv=none; b=ABF83+Kk+BbtponiiFC+pUPzwmJmKnx1CNl6ebcZstn6ZPcfYYWbZZwJp3EhgNBOuP9dXZorC8GPqWxOOWqGNfNw/95xiD5fRhL06Ox3f5IIIoSwo8TnaoM00YHD0elSA2ZCPfpcjXlUHZ5MnKVMQ36v8bYvrOSpU6UFaVe+o5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711693168; c=relaxed/simple;
	bh=VukMf/wiLDIDXbjGSrP5Oubho/u+UwmvOnHB+Z6T88M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jW6Y8ElNj4O3RqVcJxykthOK2qXWNBACwr/o50DFCVXvk9tY/GlfQ3LA7dLQOZ8n8EG+lnw1XH3XQI22SH3J1C1sc8l5qYebU1Mo0Q07UWVYP5Fe9hn+MPXIltzdoOFtESlucIco/6BvxxYpBO7C+wvKIWVyzRzQ8NA0k+0lHdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjYWp65O; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a47cecb98bso1016894eaf.0;
        Thu, 28 Mar 2024 23:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711693166; x=1712297966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a5qNysMUgsVj2NxCjAJDWpjxUroK4J5IHGWofoBiS2I=;
        b=gjYWp65On+rjem2E2GY7we+wp53XYElhfYltS9GbWI0i3IulOG7DToUU2OIzdJS85b
         4hatPPgd/RMX23r76LVEgCQU+APFHHd0VfXl5ci1rGfMFNoNztwMW79uAkvrhRr4GQO/
         zAbwK22mDieALiE4up4VTJdwu1cbgbUCacJPmLEUjFmSH1J33Mv8qpDlZLTEMWtim6up
         jIEtVEI/cLp+24PgTNFVC051niNnYJcSmzamvIzyyGOEgDnlE+hWi54JVpma62nBecS3
         cTJetFJ4M8zElYXqWOLsdyrbfo4dKTVqq1Ow5hq1ec4joztYpm9Eau5sbXSyLWLRfm5J
         HSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711693166; x=1712297966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5qNysMUgsVj2NxCjAJDWpjxUroK4J5IHGWofoBiS2I=;
        b=mrHTcwcZ+FZoSRb/JcHYhIBKIGUUQPe/8+o56+kJS09fDTNlIZ7GiWazOHsKC2nVsk
         jiD8LgtkI0Hw7AbyMGfV4xoC0FHkuhxQeWp09ozVCMHWbXOaEOcY88p8yugTV//PxvGC
         DJT6+yyATKDNmRDJhlACdOH/CqLN3gv2mV2+LTbQENMXf+BzDeO64NqtMjugIDHI9++/
         nLepH4f3XYjWCvHCTNLDC4oVWFESU9ramSf+uoPYVz9eg0HkzFgyMNhtEK+8bjWvCaBR
         irlyJmlFMGB09F6YvXQTBz55Infdd72Qsv1uqw0H4l7/mGJgqhvbOCfb9Nq3fh3VN6Yk
         aZaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb7kk2cPiky4VesnlCmu6PSopLMjFA9HlBrvpAbq4+2L7nDqCrw0fdJYq9t5vD1sr1Yakdjc03CUp2gHfidBT6ml68Ht9jRCB4nXtpNmyYZWzg2SxCMJjYjKnkznMb4I30AMzueRHZbmQhQ4blHT4deflZNB9MmyLEUSs+d5sYM/J8Jg==
X-Gm-Message-State: AOJu0YwfEDTaFc47clawmvcrrfjumLkyOP1Q6mRdP2Z+nY5mVFtmXUVu
	cl292/Y2f3BpmJdrZQagsr1+qiB3cH7k+rw2qW4HlH8JoqBq0gZm
X-Google-Smtp-Source: AGHT+IHk6VzaNA2lIv3vIFW8C8LFFIujSkvYiNCcizw35NkGfN9PQceTEP2ZxvaVFI4GV2ltBo/iDA==
X-Received: by 2002:a05:6820:208:b0:5a4:7696:6ba8 with SMTP id bw8-20020a056820020800b005a476966ba8mr1254453oob.7.1711693165742;
        Thu, 28 Mar 2024 23:19:25 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id do4-20020a05682028c400b005a22f8ae2dfsm613352oob.34.2024.03.28.23.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 23:19:25 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	richardcochran@gmail.com,
	robh+dt@kernel.org,
	sboyd@kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com,
	samuel.holland@sifive.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v13 0/5] riscv: sophgo: add clock support for sg2042
Date: Fri, 29 Mar 2024 14:19:16 +0800
Message-Id: <cover.1711692169.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

This series adds clock controller support for sophgo sg2042.

Thanks,
Chen

---

Changes in v13:

  The patch series is based on v6.9-rc1. You can simply review or test the
  patches at the link [13].

  Just added a minor fix for clk driver which was missed in v12.

Changes in v12:

  The patch series is based on v6.9-rc1. 

  Improved the dirvier code as per review comments from Stephen Boyd.
  - Remove default y for CLK_SOPHGO_SG2042.
  - Optimize sg2042_pll_get_postdiv_1_2, move postdiv1_2 to the function.
    scope and add more explaniation.
  - Optimize sg2042_get_pll_ctl_setting.
  - Switch to platform driver.
  - Use clk_hw for initialization of struct clks.
  - Don't use ignore_unused when using critical.
  - Other code cleanup as per input form the reviewers.

Changes in v11:

  The patch series is based on v6.8-rc5. You can simply review or test the
  patches at the link [12].

  Quick fixed some dt_binding_check errors reported by Rob.

Changes in v10:

  The patch series is based on v6.8-rc4. You can simply review or test the
  patches at the link [11].

  Add input clocks for rpgate & clkgen.

Changes in v9:
  The patch series is based on v6.8-rc2. You can simply review or test the
  patches at the link [10].

  From this version, drop the system-controller node due to there is no actual
  device corresponding to it in IC design. SYS_CTRL is just a registers segment
  defined on TRM for misc functions. Now three clock-controllers are defined for
  SG2042, the control registers of the three clock-controllers are scattered in
  different memory address spaces:
  - the first one is for pll clocks;
  - the second one is for gate clocks for RP subsystem;
  - the third one is for div/mux, and gate clocks working for other subsystem
    than RP subsystem.

Changes in v8:
  The patch series is based on v6.7. You can simply review or test the
  patches at the link [9].
  
  In this version, the main change is to split one clock provider into two.
  Strictly follow the hardware instructions, in the memoymap, the control
  registers of some clocks are defined in the SYS_CTRL segment, and the
  control registers of other clocks are defined in the CLOCK segment.
  Therefore, the new design defines two clock controllers, one as a child
  node of the system control and the other as an independent clock controller
  node.

  This modification involves a major modification to the binding files, so
  the reviewed-by tags has been deleted.

Changes in v7:
  The patch series is based on v6.7. You can simply review or test the
  patches at the link [8].
  - fixed initval issue.
  - fixed pll clk crash issue.
  - fixed warning reported by <lkp@intel.com>
  - code optimization as per review comments.
  - code cleanup and style improvements as per review comments and checkpatch
    with "--strict"

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

Link: https://lore.kernel.org/linux-riscv/cover.1699879741.git.unicorn_wang@outlook.com/ [1]
Link: https://lore.kernel.org/linux-riscv/cover.1701044106.git.unicorn_wang@outlook.com/ [2]
Link: https://lore.kernel.org/linux-riscv/cover.1701691923.git.unicorn_wang@outlook.com/ [3]
Link: https://lore.kernel.org/linux-riscv/MA0P287MB03329AE180378E1A2E034374FE82A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM/ [4]
Link: https://lore.kernel.org/linux-riscv/cover.1701734442.git.unicorn_wang@outlook.com/ [5]
Link: https://lore.kernel.org/linux-riscv/cover.1701938395.git.unicorn_wang@outlook.com/ [6]
Link: https://lore.kernel.org/linux-riscv/cover.1701997033.git.unicorn_wang@outlook.com/ [7]
Link: https://lore.kernel.org/linux-riscv/cover.1704694903.git.unicorn_wang@outlook.com/ [8]
Link: https://lore.kernel.org/linux-riscv/cover.1705388518.git.unicorn_wang@outlook.com/ [9]
Link: https://lore.kernel.org/linux-riscv/cover.1706854074.git.unicorn_wang@outlook.com/ [10]
Link: https://lore.kernel.org/linux-riscv/cover.1708223519.git.unicorn_wang@outlook.com/ [11]
Link: https://lore.kernel.org/linux-riscv/cover.1708397315.git.unicorn_wang@outlook.com/ [12]
Link: https://lore.kernel.org/linux-riscv/cover.1711527932.git.unicorn_wang@outlook.com/ [13]

---

Chen Wang (5):
  dt-bindings: clock: sophgo: add pll clocks for SG2042
  dt-bindings: clock: sophgo: add RP gate clocks for SG2042
  dt-bindings: clock: sophgo: add clkgen for SG2042
  clk: sophgo: Add SG2042 clock driver
  riscv: dts: add clock generator for Sophgo SG2042 SoC

 .../bindings/clock/sophgo,sg2042-clkgen.yaml  |   49 +
 .../bindings/clock/sophgo,sg2042-pll.yaml     |   45 +
 .../bindings/clock/sophgo,sg2042-rpgate.yaml  |   43 +
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |   12 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   49 +-
 drivers/clk/Kconfig                           |    1 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/sophgo/Kconfig                    |    7 +
 drivers/clk/sophgo/Makefile                   |    2 +
 drivers/clk/sophgo/clk-sophgo-sg2042.c        | 1410 +++++++++++++++++
 drivers/clk/sophgo/clk-sophgo-sg2042.h        |  216 +++
 .../dt-bindings/clock/sophgo,sg2042-clkgen.h  |  111 ++
 include/dt-bindings/clock/sophgo,sg2042-pll.h |   14 +
 .../dt-bindings/clock/sophgo,sg2042-rpgate.h  |   58 +
 14 files changed, 2017 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
 create mode 100644 drivers/clk/sophgo/Kconfig
 create mode 100644 drivers/clk/sophgo/Makefile
 create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.c
 create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.h
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-pll.h
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-rpgate.h


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.25.1


