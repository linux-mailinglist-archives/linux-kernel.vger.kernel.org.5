Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447267F0810
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 18:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjKSRSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 12:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjKSRSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 12:18:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA37D5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:17:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E20C433CA;
        Sun, 19 Nov 2023 17:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700414277;
        bh=qgUfLOgelbMc6flXfkjLtNvBseINngZV+K1eSORMcbc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B27QpvKzq90g0QRP/I8Pf279rh1zFLkbdKbHqa5+rY3aHhRnxZPxx/j4DgVxCH644
         T45pBIDDgmWMO9xpM0O8aRHV2grxsRso2XKCopSKbRc4PAp/UYTuEpb2KykCezUUPr
         8tg4zuDgfCLBbWhAOo3s/dQ6ICiiTkB/IvoUVUqv5qrehZDbUuZnyxBVs7rO4TJV3k
         QwSj6EZW3nDzJQws4DT9nVZjOXWbN6dFg6otMaAd5VvzgIFsN0/b0k6oY1ZK78ZIKI
         01lKgUAqjQEwVjDqV/hWM9+Xy5TpZmMb87RgvMGnMBn6pbdzjlP7yDGtSuyS+hWAg+
         ZXNlNUw/P2j6g==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1f066fc2a28so2290594fac.0;
        Sun, 19 Nov 2023 09:17:56 -0800 (PST)
X-Gm-Message-State: AOJu0YykLyqlsVJ7+Z5LVwVgvhMqfCnP63J6XjOolgvmdRmqcyDSQLCQ
        wF9kkijetBlEedpFWMS2vD6hgE9DiMGrDQeH/Ks=
X-Google-Smtp-Source: AGHT+IGresuODcdKPUVMYz4R8pbdwnP0Cl4tbiTb4qndqjL5iqiqHqY/XLGpjSPqVJs72qw+A9ATfVWpFFH2IZ3BJvM=
X-Received: by 2002:a05:6870:2b0b:b0:1e9:c2bd:f2e9 with SMTP id
 ld11-20020a0568702b0b00b001e9c2bdf2e9mr6310654oab.25.1700414276250; Sun, 19
 Nov 2023 09:17:56 -0800 (PST)
MIME-Version: 1.0
References: <20231117-maintainers-v1-1-85f2a7422ed9@google.com>
In-Reply-To: <20231117-maintainers-v1-1-85f2a7422ed9@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 20 Nov 2023 02:17:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNARAvH=tWpsXJ640y04Ju8UbPmDze_NC6ax1EKK4Xy73fw@mail.gmail.com>
Message-ID: <CAK7LNARAvH=tWpsXJ640y04Ju8UbPmDze_NC6ax1EKK4Xy73fw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: refresh LLVM support
To:     ndesaulniers@google.com
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick.


On Sat, Nov 18, 2023 at 4:24=E2=80=AFAM <ndesaulniers@google.com> wrote:
>
> As discussed at the ClangBuiltLinux '23 meetup (co-located with Linux Plu=
mbers
> Conf '23), I'll be taking a step back from kernel work to focus on my gro=
wing
> family and helping Google figure out its libc story. So I think it's time=
 to
> formally hand over the reigns to my co-maintainer Nathan.
>
> As such, remove myself from reviewer for:
> - CLANG CONTROL FLOW INTEGRITY SUPPORT
> - COMPILER ATTRIBUTES
> - KERNEL BUILD
>
> For CLANG/LLVM BUILD SUPPORT I'm bumping myself down from maintainer to
> reviewer, adding Bill and Justin, and removing Tom (Tom and I confirmed t=
his
> via private email; thanks for the work done Tom, ++beers_owed).
>
> It has been my pleasure to work with everyone to improve the toolchain
> portability of the Linux kernel, and to help bring LLVM to the table as a
> competitor. The work here is not done.  I have a few last LLVM patches in=
 the
> works to improve stack usage of clang which has been our longest standing=
 open
> issue (getting "rm" inline asm constraints to DTRT is part of that). But
> looking back I'm incredibly proud of where we are to today relative to wh=
ere we
> were when we started the ClangBuiltLinux journey, and am confident that t=
he
> team and processes we have put in place will continue to be successful. I
> continue to believe that a rising tide will lift all boats.
>
> I identify first and foremost as a Linux kernel developer, and an LLVM de=
v
> second. May it be a cold day in hell when that changes.
>
> Wake me when you need me.
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>




It's unfortunate, but I understand that there are moments in
a long life when tough decisions must be made.
I truly admire your leadership and contributions.

I hope you'll stay connected with the community, even with less
time pressure.
Perhaps, when your time permits, you might consider returning
and taking on a role again. Some day.



(The patch was addressed to Kees, so I will not touch it.
I think he will pick it up.)


Masahiro







> ---
>  MAINTAINERS | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 482d428472e7..1e6692697167 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5076,7 +5076,6 @@ CLANG CONTROL FLOW INTEGRITY SUPPORT
>  M:     Sami Tolvanen <samitolvanen@google.com>
>  M:     Kees Cook <keescook@chromium.org>
>  R:     Nathan Chancellor <nathan@kernel.org>
> -R:     Nick Desaulniers <ndesaulniers@google.com>
>  L:     llvm@lists.linux.dev
>  S:     Supported
>  B:     https://github.com/ClangBuiltLinux/linux/issues
> @@ -5091,8 +5090,9 @@ F:        .clang-format
>
>  CLANG/LLVM BUILD SUPPORT
>  M:     Nathan Chancellor <nathan@kernel.org>
> -M:     Nick Desaulniers <ndesaulniers@google.com>
> -R:     Tom Rix <trix@redhat.com>
> +R:     Nick Desaulniers <ndesaulniers@google.com>
> +R:     Bill Wendling <morbo@google.com>
> +R:     Justin Stitt <justinstitt@google.com>
>  L:     llvm@lists.linux.dev
>  S:     Supported
>  W:     https://clangbuiltlinux.github.io/
> @@ -5242,7 +5242,6 @@ F:        drivers/platform/x86/compal-laptop.c
>
>  COMPILER ATTRIBUTES
>  M:     Miguel Ojeda <ojeda@kernel.org>
> -R:     Nick Desaulniers <ndesaulniers@google.com>
>  S:     Maintained
>  F:     include/linux/compiler_attributes.h
>
> @@ -11516,7 +11515,6 @@ F:      fs/autofs/
>  KERNEL BUILD + files below scripts/ (unless maintained elsewhere)
>  M:     Masahiro Yamada <masahiroy@kernel.org>
>  R:     Nathan Chancellor <nathan@kernel.org>
> -R:     Nick Desaulniers <ndesaulniers@google.com>
>  R:     Nicolas Schier <nicolas@fjasle.eu>
>  L:     linux-kbuild@vger.kernel.org
>  S:     Maintained
>
> ---
> base-commit: 6bc40e44f1ddef16a787f3501b97f1fff909177c
> change-id: 20231117-maintainers-88eac4c024a1
>
> Best regards,
> --
> Nick Desaulniers <ndesaulniers@google.com>
>


--=20
Best Regards
Masahiro Yamada
