Return-Path: <linux-kernel+bounces-28614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5926B8300BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC42C1F23D92
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32521118D;
	Wed, 17 Jan 2024 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="qv9lHJt/"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B74BE4B;
	Wed, 17 Jan 2024 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705477764; cv=none; b=hKjCi18plgl3Ua4jrZdjpCSZ/iv6raFhzJx2+DxHUSWPoEQIOfB8d9aj/uGla99mmFerH3rgxQnFkXR4XM8140skvZ1QAPfRMUMw9uXsv99wdbJnTMJuTFjefSid00kBN6MrzqZ5Y15besEgMzMkyAewGjGaE5OSCzl2zL2wcdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705477764; c=relaxed/simple;
	bh=8d7UQZ3WSptWHFlhNw4Hy2Ex+4Po4FsMhRGfHPfpvoI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=XA1jIfoLUuwX3Iz5oaTLttdg3Udm7sQibT1TK+YaCRRG3HapyoIXl5IP93clNBZU3NHdCfljXgCPgWGZmavovMUF9xmYUpsx0EU2PUdOWV08YdKeMrvOv/l6o1DK+KpeXuVoM6N/sNk6dQjIxU1vAYDgO+Z6UNk5OLQ3Gm8HobM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=qv9lHJt/; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rQ0fl-0000fW-IV; Wed, 17 Jan 2024 02:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=HN7Dw3OX56V5RguZKzCSaWSIywufEzo+9zsetCtelqs=; b=qv9lHJt/Is2U2Z
	RMSo183zl+PpsvGmRB0KPlYSDOMl2OhG6pVkcYdoSw1u8kGIV0KePd8+aG4y2n2M4enXQPvNLdf4Y
	C/IiwFDCkIo3r6eKVxp2jAzGzetait06u7SZ6gKKhN544hFhIPafxiZWOIee69idS1zFJTY2Gx71D
	c+AhIYSj5RasRfvDgvsFaMW1MuD8lynxN1HiGWimWxUhdjsyZG/sfaOczhmLh2r8wWrAVkzopOxI4
	NfuXD9VYUBj1GXHSuZUkk8Vl6mkYYJMPTrTUO6TVjhbHZPxEpfRFEWP0OoFIci1MxoScWfrPexmyW
	qrNFR0/cA0gOxCEW43iQ==;
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
	Stefan Wahren <wahrenst@gmx.net>,
	Christoph Stoidner <c.stoidner@phytec.de>,
	Wadim Egorov <w.egorov@phytec.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH v2 0/2] Add Phytec i.MX93 Segin support
Date: Wed, 17 Jan 2024 08:49:09 +0100
Message-ID: <20240117074911.7425-1-othacehe@gnu.org>
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

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
Changes in v2: 
- Remove useless line
- Add missing reserved-memory entries

v1: https://lore.kernel.org/linux-devicetree/20240116113939.17339-1-othacehe@gnu.org/

Mathieu Othacehe (2):
  dt-bindings: arm: fsl: Add i.MX93 PHYTEC with Segin
  arm64: dts: imx93-phycore-segin: Add Phytec i.MX93 Segin

 .../devicetree/bindings/arm/fsl.yaml          |  6 ++
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../dts/freescale/imx93-phycore-segin.dts     | 93 +++++++++++++++++++
 .../boot/dts/freescale/imx93-phycore-som.dtsi | 64 +++++++++++++
 4 files changed, 164 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phycore-segin.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi

-- 
2.41.0


