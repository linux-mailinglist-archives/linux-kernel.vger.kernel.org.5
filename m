Return-Path: <linux-kernel+bounces-46105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DEE843A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A8D1F24478
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4F16A03D;
	Wed, 31 Jan 2024 09:08:40 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF14664CA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692119; cv=none; b=F4f8AG4p9egFqsXB+vvR6FxDK7FcJ9FUYKMVCr8W1GM6jCA7SbrfLU7MZUq9gJIMKInceMayES5v8VaJhasqzVyrngZsiOr4M0Hc9P0E+tCtGpFur5X1QlgaHGqGu1duAtzU02aian5PkJ/7+CuZ3laUjONmM3Cn6fhal2JQx9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692119; c=relaxed/simple;
	bh=qizZz7hOuS9gpFB+ftLlsUYqCNSRhUpS+WXR8Lt1sPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aD/GXNxZMinNqIIx8QAR0M4ZETFcyakxb/lJ0v6vgA6nrKIvsL4t/mS25KHEJPhKG6bNKVm/1YkvZVeSNErT6+7pdito+QwftKCq7H7qTMz0GKQw36LjhswzaH3O9aJQQLIhLQzYnPdKkTKbqnxB3fY6ETIWqIw8CoNbwcAtsNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp69t1706692064tdi9x7r4
X-QQ-Originating-IP: SpSE+unC2lTOAfquYgGcAuQxf4er1BytdNx1vNwSIRw=
Received: from [127.0.0.1] ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 31 Jan 2024 17:07:42 +0800 (CST)
X-QQ-SSF: 00400000000000B0B000000A0000000
X-QQ-FEAT: 5q30pvLz2ich9XLGcedLx6D0e03nW6PeNm4HpWmpGnnkljRSVOG3cq9CveRmS
	ssMPqZtonBH1pgVI19oMc0h6AZLsldZIqdQdv62EDLgTtOscegiklFOKMKjxXQJca9SDcjM
	2hHTC/7BRkTpq3wJt1s5/NJy4lCACBc8o08U665+VAc4DoMWEfLtJfXaTNGFpVh3lXG0x/W
	ksW2n1ci+eU8GRNPuZt43ifRzw4wY3NIOukV/Fk/PYYQ8b91fO177zu833XM/5r63c4344j
	soqBmxPPHZjhFg//VswO/cBwjLrFIHyuusAPz1wK+rvl2fNlZmlpXjzcCstj9S5zywqANU6
	JYez7Jhn5qx7MUhgHAj6RxKBDtoHY0bzxDdirTy3dYrSi3ZfsaQ2S2OhagkAaXFoNTQhMeV
	KTKZRpW1+Cxr1xHGk2UN01/0ThubbeHEre78Q5dWvns=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7609392513112760993
Message-ID: <6D9001324476F76F+ee5f853d-7c69-4a99-857c-cc2b03e9eea1@shingroup.cn>
Date: Wed, 31 Jan 2024 17:07:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/hx_arm_ni: Support uncore ARM NI-700 PMU
To: Krzysztof Kozlowski <krzk@kernel.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: shenghui.qu@shingroup.cn, ke.zhao@shingroup.cn, zhijie.ren@shingroup.cn,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240131070821.11477-1-jialong.yang@shingroup.cn>
 <deb708e5-bbaf-4510-826b-17e14e69b475@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>
In-Reply-To: <deb708e5-bbaf-4510-826b-17e14e69b475@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1



在 2024/1/31 15:59, Krzysztof Kozlowski 写道:
> On 31/01/2024 08:08, JiaLong.Yang wrote:
>> This code is based on uncore PMUs arm_smmuv3_pmu and arm-cmn.
>> One ni-700 can have many clock domains. Each of them has only one PMU.
>> Here one PMU corresponds to one 'struct ni_pmu' instance.
>> PMU name will be ni_pmu_N_M, which N means different NI-700s and M means
>> different PMU in one NI-700. If only one NI-700 found in NI-700, name will
>> be ni_pmu_N.
>> Node interface event name will be xxni_N_eventname, such as
>> asni_0_rdreq_any. There are many kinds of type of nodes in one clock
>> domain. Also means that there are many kinds of that in one PMU. So we
>> distinguish them by xxni string. Besides, maybe there are many nodes
>> have same type. So we have number N in event name.
>> By ni_pmu_0_0/asni_0_rdreq_any/, we can pinpoint accurate bus traffic.
>> Example1: perf stat -a -e ni_pmu_0_0/asni_0_rdreq_any/,ni_pmu_0_0/cycles/
>> EXample2: perf stat -a -e ni_pmu_0_0/asni,id=0,event=0x0/
>>
>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>> ---
>> v1 --> v2:
>> 1. Submit MAINTANER Documentation/ files seperately.
> 
> SEPARATE PATCHES, not patchsets. You have now checkpatch warnings
> because of this...

..OK. But the MAINTANER file changing should be given in which one 
patches.
I will submit patch v3 after talking and your permission.

> 
>> 2. Delete some useless info printing.
>> 3. Change print from pr_xxx to dev_xxx.
>> 4. Fix more than 75 length log info.
>> 5. Fix dts attribute pccs-id.
>> 6. Fix generic name according to DT specification.
>> 7. Some indentation.
>> 8. Del of_match_ptr macro.
>>
>>   drivers/perf/Kconfig     |   11 +
>>   drivers/perf/Makefile    |    1 +
>>   drivers/perf/hx_arm_ni.c | 1284 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 1296 insertions(+)
>>   create mode 100644 drivers/perf/hx_arm_ni.c
>>
>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
>> index ec6e0d9194a1..95ef8b13730f 100644
>> --- a/drivers/perf/Kconfig
>> +++ b/drivers/perf/Kconfig
>> @@ -241,4 +241,15 @@ config CXL_PMU
>>   
>>   	  If unsure say 'm'.
>>   
>> +config HX_ARM_NI_PMU
>> +       tristate "HX ARM NI-700 PMU"
>> +       depends on PPC_HX_C2000 && 64BIT
> 
> 1. There is no PPC_HX_C2000.

I have been used to using this macro. However this macro is not existed 
in mainline.
I will replace it with ARM64. And del involved C code if OK.

64bit:
__ffs(unsigned long) and __fls(unsigned long) will be wrong in 32bit. I 
pass a u64 argument.
struct ni_hw_perf_event will be big than limit.
BUILD_BUG_ON(sizeof(struct ni_hw_perf_event) > offsetof(struct 
hw_perf_event, target));

> 2. Nothing justified dependency on 64bit. Drop or explain. Your previous
> message did not provide real rationale.

If ARM64, then drop.

> 3. Your indentation here is entirely mismatched. Read the coding style.
> 

OK.

>> +       default y
>> +       help
>> +	 Support for NI-700(Network-on-chip Interconnect) PMUs, which
>> +	 provide monitoring of transactions passing through between
>> +	 CMN and other buses or periapherals.
>> +
>> +source "drivers/perf/hisilicon/Kconfig"
>> +
>>   endmenu
>> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
>> index a06338e3401c..ec8b9c08577d 100644
>> --- a/drivers/perf/Makefile
>> +++ b/drivers/perf/Makefile
>> @@ -27,3 +27,4 @@ obj-$(CONFIG_DWC_PCIE_PMU) += dwc_pcie_pmu.o
>>   obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu/
>>   obj-$(CONFIG_MESON_DDR_PMU) += amlogic/
>>   obj-$(CONFIG_CXL_PMU) += cxl_pmu.o
>> +obj-$(CONFIG_HX_ARM_NI_PMU) += hx_arm_ni.o
>> diff --git a/drivers/perf/hx_arm_ni.c b/drivers/perf/hx_arm_ni.c
>> new file mode 100644
>> index 000000000000..619e3b789dda
>> --- /dev/null
>> +++ b/drivers/perf/hx_arm_ni.c
>> @@ -0,0 +1,1284 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * HX ARM-NI-700 uncore PMU support
>> + *
>> + * This code is based on uncore PMUs arm_smmuv3_pmu and arm-cmn.
>> + *
>> + * One ni-700 can have many clock domains. Each of them has only one PMU.
>> + * Here one PMU corresponds to one 'struct ni_pmu' instance.
>> + *
>> + * PMU name will be ni_pmu_N_M, which N means different NI-700s and M means
>> + * different PMU in one NI-700. If only one NI-700 found in NI-700, name
>> + * will be ni_pmu_N.
>> + *
>> + * Node interface event name will be xxni_N_eventname, such as
>> + * asni_0_rdreq_any. There are many kinds of type of nodes in one clock
>> + * domain. Also means that there are many kinds of that in one PMU. So we
>> + * distinguish them by xxni string. Besides, maybe there are many nodes
>> + * have same type. So we have number N in event name.
>> + * By ni_pmu_0_0/asni_0_rdreq_any/, we can pinpoint accurate bus traffic.
>> + *
>> + * Example1: perf stat -a -e ni_pmu_0_0/asni_0_rdreq_any/,ni_pmu_0_0/cycles/
>> + * Example2: perf stat -a -e ni_pmu_0_0/asni,id=0,event=0x0/
>> + *
>> + * TODO: Secure or non-secure attribute in all event omitted now.
>> + *
>> + */
>> +
>> +#define dev_fmt(fmt) "ni-700 pmu: " fmt
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/bitops.h>
>> +#include <linux/cpuhotplug.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/device.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/kernel.h>
>> +#include <linux/msi.h>
>> +#include <linux/of.h>
>> +#include <linux/perf_event.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/smp.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/types.h>
>> +#include <linux/build_bug.h>
>> +
>> +/* number of counters in one ni pmu */
>> +#define NI_PMU_COUNTER_NUM 8
>> +
>> +/* node type values */
>> +enum ni_node_type {
>> +	NI_BASE = 0x0,
>> +	NI_VD,
>> +	NI_PD,
>> +	NI_CD,
>> +	NI_ASNI = 0x4,
>> +	NI_AMNI,
>> +	NI_PMU,
>> +	NI_HSNI,
>> +	NI_HMNI,
>> +	NI_PMNI = 0x9,
>> +};
>> +
>> +/* event format */
>> +/**
> 
> That's not kerneldoc.
> 
> You must test your code with W=1 build, sparse and smatch.

Changed. Pass W=1.

> 
>> + * config:
>> + * 0-5    31      32-47      48-63
>> + * event  cycles  node_type  node_id
>> + *
>> + */
>> +#define NI_EVENT_FORMAT_EVENT    GENMASK_ULL(5, 0)
>> +#define NI_EVENT_FORMAT_CYCLES   (1ULL << 31)
>> +#define NI_EVENT_FORMAT_NODETYPE GENMASK_ULL(32 + NI_PMNI, 32)
>> +#define NI_EVENT_FORMAT_ASNI     BIT(32 + NI_ASNI)
>> +#define NI_EVENT_FORMAT_AMNI     BIT(32 + NI_AMNI)
>> +#define NI_EVENT_FORMAT_HSNI     BIT(32 + NI_HSNI)
>> +#define NI_EVENT_FORMAT_HMNI     BIT(32 + NI_HMNI)
>> +#define NI_EVENT_FORMAT_PMNI     BIT(32 + NI_PMNI)
>> +#define NI_EVENT_FORMAT_NODEID   GENMASK_ULL(63, 48)
>> +
> 
> ...
> 
>> +
>> +static ssize_t ni_event_show(struct device *dev,
>> +				   struct device_attribute *attr, char *buf)
>> +{
>> +	struct ni_event_attr *eattr;
>> +
>> +	eattr = to_ni_event_attr(attr);
>> +
>> +	if (eattr->ev_desc)
>> +		return sysfs_emit(buf,
>> +				  "%s,id=0x%x,event=0x%llx\n",
>> +				  ni_node_name[eattr->node->type],
>> +				  eattr->node->id,
>> +				  eattr->ev_desc->eventid);
>> +
>> +	return sysfs_emit(buf, "cycles\n");
>> +}
>> +
>> +struct ni_format_attr {
>> +	struct device_attribute attr;
>> +	u64 field;
>> +};
> 
> Declarations go to the top of the file.

Go.

> 
>> +
> 
> ...
> 
>> +
>> +static bool is_event_supported(u64 eventid, enum ni_node_type type)
>> +{
>> +	int num;
>> +	int idx;
>> +	struct ni_event_desc **descs;
>> +
>> +	num = ni_ev_desc_array_size(type, &descs);
>> +
>> +	for (idx = 0; idx < num; idx++)
>> +		if (eventid == descs[idx]->eventid)
>> +			break;
>> +
>> +	return idx == num ? false : true;
>> +}
>> +
>> +static enum ni_node_type ni_event_config_nodetype(u64 config)
>> +{
>> +	u64 nodetype = _ni_event_config_nodetype(config);
>> +	unsigned long lo = __ffs(nodetype), hi = __fls(nodetype);
>> +
>> +	if (!nodetype || lo != hi)
>> +		return 0;
>> +
>> +	return lo;
>> +
> 
> Redundant blank line. Clean it up from the code.

done.

> 
>> +}
>> +
> 
> ...
> 
>> +
>> +static irqreturn_t ni_pmu_handle_irq(int irq_num, void *data)
>> +{
>> +	struct ni_pmu *ni_pmu = data;
>> +	int idx, ret = IRQ_NONE;
>> +
>> +	if (ni_pmu->ni->irq_num != 1)
>> +		return _ni_pmu_handle_irq(ni_pmu);
>> +
>> +	for (idx = 0; idx < ni_pmu->ni->pmu_num; idx++)
>> +		ret |= _ni_pmu_handle_irq(ni_pmu->ni->ni_pmus[idx]);
>> +
>> +	return ret;
>> +}
>> +
>> +static int ni_hp_state;
> 
> Drop. No file-scope variables. And for 100% no file scope variables
> hidden in the middle of something else.

I will place it in the top.
Remind me that one struct global_ni should have one hp_state.
Now:
struct global_ni{
	int hp_state; // new add.
};

> 
>> +static int ni_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>> +{
>> +	struct global_ni *ni;
>> +	unsigned int target;
>> +	int idx;
>> +
>> +
>> +	ni = hlist_entry_safe(node, struct global_ni, node);
>> +	if (cpu != ni->on_cpu)
>> +		return 0;
>> +
>> +
>> +	target = cpumask_any_but(cpu_online_mask, cpu);
>> +	if (target >= nr_cpu_ids)
>> +		return 0;
>> +
>> +
>> +	for (idx = 0; idx < ni->pmu_num; idx++) {
>> +		perf_pmu_migrate_context(&ni->ni_pmus[idx]->pmu, cpu, target);
>> +#ifndef CONFIG_PPC_HX_C2000
> 
> Drop, it does not exist.

Drop.

> 
>> +		WARN_ON(irq_set_affinity(ni->ni_pmus[idx]->irq, cpumask_of(target)));
>> +#endif
>> +	}
>> +
>> +	ni->on_cpu = target;
>> +
>> +	return 0;
>> +}
>> +
>> +static u32 ni_child_number_total(void __iomem *periphbase,
>> +				 void __iomem *from, enum ni_node_type type)
>> +{
>> +	enum ni_node_type node_type;
>> +	int total, idx;
>> +	void __iomem *child_base;
>> +
>> +	node_type = ni_node_type(from);
>> +
>> +	if (node_type == type)
>> +		return 1;
>> +
>> +	if (node_type >= NI_ASNI)
>> +		return 0;
>> +
>> +	total = 0;
>> +	for (idx = 0; idx < ni_child_number(from); idx++) {
>> +		child_base = ni_child_pointer(periphbase, from, idx);
>> +		total += ni_child_number_total(periphbase, child_base, type);
>> +	}
>> +
>> +	return total;
>> +}
>> +
>> +static void ni_pmu_reset(struct ni_pmu *ni_pmu)
>> +{
>> +	ni_pmu_disable(&ni_pmu->pmu);
>> +
>> +#define clear_reg(name) \
>> +	writel(readl(ni_pmu_offset(ni_pmu, name)), ni_pmu_offset(ni_pmu, name))
>> +
>> +	clear_reg(pmcntenclr);
>> +	clear_reg(pmintenclr);
>> +	clear_reg(pmovsclr);
>> +
>> +	writel_relaxed(NI_PMU_PMCR_RST_CYC_CNTR & NI_PMU_PMCR_RST_EV_CNTR,
>> +		       ni_pmu_offset(ni_pmu, pmcr));
>> +}
>> +
>> +static int ni_pmu_irq_setup(struct ni_pmu *ni_pmu, int irq_idx)
>> +{
>> +	int err;
>> +	unsigned long flags = IRQF_NOBALANCING | IRQF_SHARED | IRQF_NO_THREAD;
>> +
>> +	ni_pmu->irq = platform_get_irq(to_platform_device(ni_pmu->dev), irq_idx);
>> +	if (ni_pmu->irq < 0)
>> +		return ni_pmu->irq;
>> +
>> +	err = devm_request_irq(ni_pmu->dev, ni_pmu->irq, ni_pmu_handle_irq,
>> +			       flags, dev_name(ni_pmu->dev), ni_pmu);
>> +	if (err)
>> +		return err;
>> +
>> +#ifndef CONFIG_PPC_HX_C2000
> 
> Drop, it does not exist.

Done.

> 
>> +	err = irq_set_affinity(ni_pmu->irq, cpumask_of(ni_pmu->ni->on_cpu));
>> +	if (err)
>> +		return err;
>> +#endif
>> +
>> +	return 0;
>> +}
> 
> ...
> 
>> +static int ni_discovery(struct global_ni *ni)
>> +{
>> +	u32 vd_idx, pd_idx, cd_idx, nd_idx, num_idx = 0;
>> +	void __iomem *vd, *pd, *cd, *nd, **cd_arrays;
>> +	int num;
>> +	struct ni_pmu *ni_pmu;
>> +	struct ni_node node;
>> +	void __iomem *pbase;
>> +	struct device *dev = ni->dev;
>> +
>> +	pbase = ni->base;
>> +
>> +	cd_arrays = devm_kmalloc(dev, ni->cd_num * sizeof(typeof(cd)), GFP_KERNEL);
>> +
>> +	/* Step1: Get all clock domains. */
>> +	for (vd_idx = 0; vd_idx < ni_child_number(ni->base); vd_idx++) {
>> +		vd = ni_child_pointer(pbase, ni->base, vd_idx);
>> +
>> +		for (pd_idx = 0; pd_idx < ni_child_number(vd); pd_idx++) {
>> +			pd = ni_child_pointer(pbase, vd, pd_idx);
>> +
>> +			dev_dbg(dev, "The %dth power domain has %d clock domain",
>> +				pd_idx,
>> +				ni_child_number(pd));
>> +
>> +			for (cd_idx = 0; cd_idx < ni_child_number(pd); cd_idx++) {
>> +				cd_arrays[num_idx++] =
>> +					ni_child_pointer(pbase, pd, cd_idx);
>> +			}
>> +		}
>> +	}
>> +
>> +	/* Step2: Traverse all clock domains. */
>> +	for (cd_idx = 0; cd_idx < ni->cd_num; cd_idx++) {
>> +		cd = cd_arrays[cd_idx];
>> +
>> +		num = ni_child_number(cd);
>> +		dev_dbg(dev, "The %dth clock domain has %d child nodes:", cd_idx, num);
>> +
>> +		/* Omit pmu node */
>> +		ni_pmu = devm_kzalloc(dev, struct_size(ni_pmu, ev_src_nodes, num - 1),
>> +				      GFP_KERNEL);
>> +		ni_pmu->ev_src_num = num - 1;
>> +
>> +		if (!ni_pmu)
>> +			return -ENOMEM;
>> +
>> +		num_idx = 0;
>> +		for (nd_idx = 0; nd_idx < num; nd_idx++) {
>> +			nd = ni_child_pointer(pbase, cd, nd_idx);
>> +
>> +			node.base = nd;
>> +			node.node_type = ni_node_node_type(nd);
>> +
>> +			if (unlikely(ni_node_type(nd) == NI_PMU))
>> +				ni_pmu->pmu_node = node;
>> +			else
>> +				ni_pmu->ev_src_nodes[num_idx++] = node;
>> +			dev_dbg(dev, "  name: %s   id: %d", ni_node_name[node.type], node.id);
>> +		}
>> +
>> +		ni_pmu->dev = dev;
>> +		ni_pmu->ni = ni;
>> +		ni->ni_pmus[cd_idx] = ni_pmu;
>> +	}
>> +
>> +	devm_kfree(dev, cd_arrays);
> 
> Why? If it is not device-lifetime then allocate with usual way.
> 

No device-lifetime.
Will allocate in stack.

>> +
>> +	return 0;
>> +}
>> +
>> +static int ni_pmu_probe(struct platform_device *pdev)
>> +{
>> +	int ret, cd_num, idx, irq_num, irq_idx;
>> +	void __iomem *periphbase;
>> +	struct global_ni *ni;
>> +	struct device *dev = &pdev->dev;
>> +	char *name;
>> +	static int id;
>> +	struct ni_pmu *ni_pmu;
>> +
>> +	BUILD_BUG_ON(sizeof(struct ni_hw_perf_event) >
>> +		     offsetof(struct hw_perf_event, target));
>> +#define NI_PMU_REG_MAP_SIZE 0xE08
>> +	BUILD_BUG_ON(sizeof(struct ni_pmu_reg_map) != NI_PMU_REG_MAP_SIZE);
>> +
>> +	periphbase = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(periphbase)) {
>> +		dev_err_probe(dev, PTR_ERR(periphbase), "Couldn't get ioremap\n");
>> +		return PTR_ERR(periphbase);
> 
> I wrote you the syntax last time:
> return dev_err_probe

done.

> 
>> +	}
>> +
> 
> 
> ...
> 
>> +
>> +static const struct of_device_id ni_pmu_of_match[] = {
>> +	{ .compatible = "hx,c2000-arm-ni" },
> 
> Don't send undocumented compatibles.

OK. Means I should send doc and code in one patch thread with more than 
one patch?

> 
> Best regards,
> Krzysztof
> 
> 

