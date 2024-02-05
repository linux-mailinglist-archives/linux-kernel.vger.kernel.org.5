Return-Path: <linux-kernel+bounces-52922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 083AB849E68
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65B9CB28D01
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626E232C8E;
	Mon,  5 Feb 2024 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D84BQlaZ"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE5D2E641;
	Mon,  5 Feb 2024 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147312; cv=none; b=KhaJ+SDCcrnaf9Ddxeoy6YULZHllWvGUAgImVekCccb97s7Keublln8z0O81ZvmY3kIwMC8dVpFlAmFKyRKqbCRi2rM7Zvluvy6MZ7IWLaRbzixlys8AxOARmVgA15HMs0teBJeNp87JguluoG7tr7Ro44SiDxSOz3fXCFDqBWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147312; c=relaxed/simple;
	bh=dd9mDqYdVYkNoCFCeBGsNVSw5yG/dGVzdboxQqAfnxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jzBdTTH8kAzHEsleEdDxOvC98v//DAwfTIWDwj9rmxGGadbV7EDseqLvLnH4HvMQdUqnJi6YhLgD9i1goSkT3XwoHZouPuAISSlVmWmg/JE0PMEy0wqsA8QPyyPUhaxyzpcAZkgnwqI9OlGMBzEZLPqrOMoaWXUm4Rk0ILvMLu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D84BQlaZ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52CFC1C0003;
	Mon,  5 Feb 2024 15:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707147307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E8uq9xiakI8r5DSAEMiVTdHGIi8/1Hol1k4YnCkMi94=;
	b=D84BQlaZEYkXSv6GhU2OenFN1VHvJx7vtW5hQCPdi34qF1yMwqziEiI6MxctKukcukhS51
	rnbZHwk315agNhRBwz52z+nCXnMN3C8X2JCwmku/qMH0nq58xwtHGu7RFVFIyCN6cvKoSe
	SkkWQYVBEmODvykAbFZutpVzLT4BNSDvKJ6nNpY/92I4bXzKe5WkLuzdM22NFANDOlwUHx
	75w0CcmVeujGxSohP7DYr5oJGuOHGkXdiHdnJ1bMHDqYukdT2pllVO1qoeZxgWOZUSzr1z
	s1uksY/5YcJqGGZAZS7poydmCafl9pezTU1KGcS0AHN1uj6Z5/Rvva14UVwNbA==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Paul Burton <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir  Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v7 00/14] Add support for the Mobileye EyeQ5 SoC
Date: Mon,  5 Feb 2024 16:34:46 +0100
Message-ID: <20240205153503.574468-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com

Hello,

The EyeQ5 SoC from Mobileye is based on the MIPS I6500 architecture
and features multiple controllers such as the classic UART, I2C, SPI,
as well as CAN-FD, PCIe, Octal/Quad SPI Flash interface, Gigabit
Ethernet, MIPI CSI-2, and eMMC 5.1. It also includes a Hardware
Security Module, Functional Safety Hardware, and MJPEG encoder.

One peculiarity of this SoC is that the physical address of the DDDR
exceeds 32 bits. Given that the architecture is 64 bits, this is not
an issue, but it requires some changes in how the mips64 is currently
managed during boot.

In this seventh version, I removed the OLB related part as it is not
used yet. I have left it to Théo to handle in his series. Another
notable change is the Kconfig modification to remove the selection of
unused configurations.

To build and test the kernel, we need to run the following commands:

make eyeq5_defconfig
make vmlinuz.itb

Changelog:

 v6 -> v7

    - Added reviewed tags from Jiaxun Yang on patches 4 and 11.

    - Removed patch "dt-bindings: mfd: syscon: Document EyeQ5 OLB" as
      it is not used in this series.

    - Removed OLB node as it was not needed yet.

    - Fixed memory node and removed bootargs in dts on patch 11.

    - Modified the configuration selection as suggested by Jiaxun in
      patch 13.

 v5 -> v6:

    - From series v5, patches 1 ("MIPS: Export higher/highest
    relocation functions in uasm") and 3 ("MIPS: genex: Fix
    except_vec_vi for kernel in XKPHYS)" have been removed as "MIPS:
    Allow vectored interrupt handler to reside everywhere for 64bit"
    and "MIPS: Remove unused shadow GPR support from vector irq setup"
    address the same requirement.

    - From series v5, patches 8 to 12 have been removed as they are
    not mandatory to support EyeQ5 SoCs.

    - The 1st patch of series v6 ("MIPS: spaces: Define a couple of
    handy macros") has been modified to add the extra macros
    CKSEG[01]ADDR_OR_64BIT.

    - Patch 3 ("MIPS: Allows relocation exception vectors everywhere")
    is a merge of patches 6 ("MIPS: Refactor mips_cps_core_entry
    implementation) and 7 ("MIPS: Fix cache issue with
    mips_cps_core_entry") from series v5. It has been rewritten to
    reduce the diff stat; the 64-bit fixes have been moved to patch 5
    ("MIPS: cps-vec: Use macros for 64-bit access").

    - Patch 13 ("MIPS: Share generic kernel code with other
    architecture)" is a new one allowing separate platform support in
    the patch ("MIPS: Add support for Mobileye EyeQ5").

 v4 -> v5:

   - Improve commit messages for patch 3, 5, 12 and 13.

   - Fix style in patch 9

   - Really enable SPARSMEM and use correct address in
     board-eyeq5.config in patch 21

 v3 -> v4:

 - Fix build warning in "MIPS: Get rid of CONFIG_NO_EXCEPT_FILL":
   check that we are in 64bit mode before using KSEG0 that exist only
   in this mode.

 - Modify "MIPS: spaces: Define a couple of handy macros" to be
   buildable in 32bit mode.

 - Use correct format specifier to print address in "MIPS: traps: Give
   more explanations if ebase doesn't belong to KSEG0"

 - In "MIPS: generic: Add support for Mobileye EyeQ5",remove
   CONFIG_ZBOOT_LOAD_ADDRESS from board-eyeq5.config, (as well as
   CONFIG_USE_XKPHYS that does not exist anymore) and add
   CONFIG_SPARSEMEM_MANUAL to enable SPARSMEM.

v2 -> v3

 - Added more reviewed-by and acked-by tags

 - Fix sorting for cpus entries in

 - Fix indentation issue in Documentation/devicetree/bindings/mips/mobileye.yaml

 v1 -> v2

 - Added reviewed-by and acked-by tags

 - Fix typos reported

 - In patch 15 use 'img' vendor string instead of mti

 - In patch 16 modify licence

 - In patch 17 give more explanations about the block usage.

 - In patch 18, remove _ in node names, don't use anymore
   CONFIG_BUILTIN_DTB in Makefile, remove macro, modify licence.

 - In patch 19 remove most of the bootargs and only keeps earlycon. I
   also split the memory in 2 part in the device tree.

 - Integrate the series from Jiaxun Yang
   https://lore.kernel.org/linux-mips/20231027221106.405666-1-jiaxun.yang@flygoat.com/

  They are patches 2 to 6 and 8 to 12

  Then I added patch 7 to fix the cache issue visible on the Mobileye
  platform, I also add patch 13 to improve warning message when ebase
  doesn't belong to KSEG0

Regards,

Gregory

Gregory CLEMENT (12):
  MIPS: spaces: Define a couple of handy macros
  MIPS: traps: Give more explanations if ebase doesn't belong to KSEG0
  MIPS: cps-vec: Use macros for 64bits access
  dt-bindings: Add vendor prefix for Mobileye Vision Technologies Ltd.
  dt-bindings: mips: cpus: Sort the entries
  dt-bindings: mips: cpu: Add I-Class I6500 Multiprocessor Core
  dt-bindings: mips: Add bindings for Mobileye SoCs
  MIPS: mobileye: Add EyeQ5 dtsi
  MIPS: mobileye: Add EPM5 device tree
  MIPS: Share generic kernel code with other architecture
  MIPS: Add support for Mobileye EyeQ5
  MAINTAINERS: Add entry for Mobileye MIPS SoCs

Jiaxun Yang (2):
  MIPS: Fix set_uncached_handler for ebase in XKPHYS
  MIPS: Allows relocation exception vectors everywhere

 .../devicetree/bindings/mips/cpus.yaml        |  13 +-
 .../devicetree/bindings/mips/mobileye.yaml    |  32 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  12 +
 arch/mips/Kbuild                              |   1 +
 arch/mips/Kbuild.platforms                    |   1 +
 arch/mips/Kconfig                             |  57 ++++
 arch/mips/boot/dts/Makefile                   |   1 +
 arch/mips/boot/dts/mobileye/Makefile          |   4 +
 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts    |  23 ++
 .../boot/dts/mobileye/eyeq5-fixed-clocks.dtsi | 292 ++++++++++++++++++
 arch/mips/boot/dts/mobileye/eyeq5.dtsi        | 124 ++++++++
 arch/mips/configs/eyeq5_defconfig             | 108 +++++++
 arch/mips/generic/Makefile                    |   6 +-
 arch/mips/include/asm/addrspace.h             |   5 +
 arch/mips/include/asm/mach-generic/spaces.h   |   4 +
 arch/mips/include/asm/mips-cm.h               |   1 +
 arch/mips/include/asm/smp-cps.h               |   4 +-
 arch/mips/kernel/cps-vec.S                    |  54 +---
 arch/mips/kernel/smp-cps.c                    | 171 ++++++++--
 arch/mips/kernel/traps.c                      |   7 +-
 arch/mips/mobileye/Makefile                   |   1 +
 arch/mips/mobileye/Platform                   |  16 +
 arch/mips/mobileye/board-epm5.its.S           |  24 ++
 arch/mips/mobileye/vmlinux.its.S              |  32 ++
 25 files changed, 914 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/mobileye.yaml
 create mode 100644 arch/mips/boot/dts/mobileye/Makefile
 create mode 100644 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
 create mode 100644 arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
 create mode 100644 arch/mips/boot/dts/mobileye/eyeq5.dtsi
 create mode 100644 arch/mips/configs/eyeq5_defconfig
 create mode 100644 arch/mips/mobileye/Makefile
 create mode 100644 arch/mips/mobileye/Platform
 create mode 100644 arch/mips/mobileye/board-epm5.its.S
 create mode 100644 arch/mips/mobileye/vmlinux.its.S

-- 
2.43.0


