Return-Path: <linux-kernel+bounces-42362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30AE840060
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77D71C223BE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2515B5CE;
	Mon, 29 Jan 2024 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XASyWn+K"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CD454FA2;
	Mon, 29 Jan 2024 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706517198; cv=none; b=ln9pbKYQLd25jZjRgOdrHq6f6zTtzHfnBlx1nrUe10ZZd9mNowS+ApWjuHvz6QcLW2dnycU7sn2ncmeVz1uxQMQ2MdgINAO3vshtX7BYZbG+Q1h6S11lH6HKzh811QQsoYp0uq9XQ42rwB/dNZL42+0R59dobruTDMTGSrG9Nx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706517198; c=relaxed/simple;
	bh=d/HKFUI8hh50BRa54hRp/5YDi/wL8fi9NB810tBUV9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOQyLKFLTwevAPeRSe1czx3LN5exMuNiD3MFg5lE9v4TfFrN2zuTzgNl7hmd5FWEBICh0mxbSZ8vtD7qWVMxXGBH3eZhwAD1gwc+sRdmcjCX2vzbmG803AAjeNHwqjdxs8UivjkyHc6RZ9+HUCL4nniP+og6pBADz27vDzKnR3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XASyWn+K; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0891723cbe8111eea2298b7352fd921d-20240129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5gPx+SvCXGER7GnieatvV+tmNhNHASAQ8QOTxwJ1eJc=;
	b=XASyWn+KAC168zCd90EOZyl6L/9zZk1C7rBk2/1U1KjnNNA39+DOYIlNL9O7joccuojwlAGvyGRY2QgGrv3Swpnq6qNE9J2V47Zt4gsp6Rym7+mDsguXvICmQ9u5wW1VcwN6+iVk+c02WQrz2yFq6obqzurgD2543djV28L52mI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:d418c62a-a6f7-4d3f-a7ba-d7084a3518da,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6e16cf4,CLOUDID:5c4143fe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 0891723cbe8111eea2298b7352fd921d-20240129
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 469260788; Mon, 29 Jan 2024 16:33:09 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 29 Jan 2024 16:33:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 29 Jan 2024 16:33:06 +0800
From: Yi-De Wu <yi-de.wu@mediatek.com>
To: Yingshiuan Pan <yingshiuan.pan@mediatek.com>, Ze-Yu Wang
	<ze-yu.wang@mediatek.com>, Yi-De Wu <yi-de.wu@mediatek.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <linux-mediatek@lists.infradead.org>, David Bradil
	<dbrazdil@google.com>, Trilok Soni <quic_tsoni@quicinc.com>, My Chuang
	<my.chuang@mediatek.com>, Shawn Hsiao <shawn.hsiao@mediatek.com>, PeiLun Suei
	<peilun.suei@mediatek.com>, Liju Chen <liju-clr.chen@mediatek.com>, "Willix
 Yeh" <chi-shen.yeh@mediatek.com>, Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: [PATCH v9 07/21] virt: geniezone: Add vm capability check
Date: Mon, 29 Jan 2024 16:32:48 +0800
Message-ID: <20240129083302.26044-8-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240129083302.26044-1-yi-de.wu@mediatek.com>
References: <20240129083302.26044-1-yi-de.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.735800-8.000000
X-TMASE-MatchedRID: c6n4reyclFZWj3HFS14pKxn0UD4GU5Iq5E5u1OdPWsTgr/zYTDOZCJeq
	sXSeEviPpSHzbpDtJi1Yo3G+rvxrNW94Ipa1otxoh2VzUlo4HVPt/okBLaEo+M3uTDyQRGk0dYJ
	3pC9XNt458CIn96icLWYlLqTvfoxMaB/391PZDWi3fk4rFE3BtBmPWPgE2ntcTUobVis5Bb/u9+
	Mep8zDYpheOPJgS4aTCAv9MNEYwNxJI5ZUl647UBRFJJyf5BJe3QfwsVk0Ubt2gyyw2xTBhf1xm
	+6sPsbYjBl0RjbQXISXuYt1xEu5a0MtQb0+DpubtxFEiW5Gm6anPaRHQocDjTVVoSY9yTVzHGkh
	VmkNW9p1MunoSzaYr4CE5xpCtDRTUbJFyh4XXyqYo/TPOlMB4bCh3zE4wqa8DUCRr8oin+k=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.735800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	CDA61DB802DD83FC77A5A565618A523CCE20A41B06FD43B8AF14A2D46CC84A162000:8
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
 drivers/virt/geniezone/gzvm_main.c      |  27 ++++++
 drivers/virt/geniezone/gzvm_vm.c        |  21 ++++
 include/linux/gzvm_drv.h                |   5 +
 include/uapi/linux/gzvm.h               |  31 ++++++
 6 files changed, 208 insertions(+)

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index 2f66e496dfae..383af0829f11 100644
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
index 998d6498ac5e..02f94c86fbf1 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -58,6 +58,40 @@ int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
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
@@ -83,3 +117,91 @@ int gzvm_arch_destroy_vm(u16 vm_id)
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
index 4e7d60067c55..30f6c3975026 100644
--- a/drivers/virt/geniezone/gzvm_main.c
+++ b/drivers/virt/geniezone/gzvm_main.c
@@ -41,6 +41,28 @@ int gzvm_err_to_errno(unsigned long err)
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
@@ -50,6 +72,11 @@ static long gzvm_dev_ioctl(struct file *filp, unsigned int cmd,
 	case GZVM_CREATE_VM:
 		ret = gzvm_dev_ioctl_create_vm(user_args);
 		return ret;
+	case GZVM_CHECK_EXTENSION:
+		if (!user_args)
+			return -EINVAL;
+		ret = gzvm_dev_ioctl_check_extension(NULL, user_args);
+		return ret;
 	default:
 		break;
 	}
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index 326cc9e93d92..ba6bfb7ee6e5 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -98,6 +98,13 @@ gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
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
@@ -107,6 +114,10 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 	struct gzvm *gzvm = filp->private_data;
 
 	switch (ioctl) {
+	case GZVM_CHECK_EXTENSION: {
+		ret = gzvm_dev_ioctl_check_extension(gzvm, arg);
+		break;
+	}
 	case GZVM_SET_USER_MEMORY_REGION: {
 		struct gzvm_userspace_memory_region userspace_mem;
 
@@ -117,6 +128,16 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
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
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index 81696b7b67cc..01c92e7eb230 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -73,6 +73,7 @@ struct gzvm {
 	u16 vm_id;
 };
 
+long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
 int gzvm_dev_ioctl_create_vm(unsigned long vm_type);
 
 int gzvm_err_to_errno(unsigned long err);
@@ -83,8 +84,12 @@ void gzvm_destroy_all_vms(void);
 int gzvm_arch_probe(void);
 int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
 			    phys_addr_t region);
+int gzvm_arch_check_extension(struct gzvm *gzvm, __u64 cap, void __user *argp);
 int gzvm_arch_create_vm(unsigned long vm_type);
 int gzvm_arch_destroy_vm(u16 vm_id);
+int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
+				  struct gzvm_enable_cap *cap,
+				  void __user *argp);
 
 u64 gzvm_gfn_to_hva_memslot(struct gzvm_memslot *memslot, u64 gfn);
 
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index d2d5e6cfc2c9..77a58ee085df 100644
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
@@ -48,4 +66,17 @@ struct gzvm_userspace_memory_region {
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


