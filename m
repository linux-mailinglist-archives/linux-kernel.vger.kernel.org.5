Return-Path: <linux-kernel+bounces-10586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D4B81D687
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 21:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD34C1F21F6C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 20:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62B718054;
	Sat, 23 Dec 2023 20:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="mx44lV6W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2615E99;
	Sat, 23 Dec 2023 20:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rH8zi-0003Kn-ED; Sat, 23 Dec 2023 15:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=xQdUnDpFchJ0Zxvwx1n68wpYQcOiiJ8JX5WsclPYFYo=; b=mx44lV6WcoONFo
	HekqwT2MIlpLas578NSOgq7JLnYN6BVAyuq85lEBxBZ+1pXR/pCouLVfeftCvT3EB6PMv2/irhz0b
	aQn4jRMEUOkxYgE9HffLMuRqtl/rwcOqTUMgw0+XPUcZA5zf/JRCQGf/133H0PCGJGZ9Cdl3A/4FF
	DmsHfaxLZFx2cv27Wifs5KdINlboyQQYb9dwx3BGIiobImhpulloPqolUk4oGLkrLxpPyTktHEspu
	ly/O6QFhZeIMyd2pIIe0/qgEwBoelL55O9UrhMDuAeUphqc1GJFMeAt9GY+hB0iFITOp5DsQPb546
	jF5IavdY0pfff5Xspvqg==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Li Yang <leoyang.li@nxp.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH v2 0/2] Add Variscite VAR-SOM-MX93 support
Date: Sat, 23 Dec 2023 21:52:28 +0100
Message-ID: <20231223205230.10534-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey,

This is a v2 adding support for the Variscite VAR-SOM-MX93 SoM on Symphony
Board.

Support for "nxp,pca9451a" is not mainlined yet, it has been proposed here:
https://lore.kernel.org/lkml/20230531065724.3671795-1-joy.zou@nxp.com/T/

I removed it from the device-tree for now.

Thanks,

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
Changes in v2:
- Remove "nxp,pca9451a" block
- Fixed checkpatch warnings
- Fixed dtb_checks warnings
- Introduce dt-bindings documentation

v1: https://lore.kernel.org/linux-devicetree/3ad14d62-df64-45b1-9be4-008d30d2b52f@linaro.org/T/#t

---
Mathieu Othacehe (2):
  dt-bindings: arm: fsl: Add VAR-SOM-MX93 with Symphony
  arm64: dts: imx93-var-som: Add Variscite VAR-SOM-MX93

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-var-som-symphony.dts  | 306 ++++++++++++++++++
 .../boot/dts/freescale/imx93-var-som.dtsi     | 209 ++++++++++++
 4 files changed, 522 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-var-som.dtsi

-- 
2.41.0


