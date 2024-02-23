Return-Path: <linux-kernel+bounces-78413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47604861322
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F063128483B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B15811F1;
	Fri, 23 Feb 2024 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gTEy0rkq"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5F222EF5;
	Fri, 23 Feb 2024 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695927; cv=none; b=BMqazJzPe41FGSw0TSvOh21iUYhVaozEUe6ZZP0bC6xXy9c2rPyTk4JPP1R8HK+xvF5KslmjDzUaO0ILZsHJEt53P3hFRJYwSEmrgNTZQA1KLV9AXGATQ1mZqejwQbzrnB3twcoZwQ5rH9i/hH2I5oJATflb3qrRPBdoRJuWBkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695927; c=relaxed/simple;
	bh=BRMLvWZAkwfvmzNdxcA/tAyZT746eUsrCBZxYm35vGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NIPinSNbiCumDu/NdBBwQVev00GUhpMESDlFgWrBTAuqP21FbQI7UzsyqkY8v/Swv/KEc8y2hI//CnJbbNjLxW3x7+Wls+y5VCQJ3XinCnaVa5G7EwH9l7gV1m3jwmxdlsUX4ZMcowGsteXskvvEPKc7inMaeO0R8E4UTV05vCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gTEy0rkq; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0367A240003;
	Fri, 23 Feb 2024 13:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708695922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CUmJ2G7CxGQ9gN41KMMicO2/OzO2sVyAXn0vq+YQnEs=;
	b=gTEy0rkq6UYMGwiZTZ19b5bAZM7P5MtNF/JcL+z+6Id31uzQKxvukzqG7INnoxfz/hE5sA
	gaA0JXFzwJnX2ADB4KKpOMNs4M0hpULTxM41eZpR24F2rlTwo6CJgZB0TdIHf3L8tWamS+
	QY90FjXIpmXfsmZ5N2xJyi3tXgmV1xH9x1eVF1ptspNhFQuZhd0LQ0RzOnEP5ffJJRNlZU
	C+6pBhjcdfpt5G8PpRZUWjpQ+q+BWGXofYRijBLTb0hMpDr/Dz2w8Tbt8koOuPF9k2nDqe
	EF/kFHns6hbI75gpEdMbseAuPP5dJ/xhA6SXEQQPB890H+HatiGoKkddh4gciA==
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
Subject: [PATCH 0/3] panel-simple: add support for Crystal Clear CMT430B19N00
Date: Fri, 23 Feb 2024 14:45:14 +0100
Message-Id: <20240223134517.728568-1-jeremie.dautheribes@bootlin.com>
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

This patch series add support for the Crystal Clear Technology
CMT430B19N00 4.3" 480x272 TFT-LCD panel.
It also adds Crystal Clear Technology to vendor-prefixes.yaml.

Please note that unfortunately there is no public datasheet available
for this panel.

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


