Return-Path: <linux-kernel+bounces-45698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BB184344D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27331F253CF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AC0FBE1;
	Wed, 31 Jan 2024 02:59:04 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5616CF9F0;
	Wed, 31 Jan 2024 02:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706669943; cv=none; b=PJzInPHdKOCywDqNLcC52O2UFRi2i/cs6sXS5hDbnEpcqidqpWGPfSIb3rr/eFCKDnjKW5wjCpeYlnkRDe/EIPlVzHSFeB0CwBmFfQT/+C4uFlZPaxloFyar1sR69eMOMfU8uft/Xf1Q4eDqwIkRtbB1PyhehXq2gOvMNBjTE9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706669943; c=relaxed/simple;
	bh=w2tP0n7vYPm0ZQ9IwUTlriiUHgmzqV1P8jb0OacLpoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sG0jCpOJIaj4l4PpYQTr8gLZAnivRgDMTsYxLYzhN3sill213xPCDZYf1nrVhgKnkitmZZCOct6tDXgkEciO5zYMt1c0rJPKHC1dp7iqSTvtMbeRyMK7y69ruHPqg77jCXTzfVREC3o768tdIJa0BST7Fr3VI2YjpfqDDFDY85A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp75t1706669849tu2bear4
X-QQ-Originating-IP: a0J0ebgU6bFDY45Dx5Uy7Uz0RHKH+9VHK+kkPG0DC2M=
Received: from [127.0.0.1] ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 31 Jan 2024 10:57:26 +0800 (CST)
X-QQ-SSF: 00400000000000B0B000000A0000000
X-QQ-FEAT: mVJZl7SIEgiL5htXPfV5RKaeMnaKPoqNSCFsmFTExAS8nfVcB+IMggLcME+ke
	aG4TRrEq4H30p6sSVgCN/pk+SgZAN50Ftqrd1STHVNC2/3lGK3tdcwjdQAMddD6Ygd+FKVO
	AarTSZwYHUdiQiUSlpf9oevEz1+SJGYYg9Mm5hyCxgHnNCTiCoM9dw5QHwBwZzoV8IPv8WQ
	rXrdYBY5P6CQbZA3BXyyvnK8PQXSmu4W72ghj4sHcaosSmGT7rjJ3TELlBrfKJfkAbQV0KE
	v1iXmtUdkQaMOtG0znINfMuhpiA8CvPNhC472tQ33lGdiCg9BLyNE74w7mWrPF1/VQ9FR0s
	EzdsR5B+82Jmy/Xfgsbe9FQ3QhuX67ClG9MHkayMcJpXVuBkSuHJnCWqVwJ3r3WcrI5LLZj
	WNFGp/a3u1YxiySgRguLVw==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2611385750304473679
Message-ID: <279DAED08550A69A+3d025259-f011-4312-946d-6f7564a12898@shingroup.cn>
Date: Wed, 31 Jan 2024 10:57:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf/hx_arm_ni: Support uncore ARM NI-700 PMU
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: shenghui.qu@shingroup.cn, ke.zhao@shingroup.cn, zhijie.ren@shingroup.cn,
 Rob Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240130081745.13750-1-jialong.yang@shingroup.cn>
 <40fe84af-1208-4aa4-b97a-368787a2c443@linaro.org>
Content-Language: en-US
From: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>
In-Reply-To: <40fe84af-1208-4aa4-b97a-368787a2c443@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1



在 2024/1/30 16:43, Krzysztof Kozlowski 写道:
> On 30/01/2024 09:17, JiaLong.Yang wrote:
>> This code is based on uncore PMUs arm_smmuv3_pmu and arm-cmn.
>> One ni-700 can have many clock domains. Each of them has only one PMU.
>> Here one PMU corresponds to one 'struct ni_pmu' instance.
>> PMU name will be ni_pmu_N_M, which N means different NI-700s and M means
>> different PMU in one NI-700. If only one NI-700 found in NI-700, name will
>> be ni_pmu_N.
>> Node interface event name will be xxni_N_eventname, such as asni_0_rdreq_any.
>> There are many kinds of type of nodes in one clock domain. Also means that
>> there are many kinds of that in one PMU. So we distinguish them by xxni string.
>> Besides, maybe there are many nodes have same type. So we have number N in
>> event name.
>> By ni_pmu_0_0/asni_0_rdreq_any/, we can pinpoint accurate bus traffic.
>> Example1: perf stat -a -e ni_pmu_0_0/asni_0_rdreq_any/,ni_pmu_0_0/cycles/
>> EXample2: perf stat -a -e ni_pmu_0_0/asni,id=0,event=0x0/
>>
>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>> ---
>> If I should send Doc*/bindings/perf/*.yaml seperately?
> 
> Checkpatch tells you that, doesn't it?
OK. I will send it seperately.
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Some
> warnings can be ignored, but the code here looks like it needs a fix.
> Feel free to get in touch if the warning is not clear.
OK.
> 
>>
>>   .../bindings/perf/hx,c2000-arm-ni.yaml        |   58 +
>>   .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
>>   MAINTAINERS                                   |    6 +
>>   drivers/perf/Kconfig                          |   10 +
>>   drivers/perf/Makefile                         |    1 +
>>   drivers/perf/hx_arm_ni.c                      | 1308 +++++++++++++++++
>>   6 files changed, 1385 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml
>>   create mode 100644 drivers/perf/hx_arm_ni.c
>>
>> diff --git a/Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml b/Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml
>> new file mode 100644
>> index 000000000000..1b145ecbfa83
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml
>> @@ -0,0 +1,58 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/perf/hx,c2000-arm-ni.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: HX-C2000 NI (Network-on_chip Interconnect) Performance Monitors
>> +
>> +maintainers:
>> +  - Jialong Yang <jialong.yang@shingroup.cn>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - hx,c2000-arm-ni
>> +
>> +  reg:
>> +    items:
>> +      - description: Physical address of the base (PERIPHBASE) and
>> +          size of the whole NI configuration address space.
>> +
>> +  interrupts:
>> +    minItems: 1
> 
> Why?
According to hw, one PMU has one interrupt line. So one NI maybe has 
more than one. But actually it depends on hw implementation.
And in C code, I will return error when there is no interrupt.
> 
>> +    items:
>> +      - description: Overflow interrupt for clock domain 0
>> +      - description: Overflow interrupt for clock domain 1
>> +      - description: Overflow interrupt for clock domain 2
>> +    description: Generally, one interrupt line for one PMU. But this also
>> +      support one interrupt line for a NI if merged.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +if:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        const: hx,c2000-arm-ni
> 
> Drop entire if. What is the point of it?
This attribute is used to identify different NI in my company's product.
But even if I don't give this attribute, nothing will be wrong in code.
However if I do that, I will couldn't know the relation between sysfs 
file and hardware NI.

I will drop it. It will be as a normal way to identify NIs manually.
If there is only one NI and not give pccs-id, no thing wrong will happen.
> 
>> +then:
>> +  required:
>> +    - pccs-id
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    ni-pmu@23ff0000 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
OK.
> 
> 
>> +            compatible = "hx,c2000-arm-ni";
>> +	    #address-cells = <1>;
>> +	    #size-cells = <1>;
> 
> Broken indentation.....
> 
> 
> (...)
> 
>> +		ni_pmu->dev = dev;
>> +		ni_pmu->ni = ni;
>> +		ni->ni_pmus[cd_idx] = ni_pmu;
>> +	}
>> +
>> +	devm_kfree(dev, cd_arrays);
>> +
>> +	pr_info("End discovering hardware registers.");
> 
> That's rather useless print. First entire driver must use dev_*. Second,
> drop it, no need for end-of-function prints.
OK.
> 
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
>> +	BUILD_BUG_ON(sizeof(long) == 4);
> 
> I am sorry, but what?
I only want to ensure 64 bit environment. Maybe there are many other way.
I will ensure that in Kconfig.
> 
>> +	BUILD_BUG_ON(sizeof(struct ni_hw_perf_event) >
>> +		     offsetof(struct hw_perf_event, target));
>> +#define NI_PMU_REG_MAP_SIZE 0xE08
>> +	BUILD_BUG_ON(sizeof(struct ni_pmu_reg_map) != NI_PMU_REG_MAP_SIZE);
>> +
>> +	pr_info("Begin probing.");
> 
> NAK, drop. Drop all silly entrance/exit messages. EVERYWHERE.
OK.
> 
>> +
>> +	periphbase = devm_platform_ioremap_resource(pdev, 0);
>> +
> 
> Drop blank line
OK.
> 
>> +	if (IS_ERR(periphbase)) {
>> +		pr_err("%s: ioremap error.", __func__);
> 
> dev_err and you need to print something useful, like error code. Or use
> return dev_err_probe
OK.
> 
>> +		return PTR_ERR(periphbase);
>> +	}
>> +
>> +	cd_num = ni_child_number_total(periphbase, periphbase, NI_CD);
>> +	pr_info("%d clock domains found in NI-700.", cd_num);
> 
> Really, what's with all this printing?
I just want to print how many clock domains.
One clock domain correspond to one PMU.
> 
>> +
>> +	/* Each clock domain contains one PMU. So cd_num == pmu_num. */
>> +	ni = devm_kzalloc(dev,
>> +			  struct_size(ni, ni_pmus, cd_num),
>> +			  GFP_KERNEL);
>> +	if (!ni)
>> +		return -ENOMEM;
>> +
>> +	ni->cd_num = cd_num;
>> +	ni->base = periphbase;
>> +	ni->dev = dev;
>> +	ni->on_cpu = raw_smp_processor_id();
>> +	platform_set_drvdata(pdev, ni);
>> +
>> +	ret = ni_discovery(ni);
>> +	if (ret) {
>> +		pr_err("%s: discovery error.", __func__);
>> +		return ret;
>> +	}
>> +
>> +	irq_num = platform_irq_count(pdev);
>> +	/* Support that one NI with one irq or one clock domain with one irq. */
>> +	if (irq_num < 0 || (irq_num != 1 && irq_num != ni->cd_num)) {
>> +		pr_err("Error in irq number: %d.", irq_num);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (irq_num != cd_num) {
>> +		pr_warn("Only one IRQ found for all PMU.");
>> +		ret = ni_pmu_irq_setup(ni->ni_pmus[0], 0);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	ni->irq_num = irq_num;
>> +
>> +	for (idx = 0, irq_idx = 0; idx < ni->pmu_num; idx++) {
>> +		ni_pmu = ni->ni_pmus[idx];
>> +		ret = ni_pmu_init_attr_groups(ni_pmu);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (irq_num == cd_num) {
>> +			ret = ni_pmu_irq_setup(ni_pmu, irq_idx++);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +
>> +		ni_pmu_reset(ni_pmu);
>> +
>> +		ni_pmu->pmu = (struct pmu) {
>> +			.module		= THIS_MODULE,
>> +			.task_ctx_nr    = perf_invalid_context,
>> +			.pmu_enable	= ni_pmu_enable,
>> +			.pmu_disable	= ni_pmu_disable,
>> +			.event_init	= ni_pmu_event_init,
>> +			.add		= ni_pmu_event_add,
>> +			.del		= ni_pmu_event_del,
>> +			.start		= ni_pmu_event_start,
>> +			.stop		= ni_pmu_event_stop,
>> +			.read		= ni_pmu_event_read,
>> +			.attr_groups    = ni_pmu->pmu.attr_groups,
>> +			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
>> +		};
>> +
>> +#ifdef CONFIG_PPC_HX_C2000
>> +		if (of_property_read_u32(pdev->dev.of_node, "pccs-id", &id))
>> +			pr_warn("No found pccs_id in dts ni pmu node.");
>> +#endif
>> +		if (cd_num > 1)
>> +			name = devm_kasprintf(dev, GFP_KERNEL, "ni_pmu_%d_%d", id++, idx);
>> +		else
>> +			name = devm_kasprintf(dev, GFP_KERNEL, "ni_pmu_%d", id++);
>> +
>> +		ret = perf_pmu_register(&ni_pmu->pmu, name, -1);
>> +		if (ret) {
>> +			pr_err("Error %d_%d registering PMU", id - 1, idx);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	ret = cpuhp_state_add_instance_nocalls(ni_hp_state,
>> +					       &ni->node);
>> +	if (ret)
>> +		return ret;
>> +	pr_info("End probing.");
> 
> No, drop.
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int ni_pmu_remove(struct platform_device *pdev)
>> +{
>> +	struct global_ni *ni = platform_get_drvdata(pdev);
>> +	int idx;
>> +
>> +	for (idx = 0; idx < ni->pmu_num; idx++)
>> +		perf_pmu_unregister(&ni->ni_pmus[idx]->pmu);
>> +
>> +	cpuhp_remove_multi_state(ni_hp_state);
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id ni_pmu_of_match[] = {
>> +	{ .compatible = "hx,c2000-arm-ni" },
>> +	{},
>> +};
>> +
>> +static struct platform_driver ni_pmu_driver = {
>> +	.driver = {
>> +		.name = "ni-pmu",
>> +		.of_match_table = of_match_ptr(ni_pmu_of_match),
> 
> Drop of_match_ptr. Leads to warnings.
OK.
> 
> 
> ...
> 
>> +
>> +module_init(ni_pmu_init);
>> +module_exit(ni_pmu_exit);
>> +/* PLATFORM END */
> 
> Useless comment. Please clean your code from debugging or useless markers.
Done.
> 
> 
> 
> Best regards,
> Krzysztof
> 
> 

