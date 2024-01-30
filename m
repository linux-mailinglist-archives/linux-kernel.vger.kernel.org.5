Return-Path: <linux-kernel+bounces-44163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A32841E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B37A1F2D4D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7974A57861;
	Tue, 30 Jan 2024 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lY9wFS1X"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E005645C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604196; cv=none; b=daSNo+UUh7VEDBz26HwXgLDlDbTEEOnXXaklwKZ1VjWCHWot0gy/IaOnsD0d/B6Or+BqYLhJ1GvoqmkCc4I/XDWJFN2pMH6vdrjyPYHzNFLxuvm71pRWLun2NbSea5T8SA48a2/soYmumdqxT6NRgwrFOzrPMKQZ50xyc0hAVtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604196; c=relaxed/simple;
	bh=fgLP+z/buJDiQgwGNu/VAch94art2ca8r9MSFkaPAJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crucLtoB8e5zuvNtirL40caiVrwN/bTIlmgqUwfbv6vOSZk4n5gXWilYxZ6O+v9xrObEkmnilqJaUOamFEkpcAN348K3kJaieCTTmcSaGFHa5+4LyoU1t9riI2HrguPrH6T1sMPiT0wiNZ3Q+KoYfZv2lnSgHeSS8rMvfaK3nF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lY9wFS1X; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5102a877d50so3844485e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706604192; x=1707208992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFrSzXNeVNLAESn+6eisqdonQWCr/G/hK7wPpl59bps=;
        b=lY9wFS1X+EfdneHOlQHi+qh1YHHPvh3CfPEIuARafYtk+O/GMSmJCFCDK1/S9U5zBJ
         COBWbMdSbH4fxNoEsWDRDVON7KV7I6zJCT/rbNlMyzYtoO6n+Z8PlcEELYX/qnmLJrQE
         em3oaiD+2FXtsuzAX5/VgRskprOSr7CpO7JZN4FU2DVZN2q4H/8NyDKnXeG3tTFAS6w+
         vPF39+HV8xENVBYScY48yB3+8nHCK+tCSyicTRvDcsoA2A7Le8hDp5L6KcLgqnJhF5Jc
         MwxBuF6moWJ5MKeQ/YgoJz9c2mQ2y4Dd34aIjxtK/EJCs4ylrlJKTzxlVmspLsQKXcYR
         uc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706604192; x=1707208992;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFrSzXNeVNLAESn+6eisqdonQWCr/G/hK7wPpl59bps=;
        b=B9JJJ5m48jJMkhh5yxqVlIYbHQ1JLoAKkvIXFdUzK/kpg9+2ytyCkXYOvWDDzPdNjm
         iyLFpFkjOMNl9plDec4tpVJD/FXO1gkKoyHD3GL562UWoBvtDZvz2ASjqDA7U5aVTpQ2
         pbjaJRNXVsC5fCS6it1gCEJh24IUfs+ycvNFA3JsKLNVyC4AaemANneKPl32D+jt5wjm
         dQA5oIjaP2jk5Qi1Bfo2KWZKlCGT5qAdZAYXRyK3lcfHGyVGAYARQVr+Dyhk2egnJXQa
         +5zKQKhGThrvXVR3JAuuebG9tG1yzvSKO3H8ICHYRu9QOTZVgSYXNGW7kh6VKlrzX9dT
         af5Q==
X-Gm-Message-State: AOJu0YzdqILSTiA3mam4gc7ieTfDVVAlhYIoiuLr/DGLCmmfPZrZGGWJ
	M/t0GpBKSJbXxbX6/11OajVY0LpCMvMiR8jsjoDjC3o2BRjvj/BVo/ej82esX/c=
X-Google-Smtp-Source: AGHT+IHbmwpRIVKixJkH9O56NvVTw1kPechGrqk+3qm0KSVhTKR4GPB1RBusIKd1ucovctCcCaurUg==
X-Received: by 2002:a05:6512:74c:b0:511:18e4:df90 with SMTP id c12-20020a056512074c00b0051118e4df90mr926897lfs.1.1706604192160;
        Tue, 30 Jan 2024 00:43:12 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id ub14-20020a170907c80e00b00a3109a492d4sm4804341ejc.20.2024.01.30.00.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 00:43:11 -0800 (PST)
Message-ID: <40fe84af-1208-4aa4-b97a-368787a2c443@linaro.org>
Date: Tue, 30 Jan 2024 09:43:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf/hx_arm_ni: Support uncore ARM NI-700 PMU
Content-Language: en-US
To: "JiaLong.Yang" <jialong.yang@shingroup.cn>, Will Deacon
 <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: shenghui.qu@shingroup.cn, ke.zhao@shingroup.cn, zhijie.ren@shingroup.cn,
 Rob Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240130081745.13750-1-jialong.yang@shingroup.cn>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240130081745.13750-1-jialong.yang@shingroup.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 09:17, JiaLong.Yang wrote:
> This code is based on uncore PMUs arm_smmuv3_pmu and arm-cmn.
> One ni-700 can have many clock domains. Each of them has only one PMU.
> Here one PMU corresponds to one 'struct ni_pmu' instance.
> PMU name will be ni_pmu_N_M, which N means different NI-700s and M means
> different PMU in one NI-700. If only one NI-700 found in NI-700, name will
> be ni_pmu_N.
> Node interface event name will be xxni_N_eventname, such as asni_0_rdreq_any.
> There are many kinds of type of nodes in one clock domain. Also means that
> there are many kinds of that in one PMU. So we distinguish them by xxni string.
> Besides, maybe there are many nodes have same type. So we have number N in
> event name.
> By ni_pmu_0_0/asni_0_rdreq_any/, we can pinpoint accurate bus traffic.
> Example1: perf stat -a -e ni_pmu_0_0/asni_0_rdreq_any/,ni_pmu_0_0/cycles/
> EXample2: perf stat -a -e ni_pmu_0_0/asni,id=0,event=0x0/
> 
> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
> ---
> If I should send Doc*/bindings/perf/*.yaml seperately?

Checkpatch tells you that, doesn't it?

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

> 
>  .../bindings/perf/hx,c2000-arm-ni.yaml        |   58 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
>  MAINTAINERS                                   |    6 +
>  drivers/perf/Kconfig                          |   10 +
>  drivers/perf/Makefile                         |    1 +
>  drivers/perf/hx_arm_ni.c                      | 1308 +++++++++++++++++
>  6 files changed, 1385 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml
>  create mode 100644 drivers/perf/hx_arm_ni.c
> 
> diff --git a/Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml b/Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml
> new file mode 100644
> index 000000000000..1b145ecbfa83
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/hx,c2000-arm-ni.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HX-C2000 NI (Network-on_chip Interconnect) Performance Monitors
> +
> +maintainers:
> +  - Jialong Yang <jialong.yang@shingroup.cn>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - hx,c2000-arm-ni
> +
> +  reg:
> +    items:
> +      - description: Physical address of the base (PERIPHBASE) and
> +          size of the whole NI configuration address space.
> +
> +  interrupts:
> +    minItems: 1

Why?

> +    items:
> +      - description: Overflow interrupt for clock domain 0
> +      - description: Overflow interrupt for clock domain 1
> +      - description: Overflow interrupt for clock domain 2
> +    description: Generally, one interrupt line for one PMU. But this also
> +      support one interrupt line for a NI if merged.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: hx,c2000-arm-ni

Drop entire if. What is the point of it?

> +then:
> +  required:
> +    - pccs-id
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    ni-pmu@23ff0000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +            compatible = "hx,c2000-arm-ni";
> +	    #address-cells = <1>;
> +	    #size-cells = <1>;

Broken indentation.....


(...)

> +		ni_pmu->dev = dev;
> +		ni_pmu->ni = ni;
> +		ni->ni_pmus[cd_idx] = ni_pmu;
> +	}
> +
> +	devm_kfree(dev, cd_arrays);
> +
> +	pr_info("End discovering hardware registers.");

That's rather useless print. First entire driver must use dev_*. Second,
drop it, no need for end-of-function prints.

> +
> +	return 0;
> +}
> +
> +static int ni_pmu_probe(struct platform_device *pdev)
> +{
> +	int ret, cd_num, idx, irq_num, irq_idx;
> +	void __iomem *periphbase;
> +	struct global_ni *ni;
> +	struct device *dev = &pdev->dev;
> +	char *name;
> +	static int id;
> +	struct ni_pmu *ni_pmu;
> +
> +	BUILD_BUG_ON(sizeof(long) == 4);

I am sorry, but what?

> +	BUILD_BUG_ON(sizeof(struct ni_hw_perf_event) >
> +		     offsetof(struct hw_perf_event, target));
> +#define NI_PMU_REG_MAP_SIZE 0xE08
> +	BUILD_BUG_ON(sizeof(struct ni_pmu_reg_map) != NI_PMU_REG_MAP_SIZE);
> +
> +	pr_info("Begin probing.");

NAK, drop. Drop all silly entrance/exit messages. EVERYWHERE.

> +
> +	periphbase = devm_platform_ioremap_resource(pdev, 0);
> +

Drop blank line

> +	if (IS_ERR(periphbase)) {
> +		pr_err("%s: ioremap error.", __func__);

dev_err and you need to print something useful, like error code. Or use
return dev_err_probe

> +		return PTR_ERR(periphbase);
> +	}
> +
> +	cd_num = ni_child_number_total(periphbase, periphbase, NI_CD);
> +	pr_info("%d clock domains found in NI-700.", cd_num);

Really, what's with all this printing?

> +
> +	/* Each clock domain contains one PMU. So cd_num == pmu_num. */
> +	ni = devm_kzalloc(dev,
> +			  struct_size(ni, ni_pmus, cd_num),
> +			  GFP_KERNEL);
> +	if (!ni)
> +		return -ENOMEM;
> +
> +	ni->cd_num = cd_num;
> +	ni->base = periphbase;
> +	ni->dev = dev;
> +	ni->on_cpu = raw_smp_processor_id();
> +	platform_set_drvdata(pdev, ni);
> +
> +	ret = ni_discovery(ni);
> +	if (ret) {
> +		pr_err("%s: discovery error.", __func__);
> +		return ret;
> +	}
> +
> +	irq_num = platform_irq_count(pdev);
> +	/* Support that one NI with one irq or one clock domain with one irq. */
> +	if (irq_num < 0 || (irq_num != 1 && irq_num != ni->cd_num)) {
> +		pr_err("Error in irq number: %d.", irq_num);
> +		return -EINVAL;
> +	}
> +
> +	if (irq_num != cd_num) {
> +		pr_warn("Only one IRQ found for all PMU.");
> +		ret = ni_pmu_irq_setup(ni->ni_pmus[0], 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ni->irq_num = irq_num;
> +
> +	for (idx = 0, irq_idx = 0; idx < ni->pmu_num; idx++) {
> +		ni_pmu = ni->ni_pmus[idx];
> +		ret = ni_pmu_init_attr_groups(ni_pmu);
> +		if (ret)
> +			return ret;
> +
> +		if (irq_num == cd_num) {
> +			ret = ni_pmu_irq_setup(ni_pmu, irq_idx++);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		ni_pmu_reset(ni_pmu);
> +
> +		ni_pmu->pmu = (struct pmu) {
> +			.module		= THIS_MODULE,
> +			.task_ctx_nr    = perf_invalid_context,
> +			.pmu_enable	= ni_pmu_enable,
> +			.pmu_disable	= ni_pmu_disable,
> +			.event_init	= ni_pmu_event_init,
> +			.add		= ni_pmu_event_add,
> +			.del		= ni_pmu_event_del,
> +			.start		= ni_pmu_event_start,
> +			.stop		= ni_pmu_event_stop,
> +			.read		= ni_pmu_event_read,
> +			.attr_groups    = ni_pmu->pmu.attr_groups,
> +			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
> +		};
> +
> +#ifdef CONFIG_PPC_HX_C2000
> +		if (of_property_read_u32(pdev->dev.of_node, "pccs-id", &id))
> +			pr_warn("No found pccs_id in dts ni pmu node.");
> +#endif
> +		if (cd_num > 1)
> +			name = devm_kasprintf(dev, GFP_KERNEL, "ni_pmu_%d_%d", id++, idx);
> +		else
> +			name = devm_kasprintf(dev, GFP_KERNEL, "ni_pmu_%d", id++);
> +
> +		ret = perf_pmu_register(&ni_pmu->pmu, name, -1);
> +		if (ret) {
> +			pr_err("Error %d_%d registering PMU", id - 1, idx);
> +			return ret;
> +		}
> +	}
> +
> +	ret = cpuhp_state_add_instance_nocalls(ni_hp_state,
> +					       &ni->node);
> +	if (ret)
> +		return ret;
> +	pr_info("End probing.");

No, drop.

> +
> +	return 0;
> +}
> +
> +static int ni_pmu_remove(struct platform_device *pdev)
> +{
> +	struct global_ni *ni = platform_get_drvdata(pdev);
> +	int idx;
> +
> +	for (idx = 0; idx < ni->pmu_num; idx++)
> +		perf_pmu_unregister(&ni->ni_pmus[idx]->pmu);
> +
> +	cpuhp_remove_multi_state(ni_hp_state);
> +	return 0;
> +}
> +
> +static const struct of_device_id ni_pmu_of_match[] = {
> +	{ .compatible = "hx,c2000-arm-ni" },
> +	{},
> +};
> +
> +static struct platform_driver ni_pmu_driver = {
> +	.driver = {
> +		.name = "ni-pmu",
> +		.of_match_table = of_match_ptr(ni_pmu_of_match),

Drop of_match_ptr. Leads to warnings.


..

> +
> +module_init(ni_pmu_init);
> +module_exit(ni_pmu_exit);
> +/* PLATFORM END */

Useless comment. Please clean your code from debugging or useless markers.



Best regards,
Krzysztof


