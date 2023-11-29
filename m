Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D7D7FDA93
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbjK2O5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjK2O5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:57:14 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866BFC6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:57:20 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-28580df78f7so4673218a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701269840; x=1701874640; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lBDvY8xfUiRwWpZzeQ9H8DFnchFRqEtZ7Anhmfk/MaE=;
        b=zkxPXLmb23azapQ/eQ8IEBlsSmpL6+lP1nyoU3BCwoybWPAMQFXW56YBSk2mEdgFSC
         5kogP68//JiZLHhPGjE2b3I8TzJReSgFChkxux/sAEjXN7NT+oUoTTXefc4woRyyffcZ
         FqwMIDms+mXepeiTp/pt4k/446zTH9HACbLlViKKk6kaUp1DlIxYpiImRMidgbDIE3oe
         9VWHTOKzpCFrqs09Tt79HEGdDuwiayCh2SSoBEm2xtGx5cf+qUOcJA7i6j/aY1kQfSQe
         7V3vzxYTmyes+aW2NnxY5sffdaQIjkSJcSWjjZTZ2aapeB2wRMhsmdfzlO/GrcaJajK2
         OUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269840; x=1701874640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBDvY8xfUiRwWpZzeQ9H8DFnchFRqEtZ7Anhmfk/MaE=;
        b=id0nyv5opEFKVPJB9W9OhFMSQWMqUcOHOMC1FZD3CssoxDJrkUWMI5luFUfM8oRWM0
         x1RpH9ZOAaRJiaE6NlAFjfI2ZOUF1X5npKAzPk1HXbzJ5SQBSg75afCBvB3I/J/1MVRk
         aBKXQ4ncGt2aXaw3PWcF5sXn3XmBORi9l4hHFfeNdPDKM9evqvvlg8mQOpeLf+/+eGDi
         INxLESA+jzPybwS2Hd2EcCa/SC79qtCXXDAzjgOhopN2JdrOlZ3Jl8DeMoG22GEgIwHs
         NL43VtP5dMpBsF8EgEpoIcxsnluGlfQfpQ0DCD+AS+401T/er52SEWKr+GJ2hNN32KGt
         QEYQ==
X-Gm-Message-State: AOJu0YzDNs9izSxbubmKWzR+ODrwHVPlbd+knoIIvVFLwKXbGVZMdFtm
        jOQQm0wyA5ZcZNjG5ohD3URx+tYoyV7isa3IA7vMhQ==
X-Google-Smtp-Source: AGHT+IEHJzKIugJyAirnHA8jm9ZsrM79uoKWJCmfioIMr8438yJMfCRcgL5l4g9Ssds+KQR6JrFMN1Np/NBF2zPVw/0=
X-Received: by 2002:a17:90b:17c7:b0:285:9b51:64f with SMTP id
 me7-20020a17090b17c700b002859b51064fmr16079874pjb.36.1701269839853; Wed, 29
 Nov 2023 06:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
 <20231109101438.1139696-2-vincent.guittot@linaro.org> <ZWYM0hn28RHjAalh@arm.com>
 <ZWYOg1gIIgI1qXn7@arm.com>
In-Reply-To: <ZWYOg1gIIgI1qXn7@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 29 Nov 2023 15:57:08 +0100
Message-ID: <CAKfTPtA2g-rDPBJkoXpcHrz4vcYAivequkLvWUXgwQpqFcZkOQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] topology: Add a new arch_scale_freq_reference
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
        lukasz.luba@arm.com, pierre.gondois@arm.com,
        beata.michalska@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ionela,

On Tue, 28 Nov 2023 at 17:00, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> On Tuesday 28 Nov 2023 at 15:52:52 (+0000), Ionela Voinescu wrote:
> > Hi Vincent,
> >
> > I have a small request on this patch, which is useful for [1].
> > I'll detail what is needed lower in the code.
> >
> > [1] https://lore.kernel.org/lkml/ZWYDr6JJJzBvsqf0@arm.com/
> >
> > On Thursday 09 Nov 2023 at 11:14:32 (+0100), Vincent Guittot wrote:
> > > @@ -279,13 +278,13 @@ void topology_normalize_cpu_scale(void)
> > >
> > >     capacity_scale = 1;
> > >     for_each_possible_cpu(cpu) {
> > > -           capacity = raw_capacity[cpu] * per_cpu(freq_factor, cpu);
> > > +           capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
> >
> > The only affected code that I could find is here and below.
> >
> > The above line would have to change to:
> > capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu) ?: 1;
> >
> > >             capacity_scale = max(capacity, capacity_scale);
> > >     }
> > >
> > >     pr_debug("cpu_capacity: capacity_scale=%llu\n", capacity_scale);
> > >     for_each_possible_cpu(cpu) {
> > > -           capacity = raw_capacity[cpu] * per_cpu(freq_factor, cpu);
> > > +           capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
> >
> > and here:
> > capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu) ?: 1;
> >
> > I think it's nicer to start with capacity_freq_ref as 0 and compensate here
> > for uninitialized capacity_freq_ref.
> >
> > Let me know if this is alright of if you'd prefer us to make this change
> > in a separate patch.
> >
> > Thanks,
> > Ionela.
> >
>
> Correction - both will need to be:
> capacity = raw_capacity[cpu] * (per_cpu(capacity_freq_ref, cpu) ?: 1);

Yes, this one is better to keep the same behavior when cpufreq driver
is never loaded

I think this change should come as an additional patch either on top
of this series or directly as part of [1] which is the main user of
the change. I assume that's because you want arch_freq_get_on_cpu()
returns 0 until everything has been initialized

Vincent

>
> Thanks,
> Ionela.
