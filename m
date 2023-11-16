Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381F47EE149
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345159AbjKPNQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjKPNQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:16:09 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7057ACE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:16:04 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-4ac42a20f35so287370e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700140563; x=1700745363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69YHzJgxUUHxHVnmgHSoDMVSUl/PodcB0CYlh9UJ8z4=;
        b=lm8/T9pgyKX9XqcIAQx7Jnc7RS0RnXP7JRouwFal2MAfNiE4pv7iTrFSRkcFS/PdOc
         T/PF80nmROjjyGdiBOpK4dXTxZeuIG/TxqcdUb+UHZ/2pet7Blc94UdpklH9oR73lXWZ
         72TfDVxgA4fYYs6D6fTuUN+cm0YpDiajsl9cjhCWKR8UDV8B42RQ+OFxZSkURTv+c79L
         G3cOyRP/EXNfNe7XvMynaJT3cjS8k3KYXV7nEeUjAUEVAzGAvnX0BWeVeSRX6sxPH/0a
         jNIeGWARaH/Bck1Sp7hwC+XKxxtLLdMNDXkdQz8FoX0JM1j9Hyyyv+YmEgy9vxei1A/N
         aBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700140563; x=1700745363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69YHzJgxUUHxHVnmgHSoDMVSUl/PodcB0CYlh9UJ8z4=;
        b=BKk4TUZT8/XpNMkSXhJoSt8z6Fejdbw7PUG0TGeDQFnJ3F9yJUO8aiBPgtkqYcDVss
         xZQhbmlj1WeBYQMombsdQ8M2gpwIuikweHrY0ubbO+0FRTS7V3a+tk7CngFQw9df4Gpo
         9z1MnSo2PLrhPuu4WJLBuiZsl3KUg9kX/hUW/5QMY4af8B4bwboPHnBaURLS7dkVLNEX
         QgQg4bgiy101fg5ScYfh/D8v28vI+/RRqcmBk6+eWRm45EmHrcpUYqT3yDzpAA5xKPfz
         2mcdWB/tVjGfPsJZVtu4lBh64xL4v21gUjicmvFlJMefUbnpv1NAcL6QYMOjkQ2nWUq5
         XTNg==
X-Gm-Message-State: AOJu0Yy4cJuEYJ1pgbATWMluTyA0I9ApYp5NbNi4TqojTWWIkDsoZV3P
        oP6zSvqY///+PRqGmfafbDOn3PYhbKNcxa95LbwtOexDQHufOEn5KyU=
X-Google-Smtp-Source: AGHT+IEhKdssfv9iEp1BRylvQ+lMBhXjwCQDEVddOn5DYOh710s7GJfjHxLmp4ySWGaqaz86D+b9mEPzwkVW+NpGwQo=
X-Received: by 2002:a05:6122:3090:b0:493:7df9:bcc4 with SMTP id
 cd16-20020a056122309000b004937df9bcc4mr12347083vkb.4.1700140563418; Thu, 16
 Nov 2023 05:16:03 -0800 (PST)
MIME-Version: 1.0
References: <20231115191600.708733204@linuxfoundation.org> <CAEUSe7_KQ_-Q2ADLVcuKjb9vGOpkgAEgzgq5o-Hf=7a7c9NLXw@mail.gmail.com>
 <CAEUSe7_cN0g=i_kS29zbEYdA81ruZNbAA42eYAjRdCDJFSaT+w@mail.gmail.com>
In-Reply-To: <CAEUSe7_cN0g=i_kS29zbEYdA81ruZNbAA42eYAjRdCDJFSaT+w@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 Nov 2023 18:45:52 +0530
Message-ID: <CA+G9fYuncLhP1=BWQv561Jh5cZH9EDmnqnH3Znugi+eua5S0MA@mail.gmail.com>
Subject: Re: [PATCH 6.5 000/550] 6.5.12-rc1 review
To:     David Gow <davidgow@google.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, kunit-dev@googlegroups.com,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ kunit team

On Thu, 16 Nov 2023 at 05:30, Daniel D=C3=ADaz <daniel.diaz@linaro.org> wro=
te:
>
> Hello!
>
> On Wed, 15 Nov 2023 at 15:38, Daniel D=C3=ADaz <daniel.diaz@linaro.org> w=
rote:
> > On Wed, 15 Nov 2023 at 13:20, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > This is the start of the stable review cycle for the 6.5.12 release.
> > > There are 550 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Fri, 17 Nov 2023 19:14:03 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/pa=
tch-6.5.12-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git linux-6.5.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > We're seeing build regressions on Arm, Arm64, i386, x86, with KUnit
> > defconfigs (and multi_v5_defconfig on Arm32):
> > -----8<-----
> >   In file included from /builds/linux/lib/kunit/executor.c:225:
> >   /builds/linux/lib/kunit/executor_test.c: In function 'free_suite_set'=
:
> >   /builds/linux/lib/kunit/executor_test.c:130:30: error: invalid use
> > of undefined type 'struct kunit_suite_set'
> >     130 |         kunit_free_suite_set(*(struct kunit_suite_set *)suite=
_set);
> >         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> >   /builds/linux/lib/kunit/executor_test.c: In function 'free_suite_set_=
at_end':
> >   /builds/linux/lib/kunit/executor_test.c:141:49: error: invalid use
> > of undefined type 'struct kunit_suite_set'
> >     141 |         if (!((struct kunit_suite_set *)to_free)->start)
> >         |                                                 ^~
> >   /builds/linux/lib/kunit/executor_test.c:144:31: error: invalid
> > application of 'sizeof' to incomplete type 'struct kunit_suite_set'
> >     144 |         free =3D kzalloc(sizeof(struct kunit_suite_set), GFP_=
KERNEL);
> >         |                               ^~~~~~
> >   /builds/linux/lib/kunit/executor_test.c:145:17: error: invalid use
> > of undefined type 'struct kunit_suite_set'
> >     145 |         *free =3D *(struct kunit_suite_set *)to_free;
> >         |                 ^
> >   /builds/linux/lib/kunit/executor_test.c:145:15: error: invalid use
> > of undefined type 'struct kunit_suite_set'
> >     145 |         *free =3D *(struct kunit_suite_set *)to_free;
> >         |               ^
> >   make[5]: *** [/builds/linux/scripts/Makefile.build:243:
> > lib/kunit/executor.o] Error 1
> > ----->8-----
> >
> > This is with defconfig, CONFIG_KASAN=3Dy, CONFIG_KUNIT=3Dy, and
> > CONFIG_KUNIT_ALL_TESTS=3Dy. To reproduce,
> >
> > tuxmake \
> >   --runtime podman \
> >   --target-arch arm64 \
> >   --toolchain gcc-13 \
> >   --kconfig defconfig \
> >   --kconfig-add CONFIG_KASAN=3Dy \
> >   --kconfig-add CONFIG_KUNIT=3Dy \
> >   --kconfig-add CONFIG_KUNIT_ALL_TESTS=3Dy
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Bisection is on-going.

Thanks Daniel for bisecting this.

> Bisection points to 3aed6e0618a9 ("kunit: test: Fix the possible
> memory leak in executor_test"), upstream commit
> 8040345fdae4cb256c5d981f91ae0f22bea8adcc. Reverting this commit brings
> happiness back to the build.
>
> This problem is not observed on other branches.

stable-rc linux-6.6.y - kunit build pass
stable-rc linux-6.5.y - kunit build failed

## Test Regressions (compared to v6.5.11)
* arm, build
  - gcc-13-lkftconfig-kunit

* arm64, build
  - gcc-13-lkftconfig-kunit


>
> Greetings!
>
> Daniel D=C3=ADaz
> daniel.diaz@linaro.org

- Naresh
