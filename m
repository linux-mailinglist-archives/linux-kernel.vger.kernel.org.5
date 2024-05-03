Return-Path: <linux-kernel+bounces-167766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD46D8BAEE8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1DB1F21220
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6394A154C10;
	Fri,  3 May 2024 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pIR7mFhE"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F51215533F;
	Fri,  3 May 2024 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746084; cv=none; b=kZUyrxAgahzppY4S/d6q7/eXg97X6pMVCPL8H+WMQFybxXdRIpQcf0VFSyaff6TJ13r7oCOj5DxIGjFD74XLbc6Olo9gxtu6Hvd6iDR6TNx7cxk99KoKX8rl9Z49oiHxKo9sGb/cBndUTQ5922UQluvik5ZlgP/yWcu2C/wPga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746084; c=relaxed/simple;
	bh=GKyULpFQ8XdXBuxIrhlYdZanY0FdS+QQ7EcrusQWFb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cZQC1T1sQJFxLn+uQZSF/w1G8XLX2b7E4qDK5MEqBYX2dGhl5WMyoKlAiSr+zobUo5jbgKQpTYNCY8EBWqDPUgpsC0YRNXqDF99S5sZ2ReH+PiuelPUf1sZ2lRb3lHVzkrOfMTG6pVlLAgb2pRI6ACehi25DM8GizBAluVBDFys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pIR7mFhE; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E08FCE0015;
	Fri,  3 May 2024 14:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714746073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OzhF3QerqK8gGgB0VM7veINqFbrG/m5c23SAtCZCPxg=;
	b=pIR7mFhEN2TsFj6ass3sIkF8Ho+HSimoByULbPGQJWQIR14DrB6ySpVVNbUrmXK9IDvtJB
	2rVGfkDT+08jPH8Rf5/CMJBsV2vUhFqt9lnnbpqe9HM9sjX9LHR4AxIE/NZZm0YrA8nlyd
	H2Se5M1jhq2mHGOjzCBNkB+8Ww817RiMB7Ef+f3v7wICO9ASh4c7KvrCImSHUAppCbb5Hw
	93ftOr1R9zZs3fypr66M+Ko6gzFZ2rawNBUZGwdEKKp/I3GtD+53o0nMlY9+hWdSjLkqh/
	UZieEy/zbyA4u28OWeZMRBMswmZFO2VzmDEoxLiOuaQfyR5xK+l0D7Ya4MxOyQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 03 May 2024 16:20:50 +0200
Subject: [PATCH v2 05/11] mfd: Add cell device name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240503-mbly-olb-v2-5-95ce5a1e18fe@bootlin.com>
References: <20240503-mbly-olb-v2-0-95ce5a1e18fe@bootlin.com>
In-Reply-To: <20240503-mbly-olb-v2-0-95ce5a1e18fe@bootlin.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Lee Jones <lee@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Current device name is picked from pdev->name, coming from cell->name.
pdev->name is sometimes used to match driver so cannot be changed.
Add cell->devname field to let MFDs configure their sub-devices names
using newly introduced platform_device_add_with_name().

This comes in handy when MFDs instantiate the same platform driver.
First solution is to use auto IDs:

	// MFD device A generates sub-device named "foo.0.auto"
	struct mfd_cell cell = { .name = "foo" };
	mfd_add_devices(dev, PLATFORM_DEVID_AUTO, &cell, 1, ...);

	// MFD device B generates sub-device named "foo.1.auto"
	struct mfd_cell cell = { .name = "foo" };
	mfd_add_devices(dev, PLATFORM_DEVID_AUTO, &cell, 1, ...);

An alternative is to manually pick IDs using cell->id:

	// MFD device A generates sub-device named "foo.0"
	struct mfd_cell cell = { .name = "foo", .id = 0 };
	mfd_add_devices(dev, 0, &cell, 1, ...);

	// MFD device B generates sub-device named "foo.1"
	struct mfd_cell cell = { .name = "foo", .id = 1 };
	mfd_add_devices(dev, 0, &cell, 1, ...);

Devices still have obscure names. With changes, two MFD devices can do:

	// MFD device A generates sub-device named "foo-a"
	struct mfd_cell cell = { .name = "foo", .devname = "foo-a" };
	mfd_add_devices(dev, PLATFORM_DEVID_NONE, &cell, 1, ...);

	// MFD device B generates sub-device named "foo-b"
	struct mfd_cell cell = { .name = "foo", .devname = "foo-b" };
	mfd_add_devices(dev, PLATFORM_DEVID_NONE, &cell, 1, ...);

Device names are explicit and facilitate identification.
Benefit increases with more instances.

No shorthand MFD_CELL_*() macro is created to exploit this field.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/mfd/mfd-core.c   |  2 +-
 include/linux/mfd/core.h | 19 ++++++++++++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 6ad5c93027af..bdfbe860295a 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -271,7 +271,7 @@ static int mfd_add_device(struct device *parent, int id,
 	if (ret)
 		goto fail_res_conflict;
 
-	ret = platform_device_add(pdev);
+	ret = platform_device_add_with_name(pdev, cell->devname);
 	if (ret)
 		goto fail_res_conflict;
 
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index e8bcad641d8c..a2040372ca91 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -14,7 +14,8 @@
 
 #define MFD_RES_SIZE(arr) (sizeof(arr) / sizeof(struct resource))
 
-#define MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, _of_reg, _use_of_reg, _match) \
+#define MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,	\
+		     _of_reg, _use_of_reg, _match, _devname)		\
 	{								\
 		.name = (_name),					\
 		.resources = (_res),					\
@@ -26,25 +27,26 @@
 		.use_of_reg = (_use_of_reg),				\
 		.acpi_match = (_match),					\
 		.id = (_id),						\
+		.devname = (_devname),					\
 	}
 
 #define MFD_CELL_OF_REG(_name, _res, _pdata, _pdsize, _id, _compat, _of_reg) \
-	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, _of_reg, true, NULL)
+	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, _of_reg, true, NULL, NULL)
 
 #define MFD_CELL_OF(_name, _res, _pdata, _pdsize, _id, _compat) \
-	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, 0, false, NULL)
+	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, 0, false, NULL, NULL)
 
 #define MFD_CELL_ACPI(_name, _res, _pdata, _pdsize, _id, _match) \
-	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, 0, false, _match)
+	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, 0, false, _match, NULL)
 
 #define MFD_CELL_BASIC(_name, _res, _pdata, _pdsize, _id) \
-	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, 0, false, NULL)
+	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, 0, false, NULL, NULL)
 
 #define MFD_CELL_RES(_name, _res) \
-	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, 0, false, NULL)
+	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, 0, false, NULL, NULL)
 
 #define MFD_CELL_NAME(_name) \
-	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, 0, false, NULL)
+	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, 0, false, NULL, NULL)
 
 #define MFD_DEP_LEVEL_NORMAL 0
 #define MFD_DEP_LEVEL_HIGH 1
@@ -118,6 +120,9 @@ struct mfd_cell {
 	 */
 	int			num_parent_supplies;
 	const char * const	*parent_supplies;
+
+	/* Optional struct device name. */
+	const char		*devname;
 };
 
 /*

-- 
2.45.0


