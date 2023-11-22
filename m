Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E858F7F48BD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjKVOSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjKVOSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:18:13 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B38A97;
        Wed, 22 Nov 2023 06:18:10 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6c4eb5fda3cso6812557b3a.2;
        Wed, 22 Nov 2023 06:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700662689; x=1701267489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e/bl+HpMTJTHISOhj4vCvITdZg7HQqKMUYriE/MKkOk=;
        b=CjQFyZKjEy+b0clVzQlOevf4yoip7r0keY/bKEd7kSzacHf+4dqY56tUufFLFJe4ll
         zemgIfEnF2U3x0Imq57UknwcnzPgirxSoeghGPj2luuCFfauO7+pG7fKuDLb8yP4VEJ4
         pZe+2Kt1S3lWa+qlwgIB0mXszc15Q4RxGAWId8UO6Uch7w/pbiChu/AgDWLlqzQ4Ngrt
         +JE1VI5KlgThBk8eWJSZmsLirDihgc+OULY0L/IRF/R4urE9Tx9sufsQGRzYTKAlSxA5
         tk5eS4GwPC35ckhL4jIWMFKdn5bXo+dwCs/WJtJ2YOF66vALkfQrLTrQahPTHDbHFydq
         HjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662689; x=1701267489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/bl+HpMTJTHISOhj4vCvITdZg7HQqKMUYriE/MKkOk=;
        b=km9y6ZRNmFbko8pWuZE7rstpUVZ10ziPf4XxOiKQYHg24aFXhN3OIuu59pyxIXoiLb
         MyNPaE+ym1aAU307Ccneia71ZMdvAxPuRTB9rO9rYPqoo9RWCemu/7FaTvn6xgofkdHC
         4RsStgQ/I7jBQWKzoXnoocUP9hxiWPGVoOT5YptYs7jvJNJf3/Se1JmYWHclrHw9Fc4t
         Dd3NnKkXhmb19SlwvuNCCHeH+LtuI/I/MpTC0kPJWfsYT+jKRMBn9tDRDpYcIOuC39Pn
         KGh4loUhidaEVSDomWZ/D5OTSn7j03lkUzIm7k5ebC2jscGSDaOwoMhJatOe2tmg6ATM
         hQ2Q==
X-Gm-Message-State: AOJu0YyTXLcegQ4qXYlpVesp6EigOT8Web9deOCQ3Uq90mgrSB6v5Gp9
        gmGjfvZOg9rFN4NIfNWIpZo=
X-Google-Smtp-Source: AGHT+IGavlWwLDmkiZ6Jaki1adWqKlyaSlJenK3G9pnWv/expFADA4dSDmOVdtriA4LDTpqtp3GCwQ==
X-Received: by 2002:a05:6a00:1149:b0:6cb:d24b:8c2e with SMTP id b9-20020a056a00114900b006cbd24b8c2emr1248130pfm.13.1700662689287;
        Wed, 22 Nov 2023 06:18:09 -0800 (PST)
Received: from localhost.localdomain ([156.251.180.79])
        by smtp.gmail.com with ESMTPSA id e11-20020a056a001a8b00b006cb955dc54csm5781646pfv.58.2023.11.22.06.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:18:08 -0800 (PST)
From:   Asuna Yang <spriteovo@gmail.com>
X-Google-Original-From: Asuna Yang <SpriteOvO@gmail.com>
To:     johan@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Asuna Yang <SpriteOvO@gmail.com>,
        Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v2] USB: serial: option: add Luat Air72*U series products
Date:   Wed, 22 Nov 2023 22:18:03 +0800
Message-ID: <20231122141803.82844-1-SpriteOvO@gmail.com>
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

T: Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 13 Spd=480 MxCh= 0
D: Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs= 1
P: Vendor=1782 ProdID=4e00 Rev=00.00
S: Manufacturer=UNISOC
S: Product=UNISOC-8910
C: #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=400mA
I: If#= 0 Alt= 0 #EPs= 1 Cls=e0(wlcon) Sub=01 Prot=03 Driver=rndis_host
E: Ad=82(I) Atr=03(Int.) MxPS= 8 Ivl=4096ms
I: If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
E: Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I: If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E: Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I: If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E: Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I: If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E: Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Co-developed-by: Yangyu Chen <cyy@cyyself.name>
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Signed-off-by: Asuna Yang <SpriteOvO@gmail.com>
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

