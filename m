Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127347EE447
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345077AbjKPP3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjKPP3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:29:25 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA95C19B;
        Thu, 16 Nov 2023 07:29:18 -0800 (PST)
X-UUID: e3e842ec849411ee8051498923ad61e6-20231116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=cHCc0dgIp1tvqokRtVY/f9hYcwcbYd2AAZAeKbyiUi0=;
        b=aaq3GOVHb0+r72enwdamLZqPAXR65IR2knj8dMsIdz8wXCoC+1LrzgjgRqq5xnDmoa+E9paczH/KY/bwtWbCyyfkMeaDM1gAN8izcKZfp1i37VWYVpMDHHse7a9iLAESrYT5zK71LZtOfV7JN19phznm6YAVtkhACvnKdOcjwDU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:6cc3bf1b-12d5-4261-ba27-66c0da07bff9,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:364b77b,CLOUDID:cf392460-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e3e842ec849411ee8051498923ad61e6-20231116
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1594361572; Thu, 16 Nov 2023 23:29:10 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 16 Nov 2023 23:29:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 16 Nov 2023 23:29:09 +0800
From:   Yi-De Wu <yi-de.wu@mediatek.com>
To:     Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Yi-De Wu <yi-de.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Arnd Bergmann <arnd@arndb.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        David Bradil <dbrazdil@google.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        "My Chuang" <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        Willix Yeh <chi-shen.yeh@mediatek.com>,
        "Kevenny Hsieh" <kevenny.hsieh@mediatek.com>
Subject: [PATCH v7 03/16] virt: geniezone: Add GenieZone hypervisor driver
Date:   Thu, 16 Nov 2023 23:27:43 +0800
Message-ID: <20231116152756.4250-4-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231116152756.4250-1-yi-de.wu@mediatek.com>
References: <20231116152756.4250-1-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.609800-8.000000
X-TMASE-MatchedRID: Sr5xfaOZ+q/PwZWTvltloQI0yP/uoH+DUAjrAJWsTe9mU223IIioZfb9
        MQK6DQClvfKrrb4bmIqy7ec+ITUwM2eIEG00SdU9drnuu4cCcfF/aDoolm3GXWJkJOQVCIpwMKw
        CZ7huGiG36SL29gBZ5pCCPgbCpGAQEx7gYK5Baw8mZusHWPhfCgXBq8VnFhCkGoH7Aor25l4faH
        aH7SYxz5w9wMcKngv65JZWpbmrOY42fA1oT3w9vBes/RxhysDbO69hrW/YgWHRziMbBeTI+Tt3v
        VezfYEfTdn5Fl2oZyZY/xqzfORJ/3+cOjB/YDBsE0Q83A2vD+sikU4xQFgb7nwqSr02aA0dg7M3
        17/33cEKYu/xaKWCX6fkJPeWEebO8d2M04iWy/IdxBAG5/hkW0Dwj88nLgRT8cWgFw6wp7PJWfh
        nQliz3tm7+6JBp8fEN3vA/dbJqUbvk9E0156d6HuzDvI75j0sWwKGivsEuI1aW2Ktn+I8/l0E/8
        jA12YdJmL4F1ztDueAMuqetGVetnyef22ep6XYymsk/wUE4hoD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.609800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: DF01F509FD6BDEDFAA984D577C4E207CF8CBC55B03CD9E17829135B2534F62662000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>

GenieZone hypervisor(gzvm) is a type-1 hypervisor that supports various
virtual machine types and provides security features such as TEE-like
scenarios and secure boot. It can create guest VMs for security use
cases and has virtualization capabilities for both platform and
interrupt. Although the hypervisor can be booted independently, it
requires the assistance of GenieZone hypervisor kernel driver(gzvm-ko)
to leverage the ability of Linux kernel for vCPU scheduling, memory
management, inter-VM communication and virtio backend support.

Add the basic hypervisor driver. Subsequent patches will add more
supported features to this driver.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 MAINTAINERS                             |  3 +
 arch/arm64/Kbuild                       |  1 +
 arch/arm64/geniezone/Makefile           |  9 +++
 arch/arm64/geniezone/gzvm_arch_common.h | 37 ++++++++++
 arch/arm64/geniezone/vm.c               | 40 +++++++++++
 drivers/virt/Kconfig                    |  2 +
 drivers/virt/geniezone/Kconfig          | 16 +++++
 drivers/virt/geniezone/Makefile         | 10 +++
 drivers/virt/geniezone/gzvm_main.c      | 89 +++++++++++++++++++++++++
 include/linux/gzvm_drv.h                | 25 +++++++
 10 files changed, 232 insertions(+)
 create mode 100644 arch/arm64/geniezone/Makefile
 create mode 100644 arch/arm64/geniezone/gzvm_arch_common.h
 create mode 100644 arch/arm64/geniezone/vm.c
 create mode 100644 drivers/virt/geniezone/Kconfig
 create mode 100644 drivers/virt/geniezone/Makefile
 create mode 100644 drivers/virt/geniezone/gzvm_main.c
 create mode 100644 include/linux/gzvm_drv.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e64e510bf95..49eba202ce1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8948,6 +8948,9 @@ M:	Ze-Yu Wang <ze-yu.wang@mediatek.com>
 M:	Yi-De Wu <yi-de.wu@mediatek.com>
 F:	Documentation/devicetree/bindings/hypervisor/mediatek,geniezone-hyp.yaml
 F:	Documentation/virt/geniezone/
+F:	arch/arm64/geniezone/
+F:	drivers/virt/geniezone/
+F:	include/linux/gzvm_drv.h
 
 GENWQE (IBM Generic Workqueue Card)
 M:	Frank Haverkamp <haver@linux.ibm.com>
diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
index 5bfbf7d79c99..0c3cca572919 100644
--- a/arch/arm64/Kbuild
+++ b/arch/arm64/Kbuild
@@ -4,6 +4,7 @@ obj-$(CONFIG_KVM)	+= kvm/
 obj-$(CONFIG_XEN)	+= xen/
 obj-$(subst m,y,$(CONFIG_HYPERV))	+= hyperv/
 obj-$(CONFIG_CRYPTO)	+= crypto/
+obj-$(CONFIG_MTK_GZVM)	+= geniezone/
 
 # for cleaning
 subdir- += boot
diff --git a/arch/arm64/geniezone/Makefile b/arch/arm64/geniezone/Makefile
new file mode 100644
index 000000000000..2957898cdd05
--- /dev/null
+++ b/arch/arm64/geniezone/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Main Makefile for gzvm, this one includes drivers/virt/geniezone/Makefile
+#
+include $(srctree)/drivers/virt/geniezone/Makefile
+
+gzvm-y += vm.o
+
+obj-$(CONFIG_MTK_GZVM) += gzvm.o
diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
new file mode 100644
index 000000000000..10037013ab91
--- /dev/null
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#ifndef __GZVM_ARCH_COMMON_H__
+#define __GZVM_ARCH_COMMON_H__
+
+#include <linux/arm-smccc.h>
+
+enum {
+	GZVM_FUNC_PROBE = 12,
+	NR_GZVM_FUNC,
+};
+
+#define SMC_ENTITY_MTK			59
+#define GZVM_FUNCID_START		(0x1000)
+#define GZVM_HCALL_ID(func)						\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32,	\
+			   SMC_ENTITY_MTK, (GZVM_FUNCID_START + (func)))
+
+#define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
+
+/**
+ * gzvm_hypcall_wrapper() - the wrapper for hvc calls
+ * @a0-a7: arguments passed in registers 0 to 7
+ * @res: result values from registers 0 to 3
+ *
+ * Return: The wrapper helps caller to convert geniezone errno to Linux errno.
+ */
+int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1,
+			 unsigned long a2, unsigned long a3,
+			 unsigned long a4, unsigned long a5,
+			 unsigned long a6, unsigned long a7,
+			 struct arm_smccc_res *res);
+
+#endif /* __GZVM_ARCH_COMMON_H__ */
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
new file mode 100644
index 000000000000..aa2d08b9fa88
--- /dev/null
+++ b/arch/arm64/geniezone/vm.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/err.h>
+#include <linux/uaccess.h>
+
+#include <linux/gzvm_drv.h>
+#include "gzvm_arch_common.h"
+
+/**
+ * gzvm_hypcall_wrapper() - the wrapper for hvc calls
+ * @a0-a7: arguments passed in registers 0 to 7
+ * @res: result values from registers 0 to 3
+ *
+ * Return: The wrapper helps caller to convert geniezone errno to Linux errno.
+ */
+int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1,
+			 unsigned long a2, unsigned long a3,
+			 unsigned long a4, unsigned long a5,
+			 unsigned long a6, unsigned long a7,
+			 struct arm_smccc_res *res)
+{
+	arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res);
+	return gzvm_err_to_errno(res->a0);
+}
+
+int gzvm_arch_probe(void)
+{
+	struct arm_smccc_res res;
+	int ret;
+
+	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_PROBE, 0, 0, 0, 0, 0, 0, 0, &res);
+	if (ret)
+		return -ENXIO;
+
+	return 0;
+}
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 40129b6f0eca..b4e9bddbcee7 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -50,4 +50,6 @@ source "drivers/virt/acrn/Kconfig"
 
 source "drivers/virt/coco/Kconfig"
 
+source "drivers/virt/geniezone/Kconfig"
+
 endif
diff --git a/drivers/virt/geniezone/Kconfig b/drivers/virt/geniezone/Kconfig
new file mode 100644
index 000000000000..2643fb8913cc
--- /dev/null
+++ b/drivers/virt/geniezone/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config MTK_GZVM
+	tristate "GenieZone Hypervisor driver for guest VM operation"
+	depends on ARM64
+	help
+	  This driver, gzvm, enables to run guest VMs on MTK GenieZone
+	  hypervisor. It exports kvm-like interfaces for VMM (e.g., crosvm) in
+	  order to operate guest VMs on GenieZone hypervisor.
+
+	  GenieZone hypervisor now only supports MediaTek SoC and arm64
+	  architecture.
+
+	  Select M if you want it be built as a module (gzvm.ko).
+
+	  If unsure, say N.
diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
new file mode 100644
index 000000000000..8c1f0053e773
--- /dev/null
+++ b/drivers/virt/geniezone/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for GenieZone driver, this file should be include in arch's
+# to avoid two ko being generated.
+#
+
+GZVM_DIR ?= ../../../drivers/virt/geniezone
+
+gzvm-y := $(GZVM_DIR)/gzvm_main.o
+
diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geniezone/gzvm_main.c
new file mode 100644
index 000000000000..f7d4f0646d97
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_main.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/kdev_t.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/gzvm_drv.h>
+
+/**
+ * gzvm_err_to_errno() - Convert geniezone return value to standard errno
+ *
+ * @err: Return value from geniezone function return
+ *
+ * Return: Standard errno
+ */
+int gzvm_err_to_errno(unsigned long err)
+{
+	int gz_err = (int)err;
+
+	switch (gz_err) {
+	case 0:
+		return 0;
+	case ERR_NO_MEMORY:
+		return -ENOMEM;
+	case ERR_NOT_SUPPORTED:
+		return -EOPNOTSUPP;
+	case ERR_NOT_IMPLEMENTED:
+		return -EOPNOTSUPP;
+	case ERR_FAULT:
+		return -EFAULT;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static const struct file_operations gzvm_chardev_ops = {
+	.llseek		= noop_llseek,
+};
+
+static struct miscdevice gzvm_dev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = KBUILD_MODNAME,
+	.fops = &gzvm_chardev_ops,
+};
+
+static int gzvm_drv_probe(struct platform_device *pdev)
+{
+	if (gzvm_arch_probe() != 0) {
+		dev_err(&pdev->dev, "Not found available conduit\n");
+		return -ENODEV;
+	}
+
+	return misc_register(&gzvm_dev);
+}
+
+static int gzvm_drv_remove(struct platform_device *pdev)
+{
+	misc_deregister(&gzvm_dev);
+	return 0;
+}
+
+static const struct of_device_id gzvm_of_match[] = {
+	{ .compatible = "mediatek,geniezone-hyp" },
+	{/* sentinel */},
+};
+
+static struct platform_driver gzvm_driver = {
+	.probe = gzvm_drv_probe,
+	.remove = gzvm_drv_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.owner = THIS_MODULE,
+		.of_match_table = gzvm_of_match,
+	},
+};
+
+module_platform_driver(gzvm_driver);
+
+MODULE_DEVICE_TABLE(of, gzvm_of_match);
+MODULE_AUTHOR("MediaTek");
+MODULE_DESCRIPTION("GenieZone interface for VMM");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
new file mode 100644
index 000000000000..907f2f984de9
--- /dev/null
+++ b/include/linux/gzvm_drv.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#ifndef __GZVM_DRV_H__
+#define __GZVM_DRV_H__
+
+/*
+ * These are the definitions of APIs between GenieZone hypervisor and driver,
+ * there's no need to be visible to uapi. Furthermore, we need GenieZone
+ * specific error code in order to map to Linux errno
+ */
+#define NO_ERROR                (0)
+#define ERR_NO_MEMORY           (-5)
+#define ERR_NOT_SUPPORTED       (-24)
+#define ERR_NOT_IMPLEMENTED     (-27)
+#define ERR_FAULT               (-40)
+
+int gzvm_err_to_errno(unsigned long err);
+
+/* arch-dependant functions */
+int gzvm_arch_probe(void);
+
+#endif /* __GZVM_DRV_H__ */
-- 
2.18.0

