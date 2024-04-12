Return-Path: <linux-kernel+bounces-142078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A6E8A272A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD851F23EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5763F481C2;
	Fri, 12 Apr 2024 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="s5wqA5h3"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B6A1DDDB;
	Fri, 12 Apr 2024 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905073; cv=none; b=mOOAmsgdAA5zGHgjPnCgqghum+bvY6AZDdTvrMY8y1FncCKG+Cdb9Kif2ILrUE7kKqdHvd+2UaJgaWKj1Z9NC/wT73tsXtPCWHuCjXge0CY69qsvEpdJsZnCfSIwjcoPXA1Aikf5gtyTxTubOwkpTqHpaQcaZuL3WVfkb8T5dfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905073; c=relaxed/simple;
	bh=dSHeCzUf9Eehfy0un1M9hXm1i8gPG26PMamU4xq66Tw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QemZT/nld34ljBsHiWGTXkgz+0oY11Mq+u3YPZxgNlElQaUic7fG+UXzLuUS+icaVssbwRUwn8v6iPzKRzmjYfzDkZLY3AJmRxCd2f6TlC0G2wC3Dhb44yWzkxncRkm8DyrCb2pYAvzukdAqdebZKhEo6hdNKcTelJNQr6wHZPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=s5wqA5h3; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f817039cf89911ee935d6952f98a51a9-20240412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vJt20dtQRKUZH5ubE5hnQAp40iqHwoQN7fzsTuLrzug=;
	b=s5wqA5h36xkCKzz+EyKE7yQGprXNtR0q4FzDviQ+m1/pjSv9dqPZq05jcSj42NGQUW0VY670/DpjY2WkuZM/wdt2yCEa3rzsLjzXlOuiJU8jE+x75edqih4OU6enTKlMS/b7OQpddKyvLXemYrp7ikH9oeEGSnXspEjmATsOD6w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:c228195f-f3dd-4ad7-804a-2d7158924b83,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:604a9782-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f817039cf89911ee935d6952f98a51a9-20240412
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2015568540; Fri, 12 Apr 2024 14:57:47 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Apr 2024 14:57:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Apr 2024 14:57:45 +0800
From: Yi-De Wu <yi-de.wu@mediatek.com>
To: Yingshiuan Pan <yingshiuan.pan@mediatek.com>, Ze-Yu Wang
	<ze-yu.wang@mediatek.com>, Yi-De Wu <yi-de.wu@mediatek.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <linux-mediatek@lists.infradead.org>, David Bradil
	<dbrazdil@google.com>, Trilok Soni <quic_tsoni@quicinc.com>, My Chuang
	<my.chuang@mediatek.com>, Shawn Hsiao <shawn.hsiao@mediatek.com>, PeiLun Suei
	<peilun.suei@mediatek.com>, Liju Chen <liju-clr.chen@mediatek.com>, Willix
 Yeh <chi-shen.yeh@mediatek.com>, Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: [PATCH v10 07/21] virt: geniezone: Add vm capability check
Date: Fri, 12 Apr 2024 14:57:04 +0800
Message-ID: <20240412065718.29105-8-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240412065718.29105-1-yi-de.wu@mediatek.com>
References: <20240412065718.29105-1-yi-de.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>

Inquire the `capability support` on GenieZone hypervisor.
Example:
`GZVM_CAP_PROTECTED_VM` or `GZVM_CAP_VM_GPA_SIZE`.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: kevenny hsieh <kevenny.hsieh@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h |   2 +
 arch/arm64/geniezone/vm.c               | 122 ++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_main.c      |  26 +++++
 drivers/virt/geniezone/gzvm_vm.c        |  21 ++++
 include/linux/soc/mediatek/gzvm_drv.h   |   5 +
 include/uapi/linux/gzvm.h               |  31 ++++++
 6 files changed, 207 insertions(+)

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index 4250c0f567e7..e500dbe7f943 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -13,6 +13,7 @@ enum {
 	GZVM_FUNC_DESTROY_VM = 1,
 	GZVM_FUNC_SET_MEMREGION = 4,
 	GZVM_FUNC_PROBE = 12,
+	GZVM_FUNC_ENABLE_CAP = 13,
 	NR_GZVM_FUNC,
 };
 
@@ -26,6 +27,7 @@ enum {
 #define MT_HVC_GZVM_DESTROY_VM		GZVM_HCALL_ID(GZVM_FUNC_DESTROY_VM)
 #define MT_HVC_GZVM_SET_MEMREGION	GZVM_HCALL_ID(GZVM_FUNC_SET_MEMREGION)
 #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
+#define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
 
 /**
  * gzvm_hypcall_wrapper() - the wrapper for hvc calls
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index d4f0aa81d224..0030e57bf77b 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -72,6 +72,40 @@ int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
 				    buf_size, region, 0, 0, 0, 0, &res);
 }
 
+static int gzvm_cap_vm_gpa_size(void __user *argp)
+{
+	__u64 value = CONFIG_ARM64_PA_BITS;
+
+	if (copy_to_user(argp, &value, sizeof(__u64)))
+		return -EFAULT;
+
+	return 0;
+}
+
+int gzvm_arch_check_extension(struct gzvm *gzvm, __u64 cap, void __user *argp)
+{
+	int ret;
+
+	switch (cap) {
+	case GZVM_CAP_PROTECTED_VM: {
+		__u64 success = 1;
+
+		if (copy_to_user(argp, &success, sizeof(__u64)))
+			return -EFAULT;
+
+		return 0;
+	}
+	case GZVM_CAP_VM_GPA_SIZE: {
+		ret = gzvm_cap_vm_gpa_size(argp);
+		return ret;
+	}
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 /**
  * gzvm_arch_create_vm() - create vm
  * @vm_type: VM type. Only supports Linux VM now.
@@ -97,3 +131,91 @@ int gzvm_arch_destroy_vm(u16 vm_id)
 	return gzvm_hypcall_wrapper(MT_HVC_GZVM_DESTROY_VM, vm_id, 0, 0, 0, 0,
 				    0, 0, &res);
 }
+
+static int gzvm_vm_arch_enable_cap(struct gzvm *gzvm,
+				   struct gzvm_enable_cap *cap,
+				   struct arm_smccc_res *res)
+{
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_ENABLE_CAP, gzvm->vm_id,
+				    cap->cap, cap->args[0], cap->args[1],
+				    cap->args[2], cap->args[3], cap->args[4],
+				    res);
+}
+
+/**
+ * gzvm_vm_ioctl_get_pvmfw_size() - Get pvmfw size from hypervisor, return
+ *				    in x1, and return to userspace in args
+ * @gzvm: Pointer to struct gzvm.
+ * @cap: Pointer to struct gzvm_enable_cap.
+ * @argp: Pointer to struct gzvm_enable_cap in user space.
+ *
+ * Return:
+ * * 0			- Succeed
+ * * -EINVAL		- Hypervisor return invalid results
+ * * -EFAULT		- Fail to copy back to userspace buffer
+ */
+static int gzvm_vm_ioctl_get_pvmfw_size(struct gzvm *gzvm,
+					struct gzvm_enable_cap *cap,
+					void __user *argp)
+{
+	struct arm_smccc_res res = {0};
+
+	if (gzvm_vm_arch_enable_cap(gzvm, cap, &res) != 0)
+		return -EINVAL;
+
+	cap->args[1] = res.a1;
+	if (copy_to_user(argp, cap, sizeof(*cap)))
+		return -EFAULT;
+
+	return 0;
+}
+
+/**
+ * gzvm_vm_ioctl_cap_pvm() - Proceed GZVM_CAP_PROTECTED_VM's subcommands
+ * @gzvm: Pointer to struct gzvm.
+ * @cap: Pointer to struct gzvm_enable_cap.
+ * @argp: Pointer to struct gzvm_enable_cap in user space.
+ *
+ * Return:
+ * * 0			- Succeed
+ * * -EINVAL		- Invalid subcommand or arguments
+ */
+static int gzvm_vm_ioctl_cap_pvm(struct gzvm *gzvm,
+				 struct gzvm_enable_cap *cap,
+				 void __user *argp)
+{
+	struct arm_smccc_res res = {0};
+	int ret;
+
+	switch (cap->args[0]) {
+	case GZVM_CAP_PVM_SET_PVMFW_GPA:
+		fallthrough;
+	case GZVM_CAP_PVM_SET_PROTECTED_VM:
+		ret = gzvm_vm_arch_enable_cap(gzvm, cap, &res);
+		return ret;
+	case GZVM_CAP_PVM_GET_PVMFW_SIZE:
+		ret = gzvm_vm_ioctl_get_pvmfw_size(gzvm, cap, argp);
+		return ret;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
+				  struct gzvm_enable_cap *cap,
+				  void __user *argp)
+{
+	int ret;
+
+	switch (cap->cap) {
+	case GZVM_CAP_PROTECTED_VM:
+		ret = gzvm_vm_ioctl_cap_pvm(gzvm, cap, argp);
+		return ret;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geniezone/gzvm_main.c
index 4b4e5a222a6e..565bd1fe8ece 100644
--- a/drivers/virt/geniezone/gzvm_main.c
+++ b/drivers/virt/geniezone/gzvm_main.c
@@ -41,12 +41,38 @@ int gzvm_err_to_errno(unsigned long err)
 	return -EINVAL;
 }
 
+/**
+ * gzvm_dev_ioctl_check_extension() - Check if given capability is support
+ *				      or not
+ *
+ * @gzvm: Pointer to struct gzvm
+ * @args: Pointer in u64 from userspace
+ *
+ * Return:
+ * * 0			- Supported, no error
+ * * -EOPNOTSUPP	- Unsupported
+ * * -EFAULT		- Failed to get data from userspace
+ */
+long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args)
+{
+	__u64 cap;
+	void __user *argp = (void __user *)args;
+
+	if (copy_from_user(&cap, argp, sizeof(uint64_t)))
+		return -EFAULT;
+	return gzvm_arch_check_extension(gzvm, cap, argp);
+}
+
 static long gzvm_dev_ioctl(struct file *filp, unsigned int cmd,
 			   unsigned long user_args)
 {
 	switch (cmd) {
 	case GZVM_CREATE_VM:
 		return gzvm_dev_ioctl_create_vm(user_args);
+	case GZVM_CHECK_EXTENSION:
+		if (!user_args)
+			return -EINVAL;
+		return gzvm_dev_ioctl_check_extension(NULL, user_args);
 	default:
 		break;
 	}
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index fed426e7d375..1b02f1676d7b 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -103,6 +103,13 @@ gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
 	return register_memslot_addr_range(gzvm, memslot);
 }
 
+static int gzvm_vm_ioctl_enable_cap(struct gzvm *gzvm,
+				    struct gzvm_enable_cap *cap,
+				    void __user *argp)
+{
+	return gzvm_vm_ioctl_arch_enable_cap(gzvm, cap, argp);
+}
+
 /* gzvm_vm_ioctl() - Ioctl handler of VM FD */
 static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 			  unsigned long arg)
@@ -112,6 +119,10 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 	struct gzvm *gzvm = filp->private_data;
 
 	switch (ioctl) {
+	case GZVM_CHECK_EXTENSION: {
+		ret = gzvm_dev_ioctl_check_extension(gzvm, arg);
+		break;
+	}
 	case GZVM_SET_USER_MEMORY_REGION: {
 		struct gzvm_userspace_memory_region userspace_mem;
 
@@ -121,6 +132,16 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 		ret = gzvm_vm_ioctl_set_memory_region(gzvm, &userspace_mem);
 		break;
 	}
+	case GZVM_ENABLE_CAP: {
+		struct gzvm_enable_cap cap;
+
+		if (copy_from_user(&cap, argp, sizeof(cap))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = gzvm_vm_ioctl_enable_cap(gzvm, &cap, argp);
+		break;
+	}
 	default:
 		ret = -ENOTTY;
 	}
diff --git a/include/linux/soc/mediatek/gzvm_drv.h b/include/linux/soc/mediatek/gzvm_drv.h
index e8dded3419d6..16283ad75df9 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -92,6 +92,7 @@ struct gzvm {
 	u16 vm_id;
 };
 
+long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
 int gzvm_dev_ioctl_create_vm(unsigned long vm_type);
 
 int gzvm_err_to_errno(unsigned long err);
@@ -102,8 +103,12 @@ void gzvm_destroy_all_vms(void);
 int gzvm_arch_probe(void);
 int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
 			    phys_addr_t region);
+int gzvm_arch_check_extension(struct gzvm *gzvm, __u64 cap, void __user *argp);
 int gzvm_arch_create_vm(unsigned long vm_type);
 int gzvm_arch_destroy_vm(u16 vm_id);
+int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
+				  struct gzvm_enable_cap *cap,
+				  void __user *argp);
 
 int gzvm_gfn_to_hva_memslot(struct gzvm_memslot *memslot, u64 gfn,
 			    u64 *hva_memslot);
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 59c0f790b2e6..a79e787c9181 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -16,12 +16,30 @@
 #include <linux/types.h>
 #include <linux/ioctl.h>
 
+#define GZVM_CAP_VM_GPA_SIZE	0xa5
+#define GZVM_CAP_PROTECTED_VM	0xffbadab1
+
+/* sub-commands put in args[0] for GZVM_CAP_PROTECTED_VM */
+#define GZVM_CAP_PVM_SET_PVMFW_GPA		0
+#define GZVM_CAP_PVM_GET_PVMFW_SIZE		1
+/* GZVM_CAP_PVM_SET_PROTECTED_VM only sets protected but not load pvmfw */
+#define GZVM_CAP_PVM_SET_PROTECTED_VM		2
+
 /* GZVM ioctls */
 #define GZVM_IOC_MAGIC			0x92	/* gz */
 
 /* ioctls for /dev/gzvm fds */
 #define GZVM_CREATE_VM             _IO(GZVM_IOC_MAGIC,   0x01) /* Returns a Geniezone VM fd */
 
+/*
+ * Check if the given capability is supported or not.
+ * The argument is capability. Ex. GZVM_CAP_PROTECTED_VM or GZVM_CAP_VM_GPA_SIZE
+ * return is 0 (supported, no error)
+ * return is -EOPNOTSUPP (unsupported)
+ * return is -EFAULT (failed to get the argument from userspace)
+ */
+#define GZVM_CHECK_EXTENSION       _IO(GZVM_IOC_MAGIC,   0x03)
+
 /* ioctls for VM fds */
 /* for GZVM_SET_MEMORY_REGION */
 struct gzvm_memory_region {
@@ -53,4 +71,17 @@ struct gzvm_userspace_memory_region {
 #define GZVM_SET_USER_MEMORY_REGION _IOW(GZVM_IOC_MAGIC, 0x46, \
 					 struct gzvm_userspace_memory_region)
 
+/**
+ * struct gzvm_enable_cap: The `capability support` on GenieZone hypervisor
+ * @cap: `GZVM_CAP_ARM_PROTECTED_VM` or `GZVM_CAP_ARM_VM_IPA_SIZE`
+ * @args: x3-x7 registers can be used for additional args
+ */
+struct gzvm_enable_cap {
+	__u64 cap;
+	__u64 args[5];
+};
+
+#define GZVM_ENABLE_CAP            _IOW(GZVM_IOC_MAGIC,  0xa3, \
+					struct gzvm_enable_cap)
+
 #endif /* __GZVM_H__ */
-- 
2.18.0


