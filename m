Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B56780AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376560AbjHRLNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376592AbjHRLNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:13:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22E94228;
        Fri, 18 Aug 2023 04:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692357181; x=1723893181;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6lw+bj+V+CmqWk4clg9HEmaroeyMCvWSkT76IKDAsls=;
  b=CGrpULfWlbH8ohaDkp+SZpC6QT+8JU/T1FF0rh9ErEoc5k+ze1Oi2Y60
   XytaeXAPvNTF9p+W/wjmY1D/qX3EKTB9mO5uEOHedyS/EBh3PBUxrn2QR
   SqxiHx1O5fsUXTZYHz75dRlLDmprP8Jrdkyi4ixdNM9qaKTfGGnpUs/+A
   MXccs0YQsvqGESh6dKEnxDTzBZOvYO79541J8E1bijFIRToUecPqaqE4c
   h8qjfgXjorlMul43jlp7e8BT90qDZHL2qok1OSD7yRhfp9X483zTygAoI
   tMYOdK9vxxJvuE4pK2Nfs/tXcPQGsFaSfSEOvRmvzZPinxIRqzhz3HwtJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="376837682"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="376837682"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 04:12:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849252807"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="849252807"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2023 04:12:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 369D3E2A; Fri, 18 Aug 2023 14:12:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: core: Remove unused PORT_* definitions
Date:   Fri, 18 Aug 2023 14:12:29 +0300
Message-Id: <20230818111229.764380-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the last couple of years Linux kernel got rid of a few architectures
and many platforms. Hence some PORT_* definitions in the serial_core.h
become unused and redundant. Remove them for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/uapi/linux/serial_core.h | 43 ++------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 281fa286555c..c361570a334f 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -28,7 +28,7 @@
  */
 #define PORT_NS16550A	14
 #define PORT_XSCALE	15
-#define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
+
 #define PORT_OCTEON	17	/* Cavium OCTEON internal UART */
 #define PORT_AR7	18	/* Texas Instruments AR7 internal UART */
 #define PORT_U6_16550A	19	/* ST-Ericsson U6xxx internal UART */
@@ -94,15 +94,9 @@
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
 
@@ -112,51 +106,27 @@
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
@@ -164,9 +134,6 @@
 
 #define PORT_S3C6400	84
 
-/* NWPSERIAL, now removed */
-#define PORT_NWPSERIAL	85
-
 /* MAX3100 */
 #define PORT_MAX3100    86
 
@@ -225,13 +192,10 @@
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
@@ -243,9 +207,6 @@
 /* SPRD SERIAL  */
 #define PORT_SPRD	111
 
-/* Cris v10 / v32 SoC */
-#define PORT_CRIS	112
-
 /* STM32 USART */
 #define PORT_STM32	113
 
-- 
2.40.0.1.gaa8946217a0b

