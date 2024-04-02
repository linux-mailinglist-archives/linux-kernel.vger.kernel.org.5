Return-Path: <linux-kernel+bounces-127544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F38894D6B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C631F21DCE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963D33EA73;
	Tue,  2 Apr 2024 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DIF5AyiY"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BADF3B193;
	Tue,  2 Apr 2024 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046577; cv=none; b=N7FbnCIt5rQMtVxEPiv7pB+2Q6d7hCgz1tuiY855TvGsPp6LE/CAfkPjpLyjCEJD3pqovB0oMedPu0VhCqRcFysRGExpTIvAm44K66MZryxCgmEcjKzdUff85LN3VcqklEvEozwMPOF8MphO3flF3smwZCfcTzRUN5XH5VLtrXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046577; c=relaxed/simple;
	bh=GmMefZhlVWs8UvewqAUM1vNKBbI39elTksK1z5S6rLU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QYntYI4+kWctJ+UmKiVJxy7yK6wcX3c+OrojDAUjVOO/H/dGqpMzJ0ie7hC2vww5NuhkmNZmNc1vOelrMkHK0FBXz67rjj9CwOCiL2B+IlDOxwUydiW7hsHtFQEopung5BbNt2CRcAnfIj9JJ7Dl3Brnei7eQQpF23Lh+8PN+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=DIF5AyiY; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.118] (unknown [103.86.18.232])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BDF793A2;
	Tue,  2 Apr 2024 10:28:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712046537;
	bh=GmMefZhlVWs8UvewqAUM1vNKBbI39elTksK1z5S6rLU=;
	h=From:Subject:Date:To:Cc:From;
	b=DIF5AyiYT4EivV1CtPYpxPhpEmutiW4KpHyRMYUeH6lcOpOvE7Z6c7lCrzsO3YSLi
	 +KoG58LtEYnCutQvRi4ou9jydno1/f4KzaGYkoQXEjQq58c0fhA+M613Wyo0/fqjKY
	 DCf2HNf9rcAAmInv0gLdiZ3lDkn6zziDF8CcV1H8=
From: Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 0/3] media: i2c: Add imx283 camera sensor driver
Date: Tue, 02 Apr 2024 13:59:24 +0530
Message-Id: <20240402-kernel-name-extraversion-v1-0-57bb38de841b@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOTBC2YC/x3MQQqDMBBG4avIrB2YhCykVxEXqf5th2qUiYgQv
 Ltpl2/xvUIZpsj0aAoZDs26phqubWj8xPQG61SbvPggQTx/YQkzp7iAce4WD9gPsX9KN4XgIN1
 IlW+Gl57/dT9c1w3H4ZN1agAAAA==
To: Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Umang Jain <umang.jain@ideasonboard.com>, Rob Herring <robh@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712046569; l=2930;
 i=umang.jain@ideasonboard.com; s=20240402; h=from:subject:message-id;
 bh=GmMefZhlVWs8UvewqAUM1vNKBbI39elTksK1z5S6rLU=;
 b=wJhfjQoGUEQM/tsYN9p8rSqjUzpRLbnQh2ssgOiLkkfXqdZAIvktl//HiRChksi7vqtTqqa5I
 wA7FEYLXCTdCHC87kW3ZRfRM+FiQGODGBihF50/ot1swYdGHomB/pfI
X-Developer-Key: i=umang.jain@ideasonboard.com; a=ed25519;
 pk=8K9qSAtc2dNF4Ax+jYC0w9dlfptU7wxPBQwOy0nxRoc=

Add a v4l2 subdevice driver for the Sony IMX283 image sensor.
  
The IMX283 is a 20MP Diagonal 15.86 mm (Type 1) CMOS Image Sensor with
Square Pixel for Color Cameras.
    
The following features are supported:
- Manual exposure an gain control support
- vblank/hblank/link freq control support
- Test pattern support control
- Arbitrary horizontal and vertical cropping
- Supported resolution:
   - 5472x3648 @ 20fps (SRGGB12)
   - 5472x3648 @ 25fps (SRGGB10)
   - 2736x1824 @ 50fps (SRGGB12)

The driver is tested on mainline branch v6.8-rc2 on IMX8MP Debix-SOM-A.
Additional testing has been done on RPi5 with the downstream BSP.

Changes in v4:
- fix 32-bit build error around u64 divisions (use do_div)
- Fix hmax default and minimum values

Changes in v3:
- fix headers includes
- Improve #define(s) readability
- Drop __func__ from error logs
- Use HZ_PER_MHZ instead of MEGA
- mdsel* variables should be u8
- Use container_of_const() instead of container_of()
- Use clamp() used of clamp_t variant
- Use streams API imx283_{enable|disable}_streams (**NOTE**)
- Properly fix PM runtime handling
  (pm_ptr(), DEFINE_RUNTIME_DEV_PM_OPS,
   imx283_runtime_suspend, imx283_runtime_resume)
- Fix format modifiers, signed-ness at various places

changes in v2 (summary):
- Use u32 wherever possible
- Use MEGA macro instead of self defined MHZ() macro
- Properly refine regs using CCI
- Drop tracking of current mode. Shifted to infer from active state directly.
  (Laurent's review)
- Cont. from above: Pass the struct imx283_mode to functions whereever required.
- Remove unused comments
- Remove custom mutex. Use control handler one instead.
- Drop imx283_reset_colorspace() and inline
- Set colorspace field properly (drop _DEFAULTS)
- Use __maybe_unused for imx283_power_on() and imx283_power_off()
- Store controls  v4l2_ctrl handles for those required, not all.
- Drop imx283_free_controls(). Use v4l2_ctrl_handler_free
- fix reset-gpios handling and add it to DT schema
- fix data-lanes property in DT schema
- fix IMX283 Kconfig
- Remove unused macros
- Alphabetical case consistency

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
Kieran Bingham (1):
      media: i2c: Add imx283 camera sensor driver

Umang Jain (2):
      media: dt-bindings: media: Add bindings for IMX283
      fixups

 .../devicetree/bindings/media/i2c/sony,imx283.yaml |  107 ++
 MAINTAINERS                                        |    9 +
 drivers/media/i2c/Kconfig                          |   10 +
 drivers/media/i2c/Makefile                         |    1 +
 drivers/media/i2c/imx283.c                         | 1605 ++++++++++++++++++++
 5 files changed, 1732 insertions(+)
---
base-commit: 54ee11761885407056f4ca60309739e2db6b02dc
change-id: 20240402-kernel-name-extraversion-2b08d441e08c

Best regards,
-- 
Umang Jain <umang.jain@ideasonboard.com>


