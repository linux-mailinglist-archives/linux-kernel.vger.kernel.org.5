Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16C17825AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjHUIja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbjHUIj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:39:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07B4E3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692607152; x=1724143152;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gvnnca0HSb1HBVIEY67jaDnmUFTvJUK6M4D6sUjIiMg=;
  b=XLuo0jls48kqw5HDwK7nhuzwyHBkrIRkLcE74TzFJ88WghBks51RjKi8
   4IBUWx0eoh5C8tnmx/GlSWPHTvuFm6CSlViGAitUfKN5CF7QHv18bZMBp
   /SVeDKA/TRK25PCbnk5tQFzkG8gqaVmrpLQyVKLs3p98GWFb1bhtWpSZY
   ULriELgMsFpZjE9t+xdRKCQYUfK+N09HHR0Trp8vex9pzIsnlCdntRM6X
   O9NAsk3nLJqVmWuON4fbaBYHbkg4O5i9OKDnd9TwtBMpslSXFOsvMP/A7
   4vdsZSNzxEgX0K1T3JhjBPjsc4nYZFGdNGa0OSqcv1yta+pv5Q1lIFKkh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="373501969"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="373501969"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 01:39:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="801192443"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="801192443"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 21 Aug 2023 01:39:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E23D21A5; Mon, 21 Aug 2023 11:39:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 1/1] serial: core: Remove unused PORT_* definitions
Date:   Mon, 21 Aug 2023 11:38:57 +0300
Message-Id: <20230821083857.1065282-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the last couple of years Linux kernel got rid of a few architectures
and many platforms. Hence some PORT_* definitions in the serial_core.h
become unused and redundant. Remove them for good.

Removed IDs are checked for users against Debian Code Search engine.
Hence safe to remove as there are no consumers found (only providers).

While at it, add a note about 0-13, that are defined in the other file.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: tested via DCS (Greg), dropped 1 change due to that, added a note for 0-13
 include/uapi/linux/serial_core.h | 43 +++-----------------------------
 1 file changed, 3 insertions(+), 40 deletions(-)

diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 281fa286555c..d19dabd2c20d 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -25,6 +25,8 @@
 
 /*
  * The type definitions.  These are from Ted Ts'o's serial.h
+ * By historical reasons the values from 0 to 13 are defined
+ * in the include/uapi/linux/serial.h, do not define them here.
  */
 #define PORT_NS16550A	14
 #define PORT_XSCALE	15
@@ -94,15 +96,9 @@
 #define PORT_SCIF	53
 #define PORT_IRDA	54
 
-/* Samsung S3C2410 SoC and derivatives thereof */
-#define PORT_S3C2410    55
-
 /* SGI IP22 aka Indy / Challenge S / Indigo 2 */
 #define PORT_IP22ZILOG	56
 
-/* Sharp LH7a40x -- an ARM9 SoC series */
-#define PORT_LH7A40X	57
-
 /* PPC CPM type number */
 #define PORT_CPM        58
 
@@ -112,51 +108,27 @@
 /* IBM icom */
 #define PORT_ICOM	60
 
-/* Samsung S3C2440 SoC */
-#define PORT_S3C2440	61
-
 /* Motorola i.MX SoC */
 #define PORT_IMX	62
 
-/* Marvell MPSC (obsolete unused) */
-#define PORT_MPSC	63
-
 /* TXX9 type number */
 #define PORT_TXX9	64
 
-/* Samsung S3C2400 SoC */
-#define PORT_S3C2400	67
-
-/* M32R SIO */
-#define PORT_M32R_SIO	68
-
 /*Digi jsm */
 #define PORT_JSM        69
 
 /* SUN4V Hypervisor Console */
 #define PORT_SUNHV	72
 
-#define PORT_S3C2412	73
-
 /* Xilinx uartlite */
 #define PORT_UARTLITE	74
 
-/* Blackfin bf5xx */
-#define PORT_BFIN	75
-
 /* Broadcom SB1250, etc. SOC */
 #define PORT_SB1250_DUART	77
 
 /* Freescale ColdFire */
 #define PORT_MCF	78
 
-/* Blackfin SPORT */
-#define PORT_BFIN_SPORT		79
-
-/* MN10300 on-chip UART numbers */
-#define PORT_MN10300		80
-#define PORT_MN10300_CTS	81
-
 #define PORT_SC26XX	82
 
 /* SH-SCI */
@@ -164,9 +136,6 @@
 
 #define PORT_S3C6400	84
 
-/* NWPSERIAL, now removed */
-#define PORT_NWPSERIAL	85
-
 /* MAX3100 */
 #define PORT_MAX3100    86
 
@@ -225,13 +194,10 @@
 /* ST ASC type numbers */
 #define PORT_ASC       105
 
-/* Tilera TILE-Gx UART */
-#define PORT_TILEGX	106
-
 /* MEN 16z135 UART */
 #define PORT_MEN_Z135	107
 
-/* SC16IS74xx */
+/* SC16IS7xx */
 #define PORT_SC16IS7XX   108
 
 /* MESON */
@@ -243,9 +209,6 @@
 /* SPRD SERIAL  */
 #define PORT_SPRD	111
 
-/* Cris v10 / v32 SoC */
-#define PORT_CRIS	112
-
 /* STM32 USART */
 #define PORT_STM32	113
 
-- 
2.40.0.1.gaa8946217a0b

