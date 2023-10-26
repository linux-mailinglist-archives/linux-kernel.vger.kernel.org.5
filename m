Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3AA7D85B6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345393AbjJZPNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjJZPNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:13:46 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D7718A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:13:43 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5b8ece0f440so754056a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698333223; x=1698938023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sIQNokBhQSScd068h2R0va+GxK2e4ptgRXBIV8yGO3Q=;
        b=N62rOjtivORs1dnaKyFdptn0As3ebL4e2NRp4MbtpxB9NhDjEp5XfFLDjW5wu9AikT
         v4ZEReFBnrUJnqqwDpG6EOTYtHxx3iZSge7qELAO4/Uvt/M6tPB0cCuQbRw4HPvQs8dz
         6dB9UpZt+wWSe+JfhagQGXCePRB8a/pULdL186CltT7SodHSkcsiYi5/QYd91htniKuv
         18HUO0QyHm44ye30s416GpgwfRB2jxi5uXQVNrVLSaHOqkGWlWTYooI31FEONHkgzsGa
         LRsXBkfmhFTolbfVbWPiSK+V2+oO2gTNsOQhVy5PS+HCBt44Bxii7dpGrdCRJiAbOlhs
         gUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698333223; x=1698938023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIQNokBhQSScd068h2R0va+GxK2e4ptgRXBIV8yGO3Q=;
        b=DPBxdSFGLNJsZZZJtCxDO0eBShX+DP+QUjijNiXjOc8v4kRsWzxLfDB4bMDsFpx2/M
         xjpcVOoIUre6IK5OutRolikEWzjEB2mVkiTtbMjsY3x17akrHATu32QpJIoP7+MLnM9Y
         g6nRbYNUrMTLMIPcEBfugSfVUHysqoKlbor3n3QsjqdCUc8IpnIL8hAL9KTNi9Vr/g1w
         M4KZvT5WDKhymxDw86wskKMKpqLAWD1nrCbXE6n8bvSdNMkWIj0XyqLC+th4p7h5Dzlm
         l94XLkWrj2AkA39RvwfjcbaPUDLo4bSprYb4PuepVFuxgvgm3wKSrsIDupHiAIUjSXIw
         T12Q==
X-Gm-Message-State: AOJu0Yy3YK6yt/2m3HJd492YOKzAlMB+esgCHaGPD9Y5GNMoHUmFAvrd
        h8dUVwc6ZJK+EA/PHNnj54E9QkyldvydURFaySITbw==
X-Google-Smtp-Source: AGHT+IHpvFfxEX2wvpX4oLmokC74kO3PgHJfv15pxMoSpuOPt/vENsjW1mHuLxZFo88vzceGkfO3QCACBcu/EM6N+5k=
X-Received: by 2002:a17:90a:1a43:b0:27d:12e1:94e0 with SMTP id
 3-20020a17090a1a4300b0027d12e194e0mr12590526pjl.36.1698333223116; Thu, 26 Oct
 2023 08:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-4-vincent.guittot@linaro.org> <f5e398f3-fbb7-4840-9084-14c8254b2118@arm.com>
In-Reply-To: <f5e398f3-fbb7-4840-9084-14c8254b2118@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 26 Oct 2023 17:13:31 +0200
Message-ID: <CAKfTPtBJRT56dL7+UW-viZuK3wKfGimQfrkvtuCQ_20g4N5LPQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] cpufreq/schedutil: use a fixed reference frequency
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, viresh.kumar@linaro.org, lenb@kernel.org,
        robert.moore@intel.com, lukasz.luba@arm.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 at 22:13, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 18/10/2023 18:25, Vincent Guittot wrote:
> > cpuinfo.max_freq can change at runtime because of boost as an example. This
> > implies that the value could be different than the one that has been
> > used when computing the capacity of a CPU.
> >
> > The new arch_scale_freq_ref() returns a fixed and coherent reference
> > frequency that can be used when computing a frequency based on utilization.
> >
> > Use this arch_scale_freq_ref() when available and fallback to
> > policy otherwise.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> > Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> >
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 458d359f5991..6e4030482ae8 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -114,6 +114,28 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
> >       }
> >  }
> >
> > +/**
> > + * cpufreq_get_capacity_ref_freq - get the reference frequency of a given CPU that
>
> s/cpufreq_get_capacity_ref_freq/get_capacity_ref_freq
>
> s/of a given CPU/for a given cpufreq policy ? (of which the CPU managing
> it is used for the arch_scale_freq_ref() call in the function.
>
> > + * has been used to correlate frequency and compute capacity.
> > + * @policy: the cpufreq policy of the CPU in question.
> > + * @use_current: Fallback to current freq instead of policy->cpuinfo.max_freq.
>
> Looks like use_current does not exists as a parameter.

Thanks for the review. I'm going to apply your comments

>
> > + *
> > + * Return: the reference CPU frequency to compute a capacity.
> > + */
> > +static __always_inline
> > +unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
> > +{
> > +     unsigned int freq = arch_scale_freq_ref(policy->cpu);
> > +
> > +     if (freq)
> > +             return freq;
> > +
> > +     if (arch_scale_freq_invariant())
> > +             return policy->cpuinfo.max_freq;
> > +
> > +     return policy->cur;
> > +}
>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
>
>
