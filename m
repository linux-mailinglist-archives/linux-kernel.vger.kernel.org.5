Return-Path: <linux-kernel+bounces-74080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2820785CFBB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2151F21B39
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232E839FC3;
	Wed, 21 Feb 2024 05:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mnKkfnMJ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A639AF1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708493761; cv=none; b=AmeAVfgXYnmipcj3eF3LBu9KUDWWVuJheDcAsPUo5DQHzIlc6+R5x4FZjOjsAP44rk3iveJBtPlLy7ZZW7m4KNj1t5reER9NgdrGWFePhOFjqXHxxRAsRxX8FJHrsHds1RYmYrTgatF1gMqKUl03EhARodgLVqi6ZtvDa9XFNoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708493761; c=relaxed/simple;
	bh=i2g2RwYvdYzisFpUrzxjvDgtwPvv5krapAooAMh2eb8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C9OtYt2lAGzOC6IGIPZNEfTnzRkGAezV3l7YeggrcLYdb6k7AX6GkTdBxeTkk8mpMRTpKa5Ff3B51lqX8xtQfQKnTUGbSUXrhBuykEBnxLz4HgNay+6JfI0MOWcAJFT1hG2w63co5yY7YwSwUa+ALgoIatbVKtAfuma6BAkuWhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mnKkfnMJ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708493759; x=1740029759;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i2g2RwYvdYzisFpUrzxjvDgtwPvv5krapAooAMh2eb8=;
  b=mnKkfnMJGWBRDqkgWiAJ834HGarffXANdGEaRdg3eZce5CGMCcx1d15p
   xQpAag1dS4sBI2RyNxwnhv+nJ7zzKWLO5e0Stn3ewTEicZAvmJeF1zmDx
   RTZmfS7bUQYbjjScbKvu2AG5wnSiy/vrex+fJIDj9rLDJXwKu6RszHup+
   R6gLTgQUwafXH2OkfnaUhUSotugkcBE9n1HFkLTUKaCgeI7HeohKI8iuO
   WCezQZwn++LIbItuC3nPqE2DQmj76Un8X9birPUgZ96RKADt2x1BBeFup
   3Wb7fJ5s1bxzLWDlfklYJ0nIq3hKzZt9sxkOavV2bv1/pUS/RjaTlqsgG
   A==;
X-CSE-ConnectionGUID: GBi6ox9HSPqBW3WJPlVwRw==
X-CSE-MsgGUID: nPi8X/1qQQquDj7LyoXFMg==
X-IronPort-AV: E=Sophos;i="6.06,174,1705388400"; 
   d="scan'208";a="18086630"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Feb 2024 22:35:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 22:35:42 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 22:35:35 -0700
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
	<Balakrishnan.S@microchip.com>, <manikandan.m@microchip.com>,
	<Charan.Pedumuru@microchip.com>
Subject: [PATCH v8 0/7] Add support for XLCDC to sam9x7 SoC family.
Date: Wed, 21 Feb 2024 11:05:24 +0530
Message-ID: <20240221053531.12701-1-manikandan.m@microchip.com>
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
---

Durai Manickam KR (1):
  drm: atmel-hlcdc: Define XLCDC specific registers

Manikandan Muralidharan (6):
  drm: atmel-hlcdc: add driver ops to differentiate HLCDC and XLCDC IP
  drm: atmel_hlcdc: Add support for XLCDC using IP specific driver ops
  drm: atmel-hlcdc: add DPI mode support for XLCDC
  drm: atmel-hlcdc: add vertical and horizontal scaling support for
    XLCDC
  drm: atmel-hlcdc: add support for DSI output formats
  drm: atmel-hlcdc: add LCD controller layer definition for sam9x75

 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 176 +++++++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  | 105 +++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h  | 133 +++++--
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   | 369 +++++++++++++++---
 include/linux/mfd/atmel-hlcdc.h               |  10 +
 5 files changed, 678 insertions(+), 115 deletions(-)

-- 
2.25.1


