Return-Path: <linux-kernel+bounces-19367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7411A826BFE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3A41C2223A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A8E14291;
	Mon,  8 Jan 2024 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="Jr8qi1qX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4163114285;
	Mon,  8 Jan 2024 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rMnPX-0001RP-4U; Mon, 08 Jan 2024 06:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=mIJRlHkniiinnHEUw+7lzJw1kYFFsFuw7bpYHN2hxYI=; b=Jr8qi1qX3WHLCe
	RlyodG73p3Go2BZmGLShfJT4wzXaalAdAyfY70PytL5X7VUpguaZB6Iee6Iy58UGECihtX72+0COu
	P5s84rkz9bE7uFiJE0/pdNpmGdj3/IGSiV/lkirHp4NuOSrvfhVqtfPrFkCXcTr7r0kk6QYoXdN7K
	XrDuLRbDqf/GaICh/vy0SwpdFsrxtJ1C7Kip9jHgJRgTCd444vtazBmShzzQ6OOKi0+rvMrZPayXG
	8JKjVOHQgMrdXYRPvK6KyRgxFHxP1ma2ytWdUiSVbzehRZvysTFpX+V+vBD+YOjer8LwrjRKObcBd
	HxrlwK1APk1wh+ih7Saw==;
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
	Stefan Wahren <wahrenst@gmx.net>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH v7 0/2] Add Variscite VAR-SOM-MX93 support
Date: Mon,  8 Jan 2024 12:02:39 +0100
Message-ID: <20240108110241.8555-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey,

This is a v7 adding support for the Variscite VAR-SOM-MX93 SoM on Symphony
Board.

Thanks,

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
Changes in v7:
- Move the iomuxc nodes to the end of the files

Changes in v6:
- Fix gpio-keys and leds nodes
- Fix dtb_checks warnings

Changes in v5:
- Add gpio-keys and gpio-leds
- Enable lpuart6

Changes in v4:
- Add ethernet0 alias
- Remove useless properties

Changes in v3:
- Fix indentation on a continuation line
- Remove useless nodes and include

Changes in v2:
- Remove "nxp,pca9451a" block
- Fixed checkpatch warnings
- Fixed dtb_checks warnings
- Introduce dt-bindings documentation

v6: https://lore.kernel.org/linux-devicetree/20240103202243.26994-1-othacehe@gnu.org/


Mathieu Othacehe (2):
  dt-bindings: arm: fsl: Add VAR-SOM-MX93 with Symphony
  arm64: dts: imx93-var-som: Add Variscite VAR-SOM-MX93

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-var-som-symphony.dts  | 351 ++++++++++++++++++
 .../boot/dts/freescale/imx93-var-som.dtsi     | 111 ++++++
 4 files changed, 469 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-var-som.dtsi

-- 
2.41.0


