Return-Path: <linux-kernel+bounces-9560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BE481C789
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E882C287CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6B213FF4;
	Fri, 22 Dec 2023 09:46:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9296FBF3;
	Fri, 22 Dec 2023 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 124B67FC9;
	Fri, 22 Dec 2023 17:45:50 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 22 Dec
 2023 17:45:49 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 22 Dec 2023 17:45:48 +0800
From: William Qiu <william.qiu@starfivetech.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>
CC: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "Hal
 Feng" <hal.feng@starfivetech.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v10 0/4] StarFive's Pulse Width Modulation driver support
Date: Fri, 22 Dec 2023 17:45:44 +0800
Message-ID: <20231222094548.54103-1-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Hi,

This patchset adds initial rudimentary support for the StarFive
Pulse Width Modulation controller driver. And this driver will
be used in StarFive's VisionFive 2 board.The first patch add
Documentations for the device and Patch 2 adds device probe for
the module.

Changes v9->v10:
- Rebased to v6.7rc6.
- Dropped unuseful dependency.
- Added error handling.

Changes v8->v9:
- Rebased to v6.7rc4.
- Updated the bindings format.
- Dropped removed() interface.

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
- Renamed the dt-binding 'pwm-starfive.yaml' to 'starfive,jh7110-pwm.yaml=
'.
- Dropped the compatible's Items.
- Dropped the unuse defines.
- Modified the code to follow the Linux coding style.
- Changed return value to dev_err_probe.
- Dropped the unnecessary local variable.

The patch series is based on v6.7rc6.

William Qiu (4):
  dt-bindings: pwm: Add bindings for OpenCores PWM Controller
  pwm: opencores: Add PWM driver support
  riscv: dts: starfive: jh7100: Add PWM node and pins configuration
  riscv: dts: starfive: jh7110: Add PWM node and pins configuration

 .../bindings/pwm/opencores,pwm.yaml           |  55 +++++
 MAINTAINERS                                   |   7 +
 .../boot/dts/starfive/jh7100-common.dtsi      |  24 ++
 arch/riscv/boot/dts/starfive/jh7100.dtsi      |   9 +
 .../jh7110-starfive-visionfive-2.dtsi         |  22 ++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |   9 +
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ocores.c                      | 233 ++++++++++++++++++
 9 files changed, 372 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/opencores,pwm.y=
aml
 create mode 100644 drivers/pwm/pwm-ocores.c

--
2.34.1


