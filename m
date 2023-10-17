Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770B67CC070
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343831AbjJQKRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjJQKR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:17:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59618D5E;
        Tue, 17 Oct 2023 03:16:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21BFC43391;
        Tue, 17 Oct 2023 10:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697537787;
        bh=swyJ9YtG3EhTopO4DHeUFs2J4cW+GCL7fSY3ViXq+8A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gtOnjxYHs0lGdUOB/P3KsMpYneZXC5tUqcF/aCdso/xCjMCaCBMfRk9qPYw8kcXYO
         VJv1EzbpL63YsFC1F3Nk4n6q0/SSEdgjg2c+k7icq0UtBwlfao+0ksSwWR7eLkWT+x
         aZEyeL4/lyAOQMY+FWBxkKxly590fnKgeEoTTBVBI5nqdOYIc+NvItjqAOXcNXIwGQ
         pg9f0P6Ke1De6pPDEYsxMFWMl9MLTV54MbjPnwWDCL6JSYphCVUFPEvSaeUxHE5cac
         tv1OtOQFCqt4tZPsrcHzOgLNdFMkQJeK460QMb+0sbc643hl0MLwtaulCP9//NyR7r
         jsrZ1DdSOJl0g==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6c4f1f0774dso3823727a34.2;
        Tue, 17 Oct 2023 03:16:27 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx0u4zyJPLobUHVoEdzXCrn7HbhNqCt57duFSYJMYBf0/MkVNMe
        1e7LEtacsazZodMgZ3UGK6MOgNLqT9YFqTwZxZ8=
X-Google-Smtp-Source: AGHT+IG5Pm9ZPhUMcbgBDQ1KvRFJ1BnDq6D287LE9VXt+8p7+OgCUXA3DVQ/ZrLQQmmKI71abhSnJ+RXo2MJIFlQ2aA=
X-Received: by 2002:a05:6870:2183:b0:1e9:c315:9d66 with SMTP id
 l3-20020a056870218300b001e9c3159d66mr1951983oae.40.1697537787138; Tue, 17 Oct
 2023 03:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231005150728.3429-1-msuchanek@suse.de> <CAK7LNAQh7vCQ859RPkL3SDr2d4ptt5OVCr66fkPKGcvxDUHtkw@mail.gmail.com>
 <20231009085208.GT6241@kitsune.suse.cz> <CAK7LNASeMEKVi5c0PEow5KSdN7rsm7UYEf2smWOSkYOhr_5fVQ@mail.gmail.com>
 <20231009140733.GV6241@kitsune.suse.cz> <CAK7LNAQQMFUt4R1m_U8kBY5=BvxD_dMuE4MD4kpd48WK1E+AGA@mail.gmail.com>
 <20231010101552.GW6241@kitsune.suse.cz>
In-Reply-To: <20231010101552.GW6241@kitsune.suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 17 Oct 2023 19:15:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNASX2_-xt3Qvxie_G=Q4fuVYR6eE47QjQ5NZf7QxY-4_tQ@mail.gmail.com>
Message-ID: <CAK7LNASX2_-xt3Qvxie_G=Q4fuVYR6eE47QjQ5NZf7QxY-4_tQ@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Let me add more context to my question.
> >
> >
> > I am interested in the timing when
> > 'pkg-config --print-variables kmod | grep module_directory'
> > is executed.
> >
> >
> >
> > 1.  Build a SRPM on machine A
> >
> > 2.  Copy the SRPM from machine A to machine B
> >
> > 3.  Run rpmbuild on machine B to build the SRPM into a RPM
> >
> > 4.  Copy the RPM from machine B to machine C
> >
> > 5.  Install the RPM to machine C
>
> As far as I am aware the typical use case is two step:
>
> 1. run make rpm-pkg on machine A
> 2. install the binary rpm on machine C that might not have build tools
>    or powerful enough CPU
>
> While it's theoretically possible to use the srpm to rebuild the binary
> rpm independently of the kernel git tree I am not aware of people
> commonly doing this.



If I correctly understand commit
8818039f959b2efc0d6f2cb101f8061332f0c77e,
those Redhat guys pack a SRPM on a local machine,
then send it to their build server called 'koji'.

Otherwise, there is no reason
to have 'make srcrpm-pkg'.



I believe "A == B" is not always true,
but we can assume "distro(A) == distro(B)" is always met
for simplicity.

So, I am OK with configuration at the SRPM time.





> If rebuilding the source rpm on a different machine from where the git
> tree is located, and possibly on a different distribution is desirable
> then the detection of the KERNEL_MODULE_DIRECTORY should be added in the
> rpm spec file as well.
>
> > Of course, we are most interested in the module path
> > of machine C, but it is difficult/impossible to
> > guess it at the time of building.
> >
> > We can assume machine B == machine C.
> >
> > We are the second most interested in the module
> > path on machine B.
> >
> > The module path of machine A is not important.
> >
> > So, I am asking where you would inject
> > 'pkg-config --print-variables kmod | grep module_directory'.
>
> I don't. I don't think there will be a separate machine B.
>
> And I can't really either - so far any attempt at adding support for
> this has been rejected.
>
> Technically the KERNEL_MODULE_DIRECTORY could be set in two steps - one
> giving the script to run, and one running it, and then it could be run
> independently in the SRPM as well.


At first, I thought your patch [1] was very ugly,
but I do not think it is so ugly if cleanly implemented.

It won't hurt to allow users to specify the middle part of MODLIB.


There are two options.




[A]  Add 'MOD_PREFIX' to specify the middle part of MODLIB


The top Makefile will look as follows:


MODLIB = $(INSTALL_MOD_PATH)$(MOD_PREFIX)/lib/modules/$(KERNELRELEASE)
export MODLIB


It is easier than specifying the entire MODLIB, but you still need
to manually pass "MOD_PREFIX=/usr" from an env variable or
the command line.

If MOD_PREFIX is not given, MODLIB is the same as the current one.




[B] Support a dynamic configuration as well



MOD_PREFIX ?= $(shell pkg-config --variable=module_prefix libkmod 2>/dev/null)
export MOD_PREFIX

MODLIB = $(INSTALL_MOD_PATH)$(MOD_PREFIX)/lib/modules/$(KERNELRELEASE)
export MODLIB




If MOD_PREFIX is given from an env variable or from the command line,
it is respected.

If "pkg-config --variable=module_prefix libkmod" works,
that configuration is applied.

Otherwise, MOD_PREFIX is empty, i.e. fall back to the current behavior.






I prefer 'MOD_PREFIX' to 'KERNEL_MODULE_DIRECTORY' in your patch [1]
because "|| echo /lib/modules" can be omitted.

I do not think we will have such a crazy distro that
installs modules under /opt/ directory.




I could not understand why you inserted
"--print-variables kmod 2>/dev/null | grep '^module_directory$$' >/dev/null"
but I guess the reason is the same.
"pkg-config --variable=module_directory kmod" always succeeds,
so "|| echo /lib/modules" is never processed.


I do not know why you parsed kmod.pc instead of libkmod.pc [2]



[1] https://lore.kernel.org/linux-kbuild/20230718120348.383-1-msuchanek@suse.de/
[2] https://github.com/kmod-project/kmod/blob/v31/configure.ac#L295



--
Best Regards
Masahiro Yamada
