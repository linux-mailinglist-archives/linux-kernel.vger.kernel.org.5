Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408627ED85C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 01:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjKPAAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 19:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPAAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 19:00:34 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429E419B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 16:00:29 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1ea48ef2cbfso108808fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 16:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700092828; x=1700697628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tp8xQcGoeOD8I/B6IEM0pHmkue79495Y+96+pRcwJUM=;
        b=PfLTZrbbxOlLVkNkPMJnzKCaS/7sHC2sB9Bk2ncc6b/FP6oKpP5S7tJWlu+TSFab+3
         bYD7YaLd/WoXNGHvRpBEcM8yUKnMX16xWUt+2PpSAROp6SKgnkUthxGcn4C8uIX9EBsW
         nNMYjG+W81+bsKNcJmnqbDGWSV/2gVzDHMZ3LHoY9Fi9gWKYHYPnz5TKYWutsU6DOZNg
         KaD2q1dFi3yRqcfMbkNgkMNiUsi/n3p1NwMZXI+ahp+KIFLuFZfc5Py2G6DjqDP88Pcw
         bYFKaQlwcsBF+DURE9yRxBxopu4fQ64mhUh74Xxj6D18leOFKPKQ02yezlz6/DkPiuwL
         iE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700092828; x=1700697628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tp8xQcGoeOD8I/B6IEM0pHmkue79495Y+96+pRcwJUM=;
        b=nxJbj2mBVyfl0yMIZaXoxuWPXyJUr/abvlAI3mISalT5OgllNwMHn8CubH+1E786sG
         ZRut46b6WNNWiVjpqBMsh+z6NoQcxM3AMSUTdfP5I1Ck908qLKzl0IUjbYeqQeNFi82i
         UEd6ggxWH1Zq4mv8dH3NUU85xNUInyeWCLycIU0mOuEJr+SedxIN7TLpdOAijuZJdAsd
         o6kf9CDDkBFpYBwzPknczC+jf6QjObXqdjmXHyl3Ool3PLvNEsYKDPch7uQyGfD0fd9i
         iFowgCQV9OIDsd6waGQorE7KbCmOityhWlvMMMb3dOXRebzmLgCaX0yFZMF6DvI6ZG+d
         78BA==
X-Gm-Message-State: AOJu0YzQj6c1OwU8tmd2XBd4C9NjfrjMJsYfgDY0PRbbRxRmm/8P5A5n
        qrSFCZnCehJxx6QqAC7kRtXF3NrSmBNs6+lzkiJFyQ==
X-Google-Smtp-Source: AGHT+IGoX9qNG01zHQG14ZasIrjS0oqxINZ3hMf6kRT8IIM/DTCOIeAaVm/zU9OtB/I9iqTdLqohGxntcdeWLkl584E=
X-Received: by 2002:a05:6871:b0d:b0:1d5:eb1:c587 with SMTP id
 fq13-20020a0568710b0d00b001d50eb1c587mr17024069oab.19.1700092828602; Wed, 15
 Nov 2023 16:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20231115191600.708733204@linuxfoundation.org> <CAEUSe7_KQ_-Q2ADLVcuKjb9vGOpkgAEgzgq5o-Hf=7a7c9NLXw@mail.gmail.com>
In-Reply-To: <CAEUSe7_KQ_-Q2ADLVcuKjb9vGOpkgAEgzgq5o-Hf=7a7c9NLXw@mail.gmail.com>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Wed, 15 Nov 2023 18:00:16 -0600
Message-ID: <CAEUSe7_cN0g=i_kS29zbEYdA81ruZNbAA42eYAjRdCDJFSaT+w@mail.gmail.com>
Subject: Re: [PATCH 6.5 000/550] 6.5.12-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, 15 Nov 2023 at 15:38, Daniel D=C3=ADaz <daniel.diaz@linaro.org> wro=
te:
> On Wed, 15 Nov 2023 at 13:20, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 6.5.12 release.
> > There are 550 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 17 Nov 2023 19:14:03 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patc=
h-6.5.12-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-6.5.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> We're seeing build regressions on Arm, Arm64, i386, x86, with KUnit
> defconfigs (and multi_v5_defconfig on Arm32):
> -----8<-----
>   In file included from /builds/linux/lib/kunit/executor.c:225:
>   /builds/linux/lib/kunit/executor_test.c: In function 'free_suite_set':
>   /builds/linux/lib/kunit/executor_test.c:130:30: error: invalid use
> of undefined type 'struct kunit_suite_set'
>     130 |         kunit_free_suite_set(*(struct kunit_suite_set *)suite_s=
et);
>         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
>   /builds/linux/lib/kunit/executor_test.c: In function 'free_suite_set_at=
_end':
>   /builds/linux/lib/kunit/executor_test.c:141:49: error: invalid use
> of undefined type 'struct kunit_suite_set'
>     141 |         if (!((struct kunit_suite_set *)to_free)->start)
>         |                                                 ^~
>   /builds/linux/lib/kunit/executor_test.c:144:31: error: invalid
> application of 'sizeof' to incomplete type 'struct kunit_suite_set'
>     144 |         free =3D kzalloc(sizeof(struct kunit_suite_set), GFP_KE=
RNEL);
>         |                               ^~~~~~
>   /builds/linux/lib/kunit/executor_test.c:145:17: error: invalid use
> of undefined type 'struct kunit_suite_set'
>     145 |         *free =3D *(struct kunit_suite_set *)to_free;
>         |                 ^
>   /builds/linux/lib/kunit/executor_test.c:145:15: error: invalid use
> of undefined type 'struct kunit_suite_set'
>     145 |         *free =3D *(struct kunit_suite_set *)to_free;
>         |               ^
>   make[5]: *** [/builds/linux/scripts/Makefile.build:243:
> lib/kunit/executor.o] Error 1
> ----->8-----
>
> This is with defconfig, CONFIG_KASAN=3Dy, CONFIG_KUNIT=3Dy, and
> CONFIG_KUNIT_ALL_TESTS=3Dy. To reproduce,
>
> tuxmake \
>   --runtime podman \
>   --target-arch arm64 \
>   --toolchain gcc-13 \
>   --kconfig defconfig \
>   --kconfig-add CONFIG_KASAN=3Dy \
>   --kconfig-add CONFIG_KUNIT=3Dy \
>   --kconfig-add CONFIG_KUNIT_ALL_TESTS=3Dy
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Bisection is on-going.

Bisection points to 3aed6e0618a9 ("kunit: test: Fix the possible
memory leak in executor_test"), upstream commit
8040345fdae4cb256c5d981f91ae0f22bea8adcc. Reverting this commit brings
happiness back to the build.

This problem is not observed on other branches.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
