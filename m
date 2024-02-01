Return-Path: <linux-kernel+bounces-47904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F93184546B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C051C27AB4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2FC15B0EF;
	Thu,  1 Feb 2024 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3vKGIirR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FC94DA03;
	Thu,  1 Feb 2024 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780652; cv=none; b=fpPGVa2GRwk+x4zDLyAHSR5gdFKqG9TQCXV5ovAkQGg6/TKXZ01C5Ycr1yYBLRF3HInwNIdCVXxRKuO/OzgHTQz7O0QfY6F94PvmGU46LMWbVHnMljIIZBO1iBxZLOma9a49Qr3VnSNtxNk5KYvF4vrvOGI5GoiCouNZric3Lzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780652; c=relaxed/simple;
	bh=8uDZvyulxGAafALJBopFoctWbExfba9H5gwsoOBC41M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VmL0jyfE11+AEUGhSf2gwLjgHjTt+LwK/sS1YVR7p8mRrf68zCQ2mpkGW1NurZvdcuctc+eYpwbVtds1w/TMYGqpeadx4f3fChTgsiuqvO1SROoJAlNvSxeT80S/bxFZs2RNdMeZneMn6emFI28h8+GLY8IMjd2cORD32+WipQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3vKGIirR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706780649;
	bh=8uDZvyulxGAafALJBopFoctWbExfba9H5gwsoOBC41M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=3vKGIirRu422LqvpGZAg4q2n5NYXcPkfLqVOj5KByunRrRPm6o8lK+RMrTQJ2as62
	 J8XbQDm2BVKaKKpRpDDg/raNRnXCSNV0bvc5zwWTGuQFhEyGY7EzBClEy8zKF3RQGC
	 VqCG/y9/dmPhN/KsoXEvWzqBVDo51TWn0pigyGiY8S+4tPvSgypFZewo94ZfEybmU6
	 66LGTgzYmYif6crKffmnf/+wj7sPFazy7VmgKlLPmuhDMQ8MFtKs1W4rVnoxQs842j
	 BfzFJW7Xrhq4krpWeJhQpyLbtD008FM6QxCWYvVEjCdinT1SwmzvVeZYiwPdMHNsGb
	 EiqlsYoFSgzCA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C249D378208C;
	Thu,  1 Feb 2024 09:44:07 +0000 (UTC)
Message-ID: <e772e44f-9c60-4c4b-8054-957b07180c45@collabora.com>
Date: Thu, 1 Feb 2024 10:44:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/21] virt: geniezone: Add vm support
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
 <20240129083302.26044-6-yi-de.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240129083302.26044-6-yi-de.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/01/24 09:32, Yi-De Wu ha scritto:
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> 
> The VM component is responsible for setting up the capability and memory
> management for the protected VMs. The capability is mainly about the
> lifecycle control and boot context initialization.
> 
> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
> Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
> ---
>   MAINTAINERS                             |   1 +
>   arch/arm64/geniezone/gzvm_arch_common.h |   9 ++
>   arch/arm64/geniezone/vm.c               |  29 +++++++
>   drivers/virt/geniezone/Makefile         |   2 +-
>   drivers/virt/geniezone/gzvm_main.c      |  19 +++++
>   drivers/virt/geniezone/gzvm_vm.c        | 107 ++++++++++++++++++++++++
>   include/linux/gzvm_drv.h                |  26 ++++++
>   include/uapi/linux/gzvm.h               |  25 ++++++
>   8 files changed, 217 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/virt/geniezone/gzvm_vm.c
>   create mode 100644 include/uapi/linux/gzvm.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0cb2d0599469..3ecac8794ba9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9022,6 +9022,7 @@ F:	Documentation/virt/geniezone/
>   F:	arch/arm64/geniezone/
>   F:	drivers/virt/geniezone/
>   F:	include/linux/gzvm_drv.h
> +F:	include/uapi/linux/gzvm.h
>   
>   GENWQE (IBM Generic Workqueue Card)
>   M:	Frank Haverkamp <haver@linux.ibm.com>
> diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
> index f5bddcfe3a1f..fdaa7849353d 100644
> --- a/arch/arm64/geniezone/gzvm_arch_common.h
> +++ b/arch/arm64/geniezone/gzvm_arch_common.h
> @@ -9,6 +9,8 @@
>   #include <linux/arm-smccc.h>
>   
>   enum {
> +	GZVM_FUNC_CREATE_VM = 0,


	GZVM_FUNC_CREATE_VM,
	GZVM_FUNC_DESTROY_VM,

The first one will always be zero by default, subsequent members are always
incremental anyway.

> +	GZVM_FUNC_DESTROY_VM = 1,
>   	GZVM_FUNC_PROBE = 12,
>   	NR_GZVM_FUNC,
>   };
> @@ -19,6 +21,8 @@ enum {
>   	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64,	\
>   			   SMC_ENTITY_MTK, (GZVM_FUNCID_START + (func)))
>   
> +#define MT_HVC_GZVM_CREATE_VM		GZVM_HCALL_ID(GZVM_FUNC_CREATE_VM)
> +#define MT_HVC_GZVM_DESTROY_VM		GZVM_HCALL_ID(GZVM_FUNC_DESTROY_VM)
>   #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
>   
>   /**
> @@ -41,4 +45,9 @@ int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1,
>   			 unsigned long a6, unsigned long a7,
>   			 struct arm_smccc_res *res);
>   
> +static inline u16 get_vmid_from_tuple(unsigned int tuple)
> +{
> +	return (u16)(tuple >> 16);

As far as I can understand, this tuple is a union of two u16.

If you add that union, you won't even need this function anymore.

> +}
> +
>   #endif /* __GZVM_ARCH_COMMON_H__ */
> diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
> index e313aadec212..a15bad13c2ee 100644
> --- a/arch/arm64/geniezone/vm.c
> +++ b/arch/arm64/geniezone/vm.c
> @@ -7,9 +7,12 @@
>   #include <linux/err.h>
>   #include <linux/uaccess.h>
>   
> +#include <linux/gzvm.h>
>   #include <linux/gzvm_drv.h>
>   #include "gzvm_arch_common.h"
>   
> +#define PAR_PA47_MASK ((((1UL << 48) - 1) >> 12) << 12)

This value is unused. Anyway, isn't this just GENMASK_ULL(47, 12) ?!

> +
>   /**
>    * gzvm_hypcall_wrapper() - the wrapper for hvc calls
>    * @a0: arguments passed in registers 0
> @@ -45,3 +48,29 @@ int gzvm_arch_probe(void)
>   
>   	return 0;
>   }
> +
> +/**
> + * gzvm_arch_create_vm() - create vm
> + * @vm_type: VM type. Only supports Linux VM now.
> + *
> + * Return:
> + * * positive value	- VM ID
> + * * -ENOMEM		- Memory not enough for storing VM data
> + */
> +int gzvm_arch_create_vm(unsigned long vm_type)
> +{
> +	struct arm_smccc_res res;
> +	int ret;
> +
> +	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_CREATE_VM, vm_type, 0, 0, 0, 0,
> +				   0, 0, &res);
> +	return ret ? ret : res.a1;
> +}
> +
> +int gzvm_arch_destroy_vm(u16 vm_id)
> +{
> +	struct arm_smccc_res res;
> +
> +	return gzvm_hypcall_wrapper(MT_HVC_GZVM_DESTROY_VM, vm_id, 0, 0, 0, 0,
> +				    0, 0, &res);
> +}
> diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
> index 8c1f0053e773..066efddc0b9c 100644
> --- a/drivers/virt/geniezone/Makefile
> +++ b/drivers/virt/geniezone/Makefile
> @@ -6,5 +6,5 @@
>   
>   GZVM_DIR ?= ../../../drivers/virt/geniezone
>   
> -gzvm-y := $(GZVM_DIR)/gzvm_main.o
> +gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o
>   
> diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geniezone/gzvm_main.c
> index f7d4f0646d97..4e7d60067c55 100644
> --- a/drivers/virt/geniezone/gzvm_main.c
> +++ b/drivers/virt/geniezone/gzvm_main.c
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <linux/device.h>
> +#include <linux/file.h>
>   #include <linux/kdev_t.h>
>   #include <linux/miscdevice.h>
>   #include <linux/module.h>
> @@ -40,7 +41,24 @@ int gzvm_err_to_errno(unsigned long err)
>   	return -EINVAL;
>   }
>   
> +static long gzvm_dev_ioctl(struct file *filp, unsigned int cmd,
> +			   unsigned long user_args)
> +{
> +	long ret;
> +
> +	switch (cmd) {
> +	case GZVM_CREATE_VM:
> +		ret = gzvm_dev_ioctl_create_vm(user_args);
> +		return ret;

return gzvm_dev_ioctl_create_vm(user_args);

> +	default:
> +		break;
> +	}
> +
> +	return -ENOTTY;
> +}
> +
>   static const struct file_operations gzvm_chardev_ops = {
> +	.unlocked_ioctl = gzvm_dev_ioctl,
>   	.llseek		= noop_llseek,
>   };
>   
> @@ -62,6 +80,7 @@ static int gzvm_drv_probe(struct platform_device *pdev)
>   
>   static int gzvm_drv_remove(struct platform_device *pdev)
>   {
> +	gzvm_destroy_all_vms();
>   	misc_deregister(&gzvm_dev);
>   	return 0;
>   }
> diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
> new file mode 100644
> index 000000000000..d5e850af924a
> --- /dev/null
> +++ b/drivers/virt/geniezone/gzvm_vm.c
> @@ -0,0 +1,107 @@

.snip..

> diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
> index 907f2f984de9..f1dce23838e4 100644
> --- a/include/linux/gzvm_drv.h
> +++ b/include/linux/gzvm_drv.h
> @@ -6,6 +6,12 @@
>   #ifndef __GZVM_DRV_H__
>   #define __GZVM_DRV_H__
>   
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/gzvm.h>
> +
> +#define INVALID_VM_ID   0xffff
> +
>   /*
>    * These are the definitions of APIs between GenieZone hypervisor and driver,
>    * there's no need to be visible to uapi. Furthermore, we need GenieZone
> @@ -17,9 +23,29 @@
>   #define ERR_NOT_IMPLEMENTED     (-27)
>   #define ERR_FAULT               (-40)
>   
> +/*
> + * The following data structures are for data transferring between driver and
> + * hypervisor, and they're aligned with hypervisor definitions
> + */
> +
> +struct gzvm {
> +	/* userspace tied to this vm */
> +	struct mm_struct *mm;
> +	/* lock for list_add*/

Why are you not using kerneldoc to document this structure?

After all, you're already partially documenting it.

> +	struct mutex lock;
> +	struct list_head vm_list;
> +	u16 vm_id;
> +};
> +
> +int gzvm_dev_ioctl_create_vm(unsigned long vm_type);
> +
>   int gzvm_err_to_errno(unsigned long err);
>   

Why is there a trailing space on this function sig?

Regards,
Angelo


