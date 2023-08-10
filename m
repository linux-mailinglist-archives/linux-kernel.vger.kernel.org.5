Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364E2778297
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjHJVR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjHJVRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:17:55 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570062738
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:17:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe8c3b5ca0so2078562e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691702273; x=1692307073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mB5FHvaw40P9yBP+ozNkgvaUvFsznWaEsCNsx7UegGc=;
        b=SipkOJu9CvcAS02mXC7GaemEiJBBqKhJmFyQFkYw943BmDUzmE7hk1WoIh4iJ5LJDO
         5WKJMoRrgWYaf1hIsQTB1Kg0XrbHspHcJfySFlcFbmSComEuMjWmEE5cITAys2FdLwxO
         NmvxPIuVWWClRGwPuuweVWsASSMUR3NCOnhy0ZNeN7FAOeKDlBzMnw/GckW7MnPfOGDz
         PdjYtOz6cDwShSPinaze+oKFYA06doDu2J9pTmhPUDR6DLTmkVVZyrYS4maAwMWrsHTj
         3deJGULAMRatIHVxcoNsHi0FOI/6YzMwc/+QujX7XcJaG4xpShRMX5KVd+jwL2x39Ttv
         oMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702273; x=1692307073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mB5FHvaw40P9yBP+ozNkgvaUvFsznWaEsCNsx7UegGc=;
        b=jdlcEdX3XbFWFRgqxIMnI1pcNbwlEU8Y0f6+ZfXiiC8xLXW/6TWFMsxeZuH2u0a9xV
         gx2Tm3Qo9vTvjNWYIPbMzwMoGq+mxGxFszm8kwdCz16KuFy80AVNkYyrZO4+/H/CCj4i
         G3nsE40Zz3rmFvxpwieCFeo0Pa23XkgA8bkjDK9I9r73m7txe5Tyy/CB6p5PN6p8DwR1
         hIp4o2EKt0J+LB5ziB/ao9vfHfWxZIc6yoAVLVQX1PVIxRCzIYQuYPpOEgTK+46vZAPd
         ML3SVT8psbsh+0mHaOajKVlaMPhIosEr/YxT+VtLhlaNcGgnfaRq3Z+BU3ii5eJwj+oq
         jKEw==
X-Gm-Message-State: AOJu0YwgNcrbYGAoJC4jxLb1jzWCkDYgxnTnlgZ4RCotnFOYjYPTj3B+
        PuLu19h5WJNMC8WWPF+Ekl3PUtEF9t2aqAYV3VRT0Q==
X-Google-Smtp-Source: AGHT+IGe/kJwlOMqtTmyNhT0OGT4bd4sdq3krj53YNPiivHF3GSx2GIkfsMCEBjOuvuNK2tWeNiNC0hfyVzwhgTVkkI=
X-Received: by 2002:a05:6512:3256:b0:4f3:b588:48d0 with SMTP id
 c22-20020a056512325600b004f3b58848d0mr2615647lfr.14.1691702273438; Thu, 10
 Aug 2023 14:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230810-strncpy-arch-arm64-v1-1-f67f3685cd64@google.com>
 <202308101155.81497C5B@keescook> <CAFhGd8rfKLY5KujEdvSnqv2MZFhTbEBo_bi7xVacY1pcBC1jRg@mail.gmail.com>
 <202308101257.47E6ACBD5@keescook>
In-Reply-To: <202308101257.47E6ACBD5@keescook>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 10 Aug 2023 14:17:41 -0700
Message-ID: <CAFhGd8pa0UFFG3M39YttrfSQj0aO-Xq70XVQpcLM0X6pD9wECQ@mail.gmail.com>
Subject: Re: [PATCH] arm64/sysreg: refactor deprecated strncpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

On Thu, Aug 10, 2023 at 12:58=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Thu, Aug 10, 2023 at 12:25:37PM -0700, Justin Stitt wrote:
> > On Thu, Aug 10, 2023 at 12:00=E2=80=AFPM Kees Cook <keescook@chromium.o=
rg> wrote:
> > >
> > > On Thu, Aug 10, 2023 at 06:39:03PM +0000, Justin Stitt wrote:
> > > > `strncpy` is deprecated for use on NUL-terminated destination strin=
gs
> > > > [1]. Which seems to be the case here due to the forceful setting of=
 `buf`'s
> > > > tail to 0.
> > >
> > > Another note to include in these evaluations would be "does the
> > > destination expect to be %NUL padded?". Here, it looks like no, as al=
l
> > > the routines "buf" is passed to expect a regular C string (padding
> > > doesn't matter).
> > >
> > > >
> > > > A suitable replacement is `strscpy` [2] due to the fact that it
> > > > guarantees NUL-termination on its destination buffer argument which=
 is
> > > > _not_ the case for `strncpy`!
> > > >
> > > > In this case, there is some behavior being used in conjunction with
> > > > `strncpy` that `strscpy` already implements. This means we can drop=
 some
> > > > of the extra stuff like `... -1` and `buf[len] =3D 0`
> > > >
> > > > This should have no functional change and yet uses a more robust an=
d
> > > > less ambiguous interface whilst reducing code complexity.
> > > >
> > > > Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncp=
y-on-nul-terminated-strings[1]
> > > > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.=
9.en.html [2]
> > > > Link: https://github.com/KSPP/linux/issues/90
> > > > Cc: linux-hardening@vger.kernel.org
> > > >
> > > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > > ---
> > > > For reference, see a part of `strscpy`'s implementation here:
> > > >
> > > > |     /* Hit buffer length without finding a NUL; force NUL-termina=
tion. */
> > > > |     if (res)
> > > > |             dest[res-1] =3D '\0';
> > > >
> > > > Note: compile tested
> > > > ---
> > > >  arch/arm64/kernel/idreg-override.c | 5 ++---
> > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel=
/idreg-override.c
> > > > index 2fe2491b692c..482dc5c71e90 100644
> > > > --- a/arch/arm64/kernel/idreg-override.c
> > > > +++ b/arch/arm64/kernel/idreg-override.c
> > > > @@ -262,9 +262,8 @@ static __init void __parse_cmdline(const char *=
cmdline, bool parse_aliases)
> > > >               if (!len)
> > > >                       return;
> > > >
> > > > -             len =3D min(len, ARRAY_SIZE(buf) - 1);
> > > > -             strncpy(buf, cmdline, len);
> > > > -             buf[len] =3D 0;
> > > > +             len =3D min(len, ARRAY_SIZE(buf));
> > > > +             strscpy(buf, cmdline, len);
Perhaps keeping the `...  - 1` is good because we then don't have to
check strlen immediately after. This does still silently truncate but
didn't the previous `strncpy` also do that?

> > >
> > > This, however, isn't correct: "cmdline" will be incremented by "leN"
> > > later, and we want a count of the characters copied into "buf", even =
if
> > > they're truncated. I think this should be:
> > >
> > >                 strscpy(buf, cmdline, ARRAY_SIZE(buf));
> > >                 len =3D strlen(buf);
> > >
> > Thoughts on using the return value from `strscpy` here?
>
> This code seems to silently accept truncation, so -E2BIG will cause a
> problem if it only looks at the return value.
>
> -Kees
>
> --
> Kees Cook
