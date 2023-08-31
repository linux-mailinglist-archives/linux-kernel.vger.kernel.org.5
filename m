Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F118678F4C5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346192AbjHaVlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjHaVlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:41:50 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8E911B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:41:46 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-64a8826dde2so7492686d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693518106; x=1694122906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6EyUV5AIADigxtAZQirTseOSVmlDyjeFuLsITzk200=;
        b=Vct3GsZ6sZqZUb0TJC3TXNbWsdFlrNqYzZGZSepC/telpZ3rM7SllRGZQYClQpl2kI
         iCvyXqnILXiJi3U7GI9lzUpxL/m2isNKc0fCNOY9WIekRosk+I++JAdLMDjq0+h+4mqZ
         vtSnJVC/QutFZlwsQvRLCUQDuyWPE/nsUfv6Vn6ZCk92VP52QDsT1bphEs98zQcyOQ+Q
         aPaHKpSqHKIOE7SoreVrH4J7XXE2qkoTKy3If8I2VFwzb7SI10RF3H6zxXDrciCnCyFu
         I/omX+XaeXObu0mvRaemI6Kh4ZsMDM8PamK5hxnk8lc0NuIqGYj49bedYFLW1+7V4uUn
         IQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693518106; x=1694122906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6EyUV5AIADigxtAZQirTseOSVmlDyjeFuLsITzk200=;
        b=WNgm0iWFw6V4flPXz5bby0CW3GQhDBnkxWhHdX4w/QvoknEYqKKKq6FL4ZZuVzoNr1
         IM7iiW9M2rR8EXOhouu9OfkxtSIcghHeF0yJyI3wCvRY/p5l7Pe8waQ6sela/ogy35F6
         sQaF9Mvvk7r6W0VJ5VhPoZl8IJy/4qHeQ/Lbg16QsAU9C5oHjMdlw/+5cchPR66nU6z9
         2u13vev3YeG8ZsC6sAz+2kSgXPhglnwOIomj3kqQPPNnHBIgkxxcXR4gWS03aA3iMT0C
         iG8a8Viu4s03nf706D+Ezu0WVS2UEN6nKrA9IFNJCshkSlN0LeTI6sNLmVUmxcwED4at
         CUGQ==
X-Gm-Message-State: AOJu0YwDgFhXPBLNIpXimmDPgF3OvhJIJBKHygomR8mSEATKvI4ot1TK
        LTG6/+f1L8VLBvtpj9cVgu1tLbPq20wc5dtgX8w5hw==
X-Google-Smtp-Source: AGHT+IGxoP6SHPHqVHZs1D0kiIkGb5R071xC22qGM31a+vuVtjoP+27tmflqMxvtRHy65qHz3RLJTbR1jjJLZ+/Daoc=
X-Received: by 2002:a0c:e00b:0:b0:636:1aae:1bcc with SMTP id
 j11-20020a0ce00b000000b006361aae1bccmr479228qvk.39.1693518105881; Thu, 31 Aug
 2023 14:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdn0xoVWjQ6ufM_rojtKb0f1i1hW-J_xYGfKDNFdHwaeHQ@mail.gmail.com>
 <9d2bb495-0c1d-0d1b-96ea-4b1110d45b79@gmx.de> <ZPEEzkQcQOP9yVFF@ls3530>
In-Reply-To: <ZPEEzkQcQOP9yVFF@ls3530>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 31 Aug 2023 14:41:31 -0700
Message-ID: <CAKwvOdkXmEe46cG9Hn837215ghWA7UNKtg7ZQM8CpQcEQnoWfg@mail.gmail.com>
Subject: Re: truncation in drivers/video/fbdev/neofb.c
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 2:23=E2=80=AFPM Helge Deller <deller@gmx.de> wrote:
>
> * Helge Deller <deller@gmx.de>:
> > On 8/29/23 18:45, Nick Desaulniers wrote:
> > > A recent change in clang made it better about spotting snprintf that
> > > will result in truncation.  Nathan reported the following instances:
> > >
> > > drivers/video/fbdev/neofb.c:1959:3: warning: 'snprintf' will always b=
e
> > > truncated; specified size is 16, but format string expands to at leas=
t
> > > 17 [-Wfortify-source]
>
> FYI, I've added the patch below to the fbdev for-next git tree.
>
> Helge
>
> From: Helge Deller <deller@gmx.de>
> Subject: [PATCH] fbdev: neofb: Shorten Neomagic product name in info stru=
ct
>
> Avoid those compiler warnings:
> neofb.c:1959:3: warning: 'snprintf' will always be truncated;
>    specified size is 16, but format string expands to at least 17 [-Wfort=
ify-source]
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Link: https://lore.kernel.org/all/CAKwvOdn0xoVWjQ6ufM_rojtKb0f1i1hW-J_xYG=
fKDNFdHwaeHQ@mail.gmail.com/
> Link: https://github.com/ClangBuiltLinux/linux/issues/1923

This indeed makes the warning go away, but that's more so due to the
use of strscpy now rather than snprintf.  That alone is a good change
but we still have definite truncation.  See below:

>
> diff --git a/drivers/video/fbdev/neofb.c b/drivers/video/fbdev/neofb.c
> index d2f622b4c372..b905fe93b525 100644
> --- a/drivers/video/fbdev/neofb.c
> +++ b/drivers/video/fbdev/neofb.c
> @@ -1948,49 +1948,40 @@ static struct fb_info *neo_alloc_fb_info(struct p=
ci_dev *dev,
>
>         switch (info->fix.accel) {
>         case FB_ACCEL_NEOMAGIC_NM2070:
> -               snprintf(info->fix.id, sizeof(info->fix.id),
> -                               "MagicGraph 128");
> +               strscpy(info->fix.id, "MagicGraph128", sizeof(info->fix.i=
d));
>                 break;
>         case FB_ACCEL_NEOMAGIC_NM2090:
> -               snprintf(info->fix.id, sizeof(info->fix.id),
> -                               "MagicGraph 128V");
> +               strscpy(info->fix.id, "MagicGraph128V", sizeof(info->fix.=
id));
>                 break;
>         case FB_ACCEL_NEOMAGIC_NM2093:
> -               snprintf(info->fix.id, sizeof(info->fix.id),
> -                               "MagicGraph 128ZV");
> +               strscpy(info->fix.id, "MagicGraph128ZV", sizeof(info->fix=
.id));
>                 break;
>         case FB_ACCEL_NEOMAGIC_NM2097:
> -               snprintf(info->fix.id, sizeof(info->fix.id),
> -                               "MagicGraph 128ZV+");
> +               strscpy(info->fix.id, "Mag.Graph128ZV+", sizeof(info->fix=
.id));

I see the Mag.Graph change here; I'm curious why MagicGraph256XL+
didn't need that, too?

MagicGraph128ZV+
MagicGraph256XL+

those look like the same number of characters; are they? Does this one
need the `.` change?

```
diff --git a/drivers/video/fbdev/neofb.c b/drivers/video/fbdev/neofb.c
index b905fe93b525..6b7836f7f809 100644
--- a/drivers/video/fbdev/neofb.c
+++ b/drivers/video/fbdev/neofb.c
@@ -1957,7 +1957,7 @@ static struct fb_info *neo_alloc_fb_info(struct
pci_dev *dev,
                strscpy(info->fix.id, "MagicGraph128ZV", sizeof(info->fix.i=
d));
                break;
        case FB_ACCEL_NEOMAGIC_NM2097:
-               strscpy(info->fix.id, "Mag.Graph128ZV+", sizeof(info->fix.i=
d));
+               strscpy(info->fix.id, "MagicGraph128ZV+", sizeof(info->fix.=
id));
                break;
        case FB_ACCEL_NEOMAGIC_NM2160:
                strscpy(info->fix.id, "MagicGraph128XD", sizeof(info->fix.i=
d));

```
Builds without error for me.  Though I guess the compiler doesn't know
what strscpy is semantically.

Ah
MagicGraph128ZV+
MagicGraph256XL+

are both 17 characters. (16 literal characters + trailing NUL)

So MagicGraph256XL+ (and MagicGraph256AV+) below will fail to copy the
NUL from the source, then overwrite the `+` with NUL IIUC.

There's no ambiguity for MagicGraph256XL+, but now MagicGraph256AV+
would look like MagicGraph256AV which is another possible variant.

Then perhaps MagicGraph256XL+ MagicGraph256AV+ and below might need to chan=
ge.

Sorry, initially it looked like a simple fix and I was ready to sign
off on it; I hope I'm mistaken.  Thank you for the patch, but do
consider sending it to the ML for review before committing.

>                 break;
>         case FB_ACCEL_NEOMAGIC_NM2160:
> -               snprintf(info->fix.id, sizeof(info->fix.id),
> -                               "MagicGraph 128XD");
> +               strscpy(info->fix.id, "MagicGraph128XD", sizeof(info->fix=
.id));
>                 break;
>         case FB_ACCEL_NEOMAGIC_NM2200:
> -               snprintf(info->fix.id, sizeof(info->fix.id),
> -                               "MagicGraph 256AV");
> +               strscpy(info->fix.id, "MagicGraph256AV", sizeof(info->fix=
.id));
>                 info->flags |=3D FBINFO_HWACCEL_IMAGEBLIT |
>                                FBINFO_HWACCEL_COPYAREA |
>                                FBINFO_HWACCEL_FILLRECT;
>                 break;
>         case FB_ACCEL_NEOMAGIC_NM2230:
> -               snprintf(info->fix.id, sizeof(info->fix.id),
> -                               "MagicGraph 256AV+");
> +               strscpy(info->fix.id, "MagicGraph256AV+", sizeof(info->fi=
x.id));
>                 info->flags |=3D FBINFO_HWACCEL_IMAGEBLIT |
>                                FBINFO_HWACCEL_COPYAREA |
>                                FBINFO_HWACCEL_FILLRECT;
>                 break;
>         case FB_ACCEL_NEOMAGIC_NM2360:
> -               snprintf(info->fix.id, sizeof(info->fix.id),
> -                               "MagicGraph 256ZX");
> +               strscpy(info->fix.id, "MagicGraph256ZX", sizeof(info->fix=
.id));
>                 info->flags |=3D FBINFO_HWACCEL_IMAGEBLIT |
>                                FBINFO_HWACCEL_COPYAREA |
>                                FBINFO_HWACCEL_FILLRECT;
>                 break;
>         case FB_ACCEL_NEOMAGIC_NM2380:
> -               snprintf(info->fix.id, sizeof(info->fix.id),
> -                               "MagicGraph 256XL+");
> +               strscpy(info->fix.id, "MagicGraph256XL+", sizeof(info->fi=
x.id));
>                 info->flags |=3D FBINFO_HWACCEL_IMAGEBLIT |
>                                FBINFO_HWACCEL_COPYAREA |
>                                FBINFO_HWACCEL_FILLRECT;



--=20
Thanks,
~Nick Desaulniers
