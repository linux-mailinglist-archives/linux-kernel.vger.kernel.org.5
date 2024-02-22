Return-Path: <linux-kernel+bounces-77518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1748606AF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9211F22F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD1814CAD4;
	Thu, 22 Feb 2024 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kbFHgLQB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1334146E63;
	Thu, 22 Feb 2024 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643836; cv=none; b=VriGHydBQxa3ejBTAVI0ok6QkA+RlgyEeiaIRgxAbn1nMNh8vPvaE7XkGWkwzye67YU6b/mrTyBPw7OidMJ2msjn3Xbmxl8GC6QJiYI0qmgZq/q1RXOgBR6B8Jg/a5cmdrJPah7CCk9x9SYw4x7VVQ33L62EAkX9DWCxsF07hp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643836; c=relaxed/simple;
	bh=eKg4Wdfive8CFcZ832UFnPs5P57hVE5qhTLF0A8GLxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pIcEYbegg/i39j88svVogkKDoJIA0dxJJith0F3rS8cLHPJCnd3aLRJwWRQTV9VhTaEsKi59dzU/3+GyJQozdvfHqQ0Iop1ndBMhtKGPB8IpazkFWMXnF7lhDvSayGgNg6De+FibgKEMrZmVIMuwc31ozy8Q9vv/2LDyfzutLFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kbFHgLQB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MMwNpl021431;
	Thu, 22 Feb 2024 23:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=2U+agiqukd/du23WJFcMxZ+WQ4YQxwoiMKt/aEM341M
	=; b=kbFHgLQBLbR00Gsqxu5/yjnO6mhCKRGAewX3RDcewO62JsbY0epB9PFP4W/
	7fBjJfkf6A/5wtJKdZXR5ANSNwdRcY+CKjie411TGFQnDg98zf5i0z8Nd49cJMQ0
	hqcT0q/XTYzrBrc9+uqa456+LkslIxpvc2gU/AGequ5tqAQtjf7Ys5Qz6BMbcsJE
	ertZKrdcYQXHej713oNFG3NJPLfZAUmFWZeL4mbwGQ2l1K8IdUcBT4BCExw2XXmO
	MHTLw//Jmmt6vYoCRLyYVI7lDj0pZu++CANj0GG6Beq6jYQ73qwdiddRpIoIezMs
	NXd6NxTzhQtvFWMSSTYwIA7TPnw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdw13afvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:45 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MNGiQ0025664
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:44 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:16:43 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Thu, 22 Feb 2024 15:16:53 -0800
Subject: [PATCH v17 30/35] virt: gunyah: Allow userspace to initialize
 context of primary vCPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-gunyah-v17-30-1e9da6763d38@quicinc.com>
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
X-Proofpoint-ORIG-GUID: L2u3zRYMaWfX3RTcPIxtb-zkwxJM5pzM
X-Proofpoint-GUID: L2u3zRYMaWfX3RTcPIxtb-zkwxJM5pzM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402220179

RM provides APIs to fill boot context the initial registers upon
starting the vCPU. Most importantly, this allows userspace to set the
initial PC for the primary vCPU when the VM starts to run.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/vm_mgr.c | 77 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.h |  2 ++
 include/uapi/linux/gunyah.h  | 23 +++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index 473740a1f97d0..a61a3f3ae92f1 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -402,6 +402,7 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gunyah_rm *rm)
 	mutex_init(&ghvm->resources_lock);
 	INIT_LIST_HEAD(&ghvm->resources);
 	INIT_LIST_HEAD(&ghvm->resource_tickets);
+	xa_init(&ghvm->boot_context);
 
 	mt_init(&ghvm->mm);
 	mt_init(&ghvm->bindings);
@@ -427,6 +428,66 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gunyah_rm *rm)
 	return ghvm;
 }
 
+static long gunyah_vm_set_boot_context(struct gunyah_vm *ghvm,
+				       struct gunyah_vm_boot_context *boot_ctx)
+{
+	u8 reg_set, reg_index; /* to check values are reasonable */
+	int ret;
+
+	reg_set = (boot_ctx->reg >> GUNYAH_VM_BOOT_CONTEXT_REG_SHIFT) & 0xff;
+	reg_index = boot_ctx->reg & 0xff;
+
+	switch (reg_set) {
+	case REG_SET_X:
+		if (reg_index > 31)
+			return -EINVAL;
+		break;
+	case REG_SET_PC:
+		if (reg_index)
+			return -EINVAL;
+		break;
+	case REG_SET_SP:
+		if (reg_index > 2)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = down_read_interruptible(&ghvm->status_lock);
+	if (ret)
+		return ret;
+
+	if (ghvm->vm_status != GUNYAH_RM_VM_STATUS_NO_STATE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = xa_err(xa_store(&ghvm->boot_context, boot_ctx->reg,
+			      (void *)boot_ctx->value, GFP_KERNEL));
+out:
+	up_read(&ghvm->status_lock);
+	return ret;
+}
+
+static inline int gunyah_vm_fill_boot_context(struct gunyah_vm *ghvm)
+{
+	unsigned long reg_set, reg_index, id;
+	void *entry;
+	int ret;
+
+	xa_for_each(&ghvm->boot_context, id, entry) {
+		reg_set = (id >> GUNYAH_VM_BOOT_CONTEXT_REG_SHIFT) & 0xff;
+		reg_index = id & 0xff;
+		ret = gunyah_rm_vm_set_boot_context(
+			ghvm->rm, ghvm->vmid, reg_set, reg_index, (u64)entry);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int gunyah_vm_start(struct gunyah_vm *ghvm)
 {
 	struct gunyah_rm_hyp_resources *resources;
@@ -499,6 +560,13 @@ static int gunyah_vm_start(struct gunyah_vm *ghvm)
 	}
 	ghvm->vm_status = GUNYAH_RM_VM_STATUS_READY;
 
+	ret = gunyah_vm_fill_boot_context(ghvm);
+	if (ret) {
+		dev_warn(ghvm->parent, "Failed to setup boot context: %d\n",
+			 ret);
+		goto err;
+	}
+
 	ret = gunyah_rm_get_hyp_resources(ghvm->rm, ghvm->vmid, &resources);
 	if (ret) {
 		dev_warn(ghvm->parent,
@@ -625,6 +693,14 @@ static long gunyah_vm_ioctl(struct file *filp, unsigned int cmd,
 
 		return gunyah_gmem_modify_mapping(ghvm, &args);
 	}
+	case GUNYAH_VM_SET_BOOT_CONTEXT: {
+		struct gunyah_vm_boot_context boot_ctx;
+
+		if (copy_from_user(&boot_ctx, argp, sizeof(boot_ctx)))
+			return -EFAULT;
+
+		return gunyah_vm_set_boot_context(ghvm, &boot_ctx);
+	}
 	default:
 		r = -ENOTTY;
 		break;
@@ -716,6 +792,7 @@ static void _gunyah_vm_put(struct kref *kref)
 				 "Failed to deallocate vmid: %d\n", ret);
 	}
 
+	xa_destroy(&ghvm->boot_context);
 	gunyah_rm_put(ghvm->rm);
 	kfree(ghvm);
 }
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 5eb14f30ba965..8cee93e551700 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -81,6 +81,7 @@ long gunyah_dev_vm_mgr_ioctl(struct gunyah_rm *rm, unsigned int cmd,
  *                    folio; parcel_start is start of the folio)
  * @dtb.parcel_pages: Number of pages lent for the memory parcel
  * @dtb.parcel: Data for resource manager to lend the parcel
+ * @boot_context: Requested initial boot context to set when launching the VM
  *
  * Members are grouped by hot path.
  */
@@ -115,6 +116,7 @@ struct gunyah_vm {
 		u64 parcel_start, parcel_pages;
 		struct gunyah_rm_mem_parcel parcel;
 	} dtb;
+	struct xarray boot_context;
 };
 
 /**
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index a89d9bedf3e5d..574116f544722 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -142,6 +142,29 @@ struct gunyah_map_mem_args {
 
 #define GUNYAH_VM_MAP_MEM _IOW(GUNYAH_IOCTL_TYPE, 0x9, struct gunyah_map_mem_args)
 
+enum gunyah_vm_boot_context_reg {
+	REG_SET_X		= 0,
+	REG_SET_PC		= 1,
+	REG_SET_SP		= 2,
+};
+
+#define GUNYAH_VM_BOOT_CONTEXT_REG_SHIFT	8
+#define GUNYAH_VM_BOOT_CONTEXT_REG(reg, idx) (((reg & 0xff) << GUNYAH_VM_BOOT_CONTEXT_REG_SHIFT) |\
+					      (idx & 0xff))
+
+/**
+ * struct gunyah_vm_boot_context - Set an initial register for the VM
+ * @reg: Register to set. See GUNYAH_VM_BOOT_CONTEXT_REG_* macros
+ * @reserved: reserved for alignment
+ * @value: value to fill in the register
+ */
+struct gunyah_vm_boot_context {
+	__u32 reg;
+	__u32 reserved;
+	__u64 value;
+};
+#define GUNYAH_VM_SET_BOOT_CONTEXT	_IOW(GUNYAH_IOCTL_TYPE, 0xa, struct gunyah_vm_boot_context)
+
 /*
  * ioctls for vCPU fds
  */

-- 
2.34.1


