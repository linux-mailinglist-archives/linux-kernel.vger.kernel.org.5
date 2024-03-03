Return-Path: <linux-kernel+bounces-89835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1C486F643
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650F3286640
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6676EB49;
	Sun,  3 Mar 2024 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cSTPbv3L"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF16E600;
	Sun,  3 Mar 2024 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709484847; cv=none; b=OKaZYx044eE3xnO0oG6KenI2/l6OyX6AjdD22Fb/k0GhvT32WGFmKR2dzBgT32Jx8sKLl8JMRAmee1OjQQfNJWGyNYhfPocSxh4OyIRy7rybx6XQbTmZ0nXHe0noHQTTn7IkxT2zr0+NoWrf7gCqH+NJ/QU2nyoLUmtEMFnJC88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709484847; c=relaxed/simple;
	bh=JskG7gel/nOBzFWgnCVEU9uhz+EeTgUqBiGAOhtANwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lZlCQyS60Y42bGSPCUpm34+mobAUJ29hu5xQxm1VuPChmOGI8kS4XGxnx5wpwC1/6xbdehCRTiLziE1BbCubxs+pb/4aEtnB4Vk9uis5lRSWhIpSIiMPaEDHUE6/5OtNhUgzjsEwLdvaIuGbzfqcvH0qFUEFRI88FP2Aq/hdKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cSTPbv3L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 423Gl2iJ009145;
	Sun, 3 Mar 2024 16:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=NxhpV3+Gw6xARAgWiPDl2GGrBru1pRsD42ClCN6jXGw
	=; b=cSTPbv3L/bIj/JaM1zxZn7YggKg6MvxAQPGFePR7FtWq45K+vUreWvmsaPA
	iTPdMYfPrURUoVYia2dFaeJFNo1GAEePwI0tq2FBk4T+kHh/GXPyDmDKtfrM917V
	LWCbvr3BSof/cvxB19wBGlZiNQhriMt+d4328OfAHnTPEfT6GWLc4ves5GIeGRDe
	a4YtjVJs0X8Q+K1dI8iohP8ef2Oskz7MC3MOVovAQxCBiiVncZ70VW+dAUupIOKm
	aQM7NKWl3sNA+gxlgI73Mi+X4agaoVDL0OEbm+IN9Q867lqxilO0Wj8EAn7K9pli
	cbuPTgeOn/AjcAeHLKrRY1H4Wrg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wkv6whxpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Mar 2024 16:53:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 423GrhBK025958
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 3 Mar 2024 16:53:43 GMT
Received: from robotics-lnxbld034.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 3 Mar 2024 08:53:39 -0800
From: Canfeng Zhuang <quic_czhuang@quicinc.com>
Date: Mon, 4 Mar 2024 00:53:16 +0800
Subject: [PATCH 1/2] misc: qualcomm: QRC driver for Robotic SDK MCU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240304-qcom_qrc-v1-1-2a709f95fd61@quicinc.com>
References: <20240304-qcom_qrc-v1-0-2a709f95fd61@quicinc.com>
In-Reply-To: <20240304-qcom_qrc-v1-0-2a709f95fd61@quicinc.com>
To: Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic
	<dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Canfeng Zhuang <quic_czhuang@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709484815; l=23548;
 i=quic_czhuang@quicinc.com; s=20240304; h=from:subject:message-id;
 bh=JskG7gel/nOBzFWgnCVEU9uhz+EeTgUqBiGAOhtANwA=;
 b=VBNVwHh90+1RdWxnJhMvwrrV2WqDSRNMado1aVNgR5Y7+L33SvYSlYuGrmhK+4oXHVt5WETRi
 T4BuHvGmzYBC0l6CeHRZSpOzSEAFuf3PGg3DZ0SH6VbAP4U7otZt3dE
X-Developer-Key: i=quic_czhuang@quicinc.com; a=ed25519;
 pk=uQG1beHWTQyrSp8QCUkEKgprUZM/nlhxKMyUwzilvXQ=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dW1PUD87xsYd3bnTVDvVj2lJo-u2qYTL
X-Proofpoint-ORIG-GUID: dW1PUD87xsYd3bnTVDvVj2lJo-u2qYTL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-03_07,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403030141

QRC Driver support functions:
- Read data from serial device port.
- Write data to serial device port.
- Pin control reset robotic controller.

Signed-off-by: Canfeng Zhuang <quic_czhuang@quicinc.com>
---
 drivers/misc/Kconfig        |   1 +
 drivers/misc/Makefile       |   1 +
 drivers/misc/qrc/Kconfig    |  16 ++
 drivers/misc/qrc/Makefile   |   6 +
 drivers/misc/qrc/qrc_core.c | 336 ++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/qrc/qrc_core.h | 143 ++++++++++++++++++
 drivers/misc/qrc/qrc_uart.c | 345 ++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 848 insertions(+)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 4fb291f0bf7c..a43108af6fde 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -591,4 +591,5 @@ source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/uacce/Kconfig"
 source "drivers/misc/pvpanic/Kconfig"
 source "drivers/misc/mchp_pci1xxxx/Kconfig"
+source "drivers/misc/qrc/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index ea6ea5bbbc9c..ab3b2c4d99fa 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -68,3 +68,4 @@ obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
 obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
 obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
 obj-$(CONFIG_NSM)		+= nsm.o
+obj-$(CONFIG_QCOM_QRC)		+= qrc/
diff --git a/drivers/misc/qrc/Kconfig b/drivers/misc/qrc/Kconfig
new file mode 100644
index 000000000000..994985d7c320
--- /dev/null
+++ b/drivers/misc/qrc/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# QRC device driver configuration
+#
+
+menu "QCOM QRC device driver"
+
+config QCOM_QRC
+	tristate "QCOM QRC device driver for Robotic SDK MCU"
+	help
+	  This kernel configuration is used to enable robotic controller
+	  device driver. Say M here if you want to enable robotic
+	  controller device driver.
+	  When in doubt, say N.
+
+endmenu
diff --git a/drivers/misc/qrc/Makefile b/drivers/misc/qrc/Makefile
new file mode 100644
index 000000000000..da2cf81f3c59
--- /dev/null
+++ b/drivers/misc/qrc/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the QRC bus specific drivers.
+
+
+obj-$(CONFIG_QCOM_QRC)		+= qrc_core.o qrc_uart.o
diff --git a/drivers/misc/qrc/qrc_core.c b/drivers/misc/qrc/qrc_core.c
new file mode 100644
index 000000000000..5cedb050dac4
--- /dev/null
+++ b/drivers/misc/qrc/qrc_core.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* driver/misc/qrc/qrc_core.c
+ *
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/cdev.h>
+#include <linux/slab.h>
+#include <linux/poll.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
+
+#include "qrc_core.h"
+
+#define QRC_DEVICE_NAME "qrc"
+
+static dev_t qrc_devt;
+static struct class *qrc_class;
+
+static int qrc_cdev_fasync(int fd, struct file *filp, int mode)
+{
+	struct qrc_dev *qrc;
+
+	qrc = filp->private_data;
+	return fasync_helper(fd, filp, mode, &qrc->async_queue);
+}
+
+static int qrc_cdev_open(struct inode *inode, struct file *filp)
+{
+	struct qrc_dev *qrc;
+
+	qrc = container_of(inode->i_cdev, struct qrc_dev, cdev);
+	filp->private_data = qrc;
+	if (qrc->qrc_ops)
+		qrc->qrc_ops->qrcops_open(qrc);
+	return 0;
+}
+
+static int qrc_cdev_release(struct inode *inode, struct file *filp)
+{
+	struct qrc_dev *qrc;
+
+	qrc = filp->private_data;
+	if (qrc->qrc_ops)
+		qrc->qrc_ops->qrcops_close(qrc);
+
+	return 0;
+}
+
+/* GPIO control  */
+static int
+qrc_control_gpio_init(struct qrc_dev *qdev, struct device_node *node)
+{
+	int ret;
+	struct gpio_desc *qrc_boot0_gpiod;
+	struct gpio_desc *qrc_reset_gpiod;
+
+	/* QRC BOOT0 GPIO */
+	qdev->qrc_boot0_gpio = of_get_named_gpio(node,
+						 "qcom,qrc-boot-gpio", 0);
+	if (qdev->qrc_boot0_gpio < 0)
+		dev_err(qdev->dev, "qrc_boot0_gpio is not available\n");
+
+	/* UART RESET GPIO */
+	qdev->qrc_reset_gpio = of_get_named_gpio(node,
+						 "qcom,qrc-reset-gpio", 0);
+	if (qdev->qrc_reset_gpio < 0)
+		dev_err(qdev->dev, "qrc_reset_gpio is not available\n");
+
+	if (gpio_is_valid(qdev->qrc_boot0_gpio)) {
+		ret = gpio_request(qdev->qrc_boot0_gpio, "QRC_BOOT0_GPIO");
+		if (ret) {
+			dev_err(qdev->dev, "gpio request qrc_boot0_gpio failed for:%d\n",
+				qdev->qrc_boot0_gpio);
+			return ret;
+		}
+
+		ret = gpio_direction_output(qdev->qrc_boot0_gpio, 1);
+		qrc_boot0_gpiod = gpio_to_desc(qdev->qrc_boot0_gpio);
+		ret += gpiod_export(qrc_boot0_gpiod, 0);
+		if (ret) {
+			dev_err(qdev->dev, "Unable to configure GPIO%d (BOOT0)\n",
+				qdev->qrc_boot0_gpio);
+			ret = -EBUSY;
+			gpio_free(qdev->qrc_boot0_gpio);
+			return ret;
+		}
+
+		/* default config gpio status.boot=1 */
+		gpio_set_value(qdev->qrc_boot0_gpio, 1);
+	}
+
+	if (gpio_is_valid(qdev->qrc_reset_gpio)) {
+		ret = gpio_request(qdev->qrc_reset_gpio, "QRC_RESET_GPIO");
+		if (ret) {
+			dev_err(qdev->dev, "gpio request qrc_reset_gpio failed for:%d\n",
+				qdev->qrc_reset_gpio);
+			return ret;
+		}
+
+		ret = gpio_direction_output(qdev->qrc_reset_gpio, 0);
+		qrc_reset_gpiod = gpio_to_desc(qdev->qrc_reset_gpio);
+		ret += gpiod_export(qrc_reset_gpiod, 0);
+
+		if (ret) {
+			dev_err(qdev->dev, "Unable to configure GPIO%d (RESET)\n",
+				qdev->qrc_reset_gpio);
+			ret = -EBUSY;
+			gpio_free(qdev->qrc_reset_gpio);
+			return ret;
+		}
+
+		/* default config gpio status.reset=0 */
+		gpio_set_value(qdev->qrc_reset_gpio, 0);
+	}
+
+	return 0;
+}
+
+static void
+qrc_control_gpio_uninit(struct qrc_dev *qdev)
+{
+	if (gpio_is_valid(qdev->qrc_boot0_gpio))
+		gpio_free(qdev->qrc_boot0_gpio);
+
+	if (gpio_is_valid(qdev->qrc_reset_gpio))
+		gpio_free(qdev->qrc_reset_gpio);
+}
+
+static void qrc_gpio_reboot(struct qrc_dev *qdev)
+{
+	gpio_set_value(qdev->qrc_reset_gpio, 1);
+	msleep(100);
+	gpio_set_value(qdev->qrc_reset_gpio, 0);
+}
+
+static long qrc_cdev_ioctl(struct file *filp, unsigned int cmd,
+			   unsigned long arg)
+{
+	struct qrc_dev *qdev;
+	void __user *argp = (void __user *)arg;
+	unsigned int readable_size;
+
+	qdev = filp->private_data;
+	switch (cmd) {
+	case QRC_FIFO_CLEAR:
+		mutex_lock(&qdev->mutex);
+		qdev->qrc_ops->qrcops_data_clean(qdev);
+		mutex_unlock(&qdev->mutex);
+		return 0;
+	case QRC_REBOOT:
+		if (gpio_is_valid(qdev->qrc_reset_gpio)) {
+			qrc_gpio_reboot(qdev);
+			return 0;
+		} else {
+			return -EFAULT;
+		}
+	case QRC_BOOT_TO_MEM:
+		if (gpio_is_valid(qdev->qrc_boot0_gpio)) {
+			gpio_set_value(qdev->qrc_boot0_gpio, 1);
+			qrc_gpio_reboot(qdev);
+			return 0;
+		} else {
+			return -EFAULT;
+		}
+	case QRC_BOOT_TO_FLASH:
+		if (gpio_is_valid(qdev->qrc_boot0_gpio)) {
+			gpio_set_value(qdev->qrc_boot0_gpio, 0);
+			qrc_gpio_reboot(qdev);
+			return 0;
+		} else {
+			return -EFAULT;
+		}
+	case QRC_FIONREAD:
+		readable_size = qdev->qrc_ops->qrcops_data_status(qdev);
+		if (copy_to_user(argp, &readable_size, sizeof(unsigned int))) {
+			dev_err(qdev->dev, "copy_to_user failed\n");
+			return -EFAULT;
+		}
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static unsigned int qrc_cdev_poll(struct file *filp, poll_table *wait)
+{
+	unsigned int mask = 0;
+	struct qrc_dev *qrc;
+
+	qrc = filp->private_data;
+	mutex_lock(&qrc->mutex);
+
+	poll_wait(filp, &qrc->r_wait, wait);
+
+	if (qrc->qrc_ops->qrcops_data_status(qrc) != 0)
+		mask |= POLLIN | POLLRDNORM;
+
+	mutex_unlock(&qrc->mutex);
+	return mask;
+}
+
+static ssize_t qrc_cdev_read(struct file *filp, char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	int ret;
+	struct qrc_dev *qrc;
+	DECLARE_WAITQUEUE(wait, current);
+
+	qrc = filp->private_data;
+
+	mutex_lock(&qrc->mutex);
+	add_wait_queue(&qrc->r_wait, &wait);
+
+	while (qrc->qrc_ops->qrcops_data_status(qrc) == 0) {
+		if (filp->f_flags & O_NONBLOCK) {
+			ret = -EAGAIN;
+			goto out;
+		}
+		__set_current_state(TASK_INTERRUPTIBLE);
+		mutex_unlock(&qrc->mutex);
+
+		schedule();
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			goto remove;
+		}
+
+		mutex_lock(&qrc->mutex);
+	}
+
+	ret = qrc->qrc_ops->qrcops_receive(qrc, buf, count);
+
+out:
+	mutex_unlock(&qrc->mutex);
+remove:
+	remove_wait_queue(&qrc->r_wait, &wait);
+	set_current_state(TASK_RUNNING);
+	return ret;
+}
+
+static ssize_t qrc_cdev_write(struct file *filp, const char __user *buf,
+			      size_t count, loff_t *ppos)
+{
+	struct qrc_dev *qrc;
+	enum qrcdev_tx ret;
+
+	qrc = filp->private_data;
+	ret = qrc->qrc_ops->qrcops_xmit(buf, count, qrc);
+	if (ret == QRCDEV_TX_OK)
+		return count;
+
+	return 0;
+}
+
+static const struct file_operations qrc_cdev_fops = {
+	.owner = THIS_MODULE,
+	.read = qrc_cdev_read,
+	.write = qrc_cdev_write,
+	.unlocked_ioctl = qrc_cdev_ioctl,
+	.poll = qrc_cdev_poll,
+	.fasync = qrc_cdev_fasync,
+	.open = qrc_cdev_open,
+	.release = qrc_cdev_release,
+};
+
+/*-------Interface for qrc device ---------*/
+int qrc_register_device(struct qrc_dev *qdev, struct device *dev)
+{
+	int ret;
+	dev_t devt;
+
+	if (!qdev)
+		return -ENOMEM;
+
+	mutex_init(&qdev->mutex);
+	init_waitqueue_head(&qdev->r_wait);
+	init_waitqueue_head(&qdev->w_wait);
+
+	/*register cdev*/
+	qrc_class = class_create("qrc_class");
+	if (IS_ERR(qrc_class)) {
+		dev_err(dev, "failed to allocate class\n");
+		return PTR_ERR(qrc_class);
+	}
+	ret = alloc_chrdev_region(&qrc_devt, 0, 1, "qrc");
+	if (ret < 0) {
+		dev_err(dev, "failed to allocate char device region\n");
+		class_destroy(qrc_class);
+		return ret;
+	}
+
+	devt = MKDEV(MAJOR(qrc_devt), 0);
+
+	cdev_init(&qdev->cdev, &qrc_cdev_fops);
+	ret = qrc_control_gpio_init(qdev, dev->of_node);
+
+	ret = cdev_add(&qdev->cdev, devt, 1);
+	if (ret) {
+		dev_err(dev, "qrc failed to add char device\n");
+		return ret;
+	}
+
+	qdev->dev = device_create(qrc_class, dev, devt, qdev,
+				  "qrc");
+	if (IS_ERR(qdev->dev)) {
+		ret = PTR_ERR(qdev->dev);
+		goto del_cdev;
+	}
+
+	return 0;
+
+del_cdev:
+	cdev_del(&qdev->cdev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qrc_register_device);
+
+void qrc_unregister(struct qrc_dev *qdev)
+{
+	device_destroy(qrc_class, qdev->dev->devt);
+	qrc_control_gpio_uninit(qdev);
+	dev_err(qdev->dev, "qrc drv unregistered\n");
+}
+EXPORT_SYMBOL_GPL(qrc_unregister);
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. QRC Uart Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/qrc/qrc_core.h b/drivers/misc/qrc/qrc_core.h
new file mode 100644
index 000000000000..398343e43cfa
--- /dev/null
+++ b/drivers/misc/qrc/qrc_core.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* driver/misc/qrc/qrc_core.h
+ *
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _QRC_CORE_H
+#define _QRC_CORE_H
+
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/kfifo.h>
+#include <linux/sched/signal.h>
+#include <linux/uaccess.h>
+#include <linux/ioctl.h>
+
+#define QRC_NAME_SIZE 30
+#define QRC_INTERFACE_SIZE 30
+#define QRC_FIFO_SIZE	0x1000
+
+struct qrc_dev;
+
+/* IOCTL commands */
+#define QRC_IOC_MAGIC   'q'
+
+/* Clear read fifo */
+#define QRC_FIFO_CLEAR     _IO(QRC_IOC_MAGIC, 1)
+/* Reboot QRC controller */
+#define QRC_REBOOT         _IO(QRC_IOC_MAGIC, 2)
+/* QRC boot from memory */
+#define QRC_BOOT_TO_MEM	   _IO(QRC_IOC_MAGIC, 3)
+/* QRC boot from flash */
+#define QRC_BOOT_TO_FLASH  _IO(QRC_IOC_MAGIC, 4)
+/* QRC get read buffer size */
+#define QRC_FIONREAD	   _IO(QRC_IOC_MAGIC, 5)
+
+enum qrcdev_state_t {
+	__STATE_IDLE,
+	__STATE_READING,
+	__STATE_WRITING,
+};
+
+enum qrc_interface {
+	UART = 0,
+	SPI,
+};
+
+enum qrcdev_tx {
+	__QRCDEV_TX_MIN	 = INT_MIN,	/* make sure enum is signed (-1)*/
+	QRCDEV_TX_OK	 = 0x00,	/* driver took care of packet */
+	QRCDEV_TX_BUSY	 = 0x10,	/* driver tx path was busy*/
+};
+
+struct qrc_device_stats {
+	unsigned long	rx_bytes;
+	unsigned long	tx_bytes;
+	unsigned long	rx_errors;
+	unsigned long	tx_errors;
+	unsigned long	collisions;
+	unsigned long	rx_length_errors;
+	unsigned long	rx_over_errors;
+	unsigned long	rx_fifo_errors;
+};
+
+struct qrc_device_ops {
+	int		(*qrcops_init)(struct qrc_dev *dev);
+	void		(*qrcops_uninit)(struct qrc_dev *dev);
+	int		(*qrcops_open)(struct qrc_dev *dev);
+	int		(*qrcops_close)(struct qrc_dev *dev);
+	int		(*qrcops_setup)(struct qrc_dev *dev);
+	enum qrcdev_tx	(*qrcops_xmit)(const char __user  *buf,
+				       size_t data_length, struct qrc_dev *dev);
+	int		(*qrcops_receive)(struct qrc_dev *dev,
+					  char __user *buf, size_t count);
+	int		(*qrcops_data_status)
+			(struct qrc_dev *dev);
+	int		(*qrcops_config)(struct qrc_dev *dev);
+	void	(*qrcops_data_clean)(struct qrc_dev *dev);
+};
+
+/* qrc char device */
+struct qrc_dev {
+	struct qrc_device_stats stats;
+	struct qrc_device_ops *qrc_ops;		/* qrc dev ops */
+	struct mutex mutex;			/* protect kfifo access */
+	wait_queue_head_t r_wait;
+	wait_queue_head_t w_wait;
+	struct fasync_struct *async_queue;
+	struct cdev cdev;
+	struct device *dev;
+	void *data;
+	int qrc_boot0_gpio;
+	int qrc_reset_gpio;
+};
+
+/**
+ * struct qrcuart - The qrcuart device structure.
+ * @qrc_dev:  This is robotic controller device structure.
+ *                    It include interface for qrcuart.
+ * @lock: spinlock for transmitting lock.
+ * @tx_work: Flushes transmit TX buffer.
+ * @serdev: Serial device bus structure.
+ * @qrc_rx_fifo: Qrcuart receive buffer.
+ * @tx_head: String head in XMIT queue.
+ * @tx_left: Bytes left in XMIT queue.
+ * @tx_buffer: XMIT buffer.
+ * @is_open: Flag shows if the device is open.
+ * This structure is used to define robotic controller uart device.
+ */
+struct qrcuart {
+	struct qrc_dev *qrc_dev;
+	spinlock_t lock;			/* spinlock for transmitting lock */
+	struct work_struct tx_work;
+	struct serdev_device *serdev;
+	struct kfifo qrc_rx_fifo;
+	unsigned char *tx_head;
+	int tx_left;
+	unsigned char *tx_buffer;
+	bool is_open;
+};
+
+struct qrcspi {
+	struct qrc_dev *qrc_dev;
+	spinlock_t lock;			/* transmit lock */
+};
+
+static inline void qrc_set_data(struct qrc_dev *dev, void *data)
+{
+	dev->data = data;
+}
+
+static inline void *qrc_get_data(const struct qrc_dev *dev)
+{
+	return dev->data;
+}
+
+int qrc_register_device(struct qrc_dev *qdev, struct device *dev);
+void qrc_unregister(struct qrc_dev *qdev);
+
+#endif
+
diff --git a/drivers/misc/qrc/qrc_uart.c b/drivers/misc/qrc/qrc_uart.c
new file mode 100644
index 000000000000..74143d88c967
--- /dev/null
+++ b/drivers/misc/qrc/qrc_uart.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* driver/misc/qrc/qrc_uart.c
+ *
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/serdev.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include "qrc_core.h"
+
+#define QRC_RX_FIFO_SIZE 0x400
+#define QRC_TX_BUFF_SIZE 0x400
+#define QRCUART_DRV_NAME "qrcuart"
+#define QRC_DRV_VERSION "0.1.0"
+
+static int qrcuart_setup(struct qrc_dev *dev);
+
+static int
+qrc_uart_receive(struct serdev_device *serdev, const unsigned char *data,
+		 size_t count)
+{
+	struct qrcuart *qrc = serdev_device_get_drvdata(serdev);
+	struct qrc_dev *qrc_dev = qrc->qrc_dev;
+	int ret;
+
+	/* check count */
+	ret = kfifo_avail(&qrc->qrc_rx_fifo);
+	if (!ret)
+		return 0;
+
+	if (count > ret)
+		count = ret;
+
+	ret = kfifo_in(&qrc->qrc_rx_fifo, data, count);
+	if (!ret)
+		return 0;
+
+	wake_up_interruptible(&qrc_dev->r_wait);
+
+	return count;
+}
+
+/* Write out any remaining transmit buffer. Scheduled when tty is writable */
+static void qrcuart_transmit(struct work_struct *work)
+{
+	struct qrcuart *qrc = container_of(work, struct qrcuart, tx_work);
+	int written;
+
+	spin_lock_bh(&qrc->lock);
+
+	if (qrc->tx_left <= 0) {
+		/* Now serial buffer is almost free & we can start
+		 * transmission of another packet
+		 */
+		spin_unlock_bh(&qrc->lock);
+		return;
+	}
+
+	written = serdev_device_write_buf(qrc->serdev, qrc->tx_head,
+					  qrc->tx_left);
+	if (written > 0) {
+		qrc->tx_left -= written;
+		qrc->tx_head += written;
+	}
+	spin_unlock_bh(&qrc->lock);
+}
+
+/* Called by the driver when there's room for more data.
+ * Schedule the transmit.
+ */
+static void qrc_uart_wakeup(struct serdev_device *serdev)
+{
+	struct qrcuart *qrc = serdev_device_get_drvdata(serdev);
+
+	schedule_work(&qrc->tx_work);
+}
+
+static struct serdev_device_ops qrc_serdev_ops = {
+	.receive_buf = qrc_uart_receive,
+	.write_wakeup = qrc_uart_wakeup,
+};
+
+/*----------------Interface to QRC core -----------------------------*/
+
+static int qrcuart_open(struct qrc_dev *dev)
+{
+	struct qrcuart *qrc = qrc_get_data(dev);
+	struct serdev_device *serdev = qrc->serdev;
+	int ret;
+
+	if (!qrc->is_open) {
+		ret = serdev_device_open(serdev);
+		if (ret) {
+			dev_err(dev->dev, "qrcuart :Unable to open device\n");
+			return ret;
+		}
+		serdev_device_set_baudrate(serdev, 115200);
+		serdev_device_set_flow_control(serdev, false);
+		qrc->is_open = true;
+	}
+
+	return 0;
+}
+
+static int qrcuart_close(struct qrc_dev *dev)
+{
+	struct qrcuart *qrc = qrc_get_data(dev);
+	struct serdev_device *serdev = qrc->serdev;
+
+	flush_work(&qrc->tx_work);
+	spin_lock_bh(&qrc->lock);
+	qrc->tx_left = 0;
+	spin_unlock_bh(&qrc->lock);
+
+	if (qrc->is_open) {
+		serdev_device_close(serdev);
+		qrc->is_open = false;
+	}
+
+	return 0;
+}
+
+static int qrcuart_init(struct qrc_dev *dev)
+{
+	struct qrcuart *qrc = qrc_get_data(dev);
+	size_t len;
+	int ret;
+
+	/* Finish setting up the device info. */
+	len = QRC_TX_BUFF_SIZE;
+	qrc->tx_buffer = devm_kmalloc(&qrc->serdev->dev, len, GFP_KERNEL);
+
+	if (!qrc->tx_buffer)
+		return -ENOMEM;
+
+	qrc->tx_head = qrc->tx_buffer;
+	qrc->tx_left = 0;
+
+	ret = kfifo_alloc(&qrc->qrc_rx_fifo, QRC_RX_FIFO_SIZE,
+			  GFP_KERNEL);
+	if (ret)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void qrcuart_uninit(struct qrc_dev *dev)
+{
+	struct qrcuart *qrc = qrc_get_data(dev);
+
+	kfifo_free(&qrc->qrc_rx_fifo);
+}
+
+/*put data from kfifo to qrc fifo */
+static int qrcuart_receive(struct qrc_dev *dev, char __user *buf,
+			   size_t count)
+{
+	struct qrcuart *qrc = qrc_get_data(dev);
+	u32 fifo_len, trans_len;
+
+	if (!kfifo_is_empty(&qrc->qrc_rx_fifo)) {
+		fifo_len = kfifo_len(&qrc->qrc_rx_fifo);
+		if (count > fifo_len)
+			count = fifo_len;
+		if (kfifo_to_user(&qrc->qrc_rx_fifo,
+				  (void *)buf, count, &trans_len))
+			return -EFAULT;
+		return trans_len;
+	}
+	return 0;
+}
+
+static int qrcuart_data_status(struct qrc_dev *dev)
+{
+	struct qrcuart *qrc = qrc_get_data(dev);
+
+	return kfifo_len(&qrc->qrc_rx_fifo);
+}
+
+static void qrcuart_data_clean(struct qrc_dev *dev)
+{
+	struct qrcuart *qrc = qrc_get_data(dev);
+
+	kfifo_reset(&qrc->qrc_rx_fifo);
+}
+
+static enum qrcdev_tx qrcuart_xmit(const char __user  *buf,
+				   size_t data_length, struct qrc_dev *dev)
+{
+	struct qrcuart *qrc = qrc_get_data(dev);
+	struct qrc_device_stats *n_stats = &dev->stats;
+	size_t written;
+	u8 *pos;
+
+	WARN_ON(qrc->tx_left);
+
+	pos = qrc->tx_buffer + qrc->tx_left;
+	if ((data_length + qrc->tx_left) > QRC_TX_BUFF_SIZE) {
+		dev_err(dev->dev, "qrcuart transmit date overflow %ld\n", data_length);
+		return __QRCDEV_TX_MIN;
+	}
+
+	if (copy_from_user(pos, buf, data_length))
+		return __QRCDEV_TX_MIN;
+
+	pos += data_length;
+
+	spin_lock(&qrc->lock);
+
+	written = serdev_device_write_buf(qrc->serdev, qrc->tx_buffer,
+					  pos - qrc->tx_buffer);
+	if (written > 0) {
+		qrc->tx_left = (pos - qrc->tx_buffer) - written;
+		qrc->tx_head = qrc->tx_buffer + written;
+		n_stats->tx_bytes += written;
+	}
+
+	spin_unlock(&qrc->lock);
+
+	return QRCDEV_TX_OK;
+}
+
+static int qrcuart_config(struct qrc_dev *dev)
+{
+	/*baudrate,wordlength ... config*/
+	return 0;
+}
+
+static struct qrc_device_ops qrcuart_qrc_ops = {
+	.qrcops_open = qrcuart_open,
+	.qrcops_close = qrcuart_close,
+	.qrcops_init = qrcuart_init,
+	.qrcops_uninit = qrcuart_uninit,
+	.qrcops_xmit = qrcuart_xmit,
+	.qrcops_receive = qrcuart_receive,
+	.qrcops_config = qrcuart_config,
+	.qrcops_setup = qrcuart_setup,
+	.qrcops_data_status = qrcuart_data_status,
+	.qrcops_data_clean = qrcuart_data_clean,
+};
+
+static int qrcuart_setup(struct qrc_dev *dev)
+{
+	dev->qrc_ops = &qrcuart_qrc_ops;
+	return 0;
+}
+
+static int qrc_uart_probe(struct serdev_device *serdev)
+{
+	struct qrc_dev *qdev;
+	struct qrcuart *qrc;
+	int ret = 0;
+
+	qrc = kmalloc(sizeof(*qrc), GFP_KERNEL);
+	if (!qrc)
+		return -ENOMEM;
+	qdev = kmalloc(sizeof(*qdev), GFP_KERNEL);
+	if (!qdev) {
+		kfree(qrc);
+		return -ENOMEM;
+	}
+	qdev->dev = &serdev->dev;
+	qrc_set_data(qdev, qrc);
+
+	qrc->qrc_dev = qdev;
+	qrc->serdev = serdev;
+	spin_lock_init(&qrc->lock);
+	INIT_WORK(&qrc->tx_work, qrcuart_transmit);
+	qrcuart_setup(qdev);
+	ret = qrcuart_init(qdev);
+	if (ret) {
+		dev_err(qdev->dev, "qrcuart: Fail to init qrc structure\n");
+		kfree(qdev);
+		kfree(qrc);
+		return ret;
+	}
+	serdev_device_set_drvdata(serdev, qrc);
+	serdev_device_set_client_ops(serdev, &qrc_serdev_ops);
+
+	ret = serdev_device_open(serdev);
+	if (ret) {
+		dev_err(qdev->dev, "qrcuart :Unable to open device\n");
+		goto free;
+	}
+	serdev_device_close(serdev);
+	qrc->is_open = false;
+
+	ret = qrc_register_device(qdev, &serdev->dev);
+
+	if (ret) {
+		dev_err(qdev->dev, "qrcuart: Unable to register qrc device\n");
+		cancel_work_sync(&qrc->tx_work);
+		goto free;
+	}
+
+	return 0;
+
+free:
+	qrcuart_uninit(qdev);
+	kfree(qdev);
+	kfree(qrc);
+	return ret;
+}
+
+static void qrc_uart_remove(struct serdev_device *serdev)
+{
+	struct qrcuart *qrc = serdev_device_get_drvdata(serdev);
+
+	if (qrc->is_open)
+		serdev_device_close(serdev);
+
+	qrcuart_uninit(qrc->qrc_dev);
+	cancel_work_sync(&qrc->tx_work);
+	qrc_unregister(qrc->qrc_dev);
+	kfree(qrc->qrc_dev);
+	kfree(qrc);
+	dev_info(&serdev->dev, "qrcuart drv removed\n");
+}
+
+static const struct of_device_id qrc_uart_of_match[] = {
+	{ .compatible = "qcom,qrc-uart", },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, qrc_uart_of_match);
+
+static struct serdev_device_driver qrc_uart_driver = {
+	.probe = qrc_uart_probe,
+	.remove = qrc_uart_remove,
+	.driver = {
+		.name = QRCUART_DRV_NAME,
+		.of_match_table = of_match_ptr(qrc_uart_of_match),
+	},
+};
+
+module_serdev_device_driver(qrc_uart_driver);
+
+/**********************************************/
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. QRC Uart Driver");
+MODULE_LICENSE("GPL");

-- 
2.25.1


