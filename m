Return-Path: <linux-kernel+bounces-7999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8EA81B069
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DFBA1F23189
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DD618035;
	Thu, 21 Dec 2023 08:36:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DD3171C4;
	Thu, 21 Dec 2023 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 53DC07FFE;
	Thu, 21 Dec 2023 16:36:32 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 16:36:32 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 16:36:25 +0800
From: Alex Soo <yuklin.soo@starfivetech.com>
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>, Hal Feng <hal.feng@starfivetech.com>, "Ley
 Foon Tan" <leyfoon.tan@starfivetech.com>, Jianlong Huang
	<jianlong.huang@starfivetech.com>, Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	"Drew Fustini" <drew@beagleboard.org>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alex Soo <yuklin.soo@starfivetech.com>
Subject: [RFC PATCH 0/6] Add Pinctrl driver for Starfive JH8100 SoC
Date: Thu, 21 Dec 2023 16:36:16 +0800
Message-ID: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Starfive JH8100 SoC consists of 4 pinctrl domains - sys_east,
sys_west, sys_gmac, and aon. This patch series adds pinctrl
drivers for these 4 pinctrl domains and this patch series is
depending on the JH8100 base patch series in [1] and [2].
The relevant dt-binding documentation for each pinctrl domain has
been updated accordingly.

[1] https://lore.kernel.org/lkml/20231201121410.95298-1-jeeheng.sia@starf=
ivetech.com/
[2] https://lore.kernel.org/lkml/20231206115000.295825-1-jeeheng.sia@star=
fivetech.com/

Alex Soo (6):
  dt-bindings: pinctrl: starfive: add JH8100 pinctrl bindings
  pinctrl: starfive: jh8100: add pinctrl driver for sys_east domain
  pinctrl: starfive: jh8100: add pinctrl driver for sys_west domain
  pinctrl: starfive: jh8100: add pinctrl driver for sys_gmac domain
  pinctrl: starfive: jh8100: add pinctrl driver for AON domain
  riscv: dts: starfive: jh8100: add pinctrl device tree nodes

 .../pinctrl/starfive,jh8100-aon-pinctrl.yaml  |  183 +++
 .../starfive,jh8100-sys-east-pinctrl.yaml     |  188 +++
 .../starfive,jh8100-sys-gmac-pinctrl.yaml     |  124 ++
 .../starfive,jh8100-sys-west-pinctrl.yaml     |  188 +++
 MAINTAINERS                                   |    7 +
 arch/riscv/boot/dts/starfive/jh8100-evb.dts   |    5 +
 arch/riscv/boot/dts/starfive/jh8100-pinfunc.h |  418 +++++++
 arch/riscv/boot/dts/starfive/jh8100.dtsi      |   44 +
 drivers/pinctrl/starfive/Kconfig              |   57 +
 drivers/pinctrl/starfive/Makefile             |    6 +
 .../starfive/pinctrl-starfive-jh8100-aon.c    |  241 ++++
 .../pinctrl-starfive-jh8100-sys-east.c        |  326 +++++
 .../pinctrl-starfive-jh8100-sys-gmac.c        |  164 +++
 .../pinctrl-starfive-jh8100-sys-west.c        |  264 ++++
 .../starfive/pinctrl-starfive-jh8100.c        | 1090 +++++++++++++++++
 .../starfive/pinctrl-starfive-jh8100.h        |   85 ++
 .../pinctrl/starfive,jh8100-pinctrl.h         |  303 +++++
 17 files changed, 3693 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh=
8100-aon-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh=
8100-sys-east-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh=
8100-sys-gmac-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh=
8100-sys-west-pinctrl.yaml
 create mode 100644 arch/riscv/boot/dts/starfive/jh8100-pinfunc.h
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100-aon.=
c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-=
east.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-=
gmac.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-=
west.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
 create mode 100644 include/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h


base-commit: ddb42e41c0991b443dd6cc97213b478a7324d72b
--=20
2.25.1


