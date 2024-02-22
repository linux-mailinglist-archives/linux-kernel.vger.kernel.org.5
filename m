Return-Path: <linux-kernel+bounces-77509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227878606A6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C7DFB209CF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5403A149383;
	Thu, 22 Feb 2024 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A7W7wqej"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECFC13BAE1;
	Thu, 22 Feb 2024 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643830; cv=none; b=KCRQsMzGznSbXKzSHiLaHhbQNDAgNB3PJCHkcuWV4mDZUQDvGObDimsNhaTF/dKMkFYHj53HEchpHzWCXtVHfVQEiDPYb491TT6qJ6LWY81+NLLY9Nd28xHCoo8Cw7rXyTvjuRiw5QIR8LLYlxIHFcmyaU7pLU0vGcaRSVWzrDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643830; c=relaxed/simple;
	bh=CDMvd7OLfgO/mBRQoSaY+UNedhf98h+Fb9zoMiBia6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bEFxQT+P5km4HSARrFroxMNObP6CdPpUjHjk9rVgzxXjFqTvK7n57h+bPVohzc6Wvn1pV6Y4XzSquXHn4mLN/GFjKR1yLSRYZZdVc31/Sh5NAe8XU74ymzu16ec/X5JA2CKQrz828ZRhwKcqXf/VNHI4MUvO4ce25vyWG/ze6Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A7W7wqej; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MMgV2w013376;
	Thu, 22 Feb 2024 23:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=vo+GeAkZrIZtCLsV/xLZNLxXgjO/d+8dOj+GwHIQAtA
	=; b=A7W7wqejQwx3z1l/oM1GMtburTD6EFddQKuBnKoGYLGt2+b9GKt7z5tgI+G
	tQHISS7AKjdH4P9r6NEvYcAS1YEnqMEl4l7LBJGz+lBPWzDkqhGp7J00N/ASyFv7
	giXzs6CtafrawcvfKE6jMLd5ioTl+Yzaz/N9ZHiNFn7ZA9JkxjWn4vXULo5frsSc
	7Vy3gId/qgro/Z87uWkyIb9/gmkAT2Q+Fvi3uvaZvGzBlFUaA/T25boT/q52goHP
	ub10yfU0ASdLHaWMCuQGHCwxf1FeVtHZ9WkKVYXBGi8CnWC/MwZ0Voeqme+oX/is
	6YtjBUgtQxGqEuVVP3Dwrb9DtKA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wea7csc2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:43 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MNGhwg027798
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:43 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:16:42 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Thu, 22 Feb 2024 15:16:51 -0800
Subject: [PATCH v17 28/35] virt: gunyah: Enable demand paging
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-gunyah-v17-28-1e9da6763d38@quicinc.com>
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
X-Proofpoint-ORIG-GUID: LcPB2YrX8aG6g6aI739ImLk5MugK1jGr
X-Proofpoint-GUID: LcPB2YrX8aG6g6aI739ImLk5MugK1jGr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220179

Tell resource manager to enable demand paging and wire vCPU faults to
provide the backing folio when a guestmemfd is bound to the faulting
access.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/guest_memfd.c | 94 +++++++++++++++++++++++++++++++++++++++
 drivers/virt/gunyah/gunyah_vcpu.c | 41 +++++++++++++----
 drivers/virt/gunyah/vm_mgr.c      | 29 ++++++++++++
 drivers/virt/gunyah/vm_mgr.h      |  3 ++
 4 files changed, 159 insertions(+), 8 deletions(-)

diff --git a/drivers/virt/gunyah/guest_memfd.c b/drivers/virt/gunyah/guest_memfd.c
index 0c35ffa616d9c..797bc29a520bc 100644
--- a/drivers/virt/gunyah/guest_memfd.c
+++ b/drivers/virt/gunyah/guest_memfd.c
@@ -891,3 +891,97 @@ int gunyah_gmem_reclaim_parcel(struct gunyah_vm *ghvm,
 
 	return 0;
 }
+
+int gunyah_gmem_setup_demand_paging(struct gunyah_vm *ghvm)
+{
+	struct gunyah_rm_mem_entry *entries;
+	struct gunyah_gmem_binding *b;
+	unsigned long index = 0;
+	u32 count = 0, i;
+	int ret = 0;
+
+	down_read(&ghvm->bindings_lock);
+	mt_for_each(&ghvm->bindings, b, index, ULONG_MAX)
+		if (gunyah_guest_mem_is_lend(ghvm, b->flags))
+			count++;
+
+	if (!count)
+		goto out;
+
+	entries = kcalloc(count, sizeof(*entries), GFP_KERNEL);
+	if (!entries) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	index = i = 0;
+	mt_for_each(&ghvm->bindings, b, index, ULONG_MAX) {
+		if (!gunyah_guest_mem_is_lend(ghvm, b->flags))
+			continue;
+		entries[i].phys_addr = cpu_to_le64(gunyah_gfn_to_gpa(b->gfn));
+		entries[i].size = cpu_to_le64(b->nr << PAGE_SHIFT);
+		if (++i == count)
+			break;
+	}
+
+	ret = gunyah_rm_vm_set_demand_paging(ghvm->rm, ghvm->vmid, i, entries);
+	kfree(entries);
+out:
+	up_read(&ghvm->bindings_lock);
+	return ret;
+}
+
+int gunyah_gmem_demand_page(struct gunyah_vm *ghvm, u64 gpa, bool write)
+{
+	unsigned long gfn = gunyah_gpa_to_gfn(gpa);
+	struct gunyah_gmem_binding *b;
+	struct folio *folio;
+	int ret;
+
+	down_read(&ghvm->bindings_lock);
+	b = mtree_load(&ghvm->bindings, gfn);
+	if (!b) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	if (write && !(b->flags & GUNYAH_MEM_ALLOW_WRITE)) {
+		ret = -EPERM;
+		goto unlock;
+	}
+
+	folio = gunyah_gmem_get_folio(file_inode(b->file),
+				      gunyah_gfn_to_off(b, gfn));
+	if (!folio) {
+		ret = -ENOMEM;
+		pr_err_ratelimited("Failed to obtain memory for guest addr %016llx\n", gpa);
+		goto unlock;
+	}
+
+	/**
+	 * the folio covers the requested guest address, but the folio may not
+	 * start at the requested guest address. recompute the gfn based on the
+	 * folio itself.
+	 */
+	gfn = gunyah_off_to_gfn(b, folio_index(folio));
+
+	filemap_invalidate_lock_shared(b->file->f_mapping);
+	ret = gunyah_vm_provide_folio(ghvm, folio, gfn,
+				      !gunyah_guest_mem_is_lend(ghvm, b->flags),
+				      !!(b->flags & GUNYAH_MEM_ALLOW_WRITE));
+	filemap_invalidate_unlock_shared(b->file->f_mapping);
+	if (ret) {
+		if (ret != -EAGAIN)
+			pr_err_ratelimited(
+				"Failed to provide folio for guest addr: %016llx: %d\n",
+				gpa, ret);
+		goto out;
+	}
+out:
+	folio_unlock(folio);
+	folio_put(folio);
+unlock:
+	up_read(&ghvm->bindings_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gunyah_gmem_demand_page);
diff --git a/drivers/virt/gunyah/gunyah_vcpu.c b/drivers/virt/gunyah/gunyah_vcpu.c
index 8192350f180b0..f8306620b1dd6 100644
--- a/drivers/virt/gunyah/gunyah_vcpu.c
+++ b/drivers/virt/gunyah/gunyah_vcpu.c
@@ -89,29 +89,44 @@ static irqreturn_t gunyah_vcpu_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void gunyah_handle_page_fault(
+static bool gunyah_handle_page_fault(
 	struct gunyah_vcpu *vcpu,
 	const struct gunyah_hypercall_vcpu_run_resp *vcpu_run_resp)
 {
 	u64 addr = vcpu_run_resp->state_data[0];
+	bool write = !!vcpu_run_resp->state_data[1];
+	int ret = 0;
+
+	ret = gunyah_gmem_demand_page(vcpu->ghvm, addr, write);
+	if (!ret || ret == -EAGAIN)
+		return true;
 
 	vcpu->vcpu_run->page_fault.resume_action = GUNYAH_VCPU_RESUME_FAULT;
-	vcpu->vcpu_run->page_fault.attempt = 0;
+	vcpu->vcpu_run->page_fault.attempt = ret;
 	vcpu->vcpu_run->page_fault.phys_addr = addr;
 	vcpu->vcpu_run->exit_reason = GUNYAH_VCPU_EXIT_PAGE_FAULT;
+	return false;
 }
 
-static void
-gunyah_handle_mmio(struct gunyah_vcpu *vcpu,
+static bool
+gunyah_handle_mmio(struct gunyah_vcpu *vcpu, unsigned long resume_data[3],
 		   const struct gunyah_hypercall_vcpu_run_resp *vcpu_run_resp)
 {
 	u64 addr = vcpu_run_resp->state_data[0],
 	    len = vcpu_run_resp->state_data[1],
 	    data = vcpu_run_resp->state_data[2];
+	int ret;
 
 	if (WARN_ON(len > sizeof(u64)))
 		len = sizeof(u64);
 
+	ret = gunyah_gmem_demand_page(vcpu->ghvm, addr,
+				      vcpu->vcpu_run->mmio.is_write);
+	if (!ret || ret == -EAGAIN) {
+		resume_data[1] = GUNYAH_ADDRSPACE_VMMIO_ACTION_RETRY;
+		return true;
+	}
+
 	if (vcpu_run_resp->state == GUNYAH_VCPU_ADDRSPACE_VMMIO_READ) {
 		vcpu->vcpu_run->mmio.is_write = 0;
 		/* Record that we need to give vCPU user's supplied value next gunyah_vcpu_run() */
@@ -128,11 +143,15 @@ gunyah_handle_mmio(struct gunyah_vcpu *vcpu,
 	vcpu->mmio_addr = vcpu->vcpu_run->mmio.phys_addr = addr;
 	vcpu->vcpu_run->mmio.len = len;
 	vcpu->vcpu_run->exit_reason = GUNYAH_VCPU_EXIT_MMIO;
+
+	return false;
 }
 
 static int gunyah_handle_mmio_resume(struct gunyah_vcpu *vcpu,
 				     unsigned long resume_data[3])
 {
+	bool write = vcpu->state == GUNYAH_VCPU_RUN_STATE_MMIO_WRITE;
+
 	switch (vcpu->vcpu_run->mmio.resume_action) {
 	case GUNYAH_VCPU_RESUME_HANDLED:
 		if (vcpu->state == GUNYAH_VCPU_RUN_STATE_MMIO_READ) {
@@ -148,6 +167,8 @@ static int gunyah_handle_mmio_resume(struct gunyah_vcpu *vcpu,
 		resume_data[1] = GUNYAH_ADDRSPACE_VMMIO_ACTION_FAULT;
 		break;
 	case GUNYAH_VCPU_RESUME_RETRY:
+		/* userspace probably added a memory binding */
+		gunyah_gmem_demand_page(vcpu->ghvm, vcpu->mmio_addr, write);
 		resume_data[1] = GUNYAH_ADDRSPACE_VMMIO_ACTION_RETRY;
 		break;
 	default:
@@ -310,11 +331,15 @@ static int gunyah_vcpu_run(struct gunyah_vcpu *vcpu)
 				break;
 			case GUNYAH_VCPU_ADDRSPACE_VMMIO_READ:
 			case GUNYAH_VCPU_ADDRSPACE_VMMIO_WRITE:
-				gunyah_handle_mmio(vcpu, &vcpu_run_resp);
-				goto out;
+				if (!gunyah_handle_mmio(vcpu, resume_data,
+							&vcpu_run_resp))
+					goto out;
+				break;
 			case GUNYAH_VCPU_ADDRSPACE_PAGE_FAULT:
-				gunyah_handle_page_fault(vcpu, &vcpu_run_resp);
-				goto out;
+				if (!gunyah_handle_page_fault(vcpu,
+							      &vcpu_run_resp))
+					goto out;
+				break;
 			default:
 				pr_warn_ratelimited(
 					"Unknown vCPU state: %llx\n",
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index 198a99d78c44c..473740a1f97d0 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -474,6 +474,23 @@ static int gunyah_vm_start(struct gunyah_vm *ghvm)
 		goto err;
 	}
 
+	ret = gunyah_gmem_setup_demand_paging(ghvm);
+	if (ret) {
+		dev_warn(ghvm->parent,
+			 "Failed to set up gmem demand paging: %d\n", ret);
+		goto err;
+	}
+
+	ret = gunyah_rm_vm_set_address_layout(
+		ghvm->rm, ghvm->vmid, GUNYAH_RM_RANGE_ID_IMAGE,
+		ghvm->dtb.parcel_start << PAGE_SHIFT,
+		ghvm->dtb.parcel_pages << PAGE_SHIFT);
+	if (ret) {
+		dev_warn(ghvm->parent,
+			 "Failed to set location of DTB mem parcel: %d\n", ret);
+		goto err;
+	}
+
 	ret = gunyah_rm_vm_init(ghvm->rm, ghvm->vmid);
 	if (ret) {
 		ghvm->vm_status = GUNYAH_RM_VM_STATUS_INIT_FAILED;
@@ -501,8 +518,20 @@ static int gunyah_vm_start(struct gunyah_vm *ghvm)
 		gunyah_vm_add_resource(ghvm, ghrsc);
 	}
 
+	ret = gunyah_vm_parcel_to_paged(ghvm, &ghvm->dtb.parcel,
+					ghvm->dtb.parcel_start,
+					ghvm->dtb.parcel_pages);
+	if (ret)
+		goto err;
+
 	ret = gunyah_rm_vm_start(ghvm->rm, ghvm->vmid);
 	if (ret) {
+		/**
+		 * need to rollback parcel_to_paged because RM is still
+		 * tracking the parcel
+		 */
+		gunyah_vm_mm_erase_range(ghvm, ghvm->dtb.parcel_start,
+					 ghvm->dtb.parcel_pages);
 		dev_warn(ghvm->parent, "Failed to start VM: %d\n", ret);
 		goto err;
 	}
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index d8c299e5cf7cc..5eb14f30ba965 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -199,4 +199,7 @@ int gunyah_gmem_reclaim_parcel(struct gunyah_vm *ghvm,
 			       struct gunyah_rm_mem_parcel *parcel, u64 gfn,
 			       u64 nr);
 
+int gunyah_gmem_setup_demand_paging(struct gunyah_vm *ghvm);
+int gunyah_gmem_demand_page(struct gunyah_vm *ghvm, u64 gpa, bool write);
+
 #endif

-- 
2.34.1


