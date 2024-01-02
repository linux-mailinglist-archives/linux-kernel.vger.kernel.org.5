Return-Path: <linux-kernel+bounces-14183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1BD8218DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3C51C2175F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E015A6AD7;
	Tue,  2 Jan 2024 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="rt4YQJaf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0A163A6;
	Tue,  2 Jan 2024 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 8A7384CEFB;
	Tue,  2 Jan 2024 10:19:17 +0100 (CET)
Received: from [192.168.10.46] (unknown [130.180.211.218])
	(Authenticated sender: daniel.lezcano@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPA id 214A8B00579;
	Tue,  2 Jan 2024 10:18:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1704187150;
	bh=YRUoYjKW8wgPvfkaSvYp4j0kKMDfeM6Fj+lD91OGM74=;
	h=Date:To:Cc:From:Subject:From;
	b=rt4YQJafE5g+ceEXg/ahxqubhvkCht+UuaL0/xhW5s2ysQg8jFDATA8HRC6TmbjTR
	 OF3nUO3aQguhBNf9gDT/oehdw4t1pT0wu+Za1cj0JLJqZ6Whw7Kr9OSrxss74i/5Mv
	 bAVyJULvhuQj76KT0jrXr6PoQ55B6p7uGe9wkh35ck1XPDkP0bQeNCydYKV4bm4WWq
	 kFY4UInNuClPDQzNAfp9MlB3OxnltdJvdai2DIfZHMp2gdtsoDjiqYwcinka7e1R6W
	 WepBMnDoJs/nEYPh2k/tthkbuhtHzjj0Hnr6So6P5F0n+R0LYlUaHwP20mtE3A2KXw
	 2NnaRryztU/2Q==
Message-ID: <7163da4d-3f73-490c-a387-04d82e8bee1b@free.fr>
Date: Tue, 2 Jan 2024 10:18:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Binbin Zhou <zhoubb.aaron@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Fabio Estevam
 <festevam@denx.de>, Johan Hovold <johan+linaro@kernel.org>,
 Florian Eckert <fe@dev.tdt.de>, Mateusz Majewski <m.majewski2@samsung.com>
From: Daniel Lezcano <daniel.lezcano@free.fr>
Subject: [GIT PULL] thermal material for v6.8-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

happy new year 2024!

Please consider pulling these thermal changes.

Thanks

   -- Daniel

The following changes since commit 5f70413a85056db04050604a76b52e3f39a37f21:

   thermal: cpuidle_cooling: fix kernel-doc warning and a spello 
(2023-12-21 12:05:48 +0100)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.8-rc1

for you to fetch changes up to 5314b1543787e6cd5d248186fcfd5c5fc4ca2146:

   thermal/drivers/exynos: Use set_trips ops (2024-01-02 09:33:19 +0100)

----------------------------------------------------------------
- Converted Mediatek Thermal to the json-schema (Rafał Miłecki)

- Fixed DT bindings issue on Loongson (Binbin Zhou)

- Fixed returning NULL instead of -ENODEV on Loogsoo (Binbin Zhou)

- Added the DT binding for the tsens on SM8650 platform (Neil Armstrong)

- Added a reboot on critical option feature (Fabio Estevam)

- Made usage of DEFINE_SIMPLE_DEV_PM_OPS on AmLogic (Uwe Kleine-König)

- Added the D1/T113s THS controller support on Sun8i (Maxim Kiselev)

- Fixed example in the DT binding for QCom SPMI (Johan Hovold)

- Fixed compilation warning for the tmon utility (Florian Eckert)

- Added interrupt based configuration on Exynos along with a set of
   related cleanups (Mateusz Majewski)

----------------------------------------------------------------
Binbin Zhou (2):
       dt-bindings: thermal: loongson,ls2k-thermal: Fix binding check issues
       drivers/thermal/loongson2_thermal: Fix incorrect PTR_ERR() judgment

Fabio Estevam (4):
       dt-bindings: thermal-zones: Document critical-action
       thermal/core: Prepare for introduction of thermal reboot
       reboot: Introduce thermal_zone_device_critical_reboot()
       thermal/thermal_of: Allow rebooting after critical temp

Florian Eckert (1):
       tools/thermal/tmon: Fix compilation warning for wrong format

Johan Hovold (2):
       dt-bindings: thermal: qcom-spmi-adc-tm5/hc: Fix example node names
       dt-bindings: thermal: qcom-spmi-adc-tm5/hc: Clean up examples

Mateusz Majewski (9):
       thermal/drivers/exynos: Remove an unnecessary field description
       thermal/drivers/exynos: Drop id field
       thermal/drivers/exynos: Wwitch from workqueue-driven interrupt 
handling to threaded interrupts
       thermal/drivers/exynos: Handle devm_regulator_get_optional return 
value correctly
       thermal/drivers/exynos: Simplify regulator (de)initialization
       thermal/drivers/exynos: Stop using the threshold mechanism on 
Exynos 4210
       thermal/drivers/exynos: Split initialization of TMU and the 
thermal zone
       thermal/drivers/exynos: Use BIT wherever possible
       thermal/drivers/exynos: Use set_trips ops

Maxim Kiselev (2):
       dt-bindings: thermal: sun8i: Add binding for D1/T113s THS controller
       thermal/drivers/sun8i: Add D1/T113s THS controller support

Neil Armstrong (1):
       dt-bindings: thermal: qcom-tsens: document the SM8650 Temperature 
Sensor

Rafał Miłecki (1):
       dt-bindings: thermal: convert Mediatek Thermal to the json-schema

Uwe Kleine-König (2):
       thermal: amlogic: Make amlogic_thermal_disable() return void
       thermal: amlogic: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions

  .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml |   7 +-
  .../bindings/thermal/loongson,ls2k-thermal.yaml    |  10 +-
  .../bindings/thermal/mediatek,thermal.yaml         |  99 ++++
  .../bindings/thermal/mediatek-thermal.txt          |  52 --
  .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml      |   8 +-
  .../bindings/thermal/qcom-spmi-adc-tm5.yaml        |  16 +-
  .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
  .../devicetree/bindings/thermal/thermal-zones.yaml |  16 +
  drivers/thermal/amlogic_thermal.c                  |  19 +-
  drivers/thermal/loongson2_thermal.c                |   2 +-
  drivers/thermal/samsung/exynos_tmu.c               | 529 
+++++++++++----------
  drivers/thermal/sun8i_thermal.c                    |  13 +
  drivers/thermal/thermal_core.c                     |  21 +-
  drivers/thermal/thermal_core.h                     |   1 +
  drivers/thermal/thermal_of.c                       |   6 +
  include/linux/reboot.h                             |  12 +-
  kernel/reboot.c                                    |  34 +-
  tools/thermal/tmon/tui.c                           |   2 +-
  18 files changed, 491 insertions(+), 357 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
  delete mode 100644 
Documentation/devicetree/bindings/thermal/mediatek-thermal.txt


