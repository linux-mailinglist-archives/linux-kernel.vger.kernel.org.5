Return-Path: <linux-kernel+bounces-38980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AA783C94E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9141C268F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA3913175A;
	Thu, 25 Jan 2024 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J1Oo/a2K"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF4130E53;
	Thu, 25 Jan 2024 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201915; cv=none; b=dXXAb5OZB1t3rc9TBRuR0IGqvSFwdpy3JE6Lu7Shiu1jt2DuOQZhz4VdKqFFlHE/tpiMVgfv1Kk0PGt55yqVvWTAR0wgexwmc7WjPyZEZ5QewVBemG3Fa4+OK3oYKWhdh/m/id5xjwt1aJgM7z3cXos/fYNg6cVdpbx0YPmQqKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201915; c=relaxed/simple;
	bh=QRBuPbXAwINhQzLtUTftaUxhVpdA/iChm/wqx17zvRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nAdZpC8cRnIDY1vNyQqbIKYehDvv9GoOAZTrT3BeGxg2joJOCa4RJo28Cmn3vsU5hOVcJXAuMUPRzqgUQIIXsNpAyrCM7zJDieNqKo/9p8/l/9cfYCLavm17C4HwSsbycCHM/lNc8GrcIHy7mHTnHU1iE6kE44IRcJMgkxjZb5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J1Oo/a2K; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 126C4240005;
	Thu, 25 Jan 2024 16:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706201909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CfYnpqPBAd2xHwgJxsRg8c6biWK5zlf195w2E1yhLik=;
	b=J1Oo/a2Kiw7RMpwfVrwqLiP2iOOdJm6E6Hiysqi6YLm+L0FkTvbYeYeo7Sp7DfbEypaE7d
	rarBQX9k0/socUCdZw/CPu4r01rORp0dXSKkNLF28bfoYC+ysjaPdIyc8Fu28JYOkQHrOS
	H0u4wieWTJO5EaYTn1Of69DagpDbNWxFkwfNc8HFX5Wp6mW8inJ/eCzsEAHA4cgQTGnqN0
	xt61uhqwoVZeOhEWiCHE+9WtkEk5vpmp/5PTumafr4sAuFil8sbdmdP+lLWKJPBGaPnufY
	cWTpqOELEMSUnvbR29NMF0UyHjQuQHalzp2MIboNQ5qQrzwP2lXI6hhe6ugNlA==
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
Subject: [PATCH v6 0/3] Input: Add TouchNetix axiom touchscreen driver
Date: Thu, 25 Jan 2024 17:58:19 +0100
Message-ID: <20240125165823.996910-1-kamel.bouhara@bootlin.com>
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

---
Changes in v2:
 - Add device tree binding documentation
 - Move core functions in axiom_i2c as we only care about i2c support now
 - Use static function when required
 - Use syntax dev_err_probe()
 - Add an hardware based reset

Changes in v3:
 - Remove irq-gpios property in dt-binding
 - Use a generic node name
 - Fix issues reported in https://lore.kernel.org/oe-kbuild-all/202310100300.oAC2M62R-lkp@intel.com/

Changes in v4:
 - Cleanup unused headers and macros
 - Use standard kernel type
 - Namespace structures and functions
 - Use packed struct when possible to avoid bitfield operators
 - Fix missing break when address is found in axiom_populate_target_address()
 - Split reads in two steps for the reports, first length then report
   itself so we only read required bytes
 - Get poll-interval from devicetree
 - Add VDDI/VDDA regulators
 - Add a startup delay of 110 ms required after VDDA/VDDI is applied
 - Remove axiom_i2c_write() as it is no more used

Changes in v5:
 - Fix wrong message constructed in axiom_i2c_read
 - Delay required between i2c reads is >= 250us
 - Do not split report reading in two phases as we'll
   have to wait 500us
 - Use lower-case in properties names
 - Make regulators properties are required in dt-binding
 - Fix bug report: https://lore.kernel.org/lkml/202312051457.y3N1q3sZ-lkp@intel.com/
 - Fix bug report: https://lore.kernel.org/lkml/6f8e3b64-5b21-4a50-8680-063ef7a93bdb@suswa.mountain/

Changes in v6:
 - Fix missing unevaluatedProperties.in dt-binding
 - Use __le16 to correctly deal with device endianness
 - Use standart kernel types s/char/u8/
 - Use regmap api as driver might support spi later
 - Use get_unaligned_le16() for the sake of clarity
 - Use devm_regulator_enable_optional()

Kamel Bouhara (3):
  dt-bindings: vendor-prefixes: Add TouchNetix AS
  dt-bindings: input: Add TouchNetix axiom touchscreen
  Input: Add TouchNetix axiom i2c touchscreen driver

 .../input/touchscreen/touchnetix,ax54a.yaml   |  67 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/touchnetix_axiom.c  | 664 ++++++++++++++++++
 6 files changed, 753 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml
 create mode 100644 drivers/input/touchscreen/touchnetix_axiom.c

--
2.25.1


