Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFEA80B336
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 09:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbjLIIJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 03:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbjLIIJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 03:09:02 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E539611D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 00:09:07 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B987qUf054868;
        Sat, 9 Dec 2023 02:07:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702109272;
        bh=hSoa1Xa6h5DjuKFNUbPa5kCZbIfeIeP1yJrAtIlqyGY=;
        h=From:To:CC:Subject:Date;
        b=tcjlbp1RpzKtbkSZIh/Gp723skrVAWwDJf3+0BaCHrQO+wELb1nPLUU9EaiJjdtsX
         HtmAj7CKJgu9XbPUzA5bytgqvQmIHRn3HREj7UON7deFbTVQtnToco5HkUeyxLXnrx
         HI2iEHd5YoOGnRMMrFrq3AxzR6/V2e6z0Cz1sduI=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B987qoV110420
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 9 Dec 2023 02:07:52 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 9
 Dec 2023 02:07:52 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 9 Dec 2023 02:07:52 -0600
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.163.83])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B987lHD122124;
        Sat, 9 Dec 2023 02:07:48 -0600
From:   Shenghao Ding <shenghao-ding@ti.com>
To:     <broonie@kernel.org>
CC:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <soyer@irl.hu>, <tiwai@suse.de>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1 1/3] ASoC: tas2781: Add tas2563 into header file
Date:   Sat, 9 Dec 2023 16:07:40 +0800
Message-ID: <20231209080742.1290-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support tas2563

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 include/sound/tas2781.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index a6c808b22318..45be543110ac 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -1,13 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 //
-// ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+// ALSA SoC Texas Instruments TAS2781/TAS2563 Audio Smart Amplifier
 //
 // Copyright (C) 2022 - 2023 Texas Instruments Incorporated
 // https://www.ti.com
 //
-// The TAS2781 driver implements a flexible and configurable
+// The TAS2781/TAS2563 driver implements a flexible and configurable
 // algo coefficient setting for one, two, or even multiple
-// TAS2781 chips.
+// TAS2781/TAS2563 chips.
 //
 // Author: Shenghao Ding <shenghao-ding@ti.com>
 // Author: Kevin Lu <kevin-lu@ti.com>
@@ -60,6 +60,7 @@
 
 enum audio_device {
 	TAS2781	= 0,
+	TAS2563
 };
 
 enum device_catlog_id {
-- 
2.34.1

