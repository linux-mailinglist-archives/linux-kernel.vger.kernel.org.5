Return-Path: <linux-kernel+bounces-90893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDE087067A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4153D1F2876F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8820482FA;
	Mon,  4 Mar 2024 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D+Bnopxs"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7D045BFD;
	Mon,  4 Mar 2024 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568303; cv=none; b=D0cgCsE3k/f5w71mT/JYwBzr4Z+atNJB79q85jRRRYun49cAG7eOhhyeGCdb/SwgtjO1e7Xa7JvRB5Yhz8WRhauxN2qTDAJSOop67fKKh15TiQHgX0iSqjLdierTWj5B4Zu9t8d/VQPrxyTVwB8RzWrIavMLmRRX4Bu5DGkKfdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568303; c=relaxed/simple;
	bh=zFlzEyEMelAkPlhhW25P9azIzvu2zXIbYhy7TywgiXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=e4Ul8gsZaTMj3LKlfKK2Y3aXinm+0KgayZHIOA9g+gxKrITMs+FaK4faGntH5PnUo1AitlsXUeh4JzzLhwEC1JLWnHlxAoKAgvGbc10NomZHrEjIrXBDMUzBOJHaN1vZUp0VNcNvui97aMcHwuOAFtaF+EL/zQ3Heq+GgJxgpH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D+Bnopxs; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 05C2C2000E;
	Mon,  4 Mar 2024 16:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709568298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5HjvZ8bAGgifY3eTK7LXsl9FpYoYdN647B10jGDP7K8=;
	b=D+BnopxsXBnbZak9Qze90dyIXLh9bzRC5kChwt0OkEfAqcaTqbXiO39lXpep1oCC6s3u6+
	37fktsm0dJKMUTMQYIbVUuwkRoq/4Xf7V7qojd2r+CfZPGD75mdALGN5oGQ/6wf8FwBYgi
	zZJIGDQwNeEDGg25fRHtBR2A3T28hjZ7fxSjEbffSwUl4X8Oi8CUiZEMzhSdAvbOtNLhMP
	1AvYm+LsI3Szi1t6TiYu9+xUiYX2Pok9xnxzI9wEdprMrWOJa894A5JFN1AmSfhvhtTaxR
	Thee1m4peaHTuQbqOfwU/aWjk7dLaeDOA52fVF3TG4xPlgZP6Bm3xs6vHu2J4g==
From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>,
	=?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
Subject: [PATCH v2 0/3] panel-simple: add support for Crystal Clear CMT430B19N00
Date: Mon,  4 Mar 2024 17:04:51 +0100
Message-Id: <20240304160454.96977-1-jeremie.dautheribes@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeremie.dautheribes@bootlin.com

Hello everyone,

This patch series add support for the Crystal Clear Technology
CMT430B19N00 4.3" 480x272 TFT-LCD panel.
It also adds Crystal Clear Technology to vendor-prefixes.yaml.

Please note that unfortunately there is no public datasheet available
for this panel.

Changes in v2:
  - add link to the Crystal Clear Technology website in commit message, as
  suggested by Conor Dooley and Neil Armstrong.


Regards,

Jérémie

Jérémie Dautheribes (3):
  dt-bindings: Add Crystal Clear Technology vendor prefix
  dt-bindings: display: simple: add support for Crystal Clear
    CMT430B19N00
  drm/panel: simple: add CMT430B19N00 LCD panel support

 .../bindings/display/panel/panel-simple.yaml  |  2 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 drivers/gpu/drm/panel/panel-simple.c          | 29 +++++++++++++++++++
 3 files changed, 33 insertions(+)

-- 
2.34.1
---
- Link to v1: https://lore.kernel.org/all/20240223134517.728568-1-jeremie.dautheribes@bootlin.com/


