Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75077E0E21
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 07:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbjKDGrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 02:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjKDGr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 02:47:28 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECD6D51;
        Fri,  3 Nov 2023 23:47:24 -0700 (PDT)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SMp7j5y6Hz4f3jMf;
        Sat,  4 Nov 2023 14:47:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
        by mail.maildlp.com (Postfix) with ESMTP id 234261A016E;
        Sat,  4 Nov 2023 14:47:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP4 (Coremail) with SMTP id gCh0CgDnfd3z6EVlglQtEw--.50758S5;
        Sat, 04 Nov 2023 14:47:19 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        broonie@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        frowand.list@gmail.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 -next 1/5] spi: mockup: Add SPI controller testing driver
Date:   Sat,  4 Nov 2023 14:46:46 +0800
Message-Id: <20231104064650.972687-2-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104064650.972687-1-zhangxiaoxu@huaweicloud.com>
References: <20231104064650.972687-1-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnfd3z6EVlglQtEw--.50758S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw15Cr4xAFyxur43KFyrtFb_yoW3CrWUpF
        yrJay7JrW8GF13uF1S9rW8uFy5Ww1kCayxt3yfJa4Ik3yfXFyDXa4ktryYvay5JFyDXFyU
        ZFWa9a48CFWUZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxUzUUUUUUUU
X-CM-SenderInfo: x2kd0wp0ld053x6k3tpzhluzxrxghudrp/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>

This enables SPI controller Testing driver, which provides a way to
test SPI subsystem.

This is accomplished by executing the following command:

$ echo adcxx1s 0 > /sys/class/spi_master/spi0/new_device

The name of the target driver and its chip select were used to
instantiate the device.

$ ls /sys/bus/spi/devices/spi0.0/hwmon/hwmon0/ -l
 total 0
 lrwxrwxrwx 1 root root    0 Aug 10 08:58 device -> ../../../spi0.0
 drwxr-xr-x 2 root root    0 Aug 10 08:58 power
 lrwxrwxrwx 1 root root    0 Aug 10 08:58 subsystem -> ../../../../../../../../class/hwmon
 -rw-r--r-- 1 root root 4096 Aug 10 08:58 uevent

Remove target device by executing the following command:
$ echo 0 > /sys/class/spi_master/spi0/delete_device

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 drivers/spi/Kconfig      |  12 +++
 drivers/spi/Makefile     |   1 +
 drivers/spi/spi-mockup.c | 211 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 224 insertions(+)
 create mode 100644 drivers/spi/spi-mockup.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 2c21d5b96fdc..9169081cfecb 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1218,6 +1218,18 @@ config SPI_TLE62X0
 	  sysfs interface, with each line presented as a kind of GPIO
 	  exposing both switch control and diagnostic feedback.
 
+config SPI_MOCKUP
+	tristate "SPI controller Testing Driver"
+	depends on OF
+	help
+	  This enables SPI controller testing driver, which provides a way to
+	  test SPI subsystem.
+
+	  If you do build this module, be sure to read the notes and warnings
+	  in <file:Documentation/spi/spi-mockup.rst>.
+
+	  If you don't know what to do here, definitely say N.
+
 #
 # Add new SPI protocol masters in alphabetical order above this line
 #
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 6af54842b9fa..f28074e61df9 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SPI_MEM)			+= spi-mem.o
 obj-$(CONFIG_SPI_MUX)			+= spi-mux.o
 obj-$(CONFIG_SPI_SPIDEV)		+= spidev.o
 obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
+obj-$(CONFIG_SPI_MOCKUP)		+= spi-mockup.o
 
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_ALTERA)		+= spi-altera-platform.o
diff --git a/drivers/spi/spi-mockup.c b/drivers/spi/spi-mockup.c
new file mode 100644
index 000000000000..683a0fc43f0d
--- /dev/null
+++ b/drivers/spi/spi-mockup.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SPI controller Testing Driver
+ *
+ * Copyright(c) 2022 Huawei Technologies Co., Ltd.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+
+#define MOCKUP_CHIPSELECT_MAX		8
+
+struct mockup_spi {
+	struct mutex lock;
+	struct spi_device *devs[MOCKUP_CHIPSELECT_MAX];
+};
+
+static struct spi_controller *to_spi_controller(struct device *dev)
+{
+	return container_of(dev, struct spi_controller, dev);
+}
+
+static ssize_t
+new_device_store(struct device *dev, struct device_attribute *attr,
+		 const char *buf, size_t count)
+{
+	struct spi_controller *ctrl = to_spi_controller(dev);
+	struct spi_board_info info;
+	struct mockup_spi *mock;
+	struct spi_device *spi;
+	char *blank, end;
+	int status;
+
+	memset(&info, 0, sizeof(struct spi_board_info));
+
+	blank = strchr(buf, ' ');
+	if (!blank) {
+		dev_err(dev, "%s: Extra parameters\n", "new_device");
+		return -EINVAL;
+	}
+
+	if (blank - buf > SPI_NAME_SIZE - 1) {
+		dev_err(dev, "%s: Invalid device name\n", "new_device");
+		return -EINVAL;
+	}
+
+	memcpy(info.modalias, buf, blank - buf);
+
+	status = sscanf(++blank, "%hi%c", &info.chip_select, &end);
+	if (status < 1) {
+		dev_err(dev, "%s: Can't parse SPI chipselect\n", "new_device");
+		return -EINVAL;
+	}
+
+	if (status > 1 && end != '\n') {
+		dev_err(dev, "%s: Extra parameters\n", "new_device");
+		return -EINVAL;
+	}
+
+	if (info.chip_select >= ctrl->num_chipselect) {
+		dev_err(dev, "%s: Invalid chip_select\n", "new_device");
+		return -EINVAL;
+	}
+
+	mock = spi_controller_get_devdata(ctrl);
+	mutex_lock(&mock->lock);
+
+	if (mock->devs[info.chip_select]) {
+		dev_err(dev, "%s: Chipselect %d already in use\n",
+			"new_device", info.chip_select);
+		mutex_unlock(&mock->lock);
+		return -EINVAL;
+	}
+
+	spi = spi_new_device(ctrl, &info);
+	if (!spi) {
+		mutex_unlock(&mock->lock);
+		return -ENOMEM;
+	}
+	mock->devs[info.chip_select] = spi;
+
+	mutex_unlock(&mock->lock);
+
+	dev_info(dev, "%s: Instantiated device %s at 0x%02x\n", "new_device",
+		 info.modalias, info.chip_select);
+
+	return count;
+}
+static DEVICE_ATTR_WO(new_device);
+
+static ssize_t
+delete_device_store(struct device *dev, struct device_attribute *attr,
+		    const char *buf, size_t count)
+{
+	struct spi_controller *ctrl = to_spi_controller(dev);
+	struct mockup_spi *mock;
+	struct spi_device *spi;
+	unsigned short chip;
+	char end;
+	int res;
+
+	/* Parse parameters, reject extra parameters */
+	res = sscanf(buf, "%hi%c", &chip, &end);
+	if (res < 1) {
+		dev_err(dev, "%s: Can't parse SPI address\n", "delete_device");
+		return -EINVAL;
+	}
+	if (res > 1  && end != '\n') {
+		dev_err(dev, "%s: Extra parameters\n", "delete_device");
+		return -EINVAL;
+	}
+
+	if (chip >= ctrl->num_chipselect) {
+		dev_err(dev, "%s: Invalid chip_select\n", "delete_device");
+		return -EINVAL;
+	}
+
+	mock = spi_controller_get_devdata(ctrl);
+	mutex_lock(&mock->lock);
+
+	spi = mock->devs[chip];
+	if (!spi) {
+		mutex_unlock(&mock->lock);
+		dev_err(dev, "%s: Invalid chip_select\n", "delete_device");
+		return -ENOENT;
+	}
+
+	dev_info(dev, "%s: Deleting device %s at 0x%02hx\n", "delete_device",
+		 dev_name(&spi->dev), chip);
+
+	spi_unregister_device(spi);
+	mock->devs[chip] = NULL;
+
+	mutex_unlock(&mock->lock);
+
+	return count;
+}
+static DEVICE_ATTR_WO(delete_device);
+
+static struct attribute *spi_mockup_attrs[] = {
+	&dev_attr_new_device.attr,
+	&dev_attr_delete_device.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(spi_mockup);
+
+static int spi_mockup_transfer(struct spi_controller *ctrl,
+			       struct spi_message *msg)
+{
+	msg->status = 0;
+	spi_finalize_current_message(ctrl);
+
+	return 0;
+}
+
+static int spi_mockup_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct mockup_spi *mock;
+	struct spi_controller *ctrl;
+
+	ctrl = spi_alloc_host(&pdev->dev, sizeof(struct mockup_spi));
+	if (!ctrl) {
+		pr_err("failed to alloc spi controller\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(pdev, ctrl);
+
+	ctrl->dev.of_node = pdev->dev.of_node;
+	ctrl->dev.groups = spi_mockup_groups;
+	ctrl->num_chipselect = MOCKUP_CHIPSELECT_MAX;
+	ctrl->mode_bits = SPI_MODE_USER_MASK;
+	ctrl->bus_num = 0;
+	ctrl->transfer_one_message = spi_mockup_transfer;
+
+	mock = spi_controller_get_devdata(ctrl);
+	mutex_init(&mock->lock);
+
+	ret = devm_spi_register_controller(&pdev->dev, ctrl);
+	if (ret) {
+		spi_controller_put(ctrl);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id spi_mockup_match[] = {
+	{ .compatible = "spi-mockup", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, spi_mockup_match);
+
+static struct platform_driver spi_mockup_driver = {
+	.probe = spi_mockup_probe,
+	.driver = {
+		.name = "spi-mockup",
+		.of_match_table = spi_mockup_match,
+	},
+};
+module_platform_driver(spi_mockup_driver);
+
+MODULE_AUTHOR("Wei Yongjun <weiyongjun1@huawei.com>");
+MODULE_DESCRIPTION("SPI controller Testing Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

