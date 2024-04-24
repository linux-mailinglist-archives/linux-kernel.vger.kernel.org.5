Return-Path: <linux-kernel+bounces-156309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFFB8B0113
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACED28250B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAD7156671;
	Wed, 24 Apr 2024 05:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e9hSbyzQ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EA9155356
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713936867; cv=none; b=Glwb6/YF92Y5XGNzJfOLM03zHyeCSubv8sp9xAv8xr1zrqTmX2ww5bdrl0kvfgo06xv8bWlnHgJ0BHYtFB7psBZx8cr2MZac1jSBY5H+KjtFVegjSOGVEmhMudQVrGJPsda2YM2qBy37jlgIUOTVLrZk1AHW04Jc+YISX9/d1VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713936867; c=relaxed/simple;
	bh=mitb+D/nVSsGthWI422LmnlrCmG2yJ527JL4f7Ea30k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sMRLNBeHWr6MuFvJkoaxmykwZOGh4M9PwkPBZMbH5xURFXZY/ERbeZlKFMhrbhRmM3d8bgckFtnz2JdNGZNyeWY5pMlK94NLzwBqAPiLZCfUtL0SZ1bUtz3H5SQtafaR8g9HU4WY74gfQZiLOjfD39ZXo8fLz1//2y8Zm2jKHLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e9hSbyzQ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713936865; x=1745472865;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mitb+D/nVSsGthWI422LmnlrCmG2yJ527JL4f7Ea30k=;
  b=e9hSbyzQAgFMtFnaZFmlbuk0GsH/gS0W7XIiZM6MUCguBgbKrZeaWJJ8
   fHlAZZi6g6hkZULcBxe4qm1YIblCy4cYt6acEbczWsX1IQ2ybdeXXzjr7
   +I+md389S8gYLIRqAm5gRXjqgQkxsoeOWwUUicnHYTh0S5oHQhttZ/X6M
   e7c9Zbzmk+rcvBc+fiuSPKZGxWwSCJdrL/YdQTh8l1onTN+fz/fzvJ6hA
   yad1vpjd1WXh+H4AqGShcedT2jA+M/wQaeZJhVzjvxmqTByJl6SCnVcn0
   Zggxv76HR7DiFTdwZy4Aea4DHjv4NE5IqoMvNcCw734e8tP03ynDleri/
   w==;
X-CSE-ConnectionGUID: Er+woXTdRGuoFCdDEDLh7g==
X-CSE-MsgGUID: YvvVZm/ST2Og96PTIZWFyQ==
X-IronPort-AV: E=Sophos;i="6.07,225,1708412400"; 
   d="scan'208";a="22410826"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Apr 2024 22:34:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 22:34:18 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 22:34:09 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <sam@ravnborg.org>, <bbrezillon@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <Hari.PrasathGE@microchip.com>, <Balamanikandan.Gunasundar@microchip.com>,
	<Durai.ManickamKR@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
	<Dharma.B@microchip.com>, <Varshini.Rajendran@microchip.com>,
	<Balakrishnan.S@microchip.com>, <Charan.Pedumuru@microchip.com>, "Manikandan
 Muralidharan" <manikandan.m@microchip.com>
Subject: [PATCH RESEND v9 0/8]  Add support for XLCDC to sam9x7 SoC family.
Date: Wed, 24 Apr 2024 11:03:43 +0530
Message-ID: <20240424053351.589830-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series aims to add support for XLCDC IP of sam9x7 SoC family
to the DRM subsystem.XLCDC IP has additional registers and new
configuration bits compared to the existing register set of HLCDC IP.
The new compatible string "microchip,sam9x75-xlcdc" is defined for sam9x75
variant of the sam9x7 SoC family.The is_xlcdc flag under driver data and
IP specific driver ops helps to differentiate the XLCDC and existing HLCDC
code within the same driver.

changes in v9:
* Fix struct comments as per kernel-doc format
* Rename LCDC ops
* Move regmap_read_poll_timeout change to separate commit
* cosmetic fixes

changes in v8:
* Re-arrange the patch set to prepare and update the current HLCDC
code base with the new LCDC IP based driver ops and then add support
for XLCDC code changes.
* Fix Cosmetic issues.

changes in v7:
* LCDC IP driver ops functions are declared static and its
declaration are removed.

changes in v6:
* Fixed Cosmetic defects.
* Added comments for readability.

changes in v5:
* return value of regmap_read_poll_timeout is checked in failure
case.
* HLCDC and XLCDC specific driver functions are now invoked
using its IP specific driver ops w/o the need of checking is_xlcdc flag.
* Removed empty spaces and blank lines.

changes in v4:
* fixed kernel warnings reported by kernel test robot.

changes in v3:
* Removed de-referencing the value of is_xlcdc flag multiple times in
a single function.
* Removed cpu_relax() call when using regmap_read_poll_timeout.
* Updated xfactor and yfactor equations using shift operators
* Defined CSC co-efficients in an array for code readability.

changes in v2:
* Change the driver compatible name from "microchip,sam9x7-xlcdc" to
"microchip,sam9x75-xlcdc".
* Move is_xlcdc flag to driver data.
* Remove unsed Macro definitions.
* Add co-developed-bys tags
* Replace regmap_read() with regmap_read_poll_timeout() call
* Split code into two helpers for code readablitity.

------------
Durai Manickam KR (1):
  drm: atmel-hlcdc: Define XLCDC specific registers

Manikandan Muralidharan (7):
  drm: atmel-hlcdc: add driver ops to differentiate HLCDC and XLCDC IP
  drm: atmel_hlcdc: replace regmap_read with regmap_read_poll_timeout
  drm: atmel_hlcdc: Add support for XLCDC using IP specific driver ops
  drm: atmel-hlcdc: add DPI mode support for XLCDC
  drm: atmel-hlcdc: add vertical and horizontal scaling support for
    XLCDC
  drm: atmel-hlcdc: add support for DSI output formats
  drm: atmel-hlcdc: add LCD controller layer definition for sam9x75

 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 172 ++++++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  | 105 +++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h  | 132 +++++--
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   | 369 +++++++++++++++---
 include/linux/mfd/atmel-hlcdc.h               |  10 +
 5 files changed, 673 insertions(+), 115 deletions(-)

-- 
2.25.1


