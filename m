Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8F47D79E0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 02:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjJZA6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 20:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjJZA6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 20:58:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0784136
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:58:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56E9C433CA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698281909;
        bh=DkeMVHQTwqHPkZCBmMyFQJiD0l2SV8/DrHGVDUxDcgA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qi84bvidwho9O+RuWOkqnNfuZY6G/rPh2FBDMMpecNEQdE2Cxjw5I1PvvGjpc77jE
         0ezB7QZMLQw5L4EZ4DeUQ6WyzgikQJuUoOv3e2KYdjL//1Tu9drQCqUqSCFzUUu+w0
         gN6ItEFOZJzbd5DNFtj/TaY2B7tFXEDHJIu9W0tJ+GJPI7K83FFspUFXOOmHp/ryi/
         u185kj5IF+TCtnjMgdtDxxlGqfP3sII8ezZ9za0aeOTB9Dq/VF4dU+zYO+XaxKgiMt
         qPlFynu+sc0oN37ppOxMRYvC/j6mIVgH69qYX6cTbXvQ5GOrZCmuApe8DOXpzPPZCU
         HsYqD5iu/pAmQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso446507a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:58:29 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx1cWJNBjm1kffeuPMCMoQKXtLwxl9nOvtmMAVnNl6biOege8mv
        AlBp0EU4GKd1BplY6Uzg3W43Zr0F8UIc2E6M1Og=
X-Google-Smtp-Source: AGHT+IFQNbdFKIMr/pC0MGklXxtlajx5n2H7h8L6DhFOvIJSNkXZmdDuG0auEc6tkz7AjOC6nnisP99r+mVq0KP01Is=
X-Received: by 2002:a50:aa9b:0:b0:53e:1f7d:10f2 with SMTP id
 q27-20020a50aa9b000000b0053e1f7d10f2mr11930371edc.10.1698281908233; Wed, 25
 Oct 2023 17:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <7c50e051-eba2-09fc-da9f-023d592de457@ristioja.ee>
 <31bdf7b1-0ed9-4217-b459-1d857e53120b@leemhuis.info> <CAAhV-H7fRpykesVUEyaTpVnFiGwpP+fPbtdrp6JwfgD=bDp06Q@mail.gmail.com>
 <CAAhV-H7XCmbgS=N4-SE8FnASAws8hnDRZsQJgXE+dwyARaqzNw@mail.gmail.com>
 <ZSO9uArAtsPMPeTP@debian.me> <CAAhV-H5GbidUx8YanUc7S9oGqBkDd53xeT=2O4aCuX7KpM-+8A@mail.gmail.com>
 <c9b79a69-bdc1-4457-900d-709a15d99568@leemhuis.info> <CAAhV-H4qQW_fOdkTxmT1xbvo4LOapzw_tOw7Kma47xmh0PvpPA@mail.gmail.com>
 <ZTWoDSPxGO-ApR4r@P70.localdomain> <82f1b533-3bd8-4418-843a-718d9a6b5786@leemhuis.info>
 <CAAhV-H5DH3Oj3ttSpa_k6jUdZ+0_pMwgoaqUTGGFr46j7DMXRw@mail.gmail.com> <ba16ad66-4b35-4fb4-b4e6-1d785f260eea@ristioja.ee>
In-Reply-To: <ba16ad66-4b35-4fb4-b4e6-1d785f260eea@ristioja.ee>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 26 Oct 2023 08:58:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H64AKdGoHnVLLOYXznpr_aq1jC_TUYXFQRdOjoBxanxkw@mail.gmail.com>
Message-ID: <CAAhV-H64AKdGoHnVLLOYXznpr_aq1jC_TUYXFQRdOjoBxanxkw@mail.gmail.com>
Subject: Re: Blank screen on boot of Linux 6.5 and later on Lenovo ThinkPad L570
To:     Jaak Ristioja <jaak@ristioja.ee>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Evan Preston <x.arch@epreston.net>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jaak,

On Thu, Oct 26, 2023 at 2:49=E2=80=AFAM Jaak Ristioja <jaak@ristioja.ee> wr=
ote:
>
> On 25.10.23 16:23, Huacai Chen wrote:
> > On Wed, Oct 25, 2023 at 6:08=E2=80=AFPM Thorsten Leemhuis
> > <regressions@leemhuis.info> wrote:
> >>
> >> Javier, Dave, Sima,
> >>
> >> On 23.10.23 00:54, Evan Preston wrote:
> >>> On 2023-10-20 Fri 05:48pm, Huacai Chen wrote:
> >>>> On Fri, Oct 20, 2023 at 5:35=E2=80=AFPM Linux regression tracking (T=
horsten
> >>>> Leemhuis) <regressions@leemhuis.info> wrote:
> >>>>> On 09.10.23 10:54, Huacai Chen wrote:
> >>>>>> On Mon, Oct 9, 2023 at 4:45=E2=80=AFPM Bagas Sanjaya <bagasdotme@g=
mail.com> wrote:
> >>>>>>> On Mon, Oct 09, 2023 at 09:27:02AM +0800, Huacai Chen wrote:
> >>>>>>>> On Tue, Sep 26, 2023 at 10:31=E2=80=AFPM Huacai Chen <chenhuacai=
@kernel.org> wrote:
> >>>>>>>>> On Tue, Sep 26, 2023 at 7:15=E2=80=AFPM Linux regression tracki=
ng (Thorsten
> >>>>>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
> >>>>>>>>>> On 13.09.23 14:02, Jaak Ristioja wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> Upgrading to Linux 6.5 on a Lenovo ThinkPad L570 (Integrated =
Intel HD
> >>>>>>>>>>> Graphics 620 (rev 02), Intel(R) Core(TM) i7-7500U) results in=
 a blank
> >>>>>>>>>>> screen after boot until the display manager starts... if it d=
oes start
> >>>>>>>>>>> at all. Using the nomodeset kernel parameter seems to be a wo=
rkaround.
> >>>>>>>>>>>
> >>>>>>>>>>> I've bisected this to commit 60aebc9559492cea6a9625f514a80417=
17e3a2e4
> >>>>>>>>>>> ("drivers/firmware: Move sysfb_init() from device_initcall to
> >>>>>>>>>>> subsys_initcall_sync").
> >>>>>>>>>>
> >>>>>>>> As confirmed by Jaak, disabling DRM_SIMPLEDRM makes things work =
fine
> >>>>>>>> again. So I guess the reason:
> >>>>>
> >>>>> Well, this to me still looks a lot (please correct me if I'm wrong)=
 like
> >>>>> regression that should be fixed, as DRM_SIMPLEDRM was enabled befor=
ehand
> >>>>> if I understood things correctly. Or is there a proper fix for this
> >>>>> already in the works and I just missed this? Or is there some good
> >>>>> reason why this won't/can't be fixed?
> >>>>
> >>>> DRM_SIMPLEDRM was enabled but it didn't work at all because there wa=
s
> >>>> no corresponding platform device. Now DRM_SIMPLEDRM works but it has=
 a
> >>>> blank screen. Of course it is valuable to investigate further about
> >>>> DRM_SIMPLEDRM on Jaak's machine, but that needs Jaak's effort becaus=
e
> >>>> I don't have a same machine.
> >>
> >> Side note: Huacai, have you tried working with Jaak to get down to the
> >> real problem? Evan, might you be able to help out here?
> > No, Jaak has no response after he 'fixed' his problem by disabling SIMP=
LEDRM.
> >
>
> I'm sorry, what was it exactly you want me to do? Please be mindful that
> I'm not familiar with the internals of the Linux kernel and DRI, and it
> might sometimes take weeks before I have time to work and respond on this=
.
It doesn't matter. I hope you can do some experiments to investigate
deeper. The first experiment you can do is enabling SIMPLEFB (i.e.
CONFIG_FB_SIMPLE) instead of SIMPLEDRM (CONFIG_DRM_SIMPLEDRM) to see
whether there is also a blank screen. If no blank screen, that
probably means SIMPLEDRM has a bug, if still blank screen, that means
the firmware may pass wrong screen information.

Huacai

>
> Jaak
>
> >>
> >> But I write this mail for a different reason:
> >>
> >>> I am having the same issue on a Lenovo Thinkpad P70 (Intel
> >>> Corporation HD Graphics 530 (rev 06), Intel(R) Core(TM) i7-6700HQ).
> >>> Upgrading from Linux 6.4.12 to 6.5 and later results in only a blank
> >>> screen after boot and a rapidly flashing device-access-status
> >>> indicator.
> >>
> >> This additional report makes me wonder if we should revert the culprit
> >> (60aebc9559492c ("drivers/firmware: Move sysfb_init() from
> >> device_initcall to subsys_initcall_sync") [v6.5-rc1]). But I guess tha=
t
> >> might lead to regressions for some users? But the patch description sa=
ys
> >> that this is not a common configuration, so can we maybe get away with=
 that?
> >  From my point of view, this is not a regression, 60aebc9559492c
> > doesn't cause a problem, but exposes a problem. So we need to fix the
> > real problem (SIMPLEDRM has a blank screen on some conditions). This
> > needs Jaak or Evan's help.
> >
> > Huacai
> >>
> >> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' ha=
t)
> >> --
> >> Everything you wanna know about Linux kernel regression tracking:
> >> https://linux-regtracking.leemhuis.info/about/#tldr
> >> If I did something stupid, please tell me, as explained on that page.
> >>
> >>>>>>>> When SIMPLEDRM takes over the framebuffer, the screen is blank (=
don't
> >>>>>>>> know why). And before 60aebc9559492cea6a9625f ("drivers/firmware=
: Move
> >>>>>>>> sysfb_init() from device_initcall to subsys_initcall_sync") ther=
e is
> >>>>>>>> no platform device created for SIMPLEDRM at early stage, so it s=
eems
> >>>>>>>> also "no problem".
> >>>>>>> I don't understand above. You mean that after that commit the pla=
tform
> >>>>>>> device is also none, right?
> >>>>>> No. The SIMPLEDRM driver needs a platform device to work, and that
> >>>>>> commit makes the platform device created earlier. So, before that
> >>>>>> commit, SIMPLEDRM doesn't work, but the screen isn't blank; after =
that
> >>>>>> commit, SIMPLEDRM works, but the screen is blank.
> >>>>>>
> >>>>>> Huacai
> >>>>>>>
> >>>>>>> Confused...
> >>>>>>>
> >>>>>>> --
> >>>>>>> An old man doll... just what I always wanted! - Clara
> >>>>>>
> >>>>>>
> >>>
> >>>
>
