Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39A07CBC6C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjJQHhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQHhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:37:54 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545BA93;
        Tue, 17 Oct 2023 00:37:51 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39H7bgmE100313;
        Tue, 17 Oct 2023 02:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697528262;
        bh=v6W6VNjd8fR9Nh2hnhJXRvR++O9Ef4r2jWFFoKKLIrA=;
        h=From:Date:Subject:To:CC;
        b=RA72uv7l4tqCDM2DVxxYgp3DF+eUEx5kAxHRgPkdZhUgCvBhKZo+qslZy9EKfmZwx
         hQa4xl5sRYzcfNQz/Z+pLbD7PDYrOMPnw0ZRvdN1ZkHv+aujeyv5SFXOiwTG90gUdD
         3BWOz9TxAfxRDDR2Ky1G+oGWANOe2vaok2ZaTfn4=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39H7bg0w113629
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Oct 2023 02:37:42 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Oct 2023 02:37:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Oct 2023 02:37:41 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39H7beDJ001618;
        Tue, 17 Oct 2023 02:37:41 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Tue, 17 Oct 2023 13:07:24 +0530
Subject: [PATCH] media: platform: cadence: select MIPI_DPHY dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231017-cdns_phy_config-v1-1-583243d1c187@ti.com>
X-B4-Tracking: v=1; b=H4sIALM5LmUC/x3MTQqAIBBA4avErBPUiH6uEiGTjTUbFYUowrsnL
 b/Fey9kSkwZ5uaFRBdnDr5CtQ3YE/1Bgvdq0FJ3SqpB2N1nE8/H2OAdHwInNyKi1K7foFYxkeP
 7Py5rKR/3eY+5YQAAAA==
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=tLGG68T4+r7VRXc6DxWsmPrTloKohBWAFVxD2V3BE5w=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlLjnBw1WTfOJY531x4HMeZefHwbePuF2u9XNiR
 FNH0BkxHziJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZS45wQAKCRBD3pH5JJpx
 RS3GEADId1jYAuO5VbLH3+qEwWfcvsZyAxYja/NyECFRbzDKMUWXAg7khqR+1UCSuwO3vKNpTT8
 t9/4pLwa+yVas2wlQVpI/joySuMgInhsMLNAUmSivRuIkd68RCwU6F4nejaUEHRCW0TRQuEmKxD
 KUhSkoEMU0CT2eztdmh+avCI0ToK+iIa6o6PQDo6Ym5fxuteRvNR4sGZotdP8Thp47pfokMgt8b
 Gd6gY8hmvYY/vu2VOf7Sh9BkNzDL6BxuMomgEPQ7DAyQpL10L7zI0HSyab1aKcgHm9eoCspdwFx
 0h4P7Ngsu8q7D7NPD8A2zfZplB1SQk1IlIFC5zAEQ0q2IkHWY20ZAspsKfGoNHE0m30ih9Jvw8i
 ZmETOI4eVJi7DBxQKeZYDZDG8JbFpqS30ukQ/+svqDCV7Zz65iM7O6AucpxxJMalYvwQ8nqUUGH
 KsZIs8+0E3iqXAM7vmxX9a9Oak+0pdaUrL9tnq74eUPSSualsTog/1wL6PBqf+CxcO8OLvzR5k1
 ujmqD7zaZG0M2ApjoNAgU13mb4/GFbtHcd4d3izLEy/qIjhdjXpRrY3kFrgAL0PyFEy96pTrWNT
 X9GpwjbXSrek2kiR8V2rxRdFNDOQVubBlN5ln3TsmmVCMsa5R8YQDeInvgfhNCPNeLbDqIVqvMD
 X9PCRuCq3ldEBBA==
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

The driver uses MIPI DPHY helper routines from the PHY core. Make sure
we select the relevant config for compilation.

Fixes: a91d06f46bf7 ("media: cadence: csi2rx: Configure DPHY using link freq")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310170258.UzSN4RUB-lkp@intel.com/
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/cadence/Kconfig b/drivers/media/platform/cadence/Kconfig
index 480325d053de..317bd9e2e728 100644
--- a/drivers/media/platform/cadence/Kconfig
+++ b/drivers/media/platform/cadence/Kconfig
@@ -8,6 +8,7 @@ config VIDEO_CADENCE_CSI2RX
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
 	select V4L2_FWNODE
+	select GENERIC_PHY_MIPI_DPHY
 	help
 	  Support for the Cadence MIPI CSI2 Receiver controller.
 

---
base-commit: 94e27fbeca27d8c772fc2bc807730aaee5886055
change-id: 20231017-cdns_phy_config-a9f8aaa02f5b

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>

