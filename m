Return-Path: <linux-kernel+bounces-32676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019F9835ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C864B2AC15
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2016D3A1AE;
	Mon, 22 Jan 2024 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="FUdoIHcj"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5F839AC6;
	Mon, 22 Jan 2024 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917218; cv=none; b=CCQr7CRPXTshxF/hROp9dWfOIXAp6rEnFjzeieLAYhTXqxFWF4XfSPI33sBazC1IJwPXJ2BwoHHYlzfFz7pCViLHHhc/rV+G6AQy7E0wnlOJVgwc7BDDxelaZUbmdNRw9zGUWb6eoVz9HxKV060WrKBdiEBDCqc7pt6sRtWpPYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917218; c=relaxed/simple;
	bh=Gmlqsch+nU3OHq/zfaK40X9RQ+SCvMPGFhWvnNdBsSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKaHvTS0wQnXieaUlB6fL94wSGkZXpJElS7YOObFZIUcJj2unice11Xm+W7aSrWFHK0YjZOuNompIeeV+FcoEsHwFvHGC8Y+TQHSMBOZU+fZzlVzAeafApfD/rut9lrLIX4mmVfP+Lo7sbaG9t2Vb98nrDn5OY6ebFrHGraohZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=FUdoIHcj; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rRqzj-00047p-Ko; Mon, 22 Jan 2024 04:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=4enchjbGZZQSpYR+16gx8q2bCR1BddghDI9P1EyTw0U=; b=FUdoIHcji+v83x
	t3GIeLbGIA7Cs7oi0/0Ai5oFSuo3r7pikd5XmzvEkQAA5GV3BeoGytaFlyhQq2DieCkSUvYiaydCn
	NPuvlnD9KZy47RNtcDOMBM0GDjB/lE7AUdBfSSAKijzKzB88tTOsnMkf5/aY5wN9dzvhJoUVz2mrU
	CPsPVO6+N+y2gCuj7tppC7KXJ52EHO2fROyjzR8fNkDzyHegVWVTUSZnUq43GQcwqZEHKoQgLv46g
	zW62L1GKJIjlnAWDJ5UtttxHnacstdnSP9rHMt2Up6UoWDpS5RDEUpMWP3byNc0FG52zQkglzwAu5
	rhZJaJs1u0D4/IzU+b1g==;
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
Subject: [PATCH v4 0/3] Add phyBOARD-Segin-i.MX93 support
Date: Mon, 22 Jan 2024 10:53:03 +0100
Message-ID: <20240122095306.14084-1-othacehe@gnu.org>
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

Note that the v4 enables the FEC ethernet port to ease device-tree
debugging, as well as the heartbeat LED and the gpio-line-names for the
GPIOs on the phyBOARD X16 header.

It also adds a new documentation patch to fix a dt check warning regarding
gpio-line-names property.

Thanks,

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
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

v3: https://lore.kernel.org/linux-devicetree/20240119092835.21462-1-othacehe@gnu.org/

Mathieu Othacehe (3):
  dt-bindings: arm: fsl: Add phyBOARD-Segin-i.MX93
  dt-bindings: gpio: gpio-vf610: add gpio-line-names
  arm64: dts: imx93: Add phyBOARD-Segin-i.MX93 support

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 .../devicetree/bindings/gpio/gpio-vf610.yaml  |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-phyboard-segin.dts    | 141 ++++++++++++++++++
 .../boot/dts/freescale/imx93-phycore-som.dtsi | 127 ++++++++++++++++
 5 files changed, 276 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi

-- 
2.41.0


