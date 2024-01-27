Return-Path: <linux-kernel+bounces-41139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD61483EC6C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A9A1C21DEA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7EB1EB2F;
	Sat, 27 Jan 2024 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="jBbfztp9"
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F911F955;
	Sat, 27 Jan 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.159.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706348926; cv=none; b=dLZ1Hiv8qHburZAzA4vaWA1zG7rYLQ9hFlKoeVlwdfZ0uGvbD5/g5DBQrZHnfWNfRWbmLrMOuDLnnOY/MOX4Ys6JaT/O5ZjYQTwbAoQwBE101ocbJmIQmvh+8z82Cw1NnoSVZBrYJlT0UnxujBinBDeHnM+tKU38Fs+tw1HvfLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706348926; c=relaxed/simple;
	bh=00DmZqyEpDXJ+Q5kUCHk3ZsWcoc+Ik/n4Bym0Re+KiE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i/mJTUTlp3kRgVHgcWk/s3e5kp3bwGNahdwFifVe4EGxfLc6hLaKyzMBNCYRYIgqK8vvY9tYPX1u2ZNEcTC3PeAPREMjV8TRUDsXiBq7JCDSGV2M77+2p0f0DFl8HYghXogH1ug9oV9jHt/IOmlflB/bQ//ohqhD2lm9rVbWPDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net; spf=pass smtp.mailfrom=mecka.net; dkim=fail (0-bit key) header.d=mecka.net header.i=@mecka.net header.b=jBbfztp9 reason="key not found in DNS"; arc=none smtp.client-ip=159.69.159.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1706348923; bh=00DmZqyEpDXJ+Q5kUCHk3ZsWcoc+Ik/n4Bym0Re+KiE=;
	h=From:Subject:Date:To:Cc:From;
	b=jBbfztp9ORHzMWR37x+KZLSzE6IQPCI62bPLbEfC5YovcUzUucgqmpX8Sae7TprVb
	 F+YIGFsP1r2+SlUOmK9RzDDQvrHW01tC25Cw0F8+Jxv864v/MMNHzA8kmCIg4oz0ea
	 ygnPjnEXmdP0/mnq6z9vLwJBFaPdz6KDfaLUlQowGExsNUbzeDCSEviJE8zLo1VTrt
	 J9EtSk5kyzbGGBa8QcMMKRKfGv/lie4dPxhlpWo/QLs6AKBlsk/dTjlrePhUHQ6PWf
	 j5UEFRA0g6uEZ+Z1rmbZIjmd277ouDcyDP2XqjR0Vf5K98gmz+mJefOMGV721QwfuD
	 SALZ4IPR7beeA==
Received: from arthur.fritz.box (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id DCDF53BF7A4;
	Sat, 27 Jan 2024 10:48:42 +0100 (CET)
From: Manuel Traut <manut@mecka.net>
Subject: [PATCH v4 0/4] arm64: rockchip: Pine64 PineTab2 support
Date: Sat, 27 Jan 2024 10:48:41 +0100
Message-Id: <20240127-pinetab2-v4-0-37aab1c39194@mecka.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHnRtGUC/22NSwrCMBBAryJZG5lJaltdeQ9xkc/EBrEtSQlK6
 d1NC0IQl29m3puZRQqeIjvvZhYo+eiHPkO13zHTqf5O3NvMTICQKITgo+9pUlpwp1TTEKDVtWP
 5fAzk/GtLXW+ZOx+nIby3csJ1+ieSkAMnrFrVuBq1xcuTzEMd8pqtkSRKURaiWEWD7bG2ABLoV
 5RfsQKE8qPMotGoVH1yrZFQisuyfACGowGHEgEAAA==
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
Changes in v4:
- Rebased on v6.8-rc1
- BOE TH101MB31IG002 LCD Panel:
  * Picked patches from https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)
- PineTab2 dts:
  * Make flash-led a regulator-led and control the regulator by GPIO and set
    V5_MIDU as vin-supply to ensure that LED is working even if all other
    drivers using V5 MIDU are unloaded.
  * Add -regulator suffix to nodes, replace -con suffix by -connector
  * Set lcd pinctrl in .dts instead of .dtsi so it is more clear that this is
    different between pinetab v0.1 and v2.0
  * Remove unused bluetooth uart configuration and pinctrl
  * Increase spi-nor max-speed from 24 to 100 MHz
- Link to v3: https://lore.kernel.org/r/20240102-pinetab2-v3-0-cb1aa69f8c30@mecka.net

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
Alexander Warnecke (1):
      drm/panel: Add driver for BOE TH101MB31IG002-28A panel

Manuel Traut (3):
      dt-bindings: display: panel: Add BOE TH101MB31IG002-28A panel
      dt-bindings: arm64: rockchip: Add Pine64 PineTab2
      arm64: dts: rockchip: Add devicetree for Pine64 PineTab2

 .../devicetree/bindings/arm/rockchip.yaml          |   8 +
 .../display/panel/boe,th101mb31ig002-28a.yaml      |  58 ++
 arch/arm64/boot/dts/rockchip/Makefile              |   2 +
 .../boot/dts/rockchip/rk3566-pinetab2-v0.1.dts     |  28 +
 .../boot/dts/rockchip/rk3566-pinetab2-v2.0.dts     |  48 ++
 arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi  | 943 +++++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                      |  11 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 .../gpu/drm/panel/panel-boe-th101mb31ig002-28a.c   | 322 +++++++
 9 files changed, 1421 insertions(+)
---
base-commit: 3a5879d495b226d0404098e3564462d5f1daa33b
change-id: 20231222-pinetab2-faa77e01db6f

Best regards,
-- 
Manuel Traut <manut@mecka.net>


