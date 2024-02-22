Return-Path: <linux-kernel+bounces-77504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31265860688
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD4E2879ED
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B8E140E5A;
	Thu, 22 Feb 2024 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OK1PaOz+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883CA225CD;
	Thu, 22 Feb 2024 23:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643828; cv=none; b=Dm5GYTykRUuuVNstCQtuYhSA6nGm8S/iOOLCfNqN85ubTkyEtaJEOS1O81Oa3WfgrSrFE2hSQCcPnLhdiQWRYF77GuO4Bj7qktakiFZ415vx0vN+5jbtQmwZisH8HQesWpN6RBZF2xI3/vZ3jz6yFzAjxgK/GM0wa7nH4mSMvwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643828; c=relaxed/simple;
	bh=3Ku50MPcHlW8bklRwtagHbw4kVw1F2tXarLTrTmq/MQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ObB75ZYbcJxLjdAME+WfevIOLZ9hhjWo9x9loJ/D2rv/zz+wsEREXIcbwlnLGRZa9MxK4AUb2d0gXP7qnsaTmh+LJOw1yheHXvqZn+BsES5g8rjoyCXDJ8eeBkx8uQA20J+cEfLaKvv+rUtHGy28r2X8zYZC0uXbkpJQmib0gKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OK1PaOz+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MLfvRH024356;
	Thu, 22 Feb 2024 23:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=8v1GY1FYViwr1gDiWHVBc+SJTGgDxddStunlcMOAt7k
	=; b=OK1PaOz+MYOt1PRQxr21Xpe1Yw0XL18uDDdIztRL7PEuhE3JQ6rNW4ykj/c
	TFUu4rzEt/UooddD9ZoWY/uReznTMNCQ9FfW3CVVcXiwHEqgXPZe01gKyevWGrRH
	75FD3ICt6slF1RYvDh7Pk+EtBthpUJzXhrOvXqpejpi1bJiJa1OUrcWV9XUv1/uF
	8mgM3AFhCOuXgzvwi9WSxQ3Z8mZj9Bv2LzMRpJnc60NkZPoyYTuCICfdzHNfM5Ve
	ar89z0RMjn9napJp36X5ULJ40hxBRzpBpxoTVC29GK7FiVbkaqEROK74OvcLoMLg
	TLMb7126bakdJar8ZKaTT9RI7WA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weedkr5f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MNGeOL017516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:40 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:16:39 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Thu, 22 Feb 2024 15:16:46 -0800
Subject: [PATCH v17 23/35] virt: gunyah: Implement guestmemfd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-gunyah-v17-23-1e9da6763d38@quicinc.com>
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
X-Proofpoint-ORIG-GUID: O6Ak6C4_gppeo900tdBS_Z0_5i7JFG4I
X-Proofpoint-GUID: O6Ak6C4_gppeo900tdBS_Z0_5i7JFG4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402220178

Memory provided to Gunyah virtual machines are provided by a
Gunyah guestmemfd. Because memory provided to virtual machines may be
unmapped at stage-2 from the host (i.e. in the hypervisor's page tables
for the host), special care needs to be taken to ensure that the kernel
doesn't have a page mapped when it is lent to the guest. Without this
tracking, a kernel panic could be induced  by userspace tricking the
kernel into accessing guest-private memory.

Introduce the basic guestmemfd ops and ioctl. Userspace should be able
to access the memory unless it is provided to the guest virtual machine:
this is necessary to allow userspace to preload binaries such as the
kernel Image prior to running the VM. Subsequent commits will wire up
providing the memory to the guest.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Makefile      |   2 +-
 drivers/virt/gunyah/guest_memfd.c | 276 ++++++++++++++++++++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.c      |   9 ++
 drivers/virt/gunyah/vm_mgr.h      |   2 +
 include/uapi/linux/gunyah.h       |  19 +++
 5 files changed, 307 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index a6c6f29b887a6..c4505fce177dd 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mem.o
+gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mem.o guest_memfd.o
 
 obj-$(CONFIG_GUNYAH) += gunyah.o gunyah_rsc_mgr.o gunyah_vcpu.o
 obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
diff --git a/drivers/virt/gunyah/guest_memfd.c b/drivers/virt/gunyah/guest_memfd.c
new file mode 100644
index 0000000000000..19c72aa1d0e5e
--- /dev/null
+++ b/drivers/virt/gunyah/guest_memfd.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "gunyah_guest_mem: " fmt
+
+#include <linux/anon_inodes.h>
+#include <linux/types.h>
+#include <linux/falloc.h>
+#include <linux/file.h>
+#include <linux/migrate.h>
+#include <linux/pagemap.h>
+
+#include <uapi/linux/gunyah.h>
+
+#include "vm_mgr.h"
+
+static struct folio *gunyah_gmem_get_huge_folio(struct inode *inode,
+						pgoff_t index)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	unsigned long huge_index = round_down(index, HPAGE_PMD_NR);
+	unsigned long flags = (unsigned long)inode->i_private;
+	struct address_space *mapping = inode->i_mapping;
+	gfp_t gfp = mapping_gfp_mask(mapping);
+	struct folio *folio;
+
+	if (!(flags & GHMF_ALLOW_HUGEPAGE))
+		return NULL;
+
+	if (filemap_range_has_page(mapping, huge_index << PAGE_SHIFT,
+				   (huge_index + HPAGE_PMD_NR - 1)
+					   << PAGE_SHIFT))
+		return NULL;
+
+	folio = filemap_alloc_folio(gfp, HPAGE_PMD_ORDER);
+	if (!folio)
+		return NULL;
+
+	if (filemap_add_folio(mapping, folio, huge_index, gfp)) {
+		folio_put(folio);
+		return NULL;
+	}
+
+	return folio;
+#else
+	return NULL;
+#endif
+}
+
+static struct folio *gunyah_gmem_get_folio(struct inode *inode, pgoff_t index)
+{
+	struct folio *folio;
+
+	folio = gunyah_gmem_get_huge_folio(inode, index);
+	if (!folio) {
+		folio = filemap_grab_folio(inode->i_mapping, index);
+		if (IS_ERR_OR_NULL(folio))
+			return NULL;
+	}
+
+	/*
+	 * Use the up-to-date flag to track whether or not the memory has been
+	 * zeroed before being handed off to the guest.  There is no backing
+	 * storage for the memory, so the folio will remain up-to-date until
+	 * it's removed.
+	 */
+	if (!folio_test_uptodate(folio)) {
+		unsigned long nr_pages = folio_nr_pages(folio);
+		unsigned long i;
+
+		for (i = 0; i < nr_pages; i++)
+			clear_highpage(folio_page(folio, i));
+
+		folio_mark_uptodate(folio);
+	}
+
+	/*
+	 * Ignore accessed, referenced, and dirty flags.  The memory is
+	 * unevictable and there is no storage to write back to.
+	 */
+	return folio;
+}
+
+static vm_fault_t gunyah_gmem_host_fault(struct vm_fault *vmf)
+{
+	struct folio *folio;
+
+	folio = gunyah_gmem_get_folio(file_inode(vmf->vma->vm_file),
+				      vmf->pgoff);
+	if (!folio)
+		return VM_FAULT_SIGBUS;
+
+	vmf->page = folio_file_page(folio, vmf->pgoff);
+
+	return VM_FAULT_LOCKED;
+}
+
+static const struct vm_operations_struct gunyah_gmem_vm_ops = {
+	.fault = gunyah_gmem_host_fault,
+};
+
+static int gunyah_gmem_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	file_accessed(file);
+	vma->vm_ops = &gunyah_gmem_vm_ops;
+	return 0;
+}
+
+/**
+ * gunyah_gmem_punch_hole() - try to reclaim a range of pages
+ * @inode: guest memfd inode
+ * @offset: Offset into memfd to start reclaim
+ * @len: length to reclaim
+ *
+ * Will try to unmap from virtual machines any folios covered by
+ * [offset, offset+len]. If unmapped, then tries to free those folios
+ *
+ * Returns - error code if any folio in the range couldn't be freed.
+ */
+static long gunyah_gmem_punch_hole(struct inode *inode, loff_t offset,
+				   loff_t len)
+{
+	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
+
+	return 0;
+}
+
+static long gunyah_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
+{
+	struct address_space *mapping = inode->i_mapping;
+	pgoff_t start, index, end;
+	int r;
+
+	/* Dedicated guest is immutable by default. */
+	if (offset + len > i_size_read(inode))
+		return -EINVAL;
+
+	filemap_invalidate_lock_shared(mapping);
+
+	start = offset >> PAGE_SHIFT;
+	end = (offset + len) >> PAGE_SHIFT;
+
+	r = 0;
+	for (index = start; index < end;) {
+		struct folio *folio;
+
+		if (signal_pending(current)) {
+			r = -EINTR;
+			break;
+		}
+
+		folio = gunyah_gmem_get_folio(inode, index);
+		if (!folio) {
+			r = -ENOMEM;
+			break;
+		}
+
+		index = folio_next_index(folio);
+
+		folio_unlock(folio);
+		folio_put(folio);
+
+		/* 64-bit only, wrapping the index should be impossible. */
+		if (WARN_ON_ONCE(!index))
+			break;
+
+		cond_resched();
+	}
+
+	filemap_invalidate_unlock_shared(mapping);
+
+	return r;
+}
+
+static long gunyah_gmem_fallocate(struct file *file, int mode, loff_t offset,
+				  loff_t len)
+{
+	long ret;
+
+	if (!(mode & FALLOC_FL_KEEP_SIZE))
+		return -EOPNOTSUPP;
+
+	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
+		     FALLOC_FL_ZERO_RANGE))
+		return -EOPNOTSUPP;
+
+	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
+		return -EINVAL;
+
+	if (mode & FALLOC_FL_PUNCH_HOLE)
+		ret = gunyah_gmem_punch_hole(file_inode(file), offset, len);
+	else
+		ret = gunyah_gmem_allocate(file_inode(file), offset, len);
+
+	if (!ret)
+		file_modified(file);
+	return ret;
+}
+
+static int gunyah_gmem_release(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static const struct file_operations gunyah_gmem_fops = {
+	.owner = THIS_MODULE,
+	.llseek = generic_file_llseek,
+	.mmap = gunyah_gmem_mmap,
+	.open = generic_file_open,
+	.fallocate = gunyah_gmem_fallocate,
+	.release = gunyah_gmem_release,
+};
+
+static const struct address_space_operations gunyah_gmem_aops = {
+	.dirty_folio = noop_dirty_folio,
+	.migrate_folio = migrate_folio,
+	.error_remove_folio = generic_error_remove_folio,
+};
+
+int gunyah_guest_mem_create(struct gunyah_create_mem_args *args)
+{
+	const char *anon_name = "[gh-gmem]";
+	unsigned long fd_flags = 0;
+	struct inode *inode;
+	struct file *file;
+	int fd, err;
+
+	if (!PAGE_ALIGNED(args->size))
+		return -EINVAL;
+
+	if (args->flags & ~(GHMF_CLOEXEC | GHMF_ALLOW_HUGEPAGE))
+		return -EINVAL;
+
+	if (args->flags & GHMF_CLOEXEC)
+		fd_flags |= O_CLOEXEC;
+
+	fd = get_unused_fd_flags(fd_flags);
+	if (fd < 0)
+		return fd;
+
+	/*
+	 * Use the so called "secure" variant, which creates a unique inode
+	 * instead of reusing a single inode.  Each guest_memfd instance needs
+	 * its own inode to track the size, flags, etc.
+	 */
+	file = anon_inode_create_getfile(anon_name, &gunyah_gmem_fops, NULL,
+					 O_RDWR, NULL);
+	if (IS_ERR(file)) {
+		err = PTR_ERR(file);
+		goto err_fd;
+	}
+
+	file->f_flags |= O_LARGEFILE;
+
+	inode = file->f_inode;
+	WARN_ON(file->f_mapping != inode->i_mapping);
+
+	inode->i_private = (void *)(unsigned long)args->flags;
+	inode->i_mapping->a_ops = &gunyah_gmem_aops;
+	inode->i_mode |= S_IFREG;
+	inode->i_size = args->size;
+	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
+	mapping_set_large_folios(inode->i_mapping);
+	mapping_set_unmovable(inode->i_mapping);
+	/* Unmovable mappings are supposed to be marked unevictable as well. */
+	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
+
+	fd_install(fd, file);
+	return fd;
+
+err_fd:
+	put_unused_fd(fd);
+	return err;
+}
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index 64967a8b72885..238a7a4da554b 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -696,6 +696,15 @@ long gunyah_dev_vm_mgr_ioctl(struct gunyah_rm *rm, unsigned int cmd,
 	switch (cmd) {
 	case GUNYAH_CREATE_VM:
 		return gunyah_dev_ioctl_create_vm(rm, arg);
+	case GUNYAH_CREATE_GUEST_MEM: {
+		struct gunyah_create_mem_args args;
+
+		if (copy_from_user(&args, (const void __user *)arg,
+				   sizeof(args)))
+			return -EFAULT;
+
+		return gunyah_guest_mem_create(&args);
+	}
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index a6a4efa4138b7..7ac0dd066991b 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -171,4 +171,6 @@ int gunyah_vm_provide_folio(struct gunyah_vm *ghvm, struct folio *folio,
 int gunyah_vm_reclaim_folio(struct gunyah_vm *ghvm, u64 gfn, struct folio *folio);
 int gunyah_vm_reclaim_range(struct gunyah_vm *ghvm, u64 gfn, u64 nr);
 
+int gunyah_guest_mem_create(struct gunyah_create_mem_args *args);
+
 #endif
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index 46f7d3aa61d05..c5f506350364d 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -20,6 +20,25 @@
  */
 #define GUNYAH_CREATE_VM _IO(GUNYAH_IOCTL_TYPE, 0x0) /* Returns a Gunyah VM fd */
 
+enum gunyah_mem_flags {
+	GHMF_CLOEXEC = (1UL << 0),
+	GHMF_ALLOW_HUGEPAGE = (1UL << 1),
+};
+
+/**
+ * struct gunyah_create_mem_args - Description of guest memory to create
+ * @flags: See GHMF_*.
+ */
+struct gunyah_create_mem_args {
+	__u64 flags;
+	__u64 size;
+	__u64 reserved[6];
+};
+
+#define GUNYAH_CREATE_GUEST_MEM      \
+	_IOW(GUNYAH_IOCTL_TYPE, 0x8, \
+	     struct gunyah_create_mem_args) /* Returns a Gunyah memory fd */
+
 /*
  * ioctls for gunyah-vm fds (returned by GUNYAH_CREATE_VM)
  */

-- 
2.34.1


