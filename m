Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF5E78EF7A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346415AbjHaOVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346416AbjHaOVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:21:30 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A8DD7;
        Thu, 31 Aug 2023 07:21:27 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59234aaca15so10554727b3.3;
        Thu, 31 Aug 2023 07:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693491686; x=1694096486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2a3XR6Sxq68ivrZUK8VS9LH8RbQHO6YRGsSIW18ikA=;
        b=YOO6O7fGw1yGo3fcOpw89x3zWk40ZzbnaarVjSAqe5KA5PIeBVO+2uRZ40gV0sSl50
         +I0kB6ClS9tpjD0cd5iMgldbLQAGNBxeBYD6eUFhjoilkyZlTC6M4/Kuwi2X7I2wna7y
         t7mrP7Zj9DjszlHn+8BD6ez737hXtvF6kjNqgrbSv6MbCAnbUMZih3MX5KZE/+A5AHxq
         3/NDqn9eejg8BzS4eJvAnEZ8cga+XA9D64DrPPO6YKS6XP6CL2o2PZW3Jp7/HuQhkdNz
         xG6w1s32hwTQNAQaAGJ9oAhxTQEdBT4fL8Das9NXOUyChfXZ2koiP0X5pgE3fDKDLGbQ
         vjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693491686; x=1694096486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2a3XR6Sxq68ivrZUK8VS9LH8RbQHO6YRGsSIW18ikA=;
        b=V8Bm38x6tQY+zknwCICCJzLUMqCIKPlaBs2FBwr9FYMiDjdM+N4FkWGvpEbZ3r+eui
         2rQGKiBujfA7Yzj8mxhUPe/dKMsnrE2B8zi82NWFnw12VLkX8va4O7q+DpBaUaYQ7X6y
         y0vloMh9x2knYqj08L06RMgt/Rhd0GViBs85D2neOimCIosgFQtuT2YfWUc/BtXuAe09
         ZxEQ/wlVQkW28Wvs137BJnKagteqISsVLuwjeMx1iOJBczrOZ6DoX3NcnvR282lp+IOi
         3IWScj+uPW18yVsP7KOPIZI//LmQ9KOmeqCuU0nKhxuU9s/sR2UhstDckCIchsMLziQL
         NJQw==
X-Gm-Message-State: AOJu0YwFhmhtfEQs/GP6mOtLwauzy3Bn39QDGxWBgas9nkS7xI1iv869
        51KTqHofi727t9TSZSKoUzeykNDDUgdgTvc3N4cBDMIFdE17rlWGDXM=
X-Google-Smtp-Source: AGHT+IGXcwwbgrsUZKDHJdFfQU1lco8UH9gbJaaC38YdwnxwHR2XRd3yfkhSHc4P+JxDW8VsNXxUxmTeqAD+b5T/Tfk=
X-Received: by 2002:a25:2d1a:0:b0:bfe:e383:6297 with SMTP id
 t26-20020a252d1a000000b00bfee3836297mr5454726ybt.19.1693491686348; Thu, 31
 Aug 2023 07:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
 <2023083035-unpadded-amulet-8c7e@gregkh> <CADmuW3Wbgb7s+jRm8F0hcjzreWysVdzNvv778yUbGCOxAJHwjQ@mail.gmail.com>
 <202308301421.997C4034B5@keescook> <c44d1f9f-90e0-3e83-8394-854feb449539@kernel.org>
In-Reply-To: <c44d1f9f-90e0-3e83-8394-854feb449539@kernel.org>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Thu, 31 Aug 2023 10:21:15 -0400
Message-ID: <CADmuW3V1vDvukASPtpS2NVN=vLyQY4fXVDMbq=Gpn54qQEYtCw@mail.gmail.com>
Subject: Re: [PATCH] vt: Fix potential read overflow of kernel memory
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 1:32=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 30. 08. 23, 23:28, Kees Cook wrote:
> > On Wed, Aug 30, 2023 at 03:25:54PM -0400, Azeem Shaikh wrote:
> >> On Wed, Aug 30, 2023 at 1:57=E2=80=AFPM Greg Kroah-Hartman
> >> <gregkh@linuxfoundation.org> wrote:
> >>>
> >>> On Wed, Aug 30, 2023 at 04:04:10PM +0000, Azeem Shaikh wrote:
> >>>> strlcpy() reads the entire source buffer first.
> >>>> This read may exceed the destination size limit if
> >>>> a source string is not NUL-terminated [1].
> >>>
> >>> But that's not the case here, right?  So your "potential read overflo=
w"
> >>> isn't relevant here.
> >>>
> >>>> The copy_to_user() call uses @len returned from strlcpy() directly
> >>>> without checking its value. This could potentially lead to read
> >>>> overflow.
> >>>
> >>> But can it?  How?
> >>>
> >>
> >> The case I was considering is when the null-terminated hardcoded
> >> string @func_table[kb_func] has length @new_len > @len. In this case,
> >> strlcpy() will assign @len =3D @new_len and copy_to_user() would read
> >> @new_len from the kmalloc-ed memory of @len. This is the potential
> >> read overflow I was referring to. Let me know if I'm mistaken.
> >
> > First there is:
> >
> > ssize_t len =3D sizeof(user_kdgkb->kb_string);
> >
> > "struct user_kdgkb" is UAPI (therefore unlikely to change), and kb_stri=
ng
> > is 512:
> >
> > struct kbsentry {
> >          unsigned char kb_func;
> >          unsigned char kb_string[512];
> > };
> >
> > Then we do:
> >
> >                  len =3D strlcpy(kbs, func_table[kb_func] ? : "", len);
> >
> > This is the anti-pattern (take the length of the _source_) we need to
> > remove.
>
> But len is the length of kbs, i.e. the destination. Or what am I missing?
>
>                  kbs =3D kmalloc(len, GFP_KERNEL);
>                  len =3D strlcpy(kbs, func_table[kb_func] ? : "", len);
>
> > However, func_table[] is made up of either %NUL-terminated
> > strings:
> >
> > char func_buf[] =3D {
> >          '\033', '[', '[', 'A', 0,
> >          '\033', '[', '[', 'B', 0,
> > ...
> > char *func_table[MAX_NR_FUNC] =3D {
> >          func_buf + 0,
> >          func_buf + 5,
> > ...
> >
> > Or a NULL address itself. The ?: operator handles the NULL case, so
> > "len" can only ever be 0 through the longest string in func_buf. So it'=
s
> > what I'd call "accidentally correct". i.e. it's using a fragile
> > anti-pattern, but in this case everything is hard-coded and less than
> > 512.
> >
> > Regardless, we need to swap for a sane pattern, which you've done. But
> > the commit log is misleading, so it needs some more detail. :)
>
> I am still missing what is wrong in the above code with strlcpy(). The
> dest is deliberately made as long as the source, so the returned len is
> never less then the passed len. No checking needed IMO. Perhaps, we
> might switch to strcpy()?
>
> FWIW I introduced this in commit 82e61c3909db5. So if it needs fixing,
> the patch deserves a Fixes: 82e61c3909db5 tag.
>

As explained by Kees in previous comments, this is not actually a bug,
just a fragile anti-pattern. So we shouldn't need the Fixes: tag on
this patch.

> thanks,
> --
> js
> suse labs
>
