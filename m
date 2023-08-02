Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9319976DA7B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjHBWQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHBWQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:16:46 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC9D2710
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 15:16:43 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4036bd4fff1so111071cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 15:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691014602; x=1691619402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvvvcR5k69/bRgEynReQCQDAoMBXA9xuLK4qPuNVocA=;
        b=zglwa3PToYxIvtMzn3WnGFi8DejAw5vc0K+FdoBU1SgKVW6+BbKI8dgDEysTaBOdS3
         wAG/g1EjswgSsvmQb6Kx1pLdKZtW1OZuE1p4ppE5eswvIpJ5r643GB7xC2Qb2yteAjTS
         9S4oJ5/mEXwSi6Oo6C8R603FivtMh0vLq/XVFCbjeaq3I0yC3Uky/QK3fSk7Q9sXOp4k
         JHplFs69sFkBfelS6L2JvEYefKHdM8N8ChHmYTNQ+zC95tlwpFR2MKd+eQ3CPKHyjhhR
         f4+107CN68rYjdn+J1oH865r9e+0ghtzcUOWIXgh8iSmhOwxettiCgLLanuBusVDUpdx
         sDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691014602; x=1691619402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvvvcR5k69/bRgEynReQCQDAoMBXA9xuLK4qPuNVocA=;
        b=U3mDRyMr4+/SdQOJzqBpfkCYXgys24JI3JLDsxXhqQQXDi+FssjpGmjuLmLiZQ9aKz
         XZbGAmcHZJVmlqeB5HJ/cjdPGVgdWEnRE37pYbYxHvmTRxc3DRP15OnXwMiRY4/W9FLm
         WtLCTqL3BeJiKXi0Sr0scl5t376vtYrsZQ3iKp8Hr4tWm/E/AsDfIrg8zKnU4RKmwVM4
         kQW6noZkrzxPeDpeBVnfvVZ5nYcodY2rZJxhq9w3r2mS5xiVuJ80g3GONOp9uoe1E8cR
         dRwdjNVXzMVT6BTgvkl19ri1pIgBohpSpWUoO2q5SL35X0/yAcZDHg44UtNTTTDNL+bE
         PLvg==
X-Gm-Message-State: ABy/qLbwvHJ0/v73aQdJ+cH9tWQYK/AmYJXJFyTHqZIJqk+kMi1moCGj
        O+LbAwVAg7PDvIF75tsgiVoqGJDPzNPCe3TQhnEiRA==
X-Google-Smtp-Source: APBJJlGAe5hCh+FmJwj3DGeg9uj2C/ZaxhT8Cyzsewe74aeb6wGBeyrI37wS1LtkY2T0M0f39ogx0oD8MIBSq4/HM1k=
X-Received: by 2002:a05:622a:1493:b0:403:b242:3e30 with SMTP id
 t19-20020a05622a149300b00403b2423e30mr1502728qtx.1.1691014602087; Wed, 02 Aug
 2023 15:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230731174613.4133167-1-davidai@google.com> <20230731174613.4133167-3-davidai@google.com>
 <20230801093620.ggz25g3faxycp44q@vireshk-i7>
In-Reply-To: <20230801093620.ggz25g3faxycp44q@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 2 Aug 2023 15:16:06 -0700
Message-ID: <CAGETcx-Y2MONWPEWYHXsWtBxuFQP51wTCS30wJt+NYKD969BuA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] cpufreq: add virtual-cpufreq driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     David Dai <davidai@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 2:36=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 31-07-23, 10:46, David Dai wrote:
> > diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtua=
l-cpufreq.c
> > new file mode 100644
> > index 000000000000..66b0fd9b821c
> > --- /dev/null
> > +++ b/drivers/cpufreq/virtual-cpufreq.c
> > @@ -0,0 +1,237 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2023 Google LLC
> > + */
> > +
> > +#include <linux/arch_topology.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/init.h>
> > +#include <linux/sched.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/pm_opp.h>
> > +#include <linux/slab.h>
> > +
> > +#define REG_CUR_FREQ_OFFSET 0x0
> > +#define REG_SET_FREQ_OFFSET 0x4
> > +#define PER_CPU_OFFSET 0x8
> > +
> > +struct virt_cpufreq_ops {
> > +     void (*set_freq)(struct cpufreq_policy *policy, u32 freq);
> > +     u32 (*get_freq)(struct cpufreq_policy *policy);
> > +};
>
> Since you only have one implementation currently, this isn't really
> required. Keep the data as NULL in `virt_cpufreq_match` and use
> writel/readl directly.
>
> This can be updated if we need more implementations later.
>
> > +struct virt_cpufreq_drv_data {
> > +     void __iomem *base;
> > +     const struct virt_cpufreq_ops *ops;
> > +};
> > +
> > +static void virt_cpufreq_set_freq(struct cpufreq_policy *policy, u32 f=
req)
> > +{
> > +     struct virt_cpufreq_drv_data *data =3D policy->driver_data;
> > +
> > +     writel_relaxed(freq, data->base + policy->cpu * PER_CPU_OFFSET
> > +                     + REG_SET_FREQ_OFFSET);
> > +}
> > +
> > +static u32 virt_cpufreq_get_freq(struct cpufreq_policy *policy)
> > +{
> > +     struct virt_cpufreq_drv_data *data =3D policy->driver_data;
> > +
> > +     return readl_relaxed(data->base + policy->cpu * PER_CPU_OFFSET
> > +                     + REG_CUR_FREQ_OFFSET);
>
> This doesn't look properly aligned. Please run checkpatch (--strict
> (optional)).
>
> > +}
> > +
> > +static const struct virt_cpufreq_ops virt_freq_ops =3D {
> > +     .set_freq =3D virt_cpufreq_set_freq,
> > +     .get_freq =3D virt_cpufreq_get_freq,
> > +};
> > +
> > +static void virt_scale_freq_tick(void)
> > +{
> > +     struct cpufreq_policy *policy =3D cpufreq_cpu_get(smp_processor_i=
d());
> > +     struct virt_cpufreq_drv_data *data =3D policy->driver_data;
> > +     u32 max_freq =3D (u32)policy->cpuinfo.max_freq;
> > +     u64 cur_freq;
> > +     u64 scale;
> > +
> > +     cpufreq_cpu_put(policy);
> > +
> > +     cur_freq =3D (u64)data->ops->get_freq(policy);
> > +     cur_freq <<=3D SCHED_CAPACITY_SHIFT;
> > +     scale =3D div_u64(cur_freq, max_freq);
> > +
> > +     this_cpu_write(arch_freq_scale, (unsigned long)scale);
> > +}
> > +
> > +static struct scale_freq_data virt_sfd =3D {
> > +     .source =3D SCALE_FREQ_SOURCE_VIRT,
> > +     .set_freq_scale =3D virt_scale_freq_tick,
> > +};
> > +
> > +static unsigned int virt_cpufreq_set_perf(struct cpufreq_policy *polic=
y)
> > +{
> > +     struct virt_cpufreq_drv_data *data =3D policy->driver_data;
> > +     /*
> > +      * Use cached frequency to avoid rounding to freq table entries
> > +      * and undo 25% frequency boost applied by schedutil.
> > +      */
> > +     u32 freq =3D mult_frac(policy->cached_target_freq, 80, 100);
> > +
> > +     data->ops->set_freq(policy, freq);
> > +     return 0;
> > +}
> > +
> > +static unsigned int virt_cpufreq_fast_switch(struct cpufreq_policy *po=
licy,
> > +             unsigned int target_freq)
> > +{
> > +     virt_cpufreq_set_perf(policy);
> > +     return target_freq;
> > +}
> > +
> > +static int virt_cpufreq_target_index(struct cpufreq_policy *policy,
> > +             unsigned int index)
> > +{
> > +     return virt_cpufreq_set_perf(policy);
> > +}
> > +
> > +static int virt_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > +{
> > +     struct virt_cpufreq_drv_data *drv_data =3D cpufreq_get_driver_dat=
a();
> > +     struct cpufreq_frequency_table *table;
> > +     struct device *cpu_dev;
> > +     int ret;
> > +
> > +     cpu_dev =3D get_cpu_device(policy->cpu);
> > +     if (!cpu_dev)
> > +             return -ENODEV;
> > +
> > +     ret =3D dev_pm_opp_of_add_table(cpu_dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D dev_pm_opp_get_opp_count(cpu_dev);
> > +     if (ret <=3D 0) {
> > +             dev_err(cpu_dev, "OPP table can't be empty\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     ret =3D dev_pm_opp_init_cpufreq_table(cpu_dev, &table);
> > +     if (ret) {
> > +             dev_err(cpu_dev, "failed to init cpufreq table: %d\n", re=
t);
> > +             return ret;
> > +     }
> > +
> > +     policy->freq_table =3D table;
> > +     policy->dvfs_possible_from_any_cpu =3D false;
>
> Why can't we call virt_cpufreq_target_index() from any CPU ?

This is mainly an optimization to reduce the latency of the "frequency
change" which has a huge impact on the performance (as can be seen
from the numbers in the cover letter).

Setting this flag means that the vCPU thread triggering the MMIO
handling (on the host side) is the thread on which the host needs to
apply any uclamp settings. So this avoids the VMM having to look up
the right vCPU thread that corresponds to this CPU, and any
permissions issues wrt setting another threads uclamp, etc. This
becomes even more important if/when BPF support is added for handling
simple MMIO read/writes. Will Deacon has been working on the eBPF
part[1] and IIUC, not setting this flag adds a lot of extra overhead
on the BPF side.

So, yeah, this flag is very helpful wrt reducing latency/simplifying
host side implementation and that's why we want it here.

[1] - https://kvm-forum.qemu.org/2023/talk/AZKC77/

Thanks,
Saravana

>
> > +     policy->fast_switch_possible =3D true;
> > +     policy->driver_data =3D drv_data;
> > +
> > +     /*
> > +      * Only takes effect if another FIE source such as AMUs
> > +      * have not been registered.
> > +      */
> > +     topology_set_scale_freq_source(&virt_sfd, policy->cpus);
> > +
> > +     return 0;
> > +
> > +}
> > +
> > +static int virt_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> > +{
> > +     topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_VIRT, policy->=
related_cpus);
> > +     kfree(policy->freq_table);
> > +     policy->freq_table =3D NULL;
> > +     return 0;
> > +}
> > +
> > +static int virt_cpufreq_online(struct cpufreq_policy *policy)
> > +{
> > +     /* Nothing to restore. */
> > +     return 0;
> > +}
> > +
> > +static int virt_cpufreq_offline(struct cpufreq_policy *policy)
> > +{
> > +     /* Dummy offline() to avoid exit() being called and freeing resou=
rces. */
> > +     return 0;
> > +}
> > +
> > +static struct cpufreq_driver cpufreq_virt_driver =3D {
> > +     .name           =3D "virt-cpufreq",
> > +     .init           =3D virt_cpufreq_cpu_init,
> > +     .exit           =3D virt_cpufreq_cpu_exit,
> > +     .online         =3D virt_cpufreq_online,
> > +     .offline        =3D virt_cpufreq_offline,
> > +     .verify         =3D cpufreq_generic_frequency_table_verify,
> > +     .target_index   =3D virt_cpufreq_target_index,
> > +     .fast_switch    =3D virt_cpufreq_fast_switch,
> > +     .attr           =3D cpufreq_generic_attr,
> > +};
> > +
> > +static int virt_cpufreq_driver_probe(struct platform_device *pdev)
> > +{
> > +     int ret;
> > +     struct virt_cpufreq_drv_data *drv_data;
> > +
> > +     drv_data =3D devm_kzalloc(&pdev->dev, sizeof(*drv_data), GFP_KERN=
EL);
> > +     if (!drv_data)
> > +             return -ENOMEM;
> > +
> > +     drv_data->ops =3D of_device_get_match_data(&pdev->dev);
> > +     if (!drv_data->ops)
> > +             return -EINVAL;
> > +
> > +     drv_data->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(drv_data->base))
> > +             return PTR_ERR(drv_data->base);
> > +
> > +     cpufreq_virt_driver.driver_data =3D drv_data;
> > +
> > +     ret =3D cpufreq_register_driver(&cpufreq_virt_driver);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "Virtual CPUFreq driver failed to reg=
ister: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     dev_dbg(&pdev->dev, "Virtual CPUFreq driver initialized\n");
> > +     return 0;
> > +}
> > +
> > +static int virt_cpufreq_driver_remove(struct platform_device *pdev)
> > +{
> > +     cpufreq_unregister_driver(&cpufreq_virt_driver);
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id virt_cpufreq_match[] =3D {
> > +     { .compatible =3D "virtual,cpufreq", .data =3D &virt_freq_ops},
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, virt_cpufreq_match);
> > +
> > +static struct platform_driver virt_cpufreq_driver =3D {
> > +     .probe =3D virt_cpufreq_driver_probe,
> > +     .remove =3D virt_cpufreq_driver_remove,
> > +     .driver =3D {
> > +             .name =3D "virt-cpufreq",
> > +             .of_match_table =3D virt_cpufreq_match,
> > +     },
> > +};
> > +
> > +static int __init virt_cpufreq_init(void)
> > +{
> > +     return platform_driver_register(&virt_cpufreq_driver);
> > +}
> > +postcore_initcall(virt_cpufreq_init);
>
> Why do you want to use this and not module_init() ? Then you can
> simply use `module_platform_driver()`.
>
> > +
> > +static void __exit virt_cpufreq_exit(void)
> > +{
> > +     platform_driver_unregister(&virt_cpufreq_driver);
> > +}
> > +module_exit(virt_cpufreq_exit);
> > +
> > +MODULE_DESCRIPTION("Virtual cpufreq driver");
> > +MODULE_LICENSE("GPL");
>
> --
> viresh
