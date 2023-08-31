Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DB178F560
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 00:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347691AbjHaW1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 18:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347679AbjHaW05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:26:57 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C6710C7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:26:50 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-64f3ad95ec0so7740376d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693520809; x=1694125609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKlkGKYCgrWeKXNqJyo7pWKtqd+Hx7OjZxfb5gEIfrY=;
        b=7F/4UpZ7Y+b/BR4O47KEKyVhVx2if6ZZiWPTDI5kzz2GYSHQ4eiTNko+FWdKaRQh/f
         UY7KHi6Nf5caP0Bck86dXjFFIgPunouEc9bLMFgcACMLUQGai2TRbkg2KCMYvuUhx6o4
         iWqWGt6zc0u2BsqFV7gAnNvz1xEn14fx0HKIAYKnUguSotEEsiE//8uFziHblIuyesWo
         LgyhcWupLmEp7ckDssYZ8aojdSxDYuVlWvuCPmManMLcNZLueBln6w54C0Mt1wXGgmNx
         COo+gOjoU8mDPlB/pIweeKaGzIWjVVAUvrgFRxH6YnsYyLKijnRloIaEwyIwXFhFZKNL
         hWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693520809; x=1694125609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKlkGKYCgrWeKXNqJyo7pWKtqd+Hx7OjZxfb5gEIfrY=;
        b=j6867DsgNu7oJccxaQaXt5NGMioHLLL3wtEyfSO8l+83PzEnrREVtPMxKrOl05v3Za
         A0gwWDrHE8SQ/8EZRM+ATRoxDsZztNdiEgIu5cm9OrTrbWG0KBF9L0fq4guDYYBMuk9x
         g4GukFLrLGRA4LVcDAOuOtIHl/SvmcGgonEMOCrY5fQUFVZeLclpbOowYzNl1rIc9YwL
         jrp86NL0WEFJ6veQIcFNAj8WVeMp5fIJh7w3wAncx/YFwLBBG0l/4IYM+GJWl0dL10oP
         zliAv/oh7ZnKbZzU05tFQoG0UJNP2blK9P9PAlDEwLG3fTsN5wj6gBSEPAx5shMfAfik
         Lv4w==
X-Gm-Message-State: AOJu0Yyp2Zm1SFFdbuUcxZu2BnY0vj6fo5S6aMzyA/ndnQl2J8jGYNMY
        +kCalO9S0yHhzhkHhCNV9tp8onB750Fu2QJO2wp80w==
X-Google-Smtp-Source: AGHT+IHqutLf/Ndx2phVAuqZjb5qjCQ920NGHqHCD34nUPgPY+PJcMk8FLCrkS7O1NZpBb1oQRUn/bM3dMgktFBGgQY=
X-Received: by 2002:ad4:45aa:0:b0:64c:e8a3:fb68 with SMTP id
 y10-20020ad445aa000000b0064ce8a3fb68mr646024qvu.3.1693520809085; Thu, 31 Aug
 2023 15:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdn0xoVWjQ6ufM_rojtKb0f1i1hW-J_xYGfKDNFdHwaeHQ@mail.gmail.com>
 <9d2bb495-0c1d-0d1b-96ea-4b1110d45b79@gmx.de> <ZPEEzkQcQOP9yVFF@ls3530>
 <CAKwvOdkXmEe46cG9Hn837215ghWA7UNKtg7ZQM8CpQcEQnoWfg@mail.gmail.com> <ZPERGqgkUwcWvr+4@ls3530>
In-Reply-To: <ZPERGqgkUwcWvr+4@ls3530>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 31 Aug 2023 15:26:35 -0700
Message-ID: <CAKwvOdkqZwF_HqyPhm3hxOVpsWqhN4X=bwUw66=ZkPSpwGpLAA@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 3:16=E2=80=AFPM Helge Deller <deller@gmx.de> wrote:
>
> * Nick Desaulniers <ndesaulniers@google.com>:
> > On Thu, Aug 31, 2023 at 2:23=E2=80=AFPM Helge Deller <deller@gmx.de> wr=
ote:
> > >
> > > * Helge Deller <deller@gmx.de>:
> > > > On 8/29/23 18:45, Nick Desaulniers wrote:
> > > > > A recent change in clang made it better about spotting snprintf t=
hat
> > > > > will result in truncation.  Nathan reported the following instanc=
es:
> > > > >
> > > > > drivers/video/fbdev/neofb.c:1959:3: warning: 'snprintf' will alwa=
ys be
> > > > > truncated; specified size is 16, but format string expands to at =
least
> > > > > 17 [-Wfortify-source]
> > >
> > > FYI, I've added the patch below to the fbdev for-next git tree.
> > > [...]
> >
> > This indeed makes the warning go away, but that's more so due to the
> > use of strscpy now rather than snprintf.  That alone is a good change
> > but we still have definite truncation.  See below:
> > [...]
>
> Nick, thanks for your review and findings!
> Now every string should be max. 15 chars (which fits with the trailing
> NUL into the char[16] array).
>
> Helge
>
>
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

ah yeah LGTM

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> diff --git a/drivers/video/fbdev/neofb.c b/drivers/video/fbdev/neofb.c
> index d2f622b4c372..b58b11015c0c 100644
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
> +               strscpy(info->fix.id, "Mag.Graph256AV+", sizeof(info->fix=
.id));
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
> +               strscpy(info->fix.id, "Mag.Graph256XL+", sizeof(info->fix=
.id));
>                 info->flags |=3D FBINFO_HWACCEL_IMAGEBLIT |
>                                FBINFO_HWACCEL_COPYAREA |
>                                FBINFO_HWACCEL_FILLRECT;
>


--=20
Thanks,
~Nick Desaulniers
