Return-Path: <linux-kernel+bounces-77495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3031686065E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10AF1F2567E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D611CD22;
	Thu, 22 Feb 2024 23:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c4FHSPiO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E420518AED;
	Thu, 22 Feb 2024 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643822; cv=none; b=pdU1x3Bbh4kAcW3+gWN/7KuM7WOMCIZrNLrse38rr9FEdFiZWLkbTjEXxgAmZJcUe+1kPdXy5P0kyIIjUH3X1w3YRUGYYN4eOQ3Y0oZJBCWfhVh4r1mYQwVKX27pX61GjBoCb7lppgD1vdzhqUxhNPMTAwOWC3xP0O18Bb8zHAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643822; c=relaxed/simple;
	bh=hpXhey2P22DSST0fTrOyxWeznQCfLOG+MQxCnLizV+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kSqLOBbnN8KpmbjJRE7mUWjBoYnU79E661toSaIbn4yyrdPHA/ei3jobpyq5q2X0prHqxGHdwEa5J0x6xcJoSitdUdyDA5tpfcPKD6we7AZRbi1puiB2t6DjHkxsFXmhmY0uqs9AmaKlrvr0mgcYWshegjQaSumG6Y+6I4bZE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c4FHSPiO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MLuSH7019915;
	Thu, 22 Feb 2024 23:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=AzSoWsq1GRLYsvZhrkELU+C2/mkvSPT+9OER08NcI0Q
	=; b=c4FHSPiOPiOFSQRkfIq3ElvxtYvbsbY9X5mAgPHqCmepP7sWjVMIPmjTuAO
	bHt463IAhgxIXsjyUP7d0eyRzO/zWVlFKcvBt5LmoPPCZw8gHEkesNU9JyITQXec
	0ptjS0zbYkbbjHj/xuiAtbgpJLroXh6lKCraOKOHgsPBHnGml9FScIPrzGN/PMBB
	3PCrxfpbBpILUpAt2+PE54fs02/WnA5ftQDOWvyLJqLWf6LoU0cJwDKd4BBl+8Ae
	7xPM6MPq3/iXmXwfvKdN00v62Ftci/4C8JA0cZ0X4JLq+jfqjcFsaq0ox8LBs/Rj
	tRcHxwZBYtvUa8c0YlYyQDYCCuA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weedkr5ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MNGV6k027681
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:31 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:16:31 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Thu, 22 Feb 2024 15:16:31 -0800
Subject: [PATCH v17 08/35] gunyah: vm_mgr: Introduce basic VM Manager
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-gunyah-v17-8-1e9da6763d38@quicinc.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
In-Reply-To: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
To: Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Murali Nalajal <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri
	<quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Philip Derrin <quic_pderrin@quicinc.com>,
        Prakruthi Deepak Heragu
	<quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Fuad
 Tabba" <tabba@google.com>,
        Sean Christopherson <seanjc@google.com>,
        "Andrew
 Morton" <akpm@linux-foundation.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
        Elliot Berman
	<quic_eberman@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KJ3uDWdFbCfNSF2X6ZwJ4I5DtSATNaar
X-Proofpoint-GUID: KJ3uDWdFbCfNSF2X6ZwJ4I5DtSATNaar
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402220178

Gunyah VM manager is a kernel moduel which exposes an interface to
userspace to load, run, and interact with other Gunyah virtual machines.
The interface is a character device at /dev/gunyah.

Add a basic VM manager driver. Upcoming patches will add more ioctls
into this driver.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Alex Elder <elder@linaro.org>
Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst |  1 +
 drivers/virt/gunyah/Makefile                       |  2 +-
 drivers/virt/gunyah/rsc_mgr.c                      | 50 +++++++++++-
 drivers/virt/gunyah/rsc_mgr.h                      |  2 +
 drivers/virt/gunyah/vm_mgr.c                       | 94 ++++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.h                       | 28 +++++++
 include/uapi/linux/gunyah.h                        | 23 ++++++
 7 files changed, 198 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 457e16f06e04d..149e3899ad785 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -136,6 +136,7 @@ Code  Seq#    Include File                                           Comments
 'F'   DD     video/sstfb.h                                           conflict!
 'G'   00-3F  drivers/misc/sgi-gru/grulib.h                           conflict!
 'G'   00-0F  xen/gntalloc.h, xen/gntdev.h                            conflict!
+'G'   00-0F  linux/gunyah.h                                          conflict!
 'H'   00-7F  linux/hiddev.h                                          conflict!
 'H'   00-0F  linux/hidraw.h                                          conflict!
 'H'   01     linux/mei.h                                             conflict!
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index c2308389f5517..ceccbbe68b380 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-gunyah_rsc_mgr-y += rsc_mgr.o
+gunyah_rsc_mgr-y += rsc_mgr.o vm_mgr.o
 
 obj-$(CONFIG_GUNYAH) += gunyah.o gunyah_rsc_mgr.o
diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
index 4ac946da0ca7f..fb0efe68f0e22 100644
--- a/drivers/virt/gunyah/rsc_mgr.c
+++ b/drivers/virt/gunyah/rsc_mgr.c
@@ -10,8 +10,10 @@
 #include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/miscdevice.h>
 
 #include "rsc_mgr.h"
+#include "vm_mgr.h"
 
 /* clang-format off */
 #define RM_RPC_API_VERSION_MASK		GENMASK(3, 0)
@@ -118,6 +120,7 @@ struct gunyah_rm_message {
  * @send_lock: synchronization to allow only one request to be sent at a time
  * @send_ready: completed when we know Tx message queue can take more messages
  * @nh: notifier chain for clients interested in RM notification messages
+ * @miscdev: /dev/gunyah
  */
 struct gunyah_rm {
 	struct device *dev;
@@ -133,6 +136,8 @@ struct gunyah_rm {
 	struct mutex send_lock;
 	struct completion send_ready;
 	struct blocking_notifier_head nh;
+
+	struct miscdevice miscdev;
 };
 
 /**
@@ -613,6 +618,36 @@ int gunyah_rm_notifier_unregister(struct gunyah_rm *rm,
 }
 EXPORT_SYMBOL_GPL(gunyah_rm_notifier_unregister);
 
+struct device *gunyah_rm_get(struct gunyah_rm *rm)
+{
+	return get_device(rm->miscdev.this_device);
+}
+EXPORT_SYMBOL_GPL(gunyah_rm_get);
+
+void gunyah_rm_put(struct gunyah_rm *rm)
+{
+	put_device(rm->miscdev.this_device);
+}
+EXPORT_SYMBOL_GPL(gunyah_rm_put);
+
+static long gunyah_dev_ioctl(struct file *filp, unsigned int cmd,
+			     unsigned long arg)
+{
+	struct miscdevice *miscdev = filp->private_data;
+	struct gunyah_rm *rm = container_of(miscdev, struct gunyah_rm, miscdev);
+
+	return gunyah_dev_vm_mgr_ioctl(rm, cmd, arg);
+}
+
+static const struct file_operations gunyah_dev_fops = {
+	/* clang-format off */
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= gunyah_dev_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
+	.llseek		= noop_llseek,
+	/* clang-format on */
+};
+
 static int gunyah_platform_probe_capability(struct platform_device *pdev,
 					    int idx,
 					    struct gunyah_resource *ghrsc)
@@ -699,7 +734,19 @@ static int gunyah_rm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return 0;
+	rm->miscdev.parent = &pdev->dev;
+	rm->miscdev.name = "gunyah";
+	rm->miscdev.minor = MISC_DYNAMIC_MINOR;
+	rm->miscdev.fops = &gunyah_dev_fops;
+
+	return misc_register(&rm->miscdev);
+}
+
+static void gunyah_rm_remove(struct platform_device *pdev)
+{
+	struct gunyah_rm *rm = platform_get_drvdata(pdev);
+
+	misc_deregister(&rm->miscdev);
 }
 
 static const struct of_device_id gunyah_rm_of_match[] = {
@@ -710,6 +757,7 @@ MODULE_DEVICE_TABLE(of, gunyah_rm_of_match);
 
 static struct platform_driver gunyah_rm_driver = {
 	.probe = gunyah_rm_probe,
+	.remove_new = gunyah_rm_remove,
 	.driver = {
 		.name = "gunyah_rsc_mgr",
 		.of_match_table = gunyah_rm_of_match,
diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index 48b69dbf2190b..21318ef25040c 100644
--- a/drivers/virt/gunyah/rsc_mgr.h
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -17,6 +17,8 @@ int gunyah_rm_notifier_register(struct gunyah_rm *rm,
 				struct notifier_block *nb);
 int gunyah_rm_notifier_unregister(struct gunyah_rm *rm,
 				  struct notifier_block *nb);
+struct device *gunyah_rm_get(struct gunyah_rm *rm);
+void gunyah_rm_put(struct gunyah_rm *rm);
 
 
 int gunyah_rm_call(struct gunyah_rm *rsc_mgr, u32 message_id,
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
new file mode 100644
index 0000000000000..e9dff733e35ef
--- /dev/null
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "gunyah_vm_mgr: " fmt
+
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+
+#include <uapi/linux/gunyah.h>
+
+#include "rsc_mgr.h"
+#include "vm_mgr.h"
+
+static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gunyah_rm *rm)
+{
+	struct gunyah_vm *ghvm;
+
+	ghvm = kzalloc(sizeof(*ghvm), GFP_KERNEL);
+	if (!ghvm)
+		return ERR_PTR(-ENOMEM);
+
+	ghvm->parent = gunyah_rm_get(rm);
+	ghvm->rm = rm;
+
+	return ghvm;
+}
+
+static int gunyah_vm_release(struct inode *inode, struct file *filp)
+{
+	struct gunyah_vm *ghvm = filp->private_data;
+
+	gunyah_rm_put(ghvm->rm);
+	kfree(ghvm);
+	return 0;
+}
+
+static const struct file_operations gunyah_vm_fops = {
+	.owner = THIS_MODULE,
+	.release = gunyah_vm_release,
+	.llseek = noop_llseek,
+};
+
+static long gunyah_dev_ioctl_create_vm(struct gunyah_rm *rm, unsigned long arg)
+{
+	struct gunyah_vm *ghvm;
+	struct file *file;
+	int fd, err;
+
+	/* arg reserved for future use. */
+	if (arg)
+		return -EINVAL;
+
+	ghvm = gunyah_vm_alloc(rm);
+	if (IS_ERR(ghvm))
+		return PTR_ERR(ghvm);
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		err = fd;
+		goto err_destroy_vm;
+	}
+
+	file = anon_inode_getfile("gunyah-vm", &gunyah_vm_fops, ghvm, O_RDWR);
+	if (IS_ERR(file)) {
+		err = PTR_ERR(file);
+		goto err_put_fd;
+	}
+
+	fd_install(fd, file);
+
+	return fd;
+
+err_put_fd:
+	put_unused_fd(fd);
+err_destroy_vm:
+	gunyah_rm_put(ghvm->rm);
+	kfree(ghvm);
+	return err;
+}
+
+long gunyah_dev_vm_mgr_ioctl(struct gunyah_rm *rm, unsigned int cmd,
+			     unsigned long arg)
+{
+	switch (cmd) {
+	case GUNYAH_CREATE_VM:
+		return gunyah_dev_ioctl_create_vm(rm, arg);
+	default:
+		return -ENOTTY;
+	}
+}
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
new file mode 100644
index 0000000000000..50790d4026765
--- /dev/null
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _GUNYAH_VM_MGR_PRIV_H
+#define _GUNYAH_VM_MGR_PRIV_H
+
+#include <linux/device.h>
+
+#include <uapi/linux/gunyah.h>
+
+#include "rsc_mgr.h"
+
+long gunyah_dev_vm_mgr_ioctl(struct gunyah_rm *rm, unsigned int cmd,
+			     unsigned long arg);
+
+/**
+ * struct gunyah_vm - Main representation of a Gunyah Virtual machine
+ * @rm: Pointer to the resource manager struct to make RM calls
+ * @parent: For logging
+ */
+struct gunyah_vm {
+	struct gunyah_rm *rm;
+	struct device *parent;
+};
+
+#endif
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
new file mode 100644
index 0000000000000..ac338ec4b85dd
--- /dev/null
+++ b/include/uapi/linux/gunyah.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _UAPI_LINUX_GUNYAH_H
+#define _UAPI_LINUX_GUNYAH_H
+
+/*
+ * Userspace interface for /dev/gunyah - gunyah based virtual machine
+ */
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define GUNYAH_IOCTL_TYPE 'G'
+
+/*
+ * ioctls for /dev/gunyah fds:
+ */
+#define GUNYAH_CREATE_VM _IO(GUNYAH_IOCTL_TYPE, 0x0) /* Returns a Gunyah VM fd */
+
+#endif

-- 
2.34.1


