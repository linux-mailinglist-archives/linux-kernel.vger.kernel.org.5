Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0C580BEA6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 02:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjLKBB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 20:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjLKBBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 20:01:24 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1EBA9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 17:01:30 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5b383b4184fso33322817b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 17:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702256490; x=1702861290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WQ5Kl/17KRmeDrnv++dZDxabOnVYumyCPRm9UvxCXU=;
        b=CGszbrQZZo2UCe6PlQD4gAXjJ6qCOyzZzZiOMfcKbnwIVtAtl7+lMEVe1mLEgrxjDQ
         TjuNKqbl/wAOsYI23Km0x16ku0uUFNt4H7UWwUyN3FLNNegggc8cT1rD4kFAvohqDpDL
         e6Os2k9wwDBEUStdcYfvby4H7Bn1WnBuYANZSOM+Wm925d524zoJU/bHc1SqP6yh55mo
         9nollJXpVf4GS0wxNcNZ64AyLmsTB4dhTMJ6g+ECQzHd77yRLmH/EH4qCzCE2ZB/WOoC
         3afxWDajYOi7DbpngLTG+NSV30ABNajhUBT3+HsM0CgRXwbjxKUCbYWhwxHJ9gXDRz4r
         46VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702256490; x=1702861290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WQ5Kl/17KRmeDrnv++dZDxabOnVYumyCPRm9UvxCXU=;
        b=m2X8kPvZF4RSFbS8UFzsyPBOJTU66HxOwH1kIb/A9n+ObYZVnoJBTcHkA9AuStQ7Ri
         byxtetqxmQLQojcX0ltb29EZF7MsmI2fMf2kyYGXFFhOgmZl0ihJzsronK9QF96kkeEQ
         zwWMGnQq6Gr+fZHPp5kMZKyyzTE7UrTtQhjWqDY0uyczwj7J/eASmK/3yuo/NI4Vd33F
         jpXz+0SWl2Q69FtJunIeF55tWRhn/Ymk3SMRNqFkbHrOAb8nntG3LAiUcSuFmDQuVrG5
         EV2vBtJJscFVb87ZTJovuXiu4Cc7NLkcwSo5lo+MYv6EYn+OG3SJlz2wukjmm0yn8c2k
         SVaQ==
X-Gm-Message-State: AOJu0Yyt26Ob6vKBx7NsIAp37JH5bnvYmps4ZzVghwEtlUxTSqAu60I3
        DkKi8B3TRHz/dFCD1YSnxbNnLGUgoyM1LWJIufL7Lg==
X-Google-Smtp-Source: AGHT+IEM06+RRlE/zePs7rbDQZUekYGXrzSDuMym2bE5wBVkl63IhZGe5nggAE5d9SV6vVL4ZhYg6AITCoRBwCXDwDI=
X-Received: by 2002:a0d:f9c6:0:b0:5d7:1940:7d92 with SMTP id
 j189-20020a0df9c6000000b005d719407d92mr2245546ywf.105.1702256489515; Sun, 10
 Dec 2023 17:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20231206103702.3873743-1-surenb@google.com> <20231206103702.3873743-6-surenb@google.com>
 <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
In-Reply-To: <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sun, 10 Dec 2023 17:01:18 -0800
Message-ID: <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To:     Mark Brown <broonie@kernel.org>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, david@redhat.com,
        ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 6:26=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Dec 06, 2023 at 02:36:59AM -0800, Suren Baghdasaryan wrote:
> > Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
> > into destination buffer while checking the contents of both after
> > the move. After the operation the content of the destination buffer
> > should match the original source buffer's content while the source
> > buffer should be zeroed. Separate tests are designed for PMD aligned an=
d
> > unaligned cases because they utilize different code paths in the kernel=
.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  tools/testing/selftests/mm/uffd-common.c     |  24 +++
> >  tools/testing/selftests/mm/uffd-common.h     |   1 +
> >  tools/testing/selftests/mm/uffd-unit-tests.c | 189 +++++++++++++++++++
> >  3 files changed, 214 insertions(+)
>
> This breaks the build in at least some configurations with separate
> output directories like those used by KernelCI:
>
> make KBUILD_BUILD_USER=3DKernelCI FORMAT=3D.xz ARCH=3Darm64 HOSTCC=3Dgcc =
CROSS_COMPILE=3Daarch64-linux-gnu- CROSS_COMPILE_COMPAT=3Darm-linux-gnueabi=
hf- CC=3D"ccache aarch64-linux-gnu-gcc" O=3D/tmp/kci/linux/build -C/tmp/kci=
/linux -j10 kselftest-gen_tar
>
> (full logs for both arm64 and x86_64 at):
>
>    https://storage.kernelci.org/next/master/next-20231208/arm64/defconfig=
/gcc-10/logs/kselftest.log
>    https://storage.kernelci.org/next/master/next-20231208/x86_64/x86_64_d=
efconfig/clang-17/logs/kselftest.log
>
> or tuxmake:
>
> make --silent --keep-going --jobs=3D16 O=3D/home/broonie/.cache/tuxmake/b=
uilds/25/build INSTALL_PATH=3D/home/broonie/.cache/tuxmake/builds/25/build/=
kselftest_install ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- CROSS_COM=
PILE_COMPAT=3Darm-linux-gnueabihf- kselftest-install
>
> The specific failure:
>
> aarch64-linux-gnu-gcc -Wall -I /tmp/kci/linux/tools/testing/selftests/../=
../..  -isystem /tmp/kci/linux/build/usr/include     uffd-stress.c vm_util.=
c uffd-common.c -lrt -lpthread -lm -o /tmp/kci/linux/build/kselftest/mm/uff=
d-stress
> uffd-common.c: In function =E2=80=98move_page=E2=80=99:
> uffd-common.c:636:21: error: storage size of =E2=80=98uffdio_move=E2=80=
=99 isn=E2=80=99t known
>   636 |  struct uffdio_move uffdio_move;
>       |                     ^~~~~~~~~~~
> uffd-common.c:643:21: error: =E2=80=98UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES=E2=
=80=99 undeclared (first use in this function)
>   643 |  uffdio_move.mode =3D UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> uffd-common.c:643:21: note: each undeclared identifier is reported only o=
nce for each function it appears in
> uffd-common.c:645:17: error: =E2=80=98UFFDIO_MOVE=E2=80=99 undeclared (fi=
rst use in this function); did you mean =E2=80=98UFFDIO_COPY=E2=80=99?
>   645 |  if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
>       |                 ^~~~~~~~~~~
>       |                 UFFDIO_COPY
> uffd-common.c:636:21: warning: unused variable =E2=80=98uffdio_move=E2=80=
=99 [-Wunused-variable]
>   636 |  struct uffdio_move uffdio_move;
>       |                     ^~~~~~~~~~~

Thanks for reporting! I'll try that later today.
Just to clarify, are you using mm-unstable and if so, has it been
rebased since Friday? There was an update to this patchset in
mm-unstable which Andrew merged on Friday and the failure does look
like something that would happen with the previous version.
