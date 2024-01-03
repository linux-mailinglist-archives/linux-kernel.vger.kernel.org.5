Return-Path: <linux-kernel+bounces-15852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0326823451
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A244EB23ADF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0B81CA84;
	Wed,  3 Jan 2024 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="A+VZDDNU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615121C696
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2024010318122535f7626b60d924a294
        for <linux-kernel@vger.kernel.org>;
        Wed, 03 Jan 2024 19:12:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=IEH6nvsMj011pWE7jF9KmAgYyT5EGs2I+43ptPArTJg=;
 b=A+VZDDNUHPhWx6rdrx4MfEKqm3Vimq9yMjlHriJL0Y2BVvxOrE0G5lH9YmEbZNd+ZEbNM3
 83Ybr8paUxhGk844d+OR3lY5vYORauvPfWtBsWD/UYEAJsbCi0W8pILILRLyIIQ+sD8uMx/Z
 HlI0MwskGd3sBMn4ID5gZEPxrDXwM=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>
Subject: [PATCH v2 0/7] arm64: dts: iot2050: Add support for new SM variant
Date: Wed,  3 Jan 2024 19:12:17 +0100
Message-Id: <cover.1704305544.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

Changes in v2:
 - LED improvements
 - factor out DP and USB3 dtsi files
 - fix subject of last patch

This bring support for yet another IOT2050 device variant, see last
patch for details. The rest is binding and refactoring to make that
happen. Plus, LED nodes are improved by adding function and color
properties.

This series needs to go on top of
https://lore.kernel.org/lkml/cover.1699087938.git.jan.kiszka@siemens.com/

Jan

Baocheng Su (2):
  arm64: dts: ti: iot2050: Disable R5 lockstep for all PG2 boards
  arm64: dts: ti: iot2050: Support IOT2050-SM variant

Jan Kiszka (4):
  arm64: dts: ti: iot2050: Factor out arduino connector bits
  arm64: dts: ti: iot2050: Factor out enabling of USB3 support
  arm64: dts: ti: iot2050: Factor out DP related bits
  arm64: dts: ti: iot2050: Annotate LED nodes

Su Bao Cheng (1):
  dt-bindings: arm: ti: Add binding for Siemens IOT2050 SM variant

 .../devicetree/bindings/arm/ti/k3.yaml        |   1 +
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 .../ti/k3-am65-iot2050-arduino-connector.dtsi | 768 ++++++++++++++++
 .../dts/ti/k3-am65-iot2050-common-pg1.dtsi    |   5 +-
 .../dts/ti/k3-am65-iot2050-common-pg2.dtsi    |  25 +-
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 869 +-----------------
 .../arm64/boot/dts/ti/k3-am65-iot2050-dp.dtsi |  98 ++
 .../boot/dts/ti/k3-am65-iot2050-usb3.dtsi     |  27 +
 .../ti/k3-am6528-iot2050-basic-common.dtsi    |   6 +-
 .../dts/ti/k3-am6528-iot2050-basic-pg2.dts    |   2 +
 .../boot/dts/ti/k3-am6528-iot2050-basic.dts   |   5 +
 .../dts/ti/k3-am6548-iot2050-advanced-m2.dts  |  20 +-
 .../dts/ti/k3-am6548-iot2050-advanced-pg2.dts |  10 +-
 .../dts/ti/k3-am6548-iot2050-advanced-sm.dts  | 189 ++++
 .../dts/ti/k3-am6548-iot2050-advanced.dts     |   1 +
 15 files changed, 1131 insertions(+), 896 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-arduino-connector.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-dp.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-usb3.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts

-- 
2.35.3


