Return-Path: <linux-kernel+bounces-46510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 048328440C6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D86283DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4917F49A;
	Wed, 31 Jan 2024 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7wOeWfN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AB97BB03;
	Wed, 31 Jan 2024 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708333; cv=none; b=EDrqPhYEbI8vl+3VMhBTI5DazOW8LLBBkW5hBZZ6pCVxNsVbOtneNofC0vno5hVd87wnFYnlfycBk9HAWwp043K47FOq3ULLhuGlvt+9RvidHwDWP5DaJ4YpvhRAhdJvJuJsxcQ4AJJonVjRvm64upTbk+s5iOfKFRDgiAvzaP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708333; c=relaxed/simple;
	bh=CPLp+9AYzGX3pEeWi3wlU4ZtwP5lMB44GA9+1lDqg0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmUHIj3fRm2144wh5f1U8pQaNh7M4/c1nXhWbshMV8hygCTN7htY55JajIRjATpH2ynh8hdnYJe4GYZcLmLTweQi+5rvq1gl0zs37Jx5JH1w1Ll3Wjek/DI+VlLjOcYyUEkR+/Ve33KAd0k1TVfviyLPky38rVjfyMscAaGwM1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7wOeWfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E8DC43390;
	Wed, 31 Jan 2024 13:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706708332;
	bh=CPLp+9AYzGX3pEeWi3wlU4ZtwP5lMB44GA9+1lDqg0Q=;
	h=From:To:Cc:Subject:Date:From;
	b=N7wOeWfNFJ1SeWiKk+cAW/43kh5X4RTcseKgUBBaK7HVu8FeyNgcglzNeEXM2iNbt
	 /ER/FBSdTbD8zxzkp1m6hGF1ZbEtJSt7LAvN2RjY2ZHhsrsNdnZHICJU+dntMNj7Kt
	 +bLM6GbahqHupXQ7NAX9OsINU4u47fu2bsiiphcj6GOc8UdGxxor1JYAuTz7gx6rcs
	 FhgUs3L3O5eFGUyU/cWIHpOxgcVw+mLwH1L/2Aek4/sHOodoDgoCWjByU2tar/oc/z
	 aRKNv5zBHnxLe7jwzcZLyvci/++PNsc4zB8TtQyQPxkFeSjQZOUqTewp7WxDy9MBBR
	 MeDQYGadFcmHg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] riscv: dts: starfive: add Milkv Mars board device tree
Date: Wed, 31 Jan 2024 21:25:54 +0800
Message-ID: <20240131132600.4067-1-jszhang@kernel.org>
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

Since v2:
 - add a common board file which can be used by vf2 and mars

Since v1:
 - add two new patches which add "cpus" label and board dt-binding
 - adopt Krzysztof's suggestions, thanks

Jisheng Zhang (6):
  riscv: dts: starfive: add 'cpus' label to jh7110 and jh7100 soc dtsi
  dt-bindings: riscv: starfive: add Milkv Mars board
  riscv: dts: starfive: visionfive 2: update sound and codec dt node
    name
  riscv: dts: starfive: visionfive 2: use cpus label for timebase freq
  riscv: dts: starfive: introduce a common board dtsi for jh7110 based
    boards
  riscv: dts: starfive: add Milkv Mars board device tree

 .../devicetree/bindings/riscv/starfive.yaml   |   1 +
 arch/riscv/boot/dts/starfive/Makefile         |   1 +
 arch/riscv/boot/dts/starfive/jh7100.dtsi      |   2 +-
 .../boot/dts/starfive/jh7110-milkv-mars.dts   |  35 +
 .../jh7110-starfive-visionfive-2.dtsi         | 600 +----------------
 .../jh7110-visionfive2-mars-common.dtsi       | 617 ++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |   2 +-
 7 files changed, 657 insertions(+), 601 deletions(-)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-visionfive2-mars-common.dtsi

-- 
2.43.0


