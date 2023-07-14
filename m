Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4091E753ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbjGNM0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbjGNMZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:25:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19743C1B;
        Fri, 14 Jul 2023 05:25:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98de21518fbso251154866b.0;
        Fri, 14 Jul 2023 05:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689337492; x=1691929492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vkPYI3Vjys6HUZ7g47wuaPMnyVLdDQufL5+zqucCKZc=;
        b=AzmkvcnjqYrirYQYyNP9UwZF5wOxd8pOG9kLaNfd+JwBNM5D3VmWa7s4BPIzzvr+vy
         O9Uu1GL0Ak1ZG/K8oujzVXP4vXDm8cqXZOq+z8GpgNWVELyxY8o2v/x4J4nbkjuYSrzY
         b7xVin8dXKYhqulfRyIHJQXUURZCW0Wz55EjWfwxfzhTUZsNjhccMXp6s8K4TVu4NpLm
         qwGeO7S4rKUiUl9waTXoPhS3vi5DTkaubrSuwqR1J+5ms2ecAocYVKmmU/0d45UAL5E3
         t0S3MX0mEl1nXMXKnec8oi6YokGZqT90K+Q4QTjl+WIYKTNqJ/GbbLxHODir1tkHCJDb
         y9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689337492; x=1691929492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vkPYI3Vjys6HUZ7g47wuaPMnyVLdDQufL5+zqucCKZc=;
        b=Q6ihlVx9YgJpfwVgHXAQyuin2wcpHtruL211s/+QitVHWmk2BA2MlwZVQo0GTHpUF2
         QsxhMoZm4VOL8G5IPf/ehJJWIGP1Cd0whVmK2Gn47OOe1ODAi+IiVGhTdhfp5XC2RSoD
         N0E91kMzNsnp4SFJIqXOwhdj4nILD2WbR0CTlD4nFMlxPaY0kBhqMtCJVs3ZDRtotLjp
         tX+8pDSROJ7w8Nvj75nKj9oufVDzAoPWgdarzQyDZkJA+U6jRU4OqdKBhu7CWsATVrTN
         B8USS+Lh7z1LM6tR2WJyMsXveZ3gol83U4C4saPiTZP++V6xWXstsvVx47F3k4SvDkLI
         YqGg==
X-Gm-Message-State: ABy/qLZU8DSm+ScUgXB3pc6xSZqu9cyT9m7Qv+SmNj360I2V1O0eK+ne
        eicwztOyh+hgfCPqz9/WtDY=
X-Google-Smtp-Source: APBJJlGP00fXjQi9ojrEp9x2syWFzQt0DOIFe1J/unjIM3SHAChHfvWXet0XqhTd5Mg4zVQ6vhoLgA==
X-Received: by 2002:a17:906:a897:b0:982:1936:ad27 with SMTP id ha23-20020a170906a89700b009821936ad27mr4178686ejb.11.1689337492399;
        Fri, 14 Jul 2023 05:24:52 -0700 (PDT)
Received: from localhost.localdomain (snat-11.cgn.sat-an.net. [176.222.226.11])
        by smtp.gmail.com with ESMTPSA id h19-20020a170906719300b00993cc1242d4sm5314054ejk.151.2023.07.14.05.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 05:24:52 -0700 (PDT)
From:   Jakub Vanek <linuxtardis@gmail.com>
To:     Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jakub Vanek <linuxtardis@gmail.com>, stable@vger.kernel.org,
        Mauro Ribeiro <mauro.ribeiro@hardkernel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3] Revert "usb: dwc3: core: Enable AutoRetry feature in the controller"
Date:   Fri, 14 Jul 2023 14:24:19 +0200
Message-Id: <20230714122419.27741-1-linuxtardis@gmail.com>
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

AutoRetry has been found to sometimes cause controller freezes when
communicating with buggy USB devices.

This controller feature allows the controller in host mode to send
non-terminating/burst retry ACKs instead of terminating retry ACKs
to devices when a transaction error (CRC error or overflow) occurs.

Unfortunately, if the USB device continues to respond with a CRC error,
the controller will not complete endpoint-related commands while it
keeps trying to auto-retry. [3] The xHCI driver will notice this once
it tries to abort the transfer using a Stop Endpoint command and
does not receive a completion in time. [1]
This situation is reported to dmesg:

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

Revert the enablement commit. This will keep the AutoRetry bit in
the default state configured during SoC design [2].

Fixes: b138e23d3dff ("usb: dwc3: core: Enable AutoRetry feature in the controller")
Link: https://lore.kernel.org/r/a21f34c04632d250cd0a78c7c6f4a1c9c7a43142.camel@gmail.com/ [1]
Link: https://lore.kernel.org/r/20230711214834.kyr6ulync32d4ktk@synopsys.com/ [2]
Link: https://lore.kernel.org/r/20230712225518.2smu7wse6djc7l5o@synopsys.com/ [3]
Cc: stable@vger.kernel.org
Cc: Mauro Ribeiro <mauro.ribeiro@hardkernel.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Jakub Vanek <linuxtardis@gmail.com>
---
V2 -> V3: Include more findings in changelog
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

