Return-Path: <linux-kernel+bounces-125421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8134D8925BC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1A92B22292
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FC113CC73;
	Fri, 29 Mar 2024 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="l9SKmEPd"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F761E525;
	Fri, 29 Mar 2024 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745960; cv=none; b=H6ET4jDEqIAQ/zIdm9ynqjJuo+3kvz6bk+YrA7E4mMW6nuPqXVMkhnvJvOx9XORNhU1o6C3I2fMvgrD0ZQ6qxv9onuTFLN+9/s6vacyNZ/H6OZ7v2UE5cvQaiH0FJACSL08cQ3OCbP7i9VXJhF1SIk2sMseW3e79cuVQtn8MIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745960; c=relaxed/simple;
	bh=YWAC2wA+Kd+qKnhUcgXMYIYrKor/44A1/U+fkl2ef5g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U2ahPocGzyCasfoiSh++TnrhRwNW0DrudfbTz49rnNHmqFplQg19HGeUVRr6Ym+cE3VmN5AkQIwiJ0RTsKaOrir23AREmCZM+CvgEqe7Ti6qLwbct3IV79uV9mDi60r74JRUtAdXEY2DWl19pidtVuKh4E5FJ/X2T+LMzSXkRpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=l9SKmEPd; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 45A46120013;
	Fri, 29 Mar 2024 23:59:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 45A46120013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711745953;
	bh=OxJ2dy3C1oN4LgtG/PWU8dFWty4P+oUQ+lLO4Ynkoeg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=l9SKmEPdpfEI5v2eEmtiOx/ZDPfs7I6pR9soVAYdCj1Mk5MDhqzuZLiz6Oi8W0pR2
	 i0n/kPvapasE/e/0XpdlI/RQ8Zv66aLJDBep9pD5VJyQ43a9bkMNuwYfibLI0xiwmo
	 z0oYYP4oyxikiq2Pb4JGWkOojObgtMdBrmzjgzvjmpyty+g2PM67nj8NJq4kcBN7Dn
	 AvMHfjnN59fq+x8vRUu9dbq55ijlFXSaFkWPLm6LiK5mxoHUAN9sQkdCbpHQZjtfLc
	 95NOZ3GXDAiTDjUbBO/VFGu0RDmkOwUF+3jW5cAUr34sQAvIlcJ/+SHABPVMLj+pWa
	 aW4tEYuVRhM9g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 29 Mar 2024 23:59:13 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 23:59:12 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
Subject: [PATCH v1 0/6] clk: meson: introduce Amlogic A1 SoC Family CPU clock controller driver
Date: Fri, 29 Mar 2024 23:58:40 +0300
Message-ID: <20240329205904.25002-1-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184500 [Mar 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/29 16:52:00 #24511844
X-KSMG-AntiVirus-Status: Clean, skipped

The CPU clock controller plays a general role in the Amlogic A1 SoC
family by generating CPU clocks. As an APB slave module, it offers the
capability to inherit the CPU clock from two sources: the internal fixed
clock known as 'cpu fixed clock' and the external input provided by the
A1 PLL clock controller, referred to as 'syspll'.

It is important for the driver to handle the cpu_clk rate switching
effectively by transitioning to the CPU fixed clock to avoid any
potential execution freezes.

Validation:
* to double-check all clk flags, run the below helper script:

```
pushd /sys/kernel/debug/clk
for f in *; do
    if [[ -f "$f/clk_flags" ]]; then
        flags="$(cat $f/clk_flags | awk '{$1=$1};1' | sed ':a;N;$!ba;s/\n/ | /g')"
        echo -e "$f: $flags"
    fi
done
popd
```

* to trace the current clks state, use the
  '/sys/kernel/debug/clk/clk_dump' node with jq post-processing:

```
$ cat /sys/kernel/debug/clk/clk_dump | jq '.' > clk_dump.json
```

* to see the CPU clock hierarchy, use the
'/sys/kernel/debug/clk/clk_summary' node with jq post-processing:

```
$ cat /sys/kernel/debug/clk/clk_summary | jq '.' > clk_dump.json
```

when cpu_clk is inherited from sys_pll, it should be:

```
syspll_in    1  1  0  24000000    0  0  50000  Y  deviceless                 no_connection_id
  sys_pll    2  2  0  1200000000  0  0  50000  Y  deviceless                 no_connection_id
    cpu_clk  1  1  0  1200000000  0  0  50000  Y  cpu0                       no_connection_id
                                                  cpu0                       no_connection_id
                                                  fd000000.clock-controller  dvfs
                                                  deviceless                 no_connection_id
```

and from cpu fixed clock:

```
fclk_div3_div           1  1  0  512000000  0  0  50000  Y  deviceless                 no_connection_id
  fclk_div3             4  4  0  512000000  0  0  50000  Y  deviceless                 no_connection_id
    cpu_fsource_sel0    1  1  0  512000000  0  0  50000  Y  deviceless                 no_connection_id
      cpu_fsource_div0  1  1  0  128000000  0  0  50000  Y  deviceless                 no_connection_id
        cpu_fsel0       1  1  0  128000000  0  0  50000  Y  deviceless                 no_connection_id
          cpu_fclk      1  1  0  128000000  0  0  50000  Y  deviceless                 no_connection_id
            cpu_clk     1  1  0  128000000  0  0  50000  Y  cpu0                       no_connection_id
                                                            cpu0                       no_connection_id
                                                            fd000000.clock-controller  dvfs
                                                            deviceless                 no_connection_id
```

* to debug cpu clk rate propagation and proper parent switching, compile
  kernel with the following definition:
    $ sed -i "s/undef CLOCK_ALLOW_WRITE_DEBUGFS/define CLOCK_ALLOW_WRITE_DEBUGFS/g" drivers/clk/clk.c
  after that, clk_rate debug node for each clock will be available for
  write operation

Dmitry Rokosov (6):
  dt-bindings: clock: meson: a1: pll: introduce new syspll bindings
  clk: meson: a1: pll: support 'syspll' general-purpose PLL for CPU
    clock
  dt-bindings: clock: meson: a1: peripherals: support sys_pll_div16
    input
  clk: meson: a1: peripherals: support 'sys_pll_div16' clock as GEN
    input
  dt-bindings: clock: meson: add A1 CPU clock controller bindings
  clk: meson: a1: add Amlogic A1 CPU clock controller driver

 .../bindings/clock/amlogic,a1-cpu-clkc.yaml   |  64 ++++
 .../clock/amlogic,a1-peripherals-clkc.yaml    |   5 +-
 .../bindings/clock/amlogic,a1-pll-clkc.yaml   |   7 +-
 drivers/clk/meson/Kconfig                     |  10 +
 drivers/clk/meson/Makefile                    |   1 +
 drivers/clk/meson/a1-cpu.c                    | 324 ++++++++++++++++++
 drivers/clk/meson/a1-cpu.h                    |  16 +
 drivers/clk/meson/a1-peripherals.c            |   4 +-
 drivers/clk/meson/a1-pll.c                    |  78 +++++
 drivers/clk/meson/a1-pll.h                    |   6 +
 .../dt-bindings/clock/amlogic,a1-cpu-clkc.h   |  19 +
 .../dt-bindings/clock/amlogic,a1-pll-clkc.h   |   2 +
 12 files changed, 531 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml
 create mode 100644 drivers/clk/meson/a1-cpu.c
 create mode 100644 drivers/clk/meson/a1-cpu.h
 create mode 100644 include/dt-bindings/clock/amlogic,a1-cpu-clkc.h

-- 
2.43.0


