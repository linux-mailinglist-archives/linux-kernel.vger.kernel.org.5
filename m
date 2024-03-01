Return-Path: <linux-kernel+bounces-88263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3395386DF5D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54B428733C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43F76CBE2;
	Fri,  1 Mar 2024 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EKF8ADaE"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9A96A8BB;
	Fri,  1 Mar 2024 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289562; cv=none; b=VK+MFOsW2Ziy+v+jbUEeXp5HXnQdIC7aSpIvApJe17qGaGEhDrYGEhsiDd6Hvx21gK1l32AJAN53LOy3tq4nJP65oRfr0vKWOLA7ITGJT3PE0etxnZhPdA709zjuA60J6bSF0btnHDJNkPFEEd/drEqqTDufYfrSdvbe1ruF+6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289562; c=relaxed/simple;
	bh=QPg/h26ctDiEjOy4/uODxhaeiQTEE5tf2aqedWIaU3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UU+IiQbJLkmSezAE2gcASdwmwUUyQzVzQfd3sm6l9f+8RckQtzxx5D/8M4b2AzoiT5Abv8WYVDUPlhKDT2+d9gRRNH9Pjrm/3K9kaUsoLrgdZZrb9BTQ1JtUMxeUNicTt94Els8Qz4F881iaJAG4KY5EBLCZzCyC2c37+VQL16g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EKF8ADaE; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF50AFF802;
	Fri,  1 Mar 2024 10:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709289552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YKEiVtaPCvaI11wI4SOmpa0aMH7IZX/eMbHt5I4oNlE=;
	b=EKF8ADaEuw22Uc7j7+xbS62ttfxCDzDtoU/K1b0vsdoMydyOeiwUT16aUa7mUx2KW5++MJ
	dYfgP53PqNVCKmq6CPRyvhL2NyBg9gVP26rnYLl2oy9UlicEulvtWIiPnSEJzpLIIBPyrr
	mRLsuKCWPH/Qj6p+6HJIbIEcHsmoytk6sl7u53nbijsUR1ypmaBserD5Z2YcqjWkInMYPm
	fEIYFjZwRsZfzed+LRCqtyJ7KpSNjMeqpC0u+zgKftPRn9zvGiTniHFZXYyqwNWLc8ZpHZ
	bP5S0VaGmmLPl1JB1fyDRR0E5PpVnI6n2MLjwTB7UweVlhO8oQGUD+OVwh4YVQ==
From: Kamel Bouhara <kamel.bouhara@bootlin.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	Jeff LaBundy <jeff@labundy.com>
Cc: catalin.popescu@leica-geosystems.com,
	mark.satterthwaite@touchnetix.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	bsp-development.geo@leica-geosystems.com,
	Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH v9 0/3] Input: Add TouchNetix axiom touchscreen driver
Date: Fri,  1 Mar 2024 11:39:05 +0100
Message-ID: <20240301103909.167923-1-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kamel.bouhara@bootlin.com

Add a new driver for the TouchNetix's axiom family of touchscreen
controller. This driver only support i2c and can be later adapted for
SPI and USB support.

Kamel Bouhara (3):
  dt-bindings: vendor-prefixes: Add TouchNetix AS
  dt-bindings: input: Add TouchNetix axiom touchscreen
  Input: Add TouchNetix axiom i2c touchscreen driver

 .../input/touchscreen/touchnetix,ax54a.yaml   |  62 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/touchnetix_axiom.c  | 669 ++++++++++++++++++
 6 files changed, 753 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml
 create mode 100644 drivers/input/touchscreen/touchnetix_axiom.c

--
2.25.1


