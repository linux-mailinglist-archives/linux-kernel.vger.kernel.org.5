Return-Path: <linux-kernel+bounces-151172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 460378AAA98
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C8A1F21FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8F85FBB7;
	Fri, 19 Apr 2024 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W9wbNZFy"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686F71E491;
	Fri, 19 Apr 2024 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515712; cv=none; b=SDqxcjsaVJoADBjf3Rd9rL3nxCjpfYJY9bysGPZybShB1CGraLbde0HOcZjGQFUuwRqF2fbx5n7y9k460IER8moEcEMltcSHy4VHQGpsmroNwJcmn14NPNH+COtL0GW1/jApt0Pj+OpEvo35k4i+8dilrIbRgG53AFfXh7dJbqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515712; c=relaxed/simple;
	bh=E74CnEKmUiAofd7Vw3r+H0pSGSYwvrUfM/v6KUFb/oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TWvy70UZSApqfu9UJDJorWOBOcdwbeGWGJASgYax4i8USWtw9a706hgNUZlXJ8x0UOzWCRtuY2e1+nz18XoBSdi6S0i1+E3Lfx/m7Aa6B3MA7QF36hlpVtiiBBlmEwh1QeVFsuIiM9L9dCMXg9DR+afhUwQ6gRhwVyY+fAfS1k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W9wbNZFy; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 112FFE0009;
	Fri, 19 Apr 2024 08:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713515701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nICPpCLJljxq/VvQIiROTOswZiBYVcdMhlPW8voWJvE=;
	b=W9wbNZFyLncopXLCrE5ybyzcaL6d/gk9bnPBLv2HQ4rRyNCeUjH1zPh7zIFVrUPKUaMvub
	CQE+2im5aq9A47VWnb0gRHqGPq0h+MGOx24vpj9EB3+A3E9ZQBINglAQpe8uzWjPuhXGbJ
	+hcOs2k7YDBXanL9fCNB9yC7eswhJnlf2mHXPUwPtKvJV7f1Nc2eyhvs5ITt64csYRA3s+
	QQ1PI6jWrR9dQc4h04bViXlEY7HMxy08uaFnzElD3pxTFxi1SH2WhlMYxfztvdcHAKmTuW
	Z9uoI5NQsIhfC0Loasue7YcLRLaYU0/Nzd6b02KQ6CVmCWC3h9aELDrmpcqRkw==
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
Subject: [PATCH v10 0/3] Input: Add TouchNetix axiom touchscreen driver
Date: Fri, 19 Apr 2024 10:33:38 +0200
Message-ID: <20240419083342.61199-1-kamel.bouhara@bootlin.com>
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

--
Changes in v10:
 - Set regulators as required
 - Enable power supply before reset
 - Fix ref count due to regulator requested twice
 - Rebase on v6.9-rc4

Changes in v9:
 - Fix issue reported in https://lore.kernel.org/oe-kbuild-all/202402201157.BKo97uWl-lkp@intel.com/
 - Rebase on v6.8-rc2

Changes in v8:
 - Fix missing call to input_report_slot_state()
 - Fix issue reported in https://lore.kernel.org/oe-kbuild-all/202402020623.8T1Ah513-lkp@intel.com/

Changes in v7:
 - Remove startup time from dt-binding
 - Fix usage table not correctly populated

Changes in v6:
 - Fix missing unevaluatedProperties.in dt-binding
 - Use __le16 to correctly deal with device endianness
 - Use standart kernel types s/char/u8/
 - Use regmap api as driver might support spi later
 - Use get_unaligned_le16() for the sake of clarity
 - Use devm_regulator_enable_optional()

Changes in v5:
 - Fix wrong message constructed in axiom_i2c_read
 - Delay required between i2c reads is >= 250us
 - Do not split report reading in two phases as we'll
   have to wait 500us
 - Use lower-case in properties names
 - Make regulators properties are required in dt-binding
 - Fix bug report: https://lore.kernel.org/lkml/202312051457.y3N1q3sZ-lkp@intel.com/
 - Fix bug report: https://lore.kernel.org/lkml/6f8e3b64-5b21-4a50-8680-063ef7a93bdb@suswa.mountain/

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

Changes in v3:
 - Remove irq-gpios property in dt-binding
 - Use a generic node name
 - Fix issues reported in https://lore.kernel.org/oe-kbuild-all/202310100300.oAC2M62R-lkp@intel.com/

Changes in v2:
 - Add device tree binding documentation
 - Move core functions in axiom_i2c as we only care about i2c support now
 - Use static function when required
 - Use syntax dev_err_probe()
 - Add an hardware based reset

Kamel Bouhara (3):
  dt-bindings: vendor-prefixes: Add TouchNetix AS
  dt-bindings: input: Add TouchNetix axiom touchscreen
  Input: Add TouchNetix axiom i2c touchscreen driver

 .../input/touchscreen/touchnetix,ax54a.yaml   |  62 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   8 +
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/touchnetix_axiom.c  | 659 ++++++++++++++++++
 6 files changed, 744 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml
 create mode 100644 drivers/input/touchscreen/touchnetix_axiom.c

--
2.25.1


