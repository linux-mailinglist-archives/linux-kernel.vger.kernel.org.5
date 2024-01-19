Return-Path: <linux-kernel+bounces-30952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D72F8326B5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346D91F23E79
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2BC3C082;
	Fri, 19 Jan 2024 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="mnmDOAc4"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E41328B1;
	Fri, 19 Jan 2024 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705656532; cv=none; b=sHebXigJpRMu0kqkCnSVYRE75B1W0KTRbDZptjdJY7fX1BA3eyQhJOy6L9y0BWRztiIL9LXswdaDPe1gDNwbawutZo2O3GeZDeOROHT/JOFa6FSLiZle+RbLSGC7B9dossShyUWyzuXkv5g/nay4IPbrdAuTjQJfm/GV+l/RQSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705656532; c=relaxed/simple;
	bh=NdQ3+0idQ4VEBVxInZXoWw9HM1KV5HwZID15pPbWPdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GzyfUaJsxqCBaXPbnXOAIF8LsHM/k4M2U5VhHgUOZohWgKCrgmLHdcvci0HFbqrm/g29U0lgRK7EgcPIjpxwe5WnJAZ9uVOTbMijXw8uXBGVXSGkBOL00Uru5kCKD9qCarzBKcPLs7Ww+Cil7VEuKYHfdOm6U0a3UIkIRnVNOc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=mnmDOAc4; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rQlB6-0000hf-IU; Fri, 19 Jan 2024 04:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=wJfuih37FLTcNkZhqcOJIdV5KNB1TDrMH8T9HGmK5rA=; b=mnmDOAc4NUVmQ7
	l8Cq4wmuCLVQMLmjFgEJrUDTw4DQs2rP61lFmho48spdswjRgaSVaNtrKumoK4R4bQDDIBpRtgn92
	3ugay+qYhWm+hLXpD0Oc1BXm2mzB78vsbudoEHwqOHS2lP7mElW5ogVTECzUoVhS+yYnWqY8JTW6V
	K5zB+yLWjY/81H/qywTQ884ncc06DdOEssPXeePO/Fs4sXKBhM5A7imT9EjlcyhkT+qOpjWSI4G99
	5z7lRxIyRE7HtdIpswdyvv3h38rE1xCbzVgRpWyI92nT8IRxJCy+pgE8Qeh/cfOtfO7F/ER5hzv0c
	h9JtZ7j7JquZM0vUHnpQ==;
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
	upstream@list.phytec.de,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH v3 0/2] Add phyBOARD-Segin-i.MX93 support
Date: Fri, 19 Jan 2024 10:28:33 +0100
Message-ID: <20240119092835.21462-1-othacehe@gnu.org>
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

Thanks,

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
Changes in v3:
- Update documentation to match PHYTEC naming
- Remove useless properties
- Update pinmux from PHYTEC downstream kernel
Changes in v2: 
- Remove useless line
- Add missing reserved-memory entries

v2: https://lore.kernel.org/linux-devicetree/20240117074911.7425-1-othacehe@gnu.org/

Mathieu Othacehe (2):
  dt-bindings: arm: fsl: Add phyBOARD-Segin-i.MX93
  arm64: dts: imx93: Add phyBOARD-Segin-i.MX93 support

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-phyboard-segin.dts    | 119 ++++++++++++++++++
 .../boot/dts/freescale/imx93-phycore-som.dtsi |  56 +++++++++
 4 files changed, 182 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi

-- 
2.41.0


