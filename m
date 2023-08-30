Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875EB78DB2C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbjH3Sil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245103AbjH3O3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:29:51 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237DD193;
        Wed, 30 Aug 2023 07:29:47 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-5738cb00eebso1903760eaf.2;
        Wed, 30 Aug 2023 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693405786; x=1694010586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlttlEDqW9alqjgAxWGl4jxgD1Wge7MwJD361d8FLtw=;
        b=rb6C1FNxbRqHnGB6pJAbQaJAyT1mVeHn1hJWD1lxS2MwxizKhfuodWmNIMBV8cy4QL
         5gU0kafO1tE/Dr0/sCPbi8yApZ/+v9KmwEQsQ7otREhITVhJjX3je0SdS0/y3FMUgsQR
         +qo/mu94c5CLIUk77g2YIOPXtm8HGuumtu3MxETOWqXOq7Ur4evpWYsBOsWzdexuTnXU
         7kvAAedD07SvTT/p0Iys0hmhhWC+SXVpFFfDEs69dFI0TKUCk2QGwTDU8v0DhnbLkvNf
         /ZjrmYIf/A7tk4fa3iiwGAkOgSuULTCyNVGPaDjy0rpUEVVpYtRTsbiy+cqvekZ6cslh
         653A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693405786; x=1694010586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlttlEDqW9alqjgAxWGl4jxgD1Wge7MwJD361d8FLtw=;
        b=HRTDgWL5UOPqdp9h4/PcfqX2GdLYChmj4+jQUBHk1Co7QDTitBLhzHG3wA6W0pPiOJ
         kDYZRCGk2lKX5ptz48e+xTyUjfEIX++ckl3Df54pGSKDvLsQFs2HFffjaS9+/AyQ8u/l
         FleBWB7NzV6n4vP/pOdJcvE0Acu9C7iQAzUfFP7CSX5oBB6O1jaJ0fBbZ6Potu0lZDnk
         5dPX2CJA8crQNOPWCeYSPfjXc7Hk+URj6OvOgMIwvpItOls/7RiDO9LYHdh6AjjHsa0P
         4nbZEVAYDHSSc8CP0FTOE+SMKIvbbG6GVm39Ezdzm9qqwGwYN8Y2/X4ljuDSgdP2+Dg0
         /Jdw==
X-Gm-Message-State: AOJu0Yx4/r6zBieFO0ZnbZU+DsnATBFpI+OWFYdYFsjKi9BAE+XMUGZU
        GT2Jn8L101UbRlXSFWFuaJ/q1Q1QR+3oqSl/Q4A=
X-Google-Smtp-Source: AGHT+IHJoeozkJNRqDb9wU0X9eZUS4CXC4PL8HeApeKCunqAEMeImyi5O69r6+qX4aHDquXPNOTkCV+WuexgXtraVp4=
X-Received: by 2002:a4a:3906:0:b0:56d:2229:5f94 with SMTP id
 m6-20020a4a3906000000b0056d22295f94mr2120964ooa.6.1693405786336; Wed, 30 Aug
 2023 07:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693386602.git.pstanner@redhat.com> <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
 <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com> <721a70c347d82931d12e5b75b19d132f82ee5ed2.camel@redhat.com>
In-Reply-To: <721a70c347d82931d12e5b75b19d132f82ee5ed2.camel@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 30 Aug 2023 17:29:09 +0300
Message-ID: <CAHp75VdS=kSWnz8FzHcdrZPaeZKsQNbzjE9mNN7BDvZA_nQpaA@mail.gmail.com>
Subject: Re: [PATCH 1/5] string.h: add array-wrappers for (v)memdup_user()
To:     pstanner@redhat.com
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 5:19=E2=80=AFPM <pstanner@redhat.com> wrote:
> On Wed, 2023-08-30 at 17:11 +0300, Andy Shevchenko wrote:
> > On Wed, Aug 30, 2023 at 4:46=E2=80=AFPM Philipp Stanner <pstanner@redha=
t.com>
> > wrote:

> > > --- a/include/linux/string.h
> > > +++ b/include/linux/string.h
> >
> > I'm wondering if this has no side-effects as string.h/string.c IIRC
> > is
> > used also for early stages where some of the APIs are not available.
> >
> > > @@ -6,6 +6,8 @@
> > >  #include <linux/types.h>       /* for size_t */
> > >  #include <linux/stddef.h>      /* for NULL */
> > >  #include <linux/errno.h>       /* for E2BIG */
> > > +#include <linux/overflow.h>    /* for check_mul_overflow() */
> > > +#include <linux/err.h>         /* for ERR_PTR() */
> >
> > Can we preserve order (to some extent)?
>
> Sure. I just put it there so the comments build a congruent block.
> Which order would you prefer?

Alphabetical.

compiler.h
err.h
overflow.h
...the rest that is a bit unordered...

> > >  #include <linux/stdarg.h>
> > >  #include <uapi/linux/string.h>

...

> > > +/**
> > > + * memdup_array_user - duplicate array from user space
> >
> > > + *
> >
> > Do we need this blank line?
>
> I more or less directly copied the docstring format from the original
> functions (v)memdup_user() in mm/util.c
> I guess this is common style?

I think it's not. But you may grep kernel source tree and tell which
one occurs more often with or without this (unneeded) blank line.

> > > + * @src: source address in user space
> > > + * @n: number of array members to copy
> > > + * @size: size of one array member
> > > + *
> > > + * Return: an ERR_PTR() on failure.  Result is physically
> > > + * contiguous, to be freed by kfree().
> > > + */

...

> > > +/**
> > > + * vmemdup_array_user - duplicate array from user space
> >
> > > + *
> >
> > Redundant?
>
> No, there are two functions:
>  * memdup_array_user()
>  * vmemdup_array_user()
>
> On the deeper layers they utilize kmalloc() or kvmalloc(),
> respectively.

I guess you misunderstood my comment. I was talking about kernel doc
(as in the previous function).

> > > + * @src: source address in user space
> > > + * @n: number of array members to copy
> > > + * @size: size of one array member
> > > + *
> > > + * Return: an ERR_PTR() on failure.  Result may be not
> > > + * physically contiguous.  Use kvfree() to free.
> > > + */


--=20
With Best Regards,
Andy Shevchenko
