Return-Path: <linux-kernel+bounces-77499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF1A86066D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6138C287989
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393BA13BACF;
	Thu, 22 Feb 2024 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RI92E9jl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264D221109;
	Thu, 22 Feb 2024 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643825; cv=none; b=bdNNR5wRwScXMp2w8zySaSOOXOCXFu9L4WRdHxfQAatpIW/cpYA6zoMGJiQHtB6AH+D7KQDnqUVODYNO+88APVStKVExz8O4rhl4h8KLkSW08s2LWd6C6lTW+23AMU+ZpR4D39UROCs1GyHxYFDcCTTPDWot/w4aPrXb+nOka3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643825; c=relaxed/simple;
	bh=C9b7fayv7Srk0zvHXjTemoxdWXxe715PnkD7sakkYNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fd67FlZiE/Lfr9pNfs8Fpyc1PYAXn/tQ4J1Mq+GbxjkGO2g3NAceLe7sLbXQA+q5m8DoUDjRlLboV1TQWsGjO6jtNc0A0IrtcmfKXvTS5I+GmhgSt9tbyxTkxvtbwNh03x6S8g89zQhilo80QzBivdT7BdeagMypqugWLwdCKgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RI92E9jl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MMKnxf028355;
	Thu, 22 Feb 2024 23:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=kvX19e3Ohm/qQMw9kxBOF0A0UYzethrCUoEi5ksVirQ
	=; b=RI92E9jl2/w+OzOVO3FrLfK8jMkQVPUF9Cit68C2J7jg1LeJ2H89NsrjRiP
	MHcZJ1v2JHusYbRrz37b4RTD0jxawMde88McQlS/yWqCDFZUBCfS1I6WpO+m50C9
	sfpNL+sDe/l7BgnohpYUlqJyRs4Oz4jdNZeDnpw9P3L8Kau5c2Oie/h5k2xCPLSS
	urMek2HPwSTCYOvuNBZIoUa4JRkbOyIjGxyW82oAVkwkUwXQpleVbIxM+SXASOJ+
	Ldpqsx5DPgbbutFpEgKhbxU4zvyJuqpx4qeiJ3aEX0wpBFL3iBJ36qoDKUiZ9EEV
	bsbXaLOLiXmj6mFbJVT3YPao2sw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we97tgf8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:40 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MNGd27017508
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:39 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:16:39 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Thu, 22 Feb 2024 15:16:45 -0800
Subject: [PATCH v17 22/35] virt: gunyah: Add Qualcomm Gunyah platform ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-gunyah-v17-22-1e9da6763d38@quicinc.com>
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
X-Proofpoint-GUID: UtvzZzBYuHQ2yLUa5GJ10kDpUDECSUak
X-Proofpoint-ORIG-GUID: UtvzZzBYuHQ2yLUa5GJ10kDpUDECSUak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220179

Qualcomm platforms have a firmware entity which performs access control
to physical pages. Dynamically started Gunyah virtual machines use the
QCOM_SCM_RM_MANAGED_VMID for access. Linux thus needs to assign access
to the memory used by guest VMs. Gunyah doesn't do this operation for us
since it is the current VM (typically VMID_HLOS) delegating the access
and not Gunyah itself. Use the Gunyah platform ops to achieve this so
that only Qualcomm platforms attempt to make the needed SCM calls.

Reviewed-by: Alex Elder <elder@linaro.org>
Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Kconfig       |  13 +++
 drivers/virt/gunyah/Makefile      |   1 +
 drivers/virt/gunyah/gunyah_qcom.c | 220 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 234 insertions(+)

diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index 23ba523d25dc8..fe2823dc48bac 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -4,6 +4,7 @@ config GUNYAH
 	tristate "Gunyah Virtualization drivers"
 	depends on ARM64
 	select GUNYAH_PLATFORM_HOOKS
+	imply GUNYAH_QCOM_PLATFORM if ARCH_QCOM
 	help
 	  The Gunyah drivers are the helper interfaces that run in a guest VM
 	  such as basic inter-VM IPC and signaling mechanisms, and higher level
@@ -14,3 +15,15 @@ config GUNYAH
 
 config GUNYAH_PLATFORM_HOOKS
 	tristate
+
+config GUNYAH_QCOM_PLATFORM
+	tristate "Support for Gunyah on Qualcomm platforms"
+	depends on GUNYAH
+	select GUNYAH_PLATFORM_HOOKS
+	select QCOM_SCM
+	help
+	  Enable support for interacting with Gunyah on Qualcomm
+	  platforms. Interaction with Qualcomm firmware requires
+	  extra platform-specific support.
+
+	  Say Y/M here to use Gunyah on Qualcomm platforms.
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index ffcde0e0ccfa9..a6c6f29b887a6 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -4,3 +4,4 @@ gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mem.o
 
 obj-$(CONFIG_GUNYAH) += gunyah.o gunyah_rsc_mgr.o gunyah_vcpu.o
 obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
+obj-$(CONFIG_GUNYAH_QCOM_PLATFORM) += gunyah_qcom.o
diff --git a/drivers/virt/gunyah/gunyah_qcom.c b/drivers/virt/gunyah/gunyah_qcom.c
new file mode 100644
index 0000000000000..f2342d51a0184
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah_qcom.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/gunyah.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/types.h>
+#include <linux/uuid.h>
+
+#define QCOM_SCM_RM_MANAGED_VMID 0x3A
+#define QCOM_SCM_MAX_MANAGED_VMID 0x3F
+
+static int
+qcom_scm_gunyah_rm_pre_mem_share(struct gunyah_rm *rm,
+				 struct gunyah_rm_mem_parcel *mem_parcel)
+{
+	struct qcom_scm_vmperm *new_perms __free(kfree) = NULL;
+	u64 src, src_cpy;
+	int ret = 0, i, n;
+	u16 vmid;
+
+	new_perms = kcalloc(mem_parcel->n_acl_entries, sizeof(*new_perms),
+			    GFP_KERNEL);
+	if (!new_perms)
+		return -ENOMEM;
+
+	for (n = 0; n < mem_parcel->n_acl_entries; n++) {
+		vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
+		if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
+			new_perms[n].vmid = vmid;
+		else
+			new_perms[n].vmid = QCOM_SCM_RM_MANAGED_VMID;
+		if (mem_parcel->acl_entries[n].perms & GUNYAH_RM_ACL_X)
+			new_perms[n].perm |= QCOM_SCM_PERM_EXEC;
+		if (mem_parcel->acl_entries[n].perms & GUNYAH_RM_ACL_W)
+			new_perms[n].perm |= QCOM_SCM_PERM_WRITE;
+		if (mem_parcel->acl_entries[n].perms & GUNYAH_RM_ACL_R)
+			new_perms[n].perm |= QCOM_SCM_PERM_READ;
+	}
+
+	src = BIT_ULL(QCOM_SCM_VMID_HLOS);
+
+	for (i = 0; i < mem_parcel->n_mem_entries; i++) {
+		src_cpy = src;
+		ret = qcom_scm_assign_mem(
+			le64_to_cpu(mem_parcel->mem_entries[i].phys_addr),
+			le64_to_cpu(mem_parcel->mem_entries[i].size), &src_cpy,
+			new_perms, mem_parcel->n_acl_entries);
+		if (ret)
+			break;
+	}
+
+	/* Did it work ok? */
+	if (!ret)
+		return 0;
+
+	src = 0;
+	for (n = 0; n < mem_parcel->n_acl_entries; n++) {
+		vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
+		if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
+			src |= BIT_ULL(vmid);
+		else
+			src |= BIT_ULL(QCOM_SCM_RM_MANAGED_VMID);
+	}
+
+	new_perms[0].vmid = QCOM_SCM_VMID_HLOS;
+	new_perms[0].perm = QCOM_SCM_PERM_EXEC | QCOM_SCM_PERM_WRITE |
+			    QCOM_SCM_PERM_READ;
+
+	for (i--; i >= 0; i--) {
+		src_cpy = src;
+		WARN_ON_ONCE(qcom_scm_assign_mem(
+			le64_to_cpu(mem_parcel->mem_entries[i].phys_addr),
+			le64_to_cpu(mem_parcel->mem_entries[i].size), &src_cpy,
+			new_perms, 1));
+	}
+
+	return ret;
+}
+
+static int
+qcom_scm_gunyah_rm_post_mem_reclaim(struct gunyah_rm *rm,
+				    struct gunyah_rm_mem_parcel *mem_parcel)
+{
+	struct qcom_scm_vmperm new_perms;
+	u64 src = 0, src_cpy;
+	int ret = 0, i, n;
+	u16 vmid;
+
+	new_perms.vmid = QCOM_SCM_VMID_HLOS;
+	new_perms.perm = QCOM_SCM_PERM_EXEC | QCOM_SCM_PERM_WRITE |
+			 QCOM_SCM_PERM_READ;
+
+	for (n = 0; n < mem_parcel->n_acl_entries; n++) {
+		vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
+		if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
+			src |= (1ull << vmid);
+		else
+			src |= (1ull << QCOM_SCM_RM_MANAGED_VMID);
+	}
+
+	for (i = 0; i < mem_parcel->n_mem_entries; i++) {
+		src_cpy = src;
+		ret = qcom_scm_assign_mem(
+			le64_to_cpu(mem_parcel->mem_entries[i].phys_addr),
+			le64_to_cpu(mem_parcel->mem_entries[i].size), &src_cpy,
+			&new_perms, 1);
+		WARN_ON_ONCE(ret);
+	}
+
+	return ret;
+}
+
+static int
+qcom_scm_gunyah_rm_pre_demand_page(struct gunyah_rm *rm, u16 vmid,
+				   enum gunyah_pagetable_access access,
+				   struct folio *folio)
+{
+	struct qcom_scm_vmperm new_perms[2];
+	unsigned int n = 1;
+	u64 src;
+
+	new_perms[0].vmid = QCOM_SCM_RM_MANAGED_VMID;
+	new_perms[0].perm = QCOM_SCM_PERM_EXEC | QCOM_SCM_PERM_WRITE |
+			    QCOM_SCM_PERM_READ;
+	if (access != GUNYAH_PAGETABLE_ACCESS_X &&
+	    access != GUNYAH_PAGETABLE_ACCESS_RX &&
+	    access != GUNYAH_PAGETABLE_ACCESS_RWX) {
+		new_perms[1].vmid = QCOM_SCM_VMID_HLOS;
+		new_perms[1].perm = QCOM_SCM_PERM_EXEC | QCOM_SCM_PERM_WRITE |
+				    QCOM_SCM_PERM_READ;
+		n++;
+	}
+
+	src = BIT_ULL(QCOM_SCM_VMID_HLOS);
+
+	return qcom_scm_assign_mem(__pfn_to_phys(folio_pfn(folio)),
+				   folio_size(folio), &src, new_perms, n);
+}
+
+static int
+qcom_scm_gunyah_rm_release_demand_page(struct gunyah_rm *rm, u16 vmid,
+				       enum gunyah_pagetable_access access,
+				       struct folio *folio)
+{
+	struct qcom_scm_vmperm new_perms;
+	u64 src;
+
+	new_perms.vmid = QCOM_SCM_VMID_HLOS;
+	new_perms.perm = QCOM_SCM_PERM_EXEC | QCOM_SCM_PERM_WRITE |
+			 QCOM_SCM_PERM_READ;
+
+	src = BIT_ULL(QCOM_SCM_RM_MANAGED_VMID);
+
+	if (access != GUNYAH_PAGETABLE_ACCESS_X &&
+	    access != GUNYAH_PAGETABLE_ACCESS_RX &&
+	    access != GUNYAH_PAGETABLE_ACCESS_RWX)
+		src |= BIT_ULL(QCOM_SCM_VMID_HLOS);
+
+	return qcom_scm_assign_mem(__pfn_to_phys(folio_pfn(folio)),
+				   folio_size(folio), &src, &new_perms, 1);
+}
+
+static struct gunyah_rm_platform_ops qcom_scm_gunyah_rm_platform_ops = {
+	.pre_mem_share = qcom_scm_gunyah_rm_pre_mem_share,
+	.post_mem_reclaim = qcom_scm_gunyah_rm_post_mem_reclaim,
+	.pre_demand_page = qcom_scm_gunyah_rm_pre_demand_page,
+	.release_demand_page = qcom_scm_gunyah_rm_release_demand_page,
+};
+
+/* {19bd54bd-0b37-571b-946f-609b54539de6} */
+static const uuid_t QCOM_EXT_UUID = UUID_INIT(0x19bd54bd, 0x0b37, 0x571b, 0x94,
+					      0x6f, 0x60, 0x9b, 0x54, 0x53,
+					      0x9d, 0xe6);
+
+#define GUNYAH_QCOM_EXT_CALL_UUID_ID                              \
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
+			   ARM_SMCCC_OWNER_VENDOR_HYP, 0x3f01)
+
+static bool gunyah_has_qcom_extensions(void)
+{
+	struct arm_smccc_res res;
+	uuid_t uuid;
+	u32 *up;
+
+	arm_smccc_1_1_smc(GUNYAH_QCOM_EXT_CALL_UUID_ID, &res);
+
+	up = (u32 *)&uuid.b[0];
+	up[0] = lower_32_bits(res.a0);
+	up[1] = lower_32_bits(res.a1);
+	up[2] = lower_32_bits(res.a2);
+	up[3] = lower_32_bits(res.a3);
+
+	return uuid_equal(&uuid, &QCOM_EXT_UUID);
+}
+
+static int __init qcom_gunyah_platform_hooks_register(void)
+{
+	if (!gunyah_has_qcom_extensions())
+		return -ENODEV;
+
+	pr_info("Enabling Gunyah hooks for Qualcomm platforms.\n");
+
+	return gunyah_rm_register_platform_ops(
+		&qcom_scm_gunyah_rm_platform_ops);
+}
+
+static void __exit qcom_gunyah_platform_hooks_unregister(void)
+{
+	gunyah_rm_unregister_platform_ops(&qcom_scm_gunyah_rm_platform_ops);
+}
+
+module_init(qcom_gunyah_platform_hooks_register);
+module_exit(qcom_gunyah_platform_hooks_unregister);
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Platform Hooks for Gunyah");
+MODULE_LICENSE("GPL");

-- 
2.34.1


