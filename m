Return-Path: <linux-kernel+bounces-126669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ADF893B3F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B471C209AC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4153A3F8C2;
	Mon,  1 Apr 2024 13:11:54 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB463E495;
	Mon,  1 Apr 2024 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711977113; cv=none; b=cQ324q6b83Ps7nBGe8ikpk2wG2C82XyLTaogn6xLilh0u6BKB4axb6O1WzF6KHFZnQVZ4131AlTxuhmSp4/DsxAD5ORZdS+yLDMZqXn3ieILXVFr73FdQe0C24Uv0rHqig30fWgsUVMpXAgrnmplBV/7zrC1U/+YdVZqB9HoY2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711977113; c=relaxed/simple;
	bh=/xRbQyEj49OzBik80PzEYVfra1poW7CuE+P7YJUgUhA=;
	h=From:To:Subject:Date:Message-Id; b=eKngOXXCKPVO7VJ8x+t6GDorZvV14TcSRg+uahQd3LNi758i447klrYuIOSUyglbuGhLZuFlvRU0fPazwl82wWEyg/noX8P0RV48OqwiTIwvmDYs2wHpO5MqIxobQ8ZRqLR3NieCToI2JWe6HMVYawAzjdN2XxUzCfNjME3i8To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 68AE81A0138;
	Mon,  1 Apr 2024 15:11:45 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D2161A00F8;
	Mon,  1 Apr 2024 15:11:45 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0A6E9180031D;
	Mon,  1 Apr 2024 21:11:42 +0800 (+08)
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
Subject: [PATCH v2 0/2] ASoC: dt-bindings: convert fsl-asoc-card.txt to YAML
Date: Mon,  1 Apr 2024 20:54:14 +0800
Message-Id: <1711976056-19884-1-git-send-email-shengjiu.wang@nxp.com>
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

changes in v2:
- update commit message for reason why add compatible strings
  which are not in txt file.
- add deprecated
- add $ref for bitclock-master and others.

Shengjiu Wang (2):
  ARM: dts: imx6sx-nitrogen6sx: drop incorrect cpu-dai property
  ASoC: dt-bindings: fsl-asoc-card: convert to YAML

 .../bindings/sound/fsl-asoc-card.txt          | 117 -----------
 .../bindings/sound/fsl-asoc-card.yaml         | 195 ++++++++++++++++++
 .../boot/dts/nxp/imx/imx6sx-nitrogen6sx.dts   |   2 +-
 3 files changed, 196 insertions(+), 118 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml

-- 
2.34.1


