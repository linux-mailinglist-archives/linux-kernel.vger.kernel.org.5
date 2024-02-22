Return-Path: <linux-kernel+bounces-77516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04788606B2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1491C22CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D632D14CAD7;
	Thu, 22 Feb 2024 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SR9SpbtC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8180614039E;
	Thu, 22 Feb 2024 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643833; cv=none; b=eHHUGkl1far4+pgcmcQiAApwTlGm/a+e5N2f5K6xhsrPI+GippejgXkiuhw0gfLBQVcOIoDUN0HW312c40nAWleMJCCLRDbroINhVsMiw3M9OlBLjfx/8ZJ/ZBYuQDuMBGHp1N6IgGrwWFRXtNgyk78e7sQdslZAEmjx98mSyKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643833; c=relaxed/simple;
	bh=aTThp0h82qE19PXVREZ49HFUww3xwOtBkjpZuOE+pVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=txDvhcOd8CW4tRmlkPzeUKDu6gOytA/qqvWVjuAPFwtzWnWNvdfp6rqY9Z/9Gjw5KDz/Kn+qeh5nZXQw1cS1dRB4EWpz3k/kgzgFiYLK/VpGgymhdfu6VVPfMdI7pe9VsVUI3uP9rxFdkLnemFHQz5HxlxWGKRWxGlsEORBpN1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SR9SpbtC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MMxSGX017355;
	Thu, 22 Feb 2024 23:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=jVo09/u52xKS3SRP+ridwNYZaY+tDvXa3dwfznZpMSA
	=; b=SR9SpbtCK3RJoI6pmPizVQ/1cN+SIGggZje2hd7SLOIPkKWH6PRHeOGXwic
	U362InafOqvSN5BBSTlmatkSf+Poe81sh7LheYO+wgHsYRmThnzHMZMQL/88BQGf
	gOgr+hx9PZCbHEiRcfO7E1Kc24mwZsw/Isna8kQEWqKenHuV/hI4TAAjwncLiGwK
	09ukalV3//bGcUvvWyVC5wy7G4FSXomXONadpMOlOvKP8OTvl1as/IH7he2aIFc7
	Qm921En7tkQfEDMXN6u580V9q+kbZaKuQ69SqxGdoPDa3liMRnX1feebSG+GmUKt
	24etU0UED5lGzSJY+0RQFAX4x6w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we1b0jxsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MNGdgD018255
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:39 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:16:38 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Thu, 22 Feb 2024 15:16:44 -0800
Subject: [PATCH v17 21/35] gunyah: rsc_mgr: Add platform ops on
 mem_lend/mem_reclaim
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-gunyah-v17-21-1e9da6763d38@quicinc.com>
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
X-Proofpoint-ORIG-GUID: w0XRV1HAULetVECwnmYzVyZ97RenARDd
X-Proofpoint-GUID: w0XRV1HAULetVECwnmYzVyZ97RenARDd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220179

On Qualcomm platforms, there is a firmware entity which controls access
to physical pages. In order to share memory with another VM, this entity
needs to be informed that the guest VM should have access to the memory.

Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Kconfig                 |   4 +
 drivers/virt/gunyah/Makefile                |   1 +
 drivers/virt/gunyah/gunyah_platform_hooks.c | 117 ++++++++++++++++++++++++++++
 drivers/virt/gunyah/rsc_mgr.h               |  10 +++
 drivers/virt/gunyah/rsc_mgr_rpc.c           |  20 ++++-
 drivers/virt/gunyah/vm_mgr_mem.c            |  39 +++++++++-
 include/linux/gunyah.h                      |  63 ++++++++++++---
 7 files changed, 237 insertions(+), 17 deletions(-)

diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index 6f4c85db80b52..23ba523d25dc8 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -3,6 +3,7 @@
 config GUNYAH
 	tristate "Gunyah Virtualization drivers"
 	depends on ARM64
+	select GUNYAH_PLATFORM_HOOKS
 	help
 	  The Gunyah drivers are the helper interfaces that run in a guest VM
 	  such as basic inter-VM IPC and signaling mechanisms, and higher level
@@ -10,3 +11,6 @@ config GUNYAH
 
 	  Say Y/M here to enable the drivers needed to interact in a Gunyah
 	  virtual environment.
+
+config GUNYAH_PLATFORM_HOOKS
+	tristate
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index f3c9507224eeb..ffcde0e0ccfa9 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -3,3 +3,4 @@
 gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mem.o
 
 obj-$(CONFIG_GUNYAH) += gunyah.o gunyah_rsc_mgr.o gunyah_vcpu.o
+obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
diff --git a/drivers/virt/gunyah/gunyah_platform_hooks.c b/drivers/virt/gunyah/gunyah_platform_hooks.c
new file mode 100644
index 0000000000000..b03795df00144
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah_platform_hooks.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/gunyah.h>
+#include <linux/module.h>
+#include <linux/rwsem.h>
+
+#include "rsc_mgr.h"
+
+static const struct gunyah_rm_platform_ops *rm_platform_ops;
+static DECLARE_RWSEM(rm_platform_ops_lock);
+
+int gunyah_rm_platform_pre_mem_share(struct gunyah_rm *rm,
+				     struct gunyah_rm_mem_parcel *mem_parcel)
+{
+	int ret = 0;
+
+	down_read(&rm_platform_ops_lock);
+	if (rm_platform_ops && rm_platform_ops->pre_mem_share)
+		ret = rm_platform_ops->pre_mem_share(rm, mem_parcel);
+	up_read(&rm_platform_ops_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gunyah_rm_platform_pre_mem_share);
+
+int gunyah_rm_platform_post_mem_reclaim(struct gunyah_rm *rm,
+					struct gunyah_rm_mem_parcel *mem_parcel)
+{
+	int ret = 0;
+
+	down_read(&rm_platform_ops_lock);
+	if (rm_platform_ops && rm_platform_ops->post_mem_reclaim)
+		ret = rm_platform_ops->post_mem_reclaim(rm, mem_parcel);
+	up_read(&rm_platform_ops_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gunyah_rm_platform_post_mem_reclaim);
+
+int gunyah_rm_platform_pre_demand_page(struct gunyah_rm *rm, u16 vmid,
+				       enum gunyah_pagetable_access access,
+				       struct folio *folio)
+{
+	int ret = 0;
+
+	down_read(&rm_platform_ops_lock);
+	if (rm_platform_ops && rm_platform_ops->pre_demand_page)
+		ret = rm_platform_ops->pre_demand_page(rm, vmid, access, folio);
+	up_read(&rm_platform_ops_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gunyah_rm_platform_pre_demand_page);
+
+int gunyah_rm_platform_reclaim_demand_page(struct gunyah_rm *rm, u16 vmid,
+					   enum gunyah_pagetable_access access,
+					   struct folio *folio)
+{
+	int ret = 0;
+
+	down_read(&rm_platform_ops_lock);
+	if (rm_platform_ops && rm_platform_ops->pre_demand_page)
+		ret = rm_platform_ops->release_demand_page(rm, vmid, access,
+							   folio);
+	up_read(&rm_platform_ops_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gunyah_rm_platform_reclaim_demand_page);
+
+int gunyah_rm_register_platform_ops(
+	const struct gunyah_rm_platform_ops *platform_ops)
+{
+	int ret = 0;
+
+	down_write(&rm_platform_ops_lock);
+	if (!rm_platform_ops)
+		rm_platform_ops = platform_ops;
+	else
+		ret = -EEXIST;
+	up_write(&rm_platform_ops_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gunyah_rm_register_platform_ops);
+
+void gunyah_rm_unregister_platform_ops(
+	const struct gunyah_rm_platform_ops *platform_ops)
+{
+	down_write(&rm_platform_ops_lock);
+	if (rm_platform_ops == platform_ops)
+		rm_platform_ops = NULL;
+	up_write(&rm_platform_ops_lock);
+}
+EXPORT_SYMBOL_GPL(gunyah_rm_unregister_platform_ops);
+
+static void _devm_gunyah_rm_unregister_platform_ops(void *data)
+{
+	gunyah_rm_unregister_platform_ops(
+		(const struct gunyah_rm_platform_ops *)data);
+}
+
+int devm_gunyah_rm_register_platform_ops(
+	struct device *dev, const struct gunyah_rm_platform_ops *ops)
+{
+	int ret;
+
+	ret = gunyah_rm_register_platform_ops(ops);
+	if (ret)
+		return ret;
+
+	return devm_add_action(dev, _devm_gunyah_rm_unregister_platform_ops,
+			       (void *)ops);
+}
+EXPORT_SYMBOL_GPL(devm_gunyah_rm_register_platform_ops);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Gunyah Platform Hooks");
diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index ec8ad8149e8ef..68d08d3cff02d 100644
--- a/drivers/virt/gunyah/rsc_mgr.h
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -117,4 +117,14 @@ int gunyah_rm_call(struct gunyah_rm *rsc_mgr, u32 message_id,
 		   const void *req_buf, size_t req_buf_size, void **resp_buf,
 		   size_t *resp_buf_size);
 
+int gunyah_rm_platform_pre_mem_share(struct gunyah_rm *rm,
+				     struct gunyah_rm_mem_parcel *mem_parcel);
+int gunyah_rm_platform_post_mem_reclaim(
+	struct gunyah_rm *rm, struct gunyah_rm_mem_parcel *mem_parcel);
+
+int gunyah_rm_platform_pre_demand_page(struct gunyah_rm *rm, u16 vmid,
+				       u32 flags, struct folio *folio);
+int gunyah_rm_platform_reclaim_demand_page(struct gunyah_rm *rm, u16 vmid,
+					   u32 flags, struct folio *folio);
+
 #endif
diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
index eb06940bb3c53..99e5a3f1a5bb9 100644
--- a/drivers/virt/gunyah/rsc_mgr_rpc.c
+++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
@@ -209,6 +209,12 @@ int gunyah_rm_mem_share(struct gunyah_rm *rm, struct gunyah_rm_mem_parcel *p)
 	if (!msg)
 		return -ENOMEM;
 
+	ret = gunyah_rm_platform_pre_mem_share(rm, p);
+	if (ret) {
+		kfree(msg);
+		return ret;
+	}
+
 	req_header = msg;
 	acl = (void *)req_header + sizeof(*req_header);
 	mem = (void *)acl + acl_size;
@@ -234,8 +240,10 @@ int gunyah_rm_mem_share(struct gunyah_rm *rm, struct gunyah_rm_mem_parcel *p)
 			     &resp_size);
 	kfree(msg);
 
-	if (ret)
+	if (ret) {
+		gunyah_rm_platform_post_mem_reclaim(rm, p);
 		return ret;
+	}
 
 	p->mem_handle = le32_to_cpu(*resp);
 	kfree(resp);
@@ -267,9 +275,15 @@ int gunyah_rm_mem_reclaim(struct gunyah_rm *rm,
 	struct gunyah_rm_mem_release_req req = {
 		.mem_handle = cpu_to_le32(parcel->mem_handle),
 	};
+	int ret;
 
-	return gunyah_rm_call(rm, GUNYAH_RM_RPC_MEM_RECLAIM, &req, sizeof(req),
-			      NULL, NULL);
+	ret = gunyah_rm_call(rm, GUNYAH_RM_RPC_MEM_RECLAIM, &req, sizeof(req),
+			     NULL, NULL);
+	/* Only call platform mem reclaim hooks if we reclaimed the memory */
+	if (ret)
+		return ret;
+
+	return gunyah_rm_platform_post_mem_reclaim(rm, parcel);
 }
 ALLOW_ERROR_INJECTION(gunyah_rm_mem_reclaim, ERRNO);
 
diff --git a/drivers/virt/gunyah/vm_mgr_mem.c b/drivers/virt/gunyah/vm_mgr_mem.c
index bcc84473004be..5a4ea2b1a12ee 100644
--- a/drivers/virt/gunyah/vm_mgr_mem.c
+++ b/drivers/virt/gunyah/vm_mgr_mem.c
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 
+#include "rsc_mgr.h"
 #include "vm_mgr.h"
 
 #define WRITE_TAG (1 << 0)
@@ -107,7 +108,7 @@ int gunyah_vm_provide_folio(struct gunyah_vm *ghvm, struct folio *folio,
 	size_t size = folio_size(folio);
 	enum gunyah_error gunyah_error;
 	unsigned long tag = 0;
-	int ret;
+	int ret, tmp;
 
 	/* clang-format off */
 	if (share) {
@@ -158,6 +159,11 @@ int gunyah_vm_provide_folio(struct gunyah_vm *ghvm, struct folio *folio,
 	else /* !share && !write */
 		access = GUNYAH_PAGETABLE_ACCESS_RX;
 
+	ret = gunyah_rm_platform_pre_demand_page(ghvm->rm, ghvm->vmid, access,
+						 folio);
+	if (ret)
+		goto reclaim_host;
+
 	gunyah_error = gunyah_hypercall_memextent_donate(donate_flags(share),
 							 host_extent->capid,
 							 guest_extent->capid,
@@ -166,7 +172,7 @@ int gunyah_vm_provide_folio(struct gunyah_vm *ghvm, struct folio *folio,
 		pr_err("Failed to donate memory for guest address 0x%016llx: %d\n",
 		       gpa, gunyah_error);
 		ret = gunyah_error_remap(gunyah_error);
-		goto remove;
+		goto platform_release;
 	}
 
 	extent_attrs =
@@ -197,6 +203,16 @@ int gunyah_vm_provide_folio(struct gunyah_vm *ghvm, struct folio *folio,
 	if (gunyah_error != GUNYAH_ERROR_OK)
 		pr_err("Failed to reclaim memory donation for guest address 0x%016llx: %d\n",
 		       gpa, gunyah_error);
+platform_release:
+	tmp = gunyah_rm_platform_reclaim_demand_page(ghvm->rm, ghvm->vmid,
+						     access, folio);
+	if (tmp) {
+		pr_err("Platform failed to reclaim memory for guest address 0x%016llx: %d",
+		       gpa, tmp);
+		return ret;
+	}
+reclaim_host:
+	gunyah_folio_host_reclaim(folio);
 remove:
 	mtree_erase(&ghvm->mm, gfn);
 	return ret;
@@ -207,6 +223,7 @@ static int __gunyah_vm_reclaim_folio_locked(struct gunyah_vm *ghvm, void *entry,
 {
 	u32 map_flags = BIT(GUNYAH_ADDRSPACE_MAP_FLAG_PARTIAL);
 	struct gunyah_resource *guest_extent, *host_extent, *addrspace;
+	enum gunyah_pagetable_access access;
 	enum gunyah_error gunyah_error;
 	struct folio *folio;
 	bool write, share;
@@ -264,6 +281,24 @@ static int __gunyah_vm_reclaim_folio_locked(struct gunyah_vm *ghvm, void *entry,
 		goto err;
 	}
 
+	if (share && write)
+		access = GUNYAH_PAGETABLE_ACCESS_RW;
+	else if (share && !write)
+		access = GUNYAH_PAGETABLE_ACCESS_R;
+	else if (!share && write)
+		access = GUNYAH_PAGETABLE_ACCESS_RWX;
+	else /* !share && !write */
+		access = GUNYAH_PAGETABLE_ACCESS_RX;
+
+	ret = gunyah_rm_platform_reclaim_demand_page(ghvm->rm, ghvm->vmid,
+						     access, folio);
+	if (ret) {
+		pr_err_ratelimited(
+			"Platform failed to reclaim memory for guest address 0x%016llx: %d",
+			gunyah_gfn_to_gpa(gfn), ret);
+		goto err;
+	}
+
 	BUG_ON(mtree_erase(&ghvm->mm, gfn) != entry);
 
 	if (folio_test_private(folio)) {
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index c23e1a88703e8..cfb80f40d4e4a 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -198,6 +198,57 @@ struct gunyah_rm_mem_parcel {
 	u32 mem_handle;
 };
 
+enum gunyah_pagetable_access {
+	/* clang-format off */
+	GUNYAH_PAGETABLE_ACCESS_NONE		= 0,
+	GUNYAH_PAGETABLE_ACCESS_X		= 1,
+	GUNYAH_PAGETABLE_ACCESS_W		= 2,
+	GUNYAH_PAGETABLE_ACCESS_R		= 4,
+	GUNYAH_PAGETABLE_ACCESS_RX		= 5,
+	GUNYAH_PAGETABLE_ACCESS_RW		= 6,
+	GUNYAH_PAGETABLE_ACCESS_RWX		= 7,
+	/* clang-format on */
+};
+
+struct gunyah_rm_platform_ops {
+	int (*pre_mem_share)(struct gunyah_rm *rm,
+			     struct gunyah_rm_mem_parcel *mem_parcel);
+	int (*post_mem_reclaim)(struct gunyah_rm *rm,
+				struct gunyah_rm_mem_parcel *mem_parcel);
+
+	int (*pre_demand_page)(struct gunyah_rm *rm, u16 vmid,
+			       enum gunyah_pagetable_access access,
+			       struct folio *folio);
+	int (*release_demand_page)(struct gunyah_rm *rm, u16 vmid,
+				   enum gunyah_pagetable_access access,
+				   struct folio *folio);
+};
+
+#if IS_ENABLED(CONFIG_GUNYAH_PLATFORM_HOOKS)
+int gunyah_rm_register_platform_ops(
+	const struct gunyah_rm_platform_ops *platform_ops);
+void gunyah_rm_unregister_platform_ops(
+	const struct gunyah_rm_platform_ops *platform_ops);
+int devm_gunyah_rm_register_platform_ops(
+	struct device *dev, const struct gunyah_rm_platform_ops *ops);
+#else
+static inline int gunyah_rm_register_platform_ops(
+	const struct gunyah_rm_platform_ops *platform_ops)
+{
+	return 0;
+}
+static inline void gunyah_rm_unregister_platform_ops(
+	const struct gunyah_rm_platform_ops *platform_ops)
+{
+}
+static inline int
+devm_gunyah_rm_register_platform_ops(struct device *dev,
+				     const struct gunyah_rm_platform_ops *ops)
+{
+	return 0;
+}
+#endif
+
 /******************************************************************************/
 /* Common arch-independent definitions for Gunyah hypercalls                  */
 #define GUNYAH_CAPID_INVAL U64_MAX
@@ -318,18 +369,6 @@ enum gunyah_error gunyah_hypercall_msgq_recv(u64 capid, void *buff, size_t size,
 
 #define GUNYAH_ADDRSPACE_SELF_CAP 0
 
-enum gunyah_pagetable_access {
-	/* clang-format off */
-	GUNYAH_PAGETABLE_ACCESS_NONE		= 0,
-	GUNYAH_PAGETABLE_ACCESS_X		= 1,
-	GUNYAH_PAGETABLE_ACCESS_W		= 2,
-	GUNYAH_PAGETABLE_ACCESS_R		= 4,
-	GUNYAH_PAGETABLE_ACCESS_RX		= 5,
-	GUNYAH_PAGETABLE_ACCESS_RW		= 6,
-	GUNYAH_PAGETABLE_ACCESS_RWX		= 7,
-	/* clang-format on */
-};
-
 /* clang-format off */
 #define GUNYAH_MEMEXTENT_MAPPING_USER_ACCESS		GENMASK_ULL(2, 0)
 #define GUNYAH_MEMEXTENT_MAPPING_KERNEL_ACCESS		GENMASK_ULL(6, 4)

-- 
2.34.1


