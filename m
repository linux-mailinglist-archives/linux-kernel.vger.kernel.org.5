Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DD378E089
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbjH3UXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbjH3UWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:22:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C73CD22
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:14:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so664a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693426361; x=1694031161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbpX7Qm/dETVLLemaRynaMls7QRWhrvzeY0G4OaMlZI=;
        b=cudGavPuWCgkM6ixziFgYXt0A5xySkSaoXC6GMnUNVA7uplvUyc9/U6iViTC1oPtgW
         mcGF9zNogTHQ6WjTcCNPrZJhBM6lD0Gkc3YYlLPgs31vXXraVLWtiN9b9MWmtpP5kJKy
         +hCKW8EtLo9kOMzM+rPRhh/ECos5iExHSExYu/MTStRJ/v2dKUKjTa9+1ZyS7rXumKgK
         DXBZRdhao7gTzvcOBJHAdwuwnp24ZAsBCa01kOZ0noWGUE7Y3v1vD4C/HjG/DwOqprIQ
         0Xn9ZyHCm2EtBw6I3G9dWz+4HMokZp1q+hTlpnL1uzI/bdl6EEuZ1CTJsnCLEFj+u4Rr
         CAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693426361; x=1694031161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbpX7Qm/dETVLLemaRynaMls7QRWhrvzeY0G4OaMlZI=;
        b=CxTfLzaygecFzxl4YD2dvGyTqiS0TgLXbrB+Khyon4zPQDAthjgAJxBTMWVPvyj95w
         q+Nq/TkXtk5lwn4HAHzrCbOImIj8ynATRUcHJQJX4oJNfdYHz1aJx2t6OYeC9sRa0Dxw
         YBISZLuwr3o/ahVgiMUqbrlGRYyZhEo1Swt0TcsZQsAJ+DM4qjsfNWWXJT5XZJVUPxSg
         6/y9/HVB3Bw8JyIOwSOuekvg1sUL7oAzaQKVk38JTsxN0rCOOSEOjofQ+GgClSLlk2s8
         IUTz1g6WgCxmUrZhvATS5j/ZPKEoHuVWCFHYOv5st3vf+DBaO7gZTo+SHzJRhImREiF7
         dytA==
X-Gm-Message-State: AOJu0Yy1ZwcLaew52fE5DD736FO8JnJ9p28COfTyijHz5l46CKxPiSD+
        iEBPZ5yhASUE+MD/rlMkfLOdkyKrWJgjD7sX1QtjZsfA9sWUyW0Uy0O/
X-Google-Smtp-Source: AGHT+IEi37o1xhf+eU9hWiCam4YF+08bGRgrEaTqOlInAjmyZ3oWswzinbbMB923UGvcpg0VQbNuuRL0cwenJg9UEEU=
X-Received: by 2002:a50:8ad1:0:b0:522:cc9c:f5a4 with SMTP id
 k17-20020a508ad1000000b00522cc9cf5a4mr30588edk.4.1693425844947; Wed, 30 Aug
 2023 13:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230830-missingvardecl2-init-main-c-v1-1-59007a637259@google.com>
In-Reply-To: <20230830-missingvardecl2-init-main-c-v1-1-59007a637259@google.com>
From:   Bill Wendling <morbo@google.com>
Date:   Wed, 30 Aug 2023 13:03:46 -0700
Message-ID: <CAGG=3QVh+m00OirP0wLb1VzkO+Z6J4Cur+65x+oi4ZuQ1eHTYg@mail.gmail.com>
Subject: Re: [PATCH] init: fix -Wmissing-variable-declarations clang warning
To:     Justin Stitt <justinstitt@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

On Wed, Aug 30, 2023 at 12:47=E2=80=AFPM Justin Stitt <justinstitt@google.c=
om> wrote:
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
> Move the extern declaration to a header file so that the compiler can fin=
d it
> when compiling init/main.c.
>
> Add `const` qualifier to extern declaration so that the types match and
> we follow the One-Definition Rule (ODR).
>
I'm not sure the lack of a "const" has anything to do with the ODR.
C's type system isn't nearly as strict as C++'s. :-) That said, adding
"const" is definitely correct.

-bw

> Link: https://github.com/ClangBuiltLinux/linux/issues/1920
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
>
> There's a previous RFC [1] wherein the kernel test robot reported some
> build errors which lead me to creating this patch which both fixes the
> errors as well as the -Wmissing-variable-declarations warning.
>
> [1]: https://lore.kernel.org/all/20230829-missingvardecl-init-main-c-v1-1=
-ddf0f1a71215@google.com/
>
> Also, get_maintainer.pl had a hard time finding folks to Cc here, not sur=
e why.
> ---
>  include/linux/initrd.h  | 2 ++
>  init/do_mounts_initrd.c | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/initrd.h b/include/linux/initrd.h
> index f1a1f4c92ded..0114f1acbb45 100644
> --- a/include/linux/initrd.h
> +++ b/include/linux/initrd.h
> @@ -34,4 +34,6 @@ extern unsigned long __initramfs_size;
>
>  void console_on_rootfs(void);
>
> +extern const char *envp_init[];
> +
>  #endif /* __LINUX_INITRD_H */
> diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
> index 425f4bcf4b77..b35c1b0babc2 100644
> --- a/init/do_mounts_initrd.c
> +++ b/init/do_mounts_initrd.c
> @@ -87,7 +87,6 @@ static void __init handle_initrd(char *root_device_name=
)
>  {
>         struct subprocess_info *info;
>         static char *argv[] =3D { "linuxrc", NULL, };
> -       extern char *envp_init[];
>         int error;
>
>         pr_warn("using deprecated initrd support, will be removed in 2021=
.\n");
>
> ---
> base-commit: 706a741595047797872e669b3101429ab8d378ef
> change-id: 20230830-missingvardecl2-init-main-c-93dc1013ff8a
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>
>
