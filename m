Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33127510D2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjGLS7c convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 14:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGLS7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:59:30 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B879EA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:59:27 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-579ef51428eso85381617b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689188366; x=1691780366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMMYzW9XpCdfm5CViIxl1J1BzRy0TeapxX2MT2ii7Tk=;
        b=eNZL95AmJYkpvqCIustoqdUeZ9XkPxTH3D4Ucd9L9X9IwwCK4wH2h6HRpcRaA9oFj6
         2G/mMqqtJ/pWnqzG4XMs1dngMsIbjKwDZzI0hEBNe+TrGjcZGe6pRsia9AeM2Olp9+l1
         6VnJT2rMh6p7LBTJ6yC3LqIEHFtt/qLxK9vZjVnPOY9XH2UYGjCYBueSQdmfJsZ10fLY
         dloN89xUL7Qw522iRjiZBDXcCGtJsiWw/JzS/DOvnTgGEWeGFAsFJxn5pVY4NxAx+ZMf
         nLI95jvD0UWUK8NAkUokj8uX9WlNnR5LlrgXAKRnTQF541u6LH9Ssd3AbOJdyfFwQ+zA
         t2Aw==
X-Gm-Message-State: ABy/qLYFXRjHlI8HssNoM5UfqB2LRMPtJ9IyvF8XfvkQGyn9EHKxVvm5
        ULPtOGqaws/NBhQszJhrM0865QKhzVE9uA==
X-Google-Smtp-Source: APBJJlERt4eZ6bgT1QEnwiQB+yR1Im/HS7RLO0LMhJEF253tb8WyJw23U2l0bgM+y0dR732YbzLGcA==
X-Received: by 2002:a81:8401:0:b0:561:cb45:d7de with SMTP id u1-20020a818401000000b00561cb45d7demr20249055ywf.31.1689188366571;
        Wed, 12 Jul 2023 11:59:26 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id i134-20020a816d8c000000b00577139f85dfsm1323507ywc.22.2023.07.12.11.59.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 11:59:25 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-57712d00cc1so85267647b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:59:25 -0700 (PDT)
X-Received: by 2002:a0d:d4c2:0:b0:56d:4d17:99b0 with SMTP id
 w185-20020a0dd4c2000000b0056d4d1799b0mr22939040ywd.10.1689188364775; Wed, 12
 Jul 2023 11:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230711154449.1378385-1-eesposit@redhat.com> <7E9D397B-439F-484C-B950-9094605A7B4D@zytor.com>
 <5e01b6a5-f993-f99d-41a0-ab671ec598f8@redhat.com> <20230712120002.GIZK6Vwga6DlJqdjEh@fat_crate.local>
 <ZK6hLZcuAH9jXKuL@redhat.com> <20230712132840.GKZK6qiK70m1O90jFL@fat_crate.local>
 <ZK6zdsIbnQFUmK69@redhat.com> <2023071200-unopposed-unbuckled-cde8@gregkh>
 <CAMw=ZnTVRaqRmtz+sDj7AeAS7xivSu+56UgKbzmuW9+K6TTx1A@mail.gmail.com> <2023071239-progress-molasses-3b3d@gregkh>
In-Reply-To: <2023071239-progress-molasses-3b3d@gregkh>
From:   Luca Boccassi <bluca@debian.org>
Date:   Wed, 12 Jul 2023 19:59:12 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnRheXk7W_r-32bGymbHKdXc7aKUpwGAOX+k7DJkN+DiCQ@mail.gmail.com>
Message-ID: <CAMw=ZnRheXk7W_r-32bGymbHKdXc7aKUpwGAOX+k7DJkN+DiCQ@mail.gmail.com>
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

On Wed, 12 Jul 2023 at 17:57, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 12, 2023 at 05:23:18PM +0100, Luca Boccassi wrote:
> > On Wed, 12 Jul 2023 at 16:43, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jul 12, 2023 at 03:06:46PM +0100, Daniel P. Berrangé wrote:
> > > > On Wed, Jul 12, 2023 at 03:28:40PM +0200, Borislav Petkov wrote:
> > > > > On Wed, Jul 12, 2023 at 01:48:45PM +0100, Daniel P. Berrangé wrote:
> > > > > > That doesn't make it useless, as the 3rd/4th/5th fields in the SBAT
> > > > > > file are just human targetted metadata. The validation process just
> > > > > > works off the 1st/2nd field.
> > > > >
> > > > > It's a good thing I asked - feels like I'm just scratching the surface
> > > > > on what this thing actually is and the commit message is not explaining
> > > > > any of that.
> > > > >
> > > > > First, second field, that's what, "linux,1"?
> > > >
> > > > Each sbat CSV file line has following fields:
> > > >
> > > >   component_name: the name we're comparing
> > > >   component_generation: the generation number for the comparison
> > > >   vendor_name: human readable vendor name
> > > >   vendor_package_name: human readable package name
> > > >   vendor_version: human readable package version (maybe machine parseable too, not specified here)
> > > >   vendor_url: url to look stuff up, contact, whatever.
> > > >
> > > > So 'linux' is 'component_name' and '1' is component_generation
> > > >
> > > > > > From a functional POV, it doesn't have to be unique identified,
> > > > > > as it is just a human targetted metadata field. A friendly git
> > > > > > version as from 'git describe' is more appropriate than a build
> > > > > > ID sha.
> > > > >
> > > > > So can you explain what exactly that version is supposed to describe?
> > > > > Exact kernel sources the kernel was built from? Or a random, increasing
> > > > > number which tools can use to mark as bad?
> > > >
> > > > AFAICT beyond being "human readable package version", it is a fairly
> > > > arbitrary decision. A release version number for formal releases, or
> > > > a 'git describe' version string for git snapshots both satisfy the
> > > > versioning requirement IMHO.
> > > >
> > > > > How do you prevent people from binary-editing that section? Secure boot
> > > > > does that because that changes the signed kernel image?
> > > >
> > > > The PE files are signed by the vendor who builds them, using their
> > > > SecureBoot signing key. The data covered by the signature includes
> > > > the '.sbat' section.
> > > >
> > > > IOW, if you binary edit the section, the SecureBoot signature
> > > > verification fails and the kernel won't be booted.
> > > >
> > > > > > > And then why does it have to be a separate section? All those
> > > > > > > requirements need to be written down.
> > > > >
> > > > > You missed this question.
> > > >
> > > > That's simply what the spec defines as the approach.
> > > >
> > > > The PE file format used by EFI applications has multiple
> > > > sections and the spec has declare that the '.sbat' section
> > > > is where this data shall live.
> > > >
> > > > > > The first line just identifies the file format and should
> > > > > > never change:
> > > > > >
> > > > > >   sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
> > > > >
> > > > > Why do you even need it then?
> > > >
> > > > First it identifies the data format, and second if a
> > > > problem is ever discovered with the  SBAT concept,
> > > > a fixed approach can be indicated by changing to
> > > > 'sbat,2,.....' and thus have the effect of revoking
> > > > use of any binaries which declare the 'sbat,1,....'
> > > > version. Pretty unlikely this will happen, but a useful
> > > > backup plan/safety net.
> > > >
> > > > > > The second line identifies the kernel generation
> > > > > >
> > > > > >   linux,1,The Linux Developers,linux,6.5.0-rc1,https://linux.org
> > > > > >
> > > > > > The first field 'linux' should never change once decided upon, as it is
> > > > > > the name of the upstream project's EFI component - in this case the
> > > > > > linux kernel.
> > > > > >
> > > > > > The second field '1' is the most important one, as it is the mechanism
> > > > > > through which revokation takes places, and the only one a human upstream
> > > > > > maintainer should manually change.
> > > > >
> > > > > Hold on, how often are those things going to change? And who's going to
> > > > > change them? I sure hope we won't start getting patches constantly
> > > > > updating those numbers?
> > > >
> > > > It is hard to predict the future, but my gut feeling is very infrequently.
> > >
> > > Have you looked at the past as proof of this?
> >
> > I can't quite think of relevant bugs, in the recent past. Are you
> > aware of past instances of kernel module signature verification being
> > broken? Or userspace being allowed to do arbitrary kernel memory
> > manipulation before ExitBootServices?
>
> Yes.

Then you already know the answer w.r.t. frequency

> And no, I will not provide examples for obvious reasons.

Security-through-obscurity? Nice!

> > > > I can't say I recall any specific Linux bugs that would warrant it, but
> > > > those involved in Linux/Bootloade/SecureBoot world can probably answer
> > > > this better than me. IIUC, the scope of bugs relevent to this is quite
> > > > narrow.
> > >
> > > Really?  I know a lot of people who would disagree...
> >
> > They'd better have some convincing reasons
> >
> > > > > > If there is discovered a flaw in Linux that allows the Secure Boot chain
> > > > > > to be broken (eg some flaw allowed linux to be exploited as a mechanism
> > > > > > to load an unsigned binary), then this 'generation' number would need
> > > > > > to be incremented when a fix is provided in upstream Linux trees.
> > > > >
> > > > > Oh boy, there it is. And then when those fixes need to be backported to
> > > > > stable, then those patches updating that number would need to be
> > > > > backported too. I can already see the mess on the horizon.
> > > >
> > > > If applicable, yes.
> > >
> > > And how are you going to determine this?
> >
> > Same as it's done for the bootloaders - does it enable a secure boot
> > bypass -> yes/no
>
> And how are you going to determine this?  Seriously, please explain the
> auditing you are going to do here and who is going to maintain it and
> fund the effort?

Same way it is determined for Shim, Grub, sd-boot, Windows BootMngr,
etc - maintainers doing their jobs, researchers poking at them, or if
we are particularly unlucky by live exploits in the wild. I'm not
exactly sure where the confusion comes from, none of this is novel.

> > > > > > The SBAT config for shim would be updated to say 'linux,2' was the new
> > > > > > baseline, at which point it would refuse to load any binaries that still
> > > > > > had 'linux,1' in their sbat PE section.
> > > > >
> > > > > Ok, I fetch the latest upstream kernel, it has "linux,1", shim refuses
> > > > > to load. I go, edit the sources, increment that to "linux,234" and secure
> > > > > boot works. No fixes applied.
> > > >
> > > > Everything involved in the boot path is covered by signatures, so if
> > > > SecureBoot is enabled you can't simply build custom binaries. They
> > > > won't run unless you modify your EFI firmware config to trust your
> > > > own signing keys. If a user wants to compromise their own machine in
> > > > that way, that's fine.
> > >
> > > "SecureBoot" is a distro-specific thing, they handle the keys, it's not
> > > anything the normal kernel deals with.
> >
> > Nah, you are thinking of key management, but this is not about that.
> > This is about vulnerabilities that allow secure boot bypass, and the
> > normal kernel very much deals with that. Kernel module signature
> > enforcement, Lockdown LSM, ensuring ExitBootServices is called at the
> > right time, etc.
>
> Yes, that's all fun things but they have nothing to do with a vague idea
> of "SecureBoot" that you wish to apply for your specific threat model.
> They make up the potential solution for your model, but individually
> don't.

First of all, it's not 'my' model, secondly, I have no clue where you
got the idea that any one of those 'individually implemented secure
boot', because that's certainly not what I wrote.

> > > > > > When a downstream vendor builds the kernel they would actually add a
> > > > > > third record, where they append a vendor identifier to the 'linux'
> > > > > > component name, so the .sbat PE section might say.
> > > > > >
> > > > > >  $ cat linux.sbat
> > > > > >  sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
> > > > > >  linux,1,The Linux Developers,linux,6.5.0-rc1,https://linux.org
> > > > > >  linux.fedora,1,The Fedora Project,linux,6.5.0-rc1,https://fedoraproject.org
> > > > > >
> > > > > > this allows Fedora to deal with revokation if they make a downstream
> > > > > > only mistake that compromises SecureBoot.
> > > > >
> > > > > What does that mean, "allows Fedora to deal with revokation"?
> > > >
> > > > Lets say Fedora applied a non-upstream kernel patch that compromised
> > > > SecureBoot. Upstream Linux has no reason to change their SBAT component
> > > > generation number. Instead Fedora would change their 'linux.fedora'
> > > > component generation number to reflect their own mistake.
> > >
> > > Why are you somehow trying to differenciate between "upstream" and
> > > Fedora's kernels here?
> >
> > Because they _are_ different, and a secure boot bypass can be added
> > via a downstream patch or an upstream change, and it is important to
> > differentiate as we don't want to needlessly revoke. Having to rollout
> > a new Debian kernel because there is a vulnerability in a Fedora patch
> > would be a silly waste of time.
>
> Agreed, why would any of us care about Fedora-specific patches?

Precisely, hence why the SBAT protocol explicitly supports separate
downstream vs upstream fields

> > > Why does "upstream" need any of this?
> >
> > Because 'upstream' is involved in the boot chain
>
> How exactly?

Seriously?

> > > And how can you tell if upstream "makes a mistake" that compromises
> > > secure boot?  Who is going to keep track of this?  Who is auditing all
> > > of our fixes/changes to verify this?  Have you looked at the past year
> > > or so and actually determined if you could properly determine this?  If
> > > not, why not?
> >
> > The same people who are already doing this for bootloaders, I would guess.
>
> If you don't know who is doing this work, that means the work isn't
> actually happening, so none of this will ever work at all.

Yes, famously there's nobody doing kernel maintenance/research/etc,
how silly of me
