Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4D17CC628
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344099AbjJQOr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343637AbjJQOr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:47:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97ECF0;
        Tue, 17 Oct 2023 07:47:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71581C433CD;
        Tue, 17 Oct 2023 14:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697554043;
        bh=o+3v6lOxg61LrqHPn9ZEX42q3MvVqZ6NLg4dox/Qa90=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gk94+AxSz4tPhLOIKyVyvkgxIjb6Ob8KEanJOtvVVlh00FsAoPg2+7epQKAYNyuvj
         lzIL3if4aWMPCJYgoVq3ln92GyCKSjprtffKELWwK3sFZIIHr/ZSU0O2mqATNlG8Il
         RY4/NFPVUaCXuq28XnS793CuQs+46wPYHKrIr5A634apnTV033NcNugZFj+8eszKnS
         hs1D1DO4r94sBQ7vYtS2u5irMA9ZAKNwg77KzqlTMG/8fIegxX4oLRZElIyT58Ok0P
         +m8DWwJL/zWXETsoAQmPb2J0JmY9F5tV5kEqpDuS0y+GCQbhLA2soPxJF1MsaaVj+1
         IibeRcZbEToAg==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6c4bf619b57so3930551a34.1;
        Tue, 17 Oct 2023 07:47:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YxZr0/VwQYwqYZG0G+pvGLZMTTrvCz76/aP5D/TJ3ce7aF19NbC
        E1yQjBU4zG0l7U7NQ8s+ro8JU8opbRcKf+jbA2E=
X-Google-Smtp-Source: AGHT+IE2BjBqSePDoSy0LIctije8VSraKcc6cZhL5o50fWRSEHfxZsejlWQTmYtPubr6sKQETUcG8q4aHuUDPdBWS30=
X-Received: by 2002:a05:6870:6b05:b0:1e9:d8a4:551f with SMTP id
 mt5-20020a0568706b0500b001e9d8a4551fmr2797954oab.17.1697554042716; Tue, 17
 Oct 2023 07:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231005150728.3429-1-msuchanek@suse.de> <CAK7LNAQh7vCQ859RPkL3SDr2d4ptt5OVCr66fkPKGcvxDUHtkw@mail.gmail.com>
 <20231009085208.GT6241@kitsune.suse.cz> <CAK7LNASeMEKVi5c0PEow5KSdN7rsm7UYEf2smWOSkYOhr_5fVQ@mail.gmail.com>
 <20231009140733.GV6241@kitsune.suse.cz> <CAK7LNAQQMFUt4R1m_U8kBY5=BvxD_dMuE4MD4kpd48WK1E+AGA@mail.gmail.com>
 <20231010101552.GW6241@kitsune.suse.cz> <CAK7LNASX2_-xt3Qvxie_G=Q4fuVYR6eE47QjQ5NZf7QxY-4_tQ@mail.gmail.com>
 <20231017104453.GG6241@kitsune.suse.cz> <CAK7LNASKPg0JK0QsLGb1Rfx2ysvHJTm3NFOvtwOpZRz4-20T8w@mail.gmail.com>
 <20231017122747.GH6241@kitsune.suse.cz>
In-Reply-To: <20231017122747.GH6241@kitsune.suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 17 Oct 2023 23:46:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3N82cJD3GsF+yUBEfPNOBkhzYPk37q3k0HdU7ukz9vQ@mail.gmail.com>
Message-ID: <CAK7LNAT3N82cJD3GsF+yUBEfPNOBkhzYPk37q3k0HdU7ukz9vQ@mail.gmail.com>
Subject: Re: [PATCH rebased] kbuild: rpm-pkg: Fix build with non-default MODLIB
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Tue, Oct 17, 2023 at 9:27=E2=80=AFPM Michal Such=C3=A1nek <msuchanek@sus=
e.de> wrote:
>
> On Tue, Oct 17, 2023 at 09:05:29PM +0900, Masahiro Yamada wrote:
> > On Tue, Oct 17, 2023 at 7:44=E2=80=AFPM Michal Such=C3=A1nek <msuchanek=
@suse.de> wrote:
> > >
> > > On Tue, Oct 17, 2023 at 07:15:50PM +0900, Masahiro Yamada wrote:
> > > > > >
> > > > > > Let me add more context to my question.
> > > > > >
> > > > > >
> > > > > > I am interested in the timing when
> > > > > > 'pkg-config --print-variables kmod | grep module_directory'
> > > > > > is executed.
> > > > > >
> > > > > >
> > > > > >
> > > > > > 1.  Build a SRPM on machine A
> > > > > >
> > > > > > 2.  Copy the SRPM from machine A to machine B
> > > > > >
> > > > > > 3.  Run rpmbuild on machine B to build the SRPM into a RPM
> > > > > >
> > > > > > 4.  Copy the RPM from machine B to machine C
> > > > > >
> > > > > > 5.  Install the RPM to machine C
> > > > >
> > > > > As far as I am aware the typical use case is two step:
> > > > >
> > > > > 1. run make rpm-pkg on machine A
> > > > > 2. install the binary rpm on machine C that might not have build =
tools
> > > > >    or powerful enough CPU
> > > > >
> > > > > While it's theoretically possible to use the srpm to rebuild the =
binary
> > > > > rpm independently of the kernel git tree I am not aware of people
> > > > > commonly doing this.
> > > >
> > > >
> > > >
> > > > If I correctly understand commit
> > > > 8818039f959b2efc0d6f2cb101f8061332f0c77e,
> > > > those Redhat guys pack a SRPM on a local machine,
> > > > then send it to their build server called 'koji'.
> > > >
> > > > Otherwise, there is no reason
> > > > to have 'make srcrpm-pkg'.
> > > >
> > > >
> > > >
> > > > I believe "A =3D=3D B" is not always true,
> > > > but we can assume "distro(A) =3D=3D distro(B)" is always met
> > > > for simplicity.
> > > >
> > > > So, I am OK with configuration at the SRPM time.
> > >
> > > Even if the distro does not match it will likely work to configure SR=
PM
> > > for non-matching distro and then build it on the target distro but I =
have
> > > not tested it.
> >
> >
> >
> > Your approach specifies %{MODLIB} as a fixed string
> > when generating kernel.spec, i.e. at the SRPM time.
> >
> >
> >  %files
> >  %defattr (-, root, root)
> > -/lib/modules/%{KERNELRELEASE}
> > -%exclude /lib/modules/%{KERNELRELEASE}/build
> > +%{MODLIB}
> > +%exclude %{MODLIB}/build
> >  /boot/*
> >
> >
> > Then, how to change the path later?
>
> Why would you need to change the path later?
>
> The SRPM has sources, it does not need to build on the system on which
> it is authored if it is intended for another distribution.
>
> Of course, you would need to know for what distribution and where it
> wants its modules so that you can specify the location when creating the
> SRPM.



Simply I wrongly understood your description.

If you manage to correctly configure for the target distro
when building SRPM, that's fine.





>
> > > > > If rebuilding the source rpm on a different machine from where th=
e git
> > > > > tree is located, and possibly on a different distribution is desi=
rable
> > > > > then the detection of the KERNEL_MODULE_DIRECTORY should be added=
 in the
> > > > > rpm spec file as well.
> > > > >
> > > > > > Of course, we are most interested in the module path
> > > > > > of machine C, but it is difficult/impossible to
> > > > > > guess it at the time of building.
> > > > > >
> > > > > > We can assume machine B =3D=3D machine C.
> > > > > >
> > > > > > We are the second most interested in the module
> > > > > > path on machine B.
> > > > > >
> > > > > > The module path of machine A is not important.
> > > > > >
> > > > > > So, I am asking where you would inject
> > > > > > 'pkg-config --print-variables kmod | grep module_directory'.
> > > > >
> > > > > I don't. I don't think there will be a separate machine B.
> > > > >
> > > > > And I can't really either - so far any attempt at adding support =
for
> > > > > this has been rejected.
> > > > >
> > > > > Technically the KERNEL_MODULE_DIRECTORY could be set in two steps=
 - one
> > > > > giving the script to run, and one running it, and then it could b=
e run
> > > > > independently in the SRPM as well.
> > > >
> > > >
> > > > At first, I thought your patch [1] was very ugly,
> > > > but I do not think it is so ugly if cleanly implemented.
> > > >
> > > > It won't hurt to allow users to specify the middle part of MODLIB.
> > > >
> > > >
> > > > There are two options.
> > > >
> > > >
> > > > [A]  Add 'MOD_PREFIX' to specify the middle part of MODLIB
> > > >
> > > >
> > > > The top Makefile will look as follows:
> > > >
> > > >
> > > > MODLIB =3D $(INSTALL_MOD_PATH)$(MOD_PREFIX)/lib/modules/$(KERNELREL=
EASE)
> > > > export MODLIB
> > > >
> > > >
> > > > It is easier than specifying the entire MODLIB, but you still need
> > > > to manually pass "MOD_PREFIX=3D/usr" from an env variable or
> > > > the command line.
> > > >
> > > > If MOD_PREFIX is not given, MODLIB is the same as the current one.
> > > >
> > > > [B] Support a dynamic configuration as well
> > > >
> > > >
> > > > MOD_PREFIX ?=3D $(shell pkg-config --variable=3Dmodule_prefix libkm=
od 2>/dev/null)
> > > > export MOD_PREFIX
> > > >
> > > > MODLIB =3D $(INSTALL_MOD_PATH)$(MOD_PREFIX)/lib/modules/$(KERNELREL=
EASE)
> > > > export MODLIB
> > >
> > > That's basically the same thing as the patch that has been rejected.
> > >
> > > I used :=3D to prevent calling pkg-config every time MODLIB is used b=
ut it
> > > might not be the most flexible wrt overrides.
> >
> > That's good you care about the cost of $(shell ) invocations.
> >
> > :=3D is evaluated one time at maximum, but one time at minimum.
> >
> > $(shell ) is always invoked for non-build targets as
> > "make clean", "make help", etc.
> > That is what I care about.
> >
> >
> > ?=3D is a recursive variable.
> >
> > The workaround for one-time evaluation is here,
> > https://savannah.gnu.org/bugs/index.php?64746#comment2
> >
> > However, that is not a problem because I can do it properly somehow,
> > for example, with "private export".
>
> That's good to know.
>
> > > > If MOD_PREFIX is given from an env variable or from the command lin=
e,
> > > > it is respected.
> > > >
> > > > If "pkg-config --variable=3Dmodule_prefix libkmod" works,
> > > > that configuration is applied.
> > > >
> > > > Otherwise, MOD_PREFIX is empty, i.e. fall back to the current behav=
ior.
> > > >
> > > >
> > > > I prefer 'MOD_PREFIX' to 'KERNEL_MODULE_DIRECTORY' in your patch [1=
]
> > > > because "|| echo /lib/modules" can be omitted.
> > > >
> > > > I do not think we will have such a crazy distro that
> > > > installs modules under /opt/ directory.
> > >
> > > However, I can easily imagine a distribution that would want to put
> > > modules in /usr/lib-amd64-linux/modules.
> >
> >
> > Sorry, it is not easy for me.
> >
> > What is the background of your thought?
>
> That's where every other library and module would go on distributions
> that care about ability to install packages for multiple architectures
> at the same time. AFAIK the workaround is to inclclude the CPU
> architecture in extraversion for the kernel to fit.


In my system (Ubuntu), I see the directory paths

/usr/aarch64-linux-gnu/lib/
/usr/i686-linux-gnu/lib/
/usr/x86_64-linux-gnu/lib/

If there were such a crazy distro that supports multiple kernel arches
within a single image, modules might be installed:
/usr/x86_64-linux-gnu/lib/module/<version>/

I have never seen a distro with /usr/lib-<triplet> hierarchy.

But, I have no idea, since this discussion is hypothetical after all.


> > >
> > > > I could not understand why you inserted
> > > > "--print-variables kmod 2>/dev/null | grep '^module_directory$$' >/=
dev/null"
> > > > but I guess the reason is the same.
> > > > "pkg-config --variable=3Dmodule_directory kmod" always succeeds,
> > > > so "|| echo /lib/modules" is never processed.
> > >
> > > Yes, that's the semantics of the tool. The jq version was slightly le=
ss
> > > convoluted but required additional tool for building the kernel.
> >
> >
> > It IS convoluted.
>
> That's unfortunate result of how the pkgconfig tool works. By now it is
> even too late to complain to the tool author because it's been like that
> forever, best bet is to to use it as is or pick a different tool for
> configuration.


"pkg-config --variable=3D<name>" returns its value.
It is pretty simple, and I do not think it is a big problem.

Your code is long, but the reason is that you implemented
it in that way.


If you go with KERNEL_MODULE_DIRECTORY for max flexibility,

  KERNEL_MODULE_DIRECTORY :=3D $(or $(shell pkg-config
--variable=3Dmodule_directory kmod 2>/dev/null),/lib/modules)

should work with less characters and less process forks.

But, now I started to prefer confining the long code
into the shell script, "scripts/modinst-dir",
and calling it where needed.





>
> > > > I do not know why you parsed kmod.pc instead of libkmod.pc [2]
> > >
> > > Because it's kmod property, not libkmod property.
> > >
> > > Distributions would install libkmod.pc only with development files
> > > whereas the kmod.pc should be installed with the binaries.
> >
> >
> > This is up to the kmod maintainer.
> >
> > If they agree, I do not mind where the configuration comes from.
>
> So far it has not been commented on. Maybe it's time for a ping.
>
> Thanks
>
> Michal
>
> > > > [1] https://lore.kernel.org/linux-kbuild/20230718120348.383-1-msuch=
anek@suse.de/
> > > > [2] https://github.com/kmod-project/kmod/blob/v31/configure.ac#L295
--
Best Regards
Masahiro Yamada
