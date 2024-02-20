Return-Path: <linux-kernel+bounces-72245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E82D85B11B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0330C28238D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F0341C66;
	Tue, 20 Feb 2024 03:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzETRLP+"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF8923D7;
	Tue, 20 Feb 2024 03:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708398494; cv=none; b=kwlAYnZQa7/imCxm36PUpSaytOBtugyCG217kmL4FlsSPbIQlmaH51bBVuo8OZaGxkHpd3K85ZW1ggdFurjbozCXddbo4SB3n7VIa4fj04imsXNHzrJIoWFIgFgbP4Z6IHZXBbqjQIekj+rrqkISLv+mDX5VMaTDneV81Hpd5FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708398494; c=relaxed/simple;
	bh=gBzaPjOtVBDdojyRsxUAF5U/Yv5A3k+N5zb8p8J6468=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ioJlQKC5f/KL9riQKCsZ2lcO0ATTktYQj2s5Ox+/3XR+Bj+hfcqLn6xK81ZWPiqi6OA2X0f2mFnJVmmG75j5iHVvDl5mUYiNQuFCa+YKv9AceSBV39hAg7Lh8TD1lZBVZLjTqDiXAfiZe9Amnh58mllHzYEin1urNmQi0SG5ONU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzETRLP+; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ddca59e336so2677995a34.0;
        Mon, 19 Feb 2024 19:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708398492; x=1709003292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FV/8aar0yjeTSlwivEYZd0KdO8GyrBPEBvQRJPw14pw=;
        b=jzETRLP+Af+2wmTzlgOS7XJ06TjkAAdxhvxNf944NaD0/lP+hoCI7BtnR7k6ufnEqs
         29pwvQxcnTTv7MxbC/EkzexaF2ov19+vFmkP68/N5Rn4jvKma49+QcT/UE2cS5PHfB27
         rIzWMemoIQiESK1svMsIFZmmGrUwLi3ieoHofI8ZjoOVAgnXhl7Ny751CXIH014PhGS9
         bkjrPa5caRorWFPkiSV/o6UHYZhR39VM7InZ5Rb/crTcEaepmnRMxo+U3tF8RT0/gAct
         oP6uoFi8CnRTjkGgPOJuL6dqaz6Xph2gqQLdCcuoYXNn2dUn8Xl6Xm651lhO4EtC08uA
         Uc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708398492; x=1709003292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FV/8aar0yjeTSlwivEYZd0KdO8GyrBPEBvQRJPw14pw=;
        b=GgEg9f/353j8hUFxnPdMYsZIpdNy+mYd59Dn6OEgpy4CjNQUmn35+oLIV0P2dH3YRa
         jAkSrCP1O4rQOtz+XBgG73OVkTeRT5jq4fdcOFW5j8uV57CNF8g5cYEnHwXn6U8HIuYh
         8mdCEk/WY++mqcXfCcAZMPjYTOw1FWFEWSEj3J/COWl13W6Nw+vBo7HJDN43BWQRSkiJ
         JERkrAAAI+IMxvmY6JMUzOq48fs6qliuE9HWPGSKs94gc+YG8au15++uNGKx2EjddLQH
         l9hiWhg/G7HG+/Cl/b9THqMb3b5liIbPGwDfa1U6eLF0ktc0PAfqJlsQzlKTT9rePKWP
         UPLw==
X-Forwarded-Encrypted: i=1; AJvYcCWpOULmF2QiLUklkiV9MoKQHD7cX214RsiLHx9Paws5YPM29bSyDsKCLLnnLunvuoBeBX2F6M1ygkQONfttejWNqNFaQI1P2iFFeGbmTfCHK223PGB60w+a8LI5ZeRsmcfsUxVIRo4uX2X53oN52WinI1Q8CDtDTIeLYB6j9uM30jfltg==
X-Gm-Message-State: AOJu0YyXSiU4MqMMTKR2MD8T3ZWnRxP4w3E71mwUBZ56VuKh6IWwsGTv
	PY4rjyCxzXnPImcatP+n+wX5Iju7M/9M47ZlltOYiw1C95ZUDFt0
X-Google-Smtp-Source: AGHT+IG0bfS6KPLR4IvZ0y5QiKbxUNdumXv5cywZDVqFev9EJ1l2x/LgPwu3c7iVJStL6K2dzBIYhg==
X-Received: by 2002:a05:6830:1bf6:b0:6e2:e6cc:2fb7 with SMTP id k22-20020a0568301bf600b006e2e6cc2fb7mr7605825otb.15.1708398492174;
        Mon, 19 Feb 2024 19:08:12 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id r3-20020a056830120300b006e2dec92b91sm1164311otp.20.2024.02.19.19.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 19:08:11 -0800 (PST)
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
Subject: [PATCH v11 0/5] riscv: sophgo: add clock support for sg2042
Date: Tue, 20 Feb 2024 11:08:04 +0800
Message-Id: <cover.1708397315.git.unicorn_wang@outlook.com>
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

Changes in v11:

  The patch series is based on v6.8-rc5.

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
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   48 +
 drivers/clk/Kconfig                           |    1 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/sophgo/Kconfig                    |    8 +
 drivers/clk/sophgo/Makefile                   |    2 +
 drivers/clk/sophgo/clk-sophgo-sg2042.c        | 1401 +++++++++++++++++
 drivers/clk/sophgo/clk-sophgo-sg2042.h        |  233 +++
 .../dt-bindings/clock/sophgo,sg2042-clkgen.h  |  111 ++
 include/dt-bindings/clock/sophgo,sg2042-pll.h |   14 +
 .../dt-bindings/clock/sophgo,sg2042-rpgate.h  |   58 +
 14 files changed, 2026 insertions(+)
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


base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
-- 
2.25.1


