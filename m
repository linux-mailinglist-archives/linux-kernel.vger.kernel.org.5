Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921C77512C4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjGLVvG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 17:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGLVvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:51:04 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFAC1FD8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:50:59 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5776312eaddso84629797b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689198659; x=1691790659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzyHkGqkhve+OZA0LDRPzOWpoIxl0Lehae/nyamgbdg=;
        b=LbQsPcCTuwYUaeSXeLR0MX8+JSP85/aJ3aqKRjYQLMOsZjPkJjJRyi1PcSraNnPE0v
         W0ah63gkfitpyERfTWF2/C94CKBwiQyCHVRwy/Cp4mgqTCYJBUw3zN5+wGz9u7U9jLaR
         Hp4PAX3K8XMT7C8V3KBN+B2G/KiGW0Mj3UxA9et7N8okxYmTK05GGJXdTMQTQX6Cv+GP
         S608qd3ibcig6gaZTBFEbXnObOKqv/VfzCTL8fOI0czp33uXyMmbkAA+XEtj1MW92aRb
         elGuJ2W9ddM+ZAR4bdJUoY9CmUOf5Sg+p62149k1shLUC2q1dhNqTeXEkFZDwwFnUaHo
         HPxA==
X-Gm-Message-State: ABy/qLZduGP7GjX0v7ibSmGrqzOFDG/QZSd3c/UB7BJE3mabgVgf2Hu/
        NttDv/a+u035xcXFOmiL1rgbMYjip3BsZA==
X-Google-Smtp-Source: APBJJlEJ46i9IV8gemX/E0X3MhfRzIjwfE+i3wx+4gLoMTInULfSpOSbZAJzLmkTBL7Sy4oWgAb6Yw==
X-Received: by 2002:a81:8302:0:b0:580:d073:73b9 with SMTP id t2-20020a818302000000b00580d07373b9mr1054162ywf.23.1689198658599;
        Wed, 12 Jul 2023 14:50:58 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id m4-20020a0dca04000000b00555df877a4csm1397861ywd.102.2023.07.12.14.50.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 14:50:57 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-57026f4bccaso84731097b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:50:57 -0700 (PDT)
X-Received: by 2002:a81:6603:0:b0:577:1d1c:7b94 with SMTP id
 a3-20020a816603000000b005771d1c7b94mr21098468ywc.18.1689198657071; Wed, 12
 Jul 2023 14:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230712132840.GKZK6qiK70m1O90jFL@fat_crate.local>
 <ZK6zdsIbnQFUmK69@redhat.com> <2023071200-unopposed-unbuckled-cde8@gregkh>
 <CAMw=ZnTVRaqRmtz+sDj7AeAS7xivSu+56UgKbzmuW9+K6TTx1A@mail.gmail.com>
 <2023071239-progress-molasses-3b3d@gregkh> <CAMw=ZnRheXk7W_r-32bGymbHKdXc7aKUpwGAOX+k7DJkN+DiCQ@mail.gmail.com>
 <2023071229-dusk-repacking-da3a@gregkh> <CAMw=ZnSmZTBs+bJsQ_Y2CVO8K3OTuHOZDKW4cbxKpGbo4Vgs7Q@mail.gmail.com>
 <2023071226-crafty-deviator-12e2@gregkh> <CAMw=ZnRjnxWnmoFuw2prxFS55vAGQ1hpfKeHYFfG5Oa0LB_jYA@mail.gmail.com>
 <2023071233-empirical-overturn-744c@gregkh>
In-Reply-To: <2023071233-empirical-overturn-744c@gregkh>
From:   Luca Boccassi <bluca@debian.org>
Date:   Wed, 12 Jul 2023 22:50:45 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnRRviBNi_LK9VOSUV9PNHe3jurUcLfgLpbTOsp_eE4WyA@mail.gmail.com>
Message-ID: <CAMw=ZnRRviBNi_LK9VOSUV9PNHe3jurUcLfgLpbTOsp_eE4WyA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 at 22:20, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 12, 2023 at 09:41:23PM +0100, Luca Boccassi wrote:
> > On Wed, 12 Jul 2023 at 21:07, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jul 12, 2023 at 08:35:14PM +0100, Luca Boccassi wrote:
> > > > On Wed, 12 Jul 2023 at 20:05, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Wed, Jul 12, 2023 at 07:59:12PM +0100, Luca Boccassi wrote:
> > > > > > On Wed, 12 Jul 2023 at 17:57, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > On Wed, Jul 12, 2023 at 05:23:18PM +0100, Luca Boccassi wrote:
> > > > > > > > On Wed, 12 Jul 2023 at 16:43, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Jul 12, 2023 at 03:06:46PM +0100, Daniel P. Berrangé wrote:
> > > > > > > > > > On Wed, Jul 12, 2023 at 03:28:40PM +0200, Borislav Petkov wrote:
> > > > > > > > > > > On Wed, Jul 12, 2023 at 01:48:45PM +0100, Daniel P. Berrangé wrote:
> > > > > > > > > > > > That doesn't make it useless, as the 3rd/4th/5th fields in the SBAT
> > > > > > > > > > > > file are just human targetted metadata. The validation process just
> > > > > > > > > > > > works off the 1st/2nd field.
> > > > > > > > > > >
> > > > > > > > > > > It's a good thing I asked - feels like I'm just scratching the surface
> > > > > > > > > > > on what this thing actually is and the commit message is not explaining
> > > > > > > > > > > any of that.
> > > > > > > > > > >
> > > > > > > > > > > First, second field, that's what, "linux,1"?
> > > > > > > > > >
> > > > > > > > > > Each sbat CSV file line has following fields:
> > > > > > > > > >
> > > > > > > > > >   component_name: the name we're comparing
> > > > > > > > > >   component_generation: the generation number for the comparison
> > > > > > > > > >   vendor_name: human readable vendor name
> > > > > > > > > >   vendor_package_name: human readable package name
> > > > > > > > > >   vendor_version: human readable package version (maybe machine parseable too, not specified here)
> > > > > > > > > >   vendor_url: url to look stuff up, contact, whatever.
> > > > > > > > > >
> > > > > > > > > > So 'linux' is 'component_name' and '1' is component_generation
> > > > > > > > > >
> > > > > > > > > > > > From a functional POV, it doesn't have to be unique identified,
> > > > > > > > > > > > as it is just a human targetted metadata field. A friendly git
> > > > > > > > > > > > version as from 'git describe' is more appropriate than a build
> > > > > > > > > > > > ID sha.
> > > > > > > > > > >
> > > > > > > > > > > So can you explain what exactly that version is supposed to describe?
> > > > > > > > > > > Exact kernel sources the kernel was built from? Or a random, increasing
> > > > > > > > > > > number which tools can use to mark as bad?
> > > > > > > > > >
> > > > > > > > > > AFAICT beyond being "human readable package version", it is a fairly
> > > > > > > > > > arbitrary decision. A release version number for formal releases, or
> > > > > > > > > > a 'git describe' version string for git snapshots both satisfy the
> > > > > > > > > > versioning requirement IMHO.
> > > > > > > > > >
> > > > > > > > > > > How do you prevent people from binary-editing that section? Secure boot
> > > > > > > > > > > does that because that changes the signed kernel image?
> > > > > > > > > >
> > > > > > > > > > The PE files are signed by the vendor who builds them, using their
> > > > > > > > > > SecureBoot signing key. The data covered by the signature includes
> > > > > > > > > > the '.sbat' section.
> > > > > > > > > >
> > > > > > > > > > IOW, if you binary edit the section, the SecureBoot signature
> > > > > > > > > > verification fails and the kernel won't be booted.
> > > > > > > > > >
> > > > > > > > > > > > > And then why does it have to be a separate section? All those
> > > > > > > > > > > > > requirements need to be written down.
> > > > > > > > > > >
> > > > > > > > > > > You missed this question.
> > > > > > > > > >
> > > > > > > > > > That's simply what the spec defines as the approach.
> > > > > > > > > >
> > > > > > > > > > The PE file format used by EFI applications has multiple
> > > > > > > > > > sections and the spec has declare that the '.sbat' section
> > > > > > > > > > is where this data shall live.
> > > > > > > > > >
> > > > > > > > > > > > The first line just identifies the file format and should
> > > > > > > > > > > > never change:
> > > > > > > > > > > >
> > > > > > > > > > > >   sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
> > > > > > > > > > >
> > > > > > > > > > > Why do you even need it then?
> > > > > > > > > >
> > > > > > > > > > First it identifies the data format, and second if a
> > > > > > > > > > problem is ever discovered with the  SBAT concept,
> > > > > > > > > > a fixed approach can be indicated by changing to
> > > > > > > > > > 'sbat,2,.....' and thus have the effect of revoking
> > > > > > > > > > use of any binaries which declare the 'sbat,1,....'
> > > > > > > > > > version. Pretty unlikely this will happen, but a useful
> > > > > > > > > > backup plan/safety net.
> > > > > > > > > >
> > > > > > > > > > > > The second line identifies the kernel generation
> > > > > > > > > > > >
> > > > > > > > > > > >   linux,1,The Linux Developers,linux,6.5.0-rc1,https://linux.org
> > > > > > > > > > > >
> > > > > > > > > > > > The first field 'linux' should never change once decided upon, as it is
> > > > > > > > > > > > the name of the upstream project's EFI component - in this case the
> > > > > > > > > > > > linux kernel.
> > > > > > > > > > > >
> > > > > > > > > > > > The second field '1' is the most important one, as it is the mechanism
> > > > > > > > > > > > through which revokation takes places, and the only one a human upstream
> > > > > > > > > > > > maintainer should manually change.
> > > > > > > > > > >
> > > > > > > > > > > Hold on, how often are those things going to change? And who's going to
> > > > > > > > > > > change them? I sure hope we won't start getting patches constantly
> > > > > > > > > > > updating those numbers?
> > > > > > > > > >
> > > > > > > > > > It is hard to predict the future, but my gut feeling is very infrequently.
> > > > > > > > >
> > > > > > > > > Have you looked at the past as proof of this?
> > > > > > > >
> > > > > > > > I can't quite think of relevant bugs, in the recent past. Are you
> > > > > > > > aware of past instances of kernel module signature verification being
> > > > > > > > broken? Or userspace being allowed to do arbitrary kernel memory
> > > > > > > > manipulation before ExitBootServices?
> > > > > > >
> > > > > > > Yes.
> > > > > >
> > > > > > Then you already know the answer w.r.t. frequency
> > > > >
> > > > > I have a clue, yes.  But given that others do not that are proposing
> > > > > this, that's quite worrying.
> > > >
> > > > Not really, as that's not the purpose. As the documentation clearly
> > > > states, the purpose is to have a revocation mechanism that won't
> > > > exhaust nvram space.
> > >
> > > How do you know that the list of issues will not exhaust it, if you
> > > don't know how many issues are found?
> > >
> > > Take the time and look over the past 10 years and get an idea of what
> > > you are dealing with here please.
> > >
> > > Also note that "single identifiers for individual issues" do NOT work
> > > for kernel fixes (and arguably do not work for any other software
> > > project either) as they fail to properly describe things.
> > >
> > > Think about Meltdown, one "identifier" of a CVE, and hundreds of
> > > patches.  What if you happened to not backport one of them?
> > >
> > > Same goes for the issue reported last week or so, tens of fixes, over
> > > multiple stable kernel releases, for one "identifier", how would you
> > > have classified that?
> > >
> > > Anyway, I've been over this loads before, giving whole talks about this,
> > > there's a reason the kernel developers don't mess with CVEs (i.e.
> > > individual identifiers), they fail to work.
> >
> > There is no 'single identifier for individual issues' nor CVE involved
> > here. The purpose of the generation id (which is per EFI component,
> > not per bug) is to let the boot process know whether an EFI component
> > should be accepted or rejected, in a way that doesn't exhaust nvram.
> > Issues are not individually singled out, and there is no direct
> > correlation with CVEs. It doesn't matter how many fixes there are, or
> > how many bugs, if a generation of a component is vulnerable in any way
> > that matters, then it gets denied.
>
> What does "in any way that matters" mean exactly?

It means what it says. If you don't know what matters, then it won't
be you issuing revocations (and that's ok, it won't be me either,
thank goodness).

> And are you treating the whole kernel as an "EFI component" here?

Yes, that's the scope of this problem, again this is about having a
usable alternative to DBX, it concerns signed PE payloads, and the
kernel is one of them, as a single component.

> Who is going to be responsible for determining that this number needs to
> be updated?

Most likely those who understand the problem space - largely the group
of people maintaining the EFI stack, with various inputs, I imagine.
That's how it currently works for various bootloaders.

> How are they going to determine this?

Again, very coarsely: does the current generation allow a secure boot
bypass -> revoked, else -> no change

> What is their response time?
>
> Who will they be submitting the patch to this string in order to have it
> change?

A bit too soon for exact details on processes given where we are, I think.

> And how is any of this going to interact with stable kernel releases,
> long term kernel releases and end-of-life kernel releases?

As above: does the current generation allow a secure boot bypass ->
revoked, else -> no change

> How long will this feature have to be maintained?

Until something else supplants EFI, I'd imagine

> > The only thing that matters is, "if we had infinite space in DBX and
> > sensible ways to service it and nvram didn't wear down, would we
> > blocklist this component version" - if the answer is no, then nothing
> > happens. If the answer is yes, then the counter goes up.
>
> I suggest you all take a look at the past 10 years of kernel releases
> and changes (to pick a simple number) and determine what the number
> would be now if you were to start counting then.  Is it 10?  100?
> 10000?  What do you think it will be in the next 40 years?

What do you think that would look like if it was all individual hashes
blocklisted in DBX instead? Because this is what we are talking about.
And, for the nth time, this is not about identifying individual bugs.
You do what, 3 releases a year? So 10 years time 3, then assuming
every single release you have made is completely and hopelessly broken
in different ways, but each is only discovered one at a time exactly
once per release, then the generation counter would be 30. That's your
absolutely worst case scenario. Now try to think about how hash
entries we'd need in DBX for the exact same worst case scenario, and
the reason SBAT has been implemented should become very obvious, very
quickly.

> We have a plethora of kernel changes in our history to learn from here,
> please do so and show how this will affect us going forward based on our
> past, otherwise we have no way of knowing how any of this is going to
> work.

I am not aware of anything similar enough, but please do point those
out if you are.
