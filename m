Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E9C78DAE9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjH3SiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244838AbjH3OMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:12:02 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A3D122;
        Wed, 30 Aug 2023 07:11:58 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-571194584e2so3458335eaf.3;
        Wed, 30 Aug 2023 07:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693404717; x=1694009517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkS0efXVCy8VZ5VmSKwsFXPwQqBxWGJyzZuacJMQHs0=;
        b=nviZ2Ig855iE69l2dJVd41I7LUeYAIbu92pDQ0wG7982B9TGGL5tmFd9M2m/cTdyZE
         FUL7zzfjk1QXD9SAR9Njkb7MuIu82pZ6C8WM7S8eahWkcffpvdR2wPOnlxJkuloNZmD7
         GG8eEP1D5o9snm1qTb/TbH9RVpvD/eAa5CX6ad1bLgJIGyRQ1WOcf3Q7e7Du5yEWt4Pn
         fYqJQxwGDySe5GtoS+bA4IMBdDFSvroCu2fiP2iuIEHsYQeXTGen6dhPTDawYzirEYRB
         o+nJ6eCFnUdvDqqqxPJEn/DB/17qOKO86aUevKrfeKeLTyojFunTPJ8OQAcIIHDPh7xr
         Ui4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693404717; x=1694009517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkS0efXVCy8VZ5VmSKwsFXPwQqBxWGJyzZuacJMQHs0=;
        b=kJs4xT5fZGWPBfbhyzhgoVK+hnxjgM+CzInQdw05XYl5r7LRZuCj++7spIgx/7svKj
         c0khh9vvzFsVR6dyZ7dh5H/v0R3ymPfbO1h8XObQkRkcZIwAi58aABD+h5Y4ZbGOmlgq
         VdpBL8WTPwLXA+eex8fhqpBL82lKxEkFzt2tF89IW1uy4Hdufl8WzPozXR+pRj1eOTaQ
         bO0mkGzsw5MAyOb3nTAZI4/Zi06S9JHdu9yfchFiJZhUY+j6ohybI1h2GqWxKRlO9x1c
         JSk9LdAQnHCdQz+3SZGjSVjJ8s31tzYhNVpaEXAjI8XobYp/bA9SnMQVgKi7MdKP30bY
         bH6A==
X-Gm-Message-State: AOJu0Yw/FMhhaazeSJlp6uuDCk4qbPpcl79RaGJ6bkdDqp76OyQ96XAv
        8vBdVn57tcyPpa/VRSz7tKaIY/hYK/mmR4SHFf4=
X-Google-Smtp-Source: AGHT+IGbT74tfz3VyfVut6ethLJwLvDm6Tl7JSJUbcDNwD+fiygq/r9pK7Rbz0oaYOoffpJo/r8wDHC3auZoXajOIhc=
X-Received: by 2002:a4a:d213:0:b0:570:be00:5e14 with SMTP id
 c19-20020a4ad213000000b00570be005e14mr2163595oos.8.1693404717504; Wed, 30 Aug
 2023 07:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693386602.git.pstanner@redhat.com> <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
In-Reply-To: <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 30 Aug 2023 17:11:21 +0300
Message-ID: <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
Subject: Re: [PATCH 1/5] string.h: add array-wrappers for (v)memdup_user()
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        David Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 4:46=E2=80=AFPM Philipp Stanner <pstanner@redhat.co=
m> wrote:
>
> Currently, user array duplications are sometimes done without an
> overflow check. Sometimes the checks are done manually; sometimes the
> array size is calculated with array_size() and sometimes by calculating
> n * size directly in code.
>
> Introduce wrappers for arrays for memdup_user() and vmemdup_user() to
> provide a standardized and safe way for duplicating user arrays.
>
> This is both for new code as well as replacing usage of (v)memdup_user()
> in existing code that uses, e.g., n * size to calculate array sizes.

...

> --- a/include/linux/string.h
> +++ b/include/linux/string.h

I'm wondering if this has no side-effects as string.h/string.c IIRC is
used also for early stages where some of the APIs are not available.

> @@ -6,6 +6,8 @@
>  #include <linux/types.h>       /* for size_t */
>  #include <linux/stddef.h>      /* for NULL */
>  #include <linux/errno.h>       /* for E2BIG */
> +#include <linux/overflow.h>    /* for check_mul_overflow() */
> +#include <linux/err.h>         /* for ERR_PTR() */

Can we preserve order (to some extent)?

>  #include <linux/stdarg.h>
>  #include <uapi/linux/string.h>

...

> +/**
> + * memdup_array_user - duplicate array from user space

> + *

Do we need this blank line?

> + * @src: source address in user space
> + * @n: number of array members to copy
> + * @size: size of one array member
> + *
> + * Return: an ERR_PTR() on failure.  Result is physically
> + * contiguous, to be freed by kfree().
> + */

...

> +/**
> + * vmemdup_array_user - duplicate array from user space

> + *

Redundant?

> + * @src: source address in user space
> + * @n: number of array members to copy
> + * @size: size of one array member
> + *
> + * Return: an ERR_PTR() on failure.  Result may be not
> + * physically contiguous.  Use kvfree() to free.
> + */

--=20
With Best Regards,
Andy Shevchenko
