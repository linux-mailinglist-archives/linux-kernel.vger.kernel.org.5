Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441A6766C89
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjG1MHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjG1MHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:07:40 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B640D3A8C;
        Fri, 28 Jul 2023 05:07:38 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bb893e6365so12670545ad.2;
        Fri, 28 Jul 2023 05:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690546058; x=1691150858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1jpcXUzEwELWXs2RIMu0L/y8ad++SC5sQ/lHuSCbESc=;
        b=lB6TUsU0iXYbNOhnrWHMnF4wrUyA/ZILz9dwrze8V1KY1D7tZkwst6pdmy2XTM0uox
         5CxWYRNA1g0Jblbn3VOoVBCXzeGuaSYbgCpDy1gGzkRJnlZ+2fwW0citiYvzROP/npba
         Kp1LELSX7x8p7iZnQRGC5+V5Qr0oNkvfz8e9ESmsc+OIL3NfTdSteCndcpFtP6ICyIIT
         9hX1jHEBO/D3jBH1Swkn+h7fRilL+SaqFIFpqLnpu5552Feu2m63HI6hR3tqezTMvhAh
         t5umnfszkVl0qNXrYgOrVSUTDFCfUp0haHfKi7iFhcfkP9TQG/X3qMBEvgwizIi3s/rj
         NDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690546058; x=1691150858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1jpcXUzEwELWXs2RIMu0L/y8ad++SC5sQ/lHuSCbESc=;
        b=a8lTxuswsAgzBztkDEDo1V0yjEmCKdlRJMRnknuMt5gM28A371qCBYsm4GWjjepc+c
         IlDE18NxQiRis7cJfbKQBElr7O9UHjbGC/z5bPEY32G2pQQQ+wh3JbfH+7YiAwlrCTnc
         7r4IlaE8vDwvMqIQsuCHQogPAwqy+pQHSjfEfYGXF2lv8AduMSv9ylOHPAk3ZmKYb0Zd
         0R6KkYWbjt8DKsXvZz7YXxkLHRI4kWFJ0J03sb7/NmdFxjIo/qpCwKdaXkjWxtfLhf+3
         mul4HXU+tHdmZQoppVCNiXyJ52dSOeEAqJO1E4fxpk27a3yHgu/aa5JcNGMijfd9wfwR
         iA6g==
X-Gm-Message-State: ABy/qLasozMNFU1zXzA8zMtverpJJv/S+8GcMlkFUV/ZhU+sgeOHtuHQ
        COlMo7GM2EH3mBhELDMCJvA=
X-Google-Smtp-Source: APBJJlGjnlVu0+z2TGpdvnUNa3WkMM3jcn6GPIPfxQvVrK7w1qtolsqtumhkySfGX9plpwAVveNZbw==
X-Received: by 2002:a17:902:da83:b0:1b8:9b1b:ae8e with SMTP id j3-20020a170902da8300b001b89b1bae8emr1537022plx.59.1690546058080;
        Fri, 28 Jul 2023 05:07:38 -0700 (PDT)
Received: from localhost.localdomain ([113.103.5.50])
        by smtp.gmail.com with ESMTPSA id f16-20020a170902ce9000b001b016313b1dsm3435627plg.86.2023.07.28.05.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 05:07:37 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     nicolas.ferre@microchip.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu
Cc:     alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guiting Shen <aarongt.shen@gmail.com>
Subject: [PATCH v3 RESEND] usb: ohci-at91: Fix the unhandle interrupt when resume
Date:   Fri, 28 Jul 2023 20:06:48 +0800
Message-Id: <20230728120648.5878-1-aarongt.shen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ohci_hcd_at91_drv_suspend() sets ohci->rh_state to OHCI_RH_HALTED when
suspend which will let the ohci_irq() skip the interrupt after resume. And
nobody to handle this interrupt.

According to the comment in ohci_hcd_at91_drv_suspend(), it need to reset
when resume from suspend(MEM) to fix by setting "hibernated" argument of
ohci_resume().

Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ohci-at91.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 533537ef3c21..360680769494 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -673,7 +673,13 @@ ohci_hcd_at91_drv_resume(struct device *dev)
 	else
 		at91_start_clock(ohci_at91);
 
-	ohci_resume(hcd, false);
+	/*
+	 * According to the comment in ohci_hcd_at91_drv_suspend()
+	 * we need to do a reset if the 48Mhz clock was stopped,
+	 * that is, if ohci_at91->wakeup is clear. Tell ohci_resume()
+	 * to reset in this case by setting its "hibernated" flag.
+	 */
+	ohci_resume(hcd, !ohci_at91->wakeup);
 
 	return 0;
 }
-- 
2.25.1

