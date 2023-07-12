Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430227513B4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjGLWlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjGLWlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:41:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E771BF9;
        Wed, 12 Jul 2023 15:41:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51f7fb9a944so2762879a12.3;
        Wed, 12 Jul 2023 15:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689201671; x=1691793671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eMb7+57MCTn9xpGa2NO3n4GpLHy5O1Cdz+1zInhJgXo=;
        b=hDnNASBDETagnUQnVxkxBFWkcqjT5nLsQbk8SVEzig9Dgm1j141nubaJHSvGwY6ZDB
         jhdtLPhPzkwhIimIdSr3gLRIyH1uFpy1ehSB2xIJB/ndFiyJd8j2XwPgOcATnemf31Gr
         xSzYNbPI0BXkdb+jJbrcc1IOisQ+dZynC1i3a0gKkvBTNXtUlWHlvC8dlktGDuDdHLrJ
         yDvAXHiqIYX3+gSK7QpyVLUfZyegDLpR30+4ONNND4QSC3Gu0mEXbjw/u2D13wq4cRCV
         5/k6/9fFSRfgT1mW9tv/EggxRWde+muGqQjnTYT8TNvkrJ2tMAUfy7j4FUNPfsEeA54q
         qnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689201671; x=1691793671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMb7+57MCTn9xpGa2NO3n4GpLHy5O1Cdz+1zInhJgXo=;
        b=GVaBVIzOlDl9BQZMNoQeWVEGX4BjwBpqWKFL9aPuDsP7+kzbApnxlzxX08Qbw9tfAy
         ArX0qF0pc/Mpe0odlNZHrZljd0+wcJeUxwVrPjr19gIhzw26EKtkcrXY2ACZ4OmU+985
         4bO7FqR1u2pTFX7U5GAji1c0FOhDh5etlUNBWSxEYH+xlodIpWVIN+O6/NRptbNNAUlk
         t8al83Umkd2SQHDvQUK+ONiT94w9kZ91NZqz5SvQ3MRBcG9AtgKQtvWVNX1zVKadY+If
         oFQV8nQfU8AQCSz+o2PA5JChEtJsnM+Xz/x4pb5U3YjXZvHpLwTMo5+xP24YDOxvozPD
         eWDA==
X-Gm-Message-State: ABy/qLZ2xiUTxs4BIqF7wwoeEyf6i76pjpcaknIsi/2Td0gzIVamYZA1
        KjAJxtlhmfZJoXMj+LGyl0M=
X-Google-Smtp-Source: APBJJlEgx9lMpclN99xRaDzVqXMUYXut2IEHd/vu8uCtDM5Tpo8yQi5ANjeGuD//rUg2d2dIQATCzw==
X-Received: by 2002:a05:6402:68e:b0:51e:17d:a1c3 with SMTP id f14-20020a056402068e00b0051e017da1c3mr89998edy.32.1689201670590;
        Wed, 12 Jul 2023 15:41:10 -0700 (PDT)
Received: from localhost.localdomain (snat-11.cgn.sat-an.net. [176.222.226.11])
        by smtp.gmail.com with ESMTPSA id s20-20020a056402015400b0051a2c7f5b0fsm3364949edu.88.2023.07.12.15.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 15:41:10 -0700 (PDT)
From:   Jakub Vanek <linuxtardis@gmail.com>
To:     Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jakub Vanek <linuxtardis@gmail.com>, stable@vger.kernel.org,
        Mauro Ribeiro <mauro.ribeiro@hardkernel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] Revert "usb: dwc3: core: Enable AutoRetry feature in the controller"
Date:   Thu, 13 Jul 2023 00:40:37 +0200
Message-Id: <20230712224037.24948-1-linuxtardis@gmail.com>
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

This reverts commit b138e23d3dff90c0494925b4c1874227b81bddf7.

AutoRetry has been found to cause some issues. This feature allows
the controller in host mode (further referred to as the xHC) to send
non-terminating/burst retry ACKs (Retry=1 and Nump!=0) instead of
terminating retry ACKs (Retry=1 and Nump=0) to devices when
a transaction error occurs.

Unfortunately, some USB devices fail to retry transactions when
the xHC sends them a burst retry ACK. When this happens, the xHC
enters a strange state. After the affected transfer times out,
the xHCI driver tries to resume normal operation of the xHC
by sending it a Stop Endpoint command. However, the xHC fails
to respond to it, and the xHCI driver gives up. [1]
This fact is reported via dmesg:

[sda] tag#29 uas_eh_abort_handler 0 uas-tag 1 inflight: CMD IN
[sda] tag#29 CDB: opcode=0x28 28 00 00 69 42 80 00 00 48 00
xhci-hcd: xHCI host not responding to stop endpoint command
xhci-hcd: xHCI host controller not responding, assume dead
xhci-hcd: HC died; cleaning up

Some users observed this problem on an Odroid HC2 with the JMS578
USB3-to-SATA bridge. The issue can be triggered by starting
a read-heavy workload on an attached SSD. After a while, the host
controller would die and the SSD would disappear from the system. [1]

Further analysis by Synopsys determined that controller revisions
other than the one in Odroid HC2 are also affected by this.
The recommended solution was to disable AutoRetry altogether.
This change does not have a noticeable performance impact. [2]

Fixes: b138e23d3dff ("usb: dwc3: core: Enable AutoRetry feature in the controller")
Link: https://lore.kernel.org/r/a21f34c04632d250cd0a78c7c6f4a1c9c7a43142.camel@gmail.com/ [1]
Link: https://lore.kernel.org/r/20230711214834.kyr6ulync32d4ktk@synopsys.com/ [2]
Cc: stable@vger.kernel.org
Cc: Mauro Ribeiro <mauro.ribeiro@hardkernel.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Jakub Vanek <linuxtardis@gmail.com>
---
V1 -> V2: Updated to disable AutoRetry everywhere based on Synopsys feedback
          Reworded the changelog a bit to make it clearer

 drivers/usb/dwc3/core.c | 16 ----------------
 drivers/usb/dwc3/core.h |  3 ---
 2 files changed, 19 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f6689b731718..a4e079d37566 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1209,22 +1209,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
-	if (dwc->dr_mode == USB_DR_MODE_HOST ||
-	    dwc->dr_mode == USB_DR_MODE_OTG) {
-		reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
-
-		/*
-		 * Enable Auto retry Feature to make the controller operating in
-		 * Host mode on seeing transaction errors(CRC errors or internal
-		 * overrun scenerios) on IN transfers to reply to the device
-		 * with a non-terminating retry ACK (i.e, an ACK transcation
-		 * packet with Retry=1 & Nump != 0)
-		 */
-		reg |= DWC3_GUCTL_HSTINAUTORETRY;
-
-		dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
-	}
-
 	/*
 	 * Must config both number of packets and max burst settings to enable
 	 * RX and/or TX threshold.
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 8b1295e4dcdd..a69ac67d89fe 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -256,9 +256,6 @@
 #define DWC3_GCTL_GBLHIBERNATIONEN	BIT(1)
 #define DWC3_GCTL_DSBLCLKGTNG		BIT(0)
 
-/* Global User Control Register */
-#define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
-
 /* Global User Control 1 Register */
 #define DWC3_GUCTL1_DEV_DECOUPLE_L1L2_EVT	BIT(31)
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
-- 
2.25.1

