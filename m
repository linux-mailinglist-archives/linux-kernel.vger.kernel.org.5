Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2208F79C0AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbjIKUvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjIKUqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:46:34 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237D5118
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:46:29 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-770ef4d36f2so180903285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694465188; x=1695069988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfbFEpTKfUuP4aETijqFfdDlNmxSym5xW5z+8x33k70=;
        b=rM7aC/ZvhdbxwTNywP586VCCYg5o/kdZXZWNpqVdKbhsdSCFp/n7k0CgCSKgc721Q8
         Vf8iyuK9WLScxd4azBvRtJ3orsCg5MesnjABQzL5tVCY97ixQWNFM7Fz98ZuCIJkd3tf
         6h4ueNIRofwR/9/CnB/roR7OqGjpPUJN8JOGjv1Ip96rC0cdqA6sZ2RlEIxGKEe9o8kb
         /oevqxcPB0Ai8I+NCzZLeYeqkRfTBba3BA73vN70ikN4ombacO13FIQTCHH6xkyl9iwT
         PxwiBCLU6iZTsp1FKN13a5gD/Bo0lTyiNn0uUW+pU1vDgi47oI2oY1PeDHcjJGncYOP2
         dA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694465188; x=1695069988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfbFEpTKfUuP4aETijqFfdDlNmxSym5xW5z+8x33k70=;
        b=GGRGtbz+qaWBTZAU8cWBc6I4eRYllN0wrUqCAe4ZpeHuDbhCC5cy8OXnwjG5+/y7yZ
         ZA3h9hdF9lkZi65Z74TVwlK0ry8AxNdmfcwtM9y9zWbtJSaPgqDjWcv8Wt6reOzBGV59
         ydHJihK8tDxailRddF8r0S0QQIAIQpdAemdh3fPkK/eZMjChidnYSIWk0pAOQ4nW9hFU
         1Khl99W+5Imb8QriWit5ohxGzMl0SJWfN4CVI7LYcpROTd3oZKM+m5B34RM7nEusl9Jv
         vNL4HWDOKPAIdZd+0hw0/AdWMD2ZF3PFEY/M/vo2wNCgyy1dvPqZ75ZHeP6nZkI2ASk5
         OF6A==
X-Gm-Message-State: AOJu0YxEcMGSkH99Y4EOTgff28PXIsUiS2vb10njFRMtT7nrMRRhShB6
        JzprhU8ZX+YhF2gS+3HVwuQoG4PGbD+KvuU7IkOgKQ==
X-Google-Smtp-Source: AGHT+IEtqLjTeVXxu++lV0mt1ISqKfKmwWtzV7NW49kNL492TJ4cBfRQOurjWHhFzi4F9H+Y4iIEGiog34FbQBt8pRg=
X-Received: by 2002:a0c:dc13:0:b0:64f:3bec:9b29 with SMTP id
 s19-20020a0cdc13000000b0064f3bec9b29mr12022165qvk.39.1694465187700; Mon, 11
 Sep 2023 13:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230905-missingvardecl2-init-main-c-v2-1-08498a9cf740@google.com>
In-Reply-To: <20230905-missingvardecl2-init-main-c-v2-1-08498a9cf740@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 Sep 2023 13:46:13 -0700
Message-ID: <CAKwvOd=uqAf3bX=5FTQ2JdvLmN7m4rS55cXuT01xbRqBN21NaQ@mail.gmail.com>
Subject: Re: [PATCH v2] init: fix -Wmissing-variable-declarations clang warning
To:     Justin Stitt <justinstitt@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Bill Wendling <morbo@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 3:43=E2=80=AFPM Justin Stitt <justinstitt@google.com=
> wrote:
>
> When building x86/defconfig with Clang-18 I encounter the following warni=
ng:
> | init/main.c:189:13: warning: no previous extern declaration for non-sta=
tic variable 'envp_init' [-Wmissing-variable-declarations]
> |   189 | const char *envp_init[MAX_INIT_ENVS+2] =3D { "HOME=3D/", "TERM=
=3Dlinux", NULL, };
> | init/main.c:189:7: note: declare 'static' if the variable is not intend=
ed to be used outside of this translation unit
> |   189 | const char *envp_init[MAX_INIT_ENVS+2] =3D { "HOME=3D/", "TERM=
=3Dlinux", NULL, };
>
> Make `envp_init` static and provide `handle_initrd` its own copy.
>
> This silences the warning and makes the code more readable as you no
> longer have to track down extern definitions inside of `handle_initrd`.
> It is now more self-contained.

But this is now creating duplicate string arrays in the kernel image.

Why can't this be:
1. declared in include/linux/initrd.h
2. defined in init/main.c
3. referenced in init/do_mounts.c

The extern declaration in init/do_mounts_initrd.c isn't even correct!
It's missing a `const`! That's the kind of monkey business this
warning is trying to help avoid. C has headers for this reason, let's
use them.

Perhaps users of call_usermodehelper_setup need an update, or
envp_init actually should not be const.

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1920
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> The kernel test robot didn't like v1 of this patch and I prefer Kees'
> approach to simplifying this code anyways so I'm sending this v2.
> Hopefully the CI builds clean (as I am locally using their repro).
>
> Changes in v2:
> - Make envp_init static and provide handle_initrd() with a copy (thanks K=
ees)
> - Rebase onto mainline (2dde18cd1d8fa)
> - Link to v1: https://lore.kernel.org/r/20230830-missingvardecl2-init-mai=
n-c-v1-1-59007a637259@google.com
> ---
> Note: build-tested only.
>
> It should be noted that `handle_initrd` has been marked as deprecated
> and perhaps the entire thing can be removed as per it's own message:
> | using deprecated initrd support, will be removed in 2021.
> ---
>  init/do_mounts_initrd.c | 4 ++--
>  init/main.c             | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
> index 425f4bcf4b77..154bd0de85a6 100644
> --- a/init/do_mounts_initrd.c
> +++ b/init/do_mounts_initrd.c
> @@ -87,7 +87,7 @@ static void __init handle_initrd(char *root_device_name=
)
>  {
>         struct subprocess_info *info;
>         static char *argv[] =3D { "linuxrc", NULL, };
> -       extern char *envp_init[];
> +       static char *envp[] =3D { "HOME=3D/", "TERM=3Dlinux", NULL, };
>         int error;
>
>         pr_warn("using deprecated initrd support, will be removed in 2021=
.\n");
> @@ -100,7 +100,7 @@ static void __init handle_initrd(char *root_device_na=
me)
>         init_mkdir("/old", 0700);
>         init_chdir("/old");
>
> -       info =3D call_usermodehelper_setup("/linuxrc", argv, envp_init,
> +       info =3D call_usermodehelper_setup("/linuxrc", argv, envp,
>                                          GFP_KERNEL, init_linuxrc, NULL, =
NULL);
>         if (!info)
>                 return;
> diff --git a/init/main.c b/init/main.c
> index ad920fac325c..9a473107bb8f 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -186,7 +186,7 @@ static int __init set_reset_devices(char *str)
>  __setup("reset_devices", set_reset_devices);
>
>  static const char *argv_init[MAX_INIT_ARGS+2] =3D { "init", NULL, };
> -const char *envp_init[MAX_INIT_ENVS+2] =3D { "HOME=3D/", "TERM=3Dlinux",=
 NULL, };
> +static const char *envp_init[MAX_INIT_ENVS+2] =3D { "HOME=3D/", "TERM=3D=
linux", NULL, };
>  static const char *panic_later, *panic_param;
>
>  static bool __init obsolete_checksetup(char *line)
>
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230830-missingvardecl2-init-main-c-93dc1013ff8a
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>


--=20
Thanks,
~Nick Desaulniers
