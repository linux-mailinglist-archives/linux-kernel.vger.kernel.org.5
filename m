Return-Path: <linux-kernel+bounces-161634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F2C8B4EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70BF7B20D54
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9563D7EB;
	Mon, 29 Apr 2024 00:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebDfLKTS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53097F;
	Mon, 29 Apr 2024 00:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714350407; cv=none; b=f/zYo+AY34nGLNLl5aD4kNxaTlHvHitnya+1rCbXkzdzRi17gO3xLZt0tvtiOagQi+jKJriG2u4NsAtqpfTgeaFaDy2t0F6hYjlrTy0CWeUomaunjPtwhr9FzPwWroQuyAECpXhfQpX5pSXwPwDTqrlSe/Qmd/Hbyu0wSS8zT7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714350407; c=relaxed/simple;
	bh=+4O/HYaERDN6eRkgGqOsfuJ2sG6F1FBLC5XSIYkRN5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dv+uri/F0YmWtj0TOki9V/efHIJwofweIIiE5ZclPAYDcLK/iYbQIrVq20PqENKkS5jSvDeenjlrCX8+BrEgJwcFKmC5kKuPfeyEHlL+Yc1IVuEIw5SiY8X3L50I2evitL6Fc1rVazwJeWbg63iH8QXwkG411gFVZdrpunh7/Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebDfLKTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C63C113CC;
	Mon, 29 Apr 2024 00:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714350407;
	bh=+4O/HYaERDN6eRkgGqOsfuJ2sG6F1FBLC5XSIYkRN5s=;
	h=From:To:Cc:Subject:Date:From;
	b=ebDfLKTSrQ4dlmo8LT/Y9amkpau0ccnbEOaESUZdtP4sZcxWdK3M8bMVFmAMff4tj
	 lgdwkBbfMHFJ22JCywEJkfewrx4J37L0zOAsEOrGHv21lhTeNpujFKK8aSAXI0y72G
	 uxYzihnHhoSct8uMGr+QVS14M3U9ckhgzPenN12CuEUkRC8yq/g7I+T7/K6WaZrDJL
	 JVhgnsKvPYmeqcjo8Ee5uUkc2TaNgDqEpra+qNoevSBx+IQrJBDgZSUXlTLOtz0II+
	 GjKeqQijPxKQjtk5xw5/QVJ9I8jklnw+p/1b0rRdPJ3GZpLh7twHzRcRtzMiJGGT67
	 +5bzJ3MvtNY9Q==
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] riscv: dts: starfive: add Milkv Mars board device tree
Date: Mon, 29 Apr 2024 08:13:09 +0800
Message-ID: <20240429001317.432-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Milkv Mars is a development board based on the Starfive JH7110 SoC.
The board features:

- JH7110 SoC
- 1/2/4/8 GiB LPDDR4 DRAM
- AXP15060 PMIC
- 40 pin GPIO header
- 3x USB 3.0 host port
- 1x USB 2.0 host port
- 1x M.2 E-Key
- 1x eMMC slot
- 1x MicroSD slot
- 1x QSPI Flash
- 1x 1Gbps Ethernet port
- 1x HDMI port
- 1x 2-lane DSI and 1x 4-lane DSI
- 1x 2-lane CSI

patch1 adds 'cpus' label
patch2 adds "milkv,mars" board dt-binding
patch3 ~ patch4 adopt Krzysztof's suggestions to DT node names
patch5 introduces a board common dtsi for visionfive2 and mars
patch3 adds the mars board dts file describing the currently supported
features:
Namely PMIC, UART, I2C, GPIO, SD card, QSPI Flash, eMMC and Ethernet.

Since v3:
 - collect Reviewed-by tag
 - rename the common dtsi to jh7110-common.dtsi
 - mv cd-gpios and disable-wp into jh7110-common.dtsi
 - fix "gmac1-rgmii-rxin-clock: 'clock-frequency' is a required property"
   warning

Since v2:
 - add a common board file which can be used by vf2 and mars

Since v1:
 - add two new patches which add "cpus" label and board dt-binding
 - adopt Krzysztof's suggestions, thanks

Jisheng Zhang (8):
  riscv: dts: starfive: add 'cpus' label to jh7110 and jh7100 soc dtsi
  dt-bindings: riscv: starfive: add Milkv Mars board
  riscv: dts: starfive: visionfive 2: update sound and codec dt node
    name
  riscv: dts: starfive: visionfive 2: use cpus label for timebase freq
  riscv: dts: starfive: visionfive 2: add tf cd-gpios
  riscv: dts: starfive: visionfive 2: add "disable-wp" for tfcard
  riscv: dts: starfive: introduce a common board dtsi for jh7110 based
    boards
  riscv: dts: starfive: add Milkv Mars board device tree

 .../devicetree/bindings/riscv/starfive.yaml   |   1 +
 arch/riscv/boot/dts/starfive/Makefile         |   1 +
 arch/riscv/boot/dts/starfive/jh7100.dtsi      |   2 +-
 .../boot/dts/starfive/jh7110-common.dtsi      | 599 ++++++++++++++++++
 .../boot/dts/starfive/jh7110-milkv-mars.dts   |  30 +
 .../jh7110-starfive-visionfive-2.dtsi         | 584 +----------------
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |   2 +-
 7 files changed, 634 insertions(+), 585 deletions(-)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-common.dtsi
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts

-- 
2.43.0


