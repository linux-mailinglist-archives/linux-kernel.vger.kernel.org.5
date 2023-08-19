Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05419781940
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 13:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjHSL1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 07:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjHSL1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 07:27:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65BC27838;
        Sat, 19 Aug 2023 04:26:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 729A060C89;
        Sat, 19 Aug 2023 11:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A31C433C9;
        Sat, 19 Aug 2023 11:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692444389;
        bh=VwvuMpt4N38GNUDvqh9frFS/hNxgReyr2IQJV9dQFAI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fQPoeaSpv95URcDji5P3m+J44RCLsdhWlM3BW6ooARqrU2gmbitePU58jfsrUcHu5
         TNDah/lL/5VIdn279GPkKRB9TVLDw9c2FGYUPIdkppG5cGw0g+epaAdm177AOcvOl9
         BNrytoy4MMQb/yp5BD7CB13Lp+64waCJv8butYFcXUsIgUJRsVTxs1oZZwt+BMpKEx
         M0hqA2/8l9mpbEF9KsojesloLKIyLvVp71E4Eq8rYyGBLHidbgcwojf6u7eUDLVkU9
         RP67RS6Re1o2c5UdIdmhfxsD/8Um893/L4BfGJ6pACBtLq9598kqL9cWIlxgxQr/sF
         fZnYd5Vgdcf9w==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1c4d1274f33so1055665fac.3;
        Sat, 19 Aug 2023 04:26:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YxywdUzOupJTcKJ1bdtiEEAd1AsSbvmVkK4xn4H8v4K9hvkRvru
        Qb2UoMhoqvmPlRSyqebIB53UWcuO1bHoQkc3/nQ=
X-Google-Smtp-Source: AGHT+IF75dKeUMQ1VqpkWFn2zYyLroTmh8SRbLr0nvfWsdxkeExulTiNgjAtmOmyZ2YrmdDoVuyJp8bTEoC2EvYIJXI=
X-Received: by 2002:a05:6871:68e:b0:1bb:4606:5be with SMTP id
 l14-20020a056871068e00b001bb460605bemr2698859oao.9.1692444389147; Sat, 19 Aug
 2023 04:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689589902.git.msuchanek@suse.de> <cover.1689681454.git.msuchanek@suse.de>
 <20230817163744.GD8826@kitsune.suse.cz>
In-Reply-To: <20230817163744.GD8826@kitsune.suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 19 Aug 2023 20:25:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQy79ZHS0d000XQzC-trRPhOUBFnWsGm03yG0cQAs-rXA@mail.gmail.com>
Message-ID: <CAK7LNAQy79ZHS0d000XQzC-trRPhOUBFnWsGm03yG0cQAs-rXA@mail.gmail.com>
Subject: Re: [PATCH kmod v5 0/5] kmod /usr support
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 12:15=E2=80=AFPM Michal Such=C3=A1nek <msuchanek@su=
se.de> wrote:
>
> Hello,
>
> On Tue, Jul 18, 2023 at 02:01:51PM +0200, Michal Suchanek wrote:
> > Hello,
> >
> > with these patches it is possible to install kernel modules in an arbit=
rary
> > directory - eg. moving the /lib/modules to /usr/lib/modules or /opt/lin=
ux.
> >
> > While the modprobe.d and depmod.d search which already includes multipl=
e
> > paths is expanded to also include $(prefix) the module directory still
> > supports only one location, only a different one under $(module_directo=
ry).
> >
> > Having kmod search multiple module locations while only one is supporte=
d now
> > might break some assumption about relative module path corresponding to=
 a
> > specific file, would require more invasive changes to implement, and is=
 not
> > supportive of the goal of moving the modules away from /lib.
> >
> > Both kmod and the kernel need to be patched to make use of this feature=
.
> > Patched kernel is backwards compatible with older kmod.  Patched kmod
> > with $(module_directory) set to /lib/modules is equivalent to unpatched=
 kmod.
>
> The patch to kernel to support autodetection of module directory is
> rejected. However, a workaround like
>
> make MODLIB=3D'$(INSTALL_MOD_PATH)/usr/lib/modules/$(KERNELRELEASE)'
>
> is suggested.
>
> Can you consider inluding the kmod changes?


Hi.

I have a question about your original patch
for the Kbuild change.

In your patch, Kbuild runs 'kmod config' or
'pkg-config --variable=3Dmodule_directory kmod',
then sets the returned string to MODLIB.


If kmod is configured to use /usr/lib/modules,
/opt/modules, or whatever,
should we change the installation path of the debug
vdso accordingly?

Currently, the debug vdso is always installed
to /lib/modules/$(KERNELRELEASE)/vdso/.

However, modules and vdso are unrelated to each other.
kmod does not care about vdso.


The following commits started to install debug vdso.

Commit 8150caad0226 ("[POWERPC] powerpc vDSO: install unstripped
copies on disk")
Commit f79eb83b3af4 ("x86: Install unstripped copy of 64bit vdso to disk")


I do not know why they chose $(MODLIB)/vdso as the install destination.


I am thinking of split the variable into two:
MODLIB -  installation path for modules
VDSOLIB - installation path for debug vdso (not affected by kmod config)

I think that is the way to do this correctly.









>
> Thanks
>
> Michal
>
> >
> > Thanks
> >
> > Michal
> >
> > Link: https://lore.kernel.org/linux-modules/20210112160211.5614-1-msuch=
anek@suse.de/
> >
> > v4: set whole path to module directory instead of adding prefix
> > v5: use pkg-config instead of jq, fix build on openssl without sm3 supp=
ort
> >
> >
> > Michal Suchanek (5):
> >   configure: Detect openssl sm3 support
> >   man/depmod.d: Fix incorrect /usr/lib search path
> >   libkmod, depmod: Load modprobe.d, depmod.d from ${prefix}/lib.
> >   kmod: Add pkgconfig file with kmod compile time configuration
> >   libkmod, depmod, modprobe: Make directory for kernel modules
> >     configurable
> >
> >  Makefile.am                          |   6 +-
> >  configure.ac                         |  30 ++++++++
> >  libkmod/libkmod.c                    |  11 +--
> >  man/Makefile.am                      |  10 ++-
> >  man/depmod.d.xml                     |   9 ++-
> >  man/depmod.xml                       |   4 +-
> >  man/modinfo.xml                      |   2 +-
> >  man/modprobe.d.xml                   |   1 +
> >  man/modprobe.xml                     |   2 +-
> >  man/modules.dep.xml                  |   6 +-
> >  testsuite/module-playground/Makefile |   2 +-
> >  testsuite/setup-rootfs.sh            | 109 +++++++++++++++------------
> >  testsuite/test-depmod.c              |  16 ++--
> >  testsuite/test-testsuite.c           |   8 +-
> >  tools/depmod.c                       |   7 +-
> >  tools/kmod.pc.in                     |  10 +++
> >  tools/modinfo.c                      |   4 +-
> >  tools/modprobe.c                     |   4 +-
> >  tools/static-nodes.c                 |   6 +-
> >  19 files changed, 156 insertions(+), 91 deletions(-)
> >  create mode 100644 tools/kmod.pc.in
> >
> > --
> > 2.41.0
> >



--
Best Regards


Masahiro Yamada
