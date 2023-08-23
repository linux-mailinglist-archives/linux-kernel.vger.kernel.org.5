Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97167861E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbjHWVAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbjHWVAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:00:35 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F135B10DC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:00:32 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-407db3e9669so30321cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692824432; x=1693429232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQrhj/+Y96nHQ14b/kycbaBODT3rA3gKxR4BG9eSutI=;
        b=USgwMiS/nrvDGYn501P6BwN3MxhM4LCljwR/wi+wv9CmX3ffy9QKtZNFn7A3n1ojKA
         cL28mlAaaTqPCvzBsxk0a1XD2QvMHetOnJBHXZHc+K2LGDKczZEwJvFxEa3q14Q9Q2V4
         ml0cUTofigPDi5Hneyv957GkskMHoCU3jxLUVIT+bfV4P00xjCg4cGnWokeJq7utuxn7
         fbsq3Fv+LBy/5T9XgSc/STnqmTAc778bBuSVfsIM1WrYgQVeOU+c6cctpTcIXg+q3SLi
         /3KFgI/gxDGanLReUkKlZoSArR49vssiCEsSaaRq7ecLxtCn5k98eYHJEg0b3SthJIJl
         k2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692824432; x=1693429232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQrhj/+Y96nHQ14b/kycbaBODT3rA3gKxR4BG9eSutI=;
        b=XbincmN5Im6PNY/Ll+h/r/5uPT+oXY0XkOejnLOa+N/rZ0acX7Z6NipTSGi1J8Uc42
         rXEd/I5Ecb9TrOtWkhvSW9tUMM/nlY/MDIwGD80OXxBP88bfpLDdZC85NM7UUE0PqGRl
         cWyYsW9pGnnHC7dj/SnrizGkYyCTJz/fazXXW0sLCK4aiOVEl/SYKoIsVgICzIyRESsB
         BQpQngcd0Tx+zA8BGa63Jk7gORFvilq3dZ6N4zfxe3MyeYv/dQJcXJDPi8Xwb9pJvFzO
         sGzO+8Pxe/Tg2wKmutab6Xa1cIhNXwPepRppoAQ8e6zv+KpljR6U+AqTQNn1JeJdtlCq
         CJTg==
X-Gm-Message-State: AOJu0YxnGN1CEQwevhmHt5AJ3ud5dW3V+xyRmkpc/6KWbEsT23W8HVpc
        4mu38IJarvYZEO6ULO8NOpZpszuvmAYnIwOEy3AIMA==
X-Google-Smtp-Source: AGHT+IHYBHEweokA6LehFN+tkdk4U5tNCeiUd6qvdu53QwtrxRdjLi1VdG6C0KzaKMrz0FRQx/MDBOCW+qMRTM+0Aj4=
X-Received: by 2002:ac8:4e43:0:b0:410:385c:d1e0 with SMTP id
 e3-20020ac84e43000000b00410385cd1e0mr559508qtw.25.1692824431906; Wed, 23 Aug
 2023 14:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220613094924.913340374@linuxfoundation.org> <20220613094928.793712131@linuxfoundation.org>
 <6283c4b1-2513-207d-4ed6-fdabf3f3880e@collabora.com> <2023081619-slapping-congrats-8e85@gregkh>
 <471bf84d-9d58-befc-8224-359a62e29786@collabora.com> <CAGETcx-NVoN7b8XCV09ouof81XxZk4wtGhEcqcFAt6Gs=JWKdw@mail.gmail.com>
 <d8f8ddf6-8063-fb3a-7dad-4064a47c5fe8@collabora.com> <CAGETcx-DUm417mM-Nmyqj-e_rKUw69m=rTe5R6_Vxd_rsKMmGg@mail.gmail.com>
 <97b06c78-da3c-d8ab-ca72-ff37b9976f2a@collabora.com> <6d7a7ecc-1364-5cbe-0485-01d693dbdc6c@arm.com>
 <e42b78a2-2b0f-1934-b71d-21bb94a01eed@collabora.com>
In-Reply-To: <e42b78a2-2b0f-1934-b71d-21bb94a01eed@collabora.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 23 Aug 2023 13:59:55 -0700
Message-ID: <CAGETcx87NcKb=dJOFE3vWG_gyPR+w88Kh8ueAgRc_PX=g_uPiA@mail.gmail.com>
Subject: Re: [PATCH 5.17 127/298] driver core: Fix wait_for_device_probe() &
 deferred_probe_timeout interaction
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Stultz <jstultz@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Ferry Toth <fntoth@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-pm@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        =?UTF-8?Q?Ricardo_Ca=C3=B1uelo_Navarro?= 
        <ricardo.canuelo@collabora.com>,
        Guillaume Charles Tucker <guillaume.tucker@collabora.com>,
        usama.anjum@collabora.com, kernelci@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 7:10=E2=80=AFAM Shreeya Patel
<shreeya.patel@collabora.com> wrote:
>
> Hi Robin,
>
> On 21/08/23 18:09, Robin Murphy wrote:
> > On 2023-08-21 12:35, Shreeya Patel wrote:
> >>
> >> On 19/08/23 01:49, Saravana Kannan wrote:
> >>> On Thu, Aug 17, 2023 at 4:13=E2=80=AFPM Shreeya Patel
> >>> <shreeya.patel@collabora.com> wrote:
> >>>> Hi Geert, Saravana,
> >>>>
> >>>> On 18/08/23 00:03, Saravana Kannan wrote:
> >>>>> On Thu, Aug 17, 2023 at 4:37=E2=80=AFAM Shreeya Patel
> >>>>> <shreeya.patel@collabora.com> wrote:
> >>>>>> Hi Greg,
> >>>>>>
> >>>>>> On 16/08/23 20:33, Greg Kroah-Hartman wrote:
> >>>>>>> On Wed, Aug 16, 2023 at 03:09:27PM +0530, Shreeya Patel wrote:
> >>>>>>>> On 13/06/22 15:40, Greg Kroah-Hartman wrote:
> >>>>>>>>> From: Saravana Kannan<saravanak@google.com>
> >>>>>>>>>
> >>>>>>>>> [ Upstream commit 5ee76c256e928455212ab759c51d198fedbe7523 ]
> >>>>>>>>>
> >>>>>>>>> Mounting NFS rootfs was timing out when deferred_probe_timeout
> >>>>>>>>> was
> >>>>>>>>> non-zero [1].  This was because ip_auto_config() initcall
> >>>>>>>>> times out
> >>>>>>>>> waiting for the network interfaces to show up when
> >>>>>>>>> deferred_probe_timeout was non-zero. While ip_auto_config() cal=
ls
> >>>>>>>>> wait_for_device_probe() to make sure any currently running
> >>>>>>>>> deferred
> >>>>>>>>> probe work or asynchronous probe finishes, that wasn't
> >>>>>>>>> sufficient to
> >>>>>>>>> account for devices being deferred until deferred_probe_timeout=
.
> >>>>>>>>>
> >>>>>>>>> Commit 35a672363ab3 ("driver core: Ensure
> >>>>>>>>> wait_for_device_probe() waits
> >>>>>>>>> until the deferred_probe_timeout fires") tried to fix that by
> >>>>>>>>> making
> >>>>>>>>> sure wait_for_device_probe() waits for deferred_probe_timeout
> >>>>>>>>> to expire
> >>>>>>>>> before returning.
> >>>>>>>>>
> >>>>>>>>> However, if wait_for_device_probe() is called from the
> >>>>>>>>> kernel_init()
> >>>>>>>>> context:
> >>>>>>>>>
> >>>>>>>>> - Before deferred_probe_initcall() [2], it causes the boot
> >>>>>>>>> process to
> >>>>>>>>>       hang due to a deadlock.
> >>>>>>>>>
> >>>>>>>>> - After deferred_probe_initcall() [3], it blocks kernel_init()
> >>>>>>>>> from
> >>>>>>>>>       continuing till deferred_probe_timeout expires and beats
> >>>>>>>>> the point of
> >>>>>>>>>       deferred_probe_timeout that's trying to wait for
> >>>>>>>>> userspace to load
> >>>>>>>>>       modules.
> >>>>>>>>>
> >>>>>>>>> Neither of this is good. So revert the changes to
> >>>>>>>>> wait_for_device_probe().
> >>>>>>>>>
> >>>>>>>>> [1]
> >>>>>>>>> -https://lore.kernel.org/lkml/TYAPR01MB45443DF63B9EF29054F7C41F=
D8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com/
> >>>>>>>>> [2]
> >>>>>>>>> -https://lore.kernel.org/lkml/YowHNo4sBjr9ijZr@dev-arch.thelio-=
3990X/
> >>>>>>>>>
> >>>>>>>>> [3] -https://lore.kernel.org/lkml/Yo3WvGnNk3LvLb7R@linutronix.d=
e/
> >>>>>>>> Hi Saravana, Greg,
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> KernelCI found this patch causes the
> >>>>>>>> baseline.bootrr.deferred-probe-empty test to fail on
> >>>>>>>> r8a77960-ulcb,
> >>>>>>>> see the following details for more information.
> >>>>>>>>
> >>>>>>>> KernelCI dashboard link:
> >>>>>>>> https://linux.kernelci.org/test/plan/id/64d2a6be8c1a8435e535b264=
/
> >>>>>>>>
> >>>>>>>> Error messages from the logs :-
> >>>>>>>>
> >>>>>>>> + UUID=3D11236495_1.5.2.4.5
> >>>>>>>> + set +x
> >>>>>>>> + export
> >>>>>>>> 'PATH=3D/opt/bootrr/libexec/bootrr/helpers:/lava-11236495/1/../b=
in:/sbin:/usr/sbin:/bin:/usr/bin'
> >>>>>>>> + cd /opt/bootrr/libexec/bootrr
> >>>>>>>> + sh helpers/bootrr-auto
> >>>>>>>> e6800000.ethernet
> >>>>>>>> e6700000.dma-controller
> >>>>>>>> e7300000.dma-controller
> >>>>>>>> e7310000.dma-controller
> >>>>>>>> ec700000.dma-controller
> >>>>>>>> ec720000.dma-controller
> >>>>>>>> fea20000.vsp
> >>>>>>>> feb00000.display
> >>>>>>>> fea28000.vsp
> >>>>>>>> fea30000.vsp
> >>>>>>>> fe9a0000.vsp
> >>>>>>>> fe9af000.fcp
> >>>>>>>> fea27000.fcp
> >>>>>>>> fea2f000.fcp
> >>>>>>>> fea37000.fcp
> >>>>>>>> sound
> >>>>>>>> ee100000.mmc
> >>>>>>>> ee140000.mmc
> >>>>>>>> ec500000.sound
> >>>>>>>> /lava-11236495/1/../bin/lava-test-case
> >>>>>>>> <8>[   17.476741] <LAVA_SIGNAL_TESTCASE
> >>>>>>>> TEST_CASE_ID=3Ddeferred-probe-empty RESULT=3Dfail>
> >>>>>>>>
> >>>>>>>> Test case failing :-
> >>>>>>>> Baseline Bootrr deferred-probe-empty test
> >>>>>>>> -https://github.com/kernelci/bootrr/blob/main/helpers/bootrr-gen=
eric-tests
> >>>>>>>>
> >>>>>>>> Regression Reproduced :-
> >>>>>>>>
> >>>>>>>> Lava job after reverting the commit 5ee76c256e92
> >>>>>>>> https://lava.collabora.dev/scheduler/job/11292890
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> Bisection report from KernelCI can be found at the bottom of
> >>>>>>>> the email.
> >>>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> Shreeya Patel
> >>>>>>>>
> >>>>>>>> #regzbot introduced: 5ee76c256e92
> >>>>>>>> #regzbot title: KernelCI: Multiple devices deferring on
> >>>>>>>> r8a77960-ulcb
> >>>>>>>>
> >>>>>>>> ----------------------------------------------------------------=
---------------------------------------------------------------------------=
--------
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * =
**
> >>>>>>>> * If you do send a fix, please include this trailer: *
> >>>>>>>> * Reported-by: "kernelci.org bot" <bot@...> *
> >>>>>>>> * *
> >>>>>>>> * Hope this helps! *
> >>>>>>>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * =
*
> >>>>>>>>
> >>>>>>>> stable-rc/linux-5.10.y bisection:
> >>>>>>>> baseline.bootrr.deferred-probe-empty on
> >>>>>>>> r8a77960-ulcb
> >>>>>>> You are testing 5.10.y, yet the subject says 5.17?
> >>>>>>>
> >>>>>>> Which is it here?
> >>>>>> Sorry, I accidentally used the lore link for 5.17 while reporting
> >>>>>> this
> >>>>>> issue,
> >>>>>> but this test does fail on all the stable releases from 5.10
> >>>>>> onwards.
> >>>>>>
> >>>>>> stable 5.15 :-
> >>>>>> https://linux.kernelci.org/test/case/id/64dd156a5ac58d0cf335b1ea/
> >>>>>> mainline :-
> >>>>>> https://linux.kernelci.org/test/case/id/64dc13d55cb51357a135b209/
> >>>>>>
> >>>>> Shreeya, can you try the patch Geert suggested and let us know if i=
t
> >>>>> helps? If not, then I can try to take a closer look.
> >>>> I tried to test the kernel with 9be4cbd09da8 but it didn't change th=
e
> >>>> result.
> >>>> https://lava.collabora.dev/scheduler/job/11311615
> >>>>
> >>>> Also, I am not sure if this can change things but just FYI, KernelCI
> >>>> adds some kernel parameters when running these tests and one of the
> >>>> parameter is deferred_probe_timeout=3D60.
> >>> Ah this is good to know.
> >>>
> >>>> You can check this in the definition details given in the Lava job. =
I
> >>>> also tried to remove this parameter and rerun the test but again I g=
ot
> >>>> the same result.
> >>> How long does the test wait after boot before checking for the
> >>> deferred devices list?
> >>>
> >>
> >> AFAIK, script for running the tests is immediately ran after the boot
> >> process is complete so there is no wait time.
> >
> > Regardless of what the kernel is doing, it seems like a fundamentally
> > dumb test to specifically ask deferred probe to wait for up to a
> > minute then complain that it hasn't finished after 11 seconds :/
> >
> > If anything, it seems plausible that the "regression" might actually
> > be the correct behaviour, and it was wrong before. I can't manage to
> > pull up a boot log for a pre-5.10 kernel since all the async stuff on
> > the KernelCI dashboard always just times out for me with a helpful
> > "Error while loading data from the server (error code: 0)", but what
> > would be interesting is whether those devices on the list are expected
> > to successfully probe anyway - the mainline log below also shows other
> > stuff failing to probe and CPUs failing to come online, so it's
> > clearly not a very happy platform to begin with.
> >
>
> Sorry about the dashboard issues you are facing, KernelCI team is
> working on a new dashboard which will fix all of these issues. But we
> need to wait for it be ready for some more time.
>
>
> Your point makes sense and that is why we did a test to add some sleep
> time of 60-65 seconds before running the tests and it actually fixed the
> problem. There are no more deferred devices as you can see in the
> following job.
> https://lava.collabora.dev/scheduler/job/11330931
>
> This change, to add deferred_probe_timeout=3D60 as kernel parameter was
> recently added in KernelCI since there were number of devices failing to
> probe on different platforms, specifically for chromebooks.
> Unfortunately, no one realized to change the start of the test time and
> hence these issues are seen now on different platforms.
>
> Thanks for pointing it out, it will help us to eliminate quite many
> deferred probe test failures that we are seeing.
>
> Saravana, thanks to you as well for asking the valid questions about
> when the test starts running.

Glad we sorted this out. Thanks for maintaining the tests.

-Saravana
