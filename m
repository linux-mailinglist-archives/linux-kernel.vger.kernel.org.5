Return-Path: <linux-kernel+bounces-47905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FAF845472
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81139284E06
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1E015B987;
	Thu,  1 Feb 2024 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B6cvJlvP"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F363220F1;
	Thu,  1 Feb 2024 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780654; cv=none; b=Gcyyif09vA3LVAy1hBRzSRVALNiuK2Sd/EUIojTf2Zj454kbDViJy4C+5KbBFEMo+k4OECnNfsSxjxcBlIzr54INAzzPXzaUkjjrvl3qP4s8FkpJGZR0u5YkAFT5tqAN7TVncss+OB2VSv2Xe7SkjbkddoJD/1ZSHi/2yMg4QMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780654; c=relaxed/simple;
	bh=v8UZHDHMivJNTKZkQiBRqCctvfGUTAovPj2Llh32tRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4//WhKqORYu8WYPXP0VmFDV2ft8mX0QVPAL+0Oi3VLmhiD3ccvfcNwi8rWgoO1Nv0+mFMh7r+gHZ5HYrDHQO22Kq1fpt+wXwMVJUnwNdU8jxY4vJ4/XfJjFrK+7n2njKq27ToMZg2AOvLCU2bfDadsD2JN5ij5oSIYKyCMRTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B6cvJlvP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706780650;
	bh=v8UZHDHMivJNTKZkQiBRqCctvfGUTAovPj2Llh32tRA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B6cvJlvPjmX5CwyjO1L4ELu8292ViO1muHIlhHodeNj5ZNPqHxQAD5q9R0nn6jiIz
	 deXEdkM0ZfFrd0JcBqhjvDPfN8FVLGsh/rrdm0WIeJHs4dEJnazFvnw2yOTD52Ii6u
	 YX3jTq2SwBc0p5Jrwze1Q+5BZqJK/ggcFLkRmtsb2JJlrm2msineEqwmXsUz+TKJRa
	 Gz2cchQnHjKqr2oc/9+Bcncae6pJTnJPSUu2pmRjNj+XjQYWUtA8OBgUa6S2Us2T+2
	 2w85mhyqSJ3JPMVxOoILHuXPRCoMUoJEruN8JJ/9QjWQdTyYBVAo1iGee/CfF0X+eC
	 VXUPVGO7SZWCQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 89959378208D;
	Thu,  1 Feb 2024 09:44:08 +0000 (UTC)
Message-ID: <ea4c8128-d2cb-43fb-aebf-0f4733e1248b@collabora.com>
Date: Thu, 1 Feb 2024 10:44:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/21] virt: geniezone: Add GenieZone hypervisor driver
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
 <20240129083302.26044-5-yi-de.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240129083302.26044-5-yi-de.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/01/24 09:32, Yi-De Wu ha scritto:
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> 
> GenieZone hypervisor(gzvm) is a type-1 hypervisor that supports various
> virtual machine types and provides security features such as TEE-like
> scenarios and secure boot. It can create guest VMs for security use
> cases and has virtualization capabilities for both platform and
> interrupt. Although the hypervisor can be booted independently, it
> requires the assistance of GenieZone hypervisor kernel driver(gzvm-ko)
> to leverage the ability of Linux kernel for vCPU scheduling, memory
> management, inter-VM communication and virtio backend support.
> 
> Add the basic hypervisor driver. Subsequent patches will add more
> supported features to this driver.
> 
> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
> Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
> ---
>   MAINTAINERS                             |  3 +
>   arch/arm64/Kbuild                       |  1 +
>   arch/arm64/geniezone/Makefile           |  9 +++
>   arch/arm64/geniezone/gzvm_arch_common.h | 44 ++++++++++++
>   arch/arm64/geniezone/vm.c               | 47 +++++++++++++
>   drivers/virt/Kconfig                    |  2 +
>   drivers/virt/geniezone/Kconfig          | 16 +++++
>   drivers/virt/geniezone/Makefile         | 10 +++
>   drivers/virt/geniezone/gzvm_main.c      | 89 +++++++++++++++++++++++++
>   include/linux/gzvm_drv.h                | 25 +++++++
>   10 files changed, 246 insertions(+)
>   create mode 100644 arch/arm64/geniezone/Makefile
>   create mode 100644 arch/arm64/geniezone/gzvm_arch_common.h
>   create mode 100644 arch/arm64/geniezone/vm.c
>   create mode 100644 drivers/virt/geniezone/Kconfig
>   create mode 100644 drivers/virt/geniezone/Makefile
>   create mode 100644 drivers/virt/geniezone/gzvm_main.c
>   create mode 100644 include/linux/gzvm_drv.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 17a8e20d2baa..0cb2d0599469 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9019,6 +9019,9 @@ M:	Ze-Yu Wang <ze-yu.wang@mediatek.com>
>   M:	Yi-De Wu <yi-de.wu@mediatek.com>
>   F:	Documentation/devicetree/bindings/hypervisor/mediatek,geniezone-hyp.yaml
>   F:	Documentation/virt/geniezone/
> +F:	arch/arm64/geniezone/
> +F:	drivers/virt/geniezone/
> +F:	include/linux/gzvm_drv.h
>   
>   GENWQE (IBM Generic Workqueue Card)
>   M:	Frank Haverkamp <haver@linux.ibm.com>
> diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
> index 5bfbf7d79c99..0c3cca572919 100644
> --- a/arch/arm64/Kbuild
> +++ b/arch/arm64/Kbuild
> @@ -4,6 +4,7 @@ obj-$(CONFIG_KVM)	+= kvm/
>   obj-$(CONFIG_XEN)	+= xen/
>   obj-$(subst m,y,$(CONFIG_HYPERV))	+= hyperv/
>   obj-$(CONFIG_CRYPTO)	+= crypto/
> +obj-$(CONFIG_MTK_GZVM)	+= geniezone/
>   
>   # for cleaning
>   subdir- += boot
> diff --git a/arch/arm64/geniezone/Makefile b/arch/arm64/geniezone/Makefile
> new file mode 100644
> index 000000000000..2957898cdd05
> --- /dev/null
> +++ b/arch/arm64/geniezone/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Main Makefile for gzvm, this one includes drivers/virt/geniezone/Makefile
> +#
> +include $(srctree)/drivers/virt/geniezone/Makefile
> +
> +gzvm-y += vm.o
> +
> +obj-$(CONFIG_MTK_GZVM) += gzvm.o
> diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
> new file mode 100644
> index 000000000000..f5bddcfe3a1f
> --- /dev/null
> +++ b/arch/arm64/geniezone/gzvm_arch_common.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#ifndef __GZVM_ARCH_COMMON_H__
> +#define __GZVM_ARCH_COMMON_H__
> +
> +#include <linux/arm-smccc.h>
> +
> +enum {
> +	GZVM_FUNC_PROBE = 12,
> +	NR_GZVM_FUNC,
> +};
> +
> +#define SMC_ENTITY_MTK			59
> +#define GZVM_FUNCID_START		(0x1000)
> +#define GZVM_HCALL_ID(func)						\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64,	\
> +			   SMC_ENTITY_MTK, (GZVM_FUNCID_START + (func)))
> +
> +#define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
> +
> +/**
> + * gzvm_hypcall_wrapper() - the wrapper for hvc calls
> + * @a0: arguments passed in registers 0
> + * @a1: arguments passed in registers 1
> + * @a2: arguments passed in registers 2
> + * @a3: arguments passed in registers 3
> + * @a4: arguments passed in registers 4
> + * @a5: arguments passed in registers 5
> + * @a6: arguments passed in registers 6
> + * @a7: arguments passed in registers 7
> + * @res: result values from registers 0 to 3
> + *
> + * Return: The wrapper helps caller to convert geniezone errno to Linux errno.
> + */
> +int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1,
> +			 unsigned long a2, unsigned long a3,
> +			 unsigned long a4, unsigned long a5,
> +			 unsigned long a6, unsigned long a7,
> +			 struct arm_smccc_res *res);
> +
> +#endif /* __GZVM_ARCH_COMMON_H__ */
> diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
> new file mode 100644
> index 000000000000..e313aadec212
> --- /dev/null
> +++ b/arch/arm64/geniezone/vm.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/err.h>
> +#include <linux/uaccess.h>
> +
> +#include <linux/gzvm_drv.h>
> +#include "gzvm_arch_common.h"
> +
> +/**
> + * gzvm_hypcall_wrapper() - the wrapper for hvc calls
> + * @a0: arguments passed in registers 0

argument passed in register 0

> + * @a1: arguments passed in registers 1
> + * @a2: arguments passed in registers 2
> + * @a3: arguments passed in registers 3
> + * @a4: arguments passed in registers 4
> + * @a5: arguments passed in registers 5
> + * @a6: arguments passed in registers 6
> + * @a7: arguments passed in registers 7

..in registe7

> + * @res: result values from registers 0 to 3
> + *
> + * Return: The wrapper helps caller to convert geniezone errno to Linux errno.
> + */
> +int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1,
> +			 unsigned long a2, unsigned long a3,
> +			 unsigned long a4, unsigned long a5,
> +			 unsigned long a6, unsigned long a7,
> +			 struct arm_smccc_res *res)
> +{
> +	arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res);
> +	return gzvm_err_to_errno(res->a0);
> +}
> +
> +int gzvm_arch_probe(void)
> +{
> +	struct arm_smccc_res res;
> +	int ret;
> +
> +	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_PROBE, 0, 0, 0, 0, 0, 0, 0, &res);
> +	if (ret)
> +		return -ENXIO;
> +
> +	return 0;
> +}
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index 40129b6f0eca..b4e9bddbcee7 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -50,4 +50,6 @@ source "drivers/virt/acrn/Kconfig"
>   
>   source "drivers/virt/coco/Kconfig"
>   
> +source "drivers/virt/geniezone/Kconfig"
> +
>   endif
> diff --git a/drivers/virt/geniezone/Kconfig b/drivers/virt/geniezone/Kconfig
> new file mode 100644
> index 000000000000..b17c06c91074
> --- /dev/null
> +++ b/drivers/virt/geniezone/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config MTK_GZVM
> +	tristate "GenieZone Hypervisor driver for guest VM operation"
> +	depends on ARM64 && EVENTFD
> +	help
> +	  This driver, gzvm, enables to run guest VMs on MTK GenieZone
> +	  hypervisor. It exports kvm-like interfaces for VMM (e.g., crosvm) in
> +	  order to operate guest VMs on GenieZone hypervisor.
> +
> +	  GenieZone hypervisor now only supports MediaTek SoC and arm64
> +	  architecture.
> +
> +	  Select M if you want it be built as a module (gzvm.ko).
> +
> +	  If unsure, say N.
> diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
> new file mode 100644
> index 000000000000..8c1f0053e773
> --- /dev/null
> +++ b/drivers/virt/geniezone/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for GenieZone driver, this file should be include in arch's
> +# to avoid two ko being generated.
> +#
> +
> +GZVM_DIR ?= ../../../drivers/virt/geniezone
> +
> +gzvm-y := $(GZVM_DIR)/gzvm_main.o
> +
> diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geniezone/gzvm_main.c
> new file mode 100644
> index 000000000000..f7d4f0646d97
> --- /dev/null
> +++ b/drivers/virt/geniezone/gzvm_main.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kdev_t.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/gzvm_drv.h>
> +
> +/**
> + * gzvm_err_to_errno() - Convert geniezone return value to standard errno
> + *
> + * @err: Return value from geniezone function return
> + *
> + * Return: Standard errno
> + */
> +int gzvm_err_to_errno(unsigned long err)
> +{
> +	int gz_err = (int)err;
> +
> +	switch (gz_err) {
> +	case 0:
> +		return 0;
> +	case ERR_NO_MEMORY:
> +		return -ENOMEM;
> +	case ERR_NOT_SUPPORTED:

case ERR_NOT_SUPPORTED:
	fallthrough;
case ERR_NOT_IMPLEMENTED:
	return -EOPNOTSUPP;

> +		return -EOPNOTSUPP;
> +	case ERR_NOT_IMPLEMENTED:
> +		return -EOPNOTSUPP;
> +	case ERR_FAULT:
> +		return -EFAULT;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct file_operations gzvm_chardev_ops = {
> +	.llseek		= noop_llseek,
> +};
> +
> +static struct miscdevice gzvm_dev = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = KBUILD_MODNAME,
> +	.fops = &gzvm_chardev_ops,
> +};
> +
> +static int gzvm_drv_probe(struct platform_device *pdev)
> +{
> +	if (gzvm_arch_probe() != 0) {
> +		dev_err(&pdev->dev, "Not found available conduit\n");
> +		return -ENODEV;
> +	}
> +
> +	return misc_register(&gzvm_dev);
> +}
> +
> +static int gzvm_drv_remove(struct platform_device *pdev)
> +{
> +	misc_deregister(&gzvm_dev);
> +	return 0;
> +}
> +
> +static const struct of_device_id gzvm_of_match[] = {
> +	{ .compatible = "mediatek,geniezone-hyp" },
> +	{/* sentinel */},
> +};
> +
> +static struct platform_driver gzvm_driver = {
> +	.probe = gzvm_drv_probe,
> +	.remove = gzvm_drv_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.owner = THIS_MODULE,
> +		.of_match_table = gzvm_of_match,
> +	},
> +};
> +
> +module_platform_driver(gzvm_driver);
> +
> +MODULE_DEVICE_TABLE(of, gzvm_of_match);
> +MODULE_AUTHOR("MediaTek");
> +MODULE_DESCRIPTION("GenieZone interface for VMM");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h

Why is this not `include/linux/soc/mediatek/gzvm_drv.h`?!

That's MediaTek specific, so it should go there.

Regards,
Angelo

> new file mode 100644
> index 000000000000..907f2f984de9
> --- /dev/null
> +++ b/include/linux/gzvm_drv.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#ifndef __GZVM_DRV_H__
> +#define __GZVM_DRV_H__
> +
> +/*
> + * These are the definitions of APIs between GenieZone hypervisor and driver,
> + * there's no need to be visible to uapi. Furthermore, we need GenieZone
> + * specific error code in order to map to Linux errno
> + */
> +#define NO_ERROR                (0)
> +#define ERR_NO_MEMORY           (-5)
> +#define ERR_NOT_SUPPORTED       (-24)
> +#define ERR_NOT_IMPLEMENTED     (-27)
> +#define ERR_FAULT               (-40)
> +
> +int gzvm_err_to_errno(unsigned long err);
> +
> +/* arch-dependant functions */
> +int gzvm_arch_probe(void);
> +
> +#endif /* __GZVM_DRV_H__ */



