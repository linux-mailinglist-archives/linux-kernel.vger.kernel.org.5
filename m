Return-Path: <linux-kernel+bounces-10710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5085D81DAB8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 13:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D391F2168E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 12:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F68D3FED;
	Sun, 24 Dec 2023 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="BLmiGLSX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FF23D7C;
	Sun, 24 Dec 2023 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rHNnM-0006E4-ER; Sun, 24 Dec 2023 07:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=0ufKzIaDSqK9hGpepq8RxpQhp6ww89KLmR1dRRoj8Ss=; b=BLmiGLSXp0629k
	LGs9pFY8WKSZwzGA9uSOinzZgO78I/S5Mdp+uL5C6E2YxwyBYsRnVINHNh8IL6GPuFh1qFCPdgfl4
	gT5FfoKWctJ+jEFGKmwDY6Z/Xj+LMR7ImOMuqYYuNP/fGX1+Y6mIyC1RLX1y7o2txts4N0a+bGGLh
	nhEZiT6jhbg7Iv4av+LY1bXbB8vFsgfuAaZkm9owwywf7JZvliXkIryZxEYGfUFeR4n/+VNUHvLU8
	s7NHREq3LeVSjCruTI5JkoIaaECPB11P801+FJimGcjCt9OJ0XiZWMhAtbI6OKj3I5fuV6lxn2Bju
	s94Kizy6W2zQ2eYfa+PQ==;
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
Subject: [PATCH v3 0/2] Add Variscite VAR-SOM-MX93 support
Date: Sun, 24 Dec 2023 13:41:12 +0100
Message-ID: <20231224124114.31119-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey,

This is a v3 adding support for the Variscite VAR-SOM-MX93 SoM on Symphony
Board.

Thanks,

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
Changes in v3:
- Fix indentation on a continuation line
- Remove useless nodes and include

Changes in v2:
- Remove "nxp,pca9451a" block
- Fixed checkpatch warnings
- Fixed dtb_checks warnings
- Introduce dt-bindings documentation

v2: https://lore.kernel.org/linux-devicetree/20231223205230.10534-1-othacehe@gnu.org/T/#t

---
Mathieu Othacehe (2):
  dt-bindings: arm: fsl: Add VAR-SOM-MX93 with Symphony
  arm64: dts: imx93-var-som: Add Variscite VAR-SOM-MX93

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-var-som-symphony.dts  | 306 ++++++++++++++++++
 .../boot/dts/freescale/imx93-var-som.dtsi     | 111 +++++++
 4 files changed, 424 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-var-som.dtsi

-- 
2.41.0


