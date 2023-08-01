Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268B976AE74
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjHAJjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjHAJio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:38:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BD830C3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:36:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686c06b806cso3832442b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 02:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690882583; x=1691487383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Og0XYHZdIBQ/ijB4oLzVCTJMROZEyka8DTm1Yz0PV3Q=;
        b=D2SrTXANnoth1OFxF9WHB6AKYfSWUYclffrq0OhnnzVixRX8pDxT2WNVlpdIvd269S
         kJOS6TifQEv55b+um7Bt0u45JLqYHCg0ouq45DklxNwYlIL6YNrqCnyoznfUJ3z6OFNk
         iSGoLD8SidSLI5VxtpcqKokNMfDxuqte32GW0DbK4xW+hAyoUq810gq4u9cbfDfPg5y8
         XQgPkKqIZkkNf0S8tay6SGUMqciNGJB1zi9B8gTQlXsFTd9MCu7WQgItkqSEjfI3Uv+I
         k0lEtRDwEFGd4D5uY5SaRHgMMLYRGug3AfLLfdkFEhz+GCEdvKnEhA8Y1pPZ9gQCWxyM
         +zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690882583; x=1691487383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Og0XYHZdIBQ/ijB4oLzVCTJMROZEyka8DTm1Yz0PV3Q=;
        b=N4F4BY9kS8TDtrwDHGXcHJ3JC/w2DGbNtee3X6OqtXaxFlm7WMNyO4YO25hSPEUeN5
         pZuMTOeP1fFgiJX0G8xDI3mHqs9z3aKlXnD382YTbXS46GpA56aDHqQHeeiJd4bjkVZU
         5oH0fhczPHMCrjhX2Tkv3kKj5bM0+l5/SCiQQv9noJo/c4+A3fw1B6x2+4RATJelU37Y
         QxrhrTefCjrt/vJnWXZ5FZxL8SPVUkt+ax1j6lQqWX0b9xkK6s8x1HvhUv+SNfX6rIks
         sEI5qSfn+gvXogmLYX9wbAtUIfNTAJPSa2549i7jCiF2MAN8Wryj/QUFnGExXfoLL1eY
         n5wA==
X-Gm-Message-State: ABy/qLaxrE/yU9P3vTOAyx4S9DmVK3jAXPTjMqNF+b0wp3bF3HsSRw5h
        Um9susM8dk31tXG26vMgELHOTycaTPzJJKwUBrQ=
X-Google-Smtp-Source: APBJJlETs6IDwXkx3rcuHXS6o/qaJ6zjUgKljvm15b+JDoEBLy3BdZ33885uL0aBkdngruFCsVzfGQ==
X-Received: by 2002:a05:6a20:7fa7:b0:135:10fd:31b0 with SMTP id d39-20020a056a207fa700b0013510fd31b0mr14685841pzj.15.1690882583464;
        Tue, 01 Aug 2023 02:36:23 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id c22-20020aa78816000000b006870b923fb3sm7137778pfo.52.2023.08.01.02.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 02:36:22 -0700 (PDT)
Date:   Tue, 1 Aug 2023 15:06:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     David Dai <davidai@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Quentin Perret <qperret@google.com>,
        Masami Hiramatsu <mhiramat@google.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Gupta Pankaj <pankaj.gupta@amd.com>,
        Mel Gorman <mgorman@suse.de>, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] cpufreq: add virtual-cpufreq driver
Message-ID: <20230801093620.ggz25g3faxycp44q@vireshk-i7>
References: <20230731174613.4133167-1-davidai@google.com>
 <20230731174613.4133167-3-davidai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731174613.4133167-3-davidai@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-07-23, 10:46, David Dai wrote:
> diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-cpufreq.c
> new file mode 100644
> index 000000000000..66b0fd9b821c
> --- /dev/null
> +++ b/drivers/cpufreq/virtual-cpufreq.c
> @@ -0,0 +1,237 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Google LLC
> + */
> +
> +#include <linux/arch_topology.h>
> +#include <linux/cpufreq.h>
> +#include <linux/init.h>
> +#include <linux/sched.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_opp.h>
> +#include <linux/slab.h>
> +
> +#define REG_CUR_FREQ_OFFSET 0x0
> +#define REG_SET_FREQ_OFFSET 0x4
> +#define PER_CPU_OFFSET 0x8
> +
> +struct virt_cpufreq_ops {
> +	void (*set_freq)(struct cpufreq_policy *policy, u32 freq);
> +	u32 (*get_freq)(struct cpufreq_policy *policy);
> +};

Since you only have one implementation currently, this isn't really
required. Keep the data as NULL in `virt_cpufreq_match` and use
writel/readl directly.

This can be updated if we need more implementations later.

> +struct virt_cpufreq_drv_data {
> +	void __iomem *base;
> +	const struct virt_cpufreq_ops *ops;
> +};
> +
> +static void virt_cpufreq_set_freq(struct cpufreq_policy *policy, u32 freq)
> +{
> +	struct virt_cpufreq_drv_data *data = policy->driver_data;
> +
> +	writel_relaxed(freq, data->base + policy->cpu * PER_CPU_OFFSET
> +			+ REG_SET_FREQ_OFFSET);
> +}
> +
> +static u32 virt_cpufreq_get_freq(struct cpufreq_policy *policy)
> +{
> +	struct virt_cpufreq_drv_data *data = policy->driver_data;
> +
> +	return readl_relaxed(data->base + policy->cpu * PER_CPU_OFFSET
> +			+ REG_CUR_FREQ_OFFSET);

This doesn't look properly aligned. Please run checkpatch (--strict
(optional)).

> +}
> +
> +static const struct virt_cpufreq_ops virt_freq_ops = {
> +	.set_freq = virt_cpufreq_set_freq,
> +	.get_freq = virt_cpufreq_get_freq,
> +};
> +
> +static void virt_scale_freq_tick(void)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(smp_processor_id());
> +	struct virt_cpufreq_drv_data *data = policy->driver_data;
> +	u32 max_freq = (u32)policy->cpuinfo.max_freq;
> +	u64 cur_freq;
> +	u64 scale;
> +
> +	cpufreq_cpu_put(policy);
> +
> +	cur_freq = (u64)data->ops->get_freq(policy);
> +	cur_freq <<= SCHED_CAPACITY_SHIFT;
> +	scale = div_u64(cur_freq, max_freq);
> +
> +	this_cpu_write(arch_freq_scale, (unsigned long)scale);
> +}
> +
> +static struct scale_freq_data virt_sfd = {
> +	.source = SCALE_FREQ_SOURCE_VIRT,
> +	.set_freq_scale = virt_scale_freq_tick,
> +};
> +
> +static unsigned int virt_cpufreq_set_perf(struct cpufreq_policy *policy)
> +{
> +	struct virt_cpufreq_drv_data *data = policy->driver_data;
> +	/*
> +	 * Use cached frequency to avoid rounding to freq table entries
> +	 * and undo 25% frequency boost applied by schedutil.
> +	 */
> +	u32 freq = mult_frac(policy->cached_target_freq, 80, 100);
> +
> +	data->ops->set_freq(policy, freq);
> +	return 0;
> +}
> +
> +static unsigned int virt_cpufreq_fast_switch(struct cpufreq_policy *policy,
> +		unsigned int target_freq)
> +{
> +	virt_cpufreq_set_perf(policy);
> +	return target_freq;
> +}
> +
> +static int virt_cpufreq_target_index(struct cpufreq_policy *policy,
> +		unsigned int index)
> +{
> +	return virt_cpufreq_set_perf(policy);
> +}
> +
> +static int virt_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +	struct virt_cpufreq_drv_data *drv_data = cpufreq_get_driver_data();
> +	struct cpufreq_frequency_table *table;
> +	struct device *cpu_dev;
> +	int ret;
> +
> +	cpu_dev = get_cpu_device(policy->cpu);
> +	if (!cpu_dev)
> +		return -ENODEV;
> +
> +	ret = dev_pm_opp_of_add_table(cpu_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = dev_pm_opp_get_opp_count(cpu_dev);
> +	if (ret <= 0) {
> +		dev_err(cpu_dev, "OPP table can't be empty\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &table);
> +	if (ret) {
> +		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
> +		return ret;
> +	}
> +
> +	policy->freq_table = table;
> +	policy->dvfs_possible_from_any_cpu = false;

Why can't we call virt_cpufreq_target_index() from any CPU ?

> +	policy->fast_switch_possible = true;
> +	policy->driver_data = drv_data;
> +
> +	/*
> +	 * Only takes effect if another FIE source such as AMUs
> +	 * have not been registered.
> +	 */
> +	topology_set_scale_freq_source(&virt_sfd, policy->cpus);
> +
> +	return 0;
> +
> +}
> +
> +static int virt_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_VIRT, policy->related_cpus);
> +	kfree(policy->freq_table);
> +	policy->freq_table = NULL;
> +	return 0;
> +}
> +
> +static int virt_cpufreq_online(struct cpufreq_policy *policy)
> +{
> +	/* Nothing to restore. */
> +	return 0;
> +}
> +
> +static int virt_cpufreq_offline(struct cpufreq_policy *policy)
> +{
> +	/* Dummy offline() to avoid exit() being called and freeing resources. */
> +	return 0;
> +}
> +
> +static struct cpufreq_driver cpufreq_virt_driver = {
> +	.name		= "virt-cpufreq",
> +	.init		= virt_cpufreq_cpu_init,
> +	.exit		= virt_cpufreq_cpu_exit,
> +	.online         = virt_cpufreq_online,
> +	.offline        = virt_cpufreq_offline,
> +	.verify		= cpufreq_generic_frequency_table_verify,
> +	.target_index	= virt_cpufreq_target_index,
> +	.fast_switch	= virt_cpufreq_fast_switch,
> +	.attr		= cpufreq_generic_attr,
> +};
> +
> +static int virt_cpufreq_driver_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct virt_cpufreq_drv_data *drv_data;
> +
> +	drv_data = devm_kzalloc(&pdev->dev, sizeof(*drv_data), GFP_KERNEL);
> +	if (!drv_data)
> +		return -ENOMEM;
> +
> +	drv_data->ops = of_device_get_match_data(&pdev->dev);
> +	if (!drv_data->ops)
> +		return -EINVAL;
> +
> +	drv_data->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(drv_data->base))
> +		return PTR_ERR(drv_data->base);
> +
> +	cpufreq_virt_driver.driver_data = drv_data;
> +
> +	ret = cpufreq_register_driver(&cpufreq_virt_driver);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Virtual CPUFreq driver failed to register: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_dbg(&pdev->dev, "Virtual CPUFreq driver initialized\n");
> +	return 0;
> +}
> +
> +static int virt_cpufreq_driver_remove(struct platform_device *pdev)
> +{
> +	cpufreq_unregister_driver(&cpufreq_virt_driver);
> +	return 0;
> +}
> +
> +static const struct of_device_id virt_cpufreq_match[] = {
> +	{ .compatible = "virtual,cpufreq", .data = &virt_freq_ops},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, virt_cpufreq_match);
> +
> +static struct platform_driver virt_cpufreq_driver = {
> +	.probe = virt_cpufreq_driver_probe,
> +	.remove = virt_cpufreq_driver_remove,
> +	.driver = {
> +		.name = "virt-cpufreq",
> +		.of_match_table = virt_cpufreq_match,
> +	},
> +};
> +
> +static int __init virt_cpufreq_init(void)
> +{
> +	return platform_driver_register(&virt_cpufreq_driver);
> +}
> +postcore_initcall(virt_cpufreq_init);

Why do you want to use this and not module_init() ? Then you can
simply use `module_platform_driver()`.

> +
> +static void __exit virt_cpufreq_exit(void)
> +{
> +	platform_driver_unregister(&virt_cpufreq_driver);
> +}
> +module_exit(virt_cpufreq_exit);
> +
> +MODULE_DESCRIPTION("Virtual cpufreq driver");
> +MODULE_LICENSE("GPL");

-- 
viresh
