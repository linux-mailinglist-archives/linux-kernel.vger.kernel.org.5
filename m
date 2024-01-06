Return-Path: <linux-kernel+bounces-18587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FC6825FC3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E741C211F1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9D07483;
	Sat,  6 Jan 2024 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b="XDlqgqcS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AA48C0A;
	Sat,  6 Jan 2024 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=linux-watchdog.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux-watchdog.org
Received: by www.linux-watchdog.org (Postfix, from userid 500)
	id 0A668409F1; Sat,  6 Jan 2024 14:44:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 0A668409F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
	s=odk20180602; t=1704548667;
	bh=3wXHJ5X0Y/5UXPZ+cSSBwup9eb5KfXFSoUe6hAGQfEo=;
	h=Date:From:To:Cc:Subject:From;
	b=XDlqgqcSKAuuaZtp6IM02qFkinnhHJF/rqpkVnrrDx3gvW9VkcYdbqnOSibkYCXQi
	 uSlrZF1s0ShjcvtdK531vxgDACVcojL77mchveENsuyHw5WeaD5PmMQmb4IKx06Fqp
	 WlEJZ07DbYDHQcqh7bHFgqhUhJbAm5LjNBq9GuKk=
Date: Sat, 6 Jan 2024 14:44:11 +0100
From: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Curtis Klein <curtis.klein@hpe.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Douglas Anderson <dianders@chromium.org>,
	Jerry Hoemann <jerry.hoemann@hpe.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Nik Bune <n2h9z4@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Werner Fischer <devlists@wefi.net>
Subject: [GIT PULL REQUEST] watchdog - v6.8 release cycle.
Message-ID: <20240106134410.GA19394@www.linux-watchdog.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.20 (2009-12-10)

Hi Linus,

Please pull following watchdog changes for the v6.8 release cycle (once the window is open :-) ).

This series contains:
* Add Mediatek MT7988 watchdog
* Add IT8659 watchdog
* watchdog: set cdev owner before adding
* hpwdt: Only claim UNKNOWN NMI if from iLO
* Various other fixes and improvements

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.8-rc1

for you to fetch changes up to 9546b21ea672aa961d5a89ea754214afed013f02:

  watchdog: mlx_wdt: fix all kernel-doc warnings (2023-12-24 10:44:40 +0100)

----------------------------------------------------------------
linux-watchdog 6.8-rc1 tag

----------------------------------------------------------------
Ben Dooks (1):
      watchdog: starfive: add lock annotations to fix context imbalances

Biju Das (2):
      dt-bindings: watchdog: dlg,da9062-watchdog: Add fallback for DA9061 watchdog
      dt-bindings: watchdog: dlg,da9062-watchdog: Document DA9063 watchdog

Curtis Klein (1):
      watchdog: set cdev owner before adding

Daniel Golle (2):
      dt-bindings: watchdog: mediatek,mtk-wdt: add MT7988 watchdog and toprgu
      watchdog: mediatek: mt7988: add wdt support

Douglas Anderson (1):
      dt-bindings: watchdog: qcom-wdt: Make the interrupt example edge triggered

Jerry Hoemann (3):
      watchdog/hpwdt: Only claim UNKNOWN NMI if from iLO
      watchdog/hpwdt: Remove redundant test.
      watchdog/hpwdt: Remove unused variable

Johan Hovold (1):
      dt-bindings: watchdog: qcom,pm8916-wdt: add parent spmi node to example

Krzysztof Kozlowski (2):
      dt-bindings: watchdog: re-order entries to match coding convention
      dt-bindings: watchdog: intel,keembay: reference common watchdog schema

Lukas Bulwahn (1):
      MAINTAINERS: rectify entry for DIALOG SEMICONDUCTOR DRIVERS

Nik Bune (3):
      dt-bindings: watchdog: realtek,rtd1295-watchdog: convert txt to yaml
      dt-bindings: watchdog: qca,ar7130-wdt: convert txt to yaml
      dt-bindings: watchdog: nxp,pnx4008-wdt: convert txt to yaml

Nikita Shubin (1):
      dt-bindings: wdt: Add ts72xx

Randy Dunlap (1):
      watchdog: mlx_wdt: fix all kernel-doc warnings

Stefan Wahren (1):
      watchdog: bcm2835_wdt: Fix WDIOC_SETTIMEOUT handling

Uwe Kleine-König (5):
      watchdog: at91sam9: Stop using module_platform_driver_probe()
      watchdog: txx9: Stop using module_platform_driver_probe()
      watchdog: at91sam9_wdt: Convert to platform remove callback returning void
      watchdog: starfive-wdt: Convert to platform remove callback returning void
      watchdog: txx9wdt: Convert to platform remove callback returning void

Vignesh Raghavendra (1):
      watchdog: rti_wdt: Drop runtime pm reference count when watchdog is unused

Werner Fischer (4):
      watchdog: it87_wdt: add blank line after variable declaration
      watchdog: it87_wdt: Remove redundant max_units setting
      watchdog: it87_wdt: Add IT8659 ID
      watchdog: it87_wdt: Keep WDTCTRL bit 3 unmodified for IT8784/IT8786

 .../bindings/watchdog/allwinner,sun4i-a10-wdt.yaml |  6 +--
 .../bindings/watchdog/alphascale,asm9260-wdt.yaml  |  6 +--
 .../devicetree/bindings/watchdog/apple,wdt.yaml    |  6 +--
 .../devicetree/bindings/watchdog/arm-smc-wdt.yaml  |  6 +--
 .../bindings/watchdog/brcm,bcm7038-wdt.yaml        | 10 ++---
 .../bindings/watchdog/cnxt,cx92755-wdt.yaml        |  6 +--
 .../bindings/watchdog/dlg,da9062-watchdog.yaml     | 12 ++++--
 .../bindings/watchdog/intel,keembay-wdt.yaml       |  5 ++-
 .../bindings/watchdog/maxim,max63xx.yaml           |  8 ++--
 .../bindings/watchdog/mediatek,mtk-wdt.yaml        |  1 +
 .../bindings/watchdog/nxp,pnx4008-wdt.yaml         | 34 ++++++++++++++++
 .../devicetree/bindings/watchdog/pnx4008-wdt.txt   | 17 --------
 .../bindings/watchdog/qca,ar7130-wdt.yaml          | 33 ++++++++++++++++
 .../bindings/watchdog/qca-ar7130-wdt.txt           | 13 -------
 .../bindings/watchdog/qcom,pm8916-wdt.yaml         | 33 +++++++++-------
 .../devicetree/bindings/watchdog/qcom-wdt.yaml     |  2 +-
 .../bindings/watchdog/realtek,rtd119x.txt          | 17 --------
 .../watchdog/realtek,rtd1295-watchdog.yaml         | 38 ++++++++++++++++++
 .../devicetree/bindings/watchdog/snps,dw-wdt.yaml  | 10 ++---
 .../bindings/watchdog/technologic,ts7200-wdt.yaml  | 45 ++++++++++++++++++++++
 MAINTAINERS                                        |  2 +-
 drivers/watchdog/at91sam9_wdt.c                    | 12 +++---
 drivers/watchdog/bcm2835_wdt.c                     |  3 +-
 drivers/watchdog/hpwdt.c                           |  9 +----
 drivers/watchdog/it87_wdt.c                        | 29 ++++++++++----
 drivers/watchdog/mlx_wdt.c                         |  4 +-
 drivers/watchdog/mtk_wdt.c                         | 42 ++++++++++++++++++++
 drivers/watchdog/rti_wdt.c                         | 13 ++++++-
 drivers/watchdog/starfive-wdt.c                    |  8 ++--
 drivers/watchdog/txx9wdt.c                         | 11 +++---
 drivers/watchdog/watchdog_dev.c                    |  3 +-
 31 files changed, 307 insertions(+), 137 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/nxp,pnx4008-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/pnx4008-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/qca,ar7130-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/qca-ar7130-wdt.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/realtek,rtd1295-watchdog.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/technologic,ts7200-wdt.yaml
----------------------------------------------------------------

Kind regards,
Wim.


