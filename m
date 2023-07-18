Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8A6757F66
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjGRO0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGRO0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:26:14 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B161C188
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:26:13 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b708e49059so90227221fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689690372; x=1692282372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0V4TmytEo0Hg+opeFgD+EAIfTgjCkbTYm7vcBHHnpLY=;
        b=FByDRCEU+RPv7Yew/O4LrGkoNfzWFPE42WEbbF9V8XSub8FXnAu1qDe0Vwbm4X4yA6
         2ygBXVNlsBzVJywRaZsAAyk3MPLe27f9T0s7KRPoMvaZhJojLlNBq4Jwuz56WhC+Q4St
         6dNxWiAaQubbkwF2aWTkeF731w4QEHHedlQxZeq9x9lQ5LQ3+9qhCH2OPsj9XA5e7rGn
         At3p9qplNG8iw9+DHD5lWhwbybtJ7XKzp+wEh8Z4welNWPhdQO4Uxyasi3bjyVhauyYu
         xfxVepag4+JN7k/fd9c93iAk9Vnwoxx7rVkfwWYBxt2J3H59ih4olQoJZp4lLq/IxPww
         eyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689690372; x=1692282372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0V4TmytEo0Hg+opeFgD+EAIfTgjCkbTYm7vcBHHnpLY=;
        b=SvnxaX+aJEQiEzTs/lsWjFbLyNjQvBfNd0VgKGSEWSnx49cl4ISp2wBjMsxztusgo2
         JJteAt7EjG0rq309peZ84scNZDD5irdBJAuhscbVB1t4pv8lOYzqXUutZ7UAraPS8chf
         zcAlbytxpyoQEq95WyPxZQc/1NaOJluogYkzaZ8VIih8IJO3h7I2snG8p8QZ3tNObGBy
         Ajjjn6/yXEY6YoAh5VT59NkzLK3wsIb7RQAMDe3OLl5F3i2yC/hx+fKUX+HB78lgf1eg
         sMsp9qPK39To7WC7pLtKGrGA2Y+sG+AR5+vSHVtcD9bSkSk0KsU4Nj7JmeKCWkGoBmvO
         gIAg==
X-Gm-Message-State: ABy/qLbTQHweY3UcinMPFmd1kQwIUx9cnrmnzou3Xd5SL/EITMwa6We1
        F71JpZ0bjxNDb4j6qkZ5ZFJN3SkkIqR8Ue5OuA==
X-Google-Smtp-Source: APBJJlEuE01wpfjce7xKDr4DH3vIXYyXH0rYeR6fuoEsLoF89PjzypUT600RQfs+5tmpAc1dHvJ4YKWwdm0inN6qTfQ=
X-Received: by 2002:a2e:9b4f:0:b0:2b7:ae29:88fd with SMTP id
 o15-20020a2e9b4f000000b002b7ae2988fdmr10640570ljj.48.1689690371675; Tue, 18
 Jul 2023 07:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230718134446.168654-1-brgerst@gmail.com> <20230718134446.168654-3-brgerst@gmail.com>
 <a7b18c6b-1b27-b9fa-8936-2c0b7f5e5151@redhat.com>
In-Reply-To: <a7b18c6b-1b27-b9fa-8936-2c0b7f5e5151@redhat.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Tue, 18 Jul 2023 10:25:59 -0400
Message-ID: <CAMzpN2jzsbUh=2JyCxvOCGJNpycaKPW9WL3JniwrzZB+-mf+tg@mail.gmail.com>
Subject: Re: [PATCH 2/6] x86/entry/64: Convert SYSRET validation tests to C
To:     =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:17=E2=80=AFAM Mika Penttil=C3=A4 <mpenttil@redha=
t.com> wrote:
>
> Hi,
>
>
> On 18.7.2023 16.44, Brian Gerst wrote:
> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > ---
> >   arch/x86/entry/common.c        | 50 ++++++++++++++++++++++++++++++-
> >   arch/x86/entry/entry_64.S      | 55 ++-------------------------------=
-
> >   arch/x86/include/asm/syscall.h |  2 +-
> >   3 files changed, 52 insertions(+), 55 deletions(-)
> >
> > diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> > index 6c2826417b33..afe79c3f1c5b 100644
> > --- a/arch/x86/entry/common.c
> > +++ b/arch/x86/entry/common.c
> > @@ -70,8 +70,12 @@ static __always_inline bool do_syscall_x32(struct pt=
_regs *regs, int nr)
> >       return false;
> >   }
> >
> > -__visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
> > +/* Returns true to return using SYSRET, or false to use IRET */
> > +__visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
> >   {
> > +     long rip;
> > +     unsigned int shift_rip;
> > +
> >       add_random_kstack_offset();
> >       nr =3D syscall_enter_from_user_mode(regs, nr);
> >
> > @@ -84,6 +88,50 @@ __visible noinstr void do_syscall_64(struct pt_regs =
*regs, int nr)
> >
> >       instrumentation_end();
> >       syscall_exit_to_user_mode(regs);
> > +
> > +     /*
> > +      * Check that the register state is valid for using SYSRET to exi=
t
> > +      * to userspace.  Otherwise use the slower but fully capable IRET
> > +      * exit path.
> > +      */
> > +
> > +     /* XEN PV guests always use IRET path */
> > +     if (cpu_feature_enabled(X86_FEATURE_XENPV))
> > +             return false;
> > +
> > +     /* SYSRET requires RCX =3D=3D RIP and R11 =3D=3D EFLAGS */
> > +     if (unlikely(regs->cx !=3D regs->ip || regs->r11 !=3D regs->flags=
))
> > +             return false;
> > +
> > +     /* CS and SS must match the values set in MSR_STAR */
> > +     if (unlikely(regs->cs !=3D __USER_CS || regs->ss !=3D __USER_DS))
> > +             return false;
> > +
> > +     /*
> > +      * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
> > +      * in kernel space.  This essentially lets the user take over
> > +      * the kernel, since userspace controls RSP.
> > +      *
> > +      * Change top bits to match most significant bit (47th or 56th bi=
t
> > +      * depending on paging mode) in the address.
> > +      */
> > +     shift_rip =3D (64 - __VIRTUAL_MASK_SHIFT + 1);
>
> Should this be:
>
>         shift_rip =3D (64 - __VIRTUAL_MASK_SHIFT - 1);
> ?

I removed a set of parentheses, which switched the sign from -1 to +1.
I could put it back if that's less confusing.

Brian Gerst
