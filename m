Return-Path: <linux-kernel+bounces-27336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1602882EDF4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CAA28516E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073831B972;
	Tue, 16 Jan 2024 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="PPj1+iL5"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA53F1B814;
	Tue, 16 Jan 2024 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rPhnM-0007Zl-PM; Tue, 16 Jan 2024 06:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=d2vWuSxRr+AvXfOlhUQjdYNlQ6YyHdlleYl51vOgvGE=; b=PPj1+iL5gOhCXl
	by+GTFosRohyeDQTxpBkr8lYcuLlfCillqodx3UETPYF9dTGCyoYSSC556PSi1D9Xbk291di33S76
	0oAa3UILZIh6NEMJm1aBmFZv1uM9POwGBEukf7TJ+eRVNyWKsWT+hsdk0qlFpH0HInr3UR936arjt
	owi8qnBZJskHp6xhHOqSxLzMkMVeEtrqlltWiOL5X9PmByEes28pYNOPL3tnS6bjbrNvKvyYlFsfP
	a846qHMW4RKNcYV8NoghqO0WutI4WCEo/TGqbB6VFPmjpo6pvAA3sDPuCffipnNfKJ0vU6KQyTmUe
	3UJ+9DtFThHUHR+rMwlQ==;
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
Subject: [PATCH 0/2] Add Phytec i.MX93 Segin support
Date: Tue, 16 Jan 2024 12:39:37 +0100
Message-ID: <20240116113939.17339-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This adds support for the Phytec i.MX93 Segin board.

Thanks,

Mathieu

Mathieu Othacehe (2):
  dt-bindings: arm: fsl: Add i.MX93 PHYTEC with Segin
  arm64: dts: imx93-phycore-segin: Add Phytec i.MX93 Segin

 .../devicetree/bindings/arm/fsl.yaml          |  6 ++
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../dts/freescale/imx93-phycore-segin.dts     | 92 +++++++++++++++++++
 .../boot/dts/freescale/imx93-phycore-som.dtsi | 54 +++++++++++
 4 files changed, 153 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phycore-segin.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi

-- 
2.41.0


