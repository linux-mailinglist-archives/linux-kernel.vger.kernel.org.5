Return-Path: <linux-kernel+bounces-112336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D02D887891
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD92AB23E1B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E4E3D0CD;
	Sat, 23 Mar 2024 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xyVGsYbG"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B563F9EC;
	Sat, 23 Mar 2024 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711196348; cv=none; b=mL9imXpMFsDqpuPYsAVonbEcLfFd3sUvg6VMgYdlrwYRWCXVb24AwcJIJY+4F0cx9r9qHBYxDEBjsTZH/x/JEf86vwKBV6rkwepyZnSiLEvvGol6c15i7oO33V2t7v/eKumK0IO7LehXCWhKe0ySo1y4qyMJL76CTHD/sYn+aa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711196348; c=relaxed/simple;
	bh=miFsSSO6ORAFKfb/FNplR2ic2Sl1l5TEs4zGx418nbM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ZWSeiaGKwmD0sh0OLnMIaujbybFRqtq7Lm9eJaZASRYKNWAUp17dyqUWjxj9dxASXqbDv7JlJBADNH2/MC21ntTBfMv7hJvpzfLhDCHdkvNQIFHFSZ0DDkpSO5wImMUGRrLEeSiNR8R0QqVUFQq4yfGx4M8JzWUQBCDAf3E98MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xyVGsYbG; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711196340; bh=FXV/7ms+3t0/0kPfleO6oqzdUTF8q8JeIeMsgZdvycQ=;
	h=From:To:Cc:Subject:Date;
	b=xyVGsYbGdlfK7syv/7rw/9CxFN+2u97nXWHevUw1lP1bAI0V2fFz13SSn96Op7iLC
	 zhd+8GOR+xUsRUq9/uXDh7byKFuoUxNT0Y5/ueBAgb3FnSOW+hpOFl5gGl35hvzn84
	 s1XfkxIA7ikOIXNKpuEThg40dnjOyeakmkdhcAGY=
Received: from cyy-pc.lan ([240e:379:225d:8e00:b91:b2e7:7c69:8554])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 29B94C26; Sat, 23 Mar 2024 20:10:27 +0800
X-QQ-mid: xmsmtpt1711195827thrvb5b58
Message-ID: <tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com>
X-QQ-XMAILINFO: OQ59tfF64tJLcVZEXNL6UKJCRP6DHmqNBwAbU7DzvlZsg0jBqqRaEo1a73jhJm
	 Vh0+GpXnv94y64GUeH5S+fE/Ps19L9WbiN9ZmXTXotRyo2XLcy/EQKsTlJBDshdlxmk4pmT+i70G
	 3HosWAV2ZIeXLr5ALg+vLiO+j3RUhuItIlsUiMcAK5N0xfpfTJ5LSKVAr7M49GeFf9fymOKgsk64
	 sK5+srDS91yIJ4R4+QujU1guaQBu7MuVXVHh7qHRpp+Q5ku4KfMsRvkaF71F9ONeBcXsLCImI402
	 mqtkIpylN8HdSzcwLctKhNYZ61m/YJR264ZDCQyy4sxNX9XN6BUEftw2M6S1W9FroNg4/ucAmNvN
	 /Pszszfjb2/snKHFsAVysatXYGVQnHB5uxrWrsbbRkRsX08pbtGBT7e/qG7bAn5/qXQUBwd1QEWH
	 qaKiCZW731/G2/Xqu5K0+5jTMNK5dgwm0YWpxfCTYc39Lfzo/tf/dfWF9uDfDJ7sKZq4BB/H9YRK
	 mJhYmEycgRABuR9xYd9qyvEzNJzpWrGmI35vvsJPVVoFUjybS+2+yid/YN0H4d17VVGpB9nvH6ES
	 S8IPJiQdWKp3oy5hEIFrsq34usTmHNogPQbmwVOQMEcIy4+OR1WijG1T1YIIfy0do328CpSzSEMY
	 YFXPbpG265qTzUCekSfDntNMpV5rCpE9jeLzJyiqlcJXj72pW0/b3c+aJC9QHOuuMweGjBt+8UhQ
	 GzPdj36D0ittQNv0ux4ZhC0Et0RF7ofenLujMVGfIDYfjczIXK3uto07gEVKlYY4xe+EdLuXlkZQ
	 C8obnGdoLtKrnnnmVII4Er0RxxoGrZZk9i4IjN4tAhqDL0R+wtLbfvAPRt2mM4Z06Q2alTad4cEY
	 qL1D4LvB1CoFOLJMCkKrwwcvU0afxtkEkl+C2y8fh03VNV9A+Kg5WFRuIykSWBQvh+z1Nkw7RpE3
	 tzUBgj04844rp8o0KENCsG5YyRA9vETpl8Gn6/8AknawQfz41E2Z0d5bSBH6Car5+kFpVkkzE=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-gpio@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v6 00/11] riscv: add initial support for Canaan Kendryte K230
Date: Sat, 23 Mar 2024 20:09:42 +0800
X-OQ-MSGID: <20240323120942.1728629-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

K230 is an ideal chip for RISC-V Vector 1.0 evaluation now. Add initial
support for it to allow more people to participate in building drivers
to mainline for it.

This kernel has been tested upon factory SDK [1] with
k230_evb_only_linux_defconfig and patched mainline opensbi [2] to skip
locked pmp and successfully booted to busybox on initrd with this log [3].

[1] https://github.com/kendryte/k230_sdk
[2] https://github.com/cyyself/opensbi/tree/k230
[3] https://gist.github.com/cyyself/b9445f38cc3ba1094924bd41c9086176

Changes since v5:
- Deprecate SOC_CANAAN and use SOC_CANAAN_K210 for K210 SoCs
- Modify existing K210 drivers depends on SOC_CANAAN_K210 symbol
- Reword dts commit message
- Modify dts to use Full 512MB memory
- Rebase to linux mainline master

Changes since v4:
- Reword commit message on dts that the B-ext version of c908 is 1.0 rather
  than 1.0-rc1

v4: https://lore.kernel.org/linux-riscv/tencent_587730262984A011834F42D0563BC6B10405@qq.com/

Changes since v3:
- Refactor Kconfig.soc which uses ARCH_CANAAN for regular Canaan SoCs and
  rename SOC_CANAAN to SOC_CANAAN_K210 for K210 in patch [5/7]
- Sort dt-binding stings on Cannan SoCs in alphanumerical order

v3: https://lore.kernel.org/linux-riscv/tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com/

Changes since v2:
- Add MIT License to dts file
- Sort dt-binding stings in alphanumerical order
- Sort filename in dts Makefile in alphanumerical order
- Rename canmv-k230.dts to k230-canmv.dts

v2: https://lore.kernel.org/linux-riscv/tencent_64A9B4B31C2D70D5633042461AC9F80C0509@qq.com/

Changes since v1:
- Patch dt-bindings in clint and plic
- Use enum in K230 compatible dt bindings
- Fix dts to pass `make dtbs_check`
- Add more details in commit message

v1: https://lore.kernel.org/linux-riscv/tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com/

Yangyu Chen (11):
  dt-bindings: riscv: Add T-HEAD C908 compatible
  dt-bindings: add Canaan K230 boards compatible strings
  dt-bindings: timer: Add Canaan K230 CLINT
  dt-bindings: interrupt-controller: Add Canaan K230 PLIC
  riscv: Kconfig.socs: Split ARCH_CANAAN and SOC_CANAAN_K210
  soc: canaan: Deprecate SOC_CANAAN and use SOC_CANAAN_K210 for K210
  clk: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
  pinctrl: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
  reset: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
  riscv: dts: add initial canmv-k230 and k230-evb dts
  riscv: config: enable ARCH_CANAAN in defconfig

 .../sifive,plic-1.0.0.yaml                    |   1 +
 .../devicetree/bindings/riscv/canaan.yaml     |   8 +-
 .../devicetree/bindings/riscv/cpus.yaml       |   1 +
 .../bindings/timer/sifive,clint.yaml          |   1 +
 arch/riscv/Kconfig.socs                       |   8 +-
 arch/riscv/Makefile                           |   2 +-
 arch/riscv/boot/dts/canaan/Makefile           |   2 +
 arch/riscv/boot/dts/canaan/k230-canmv.dts     |  24 +++
 arch/riscv/boot/dts/canaan/k230-evb.dts       |  24 +++
 arch/riscv/boot/dts/canaan/k230.dtsi          | 140 ++++++++++++++++++
 arch/riscv/configs/defconfig                  |   1 +
 arch/riscv/configs/nommu_k210_defconfig       |   3 +-
 .../riscv/configs/nommu_k210_sdcard_defconfig |   3 +-
 drivers/clk/Kconfig                           |   4 +-
 drivers/pinctrl/Kconfig                       |   4 +-
 drivers/reset/Kconfig                         |   4 +-
 drivers/soc/Makefile                          |   2 +-
 drivers/soc/canaan/Kconfig                    |   4 +-
 18 files changed, 220 insertions(+), 16 deletions(-)
 create mode 100644 arch/riscv/boot/dts/canaan/k230-canmv.dts
 create mode 100644 arch/riscv/boot/dts/canaan/k230-evb.dts
 create mode 100644 arch/riscv/boot/dts/canaan/k230.dtsi

base-commit: 8e938e39866920ddc266898e6ae1fffc5c8f51aa
-- 
2.43.0


