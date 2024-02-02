Return-Path: <linux-kernel+bounces-49275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C0E84681F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7112889A1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAB41755F;
	Fri,  2 Feb 2024 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AynIh1kh"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32426DDAF;
	Fri,  2 Feb 2024 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706855951; cv=none; b=VNJi8ftO3Q68hsJxecwGlVzV342Q2qUNRrJhBddLWu7/So595wlt+Vk/mpOwVVzL8DmNmxiP0zkjYgY/eAk8pGI/IgpE+i3LnlLRp/dYczfQ9NMpHwBmim1kDhfCcZ4OjSJ+eLiI1XprNla0afrPy+sncyrsRNhKeIyEYq8tIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706855951; c=relaxed/simple;
	bh=6EPiH1cuCdFr3hqVydnRELVaVjXd9CwJbGjbB3z8Wgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XjHC8vFNZQHlg61hjAFbsMCnrFapip+TfYxP2vDNwW+YvQ8UIBrBFm4e2iQxtTDj2zXIa5k0kQ2QGINjlMDb09Mw1mOvxo2yCZLwRQAhSpGLRgUNtbiG4qjFuFHW13nAAW/a55Xr0rJuEDtAldmfSdSdTAEqZhcoXuqeLIodAjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AynIh1kh; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59a31c14100so1049273eaf.0;
        Thu, 01 Feb 2024 22:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706855949; x=1707460749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jJbEo/Toazrk+xPxIk8inyWPiuGq5pJrmcLxJn+T+WI=;
        b=AynIh1khorRJcv57+m3X/oio/wp/GNJ3ll5bIDqZ3jIRuH8imf6MKPZ3lCG7pPyTgC
         TVdjN37nAzJbEGb8dg5YcFQchzWJmXGyYS5ga/n05oew5SmaJKJKdctJAro417SD5klA
         uH4D2lMohfYopjrm1Yu387v9A0i3a8+yFTj4yjihLSGdos+K+1D+8jFvzAuE9uFVJnyB
         JU3awfCuRIJIS3jbhw8joI8/ArMlwsCpD4soiIG1TEIypdinx2b5AVxbxxq7pHsJu4HI
         ef+pDRPXwK5m8eXQu9YthKWNeHT0HiM6Jj28PcEgaeeSUrgjsxg/Kw1c9DIcRXx51SBA
         ZQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706855949; x=1707460749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJbEo/Toazrk+xPxIk8inyWPiuGq5pJrmcLxJn+T+WI=;
        b=atVu8mkX7AnYGXtbO11AkY7/Ydz1cSzfOR3+g5geawKmlM+SV9DrL2Ex/ZJqlITSw4
         NOODItltCCBKrNq3F4FF7XzIAf09pwKAwNnuy1H3GPhfd58coIlz686iR2K6kS/AzQg5
         R8Tr9KbKGqLWViTIjbCYrwlufKiGm0BtRHyB2xip2G6mMp+oDIDzfGWRiPMj6W6maYkt
         BuH9Y4CS9ubgdZQFMfb8pSIINLGX6TlpL1JZyBCfnlCzHgwxv7WLXTU7yKQvCH2zdwHs
         QorbGa6HnIFmz1xNwL11JM7FPYrsxkWgJyC5GF3luB0bEFrAlV3RSgCfVM/O4gBqCUZ1
         n1hA==
X-Gm-Message-State: AOJu0Yy5hbz9hKh4YlKc9VmJlphzp/41UfNCCH+zwWPglQnRBEpsLEj6
	6YooLOPzQ8tcj2YVcQGlKEo0JwWIaIrcAB9+z7IMY4qVhF57ksaA
X-Google-Smtp-Source: AGHT+IGwsUmKtKQ7cPmsSLpZJJolXyk1TGNZXnqP9wf9YCFH9Dg7QrcMIbyRoqm83Ityw48qUXsJtQ==
X-Received: by 2002:a4a:d6ca:0:b0:599:ba9c:393a with SMTP id j10-20020a4ad6ca000000b00599ba9c393amr6598794oot.0.1706855948981;
        Thu, 01 Feb 2024 22:39:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUoW95Sf6wGde/380u1EAZ2lKERzkZFeHkae99XR42pzvscPXgjIwes+2uaUHVqR8QAX/yV2DcOUgWX97pQ/MoGDd5LPuqL9t0TQXTKldZIL9T0iMM/pngv325PB99DIqVn8zTwhiNAfSg448iKnf/KR/1O2Gao9RM3ynIQU5YS3vGzZWCuRwBxUSUhqidHk3nmsssBJ04gFXcEZ1xSAritxbJGm2DpBS1iJHEZ5d5ELRMTBignY9trUMNwEsQ1kQ7+2B+OOqlnWSdcIvR50PEIWSAF6aNfIMFOnJPFm8UIUZRRKXc7tcWuD2gOjweKpLu2zrJAFBGZ2onhI4pENe1MLIgY+Ww7tN95bzaEvw5GkZoEbe4BHWAq1Ns5CQIiLWU5A6MpVg95eGVpQRY1SywnT3O7ApMfwJIMkTnQQ/xUVsVB4aUcauEc6ZgjHInCvZRCjz5ApIH0WzKb9TOSHQbQLKaLX36I19GV2rNkartAeXB7OhdkQBiwrztEVGyNyAtvnI3/uJKW96SEQ9aISJbDTGVxIPNGxwouxtGjrehdhot+p82CyXgOUEfZfG+6Mm4EX1/PBy2n1n4EB/jdpcp+gvH03L2xpHNDS8plO7pzLiXTFttBztPJ0osxReFuVSvntRSCh1vYL0TetnrxqX4mKqoIH7EVFKwi0TSKqNZp+T4=
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 17-20020a4ae1b1000000b0059a530f54c6sm281948ooy.10.2024.02.01.22.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 22:39:08 -0800 (PST)
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
Subject: [PATCH v9 0/5] riscv: sophgo: add clock support for sg2042
Date: Fri,  2 Feb 2024 14:39:00 +0800
Message-Id: <cover.1706854074.git.unicorn_wang@outlook.com>
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

Changes in v9:
  The patch series is based on v6.8-rc2.

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

---

Chen Wang (5):
  dt-bindings: clock: sophgo: add pll clocks for SG2042
  dt-bindings: clock: sophgo: add RP gate clocks for SG2042
  dt-bindings: clock: sophgo: add clkgen for SG2042
  clk: sophgo: Add SG2042 clock driver
  riscv: dts: add clock generator for Sophgo SG2042 SoC

 .../bindings/clock/sophgo,sg2042-clkgen.yaml  |   37 +
 .../bindings/clock/sophgo,sg2042-pll.yaml     |   45 +
 .../bindings/clock/sophgo,sg2042-rpgate.yaml  |   37 +
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |   12 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   41 +
 drivers/clk/Kconfig                           |    1 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/sophgo/Kconfig                    |    8 +
 drivers/clk/sophgo/Makefile                   |    2 +
 drivers/clk/sophgo/clk-sophgo-sg2042.c        | 1401 +++++++++++++++++
 drivers/clk/sophgo/clk-sophgo-sg2042.h        |  233 +++
 .../dt-bindings/clock/sophgo,sg2042-clkgen.h  |  111 ++
 include/dt-bindings/clock/sophgo,sg2042-pll.h |   14 +
 .../dt-bindings/clock/sophgo,sg2042-rpgate.h  |   58 +
 14 files changed, 2001 insertions(+)
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


base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
-- 
2.25.1


