Return-Path: <linux-kernel+bounces-8188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A80C81B354
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566E928551B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DA051C39;
	Thu, 21 Dec 2023 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fne4aXwm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA81B51C25;
	Thu, 21 Dec 2023 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLADv1h012631;
	Thu, 21 Dec 2023 04:13:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703153637;
	bh=sLdFXnpxFlQqoK1p8Vg4Etqv0GZzsWvE6eYx5Q11kJs=;
	h=From:To:CC:Subject:Date;
	b=Fne4aXwmBn5dkqpqqFw+7R70drLMXfF1yxXg1kAffa/M4/hJk+qR2eP/AFxxfzls2
	 r5w+WzMMNOAjL+6aUXm4OBt72RJTx3481WiYorsaZtSicVRp/85TDKb8d8C/HeiXbl
	 JL3IT4IpZGut2koWzEOW5kN6000OxrXmwSfiHN6M=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLADvhN017220
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 Dec 2023 04:13:57 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 04:13:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 04:13:56 -0600
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.210])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLADoQc069419;
	Thu, 21 Dec 2023 04:13:51 -0600
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
Subject: [PATCH v2 1/5] ASoC: dt-bindings: remove tas2563 from yaml
Date: Thu, 21 Dec 2023 18:13:41 +0800
Message-ID: <20231221101346.429-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Remove tas2563 from tas2562, it will be supported in tas2781 to better
support dsp mode.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Change in v2:
 - remove tas2563, which will be move to tas2781 driver
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


