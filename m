Return-Path: <linux-kernel+bounces-75431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9635385E899
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345241F2903C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2EB1339BA;
	Wed, 21 Feb 2024 19:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="kTqXVU7H"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0F38527A;
	Wed, 21 Feb 2024 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708545135; cv=none; b=KA7YPxq5+F9rj+lNR05fnMQy/wmmGTy+RFitByR/zDC9Fs6ZjCBH4rOyLVmvg4PgQ9KJpyjFE2xQpDwby36aDpHwvUS2/EoJfJOV6nsS+ZwsFRcIg5/ioB9BUdiC/fGIkR70nTKQ6bVz4jkBdlCHKEvdzFShAIr7V1xPyxV6pdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708545135; c=relaxed/simple;
	bh=T03lXPOlsG4g2IR2S86hxMBh72GdzB2bkB/fgTmlIG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oqifgNwB/ULa8/5bIJMuNezoq+lTNjF2KXp06dxtmrhTMyeIXRkfDw7beBOiHYnvlKDA9DUc9eB4OTsrVTaqd8Gt8UJjwVF9feQ58GdNSRETTaVrA7gTsvQZITMb8BHWCHLpF6yh/FH5AILmQDLoUxIsz4EcDdcPMjpxGTufLOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=kTqXVU7H; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5F5409C4AFC;
	Wed, 21 Feb 2024 14:52:06 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id f7h5hxMpFJtW; Wed, 21 Feb 2024 14:52:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6E9749C4B59;
	Wed, 21 Feb 2024 14:52:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 6E9749C4B59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1708545125; bh=84El8YZEA23jo1PRxQQ+f5wwFQuTQbf/GA9Hwoe3eDU=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=kTqXVU7HM+tOTPwCiR0f15NQFeomiKJwOxw+Xx6yAT5fe4c0j8i2PajCajPdidzAs
	 NAiRc2dEMyb4dEoNX+fK+jeAfLMIhht7tffTzf5DWade2OPrFecOOOvnXjgMEQ6Ehw
	 J2KAfvQRR0HVZsYa7HGwqPMkvOOPmTgd4rIH+2CCQF/5YgA/M7bJBboTHIItfRDgpB
	 BXc0Z+FEaZVok5vd5Dk7Hp5Kzo9elRdwa/huGC9XNdtV1xoIFPmY4TgT98aocH9W+d
	 XybEiNsq+gEOXAniAsgxgDW+SNvmmRNmICym1Vx51C8DBEDBh4y3qwoWc34nE+uKbV
	 NSfIuwQ5G9gLw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Nl1slpRdueOK; Wed, 21 Feb 2024 14:52:05 -0500 (EST)
Received: from pcperry.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 346839C4AFC;
	Wed, 21 Feb 2024 14:52:05 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: mdf@kernel.org
Cc: avandiver@markem-imaje.com,
	bcody@markem-imaje.com,
	Charles Perry <charles.perry@savoirfairelinux.com>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/3] fpga: xilinx-selectmap: add new driver
Date: Wed, 21 Feb 2024 14:50:46 -0500
Message-ID: <20240221195058.1281973-1-charles.perry@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

This patchset adds a new driver for the 7 series FPGA's SelectMAP
interface.

The SelectMAP interface shares a common GPIO protocol with the SPI
interface which is already in the kernel (drivers/fpga/xilinx-spi.c).
The approach proposed in this patchset is to refactor xilinx-spi.c into
xilinx-core.c which would handle the common GPIO protocol. This is then
used to build two drivers, the already existing xilinx-spi.c driver and
a newly added xilinx-selectmap.c driver.

The SelectMAP driver proposed only supports 8 bit mode. This is because
the 16 and 32 bits mode have limitations with regards to compressed
bitstream support as well as introducing endianness considerations.

I'm testing xilinx-selectmap.c on a custom i.MX6 board connected to an
Artix 7 FPGA. Flashing a 913K bitstream takes 0.44 seconds.

Changes since v3: (from Rob Herring review)
 * Fix an error in the DT binding example compatible.
 * Drop the renaming of "prog_b" to "prog" and "init-b" to "init".
   Patches 2 and 3 are removed.

Changes since v2:
 * Inserted patch 2 and 3 which rename "prog_b" and "init-b" into "prog"
   and "init" for the SPI driver.
 * From Krzysztof Kozlowski review's:
   * Use more specific compatible names
   * Remove other missing occurences of the slave word missed in v2.
 * From Xu Yilun review's:
   * Fix vertical whitespace in get_done_gpio().
   * Combine write() and write_one_dummy_byte() together.
   * Eliminate most of the xilinx_core_probe() arguments, the driver
     needs to populate those directly into the xilinx_fpga_core struct.
     Added some documentation to struct xilinx_fpga_core to clarify
     this.
   * Removed typedefs from xilinx-core.h.
   * Moved null checks in xilinx_core_probe() to first patch.
   * Move csi_b and rdwr_b out of xilinx_selectmap_conf as they are not
     used out of the probe function.

Changes since v1: (from Krzysztof Kozlowski review's)
  * Use more conventional names for gpio DT bindings
  * fix example in DT bindings
  * add mc-peripheral-props.yaml to DT bindings
  * fix various formatting mistakes
  * Remove all occurences of the "slave" word.

Charles Perry (3):
  fpga: xilinx-spi: extract a common driver core
  dt-bindings: fpga: xlnx,fpga-selectmap: add DT schema
  fpga: xilinx-selectmap: add new driver

 .../bindings/fpga/xlnx,fpga-selectmap.yaml    |  86 +++++++
 drivers/fpga/Kconfig                          |  12 +
 drivers/fpga/Makefile                         |   2 +
 drivers/fpga/xilinx-core.c                    | 208 +++++++++++++++++
 drivers/fpga/xilinx-core.h                    |  28 +++
 drivers/fpga/xilinx-selectmap.c               |  97 ++++++++
 drivers/fpga/xilinx-spi.c                     | 212 ++----------------
 7 files changed, 446 insertions(+), 199 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-sele=
ctmap.yaml
 create mode 100644 drivers/fpga/xilinx-core.c
 create mode 100644 drivers/fpga/xilinx-core.h
 create mode 100644 drivers/fpga/xilinx-selectmap.c

--
2.43.0

