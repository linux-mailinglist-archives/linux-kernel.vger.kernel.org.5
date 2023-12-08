Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7970080A9FD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjLHREh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjLHREe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:04:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B62BA;
        Fri,  8 Dec 2023 09:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702055080; x=1733591080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eLexHLDuIGRipR5ryxhx1W/iX5Ccx/0q1xyo5G9jfrk=;
  b=P7HBq2KMBFmFmYHi0UzTeQW1RIib0WOQOzST4y4ZbpMQ8dv/mEL4T6Nb
   VYUGgUUeTgQAbgZak9yzeOQT4OYUxqzNALr6q63LEU4OdyhnJskgWjyr5
   s61GGdODSFJs9pyCaIgXd+AxdzRNCRnaYdO2NBQs45vWTjXqRiQAFEWsB
   r8ZgoT7N0QDxBhdFCO2A2yB6JlsRRny256HQ3RlwvUuax1aDxVPqJybgn
   JP6dV8TY8uG+6CsINRw3Vso1BHxbpvsGQP4Ropmx00NuX71QdMUwVKzle
   TSQ6tbE0zOB1KCXoCEYa+Qbr88ttp0OT6JUD1uFlaTXQMtminZ93pPaqP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1311101"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="1311101"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 09:04:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="838189000"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="838189000"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 08 Dec 2023 09:04:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A4707DE; Fri,  8 Dec 2023 19:04:37 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/2] spi: pxa2xx: Use inclusive language
Date:   Fri,  8 Dec 2023 19:02:54 +0200
Message-ID: <20231208170436.3309648-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231208170436.3309648-1-andriy.shevchenko@linux.intel.com>
References: <20231208170436.3309648-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 04f2a3856c40..143f1df83f79 100644
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
+Typically, for a legacy platform, an SPI host controller is defined in the
+arch/.../mach-*/board-*.c as a "platform device". The host controller configuration
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
+  static struct pxa2xx_spi_controller pxa_nssp_controller_info = {
 	.num_chipselect = 1, /* Matches the number of chips attached to NSSP */
 	.enable_dma = 1, /* Enables NSSP DMA */
   };
@@ -68,7 +68,7 @@ Below is a sample configuration using the PXA255 NSSP for a legacy platform::
 	.resource = pxa_spi_nssp_resources,
 	.num_resources = ARRAY_SIZE(pxa_spi_nssp_resources),
 	.dev = {
-		.platform_data = &pxa_nssp_master_info, /* Passed to driver */
+		.platform_data = &pxa_nssp_controller_info, /* Passed to driver */
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
+Each peripheral device (chip) attached to the PXA2xx must provide specific chip configuration
 information via the structure "pxa2xx_spi_chip" found in
-"include/linux/spi/pxa2xx_spi.h".  The pxa2xx_spi master controller driver
-will uses the configuration whenever the driver communicates with the slave
+"include/linux/spi/pxa2xx_spi.h". The PXA2xx host controller driver will use
+the configuration whenever the driver communicates with the peripheral
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

