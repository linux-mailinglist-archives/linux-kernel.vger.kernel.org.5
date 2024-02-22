Return-Path: <linux-kernel+bounces-77507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF0986069A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3F6287646
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467B5143C61;
	Thu, 22 Feb 2024 23:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IDTBGxDV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46AE137938;
	Thu, 22 Feb 2024 23:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643830; cv=none; b=XuT5iR3g6ngDRpNLHLe3JsR0IvCN0F1JAa9UYPsn0sK9b+jJPbrg2FVuRk0hp5mpha74S0NR/HxCGcrMmTCdKZ5D5E2RiK+ZoOb430i+sPK355r6NP1GrHBu/20kdSVBLqfeiuWI0AcXuH6935qulX1WYmWPl6ThFNIPz32mjHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643830; c=relaxed/simple;
	bh=wqcFf5tGf65Rykb5i/CI/IkG99/aSu0nMjKt5dgScTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Hux/fjyU2xrcLub9BmrUb+rYG2S+vrRaec71Ybs99Eo8N0BY3kavyBUOKvnzc74GZifkfyr500Mrj9QdVJCNcmGNwQ/dNtAbtuigjzlarFrg/CrtWjp1pJXWAzrNJAW6dnmyHgNeWKmhi/tG90K1lOa6BeDYmpf2mDWOTmy+H0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IDTBGxDV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MLfuAN024795;
	Thu, 22 Feb 2024 23:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=qh+jPnXSbiXkdzqCKqtelkO/e60PKZzxBC0LGQzikQc
	=; b=IDTBGxDVMlOnY9TRPjx4tn4PXf17/qS4NpZe+wOYSSQw3iNSpU6nagDoQtU
	lOfNy+ctynbmIER1vf6k7eVjaJ5TZ527gZzso64lNSuy1MbsTXzYWLJ4AJppev60
	1JoxGYk6Z/xgM2ufdsF+tKvtlpk8va6rog29gvVVHWYvABhKJRfAUQkqGKK8LIZe
	qXKe6Cq/jx2vnY0oWB3g/2DH4RZR4nS4Bhs1WAqFyKSuWrVMJd2Mh5Ano6euMOIL
	wyQBJ38QGUjEn+gipIe2o1MH/SO/A4MjcJ+nx2KgpIIEnZbZXICRiEPu+ZMhq/eV
	d5eY2NgnIM/UorcVShQACEI3cVQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we4dq17sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MNGklC028227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:46 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:16:45 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Thu, 22 Feb 2024 15:16:56 -0800
Subject: [PATCH v17 33/35] virt: gunyah: Add IO handlers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-gunyah-v17-33-1e9da6763d38@quicinc.com>
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
X-Proofpoint-GUID: _RzcJvsLBoQGikWouASJqOQmU4qKmExK
X-Proofpoint-ORIG-GUID: _RzcJvsLBoQGikWouASJqOQmU4qKmExK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220179

Add framework for VM functions to handle stage-2 write faults from Gunyah
guest virtual machines. IO handlers have a range of addresses which they
apply to. Optionally, they may apply to only when the value written
matches the IO handler's value.

Reviewed-by: Alex Elder <elder@linaro.org>
Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/gunyah_vcpu.c |   4 ++
 drivers/virt/gunyah/vm_mgr.c      | 115 ++++++++++++++++++++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.h      |   8 +++
 include/linux/gunyah.h            |  29 ++++++++++
 4 files changed, 156 insertions(+)

diff --git a/drivers/virt/gunyah/gunyah_vcpu.c b/drivers/virt/gunyah/gunyah_vcpu.c
index f8306620b1dd6..ef78503fe586d 100644
--- a/drivers/virt/gunyah/gunyah_vcpu.c
+++ b/drivers/virt/gunyah/gunyah_vcpu.c
@@ -133,6 +133,10 @@ gunyah_handle_mmio(struct gunyah_vcpu *vcpu, unsigned long resume_data[3],
 		vcpu->state = GUNYAH_VCPU_RUN_STATE_MMIO_READ;
 		vcpu->mmio_read_len = len;
 	} else { /* GUNYAH_VCPU_ADDRSPACE_VMMIO_WRITE */
+		if (!gunyah_vm_mmio_write(vcpu->ghvm, addr, len, data)) {
+			resume_data[0] = GUNYAH_ADDRSPACE_VMMIO_ACTION_EMULATE;
+			return true;
+		}
 		vcpu->vcpu_run->mmio.is_write = 1;
 		memcpy(vcpu->vcpu_run->mmio.data, &data, len);
 		vcpu->state = GUNYAH_VCPU_RUN_STATE_MMIO_WRITE;
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index a61a3f3ae92f1..2434be5dffe08 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -302,6 +302,118 @@ static void gunyah_vm_clean_resources(struct gunyah_vm *ghvm)
 	mutex_unlock(&ghvm->resources_lock);
 }
 
+static int _gunyah_vm_io_handler_compare(const struct rb_node *node,
+					 const struct rb_node *parent)
+{
+	struct gunyah_vm_io_handler *n =
+		container_of(node, struct gunyah_vm_io_handler, node);
+	struct gunyah_vm_io_handler *p =
+		container_of(parent, struct gunyah_vm_io_handler, node);
+
+	if (n->addr < p->addr)
+		return -1;
+	if (n->addr > p->addr)
+		return 1;
+	if ((n->len && !p->len) || (!n->len && p->len))
+		return 0;
+	if (n->len < p->len)
+		return -1;
+	if (n->len > p->len)
+		return 1;
+	/* one of the io handlers doesn't have datamatch and the other does.
+	 * For purposes of comparison, that makes them identical since the
+	 * one that doesn't have datamatch will cover the same handler that
+	 * does.
+	 */
+	if (n->datamatch != p->datamatch)
+		return 0;
+	if (n->data < p->data)
+		return -1;
+	if (n->data > p->data)
+		return 1;
+	return 0;
+}
+
+static int gunyah_vm_io_handler_compare(struct rb_node *node,
+					const struct rb_node *parent)
+{
+	return _gunyah_vm_io_handler_compare(node, parent);
+}
+
+static int gunyah_vm_io_handler_find(const void *key,
+				     const struct rb_node *node)
+{
+	const struct gunyah_vm_io_handler *k = key;
+
+	return _gunyah_vm_io_handler_compare(&k->node, node);
+}
+
+static struct gunyah_vm_io_handler *
+gunyah_vm_mgr_find_io_hdlr(struct gunyah_vm *ghvm, u64 addr, u64 len, u64 data)
+{
+	struct gunyah_vm_io_handler key = {
+		.addr = addr,
+		.len = len,
+		.datamatch = true,
+		.data = data,
+	};
+	struct rb_node *node;
+
+	node = rb_find(&key, &ghvm->mmio_handler_root,
+		       gunyah_vm_io_handler_find);
+	if (!node)
+		return NULL;
+
+	return container_of(node, struct gunyah_vm_io_handler, node);
+}
+
+int gunyah_vm_mmio_write(struct gunyah_vm *ghvm, u64 addr, u32 len, u64 data)
+{
+	struct gunyah_vm_io_handler *io_hdlr = NULL;
+	int ret;
+
+	down_read(&ghvm->mmio_handler_lock);
+	io_hdlr = gunyah_vm_mgr_find_io_hdlr(ghvm, addr, len, data);
+	if (!io_hdlr || !io_hdlr->ops || !io_hdlr->ops->write) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	ret = io_hdlr->ops->write(io_hdlr, addr, len, data);
+
+out:
+	up_read(&ghvm->mmio_handler_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gunyah_vm_mmio_write);
+
+int gunyah_vm_add_io_handler(struct gunyah_vm *ghvm,
+			     struct gunyah_vm_io_handler *io_hdlr)
+{
+	struct rb_node *found;
+
+	if (io_hdlr->datamatch &&
+	    (!io_hdlr->len || io_hdlr->len > sizeof(io_hdlr->data)))
+		return -EINVAL;
+
+	down_write(&ghvm->mmio_handler_lock);
+	found = rb_find_add(&io_hdlr->node, &ghvm->mmio_handler_root,
+			    gunyah_vm_io_handler_compare);
+	up_write(&ghvm->mmio_handler_lock);
+
+	return found ? -EEXIST : 0;
+}
+EXPORT_SYMBOL_GPL(gunyah_vm_add_io_handler);
+
+void gunyah_vm_remove_io_handler(struct gunyah_vm *ghvm,
+				 struct gunyah_vm_io_handler *io_hdlr)
+{
+	down_write(&ghvm->mmio_handler_lock);
+	rb_erase(&io_hdlr->node, &ghvm->mmio_handler_root);
+	up_write(&ghvm->mmio_handler_lock);
+}
+EXPORT_SYMBOL_GPL(gunyah_vm_remove_io_handler);
+
 static int gunyah_vm_rm_notification_status(struct gunyah_vm *ghvm, void *data)
 {
 	struct gunyah_rm_vm_status_payload *payload = data;
@@ -404,6 +516,9 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gunyah_rm *rm)
 	INIT_LIST_HEAD(&ghvm->resource_tickets);
 	xa_init(&ghvm->boot_context);
 
+	init_rwsem(&ghvm->mmio_handler_lock);
+	ghvm->mmio_handler_root = RB_ROOT;
+
 	mt_init(&ghvm->mm);
 	mt_init(&ghvm->bindings);
 	init_rwsem(&ghvm->bindings_lock);
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 8cee93e551700..daddb1d0cb70b 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -11,6 +11,7 @@
 #include <linux/maple_tree.h>
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
+#include <linux/rbtree.h>
 #include <linux/rwsem.h>
 #include <linux/set_memory.h>
 #include <linux/wait.h>
@@ -58,6 +59,9 @@ long gunyah_dev_vm_mgr_ioctl(struct gunyah_rm *rm, unsigned int cmd,
  * @guest_shared_extent_ticket: Resource ticket to the capability for
  *                              the memory extent that represents
  *                              memory shared with the guest.
+ * @mmio_handler_root: RB tree of MMIO handlers.
+ *                     Entries are &struct gunyah_vm_io_handler
+ * @mmio_handler_lock: Serialization of traversing @mmio_handler_root
  * @rm: Pointer to the resource manager struct to make RM calls
  * @parent: For logging
  * @nb: Notifier block for RM notifications
@@ -93,6 +97,8 @@ struct gunyah_vm {
 	struct gunyah_vm_resource_ticket addrspace_ticket,
 		host_private_extent_ticket, host_shared_extent_ticket,
 		guest_private_extent_ticket, guest_shared_extent_ticket;
+	struct rb_root mmio_handler_root;
+	struct rw_semaphore mmio_handler_lock;
 
 	struct gunyah_rm *rm;
 
@@ -119,6 +125,8 @@ struct gunyah_vm {
 	struct xarray boot_context;
 };
 
+int gunyah_vm_mmio_write(struct gunyah_vm *ghvm, u64 addr, u32 len, u64 data);
+
 /**
  * folio_mmapped() - Returns true if the folio is mapped into any vma
  * @folio: Folio to test
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index a9d58150de696..dbd5b0251b491 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -155,6 +155,35 @@ int gunyah_vm_add_resource_ticket(struct gunyah_vm *ghvm,
 void gunyah_vm_remove_resource_ticket(struct gunyah_vm *ghvm,
 				      struct gunyah_vm_resource_ticket *ticket);
 
+/*
+ * gunyah_vm_io_handler contains the info about an io device and its associated
+ * addr and the ops associated with the io device.
+ */
+struct gunyah_vm_io_handler {
+	struct rb_node node;
+	u64 addr;
+
+	bool datamatch;
+	u8 len;
+	u64 data;
+	struct gunyah_vm_io_handler_ops *ops;
+};
+
+/*
+ * gunyah_vm_io_handler_ops contains function pointers associated with an iodevice.
+ */
+struct gunyah_vm_io_handler_ops {
+	int (*read)(struct gunyah_vm_io_handler *io_dev, u64 addr, u32 len,
+		    u64 data);
+	int (*write)(struct gunyah_vm_io_handler *io_dev, u64 addr, u32 len,
+		     u64 data);
+};
+
+int gunyah_vm_add_io_handler(struct gunyah_vm *ghvm,
+			     struct gunyah_vm_io_handler *io_dev);
+void gunyah_vm_remove_io_handler(struct gunyah_vm *ghvm,
+				 struct gunyah_vm_io_handler *io_dev);
+
 #define GUNYAH_RM_ACL_X BIT(0)
 #define GUNYAH_RM_ACL_W BIT(1)
 #define GUNYAH_RM_ACL_R BIT(2)

-- 
2.34.1


