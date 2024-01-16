Return-Path: <linux-kernel+bounces-27061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA2282E9DD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2E31F23903
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407D610A30;
	Tue, 16 Jan 2024 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T70BlK1S"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CD711181;
	Tue, 16 Jan 2024 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-598b8dd877dso2125881eaf.3;
        Mon, 15 Jan 2024 23:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705389648; x=1705994448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jJqSlAU7q9YYEOU/puykZteEqit8IcDYwZiXQDq5f5Q=;
        b=T70BlK1SJa7Ib/Nw7YJPm/vol8agyz61Ngwq/ZOU14mIIe87BVAeU6DFXcCR6fndzO
         KHRSaNFtFpK7/n6uOIyBX+embgFeMwicnqkCOAo4xIFZtWJsjFutYwL03L/ppc1Vy08m
         3eWrTQcnZwY4sK9b4eyUqKk7HpcD9f+1Ir5c9XT2WQCKASZw5zTjjn5K5cuyiwArOM8c
         2WxpL2XvdJhqNnq2PSyKEVLi+Vg5RKanpSFaa63Mz+tCjU87BAEsPBA3aNzEVMRewVBu
         Wb7oRlyfwg0B4y/zujt/jf7WQ8fbzqbN9vnXejrKECM8SIdiIf/P28QRXfFwJREvOnAW
         mvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705389648; x=1705994448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJqSlAU7q9YYEOU/puykZteEqit8IcDYwZiXQDq5f5Q=;
        b=ov2vqc0qulX0OD8BgvW2DTMqNwU+r8dfkjDnx/F58cciGUC3gE0gCKEoGXD3KwXXfN
         icFxkybpump9wtjaBbfzGGhYWFO+LAhYM4km0soMMsjlFwsXd+9knDuiIwACS4DEYyqx
         zVdCATDYa67qVADUqKazrrssdQCeaq5SsS1GXUlYB0Fqsgs1cZsa/e/kzReqIumqpix5
         Ocgzm6I8f+bjEx/pO2XN+uW/H1PTveP6LDCPZFRRgNPgjIwBm66wv3WH2uH7OXyhIukz
         JUeujWNafR7QChGSpVBSJMm6/GV3AvaegU9/H4nNn13PkTcFgfFCJqYpTCiMt91OxY1E
         zeEw==
X-Gm-Message-State: AOJu0Yx+U/ai8f6pCBNTMdpbiQD0pXBCNxa0iXTReMrQww8XuHIOFYFQ
	wuM30m0r/oyFzjUSJ+eAmeY=
X-Google-Smtp-Source: AGHT+IEUP96NmVar7W4hsw8EHmyGci8/JfqqXe3D9G9HzR5hlIK2NsHXM0P3vBPPjoIdRNIUEPsD4g==
X-Received: by 2002:a4a:8c66:0:b0:598:bffb:f1c3 with SMTP id v35-20020a4a8c66000000b00598bffbf1c3mr3028339ooj.13.1705389645949;
        Mon, 15 Jan 2024 23:20:45 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id b5-20020a4aac85000000b005984163c66fsm1949246oon.7.2024.01.15.23.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:20:45 -0800 (PST)
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
Subject: [PATCH v8 0/5] riscv: sophgo: add clock support for sg2042
Date: Tue, 16 Jan 2024 15:20:37 +0800
Message-Id: <cover.1705388518.git.unicorn_wang@outlook.com>
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

Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v1 [1]
Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v2 [2]
Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v3 [3]
Link: https://lore.kernel.org/linux-riscv/MA0P287MB03329AE180378E1A2E034374FE82A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM/ [4]
Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v4 [5]
Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v5 [6]
Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v6 [7]
Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v7 [8]
Link: https://github.com/unicornx/linux-riscv/commits/upstream-sg2042-clock-v8 [9]

---

Chen Wang (5):
  dt-bindings: clock: sophgo: add sysclk for SG2042
  dt-bindings: soc: sophgo: Add Sophgo system control module
  dt-bindings: clock: sophgo: add clkgen for SG2042
  clk: sophgo: Add SG2042 clock generator driver
  riscv: dts: add clock generator for Sophgo SG2042 SoC

 .../bindings/clock/sophgo,sg2042-clkgen.yaml  |   40 +
 .../bindings/clock/sophgo,sg2042-sysclk.yaml  |   44 +
 .../soc/sophgo/sophgo,sg2042-sysctrl.yaml     |   46 +
 MAINTAINERS                                   |    7 +
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |   12 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   39 +
 drivers/clk/Kconfig                           |    1 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/sophgo/Kconfig                    |    8 +
 drivers/clk/sophgo/Makefile                   |    2 +
 drivers/clk/sophgo/clk-sophgo-sg2042.c        | 1387 +++++++++++++++++
 drivers/clk/sophgo/clk-sophgo-sg2042.h        |  233 +++
 .../dt-bindings/clock/sophgo,sg2042-clkgen.h  |  111 ++
 .../dt-bindings/clock/sophgo,sg2042-sysclk.h  |   63 +
 14 files changed, 1994 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-sysclk.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
 create mode 100644 drivers/clk/sophgo/Kconfig
 create mode 100644 drivers/clk/sophgo/Makefile
 create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.c
 create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.h
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-sysclk.h


base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
2.25.1


