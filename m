Return-Path: <linux-kernel+bounces-36591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C83A383A385
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BF31C28F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCD4171AB;
	Wed, 24 Jan 2024 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="MakCWVCd"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62E917542;
	Wed, 24 Jan 2024 07:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706082688; cv=none; b=nAestmrDElydLqzCTn717ghrnaTU/LpcHXi2LGXUueMfqfQa4AP6FKyIURx2mDYZVhr9C2YRr0pGM4tPZRS+8g0fDHrNLk1f6bda7Rs8rAJvnDvq1XGYn45JLCS4GzbCwnFPAsQSMIhtD4PjB0+zJ5JqnaoS/90Zkf+7cqZQLLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706082688; c=relaxed/simple;
	bh=DcFSPhT3LeuMsdh0kljwg6YnnEEpXhf+WOiAEbOy9xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JQwJTRfqWXMtDZHIntPQzrbVbc+ukOnEc/goyCfsnVt5GpTcBUWYvyQSa+nk0XtjubJxSs8H4Xiew6psi0UacJg6vTI9FeO3LfMn1tisqx81AjZ9QB2fJd0UnMxOsnRim7Mr/y62iousF2GSULJWCtbhzU9k/a+p7axFZ1chqo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=MakCWVCd; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rSY2R-0004j5-Ca; Wed, 24 Jan 2024 02:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=0rTSBM8FAiLBtJbaMKADVCeePIBHC+QW0h8Zr7BMfQU=; b=MakCWVCddnpJR4
	LaW0p+qScZgkL6uoVzsNKThNpzAhNtVBAjYJBQs/bb+kEPDCMzjeOAWCHtLaUaKkpHSRkJfdNFvG2
	CXr+be8omi/+xEHpby2FmUN9NF5d3xfZzgFn+bEzYyZU/xyiUjPWkCehuAgvoUk0ilZdyoD4In/Ov
	bJvb/5Wyuq9pKSyb6FM6gRPlcIwz9t4fYNN1WJLt+AIOLsJs6Ubd4oTX5xRWmk03NFesKcR0ks83B
	jryrTkRssG/elxpiNBjgDjPSHWpfp8Zt4ypgCL8LeTTA7hOmMVkWf10tMD1SFo7h6oJlBS0t2hIRy
	ydhI0YgBohroiyjpEhXg==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Primoz Fiser <primoz.fiser@norik.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Christoph Stoidner <c.stoidner@phytec.de>,
	Wadim Egorov <w.egorov@phytec.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH v5 0/3] Add phyBOARD-Segin-i.MX93 support
Date: Wed, 24 Jan 2024 08:49:27 +0100
Message-ID: <20240124074930.26101-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This adds support for the phyBOARD-Segin-i.MX93 board.
In this v5, I removed the gpio-line-names that were controversial.

Thanks,

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
Changes in v5:
- Remove the gpio-line-names
- Fix the product URLs
Changes in v4:
- Add gpio-line-names to gpio-vf610 dt-bindings documentation
- Add the heartbeat SoM LED
- Add support for the FEC ethernet port
- Restore the original authors in the copyright
- Add gpio-line-names for the GPIOs on the X16 header
Changes in v3:
- Update documentation to match PHYTEC naming
- Remove useless properties
- Update pinmux from PHYTEC downstream kernel
Changes in v2: 
- Remove useless line
- Add missing reserved-memory entries

v4: https://lore.kernel.org/linux-devicetree/20240122095306.14084-1-othacehe@gnu.org/

Mathieu Othacehe (3):
  dt-bindings: arm: fsl: Add phyBOARD-Segin-i.MX93
  dt-bindings: gpio: gpio-vf610: add gpio-line-names
  arm64: dts: imx93: Add phyBOARD-Segin-i.MX93 support

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 .../devicetree/bindings/gpio/gpio-vf610.yaml  |   2 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-phyboard-segin.dts    | 117 ++++++++++++++++
 .../boot/dts/freescale/imx93-phycore-som.dtsi | 126 ++++++++++++++++++
 5 files changed, 252 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi

-- 
2.41.0


