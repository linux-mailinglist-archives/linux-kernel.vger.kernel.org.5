Return-Path: <linux-kernel+bounces-14592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E47821F58
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DBF2823A9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAC914F9B;
	Tue,  2 Jan 2024 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="Wf2zKLMs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F5414F61;
	Tue,  2 Jan 2024 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1704212151; bh=/yn+BnszyZ+KRHVcYDAKoJNyr3kCxWnTqCINmt8R93U=;
	h=From:Subject:Date:To:Cc:From;
	b=Wf2zKLMsn4n0KvBqpBNjqoFONc95QW5n6P8pkUnUfJyBoDgdy3x0bc737NqQHZMz4
	 K+bYV2R4xA4XmDF/mILdboHU5RMASwJGvDOZGyRs1Kgd5f2c1/6p9h0+i9kAR7A/e6
	 TbHI6JxjB5M7Ob1BT2dD1+6jrQ9I6o2m92qtlJE2KZwR15kvDOqKmwxOaAdR8QWAFo
	 9DAZWeE9FtGOHkDGT1hO4KmwpuYeYIF3Dj+qQmcVa4tpcUW0+TjtfbDrhlGECMi3a2
	 NinS2pGGaclfiZeg7QkmbkMw4kxZ+Nr974Ul63QWbm6Uc396Yw2ZgVS4OqWMUH6dlH
	 nPq32xyOlE/lQ==
Received: from arthur.fritz.box (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id 5904A377C52;
	Tue,  2 Jan 2024 17:15:51 +0100 (CET)
From: Manuel Traut <manut@mecka.net>
Subject: [PATCH v3 0/4] arm64: rockchip: Pine64 PineTab2 support
Date: Tue, 02 Jan 2024 17:15:43 +0100
Message-Id: <20240102-pinetab2-v3-0-cb1aa69f8c30@mecka.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK82lGUC/22MQQ6CMBBFr0JmbU1nqkBccQ/jotCpTIxAWtJoC
 He3sGLh8s389xaIHIQj3IoFAieJMg4ZzKmArrfDk5W4zECaDBKRmmTg2bakvLVVxRpdW3rI8ym
 wl8+euj8y9xLnMXz3csLt+ieSUGnFeKlt5UtsHTZv7l72nN+wRRIdRXMQaRM7rK+l09poPorru
 v4AlRdRPdkAAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sandy Huang <hjc@rock-chips.com>, Mark Yao <markyao0591@gmail.com>, 
 Diederik de Haas <didi.debian@cknow.org>, 
 Segfault <awarnecke002@hotmail.com>, Arnaud Ferraris <aferraris@debian.org>, 
 Danct12 <danct12@riseup.net>, Ondrej Jirman <megi@xff.cz>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Manuel Traut <manut@mecka.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4

This adds support for the BOE TH101MB31IG002 LCD Panel used in PineTab2 [1] and
PineTab-V [2] as well as the devictrees for the PineTab2 v0.1 and v2.0.

The BOE LCD Panel patch was retrieved from [3]. The function-name prefix has
been adapted and the LCD init section was simplified.

The PineTab2 devicetree patch was retrieved from [4]. Some renaming was needed
to pass the dtb-checks, the brightness-levels are specified as range and steps
instead of a list of values.

[5] and [6] was also used as source for this queue.

[1] https://wiki.pine64.org/wiki/PineTab2
[2] https://wiki.pine64.org/wiki/PineTab-V
[3] https://salsa.debian.org/Mobian-team/devices/kernels/rockchip-linux/-/blob/mobian-6.6/debian/patches/display/0018-drm-panel-add-BOE-TH101MB31IG002-28A-driver.patch?ref_type=heads
[4] https://salsa.debian.org/Mobian-team/devices/kernels/rockchip-linux/-/blob/mobian-6.6/debian/patches/device-tree/0134-arch-arm64-add-Pine64-PineTab2-device-trees.patch?ref_type=heads
[5] https://github.com/dreemurrs-embedded/linux-pinetab2/tree/v6.6.7-danctnix1
[6] https://xff.cz/git/linux?h=pt2-6.7

Signed-off-by: Manuel Traut <manut@mecka.net>
---
Changes in v3:
- PineTab2 dts:
    * Remove useless regulator-state-mem nodes for fixed regulators
    * Swap mmc0 and mmc1, so mmc0 is now the internal eMMC
- BOE TH101MB31IG002 LCD Panel:
    * Remove enabled/prepared checks since they are done in core.
- Use consistent naming (PineTab2 and PineTab-V) in commit messages.
- Link to v2: https://lore.kernel.org/r/20231223-pinetab2-v2-0-ec1856d0030e@mecka.net

Changes in v2:
- Removed dtb-checker fixups, cause I am not sure if they are correct
- Applied review comments for dt bindings
- pinetab2 dts:
    * Remove unverified WLAN entries, as in [5]
    * Simplify flash LED definition, as in [5]
    * Fix headphone detection and sound routing, as in [5]
    * Fix CRU clock configuration
- BOE TH101MB31IG002 LCD Panel:
    * Reworked prepare/enable unprepare/disable, as in [5]
- Replaced nicknames by realnames in author and signed-offs

- Link to v1: https://lore.kernel.org/r/20231222-pinetab2-v1-0-e148a7f61bd1@mecka.net

---
Alexander Warnecke (2):
      drm/panel: Add driver for BOE TH101MB31IG002-28A panel
      arm64: dts: rockchip: Add devicetree for Pine64 PineTab2

Manuel Traut (2):
      dt-bindings: display: panel: Add BOE TH101MB31IG002-28A panel
      dt-bindings: arm64: rockchip: Add Pine64 PineTab2

 .../devicetree/bindings/arm/rockchip.yaml          |   8 +
 .../display/panel/boe,th101mb31ig002-28a.yaml      |  58 ++
 arch/arm64/boot/dts/rockchip/Makefile              |   2 +
 .../boot/dts/rockchip/rk3566-pinetab2-v0.1.dts     |  26 +
 .../boot/dts/rockchip/rk3566-pinetab2-v2.0.dts     |  46 +
 arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi  | 959 +++++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                      |  11 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 .../gpu/drm/panel/panel-boe-th101mb31ig002-28a.c   | 322 +++++++
 9 files changed, 1433 insertions(+)
---
base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
change-id: 20231222-pinetab2-faa77e01db6f

Best regards,
-- 
Manuel Traut <manut@mecka.net>


