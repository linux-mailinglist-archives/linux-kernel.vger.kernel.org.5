Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F10809523
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444081AbjLGWOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444057AbjLGWOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:14:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F7B10F9;
        Thu,  7 Dec 2023 14:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701987277; x=1733523277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+9rjm8/R+ymt6ecjZHbZjfxI3PAzoqkWcm1btj/h204=;
  b=TdktQAo6+9P5/R+opp1ZtfjcJh40gSU2RQ3JZ0gBfd4K7mXrplykPR86
   PGyBJ9Ths6L8fgOXRrrJfKIUL8IJqbpZ9AL1mAjpbG5+XVrdKFZpbRe+A
   FJyiZVgI72WGTYZ8aR9ReK2udBig37qL9jPzJMGCslKdmMlbS0pxb6WUO
   Q3pMRcofny9ia8NqwntGqLYJzeeXpbVwmn0rm1xMfoUntp9cOvxlqW0dF
   EZCu+91cgETZQZ3+dHUGSlfPOyi0YUh0irIpwYYMQjyFVeJQxLvmCU877
   FXZ+ampfoDpg/Hy14gh5yaqWavQVFfPvu+FdcVcO3PPwSYI+avixbqfZJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1197562"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1197562"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:14:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="842365245"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="842365245"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 07 Dec 2023 14:14:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 148CD154; Fri,  8 Dec 2023 00:14:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/2] spi: pxa2xx: Use inclusive language
Date:   Fri,  8 Dec 2023 00:13:39 +0200
Message-ID: <20231207221426.3259806-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231207221426.3259806-1-andriy.shevchenko@linux.intel.com>
References: <20231207221426.3259806-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace master/slave by host/peripheral language in the documentation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/spi/pxa2xx.rst | 48 ++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/spi/pxa2xx.rst b/Documentation/spi/pxa2xx.rst
index 04f2a3856c40..b66702724ccf 100644
--- a/Documentation/spi/pxa2xx.rst
+++ b/Documentation/spi/pxa2xx.rst
@@ -3,13 +3,13 @@ PXA2xx SPI on SSP driver HOWTO
 ==============================
 
 This a mini HOWTO on the pxa2xx_spi driver. The driver turns a PXA2xx
-synchronous serial port into an SPI master controller
+synchronous serial port into an SPI host controller
 (see Documentation/spi/spi-summary.rst). The driver has the following features
 
 - Support for any PXA2xx and compatible SSP.
 - SSP PIO and SSP DMA data transfers.
 - External and Internal (SSPFRM) chip selects.
-- Per slave device (chip) configuration.
+- Per peripheral device (chip) configuration.
 - Full suspend, freeze, resume support.
 
 The driver is built around a &struct spi_message FIFO serviced by kernel
@@ -17,10 +17,10 @@ thread. The kernel thread, spi_pump_messages(), drives message FIFO and
 is responsible for queuing SPI transactions and setting up and launching
 the DMA or interrupt driven transfers.
 
-Declaring PXA2xx Master Controllers
------------------------------------
-Typically, for a legacy platform, an SPI master is defined in the
-arch/.../mach-*/board-*.c as a "platform device". The master configuration
+Declaring PXA2xx host controllers
+---------------------------------
+Typically, for a legacy platform, an SPI host is defined in the
+arch/.../mach-*/board-*.c as a "platform device". The host configuration
 is passed to the driver via a table found in include/linux/spi/pxa2xx_spi.h::
 
   struct pxa2xx_spi_controller {
@@ -30,7 +30,7 @@ is passed to the driver via a table found in include/linux/spi/pxa2xx_spi.h::
   };
 
 The "pxa2xx_spi_controller.num_chipselect" field is used to determine the number of
-slave device (chips) attached to this SPI master.
+peripheral devices (chips) attached to this SPI host controller.
 
 The "pxa2xx_spi_controller.enable_dma" field informs the driver that SSP DMA should
 be used. This caused the driver to acquire two DMA channels: Rx channel and
@@ -40,8 +40,8 @@ See the "PXA2xx Developer Manual" section "DMA Controller".
 For the new platforms the description of the controller and peripheral devices
 comes from Device Tree or ACPI.
 
-NSSP MASTER SAMPLE
-------------------
+NSSP HOST SAMPLE
+----------------
 Below is a sample configuration using the PXA255 NSSP for a legacy platform::
 
   static struct resource pxa_spi_nssp_resources[] = {
@@ -57,7 +57,7 @@ Below is a sample configuration using the PXA255 NSSP for a legacy platform::
 	},
   };
 
-  static struct pxa2xx_spi_controller pxa_nssp_master_info = {
+  static struct pxa2xx_spi_controller pxa_nssp_ctrl_info = {
 	.num_chipselect = 1, /* Matches the number of chips attached to NSSP */
 	.enable_dma = 1, /* Enables NSSP DMA */
   };
@@ -68,7 +68,7 @@ Below is a sample configuration using the PXA255 NSSP for a legacy platform::
 	.resource = pxa_spi_nssp_resources,
 	.num_resources = ARRAY_SIZE(pxa_spi_nssp_resources),
 	.dev = {
-		.platform_data = &pxa_nssp_master_info, /* Passed to driver */
+		.platform_data = &pxa_nssp_ctrl_info, /* Passed to driver */
 	},
   };
 
@@ -81,17 +81,17 @@ Below is a sample configuration using the PXA255 NSSP for a legacy platform::
 	(void)platform_add_device(devices, ARRAY_SIZE(devices));
   }
 
-Declaring Slave Devices
------------------------
-Typically, for a legacy platform, each SPI slave (chip) is defined in the
+Declaring peripheral devices
+----------------------------
+Typically, for a legacy platform, each SPI peripheral device (chip) is defined in the
 arch/.../mach-*/board-*.c using the "spi_board_info" structure found in
 "linux/spi/spi.h". See "Documentation/spi/spi-summary.rst" for additional
 information.
 
-Each slave device attached to the PXA must provide slave specific configuration
+Each peripheral device (chip) attached to the PXA must provide specific chip configuration
 information via the structure "pxa2xx_spi_chip" found in
-"include/linux/spi/pxa2xx_spi.h".  The pxa2xx_spi master controller driver
-will uses the configuration whenever the driver communicates with the slave
+"include/linux/spi/pxa2xx_spi.h". The pxa2xx_spi host controller driver
+will uses the configuration whenever the driver communicates with the peripheral
 device. All fields are optional.
 
 ::
@@ -123,7 +123,7 @@ dma_burst_size == 0.
 The "pxa2xx_spi_chip.timeout" fields is used to efficiently handle
 trailing bytes in the SSP receiver FIFO. The correct value for this field is
 dependent on the SPI bus speed ("spi_board_info.max_speed_hz") and the specific
-slave device.  Please note that the PXA2xx SSP 1 does not support trailing byte
+peripheral device. Please note that the PXA2xx SSP 1 does not support trailing byte
 timeouts and must busy-wait any trailing bytes.
 
 NOTE: the SPI driver cannot control the chip select if SSPFRM is used, so the
@@ -132,8 +132,8 @@ asserted around the complete message. Use SSPFRM as a GPIO (through a descriptor
 to accommodate these chips.
 
 
-NSSP SLAVE SAMPLE
------------------
+NSSP PERIPHERAL SAMPLE
+----------------------
 For a legacy platform or in some other cases, the pxa2xx_spi_chip structure
 is passed to the pxa2xx_spi driver in the "spi_board_info.controller_data"
 field. Below is a sample configuration using the PXA255 NSSP.
@@ -161,16 +161,16 @@ field. Below is a sample configuration using the PXA255 NSSP.
 		.bus_num = 2, /* Framework bus number */
 		.chip_select = 0, /* Framework chip select */
 		.platform_data = NULL; /* No spi_driver specific config */
-		.controller_data = &cs8415a_chip_info, /* Master chip config */
-		.irq = STREETRACER_APCI_IRQ, /* Slave device interrupt */
+		.controller_data = &cs8415a_chip_info, /* Host controller config */
+		.irq = STREETRACER_APCI_IRQ, /* Peripheral device interrupt */
 	},
 	{
 		.modalias = "cs8405a", /* Name of spi_driver for this device */
 		.max_speed_hz = 3686400, /* Run SSP as fast a possible */
 		.bus_num = 2, /* Framework bus number */
 		.chip_select = 1, /* Framework chip select */
-		.controller_data = &cs8405a_chip_info, /* Master chip config */
-		.irq = STREETRACER_APCI_IRQ, /* Slave device interrupt */
+		.controller_data = &cs8405a_chip_info, /* Host controller config */
+		.irq = STREETRACER_APCI_IRQ, /* Peripheral device interrupt */
 	},
   };
 
-- 
2.43.0.rc1.1.gbec44491f096

