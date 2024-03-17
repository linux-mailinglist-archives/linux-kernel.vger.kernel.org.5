Return-Path: <linux-kernel+bounces-105379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E7E87DD16
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 12:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C76281654
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 11:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C5C1AACB;
	Sun, 17 Mar 2024 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b="IlRw+Vju"
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFE112E68;
	Sun, 17 Mar 2024 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.87.125.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710676121; cv=none; b=RLhuO/XS/TKX2dBwRjtz3kALv8QcqSIsfh/SY90ta+rZIMx0cfBn7bLTke/gAHDK/ghtGVXbwWRNml9g6UokJXsUMZZqq2Tyb8NhxYQUj2ICPt6ps1jdMdZVO+e8eDzHCbv11hBFMuItBKssnPZMLPzWVYU9FlaTplI9FXY92M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710676121; c=relaxed/simple;
	bh=Xd3HVK9KzLr6UudVs0ql/FdH/WPlFteVyG3/uzLUdPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o5GyuATF+wdknT7yARkhRfkIIW68tYtmANxXH64gonpbmHNcU5BFp+vkZWJrIYAzJisdyoq7bE2EmSuwmePXDokjHa3I3b/ytBQDdrx9sLKvyv/3LSwY6uCHcSsxk2u+bAw5UU9GMAQzsnFefR3qYaapEwg/KdUdjekaFNpqg8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=linux-watchdog.org; spf=pass smtp.mailfrom=linux-watchdog.org; dkim=pass (1024-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b=IlRw+Vju; arc=none smtp.client-ip=185.87.125.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=linux-watchdog.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux-watchdog.org
Received: by www.linux-watchdog.org (Postfix, from userid 500)
	id 714F6409FE; Sun, 17 Mar 2024 12:24:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 714F6409FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
	s=odk20180602; t=1710674677;
	bh=Xd3HVK9KzLr6UudVs0ql/FdH/WPlFteVyG3/uzLUdPQ=;
	h=Date:From:To:Cc:Subject:From;
	b=IlRw+Vjulq7/UpwLcdljtarCO/nackaNnBpp/r/wlOSBoop32/Jw+sZUS8gf4A4F0
	 qZCmsoedikIiOY79unmOuebjznheHMR33mCPqpDp8JCv3VOru0OWceM+mh5k5+7RIT
	 M3TPdm1+utPwb+sTH4/Xoe41fShHPRDteYwZT2js=
Date: Sun, 17 Mar 2024 12:24:37 +0100
From: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ben Wolsieffer <ben.wolsieffer@hefring.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jerry Hoemann <jerry.hoemann@hpe.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
	Minh Le <minh.le.aj@renesas.com>,
	Stanislav Jakubek <stano.jakubek@gmail.com>,
	Varshini Rajendran <varshini.rajendran@microchip.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Yang Xiwen <forbidden405@outlook.com>
Subject: [GIT PULL REQUEST] watchdog - v6.9 release cycle.
Message-ID: <20240317112437.GA9174@www.linux-watchdog.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)

Hi Linus,

Please pull following watchdog changes for the v6.9 release cycle.

This series contains:
* core: Remove usage of the deprecated ida_simple_xx() API
* Add kernel-doc for wdt_set_timeout()
* Add support for R-Car V4M,  StarFive's JH8100 and sam9x7-wdt
* Fixes and small improvements

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.9-rc1

for you to fetch changes up to 6fe5aabf7fc645562faec50c79c7a21a4dd1cab6:

  watchdog: intel-mid_wdt: Get platform data via dev_get_platdata() (2024-03-10 11:14:46 +0100)

----------------------------------------------------------------
linux-watchdog 6.9-rc1 tag

----------------------------------------------------------------
Andy Shevchenko (3):
      watchdog: intel-mid_wdt: Remove unused intel-mid.h
      watchdog: intel-mid_wdt: Don't use "proxy" headers
      watchdog: intel-mid_wdt: Get platform data via dev_get_platdata()

Ben Wolsieffer (1):
      watchdog: stm32_iwdg: initialize default timeout

Christophe JAILLET (1):
      watchdog: core: Remove usage of the deprecated ida_simple_xx() API

Jerry Hoemann (1):
      watchdog/hpwdt: Support Suspend and Resume

Ji Sheng Teoh (3):
      watchdog: starfive: Check pm_runtime_enabled() before decrementing usage counter
      watchdog: starfive: check watchdog status before enabling in system resume
      dt-bindings: watchdog: starfive,jh7100-wdt: Add compatible for JH8100

Kathiravan Thirumoorthy (1):
      watchdog: qcom: fine tune the max timeout value calculation

Minh Le (1):
      dt-bindings: watchdog: renesas-wdt: Add support for R-Car V4M

Stanislav Jakubek (1):
      dt-bindings: watchdog: sprd,sp9860-wdt: convert to YAML

Varshini Rajendran (1):
      dt-bindings: watchdog: sama5d4-wdt: add compatible for sam9x7-wdt

Yang Li (1):
      watchdog: Add kernel-doc for wdt_set_timeout()

Yang Xiwen (2):
      watchdog: sp805_wdt: deassert the reset if available
      dt-bindings: watchdog: arm,sp805: document the reset signal

 .../devicetree/bindings/watchdog/arm,sp805.yaml    |  5 ++
 .../bindings/watchdog/atmel,sama5d4-wdt.yaml       | 12 ++--
 .../devicetree/bindings/watchdog/renesas,wdt.yaml  |  1 +
 .../bindings/watchdog/sprd,sp9860-wdt.yaml         | 64 ++++++++++++++++++++++
 .../devicetree/bindings/watchdog/sprd-wdt.txt      | 19 -------
 .../bindings/watchdog/starfive,jh7100-wdt.yaml     | 40 +++++++++++---
 drivers/watchdog/hpwdt.c                           | 25 +++++++++
 drivers/watchdog/intel-mid_wdt.c                   | 11 +++-
 drivers/watchdog/it87_wdt.c                        |  4 ++
 drivers/watchdog/qcom-wdt.c                        |  7 ++-
 drivers/watchdog/sp805_wdt.c                       |  8 +++
 drivers/watchdog/starfive-wdt.c                    | 14 ++++-
 drivers/watchdog/stm32_iwdg.c                      |  3 +
 drivers/watchdog/watchdog_core.c                   | 17 +++---
 14 files changed, 182 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sprd,sp9860-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/sprd-wdt.txt
----------------------------------------------------------------

Kind regards,
Wim.


