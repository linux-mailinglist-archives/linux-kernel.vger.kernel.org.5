Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F277F7E05D1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343894AbjKCP4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjKCP4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:56:47 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BA61BC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 08:56:40 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-409299277bbso15988965e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1699026999; x=1699631799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Y/ZjzGOYf3uFvR4OqP02C9g68KQxKGfJ/zZcpHtn+k=;
        b=XjxNe+FS0k9Y6qkwdVA2MEvHCu607XofalfLUaXNpd4dahSC99thY5YwMmdrlvvt13
         K0jF0OkPrKg4dPCpTgLFAITwbS8k9/BQq0fvoxaBSm4Kx4baIXI96Mv9QuK6GhJMpHbE
         M2bwJmdXk4OpFTZYth9HiCwBAOPK6h9BKTHp/yYYu0XAHUbl94UHtZ8DKFm+xQ1/U9u/
         0t6RhPv8rk3+RRQ0QIWeD3Sim7B5OkzS/SgQifAhidxAK5ZGCi8hji+596VT+o+/WMn7
         uxQd/nZvYqLl3bMDZN2fGCGfGABZkVUcxlNVQpgi1OqVbcghDOzGRWn3TasWiOh1rulO
         CvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699026999; x=1699631799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Y/ZjzGOYf3uFvR4OqP02C9g68KQxKGfJ/zZcpHtn+k=;
        b=DyGsOAxC4zLltz4R4i036UA0+XUJt2hnHvxKnlLPKMk80ahY1oh9YXCUJdxCkfsTvV
         Au4W2AQP5iSQ0G1dVXSQJoKGE4DI7fISr7Luy5URUO3upDevL1UQ6tcMu4/8lr9WkNmM
         w8t+6ku4Qf/XOnDgunqJbrXtIYBbFJBo7FUn7mwL0cVsdRh6ISkbl6cxKczyqLFUXmeN
         UKl9hjKKMBubqdlL79ZNLOAUudn3Ce7D3ofGDVF17dMh9NKwejzYFMl6jcjNtDQSOng9
         mdH1Zxpnnt+qmaofK7pD/GCA1USyKhk7T6AHVAsWKG5Sm3fkrLMKoUg5we62TcTdzdQd
         mXbA==
X-Gm-Message-State: AOJu0YxdL343qpnA3MpIyWM1saOQBBtwXWBjnYBoTY43N9QmvqeFrs+z
        XrqKP5AeLBQh9BWk1Xxgvh1jsEwNWvEhDCHHVQQQjg==
X-Google-Smtp-Source: AGHT+IGTDlR1kMzo7Q8s1aofjqF9TBtqnKsq48wjkvuAfJPcwBkAF7KJXKeOa9SaNjlzNwAaiAkx4HluN8PnF2wMa78=
X-Received: by 2002:a05:600c:4687:b0:409:5a92:470c with SMTP id
 p7-20020a05600c468700b004095a92470cmr6936361wmo.13.1699026999264; Fri, 03 Nov
 2023 08:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <4169555.5IIHXK4Dsd@kreacher> <2786976.RHVxHup3hB@kreacher> <a5105853-6b36-7221-0d06-e726d33492fb@huawei.com>
In-Reply-To: <a5105853-6b36-7221-0d06-e726d33492fb@huawei.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Fri, 3 Nov 2023 08:56:29 -0700
Message-ID: <CAAYoRsUrun69UQmx1VR+0CcuM0oyQC-Sm6zAS-TETLdAyHo9Sw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] cpufreq: intel_pstate: Add ->offline and ->online callbacks
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 3:57=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com> =
wrote:
> On 2020/8/25 1:43, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > Add ->offline and ->online driver callbacks to prepare for taking a
> > CPU offline and to restore its working configuration when it goes
> > back online, respectively, to avoid invoking the ->init callback on
> > every CPU online which is quite a bit of unnecessary overhead.
> >
> > Define ->offline and ->online so that they can be used in the
> > passive mode as well as in the active mode and because ->offline
> > will do the majority of ->stop_cpu work, the passive mode does
> > not need that callback any more, so drop it.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > -> v2: Typo fixes and changelog edits (Doug).
> >
> > ---
> >  drivers/cpufreq/intel_pstate.c | 38 ++++++++++++++++++++++++++++------
> >  1 file changed, 32 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pst=
ate.c
> > index 3d18934fa975..98836ac299db 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -2297,28 +2297,51 @@ static int intel_pstate_verify_policy(struct cp=
ufreq_policy_data *policy)
> >       return 0;
> >  }
> >
> > -static void intel_cpufreq_stop_cpu(struct cpufreq_policy *policy)
> > +static int intel_pstate_cpu_offline(struct cpufreq_policy *policy)
> >  {
> > +     pr_debug("CPU %d going offline\n", policy->cpu);
> > +
> > +     intel_pstate_exit_perf_limits(policy);
> > +
> > +     /*
> > +      * If the CPU is an SMT thread and it goes offline with the perfo=
rmance
> > +      * settings different from the minimum, it will prevent its sibli=
ng
> > +      * from getting to lower performance levels, so force the minimum
> > +      * performance on CPU offline to prevent that from happening.
> > +      */
> >       if (hwp_active)
> >               intel_pstate_hwp_force_min_perf(policy->cpu);
> >       else
> >               intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
> > +
> > +     return 0;
> > +}
> > +
> > +static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
> > +{
> > +     pr_debug("CPU %d going online\n", policy->cpu);
> > +
> > +     intel_pstate_init_acpi_perf_limits(policy);
> > +
> > +     if (hwp_active)
> > +             wrmsrl_on_cpu(policy->cpu, MSR_HWP_REQUEST,
> > +                           all_cpu_data[policy->cpu]->hwp_req_cached);
> > +
> > +     return 0;
> >  }
>
> On Ice Lake server, there seems a bug when CONFIG_X86_INTEL_PSTATE=3Dy an=
d
> not configure intel_pstate=3Dxxx in command line.
>
> Although the Performance tuner is used, the CPU have the lowest
> frequency in scaling_cur_freq after the CPU goes offline and then goes
> online, running the same infinite loop load.
>
> How to produce:
>
> echo performance > /sys/devices/system/cpu/cpu12/cpufreq/scaling_governor
>
> cat while_true.c
> #include <stdio.h>
> void main(void)
> {
>         while(1);
> }
>
>
> [root@localhost freq_test]# cat test.sh
> #!/bin/bash
>
> cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
> cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_governor
> taskset -c ${1} ./while_true &
> sleep 1s
>
> cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
>
> echo 0 > /sys/devices/system/cpu/cpu${1}/online
>
> sleep 1s
> cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
>
> sleep 1s
>
> echo 1 > /sys/devices/system/cpu/cpu${1}/online
> cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
>
> taskset -c ${1} ./while_true &
>
> sleep 1s
> cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
>
> sleep 1s
> cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
>
> sleep 1s
> cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
>
>
> [root@localhost freq_test]# sh test.sh 40
> 2300000
> performance
> 2299977
> cat: /sys/devices/system/cpu/cpu40/cpufreq/scaling_cur_freq: Device or
> resource busy
> 2300000
> 2300022
> 2300000
> 2299953
> [root@localhost freq_test]# sh test.sh 50
> 2300000
> performance
> 2300000
> cat: /sys/devices/system/cpu/cpu50/cpufreq/scaling_cur_freq: Device or
> resource busy
> 2300000
> 2299977
> 2300022
> 2299977
> [root@localhost freq_test]# sh test.sh 20
> 2300000
> performance
> 2299977
> cat: /sys/devices/system/cpu/cpu20/cpufreq/scaling_cur_freq: Device or
> resource busy
> 800000
> 800000
> 800000
> 799992
> [root@localhost freq_test]# sh test.sh 21
> 2300000
> performance
> 2300000
> cat: /sys/devices/system/cpu/cpu21/cpufreq/scaling_cur_freq: Device or
> resource busy
> 800000
> 800000
> 800000
> 800000
>
> [root@localhost freq_test]# cat
> /sys/devices/system/cpu/cpu21/cpufreq/scaling_max_freq
> 2300000
> [root@localhost freq_test]# cat
> /sys/devices/system/cpu/cpu21/cpufreq/scaling_min_freq
> 800000

Hi,

I followed your "how to reproduce" notes exactly.
So far, I have been unable to reproduce your issue.

I am using kernel 6.6.
My processor is:
Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz

Results:
root@s19:/home/doug/pstate# ./test.sh 8
800000
performance
4799994
cat: /sys/devices/system/cpu/cpu8/cpufreq/scaling_cur_freq: Device or
resource busy
4799999
4800000
4800001
4799996
root@s19:/home/doug/pstate# ./test.sh 7
800000
performance
4800001
cat: /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq: Device or
resource busy
4799967
4800028
4800006
4799997
root@s19:/home/doug/pstate# ./test.sh 6
800000
performance
4800001
cat: /sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq: Device or
resource busy
4799983
4800001
4799993
4800002
root@s19:/home/doug/pstate# ./test.sh 5
800000
performance
4799990
cat: /sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq: Device or
resource busy
4800006
4800002
4800011
4799980
root@s19:/home/doug/pstate# ./test.sh 4
4799940
performance
4799985
cat: /sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq: Device or
resource busy
4799975
4799994
4799984
4799996
root@s19:/home/doug/pstate# ./test.sh 3
4799986
performance
4799990
cat: /sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq: Device or
resource busy
4799976
4800015
4800000
4799995

... Doug
