Return-Path: <linux-kernel+bounces-111292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7DD886A47
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98638281FCF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D873D0D9;
	Fri, 22 Mar 2024 10:30:18 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D82F2837E;
	Fri, 22 Mar 2024 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103417; cv=none; b=q+uKc3k1fFypqFG2CK9UaXWKsCGl+Ri08Yk3vQxNBRHeOAxcvnjqnkbvHCIJv+cmVanTGLQBgewkavwyQeiefPwEn5Ecgh8RZmosbGx4KzyuZoJ2KsxaEBISVXjWkpP+pr8WCkkTAtcsRk23MWSf2wD5UnLEVGRm8/wd3MA3BI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103417; c=relaxed/simple;
	bh=GUtmXf9WlmO3w758QqnC1fkxggOvB6pRAawA1GBYSW0=;
	h=From:To:Subject:Date:Message-Id; b=nuQvAlfw4PtMamtR6mn/AQ83oVqUxVTnyFXxtvTQ0N2j430kaF9L+Jz3AO7EWfguDN0go3YGe5nQY+FbJQIVARdOfZBlKxXCgOyrwoiLcN3v1NK/xZf1BuqRTvlz7lAy3/hw6j+GWoWglOzH4t6veNeHVbr452AjAFnLv6LxI5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3F5FF200FED;
	Fri, 22 Mar 2024 11:30:09 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DF9F6200F42;
	Fri, 22 Mar 2024 11:30:08 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A235D183AD25;
	Fri, 22 Mar 2024 18:30:06 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] ASoC: dt-bindings: convert fsl-asoc-card.txt to YAML
Date: Fri, 22 Mar 2024 18:13:24 +0800
Message-Id: <1711102406-8399-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Convert fsl-asoc-card.txt to YAML. In order to pass the checking,
add some used compatible string from devicetree.

change cpu-dai in imx6sx-nitrogen6sx to ssi-controller.

Shengjiu Wang (2):
  ASoC: dt-bindings: fsl-asoc-card: convert to YAML
  ARM: dts: imx6sx-nitrogen6sx: drop incorrect cpu-dai property

 .../bindings/sound/fsl-asoc-card.txt          | 117 -----------
 .../bindings/sound/fsl-asoc-card.yaml         | 196 ++++++++++++++++++
 .../boot/dts/nxp/imx/imx6sx-nitrogen6sx.dts   |   2 +-
 3 files changed, 197 insertions(+), 118 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml

-- 
2.34.1


