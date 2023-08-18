Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14548781441
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 22:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379962AbjHRUUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 16:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379938AbjHRUU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:20:26 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E40359D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 13:20:23 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40a47e8e38dso18231cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 13:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692390023; x=1692994823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJivKRUQVufG/gPmQeTicJgOw5YOtNiOedA2X8vU9zE=;
        b=G3VGxR5zQ/wn8bs1jFo/t0VmyFqMoOtDmLslbRIHJk21UrHdZY8HT8PexNES69U8cc
         COydRhoSc2QngvCduPSEVYlodpuas9ObmPtUWW122HK8lZTSSCvjoy30H7lDXADy4EXV
         5C1siSFS37lpkbu/yoolDQK8T/bXCB7/7pnZ0E7eraoK1ikRGty5FCbdgH7oR8AYFbS+
         zO7O/LqS2xLH9BzUgKyBFydjigHDw9QQKSK25RA/gnWIpbLhEJlj3WcgLwP+XBVe17Mq
         cO5v1MaDpawx4RoM46uQ94x3vozEKXF6MjTydtMTTAlt+XTyWdZlDPZbjfwvbnNnRpqG
         qmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692390023; x=1692994823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJivKRUQVufG/gPmQeTicJgOw5YOtNiOedA2X8vU9zE=;
        b=XKiV6ULdEhxzFpHnUms/hLabcm8ffGh09UV2m/ZH0X7K+XkkMFgLl1KEU1ulyr2//d
         yt6y3BVI3LOIJIPE2muwrU7vw9Dk3SuZdSuQhyCgYqA2tTuL67+u9Trj6jM4+3lfM5n2
         Zc0VDPt96f75Lh9RpBxmRLRY+v15lSoZF0avAHjSRsphURG96J9/FiYRSCGHj3oBi9Cj
         z1MtAgBg2C7I5J+tkgWLoyBZy1ZsgoW04zDUXBR4u3K1n4qxVYMfP9N41EaN8Eakrh2d
         qN8qfCvboGVwG+mgOOaO/cLueS9cyT98Cib2+VQgCYfhdxkKveDfA1zpUa75ER8B76+8
         AA/Q==
X-Gm-Message-State: AOJu0YwdquqOwdbafyORHrGS9BLdJ/nax/ynFwRkBFo+P0TwvV9UN8QC
        g8uN8qhjPGkPsSFP+mCzD+zaC7qXIlS2k07tK2oVRg==
X-Google-Smtp-Source: AGHT+IEhwnsWoqhjrCcucUjO6z8QLTGzlIDf8prugA9O2RpP4srmVZqsJbmCcbZ5tZ9oWV31HG4wWi04/nNC4NUYdz4=
X-Received: by 2002:ac8:5782:0:b0:40f:d1f4:aa58 with SMTP id
 v2-20020ac85782000000b0040fd1f4aa58mr288786qta.8.1692390022713; Fri, 18 Aug
 2023 13:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220613094924.913340374@linuxfoundation.org> <20220613094928.793712131@linuxfoundation.org>
 <6283c4b1-2513-207d-4ed6-fdabf3f3880e@collabora.com> <2023081619-slapping-congrats-8e85@gregkh>
 <471bf84d-9d58-befc-8224-359a62e29786@collabora.com> <CAGETcx-NVoN7b8XCV09ouof81XxZk4wtGhEcqcFAt6Gs=JWKdw@mail.gmail.com>
 <d8f8ddf6-8063-fb3a-7dad-4064a47c5fe8@collabora.com>
In-Reply-To: <d8f8ddf6-8063-fb3a-7dad-4064a47c5fe8@collabora.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 18 Aug 2023 13:19:46 -0700
Message-ID: <CAGETcx-DUm417mM-Nmyqj-e_rKUw69m=rTe5R6_Vxd_rsKMmGg@mail.gmail.com>
Subject: Re: [PATCH 5.17 127/298] driver core: Fix wait_for_device_probe() &
 deferred_probe_timeout interaction
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Stultz <jstultz@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Robin Murphy <robin.murphy@arm.com>,
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

On Thu, Aug 17, 2023 at 4:13=E2=80=AFPM Shreeya Patel
<shreeya.patel@collabora.com> wrote:
>
> Hi Geert, Saravana,
>
> On 18/08/23 00:03, Saravana Kannan wrote:
> > On Thu, Aug 17, 2023 at 4:37=E2=80=AFAM Shreeya Patel
> > <shreeya.patel@collabora.com> wrote:
> >> Hi Greg,
> >>
> >> On 16/08/23 20:33, Greg Kroah-Hartman wrote:
> >>> On Wed, Aug 16, 2023 at 03:09:27PM +0530, Shreeya Patel wrote:
> >>>> On 13/06/22 15:40, Greg Kroah-Hartman wrote:
> >>>>> From: Saravana Kannan<saravanak@google.com>
> >>>>>
> >>>>> [ Upstream commit 5ee76c256e928455212ab759c51d198fedbe7523 ]
> >>>>>
> >>>>> Mounting NFS rootfs was timing out when deferred_probe_timeout was
> >>>>> non-zero [1].  This was because ip_auto_config() initcall times out
> >>>>> waiting for the network interfaces to show up when
> >>>>> deferred_probe_timeout was non-zero. While ip_auto_config() calls
> >>>>> wait_for_device_probe() to make sure any currently running deferred
> >>>>> probe work or asynchronous probe finishes, that wasn't sufficient t=
o
> >>>>> account for devices being deferred until deferred_probe_timeout.
> >>>>>
> >>>>> Commit 35a672363ab3 ("driver core: Ensure wait_for_device_probe() w=
aits
> >>>>> until the deferred_probe_timeout fires") tried to fix that by makin=
g
> >>>>> sure wait_for_device_probe() waits for deferred_probe_timeout to ex=
pire
> >>>>> before returning.
> >>>>>
> >>>>> However, if wait_for_device_probe() is called from the kernel_init(=
)
> >>>>> context:
> >>>>>
> >>>>> - Before deferred_probe_initcall() [2], it causes the boot process =
to
> >>>>>      hang due to a deadlock.
> >>>>>
> >>>>> - After deferred_probe_initcall() [3], it blocks kernel_init() from
> >>>>>      continuing till deferred_probe_timeout expires and beats the p=
oint of
> >>>>>      deferred_probe_timeout that's trying to wait for userspace to =
load
> >>>>>      modules.
> >>>>>
> >>>>> Neither of this is good. So revert the changes to
> >>>>> wait_for_device_probe().
> >>>>>
> >>>>> [1] -https://lore.kernel.org/lkml/TYAPR01MB45443DF63B9EF29054F7C41F=
D8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com/
> >>>>> [2] -https://lore.kernel.org/lkml/YowHNo4sBjr9ijZr@dev-arch.thelio-=
3990X/
> >>>>> [3] -https://lore.kernel.org/lkml/Yo3WvGnNk3LvLb7R@linutronix.de/
> >>>> Hi Saravana, Greg,
> >>>>
> >>>>
> >>>> KernelCI found this patch causes the baseline.bootrr.deferred-probe-=
empty test to fail on r8a77960-ulcb,
> >>>> see the following details for more information.
> >>>>
> >>>> KernelCI dashboard link:
> >>>> https://linux.kernelci.org/test/plan/id/64d2a6be8c1a8435e535b264/
> >>>>
> >>>> Error messages from the logs :-
> >>>>
> >>>> + UUID=3D11236495_1.5.2.4.5
> >>>> + set +x
> >>>> + export 'PATH=3D/opt/bootrr/libexec/bootrr/helpers:/lava-11236495/1=
/../bin:/sbin:/usr/sbin:/bin:/usr/bin'
> >>>> + cd /opt/bootrr/libexec/bootrr
> >>>> + sh helpers/bootrr-auto
> >>>> e6800000.ethernet
> >>>> e6700000.dma-controller
> >>>> e7300000.dma-controller
> >>>> e7310000.dma-controller
> >>>> ec700000.dma-controller
> >>>> ec720000.dma-controller
> >>>> fea20000.vsp
> >>>> feb00000.display
> >>>> fea28000.vsp
> >>>> fea30000.vsp
> >>>> fe9a0000.vsp
> >>>> fe9af000.fcp
> >>>> fea27000.fcp
> >>>> fea2f000.fcp
> >>>> fea37000.fcp
> >>>> sound
> >>>> ee100000.mmc
> >>>> ee140000.mmc
> >>>> ec500000.sound
> >>>> /lava-11236495/1/../bin/lava-test-case
> >>>> <8>[   17.476741] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddeferred-prob=
e-empty RESULT=3Dfail>
> >>>>
> >>>> Test case failing :-
> >>>> Baseline Bootrr deferred-probe-empty test -https://github.com/kernel=
ci/bootrr/blob/main/helpers/bootrr-generic-tests
> >>>>
> >>>> Regression Reproduced :-
> >>>>
> >>>> Lava job after reverting the commit 5ee76c256e92
> >>>> https://lava.collabora.dev/scheduler/job/11292890
> >>>>
> >>>>
> >>>> Bisection report from KernelCI can be found at the bottom of the ema=
il.
> >>>>
> >>>> Thanks,
> >>>> Shreeya Patel
> >>>>
> >>>> #regzbot introduced: 5ee76c256e92
> >>>> #regzbot title: KernelCI: Multiple devices deferring on r8a77960-ulc=
b
> >>>>
> >>>> --------------------------------------------------------------------=
---------------------------------------------------------------------------=
----
> >>>>
> >>>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * **
> >>>> * If you do send a fix, please include this trailer: *
> >>>> * Reported-by: "kernelci.org bot" <bot@...> *
> >>>> * *
> >>>> * Hope this helps! *
> >>>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> >>>>
> >>>> stable-rc/linux-5.10.y bisection: baseline.bootrr.deferred-probe-emp=
ty on
> >>>> r8a77960-ulcb
> >>> You are testing 5.10.y, yet the subject says 5.17?
> >>>
> >>> Which is it here?
> >> Sorry, I accidentally used the lore link for 5.17 while reporting this
> >> issue,
> >> but this test does fail on all the stable releases from 5.10 onwards.
> >>
> >> stable 5.15 :-
> >> https://linux.kernelci.org/test/case/id/64dd156a5ac58d0cf335b1ea/
> >> mainline :-
> >> https://linux.kernelci.org/test/case/id/64dc13d55cb51357a135b209/
> >>
> > Shreeya, can you try the patch Geert suggested and let us know if it
> > helps? If not, then I can try to take a closer look.
>
> I tried to test the kernel with 9be4cbd09da8 but it didn't change the
> result.
> https://lava.collabora.dev/scheduler/job/11311615
>
> Also, I am not sure if this can change things but just FYI, KernelCI
> adds some kernel parameters when running these tests and one of the
> parameter is deferred_probe_timeout=3D60.

Ah this is good to know.

> You can check this in the definition details given in the Lava job. I
> also tried to remove this parameter and rerun the test but again I got
> the same result.

How long does the test wait after boot before checking for the
deferred devices list?

> I will try to add 9be4cbd09da8 to mainline kernel and see what results I
> get.

Now I'm confused. What do you mean by mainline? Are you saying the tip
of tree of Linus's tree is also hitting this issue?

-Saravana
