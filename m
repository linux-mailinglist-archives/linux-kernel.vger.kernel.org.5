Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393BA7AC7B0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 13:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjIXLR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 07:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIXLRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 07:17:55 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C374FB;
        Sun, 24 Sep 2023 04:17:49 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d7b91422da8so5481708276.2;
        Sun, 24 Sep 2023 04:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695554269; x=1696159069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b4HS8L745KJlohWleqIho/MyqaVQPR2qi4XVsaMxch8=;
        b=FdG20oX2NRaIdOE1Sj9fdXAaDz4qZq23gmu5hE0c+a/7EiSeo0nvg8ILeZXyWfyoVM
         LH6YFTVKWoAznXTXsFzq3OiUFSOBCskLu8y41JB6u9XCycG1uMAwwYeLTcD8EWG+G+u6
         rdVaciftvOSWetHY7fvKYvJB/avxGl1aNjCePeU1DrkihNJ80vnG143W0T4H86iFk/yV
         +7yuWhzw4pm783FCGu8zrgxRmwXPnihBsWNslFLegjt+2vvXDc3WSikPFnNyXeY3y7FK
         UfoWzu5pamREQPqR6MfC0dSQnd1zqTP3t7eEpkyZ5by6ONZHAlQZIQHXrLJsjdyrNjDF
         Z9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695554269; x=1696159069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4HS8L745KJlohWleqIho/MyqaVQPR2qi4XVsaMxch8=;
        b=V5VooKRDii4xQ4Plw21PrBkQXdO3pB2E9/QI1NpyOI9p6GJ1InVqYjavw47xCmAlQm
         fC+e2jQYDb47g3Jb9olwWFrXoTgKlqSKUI+bXWRSBTOb9gOuvFOp2Beb2KqqnMn18N7z
         tZJmKR9Q3HfGoBbvEkZbMAHRbJ8FgH5TvNHgQY5jyGPoOiK14ow3OrRD8iYfzacvPhSm
         Y8+gM8WVKycQz3t/c4yEnhbdT3Tyt8s7wSlMXAj4eqweMNGWJjCdnUq0R1K2jGqSzFGU
         P/xJbPP1etvJQfltPfg89WHXbfOzu34kx+Zll2yiCSvAJVP8Hf9hequMFbJDvuIHjhGh
         gARw==
X-Gm-Message-State: AOJu0YzYzzrUi1nc32OsAZt/nUf2H8On3XnvUvwNv926+4H8kA3Us6/E
        tzI2qWuE+Pagcg0vsAsQAwU=
X-Google-Smtp-Source: AGHT+IFvEPfpA/v2lWqalbgb8y7rsCvrt5ctKUb64iGmMDhnEj5omZtFyHYuVh9faGddfojaQc0X1Q==
X-Received: by 2002:a25:dcc8:0:b0:d86:52d8:bf40 with SMTP id y191-20020a25dcc8000000b00d8652d8bf40mr4052050ybe.17.1695554268640;
        Sun, 24 Sep 2023 04:17:48 -0700 (PDT)
Received: from Ainz-PC-Linux.. ([103.170.182.162])
        by smtp.googlemail.com with ESMTPSA id q9-20020a639809000000b00573f82bb00esm6037746pgd.2.2023.09.24.04.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 04:17:47 -0700 (PDT)
From:   Masum Reza <masumrezarock100@gmail.com>
Cc:     marcel@holtmann.org, Masum Reza <masumrezarock100@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add RTW8852BE device 13d3:3570 to device tables
Date:   Sun, 24 Sep 2023 16:46:55 +0530
Message-Id: <20230924111655.36749-1-masumrezarock100@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device is used in TP-Link TX20E WiFi+Bluetooth adapter.

Relevant information in /sys/kernel/debug/usb/devices
about the Bluetooth device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=08 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3570 Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Signed-off-by: Masum Reza <masumrezarock100@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 499f4809fcdf..86adeaa11725 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -543,6 +543,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0bda, 0x887b), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3570), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3571), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
-- 
2.39.2

