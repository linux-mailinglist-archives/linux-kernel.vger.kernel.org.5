Return-Path: <linux-kernel+bounces-151774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC488AB3BA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE2E286B28
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB2913D502;
	Fri, 19 Apr 2024 16:47:57 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ED213D24A;
	Fri, 19 Apr 2024 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545276; cv=none; b=s/8DbQqMh2bmr9fvIWFYy1z8h4EcYBS3tVI3zUrdVPOC73ygL1B1p9TlFaAHWH4N3K6ELcgIfJzO3Ieu9CQWRlmQLMu4Mt+o3NZszEvHQ/GMcXjnKRJB3dUCnoLVVbrWROt7HJpT/KlI8oZbrpMiwvM/wPiuJfsBx4T7Ho5H39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545276; c=relaxed/simple;
	bh=/g4f7qp6hur4avI/RS/oiYOYgMpH/1YNdrDGuVqvUUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1Feqq6BXWrtSIuYmpjBZxXNy1HR79xnifwbukWqcS17i2/gbV4a4ohWaTMOj7klMmqaCYtmDyoAvTLRM1O0ZQPsAHCVslLmPWQPQSluXK8DPX9kAxm858BvDmulmUR21i227EOW6zxCilpJM9bnGn+ere8SNp1x2dxmGyhkT9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VLgYf2Cfyz6K8x1;
	Sat, 20 Apr 2024 00:47:50 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id AC42F140B55;
	Sat, 20 Apr 2024 00:47:51 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 17:47:50 +0100
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH v8 10/10] ras: scrub: ACPI RAS2: Add memory ACPI RAS2 driver
Date: Sat, 20 Apr 2024 00:47:19 +0800
Message-ID: <20240419164720.1765-11-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240419164720.1765-1-shiju.jose@huawei.com>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Memory ACPI RAS2 driver binds to the platform device add by the
ACPI RAS2 table parser.

Driver uses a PCC subspace for communicating with the ACPI compliant
platform to provide control of memory scrub parameters via the scrub
subsystem.

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/scrub/scrub-configure.rst |  33 +++
 drivers/ras/Kconfig                     |  10 +
 drivers/ras/Makefile                    |   1 +
 drivers/ras/acpi_ras2.c                 | 358 ++++++++++++++++++++++++
 4 files changed, 402 insertions(+)
 create mode 100644 drivers/ras/acpi_ras2.c

diff --git a/Documentation/scrub/scrub-configure.rst b/Documentation/scrub/scrub-configure.rst
index 2275366b60d3..7a1bf87bc6d7 100644
--- a/Documentation/scrub/scrub-configure.rst
+++ b/Documentation/scrub/scrub-configure.rst
@@ -50,3 +50,36 @@ The usage takes the form shown in this example::
     # echo 0 > /sys/class/ras/ras0/scrub/enable_background
     # cat /sys/class/ras/ras0/scrub/enable_background
     # 0
+
+2. RAS2
+2.1 On demand scrubbing for a specific memory region.
+    # echo 0x120000 > /sys/class/ras/ras1/scrub/addr_range_base
+    # echo 0x150000 > /sys/class/ras/ras1/scrub/addr_range_size
+    # cat /sys/class/ras/ras1/scrub/rate_available
+    # 0x1-0x18
+    # echo 20 > /sys/class/ras/ras1/scrub/rate
+    # echo 1 > /sys/class/ras/ras1/scrub/enable_on_demand
+    # cat /sys/class/ras/ras1/scrub/enable_on_demand
+    # 1
+    # cat /sys/class/ras/ras1/scrub/rate
+    # 0x14
+    # cat /sys/class/ras/ras1/scrub/addr_range_base
+    # 0x120000
+    # cat /sys/class/ras/ras1/scrub/addr_range_size
+    # 0x150000
+    # echo 0 > /sys/class/ras/ras1/scrub/enable_on_demand
+    # cat /sys/class/ras/ras1/scrub/enable_on_demand
+    # 0
+
+2.2 Background scrubbing the entire memory
+    # cat /sys/class/ras/ras1/scrub/rate_available
+    # 0x1-0x18
+    # echo 3 > /sys/class/ras/ras1/scrub/rate
+    # echo 1 > /sys/class/ras/ras1/scrub/enable_background
+    # cat /sys/class/ras/ras1/scrub/enable_background
+    # 1
+    # cat /sys/class/ras/ras1/scrub/rate
+    # 0x3
+    # echo 0 > /sys/class/ras/ras1/scrub/enable_background
+    # cat /sys/class/ras/ras1/scrub/enable_background
+    # 0
diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index 181701479564..57c346dfc01f 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -53,4 +53,14 @@ config SCRUB
 	  configuring the parameters of underlying scrubbers in the
 	  system for the DRAM memories.
 
+config MEM_ACPI_RAS2
+	tristate "Memory ACPI RAS2 driver"
+	depends on ACPI_RAS2
+	depends on SCRUB
+	help
+	  The driver binds to the platform device added by the ACPI RAS2
+	  table parser. Use a PCC channel subspace for communicating with
+	  the ACPI compliant platform to provide control of memory scrub
+	  parameters via the scrub subsystem.
+
 endif
diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
index 89bcf0d84355..48339fee1cb3 100644
--- a/drivers/ras/Makefile
+++ b/drivers/ras/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_RAS)	+= ras.o
 obj-$(CONFIG_DEBUG_FS)	+= debugfs.o
 obj-$(CONFIG_RAS_CEC)	+= cec.o
 obj-$(CONFIG_SCRUB)	+= memory_scrub.o
+obj-$(CONFIG_MEM_ACPI_RAS2)	+= acpi_ras2.o
 
 obj-$(CONFIG_RAS_FMPM)	+= amd/fmpm.o
 obj-y			+= amd/atl/
diff --git a/drivers/ras/acpi_ras2.c b/drivers/ras/acpi_ras2.c
new file mode 100644
index 000000000000..b3e9b61367bb
--- /dev/null
+++ b/drivers/ras/acpi_ras2.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ACPI RAS2 memory driver
+ *
+ * Copyright (c) 2024 HiSilicon Limited.
+ *
+ */
+
+#define pr_fmt(fmt)	"MEMORY ACPI RAS2: " fmt
+
+#include <linux/memory_scrub.h>
+#include <linux/platform_device.h>
+#include <acpi/ras2_acpi.h>
+
+#define RAS2_SUPPORT_HW_PARTOL_SCRUB	BIT(0)
+#define RAS2_TYPE_PATROL_SCRUB	0x0000
+
+#define RAS2_GET_PATROL_PARAMETERS	0x01
+#define	RAS2_START_PATROL_SCRUBBER	0x02
+#define	RAS2_STOP_PATROL_SCRUBBER	0x03
+
+#define RAS2_PATROL_SCRUB_RATE_IN_MASK	GENMASK(15, 8)
+#define RAS2_PATROL_SCRUB_EN_BACKGROUND	BIT(0)
+#define RAS2_PATROL_SCRUB_RATE_OUT_MASK	GENMASK(7, 0)
+#define RAS2_PATROL_SCRUB_MIN_RATE_OUT_MASK	GENMASK(15, 8)
+#define RAS2_PATROL_SCRUB_MAX_RATE_OUT_MASK	GENMASK(23, 16)
+#define RAS2_PATROL_SCRUB_FLAG_SCRUBBER_RUNNING	BIT(0)
+
+struct acpi_ras2_ps_shared_mem {
+	struct acpi_ras2_shared_memory common;
+	struct acpi_ras2_patrol_scrub_parameter params;
+};
+
+static int ras2_is_patrol_scrub_support(struct ras2_scrub_ctx *ras2_ctx)
+{
+	struct acpi_ras2_shared_memory __iomem *common = (void *)
+				ras2_ctx->pcc_subspace->pcc_comm_addr;
+
+	guard(mutex)(&ras2_ctx->lock);
+	common->set_capabilities[0] = 0;
+
+	return common->features[0] & RAS2_SUPPORT_HW_PARTOL_SCRUB;
+}
+
+static int ras2_update_patrol_scrub_params_cache(struct ras2_scrub_ctx *ras2_ctx)
+{
+	struct acpi_ras2_ps_shared_mem __iomem *ps_sm = (void *)
+					ras2_ctx->pcc_subspace->pcc_comm_addr;
+	int ret;
+
+	ps_sm->common.set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
+	ps_sm->params.patrol_scrub_command = RAS2_GET_PATROL_PARAMETERS;
+
+	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
+	if (ret) {
+		dev_err(ras2_ctx->dev, "failed to read parameters\n");
+		return ret;
+	}
+
+	ras2_ctx->rate_min = FIELD_GET(RAS2_PATROL_SCRUB_MIN_RATE_OUT_MASK,
+				       ps_sm->params.scrub_params_out);
+	ras2_ctx->rate_max = FIELD_GET(RAS2_PATROL_SCRUB_MAX_RATE_OUT_MASK,
+				       ps_sm->params.scrub_params_out);
+	ras2_ctx->base = ps_sm->params.actual_address_range[0];
+	ras2_ctx->size = ps_sm->params.actual_address_range[1];
+	ras2_ctx->rate = FIELD_GET(RAS2_PATROL_SCRUB_RATE_OUT_MASK,
+				   ps_sm->params.scrub_params_out);
+	return 0;
+}
+
+/* Context - lock must be held */
+static int ras2_get_patrol_scrub_running(struct ras2_scrub_ctx *ras2_ctx,
+					 bool *running)
+{
+	struct acpi_ras2_ps_shared_mem __iomem *ps_sm = (void *)
+					ras2_ctx->pcc_subspace->pcc_comm_addr;
+	int ret;
+
+	if (ras2_ctx->bg)
+		*running = true;
+
+	ps_sm->common.set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
+	ps_sm->params.patrol_scrub_command = RAS2_GET_PATROL_PARAMETERS;
+
+	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
+	if (ret) {
+		dev_err(ras2_ctx->dev, "failed to read parameters\n");
+		return ret;
+	}
+
+	*running = ps_sm->params.flags & RAS2_PATROL_SCRUB_FLAG_SCRUBBER_RUNNING;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_write_rate(struct device *dev, u64 rate)
+{
+	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
+	bool running;
+	int ret;
+
+	guard(mutex)(&ras2_ctx->lock);
+	ret = ras2_get_patrol_scrub_running(ras2_ctx, &running);
+	if (ret)
+		return ret;
+
+	if (running)
+		return -EBUSY;
+
+	if (rate < ras2_ctx->rate_min || rate > ras2_ctx->rate_max)
+		return -EINVAL;
+
+	ras2_ctx->rate = rate;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_read_rate(struct device *dev, u64 *rate)
+{
+	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
+
+	*rate = ras2_ctx->rate;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_read_rate_avail(struct device *dev, u64 *min, u64 *max)
+{
+	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
+
+	*min = ras2_ctx->rate_min;
+	*max = ras2_ctx->rate_max;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_read_range(struct device *dev, u64 *base, u64 *size)
+{
+	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
+
+	*base = ras2_ctx->base;
+	*size = ras2_ctx->size;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_write_range(struct device *dev, u64 base, u64 size)
+{
+	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
+	bool running;
+	int ret;
+
+	guard(mutex)(&ras2_ctx->lock);
+	ret = ras2_get_patrol_scrub_running(ras2_ctx, &running);
+	if (ret)
+		return ret;
+
+	if (running)
+		return -EBUSY;
+
+	ras2_ctx->base = base;
+	ras2_ctx->size = size;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_set_enabled_bg(struct device *dev, bool enable)
+{
+	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
+	struct acpi_ras2_ps_shared_mem __iomem *ps_sm = (void *)
+					ras2_ctx->pcc_subspace->pcc_comm_addr;
+	int ret;
+
+	guard(mutex)(&ras2_ctx->lock);
+	ps_sm->common.set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
+	if (enable) {
+		ps_sm->params.requested_address_range[0] = 0;
+		ps_sm->params.requested_address_range[1] = 0;
+		ps_sm->params.scrub_params_in &= ~RAS2_PATROL_SCRUB_RATE_IN_MASK;
+		ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PATROL_SCRUB_RATE_IN_MASK,
+							    ras2_ctx->rate);
+		ps_sm->params.patrol_scrub_command = RAS2_START_PATROL_SCRUBBER;
+	} else {
+		ps_sm->params.patrol_scrub_command = RAS2_STOP_PATROL_SCRUBBER;
+	}
+	ps_sm->params.scrub_params_in &= ~RAS2_PATROL_SCRUB_EN_BACKGROUND;
+	ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PATROL_SCRUB_EN_BACKGROUND,
+						    enable);
+
+	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
+	if (ret) {
+		dev_err(ras2_ctx->dev, "%s: failed to enable(%d) background scrubbing\n",
+			__func__, enable);
+		return ret;
+	}
+	ras2_ctx->bg = true;
+
+	/* Update the cache to account for rounding of supplied parameters and similar */
+	return ras2_update_patrol_scrub_params_cache(ras2_ctx);
+}
+
+static int ras2_hw_scrub_get_enabled_bg(struct device *dev, bool *enabled)
+{
+	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
+
+	*enabled = ras2_ctx->bg;
+
+	return 0;
+}
+
+static int ras2_hw_scrub_set_enabled_od(struct device *dev, bool enable)
+{
+	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
+	struct acpi_ras2_ps_shared_mem __iomem *ps_sm = (void *)
+					ras2_ctx->pcc_subspace->pcc_comm_addr;
+	bool enabled;
+	int ret;
+
+	guard(mutex)(&ras2_ctx->lock);
+	ps_sm->common.set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
+	if (enable) {
+		if (!ras2_ctx->size) {
+			dev_warn(ras2_ctx->dev,
+				 "%s: Invalid requested address range, requested_address_range[0]=0x%llx "
+				 "requested_address_range[1]=0x%llx\n", __func__,
+				 ps_sm->params.requested_address_range[0],
+				 ps_sm->params.requested_address_range[1]);
+			return -ERANGE;
+		}
+		ret = ras2_get_patrol_scrub_running(ras2_ctx, &enabled);
+		if (ret)
+			return ret;
+
+		if (enabled)
+			return 0;
+
+		ps_sm->params.scrub_params_in &= ~RAS2_PATROL_SCRUB_RATE_IN_MASK;
+		ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PATROL_SCRUB_RATE_IN_MASK,
+							    ras2_ctx->rate);
+		ps_sm->params.requested_address_range[0] = ras2_ctx->base;
+		ps_sm->params.requested_address_range[1] = ras2_ctx->size;
+		ps_sm->params.patrol_scrub_command = RAS2_START_PATROL_SCRUBBER;
+	} else {
+		ps_sm->params.patrol_scrub_command = RAS2_STOP_PATROL_SCRUBBER;
+	}
+
+	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
+	if (ret) {
+		dev_err(ras2_ctx->dev, "failed to enable(%d) the demand scrubbing\n", enable);
+		return ret;
+	}
+	ras2_ctx->bg = false;
+
+	return ras2_update_patrol_scrub_params_cache(ras2_ctx);
+}
+
+static int ras2_hw_scrub_get_enabled_od(struct device *dev, bool *enabled)
+{
+	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
+
+	guard(mutex)(&ras2_ctx->lock);
+	if (ras2_ctx->bg) {
+		*enabled = false;
+		return 0;
+	}
+
+	return ras2_get_patrol_scrub_running(ras2_ctx, enabled);
+}
+
+static int ras2_hw_scrub_get_name(struct device *dev, char *name)
+{
+	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
+
+	return sysfs_emit(name, "ras2_scrub%d\n", ras2_ctx->id);
+}
+
+static const struct scrub_ops ras2_scrub_ops = {
+	.read_range = ras2_hw_scrub_read_range,
+	.write_range = ras2_hw_scrub_write_range,
+	.get_enabled_bg = ras2_hw_scrub_get_enabled_bg,
+	.set_enabled_bg = ras2_hw_scrub_set_enabled_bg,
+	.get_enabled_od = ras2_hw_scrub_get_enabled_od,
+	.set_enabled_od = ras2_hw_scrub_set_enabled_od,
+	.get_name = ras2_hw_scrub_get_name,
+	.rate_avail_range = ras2_hw_scrub_read_rate_avail,
+	.rate_read = ras2_hw_scrub_read_rate,
+	.rate_write = ras2_hw_scrub_write_rate,
+};
+
+static DEFINE_IDA(ras2_ida);
+
+static void ida_release(void *ctx)
+{
+	struct ras2_scrub_ctx *ras2_ctx = ctx;
+
+	ida_free(&ras2_ida, ras2_ctx->id);
+}
+
+static int ras2_probe(struct platform_device *pdev)
+{
+	struct ras2_scrub_ctx *ras2_ctx;
+	struct device *hw_scrub_dev;
+	int ret, id;
+
+	/* RAS2 PCC Channel and Scrub specific context */
+	ras2_ctx = devm_kzalloc(&pdev->dev, sizeof(*ras2_ctx), GFP_KERNEL);
+	if (!ras2_ctx)
+		return -ENOMEM;
+
+	ras2_ctx->dev = &pdev->dev;
+	mutex_init(&ras2_ctx->lock);
+
+	ret = devm_ras2_register_pcc_channel(&pdev->dev, ras2_ctx,
+					     *((int *)dev_get_platdata(&pdev->dev)));
+	if (ret < 0) {
+		dev_dbg(ras2_ctx->dev,
+			"failed to register pcc channel ret=%d\n", ret);
+		return ret;
+	}
+	if (!ras2_is_patrol_scrub_support(ras2_ctx))
+		return -EOPNOTSUPP;
+
+	ret = ras2_update_patrol_scrub_params_cache(ras2_ctx);
+	if (ret)
+		return ret;
+
+	id = ida_alloc(&ras2_ida, GFP_KERNEL);
+	if (id < 0)
+		return id;
+
+	ras2_ctx->id = id;
+
+	ret = devm_add_action_or_reset(&pdev->dev, ida_release, ras2_ctx);
+	if (ret < 0)
+		return ret;
+
+	hw_scrub_dev = devm_scrub_device_register(&pdev->dev, ras2_ctx, &ras2_scrub_ops);
+	if (IS_ERR(hw_scrub_dev))
+		return PTR_ERR(hw_scrub_dev);
+
+	ras2_ctx->scrub_dev = hw_scrub_dev;
+
+	return 0;
+}
+
+static const struct platform_device_id ras2_id_table[] = {
+	{ .name = "acpi_ras2", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, ras2_id_table);
+
+static struct platform_driver ras2_driver = {
+	.probe = ras2_probe,
+	.driver = {
+		.name = "acpi_ras2",
+	},
+	.id_table = ras2_id_table,
+};
+module_driver(ras2_driver, platform_driver_register, platform_driver_unregister);
+
+MODULE_IMPORT_NS(ACPI_RAS2);
+MODULE_DESCRIPTION("ACPI RAS2 memory driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


