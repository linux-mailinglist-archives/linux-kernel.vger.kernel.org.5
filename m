Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC0C76B706
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjHAOQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjHAOQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:16:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A251B2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:16:31 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c1d03e124so253720966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 07:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690899388; x=1691504188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlwT1DueXSoCf3c/b9PN9KuFDaf4M9D4nHATxObaoOk=;
        b=i3Jf7kv0VOdvht1XjsefyLRkLkeGocdXIayr6oPW4wEIR9AxVSLXyfdIEHqtjuqzvV
         l0TiHdoy5msVMuaOzlTi0+qAZ+LfD5LXgQhPxJzFhWdPy+QEAmlyHPSBUPF3yb8HtnD/
         Cx92kvBsC6OhwnllbfwBOZGnt4Uy5Uzp4dxeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690899388; x=1691504188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlwT1DueXSoCf3c/b9PN9KuFDaf4M9D4nHATxObaoOk=;
        b=b1GeRTCJ/JJsqVPWp0Qtj4FA1SI3sBWzgWInw8YPOVx+ZJF5KNyugABVabTO8psIhe
         tgglqBuPGx6FOH4gYNgdXnVQhg18cmTd85XvLA2Q666+sKXdxVjC6SmHgXeCv+M+q7Wx
         ktZ+VS+J4XAs/C80pLk6xBpJJwpnWtcLJSS1hyqcehy7k7KzSsOoXxOkFT2fSrI39gKz
         sfyny8XI7HhK6qb4lsBZlqKCKc1FkRTvwIra8d1cECSlSEEH3CY9t5zyR3HuYdrTb7BZ
         MR20+CJG7mH54ZeJZcjMZ7/Nw4Rq8V11mxDCu+n5yD+TgQp2k/SGzXTMNqN5JNrhBra/
         NNRA==
X-Gm-Message-State: ABy/qLbv2BpC9YaGmbcBm2U2JncU3TPwZ7uFCUYnTCNcigPoX5LA09mB
        L20/+eIlPaKqjQleWSFQR9lEqNsqKUzFE8Qs0XygtQ==
X-Google-Smtp-Source: APBJJlEMAyXjmtjCGCvRqrSZHekAB+oZKDvuxr7PVuJJ5C3gNrEH/jCavpGDoYr76ikp/mIoPDlkdg==
X-Received: by 2002:a17:907:77cd:b0:99b:cb7a:c164 with SMTP id kz13-20020a17090777cd00b0099bcb7ac164mr1897212ejc.62.1690899388557;
        Tue, 01 Aug 2023 07:16:28 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id rn16-20020a170906d93000b009875a6d28b0sm7724316ejb.51.2023.08.01.07.16.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 07:16:28 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so10831a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 07:16:28 -0700 (PDT)
X-Received: by 2002:a50:c31c:0:b0:522:3ead:377 with SMTP id
 a28-20020a50c31c000000b005223ead0377mr139742edb.7.1690899387728; Tue, 01 Aug
 2023 07:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230731091754.1.I501ab68cb926ee33a7c87e063d207abf09b9943c@changeid>
 <ZMkBY7K3Dn04YQ65@dhcp22.suse.cz>
In-Reply-To: <ZMkBY7K3Dn04YQ65@dhcp22.suse.cz>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Aug 2023 07:16:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V5hx7Zy-XMB=sPYcD_h-iP5VknmEoJwvw3Akd_1wDnRw@mail.gmail.com>
Message-ID: <CAD=FV=V5hx7Zy-XMB=sPYcD_h-iP5VknmEoJwvw3Akd_1wDnRw@mail.gmail.com>
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

On Tue, Aug 1, 2023 at 5:58=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Mon 31-07-23 09:17:59, Douglas Anderson wrote:
> > After commit 77c12fc95980 ("watchdog/hardlockup: add a "cpu" param to
> > watchdog_hardlockup_check()") we started storing a `struct cpumask` on
> > the stack in watchdog_hardlockup_check(). On systems with
> > CONFIG_NR_CPUS set to 8192 this takes up 1K on the stack. That
> > triggers warnings with `CONFIG_FRAME_WARN` set to 1024.
> >
> > Instead of putting this `struct cpumask` on the stack, let's declare
> > it as `static`. This has the downside of taking up 1K of memory all
> > the time on systems with `CONFIG_NR_CPUS` to 8192, but on systems with
> > smaller `CONFIG_NR_CPUS` it's not much emory (with 128 CPUs it's only
> > 16 bytes of memory). Presumably anyone building a system with
> > `CONFIG_NR_CPUS=3D8192` can afford the extra 1K of memory.
> >
> > NOTE: as part of this change, we no longer check the return value of
> > trigger_single_cpu_backtrace(). While we could do this and only call
> > cpumask_clear_cpu() if trigger_single_cpu_backtrace() didn't fail,
> > that's probably not worth it. There's no reason to believe that
> > trigger_cpumask_backtrace() will succeed at backtracing the CPU when
> > trigger_single_cpu_backtrace() failed.
> >
> > Alternatives considered:
> > - Use kmalloc with GFP_ATOMIC to allocate. I decided against this
> >   since relying on kmalloc when the system is hard locked up seems
> >   like a bad idea.
> > - Change the arch_trigger_cpumask_backtrace() across all architectures
> >   to take an extra parameter to get the needed behavior. This seems
> >   like a lot of churn for a small savings.
> >
> > Fixes: 77c12fc95980 ("watchdog/hardlockup: add a "cpu" param to watchdo=
g_hardlockup_check()")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/r/202307310955.pLZDhpnl-lkp@intel.com
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  kernel/watchdog.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> > index be38276a365f..19db2357969a 100644
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -151,9 +151,6 @@ void watchdog_hardlockup_check(unsigned int cpu, st=
ruct pt_regs *regs)
> >        */
> >       if (is_hardlockup(cpu)) {
> >               unsigned int this_cpu =3D smp_processor_id();
> > -             struct cpumask backtrace_mask;
> > -
> > -             cpumask_copy(&backtrace_mask, cpu_online_mask);
> >
> >               /* Only print hardlockups once. */
> >               if (per_cpu(watchdog_hardlockup_warned, cpu))
> > @@ -167,10 +164,8 @@ void watchdog_hardlockup_check(unsigned int cpu, s=
truct pt_regs *regs)
> >                               show_regs(regs);
> >                       else
> >                               dump_stack();
> > -                     cpumask_clear_cpu(cpu, &backtrace_mask);
> >               } else {
> > -                     if (trigger_single_cpu_backtrace(cpu))
> > -                             cpumask_clear_cpu(cpu, &backtrace_mask);
> > +                     trigger_single_cpu_backtrace(cpu);
> >               }
> >
> >               /*
> > @@ -178,8 +173,13 @@ void watchdog_hardlockup_check(unsigned int cpu, s=
truct pt_regs *regs)
> >                * hardlockups generating interleaving traces
> >                */
> >               if (sysctl_hardlockup_all_cpu_backtrace &&
> > -                 !test_and_set_bit(0, &watchdog_hardlockup_all_cpu_dum=
ped))
> > +                 !test_and_set_bit(0, &watchdog_hardlockup_all_cpu_dum=
ped)) {
> > +                     static struct cpumask backtrace_mask;
> > +
> > +                     cpumask_copy(&backtrace_mask, cpu_online_mask);
> > +                     cpumask_clear_cpu(cpu, &backtrace_mask);
> >                       trigger_cpumask_backtrace(&backtrace_mask);
>
> This looks rather wasteful to just copy the cpumask over to
> backtrace_mask in nmi_trigger_cpumask_backtrace (which all but sparc
> arches do AFAICS).
>
> Would it be possible to use arch_trigger_cpumask_backtrace(cpu_online_mas=
k, false)
> and special case cpu !=3D this_cpu && sysctl_hardlockup_all_cpu_backtrace=
?

So you're saying optimize the case where cpu =3D=3D this_cpu and then have
a special case (where we still copy) for cpu !=3D this_cpu? I can do
that if that's what people want, but (assuming I understand correctly)
that's making the wrong tradeoff. Specifically, this code runs one
time right as we're crashing and if it takes an extra millisecond to
run it's not a huge deal. It feels better to avoid the special case
and keep the code smaller.

Let me know if I misunderstood.

-Doug
