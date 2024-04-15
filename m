Return-Path: <linux-kernel+bounces-144657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E788A48DE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61511C22DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB912263A;
	Mon, 15 Apr 2024 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQQdxEZM"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0CA2110F;
	Mon, 15 Apr 2024 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165715; cv=none; b=LJAMza020sBJLX/CNvlAbektDJLj8m0YLXfDrJ1/txTEnPViUSvfhvfXKZNPNkJmuzM9E+yibYBdDI+gB2s/b7Yt87pHgnNIE7PtO1cL2k7OWN6fZ/9uLS/sFRqrBXas4eOvg5XQ1Cxm8mfjHE7VROKUGGl/ZyO0jjn7ksz5VC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165715; c=relaxed/simple;
	bh=cXdoxXtJhU1Byr2oj6l+xuGvFZ2+Lq7+VEcEbtjbYVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bIea+v9bWRC9NaghSRoA08YnXn59avV8/Kf3NEVu7FdVIHyDDfuSqHOdL1yH7ATvodxZU8UJuXm1owL/SQEOqAfKOZJZtEtJwdIEzVEBdv9LSFJ6ge3R5vxxkq86ThHICnDOYMvkc0SJgoWFsQpvlXdLwX/rmAhFplBR4vCVyQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQQdxEZM; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-22ec890ee96so1906490fac.1;
        Mon, 15 Apr 2024 00:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713165713; x=1713770513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YtAqaBR5s+OAli9OJSXa66ymNYqzO2AN9NU6Kk2lvFc=;
        b=XQQdxEZMq20tIigvLFFUUkaLxR1i67Ye/6Q4y3udhe04CdZpHDNpB4FIHTWToW+yeN
         HjlbwWdfYrP5HjMi3DX9xpVwmCTExPlRuBqVEMk11orlurRLNx30X8GfknmVGTobBzJB
         znRIJqKXgKmz+JL/U0KxjkGsjOZcRlEYmeEEGs8p46IGM+HPbZu0Uge8FqON+StXN12E
         sbL3nxHZU9aYdhDBPN+gJ9W4svGb0d+kEA1+rUnXNmthCZ/GeqvhuD4H/g8bA9a4LA2P
         byO4DI43jr73K3zeaPcUKLffsXXV74AiHoY2S+V6vmW5RvBvvYspHysBFJz1v16VVp+z
         zg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713165713; x=1713770513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtAqaBR5s+OAli9OJSXa66ymNYqzO2AN9NU6Kk2lvFc=;
        b=PBKFXz+PID0+C2phy+i7wR8L4s8T+Lsh6Z2NH/wJyvfViPUtr1ZTuTsQU1DszP0Oos
         g0yMCCE7ID2TchtJ8kyPny7uhZBZPWm/rpVemxIh+oQLDG1piiy7o0lViCMcxuAkS7SW
         ebOKNX0dycx5mkAhAMtSxsw5N6iPj1OPkAOF5+38J2mqC4ufTgWLjGP35j1fUmYt5LkN
         G3F4gf4FK2ovUU+g3Bm1aKWJ1QqFjYY3wI8DRUatH0IXT8wOrx/zBqXYXhT/PBseT8oF
         OSOM4iRYzRd3QU9aU7ktlqCDdPBxFCzOLQko7dulQYhHiDsxnNab4/bD/iiELkxhmxvn
         Jw7A==
X-Forwarded-Encrypted: i=1; AJvYcCX2v6r7uDLiKINKI/0w0NhCp7TiAHJHv6GnnVkLqXMbBZr/v9iZoWJzwfIsoZ5FhJ8UuR8ijPxUNvwniruYUeuZxYAXuPmO52mUFCGHgkgBNn/Vj5YK/Q0DH6eogSYamJoxvpNpIZykKhqDn7TeXeDE2g2Jc1Hp3rAynylg0gBAyhT8YA==
X-Gm-Message-State: AOJu0YxQYABe8NSjY4albg82AaPKCJ9NC7p+QCjFUpoOCnOFMoiuhlzD
	qBsBem4rbE5MIUH4EsvREsbH3BSFRdyY6vcuK/IWIZBVb9iUAU9F
X-Google-Smtp-Source: AGHT+IFteLOZEFU+1qO1NsrBE/PdWJenuyhmqP93UfuT7SKJZ0n16xUcFNBJ2adDdN9oFi1cxx87Gg==
X-Received: by 2002:a05:6870:200b:b0:229:f31d:8c3 with SMTP id o11-20020a056870200b00b00229f31d08c3mr11812880oab.50.1713165712674;
        Mon, 15 Apr 2024 00:21:52 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id ny23-20020a056871751700b0022eeab387b8sm2157451oac.52.2024.04.15.00.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 00:21:49 -0700 (PDT)
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
Subject: [PATCH v14 0/5] riscv: sophgo: add clock support for sg2042
Date: Mon, 15 Apr 2024 15:21:35 +0800
Message-Id: <cover.1713164546.git.unicorn_wang@outlook.com>
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

Changes in v14:

  The patch series is based on v6.9-rc1. 

  Improved the dirvier code as per 2nd review comments from Stephen Boyd.
  - Inline the header file into source file.
  - Use devm_xxx functions for pll/div/gate registeration.
  - Use clk_parent_data for mux clocks initialization.
  - Use u32 for registers readl/writel.
  - Use devm_platform_ioremap_resource instead of devm_of_iomap.
  - Cleanup some dead code and add definitions for some magic numbers.
  - Add include files missed.
  - Use kernel-doc to improve comments for some structure and functions.
  - Other misc code cleanup work as per input from reviewers.

Changes in v13:

  The patch series is based on v6.9-rc1. You can simply review or test the
  patches at the link [14].

  Just added a minor fix for clk driver which was missed in v12.

Changes in v12:

  The patch series is based on v6.9-rc1. You can simply review or test the
  patches at the link [13].

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
Link: https://lore.kernel.org/linux-riscv/cover.1711692169.git.unicorn_wang@outlook.com/ [14]

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
 drivers/clk/sophgo/Kconfig                    |    8 +
 drivers/clk/sophgo/Makefile                   |    2 +
 drivers/clk/sophgo/clk-sophgo-sg2042.c        | 1645 +++++++++++++++++
 .../dt-bindings/clock/sophgo,sg2042-clkgen.h  |  111 ++
 include/dt-bindings/clock/sophgo,sg2042-pll.h |   14 +
 .../dt-bindings/clock/sophgo,sg2042-rpgate.h  |   58 +
 13 files changed, 2037 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
 create mode 100644 drivers/clk/sophgo/Kconfig
 create mode 100644 drivers/clk/sophgo/Makefile
 create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.c
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-pll.h
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-rpgate.h


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.25.1


