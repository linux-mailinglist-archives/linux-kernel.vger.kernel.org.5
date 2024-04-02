Return-Path: <linux-kernel+bounces-128692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A646A895E46
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04682B21CBF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B82415E5CA;
	Tue,  2 Apr 2024 21:02:33 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE3C15CD70;
	Tue,  2 Apr 2024 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091753; cv=none; b=j0Y+UU/55xc5cNY+/jbMZ6druhhlXYMzUKpgr+t6PWhnlXfhYyWFCljo2/X5K/73uVQwOnlzlKzgSfwA95BZ93F2CyxOBtsdts5gozDEbFXbSa+H9vE+kpGzGQaxeWdYqEnZHXwqPwZuV0BNWR54Li0ZNH0vtwlIqX4OACNG0Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091753; c=relaxed/simple;
	bh=Cp6he2a9UqGtuTFmWoNQN/jdehjR6aFt3myxO5A9QFw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WeJSlPagZkGgeVqWLw01VCW0UdoQxgpXfai6b9eopd3Y09ss0QSrcy1WylnleKYWtLcmSorXV3ehALGxQLa0vYw1hTE8gsbaTG3nVXYSUmA9V88kgifagma859nWc5OqEN4/6ry8xoZdZ5xUQdkY+Hg2clJC0vtIbzGog7GXNGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 562B986C4F;
	Tue,  2 Apr 2024 22:55:46 +0200 (CEST)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH v9 0/9] Initial Marvell PXA1908 support
Date: Tue, 02 Apr 2024 22:55:36 +0200
Message-Id: <20240402-pxa1908-lkml-v9-0-25a003e83c6f@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMhwDGYC/4XOTU7DMBAF4KtUXuNoxuNfVtwDsXCSCTFNmyqBq
 KjK3XErFYJZsHwjfW/eRcw8JZ7F4+4iJl7SnMZjDuFhJ5o+Hl9ZpjZnoUAReCB5OkcM4OWwPwz
 SegL2bdSmcSKT08RdOt/qnl9y7tP8Pk6ft/aFrtd7kf5dtJAE6Vn7ronkIISneT8OXPWTuPYs6
 sc65dCqAKGyQChRth9vXB1SXjsuqSkgbiEqBNCqUmjI/Cf1dq4r5uo8t6nJu9ZRrY0qrNlYVIU
 12UbTGgzkmEkX1n5bBITC2mxr1TEEpaHpfGH93WrAP9Zn23F01kcTtNv+Xdf1C43GUMgKAgAA
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Haojian Zhuang <haojian.zhuang@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Lubomir Rintel <lkundrak@v3.sk>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Rob Herring <robh@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6513;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=Cp6he2a9UqGtuTFmWoNQN/jdehjR6aFt3myxO5A9QFw=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBmDHDNz3Ul+t4J4tg3Rbu6M0zFR2ZCjyilQD2P0
 vjcqOZCmJaJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZgxwzQAKCRCaEZ6wQi2W
 4bKhD/wM1CcdHtjGi4TWvgVLtGWSLV2bnD6KXuzsWYbUcDkO483IGjqGIn1P3lM0yA0+orgYoIg
 I5uLhipAGHTAMI8kzGs8C1kMPUAQpKrite2HDNAbeOcGdRuPh4sKvXkRUrGbOq8CTOiZyfSdCip
 v+uCEQ7zEj2uizugwlpRLBnPvUU67gevrDlQUs9iJXE9rMJQGih9UFP9EUtMYU2Twslf36zoFKL
 fRqFmmkp2bQrBPSnTOfa9jv8lrXyD9cOodI+InykUPKY5/1KzzAcB2WA5OeDNUI9WOYgWcrdwVf
 yqpzemBltLr6ewueLEf9BtggobW2WNx1E42q6Twk1s5LFmpb1rZo6hUGSrihWISHv//heONysaD
 EiAxhlVxenrxi9cXebzYSg0IDHrqEsUF4KW0jXL19SNwEviEHFAfTVUwXYaexiUb6n6GrylUPDX
 f7uuet6RlT0OhbmAOkF3m+yO3Gkyi9yACn6yV9AJp/8vVQ0iQQ5UvNHNFHswtiw0bsfjEs2Q1cR
 O8oYH5Zzrdjdxw0/GN1YxnGpG3yfs4dZAsHy9EgJ+zlWpLBlYib8IaSpZ4HRVw+4Er1/u1i4I7c
 f+UHtJWQEUdeB/94aFkaS57rV5eSGz26DCoxuPZH4FbbsOrgq6P3ulkqerV3PvBFRi/KBZrcG5u
 yqBclxxE6cPbfLg==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Hello,

This series adds initial support for the Marvell PXA1908 SoC and
"samsung,coreprimevelte", a smartphone using the SoC.

USB works and the phone can boot a rootfs from an SD card, but there are
some warnings in the dmesg:

During SMP initialization:
[    0.006519] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU1: 0x00000000000000
[    0.006542] CPU features: Unsupported CPU feature variation detected.
[    0.006589] CPU1: Booted secondary processor 0x0000000001 [0x410fd032]
[    0.010710] Detected VIPT I-cache on CPU2
[    0.010716] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU2: 0x00000000000000
[    0.010758] CPU2: Booted secondary processor 0x0000000002 [0x410fd032]
[    0.014849] Detected VIPT I-cache on CPU3
[    0.014855] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU3: 0x00000000000000
[    0.014895] CPU3: Booted secondary processor 0x0000000003 [0x410fd032]

SMMU probing fails:
[    0.101798] arm-smmu c0010000.iommu: probing hardware configuration...
[    0.101809] arm-smmu c0010000.iommu: SMMUv1 with:
[    0.101816] arm-smmu c0010000.iommu:         no translation support!

A 3.14 based Marvell tree is available on GitHub
acorn-marvell/brillo_pxa_kernel, and a Samsung one on GitHub
CoderCharmander/g361f-kernel.

Andreas Färber attempted to upstream support for this SoC in 2017:
https://lore.kernel.org/lkml/20170222022929.10540-1-afaerber@suse.de/

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>

Changes in v9:
- Update trailers and rebase on v6.9-rc2, no changes
- Link to v8: https://lore.kernel.org/20240110-pxa1908-lkml-v8-0-fea768a59474@skole.hr

Changes in v8:
- Drop SSPA patch
- Drop broken-cd from eMMC node
- Specify S-Boot hardcoded initramfs location in device tree
- Add ARM PMU node
- Correct inverted modem memory base and size
- Update trailers
- Rebase on next-20240110
- Link to v7: https://lore.kernel.org/20231102-pxa1908-lkml-v7-0-cabb1a0cb52b@skole.hr
  and https://lore.kernel.org/20231102152033.5511-1-duje.mihanovic@skole.hr

Changes in v7:
- Suppress SND_MMP_SOC_SSPA on ARM64
- Update trailers
- Rebase on v6.6-rc7
- Link to v6: https://lore.kernel.org/r/20231010-pxa1908-lkml-v6-0-b2fe09240cf8@skole.hr

Changes in v6:
- Address maintainer comments:
  - Add "marvell,pxa1908-padconf" binding to pinctrl-single driver
- Drop GPIO patch as it's been pulled
- Update trailers
- Rebase on v6.6-rc5
- Link to v5: https://lore.kernel.org/r/20230812-pxa1908-lkml-v5-0-a5d51937ee34@skole.hr

Changes in v5:
- Address maintainer comments:
  - Move *_NR_CLKS to clock driver from dt binding file
- Allocate correct number of clocks for each block instead of blindly
  allocating 50 for each
- Link to v4: https://lore.kernel.org/r/20230807-pxa1908-lkml-v4-0-cb387d73b452@skole.hr

Changes in v4:
- Address maintainer comments:
  - Relicense clock binding file to BSD-2
- Add pinctrl-names to SD card node
- Add vgic registers to GIC node
- Rebase on v6.5-rc5
- Link to v3: https://lore.kernel.org/r/20230804-pxa1908-lkml-v3-0-8e48fca37099@skole.hr

Changes in v3:
- Address maintainer comments:
  - Drop GPIO dynamic allocation patch
  - Move clock register offsets into driver (instead of bindings file)
  - Add missing Tested-by trailer to u32_fract patch
  - Move SoC binding to arm/mrvl/mrvl.yaml
- Add serial0 alias and stdout-path to board dts to enable UART
  debugging
- Rebase on v6.5-rc4
- Link to v2: https://lore.kernel.org/r/20230727162909.6031-1-duje.mihanovic@skole.hr

Changes in v2:
- Remove earlycon patch as it's been merged into tty-next
- Address maintainer comments:
  - Clarify GPIO regressions on older PXA platforms
  - Add Fixes tag to commit disabling GPIO pinctrl calls for this SoC
  - Add missing includes to clock driver
  - Clock driver uses HZ_PER_MHZ, u32_fract and GENMASK
  - Dual license clock bindings
  - Change clock IDs to decimal
  - Fix underscores in dt node names
  - Move chosen node to top of board dts
  - Clean up documentation
  - Reorder commits
  - Drop pxa,rev-id
- Rename muic-i2c to i2c-muic
- Reword some commits
- Move framebuffer node to chosen
- Add aliases for mmc nodes
- Rebase on v6.5-rc3
- Link to v1: https://lore.kernel.org/r/20230721210042.21535-1-duje.mihanovic@skole.hr

---
Andy Shevchenko (1):
      clk: mmp: Switch to use struct u32_fract instead of custom one

Duje Mihanović (8):
      dt-bindings: pinctrl: pinctrl-single: add marvell,pxa1908-padconf compatible
      pinctrl: single: add marvell,pxa1908-padconf compatible
      dt-bindings: clock: Add Marvell PXA1908 clock bindings
      clk: mmp: Add Marvell PXA1908 clock driver
      dt-bindings: marvell: Document PXA1908 SoC
      arm64: Kconfig.platforms: Add config for Marvell PXA1908 platform
      arm64: dts: Add DTS for Marvell PXA1908 and samsung,coreprimevelte
      MAINTAINERS: add myself as Marvell PXA1908 maintainer

 .../devicetree/bindings/arm/mrvl/mrvl.yaml         |   5 +
 .../devicetree/bindings/clock/marvell,pxa1908.yaml |  48 +++
 .../bindings/pinctrl/pinctrl-single.yaml           |   4 +
 MAINTAINERS                                        |   9 +
 arch/arm64/Kconfig.platforms                       |   8 +
 arch/arm64/boot/dts/marvell/Makefile               |   3 +
 .../dts/marvell/pxa1908-samsung-coreprimevelte.dts | 336 +++++++++++++++++++++
 arch/arm64/boot/dts/marvell/pxa1908.dtsi           | 304 +++++++++++++++++++
 drivers/clk/mmp/Makefile                           |   2 +-
 drivers/clk/mmp/clk-frac.c                         |  57 ++--
 drivers/clk/mmp/clk-of-mmp2.c                      |  26 +-
 drivers/clk/mmp/clk-of-pxa168.c                    |   4 +-
 drivers/clk/mmp/clk-of-pxa1908.c                   | 328 ++++++++++++++++++++
 drivers/clk/mmp/clk-of-pxa1928.c                   |   6 +-
 drivers/clk/mmp/clk-of-pxa910.c                    |   4 +-
 drivers/clk/mmp/clk.h                              |  10 +-
 drivers/pinctrl/pinctrl-single.c                   |   1 +
 include/dt-bindings/clock/marvell,pxa1908.h        |  88 ++++++
 18 files changed, 1186 insertions(+), 57 deletions(-)
---
base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
change-id: 20230803-pxa1908-lkml-6830e8da45c7

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>



