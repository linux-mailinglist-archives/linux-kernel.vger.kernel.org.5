Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9DD77F2F3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349380AbjHQJOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349369AbjHQJNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:13:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E4919A1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692263609; x=1723799609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WCG1Ovk97pVQtMtJX+NlFhx11oFlfPXeQ8l9DlmV5mE=;
  b=1PSVvZt+VkLooOR9l67DapuKaUNzPLlCCnU9SMYBd+31mPc9ejXtKF/I
   fQpE2pJFd56qn3Bq8JjGpG7i+wkEHzxXEaSyqUzD57pcof8pOwmuBxKbT
   wBnUgRtS7DEZpOaAyFp9ZWy6dLFP8YIWO26kzio0ooeeZpO100SW+8fY9
   9CjqyYCYfmP/XHitMydUp2redUdCENShfRtlxlMlxsucvGGV9r6kmUr1c
   ZZ1ahymv4/L6nP8BHyqXgSoUg58hjFyAiALLG1PVHUOlC7Mi3srDjC5DE
   FWzFTouXTLNfKz/8A0vm2YHVJ2UdhTgZ4SjIj4HgBHsMD+lpB4d3DeqFj
   A==;
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="166879526"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Aug 2023 02:13:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 17 Aug 2023 02:13:28 -0700
Received: from che-lt-i67131.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 17 Aug 2023 02:13:21 -0700
From:   Manikandan Muralidharan <manikandan.m@microchip.com>
To:     <sam@ravnborg.org>, <bbrezillon@kernel.org>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <lee@kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Durai.ManickamKR@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
        <Dharma.B@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Balakrishnan.S@microchip.com>,
        Manikandan Muralidharan <manikandan.m@microchip.com>
Subject: [PATCH v3 1/8] mfd: atmel-hlcdc: Add compatible for sam9x75 XLCD controller
Date:   Thu, 17 Aug 2023 14:42:43 +0530
Message-ID: <20230817091250.225512-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230817091250.225512-1-manikandan.m@microchip.com>
References: <20230817091250.225512-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for sam9x75 XLCD controller.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/mfd/atmel-hlcdc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
index 3c2414ba4b01..1daa7410468a 100644
--- a/drivers/mfd/atmel-hlcdc.c
+++ b/drivers/mfd/atmel-hlcdc.c
@@ -141,6 +141,7 @@ static const struct of_device_id atmel_hlcdc_match[] = {
 	{ .compatible = "atmel,sama5d3-hlcdc" },
 	{ .compatible = "atmel,sama5d4-hlcdc" },
 	{ .compatible = "microchip,sam9x60-hlcdc" },
+	{ .compatible = "microchip,sam9x75-xlcdc" },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, atmel_hlcdc_match);
-- 
2.25.1

