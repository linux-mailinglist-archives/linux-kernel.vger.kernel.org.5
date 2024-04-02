Return-Path: <linux-kernel+bounces-127692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFC4894F8D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4684C282EC3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68005A0FD;
	Tue,  2 Apr 2024 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CzY6cfBI"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9C45914E;
	Tue,  2 Apr 2024 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052485; cv=none; b=JGBtLOC7nnl29K82kmghtqGozPWPcb62VEpBYK7sLyqCwwYKBcgt+gl/Wq3FWzuYISgkjCI47QWq//aIiMukMdEXIpMhh5s832XRfzrpZkaXyuP5+/uqUquwp6TkLqdTgYumLzUN0pN2X5cghfSJC/HF4kRvoTsqoKOkxvMZn3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052485; c=relaxed/simple;
	bh=I7iE9K+AKJKfQXjzWNOPLrDol5yt7Vyxo4TB2K0lmKY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=feDejsw8zd/T2xQGnZkwrM2afB5qC34rxFl/imtf3pKJSYcAkOTSpB662k9dZnuNK5Ugnq+4uBF7Gmv+b8bIPJaoTtVUnp7xmbTlRDlkqd7TUDv0HQRT9e4bZArAvphmrdY4h7ga4KvMuOwt7ZmbgoHRavIVd5WTlPmNhClI+HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=CzY6cfBI; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.118] (unknown [103.86.18.232])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A46CE1A2;
	Tue,  2 Apr 2024 12:07:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712052445;
	bh=I7iE9K+AKJKfQXjzWNOPLrDol5yt7Vyxo4TB2K0lmKY=;
	h=From:Subject:Date:To:Cc:From;
	b=CzY6cfBIofkTfw7BUjMbD+lphND9Zpm1sRUKUkvHlrF/vHc6hy5PjzeBd8Czx9pWJ
	 njyqoZo97zTrgJkvJI5WDzS0bUL92SqOv2sesOWGoiCzVjOPHT5UDrSOI9hd/9frxr
	 628kqLEzHOajHBR/AlgJ472WIRSaaNPtvCjhkIS0=
From: Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v4 0/2] media: i2c: Add imx283 camera sensor driver
Date: Tue, 02 Apr 2024 15:37:49 +0530
Message-Id: <20240402-kernel-name-extraversion-v4-0-fb776893e4ec@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPbYC2YC/42NQQ7CIBBFr9KwdgwgRuLKe5guoIx2ogUzNKSm4
 e7SnsDl+8l7fxUZmTCLa7cKxkKZUmxgDp0YRhefCBQaCy21kUZqeCFHfEN0EwIuM7uCvEmgvbT
 BGIXSDqLpH8YHLXv63jceKc+Jv/tTUdv6R7QokHC+eH+yAa1R/kYBXU7RJ8fhOKRJ9LXWHwTP/
 C3HAAAA
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Umang Jain <umang.jain@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712052475; l=2916;
 i=umang.jain@ideasonboard.com; s=20240402; h=from:subject:message-id;
 bh=I7iE9K+AKJKfQXjzWNOPLrDol5yt7Vyxo4TB2K0lmKY=;
 b=jeoV1zgprwGFPz5rn2VKaTZIKAYeMtE0b4orpUY2OrjQXPHx5fEG9LczZh6mn7MKPBX8+qrRa
 CzAxYt5s8WSAOfoj2GKqjI/7aLL3eHG92z4L+9dD26RP6mBofVaF6gG
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

Umang Jain (1):
      media: dt-bindings: media: Add bindings for IMX283

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


