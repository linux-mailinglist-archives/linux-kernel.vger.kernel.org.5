Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343177F2B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbjKULQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKULQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:16:37 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4BC9C;
        Tue, 21 Nov 2023 03:16:33 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cb9dd2ab56so1729799b3a.3;
        Tue, 21 Nov 2023 03:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700565393; x=1701170193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hsq5OvLrZNHPYavKIdE/h8XiIMaboUBjfZph7IRTKJI=;
        b=TNCRwgkHsJgLsNwepbmht1FrvwTvPV1uwbPzZSfYfr4WyXY+E/z+JmLDBKRiVg1bJT
         JySCQdwsaqbsuFei7IliMqMttwa93SfwTcM9mwVvHdLlzTzGHkVshJtmsxRYtxyi2Qnw
         4vHBtcenYRPdnm+N2iflElGtK1TSUuQ8aqhOEDPGfsQyeNyepPpkzocdeof/kEcPp/0H
         qUgLaLTkARviY82AjICYoJPCYw0QliSrLBti36+oAizPSPRCR3cJ5V9UrVoJ4Stl9taY
         zb4+Rg47tkBM6YQj6ky82YAgod5Pam0R0VBC+bsU8iXBYRKuFuJPmPUWR02DeF2IjfTy
         4PBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700565393; x=1701170193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hsq5OvLrZNHPYavKIdE/h8XiIMaboUBjfZph7IRTKJI=;
        b=mTvmxjOVxsFlnrCrXcCdD3aDesaB+9D82KbmrUXJXQBFiMJDUXo80Pf+w+0CVcwXm7
         GWBISd3FixZdMjafIlFhXp87SXi8/+o/90blTOoRZLS4qCrqJ5PrjFwi3ybjd+8R9ro/
         AHeYwkPF4cgd/y9n0evVn2S7dJPZ3HLriWUjIyscnceFRPRKUJ52YgWBEneYWWMfears
         Bj3OplQy+MoGCCY+Oae8f3oVPwuYN2aJS/UBqf1CtpPfJPgLM0XyRSCZPUjeWPW6Bj/J
         FpB08W9M/y+pgXs6DAMbM27NYzWjNU4F3QsGhIR4LDJulGA55TlCky0f84fxN0tXUvDu
         ewlw==
X-Gm-Message-State: AOJu0Yxvki6gW0+wgX0qAmIu1IZxpAr6+FAWxyWqkP4PeM4Y2d+dUpO/
        mXqNo78jwcR8AiZrDe3NAjc=
X-Google-Smtp-Source: AGHT+IErAOYYG6G8Kknk4ECT0hdmEc8VjQWQLW5b9EReFJBubzM/EM4lpJ6qP/UyCIDZxbb7BrZklg==
X-Received: by 2002:a05:6a21:a593:b0:187:6dab:578 with SMTP id gd19-20020a056a21a59300b001876dab0578mr9167334pzc.40.1700565392772;
        Tue, 21 Nov 2023 03:16:32 -0800 (PST)
Received: from localhost.localdomain ([156.251.180.79])
        by smtp.gmail.com with ESMTPSA id q22-20020a170902bd9600b001c736746d33sm7620522pls.217.2023.11.21.03.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 03:16:32 -0800 (PST)
From:   Sprite <spriteovo@gmail.com>
X-Google-Original-From: Sprite <SpriteOvO@gmail.com>
To:     johan@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sprite <SpriteOvO@gmail.com>, Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH] USB: serial: option: add Luat Air72*U series products
Date:   Tue, 21 Nov 2023 19:16:26 +0800
Message-ID: <20231121111626.64804-1-SpriteOvO@gmail.com>
X-Mailer: git-send-email 2.42.1
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

Update the USB serial option driver support for Luat Air72*U series
products.

ID 1782:4e00 Spreadtrum Communications Inc. UNISOC-8910

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 13 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1782 ProdID=4e00 Rev=00.00
S:  Manufacturer=UNISOC
S:  Product=UNISOC-8910
C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=400mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=e0(wlcon) Sub=01 Prot=03 Driver=rndis_host
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=4096ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Co-developed-by: Yangyu Chen <cyy@cyyself.name>
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Signed-off-by: Sprite <SpriteOvO@gmail.com>
---
 drivers/usb/serial/option.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 45dcfaadaf98..b76cb9a096f7 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -609,6 +609,8 @@ static void option_instat_callback(struct urb *urb);
 #define UNISOC_VENDOR_ID			0x1782
 /* TOZED LT70-C based on UNISOC SL8563 uses UNISOC's vendor ID */
 #define TOZED_PRODUCT_LT70C			0x4055
+/* Luat Air72*U series based on UNISOC UIS8910 uses UNISOC's vendor ID */
+#define LUAT_PRODUCT_AIR720U			0x4e00
 
 /* Device flags */
 
@@ -2271,6 +2273,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
-- 
2.42.1

