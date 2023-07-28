Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662B4766AC2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbjG1KeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbjG1Kc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:32:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E89F59D7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540259; x=1722076259;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0EGq0ZVfpcCJM4IAcCqavy7vjelv4zEARyppyJL5U7Q=;
  b=1FGUear4uJsMqKP7VXG1KJMtY4kqUOTJBkzrK2XZ+EaiuQwCnoel6m8T
   TzyniKwGV2t4I1J1hH7DubD3AjkOhzVdB3WvRfGQnESLnN5LQCidNh/9T
   LdaVtTBTB/jskcWnJlU437JSBI/3WI6kqPt39ZyxYCLvyQWWc+fiJ2Qr+
   dnKf3po6hlCUH474oed9AtdF1iSHQKPefBjbg1vMLFhuPSiXx86ugkYU1
   VPwG8iBdH6cFsXOZJAlbSRnNHL+Ax/Zjcsu5GZcsjDwJy3KtP08o/sBvh
   XIxUiTa1yGAV2WdP+k4HDS2tfSrwpgeNQwHG/j93UTIXTDFnIpEqGXqkZ
   w==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="163713071"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:30:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:30:58 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:30:54 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <arnd@arndb.de>, <deller@gmx.de>,
        <varshini.rajendran@microchip.com>, <rientjes@google.com>,
        <vbabka@suse.cz>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 47/50] ARM: configs: at91: enable config flags for sam9x7 SoC family
Date:   Fri, 28 Jul 2023 16:00:51 +0530
Message-ID: <20230728103051.267694-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable config flags for SAM9X7 SoC for the sam9x7 SoC family.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 8cc602853cc5..342ceeab5aaa 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -15,6 +15,7 @@ CONFIG_ARCH_AT91=y
 CONFIG_SOC_AT91RM9200=y
 CONFIG_SOC_AT91SAM9=y
 CONFIG_SOC_SAM9X60=y
+CONFIG_SOC_SAM9X7=y
 # CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
 CONFIG_AEABI=y
 CONFIG_UACCESS_WITH_MEMCPY=y
-- 
2.25.1

