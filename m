Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827FF78E8F2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242002AbjHaI74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjHaI7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:59:55 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B98DCF4;
        Thu, 31 Aug 2023 01:59:51 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-5738cb00eebso369873eaf.2;
        Thu, 31 Aug 2023 01:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693472391; x=1694077191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WCBkbdNR2D/dn3x6jAE+/xbR9io7eSmxn1U8tK6k34=;
        b=gQeykQMyJnheAFbYczk2x2ut5YhnhXbdvpahC++wz4TAbz8U5YS30AG/TcIxhfj7eQ
         iGjofMYpui57B4LmjARvn0Js7dg05Z8r25tqkGnJE1EOaYW8e3848R9sbJ48hHZmCDY7
         dfkXE/cKQ4lluKAteUYoMDfRPlsrFthMJFkEc0liyD1MIDpcY40vLeDbRsznkDb5eg4p
         o9WEQWVfH9W+Kef8YapnNuIKTKm1MERUp/mR8EZYAsxdkiN29weFsPjt+2LGPESqSMtE
         uXFZ8/6XUxsVcEKGdw/NgxMpnzOWl5Q8vQ9p4Nhr0UKLSE8JPaRX/gd5wGFXAtczGt+c
         ztag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693472391; x=1694077191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WCBkbdNR2D/dn3x6jAE+/xbR9io7eSmxn1U8tK6k34=;
        b=dq1GKHGczW1yRECkE6cewtYiZZKBEeJLwh21geKQSG/xwBAbikOr41JIaXa8Tow3ug
         Vvio88vwA4eABjtcfxwV0pKMS1GoiCjk8sIoCz56j9Zef9yZsoH7L07d3vhMFzdbp0bt
         WXPOXvGa1DZ+42iVLCJZTQ5kUzCgESP1szIXd+IN5K9klcvAa/K2U3PEhn8A+ZLsJZms
         5bCMvyDbeTUrwbwr8b/LQCPP+Rgwinh2QPbdU6QMTVKDoF/Iccp9UOrU6UN68jgrTptg
         LFEtKX5LXrcKa2Xz7L2/h3BPUOYyrFMCSc3iYVWgyTqqDgK8O1OGmzpl5Mpime4vc7Kf
         XiwQ==
X-Gm-Message-State: AOJu0YykxKGiAMoEbqu7pqngIViVUrlphFACN+goC2nPAlQ5VMqaGI94
        OtBxzDRz6jAKCsstWIQ+8ArdxX69HRFA1D6YKqTubU4DH1o=
X-Google-Smtp-Source: AGHT+IHD40W+0VPJ3vNndBJ9GxsD1cpYZQwMg37odmvA2L5FhdqLghEG+N8XXu1zSL+1GhjtspeZlpQR10ud8jErSAU=
X-Received: by 2002:a4a:2a52:0:b0:573:3711:51c4 with SMTP id
 x18-20020a4a2a52000000b00573371151c4mr4288732oox.8.1693472390851; Thu, 31 Aug
 2023 01:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693386602.git.pstanner@redhat.com> <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
 <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
 <721a70c347d82931d12e5b75b19d132f82ee5ed2.camel@redhat.com>
 <CAHp75VdS=kSWnz8FzHcdrZPaeZKsQNbzjE9mNN7BDvZA_nQpaA@mail.gmail.com> <a4ba0493965ad32fcf95cd6e2439096668a9ed46.camel@redhat.com>
In-Reply-To: <a4ba0493965ad32fcf95cd6e2439096668a9ed46.camel@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 31 Aug 2023 11:59:14 +0300
Message-ID: <CAHp75VdqFPJAnCm9A-S+TCChr9v9_s=Wfnb5wO2=vuwp1v+JvA@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 10:15=E2=80=AFPM <pstanner@redhat.com> wrote:
> On Wed, 2023-08-30 at 17:29 +0300, Andy Shevchenko wrote:
> > On Wed, Aug 30, 2023 at 5:19=E2=80=AFPM <pstanner@redhat.com> wrote:
> > > On Wed, 2023-08-30 at 17:11 +0300, Andy Shevchenko wrote:
> > > > On Wed, Aug 30, 2023 at 4:46=E2=80=AFPM Philipp Stanner
> > > > <pstanner@redhat.com>
> > > > wrote:

...

> > > > >  #include <linux/types.h>       /* for size_t */
> > > > >  #include <linux/stddef.h>      /* for NULL */
> > > > >  #include <linux/errno.h>       /* for E2BIG */
> > > > > +#include <linux/overflow.h>    /* for check_mul_overflow() */
> > > > > +#include <linux/err.h>         /* for ERR_PTR() */
> > > >
> > > > Can we preserve order (to some extent)?
> > >
> > > Sure. I just put it there so the comments build a congruent block.
> > > Which order would you prefer?
> >
> > Alphabetical.
> >
> > compiler.h
> > err.h
> > overflow.h
> > ...the rest that is a bit unordered...
> >
> > > > >  #include <linux/stdarg.h>
> > > > >  #include <uapi/linux/string.h>
>
> I mean I could include my own in a sorted manner =E2=80=93 but the existi=
ng
> ones are not sorted:

I know, that's why I put "(to some extent)" in my initial comment.

> We could sort them all, but I'd prefer to do that in a separate patch
> so that this commit does not make the impression of doing anything else
> than including the two new headers

But you can do your stuff first with better ordering than you proposed
initially, so there will be less churn for any additional change
(either that simply unifies the thing or something else).

> Such a separate patch could also unify the docstring style, see below

Sure, patches are welcome!

> > > > > +/**
> > > > > + * memdup_array_user - duplicate array from user space
> > > >
> > > > > + *
> > > >
> > > > Do we need this blank line?
> > >
> > > I more or less directly copied the docstring format from the
> > > original
> > > functions (v)memdup_user() in mm/util.c
> > > I guess this is common style?
> >
> > I think it's not. But you may grep kernel source tree and tell which
> > one occurs more often with or without this (unneeded) blank line.
>
>
> It seems to be very much mixed. string.h itself is mixed.
> When you look at the bottom of string.h, you'll find functions such as
> kbasename() that have the extra line.
>
> That's not really a super decisive point for me, though. We can remove
> the line I guess

I think the less LoCs the better generally speaking. So, if we don't
need that line and it doesn't make the readability worse, why to keep
it?

> > > > > + * @src: source address in user space
> > > > > + * @n: number of array members to copy
> > > > > + * @size: size of one array member
> > > > > + *
> > > > > + * Return: an ERR_PTR() on failure.  Result is physically
> > > > > + * contiguous, to be freed by kfree().
> > > > > + */

--
With Best Regards,
Andy Shevchenko
