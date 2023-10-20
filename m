Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13407D0C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376734AbjJTJsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376708AbjJTJsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:48:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7748C1A6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:48:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178DDC433CA
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697795325;
        bh=5hPIX5pwcYuE0uWU/V0Mnyc1Me4urH8zEE25jIYlCLk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RXUlindkpG+fkp3WU5PVzYeh+83Z0P7qcYaUDmRkOdZinCZXpXd0cbFvXSfX3q3XB
         xpifVRHs3cqMWcMN8i3ET5BWZ8HidI2dz+E0n7roFeD/OkE5qtr67S8k0v00xM4ytH
         E1DAImLABmj2KnlSAg0d+VavDuzLYuoqg/LthtLaDtXEd5WeOy2EW++43KLHfpGT3L
         lbrRbSHTP8PVRzJIzOMs2F0ajnoXFYoMvHxcfNxm3RpVmNEpycntrXJbgED+o6e5p2
         jwt21lwX2nL8BveM3PgCliU//7CvkThcUdqDvHV8pE3/on++RsbfHXh5Rp0myKrwcj
         pTEVMpF5in42Q==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-99c1c66876aso95517866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:48:44 -0700 (PDT)
X-Gm-Message-State: AOJu0YxLjgXI0wo0W3PaJdxsKOtNgBks41L8Ds8BYWY/YBjMGNv6NOWd
        llhjiMrwnlXt+RVy+a/vCBiDMXQe+nwbMmhCL2E=
X-Google-Smtp-Source: AGHT+IEynU1kFPcloYZE4jF3Lro2md200SGvSg9nTp/oH+6QsKaL6AYiLxZVPXRwoz6MeMKfJme35HRqmE52N12hU2o=
X-Received: by 2002:a17:907:1b0a:b0:9c7:5a01:ffe8 with SMTP id
 mp10-20020a1709071b0a00b009c75a01ffe8mr685785ejc.29.1697795323494; Fri, 20
 Oct 2023 02:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <7c50e051-eba2-09fc-da9f-023d592de457@ristioja.ee>
 <31bdf7b1-0ed9-4217-b459-1d857e53120b@leemhuis.info> <CAAhV-H7fRpykesVUEyaTpVnFiGwpP+fPbtdrp6JwfgD=bDp06Q@mail.gmail.com>
 <CAAhV-H7XCmbgS=N4-SE8FnASAws8hnDRZsQJgXE+dwyARaqzNw@mail.gmail.com>
 <ZSO9uArAtsPMPeTP@debian.me> <CAAhV-H5GbidUx8YanUc7S9oGqBkDd53xeT=2O4aCuX7KpM-+8A@mail.gmail.com>
 <c9b79a69-bdc1-4457-900d-709a15d99568@leemhuis.info>
In-Reply-To: <c9b79a69-bdc1-4457-900d-709a15d99568@leemhuis.info>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 20 Oct 2023 17:48:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4qQW_fOdkTxmT1xbvo4LOapzw_tOw7Kma47xmh0PvpPA@mail.gmail.com>
Message-ID: <CAAhV-H4qQW_fOdkTxmT1xbvo4LOapzw_tOw7Kma47xmh0PvpPA@mail.gmail.com>
Subject: Re: Blank screen on boot of Linux 6.5 and later on Lenovo ThinkPad L570
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jaak Ristioja <jaak@ristioja.ee>,
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 5:35=E2=80=AFPM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 09.10.23 10:54, Huacai Chen wrote:
> > On Mon, Oct 9, 2023 at 4:45=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.=
com> wrote:
> >> On Mon, Oct 09, 2023 at 09:27:02AM +0800, Huacai Chen wrote:
> >>> On Tue, Sep 26, 2023 at 10:31=E2=80=AFPM Huacai Chen <chenhuacai@kern=
el.org> wrote:
> >>>> On Tue, Sep 26, 2023 at 7:15=E2=80=AFPM Linux regression tracking (T=
horsten
> >>>> Leemhuis) <regressions@leemhuis.info> wrote:
> >>>>> On 13.09.23 14:02, Jaak Ristioja wrote:
> >>>>>>
> >>>>>> Upgrading to Linux 6.5 on a Lenovo ThinkPad L570 (Integrated Intel=
 HD
> >>>>>> Graphics 620 (rev 02), Intel(R) Core(TM) i7-7500U) results in a bl=
ank
> >>>>>> screen after boot until the display manager starts... if it does s=
tart
> >>>>>> at all. Using the nomodeset kernel parameter seems to be a workaro=
und.
> >>>>>>
> >>>>>> I've bisected this to commit 60aebc9559492cea6a9625f514a8041717e3a=
2e4
> >>>>>> ("drivers/firmware: Move sysfb_init() from device_initcall to
> >>>>>> subsys_initcall_sync").
> >>>>>
> >>>>> Hmmm, no reaction since it was posted a while ago, unless I'm missi=
ng
> >>>>> something.
> >>>>>
> >>>>> Huacai Chen, did you maybe miss this report? The problem is apparen=
tly
> >>>>> caused by a commit of yours (that Javier applied), you hence should=
 look
> >>>>> into this.
> >>>> I'm sorry but it looks very strange, could you please share your con=
fig file?
> >>> As confirmed by Jaak, disabling DRM_SIMPLEDRM makes things work fine
> >>> again. So I guess the reason:
> >>
> >> Did Jaak reply privately? It should have been disclosed in public
> >> ML here instead.
> > Yes, he replied privately, and disabling DRM_SIMPLEDRM was suggested by=
 me.
>
> Well, this to me still looks a lot (please correct me if I'm wrong) like
> regression that should be fixed, as DRM_SIMPLEDRM was enabled beforehand
> if I understood things correctly. Or is there a proper fix for this
> already in the works and I just missed this? Or is there some good
> reason why this won't/can't be fixed?
DRM_SIMPLEDRM was enabled but it didn't work at all because there was
no corresponding platform device. Now DRM_SIMPLEDRM works but it has a
blank screen. Of course it is valuable to investigate further about
DRM_SIMPLEDRM on Jaak's machine, but that needs Jaak's effort because
I don't have a same machine.

Huacai
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot poke
>
> >>> When SIMPLEDRM takes over the framebuffer, the screen is blank (don't
> >>> know why). And before 60aebc9559492cea6a9625f ("drivers/firmware: Mov=
e
> >>> sysfb_init() from device_initcall to subsys_initcall_sync") there is
> >>> no platform device created for SIMPLEDRM at early stage, so it seems
> >>> also "no problem".
> >>
> >> I don't understand above. You mean that after that commit the platform
> >> device is also none, right?
> > No. The SIMPLEDRM driver needs a platform device to work, and that
> > commit makes the platform device created earlier. So, before that
> > commit, SIMPLEDRM doesn't work, but the screen isn't blank; after that
> > commit, SIMPLEDRM works, but the screen is blank.
> >
> > Huacai
> >>
> >> Confused...
> >>
> >> --
> >> An old man doll... just what I always wanted! - Clara
> >
> >
