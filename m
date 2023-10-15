Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D0E7C98CC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 13:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjJOL0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 07:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjJOL0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 07:26:39 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4AED9;
        Sun, 15 Oct 2023 04:26:36 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-1e59894d105so2127457fac.1;
        Sun, 15 Oct 2023 04:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697369196; x=1697973996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aIP1YzudvKKCulfceAKZGd9fAuchfUzeWguBA1vwXP0=;
        b=H1V58LXNrf81PO5xqhvW3EYDfGnPdWkk0CFxmyUxqd7GxApCGrQihoVIqPoZWFTP9M
         /C2kVsFN+19IRre5ysnjfmXjmv7Bm3SV+bFIkuWWCNOT50mIOM12AVnVWMNNy2xk6TZl
         sP5v1VYBff+vyJmLM596bPvjFqIUJ3QfnYs0WTdyz/Ip//QODAzvVIACrARSLxy1p8Ro
         NG/g5vwpJljrAYFtVgFJJRLCMnqY3xSKCQ6HUDLbI+N6RfwlzFtpw02HW7+TTKg/OlVv
         HAPtBLpSng+obLFZIbovOP1FPgfoZJT/5+205gZBsN/azk6aVev9nN4A9Ltxbl5SYOPL
         QXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697369196; x=1697973996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIP1YzudvKKCulfceAKZGd9fAuchfUzeWguBA1vwXP0=;
        b=hs+cm+vXnXre8jhFWRfn1/Hxy8x139EEDoqim2QEVgrq5sfcSB4tdj4evLe8r7eNlj
         82bxtM0CnKgVlfECbRZvh4tIpqzIqKNPRm9qLnr8dMXm0zPd8uW4sTO6FHck/NwAgl1v
         hyNUBpXf0HSyLzQyjudKuXEUwtpW77AQZwbXdrtPC6K2iVNbeLCMlVDy6V82dAAJzPhQ
         FxbDjcNb83K1Qqx9kiovLal+0HR8bjPftsh39vKIKtd38QlXCjSa+jSMQS73HBgSEn7X
         7Vd7hrdnVpcwWdi/Q4dBRZMQPOgPdvttSodUPpGOncHo6EGocgjZttYsfxoZmifgk2oz
         ombA==
X-Gm-Message-State: AOJu0YxIWWOgT6FNv5EG6dsH3YVdRxpB5iix6RpprqkW8qmKB+tVawIY
        pnHb4u7bhzywXfhlRJRTsUu3ZEKanQSyuge1U5o=
X-Google-Smtp-Source: AGHT+IFgrv6NQ6q82bEbRsbaRFOHFqTc6aq6QkKCjP26uEWQC+Nh1guy2tlIIdxA51oYHMs1i3svMw==
X-Received: by 2002:a05:6871:1d2:b0:1c3:91b9:e1e7 with SMTP id q18-20020a05687101d200b001c391b9e1e7mr35599924oad.21.1697369195625;
        Sun, 15 Oct 2023 04:26:35 -0700 (PDT)
Received: from localhost ([2409:8a3c:3640:7481:178a:30e9:674c:c2f3])
        by smtp.gmail.com with ESMTPSA id f9-20020a639c09000000b005781e026905sm6004455pge.56.2023.10.15.04.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 04:26:35 -0700 (PDT)
From:   John Sanpe <sanpeqf@gmail.com>
To:     andrew.smirnov@gmail.com, cphealy@gmail.com,
        mm-commits@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, John Sanpe <sanpeqf@gmail.com>
Subject: [PATCH] lib/crc-ccitt: remove ccitt_false function
Date:   Sun, 15 Oct 2023 19:26:29 +0800
Message-ID: <20231015112629.872546-1-sanpeqf@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ccitt_false polynomial is consistent with itu-t, the
only difference is that the initial crc value is different.

Signed-off-by: John Sanpe <sanpeqf@gmail.com>
---
 .../driver-api/surface_aggregator/ssh.rst     |  2 +-
 drivers/mfd/Kconfig                           |  2 +-
 drivers/mfd/rave-sp.c                         |  6 +-
 drivers/platform/surface/aggregator/Kconfig   |  2 +-
 include/linux/crc-ccitt.h                     |  7 ---
 include/linux/surface_aggregator/serial_hub.h |  4 +-
 lib/crc-ccitt.c                               | 55 -------------------
 7 files changed, 8 insertions(+), 70 deletions(-)

diff --git a/Documentation/driver-api/surface_aggregator/ssh.rst b/Documentation/driver-api/surface_aggregator/ssh.rst
index b955b673838b..58a757319931 100644
--- a/Documentation/driver-api/surface_aggregator/ssh.rst
+++ b/Documentation/driver-api/surface_aggregator/ssh.rst
@@ -39,7 +39,7 @@ Note that the standard disclaimer for this subsystem also applies to this
 document: All of this has been reverse-engineered and may thus be erroneous
 and/or incomplete.
 
-All CRCs used in the following are two-byte ``crc_ccitt_false(0xffff, ...)``.
+All CRCs used in the following are two-byte ``crc_itu_t(0xffff, ...)``.
 All multi-byte values are little-endian, there is no implicit padding between
 values.
 
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 90ce58fd629e..925c19ee513b 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2255,7 +2255,7 @@ config MFD_VEXPRESS_SYSREG
 config RAVE_SP_CORE
 	tristate "RAVE SP MCU core driver"
 	depends on SERIAL_DEV_BUS
-	select CRC_CCITT
+	select CRC_ITU_T
 	help
 	  Select this to get support for the Supervisory Processor
 	  device found on several devices in RAVE line of hardware.
diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index da50eba10014..44ce7e730744 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -9,7 +9,7 @@
  */
 
 #include <linux/atomic.h>
-#include <linux/crc-ccitt.h>
+#include <linux/crc-itu-t.h>
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/init.h>
@@ -251,11 +251,11 @@ static void csum_8b2c(const u8 *buf, size_t size, u8 *crc)
 
 static void csum_ccitt(const u8 *buf, size_t size, u8 *crc)
 {
-	const u16 calculated = crc_ccitt_false(0xffff, buf, size);
+	const u16 calculated = crc_itu_t(0xffff, buf, size);
 
 	/*
 	 * While the rest of the wire protocol is little-endian,
-	 * CCITT-16 CRC in RDU2 device is sent out in big-endian order.
+	 * ITU-T-16 CRC in RDU2 device is sent out in big-endian order.
 	 */
 	put_unaligned_be16(calculated, crc);
 }
diff --git a/drivers/platform/surface/aggregator/Kconfig b/drivers/platform/surface/aggregator/Kconfig
index 88afc38ffdc5..957c216c180c 100644
--- a/drivers/platform/surface/aggregator/Kconfig
+++ b/drivers/platform/surface/aggregator/Kconfig
@@ -5,7 +5,7 @@ menuconfig SURFACE_AGGREGATOR
 	tristate "Microsoft Surface System Aggregator Module Subsystem and Drivers"
 	depends on SERIAL_DEV_BUS
 	depends on ACPI && !RISCV
-	select CRC_CCITT
+	select CRC_ITU_T
 	help
 	  The Surface System Aggregator Module (Surface SAM or SSAM) is an
 	  embedded controller (EC) found on 5th- and later-generation Microsoft
diff --git a/include/linux/crc-ccitt.h b/include/linux/crc-ccitt.h
index 72c92c396bb8..cd4f420231ba 100644
--- a/include/linux/crc-ccitt.h
+++ b/include/linux/crc-ccitt.h
@@ -5,19 +5,12 @@
 #include <linux/types.h>
 
 extern u16 const crc_ccitt_table[256];
-extern u16 const crc_ccitt_false_table[256];
 
 extern u16 crc_ccitt(u16 crc, const u8 *buffer, size_t len);
-extern u16 crc_ccitt_false(u16 crc, const u8 *buffer, size_t len);
 
 static inline u16 crc_ccitt_byte(u16 crc, const u8 c)
 {
 	return (crc >> 8) ^ crc_ccitt_table[(crc ^ c) & 0xff];
 }
 
-static inline u16 crc_ccitt_false_byte(u16 crc, const u8 c)
-{
-    return (crc << 8) ^ crc_ccitt_false_table[(crc >> 8) ^ c];
-}
-
 #endif /* _LINUX_CRC_CCITT_H */
diff --git a/include/linux/surface_aggregator/serial_hub.h b/include/linux/surface_aggregator/serial_hub.h
index 5c4ae1a26183..d8dbef6b7fc2 100644
--- a/include/linux/surface_aggregator/serial_hub.h
+++ b/include/linux/surface_aggregator/serial_hub.h
@@ -12,7 +12,7 @@
 #ifndef _LINUX_SURFACE_AGGREGATOR_SERIAL_HUB_H
 #define _LINUX_SURFACE_AGGREGATOR_SERIAL_HUB_H
 
-#include <linux/crc-ccitt.h>
+#include <linux/crc-itu-t.h>
 #include <linux/kref.h>
 #include <linux/ktime.h>
 #include <linux/list.h>
@@ -188,7 +188,7 @@ static_assert(sizeof(struct ssh_command) == 8);
  */
 static inline u16 ssh_crc(const u8 *buf, size_t len)
 {
-	return crc_ccitt_false(0xffff, buf, len);
+	return crc_itu_t(0xffff, buf, len);
 }
 
 /*
diff --git a/lib/crc-ccitt.c b/lib/crc-ccitt.c
index d1a7d29d2ac9..9cddf35d3b66 100644
--- a/lib/crc-ccitt.c
+++ b/lib/crc-ccitt.c
@@ -49,46 +49,6 @@ u16 const crc_ccitt_table[256] = {
 };
 EXPORT_SYMBOL(crc_ccitt_table);
 
-/*
- * Similar table to calculate CRC16 variant known as CRC-CCITT-FALSE
- * Reflected bits order, does not augment final value.
- */
-u16 const crc_ccitt_false_table[256] = {
-    0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50A5, 0x60C6, 0x70E7,
-    0x8108, 0x9129, 0xA14A, 0xB16B, 0xC18C, 0xD1AD, 0xE1CE, 0xF1EF,
-    0x1231, 0x0210, 0x3273, 0x2252, 0x52B5, 0x4294, 0x72F7, 0x62D6,
-    0x9339, 0x8318, 0xB37B, 0xA35A, 0xD3BD, 0xC39C, 0xF3FF, 0xE3DE,
-    0x2462, 0x3443, 0x0420, 0x1401, 0x64E6, 0x74C7, 0x44A4, 0x5485,
-    0xA56A, 0xB54B, 0x8528, 0x9509, 0xE5EE, 0xF5CF, 0xC5AC, 0xD58D,
-    0x3653, 0x2672, 0x1611, 0x0630, 0x76D7, 0x66F6, 0x5695, 0x46B4,
-    0xB75B, 0xA77A, 0x9719, 0x8738, 0xF7DF, 0xE7FE, 0xD79D, 0xC7BC,
-    0x48C4, 0x58E5, 0x6886, 0x78A7, 0x0840, 0x1861, 0x2802, 0x3823,
-    0xC9CC, 0xD9ED, 0xE98E, 0xF9AF, 0x8948, 0x9969, 0xA90A, 0xB92B,
-    0x5AF5, 0x4AD4, 0x7AB7, 0x6A96, 0x1A71, 0x0A50, 0x3A33, 0x2A12,
-    0xDBFD, 0xCBDC, 0xFBBF, 0xEB9E, 0x9B79, 0x8B58, 0xBB3B, 0xAB1A,
-    0x6CA6, 0x7C87, 0x4CE4, 0x5CC5, 0x2C22, 0x3C03, 0x0C60, 0x1C41,
-    0xEDAE, 0xFD8F, 0xCDEC, 0xDDCD, 0xAD2A, 0xBD0B, 0x8D68, 0x9D49,
-    0x7E97, 0x6EB6, 0x5ED5, 0x4EF4, 0x3E13, 0x2E32, 0x1E51, 0x0E70,
-    0xFF9F, 0xEFBE, 0xDFDD, 0xCFFC, 0xBF1B, 0xAF3A, 0x9F59, 0x8F78,
-    0x9188, 0x81A9, 0xB1CA, 0xA1EB, 0xD10C, 0xC12D, 0xF14E, 0xE16F,
-    0x1080, 0x00A1, 0x30C2, 0x20E3, 0x5004, 0x4025, 0x7046, 0x6067,
-    0x83B9, 0x9398, 0xA3FB, 0xB3DA, 0xC33D, 0xD31C, 0xE37F, 0xF35E,
-    0x02B1, 0x1290, 0x22F3, 0x32D2, 0x4235, 0x5214, 0x6277, 0x7256,
-    0xB5EA, 0xA5CB, 0x95A8, 0x8589, 0xF56E, 0xE54F, 0xD52C, 0xC50D,
-    0x34E2, 0x24C3, 0x14A0, 0x0481, 0x7466, 0x6447, 0x5424, 0x4405,
-    0xA7DB, 0xB7FA, 0x8799, 0x97B8, 0xE75F, 0xF77E, 0xC71D, 0xD73C,
-    0x26D3, 0x36F2, 0x0691, 0x16B0, 0x6657, 0x7676, 0x4615, 0x5634,
-    0xD94C, 0xC96D, 0xF90E, 0xE92F, 0x99C8, 0x89E9, 0xB98A, 0xA9AB,
-    0x5844, 0x4865, 0x7806, 0x6827, 0x18C0, 0x08E1, 0x3882, 0x28A3,
-    0xCB7D, 0xDB5C, 0xEB3F, 0xFB1E, 0x8BF9, 0x9BD8, 0xABBB, 0xBB9A,
-    0x4A75, 0x5A54, 0x6A37, 0x7A16, 0x0AF1, 0x1AD0, 0x2AB3, 0x3A92,
-    0xFD2E, 0xED0F, 0xDD6C, 0xCD4D, 0xBDAA, 0xAD8B, 0x9DE8, 0x8DC9,
-    0x7C26, 0x6C07, 0x5C64, 0x4C45, 0x3CA2, 0x2C83, 0x1CE0, 0x0CC1,
-    0xEF1F, 0xFF3E, 0xCF5D, 0xDF7C, 0xAF9B, 0xBFBA, 0x8FD9, 0x9FF8,
-    0x6E17, 0x7E36, 0x4E55, 0x5E74, 0x2E93, 0x3EB2, 0x0ED1, 0x1EF0
-};
-EXPORT_SYMBOL(crc_ccitt_false_table);
-
 /**
  *	crc_ccitt - recompute the CRC (CRC-CCITT variant) for the data
  *	buffer
@@ -104,20 +64,5 @@ u16 crc_ccitt(u16 crc, u8 const *buffer, size_t len)
 }
 EXPORT_SYMBOL(crc_ccitt);
 
-/**
- *	crc_ccitt_false - recompute the CRC (CRC-CCITT-FALSE variant)
- *	for the data buffer
- *	@crc: previous CRC value
- *	@buffer: data pointer
- *	@len: number of bytes in the buffer
- */
-u16 crc_ccitt_false(u16 crc, u8 const *buffer, size_t len)
-{
-	while (len--)
-		crc = crc_ccitt_false_byte(crc, *buffer++);
-	return crc;
-}
-EXPORT_SYMBOL(crc_ccitt_false);
-
 MODULE_DESCRIPTION("CRC-CCITT calculations");
 MODULE_LICENSE("GPL");
-- 
2.41.0

