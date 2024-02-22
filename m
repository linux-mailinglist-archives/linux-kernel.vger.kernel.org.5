Return-Path: <linux-kernel+bounces-77512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1270E8606A5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0329B286754
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E86149381;
	Thu, 22 Feb 2024 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FjtDETKc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA2B13BAF2;
	Thu, 22 Feb 2024 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643831; cv=none; b=j17v1ayCw7vWEHAmyzJSvxbogYmdKmQV66P0qKb2YfakiJ/3JD9ANr/7p4ikCyDgrLk/4jo5I6l1e4dSWC5JQ5p9smanEKulVVVeDMzi6zg11UcIJU8//45R5oJphWFFT8JbGK5igiXOsbQxSi5RpBorgtzglkCw4N+SriCA6sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643831; c=relaxed/simple;
	bh=yiYkGcCnLlL27RWVyDjHKsRWJDI5Cj39FsMdry9HNCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fJczU1BF8V8ZU+ITrL1RGAmyItw0atTuDqym7qfwLrPoK2ewZylmbPyXR0gfz+iSzl2trRxc1LB4EDmBlp7hoOQKMMkF341BcFR1T8biR9CrFRuN57MW6UF351+2r1KZ6lWB8pyl7aUEtMfFPnj+i/0MbNhihsUqx3J98NxNx7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FjtDETKc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MLcfsx010074;
	Thu, 22 Feb 2024 23:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=JCvR/F4e78SINAjN3meQYZzTInDObRjxvrSnXKpjai8
	=; b=FjtDETKc/0YZ7h6GsKOoYFC95XN1GsWS2Ki6KfHY2R09+DyalIWE4XK7eaG
	5aC38FRjcTiPbwP5lRGFYahhT06fipPKURtl9nqKSKb4VaCOijdCriHT0qVs5DUV
	2HLU6KSWWB4Y998qRUphry2pqZOIFsB/fkEQWBnbD4LATnYjqzCEAbOesOD27S12
	GxP2S/08Jc0e06MV/j7Xrzkbr2e0Ekrpf0n1SHupWlsxfshnwO1okTdANJ7jPPi5
	rmkQ9HFUniWnK18W50p9Ax4jhJh5hsmazkDvDbziXOefss+7giMVTPZxh82UDa0D
	BnuL1XOK4Ez8i2eLVSXgH7fi9GA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we2kf9puv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MNGksh025676
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:46 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:16:46 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Thu, 22 Feb 2024 15:16:57 -0800
Subject: [PATCH v17 34/35] virt: gunyah: Add ioeventfd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-gunyah-v17-34-1e9da6763d38@quicinc.com>
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
X-Proofpoint-ORIG-GUID: bWGKXIzCtCgdXv3iBnUxn_P4tDEUuHGp
X-Proofpoint-GUID: bWGKXIzCtCgdXv3iBnUxn_P4tDEUuHGp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220179

Allow userspace to attach an ioeventfd to an mmio address within the
guest.  Userspace provides a description of the type of write to
"subscribe" to and eventfd to trigger when that type of write is
performed by the guest. This mechanism allows userspace to respond
asynchronously to a guest manipulating a virtualized device and is
similar to KVM's ioeventfd.

Reviewed-by: Alex Elder <elder@linaro.org>
Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Kconfig            |   9 +++
 drivers/virt/gunyah/Makefile           |   1 +
 drivers/virt/gunyah/gunyah_ioeventfd.c | 139 +++++++++++++++++++++++++++++++++
 include/uapi/linux/gunyah.h            |  37 +++++++++
 4 files changed, 186 insertions(+)

diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index 1685b75fb77a0..855d41a88b160 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -36,3 +36,12 @@ config GUNYAH_IRQFD
 	  on Gunyah virtual machine.
 
 	  Say Y/M here if unsure and you want to support Gunyah VMMs.
+
+config GUNYAH_IOEVENTFD
+	tristate "Gunyah ioeventfd interface"
+	depends on GUNYAH
+	help
+	  Enable kernel support for creating ioeventfds which can alert userspace
+	  when a Gunyah virtual machine accesses a memory address.
+
+	  Say Y/M here if unsure and you want to support Gunyah VMMs.
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index b41b02792921c..2aec5989402b0 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_GUNYAH) += gunyah.o gunyah_rsc_mgr.o gunyah_vcpu.o
 obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
 obj-$(CONFIG_GUNYAH_QCOM_PLATFORM) += gunyah_qcom.o
 obj-$(CONFIG_GUNYAH_IRQFD) += gunyah_irqfd.o
+obj-$(CONFIG_GUNYAH_IOEVENTFD) += gunyah_ioeventfd.o
diff --git a/drivers/virt/gunyah/gunyah_ioeventfd.c b/drivers/virt/gunyah/gunyah_ioeventfd.c
new file mode 100644
index 0000000000000..894d303968c4c
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah_ioeventfd.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/eventfd.h>
+#include <linux/device/driver.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/gunyah.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+
+#include <uapi/linux/gunyah.h>
+
+struct gunyah_ioeventfd {
+	struct gunyah_vm_function_instance *f;
+	struct gunyah_vm_io_handler io_handler;
+
+	struct eventfd_ctx *ctx;
+};
+
+static int gunyah_write_ioeventfd(struct gunyah_vm_io_handler *io_dev, u64 addr,
+				  u32 len, u64 data)
+{
+	struct gunyah_ioeventfd *iofd =
+		container_of(io_dev, struct gunyah_ioeventfd, io_handler);
+
+	eventfd_signal(iofd->ctx);
+	return 0;
+}
+
+static struct gunyah_vm_io_handler_ops io_ops = {
+	.write = gunyah_write_ioeventfd,
+};
+
+static long gunyah_ioeventfd_bind(struct gunyah_vm_function_instance *f)
+{
+	const struct gunyah_fn_ioeventfd_arg *args = f->argp;
+	struct gunyah_ioeventfd *iofd;
+	struct eventfd_ctx *ctx;
+	int ret;
+
+	if (f->arg_size != sizeof(*args))
+		return -EINVAL;
+
+	/* All other flag bits are reserved for future use */
+	if (args->flags & ~GUNYAH_IOEVENTFD_FLAGS_DATAMATCH)
+		return -EINVAL;
+
+	/* must be natural-word sized, or 0 to ignore length */
+	switch (args->len) {
+	case 0:
+	case 1:
+	case 2:
+	case 4:
+	case 8:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* check for range overflow */
+	if (overflows_type(args->addr + args->len, u64))
+		return -EINVAL;
+
+	/* ioeventfd with no length can't be combined with DATAMATCH */
+	if (!args->len && (args->flags & GUNYAH_IOEVENTFD_FLAGS_DATAMATCH))
+		return -EINVAL;
+
+	ctx = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	iofd = kzalloc(sizeof(*iofd), GFP_KERNEL);
+	if (!iofd) {
+		ret = -ENOMEM;
+		goto err_eventfd;
+	}
+
+	f->data = iofd;
+	iofd->f = f;
+
+	iofd->ctx = ctx;
+
+	if (args->flags & GUNYAH_IOEVENTFD_FLAGS_DATAMATCH) {
+		iofd->io_handler.datamatch = true;
+		iofd->io_handler.len = args->len;
+		iofd->io_handler.data = args->datamatch;
+	}
+	iofd->io_handler.addr = args->addr;
+	iofd->io_handler.ops = &io_ops;
+
+	ret = gunyah_vm_add_io_handler(f->ghvm, &iofd->io_handler);
+	if (ret)
+		goto err_io_dev_add;
+
+	return 0;
+
+err_io_dev_add:
+	kfree(iofd);
+err_eventfd:
+	eventfd_ctx_put(ctx);
+	return ret;
+}
+
+static void gunyah_ioevent_unbind(struct gunyah_vm_function_instance *f)
+{
+	struct gunyah_ioeventfd *iofd = f->data;
+
+	gunyah_vm_remove_io_handler(iofd->f->ghvm, &iofd->io_handler);
+	eventfd_ctx_put(iofd->ctx);
+	kfree(iofd);
+}
+
+static bool gunyah_ioevent_compare(const struct gunyah_vm_function_instance *f,
+				   const void *arg, size_t size)
+{
+	const struct gunyah_fn_ioeventfd_arg *instance = f->argp, *other = arg;
+
+	if (sizeof(*other) != size)
+		return false;
+
+	if (instance->addr != other->addr || instance->len != other->len ||
+	    instance->flags != other->flags)
+		return false;
+
+	if ((instance->flags & GUNYAH_IOEVENTFD_FLAGS_DATAMATCH) &&
+	    instance->datamatch != other->datamatch)
+		return false;
+
+	return true;
+}
+
+DECLARE_GUNYAH_VM_FUNCTION_INIT(ioeventfd, GUNYAH_FN_IOEVENTFD, 3,
+				gunyah_ioeventfd_bind, gunyah_ioevent_unbind,
+				gunyah_ioevent_compare);
+MODULE_DESCRIPTION("Gunyah ioeventfd VM Function");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index cb7b0bb9bef38..fd461e2fe8b58 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -65,10 +65,13 @@ struct gunyah_vm_dtb_config {
  *              Return: file descriptor to manipulate the vcpu.
  * @GUNYAH_FN_IRQFD: register eventfd to assert a Gunyah doorbell
  *               &struct gunyah_fn_desc.arg is a pointer to &struct gunyah_fn_irqfd_arg
+ * @GUNYAH_FN_IOEVENTFD: register ioeventfd to trigger when VM faults on parameter
+ *                   &struct gunyah_fn_desc.arg is a pointer to &struct gunyah_fn_ioeventfd_arg
  */
 enum gunyah_fn_type {
 	GUNYAH_FN_VCPU = 1,
 	GUNYAH_FN_IRQFD,
+	GUNYAH_FN_IOEVENTFD,
 };
 
 #define GUNYAH_FN_MAX_ARG_SIZE		256
@@ -120,6 +123,40 @@ struct gunyah_fn_irqfd_arg {
 	__u32 padding;
 };
 
+/**
+ * enum gunyah_ioeventfd_flags - flags for use in gunyah_fn_ioeventfd_arg
+ * @GUNYAH_IOEVENTFD_FLAGS_DATAMATCH: the event will be signaled only if the
+ *                                written value to the registered address is
+ *                                equal to &struct gunyah_fn_ioeventfd_arg.datamatch
+ */
+enum gunyah_ioeventfd_flags {
+	GUNYAH_IOEVENTFD_FLAGS_DATAMATCH	= 1UL << 0,
+};
+
+/**
+ * struct gunyah_fn_ioeventfd_arg - Arguments to create an ioeventfd function
+ * @datamatch: data used when GUNYAH_IOEVENTFD_DATAMATCH is set
+ * @addr: Address in guest memory
+ * @len: Length of access
+ * @fd: When ioeventfd is matched, this eventfd is written
+ * @flags: See &enum gunyah_ioeventfd_flags
+ * @padding: padding bytes
+ *
+ * Create this function with &GUNYAH_VM_ADD_FUNCTION using type &GUNYAH_FN_IOEVENTFD.
+ *
+ * Attaches an ioeventfd to a legal mmio address within the guest. A guest write
+ * in the registered address will signal the provided event instead of triggering
+ * an exit on the GUNYAH_VCPU_RUN ioctl.
+ */
+struct gunyah_fn_ioeventfd_arg {
+	__u64 datamatch;
+	__u64 addr;        /* legal mmio address */
+	__u32 len;         /* 1, 2, 4, or 8 bytes; or 0 to ignore length */
+	__s32 fd;
+	__u32 flags;
+	__u32 padding;
+};
+
 /**
  * struct gunyah_fn_desc - Arguments to create a VM function
  * @type: Type of the function. See &enum gunyah_fn_type.

-- 
2.34.1


