Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AD27F1DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjKTUWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKTUWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:22:31 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D30CD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 12:22:27 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso2999a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 12:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700511746; x=1701116546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKQchH0KG/ka3pq4IDflhEafmYdf5otEPRjqnY14Sx4=;
        b=WqXrCEPXCK7s1YTJv0f2CDZHy/XzsZrCM9bEO25Uajke/cJBI+ggj92IneKYk5pevg
         +VaRrFIH3vqYWnC/nhwuRQo2Xj9weuP5jknOUyiqCI+yzkqb7P12Cyz+/kkR4G/VKbP0
         /CGVmGhsRuRzfZ2MCb2i7MBr1ieDP/U+dKEqZfCDxZy6x4dayZ5ujkg+YLM+j1i/kFqP
         Rp2S3PT1j5EiGZiAezBQThHeZQbogbzEFQRzjdDl4mndoWyv/C9m7mLTXPlgp7wfaoGM
         eOBkMT7fztgvuCWO1eM+TFHyt+sYp6u5uuDaRef/WTRThCVDbE6djmwaGMncyCmmoivw
         XmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700511746; x=1701116546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKQchH0KG/ka3pq4IDflhEafmYdf5otEPRjqnY14Sx4=;
        b=equCrFX8SlWPHTCdvFzxiM8gSIk9N6ZmnCsy+W0TZ6wgDidnv0Ew1WdG8zYxzNSYOp
         J+pTTJRD+eaVhtY6QKCyFNGRhQDC/jE7uzdw9+gEzhvwT151lP+InSCljizW5UopkebV
         PbTLtAM/oggHrcZiiCkJ+ii4JRIAaoTVYEEJkUtArMDEt93+NEuYduXbS7aeX4WEg6IC
         Za74d1BGIxz3/dyhc2uBhjvN7OlECpcnGwL7dsJtUhmw08EnkfRb1L4qvXghwWYtE76Y
         AaMPPNHiP8eodEbf7L4Nvf82euBaYanuXb/34Zp3w6GUyCwaQblxhHdYBsHpDu5M+op6
         vMOg==
X-Gm-Message-State: AOJu0YzLOmCCJ/lWbWxcnW6glVQ7zWlgmrrWiVZbpu9ztufB/EWez2R2
        DpXd0rzlSyak0ISwDgaEG/2zK39WvGYBzIG8+mAy
X-Google-Smtp-Source: AGHT+IFSaY9sZiHPmdbardRNSWpqGFpsxku70pLHjUVi59i+tqerL9K9fVTstzns+Euj3IuDIlVmq2bo+v/xt5rW60Q=
X-Received: by 2002:a05:6402:514f:b0:545:94c:862e with SMTP id
 n15-20020a056402514f00b00545094c862emr305076edd.2.1700511745653; Mon, 20 Nov
 2023 12:22:25 -0800 (PST)
MIME-Version: 1.0
References: <20231117-maintainers-v1-1-85f2a7422ed9@google.com>
In-Reply-To: <20231117-maintainers-v1-1-85f2a7422ed9@google.com>
From:   Bill Wendling <morbo@google.com>
Date:   Mon, 20 Nov 2023 12:22:09 -0800
Message-ID: <CAGG=3QV6Uk=YUTiP2KZqox9RD=dhBujx_8rQoT_5tbTmE85Eig@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: refresh LLVM support
To:     ndesaulniers@google.com
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Acked-by: Bill Wendling <morbo@google.com>

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
