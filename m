Return-Path: <linux-kernel+bounces-38370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB3A83BE70
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 885C1B2285F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4281CA85;
	Thu, 25 Jan 2024 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="AWNDXi9F"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBA11CA81;
	Thu, 25 Jan 2024 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177722; cv=none; b=U08eGaZcLsZsiIHSFMg0rdNDQdhj+E51H6sil/BWewwRj2p2v6/HFtcqt9b+cV6hfFK560cusI6Pn1yKFB8ZekYRkSEbDjcwKs+Ee9SvlJe3t5pude25TqbQHXJnd8uBrBUzXIFRLc13a64XIrBVssaKoP46xm8YELeG4g1ruNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177722; c=relaxed/simple;
	bh=IInxiPcVnGJnkitFQ4JslQKujcO/Onj7En0u9hQF/8M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hrRHyTZ1eAnUIA8O9Wr7fN5zcvdrLPrWmsgP+uEL9BtxcMMk9aXNlnCGDZushKFQK+/VJ2dKoHWgNXMBzL6XeJouh5wlkWF2u7L1IWgJKBOgaI+sXvC5Pnv/PZ0lp54xXhUrXapoEFLYvYSQqtVCuciZE5zloKVqe39KBkxOYng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=AWNDXi9F; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id B8881206D5;
	Thu, 25 Jan 2024 11:15:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1706177710;
	bh=INc7mVqBcxtgo9Rib9RuI6CeSV/qamAJQEdqhenWWBg=; h=From:To:Subject;
	b=AWNDXi9F30vWqFLaI3bnEwAElWAe4pATkNAj7RsQvKhXY3lp4ShPJHK9pKrkY+X3L
	 NiZqv2vQ2i8qwoXwRpJUT469YGoGmSicGUu5ORVelfqYr1kyjseTjtAMcbNHL6iug5
	 9uWQoQrtML8yzVrVf5dn4RjpUZxdKjHZspFD7btyPGpUgMPKItmLRJ4ZKmFZG1HsEg
	 7LmkJ84RXlEkb0c1nGYOINUEZgoM2S6ZLdyvDcNvzzzT6ca1/Gi7BQ++RFJYkug+Mr
	 BqPKhCluTr4Rk1wOK2PfUTDMv7bCIEwMPc/cpZswL8g8okT1NVwKlF74D4fgrEov1z
	 uVT15Li9qWEJg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Li Yang <leoyang.li@nxp.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/2] arm64: dts: freescale: imx8qm: add apalis eval v1.2 carrier board
Date: Thu, 25 Jan 2024 11:14:55 +0100
Message-Id: <20240125101457.9873-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

This series introduces support for the new Apalis Evaluation Board v1.2
for imx8qm-based Toradex SoM. With the introduction of board v1.2, a common
board configurations dtsi file and two version-specific dtsi board files were
added. Consequently, four possible dts files are generated to support the
range of different SoM versions. Additionally, updates have been made to dts
freescale/Makefile and arm/fsl.yaml to accommodate the changes.


Joao Paulo Goncalves (2):
  dt-bindings: arm: fsl: add imx8qm apalis eval v1.2 carrier board
  arm64: dts: freescale: imx8qm: add apalis eval v1.2 carrier board

 .../devicetree/bindings/arm/fsl.yaml          |   6 +-
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../dts/freescale/imx8-apalis-eval-v1.1.dtsi  |  26 ++++
 .../dts/freescale/imx8-apalis-eval-v1.2.dtsi  | 124 ++++++++++++++++++
 .../boot/dts/freescale/imx8-apalis-eval.dtsi  |  22 ----
 .../dts/freescale/imx8qm-apalis-eval-v1.2.dts |  16 +++
 .../boot/dts/freescale/imx8qm-apalis-eval.dts |   2 +-
 .../imx8qm-apalis-v1.1-eval-v1.2.dts          |  26 ++++
 .../dts/freescale/imx8qm-apalis-v1.1-eval.dts |   2 +-
 9 files changed, 200 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-apalis-eval-v1.1.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-apalis-eval-v1.2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-eval-v1.2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-eval-v1.2.dts

-- 
2.39.2


