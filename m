Return-Path: <linux-kernel+bounces-75125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E816285E39E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C871C21946
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7703683CB9;
	Wed, 21 Feb 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gc4E77EP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DFC80C03;
	Wed, 21 Feb 2024 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533681; cv=none; b=pqZ9hXU0vdleQK5/aJPHU2fgki5UVCc6MAc787N9sV+OTCIbWa/N9RcFPOvNgT14w6FQO1X6ChxQT5ZJib2UPp5VKs1MqetOCFXNzKQ7ZXuxoiGpZUh81Qr8fCymCwo0OE+2ByEy8XiMmYhDebP/TkX70j+H7hRwEEZzgbwN6zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533681; c=relaxed/simple;
	bh=0Cd+VCIeTdBn+L0SAfWXHlwel79wcGcBBMfeVDyDkyU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=siM1l36Tm+9Nck6ym/wrsIHBDzuoQZuzQMj1kK33YZdcK049OGSNeMPO4cp/U56eB/SkeeUChV0CThZXFIuybje05+8EkwwnwZCX/9ysRt/y/zvrrMnWIUcJXwWXCY2fZ/f0+9YjOFH0S9NC5t7HcXe2fRo9Nch/LLUZ9Lmwc24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gc4E77EP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BAFCC433F1;
	Wed, 21 Feb 2024 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708533681;
	bh=0Cd+VCIeTdBn+L0SAfWXHlwel79wcGcBBMfeVDyDkyU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=gc4E77EP/syityRCO9eh+MI3qtQQI1ZyGO1F771h8mqI6pwtEZNhUjD1VZmGCztUi
	 fCzsqMTC9a1WN9qyblVpSzuff6vKDECDE1ajZqxJA/0K+rJfu+XwaGfOQlXkM0HTpc
	 H2FmjYNbeU6s4rxbiN3LrIrV5sE8fHH5GvnBf8FFUJUfB0lh1r86Lo7AvAiyxBWGP6
	 r2oJIdH/vOz26yuH03oC+g9LbfAVCTUhuntatK34aD1mR3uNwMQ+t6vkyKlqksUsRM
	 1HfZvlG3xloMBq+1ZtOf2TN0XVqwg/x99jQvJNr9tKRN3ctzq6EwPlFyDh9jBcOSqp
	 oL35dR1Sjp7Hg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F91C48BEB;
	Wed, 21 Feb 2024 16:41:21 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v3 0/8] clk: hisilicon: add support for Hi3798MV200
Date: Thu, 22 Feb 2024 00:41:03 +0800
Message-Id: <20240222-clk-mv200-v3-0-f30795b50318@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ8n1mUC/22Myw6CMBBFf4XM2poykAKu/A/jooyDNDxKWmw0h
 H+3sMLE5bm55yzg2Rn2cEkWcByMN3aMkJ0SoFaPTxbmERlQYi4xVYL6TgwBpRREJWnOKsUsIf4
 nx415763bPXJr/GzdZ0+HdFv/VUIqpNBYaWKsWGXqal9zb213JjvA1gl4dIuji9GtixI551qpp
 vh113X9AjQVmxTgAAAA
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708533664; l=2791;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=0Cd+VCIeTdBn+L0SAfWXHlwel79wcGcBBMfeVDyDkyU=;
 b=GjURGN5urv/SOzVTLvxeenBm0J574z/T6mXEfzBgt9GMgy5QkFcgmgwWcHZ0pk5+lS1QPTjRY
 6g2DfAVEib+Dmu7ccnTmqV1NQYq4fg76jdJq8XYIuppg8AGNU//mV1N
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

This SoC is similar to Hi3798CV200 with a few more clocks in CRG module.

Note this driver is still ongoing, many clocks are not registered in the
driver now. Feedback is welcomed, especially from HiSilicon people.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v3:
- remove RFC (Krzysztof Kozlowski)
- rearrange patches so dt-binding comes before drivers (Krzysztof Kozlowski)
- dt-bindings: Remove lots of properties
- dt-bindings: stop merging all hisi-clock bindings, only convert hisi-crg.txt for now.
- dt-bindings: remove hisilicon,hisi-sdmmc-dll subnode (Rob Herring, Krzysztof Kozlowski)
- split histb-clock.h into two files, deprecate this header file
- fix all users (hi3798cv200.dtsi and hi3798cv200 CRG driver)
- hi3798mv200-crg: add a few missing clocks
- Link to v2: https://lore.kernel.org/r/20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com

Changes in v2:
- s/dt-binding/dt-bindings in commit logs: (Krzysztof Kozlowski)
- fix bot error by adding "hisilicon,hisi-sdmmc-dll" to syscon.yaml (Rob Herring)
- hi3798mv200-crg: assign fixed rate parents to some gates
- hi3798mv200-crg: s/ETH/FEMAC, add GMAC ctrl clock
- Link to v1: https://lore.kernel.org/r/20240216-clk-mv200-v1-0-a29ace29e636@outlook.com

---
Yang Xiwen (8):
      dt-bindings: clock: convert hisi-crg.txt to YAML
      ARM: dts: hisilicon: add missing compatibles to CRG node
      dt-bindings: clock: histb-clock: split into two header files
      arm64: dts: hisilicon: fix include path
      clk: hisilicon: fix include path for crg-hi3798cv200
      dt-bindings: clock: hisilicon,clock-reset-controller: add Hi3798MV200 SoC
      dt-bindings: clock: hisilicon: add clock definitions for Hi3798MV200
      clk: hisilicon: add CRG driver for Hi3798MV200 SoC

 .../bindings/clock/hisilicon,hisi-crg.yaml         |  71 ++++
 arch/arm/boot/dts/hisilicon/hi3519.dtsi            |   2 +-
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi     |   3 +-
 drivers/clk/hisilicon/Kconfig                      |   8 +
 drivers/clk/hisilicon/Makefile                     |   1 +
 drivers/clk/hisilicon/crg-hi3798cv200.c            |   3 +-
 drivers/clk/hisilicon/crg-hi3798mv200.c            | 462 +++++++++++++++++++++
 .../dt-bindings/clock/hisilicon,hi3798cv200-crg.h  |  62 +++
 .../clock/hisilicon,hi3798cv200-sysctrl.h          |  17 +
 .../dt-bindings/clock/hisilicon,hi3798mv200-crg.h  | 150 +++++++
 .../clock/hisilicon,hi3798mv200-sysctrl.h          |  21 +
 include/dt-bindings/clock/histb-clock.h            |  73 +---
 12 files changed, 805 insertions(+), 68 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240216-clk-mv200-cc8cae396ee0

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


