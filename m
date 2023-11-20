Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED577F1D84
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjKTTrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjKTTrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:47:09 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBB9A2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:47:04 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c8769edd9fso27735051fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700509623; x=1701114423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k63y0ImIMzxwhoXgElC40ZBYzHWgYpN897FOa0LAhXo=;
        b=TytuiUM9xjgmSrq8PTCyhB8GE4jNsAj4tXQqLg69j0RL9bfmFxBU5CJsbCO0PY5Wwc
         4l7JejFJMW5ooDzTjZllyKxd2RZPrt5YYDr78DAGE+bbsiXce+uPKuL3p270nVgqb+sp
         3oKtsat1WxlPSQHkTihWb63BYlwmwtTfsd2ypmN4TzF2AIZEdy59AZaBq7tETUtnSIAW
         CvrU716KpBfL7JabFqlanu37nhj739r7IeynpzZ0SJo/DzJyRJAoOrgrHgtxMq5i+yLF
         BAGdTZByHbBu9OT5idjwmQ5eHFOc0+IhrLNcRmRc14Md+K8p9imCrojKEKoJPj+iIU5m
         uXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700509623; x=1701114423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k63y0ImIMzxwhoXgElC40ZBYzHWgYpN897FOa0LAhXo=;
        b=siFBTGhPl8TPkv3FShbh93uyg2Kf5rvGYL17+CXR1yXZQzWtSJKj8N/wYwQcXjjGvb
         dsWRpMvbrZGYsi8gH0JiG2ID7+AcVa3+6uOQ3TXUmqTAO4VsYkA/Hh0L3urGkceOJXhi
         fGXaQJt2n86n32de71Uz+4pgk9gsTd44dFu75/1oopLexW9ZKp5Ui/xCE9yMh/IyMiZF
         P8JHtq60yfmhsdKmwWcWGGKsCshVxLh/WQoc02G30VmWUA19w0vaxDC5dQ3gRJ6K4Mru
         4lTFj0N0McG0p70t2UzSkJ0qZrPEAI9P5eYm3QJCEM2i+QFBldTm7m2sM7vhjk6kWaOX
         0GQw==
X-Gm-Message-State: AOJu0Yw6gZo40uabNOt7B/bjObuodLHYInkhKds9Hd5Rw6Skq+HG9pwH
        8YIM13vX4mk+fmuchFs0cUuB8E/koQ8n1vEITesFkQ==
X-Google-Smtp-Source: AGHT+IFcP9Bi77QpumgXWYcYlyZBFp9cVOTTuzfplw5aXvIURHzOjITODIQ80+1AZypInFxLgyl/s1nd/Te+pEN9yGs=
X-Received: by 2002:a2e:9912:0:b0:2c5:3a9:7467 with SMTP id
 v18-20020a2e9912000000b002c503a97467mr5808973lji.8.1700509622610; Mon, 20 Nov
 2023 11:47:02 -0800 (PST)
MIME-Version: 1.0
References: <20231117-maintainers-v1-1-85f2a7422ed9@google.com>
In-Reply-To: <20231117-maintainers-v1-1-85f2a7422ed9@google.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Mon, 20 Nov 2023 11:46:49 -0800
Message-ID: <CAFhGd8qLEoJGuur8KVO8=ijUF_O_XgcaABwTp+aZ2W6bxmfy5Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: refresh LLVM support
To:     ndesaulniers@google.com
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>, Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Nov 17, 2023 at 11:24=E2=80=AFAM <ndesaulniers@google.com> wrote:
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

Thanks for all the hard work Nick! The ClangBuiltLinux project wouldn't be
where it is today without your contributions and leadership.

Justin
