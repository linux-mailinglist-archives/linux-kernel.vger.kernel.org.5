Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCED7C8147
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjJMJBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjJMJAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:00:55 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E2CDD;
        Fri, 13 Oct 2023 01:59:53 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39D8wGJH117330;
        Fri, 13 Oct 2023 03:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697187496;
        bh=tehlWY3R24oF54ia6UG9+oUYnETy85IMYdCvcWzzTW0=;
        h=From:Date:Subject:To:CC;
        b=pRnLrWc6bjwvBrzI8arqWOc/pcSHuh2GmsmQOBRbYG6j+VEaIixuR2i+DhsslqlXM
         labfjvkki62ezCZDX8VdySDyH1N7an106pcdprJZc7CTrvB5Ljni7cO2wCK0W/K6mP
         q24v50tj1KeT+vJlAFSqWsp7Yp1PZ46EWHja0pkk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39D8wGwo023824
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Oct 2023 03:58:16 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Oct 2023 03:58:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Oct 2023 03:58:15 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39D8wER5002982;
        Fri, 13 Oct 2023 03:58:15 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Fri, 13 Oct 2023 14:27:56 +0530
Subject: [PATCH] media: MAINTAINERS: Fix path for J721E CSI2RX bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231013-maintainers_path-v1-1-e28bdcc96ef2@ti.com>
X-B4-Tracking: v=1; b=H4sIAJMGKWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDA0Nj3dzEzLwSIE4tKo4vSCzJ0DUzNTBJS7VINTcyN1QCaisoSk3LrAA
 bGR1bWwsAQvNEqWIAAAA=
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        kernel test robot <lkp@intel.com>,
        Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=KgHMFv8L5FhhkDgA8/HKnFLM8B9gboEiWFOgX9lHIMs=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlKQalhkdw+e3RgkbryduCLVoaaeuELy/9RioYJ
 jJNXdZHJ7SJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZSkGpQAKCRBD3pH5JJpx
 RZvGD/9b77iap/O0Rhwj7HKjl/uBb00qwEX3PCZZ/bsBDs8bkKzm/2nsfIQdA/Ud4FdCvuPkLrK
 mv6/28PdaWpLZH0BmsPVRuSbmydYWzBTeTNeV/BPMgTVkDNXkHPB6zDdcmaf7Yooi2eIMxfD078
 va4j1uVLtmTKercbo+tN2S89i+ZJ7Zr5sgKJtTDUnTOeHtXzzXd5t5mR66CcxevPIBTYjyabdaK
 zljyJazf6sEokQOzsGDrUzfaHootCoVh1exGy4XaHdBzUL+g/ZG72roRWZ3MrQxUSvzn0fnKI1s
 14jCfmioTLMP2nWSqtBME6kliXGvHA0TXfJlTNqiu4QRxMJUaiARaOaLXkAeVYs7CkEW96Lt4Jy
 WOv1CUnMqUBpc0aqL46CTqDSnpFOrtPkhKBfAxE0lN47OiFFTVgss7I803XoZB8ae6oTyuIeaZm
 MiXTzaS77T7NPYmkYnj6MPUwZV1XwaCc++yGOGb1kJZCCDdfF7Ov3FXMgmxKgldAyXNVqhS/sAr
 uAfCeAukZmjadwD/YtWwKRXegBOBYaNj+C4CKB7Necty6ZOLixa8Dg8V3ol0mP5x2OXDq7s92rD
 HFxmWRQEAu4Z5ChwgkZyxz4sU1qxo/wy9Vd4xxKku+md3IuropcBw5MkCn2dkqXnsFkS0t5ScYL
 ri9ScWHo6mkd8kA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the path of the devicetree bindings. The path was changed during
review but MAINTAINERS file was not updated.

Fixes: b4a3d877dc92 ("media: ti: Add CSI2RX support for J721E")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310130411.c66pTXjG-lkp@intel.com/
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b47e0b56859..f3e6dbbbbccb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21599,7 +21599,7 @@ TI J721E CSI2RX DRIVER
 M:	Jai Luthra <j-luthra@ti.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/media/ti,j721e-csi2rx.yaml
+F:	Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.yaml
 F:	drivers/media/platform/ti/j721e-csi2rx/
 
 TI KEYSTONE MULTICORE NAVIGATOR DRIVERS

---
base-commit: 51b74c09ac8c5862007fc2bf0d465529d06dd446
change-id: 20231013-maintainers_path-6504fe8e7271

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>

