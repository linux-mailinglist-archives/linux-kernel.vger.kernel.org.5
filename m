Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD98770C81
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 01:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjHDXq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 19:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHDXq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 19:46:26 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAC34EE1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 16:46:25 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so41835231fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 16:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691192783; x=1691797583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sb+4pCllmJJ7rjBv2mlDr8tgkSUYIc/QTdbIJT7j/YQ=;
        b=PzCd8T7aoqQy5P9TsCJNsqS5TmAI12zcYzAltIgqkJ1wk6Rv2n29yBWb7SKQzTEOMg
         klv4p+o+1Uus8kYzKq7zpJ2U+2ZinK/a7BkZhA2stFroz2FAT6ZODN41FKNIVAaS6xGL
         FppB/dRYHRCw+j7igA6DnbO1WwSprtAs04KtJV0j1UCis4Wf3A+65l56iwBI4J37MUcf
         +MH83HnxPusi8yR9PBvZZ78W+wmHceMd2R31GdwfGGMH8cWQ0Y21Hx53NUCfuJ/U8pQb
         4bAaUKF/ZKcZwR8D1M4q72z/kQbEkhdeYx4m6RFEzKPZf1DzK9nP7OiGpsajImLtLY8F
         UurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691192783; x=1691797583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sb+4pCllmJJ7rjBv2mlDr8tgkSUYIc/QTdbIJT7j/YQ=;
        b=fFyhfkLvh47fYJwnezK4mJt5R1TWgLKlIhOJHwhlH6Uqqdt873/RTH8YYy5T5yKBdQ
         0iPpHHQRgLAwOe14Om8kkB5p5iKPzXj8P5Y+tR/l5T++zYnTjEcV1rijXVXto63IA8DA
         DRsV14CKMhfQFTyfPCq1cGRHr1XZIc83qPpz4F3FY/3JAd+QWxK/xugZAPaHacWkAwX/
         nJo2719IMaKJ4iABo2u2xeQnYBE2+SDmCrTUbbE+zTJbEfkEZ49SY9xZ7dK5PGacaR8z
         V0vfuPgqfW0S6SsDVIz5UWoQWeSXjiFM6ZAvG/mMik62Qj0o9Eqc/V2VIfD5+Hm4VHi8
         yGMw==
X-Gm-Message-State: AOJu0Ywjs4SEvjO1QqR/JOk6arGve1OaQzU0mwEzBiImzmtyqrN200xc
        7tLDXDX2oVChJzdhozFgNt9USkrtRNkx/57Mo09f4w==
X-Google-Smtp-Source: AGHT+IF7Xj9hVx7e2cSxvhdM67SjQGRQCW8amISJQSkk0Sab0lW07zShtf4Zr8t2PohrDE+oAfoosrldACSQCmzw4aQ=
X-Received: by 2002:a2e:8e93:0:b0:2b9:412a:111d with SMTP id
 z19-20020a2e8e93000000b002b9412a111dmr2610679ljk.42.1691192783428; Fri, 04
 Aug 2023 16:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230731174613.4133167-1-davidai@google.com> <20230731174613.4133167-3-davidai@google.com>
 <80f47262-9354-472f-8122-5ae262c0a46d@quicinc.com>
In-Reply-To: <80f47262-9354-472f-8122-5ae262c0a46d@quicinc.com>
From:   David Dai <davidai@google.com>
Date:   Fri, 4 Aug 2023 16:46:11 -0700
Message-ID: <CABN1KCKUt3GN=LqF9AK3Dc+4x98Asj-wpW4UNYsfjRz4Di8N5Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] cpufreq: add virtual-cpufreq driver
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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
        Gupta Pankaj <pankaj.gupta@amd.com>,
        Mel Gorman <mgorman@suse.de>, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,

Thanks for reviewing!

On Wed, Aug 2, 2023 at 9:18=E2=80=AFPM Pavan Kondeti <quic_pkondeti@quicinc=
.com> wrote:
>
> On Mon, Jul 31, 2023 at 10:46:09AM -0700, David Dai wrote:
> > Introduce a virtualized cpufreq driver for guest kernels to improve
> > performance and power of workloads within VMs.
> >
> > This driver does two main things:
> >
> > 1. Sends the frequency of vCPUs as a hint to the host. The host uses th=
e
> > hint to schedule the vCPU threads and decide physical CPU frequency.
> >
> > 2. If a VM does not support a virtualized FIE(like AMUs), it queries th=
e
> > host CPU frequency by reading a MMIO region of a virtual cpufreq device
> > to update the guest's frequency scaling factor periodically. This enabl=
es
> > accurate Per-Entity Load Tracking for tasks running in the guest.
> >
> > Co-developed-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: David Dai <davidai@google.com>
>
> [...]
>
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
>
> We expect the host to provide the frequency in kHz, can you please add a
> comment about it. It is not very obvious when you look at the
> REG_CUR_FREQ_OFFSET register name.

I=E2=80=99ll include a KHZ in the offset names.

>
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
>
> Why do we undo the frequency boost? A governor may apply other boosts
> like RT (uclamp), iowait. It is not clear why we need to worry about
> governor policies here.

See Saravana=E2=80=99s response to Quentin for more details, but in short,
we=E2=80=99ll remove this particular snippet in the driver.

>
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
>
> Do we need to register as FIE source even with the below commit? By
> registering as a source, we are not supplying any accurate metric. We
> still fallback on the same source that cpufreq implements it.

The arch_set_freq_scale() done at cpufreq driver=E2=80=99s frequency update=
s
at cpufreq_freq_transition_end() and cpufreq_driver_fast_switch() only
represent the guest=E2=80=99s frequency request. However, this does not
accurately represent the physical CPU=E2=80=99s frequency that the vCPU is
running on. E.g. There may be other processes sharing the same
physical CPU that results in a much higher CPU frequency than what=E2=80=99=
s
requested by the vCPU.

Thanks,
David

>
> 874f63531064 ("cpufreq: report whether cpufreq supports Frequency
> Invariance (FI)")
>
> Thanks,
> Pavan
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
