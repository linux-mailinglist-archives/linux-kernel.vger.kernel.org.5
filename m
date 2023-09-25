Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0888C7AD822
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjIYMgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjIYMgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:36:04 -0400
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA5EFFB;
        Mon, 25 Sep 2023 05:35:52 -0700 (PDT)
Received: from localhost.localdomain (host-178-72-203-85.ip.nej.cz [178.72.203.85])
        by mx.gpxsee.org (Postfix) with ESMTPSA id 712ED1A46;
        Mon, 25 Sep 2023 14:35:49 +0200 (CEST)
From:   tumic@gpxsee.org
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH v11 1/2] Added Digiteq Automotive MGB4 driver
Date:   Mon, 25 Sep 2023 16:36:04 +0200
Message-Id: <20230925143605.4686-2-tumic@gpxsee.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925143605.4686-1-tumic@gpxsee.org>
References: <20230925143605.4686-1-tumic@gpxsee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Tůma <martin.tuma@digiteqautomotive.com>

Digiteq Automotive MGB4 is a modular frame grabber PCIe card for automotive
video interfaces. As for now, two modules - FPD-Link and GMSL - are
available and supported by the driver. The card has two inputs and two
outputs (FPD-Link only).

In addition to the video interfaces it also provides a trigger signal
interface and a MTD interface for FPGA firmware upload.

Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
---
 MAINTAINERS                             |   7 +
 drivers/media/pci/Kconfig               |   1 +
 drivers/media/pci/Makefile              |   1 +
 drivers/media/pci/mgb4/Kconfig          |  17 +
 drivers/media/pci/mgb4/Makefile         |   6 +
 drivers/media/pci/mgb4/mgb4_cmt.c       | 244 ++++++
 drivers/media/pci/mgb4/mgb4_cmt.h       |  17 +
 drivers/media/pci/mgb4/mgb4_core.c      | 686 +++++++++++++++++
 drivers/media/pci/mgb4/mgb4_core.h      |  74 ++
 drivers/media/pci/mgb4/mgb4_dma.c       | 123 ++++
 drivers/media/pci/mgb4/mgb4_dma.h       |  18 +
 drivers/media/pci/mgb4/mgb4_i2c.c       | 140 ++++
 drivers/media/pci/mgb4/mgb4_i2c.h       |  35 +
 drivers/media/pci/mgb4/mgb4_io.h        |  33 +
 drivers/media/pci/mgb4/mgb4_regs.c      |  30 +
 drivers/media/pci/mgb4/mgb4_regs.h      |  35 +
 drivers/media/pci/mgb4/mgb4_sysfs.h     |  18 +
 drivers/media/pci/mgb4/mgb4_sysfs_in.c  | 772 +++++++++++++++++++
 drivers/media/pci/mgb4/mgb4_sysfs_out.c | 737 +++++++++++++++++++
 drivers/media/pci/mgb4/mgb4_sysfs_pci.c |  71 ++
 drivers/media/pci/mgb4/mgb4_trigger.c   | 208 ++++++
 drivers/media/pci/mgb4/mgb4_trigger.h   |   8 +
 drivers/media/pci/mgb4/mgb4_vin.c       | 939 ++++++++++++++++++++++++
 drivers/media/pci/mgb4/mgb4_vin.h       |  69 ++
 drivers/media/pci/mgb4/mgb4_vout.c      | 602 +++++++++++++++
 drivers/media/pci/mgb4/mgb4_vout.h      |  65 ++
 26 files changed, 4956 insertions(+)
 create mode 100644 drivers/media/pci/mgb4/Kconfig
 create mode 100644 drivers/media/pci/mgb4/Makefile
 create mode 100644 drivers/media/pci/mgb4/mgb4_cmt.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_cmt.h
 create mode 100644 drivers/media/pci/mgb4/mgb4_core.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_core.h
 create mode 100644 drivers/media/pci/mgb4/mgb4_dma.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_dma.h
 create mode 100644 drivers/media/pci/mgb4/mgb4_i2c.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_i2c.h
 create mode 100644 drivers/media/pci/mgb4/mgb4_io.h
 create mode 100644 drivers/media/pci/mgb4/mgb4_regs.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_regs.h
 create mode 100644 drivers/media/pci/mgb4/mgb4_sysfs.h
 create mode 100644 drivers/media/pci/mgb4/mgb4_sysfs_in.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_sysfs_out.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_sysfs_pci.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_trigger.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_trigger.h
 create mode 100644 drivers/media/pci/mgb4/mgb4_vin.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_vin.h
 create mode 100644 drivers/media/pci/mgb4/mgb4_vout.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_vout.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c155eb535906..4b3837d92d68 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6075,6 +6075,13 @@ L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-gpio-mm.c
 
+DIGITEQ AUTOMOTIVE MGB4 V4L2 DRIVER
+M:	Martin Tuma <martin.tuma@digiteqautomotive.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	Documentation/admin-guide/media/mgb4.rst
+F:	drivers/media/pci/mgb4/
+
 DIOLAN U2C-12 I2C DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-i2c@vger.kernel.org
diff --git a/drivers/media/pci/Kconfig b/drivers/media/pci/Kconfig
index ee095bde0b68..7f65aa609388 100644
--- a/drivers/media/pci/Kconfig
+++ b/drivers/media/pci/Kconfig
@@ -13,6 +13,7 @@ if MEDIA_PCI_SUPPORT
 if MEDIA_CAMERA_SUPPORT
 	comment "Media capture support"
 
+source "drivers/media/pci/mgb4/Kconfig"
 source "drivers/media/pci/solo6x10/Kconfig"
 source "drivers/media/pci/sta2x11/Kconfig"
 source "drivers/media/pci/tw5864/Kconfig"
diff --git a/drivers/media/pci/Makefile b/drivers/media/pci/Makefile
index 8bed619b7130..f18c7e15abe3 100644
--- a/drivers/media/pci/Makefile
+++ b/drivers/media/pci/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_VIDEO_CX25821) += cx25821/
 obj-$(CONFIG_VIDEO_CX88) += cx88/
 obj-$(CONFIG_VIDEO_DT3155) += dt3155/
 obj-$(CONFIG_VIDEO_IVTV) += ivtv/
+obj-$(CONFIG_VIDEO_MGB4) += mgb4/
 obj-$(CONFIG_VIDEO_SAA7134) += saa7134/
 obj-$(CONFIG_VIDEO_SAA7164) += saa7164/
 obj-$(CONFIG_VIDEO_SOLO6X10) += solo6x10/
diff --git a/drivers/media/pci/mgb4/Kconfig b/drivers/media/pci/mgb4/Kconfig
new file mode 100644
index 000000000000..13fad15a434c
--- /dev/null
+++ b/drivers/media/pci/mgb4/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_MGB4
+	tristate "Digiteq Automotive MGB4 support"
+	depends on VIDEO_DEV && PCI && I2C && DMADEVICES && SPI && MTD && IIO
+	select VIDEOBUF2_DMA_SG
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select I2C_XILINX
+	select SPI_XILINX
+	select MTD_SPI_NOR
+	select XILINX_XDMA
+	help
+	  This is a video4linux driver for Digiteq Automotive MGB4 grabber
+	  cards.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mgb4.
diff --git a/drivers/media/pci/mgb4/Makefile b/drivers/media/pci/mgb4/Makefile
new file mode 100644
index 000000000000..e92ead18bed0
--- /dev/null
+++ b/drivers/media/pci/mgb4/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+mgb4-objs	:= mgb4_regs.o mgb4_core.o mgb4_vin.o mgb4_vout.o \
+               mgb4_sysfs_pci.o mgb4_sysfs_in.o mgb4_sysfs_out.o \
+               mgb4_i2c.o mgb4_cmt.o mgb4_trigger.o mgb4_dma.o
+
+obj-$(CONFIG_VIDEO_MGB4) += mgb4.o
diff --git a/drivers/media/pci/mgb4/mgb4_cmt.c b/drivers/media/pci/mgb4/mgb4_cmt.c
new file mode 100644
index 000000000000..70dc78ef193c
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_cmt.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021-2023 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ *
+ * The CMT module configures the FPGA Clock Management Tile (CMT) registers. For
+ * different video signal frequencies (FPGA input signal frequencies), the FPGA
+ * CMT registers need to be adjusted for the FPGA to work properly. The values
+ * are precomputed based on formulas given by Xilinx in their FPGA documentation
+ * (which are in turn full of some magic values/tables...).
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include "mgb4_core.h"
+#include "mgb4_cmt.h"
+
+static const u16 cmt_vals_out[][15] = {
+	{0x1208, 0x0000, 0x171C, 0x0000, 0x1E38, 0x0000, 0x11C7, 0x0000, 0x1041, 0x01BC, 0x7C01, 0x7DE9, 0xFFFF, 0x9900, 0x8100, },
+	{0x11C7, 0x0000, 0x1619, 0x0080, 0x1C71, 0x0000, 0x130D, 0x0080, 0x0041, 0x0090, 0x7C01, 0x7DE9, 0xFFFF, 0x1100, 0x9000, },
+	{0x11C7, 0x0000, 0x1619, 0x0080, 0x1C71, 0x0000, 0x165A, 0x0080, 0x0082, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1000, 0x9000, },
+	{0x11C7, 0x0000, 0x1619, 0x0080, 0x1C71, 0x0000, 0x1187, 0x0080, 0x1041, 0x01EE, 0x7C01, 0x7DE9, 0xFFFF, 0x9900, 0x8100, },
+	{0x1186, 0x0000, 0x1555, 0x0000, 0x1AAA, 0x0000, 0x1451, 0x0000, 0x0042, 0x0013, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x11C7, 0x0000, 0x1619, 0x0080, 0x1C71, 0x0000, 0x134E, 0x0080, 0x0041, 0x005E, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x1145, 0x0000, 0x1452, 0x0080, 0x18E3, 0x0000, 0x1619, 0x0080, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1000, 0x9000, },
+	{0x1145, 0x0000, 0x1452, 0x0080, 0x18E3, 0x0000, 0x179E, 0x0000, 0x00C3, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x1000, },
+	{0x1145, 0x0000, 0x1452, 0x0080, 0x18E3, 0x0000, 0x179F, 0x0080, 0x00C3, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x1000, },
+	{0x1145, 0x0000, 0x1452, 0x0080, 0x18E3, 0x0000, 0x17DF, 0x0000, 0x00C3, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1000, 0x8800, },
+	{0x1145, 0x0000, 0x1452, 0x0080, 0x18E3, 0x0000, 0x128B, 0x0080, 0x0041, 0x00DB, 0x7C01, 0x7DE9, 0xFFFF, 0x9000, 0x0100, },
+	{0x1186, 0x0000, 0x1555, 0x0000, 0x1AAA, 0x0000, 0x1820, 0x0000, 0x0083, 0x00FA, 0x7DE9, 0x7DE8, 0xFFFF, 0x0900, 0x9000, },
+	{0x1186, 0x0000, 0x1555, 0x0000, 0x1AAA, 0x0000, 0x1187, 0x0080, 0x1041, 0x01EE, 0x7C01, 0x7DE9, 0xFFFF, 0x9900, 0x8100, },
+	{0x1104, 0x0000, 0x138E, 0x0000, 0x171C, 0x0000, 0x169B, 0x0080, 0x00C3, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1800, 0x0100, },
+	{0x1145, 0x0000, 0x1452, 0x0080, 0x18E3, 0x0000, 0x171C, 0x0000, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1100, 0x1800, },
+	{0x1186, 0x0000, 0x1555, 0x0000, 0x1AAA, 0x0000, 0x1515, 0x0080, 0x0042, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x1104, 0x0000, 0x138E, 0x0000, 0x171C, 0x0000, 0x1493, 0x0080, 0x0082, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x1145, 0x0000, 0x1452, 0x0080, 0x18E3, 0x0000, 0x15D8, 0x0080, 0x0082, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1900, 0x0100, },
+	{0x1104, 0x0000, 0x138E, 0x0000, 0x171C, 0x0000, 0x124A, 0x0080, 0x0041, 0x010D, 0x7C01, 0x7DE9, 0xFFFF, 0x9000, 0x0100, },
+	{0x1104, 0x0000, 0x138E, 0x0000, 0x171C, 0x0000, 0x175D, 0x0000, 0x00C3, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x1000, },
+	{0x1145, 0x0000, 0x1452, 0x0080, 0x18E3, 0x0000, 0x1619, 0x0080, 0x0082, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1000, 0x9000, },
+	{0x1145, 0x0000, 0x1452, 0x0080, 0x18E3, 0x0000, 0x17DF, 0x0000, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1000, 0x8800, },
+	{0x1145, 0x0000, 0x1452, 0x0080, 0x18E3, 0x0000, 0x17E0, 0x0080, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x9000, },
+	{0x1145, 0x0000, 0x1452, 0x0080, 0x18E3, 0x0000, 0x1820, 0x0000, 0x0083, 0x00FA, 0x7DE9, 0x7DE8, 0xFFFF, 0x0900, 0x9000, },
+	{0x1104, 0x0000, 0x138E, 0x0000, 0x171C, 0x0000, 0x13D0, 0x0080, 0x0042, 0x002C, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x1104, 0x0000, 0x138E, 0x0000, 0x171C, 0x0000, 0x128B, 0x0080, 0x0041, 0x00DB, 0x7C01, 0x7DE9, 0xFFFF, 0x9000, 0x0100, },
+	{0x1104, 0x0000, 0x138E, 0x0000, 0x171C, 0x0000, 0x1820, 0x0000, 0x00C3, 0x00FA, 0x7DE9, 0x7DE8, 0xFFFF, 0x0900, 0x9000, },
+	{0x1145, 0x0000, 0x1452, 0x0080, 0x18E3, 0x0000, 0x134E, 0x0080, 0x0041, 0x005E, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x1145, 0x0000, 0x1452, 0x0080, 0x18E3, 0x0000, 0x1515, 0x0080, 0x0042, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x175D, 0x0000, 0x00C4, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x1000, },
+	{0x1145, 0x0000, 0x1452, 0x0080, 0x18E3, 0x0000, 0x11C7, 0x0000, 0x1041, 0x01BC, 0x7C01, 0x7DE9, 0xFFFF, 0x9900, 0x8100, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x1209, 0x0080, 0x0041, 0x013F, 0x7C01, 0x7DE9, 0xFFFF, 0x9900, 0x1100, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x1556, 0x0080, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x8000, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x179F, 0x0080, 0x00C4, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x1000, },
+	{0x1104, 0x0000, 0x138E, 0x0000, 0x171C, 0x0000, 0x15D8, 0x0080, 0x0082, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1900, 0x0100, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x1105, 0x0080, 0x1041, 0x01E8, 0x6401, 0x65E9, 0xFFFF, 0x9800, 0x1100, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x1820, 0x0000, 0x00C4, 0x00FA, 0x7DE9, 0x7DE8, 0xFFFF, 0x0900, 0x9000, },
+	{0x1104, 0x0000, 0x138E, 0x0000, 0x171C, 0x0000, 0x1493, 0x0080, 0x0042, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x138E, 0x0000, 0x0042, 0x005E, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x1104, 0x0000, 0x138E, 0x0000, 0x171C, 0x0000, 0x17E0, 0x0080, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x9000, },
+	{0x1104, 0x0000, 0x138E, 0x0000, 0x171C, 0x0000, 0x165A, 0x0080, 0x0082, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1000, 0x9000, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x175D, 0x0000, 0x00C3, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x1000, },
+	{0x1104, 0x0000, 0x138E, 0x0000, 0x171C, 0x0000, 0x1187, 0x0080, 0x1041, 0x01EE, 0x7C01, 0x7DE9, 0xFFFF, 0x9900, 0x8100, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x175E, 0x0080, 0x00C3, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x1000, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x179E, 0x0000, 0x00C3, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x1000, },
+	{0x1104, 0x0000, 0x138E, 0x0000, 0x171C, 0x0000, 0x134E, 0x0080, 0x0041, 0x005E, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x165A, 0x0080, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1000, 0x9000, },
+	{0x1104, 0x0000, 0x138E, 0x0000, 0x171C, 0x0000, 0x16DC, 0x0080, 0x0082, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1100, 0x1800, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x169A, 0x0000, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1000, 0x9000, },
+	{0x1104, 0x0000, 0x138E, 0x0000, 0x171C, 0x0000, 0x11C7, 0x0000, 0x1041, 0x01BC, 0x7C01, 0x7DE9, 0xFFFF, 0x9900, 0x8100, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x169B, 0x0080, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1800, 0x0100, },
+	{0x1104, 0x0000, 0x138E, 0x0000, 0x171C, 0x0000, 0x171D, 0x0080, 0x0082, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1100, 0x1800, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x16DB, 0x0000, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1800, 0x0100, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x1146, 0x0080, 0x1041, 0x0184, 0x7C01, 0x7DE9, 0xFFFF, 0x9900, 0x8100, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x171C, 0x0000, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1100, 0x1800, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x1451, 0x0000, 0x0042, 0x0013, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x171D, 0x0080, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1100, 0x1800, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x175D, 0x0000, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x1000, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x1452, 0x0080, 0x0042, 0x0013, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x15D8, 0x0080, 0x0082, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1900, 0x0100, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x1104, 0x0000, 0x1041, 0x01E8, 0x5801, 0x59E9, 0xFFFF, 0x9900, 0x0900, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x179F, 0x0080, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x1000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x1515, 0x0080, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x17DF, 0x0000, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1000, 0x8800, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x1659, 0x0000, 0x00C3, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1000, 0x9000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x1555, 0x0000, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x8000, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x14D3, 0x0000, 0x0042, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x1820, 0x0000, 0x0083, 0x00FA, 0x7DE9, 0x7DE8, 0xFFFF, 0x0900, 0x9000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x1556, 0x0080, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x8000, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x1187, 0x0080, 0x1041, 0x01EE, 0x7C01, 0x7DE9, 0xFFFF, 0x9900, 0x8100, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x1452, 0x0080, 0x0082, 0x0013, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x169B, 0x0080, 0x00C3, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1800, 0x0100, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x1514, 0x0000, 0x0042, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x17E0, 0x0080, 0x00C4, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x9000, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x1515, 0x0080, 0x0042, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x10C3, 0x0000, 0x128B, 0x0080, 0x1555, 0x0000, 0x16DC, 0x0080, 0x0082, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1100, 0x1800, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x1493, 0x0080, 0x0082, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x171C, 0x0000, 0x00C3, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1100, 0x1800, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x15D8, 0x0080, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1900, 0x0100, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x171D, 0x0080, 0x00C3, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1100, 0x1800, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x1618, 0x0000, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1900, 0x0100, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x175D, 0x0000, 0x00C3, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x1000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x14D4, 0x0080, 0x0082, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x1619, 0x0080, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1000, 0x9000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x179E, 0x0000, 0x00C3, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x1000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x179F, 0x0080, 0x00C3, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x1000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x1515, 0x0080, 0x0082, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x13D0, 0x0080, 0x0042, 0x002C, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x169A, 0x0000, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1000, 0x9000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x128B, 0x0080, 0x0041, 0x00DB, 0x7C01, 0x7DE9, 0xFFFF, 0x9000, 0x0100, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x169B, 0x0080, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1800, 0x0100, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x1820, 0x0000, 0x00C3, 0x00FA, 0x7DE9, 0x7DE8, 0xFFFF, 0x0900, 0x9000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x1556, 0x0080, 0x0082, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x8000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x16DB, 0x0000, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1800, 0x0100, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x1411, 0x0080, 0x0042, 0x002C, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x171C, 0x0000, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1100, 0x1800, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x1597, 0x0080, 0x0082, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x8000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x1451, 0x0000, 0x0042, 0x0013, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x171D, 0x0080, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1100, 0x1800, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x12CC, 0x0080, 0x0041, 0x00A9, 0x7C01, 0x7DE9, 0xFFFF, 0x1100, 0x9000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x175D, 0x0000, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x1000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x1452, 0x0080, 0x0042, 0x0013, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x15D8, 0x0080, 0x0082, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1900, 0x0100, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x175E, 0x0080, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x1000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x1492, 0x0000, 0x0042, 0x0013, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x179F, 0x0080, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0800, 0x1000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x1619, 0x0080, 0x0082, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1000, 0x9000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x1493, 0x0080, 0x0042, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x17DF, 0x0000, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1000, 0x8800, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x130D, 0x0080, 0x0041, 0x0090, 0x7C01, 0x7DE9, 0xFFFF, 0x1100, 0x9000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x17E0, 0x0080, 0x0083, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x9000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x14D3, 0x0000, 0x0042, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x165A, 0x0080, 0x0082, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1000, 0x9000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x1820, 0x0000, 0x0083, 0x00FA, 0x7DE9, 0x7DE8, 0xFFFF, 0x0900, 0x9000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x14D4, 0x0080, 0x0042, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x0900, 0x1000, },
+	{0x1082, 0x0000, 0x11C7, 0x0000, 0x138E, 0x0000, 0x169B, 0x0080, 0x0082, 0x00FA, 0x7C01, 0x7DE9, 0xFFFF, 0x1800, 0x0100, },
+};
+
+static const u16 cmt_vals_in[][13] = {
+	{0x1082, 0x0000, 0x5104, 0x0000, 0x11C7, 0x0000, 0x1041, 0x02BC, 0x7C01, 0xFFE9, 0x9900, 0x9908, 0x8100},
+	{0x1104, 0x0000, 0x9208, 0x0000, 0x138E, 0x0000, 0x1041, 0x015E, 0x7C01, 0xFFE9, 0x0100, 0x0908, 0x1000},
+};
+
+static const u32 cmt_addrs_out[][15] = {
+	{0x420, 0x424, 0x428, 0x42C, 0x430, 0x434, 0x450, 0x454, 0x458, 0x460, 0x464, 0x468, 0x4A0, 0x538, 0x53C},
+	{0x620, 0x624, 0x628, 0x62C, 0x630, 0x634, 0x650, 0x654, 0x658, 0x660, 0x664, 0x668, 0x6A0, 0x738, 0x73C},
+};
+
+static const u32 cmt_addrs_in[][13] = {
+	{0x020, 0x024, 0x028, 0x02C, 0x050, 0x054, 0x058, 0x060, 0x064, 0x068, 0x0A0, 0x138, 0x13C},
+	{0x220, 0x224, 0x228, 0x22C, 0x250, 0x254, 0x258, 0x260, 0x264, 0x268, 0x2A0, 0x338, 0x33C},
+};
+
+static const u32 cmt_freq[] = {
+	25000, 25510, 26020, 26530, 26983, 27551, 28000, 28570,
+	29046, 29522, 30000, 30476, 30952, 31546, 32000, 32539,
+	33035, 33571, 33928, 34522, 35000, 35428, 36000, 36571,
+	36904, 37500, 38093, 38571, 39047, 39453, 40000, 40476,
+	40952, 41494, 41964, 42857, 43535, 44047, 44444, 45000,
+	45535, 46029, 46428, 46823, 47617, 48214, 48571, 49107,
+	49523, 50000, 50476, 50892, 51428, 52380, 53333, 53967,
+	54285, 55238, 55555, 55952, 57142, 58095, 58571, 59047,
+	59521, 60000, 60316, 60952, 61428, 61904, 62500, 63092,
+	63491, 64282, 65078, 65476, 66071, 66664, 67142, 67854,
+	68571, 69044, 69642, 70000, 71425, 72616, 73214, 73808,
+	74285, 75000, 75714, 76187, 76785, 77142, 78570, 80000,
+	80357, 80951, 81428, 82142, 82857, 83332, 83928, 84285,
+	85713, 87142, 87500, 88094, 88571, 89285, 90000, 90475,
+	91071, 91428, 92856, 94642,
+};
+
+static size_t freq_srch(u32 key, const u32 *array, size_t size)
+{
+	int l = 0;
+	int r = size - 1;
+	int m = 0;
+
+	while (l <= r) {
+		m = (l + r) / 2;
+		if (array[m] < key)
+			l = m + 1;
+		else if (array[m] > key)
+			r = m - 1;
+		else
+			return m;
+	}
+
+	if (r < 0 || l > size - 1)
+		return m;
+	else
+		return (abs(key - array[l]) < abs(key - array[r])) ? l : r;
+}
+
+u32 mgb4_cmt_set_vout_freq(struct mgb4_vout_dev *voutdev, unsigned int freq)
+{
+	struct mgb4_regs *video = &voutdev->mgbdev->video;
+	const struct mgb4_vout_regs *regs = &voutdev->config->regs;
+	const u16 *reg_set;
+	const u32 *addr;
+	u32 config;
+	size_t i, index;
+
+	index = freq_srch(freq, cmt_freq, ARRAY_SIZE(cmt_freq));
+	addr = cmt_addrs_out[voutdev->config->id];
+	reg_set = cmt_vals_out[index];
+
+	config = mgb4_read_reg(video, regs->config);
+
+	mgb4_write_reg(video, regs->config, 0x1 | (config & ~0x3));
+
+	for (i = 0; i < ARRAY_SIZE(cmt_addrs_out[0]); i++)
+		mgb4_write_reg(&voutdev->mgbdev->cmt, addr[i], reg_set[i]);
+
+	mgb4_mask_reg(video, regs->config, 0x100, 0x100);
+	mgb4_mask_reg(video, regs->config, 0x100, 0x0);
+
+	mgb4_write_reg(video, regs->config, config & ~0x1);
+
+	return cmt_freq[index];
+}
+
+void mgb4_cmt_set_vin_freq_range(struct mgb4_vin_dev *vindev,
+				 unsigned int freq_range)
+{
+	struct mgb4_regs *video = &vindev->mgbdev->video;
+	const struct mgb4_vin_regs *regs = &vindev->config->regs;
+	const u16 *reg_set;
+	const u32 *addr;
+	u32 config;
+	size_t i;
+
+	addr = cmt_addrs_in[vindev->config->id];
+	reg_set = cmt_vals_in[freq_range];
+
+	config = mgb4_read_reg(video, regs->config);
+
+	mgb4_write_reg(video, regs->config, 0x1 | (config & ~0x3));
+
+	for (i = 0; i < ARRAY_SIZE(cmt_addrs_in[0]); i++)
+		mgb4_write_reg(&vindev->mgbdev->cmt, addr[i], reg_set[i]);
+
+	mgb4_mask_reg(video, regs->config, 0x1000, 0x1000);
+	mgb4_mask_reg(video, regs->config, 0x1000, 0x0);
+
+	mgb4_write_reg(video, regs->config, config & ~0x1);
+}
diff --git a/drivers/media/pci/mgb4/mgb4_cmt.h b/drivers/media/pci/mgb4/mgb4_cmt.h
new file mode 100644
index 000000000000..b15df56ca059
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_cmt.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021-2023 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ */
+
+#ifndef __MGB4_CMT_H__
+#define __MGB4_CMT_H__
+
+#include "mgb4_vout.h"
+#include "mgb4_vin.h"
+
+u32 mgb4_cmt_set_vout_freq(struct mgb4_vout_dev *voutdev, unsigned int freq);
+void mgb4_cmt_set_vin_freq_range(struct mgb4_vin_dev *vindev,
+				 unsigned int freq_range);
+
+#endif
diff --git a/drivers/media/pci/mgb4/mgb4_core.c b/drivers/media/pci/mgb4/mgb4_core.c
new file mode 100644
index 000000000000..3efb33fbf40c
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_core.c
@@ -0,0 +1,686 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This is the driver for the MGB4 video grabber card by Digiteq Automotive.
+ *
+ * Copyright (C) 2021-2023 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ *
+ * This is the main driver module. The DMA, I2C and SPI sub-drivers are
+ * initialized here and the input/output v4l2 devices are created.
+ *
+ * The mgb4 card uses different expansion modules for different video sources
+ * (GMSL and FPDL3 for now) so in probe() we detect the module type based on
+ * what we see on the I2C bus and check if it matches the FPGA bitstream (there
+ * are different bitstreams for different expansion modules). When no expansion
+ * module is present, we still let the driver initialize to allow flashing of
+ * the FPGA firmware using the SPI FLASH device. No v4l2 video devices are
+ * created in this case.
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/dma/amd_xdma.h>
+#include <linux/platform_data/amd_xdma.h>
+#include <linux/spi/xilinx_spi.h>
+#include <linux/mtd/mtd.h>
+#include <linux/hwmon.h>
+#include <linux/debugfs.h>
+#include "mgb4_dma.h"
+#include "mgb4_i2c.h"
+#include "mgb4_sysfs.h"
+#include "mgb4_vout.h"
+#include "mgb4_vin.h"
+#include "mgb4_trigger.h"
+#include "mgb4_core.h"
+
+#define MGB4_USER_IRQS 16
+
+ATTRIBUTE_GROUPS(mgb4_pci);
+
+static int flashid;
+
+static struct xdma_chan_info h2c_chan_info = {
+	.dir = DMA_MEM_TO_DEV,
+};
+
+static struct xdma_chan_info c2h_chan_info = {
+	.dir = DMA_DEV_TO_MEM,
+};
+
+static struct xspi_platform_data spi_platform_data = {
+	.num_chipselect = 1,
+	.bits_per_word = 8
+};
+
+static const struct i2c_board_info extender_info = {
+	I2C_BOARD_INFO("extender", 0x21)
+};
+
+#if IS_REACHABLE(CONFIG_HWMON)
+static umode_t temp_is_visible(const void *data, enum hwmon_sensor_types type,
+			       u32 attr, int channel)
+{
+	if (type == hwmon_temp &&
+	    (attr == hwmon_temp_input || attr == hwmon_temp_label))
+		return 0444;
+	else
+		return 0;
+}
+
+static int temp_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
+		     int channel, long *val)
+{
+	struct mgb4_dev *mgbdev = dev_get_drvdata(dev);
+	u32 val10, raw;
+
+	if (type != hwmon_temp || attr != hwmon_temp_input)
+		return -EOPNOTSUPP;
+
+	raw = mgb4_read_reg(&mgbdev->video, 0xD0);
+	/* register value -> Celsius degrees formula given by Xilinx */
+	val10 = ((((raw >> 20) & 0xFFF) * 503975) - 1118822400) / 409600;
+	*val = val10 * 100;
+
+	return 0;
+}
+
+static int temp_read_string(struct device *dev, enum hwmon_sensor_types type,
+			    u32 attr, int channel, const char **str)
+{
+	if (type != hwmon_temp || attr != hwmon_temp_label)
+		return -EOPNOTSUPP;
+
+	*str = "FPGA Temperature";
+
+	return 0;
+}
+
+static const struct hwmon_ops temp_ops = {
+	.is_visible = temp_is_visible,
+	.read = temp_read,
+	.read_string = temp_read_string
+};
+
+static const struct hwmon_channel_info *temp_channel_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL),
+	NULL
+};
+
+static const struct hwmon_chip_info temp_chip_info = {
+	.ops = &temp_ops,
+	.info = temp_channel_info,
+};
+#endif
+
+static int match_i2c_adap(struct device *dev, void *data)
+{
+	return i2c_verify_adapter(dev) ? 1 : 0;
+}
+
+static struct i2c_adapter *get_i2c_adap(struct platform_device *pdev)
+{
+	struct device *dev;
+
+	mutex_lock(&pdev->dev.mutex);
+	dev = device_find_child(&pdev->dev, NULL, match_i2c_adap);
+	mutex_unlock(&pdev->dev.mutex);
+
+	return dev ? to_i2c_adapter(dev) : NULL;
+}
+
+static int match_spi_adap(struct device *dev, void *data)
+{
+	return to_spi_device(dev) ? 1 : 0;
+}
+
+static struct spi_master *get_spi_adap(struct platform_device *pdev)
+{
+	struct device *dev;
+
+	mutex_lock(&pdev->dev.mutex);
+	dev = device_find_child(&pdev->dev, NULL, match_spi_adap);
+	mutex_unlock(&pdev->dev.mutex);
+
+	return dev ? container_of(dev, struct spi_master, dev) : NULL;
+}
+
+static int init_spi(struct mgb4_dev *mgbdev)
+{
+	struct resource spi_resources[] = {
+		{
+			.start	= 0x400,
+			.end	= 0x47f,
+			.flags	= IORESOURCE_MEM,
+			.name	= "io-memory",
+		},
+		{
+			.start	= 14,
+			.end	= 14,
+			.flags	= IORESOURCE_IRQ,
+			.name	= "irq",
+		},
+	};
+	struct spi_board_info spi_info = {
+		.max_speed_hz = 10000000,
+		.modalias = "m25p80",
+		.chip_select = 0,
+		.mode = SPI_MODE_3,
+	};
+	struct pci_dev *pdev = mgbdev->pdev;
+	struct device *dev = &pdev->dev;
+	struct spi_master *master;
+	struct spi_device *spi_dev;
+	u32 irq;
+	int rv, id;
+	resource_size_t mapbase = pci_resource_start(pdev, MGB4_MGB4_BAR_ID);
+
+	request_module("platform:xilinx_spi");
+
+	irq = xdma_get_user_irq(mgbdev->xdev, 14);
+	xdma_enable_user_irq(mgbdev->xdev, irq);
+
+	spi_resources[0].parent = &pdev->resource[MGB4_MGB4_BAR_ID];
+	spi_resources[0].start += mapbase;
+	spi_resources[0].end += mapbase;
+	spi_resources[1].start = irq;
+	spi_resources[1].end = irq;
+
+	id = pci_dev_id(pdev);
+	mgbdev->spi_pdev = platform_device_register_resndata(dev, "xilinx_spi",
+							     id, spi_resources,
+							     ARRAY_SIZE(spi_resources),
+							     &spi_platform_data,
+							     sizeof(spi_platform_data));
+	if (IS_ERR(mgbdev->spi_pdev)) {
+		dev_err(dev, "failed to register SPI device\n");
+		return PTR_ERR(mgbdev->spi_pdev);
+	}
+
+	master = get_spi_adap(mgbdev->spi_pdev);
+	if (!master) {
+		dev_err(dev, "failed to get SPI adapter\n");
+		rv = -EINVAL;
+		goto err_pdev;
+	}
+
+	snprintf(mgbdev->fw_part_name, sizeof(mgbdev->fw_part_name),
+		 "mgb4-fw.%d", flashid);
+	mgbdev->partitions[0].name = mgbdev->fw_part_name;
+	mgbdev->partitions[0].size = 0x400000;
+	mgbdev->partitions[0].offset = 0x400000;
+	mgbdev->partitions[0].mask_flags = 0;
+
+	snprintf(mgbdev->data_part_name, sizeof(mgbdev->data_part_name),
+		 "mgb4-data.%d", flashid);
+	mgbdev->partitions[1].name = mgbdev->data_part_name;
+	mgbdev->partitions[1].size = 0x10000;
+	mgbdev->partitions[1].offset = 0xFF0000;
+	mgbdev->partitions[1].mask_flags = MTD_CAP_NORFLASH;
+
+	snprintf(mgbdev->flash_name, sizeof(mgbdev->flash_name),
+		 "mgb4-flash.%d", flashid);
+	mgbdev->flash_data.name = mgbdev->flash_name;
+	mgbdev->flash_data.parts = mgbdev->partitions;
+	mgbdev->flash_data.nr_parts = ARRAY_SIZE(mgbdev->partitions);
+	mgbdev->flash_data.type = "spi-nor";
+
+	spi_info.platform_data = &mgbdev->flash_data;
+
+	spi_dev = spi_new_device(master, &spi_info);
+	put_device(&master->dev);
+	if (!spi_dev) {
+		dev_err(dev, "failed to create MTD device\n");
+		rv = -EINVAL;
+		goto err_pdev;
+	}
+
+	return 0;
+
+err_pdev:
+	platform_device_unregister(mgbdev->spi_pdev);
+
+	return rv;
+}
+
+static void free_spi(struct mgb4_dev *mgbdev)
+{
+	platform_device_unregister(mgbdev->spi_pdev);
+}
+
+static int init_i2c(struct mgb4_dev *mgbdev)
+{
+	struct resource i2c_resources[] = {
+		{
+			.start	= 0x200,
+			.end	= 0x3ff,
+			.flags	= IORESOURCE_MEM,
+			.name	= "io-memory",
+		},
+		{
+			.start	= 15,
+			.end	= 15,
+			.flags	= IORESOURCE_IRQ,
+			.name	= "irq",
+		},
+	};
+	struct pci_dev *pdev = mgbdev->pdev;
+	struct device *dev = &pdev->dev;
+	char clk_name[16];
+	u32 irq;
+	int rv, id;
+	resource_size_t mapbase = pci_resource_start(pdev, MGB4_MGB4_BAR_ID);
+
+	request_module("platform:xiic-i2c");
+
+	irq = xdma_get_user_irq(mgbdev->xdev, 15);
+	xdma_enable_user_irq(mgbdev->xdev, irq);
+
+	i2c_resources[0].parent = &pdev->resource[MGB4_MGB4_BAR_ID];
+	i2c_resources[0].start += mapbase;
+	i2c_resources[0].end += mapbase;
+	i2c_resources[1].start = irq;
+	i2c_resources[1].end = irq;
+
+	id = pci_dev_id(pdev);
+
+	/* create dummy clock required by the xiic-i2c adapter */
+	snprintf(clk_name, sizeof(clk_name), "xiic-i2c.%d", id);
+	mgbdev->i2c_clk = clk_hw_register_fixed_rate(NULL, clk_name, NULL,
+						     0, 125000000);
+	if (IS_ERR(mgbdev->i2c_clk)) {
+		dev_err(dev, "failed to register I2C clock\n");
+		return PTR_ERR(mgbdev->i2c_clk);
+	}
+	mgbdev->i2c_cl = clkdev_hw_create(mgbdev->i2c_clk, NULL, "xiic-i2c.%d",
+					  id);
+	if (!mgbdev->i2c_cl) {
+		dev_err(dev, "failed to register I2C clockdev\n");
+		rv = -ENOMEM;
+		goto err_clk;
+	}
+
+	mgbdev->i2c_pdev = platform_device_register_resndata(dev, "xiic-i2c",
+							     id, i2c_resources,
+							     ARRAY_SIZE(i2c_resources),
+							     NULL, 0);
+	if (IS_ERR(mgbdev->i2c_pdev)) {
+		dev_err(dev, "failed to register I2C device\n");
+		rv = PTR_ERR(mgbdev->i2c_pdev);
+		goto err_clkdev;
+	}
+
+	mgbdev->i2c_adap = get_i2c_adap(mgbdev->i2c_pdev);
+	if (!mgbdev->i2c_adap) {
+		dev_err(dev, "failed to get I2C adapter\n");
+		rv = -EINVAL;
+		goto err_pdev;
+	}
+
+	mutex_init(&mgbdev->i2c_lock);
+
+	return 0;
+
+err_pdev:
+	platform_device_unregister(mgbdev->i2c_pdev);
+err_clkdev:
+	clkdev_drop(mgbdev->i2c_cl);
+err_clk:
+	clk_hw_unregister(mgbdev->i2c_clk);
+
+	return rv;
+}
+
+static void free_i2c(struct mgb4_dev *mgbdev)
+{
+	put_device(&mgbdev->i2c_adap->dev);
+	platform_device_unregister(mgbdev->i2c_pdev);
+	clkdev_drop(mgbdev->i2c_cl);
+	clk_hw_unregister(mgbdev->i2c_clk);
+}
+
+static int get_serial_number(struct mgb4_dev *mgbdev)
+{
+	struct device *dev = &mgbdev->pdev->dev;
+	struct mtd_info *mtd;
+	size_t rs;
+	int rv;
+
+	mgbdev->serial_number = 0;
+
+	mtd = get_mtd_device_nm(mgbdev->data_part_name);
+	if (IS_ERR(mtd)) {
+		dev_warn(dev, "failed to get data MTD device\n");
+		return -ENOENT;
+	}
+	rv = mtd_read(mtd, 0, sizeof(mgbdev->serial_number), &rs,
+		      (u_char *)&mgbdev->serial_number);
+	put_mtd_device(mtd);
+	if (rv < 0 || rs != sizeof(mgbdev->serial_number)) {
+		dev_warn(dev, "error reading MTD device\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int get_module_version(struct mgb4_dev *mgbdev)
+{
+	struct device *dev = &mgbdev->pdev->dev;
+	struct mgb4_i2c_client extender;
+	s32 version;
+	u32 fw_version;
+	int rv;
+
+	rv = mgb4_i2c_init(&extender, mgbdev->i2c_adap, &extender_info, 8);
+	if (rv < 0) {
+		dev_err(dev, "failed to create extender I2C device\n");
+		return rv;
+	}
+	version = mgb4_i2c_read_byte(&extender, 0x00);
+	mgb4_i2c_free(&extender);
+	if (version < 0) {
+		dev_err(dev, "error reading module version\n");
+		return -EIO;
+	}
+
+	mgbdev->module_version = ~((u32)version) & 0xff;
+	if (!(MGB4_IS_FPDL3(mgbdev) || MGB4_IS_GMSL(mgbdev))) {
+		dev_err(dev, "unknown module type\n");
+		return -EINVAL;
+	}
+	fw_version = mgb4_read_reg(&mgbdev->video, 0xC4);
+	if (fw_version >> 24 != mgbdev->module_version >> 4) {
+		dev_err(dev, "module/firmware type mismatch\n");
+		return -EINVAL;
+	}
+
+	dev_info(dev, "%s module detected\n",
+		 MGB4_IS_FPDL3(mgbdev) ? "FPDL3" : "GMSL");
+
+	return 0;
+}
+
+static int map_regs(struct pci_dev *pdev, struct resource *res,
+		    struct mgb4_regs *regs)
+{
+	int rv;
+	resource_size_t mapbase = pci_resource_start(pdev, MGB4_MGB4_BAR_ID);
+
+	res->start += mapbase;
+	res->end += mapbase;
+
+	rv = mgb4_regs_map(res, regs);
+	if (rv < 0) {
+		dev_err(&pdev->dev, "failed to map %s registers\n", res->name);
+		return rv;
+	}
+
+	return 0;
+}
+
+static int init_xdma(struct mgb4_dev *mgbdev)
+{
+	struct xdma_platdata data;
+	struct resource res[2] = { 0 };
+	struct dma_slave_map *map;
+	struct pci_dev *pdev = mgbdev->pdev;
+	struct device *dev = &pdev->dev;
+	int i;
+
+	res[0].start = pci_resource_start(pdev, MGB4_XDMA_BAR_ID);
+	res[0].end = pci_resource_end(pdev, MGB4_XDMA_BAR_ID);
+	res[0].flags = IORESOURCE_MEM;
+	res[0].parent = &pdev->resource[MGB4_XDMA_BAR_ID];
+	res[1].start = pci_irq_vector(pdev, 0);
+	res[1].end = res[1].start + MGB4_VIN_DEVICES + MGB4_VOUT_DEVICES
+		     + MGB4_USER_IRQS - 1;
+	res[1].flags = IORESOURCE_IRQ;
+
+	data.max_dma_channels = MGB4_VIN_DEVICES + MGB4_VOUT_DEVICES;
+	data.device_map = mgbdev->slave_map;
+	data.device_map_cnt = MGB4_VIN_DEVICES + MGB4_VOUT_DEVICES;
+
+	for (i = 0; i < MGB4_VIN_DEVICES; i++) {
+		sprintf(mgbdev->channel_names[i], "c2h%d", i);
+		map = &data.device_map[i];
+		map->slave = mgbdev->channel_names[i];
+		map->devname = dev_name(dev);
+		map->param = XDMA_FILTER_PARAM(&c2h_chan_info);
+	}
+	for (i = 0; i < MGB4_VOUT_DEVICES; i++) {
+		sprintf(mgbdev->channel_names[i + MGB4_VIN_DEVICES], "h2c%d", i);
+		map = &data.device_map[i + MGB4_VIN_DEVICES];
+		map->slave = mgbdev->channel_names[i + MGB4_VIN_DEVICES];
+		map->devname = dev_name(dev);
+		map->param = XDMA_FILTER_PARAM(&h2c_chan_info);
+	}
+
+	mgbdev->xdev = platform_device_register_resndata(dev, "xdma",
+							 PLATFORM_DEVID_AUTO, res,
+							 2, &data, sizeof(data));
+	if (IS_ERR(mgbdev->xdev)) {
+		dev_err(dev, "failed to register XDMA device\n");
+		return PTR_ERR(mgbdev->xdev);
+	}
+
+	return 0;
+}
+
+static void free_xdma(struct mgb4_dev *mgbdev)
+{
+	platform_device_unregister(mgbdev->xdev);
+}
+
+static int mgb4_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	int i, rv;
+	struct mgb4_dev *mgbdev;
+	struct resource video = {
+		.start	= 0x0,
+		.end	= 0x100,
+		.flags	= IORESOURCE_MEM,
+		.name	= "mgb4-video",
+	};
+	struct resource cmt = {
+		.start	= 0x1000,
+		.end	= 0x1800,
+		.flags	= IORESOURCE_MEM,
+		.name	= "mgb4-cmt",
+	};
+	int irqs = pci_msix_vec_count(pdev);
+
+	mgbdev = kzalloc(sizeof(*mgbdev), GFP_KERNEL);
+	if (!mgbdev)
+		return -ENOMEM;
+
+	mgbdev->pdev = pdev;
+	pci_set_drvdata(pdev, mgbdev);
+
+	/* PCIe related stuff */
+	rv = pci_enable_device(pdev);
+	if (rv) {
+		dev_err(&pdev->dev, "error enabling PCI device\n");
+		goto err_mgbdev;
+	}
+
+	rv = pcie_capability_set_word(pdev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_RELAX_EN);
+	if (rv)
+		dev_warn(&pdev->dev, "error enabling PCIe relaxed ordering\n");
+	rv = pcie_capability_set_word(pdev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_EXT_TAG);
+	if (rv)
+		dev_warn(&pdev->dev, "error enabling PCIe extended tag field\n");
+	rv = pcie_set_readrq(pdev, 512);
+	if (rv)
+		dev_warn(&pdev->dev, "error setting PCIe max. memory read size\n");
+	pci_set_master(pdev);
+
+	rv = pci_alloc_irq_vectors(pdev, irqs, irqs, PCI_IRQ_MSIX);
+	if (rv < 0) {
+		dev_err(&pdev->dev, "error allocating MSI-X IRQs\n");
+		goto err_enable_pci;
+	}
+
+	rv = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (rv) {
+		dev_err(&pdev->dev, "error setting DMA mask\n");
+		goto err_enable_pci;
+	}
+
+	/* DMA + IRQ engine */
+	rv = init_xdma(mgbdev);
+	if (rv)
+		goto err_alloc_irq;
+	rv = mgb4_dma_channel_init(mgbdev);
+	if (rv)
+		goto err_dma_chan;
+
+	/* mgb4 video registers */
+	rv = map_regs(pdev, &video, &mgbdev->video);
+	if (rv < 0)
+		goto err_dma_chan;
+	/* mgb4 cmt registers */
+	rv = map_regs(pdev, &cmt, &mgbdev->cmt);
+	if (rv < 0)
+		goto err_video_regs;
+
+	/* SPI FLASH */
+	rv = init_spi(mgbdev);
+	if (rv < 0)
+		goto err_cmt_regs;
+
+	/* I2C controller */
+	rv = init_i2c(mgbdev);
+	if (rv < 0)
+		goto err_spi;
+
+	/* PCI card related sysfs attributes */
+	rv = device_add_groups(&pdev->dev, mgb4_pci_groups);
+	if (rv < 0)
+		goto err_i2c;
+
+#if IS_REACHABLE(CONFIG_HWMON)
+	/* HWmon (card temperature) */
+	mgbdev->hwmon_dev = hwmon_device_register_with_info(&pdev->dev, "mgb4",
+							    mgbdev,
+							    &temp_chip_info,
+							    NULL);
+#endif
+
+#ifdef CONFIG_DEBUG_FS
+	mgbdev->debugfs = debugfs_create_dir(dev_name(&pdev->dev), NULL);
+#endif
+
+	/* Get card serial number. On systems without MTD flash support we may
+	 * get an error thus ignore the return value. An invalid serial number
+	 * should not break anything...
+	 */
+	if (get_serial_number(mgbdev) < 0)
+		dev_warn(&pdev->dev, "error reading card serial number\n");
+
+	/* Get module type. If no valid module is found, skip the video device
+	 * creation part but do not exit with error to allow flashing the card.
+	 */
+	rv = get_module_version(mgbdev);
+	if (rv < 0)
+		goto exit;
+
+	/* Video input v4l2 devices */
+	for (i = 0; i < MGB4_VIN_DEVICES; i++)
+		mgbdev->vin[i] = mgb4_vin_create(mgbdev, i);
+
+	/* Video output v4l2 devices */
+	for (i = 0; i < MGB4_VOUT_DEVICES; i++)
+		mgbdev->vout[i] = mgb4_vout_create(mgbdev, i);
+
+	/* Triggers */
+	mgbdev->indio_dev = mgb4_trigger_create(mgbdev);
+
+exit:
+	flashid++;
+
+	return 0;
+
+err_i2c:
+	free_i2c(mgbdev);
+err_spi:
+	free_spi(mgbdev);
+err_cmt_regs:
+	mgb4_regs_free(&mgbdev->cmt);
+err_video_regs:
+	mgb4_regs_free(&mgbdev->video);
+err_dma_chan:
+	mgb4_dma_channel_free(mgbdev);
+	free_xdma(mgbdev);
+err_alloc_irq:
+	pci_disable_msix(pdev);
+err_enable_pci:
+	pci_disable_device(pdev);
+err_mgbdev:
+	kfree(mgbdev);
+
+	return rv;
+}
+
+static void mgb4_remove(struct pci_dev *pdev)
+{
+	struct mgb4_dev *mgbdev = pci_get_drvdata(pdev);
+	int i;
+
+#ifdef CONFIG_DEBUG_FS
+	debugfs_remove_recursive(mgbdev->debugfs);
+#endif
+#if IS_REACHABLE(CONFIG_HWMON)
+	hwmon_device_unregister(mgbdev->hwmon_dev);
+#endif
+
+	if (mgbdev->indio_dev)
+		mgb4_trigger_free(mgbdev->indio_dev);
+
+	for (i = 0; i < MGB4_VOUT_DEVICES; i++)
+		if (mgbdev->vout[i])
+			mgb4_vout_free(mgbdev->vout[i]);
+	for (i = 0; i < MGB4_VIN_DEVICES; i++)
+		if (mgbdev->vin[i])
+			mgb4_vin_free(mgbdev->vin[i]);
+
+	device_remove_groups(&mgbdev->pdev->dev, mgb4_pci_groups);
+	free_spi(mgbdev);
+	free_i2c(mgbdev);
+	mgb4_regs_free(&mgbdev->video);
+	mgb4_regs_free(&mgbdev->cmt);
+
+	mgb4_dma_channel_free(mgbdev);
+	free_xdma(mgbdev);
+
+	pci_disable_msix(mgbdev->pdev);
+	pci_disable_device(mgbdev->pdev);
+
+	kfree(mgbdev);
+}
+
+static const struct pci_device_id mgb4_pci_ids[] = {
+	{ PCI_DEVICE(0x1ed8, 0x0101), },
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, mgb4_pci_ids);
+
+static struct pci_driver mgb4_pci_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = mgb4_pci_ids,
+	.probe = mgb4_probe,
+	.remove = mgb4_remove,
+};
+
+module_pci_driver(mgb4_pci_driver);
+
+MODULE_AUTHOR("Digiteq Automotive s.r.o.");
+MODULE_DESCRIPTION("Digiteq Automotive MGB4 Driver");
+MODULE_LICENSE("GPL");
+MODULE_SOFTDEP("pre: platform:xiic-i2c platform:xilinx_spi spi-nor");
diff --git a/drivers/media/pci/mgb4/mgb4_core.h b/drivers/media/pci/mgb4/mgb4_core.h
new file mode 100644
index 000000000000..2a946e46aec1
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_core.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021-2023 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ */
+
+#ifndef __MGB4_CORE_H__
+#define __MGB4_CORE_H__
+
+#include <linux/spi/flash.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mutex.h>
+#include <linux/dmaengine.h>
+#include "mgb4_regs.h"
+
+#define MGB4_VIN_DEVICES  2
+#define MGB4_VOUT_DEVICES 2
+
+#define MGB4_MGB4_BAR_ID  0
+#define MGB4_XDMA_BAR_ID  1
+
+#define MGB4_IS_GMSL(mgbdev) \
+	((mgbdev)->module_version >> 4 == 2)
+#define MGB4_IS_FPDL3(mgbdev) \
+	((mgbdev)->module_version >> 4 == 1)
+
+struct mgb4_dma_channel {
+	struct dma_chan *chan;
+	struct completion req_compl;
+};
+
+struct mgb4_dev {
+	struct pci_dev *pdev;
+	struct platform_device *xdev;
+	struct mgb4_vin_dev *vin[MGB4_VIN_DEVICES];
+	struct mgb4_vout_dev *vout[MGB4_VOUT_DEVICES];
+
+	struct mgb4_dma_channel c2h_chan[MGB4_VIN_DEVICES];
+	struct mgb4_dma_channel h2c_chan[MGB4_VOUT_DEVICES];
+	struct dma_slave_map slave_map[MGB4_VIN_DEVICES + MGB4_VOUT_DEVICES];
+
+	struct mgb4_regs video;
+	struct mgb4_regs cmt;
+
+	struct clk_hw *i2c_clk;
+	struct clk_lookup *i2c_cl;
+	struct platform_device *i2c_pdev;
+	struct i2c_adapter *i2c_adap;
+	struct mutex i2c_lock; /* I2C bus access lock */
+
+	struct platform_device *spi_pdev;
+	struct flash_platform_data flash_data;
+	struct mtd_partition partitions[2];
+	char flash_name[16];
+	char fw_part_name[16];
+	char data_part_name[16];
+	char channel_names[MGB4_VIN_DEVICES + MGB4_VOUT_DEVICES][16];
+
+	struct iio_dev *indio_dev;
+#if IS_REACHABLE(CONFIG_HWMON)
+	struct device *hwmon_dev;
+#endif
+
+	unsigned long io_reconfig;
+
+	u8 module_version;
+	u32 serial_number;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs;
+#endif
+};
+
+#endif
diff --git a/drivers/media/pci/mgb4/mgb4_dma.c b/drivers/media/pci/mgb4/mgb4_dma.c
new file mode 100644
index 000000000000..cae888e6504b
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_dma.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021-2022 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ *
+ * This module handles the DMA transfers. A standard dmaengine API as provided
+ * by the XDMA module is used.
+ */
+
+#include <linux/pci.h>
+#include <linux/dma-direction.h>
+#include "mgb4_core.h"
+#include "mgb4_dma.h"
+
+static void chan_irq(void *param)
+{
+	struct mgb4_dma_channel *chan = param;
+
+	complete(&chan->req_compl);
+}
+
+int mgb4_dma_transfer(struct mgb4_dev *mgbdev, u32 channel, bool write,
+		      u64 paddr, struct sg_table *sgt)
+{
+	struct dma_slave_config cfg;
+	struct mgb4_dma_channel *chan;
+	struct dma_async_tx_descriptor *tx;
+	struct pci_dev *pdev = mgbdev->pdev;
+	int ret;
+
+	memset(&cfg, 0, sizeof(cfg));
+
+	if (write) {
+		cfg.direction = DMA_MEM_TO_DEV;
+		cfg.dst_addr = paddr;
+		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		chan = &mgbdev->h2c_chan[channel];
+	} else {
+		cfg.direction = DMA_DEV_TO_MEM;
+		cfg.src_addr = paddr;
+		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		chan = &mgbdev->c2h_chan[channel];
+	}
+
+	ret = dmaengine_slave_config(chan->chan, &cfg);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to config dma: %d\n", ret);
+		return ret;
+	}
+
+	tx = dmaengine_prep_slave_sg(chan->chan, sgt->sgl, sgt->nents,
+				     cfg.direction, 0);
+	if (!tx) {
+		dev_err(&pdev->dev, "failed to prep slave sg\n");
+		return -EIO;
+	}
+
+	tx->callback = chan_irq;
+	tx->callback_param = chan;
+
+	ret = dma_submit_error(dmaengine_submit(tx));
+	if (ret) {
+		dev_err(&pdev->dev, "failed to submit sg\n");
+		return -EIO;
+	}
+
+	dma_async_issue_pending(chan->chan);
+
+	if (!wait_for_completion_timeout(&chan->req_compl,
+					 msecs_to_jiffies(10000))) {
+		dev_err(&pdev->dev, "dma timeout\n");
+		dmaengine_terminate_sync(chan->chan);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int mgb4_dma_channel_init(struct mgb4_dev *mgbdev)
+{
+	int i, ret;
+	char name[16];
+	struct pci_dev *pdev = mgbdev->pdev;
+
+	for (i = 0; i < MGB4_VIN_DEVICES; i++) {
+		sprintf(name, "c2h%d", i);
+		mgbdev->c2h_chan[i].chan = dma_request_chan(&pdev->dev, name);
+		if (IS_ERR(mgbdev->c2h_chan[i].chan)) {
+			dev_err(&pdev->dev, "failed to initialize %s", name);
+			ret = PTR_ERR(mgbdev->c2h_chan[i].chan);
+			mgbdev->c2h_chan[i].chan = NULL;
+			return ret;
+		}
+		init_completion(&mgbdev->c2h_chan[i].req_compl);
+	}
+	for (i = 0; i < MGB4_VOUT_DEVICES; i++) {
+		sprintf(name, "h2c%d", i);
+		mgbdev->h2c_chan[i].chan = dma_request_chan(&pdev->dev, name);
+		if (IS_ERR(mgbdev->h2c_chan[i].chan)) {
+			dev_err(&pdev->dev, "failed to initialize %s", name);
+			ret = PTR_ERR(mgbdev->h2c_chan[i].chan);
+			mgbdev->h2c_chan[i].chan = NULL;
+			return ret;
+		}
+		init_completion(&mgbdev->h2c_chan[i].req_compl);
+	}
+
+	return 0;
+}
+
+void mgb4_dma_channel_free(struct mgb4_dev *mgbdev)
+{
+	int i;
+
+	for (i = 0; i < MGB4_VIN_DEVICES; i++) {
+		if (mgbdev->c2h_chan[i].chan)
+			dma_release_channel(mgbdev->c2h_chan[i].chan);
+	}
+	for (i = 0; i < MGB4_VOUT_DEVICES; i++) {
+		if (mgbdev->h2c_chan[i].chan)
+			dma_release_channel(mgbdev->h2c_chan[i].chan);
+	}
+}
diff --git a/drivers/media/pci/mgb4/mgb4_dma.h b/drivers/media/pci/mgb4/mgb4_dma.h
new file mode 100644
index 000000000000..4ebc2b1ce9b7
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_dma.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021-2023 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ */
+
+#ifndef __MGB4_DMA_H__
+#define __MGB4_DMA_H__
+
+#include "mgb4_core.h"
+
+int mgb4_dma_channel_init(struct mgb4_dev *mgbdev);
+void mgb4_dma_channel_free(struct mgb4_dev *mgbdev);
+
+int mgb4_dma_transfer(struct mgb4_dev *mgbdev, u32 channel, bool write,
+		      u64 paddr, struct sg_table *sgt);
+
+#endif
diff --git a/drivers/media/pci/mgb4/mgb4_i2c.c b/drivers/media/pci/mgb4/mgb4_i2c.c
new file mode 100644
index 000000000000..2697b67e290e
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_i2c.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021-2023 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ *
+ * The i2c module unifies the I2C access to the serializes/deserializes. The I2C
+ * chips on the GMSL module use 16b addressing, the FPDL3 chips use standard
+ * 8b addressing.
+ */
+
+#include "mgb4_i2c.h"
+
+static int read_r16(struct i2c_client *client, u16 reg, u8 *val, int len)
+{
+	int ret;
+	u8 buf[2];
+	struct i2c_msg msg[2] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = 2,
+			.buf = buf,
+		}, {
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = len,
+			.buf = val,
+		}
+	};
+
+	buf[0] = (reg >> 8) & 0xff;
+	buf[1] = (reg >> 0) & 0xff;
+
+	ret = i2c_transfer(client->adapter, msg, 2);
+	if (ret < 0)
+		return ret;
+	else if (ret != 2)
+		return -EREMOTEIO;
+	else
+		return 0;
+}
+
+static int write_r16(struct i2c_client *client, u16 reg, const u8 *val, int len)
+{
+	int ret;
+	u8 buf[4];
+	struct i2c_msg msg[1] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = 2 + len,
+			.buf = buf,
+		}
+	};
+
+	if (2 + len > sizeof(buf))
+		return -EINVAL;
+
+	buf[0] = (reg >> 8) & 0xff;
+	buf[1] = (reg >> 0) & 0xff;
+	memcpy(&buf[2], val, len);
+
+	ret = i2c_transfer(client->adapter, msg, 1);
+	if (ret < 0)
+		return ret;
+	else if (ret != 1)
+		return -EREMOTEIO;
+	else
+		return 0;
+}
+
+int mgb4_i2c_init(struct mgb4_i2c_client *client, struct i2c_adapter *adap,
+		  struct i2c_board_info const *info, int addr_size)
+{
+	client->client = i2c_new_client_device(adap, info);
+	if (IS_ERR(client->client))
+		return PTR_ERR(client->client);
+
+	client->addr_size = addr_size;
+
+	return 0;
+}
+
+void mgb4_i2c_free(struct mgb4_i2c_client *client)
+{
+	i2c_unregister_device(client->client);
+}
+
+s32 mgb4_i2c_read_byte(struct mgb4_i2c_client *client, u16 reg)
+{
+	int ret;
+	u8 b;
+
+	if (client->addr_size == 8)
+		return i2c_smbus_read_byte_data(client->client, reg);
+
+	ret = read_r16(client->client, reg, &b, 1);
+	if (ret < 0)
+		return ret;
+
+	return (s32)b;
+}
+
+s32 mgb4_i2c_write_byte(struct mgb4_i2c_client *client, u16 reg, u8 val)
+{
+	if (client->addr_size == 8)
+		return i2c_smbus_write_byte_data(client->client, reg, val);
+	else
+		return write_r16(client->client, reg, &val, 1);
+}
+
+s32 mgb4_i2c_mask_byte(struct mgb4_i2c_client *client, u16 reg, u8 mask, u8 val)
+{
+	s32 ret;
+
+	if (mask != 0xFF) {
+		ret = mgb4_i2c_read_byte(client, reg);
+		if (ret < 0)
+			return ret;
+		val |= (u8)ret & ~mask;
+	}
+
+	return mgb4_i2c_write_byte(client, reg, val);
+}
+
+int mgb4_i2c_configure(struct mgb4_i2c_client *client,
+		       const struct mgb4_i2c_kv *values, size_t count)
+{
+	size_t i;
+	s32 res;
+
+	for (i = 0; i < count; i++) {
+		res = mgb4_i2c_mask_byte(client, values[i].reg, values[i].mask,
+					 values[i].val);
+		if (res < 0)
+			return res;
+	}
+
+	return 0;
+}
diff --git a/drivers/media/pci/mgb4/mgb4_i2c.h b/drivers/media/pci/mgb4/mgb4_i2c.h
new file mode 100644
index 000000000000..fac6a1634474
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_i2c.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021-2023 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ */
+
+#ifndef __MGB4_I2C_H__
+#define __MGB4_I2C_H__
+
+#include <linux/i2c.h>
+
+struct mgb4_i2c_client {
+	struct i2c_client *client;
+	int addr_size;
+};
+
+struct mgb4_i2c_kv {
+	u16 reg;
+	u8 mask;
+	u8 val;
+};
+
+int mgb4_i2c_init(struct mgb4_i2c_client *client, struct i2c_adapter *adap,
+		  struct i2c_board_info const *info, int addr_size);
+void mgb4_i2c_free(struct mgb4_i2c_client *client);
+
+s32 mgb4_i2c_read_byte(struct mgb4_i2c_client *client, u16 reg);
+s32 mgb4_i2c_write_byte(struct mgb4_i2c_client *client, u16 reg, u8 val);
+s32 mgb4_i2c_mask_byte(struct mgb4_i2c_client *client, u16 reg, u8 mask,
+		       u8 val);
+
+int mgb4_i2c_configure(struct mgb4_i2c_client *client,
+		       const struct mgb4_i2c_kv *values, size_t count);
+
+#endif
diff --git a/drivers/media/pci/mgb4/mgb4_io.h b/drivers/media/pci/mgb4/mgb4_io.h
new file mode 100644
index 000000000000..8698db1be4a9
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_io.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021-2022 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ */
+
+#ifndef __MGB4_IO_H__
+#define __MGB4_IO_H__
+
+#include <media/v4l2-dev.h>
+
+#define MGB4_DEFAULT_WIDTH     1280
+#define MGB4_DEFAULT_HEIGHT    640
+#define MGB4_DEFAULT_PERIOD    (125000000 / 60)
+
+/* Register access error indication */
+#define MGB4_ERR_NO_REG        0xFFFFFFFE
+/* Frame buffer addresses greater than 0xFFFFFFFA indicate HW errors */
+#define MGB4_ERR_QUEUE_TIMEOUT 0xFFFFFFFD
+#define MGB4_ERR_QUEUE_EMPTY   0xFFFFFFFC
+#define MGB4_ERR_QUEUE_FULL    0xFFFFFFFB
+
+struct mgb4_frame_buffer {
+	struct vb2_v4l2_buffer vb;
+	struct list_head list;
+};
+
+static inline struct mgb4_frame_buffer *to_frame_buffer(struct vb2_v4l2_buffer *vbuf)
+{
+	return container_of(vbuf, struct mgb4_frame_buffer, vb);
+}
+
+#endif
diff --git a/drivers/media/pci/mgb4/mgb4_regs.c b/drivers/media/pci/mgb4/mgb4_regs.c
new file mode 100644
index 000000000000..53d4e4503a74
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_regs.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021-2022 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ */
+
+#include <linux/ioport.h>
+#include "mgb4_regs.h"
+
+int mgb4_regs_map(struct resource *res, struct mgb4_regs *regs)
+{
+	regs->mapbase = res->start;
+	regs->mapsize = res->end - res->start;
+
+	if (!request_mem_region(regs->mapbase, regs->mapsize, res->name))
+		return -EINVAL;
+	regs->membase = ioremap(regs->mapbase, regs->mapsize);
+	if (!regs->membase) {
+		release_mem_region(regs->mapbase, regs->mapsize);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void mgb4_regs_free(struct mgb4_regs *regs)
+{
+	iounmap(regs->membase);
+	release_mem_region(regs->mapbase, regs->mapsize);
+}
diff --git a/drivers/media/pci/mgb4/mgb4_regs.h b/drivers/media/pci/mgb4/mgb4_regs.h
new file mode 100644
index 000000000000..c45180890730
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_regs.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021-2022 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ */
+
+#ifndef __MGB4_REGS_H__
+#define __MGB4_REGS_H__
+
+#include <linux/io.h>
+
+struct mgb4_regs {
+	resource_size_t mapbase;
+	resource_size_t mapsize;
+	void __iomem *membase;
+};
+
+#define mgb4_write_reg(regs, offset, val) \
+	iowrite32(val, (regs)->membase + (offset))
+#define  mgb4_read_reg(regs, offset) \
+	ioread32((regs)->membase + (offset))
+
+static inline void mgb4_mask_reg(struct mgb4_regs *regs, u32 reg, u32 mask,
+				 u32 val)
+{
+	u32 ret = mgb4_read_reg(regs, reg);
+
+	val |= ret & ~mask;
+	mgb4_write_reg(regs, reg, val);
+}
+
+int mgb4_regs_map(struct resource *res, struct mgb4_regs *regs);
+void mgb4_regs_free(struct mgb4_regs *regs);
+
+#endif
diff --git a/drivers/media/pci/mgb4/mgb4_sysfs.h b/drivers/media/pci/mgb4/mgb4_sysfs.h
new file mode 100644
index 000000000000..017d82c0624e
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_sysfs.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021-2022 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ */
+
+#ifndef __MGB4_SYSFS_H__
+#define __MGB4_SYSFS_H__
+
+#include <linux/sysfs.h>
+
+extern struct attribute *mgb4_pci_attrs[];
+extern struct attribute *mgb4_fpdl3_in_attrs[];
+extern struct attribute *mgb4_gmsl_in_attrs[];
+extern struct attribute *mgb4_fpdl3_out_attrs[];
+extern struct attribute *mgb4_gmsl_out_attrs[];
+
+#endif
diff --git a/drivers/media/pci/mgb4/mgb4_sysfs_in.c b/drivers/media/pci/mgb4/mgb4_sysfs_in.c
new file mode 100644
index 000000000000..0ba66a2cf145
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_sysfs_in.c
@@ -0,0 +1,772 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021-2023 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ *
+ * This module handles all the sysfs info/configuration that is related to the
+ * v4l2 input devices.
+ */
+
+#include <linux/device.h>
+#include "mgb4_core.h"
+#include "mgb4_i2c.h"
+#include "mgb4_vin.h"
+#include "mgb4_cmt.h"
+#include "mgb4_sysfs.h"
+
+/* Common for both FPDL3 and GMSL */
+
+static ssize_t input_id_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+
+	return sprintf(buf, "%d\n", vindev->config->id);
+}
+
+static ssize_t oldi_lane_width_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	struct mgb4_dev *mgbdev = vindev->mgbdev;
+	u16 i2c_reg;
+	u8 i2c_mask, i2c_single_val, i2c_dual_val;
+	u32 config;
+	int ret;
+
+	i2c_reg = MGB4_IS_GMSL(mgbdev) ? 0x1CE : 0x49;
+	i2c_mask = MGB4_IS_GMSL(mgbdev) ? 0x0E : 0x03;
+	i2c_single_val = MGB4_IS_GMSL(mgbdev) ? 0x00 : 0x02;
+	i2c_dual_val = MGB4_IS_GMSL(mgbdev) ? 0x0E : 0x00;
+
+	mutex_lock(&mgbdev->i2c_lock);
+	ret = mgb4_i2c_read_byte(&vindev->deser, i2c_reg);
+	mutex_unlock(&mgbdev->i2c_lock);
+	if (ret < 0)
+		return -EIO;
+
+	config = mgb4_read_reg(&mgbdev->video, vindev->config->regs.config);
+
+	if (((config & (1U << 9)) && ((ret & i2c_mask) != i2c_dual_val)) ||
+	    (!(config & (1U << 9)) && ((ret & i2c_mask) != i2c_single_val))) {
+		dev_err(dev, "I2C/FPGA register value mismatch\n");
+		return -EINVAL;
+	}
+
+	return sprintf(buf, "%s\n", config & (1U << 9) ? "1" : "0");
+}
+
+/*
+ * OLDI lane width change is expected to be called on live streams. Video device
+ * locking/queue check is not needed.
+ */
+static ssize_t oldi_lane_width_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	struct mgb4_dev *mgbdev = vindev->mgbdev;
+	u32 fpga_data;
+	u16 i2c_reg;
+	u8 i2c_mask, i2c_data;
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	switch (val) {
+	case 0: /* single */
+		fpga_data = 0;
+		i2c_data = MGB4_IS_GMSL(mgbdev) ? 0x00 : 0x02;
+		break;
+	case 1: /* dual */
+		fpga_data = 1U << 9;
+		i2c_data = MGB4_IS_GMSL(mgbdev) ? 0x0E : 0x00;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	i2c_reg = MGB4_IS_GMSL(mgbdev) ? 0x1CE : 0x49;
+	i2c_mask = MGB4_IS_GMSL(mgbdev) ? 0x0E : 0x03;
+
+	mutex_lock(&mgbdev->i2c_lock);
+	ret = mgb4_i2c_mask_byte(&vindev->deser, i2c_reg, i2c_mask, i2c_data);
+	mutex_unlock(&mgbdev->i2c_lock);
+	if (ret < 0)
+		return -EIO;
+	mgb4_mask_reg(&mgbdev->video, vindev->config->regs.config, 1U << 9,
+		      fpga_data);
+	if (MGB4_IS_GMSL(mgbdev)) {
+		/* reset input link */
+		mutex_lock(&mgbdev->i2c_lock);
+		ret = mgb4_i2c_mask_byte(&vindev->deser, 0x10, 1U << 5, 1U << 5);
+		mutex_unlock(&mgbdev->i2c_lock);
+		if (ret < 0)
+			return -EIO;
+	}
+
+	return count;
+}
+
+static ssize_t color_mapping_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	u32 config = mgb4_read_reg(&vindev->mgbdev->video,
+	  vindev->config->regs.config);
+
+	return sprintf(buf, "%s\n", config & (1U << 8) ? "0" : "1");
+}
+
+/*
+ * Color mapping change is expected to be called on live streams. Video device
+ * locking/queue check is not needed.
+ */
+static ssize_t color_mapping_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	u32 fpga_data;
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	switch (val) {
+	case 0: /* OLDI/JEIDA */
+		fpga_data = (1U << 8);
+		break;
+	case 1: /* SPWG/VESA */
+		fpga_data = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mgb4_mask_reg(&vindev->mgbdev->video, vindev->config->regs.config,
+		      1U << 8, fpga_data);
+
+	return count;
+}
+
+static ssize_t link_status_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	u32 status = mgb4_read_reg(&vindev->mgbdev->video,
+				   vindev->config->regs.status);
+
+	return sprintf(buf, "%s\n", status & (1U << 2) ? "1" : "0");
+}
+
+static ssize_t stream_status_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	u32 status = mgb4_read_reg(&vindev->mgbdev->video,
+				   vindev->config->regs.status);
+
+	return sprintf(buf, "%s\n", ((status & (1 << 14)) &&
+		       (status & (1 << 2)) && (status & (3 << 9))) ? "1" : "0");
+}
+
+static ssize_t video_width_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	u32 config = mgb4_read_reg(&vindev->mgbdev->video,
+	  vindev->config->regs.resolution);
+
+	return sprintf(buf, "%u\n", config >> 16);
+}
+
+static ssize_t video_height_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	u32 config = mgb4_read_reg(&vindev->mgbdev->video,
+	  vindev->config->regs.resolution);
+
+	return sprintf(buf, "%u\n", config & 0xFFFF);
+}
+
+static ssize_t hsync_status_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	u32 status = mgb4_read_reg(&vindev->mgbdev->video,
+				   vindev->config->regs.status);
+	u32 res;
+
+	if (!(status & (1U << 11)))
+		res = 0x02; // not available
+	else if (status & (1U << 12))
+		res = 0x01; // active high
+	else
+		res = 0x00; // active low
+
+	return sprintf(buf, "%u\n", res);
+}
+
+static ssize_t vsync_status_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	u32 status = mgb4_read_reg(&vindev->mgbdev->video,
+				   vindev->config->regs.status);
+	u32 res;
+
+	if (!(status & (1U << 11)))
+		res = 0x02; // not available
+	else if (status & (1U << 13))
+		res = 0x01; // active high
+	else
+		res = 0x00; // active low
+
+	return sprintf(buf, "%u\n", res);
+}
+
+static ssize_t hsync_gap_length_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	u32 sync = mgb4_read_reg(&vindev->mgbdev->video,
+				 vindev->config->regs.sync);
+
+	return sprintf(buf, "%u\n", sync >> 16);
+}
+
+/*
+ * HSYNC gap length change is expected to be called on live streams. Video
+ * device locking/queue check is not needed.
+ */
+static ssize_t hsync_gap_length_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+	if (val > 0xFFFF)
+		return -EINVAL;
+
+	mgb4_mask_reg(&vindev->mgbdev->video, vindev->config->regs.sync,
+		      0xFFFF0000, val << 16);
+
+	return count;
+}
+
+static ssize_t vsync_gap_length_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	u32 sync = mgb4_read_reg(&vindev->mgbdev->video,
+				 vindev->config->regs.sync);
+
+	return sprintf(buf, "%u\n", sync & 0xFFFF);
+}
+
+/*
+ * VSYNC gap length change is expected to be called on live streams. Video
+ * device locking/queue check is not needed.
+ */
+static ssize_t vsync_gap_length_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+	if (val > 0xFFFF)
+		return -EINVAL;
+
+	mgb4_mask_reg(&vindev->mgbdev->video, vindev->config->regs.sync, 0xFFFF,
+		      val);
+
+	return count;
+}
+
+static ssize_t pclk_frequency_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	u32 freq = mgb4_read_reg(&vindev->mgbdev->video,
+				 vindev->config->regs.pclk);
+
+	return sprintf(buf, "%u\n", freq);
+}
+
+static ssize_t hsync_width_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	u32 sig = mgb4_read_reg(&vindev->mgbdev->video,
+				vindev->config->regs.signal);
+
+	return sprintf(buf, "%u\n", (sig & 0x00FF0000) >> 16);
+}
+
+static ssize_t vsync_width_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	u32 sig = mgb4_read_reg(&vindev->mgbdev->video,
+				vindev->config->regs.signal2);
+
+	return sprintf(buf, "%u\n", (sig & 0x00FF0000) >> 16);
+}
+
+static ssize_t hback_porch_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	u32 sig = mgb4_read_reg(&vindev->mgbdev->video,
+				vindev->config->regs.signal);
+
+	return sprintf(buf, "%u\n", (sig & 0x0000FF00) >> 8);
+}
+
+static ssize_t hfront_porch_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	u32 sig = mgb4_read_reg(&vindev->mgbdev->video,
+				vindev->config->regs.signal);
+
+	return sprintf(buf, "%u\n", (sig & 0x000000FF));
+}
+
+static ssize_t vback_porch_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	u32 sig = mgb4_read_reg(&vindev->mgbdev->video,
+				vindev->config->regs.signal2);
+
+	return sprintf(buf, "%u\n", (sig & 0x0000FF00) >> 8);
+}
+
+static ssize_t vfront_porch_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	u32 sig = mgb4_read_reg(&vindev->mgbdev->video,
+				vindev->config->regs.signal2);
+
+	return sprintf(buf, "%u\n", (sig & 0x000000FF));
+}
+
+static ssize_t frequency_range_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+
+	return sprintf(buf, "%d\n", vindev->freq_range);
+}
+
+static ssize_t frequency_range_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+	if (val > 1)
+		return -EINVAL;
+
+	mutex_lock(vindev->vdev.lock);
+	if (vb2_is_busy(vindev->vdev.queue)) {
+		mutex_unlock(vindev->vdev.lock);
+		return -EBUSY;
+	}
+
+	mgb4_cmt_set_vin_freq_range(vindev, val);
+	vindev->freq_range = val;
+
+	mutex_unlock(vindev->vdev.lock);
+
+	return count;
+}
+
+/* FPDL3 only */
+
+static ssize_t fpdl3_input_width_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	s32 ret;
+
+	mutex_lock(&vindev->mgbdev->i2c_lock);
+	ret = mgb4_i2c_read_byte(&vindev->deser, 0x34);
+	mutex_unlock(&vindev->mgbdev->i2c_lock);
+	if (ret < 0)
+		return -EIO;
+
+	switch ((u8)ret & 0x18) {
+	case 0:
+		return sprintf(buf, "0\n");
+	case 0x10:
+		return sprintf(buf, "1\n");
+	case 0x08:
+		return sprintf(buf, "2\n");
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * FPD-Link width change is expected to be called on live streams. Video device
+ * locking/queue check is not needed.
+ */
+static ssize_t fpdl3_input_width_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	u8 i2c_data;
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	switch (val) {
+	case 0: /* auto */
+		i2c_data = 0x00;
+		break;
+	case 1: /* single */
+		i2c_data = 0x10;
+		break;
+	case 2: /* dual */
+		i2c_data = 0x08;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_lock(&vindev->mgbdev->i2c_lock);
+	ret = mgb4_i2c_mask_byte(&vindev->deser, 0x34, 0x18, i2c_data);
+	mutex_unlock(&vindev->mgbdev->i2c_lock);
+	if (ret < 0)
+		return -EIO;
+
+	return count;
+}
+
+/* GMSL only */
+
+static ssize_t gmsl_mode_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	s32 r1, r300, r3;
+
+	mutex_lock(&vindev->mgbdev->i2c_lock);
+	r1 = mgb4_i2c_read_byte(&vindev->deser, 0x01);
+	r300 = mgb4_i2c_read_byte(&vindev->deser, 0x300);
+	r3 = mgb4_i2c_read_byte(&vindev->deser, 0x03);
+	mutex_unlock(&vindev->mgbdev->i2c_lock);
+	if (r1 < 0 || r300 < 0 || r3 < 0)
+		return -EIO;
+
+	if ((r1 & 0x03) == 0x03 && (r300 & 0x0C) == 0x0C && (r3 & 0xC0) == 0xC0)
+		return sprintf(buf, "0\n");
+	else if ((r1 & 0x03) == 0x02 && (r300 & 0x0C) == 0x08 && (r3 & 0xC0) == 0x00)
+		return sprintf(buf, "1\n");
+	else if ((r1 & 0x03) == 0x01 && (r300 & 0x0C) == 0x04 && (r3 & 0xC0) == 0x00)
+		return sprintf(buf, "2\n");
+	else if ((r1 & 0x03) == 0x00 && (r300 & 0x0C) == 0x00 && (r3 & 0xC0) == 0x00)
+		return sprintf(buf, "3\n");
+	else
+		return -EINVAL;
+}
+
+/*
+ * GMSL mode change is expected to be called on live streams. Video device
+ * locking/queue check is not needed.
+ */
+static ssize_t gmsl_mode_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
+{
+	static const struct mgb4_i2c_kv G12[] = {
+		{0x01, 0x03, 0x03}, {0x300, 0x0C, 0x0C}, {0x03, 0xC0, 0xC0}};
+	static const struct mgb4_i2c_kv G6[] = {
+		{0x01, 0x03, 0x02}, {0x300, 0x0C, 0x08}, {0x03, 0xC0, 0x00}};
+	static const struct mgb4_i2c_kv G3[] = {
+		{0x01, 0x03, 0x01}, {0x300, 0x0C, 0x04}, {0x03, 0xC0, 0x00}};
+	static const struct mgb4_i2c_kv G1[] = {
+		{0x01, 0x03, 0x00}, {0x300, 0x0C, 0x00}, {0x03, 0xC0, 0x00}};
+	static const struct mgb4_i2c_kv reset[] = {
+		{0x10, 1U << 5, 1U << 5}, {0x300, 1U << 6, 1U << 6}};
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	const struct mgb4_i2c_kv *values;
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	switch (val) {
+	case 0: /* 12Gb/s */
+		values = G12;
+		break;
+	case 1: /* 6Gb/s */
+		values = G6;
+		break;
+	case 2: /* 3Gb/s */
+		values = G3;
+		break;
+	case 3: /* 1.5Gb/s */
+		values = G1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_lock(&vindev->mgbdev->i2c_lock);
+	ret = mgb4_i2c_configure(&vindev->deser, values, 3);
+	ret |= mgb4_i2c_configure(&vindev->deser, reset, 2);
+	mutex_unlock(&vindev->mgbdev->i2c_lock);
+	if (ret < 0)
+		return -EIO;
+
+	return count;
+}
+
+static ssize_t gmsl_stream_id_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	s32 ret;
+
+	mutex_lock(&vindev->mgbdev->i2c_lock);
+	ret = mgb4_i2c_read_byte(&vindev->deser, 0xA0);
+	mutex_unlock(&vindev->mgbdev->i2c_lock);
+	if (ret < 0)
+		return -EIO;
+
+	return sprintf(buf, "%d\n", ret & 0x03);
+}
+
+static ssize_t gmsl_stream_id_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+	if (val > 3)
+		return -EINVAL;
+
+	mutex_lock(vindev->vdev.lock);
+	if (vb2_is_busy(vindev->vdev.queue)) {
+		mutex_unlock(vindev->vdev.lock);
+		return -EBUSY;
+	}
+
+	mutex_lock(&vindev->mgbdev->i2c_lock);
+	ret = mgb4_i2c_mask_byte(&vindev->deser, 0xA0, 0x03, (u8)val);
+	mutex_unlock(&vindev->mgbdev->i2c_lock);
+
+	mutex_unlock(vindev->vdev.lock);
+
+	return (ret < 0) ? -EIO : count;
+}
+
+static ssize_t gmsl_fec_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	s32 r3e0, r308;
+
+	mutex_lock(&vindev->mgbdev->i2c_lock);
+	r3e0 = mgb4_i2c_read_byte(&vindev->deser, 0x3E0);
+	r308 = mgb4_i2c_read_byte(&vindev->deser, 0x308);
+	mutex_unlock(&vindev->mgbdev->i2c_lock);
+	if (r3e0 < 0 || r308 < 0)
+		return -EIO;
+
+	if ((r3e0 & 0x07) == 0x00 && (r308 & 0x01) == 0x00)
+		return sprintf(buf, "0\n");
+	else if ((r3e0 & 0x07) == 0x07 && (r308 & 0x01) == 0x01)
+		return sprintf(buf, "1\n");
+	else
+		return -EINVAL;
+}
+
+/*
+ * GMSL FEC change is expected to be called on live streams. Video device
+ * locking/queue check is not needed.
+ */
+static ssize_t gmsl_fec_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vin_dev *vindev = video_get_drvdata(vdev);
+	static const struct mgb4_i2c_kv enable[] = {
+		{0x3E0, 0x07, 0x07}, {0x308, 0x01, 0x01}};
+	static const struct mgb4_i2c_kv disable[] = {
+		{0x3E0, 0x07, 0x00}, {0x308, 0x01, 0x00}};
+	static const struct mgb4_i2c_kv reset[] = {
+		{0x10, 1U << 5, 1U << 5}, {0x300, 1U << 6, 1U << 6}};
+	const struct mgb4_i2c_kv *values;
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	switch (val) {
+	case 0: /* disabled */
+		values = disable;
+		break;
+	case 1: /* enabled */
+		values = enable;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_lock(&vindev->mgbdev->i2c_lock);
+	ret = mgb4_i2c_configure(&vindev->deser, values, 2);
+	ret |= mgb4_i2c_configure(&vindev->deser, reset, 2);
+	mutex_unlock(&vindev->mgbdev->i2c_lock);
+	if (ret < 0)
+		return -EIO;
+
+	return count;
+}
+
+static DEVICE_ATTR_RO(input_id);
+static DEVICE_ATTR_RW(oldi_lane_width);
+static DEVICE_ATTR_RW(color_mapping);
+static DEVICE_ATTR_RO(link_status);
+static DEVICE_ATTR_RO(stream_status);
+static DEVICE_ATTR_RO(video_width);
+static DEVICE_ATTR_RO(video_height);
+static DEVICE_ATTR_RO(hsync_status);
+static DEVICE_ATTR_RO(vsync_status);
+static DEVICE_ATTR_RW(hsync_gap_length);
+static DEVICE_ATTR_RW(vsync_gap_length);
+static DEVICE_ATTR_RO(pclk_frequency);
+static DEVICE_ATTR_RO(hsync_width);
+static DEVICE_ATTR_RO(vsync_width);
+static DEVICE_ATTR_RO(hback_porch);
+static DEVICE_ATTR_RO(hfront_porch);
+static DEVICE_ATTR_RO(vback_porch);
+static DEVICE_ATTR_RO(vfront_porch);
+static DEVICE_ATTR_RW(frequency_range);
+
+static DEVICE_ATTR_RW(fpdl3_input_width);
+
+static DEVICE_ATTR_RW(gmsl_mode);
+static DEVICE_ATTR_RW(gmsl_stream_id);
+static DEVICE_ATTR_RW(gmsl_fec);
+
+struct attribute *mgb4_fpdl3_in_attrs[] = {
+	&dev_attr_input_id.attr,
+	&dev_attr_link_status.attr,
+	&dev_attr_stream_status.attr,
+	&dev_attr_video_width.attr,
+	&dev_attr_video_height.attr,
+	&dev_attr_hsync_status.attr,
+	&dev_attr_vsync_status.attr,
+	&dev_attr_oldi_lane_width.attr,
+	&dev_attr_color_mapping.attr,
+	&dev_attr_hsync_gap_length.attr,
+	&dev_attr_vsync_gap_length.attr,
+	&dev_attr_pclk_frequency.attr,
+	&dev_attr_hsync_width.attr,
+	&dev_attr_vsync_width.attr,
+	&dev_attr_hback_porch.attr,
+	&dev_attr_hfront_porch.attr,
+	&dev_attr_vback_porch.attr,
+	&dev_attr_vfront_porch.attr,
+	&dev_attr_frequency_range.attr,
+	&dev_attr_fpdl3_input_width.attr,
+	NULL
+};
+
+struct attribute *mgb4_gmsl_in_attrs[] = {
+	&dev_attr_input_id.attr,
+	&dev_attr_link_status.attr,
+	&dev_attr_stream_status.attr,
+	&dev_attr_video_width.attr,
+	&dev_attr_video_height.attr,
+	&dev_attr_hsync_status.attr,
+	&dev_attr_vsync_status.attr,
+	&dev_attr_oldi_lane_width.attr,
+	&dev_attr_color_mapping.attr,
+	&dev_attr_hsync_gap_length.attr,
+	&dev_attr_vsync_gap_length.attr,
+	&dev_attr_pclk_frequency.attr,
+	&dev_attr_hsync_width.attr,
+	&dev_attr_vsync_width.attr,
+	&dev_attr_hback_porch.attr,
+	&dev_attr_hfront_porch.attr,
+	&dev_attr_vback_porch.attr,
+	&dev_attr_vfront_porch.attr,
+	&dev_attr_frequency_range.attr,
+	&dev_attr_gmsl_mode.attr,
+	&dev_attr_gmsl_stream_id.attr,
+	&dev_attr_gmsl_fec.attr,
+	NULL
+};
diff --git a/drivers/media/pci/mgb4/mgb4_sysfs_out.c b/drivers/media/pci/mgb4/mgb4_sysfs_out.c
new file mode 100644
index 000000000000..23a9aabf3915
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_sysfs_out.c
@@ -0,0 +1,737 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021-2023 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ *
+ * This module handles all the sysfs info/configuration that is related to the
+ * v4l2 output devices.
+ */
+
+#include <linux/device.h>
+#include "mgb4_core.h"
+#include "mgb4_i2c.h"
+#include "mgb4_vout.h"
+#include "mgb4_vin.h"
+#include "mgb4_cmt.h"
+#include "mgb4_sysfs.h"
+
+static int loopin_cnt(struct mgb4_vin_dev *vindev)
+{
+	struct mgb4_vout_dev *voutdev;
+	u32 config;
+	int i, cnt = 0;
+
+	for (i = 0; i < MGB4_VOUT_DEVICES; i++) {
+		voutdev = vindev->mgbdev->vout[i];
+		if (!voutdev)
+			continue;
+
+		config = mgb4_read_reg(&voutdev->mgbdev->video,
+				       voutdev->config->regs.config);
+		if ((config & 0xc) >> 2 == vindev->config->id)
+			cnt++;
+	}
+
+	return cnt;
+}
+
+static bool is_busy(struct video_device *dev)
+{
+	bool ret;
+
+	mutex_lock(dev->lock);
+	ret = vb2_is_busy(dev->queue);
+	mutex_unlock(dev->lock);
+
+	return ret;
+}
+
+/* Common for both FPDL3 and GMSL */
+
+static ssize_t output_id_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+
+	return sprintf(buf, "%d\n", voutdev->config->id);
+}
+
+static ssize_t video_source_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	u32 config = mgb4_read_reg(&voutdev->mgbdev->video,
+	  voutdev->config->regs.config);
+
+	return sprintf(buf, "%u\n", (config & 0xc) >> 2);
+}
+
+/*
+ * Video source change may affect the buffer queue of ANY video input/output on
+ * the card thus if any of the inputs/outputs is in use, we do not allow
+ * the change.
+ *
+ * As we do not want to lock all the video devices at the same time, a two-stage
+ * locking strategy is used. In addition to the video device locking there is
+ * a global (PCI device) variable "io_reconfig" atomically checked/set when
+ * the reconfiguration is running. All the video devices check the variable in
+ * their queue_setup() functions and do not allow to start the queue when
+ * the reconfiguration has started.
+ */
+static ssize_t video_source_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	struct mgb4_dev *mgbdev = voutdev->mgbdev;
+	struct mgb4_vin_dev *loopin_new = NULL, *loopin_old = NULL;
+	unsigned long val;
+	ssize_t ret;
+	u32 config;
+	int i;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+	if (val > 3)
+		return -EINVAL;
+
+	if (test_and_set_bit(0, &mgbdev->io_reconfig))
+		return -EBUSY;
+
+	ret = -EBUSY;
+	for (i = 0; i < MGB4_VIN_DEVICES; i++)
+		if (mgbdev->vin[i] && is_busy(&mgbdev->vin[i]->vdev))
+			goto end;
+	for (i = 0; i < MGB4_VOUT_DEVICES; i++)
+		if (mgbdev->vout[i] && is_busy(&mgbdev->vout[i]->vdev))
+			goto end;
+
+	config = mgb4_read_reg(&mgbdev->video, voutdev->config->regs.config);
+
+	if (((config & 0xc) >> 2) < MGB4_VIN_DEVICES)
+		loopin_old = mgbdev->vin[(config & 0xc) >> 2];
+	if (val < MGB4_VIN_DEVICES)
+		loopin_new = mgbdev->vin[val];
+	if (loopin_old && loopin_cnt(loopin_old) == 1)
+		mgb4_mask_reg(&mgbdev->video, loopin_old->config->regs.config,
+			      0x2, 0x0);
+	if (loopin_new)
+		mgb4_mask_reg(&mgbdev->video, loopin_new->config->regs.config,
+			      0x2, 0x2);
+
+	if (val == voutdev->config->id + MGB4_VIN_DEVICES)
+		mgb4_write_reg(&mgbdev->video, voutdev->config->regs.config,
+			       config & ~(1 << 1));
+	else
+		mgb4_write_reg(&mgbdev->video, voutdev->config->regs.config,
+			       config | (1U << 1));
+
+	mgb4_mask_reg(&mgbdev->video, voutdev->config->regs.config, 0xc,
+		      val << 2);
+
+	ret = count;
+end:
+	clear_bit(0, &mgbdev->io_reconfig);
+
+	return ret;
+}
+
+static ssize_t display_width_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	u32 config = mgb4_read_reg(&voutdev->mgbdev->video,
+	  voutdev->config->regs.resolution);
+
+	return sprintf(buf, "%u\n", config >> 16);
+}
+
+static ssize_t display_width_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+	if (val > 0xFFFF)
+		return -EINVAL;
+
+	mutex_lock(voutdev->vdev.lock);
+	if (vb2_is_busy(voutdev->vdev.queue)) {
+		mutex_unlock(voutdev->vdev.lock);
+		return -EBUSY;
+	}
+
+	mgb4_mask_reg(&voutdev->mgbdev->video, voutdev->config->regs.resolution,
+		      0xFFFF0000, val << 16);
+
+	mutex_unlock(voutdev->vdev.lock);
+
+	return count;
+}
+
+static ssize_t display_height_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	u32 config = mgb4_read_reg(&voutdev->mgbdev->video,
+	  voutdev->config->regs.resolution);
+
+	return sprintf(buf, "%u\n", config & 0xFFFF);
+}
+
+static ssize_t display_height_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+	if (val > 0xFFFF)
+		return -EINVAL;
+
+	mutex_lock(voutdev->vdev.lock);
+	if (vb2_is_busy(voutdev->vdev.queue)) {
+		mutex_unlock(voutdev->vdev.lock);
+		return -EBUSY;
+	}
+
+	mgb4_mask_reg(&voutdev->mgbdev->video, voutdev->config->regs.resolution,
+		      0xFFFF, val);
+
+	mutex_unlock(voutdev->vdev.lock);
+
+	return count;
+}
+
+static ssize_t frame_rate_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	u32 period = mgb4_read_reg(&voutdev->mgbdev->video,
+				   voutdev->config->regs.frame_period);
+
+	return sprintf(buf, "%u\n", 125000000 / period);
+}
+
+/*
+ * Frame rate change is expected to be called on live streams. Video device
+ * locking/queue check is not needed.
+ */
+static ssize_t frame_rate_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	mgb4_write_reg(&voutdev->mgbdev->video,
+		       voutdev->config->regs.frame_period, 125000000 / val);
+
+	return count;
+}
+
+static ssize_t hsync_width_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	u32 sig = mgb4_read_reg(&voutdev->mgbdev->video,
+				voutdev->config->regs.hsync);
+
+	return sprintf(buf, "%u\n", (sig & 0x00FF0000) >> 16);
+}
+
+/*
+ * HSYNC width change is expected to be called on live streams. Video device
+ * locking/queue check is not needed.
+ */
+static ssize_t hsync_width_store(struct device *dev,
+				 struct device_attribute *attr, const char *buf,
+				 size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+	if (val > 0xFF)
+		return -EINVAL;
+
+	mgb4_mask_reg(&voutdev->mgbdev->video, voutdev->config->regs.hsync,
+		      0x00FF0000, val << 16);
+
+	return count;
+}
+
+static ssize_t vsync_width_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	u32 sig = mgb4_read_reg(&voutdev->mgbdev->video,
+				voutdev->config->regs.vsync);
+
+	return sprintf(buf, "%u\n", (sig & 0x00FF0000) >> 16);
+}
+
+/*
+ * VSYNC vidth change is expected to be called on live streams. Video device
+ * locking/queue check is not needed.
+ */
+static ssize_t vsync_width_store(struct device *dev,
+				 struct device_attribute *attr, const char *buf,
+				 size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+	if (val > 0xFF)
+		return -EINVAL;
+
+	mgb4_mask_reg(&voutdev->mgbdev->video, voutdev->config->regs.vsync,
+		      0x00FF0000, val << 16);
+
+	return count;
+}
+
+static ssize_t hback_porch_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	u32 sig = mgb4_read_reg(&voutdev->mgbdev->video,
+				voutdev->config->regs.hsync);
+
+	return sprintf(buf, "%u\n", (sig & 0x0000FF00) >> 8);
+}
+
+/*
+ * hback porch change is expected to be called on live streams. Video device
+ * locking/queue check is not needed.
+ */
+static ssize_t hback_porch_store(struct device *dev,
+				 struct device_attribute *attr, const char *buf,
+				 size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+	if (val > 0xFF)
+		return -EINVAL;
+
+	mgb4_mask_reg(&voutdev->mgbdev->video, voutdev->config->regs.hsync,
+		      0x0000FF00, val << 8);
+
+	return count;
+}
+
+static ssize_t vback_porch_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	u32 sig = mgb4_read_reg(&voutdev->mgbdev->video,
+				voutdev->config->regs.vsync);
+
+	return sprintf(buf, "%u\n", (sig & 0x0000FF00) >> 8);
+}
+
+/*
+ * vback porch change is expected to be called on live streams. Video device
+ * locking/queue check is not needed.
+ */
+static ssize_t vback_porch_store(struct device *dev,
+				 struct device_attribute *attr, const char *buf,
+				 size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+	if (val > 0xFF)
+		return -EINVAL;
+
+	mgb4_mask_reg(&voutdev->mgbdev->video, voutdev->config->regs.vsync,
+		      0x0000FF00, val << 8);
+
+	return count;
+}
+
+static ssize_t hfront_porch_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	u32 sig = mgb4_read_reg(&voutdev->mgbdev->video,
+				voutdev->config->regs.hsync);
+
+	return sprintf(buf, "%u\n", (sig & 0x000000FF));
+}
+
+/*
+ * hfront porch change is expected to be called on live streams. Video device
+ * locking/queue check is not needed.
+ */
+static ssize_t hfront_porch_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+	if (val > 0xFF)
+		return -EINVAL;
+
+	mgb4_mask_reg(&voutdev->mgbdev->video, voutdev->config->regs.hsync,
+		      0x000000FF, val);
+
+	return count;
+}
+
+static ssize_t vfront_porch_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	u32 sig = mgb4_read_reg(&voutdev->mgbdev->video,
+				voutdev->config->regs.vsync);
+
+	return sprintf(buf, "%u\n", (sig & 0x000000FF));
+}
+
+/*
+ * vfront porch change is expected to be called on live streams. Video device
+ * locking/queue check is not needed.
+ */
+static ssize_t vfront_porch_store(struct device *dev,
+				  struct device_attribute *attr, const char *buf,
+				  size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+	if (val > 0xFF)
+		return -EINVAL;
+
+	mgb4_mask_reg(&voutdev->mgbdev->video, voutdev->config->regs.vsync,
+		      0x000000FF, val);
+
+	return count;
+}
+
+/* FPDL3 only */
+
+static ssize_t hsync_polarity_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	u32 config = mgb4_read_reg(&voutdev->mgbdev->video,
+	  voutdev->config->regs.hsync);
+
+	return sprintf(buf, "%u\n", (config & (1U << 31)) >> 31);
+}
+
+/*
+ * HSYNC polarity change is expected to be called on live streams. Video device
+ * locking/queue check is not needed.
+ */
+static ssize_t hsync_polarity_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+	if (val > 1)
+		return -EINVAL;
+
+	mgb4_mask_reg(&voutdev->mgbdev->video, voutdev->config->regs.hsync,
+		      (1U << 31), val << 31);
+
+	return count;
+}
+
+static ssize_t vsync_polarity_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	u32 config = mgb4_read_reg(&voutdev->mgbdev->video,
+	  voutdev->config->regs.vsync);
+
+	return sprintf(buf, "%u\n", (config & (1U << 31)) >> 31);
+}
+
+/*
+ * VSYNC polarity change is expected to be called on live streams. Video device
+ * locking/queue check is not needed.
+ */
+static ssize_t vsync_polarity_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+	if (val > 1)
+		return -EINVAL;
+
+	mgb4_mask_reg(&voutdev->mgbdev->video, voutdev->config->regs.vsync,
+		      (1U << 31), val << 31);
+
+	return count;
+}
+
+static ssize_t de_polarity_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	u32 config = mgb4_read_reg(&voutdev->mgbdev->video,
+	  voutdev->config->regs.vsync);
+
+	return sprintf(buf, "%u\n", (config & (1U << 30)) >> 30);
+}
+
+/*
+ * DE polarity change is expected to be called on live streams. Video device
+ * locking/queue check is not needed.
+ */
+static ssize_t de_polarity_store(struct device *dev,
+				 struct device_attribute *attr, const char *buf,
+				 size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+	if (val > 1)
+		return -EINVAL;
+
+	mgb4_mask_reg(&voutdev->mgbdev->video, voutdev->config->regs.vsync,
+		      (1U << 30), val << 30);
+
+	return count;
+}
+
+static ssize_t fpdl3_output_width_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	s32 ret;
+
+	mutex_lock(&voutdev->mgbdev->i2c_lock);
+	ret = mgb4_i2c_read_byte(&voutdev->ser, 0x5B);
+	mutex_unlock(&voutdev->mgbdev->i2c_lock);
+	if (ret < 0)
+		return -EIO;
+
+	switch ((u8)ret & 0x03) {
+	case 0:
+		return sprintf(buf, "0\n");
+	case 1:
+		return sprintf(buf, "1\n");
+	case 3:
+		return sprintf(buf, "2\n");
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * FPD-Link width change is expected to be called on live streams. Video device
+ * locking/queue check is not needed.
+ */
+static ssize_t fpdl3_output_width_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	u8 i2c_data;
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	switch (val) {
+	case 0: /* auto */
+		i2c_data = 0x00;
+		break;
+	case 1: /* single */
+		i2c_data = 0x01;
+		break;
+	case 2: /* dual */
+		i2c_data = 0x03;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_lock(&voutdev->mgbdev->i2c_lock);
+	ret = mgb4_i2c_mask_byte(&voutdev->ser, 0x5B, 0x03, i2c_data);
+	mutex_unlock(&voutdev->mgbdev->i2c_lock);
+	if (ret < 0)
+		return -EIO;
+
+	return count;
+}
+
+static ssize_t pclk_frequency_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+
+	return sprintf(buf, "%u\n", voutdev->freq);
+}
+
+static ssize_t pclk_frequency_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct video_device *vdev = to_video_device(dev);
+	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
+	unsigned long val;
+	int ret;
+	unsigned int dp;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(voutdev->vdev.lock);
+	if (vb2_is_busy(voutdev->vdev.queue)) {
+		mutex_unlock(voutdev->vdev.lock);
+		return -EBUSY;
+	}
+
+	dp = (val > 50000) ? 1 : 0;
+	voutdev->freq = mgb4_cmt_set_vout_freq(voutdev, val >> dp) << dp;
+
+	mgb4_mask_reg(&voutdev->mgbdev->video, voutdev->config->regs.config,
+		      0x10, dp << 4);
+	mutex_lock(&voutdev->mgbdev->i2c_lock);
+	ret = mgb4_i2c_mask_byte(&voutdev->ser, 0x4F, 1 << 6, ((~dp) & 1) << 6);
+	mutex_unlock(&voutdev->mgbdev->i2c_lock);
+
+	mutex_unlock(voutdev->vdev.lock);
+
+	return (ret < 0) ? -EIO : count;
+}
+
+static DEVICE_ATTR_RO(output_id);
+static DEVICE_ATTR_RW(video_source);
+static DEVICE_ATTR_RW(display_width);
+static DEVICE_ATTR_RW(display_height);
+static DEVICE_ATTR_RW(frame_rate);
+static DEVICE_ATTR_RW(hsync_polarity);
+static DEVICE_ATTR_RW(vsync_polarity);
+static DEVICE_ATTR_RW(de_polarity);
+static DEVICE_ATTR_RW(pclk_frequency);
+static DEVICE_ATTR_RW(hsync_width);
+static DEVICE_ATTR_RW(vsync_width);
+static DEVICE_ATTR_RW(hback_porch);
+static DEVICE_ATTR_RW(hfront_porch);
+static DEVICE_ATTR_RW(vback_porch);
+static DEVICE_ATTR_RW(vfront_porch);
+
+static DEVICE_ATTR_RW(fpdl3_output_width);
+
+struct attribute *mgb4_fpdl3_out_attrs[] = {
+	&dev_attr_output_id.attr,
+	&dev_attr_video_source.attr,
+	&dev_attr_display_width.attr,
+	&dev_attr_display_height.attr,
+	&dev_attr_frame_rate.attr,
+	&dev_attr_hsync_polarity.attr,
+	&dev_attr_vsync_polarity.attr,
+	&dev_attr_de_polarity.attr,
+	&dev_attr_pclk_frequency.attr,
+	&dev_attr_hsync_width.attr,
+	&dev_attr_vsync_width.attr,
+	&dev_attr_hback_porch.attr,
+	&dev_attr_hfront_porch.attr,
+	&dev_attr_vback_porch.attr,
+	&dev_attr_vfront_porch.attr,
+	&dev_attr_fpdl3_output_width.attr,
+	NULL
+};
+
+struct attribute *mgb4_gmsl_out_attrs[] = {
+	&dev_attr_output_id.attr,
+	&dev_attr_video_source.attr,
+	&dev_attr_display_width.attr,
+	&dev_attr_display_height.attr,
+	&dev_attr_frame_rate.attr,
+	NULL
+};
diff --git a/drivers/media/pci/mgb4/mgb4_sysfs_pci.c b/drivers/media/pci/mgb4/mgb4_sysfs_pci.c
new file mode 100644
index 000000000000..d26935ff956b
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_sysfs_pci.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021-2022 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ *
+ * This module handles all the sysfs info/configuration that is related to the
+ * PCI card device.
+ */
+
+#include <linux/device.h>
+#include "mgb4_core.h"
+#include "mgb4_sysfs.h"
+
+static ssize_t module_version_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct mgb4_dev *mgbdev = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", mgbdev->module_version & 0x0F);
+}
+
+static ssize_t module_type_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct mgb4_dev *mgbdev = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", mgbdev->module_version >> 4);
+}
+
+static ssize_t fw_version_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct mgb4_dev *mgbdev = dev_get_drvdata(dev);
+	u32 config = mgb4_read_reg(&mgbdev->video, 0xC4);
+
+	return sprintf(buf, "%u\n", config & 0xFFFF);
+}
+
+static ssize_t fw_type_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct mgb4_dev *mgbdev = dev_get_drvdata(dev);
+	u32 config = mgb4_read_reg(&mgbdev->video, 0xC4);
+
+	return sprintf(buf, "%u\n", config >> 24);
+}
+
+static ssize_t serial_number_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct mgb4_dev *mgbdev = dev_get_drvdata(dev);
+	u32 sn = mgbdev->serial_number;
+
+	return sprintf(buf, "%03d-%03d-%03d-%03d\n", sn >> 24, (sn >> 16) & 0xFF,
+	  (sn >> 8) & 0xFF, sn & 0xFF);
+}
+
+static DEVICE_ATTR_RO(module_version);
+static DEVICE_ATTR_RO(module_type);
+static DEVICE_ATTR_RO(fw_version);
+static DEVICE_ATTR_RO(fw_type);
+static DEVICE_ATTR_RO(serial_number);
+
+struct attribute *mgb4_pci_attrs[] = {
+	&dev_attr_module_type.attr,
+	&dev_attr_module_version.attr,
+	&dev_attr_fw_type.attr,
+	&dev_attr_fw_version.attr,
+	&dev_attr_serial_number.attr,
+	NULL
+};
diff --git a/drivers/media/pci/mgb4/mgb4_trigger.c b/drivers/media/pci/mgb4/mgb4_trigger.c
new file mode 100644
index 000000000000..923650d53d4c
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_trigger.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021-2023 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ *
+ * This module handles the IIO trigger device. The card has two signal inputs
+ * for event triggers that can be used to record events related to the video
+ * stream. A standard linux IIO device with triggered buffer capability is
+ * created and configured that can be used to fetch the events with the same
+ * clock source as the video frames.
+ */
+
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/pci.h>
+#include <linux/dma/amd_xdma.h>
+#include "mgb4_core.h"
+#include "mgb4_trigger.h"
+
+struct trigger_data {
+	struct mgb4_dev *mgbdev;
+	struct iio_trigger *trig;
+};
+
+static int trigger_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct trigger_data *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (iio_buffer_enabled(indio_dev))
+			return -EBUSY;
+		*val = mgb4_read_reg(&st->mgbdev->video, 0xA0);
+
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int trigger_set_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct trigger_data *st = iio_priv(indio_dev);
+	int irq = xdma_get_user_irq(st->mgbdev->xdev, 11);
+
+	if (state)
+		xdma_enable_user_irq(st->mgbdev->xdev, irq);
+	else
+		xdma_disable_user_irq(st->mgbdev->xdev, irq);
+
+	return 0;
+}
+
+static const struct iio_trigger_ops trigger_ops = {
+	.set_trigger_state = &trigger_set_state,
+};
+
+static const struct iio_info trigger_info = {
+	.read_raw         = trigger_read_raw,
+};
+
+#define TRIGGER_CHANNEL(_si) {                    \
+	.type = IIO_ACTIVITY,                         \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.scan_index = _si,                            \
+	.scan_type = {                                \
+		.sign = 'u',                              \
+		.realbits = 32,                           \
+		.storagebits = 32,                        \
+		.shift = 0,                               \
+		.endianness = IIO_CPU                     \
+	},                                            \
+}
+
+static const struct iio_chan_spec trigger_channels[] = {
+	TRIGGER_CHANNEL(0),
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static irqreturn_t trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct trigger_data *st = iio_priv(indio_dev);
+	struct {
+		u32 data;
+		s64 ts __aligned(8);
+	} scan;
+
+	scan.data = mgb4_read_reg(&st->mgbdev->video, 0xA0);
+	mgb4_write_reg(&st->mgbdev->video, 0xA0, scan.data);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	mgb4_write_reg(&st->mgbdev->video, 0xB4, 1U << 11);
+
+	return IRQ_HANDLED;
+}
+
+static int probe_trigger(struct iio_dev *indio_dev, int irq)
+{
+	int ret;
+	struct trigger_data *st = iio_priv(indio_dev);
+
+	st->trig = iio_trigger_alloc(&st->mgbdev->pdev->dev, "%s-dev%d",
+				     indio_dev->name, iio_device_id(indio_dev));
+	if (!st->trig)
+		return -ENOMEM;
+
+	ret = request_irq(irq, &iio_trigger_generic_data_rdy_poll, 0,
+			  "mgb4-trigger", st->trig);
+	if (ret)
+		goto error_free_trig;
+
+	st->trig->ops = &trigger_ops;
+	iio_trigger_set_drvdata(st->trig, indio_dev);
+	ret = iio_trigger_register(st->trig);
+	if (ret)
+		goto error_free_irq;
+
+	indio_dev->trig = iio_trigger_get(st->trig);
+
+	return 0;
+
+error_free_irq:
+	free_irq(irq, st->trig);
+error_free_trig:
+	iio_trigger_free(st->trig);
+
+	return ret;
+}
+
+static void remove_trigger(struct iio_dev *indio_dev, int irq)
+{
+	struct trigger_data *st = iio_priv(indio_dev);
+
+	iio_trigger_unregister(st->trig);
+	free_irq(irq, st->trig);
+	iio_trigger_free(st->trig);
+}
+
+struct iio_dev *mgb4_trigger_create(struct mgb4_dev *mgbdev)
+{
+	struct iio_dev *indio_dev;
+	struct trigger_data *data;
+	struct pci_dev *pdev = mgbdev->pdev;
+	struct device *dev = &pdev->dev;
+	int rv, irq;
+
+	indio_dev = iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return NULL;
+
+	indio_dev->info = &trigger_info;
+	indio_dev->name = "mgb4";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = trigger_channels;
+	indio_dev->num_channels = ARRAY_SIZE(trigger_channels);
+
+	data = iio_priv(indio_dev);
+	data->mgbdev = mgbdev;
+
+	irq = xdma_get_user_irq(mgbdev->xdev, 11);
+	rv = probe_trigger(indio_dev, irq);
+	if (rv < 0) {
+		dev_err(dev, "iio triggered setup failed\n");
+		goto error_alloc;
+	}
+	rv = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
+					trigger_handler, NULL);
+	if (rv < 0) {
+		dev_err(dev, "iio triggered buffer setup failed\n");
+		goto error_trigger;
+	}
+	rv = iio_device_register(indio_dev);
+	if (rv < 0) {
+		dev_err(dev, "iio device register failed\n");
+		goto error_buffer;
+	}
+
+	return indio_dev;
+
+error_buffer:
+	iio_triggered_buffer_cleanup(indio_dev);
+error_trigger:
+	remove_trigger(indio_dev, irq);
+error_alloc:
+	iio_device_free(indio_dev);
+
+	return NULL;
+}
+
+void mgb4_trigger_free(struct iio_dev *indio_dev)
+{
+	struct trigger_data *st = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+	remove_trigger(indio_dev, xdma_get_user_irq(st->mgbdev->xdev, 11));
+	iio_device_free(indio_dev);
+}
diff --git a/drivers/media/pci/mgb4/mgb4_trigger.h b/drivers/media/pci/mgb4/mgb4_trigger.h
new file mode 100644
index 000000000000..6c25bc4576f6
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_trigger.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021-2022 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ */
+
+struct iio_dev *mgb4_trigger_create(struct mgb4_dev *mgbdev);
+void mgb4_trigger_free(struct iio_dev *indio_dev);
diff --git a/drivers/media/pci/mgb4/mgb4_vin.c b/drivers/media/pci/mgb4/mgb4_vin.c
new file mode 100644
index 000000000000..d72b07b87cd1
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_vin.c
@@ -0,0 +1,939 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021-2023 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ *
+ * This is the v4l2 input device module. It initializes the signal deserializers
+ * and creates the v4l2 video devices. The input signal can change at any time
+ * which is handled by the "timings" callbacks and an IRQ based watcher, that
+ * emits the V4L2_EVENT_SOURCE_CHANGE event in case of a signal source change.
+ *
+ * When the device is in loopback mode (a direct, in HW, in->out frame passing
+ * mode) the card's frame queue must be running regardless of whether a v4l2
+ * stream is running and the output parameters like frame buffers padding must
+ * be in sync with the input parameters.
+ */
+
+#include <linux/pci.h>
+#include <linux/workqueue.h>
+#include <linux/align.h>
+#include <linux/dma/amd_xdma.h>
+#include <media/v4l2-ioctl.h>
+#include <media/videobuf2-v4l2.h>
+#include <media/videobuf2-dma-sg.h>
+#include <media/v4l2-dv-timings.h>
+#include <media/v4l2-event.h>
+#include "mgb4_core.h"
+#include "mgb4_dma.h"
+#include "mgb4_sysfs.h"
+#include "mgb4_io.h"
+#include "mgb4_vout.h"
+#include "mgb4_vin.h"
+
+ATTRIBUTE_GROUPS(mgb4_fpdl3_in);
+ATTRIBUTE_GROUPS(mgb4_gmsl_in);
+
+static const struct mgb4_vin_config vin_cfg[] = {
+	{0, 0, 0, 6, {0x10, 0x00, 0x04, 0x08, 0x1C, 0x14, 0x18, 0x20, 0x24, 0x28}},
+	{1, 1, 1, 7, {0x40, 0x30, 0x34, 0x38, 0x4C, 0x44, 0x48, 0x50, 0x54, 0x58}}
+};
+
+static const struct i2c_board_info fpdl3_deser_info[] = {
+	{I2C_BOARD_INFO("deserializer1", 0x38)},
+	{I2C_BOARD_INFO("deserializer2", 0x36)},
+};
+
+static const struct i2c_board_info gmsl_deser_info[] = {
+	{I2C_BOARD_INFO("deserializer1", 0x4C)},
+	{I2C_BOARD_INFO("deserializer2", 0x2A)},
+};
+
+static const struct mgb4_i2c_kv fpdl3_i2c[] = {
+	{0x06, 0xFF, 0x04}, {0x07, 0xFF, 0x01}, {0x45, 0xFF, 0xE8},
+	{0x49, 0xFF, 0x00}, {0x34, 0xFF, 0x00}, {0x23, 0xFF, 0x00}
+};
+
+static const struct mgb4_i2c_kv gmsl_i2c[] = {
+	{0x01, 0x03, 0x03}, {0x300, 0x0C, 0x0C}, {0x03, 0xC0, 0xC0},
+	{0x1CE, 0x0E, 0x0E}, {0x11, 0x05, 0x00}, {0x05, 0xC0, 0x40},
+	{0x307, 0x0F, 0x00}, {0xA0, 0x03, 0x00}, {0x3E0, 0x07, 0x07},
+	{0x308, 0x01, 0x01}, {0x10, 0x20, 0x20}, {0x300, 0x40, 0x40}
+};
+
+static const struct v4l2_dv_timings_cap video_timings_cap = {
+	.type = V4L2_DV_BT_656_1120,
+	.bt = {
+		.min_width = 320,
+		.max_width = 4096,
+		.min_height = 240,
+		.max_height = 2160,
+		.min_pixelclock = 1843200, /* 320 x 240 x 24Hz */
+		.max_pixelclock = 530841600, /* 4096 x 2160 x 60Hz */
+		.standards = V4L2_DV_BT_STD_CEA861 | V4L2_DV_BT_STD_DMT |
+			V4L2_DV_BT_STD_CVT | V4L2_DV_BT_STD_GTF,
+		.capabilities = V4L2_DV_BT_CAP_PROGRESSIVE |
+			V4L2_DV_BT_CAP_CUSTOM,
+	},
+};
+
+/*
+ * Returns the video output connected with the given video input if the input
+ * is in loopback mode.
+ */
+static struct mgb4_vout_dev *loopback_dev(struct mgb4_vin_dev *vindev, int i)
+{
+	struct mgb4_vout_dev *voutdev;
+	u32 config;
+
+	voutdev = vindev->mgbdev->vout[i];
+	if (!voutdev)
+		return NULL;
+
+	config = mgb4_read_reg(&voutdev->mgbdev->video,
+			       voutdev->config->regs.config);
+	if ((config & 0xc) >> 2 == vindev->config->id)
+		return voutdev;
+
+	return NULL;
+}
+
+/*
+ * Check, whether the loopback mode - a HW INPUT->OUTPUT transmission - is
+ * enabled on the given input.
+ */
+static int loopback_active(struct mgb4_vin_dev *vindev)
+{
+	int i;
+
+	for (i = 0; i < MGB4_VOUT_DEVICES; i++)
+		if (loopback_dev(vindev, i))
+			return 1;
+
+	return 0;
+}
+
+/*
+ * Set the output frame buffer padding of all outputs connected with the given
+ * input when the video input is set to loopback mode. The paddings must be
+ * the same for the loopback to work properly.
+ */
+static void set_loopback_padding(struct mgb4_vin_dev *vindev, u32 padding)
+{
+	struct mgb4_regs *video = &vindev->mgbdev->video;
+	struct mgb4_vout_dev *voutdev;
+	int i;
+
+	for (i = 0; i < MGB4_VOUT_DEVICES; i++) {
+		voutdev = loopback_dev(vindev, i);
+		if (voutdev)
+			mgb4_write_reg(video, voutdev->config->regs.padding,
+				       padding);
+	}
+}
+
+static int get_timings(struct mgb4_vin_dev *vindev,
+		       struct v4l2_dv_timings *timings)
+{
+	struct mgb4_regs *video = &vindev->mgbdev->video;
+	const struct mgb4_vin_regs *regs = &vindev->config->regs;
+
+	u32 status = mgb4_read_reg(video, regs->status);
+	u32 pclk = mgb4_read_reg(video, regs->pclk);
+	u32 signal = mgb4_read_reg(video, regs->signal);
+	u32 signal2 = mgb4_read_reg(video, regs->signal2);
+	u32 resolution = mgb4_read_reg(video, regs->resolution);
+
+	if (!(status & (1U << 2)))
+		return -ENOLCK;
+	if (!(status & (3 << 9)))
+		return -ENOLINK;
+
+	memset(timings, 0, sizeof(*timings));
+	timings->type = V4L2_DV_BT_656_1120;
+	timings->bt.width = resolution >> 16;
+	timings->bt.height = resolution & 0xFFFF;
+	if (status & (1U << 12))
+		timings->bt.polarities |= V4L2_DV_HSYNC_POS_POL;
+	if (status & (1U << 13))
+		timings->bt.polarities |= V4L2_DV_VSYNC_POS_POL;
+	timings->bt.pixelclock = pclk * 1000;
+	timings->bt.hsync = (signal & 0x00FF0000) >> 16;
+	timings->bt.vsync = (signal2 & 0x00FF0000) >> 16;
+	timings->bt.hbackporch = (signal & 0x0000FF00) >> 8;
+	timings->bt.hfrontporch = signal & 0x000000FF;
+	timings->bt.vbackporch = (signal2 & 0x0000FF00) >> 8;
+	timings->bt.vfrontporch = signal2 & 0x000000FF;
+
+	return 0;
+}
+
+static void return_all_buffers(struct mgb4_vin_dev *vindev,
+			       enum vb2_buffer_state state)
+{
+	struct mgb4_frame_buffer *buf, *node;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vindev->qlock, flags);
+	list_for_each_entry_safe(buf, node, &vindev->buf_list, list) {
+		vb2_buffer_done(&buf->vb.vb2_buf, state);
+		list_del(&buf->list);
+	}
+	spin_unlock_irqrestore(&vindev->qlock, flags);
+}
+
+static int queue_setup(struct vb2_queue *q, unsigned int *nbuffers,
+		       unsigned int *nplanes, unsigned int sizes[],
+		       struct device *alloc_devs[])
+{
+	struct mgb4_vin_dev *vindev = vb2_get_drv_priv(q);
+	unsigned int size = (vindev->timings.bt.width + vindev->padding)
+	 * vindev->timings.bt.height * 4;
+
+	/*
+	 * If I/O reconfiguration is in process, do not allow to start
+	 * the queue. See video_source_store() in mgb4_sysfs_out.c for
+	 * details.
+	 */
+	if (test_bit(0, &vindev->mgbdev->io_reconfig))
+		return -EBUSY;
+
+	if (!size)
+		return -EINVAL;
+	if (*nplanes)
+		return sizes[0] < size ? -EINVAL : 0;
+	*nplanes = 1;
+	sizes[0] = size;
+
+	return 0;
+}
+
+static int buffer_init(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct mgb4_frame_buffer *buf = to_frame_buffer(vbuf);
+
+	INIT_LIST_HEAD(&buf->list);
+
+	return 0;
+}
+
+static int buffer_prepare(struct vb2_buffer *vb)
+{
+	struct mgb4_vin_dev *vindev = vb2_get_drv_priv(vb->vb2_queue);
+	struct device *dev = &vindev->mgbdev->pdev->dev;
+	unsigned int size = (vindev->timings.bt.width + vindev->padding)
+	 * vindev->timings.bt.height * 4;
+
+	if (vb2_plane_size(vb, 0) < size) {
+		dev_err(dev, "buffer too small (%lu < %u)\n",
+			vb2_plane_size(vb, 0), size);
+		return -EINVAL;
+	}
+
+	vb2_set_plane_payload(vb, 0, size);
+
+	return 0;
+}
+
+static void buffer_queue(struct vb2_buffer *vb)
+{
+	struct mgb4_vin_dev *vindev = vb2_get_drv_priv(vb->vb2_queue);
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct mgb4_frame_buffer *buf = to_frame_buffer(vbuf);
+	unsigned long flags;
+
+	spin_lock_irqsave(&vindev->qlock, flags);
+	list_add_tail(&buf->list, &vindev->buf_list);
+	spin_unlock_irqrestore(&vindev->qlock, flags);
+}
+
+static void stop_streaming(struct vb2_queue *vq)
+{
+	struct mgb4_vin_dev *vindev = vb2_get_drv_priv(vq);
+	const struct mgb4_vin_config *config = vindev->config;
+	int irq = xdma_get_user_irq(vindev->mgbdev->xdev, config->vin_irq);
+
+	xdma_disable_user_irq(vindev->mgbdev->xdev, irq);
+
+	/*
+	 * In loopback mode, the HW frame queue must be left running for
+	 * the IN->OUT transmission to work!
+	 */
+	if (!loopback_active(vindev))
+		mgb4_mask_reg(&vindev->mgbdev->video, config->regs.config, 0x2,
+			      0x0);
+
+	cancel_work_sync(&vindev->dma_work);
+	return_all_buffers(vindev, VB2_BUF_STATE_ERROR);
+}
+
+static int start_streaming(struct vb2_queue *vq, unsigned int count)
+{
+	struct mgb4_vin_dev *vindev = vb2_get_drv_priv(vq);
+	const struct mgb4_vin_config *config = vindev->config;
+	int irq = xdma_get_user_irq(vindev->mgbdev->xdev, config->vin_irq);
+
+	vindev->sequence = 0;
+
+	/*
+	 * In loopback mode, the HW frame queue is already running.
+	 */
+	if (!loopback_active(vindev))
+		mgb4_mask_reg(&vindev->mgbdev->video, config->regs.config, 0x2,
+			      0x2);
+
+	xdma_enable_user_irq(vindev->mgbdev->xdev, irq);
+
+	return 0;
+}
+
+static const struct vb2_ops queue_ops = {
+	.queue_setup = queue_setup,
+	.buf_init = buffer_init,
+	.buf_prepare = buffer_prepare,
+	.buf_queue = buffer_queue,
+	.start_streaming = start_streaming,
+	.stop_streaming = stop_streaming,
+	.wait_prepare = vb2_ops_wait_prepare,
+	.wait_finish = vb2_ops_wait_finish
+};
+
+static int fh_open(struct file *file)
+{
+	struct mgb4_vin_dev *vindev = video_drvdata(file);
+	int rv;
+
+	mutex_lock(&vindev->lock);
+
+	rv = v4l2_fh_open(file);
+	if (rv)
+		goto out;
+
+	if (!v4l2_fh_is_singular_file(file))
+		goto out;
+
+	get_timings(vindev, &vindev->timings);
+	set_loopback_padding(vindev, vindev->padding);
+
+out:
+	mutex_unlock(&vindev->lock);
+	return rv;
+}
+
+static int fh_release(struct file *file)
+{
+	struct mgb4_vin_dev *vindev = video_drvdata(file);
+	int rv;
+
+	mutex_lock(&vindev->lock);
+
+	if (v4l2_fh_is_singular_file(file))
+		set_loopback_padding(vindev, 0);
+
+	rv = _vb2_fop_release(file, NULL);
+
+	mutex_unlock(&vindev->lock);
+
+	return rv;
+}
+
+static const struct v4l2_file_operations video_fops = {
+	.owner = THIS_MODULE,
+	.open = fh_open,
+	.release = fh_release,
+	.unlocked_ioctl = video_ioctl2,
+	.read = vb2_fop_read,
+	.mmap = vb2_fop_mmap,
+	.poll = vb2_fop_poll,
+};
+
+static int vidioc_querycap(struct file *file, void *priv,
+			   struct v4l2_capability *cap)
+{
+	strscpy(cap->driver, KBUILD_MODNAME, sizeof(cap->driver));
+	strscpy(cap->card, "MGB4 PCIe Card", sizeof(cap->card));
+
+	return 0;
+}
+
+static int vidioc_enum_fmt(struct file *file, void *priv,
+			   struct v4l2_fmtdesc *f)
+{
+	if (f->index != 0)
+		return -EINVAL;
+
+	f->pixelformat = V4L2_PIX_FMT_ABGR32;
+
+	return 0;
+}
+
+static int vidioc_enum_frameintervals(struct file *file, void *priv,
+				      struct v4l2_frmivalenum *ival)
+{
+	struct mgb4_vin_dev *vindev = video_drvdata(file);
+
+	if (ival->index != 0)
+		return -EINVAL;
+	if (ival->pixel_format != V4L2_PIX_FMT_ABGR32)
+		return -EINVAL;
+	if (ival->width != vindev->timings.bt.width ||
+	    ival->height != vindev->timings.bt.height)
+		return -EINVAL;
+
+	ival->type = V4L2_FRMIVAL_TYPE_CONTINUOUS;
+	ival->stepwise.min.denominator = 60;
+	ival->stepwise.min.numerator = 1;
+	ival->stepwise.max.denominator = 1;
+	ival->stepwise.max.numerator = 1;
+	ival->stepwise.step = ival->stepwise.max;
+
+	return 0;
+}
+
+static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct mgb4_vin_dev *vindev = video_drvdata(file);
+
+	f->fmt.pix.pixelformat = V4L2_PIX_FMT_ABGR32;
+	f->fmt.pix.width = vindev->timings.bt.width;
+	f->fmt.pix.height = vindev->timings.bt.height;
+	f->fmt.pix.field = V4L2_FIELD_NONE;
+	f->fmt.pix.colorspace = V4L2_COLORSPACE_RAW;
+	f->fmt.pix.bytesperline = (f->fmt.pix.width + vindev->padding) * 4;
+	f->fmt.pix.sizeimage = f->fmt.pix.bytesperline * f->fmt.pix.height;
+
+	return 0;
+}
+
+static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct mgb4_vin_dev *vindev = video_drvdata(file);
+
+	f->fmt.pix.pixelformat = V4L2_PIX_FMT_ABGR32;
+	f->fmt.pix.width = vindev->timings.bt.width;
+	f->fmt.pix.height = vindev->timings.bt.height;
+	f->fmt.pix.field = V4L2_FIELD_NONE;
+	f->fmt.pix.colorspace = V4L2_COLORSPACE_RAW;
+	f->fmt.pix.bytesperline = max(f->fmt.pix.width * 4,
+				      ALIGN_DOWN(f->fmt.pix.bytesperline, 4));
+	f->fmt.pix.sizeimage = f->fmt.pix.bytesperline * f->fmt.pix.height;
+
+	return 0;
+}
+
+static int vidioc_s_fmt(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct mgb4_vin_dev *vindev = video_drvdata(file);
+	struct mgb4_regs *video = &vindev->mgbdev->video;
+
+	if (vb2_is_busy(&vindev->queue))
+		return -EBUSY;
+
+	vidioc_try_fmt(file, priv, f);
+
+	vindev->padding = (f->fmt.pix.bytesperline - (f->fmt.pix.width * 4)) / 4;
+	mgb4_write_reg(video, vindev->config->regs.padding, vindev->padding);
+	set_loopback_padding(vindev, vindev->padding);
+
+	return 0;
+}
+
+static int vidioc_enum_input(struct file *file, void *priv,
+			     struct v4l2_input *i)
+{
+	struct mgb4_vin_dev *vindev = video_drvdata(file);
+	struct mgb4_regs *video = &vindev->mgbdev->video;
+	u32 status;
+
+	if (i->index != 0)
+		return -EINVAL;
+
+	strscpy(i->name, "MGB4", sizeof(i->name));
+	i->type = V4L2_INPUT_TYPE_CAMERA;
+	i->capabilities = V4L2_IN_CAP_DV_TIMINGS;
+	i->status = 0;
+
+	status = mgb4_read_reg(video, vindev->config->regs.status);
+	if (!(status & (1U << 2)))
+		i->status |= V4L2_IN_ST_NO_SYNC;
+	if (!(status & (3 << 9)))
+		i->status |= V4L2_IN_ST_NO_SIGNAL;
+
+	return 0;
+}
+
+static int vidioc_enum_framesizes(struct file *file, void *fh,
+				  struct v4l2_frmsizeenum *fsize)
+{
+	struct mgb4_vin_dev *vindev = video_drvdata(file);
+
+	if (fsize->index != 0 || fsize->pixel_format != V4L2_PIX_FMT_ABGR32)
+		return -EINVAL;
+
+	fsize->discrete.width = vindev->timings.bt.width;
+	fsize->discrete.height = vindev->timings.bt.height;
+	fsize->type = V4L2_FRMSIZE_TYPE_DISCRETE;
+
+	return 0;
+}
+
+static int vidioc_s_input(struct file *file, void *priv, unsigned int i)
+{
+	return (i == 0) ? 0 : -EINVAL;
+}
+
+static int vidioc_g_input(struct file *file, void *priv, unsigned int *i)
+{
+	*i = 0;
+	return 0;
+}
+
+static int vidioc_parm(struct file *file, void *priv,
+		       struct v4l2_streamparm *parm)
+{
+	struct mgb4_vin_dev *vindev = video_drvdata(file);
+	struct mgb4_regs *video = &vindev->mgbdev->video;
+	const struct mgb4_vin_regs *regs = &vindev->config->regs;
+	struct v4l2_fract timeperframe = {
+		.numerator = mgb4_read_reg(video, regs->frame_period),
+		.denominator = 125000000,
+	};
+
+	if (parm->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
+
+	parm->parm.capture.readbuffers = 2;
+	parm->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
+	parm->parm.capture.timeperframe = timeperframe;
+
+	return 0;
+}
+
+static int vidioc_s_dv_timings(struct file *file, void *fh,
+			       struct v4l2_dv_timings *timings)
+{
+	struct mgb4_vin_dev *vindev = video_drvdata(file);
+
+	if (timings->bt.width < video_timings_cap.bt.min_width ||
+	    timings->bt.width > video_timings_cap.bt.max_width ||
+	    timings->bt.height < video_timings_cap.bt.min_height ||
+	    timings->bt.height > video_timings_cap.bt.max_height)
+		return -EINVAL;
+	if (timings->bt.width == vindev->timings.bt.width &&
+	    timings->bt.height == vindev->timings.bt.height)
+		return 0;
+	if (vb2_is_busy(&vindev->queue))
+		return -EBUSY;
+
+	vindev->timings = *timings;
+
+	return 0;
+}
+
+static int vidioc_g_dv_timings(struct file *file, void *fh,
+			       struct v4l2_dv_timings *timings)
+{
+	struct mgb4_vin_dev *vindev = video_drvdata(file);
+	*timings = vindev->timings;
+
+	return 0;
+}
+
+static int vidioc_query_dv_timings(struct file *file, void *fh,
+				   struct v4l2_dv_timings *timings)
+{
+	struct mgb4_vin_dev *vindev = video_drvdata(file);
+
+	return get_timings(vindev, timings);
+}
+
+static int vidioc_enum_dv_timings(struct file *file, void *fh,
+				  struct v4l2_enum_dv_timings *timings)
+{
+	return v4l2_enum_dv_timings_cap(timings, &video_timings_cap, NULL, NULL);
+}
+
+static int vidioc_dv_timings_cap(struct file *file, void *fh,
+				 struct v4l2_dv_timings_cap *cap)
+{
+	*cap = video_timings_cap;
+
+	return 0;
+}
+
+static int vidioc_subscribe_event(struct v4l2_fh *fh,
+				  const struct v4l2_event_subscription *sub)
+{
+	switch (sub->type) {
+	case V4L2_EVENT_SOURCE_CHANGE:
+		return v4l2_src_change_event_subscribe(fh, sub);
+	}
+
+	return v4l2_ctrl_subscribe_event(fh, sub);
+}
+
+static const struct v4l2_ioctl_ops video_ioctl_ops = {
+	.vidioc_querycap = vidioc_querycap,
+	.vidioc_enum_fmt_vid_cap = vidioc_enum_fmt,
+	.vidioc_try_fmt_vid_cap = vidioc_try_fmt,
+	.vidioc_s_fmt_vid_cap = vidioc_s_fmt,
+	.vidioc_g_fmt_vid_cap = vidioc_g_fmt,
+	.vidioc_enum_framesizes = vidioc_enum_framesizes,
+	.vidioc_enum_frameintervals = vidioc_enum_frameintervals,
+	.vidioc_enum_input = vidioc_enum_input,
+	.vidioc_g_input = vidioc_g_input,
+	.vidioc_s_input = vidioc_s_input,
+	.vidioc_reqbufs = vb2_ioctl_reqbufs,
+	.vidioc_create_bufs = vb2_ioctl_create_bufs,
+	.vidioc_prepare_buf = vb2_ioctl_prepare_buf,
+	.vidioc_querybuf = vb2_ioctl_querybuf,
+	.vidioc_qbuf = vb2_ioctl_qbuf,
+	.vidioc_dqbuf = vb2_ioctl_dqbuf,
+	.vidioc_expbuf = vb2_ioctl_expbuf,
+	.vidioc_streamon = vb2_ioctl_streamon,
+	.vidioc_streamoff = vb2_ioctl_streamoff,
+	.vidioc_g_parm = vidioc_parm,
+	.vidioc_s_parm = vidioc_parm,
+	.vidioc_dv_timings_cap = vidioc_dv_timings_cap,
+	.vidioc_enum_dv_timings = vidioc_enum_dv_timings,
+	.vidioc_g_dv_timings = vidioc_g_dv_timings,
+	.vidioc_s_dv_timings = vidioc_s_dv_timings,
+	.vidioc_query_dv_timings = vidioc_query_dv_timings,
+	.vidioc_subscribe_event = vidioc_subscribe_event,
+	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
+};
+
+static void dma_transfer(struct work_struct *work)
+{
+	struct mgb4_vin_dev *vindev = container_of(work, struct mgb4_vin_dev,
+						   dma_work);
+	struct mgb4_regs *video = &vindev->mgbdev->video;
+	struct device *dev = &vindev->mgbdev->pdev->dev;
+	struct mgb4_frame_buffer *buf = NULL;
+	unsigned long flags;
+	u32 addr;
+	int rv;
+
+	spin_lock_irqsave(&vindev->qlock, flags);
+	if (!list_empty(&vindev->buf_list)) {
+		buf = list_first_entry(&vindev->buf_list,
+				       struct mgb4_frame_buffer, list);
+		list_del_init(vindev->buf_list.next);
+	}
+	spin_unlock_irqrestore(&vindev->qlock, flags);
+
+	if (!buf)
+		return;
+
+	addr = mgb4_read_reg(video, vindev->config->regs.address);
+	if (addr >= MGB4_ERR_QUEUE_FULL) {
+		dev_dbg(dev, "frame queue error (%d)\n", (int)addr);
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+		return;
+	}
+
+	rv = mgb4_dma_transfer(vindev->mgbdev, vindev->config->dma_channel,
+			       false, addr,
+			       vb2_dma_sg_plane_desc(&buf->vb.vb2_buf, 0));
+	if (rv < 0) {
+		dev_warn(dev, "DMA transfer error\n");
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+	} else {
+		buf->vb.vb2_buf.timestamp = ktime_get_ns();
+		buf->vb.sequence = vindev->sequence++;
+		buf->vb.field = V4L2_FIELD_NONE;
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
+	}
+}
+
+static void signal_change(struct work_struct *work)
+{
+	struct mgb4_vin_dev *vindev = container_of(work, struct mgb4_vin_dev,
+						   err_work);
+	struct mgb4_regs *video = &vindev->mgbdev->video;
+	struct v4l2_bt_timings *timings = &vindev->timings.bt;
+	struct device *dev = &vindev->mgbdev->pdev->dev;
+
+	u32 resolution = mgb4_read_reg(video, vindev->config->regs.resolution);
+	u32 width = resolution >> 16;
+	u32 height = resolution & 0xFFFF;
+
+	if (timings->width != width || timings->height != height) {
+		static const struct v4l2_event ev = {
+			.type = V4L2_EVENT_SOURCE_CHANGE,
+			.u.src_change.changes = V4L2_EVENT_SRC_CH_RESOLUTION,
+		};
+
+		v4l2_event_queue(&vindev->vdev, &ev);
+
+		if (vb2_is_streaming(&vindev->queue))
+			vb2_queue_error(&vindev->queue);
+	}
+
+	dev_dbg(dev, "stream changed to %ux%u\n", width, height);
+}
+
+static irqreturn_t vin_handler(int irq, void *ctx)
+{
+	struct mgb4_vin_dev *vindev = (struct mgb4_vin_dev *)ctx;
+	struct mgb4_regs *video = &vindev->mgbdev->video;
+
+	schedule_work(&vindev->dma_work);
+
+	mgb4_write_reg(video, 0xB4, 1U << vindev->config->vin_irq);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t err_handler(int irq, void *ctx)
+{
+	struct mgb4_vin_dev *vindev = (struct mgb4_vin_dev *)ctx;
+	struct mgb4_regs *video = &vindev->mgbdev->video;
+
+	schedule_work(&vindev->err_work);
+
+	mgb4_write_reg(video, 0xB4, 1U << vindev->config->err_irq);
+
+	return IRQ_HANDLED;
+}
+
+static int deser_init(struct mgb4_vin_dev *vindev, int id)
+{
+	int rv, addr_size;
+	size_t values_count;
+	const struct mgb4_i2c_kv *values;
+	const struct i2c_board_info *info;
+	struct device *dev = &vindev->mgbdev->pdev->dev;
+
+	if (MGB4_IS_GMSL(vindev->mgbdev)) {
+		info = &gmsl_deser_info[id];
+		addr_size = 16;
+		values = gmsl_i2c;
+		values_count = ARRAY_SIZE(gmsl_i2c);
+	} else {
+		info = &fpdl3_deser_info[id];
+		addr_size = 8;
+		values = fpdl3_i2c;
+		values_count = ARRAY_SIZE(fpdl3_i2c);
+	}
+
+	rv = mgb4_i2c_init(&vindev->deser, vindev->mgbdev->i2c_adap, info,
+			   addr_size);
+	if (rv < 0) {
+		dev_err(dev, "failed to create deserializer\n");
+		return rv;
+	}
+	rv = mgb4_i2c_configure(&vindev->deser, values, values_count);
+	if (rv < 0) {
+		dev_err(dev, "failed to configure deserializer\n");
+		goto err_i2c_dev;
+	}
+
+	return 0;
+
+err_i2c_dev:
+	mgb4_i2c_free(&vindev->deser);
+
+	return rv;
+}
+
+static void fpga_init(struct mgb4_vin_dev *vindev)
+{
+	struct mgb4_regs *video = &vindev->mgbdev->video;
+	const struct mgb4_vin_regs *regs = &vindev->config->regs;
+
+	mgb4_write_reg(video, regs->config, 0x00000001);
+	mgb4_write_reg(video, regs->sync, 0x03E80002);
+	mgb4_write_reg(video, regs->padding, 0x00000000);
+	mgb4_write_reg(video, regs->config, 1U << 9);
+}
+
+#ifdef CONFIG_DEBUG_FS
+static void debugfs_init(struct mgb4_vin_dev *vindev)
+{
+	struct mgb4_regs *video = &vindev->mgbdev->video;
+
+	vindev->debugfs = debugfs_create_dir(vindev->vdev.name,
+					     vindev->mgbdev->debugfs);
+	if (!vindev->debugfs)
+		return;
+
+	vindev->regs[0].name = "CONFIG";
+	vindev->regs[0].offset = vindev->config->regs.config;
+	vindev->regs[1].name = "STATUS";
+	vindev->regs[1].offset = vindev->config->regs.status;
+	vindev->regs[2].name = "RESOLUTION";
+	vindev->regs[2].offset = vindev->config->regs.resolution;
+	vindev->regs[3].name = "FRAME_PERIOD";
+	vindev->regs[3].offset = vindev->config->regs.frame_period;
+	vindev->regs[4].name = "HS_VS_GENER_SETTINGS";
+	vindev->regs[4].offset = vindev->config->regs.sync;
+	vindev->regs[5].name = "PCLK_FREQUENCY";
+	vindev->regs[5].offset = vindev->config->regs.pclk;
+	vindev->regs[6].name = "VIDEO_PARAMS_1";
+	vindev->regs[6].offset = vindev->config->regs.signal;
+	vindev->regs[7].name = "VIDEO_PARAMS_2";
+	vindev->regs[7].offset = vindev->config->regs.signal2;
+	vindev->regs[8].name = "PADDING_PIXELS";
+	vindev->regs[8].offset = vindev->config->regs.padding;
+
+	vindev->regset.base = video->membase;
+	vindev->regset.regs = vindev->regs;
+	vindev->regset.nregs = ARRAY_SIZE(vindev->regs);
+
+	debugfs_create_regset32("registers", 0444, vindev->debugfs,
+				&vindev->regset);
+}
+#endif
+
+struct mgb4_vin_dev *mgb4_vin_create(struct mgb4_dev *mgbdev, int id)
+{
+	int rv;
+	const struct attribute_group **groups;
+	struct mgb4_vin_dev *vindev;
+	struct pci_dev *pdev = mgbdev->pdev;
+	struct device *dev = &pdev->dev;
+	int vin_irq, err_irq;
+
+	vindev = kzalloc(sizeof(*vindev), GFP_KERNEL);
+	if (!vindev)
+		return NULL;
+
+	vindev->mgbdev = mgbdev;
+	vindev->config = &vin_cfg[id];
+
+	/* Frame queue*/
+	INIT_LIST_HEAD(&vindev->buf_list);
+	spin_lock_init(&vindev->qlock);
+
+	/* Work queues */
+	INIT_WORK(&vindev->dma_work, dma_transfer);
+	INIT_WORK(&vindev->err_work, signal_change);
+
+	/* IRQ callback */
+	vin_irq = xdma_get_user_irq(mgbdev->xdev, vindev->config->vin_irq);
+	rv = request_irq(vin_irq, vin_handler, 0, "mgb4-vin", vindev);
+	if (rv) {
+		dev_err(dev, "failed to register vin irq handler\n");
+		goto err_alloc;
+	}
+	/* Error IRQ callback */
+	err_irq = xdma_get_user_irq(mgbdev->xdev, vindev->config->err_irq);
+	rv = request_irq(err_irq, err_handler, 0, "mgb4-err", vindev);
+	if (rv) {
+		dev_err(dev, "failed to register err irq handler\n");
+		goto err_vin_irq;
+	}
+
+	/* Set the FPGA registers default values */
+	fpga_init(vindev);
+
+	/* Set the deserializer default values */
+	rv = deser_init(vindev, id);
+	if (rv)
+		goto err_err_irq;
+
+	/* V4L2 stuff init */
+	rv = v4l2_device_register(dev, &vindev->v4l2dev);
+	if (rv) {
+		dev_err(dev, "failed to register v4l2 device\n");
+		goto err_err_irq;
+	}
+
+	mutex_init(&vindev->lock);
+
+	vindev->queue.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+	vindev->queue.io_modes = VB2_MMAP | VB2_DMABUF | VB2_READ;
+	vindev->queue.buf_struct_size = sizeof(struct mgb4_frame_buffer);
+	vindev->queue.ops = &queue_ops;
+	vindev->queue.mem_ops = &vb2_dma_sg_memops;
+	vindev->queue.gfp_flags = GFP_DMA32;
+	vindev->queue.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	vindev->queue.min_buffers_needed = 2;
+	vindev->queue.drv_priv = vindev;
+	vindev->queue.lock = &vindev->lock;
+	vindev->queue.dev = dev;
+	rv = vb2_queue_init(&vindev->queue);
+	if (rv) {
+		dev_err(dev, "failed to initialize vb2 queue\n");
+		goto err_v4l2_dev;
+	}
+
+	snprintf(vindev->vdev.name, sizeof(vindev->vdev.name), "mgb4-in%d",
+		 id + 1);
+	vindev->vdev.device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_READWRITE
+	  | V4L2_CAP_STREAMING;
+	vindev->vdev.fops = &video_fops;
+	vindev->vdev.ioctl_ops = &video_ioctl_ops;
+	vindev->vdev.release = video_device_release_empty;
+	vindev->vdev.v4l2_dev = &vindev->v4l2dev;
+	vindev->vdev.lock = &vindev->lock;
+	vindev->vdev.queue = &vindev->queue;
+	video_set_drvdata(&vindev->vdev, vindev);
+
+	/* Enable the video signal change watcher */
+	xdma_enable_user_irq(vindev->mgbdev->xdev, err_irq);
+
+	/* Register the video device */
+	rv = video_register_device(&vindev->vdev, VFL_TYPE_VIDEO, -1);
+	if (rv) {
+		dev_err(dev, "failed to register video device\n");
+		goto err_v4l2_dev;
+	}
+
+	/* Module sysfs attributes */
+	groups = MGB4_IS_GMSL(mgbdev)
+	  ? mgb4_gmsl_in_groups : mgb4_fpdl3_in_groups;
+	rv = device_add_groups(&vindev->vdev.dev, groups);
+	if (rv) {
+		dev_err(dev, "failed to create sysfs attributes\n");
+		goto err_video_dev;
+	}
+
+#ifdef CONFIG_DEBUG_FS
+	debugfs_init(vindev);
+#endif
+
+	return vindev;
+
+err_video_dev:
+	video_unregister_device(&vindev->vdev);
+err_v4l2_dev:
+	v4l2_device_unregister(&vindev->v4l2dev);
+err_err_irq:
+	free_irq(err_irq, vindev);
+err_vin_irq:
+	free_irq(vin_irq, vindev);
+err_alloc:
+	kfree(vindev);
+
+	return NULL;
+}
+
+void mgb4_vin_free(struct mgb4_vin_dev *vindev)
+{
+	const struct attribute_group **groups;
+	int vin_irq = xdma_get_user_irq(vindev->mgbdev->xdev,
+					vindev->config->vin_irq);
+	int err_irq = xdma_get_user_irq(vindev->mgbdev->xdev,
+					vindev->config->err_irq);
+
+	xdma_disable_user_irq(vindev->mgbdev->xdev, err_irq);
+
+	free_irq(vin_irq, vindev);
+	free_irq(err_irq, vindev);
+
+#ifdef CONFIG_DEBUG_FS
+	debugfs_remove_recursive(vindev->debugfs);
+#endif
+
+	groups = MGB4_IS_GMSL(vindev->mgbdev)
+	  ? mgb4_gmsl_in_groups : mgb4_fpdl3_in_groups;
+	device_remove_groups(&vindev->vdev.dev, groups);
+
+	mgb4_i2c_free(&vindev->deser);
+	video_unregister_device(&vindev->vdev);
+	v4l2_device_unregister(&vindev->v4l2dev);
+
+	kfree(vindev);
+}
diff --git a/drivers/media/pci/mgb4/mgb4_vin.h b/drivers/media/pci/mgb4/mgb4_vin.h
new file mode 100644
index 000000000000..0249b400ad4d
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_vin.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021-2023 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ */
+
+#ifndef __MGB4_VIN_H__
+#define __MGB4_VIN_H__
+
+#include <media/v4l2-device.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-ctrls.h>
+#include <media/videobuf2-core.h>
+#include <linux/debugfs.h>
+#include "mgb4_i2c.h"
+
+struct mgb4_vin_regs {
+	u32 address;
+	u32 config;
+	u32 status;
+	u32 resolution;
+	u32 frame_period;
+	u32 sync;
+	u32 pclk;
+	u32 signal;
+	u32 signal2;
+	u32 padding;
+};
+
+struct mgb4_vin_config {
+	int id;
+	int dma_channel;
+	int vin_irq;
+	int err_irq;
+	struct mgb4_vin_regs regs;
+};
+
+struct mgb4_vin_dev {
+	struct mgb4_dev *mgbdev;
+	struct v4l2_device v4l2dev;
+	struct video_device vdev;
+	struct vb2_queue queue;
+	struct mutex lock; /* vdev lock */
+
+	spinlock_t qlock; /* video buffer queue lock */
+	struct list_head buf_list;
+	struct work_struct dma_work, err_work;
+
+	unsigned int sequence;
+
+	struct v4l2_dv_timings timings;
+	u32 freq_range;
+	u32 padding;
+
+	struct mgb4_i2c_client deser;
+
+	const struct mgb4_vin_config *config;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs;
+	struct debugfs_regset32 regset;
+	struct debugfs_reg32 regs[9];
+#endif
+};
+
+struct mgb4_vin_dev *mgb4_vin_create(struct mgb4_dev *mgbdev, int id);
+void mgb4_vin_free(struct mgb4_vin_dev *vindev);
+
+#endif
diff --git a/drivers/media/pci/mgb4/mgb4_vout.c b/drivers/media/pci/mgb4/mgb4_vout.c
new file mode 100644
index 000000000000..857fc7bbd21a
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_vout.c
@@ -0,0 +1,602 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021-2023 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ *
+ * This is the v4l2 output device module. It initializes the signal serializers
+ * and creates the v4l2 video devices.
+ *
+ * When the device is in loopback mode (a direct, in HW, in->out frame passing
+ * mode) we disable the v4l2 output by returning EBUSY in the open() syscall.
+ */
+
+#include <linux/pci.h>
+#include <linux/align.h>
+#include <linux/dma/amd_xdma.h>
+#include <media/v4l2-ioctl.h>
+#include <media/videobuf2-v4l2.h>
+#include <media/videobuf2-dma-sg.h>
+#include "mgb4_core.h"
+#include "mgb4_dma.h"
+#include "mgb4_sysfs.h"
+#include "mgb4_io.h"
+#include "mgb4_cmt.h"
+#include "mgb4_vout.h"
+
+ATTRIBUTE_GROUPS(mgb4_fpdl3_out);
+ATTRIBUTE_GROUPS(mgb4_gmsl_out);
+
+static const struct mgb4_vout_config vout_cfg[] = {
+	{0, 0, 8, {0x78, 0x60, 0x64, 0x68, 0x74, 0x6C, 0x70, 0x7c}},
+	{1, 1, 9, {0x98, 0x80, 0x84, 0x88, 0x94, 0x8c, 0x90, 0x9c}}
+};
+
+static const struct i2c_board_info fpdl3_ser_info[] = {
+	{I2C_BOARD_INFO("serializer1", 0x14)},
+	{I2C_BOARD_INFO("serializer2", 0x16)},
+};
+
+static const struct mgb4_i2c_kv fpdl3_i2c[] = {
+	{0x05, 0xFF, 0x04}, {0x06, 0xFF, 0x01}, {0xC2, 0xFF, 0x80}
+};
+
+static void return_all_buffers(struct mgb4_vout_dev *voutdev,
+			       enum vb2_buffer_state state)
+{
+	struct mgb4_frame_buffer *buf, *node;
+	unsigned long flags;
+
+	spin_lock_irqsave(&voutdev->qlock, flags);
+	list_for_each_entry_safe(buf, node, &voutdev->buf_list, list) {
+		vb2_buffer_done(&buf->vb.vb2_buf, state);
+		list_del(&buf->list);
+	}
+	spin_unlock_irqrestore(&voutdev->qlock, flags);
+}
+
+static int queue_setup(struct vb2_queue *q, unsigned int *nbuffers,
+		       unsigned int *nplanes, unsigned int sizes[],
+		       struct device *alloc_devs[])
+{
+	struct mgb4_vout_dev *voutdev = vb2_get_drv_priv(q);
+	unsigned int size;
+
+	/*
+	 * If I/O reconfiguration is in process, do not allow to start
+	 * the queue. See video_source_store() in mgb4_sysfs_out.c for
+	 * details.
+	 */
+	if (test_bit(0, &voutdev->mgbdev->io_reconfig))
+		return -EBUSY;
+
+	size = (voutdev->width + voutdev->padding) * voutdev->height * 4;
+
+	if (*nplanes)
+		return sizes[0] < size ? -EINVAL : 0;
+	*nplanes = 1;
+	sizes[0] = size;
+
+	return 0;
+}
+
+static int buffer_init(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct mgb4_frame_buffer *buf = to_frame_buffer(vbuf);
+
+	INIT_LIST_HEAD(&buf->list);
+
+	return 0;
+}
+
+static int buffer_prepare(struct vb2_buffer *vb)
+{
+	struct mgb4_vout_dev *voutdev = vb2_get_drv_priv(vb->vb2_queue);
+	struct device *dev = &voutdev->mgbdev->pdev->dev;
+	unsigned int size;
+
+	size = (voutdev->width + voutdev->padding) * voutdev->height * 4;
+
+	if (vb2_plane_size(vb, 0) < size) {
+		dev_err(dev, "buffer too small (%lu < %u)\n",
+			vb2_plane_size(vb, 0), size);
+		return -EINVAL;
+	}
+
+	vb2_set_plane_payload(vb, 0, size);
+
+	return 0;
+}
+
+static void buffer_queue(struct vb2_buffer *vb)
+{
+	struct mgb4_vout_dev *vindev = vb2_get_drv_priv(vb->vb2_queue);
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct mgb4_frame_buffer *buf = to_frame_buffer(vbuf);
+	unsigned long flags;
+
+	spin_lock_irqsave(&vindev->qlock, flags);
+	list_add_tail(&buf->list, &vindev->buf_list);
+	spin_unlock_irqrestore(&vindev->qlock, flags);
+}
+
+static void stop_streaming(struct vb2_queue *vq)
+{
+	struct mgb4_vout_dev *voutdev = vb2_get_drv_priv(vq);
+	struct mgb4_dev *mgbdev = voutdev->mgbdev;
+	int irq = xdma_get_user_irq(mgbdev->xdev, voutdev->config->irq);
+
+	xdma_disable_user_irq(mgbdev->xdev, irq);
+	cancel_work_sync(&voutdev->dma_work);
+	mgb4_mask_reg(&mgbdev->video, voutdev->config->regs.config, 0x2, 0x0);
+	return_all_buffers(voutdev, VB2_BUF_STATE_ERROR);
+}
+
+static int start_streaming(struct vb2_queue *vq, unsigned int count)
+{
+	struct mgb4_vout_dev *voutdev = vb2_get_drv_priv(vq);
+	struct mgb4_dev *mgbdev = voutdev->mgbdev;
+	struct device *dev = &mgbdev->pdev->dev;
+	struct mgb4_frame_buffer *buf;
+	struct mgb4_regs *video = &mgbdev->video;
+	const struct mgb4_vout_config *config = voutdev->config;
+	int irq = xdma_get_user_irq(mgbdev->xdev, config->irq);
+	int rv;
+	u32 addr;
+
+	mgb4_mask_reg(video, config->regs.config, 0x2, 0x2);
+
+	addr = mgb4_read_reg(video, config->regs.address);
+	if (addr >= MGB4_ERR_QUEUE_FULL) {
+		dev_dbg(dev, "frame queue error (%d)\n", (int)addr);
+		return_all_buffers(voutdev, VB2_BUF_STATE_QUEUED);
+		return -EBUSY;
+	}
+
+	buf = list_first_entry(&voutdev->buf_list, struct mgb4_frame_buffer,
+			       list);
+	list_del_init(voutdev->buf_list.next);
+
+	rv = mgb4_dma_transfer(mgbdev, config->dma_channel, true, addr,
+			       vb2_dma_sg_plane_desc(&buf->vb.vb2_buf, 0));
+	if (rv < 0) {
+		dev_warn(dev, "DMA transfer error\n");
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+	} else {
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
+	}
+
+	xdma_enable_user_irq(mgbdev->xdev, irq);
+
+	return 0;
+}
+
+static const struct vb2_ops queue_ops = {
+	.queue_setup = queue_setup,
+	.buf_init = buffer_init,
+	.buf_prepare = buffer_prepare,
+	.buf_queue = buffer_queue,
+	.start_streaming = start_streaming,
+	.stop_streaming = stop_streaming,
+	.wait_prepare = vb2_ops_wait_prepare,
+	.wait_finish = vb2_ops_wait_finish
+};
+
+static int vidioc_querycap(struct file *file, void *priv,
+			   struct v4l2_capability *cap)
+{
+	strscpy(cap->driver, KBUILD_MODNAME, sizeof(cap->driver));
+	strscpy(cap->card, "MGB4 PCIe Card", sizeof(cap->card));
+
+	return 0;
+}
+
+static int vidioc_enum_fmt(struct file *file, void *priv,
+			   struct v4l2_fmtdesc *f)
+{
+	if (f->index != 0)
+		return -EINVAL;
+
+	f->pixelformat = V4L2_PIX_FMT_ABGR32;
+
+	return 0;
+}
+
+static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct mgb4_vout_dev *voutdev = video_drvdata(file);
+
+	f->fmt.pix.pixelformat = V4L2_PIX_FMT_ABGR32;
+	f->fmt.pix.width = voutdev->width;
+	f->fmt.pix.height = voutdev->height;
+	f->fmt.pix.field = V4L2_FIELD_NONE;
+	f->fmt.pix.colorspace = V4L2_COLORSPACE_RAW;
+	f->fmt.pix.bytesperline = (f->fmt.pix.width + voutdev->padding) * 4;
+	f->fmt.pix.sizeimage = f->fmt.pix.bytesperline * f->fmt.pix.height;
+
+	return 0;
+}
+
+static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct mgb4_vout_dev *voutdev = video_drvdata(file);
+
+	f->fmt.pix.pixelformat = V4L2_PIX_FMT_ABGR32;
+	f->fmt.pix.width = voutdev->width;
+	f->fmt.pix.height = voutdev->height;
+	f->fmt.pix.field = V4L2_FIELD_NONE;
+	f->fmt.pix.colorspace = V4L2_COLORSPACE_RAW;
+	f->fmt.pix.bytesperline = max(f->fmt.pix.width * 4,
+				      ALIGN_DOWN(f->fmt.pix.bytesperline, 4));
+	f->fmt.pix.sizeimage = f->fmt.pix.bytesperline * f->fmt.pix.height;
+
+	return 0;
+}
+
+static int vidioc_s_fmt(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct mgb4_vout_dev *voutdev = video_drvdata(file);
+	struct mgb4_regs *video = &voutdev->mgbdev->video;
+
+	if (vb2_is_busy(&voutdev->queue))
+		return -EBUSY;
+
+	vidioc_try_fmt(file, priv, f);
+
+	voutdev->padding = (f->fmt.pix.bytesperline - (f->fmt.pix.width * 4)) / 4;
+	mgb4_write_reg(video, voutdev->config->regs.padding, voutdev->padding);
+
+	return 0;
+}
+
+static int vidioc_g_output(struct file *file, void *priv, unsigned int *i)
+{
+	*i = 0;
+	return 0;
+}
+
+static int vidioc_s_output(struct file *file, void *priv, unsigned int i)
+{
+	return i ? -EINVAL : 0;
+}
+
+static int vidioc_enum_output(struct file *file, void *priv,
+			      struct v4l2_output *out)
+{
+	if (out->index != 0)
+		return -EINVAL;
+
+	out->type = V4L2_OUTPUT_TYPE_ANALOG;
+	strscpy(out->name, "MGB4", sizeof(out->name));
+
+	return 0;
+}
+
+static const struct v4l2_ioctl_ops video_ioctl_ops = {
+	.vidioc_querycap = vidioc_querycap,
+	.vidioc_enum_fmt_vid_out = vidioc_enum_fmt,
+	.vidioc_try_fmt_vid_out = vidioc_try_fmt,
+	.vidioc_s_fmt_vid_out = vidioc_s_fmt,
+	.vidioc_g_fmt_vid_out = vidioc_g_fmt,
+	.vidioc_enum_output = vidioc_enum_output,
+	.vidioc_g_output = vidioc_g_output,
+	.vidioc_s_output = vidioc_s_output,
+	.vidioc_reqbufs = vb2_ioctl_reqbufs,
+	.vidioc_create_bufs = vb2_ioctl_create_bufs,
+	.vidioc_prepare_buf = vb2_ioctl_prepare_buf,
+	.vidioc_querybuf = vb2_ioctl_querybuf,
+	.vidioc_qbuf = vb2_ioctl_qbuf,
+	.vidioc_dqbuf = vb2_ioctl_dqbuf,
+	.vidioc_expbuf = vb2_ioctl_expbuf,
+	.vidioc_streamon = vb2_ioctl_streamon,
+	.vidioc_streamoff = vb2_ioctl_streamoff,
+};
+
+static int fh_open(struct file *file)
+{
+	struct mgb4_vout_dev *voutdev = video_drvdata(file);
+	struct mgb4_regs *video = &voutdev->mgbdev->video;
+	struct device *dev = &voutdev->mgbdev->pdev->dev;
+	u32 config, resolution;
+	int rv;
+
+	/* Return EBUSY when the device is in loopback mode */
+	config = mgb4_read_reg(video, voutdev->config->regs.config);
+	if ((config & 0xc) >> 2 != voutdev->config->id + MGB4_VIN_DEVICES) {
+		dev_dbg(dev, "can not open - device in loopback mode");
+		return -EBUSY;
+	}
+
+	mutex_lock(&voutdev->lock);
+
+	rv = v4l2_fh_open(file);
+	if (rv)
+		goto out;
+
+	if (!v4l2_fh_is_singular_file(file))
+		goto out;
+
+	resolution = mgb4_read_reg(video, voutdev->config->regs.resolution);
+	voutdev->width = resolution >> 16;
+	voutdev->height = resolution & 0xFFFF;
+
+out:
+	mutex_unlock(&voutdev->lock);
+	return rv;
+}
+
+static const struct v4l2_file_operations video_fops = {
+	.owner = THIS_MODULE,
+	.open = fh_open,
+	.release = vb2_fop_release,
+	.unlocked_ioctl = video_ioctl2,
+	.write = vb2_fop_write,
+	.mmap = vb2_fop_mmap,
+	.poll = vb2_fop_poll,
+};
+
+static void dma_transfer(struct work_struct *work)
+{
+	struct mgb4_vout_dev *voutdev = container_of(work, struct mgb4_vout_dev,
+						     dma_work);
+	struct device *dev = &voutdev->mgbdev->pdev->dev;
+	struct mgb4_regs *video = &voutdev->mgbdev->video;
+	struct mgb4_frame_buffer *buf = NULL;
+	unsigned long flags;
+	u32 addr;
+	int rv;
+
+	spin_lock_irqsave(&voutdev->qlock, flags);
+	if (!list_empty(&voutdev->buf_list)) {
+		buf = list_first_entry(&voutdev->buf_list,
+				       struct mgb4_frame_buffer, list);
+		list_del_init(voutdev->buf_list.next);
+	}
+	spin_unlock_irqrestore(&voutdev->qlock, flags);
+
+	if (!buf)
+		return;
+
+	addr = mgb4_read_reg(video, voutdev->config->regs.address);
+	if (addr >= MGB4_ERR_QUEUE_FULL) {
+		dev_dbg(dev, "frame queue error (%d)\n", (int)addr);
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+		return;
+	}
+
+	rv = mgb4_dma_transfer(voutdev->mgbdev, voutdev->config->dma_channel,
+			       true, addr,
+			       vb2_dma_sg_plane_desc(&buf->vb.vb2_buf, 0));
+	if (rv < 0) {
+		dev_warn(dev, "DMA transfer error\n");
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+	} else {
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
+	}
+}
+
+static irqreturn_t handler(int irq, void *ctx)
+{
+	struct mgb4_vout_dev *voutdev = (struct mgb4_vout_dev *)ctx;
+	struct mgb4_regs *video = &voutdev->mgbdev->video;
+
+	schedule_work(&voutdev->dma_work);
+
+	mgb4_write_reg(video, 0xB4, 1U << voutdev->config->irq);
+
+	return IRQ_HANDLED;
+}
+
+static int ser_init(struct mgb4_vout_dev *voutdev, int id)
+{
+	int rv;
+	const struct i2c_board_info *info = &fpdl3_ser_info[id];
+	struct mgb4_i2c_client *ser = &voutdev->ser;
+	struct device *dev = &voutdev->mgbdev->pdev->dev;
+
+	if (MGB4_IS_GMSL(voutdev->mgbdev))
+		return 0;
+
+	rv = mgb4_i2c_init(ser, voutdev->mgbdev->i2c_adap, info, 8);
+	if (rv < 0) {
+		dev_err(dev, "failed to create serializer\n");
+		return rv;
+	}
+	rv = mgb4_i2c_configure(ser, fpdl3_i2c, ARRAY_SIZE(fpdl3_i2c));
+	if (rv < 0) {
+		dev_err(dev, "failed to configure serializer\n");
+		goto err_i2c_dev;
+	}
+
+	return 0;
+
+err_i2c_dev:
+	mgb4_i2c_free(ser);
+
+	return rv;
+}
+
+static void fpga_init(struct mgb4_vout_dev *voutdev)
+{
+	struct mgb4_regs *video = &voutdev->mgbdev->video;
+	const struct mgb4_vout_regs *regs = &voutdev->config->regs;
+
+	mgb4_write_reg(video, regs->config, 0x00000011);
+	mgb4_write_reg(video, regs->resolution,
+		       (MGB4_DEFAULT_WIDTH << 16) | MGB4_DEFAULT_HEIGHT);
+	mgb4_write_reg(video, regs->hsync, 0x00102020);
+	mgb4_write_reg(video, regs->vsync, 0x40020202);
+	mgb4_write_reg(video, regs->frame_period, MGB4_DEFAULT_PERIOD);
+	mgb4_write_reg(video, regs->padding, 0x00000000);
+
+	voutdev->freq = mgb4_cmt_set_vout_freq(voutdev, 70000 >> 1) << 1;
+
+	mgb4_write_reg(video, regs->config,
+		       (voutdev->config->id + MGB4_VIN_DEVICES) << 2 | 1 << 4);
+}
+
+#ifdef CONFIG_DEBUG_FS
+static void debugfs_init(struct mgb4_vout_dev *voutdev)
+{
+	struct mgb4_regs *video = &voutdev->mgbdev->video;
+
+	voutdev->debugfs = debugfs_create_dir(voutdev->vdev.name,
+					      voutdev->mgbdev->debugfs);
+	if (!voutdev->debugfs)
+		return;
+
+	voutdev->regs[0].name = "CONFIG";
+	voutdev->regs[0].offset = voutdev->config->regs.config;
+	voutdev->regs[1].name = "STATUS";
+	voutdev->regs[1].offset = voutdev->config->regs.status;
+	voutdev->regs[2].name = "RESOLUTION";
+	voutdev->regs[2].offset = voutdev->config->regs.resolution;
+	voutdev->regs[3].name = "VIDEO_PARAMS_1";
+	voutdev->regs[3].offset = voutdev->config->regs.hsync;
+	voutdev->regs[4].name = "VIDEO_PARAMS_2";
+	voutdev->regs[4].offset = voutdev->config->regs.vsync;
+	voutdev->regs[5].name = "FRAME_PERIOD";
+	voutdev->regs[5].offset = voutdev->config->regs.frame_period;
+	voutdev->regs[6].name = "PADDING";
+	voutdev->regs[6].offset = voutdev->config->regs.padding;
+
+	voutdev->regset.base = video->membase;
+	voutdev->regset.regs = voutdev->regs;
+	voutdev->regset.nregs = ARRAY_SIZE(voutdev->regs);
+
+	debugfs_create_regset32("registers", 0444, voutdev->debugfs,
+				&voutdev->regset);
+}
+#endif
+
+struct mgb4_vout_dev *mgb4_vout_create(struct mgb4_dev *mgbdev, int id)
+{
+	int rv, irq;
+	const struct attribute_group **groups;
+	struct mgb4_vout_dev *voutdev;
+	struct pci_dev *pdev = mgbdev->pdev;
+	struct device *dev = &pdev->dev;
+
+	voutdev = kzalloc(sizeof(*voutdev), GFP_KERNEL);
+	if (!voutdev)
+		return NULL;
+
+	voutdev->mgbdev = mgbdev;
+	voutdev->config = &vout_cfg[id];
+
+	/* Frame queue */
+	INIT_LIST_HEAD(&voutdev->buf_list);
+	spin_lock_init(&voutdev->qlock);
+
+	/* DMA transfer stuff */
+	INIT_WORK(&voutdev->dma_work, dma_transfer);
+
+	/* IRQ callback */
+	irq = xdma_get_user_irq(mgbdev->xdev, voutdev->config->irq);
+	rv = request_irq(irq, handler, 0, "mgb4-vout", voutdev);
+	if (rv) {
+		dev_err(dev, "failed to register irq handler\n");
+		goto err_alloc;
+	}
+
+	/* Set the FPGA registers default values */
+	fpga_init(voutdev);
+
+	/* Set the serializer default values */
+	rv = ser_init(voutdev, id);
+	if (rv)
+		goto err_irq;
+
+	/* V4L2 stuff init  */
+	rv = v4l2_device_register(dev, &voutdev->v4l2dev);
+	if (rv) {
+		dev_err(dev, "failed to register v4l2 device\n");
+		goto err_irq;
+	}
+
+	mutex_init(&voutdev->lock);
+
+	voutdev->queue.type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
+	voutdev->queue.io_modes = VB2_MMAP | VB2_DMABUF | VB2_WRITE;
+	voutdev->queue.buf_struct_size = sizeof(struct mgb4_frame_buffer);
+	voutdev->queue.ops = &queue_ops;
+	voutdev->queue.mem_ops = &vb2_dma_sg_memops;
+	voutdev->queue.gfp_flags = GFP_DMA32;
+	voutdev->queue.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	voutdev->queue.min_buffers_needed = 2;
+	voutdev->queue.drv_priv = voutdev;
+	voutdev->queue.lock = &voutdev->lock;
+	voutdev->queue.dev = dev;
+	rv = vb2_queue_init(&voutdev->queue);
+	if (rv) {
+		dev_err(dev, "failed to initialize vb2 queue\n");
+		goto err_v4l2_dev;
+	}
+
+	snprintf(voutdev->vdev.name, sizeof(voutdev->vdev.name), "mgb4-out%d",
+		 id + 1);
+	voutdev->vdev.device_caps = V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_READWRITE
+	  | V4L2_CAP_STREAMING;
+	voutdev->vdev.vfl_dir = VFL_DIR_TX;
+	voutdev->vdev.fops = &video_fops;
+	voutdev->vdev.ioctl_ops = &video_ioctl_ops;
+	voutdev->vdev.release = video_device_release_empty;
+	voutdev->vdev.v4l2_dev = &voutdev->v4l2dev;
+	voutdev->vdev.lock = &voutdev->lock;
+	voutdev->vdev.queue = &voutdev->queue;
+	video_set_drvdata(&voutdev->vdev, voutdev);
+
+	rv = video_register_device(&voutdev->vdev, VFL_TYPE_VIDEO, -1);
+	if (rv) {
+		dev_err(dev, "failed to register video device\n");
+		goto err_v4l2_dev;
+	}
+
+	/* Module sysfs attributes */
+	groups = MGB4_IS_GMSL(mgbdev)
+	  ? mgb4_gmsl_out_groups : mgb4_fpdl3_out_groups;
+	rv = device_add_groups(&voutdev->vdev.dev, groups);
+	if (rv) {
+		dev_err(dev, "failed to create sysfs attributes\n");
+		goto err_video_dev;
+	}
+
+#ifdef CONFIG_DEBUG_FS
+	debugfs_init(voutdev);
+#endif
+
+	return voutdev;
+
+err_video_dev:
+	video_unregister_device(&voutdev->vdev);
+err_v4l2_dev:
+	v4l2_device_unregister(&voutdev->v4l2dev);
+err_irq:
+	free_irq(irq, voutdev);
+err_alloc:
+	kfree(voutdev);
+
+	return NULL;
+}
+
+void mgb4_vout_free(struct mgb4_vout_dev *voutdev)
+{
+	const struct attribute_group **groups;
+	int irq = xdma_get_user_irq(voutdev->mgbdev->xdev, voutdev->config->irq);
+
+	free_irq(irq, voutdev);
+
+#ifdef CONFIG_DEBUG_FS
+	debugfs_remove_recursive(voutdev->debugfs);
+#endif
+
+	groups = MGB4_IS_GMSL(voutdev->mgbdev)
+	  ? mgb4_gmsl_out_groups : mgb4_fpdl3_out_groups;
+	device_remove_groups(&voutdev->vdev.dev, groups);
+
+	mgb4_i2c_free(&voutdev->ser);
+	video_unregister_device(&voutdev->vdev);
+	v4l2_device_unregister(&voutdev->v4l2dev);
+
+	kfree(voutdev);
+}
diff --git a/drivers/media/pci/mgb4/mgb4_vout.h b/drivers/media/pci/mgb4/mgb4_vout.h
new file mode 100644
index 000000000000..b163dee711fd
--- /dev/null
+++ b/drivers/media/pci/mgb4/mgb4_vout.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021-2023 Digiteq Automotive
+ *     author: Martin Tuma <martin.tuma@digiteqautomotive.com>
+ */
+
+#ifndef __MGB4_VOUT_H__
+#define __MGB4_VOUT_H__
+
+#include <media/v4l2-device.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-ctrls.h>
+#include <media/videobuf2-core.h>
+#include <linux/debugfs.h>
+#include "mgb4_i2c.h"
+
+struct mgb4_vout_regs {
+	u32 address;
+	u32 config;
+	u32 status;
+	u32 resolution;
+	u32 frame_period;
+	u32 hsync;
+	u32 vsync;
+	u32 padding;
+};
+
+struct mgb4_vout_config {
+	int id;
+	int dma_channel;
+	int irq;
+	struct mgb4_vout_regs regs;
+};
+
+struct mgb4_vout_dev {
+	struct mgb4_dev *mgbdev;
+	struct v4l2_device v4l2dev;
+	struct video_device vdev;
+	struct vb2_queue queue;
+	struct mutex lock; /* vdev lock */
+
+	spinlock_t qlock; /* buffer queue lock */
+	struct list_head buf_list;
+	struct work_struct dma_work;
+
+	u32 width;
+	u32 height;
+	u32 freq;
+	u32 padding;
+
+	struct mgb4_i2c_client ser;
+
+	const struct mgb4_vout_config *config;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs;
+	struct debugfs_regset32 regset;
+	struct debugfs_reg32 regs[7];
+#endif
+};
+
+struct mgb4_vout_dev *mgb4_vout_create(struct mgb4_dev *mgbdev, int id);
+void mgb4_vout_free(struct mgb4_vout_dev *voutdev);
+
+#endif
-- 
2.40.1

