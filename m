Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9067FD285
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjK2J1n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 04:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjK2J1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:27:41 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1100F1BD4;
        Wed, 29 Nov 2023 01:27:41 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 18E1B24E2D4;
        Wed, 29 Nov 2023 17:27:34 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 29 Nov
 2023 17:27:34 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 29 Nov 2023 17:27:32 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Hal Feng" <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v8 0/4] StarFive's Pulse Width Modulation driver support
Date:   Wed, 29 Nov 2023 17:27:28 +0800
Message-ID: <20231129092732.43387-1-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset adds initial rudimentary support for the StarFive
Pulse Width Modulation controller driver. And this driver will
be used in StarFive's VisionFive 2 board.The first patch add
Documentations for the device and Patch 2 adds device probe for
the module.

Changes v7->v8:
- Rebased to v6.7rc3.
- Changed compatible to "opencores,pwm-v1"
- Adjusted the clock unprepare order.
- Followed dt-bindings Coding style.

Changes v6->v7:
- Rebased to v6.6.
- Added dependency architecture.
- Adopted new rounding algorithm.
- Added limitation descripton.
- Used function interfaces instead of macro definitions.
- Followed the linux coding style.

Changes v5->v6:
- Rebased to v6.6rc5.
- Changed driver into a generic OpenCores driver.
- Modified dt-bindings description into OpenCores.
- Uesd the StarFive compatible string to parameterize.

Changes v4->v5:
- Rebased to v6.6rc2.
- Updated macro definition indent.
- Replaced the clock initializes the interface.
- Fixed patch description.

Changes v3->v4:
- Rebased to v6.5rc7.
- Sorted the header files in alphabetic order.
- Changed iowrite32() to writel().
- Added a way to turn off.
- Modified polarity inversion implementation.
- Added 7100 support.
- Added dts patches.
- Used the various helpers in linux/math.h.
- Corrected formatting problems.
- Renamed dtbinding  to 'starfive,jh7100-pwm.yaml'.
- Dropped the redundant code.

Changes v2->v3:
- Fixed some formatting issues.

Changes v1->v2:
- Renamed the dt-binding 'pwm-starfive.yaml' to 'starfive,jh7110-pwm.yaml'.
- Dropped the compatible's Items.
- Dropped the unuse defines.
- Modified the code to follow the Linux coding style.
- Changed return value to dev_err_probe.
- Dropped the unnecessary local variable.

The patch series is based on v6.7rc3.

William Qiu (4):
  dt-bindings: pwm: Add bindings for OpenCores PWM Controller
  pwm: opencores: Add PWM driver support
  riscv: dts: starfive: jh7100: Add PWM node and pins configuration
  riscv: dts: starfive: jh7110: Add PWM node and pins configuration

 .../bindings/pwm/opencores,pwm.yaml           |  56 +++++
 MAINTAINERS                                   |   7 +
 .../boot/dts/starfive/jh7100-common.dtsi      |  24 ++
 arch/riscv/boot/dts/starfive/jh7100.dtsi      |   9 +
 .../jh7110-starfive-visionfive-2.dtsi         |  22 ++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |   9 +
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ocores.c                      | 232 ++++++++++++++++++
 9 files changed, 372 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
 create mode 100644 drivers/pwm/pwm-ocores.c

--
2.34.1

