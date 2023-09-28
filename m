Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B8D7B176C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjI1JdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjI1JdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:33:20 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10D41B0;
        Thu, 28 Sep 2023 02:33:15 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38S8hI2c022933;
        Thu, 28 Sep 2023 05:33:04 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tbx5y6xm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 05:33:04 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 38S9X28f056404
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Sep 2023 05:33:02 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 28 Sep 2023 05:33:01 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 28 Sep 2023 05:33:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 28 Sep 2023 05:33:01 -0400
Received: from ubuntu20.04.ad.analog.com (HYB-d0iOFy9ma8q.ad.analog.com [10.48.65.139])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 38S9Vjfc028736;
        Thu, 28 Sep 2023 05:32:50 -0400
From:   Eliza Balas <eliza.balas@analog.com>
CC:     Eliza Balas <eliza.balas@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Date:   Thu, 28 Sep 2023 12:28:04 +0300
Message-ID: <20230928092804.22612-3-eliza.balas@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230928092804.22612-1-eliza.balas@analog.com>
References: <20230928092804.22612-1-eliza.balas@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: p66iwJh3TPkCz8hUEz55ey5BXns5fPpe
X-Proofpoint-GUID: p66iwJh3TPkCz8hUEz55ey5BXns5fPpe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_07,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309280082
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the driver for the new ADI TDD engine HDL.
The generic TDD controller is in essence a waveform generator
capable of addressing RF applications which require Time Division
Duplexing, as well as controlling other modules of general
applications through its dedicated 32 channel outputs.

The reason of creating the generic TDD controller was to reduce
the naming confusion around the existing repurposed TDD core
built for AD9361, as well as expanding its number of output
channels for systems which require more than six controlling signals.

Signed-off-by: Eliza Balas <eliza.balas@analog.com>
---
 .../sysfs-bus-platform-drivers-adi-axi-tdd    | 158 ++++
 MAINTAINERS                                   |   2 +
 drivers/misc/Kconfig                          |  10 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/adi-axi-tdd.c                    | 780 ++++++++++++++++++
 5 files changed, 951 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-drivers-adi-axi-tdd
 create mode 100644 drivers/misc/adi-axi-tdd.c

diff --git a/Documentation/ABI/testing/sysfs-bus-platform-drivers-adi-axi-tdd b/Documentation/ABI/testing/sysfs-bus-platform-drivers-adi-axi-tdd
new file mode 100644
index 000000000000..acbb3dcf10f1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-platform-drivers-adi-axi-tdd
@@ -0,0 +1,158 @@
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/burst_count
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Allows the user to set the number of TDD frames per burst.
+                If set to 0x0 and the TDD module is enabled, then the controller
+                operates in TDD mode as long as the ENABLE property is set.
+                If set to a non-zero value, the controller
+                operates for the set number of frames and then stops.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/core_id
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Displays the value of the ID configuration parameter.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/enable
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Allows the user to enable or disable the TDD module.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/frame_length_ms
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Allows the user to set the length of the transmission frame,
+                defined in milliseconds.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/frame_length_raw
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Allows the user to set the length of the transmission frame,
+                defined in clock cycles of the input clock.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/internal_sync_period_ms
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Allows the user to set the period of the internal sync generator,
+                defined in milliseconds.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/internal_sync_period_raw
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Allows the user to set the period of the internal sync generator,
+                defined in clock cycles of the input clock.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/magic
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Displays the code name of the TDD module for identification.
+                The value is 0x5444444E ('T', 'D', 'D', 'N').
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/out_channel<n>_enable
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Allows the user to enable or disable the output channel CH<n>.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/out_channel<n>_off_ms
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Allows the user to set the offset from the beginning of a new
+                frame when channel CH<n> is reset, defined in milliseconds.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/out_channel<n>_off_raw
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Allows the user to set the offset from the beginning of a new
+                frame when channel CH<n> is reset, defined in clock cycles
+                of the input clock.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/out_channel<n>_on_ms
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Allows the user to set the offset from the beginning of a new
+                frame when channel CH<n> is set, defined in milliseconds.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/out_channel<n>_on_raw
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Allows the user to set the offset from the beginning of a new
+                frame when channel CH<n> is set, defined in clock cycles
+                of the input clock.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/out_channel<n>_polarity
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Allows the user to set the polarity of the output channel CH<n>.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/scratch
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Allows the user to write and read the scratch register for
+                debugging purposes.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/startup_delay_ms
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Allows the user to set the initial delay before the first frame,
+                defined in milliseconds.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/startup_delay_raw
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Allows the user to set the initial delay before the first frame,
+                defined in clock cycles of the input clock.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/state
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Displays the current state of the peripheral FSM, used for
+                debugging purposes.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/sync_external
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Allows the user to enable or disable the external sync trigger.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/sync_internal
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Allows the user to enable or disable the internal sync trigger.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/sync_reset
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Allows the user to reset the internal counter when receiving a
+                sync event.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/sync_soft
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Allows the user to trigger one software sync pulse.
+
+What:           /sys/bus/platform/drivers/adi-axi-tdd/*/version
+Date:           November 2023
+KernelVersion:  6.7
+Contact:        Eliza Balas <eliza.balas@analog.com>
+Description:    Displays the version of the peripheral. Follows semantic
+                versioning. Current version is 2.00.61.
diff --git a/MAINTAINERS b/MAINTAINERS
index c5cc69c83c39..9862704cec7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1350,7 +1350,9 @@ M:	Eliza Balas <eliza.balas@analog.com>
 S:	Supported
 W:	http://wiki.analog.com/resources/fpga/docs/axi_tdd
 W:	http://ez.analog.com/linux-software-drivers/
+F:	Documentation/ABI/testing/sysfs-bus-platform-drivers-adi-axi-tdd
 F:	Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
+F:	drivers/misc/adi-axi-tdd.c
 
 ANALOG DEVICES INC IIO DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index cadd4a820c03..45074a93fa55 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -50,6 +50,16 @@ config AD525X_DPOT_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad525x_dpot-spi.
 
+config ADI_AXI_TDD
+	tristate "Analog Devices TDD Engine support"
+	depends on HAS_IOMEM
+	select REGMAP_MMIO
+	help
+	  The ADI AXI TDD core is the reworked and generic TDD engine which
+	  was developed for general use in Analog Devices HDL projects. Unlike
+	  the previous TDD engine, this core can only be used standalone mode,
+	  and is not embedded into other devices.
+
 config DUMMY_IRQ
 	tristate "Dummy IRQ handler"
 	help
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index f2a4d1ff65d4..d97afe1eeba5 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_IBMVMC)		+= ibmvmc.o
 obj-$(CONFIG_AD525X_DPOT)	+= ad525x_dpot.o
 obj-$(CONFIG_AD525X_DPOT_I2C)	+= ad525x_dpot-i2c.o
 obj-$(CONFIG_AD525X_DPOT_SPI)	+= ad525x_dpot-spi.o
+obj-$(CONFIG_ADI_AXI_TDD)	+= adi-axi-tdd.o
 obj-$(CONFIG_ATMEL_SSC)		+= atmel-ssc.o
 obj-$(CONFIG_DUMMY_IRQ)		+= dummy-irq.o
 obj-$(CONFIG_ICS932S401)	+= ics932s401.o
diff --git a/drivers/misc/adi-axi-tdd.c b/drivers/misc/adi-axi-tdd.c
new file mode 100644
index 000000000000..764e65086e83
--- /dev/null
+++ b/drivers/misc/adi-axi-tdd.c
@@ -0,0 +1,780 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * TDD HDL CORE driver
+ *
+ * Copyright 2023 Analog Devices Inc.
+ *
+ */
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/fpga/adi-axi-common.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+
+/* Register Map */
+#define ADI_REG_TDD_VERSION                 0x0000
+#define ADI_REG_TDD_PERIPHERAL_ID           0x0004
+#define ADI_REG_TDD_SCRATCH                 0x0008
+#define ADI_REG_TDD_IDENTIFICATION          0x000c
+#define ADI_REG_TDD_INTERFACE_DESCRIPTION   0x0010
+#define ADI_REG_TDD_DEFAULT_POLARITY        0x0014
+#define ADI_REG_TDD_CONTROL                 0x0040
+#define ADI_REG_TDD_CHANNEL_ENABLE          0x0044
+#define ADI_REG_TDD_CHANNEL_POLARITY        0x0048
+#define ADI_REG_TDD_BURST_COUNT             0x004c
+#define ADI_REG_TDD_STARTUP_DELAY           0x0050
+#define ADI_REG_TDD_FRAME_LENGTH            0x0054
+#define ADI_REG_TDD_SYNC_COUNTER_LOW        0x0058
+#define ADI_REG_TDD_SYNC_COUNTER_HIGH       0x005c
+#define ADI_REG_TDD_STATUS                  0x0060
+#define ADI_REG_TDD_CHANNEL_BASE            0x0080
+
+/* Identification Register */
+#define ADI_TDD_MAGIC                       0x5444444E
+
+/* Interface Description Register */
+#define ADI_TDD_SYNC_COUNT_WIDTH            GENMASK(30, 24)
+#define ADI_TDD_BURST_COUNT_WIDTH           GENMASK(21, 16)
+#define ADI_TDD_REG_WIDTH                   GENMASK(13, 8)
+#define ADI_TDD_SYNC_EXTERNAL_CDC           BIT(7)
+#define ADI_TDD_SYNC_EXTERNAL               BIT(6)
+#define ADI_TDD_SYNC_INTERNAL               BIT(5)
+#define ADI_TDD_CHANNEL_COUNT               GENMASK(4, 0)
+
+/* Control Register */
+#define ADI_TDD_SYNC_SOFT                   BIT(4)
+#define ADI_TDD_SYNC_EXT                    BIT(3)
+#define ADI_TDD_SYNC_INT                    BIT(2)
+#define ADI_TDD_SYNC_RST                    BIT(1)
+#define ADI_TDD_ENABLE                      BIT(0)
+
+/* Channel Definitions */
+#define ADI_TDD_CHANNEL_OFFSET              0x0008
+#define ADI_TDD_CHANNEL_ON                  0x0000
+#define ADI_TDD_CHANNEL_OFF                 0x0004
+
+#define ADI_REG_TDD_CHANNEL(c, o)           \
+	(ADI_REG_TDD_CHANNEL_BASE + ADI_TDD_CHANNEL_OFFSET * (c) + (o))
+
+enum adi_axi_tdd_attribute_id {
+	ADI_TDD_ATTR_VERSION,
+	ADI_TDD_ATTR_CORE_ID,
+	ADI_TDD_ATTR_SCRATCH,
+	ADI_TDD_ATTR_MAGIC,
+
+	ADI_TDD_ATTR_SYNC_SOFT,
+	ADI_TDD_ATTR_SYNC_EXT,
+	ADI_TDD_ATTR_SYNC_INT,
+	ADI_TDD_ATTR_SYNC_RST,
+	ADI_TDD_ATTR_ENABLE,
+
+	ADI_TDD_ATTR_BURST_COUNT,
+	ADI_TDD_ATTR_STARTUP_DELAY_RAW,
+	ADI_TDD_ATTR_STARTUP_DELAY_MS,
+	ADI_TDD_ATTR_FRAME_LENGTH_RAW,
+	ADI_TDD_ATTR_FRAME_LENGTH_MS,
+	ADI_TDD_ATTR_INTERNAL_SYNC_PERIOD_RAW,
+	ADI_TDD_ATTR_INTERNAL_SYNC_PERIOD_MS,
+
+	ADI_TDD_ATTR_STATE,
+
+	ADI_TDD_ATTR_CHANNEL_ENABLE,
+	ADI_TDD_ATTR_CHANNEL_POLARITY,
+	ADI_TDD_ATTR_CHANNEL_ON_RAW,
+	ADI_TDD_ATTR_CHANNEL_OFF_RAW,
+	ADI_TDD_ATTR_CHANNEL_ON_MS,
+	ADI_TDD_ATTR_CHANNEL_OFF_MS,
+};
+
+struct adi_axi_tdd_clk {
+	struct notifier_block nb;
+	unsigned long rate;
+	struct clk *clk;
+
+};
+
+struct adi_axi_tdd_attribute {
+	enum adi_axi_tdd_attribute_id id;
+	struct device_attribute attr;
+	u32 channel;
+	u8 name[32];
+};
+
+#define to_tdd_attribute(x) container_of(x, struct adi_axi_tdd_attribute, attr)
+
+/**
+ * struct adi_axi_tdd_state - Driver state information for the TDD CORE
+ * @clk: Interface clock definition. Used to translate ms into cycle counts
+ * @base: Device register base address in memory
+ * @regs: Device memory-mapped region regmap
+ * @sync_count_width: Bit width of the internal synchronization counter, <= 64
+ * @sync_count_mask: Bit mask of sync counter
+ * @burst_count_width: Bit width of the burst counter, <= 32
+ * @burst_count_mask: Bit mask of the burst counter
+ * @reg_width: Timing register bit width, <= 32
+ * @reg_mask: Timing register bit mask
+ * @sync_external_cdc: Whether the external sync input is synchronized into the main clock domain
+ * @sync_external: Whether external synchronization support was enabled at synthesis time
+ * @sync_internal: Whether internal synchronization support was enabled at synthesis time
+ * @channel_count: Available channel count
+ * @enabled: Whether the TDD engine is currently enabled.
+ *	     Note: Most configuration registers cannot be changed while the TDD core is enabled.
+ */
+struct adi_axi_tdd_state {
+	struct adi_axi_tdd_clk clk;
+	void __iomem *base;
+	struct regmap *regs;
+	u32 sync_count_width;
+	u64 sync_count_mask;
+	u32 burst_count_width;
+	u32 burst_count_mask;
+	u32 reg_width;
+	u32 reg_mask;
+	bool sync_external_cdc;
+	bool sync_external;
+	bool sync_internal;
+	u32 channel_count;
+	bool enabled;
+};
+
+static const struct regmap_config adi_axi_tdd_regmap_cfg = {
+	.name = "adi-axi-tdd",
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static int adi_axi_tdd_format_ms(struct adi_axi_tdd_state *st, u64 x, char *buf)
+{
+	u32 vals[2];
+	u64 t_ns;
+
+	t_ns = div_u64(x * 1000000000ULL, READ_ONCE(st->clk.rate));
+	vals[0] = div_u64_rem(t_ns, 1000000, &vals[1]);
+
+	return sysfs_emit(buf, "%d.%06u\n", vals[0], vals[1]);
+}
+
+static ssize_t adi_axi_tdd_show(struct device *dev,
+				struct device_attribute *dev_attr, char *buf)
+{
+	const struct adi_axi_tdd_attribute *attr = to_tdd_attribute(dev_attr);
+	struct adi_axi_tdd_state *st = dev_get_drvdata(dev);
+	u32 channel = attr->channel;
+	bool ms = false;
+	u64 data64;
+	u32 data;
+	int ret;
+
+	switch (attr->id) {
+	case ADI_TDD_ATTR_VERSION:
+		ret = regmap_read(st->regs, ADI_AXI_REG_VERSION, &data);
+		if (ret)
+			return ret;
+		return sysfs_emit(buf, "%d.%.2d.%c\n",
+				 ADI_AXI_PCORE_VER_MAJOR(data),
+				 ADI_AXI_PCORE_VER_MINOR(data),
+				 ADI_AXI_PCORE_VER_PATCH(data));
+	case ADI_TDD_ATTR_CORE_ID:
+		ret = regmap_read(st->regs, ADI_REG_TDD_PERIPHERAL_ID, &data);
+		if (ret)
+			return ret;
+		return sysfs_emit(buf, "%u\n", data);
+	case ADI_TDD_ATTR_SCRATCH:
+		ret = regmap_read(st->regs, ADI_REG_TDD_SCRATCH, &data);
+		if (ret)
+			return ret;
+		return sysfs_emit(buf, "0x%08x\n", data);
+	case ADI_TDD_ATTR_MAGIC:
+		ret = regmap_read(st->regs, ADI_REG_TDD_IDENTIFICATION, &data);
+		if (ret)
+			return ret;
+		return sysfs_emit(buf, "0x%08x\n", data);
+	case ADI_TDD_ATTR_SYNC_EXT:
+		ret = regmap_read(st->regs, ADI_REG_TDD_CONTROL, &data);
+		if (ret)
+			return ret;
+		return sysfs_emit(buf, "%d\n", !!(data & ADI_TDD_SYNC_EXT));
+	case ADI_TDD_ATTR_SYNC_INT:
+		ret = regmap_read(st->regs, ADI_REG_TDD_CONTROL, &data);
+		if (ret)
+			return ret;
+		return sysfs_emit(buf, "%d\n", !!(data & ADI_TDD_SYNC_INT));
+	case ADI_TDD_ATTR_SYNC_RST:
+		ret = regmap_read(st->regs, ADI_REG_TDD_CONTROL, &data);
+		if (ret)
+			return ret;
+		return sysfs_emit(buf, "%d\n", !!(data & ADI_TDD_SYNC_RST));
+	case ADI_TDD_ATTR_ENABLE:
+		ret = regmap_read(st->regs, ADI_REG_TDD_CONTROL, &data);
+		if (ret)
+			return ret;
+		st->enabled = !!(data & ADI_TDD_ENABLE);
+		return sysfs_emit(buf, "%d\n", st->enabled);
+	case ADI_TDD_ATTR_BURST_COUNT:
+		ret = regmap_read(st->regs, ADI_REG_TDD_BURST_COUNT, &data);
+		if (ret)
+			return ret;
+		return sysfs_emit(buf, "%u\n", data);
+	case ADI_TDD_ATTR_STARTUP_DELAY_RAW:
+		ret = regmap_read(st->regs, ADI_REG_TDD_STARTUP_DELAY, &data);
+		if (ret)
+			return ret;
+		return sysfs_emit(buf, "%u\n", data);
+	case ADI_TDD_ATTR_STARTUP_DELAY_MS:
+		ret = regmap_read(st->regs, ADI_REG_TDD_STARTUP_DELAY, &data);
+		if (ret)
+			return ret;
+		return adi_axi_tdd_format_ms(st, data, buf);
+	case ADI_TDD_ATTR_FRAME_LENGTH_RAW:
+		ret = regmap_read(st->regs, ADI_REG_TDD_FRAME_LENGTH, &data);
+		if (ret)
+			return ret;
+		return sysfs_emit(buf, "%u\n", data);
+	case ADI_TDD_ATTR_FRAME_LENGTH_MS:
+		ret = regmap_read(st->regs, ADI_REG_TDD_FRAME_LENGTH, &data);
+		if (ret)
+			return ret;
+		return adi_axi_tdd_format_ms(st, data, buf);
+	case ADI_TDD_ATTR_INTERNAL_SYNC_PERIOD_RAW:
+		ret = regmap_bulk_read(st->regs, ADI_REG_TDD_SYNC_COUNTER_LOW,
+				       &data64, 2);
+		if (ret)
+			return ret;
+		return sysfs_emit(buf, "%llu\n", data64);
+	case ADI_TDD_ATTR_INTERNAL_SYNC_PERIOD_MS:
+		ret = regmap_bulk_read(st->regs, ADI_REG_TDD_SYNC_COUNTER_LOW,
+				       &data64, 2);
+		if (ret)
+			return ret;
+		return adi_axi_tdd_format_ms(st, data64, buf);
+	case ADI_TDD_ATTR_STATE:
+		ret = regmap_read(st->regs, ADI_REG_TDD_STATUS, &data);
+		if (ret)
+			return ret;
+		return sysfs_emit(buf, "%u\n", data);
+	case ADI_TDD_ATTR_CHANNEL_ENABLE:
+		ret = regmap_read(st->regs, ADI_REG_TDD_CHANNEL_ENABLE, &data);
+		if (ret)
+			return ret;
+		return sysfs_emit(buf, "%d\n", !!(BIT(channel) & data));
+	case ADI_TDD_ATTR_CHANNEL_POLARITY:
+		ret = regmap_read(st->regs, ADI_REG_TDD_CHANNEL_POLARITY,
+				  &data);
+		if (ret)
+			return ret;
+		return sysfs_emit(buf, "%d\n", !!(BIT(channel) & data));
+	case ADI_TDD_ATTR_CHANNEL_ON_MS:
+		ms = true;
+		fallthrough;
+	case ADI_TDD_ATTR_CHANNEL_ON_RAW:
+		ret = regmap_read(st->regs,
+				  ADI_REG_TDD_CHANNEL(channel,
+						      ADI_TDD_CHANNEL_ON),
+				  &data);
+		if (ret)
+			return ret;
+		if (ms)
+			return adi_axi_tdd_format_ms(st, data, buf);
+		return sysfs_emit(buf, "%u\n", data);
+	case ADI_TDD_ATTR_CHANNEL_OFF_MS:
+		ms = true;
+		fallthrough;
+	case ADI_TDD_ATTR_CHANNEL_OFF_RAW:
+		ret = regmap_read(st->regs,
+				  ADI_REG_TDD_CHANNEL(channel,
+						      ADI_TDD_CHANNEL_OFF),
+				  &data);
+		if (ret)
+			return ret;
+		if (ms)
+			return adi_axi_tdd_format_ms(st, data, buf);
+		return sysfs_emit(buf, "%u\n", data);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adi_axi_tdd_parse_ms(struct adi_axi_tdd_state *st,
+				const char *buf,
+				u64 *res)
+{
+	u64 clk_rate = READ_ONCE(st->clk.rate);
+	char *orig_str, *modf_str, *int_part, frac_part[7];
+	long ival, frac;
+	int ret;
+
+	orig_str = kstrdup(buf, GFP_KERNEL);
+	int_part = strsep(&orig_str, ".");
+	ret = kstrtol(int_part, 10, &ival);
+	if (ret || ival < 0)
+		return -EINVAL;
+	modf_str = strsep(&orig_str, ".");
+	if (modf_str) {
+		snprintf(frac_part, 7, "%s00000", modf_str);
+		ret = kstrtol(frac_part, 10, &frac);
+		if (ret)
+			return -EINVAL;
+	} else {
+		frac = 0;
+	}
+
+	*res = DIV_ROUND_CLOSEST_ULL((u64)ival * clk_rate, 1000)
+		+ DIV_ROUND_CLOSEST_ULL((u64)frac * clk_rate, 1000000000);
+
+	kfree(orig_str);
+
+	return ret;
+}
+
+static int adi_axi_tdd_write_regs(const struct adi_axi_tdd_attribute *attr,
+				  struct adi_axi_tdd_state *st,
+				  const char *buf)
+{
+	u32 channel = attr->channel;
+	u64 data64;
+	u32 data;
+	int ret;
+
+	switch (attr->id) {
+	case ADI_TDD_ATTR_SCRATCH:
+		ret = kstrtou32(buf, 0, &data);
+		if (ret)
+			return ret;
+		return regmap_write(st->regs, ADI_REG_TDD_SCRATCH, data);
+	case ADI_TDD_ATTR_SYNC_SOFT:
+		ret = kstrtou32(buf, 0, &data);
+		if (ret)
+			return ret;
+		return regmap_update_bits_base(st->regs, ADI_REG_TDD_CONTROL,
+					       ADI_TDD_SYNC_SOFT,
+					       ADI_TDD_SYNC_SOFT * !!data,
+					       NULL, false, false);
+	case ADI_TDD_ATTR_SYNC_EXT:
+		ret = kstrtou32(buf, 0, &data);
+		if (ret)
+			return ret;
+		return regmap_update_bits_base(st->regs, ADI_REG_TDD_CONTROL,
+					       ADI_TDD_SYNC_EXT,
+					       ADI_TDD_SYNC_EXT * !!data,
+					       NULL, false, false);
+	case ADI_TDD_ATTR_SYNC_INT:
+		ret = kstrtou32(buf, 0, &data);
+		if (ret)
+			return ret;
+		return regmap_update_bits_base(st->regs, ADI_REG_TDD_CONTROL,
+					       ADI_TDD_SYNC_INT,
+					       ADI_TDD_SYNC_INT * !!data,
+					       NULL, false, false);
+	case ADI_TDD_ATTR_SYNC_RST:
+		ret = kstrtou32(buf, 0, &data);
+		if (ret)
+			return ret;
+		return regmap_update_bits_base(st->regs, ADI_REG_TDD_CONTROL,
+					       ADI_TDD_SYNC_RST,
+					       ADI_TDD_SYNC_RST * !!data,
+					       NULL, false, false);
+	case ADI_TDD_ATTR_ENABLE:
+		ret = kstrtou32(buf, 0, &data);
+		if (ret)
+			return ret;
+		return regmap_update_bits_base(st->regs, ADI_REG_TDD_CONTROL,
+					       ADI_TDD_ENABLE,
+					       ADI_TDD_ENABLE * !!data,
+					       NULL, false, false);
+	case ADI_TDD_ATTR_BURST_COUNT:
+		ret = kstrtou32(buf, 0, &data);
+		if (ret)
+			return ret;
+		return regmap_write(st->regs, ADI_REG_TDD_BURST_COUNT, data);
+	case ADI_TDD_ATTR_STARTUP_DELAY_RAW:
+		ret = kstrtou32(buf, 0, &data);
+		if (ret)
+			return ret;
+		return regmap_write(st->regs, ADI_REG_TDD_STARTUP_DELAY, data);
+	case ADI_TDD_ATTR_STARTUP_DELAY_MS:
+		ret = adi_axi_tdd_parse_ms(st, buf, &data64);
+		if (ret)
+			return ret;
+		if (FIELD_GET(GENMASK_ULL(63, 32), data64))
+			return -EINVAL;
+		return regmap_write(st->regs, ADI_REG_TDD_STARTUP_DELAY,
+				    (u32)data64);
+	case ADI_TDD_ATTR_FRAME_LENGTH_RAW:
+		ret = kstrtou32(buf, 0, &data);
+		if (ret)
+			return ret;
+		return regmap_write(st->regs, ADI_REG_TDD_FRAME_LENGTH, data);
+	case ADI_TDD_ATTR_FRAME_LENGTH_MS:
+		ret = adi_axi_tdd_parse_ms(st, buf, &data64);
+		if (ret)
+			return ret;
+		if (FIELD_GET(GENMASK_ULL(63, 32), data64))
+			return -EINVAL;
+		return regmap_write(st->regs, ADI_REG_TDD_FRAME_LENGTH,
+				    (u32)data64);
+	case ADI_TDD_ATTR_INTERNAL_SYNC_PERIOD_RAW:
+		ret = kstrtou64(buf, 0, &data64);
+		if (ret)
+			return ret;
+		return regmap_bulk_write(st->regs, ADI_REG_TDD_SYNC_COUNTER_LOW,
+					 &data64, 2);
+	case ADI_TDD_ATTR_INTERNAL_SYNC_PERIOD_MS:
+		ret = adi_axi_tdd_parse_ms(st, buf, &data64);
+		if (ret)
+			return ret;
+		return regmap_bulk_write(st->regs, ADI_REG_TDD_SYNC_COUNTER_LOW,
+					 &data64, 2);
+	case ADI_TDD_ATTR_CHANNEL_ENABLE:
+		ret = kstrtou32(buf, 0, &data);
+		if (ret)
+			return ret;
+		return regmap_update_bits_base(st->regs,
+					       ADI_REG_TDD_CHANNEL_ENABLE,
+					       BIT(channel),
+					       BIT(channel) * !!data,
+					       NULL, false, false);
+	case ADI_TDD_ATTR_CHANNEL_POLARITY:
+		ret = kstrtou32(buf, 0, &data);
+		if (ret)
+			return ret;
+		return regmap_update_bits_base(st->regs,
+					       ADI_REG_TDD_CHANNEL_POLARITY,
+					       BIT(channel),
+					       BIT(channel) * !!data,
+					       NULL, false, false);
+	case ADI_TDD_ATTR_CHANNEL_ON_RAW:
+		ret = kstrtou32(buf, 0, &data);
+		if (ret)
+			return ret;
+		return regmap_write(st->regs,
+				    ADI_REG_TDD_CHANNEL(channel,
+							ADI_TDD_CHANNEL_ON),
+				    data);
+	case ADI_TDD_ATTR_CHANNEL_ON_MS:
+		ret = adi_axi_tdd_parse_ms(st, buf, &data64);
+		if (ret)
+			return ret;
+		if (FIELD_GET(GENMASK_ULL(63, 32), data64))
+			return -EINVAL;
+		return regmap_write(st->regs,
+				    ADI_REG_TDD_CHANNEL(channel,
+							ADI_TDD_CHANNEL_ON),
+				    (u32)data64);
+	case ADI_TDD_ATTR_CHANNEL_OFF_RAW:
+		ret = kstrtou32(buf, 0, &data);
+		if (ret)
+			return ret;
+		return regmap_write(st->regs,
+				    ADI_REG_TDD_CHANNEL(channel,
+							ADI_TDD_CHANNEL_OFF),
+				    data);
+	case ADI_TDD_ATTR_CHANNEL_OFF_MS:
+		ret = adi_axi_tdd_parse_ms(st, buf, &data64);
+		if (ret)
+			return ret;
+		if (FIELD_GET(GENMASK_ULL(63, 32), data64))
+			return -EINVAL;
+		return regmap_write(st->regs,
+				    ADI_REG_TDD_CHANNEL(channel,
+							ADI_TDD_CHANNEL_OFF),
+				    (u32)data64);
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t adi_axi_tdd_store(struct device *dev,
+				 struct device_attribute *dev_attr,
+				 const char *buf, size_t count)
+{
+	const struct adi_axi_tdd_attribute *attr = to_tdd_attribute(dev_attr);
+	struct adi_axi_tdd_state *st = dev_get_drvdata(dev);
+
+	return adi_axi_tdd_write_regs(attr, st, buf) ?: count;
+}
+
+static int adi_axi_tdd_init_synthesis_parameters(struct adi_axi_tdd_state *st)
+{
+	u32 interface_config;
+	int ret;
+
+	ret = regmap_read(st->regs, ADI_REG_TDD_INTERFACE_DESCRIPTION,
+			  &interface_config);
+	if (ret)
+		return ret;
+
+	st->sync_count_width = FIELD_GET(ADI_TDD_SYNC_COUNT_WIDTH,
+					 interface_config);
+	st->burst_count_width = FIELD_GET(ADI_TDD_BURST_COUNT_WIDTH,
+					  interface_config);
+	st->reg_width = FIELD_GET(ADI_TDD_REG_WIDTH, interface_config);
+	st->sync_external_cdc = ADI_TDD_SYNC_EXTERNAL_CDC & interface_config;
+	st->sync_external = ADI_TDD_SYNC_EXTERNAL & interface_config;
+	st->sync_internal = ADI_TDD_SYNC_INTERNAL & interface_config;
+	st->channel_count = FIELD_GET(ADI_TDD_CHANNEL_COUNT,
+				      interface_config) + 1;
+
+	if (!st->burst_count_width || !st->reg_width)
+		return -EINVAL;
+
+	st->sync_count_mask = GENMASK_ULL(st->sync_count_width - 1, 0);
+	st->burst_count_mask = GENMASK_ULL(st->burst_count_width - 1, 0);
+	st->reg_mask = GENMASK_ULL(st->reg_width - 1, 0);
+
+	return ret;
+}
+
+#define __TDD_ATTR(_name, _id, _channel, _mode)                         \
+	{								\
+		.attr = __ATTR(_name, _mode, adi_axi_tdd_show,          \
+				adi_axi_tdd_store),                     \
+		.id = _id,                                              \
+		.channel = _channel                                     \
+	}
+
+#define TDD_ATTR(_name, _id, _mode)                                     \
+	struct adi_axi_tdd_attribute dev_attr_##_name =                 \
+		__TDD_ATTR(_name, _id, 0, _mode)                        \
+
+static const TDD_ATTR(version, ADI_TDD_ATTR_VERSION, 0444);
+static const TDD_ATTR(core_id, ADI_TDD_ATTR_CORE_ID, 0444);
+static const TDD_ATTR(scratch, ADI_TDD_ATTR_SCRATCH, 0644);
+static const TDD_ATTR(magic, ADI_TDD_ATTR_MAGIC, 0444);
+
+static const TDD_ATTR(sync_soft, ADI_TDD_ATTR_SYNC_SOFT, 0200);
+static const TDD_ATTR(sync_external, ADI_TDD_ATTR_SYNC_EXT, 0644);
+static const TDD_ATTR(sync_internal, ADI_TDD_ATTR_SYNC_INT, 0644);
+static const TDD_ATTR(sync_reset, ADI_TDD_ATTR_SYNC_RST, 0644);
+static const TDD_ATTR(enable, ADI_TDD_ATTR_ENABLE, 0644);
+
+static const TDD_ATTR(burst_count, ADI_TDD_ATTR_BURST_COUNT, 0644);
+static const TDD_ATTR(startup_delay_raw, ADI_TDD_ATTR_STARTUP_DELAY_RAW, 0644);
+static const TDD_ATTR(startup_delay_ms, ADI_TDD_ATTR_STARTUP_DELAY_MS, 0644);
+static const TDD_ATTR(frame_length_raw, ADI_TDD_ATTR_FRAME_LENGTH_RAW, 0644);
+static const TDD_ATTR(frame_length_ms, ADI_TDD_ATTR_FRAME_LENGTH_MS, 0644);
+static const TDD_ATTR(internal_sync_period_raw,
+		      ADI_TDD_ATTR_INTERNAL_SYNC_PERIOD_RAW, 0644);
+static const TDD_ATTR(internal_sync_period_ms,
+		      ADI_TDD_ATTR_INTERNAL_SYNC_PERIOD_MS, 0644);
+
+static const TDD_ATTR(state, ADI_TDD_ATTR_STATE, 0444);
+
+static const struct attribute *adi_axi_tdd_base_attributes[] = {
+	&dev_attr_version.attr.attr,
+	&dev_attr_core_id.attr.attr,
+	&dev_attr_scratch.attr.attr,
+	&dev_attr_magic.attr.attr,
+	&dev_attr_sync_soft.attr.attr,
+	&dev_attr_sync_external.attr.attr,
+	&dev_attr_sync_internal.attr.attr,
+	&dev_attr_sync_reset.attr.attr,
+	&dev_attr_enable.attr.attr,
+	&dev_attr_burst_count.attr.attr,
+	&dev_attr_startup_delay_raw.attr.attr,
+	&dev_attr_startup_delay_ms.attr.attr,
+	&dev_attr_frame_length_raw.attr.attr,
+	&dev_attr_frame_length_ms.attr.attr,
+	&dev_attr_internal_sync_period_raw.attr.attr,
+	&dev_attr_internal_sync_period_ms.attr.attr,
+	&dev_attr_state.attr.attr,
+	/* NOT TERMINATED */
+};
+
+static const char * const channel_names[] = {
+	"out_channel%u_enable", "out_channel%u_polarity",
+	"out_channel%u_on_raw", "out_channel%u_off_raw",
+	"out_channel%u_on_ms", "out_channel%u_off_ms"
+};
+
+static const enum adi_axi_tdd_attribute_id channel_ids[] = {
+	ADI_TDD_ATTR_CHANNEL_ENABLE, ADI_TDD_ATTR_CHANNEL_POLARITY,
+	ADI_TDD_ATTR_CHANNEL_ON_RAW, ADI_TDD_ATTR_CHANNEL_OFF_RAW,
+	ADI_TDD_ATTR_CHANNEL_ON_MS, ADI_TDD_ATTR_CHANNEL_OFF_MS
+};
+
+static int adi_axi_tdd_init_sysfs(struct platform_device *pdev,
+				  struct adi_axi_tdd_state *st)
+{
+	size_t base_attr_count = ARRAY_SIZE(adi_axi_tdd_base_attributes);
+	size_t attribute_count = base_attr_count + 6 * st->channel_count + 1;
+	struct adi_axi_tdd_attribute *channel_attributes;
+	struct adi_axi_tdd_attribute *channel_iter;
+	struct attribute_group *attr_group;
+	struct attribute **tdd_attrs;
+	u32 i, j;
+
+	channel_attributes = devm_kcalloc(&pdev->dev, 6 * st->channel_count,
+					  sizeof(*channel_attributes),
+					  GFP_KERNEL);
+	if (!channel_attributes)
+		return -ENOMEM;
+
+	tdd_attrs = devm_kcalloc(&pdev->dev, attribute_count,
+				 sizeof(*tdd_attrs), GFP_KERNEL);
+	if (!tdd_attrs)
+		return -ENOMEM;
+
+	memcpy(tdd_attrs, adi_axi_tdd_base_attributes,
+	       sizeof(adi_axi_tdd_base_attributes));
+
+	channel_iter = channel_attributes;
+
+	for (i = 0; i < st->channel_count; i++) {
+		for (j = 0; j < ARRAY_SIZE(channel_names); j++) {
+			snprintf(channel_iter->name,
+				 sizeof(channel_iter->name), channel_names[j],
+				 i);
+			channel_iter->id = channel_ids[j];
+			channel_iter->channel = i;
+			channel_iter->attr.attr.name = channel_iter->name;
+			channel_iter->attr.attr.mode = 0644;
+			channel_iter->attr.show = adi_axi_tdd_show;
+			channel_iter->attr.store = adi_axi_tdd_store;
+
+			tdd_attrs[base_attr_count + 6 * i + j] =
+				&channel_iter->attr.attr;
+			channel_iter++;
+		}
+	}
+
+	attr_group = devm_kzalloc(&pdev->dev, sizeof(attr_group), GFP_KERNEL);
+	if (!attr_group)
+		return -ENOMEM;
+
+	attr_group->attrs = tdd_attrs;
+
+	return devm_device_add_group(&pdev->dev, attr_group);
+}
+
+static int adi_axi_tdd_rate_change(struct notifier_block *nb,
+				   unsigned long flags, void *data)
+{
+	struct adi_axi_tdd_clk *clk =
+		container_of(nb, struct adi_axi_tdd_clk, nb);
+	struct clk_notifier_data *cnd = data;
+
+	/* cache the new rate */
+	WRITE_ONCE(clk->rate, cnd->new_rate);
+
+	return NOTIFY_OK;
+}
+
+static void adi_axi_tdd_clk_notifier_unreg(void *data)
+{
+	struct adi_axi_tdd_clk *clk = data;
+
+	clk_notifier_unregister(clk->clk, &clk->nb);
+}
+
+static int adi_axi_tdd_probe(struct platform_device *pdev)
+{
+	unsigned int expected_version, version, data;
+	struct adi_axi_tdd_state *st;
+	struct clk *aclk;
+	int ret;
+
+	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(st->base))
+		return PTR_ERR(st->base);
+
+	platform_set_drvdata(pdev, st);
+
+	aclk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
+	if (IS_ERR(aclk))
+		return PTR_ERR(aclk);
+
+	st->clk.clk = devm_clk_get_enabled(&pdev->dev, "intf_clk");
+	if (IS_ERR(st->clk.clk))
+		return PTR_ERR(st->clk.clk);
+
+	st->clk.rate = clk_get_rate(st->clk.clk);
+	st->clk.nb.notifier_call = adi_axi_tdd_rate_change;
+	ret = clk_notifier_register(st->clk.clk, &st->clk.nb);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       adi_axi_tdd_clk_notifier_unreg,
+				       st->clk.clk);
+	if (ret)
+		return ret;
+
+	st->regs = devm_regmap_init_mmio(&pdev->dev, st->base,
+					 &adi_axi_tdd_regmap_cfg);
+	if (IS_ERR(st->regs))
+		return PTR_ERR(st->regs);
+
+	ret = regmap_read(st->regs, ADI_AXI_REG_VERSION, &version);
+	if (ret)
+		return ret;
+
+	expected_version = ADI_AXI_PCORE_VER(2, 0, 'a');
+
+	if (ADI_AXI_PCORE_VER_MAJOR(version) !=
+	    ADI_AXI_PCORE_VER_MAJOR(expected_version))
+		return dev_err_probe(&pdev->dev,
+				     -ENODEV,
+				     "Major version mismatch between PCORE and driver. Driver expected %d.%.2d.%c, PCORE reported %d.%.2d.%c\n",
+				     ADI_AXI_PCORE_VER_MAJOR(expected_version),
+				     ADI_AXI_PCORE_VER_MINOR(expected_version),
+				     ADI_AXI_PCORE_VER_PATCH(expected_version),
+				     ADI_AXI_PCORE_VER_MAJOR(version),
+				     ADI_AXI_PCORE_VER_MINOR(version),
+				     ADI_AXI_PCORE_VER_PATCH(version));
+
+	ret = adi_axi_tdd_init_synthesis_parameters(st);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to load synthesis parameters, make sure the device is configured correctly.\n");
+
+	ret = regmap_read(st->regs, ADI_REG_TDD_CONTROL, &data);
+	if (ret)
+		return ret;
+
+	st->enabled =  data & ADI_TDD_ENABLE;
+
+	ret = adi_axi_tdd_init_sysfs(pdev, st);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to init sysfs, aborting ...\n");
+
+	dev_dbg(&pdev->dev, "Probed Analog Devices AXI TDD (%d.%.2d.%c)",
+		ADI_AXI_PCORE_VER_MAJOR(version),
+		ADI_AXI_PCORE_VER_MINOR(version),
+		ADI_AXI_PCORE_VER_PATCH(version));
+
+	return 0;
+}
+
+/* Match table for of_platform binding */
+static const struct of_device_id adi_axi_tdd_of_match[] = {
+	{ .compatible = "adi,axi-tdd-2.00.a" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adi_axi_tdd_of_match);
+
+static struct platform_driver adi_axi_tdd_driver = {
+	.driver = {
+		.name = "adi-axi-tdd",
+		.of_match_table = adi_axi_tdd_of_match,
+	},
+	.probe = adi_axi_tdd_probe,
+};
+module_platform_driver(adi_axi_tdd_driver);
+
+MODULE_AUTHOR("Eliza Balas <eliza.balas@analog.com>");
+MODULE_AUTHOR("David Winter <david.winter@analog.com>");
+MODULE_DESCRIPTION("Analog Devices TDD HDL CORE driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.25.1

