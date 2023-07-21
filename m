Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D16D75BCD0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjGUDax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjGUDav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:30:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341CF272E;
        Thu, 20 Jul 2023 20:30:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB55D604AD;
        Fri, 21 Jul 2023 03:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B17CC433CA;
        Fri, 21 Jul 2023 03:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689910244;
        bh=P3Y0G8/zzL+Nhngt7XtAvkZnhEiGjeTZy9ZP98jV8+c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TaKDXTTI0MEadIT8proVhhnPM/KEjCQ9oUz0S5kAB/Lnlw2hpfi+3PwCV15q9zXB9
         JeYB1j01UxMrZi4l/2+x29bBaMCmKIPJqnToeUKjYKa7IQnoWob8FkhgKRc0VK4x6h
         xXY2hltxIS+KstWggXPV+oEobwJYpakq0MiHYIb0ApnlC3Q9lq5mlbPPEOACInsw3L
         DuKedrqfIvxer1OvzGfbCYf1eGtP949HQNnlLJ6mSUkeV2MVxqVgjl6zLuKg4qCur4
         4e+SOwI85PcpmBrLXcF/jehA84NS/EPPRi/vWj8e66QFOsVwROWyDXAwranCht09Wn
         2lI3BVbnE/0PQ==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-564e4656fecso975386eaf.0;
        Thu, 20 Jul 2023 20:30:44 -0700 (PDT)
X-Gm-Message-State: ABy/qLYb8j3daAZ/GPe5WRH4gAJV6kSk5xz/YU7EtwVW7a1/6Vb4wh2X
        Mic4h5OY5RIZSiMyaDeJhAvzWLSz6enrQWG9AV4=
X-Google-Smtp-Source: APBJJlEbukEvjQ2n/VPRmQTsiDSn1rOtzwNlK20fmI6AD+8Ik06WmpFrbwE3agD/3iKtnFrfOfMCDsb7Ni807E5NnxQ=
X-Received: by 2002:a4a:344a:0:b0:566:efc9:1464 with SMTP id
 n10-20020a4a344a000000b00566efc91464mr767853oof.0.1689910243449; Thu, 20 Jul
 2023 20:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <e7292802-e517-6469-6fbd-a4d30887c99b@gmail.com>
In-Reply-To: <e7292802-e517-6469-6fbd-a4d30887c99b@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 21 Jul 2023 12:30:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNATehP+0Woq6yVkB_NdvsmCLX3g04j-h22T9qy-GbWQ3_w@mail.gmail.com>
Message-ID: <CAK7LNATehP+0Woq6yVkB_NdvsmCLX3g04j-h22T9qy-GbWQ3_w@mail.gmail.com>
Subject: Re: 6.4.4 breaks module-free builds of Debian kernel packages
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Sasha Levin <sashal@kernel.org>,
        Brian Lindholm <brian_lindholm@users.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 12:19=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.co=
m> wrote:
>
> Hi,
>
> I notice a regression report on Bugzilla [1]. Quoting from it:
>
> > I'm on AMD64 with Debian testing (trixie), where I build my own kernels=
 (with CONFIG_MODULES unset) using "make bindeb-pkg". The build proceeds th=
rough 99% of the process, but fails here:
> >
> > Kernel: arch/x86/boot/bzImage is ready  (#2)
> > make -f ./Makefile ARCH=3Dx86     KERNELRELEASE=3D6.4.4-i5 intdeb-pkg
> > sh ./scripts/package/builddeb
> > ***
> > *** The present kernel configuration has modules disabled.
> > *** To use the module feature, please run "make menuconfig" etc.
> > *** to enable CONFIG_MODULES.
> > ***
> > make[5]: *** [Makefile:1969: modules_install] Error 1
> > make[4]: *** [scripts/Makefile.package:150: intdeb-pkg] Error 2
> > make[3]: *** [Makefile:1657: intdeb-pkg] Error 2
> > make[2]: *** [debian/rules:16: binary-arch] Error 2
> > dpkg-buildpackage: error: debian/rules binary subprocess returned exit =
status 2
> > make[1]: *** [scripts/Makefile.package:139: bindeb-pkg] Error 2
> > make: *** [Makefile:1657: bindeb-pkg] Error 2
> >
> > 6.3.13 contained the same error, but I "fixed" that by moving to 6.4.3.=
  But alas, 6.4.4 now has the same issue.
> >
> > I worked around the issue by changing "exit 1" to "exit 0" in the main =
Makefile (at "modules module_install", per the attached patch), but I don't=
 know if this is a true fix or something that simply happens to work for my=
 particular configuration.
>
> See Bugzilla for the full thread and attached patch that ignores the erro=
r.
>
> Josh: It looks like this regression is caused by a commit of yours
> (and also 1240dabe8d58b4). Would you like to take a look on it?
>
> Anyway, I'm adding this regression to be tracked by regzbot:
>
> #regzbot introduced: 4243afdb932677 https://bugzilla.kernel.org/show_bug.=
cgi?id=3D217689
> #regzbot title: always doing modules_install breaks CONFIG_MODULES=3Dn bu=
ilds
>
> Thanks.
>
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217689
>
> --
> An old man doll... just what I always wanted! - Clara




The following commit must be back-ported.



commit 8ae071fc216a25f4f797f33c56857f4dd6b4408e
Author: Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu Jun 15 20:17:43 2023 +0900

    kbuild: make modules_install copy modules.builtin(.modinfo)









--=20
Best Regards
Masahiro Yamada
