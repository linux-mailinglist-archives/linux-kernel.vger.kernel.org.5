Return-Path: <linux-kernel+bounces-110722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B70318862E6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406C4286D13
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBA2136996;
	Thu, 21 Mar 2024 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="sAZfLl1A"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ADD132489;
	Thu, 21 Mar 2024 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058775; cv=none; b=QaAZZcElso++Vo8KgwDM3M7wyyfUY+/3aOpjjrwNiK4k1i7qc5Vlw1Gesezz26/1hnzYqb3+A6r21J+kiUSlz+3idRL2dMimh1on1MUdLMQN7zB9VAuib1NMqThQuSkrY4/CkY1izHkdKSHp6Yh5UIEBJ71JDrXos6ojAK2zPNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058775; c=relaxed/simple;
	bh=jCsAdyC1KUA5vKIMMyySgNdeDPLdStRYb2SYcOmbSS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dphE5pAShrf1GaAa+VGfKhEn4uS1i48YCH/QfMV2Y4HAQTeA9YyAvoBcNfvMDlDyrG3/P3ClhflQslZT1XjvDkCSCHZet9zoffGJd8DrGwzF1GYBfQKX4r1ufUSb3zU1umMOOwKyY72FKPINGsR6QhfTUg0XnRt2UBYggbP1XW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=sAZfLl1A; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C0E759C53D6;
	Thu, 21 Mar 2024 18:06:03 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id nvZ0To_hTJnD; Thu, 21 Mar 2024 18:06:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8C5CD9C52E9;
	Thu, 21 Mar 2024 18:06:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 8C5CD9C52E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1711058762; bh=1r3GwkK0c9zs1wbPB3fzzwaH34IaNdvV4R26cOy5fiA=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=sAZfLl1AnVNozQ6iyYB2Qdc1GW14FSA1QscuRbjlufMGhSEj6xfGeABh55pwC8SP7
	 4xOSBwfrpj7L7Eu20jlv2wbaTLrQmof0gIP8MvBx1ekOBZCg3uXTjkBDIPl1wGXzQ1
	 9km//6FG3SIQP1N5GPAJ2PQh0rMW+bdpOMFzWIcpgARdg7x0Skj8OVXgSbiteNKil4
	 cUrgbAQEstR2nDI5yG0oRhCj0I5ZmfMt4AVnPucJBLOEWOFIlxNv8t1YMko1nvV52z
	 5ImS3cp122Jg0GKCHMfL2La+S5hHSWPU1rMWPRUwOlgies9OOMK8wf+/IgVBN/ptUU
	 rOJHAscDb4zsA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id PVetQC4MblrT; Thu, 21 Mar 2024 18:06:02 -0400 (EDT)
Received: from pcperry.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 535DC9C52D8;
	Thu, 21 Mar 2024 18:06:02 -0400 (EDT)
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
Subject: [PATCH v6 0/4] fpga: xilinx-selectmap: add new driver
Date: Thu, 21 Mar 2024 18:04:32 -0400
Message-ID: <20240321220447.3260065-1-charles.perry@savoirfairelinux.com>
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

Changes since v5: (from Yilun review)
 * xilinx-core.h: remove private fields kernel-doc
 * xilinx-spi.c: rename conf into core in xilinx_spi_probe
 * xilinx-core.c: introduce the new gpio names in patch 4/4
 * xilinx-core.c: remove kernel-doc on xilinx_core_devm_gpiod_get()
 * xilinx-selectmap.c:
   * reorder includes in alphabetical order
   * xilinx_selectmap_probe(): remove unused resource *r variable
   * xilinx_selectmap_probe(): use a single gpio_desc* temporary
   * xilinx_selectmap_probe(): declare variables in reverse xmas tree

Changes since v4: (from Yilun and Krzysztof review)
 * xilinx-core: use sizeof() instead of hardcoded immediate
 * xilinx-core: fix module compilation (EXPORT_SYMBOL_GPL, MODULE_LICENSE=
,
   MODULE_AUTHOR, MODULE_DESCRIPTION)
 * xilinx-core: add private/public qualifiers for struct xilinx_fpga_core
 * xilinx-spi: remove struct xilinx_spi_conf. This struct isn't needed as
   the struct spi_device* can be retrieved from the struct device*.
 * dt-bindings: remove usage of "_b" and "-b" for the new driver. We
   agreed that the spi and selectmap driver will use different bindings
   which will be handled by the driver core and that the legacy names wil=
l
   be used only for the spi compatible.
 * xilinx-core: select between prog/init and prog_b/init-b

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

Charles Perry (4):
  fpga: xilinx-spi: extract a common driver core
  dt-bindings: fpga: xlnx,fpga-selectmap: add DT schema
  fpga: xilinx-selectmap: add new driver
  xilinx-core: add new gpio names for prog and init

 .../bindings/fpga/xlnx,fpga-selectmap.yaml    |  86 +++++++
 drivers/fpga/Kconfig                          |  12 +
 drivers/fpga/Makefile                         |   2 +
 drivers/fpga/xilinx-core.c                    | 229 ++++++++++++++++++
 drivers/fpga/xilinx-core.h                    |  27 +++
 drivers/fpga/xilinx-selectmap.c               |  95 ++++++++
 drivers/fpga/xilinx-spi.c                     | 224 ++---------------
 7 files changed, 466 insertions(+), 209 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-sele=
ctmap.yaml
 create mode 100644 drivers/fpga/xilinx-core.c
 create mode 100644 drivers/fpga/xilinx-core.h
 create mode 100644 drivers/fpga/xilinx-selectmap.c

--
2.43.0

