Return-Path: <linux-kernel+bounces-10896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0264481DE47
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 06:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331E41C206A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 05:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E6E1846;
	Mon, 25 Dec 2023 05:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DXxqZL2L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76B110FE;
	Mon, 25 Dec 2023 05:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BP5dm4M040586;
	Sun, 24 Dec 2023 23:39:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703482788;
	bh=lbV2Hq/3rS7COuxdm4zdcZSLkIVz4F3DtABgamkDASM=;
	h=From:To:CC:Subject:Date;
	b=DXxqZL2LD4LpQSLINhR/aN0S9P4UzSYsP4F6pzvlUq1oyoVhDsZ1OK1q1ZxWkiHPz
	 N5LGPmxwEWZYU7IkC76e3zc1ygoj/5IpjJreWuG8SUJ5PppwN6UlkzI+X4GR8X3FkR
	 MJIiqgasUjXIg7jUFwydMaURZjdXJPhPDDjbj7jE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BP5dmSd020659
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 24 Dec 2023 23:39:48 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 24
 Dec 2023 23:39:48 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 24 Dec 2023 23:39:47 -0600
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.240])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BP5defc118972;
	Sun, 24 Dec 2023 23:39:40 -0600
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
Subject: [PATCH v3 1/5] ASoC: dt-bindings: move tas2563 from tas2562.yaml to tas2781.yaml
Date: Mon, 25 Dec 2023 13:39:27 +0800
Message-ID: <20231225053932.1138-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Move tas2563 from tas2562.yaml to tas2781.yaml, because tas2563 only work
in bypass-DSP mode with tas2562 driver. In oder to enable DSP mode for
tas2563, it has been moved to tas2781 driver. As to the hardware part,
such as register setting and DSP firmware, all these are stored in the
binary firmware. What tas2781 drivder dooes is to parse the firmware and
download them to the tas2781 or tas2563, then power on tas2781 or tas2563.
So, tas2781 driver can be resued as tas2563 driver。 Only attention will
be paid to downloading corresponding firmware.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Change in v3:
 - remove tas2563, which will be move to tas2781 driver
 - Add more comments on why move tas2563 to tas2781 driver
 - provide rationale in terms of bindings and hardware, not in terms of driver.
   Or at least not only.
---
 Documentation/devicetree/bindings/sound/tas2562.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
index f01c0dde0cf7..d28c102c0ce7 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
@@ -18,7 +18,6 @@ description: |
 
   Specifications about the audio amplifier can be found at:
     https://www.ti.com/lit/gpn/tas2562
-    https://www.ti.com/lit/gpn/tas2563
     https://www.ti.com/lit/gpn/tas2564
     https://www.ti.com/lit/gpn/tas2110
 
@@ -29,7 +28,6 @@ properties:
   compatible:
     enum:
       - ti,tas2562
-      - ti,tas2563
       - ti,tas2564
       - ti,tas2110
 
-- 
2.34.1


