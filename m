Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D540375BD15
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 06:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjGUEFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 00:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGUEFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 00:05:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F67F1BFC;
        Thu, 20 Jul 2023 21:05:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C58D760FDC;
        Fri, 21 Jul 2023 04:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29604C433C9;
        Fri, 21 Jul 2023 04:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689912331;
        bh=kSPOSurbW8NbsVtMojaioWWzEDIww44TVaaIl98iVC4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LRj7Z6aXaS4HgZ0bLOgQb65LqgC/9wSgKPtOFLlLoI+xUkAJueYmPbVM9fFBNEH6U
         tVezbMKPHgUpQ3Atc0SK51nRy6S5IPH7w/G/x7fZ123dpXjaoq4BM476ARoGnkPC7V
         XCdQCQrX0mH/ETGlNG6/sP5D+cyr4qA8jrWgMoMb11qHVUVg8vRvUwPLjzR3p+asj3
         vbpKU7tJgARaxNK+zU5cjd/4w0rmED052F5c014GLSd/DUOJsgWkBiaaj6vNKnL6Ix
         nz7gd+7u7nvtAMmg5MJNfbgwcdy8KP2C1vJQX8amrVXgZsPSMJbx6IxEazvZ6SZvj/
         UytlP9x5zlJ4g==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1b056276889so1189431fac.2;
        Thu, 20 Jul 2023 21:05:31 -0700 (PDT)
X-Gm-Message-State: ABy/qLYk6g92VDkd6xMOp7h3XICkWVJGwPV2OCwYgbne09axC8+g3khC
        NedjG8pVX5+Z/Dt5/969igX0vdNIWOY0nrizP0s=
X-Google-Smtp-Source: APBJJlFPBf8pC2X5XxVXk5qUJ6GVmzWV+g9JGQS25fqtJWVtLnHQrESRHbunQBNrvS9I15O3eU7GKwJeivLIuPV0OwU=
X-Received: by 2002:a05:6870:2183:b0:1b3:eec8:fa94 with SMTP id
 l3-20020a056870218300b001b3eec8fa94mr883553oae.7.1689912330393; Thu, 20 Jul
 2023 21:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <e7292802-e517-6469-6fbd-a4d30887c99b@gmail.com>
In-Reply-To: <e7292802-e517-6469-6fbd-a4d30887c99b@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 21 Jul 2023 13:04:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNATs65gj-uECfwKLT++08MyWtC39RGHgTqzNNXR66dxenQ@mail.gmail.com>
Message-ID: <CAK7LNATs65gj-uECfwKLT++08MyWtC39RGHgTqzNNXR66dxenQ@mail.gmail.com>
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



I sent a back-port request.
https://lore.kernel.org/stable/CAK7LNAQNwjRYQDCD3=3DVoddnFmhxruzGpyppHr+2ZF=
3SgqDme-w@mail.gmail.com/T/#u

Hopefully, 6.4.x will be fixed in the next release.



The 6.3.x series is EOL.
So, we cannot fix it.






--
Best Regards
Masahiro Yamada
