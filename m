Return-Path: <linux-kernel+bounces-36861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6545583A7CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163C8290D55
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54FC1B271;
	Wed, 24 Jan 2024 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l9tTFN8W"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DEC1AAD8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095700; cv=none; b=Za5TFgYkg6A6RDqlkpuFOMLSJlTqV6zMiwaaoa6H2QZfahS4rsdAf4gwJoWx1pp8Ze5xS05uOQPDJ2dsXjNfUQIVSWwC0Y4/jZmv4FMSHA9XeBOHiX+MMZTf9A4++UTP++hsCXRuhhvZ8V9ppqIDlMVjxNt4RVzSVAxmipbHfa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095700; c=relaxed/simple;
	bh=zS/arkhd8QlPP+xZPJ8bRaO5apkXeCZXoTOnSlWdFvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKs1+SQMWSa32/G544v9v9JJKiWeqyIzGzu5TmSpAa2cwSFC03iUoTk60dfy1QqhW5AZ8Xqz9C1Vt0iutJhM+ZXQ91LLU2WpuMgHvAY3y2dmsdpKkRTiCZ55lT42d/QOU0OwzYhVrR+dT+2HMLoE9Mk808zmBd/qquXHLI7Yxbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l9tTFN8W; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <68333f0b-4657-4171-8772-12e2b453f139@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706095694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=flQ+i4PHxqCY8GhePBhk5z9vbjNANuIkCWuOY/CAPj4=;
	b=l9tTFN8WP+Ot4NU+G8TiAAc6cToezKGvQq/QPIKus6PfGBz6O/h4DUvh3I02jvEa9jXDZN
	PgoFhz0+Mf7TYJLJhl/OubDjHXHBGYz8tx/OiPE9MdroLoY0uVtX9F/tzYC8Kdu4HIV4iN
	w1fwLYf6OA4yisfEd7UGnb8Jo1mOSzA=
Date: Wed, 24 Jan 2024 11:28:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next PATCH] octeontx2: Add PTP clock driver for Octeon PTM
 clock.
Content-Language: en-US
To: Sai Krishna <saikrishnag@marvell.com>, richardcochran@gmail.com,
 davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 lcherian@marvell.com, hkelam@marvell.com, sbhatta@marvell.com
Cc: Naveen Mamindlapalli <naveenm@marvell.com>
References: <20240124064156.2577119-1-saikrishnag@marvell.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240124064156.2577119-1-saikrishnag@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 24/01/2024 06:41, Sai Krishna wrote:
> The PCIe PTM(Precision time measurement) protocol provides precise
> coordination of events across multiple components like PCIe host
> clock, PCIe EP PHC local clocks of PCIe devices. This patch adds
> support for ptp clock based PTM clock. We can use this PTP device
> to sync the PTM time with CLOCK_REALTIME or other PTP PHC
> devices using phc2sys.
> 
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> ---
>   drivers/ptp/Kconfig          |  10 ++
>   drivers/ptp/Makefile         |   1 +
>   drivers/ptp/ptp_octeon_ptm.c | 254 +++++++++++++++++++++++++++++++++++
>   3 files changed, 265 insertions(+)
>   create mode 100644 drivers/ptp/ptp_octeon_ptm.c
> 
> diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
> index 5dd5f188e14f..afa82555dbd9 100644
> --- a/drivers/ptp/Kconfig
> +++ b/drivers/ptp/Kconfig
> @@ -212,4 +212,14 @@ config PTP_DFL_TOD
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called ptp_dfl_tod.
>   
> +config PTP_CLOCK_OCTEON
> +	tristate "OCTEON PTM PTP clock"
> +	depends on PTP_1588_CLOCK
> +	default n
> +	help
> +	  This driver adds support for using Octeon PTM device clock as
> +	  a PTP clock.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called ptp_octeon_ptm.
>   endmenu
> diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
> index dea0cebd2303..e811ae6df5c0 100644
> --- a/drivers/ptp/Makefile
> +++ b/drivers/ptp/Makefile
> @@ -20,3 +20,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_MOCK)	+= ptp_mock.o
>   obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
>   obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
>   obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
> +obj-$(CONFIG_PTP_CLOCK_OCTEON)		+= ptp_octeon_ptm.o
> diff --git a/drivers/ptp/ptp_octeon_ptm.c b/drivers/ptp/ptp_octeon_ptm.c
> new file mode 100644
> index 000000000000..da069645ebf7
> --- /dev/null
> +++ b/drivers/ptp/ptp_octeon_ptm.c
> @@ -0,0 +1,254 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell PTP PHC clock driver for PCIe PTM (Precision Time Measurement) EP
> + *
> + * Copyright (c) 2023 Marvell.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +
> +#include <linux/ptp_clock_kernel.h>
> +
> +#include "ptp_private.h"
> +
> +#define PEMX_PFX_CSX_PFCFGX(pem, pf, _offset)	({typeof(_offset) (offset) = (_offset); \
> +						((0x8e0000008000 | (u64)(pem) << 36 \
> +						| (pf) << 18 \
> +						| (((offset) >> 16) & 1) << 16 \
> +						| ((offset) >> 3) << 3) \
> +						+ ((((offset) >> 2) & 1) << 2)); })
> +
> +#define PEMX_CFG_WR(a)			(0x8E0000000018ull | (u64)(a) << 36)
> +#define PEMX_CFG_RD(a)			(0x8E0000000020ull | (u64)(a) << 36)
> +
> +/* Octeon CSRs   */
> +#define PEMX_CFG                        0x8e00000000d8ULL
> +#define PEMX_PTM_CTL			0x8e0000000098ULL
> +#define PEMX_PTM_CTL_CAP		BIT_ULL(10)
> +#define PEMX_PTM_LCL_TIME		0x8e00000000a0ULL /* PTM time */
> +#define PEMX_PTM_MAS_TIME		0x8e00000000a8ULL /* PTP time */
> +#define PTM_DEBUG			0
> +
> +struct oct_ptp_clock {
> +	struct ptp_clock *ptp_clock;
> +	struct ptp_clock_info caps;
> +	bool cn10k_variant;
> +};
> +
> +static struct oct_ptp_clock oct_ptp_clock;
> +static void __iomem *ptm_ctl_addr;
> +static void __iomem *ptm_lcl_addr;
> +
> +/* Config space registers   */
> +#define PCIEEPX_PTM_REQ_STAT		(oct_ptp_clock.cn10k_variant ? 0x3a8 : 0x474)
> +#define PCIEEPX_PTM_REQ_T1L		(oct_ptp_clock.cn10k_variant ? 0x3b4 : 0x480)
> +#define PCIEEPX_PTM_REQ_T1M		(oct_ptp_clock.cn10k_variant ? 0x3b8 : 0x484)
> +#define PCIEEPX_PTM_REQ_T4L		(oct_ptp_clock.cn10k_variant ? 0x3c4 : 0x490)
> +#define PCIEEPX_PTM_REQ_T4M		(oct_ptp_clock.cn10k_variant ? 0x3c8 : 0x494)
> +
> +#define PCI_VENDOR_ID_CAVIUM			0x177d
> +#define PCI_DEVID_OCTEONTX2_PTP			0xA00C
> +#define PCI_SUBSYS_DEVID_95XX			0xB300
> +#define PCI_SUBSYS_DEVID_95XXN			0xB400
> +#define PCI_SUBSYS_DEVID_95XXMM			0xB500
> +#define PCI_SUBSYS_DEVID_96XX			0xB200
> +#define PCI_SUBSYS_DEVID_98XX			0xB100
> +#define PCI_SUBSYS_DEVID_CN10K_A		0xB900
> +#define PCI_SUBSYS_DEVID_CN10K_B		0xBD00
> +#define PCI_SUBSYS_DEVID_CNF10K_A		0xBA00
> +#define PCI_SUBSYS_DEVID_CNF10K_B		0xBC00
> +
> +static bool is_otx2_support_ptm(struct pci_dev *pdev)
> +{
> +	return (pdev->subsystem_device == PCI_SUBSYS_DEVID_96XX ||
> +		pdev->subsystem_device == PCI_SUBSYS_DEVID_95XX ||
> +		pdev->subsystem_device == PCI_SUBSYS_DEVID_95XXN ||
> +		pdev->subsystem_device == PCI_SUBSYS_DEVID_98XX ||
> +		pdev->subsystem_device == PCI_SUBSYS_DEVID_95XXMM);
> +}
> +
> +static bool is_cn10k_support_ptm(struct pci_dev *pdev)
> +{
> +	return (pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_A ||
> +		pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_A ||
> +		pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_B ||
> +		pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_B);
> +}
> +
> +static int ptp_oct_ptm_adjtime(struct ptp_clock_info *ptp, s64 delta)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int ptp_oct_ptm_settime(struct ptp_clock_info *ptp,
> +			       const struct timespec64 *ts)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static u32 read_pcie_config32(int ep_pem, int cfg_addr)
> +{
> +	void __iomem *addr;
> +	u64 val;
> +
> +	if (oct_ptp_clock.cn10k_variant) {
> +		addr  = ioremap(PEMX_PFX_CSX_PFCFGX(ep_pem, 0, cfg_addr), 8);
> +		if (!addr) {
> +			pr_err("PTM_EP: Failed to ioremap Octeon CSR space\n");
> +			return -1U;
> +		}
> +		val = readl(addr);
> +		iounmap(addr);
> +	} else {
> +		addr  = ioremap(PEMX_CFG_RD(ep_pem), 8);
> +		if (!addr) {
> +			pr_err("PTM_EP: Failed to ioremap Octeon CSR space\n");
> +			return -1U;
> +		}
> +		val = ((1 << 15) | (cfg_addr & 0xfff));
> +		writeq(val, addr);
> +		val = readq(addr) >> 32;
> +		iounmap(addr);
> +	}
> +	return (val & 0xffffffff);
> +}
> +
> +static uint64_t octeon_csr_read(u64 csr_addr)
> +{
> +	u64 val;
> +	void __iomem *addr;
> +
> +	addr = ioremap(csr_addr, 8);
> +	if (!addr) {
> +		pr_err("PTM_EP: Failed to ioremap CSR space\n");
> +		return -1UL;
> +	}
> +	val = (u64)READ_ONCE(*(u64 __iomem *)addr);
> +	iounmap(addr);
> +	return val;
> +}
> +
> +static int ptp_oct_ptm_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
> +{
> +	u64 ptp_time, val64;
> +#if PTM_DEBUG
> +	u64 ptm_time;
> +#endif

Looks like some out-of-tree debug artifacts here and later in the
function

> +	u32 val32;
> +
> +	/* Check for valid PTM context */
> +	val32 = read_pcie_config32(0, PCIEEPX_PTM_REQ_STAT);
> +	if (!(val32 & 0x1)) {
> +		pr_err("PTM_EP: ERROR: PTM context not valid: 0x%x\n", val32);
> +#if PTM_DEBUG
> +		ptm_time = 0;
> +#endif
> +		ptp_time = 0;

No reason to clean up local variables.

> +		ts->tv_sec = 0;
> +		ts->tv_nsec = 0;
> +
> +		return -EINVAL;
> +	}
> +
> +	/* Trigger PTM/PTP capture */
> +	val64 = (u64)READ_ONCE(*(u64 __iomem *)ptm_ctl_addr);
> +	val64 |= PEMX_PTM_CTL_CAP;
> +	WRITE_ONCE(*(u64 __iomem *)ptm_ctl_addr, val64);
> +	/* Read PTM/PTP clocks  */
> +	ptp_time = (u64)READ_ONCE(*(u64 __iomem *)ptm_lcl_addr);
> +	ts->tv_sec = ptp_time / NSEC_PER_SEC;
> +	ts->tv_nsec = ptp_time % NSEC_PER_SEC;

ns_to_timespec64() here?

> +
> +#if PTM_DEBUG
> +	ptm_time = octeon_csr_read(PEMX_PTM_MAS_TIME);
> +	pr_info("PTM_EP: system %lld ptm time: %lld\n", ptp_time, ptm_time);
> +#endif
> +
> +	return 0;
> +}
> +
> +static int ptp_oct_ptm_enable(struct ptp_clock_info *ptp,
> +			      struct ptp_clock_request *rq, int on)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct ptp_clock_info ptp_oct_caps = {
> +	.owner		= THIS_MODULE,
> +	.name		= "OCTEON PTM PHC",
> +	.max_adj	= 0,
> +	.n_ext_ts	= 0,
> +	.n_pins		= 0,
> +	.pps		= 0,
> +	.adjtime	= ptp_oct_ptm_adjtime,
> +	.gettime64	= ptp_oct_ptm_gettime,
> +	.settime64	= ptp_oct_ptm_settime,
> +	.enable		= ptp_oct_ptm_enable,
> +};
> +
> +static void __exit ptp_oct_ptm_exit(void)
> +{
> +	iounmap(ptm_ctl_addr);
> +	iounmap(ptm_lcl_addr);
> +	ptp_clock_unregister(oct_ptp_clock.ptp_clock);
> +}
> +
> +static int __init ptp_oct_ptm_init(void)
> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
> +			      PCI_DEVID_OCTEONTX2_PTP, pdev);
> +	if (!pdev)
> +		return 0;
> +
> +	if (octeon_csr_read(PEMX_CFG) & 0x1ULL) {
> +		pr_err("PEM0 is configured as RC\n");
> +		return 0;
> +	}
> +
> +	if (is_otx2_support_ptm(pdev)) {
> +		oct_ptp_clock.cn10k_variant = 0;
> +	} else if (is_cn10k_support_ptm(pdev)) {
> +		oct_ptp_clock.cn10k_variant = 1;
> +	} else {
> +		/* PTM_EP: unsupported processor */
> +		return 0;
> +	}
> +
> +	ptm_ctl_addr = ioremap(PEMX_PTM_CTL, 8);
> +	if (!ptm_ctl_addr) {
> +		pr_err("PTM_EP: Failed to ioremap CSR space\n");
> +		return 0;
> +	}
> +
> +	ptm_lcl_addr = ioremap(PEMX_PTM_LCL_TIME, 8);
> +	if (!ptm_lcl_addr) {
> +		pr_err("PTM_EP: Failed to ioremap CSR space\n");
> +		return 0;
> +	}
> +
> +	oct_ptp_clock.caps = ptp_oct_caps;
> +
> +	oct_ptp_clock.ptp_clock = ptp_clock_register(&oct_ptp_clock.caps, NULL);
> +
> +	pr_info("PTP device index for PTM clock:%d\n", oct_ptp_clock.ptp_clock->index);
> +	pr_info("cn10k_variant %d\n", oct_ptp_clock.cn10k_variant);
> +
> +	return PTR_ERR_OR_ZERO(oct_ptp_clock.ptp_clock);
> +}
> +
> +module_init(ptp_oct_ptm_init);
> +module_exit(ptp_oct_ptm_exit);
> +
> +MODULE_AUTHOR("Marvell Inc.");
> +MODULE_DESCRIPTION("PTP PHC clock using PTM");
> +MODULE_LICENSE("GPL");


