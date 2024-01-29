Return-Path: <linux-kernel+bounces-42436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73491840160
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8BB2813A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6F955E59;
	Mon, 29 Jan 2024 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fIsGsqOa"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2F455792
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520290; cv=none; b=AhvX1V7No7pgX/7aAQuBBe7gGb3ux/ORm7aKzDajDSRPe6XE1iiGQ20FzaUPDw+wUuxT7ct3uzYDq1ixnws2Kc9754jBvJ/xK5jqaE2nLNlHrlVzs9OWhO3C/+UfdneObJTK+Gl1bbif5pqTwIq62XcYAt31IQzMrSt+NZh2qVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520290; c=relaxed/simple;
	bh=uPW5WaZeYCNjpAiQXQ6dsyN5lBlDGiOxHHcb3Werqlg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HHovXghBMXlatTvQmzsFkLECu5srLj7SzZGk6+hVkZ0kORw/5ewuhjbBoGhUiZutU6733aVYjjC35G5wL76lKILmkcMoqNuPXWpFUSaco5hHDbxURpfXyn6CnXfCUYPJrn5TUnv8BcK5/Xf0GZJT9HqrwY35xIJd7mWoNLA+cRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fIsGsqOa; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706520287; x=1738056287;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uPW5WaZeYCNjpAiQXQ6dsyN5lBlDGiOxHHcb3Werqlg=;
  b=fIsGsqOaX9wCjPkwCBYnhRB7lggxgM8kJ51oTFZ/EtMqo8eFDpY3yTzU
   asKC5fitFJwnypsas/IZD1CdvqC+XEa+3P97QgKiZE3lk/FKOsh48EWZt
   c9uxSkCd2ZXdtnE5u+NnKM70u0DNjuMWt5Fib2YY1uVEf5PIK223vp1/L
   2fLe6bNwI0KJy98IWkezIWiV+7erNjaLzlIBcjba8IRlKag048/HH44dz
   xoKxuNCL5o1EGqI1tXlu8Smx1lZLPx/pCyTq2zCHyy02bFp9JBfBQ42JG
   7DsiAAVCW5SGclQOZ7ANl7jR/bLrPFnhDNqk5z7eMESIHW6yZCpm9Gb/h
   w==;
X-CSE-ConnectionGUID: yiykArgaTK2rjSxwUhiB8w==
X-CSE-MsgGUID: eTsSxssXSN2wWUTre263AA==
X-IronPort-AV: E=Sophos;i="6.05,226,1701154800"; 
   d="scan'208";a="15433321"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jan 2024 02:24:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 02:24:11 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 02:24:04 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <sam@ravnborg.org>, <bbrezillon@kernel.org>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<lee@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <Hari.PrasathGE@microchip.com>, <Balamanikandan.Gunasundar@microchip.com>,
	<Durai.ManickamKR@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
	<Dharma.B@microchip.com>, <Varshini.Rajendran@microchip.com>,
	<Balakrishnan.S@microchip.com>, Manikandan Muralidharan
	<manikandan.m@microchip.com>
Subject: [PATCH RESEND v7 0/7] Add support for XLCDC to sam9x7 SoC family.
Date: Mon, 29 Jan 2024 14:53:12 +0530
Message-ID: <20240129092319.199365-1-manikandan.m@microchip.com>
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

Durai Manickam KR (1):
  drm: atmel-hlcdc: Define SAM9X7 SoC XLCDC specific registers

Manikandan Muralidharan (6):
  drm: atmel-hlcdc: add flag and driver ops to differentiate XLCDC and
    HLCDC IP
  drm: atmel-hlcdc: add LCD controller layer definition for sam9x75
  drm: atmel_hlcdc: Add support for XLCDC in atmel LCD driver
  drm: atmel-hlcdc: add DPI mode support for XLCDC
  drm: atmel-hlcdc: add vertical and horizontal scaling support for
    XLCDC
  drm: atmel-hlcdc: add support for DSI output formats

 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 175 +++++++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  | 105 +++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h  |  86 ++++
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   | 369 +++++++++++++++---
 include/linux/mfd/atmel-hlcdc.h               |  10 +
 5 files changed, 647 insertions(+), 98 deletions(-)

-- 
2.25.1


