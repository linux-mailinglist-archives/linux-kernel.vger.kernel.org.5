Return-Path: <linux-kernel+bounces-136524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4691289D520
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D745C1F22ABF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510A67F474;
	Tue,  9 Apr 2024 09:08:30 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A657E792;
	Tue,  9 Apr 2024 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653709; cv=none; b=orCTJDug71mMsBQGrJ7clEuVnv0bVu8Z0AJGr9JAm1X6Erk0aLj7cboGxiFjEgo4OrXZvI9RYSOAxDipYLvUlVWRnqpNEnAioCFoPPMNKyJYE0k/+8M6FEmkAF2nT7vZcoX1bAQvE3wZaw0BMukq8mITgtdSRT9ot4H7FETs3ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653709; c=relaxed/simple;
	bh=JY67xaP9uwTUCNVOYThDoay+Y3QXMVsFqRJk67Zi1to=;
	h=From:To:Subject:Date:Message-Id; b=it0p1oaoc/lya0V//aV+NlD5DRzlRhCy8eYNOaJ/40Y2tmERDzDy7H+/2be9HBaNuDtuVgk4qEfJiAfFPLCalwGCjppaPjg+09AxpR60p10twKFvfvryNSb5vprap28vFC1t21yH6n8XN16vOHXKhZCdm9sDfeLlmCsaXGWn1DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8650B2016AA;
	Tue,  9 Apr 2024 11:08:21 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4E8BF20077B;
	Tue,  9 Apr 2024 11:08:21 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 714DC1834898;
	Tue,  9 Apr 2024 17:08:19 +0800 (+08)
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
Subject: [PATCH v3 0/2] convert imx-audio-spdif.txt to YAML
Date: Tue,  9 Apr 2024 16:50:42 +0800
Message-Id: <1712652644-28887-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

convert imx-audio-spdif.txt to YAML

changes in v3:
- change file name to fsl,imx-audio-spdif.yaml
- change example name back to sound-spdif
- exchange the fallback and specific compatible string
- update anyOf content

changes in v2:
- change file name to imx-spdif.yaml
- remove |
- add anyof for spdif-in and spdif-out requirement
- change example name to sound

Shengjiu Wang (2):
  ASoC: dt-bindings: imx-audio-spdif: convert to YAML
  ARM: dts: imx6: exchange fallback and specific compatible string

 .../bindings/sound/fsl,imx-audio-spdif.yaml   | 67 +++++++++++++++++++
 .../bindings/sound/imx-audio-spdif.txt        | 36 ----------
 .../boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi   |  4 +-
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi     |  4 +-
 4 files changed, 71 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-audio-spdif.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/imx-audio-spdif.txt

-- 
2.34.1


