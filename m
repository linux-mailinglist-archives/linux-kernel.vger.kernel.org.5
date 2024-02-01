Return-Path: <linux-kernel+bounces-47907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6C1845477
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145651F24206
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F1815D5BC;
	Thu,  1 Feb 2024 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aiMu/SrP"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921BE15B995;
	Thu,  1 Feb 2024 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780657; cv=none; b=H0bWg3qIDKWuUd+u/WbDuumdZ6eE+YlDiyc1PXMDWeXwwMhuPXeAicRuvQu5MpW36oKA5BeYT6Th051oOuRXxogdZLWzfMRdQo0MzAc5KEtcVliq9nw+wNaSoxQ4KNSNay3d1TzStVbYhGey2jeVBFIYRmEIaJuRW8N4d2GJzjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780657; c=relaxed/simple;
	bh=C8AitdaoBIcKR44uJyMOG7G5OG2flvelnSS+vt/CmMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+wEbLC8VYqIchatTIt2ZckDs72zB27CmlM/vJZ5jKaFuVl2WfWpDGkvuMBbhCygl9asqMbyL67GzFcnX3cbSr2FD0EhAEvp5HQmjYJBOiCAn5fMQAWIhNGMhurSj4KqJ6vvelWUelNqJvMol6xkeWob0KSiha9modTf2dyIbKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aiMu/SrP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706780654;
	bh=C8AitdaoBIcKR44uJyMOG7G5OG2flvelnSS+vt/CmMQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aiMu/SrPTKm2kxhZRA6E9jWpsDX3XVEtQszdCaYdOt1e3PgBMcz7W2LBKZWW2NKsY
	 fbBEFwmakwX8tJagXc/r9eVw3mFrJmTo97T5CYuZ2dPl7Jbvwy4yUe1BPeLP4+JmgQ
	 PRHs+PkZo1yA6arQHYef+CWIOGnZDCsRSNIAj69ZReCmZuefM8r3RT7MN2kmx4NMKI
	 2EhLS9kEP6W+Tv9KuyVugrQSZMqz4UbHV6o3dBVIFdrWQx1QoRFVTEewpTdUqzUwxW
	 g2HA4IQX+CqOTgVqzB0LT1ARlRuWF2X+WLIvdzr6KmoCEonSQ/epZip6NaJu0/1qJF
	 iT8/DaHH8/Buw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7C092378208F;
	Thu,  1 Feb 2024 09:44:12 +0000 (UTC)
Message-ID: <e43a6f6e-6e95-4cbd-9e73-49c129d5724e@collabora.com>
Date: Thu, 1 Feb 2024 10:44:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/21] virt: geniezone: Add set_user_memory_region for
 vm
Content-Language: en-US
To: Yi-De Wu <yi-de.wu@mediatek.com>,
 Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
 Ze-Yu Wang <ze-yu.wang@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
 David Bradil <dbrazdil@google.com>, Trilok Soni <quic_tsoni@quicinc.com>,
 My Chuang <my.chuang@mediatek.com>, Shawn Hsiao <shawn.hsiao@mediatek.com>,
 PeiLun Suei <peilun.suei@mediatek.com>,
 Liju Chen <liju-clr.chen@mediatek.com>,
 Willix Yeh <chi-shen.yeh@mediatek.com>,
 Kevenny Hsieh <kevenny.hsieh@mediatek.com>
References: <20240129083302.26044-1-yi-de.wu@mediatek.com>
 <20240129083302.26044-7-yi-de.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240129083302.26044-7-yi-de.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/01/24 09:32, Yi-De Wu ha scritto:
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> 
> Direct use of physical memory from VMs is forbidden and designed to be
> dictated to the privilege models managed by GenieZone hypervisor for
> security reason. With the help of gzvm-ko, the hypervisor would be able
> to manipulate memory as objects. And the memory management is highly
> integrated with ARM 2-stage translation tables to convert VA to IPA to
> PA under proper security measures required by protected VMs.
> 
> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
> Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
> ---
>   arch/arm64/geniezone/gzvm_arch_common.h |   2 +
>   arch/arm64/geniezone/vm.c               |   9 ++
>   drivers/virt/geniezone/Makefile         |   1 -
>   drivers/virt/geniezone/gzvm_vm.c        | 110 ++++++++++++++++++++++++
>   include/linux/gzvm_drv.h                |  40 +++++++++
>   include/uapi/linux/gzvm.h               |  26 ++++++
>   6 files changed, 187 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
> index fdaa7849353d..2f66e496dfae 100644
> --- a/arch/arm64/geniezone/gzvm_arch_common.h
> +++ b/arch/arm64/geniezone/gzvm_arch_common.h
> @@ -11,6 +11,7 @@
>   enum {
>   	GZVM_FUNC_CREATE_VM = 0,
>   	GZVM_FUNC_DESTROY_VM = 1,
> +	GZVM_FUNC_SET_MEMREGION = 4,
>   	GZVM_FUNC_PROBE = 12,
>   	NR_GZVM_FUNC,
>   };
> @@ -23,6 +24,7 @@ enum {
>   
>   #define MT_HVC_GZVM_CREATE_VM		GZVM_HCALL_ID(GZVM_FUNC_CREATE_VM)
>   #define MT_HVC_GZVM_DESTROY_VM		GZVM_HCALL_ID(GZVM_FUNC_DESTROY_VM)
> +#define MT_HVC_GZVM_SET_MEMREGION	GZVM_HCALL_ID(GZVM_FUNC_SET_MEMREGION)
>   #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
>   
>   /**
> diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
> index a15bad13c2ee..998d6498ac5e 100644
> --- a/arch/arm64/geniezone/vm.c
> +++ b/arch/arm64/geniezone/vm.c
> @@ -49,6 +49,15 @@ int gzvm_arch_probe(void)
>   	return 0;
>   }
>   
> +int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
> +			    phys_addr_t region)
> +{
> +	struct arm_smccc_res res;
> +
> +	return gzvm_hypcall_wrapper(MT_HVC_GZVM_SET_MEMREGION, vm_id,
> +				    buf_size, region, 0, 0, 0, 0, &res);
> +}
> +
>   /**
>    * gzvm_arch_create_vm() - create vm
>    * @vm_type: VM type. Only supports Linux VM now.
> diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
> index 066efddc0b9c..25614ea3dea2 100644
> --- a/drivers/virt/geniezone/Makefile
> +++ b/drivers/virt/geniezone/Makefile
> @@ -7,4 +7,3 @@
>   GZVM_DIR ?= ../../../drivers/virt/geniezone
>   
>   gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o
> -

Don't remove this line here - actually, don't introduce it in the first place...

> diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
> index d5e850af924a..326cc9e93d92 100644
> --- a/drivers/virt/geniezone/gzvm_vm.c
> +++ b/drivers/virt/geniezone/gzvm_vm.c
> @@ -15,6 +15,115 @@
>   static DEFINE_MUTEX(gzvm_list_lock);
>   static LIST_HEAD(gzvm_list);
>   
> +u64 gzvm_gfn_to_hva_memslot(struct gzvm_memslot *memslot, u64 gfn)
> +{
> +	u64 offset = gfn - memslot->base_gfn;

I'd check if `gfn` is less than `memslot->base_gfn` - that's a potential security
issue.

This means that this function should be

int gzvm_gfn_to_hva_memslot(struct gzvm_memslot *memslot, u64 gfn, u64 *hva_memslot)

if (gfn < memslot->base_gfn)
	return -EINVAL

offset = gfn - memslot->base_gfn;
*hva_memslot = memslot->userspace_addr + offset * PAGE_SIZE:

return 0;

> +
> +	return memslot->userspace_addr + offset * PAGE_SIZE;
> +}
> +
> +/**
> + * register_memslot_addr_range() - Register memory region to GenieZone
> + * @gzvm: Pointer to struct gzvm
> + * @memslot: Pointer to struct gzvm_memslot
> + *
> + * Return: 0 for success, negative number for error
> + */
> +static int
> +register_memslot_addr_range(struct gzvm *gzvm, struct gzvm_memslot *memslot)
> +{
> +	struct gzvm_memory_region_ranges *region;
> +	u32 buf_size = PAGE_SIZE * 2;
> +	u64 gfn;
> +
> +	region = alloc_pages_exact(buf_size, GFP_KERNEL);
> +	if (!region)
> +		return -ENOMEM;
> +
> +	region->slot = memslot->slot_id;
> +	region->total_pages = memslot->npages;
> +	gfn = memslot->base_gfn;
> +	region->gpa = PFN_PHYS(gfn);
> +
> +	if (gzvm_arch_set_memregion(gzvm->vm_id, buf_size,
> +				    virt_to_phys(region))) {
> +		pr_err("Failed to register memregion to hypervisor\n");
> +		free_pages_exact(region, buf_size);
> +		return -EFAULT;
> +	}
> +
> +	free_pages_exact(region, buf_size);
> +	return 0;
> +}
> +
> +/**
> + * gzvm_vm_ioctl_set_memory_region() - Set memory region of guest
> + * @gzvm: Pointer to struct gzvm.
> + * @mem: Input memory region from user.
> + *
> + * Return: 0 for success, negative number for error
> + *
> + * -EXIO		- The memslot is out-of-range
> + * -EFAULT		- Cannot find corresponding vma
> + * -EINVAL		- Region size and VMA size mismatch
> + */
> +static int
> +gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
> +				struct gzvm_userspace_memory_region *mem)
> +{
> +	struct vm_area_struct *vma;
> +	struct gzvm_memslot *memslot;
> +	unsigned long size;
> +	__u32 slot;
> +

Remove __u32 slot.....

	if (mem->slot >= GZVM_MAX_MEM_REGION)
		return -ENXIO;

	memslot = &gzvm->memslot[mem->slot];

> +	slot = mem->slot;
> +	if (slot >= GZVM_MAX_MEM_REGION)
> +		return -ENXIO;
> +	memslot = &gzvm->memslot[slot];
> + > +	vma = vma_lookup(gzvm->mm, mem->userspace_addr);
> +	if (!vma)
> +		return -EFAULT;
> +
> +	size = vma->vm_end - vma->vm_start;
> +	if (size != mem->memory_size)
> +		return -EINVAL;
> +
> +	memslot->base_gfn = __phys_to_pfn(mem->guest_phys_addr);
> +	memslot->npages = size >> PAGE_SHIFT;
> +	memslot->userspace_addr = mem->userspace_addr;
> +	memslot->vma = vma;
> +	memslot->flags = mem->flags;
> +	memslot->slot_id = mem->slot;
> +	return register_memslot_addr_range(gzvm, memslot);
> +}
> +
> +/* gzvm_vm_ioctl() - Ioctl handler of VM FD */
> +static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
> +			  unsigned long arg)
> +{
> +	long ret;
> +	void __user *argp = (void __user *)arg;
> +	struct gzvm *gzvm = filp->private_data;
> +
> +	switch (ioctl) {
> +	case GZVM_SET_USER_MEMORY_REGION: {
> +		struct gzvm_userspace_memory_region userspace_mem;
> +
> +		if (copy_from_user(&userspace_mem, argp, sizeof(userspace_mem))) {

			return -EFAULT;

> +			ret = -EFAULT;
> +			goto out;
> +		}
> +		ret = gzvm_vm_ioctl_set_memory_region(gzvm, &userspace_mem);
> +		break;
> +	}
> +	default:
> +		ret = -ENOTTY;
> +	}
> +out:
> +	return ret;
> +}
> +
>   static void gzvm_destroy_vm(struct gzvm *gzvm)
>   {
>   	pr_debug("VM-%u is going to be destroyed\n", gzvm->vm_id);
> @@ -42,6 +151,7 @@ static int gzvm_vm_release(struct inode *inode, struct file *filp)
>   
>   static const struct file_operations gzvm_vm_fops = {
>   	.release        = gzvm_vm_release,
> +	.unlocked_ioctl = gzvm_vm_ioctl,
>   	.llseek		= noop_llseek,
>   };
>   
> diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
> index f1dce23838e4..81696b7b67cc 100644
> --- a/include/linux/gzvm_drv.h
> +++ b/include/linux/gzvm_drv.h
> @@ -7,9 +7,16 @@
>   #define __GZVM_DRV_H__
>   
>   #include <linux/list.h>
> +#include <linux/mm.h>
>   #include <linux/mutex.h>
>   #include <linux/gzvm.h>
>   
> +/*
> + * For the normal physical address, the highest 12 bits should be zero, so we
> + * can mask bit 62 ~ bit 52 to indicate the error physical address
> + */
> +#define GZVM_PA_ERR_BAD (0x7ffULL << 52)
> +
>   #define INVALID_VM_ID   0xffff
>   
>   /*
> @@ -27,10 +34,39 @@
>    * The following data structures are for data transferring between driver and
>    * hypervisor, and they're aligned with hypervisor definitions
>    */
> +#define GZVM_MAX_MEM_REGION	10
> +
> +/* struct mem_region_addr_range - Identical to ffa memory constituent */
> +struct mem_region_addr_range {
> +	/* the base IPA of the constituent memory region, aligned to 4 kiB */
> +	__u64 address;
> +	/* the number of 4 kiB pages in the constituent memory region. */
> +	__u32 pg_cnt;
> +	__u32 reserved;
> +};
> +
> +struct gzvm_memory_region_ranges {
> +	__u32 slot;
> +	__u32 constituent_cnt;
> +	__u64 total_pages;
> +	__u64 gpa;
> +	struct mem_region_addr_range constituents[];
> +};
> +
> +/* struct gzvm_memslot - VM's memory slot descriptor */
> +struct gzvm_memslot {
> +	u64 base_gfn;			/* begin of guest page frame */
> +	unsigned long npages;		/* number of pages this slot covers */
> +	unsigned long userspace_addr;	/* corresponding userspace va */
> +	struct vm_area_struct *vma;	/* vma related to this userspace addr */

kerneldoc please

> +	u32 flags;
> +	u32 slot_id;
> +};
>   

Regards,
Angelo


