Return-Path: <linux-kernel+bounces-12158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D5681F0B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6161F221B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016C646444;
	Wed, 27 Dec 2023 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="Qqodpruz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8646430;
	Wed, 27 Dec 2023 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rIXPL-0004KO-AD; Wed, 27 Dec 2023 12:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=ZSjpjOwaMBX7Au3IBUcM+t0U9vm7stZwntnXm9UFvmw=; b=Qqodpruz2Eq+Qx
	ktCwLC+2PEiIzdCRfS2lsXtzMm5VxK10Mi9++5/zn6/5nQ6q5tYkI9oJtnYIcT8PxF4OoJv49DunO
	MGUR/QBKz3b23TE61NW2H3RGxsirCJ/Ar4PX9i/QLdPApdA3dEpjoGIK5UMVHP2fXBpagLyq6LUME
	Uh5huef42S9A11WZx/wlUwbv1c/1CPWSVJb/LvidRSMqo5cFHo+fV3vvwMuDpMNICVqoN5a3XXtRA
	dt1K2RRS47iyfZGG4vXuIhMcNv/N/QNkGxTWnB0WxfmIMjgLe0Dm0q306kEYeOSzbfXqJEYwEzENS
	cznsJCbHLicpxkeWZZzg==;
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
Subject: [PATCH v4 0/2] Add Variscite VAR-SOM-MX93 support
Date: Wed, 27 Dec 2023 18:09:17 +0100
Message-ID: <20231227170919.8771-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey,

This is a v4 adding support for the Variscite VAR-SOM-MX93 SoM on Symphony
Board.

Thanks,

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
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

v3: https://lore.kernel.org/linux-devicetree/20231224124114.31119-1-othacehe@gnu.org/T/#t


Mathieu Othacehe (2):
  dt-bindings: arm: fsl: Add VAR-SOM-MX93 with Symphony
  arm64: dts: imx93-var-som: Add Variscite VAR-SOM-MX93

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-var-som-symphony.dts  | 303 ++++++++++++++++++
 .../boot/dts/freescale/imx93-var-som.dtsi     | 111 +++++++
 4 files changed, 421 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-var-som.dtsi

-- 
2.41.0


