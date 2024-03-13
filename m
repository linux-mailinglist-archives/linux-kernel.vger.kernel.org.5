Return-Path: <linux-kernel+bounces-102253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA70387AFD7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61F8286686
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D3080C0C;
	Wed, 13 Mar 2024 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XzCOUfBo"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF880BF8;
	Wed, 13 Mar 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350434; cv=none; b=JACVuMlDRmAlTV5bsO9x8zPWcOIfETfFHRrZh1VoijhC8XrrbMbHSuqozGNS2uSfQWx7oem/GFXPnHJS/s3dGijju5r996qLZxmHZqy+DgVeOdcnoA4i5WNuJBKWM0dVmqFpmJI6ZI3OVXuFu5LYUtnU43dsJSPL+81vt9/Gy7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350434; c=relaxed/simple;
	bh=PDm1SItksNTofzuQzI9fFJVVPjchoKbvQNAAeFJDhCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=p3foFi9rXcKluMB9dAGpsNtXcjHQApBQ4RV+CZMdgtyXU194w4hJ5piZIDShJz2VbmNNDrx/d6S7sVSKgI6H9F55diwAEb6z2VVNH0GpKbuT+B65btYZUIBHTCl9akeq3R85pVxkSj+l70dV/fS5VEwGWsA8lApRR4rnIxafEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XzCOUfBo; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5DB3F60006;
	Wed, 13 Mar 2024 17:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710350424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ALphmlMJMXjWnAezL6iQbzO6NFcgXvLJ93zEeDxPP/U=;
	b=XzCOUfBojPliqqGwG1/5px2zHXOyYoIR/4C1B1yPMLdF7qEWnMYdFt4z/1HIsFAqcxeDvx
	Zy9vGtzScRdZWrE7j7c0bXfyHSvdwI7wTyy+qKmOduy/ZrZrszkFMy4mHaYeTJ8/0SjQ6B
	17GYllEJHIa6Uzw689W0CsL3NMIyhxdj8uwuv6yik/py/xGZT+PBqVUhqnqeHjAFtyF4wk
	e62DR3CjOjZpMfucaK7jU5krKYBRwJT9EQccEeFb7ZLa+1E3dSa/7Ujs/1P5My7S7gvLk6
	ya937VFo1pWt690F3jkENDIcGaU2ksgtB0FkpZROdD3+Rchd0/8RNzUOX804HQ==
From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
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
Subject: [PATCH v3 0/3] panel-simple: add support for Crystal Clear CMT430B19N00
Date: Wed, 13 Mar 2024 18:20:13 +0100
Message-Id: <20240313172016.387277-1-jeremie.dautheribes@bootlin.com>
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

Changes in v3:
  - PATCH 3/3: use display_timing structure instead of display_mode
  structure as suggested by Maxime Ripard.
  - Link to v2: https://lore.kernel.org/all/20240304160454.96977-1-jeremie.dautheribes@bootlin.com/

Changes in v2:
  - add link to the Crystal Clear Technology website in commit message, as
  suggested by Conor Dooley and Neil Armstrong.
  - Link to v1: https://lore.kernel.org/all/20240223134517.728568-1-jeremie.dautheribes@bootlin.com/

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

