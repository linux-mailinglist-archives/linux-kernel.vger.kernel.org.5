Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569A275C1C2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjGUIeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGUId7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:33:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2197273C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:33:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so2722272e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689928436; x=1690533236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j48T9zCnWdAs5uI/adcGdZub04Cr2ho64wAf4zPt+xU=;
        b=g+lMby7oFVXzQQJ9+l9OAZaKWzytcclPKPjMT+8HOtZYNEVfR+9ZXUk8Il+f7LN7p/
         CK5KM5bKWhZ8sOsmfx70+x0VoNCmxwCeS8MLAS05LGzGvBc2LY2aKp+MCMsztqdT1nnM
         AbVd4+17ATjBZTu6bLTviHAg+YCxW+siob84K/20qA9EED778azsDms5MhRNdVnuW6Sd
         O8UyIiG3UfeGm6RWxqUlke4LlWJqN2nlSje7fS+3aC/j9SO2M8/RcJthaqABg5g0h81O
         EkHpgIUUDtJoHe16PKlyORnkV5DcefFtQNSZDQY9aAklzgXJ9mJc5ODxl+t6UBgckH9R
         zgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689928436; x=1690533236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j48T9zCnWdAs5uI/adcGdZub04Cr2ho64wAf4zPt+xU=;
        b=KVmADVPrSZTbuhiinr2fH4yS9/HrUGYSbl26NQvLrCL6LG9W61a0v4d6mSt49gcVsh
         J+p3piTt3uIebTNBwV9GuNRbfWMWm7hMFUznY/IVmrTKM1AvfpT1a6LmaD0/tWUAyJjK
         5I2nQaEOfp3qxSLRhs/JZWJYfRDwkghOlglyheVR+I6M/LO1FHs41nU+QQwtKbCz45D2
         WC9j41lKm54wNA+EUm1uYgdQ1JqA6OfFQsrSLVQdbK3ibZXsyBq6Y/EXVu1GmwtUj3/D
         aaCnlKDC5caDUfzJYwpR6OejAHVc+sOFvN9AHN08iDEUAsOM1ifVb1c1CQ9q6QvdQvYt
         1GSg==
X-Gm-Message-State: ABy/qLa18U5gbnwoZyBDmjRT5QnEcdQvl/55lvX+4CaL8HVnAkvdyQAQ
        otO6kKcT1a4E5rFhprxJ/An/roCklcTqfIAk+tbhcA==
X-Google-Smtp-Source: APBJJlGT3/iR9y5HHA/jBVQ9tVc+TQIyqddNHIye4549tL8TPl4RlNfQYLMBmdAG9ppv6DmGtV3l2zVOzpyA/lhNx3s=
X-Received: by 2002:a19:8c54:0:b0:4f9:5a87:1028 with SMTP id
 i20-20020a198c54000000b004f95a871028mr794622lfj.30.1689928435798; Fri, 21 Jul
 2023 01:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <1689842053-5291-1-git-send-email-Kenan.Liu@linux.alibaba.com>
 <20230720085032.GB3569127@hirez.programming.kicks-ass.net> <6a70900a-649f-3a4d-2e47-61648bc95666@linux.alibaba.com>
In-Reply-To: <6a70900a-649f-3a4d-2e47-61648bc95666@linux.alibaba.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 21 Jul 2023 10:33:44 +0200
Message-ID: <CAKfTPtCmBL6aq9CaPvmhcyvGZtu=98crDyaHXRdwQxjyGtcDkQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Adjust CFS loadbalance to adapt QEMU CPU topology.
To:     "Kenan.Liu" <Kenan.Liu@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, luoben@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 at 04:59, Kenan.Liu <Kenan.Liu@linux.alibaba.com> wrote=
:
>
> Hi Peter, thanks for your attention,
>
> please refer to my answer to your question inline:
>
>
> =E5=9C=A8 2023/7/20 =E4=B8=8B=E5=8D=884:50, Peter Zijlstra =E5=86=99=E9=
=81=93:
> > On Thu, Jul 20, 2023 at 04:34:11PM +0800, Kenan.Liu wrote:
> >> From: "Kenan.Liu" <Kenan.Liu@linux.alibaba.com>
> >>
> >> Multithreading workloads in VM with Qemu may encounter an unexpected
> >> phenomenon: one hyperthread of a physical core is busy while its sibli=
ng
> >> is idle. Such as:
> > Is this with vCPU pinning? Without that, guest topology makes no sense
> > what so ever.
>
>
> vCPU is pinned on host and the imbalance phenomenon we observed is inside
> VM, not for the vCPU threads on host.
>
>
> >> The main reason is that hyperthread index is consecutive in qemu nativ=
e x86 CPU
> >> model which is different from the physical topology.
> > I'm sorry, what? That doesn't make sense. SMT enumeration is all over
> > the place for Intel, but some actually do have (n,n+1) SMT. On AMD it's
> > always (n,n+1) IIRC.
> >
> >> As the current kernel scheduler
> >> implementation, hyperthread with an even ID number will be picked up i=
n a much
> >> higher probability during load-balancing and load-deploying.
> > How so?
>
>
> The SMT topology in qemu native x86 CPU model is (0,1),=E2=80=A6,(n,n+1),=
=E2=80=A6,
> but nomarlly seen SMT topo in physical machine is like (0,n),(1,n+1),=E2=
=80=A6,
> n means the total core number of the machine.
>
> The imbalance happens when the number of runnable threads is less
> than the number of hyperthreads, select_idle_core() would be called
> to decide which cpu be selected to run the waken-up task.
>
> select_idle_core() will return the checked cpu number if the whole
> core is idle. On the contrary, if any one HT of the core is busy,
> select_idle_core() would clear the whole core out from cpumask and
> check the next core.
>
> select_idle_core():
>      =E2=80=A6
>      if (idle)
>          return core;
>
>      cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
>      return -1;
>
> In this manner, except the very beginning of for_each_cpu_wrap() loop,
> HT with even ID number is always be checked at first, and be returned
> to the caller if the whole core is idle, so the odd indexed HT almost
> has no chance to be selected.
>
> select_idle_cpu():
>      =E2=80=A6
>      for_each_cpu_wrap(cpu, cpus, target + 1) {
>          if (has_idle_core) {
>              i =3D select_idle_core(p, cpu, cpus, &idle_cpu);
>
> And this will NOT happen when the SMT topo is (0,n),(1,n+1),=E2=80=A6, be=
cause
> when the loop starts from the bottom half of SMT number, HTs with larger
> number will be checked first, when it starts from the top half, their
> siblings with smaller number take the first place of inner core searching=
.

But why is it a problem ? Your system is almost idle and 1 HT per core
is used. Who cares to select evenly one HT or the other as long as we
select an idle core in priority ?

This seems related to
https://lore.kernel.org/lkml/BYAPR21MB1688FE804787663C425C2202D753A@BYAPR21=
MB1688.namprd21.prod.outlook.com/
we concluded that it was not a problem

>
>
> >
> >> This RFC targets to solve the problem by adjusting CFS loabalance poli=
cy:
> >> 1. Explore CPU topology and adjust CFS loadbalance policy when we foun=
d machine
> >> with qemu native CPU topology.
> >> 2. Export a procfs to control the traverse length when select idle cpu=
.
> >>
> >> Kenan.Liu (2):
> >>    sched/fair: Adjust CFS loadbalance for machine with qemu native CPU
> >>      topology.
> >>    sched/fair: Export a param to control the traverse len when select
> >>      idle cpu.
> > NAK, qemu can either provide a fake topology to the guest using normal
> > x86 means (MADT/CPUID) or do some paravirt topology setup, but this is
> > quite insane.
> Thanks,
>
> Kenan.Liu
