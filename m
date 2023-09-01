Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57CE78FAF9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344285AbjIAJg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbjIAJg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:36:26 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AAFC5;
        Fri,  1 Sep 2023 02:36:22 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4122e42a76aso11539091cf.1;
        Fri, 01 Sep 2023 02:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693560982; x=1694165782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uTRQG1+/zAJ7lIWvTYtqhGkQhkus5847tvqfQhvtoOc=;
        b=JFLUvFFvMI/5Zz9typC2aAuKpdxKQLrxvLDYF1vtukKUNnvMx6BOmmRSHqIRm+O0NR
         M4B9MnlTkz8rvMgShv1/AYgEDw7r9hEzHJd0J9BzIwbXXOGElaG99xNkO+yOSaKMNjfb
         nz3nTK6n8IDhwYxLacasMLrenSZXViwS1wXe3OQqwqXDJBUoTv4aeStDdG6POEEUB+Xt
         aUNuJDLgHex+hApjD98G1pLTOqpVU0+ZnU/HW2bwXGMLnzj8KjUSzbCGSCwbDQ6fvRDw
         xABxOroz7/DouLF9WVnjgzPL32lZ9hcD+Dm6FeIeempkqol0UQY7fWbdJZNL9td5tSVx
         Ta5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693560982; x=1694165782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uTRQG1+/zAJ7lIWvTYtqhGkQhkus5847tvqfQhvtoOc=;
        b=DGPqWjrl9wNn0zAb9dBSBKQCwF6XqLmutdzvCzIVAqVTPfwqZfG1t2U8ugmtZNBpXA
         2UkDAWgEH+j4qB4O4a4SR+JDNq+H5Ys837lLxzy30+hgS5AFrY1+5HSPO2tDX2mTcEZm
         +EwNnSNDjQfRHGu03MFoS+rNIWBL3M1d2S/OfHBuBRrIjT1c9lTzNmu9vEc37/dCaz6E
         YdTz/UXhl7PKdCz3HEmtRgvEUYKACVKAkPtSrEEJ6lLsN1qUF/V7jKCmCmesErJzlnJs
         z00aUX27fCagq1mbtKh99vPd4gH0q6Z/1MtsHsHUMQYzSC3Szgbf1dQj8+hcLqkB8ugw
         8ytw==
X-Gm-Message-State: AOJu0Yxo1R9TTiUKXXEVQ4QNZ8vJydJe+H/yKUAGD26pBcjZdGsIhE+l
        oE62fH2VqMi23vpg+iZsY2NPqiMqgWGKK9VF
X-Google-Smtp-Source: AGHT+IHPr+svbcwGAypvvN3zhI371quMWxwVuAfORSKfJaLPlDOZDl0w724FzBstEnoD7p8ccsbhFw==
X-Received: by 2002:ac8:7d16:0:b0:402:2e84:f06e with SMTP id g22-20020ac87d16000000b004022e84f06emr2451321qtb.27.1693560981816;
        Fri, 01 Sep 2023 02:36:21 -0700 (PDT)
Received: from ght-Latitude-7640.. ([149.28.230.27])
        by smtp.gmail.com with ESMTPSA id r11-20020ac87eeb000000b00403c82c609asm1310270qtc.14.2023.09.01.02.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 02:36:21 -0700 (PDT)
From:   Puliang Lu <530194200.fh@gmail.com>
X-Google-Original-From: Puliang Lu <puliang.lu@fibocom.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Puliang Lu <puliang.lu@fibocom.com>
Subject: [PATCH] USB: serial: option: add Fibocom to DELL custom modem FM101R-GL
Date:   Fri,  1 Sep 2023 17:36:10 +0800
Message-Id: <20230901093610.67438-1-puliang.lu@fibocom.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the USB serial option driver support for the Fibocom
FM101R-GL
LTE modules as there are actually several different variants.
- VID:PID 413C:8213, FM101R-GL are laptop M.2 cards (with
MBIM interfaces for Linux)
- VID:PID 413C:8215, FM101R-GL ESIM are laptop M.2 cards(with
MBIM interface for Linux)

T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=5000 MxCh= 0
D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=413c ProdID=8213 Rev= 5.04
S:  Manufacturer=Fibocom Wireless Inc.
S:  Product=Fibocom FM101-GL Module
S:  SerialNumber=a3b7cbf0
C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=896mA
A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=8e(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=0f(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40 Driver=(none)
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms

T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  3 Spd=5000 MxCh= 0
D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=413c ProdID=8215 Rev= 5.04
S:  Manufacturer=Fibocom Wireless Inc.
S:  Product=Fibocom FM101-GL Module
S:  SerialNumber=a3b7cbf0
C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=896mA
A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=8e(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=0f(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40 Driver=(none)
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms

Signed-off-by: Puliang Lu <puliang.lu@fibocom.com>
---
 drivers/usb/serial/option.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 8ac98e60fff5..1dcd1f068f23 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -203,6 +203,9 @@ static void option_instat_callback(struct urb *urb);
 #define DELL_PRODUCT_5829E_ESIM			0x81e4
 #define DELL_PRODUCT_5829E			0x81e6
 
+#define DELL_PRODUCT_FM101R			0x8213
+#define DELL_PRODUCT_FM101R_ESIM		0x8215
+
 #define KYOCERA_VENDOR_ID			0x0c88
 #define KYOCERA_PRODUCT_KPC650			0x17da
 #define KYOCERA_PRODUCT_KPC680			0x180a
@@ -1107,6 +1110,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | RSVD(6) },
 	{ USB_DEVICE(DELL_VENDOR_ID, DELL_PRODUCT_5829E_ESIM),
 	  .driver_info = RSVD(0) | RSVD(6) },
+	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_FM101R, 0xff) },
+	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_FM101R_ESIM, 0xff) },
 	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_E100A) },	/* ADU-E100, ADU-310 */
 	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_500A) },
 	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_620UW) },
-- 
2.34.1

