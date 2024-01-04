Return-Path: <linux-kernel+bounces-16814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05006824449
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D8EEB24527
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AFE241E0;
	Thu,  4 Jan 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uxunJUah"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96AF20DFF;
	Thu,  4 Jan 2024 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 404EvoKY094833;
	Thu, 4 Jan 2024 08:57:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704380270;
	bh=xh3RmFWtFRhsE0WfSJVrIa9/MFg7kvHXYymcnBeoVsg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uxunJUahTuhAa/rXdSnZuhs8v6jat9ergWlb86hLALancYy1nTWh0f+GL+2YoOGkD
	 aDc6Wv1cDOGoutIBV10YizpQZgNMUvnoYsrkNgeZ/7PvPS+gBumFQDy90KYOGCRqeQ
	 AF6BwD7op788FYSfoveLMcOKllIPXn3yR4y01pb4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 404Evow4067796
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jan 2024 08:57:50 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jan 2024 08:57:49 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jan 2024 08:57:49 -0600
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.161.227])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 404EvPfO105959;
	Thu, 4 Jan 2024 08:57:43 -0600
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <kevin-lu@ti.com>, <baojun.xu@ti.com>, <devicetree@vger.kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <13916275206@139.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liam.r.girdwood@intel.com>, <soyer@irl.hu>, <tiwai@suse.de>,
        <peeyush@ti.com>, <navada@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v5 3/4] ASoC: tas2781: Add tas2563 into header file for DSP mode
Date: Thu, 4 Jan 2024 22:57:18 +0800
Message-ID: <20240104145721.1398-3-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20240104145721.1398-1-shenghao-ding@ti.com>
References: <20240104145721.1398-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Move tas2563 from tas2562 header file to tas2781 header file to unbind
tas2563 from tas2562 driver code and bind it to tas2781 driver code,
because tas2563 only work in bypass-DSP mode with tas2562 driver. In
order to enable DSP mode for tas2563, it has been moved to tas2781
driver. As to the hardware part, such as register setting and DSP
firmware, all these are stored in the binary firmware. What tas2781
drivder does is to parse the firmware and download it to the chip,
then power on the chip. So, tas2781 driver can be resued as tas2563
driver. Only attention will be paid to downloading corresponding firmware.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Change in v5:
 - Move tas2563 to tas2781 driver.
 - Add more comments on why move tas2563 to tas2781 driver.
 - Provide rationale in terms of bindings and hardware, not in terms of driver.
   Or at least not only.
 - leave comma as the last entry is _not_ a terminator.
 - Make the enum order, tas2563 is first, tas2781 is second.
---
 include/sound/tas2781.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index a6c808b22318..813cf9446a58 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -1,13 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 //
-// ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+// ALSA SoC Texas Instruments TAS2563/TAS2781 Audio Smart Amplifier
 //
 // Copyright (C) 2022 - 2023 Texas Instruments Incorporated
 // https://www.ti.com
 //
-// The TAS2781 driver implements a flexible and configurable
+// The TAS2563/TAS2781 driver implements a flexible and configurable
 // algo coefficient setting for one, two, or even multiple
-// TAS2781 chips.
+// TAS2563/TAS2781 chips.
 //
 // Author: Shenghao Ding <shenghao-ding@ti.com>
 // Author: Kevin Lu <kevin-lu@ti.com>
@@ -59,7 +59,8 @@
 #define TASDEVICE_CMD_FIELD_W		0x4
 
 enum audio_device {
-	TAS2781	= 0,
+	TAS2563,
+	TAS2781,
 };
 
 enum device_catlog_id {
-- 
2.34.1


