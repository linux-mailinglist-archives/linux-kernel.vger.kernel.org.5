Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CA276B8DF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbjHAPmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbjHAPmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:42:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7C91B7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:42:05 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-522c9d388d2so2939691a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690904522; x=1691509322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQtcPKbsXQesd3ee73glLJa3neIpWm9Jw1Zgod3VBZc=;
        b=QVjaCJdShYncXob5qDKPKZOrHOXXG+Mzk+nvoQrSJig0/gP2J+W6aXoV+s1V0lnufC
         OADuO80eETTmCYQqjKZXqaz/9nLY/KqrxbRT8YFElCSyYPsNghkaWNj/Oe3bFGQ6Pz0F
         AvYztyJPHSml5twrD4qlbRb5bPb+B12i0cJPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690904522; x=1691509322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQtcPKbsXQesd3ee73glLJa3neIpWm9Jw1Zgod3VBZc=;
        b=EVI+bj6eBk16Wymv2eQTfOZDfOlPIzTMvSWILI6ZX26UYtyhEdr59BzSPTniK9Zhoo
         h5KuX2GQqzhipQ70ZrgdiDwgATif/Sss1s1TH/8XvHHIEVAqMKysBnEHUu58yh1oEfQ4
         /PdbnaKNzaHB7G7DjRwV74giAJOu+9N1unSDY0NqK+4Qk2M3DQurlEaY8QfeFKvPEP4o
         cdhks0QcqtHld8W1e9ZPiKqI23Rd5ctwQIJXvEqnPFfhbw3BNvXh4iLJJdKr0bDcsARX
         nb4g6ShRbvxiiJOLUL/1Q7gnEwZOtfhV4/aREIjRtyRzRMyYJlbqjPGcHAWkBXWfocUO
         8JYA==
X-Gm-Message-State: ABy/qLapfvspbpVV9Jzb8BIrUCXIXh0Q6K6mQKOdo2E7v+DpZEREiUYV
        HRRpCvnCwQpM94H8phHjoC8ncfWHuI1hE9E4ZQfuwgLM
X-Google-Smtp-Source: APBJJlGYgSb8JLPbD5v1zfgozoVcGz7uUVlMI7NN0KJrqWvZzPANlyvT0KP/0kbdQ3BK+3pvOVVogQ==
X-Received: by 2002:aa7:c991:0:b0:522:2aee:6832 with SMTP id c17-20020aa7c991000000b005222aee6832mr2685562edt.9.1690904522503;
        Tue, 01 Aug 2023 08:42:02 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id u19-20020a056402111300b0050bc4600d38sm7023651edv.79.2023.08.01.08.42.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 08:42:02 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5229e0603edso11865a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 08:42:02 -0700 (PDT)
X-Received: by 2002:a50:8e16:0:b0:506:b280:4993 with SMTP id
 22-20020a508e16000000b00506b2804993mr301252edw.2.1690904521659; Tue, 01 Aug
 2023 08:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230731091754.1.I501ab68cb926ee33a7c87e063d207abf09b9943c@changeid>
 <ZMkBY7K3Dn04YQ65@dhcp22.suse.cz> <CAD=FV=V5hx7Zy-XMB=sPYcD_h-iP5VknmEoJwvw3Akd_1wDnRw@mail.gmail.com>
 <ZMkkNpYcaYPAMj0Z@dhcp22.suse.cz>
In-Reply-To: <ZMkkNpYcaYPAMj0Z@dhcp22.suse.cz>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Aug 2023 08:41:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ujmyq-1GAvNJsrp=mj_Vg=9b6fmfMfkHq3+8ZQ5KiaRw@mail.gmail.com>
Message-ID: <CAD=FV=Ujmyq-1GAvNJsrp=mj_Vg=9b6fmfMfkHq3+8ZQ5KiaRw@mail.gmail.com>
Subject: Re: [PATCH] watchdog/hardlockup: Avoid large stack frames in watchdog_hardlockup_check()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        kernel test robot <lkp@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 1, 2023 at 8:26=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Tue 01-08-23 07:16:15, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Aug 1, 2023 at 5:58=E2=80=AFAM Michal Hocko <mhocko@suse.com> w=
rote:
> > >
> > > On Mon 31-07-23 09:17:59, Douglas Anderson wrote:
> > > > After commit 77c12fc95980 ("watchdog/hardlockup: add a "cpu" param =
to
> > > > watchdog_hardlockup_check()") we started storing a `struct cpumask`=
 on
> > > > the stack in watchdog_hardlockup_check(). On systems with
> > > > CONFIG_NR_CPUS set to 8192 this takes up 1K on the stack. That
> > > > triggers warnings with `CONFIG_FRAME_WARN` set to 1024.
> > > >
> > > > Instead of putting this `struct cpumask` on the stack, let's declar=
e
> > > > it as `static`. This has the downside of taking up 1K of memory all
> > > > the time on systems with `CONFIG_NR_CPUS` to 8192, but on systems w=
ith
> > > > smaller `CONFIG_NR_CPUS` it's not much emory (with 128 CPUs it's on=
ly
> > > > 16 bytes of memory). Presumably anyone building a system with
> > > > `CONFIG_NR_CPUS=3D8192` can afford the extra 1K of memory.
> > > >
> > > > NOTE: as part of this change, we no longer check the return value o=
f
> > > > trigger_single_cpu_backtrace(). While we could do this and only cal=
l
> > > > cpumask_clear_cpu() if trigger_single_cpu_backtrace() didn't fail,
> > > > that's probably not worth it. There's no reason to believe that
> > > > trigger_cpumask_backtrace() will succeed at backtracing the CPU whe=
n
> > > > trigger_single_cpu_backtrace() failed.
> > > >
> > > > Alternatives considered:
> > > > - Use kmalloc with GFP_ATOMIC to allocate. I decided against this
> > > >   since relying on kmalloc when the system is hard locked up seems
> > > >   like a bad idea.
> > > > - Change the arch_trigger_cpumask_backtrace() across all architectu=
res
> > > >   to take an extra parameter to get the needed behavior. This seems
> > > >   like a lot of churn for a small savings.
> > > >
> > > > Fixes: 77c12fc95980 ("watchdog/hardlockup: add a "cpu" param to wat=
chdog_hardlockup_check()")
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/r/202307310955.pLZDhpnl-lkp@intel.c=
om
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > >
> > > >  kernel/watchdog.c | 14 +++++++-------
> > > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> > > > index be38276a365f..19db2357969a 100644
> > > > --- a/kernel/watchdog.c
> > > > +++ b/kernel/watchdog.c
> > > > @@ -151,9 +151,6 @@ void watchdog_hardlockup_check(unsigned int cpu=
, struct pt_regs *regs)
> > > >        */
> > > >       if (is_hardlockup(cpu)) {
> > > >               unsigned int this_cpu =3D smp_processor_id();
> > > > -             struct cpumask backtrace_mask;
> > > > -
> > > > -             cpumask_copy(&backtrace_mask, cpu_online_mask);
> > > >
> > > >               /* Only print hardlockups once. */
> > > >               if (per_cpu(watchdog_hardlockup_warned, cpu))
> > > > @@ -167,10 +164,8 @@ void watchdog_hardlockup_check(unsigned int cp=
u, struct pt_regs *regs)
> > > >                               show_regs(regs);
> > > >                       else
> > > >                               dump_stack();
> > > > -                     cpumask_clear_cpu(cpu, &backtrace_mask);
> > > >               } else {
> > > > -                     if (trigger_single_cpu_backtrace(cpu))
> > > > -                             cpumask_clear_cpu(cpu, &backtrace_mas=
k);
> > > > +                     trigger_single_cpu_backtrace(cpu);
> > > >               }
> > > >
> > > >               /*
> > > > @@ -178,8 +173,13 @@ void watchdog_hardlockup_check(unsigned int cp=
u, struct pt_regs *regs)
> > > >                * hardlockups generating interleaving traces
> > > >                */
> > > >               if (sysctl_hardlockup_all_cpu_backtrace &&
> > > > -                 !test_and_set_bit(0, &watchdog_hardlockup_all_cpu=
_dumped))
> > > > +                 !test_and_set_bit(0, &watchdog_hardlockup_all_cpu=
_dumped)) {
> > > > +                     static struct cpumask backtrace_mask;
> > > > +
> > > > +                     cpumask_copy(&backtrace_mask, cpu_online_mask=
);
> > > > +                     cpumask_clear_cpu(cpu, &backtrace_mask);
> > > >                       trigger_cpumask_backtrace(&backtrace_mask);
> > >
> > > This looks rather wasteful to just copy the cpumask over to
> > > backtrace_mask in nmi_trigger_cpumask_backtrace (which all but sparc
> > > arches do AFAICS).
> > >
> > > Would it be possible to use arch_trigger_cpumask_backtrace(cpu_online=
_mask, false)
> > > and special case cpu !=3D this_cpu && sysctl_hardlockup_all_cpu_backt=
race?
> >
> > So you're saying optimize the case where cpu =3D=3D this_cpu and then h=
ave
> > a special case (where we still copy) for cpu !=3D this_cpu? I can do
> > that if that's what people want, but (assuming I understand correctly)
> > that's making the wrong tradeoff. Specifically, this code runs one
> > time right as we're crashing and if it takes an extra millisecond to
> > run it's not a huge deal. It feels better to avoid the special case
> > and keep the code smaller.
> >
> > Let me know if I misunderstood.
>
> I meant something like this (untested but it should give an idea what I
> mean hopefully). Maybe it can be simplified even further. TBH I am not
> entirely sure why cpu =3D=3D this_cpu needs this special handling.
> ---
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index be38276a365f..0eedac9f1019 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -151,9 +151,7 @@ void watchdog_hardlockup_check(unsigned int cpu, stru=
ct pt_regs *regs)
>          */
>         if (is_hardlockup(cpu)) {
>                 unsigned int this_cpu =3D smp_processor_id();
> -               struct cpumask backtrace_mask;
> -
> -               cpumask_copy(&backtrace_mask, cpu_online_mask);
> +               bool dump_all =3D false;
>
>                 /* Only print hardlockups once. */
>                 if (per_cpu(watchdog_hardlockup_warned, cpu))
> @@ -167,10 +165,6 @@ void watchdog_hardlockup_check(unsigned int cpu, str=
uct pt_regs *regs)
>                                 show_regs(regs);
>                         else
>                                 dump_stack();
> -                       cpumask_clear_cpu(cpu, &backtrace_mask);
> -               } else {
> -                       if (trigger_single_cpu_backtrace(cpu))
> -                               cpumask_clear_cpu(cpu, &backtrace_mask);
>                 }
>
>                 /*
> @@ -179,7 +173,12 @@ void watchdog_hardlockup_check(unsigned int cpu, str=
uct pt_regs *regs)
>                  */
>                 if (sysctl_hardlockup_all_cpu_backtrace &&
>                     !test_and_set_bit(0, &watchdog_hardlockup_all_cpu_dum=
ped))
> -                       trigger_cpumask_backtrace(&backtrace_mask);
> +                       dump_all =3D true;
> +
> +               if (dump_all)
> +                       arch_trigger_cpumask_backtrace(cpu_online_mask, c=
pu !=3D this_cpu);
> +               else if (cpu !=3D this_cpu)
> +                       trigger_single_cpu_backtrace(cpu);

Ah, I see what you mean. The one issue I have with your solution is
that the ordering of the stack crawls is less ideal in the "dump all"
case when cpu !=3D this_cpu. We really want to see the stack crawl of
the locked up CPU first and _then_ see the stack crawls of other CPUs.
With your solution the locked up CPU will be interspersed with all the
others and will be harder to find in the output (you've got to match
it up with the "Watchdog detected hard LOCKUP on cpu N" message).
While that's probably not a huge deal, it's nicer to make the output
easy to understand for someone trying to parse it...

-Doug
