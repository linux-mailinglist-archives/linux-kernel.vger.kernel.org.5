Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0C8758141
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjGRPrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjGRPrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:47:10 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11C2A9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:47:08 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b734aea34aso91450171fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689695227; x=1692287227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6usP1mWM3GxXfKqGQc3GEa/0nZE/UFIhKEnNTRZSUiQ=;
        b=ioTADJn52gEsnZQX2iJR8ZF9nzAHkpp/ckKrOvfItEnVDlruq6Bq7Z6YWAgl46eQPN
         GUoLoX7MC4Lv/q8FaGu6M9Ihrs6YmGVskOuDFLrC4WzUEfQ7uKzKnfukfAyBdwxOcybp
         xTPonM2mwbhfvCvHAMhhvBo6D+jSQJnks7aiAkCIZXkgooqW/NKWWdrBWTjTITvtqYCG
         qoAOLtZBPw4Oc/egoAU7xi4dV6bed4AAn/Mtle1yi0a5rOnMoY8fxesjbj+9tdHzaZSA
         WUbE+IsSPWqIEMC5jZ3Lr2c07o3XwPb1O5L6D78IOytjFxMJKcZIycmuZb1AIfkifToz
         wP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689695227; x=1692287227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6usP1mWM3GxXfKqGQc3GEa/0nZE/UFIhKEnNTRZSUiQ=;
        b=O2X6xHiqfrQm47zR9O8ZPTPVlUO/Fy2C4aEWKB2VbhPDgNXyAgrigrr1KcQnUcp2Hx
         FG+P3ScVrn5JWkvpWgg1LKVnpQ5Yai69u3NS/A058FMYZD8kRNEHrzz3Pw3hjFYbuSkB
         QIMgCGRq+JlNMzVxG2HD5+BwkGX3AGAgLIXp0jBMrVrmDqjb3mD+hCPJ8jP3cbxgQMrv
         nrQi5ddLft2Zsk1pNaHpuGYkbdGaJrjkK8cOICT91twcpJiKkhIj5w59bq/ylqKLRPwV
         Vnp2Vy0RQJZGWfQRKeUO6UmVPZ5MHaWa0Akhc6UlIaoGegEvls6iLqVNbLT0e/sHjeaJ
         onsQ==
X-Gm-Message-State: ABy/qLaus+8HqVKrYjVGw0yx/8aPuy1wf58SIM62q3EY3EDeYxVX18qk
        kR++1k1UZZoYbfMfL0W32zJvbVDvdS043eoSKg==
X-Google-Smtp-Source: APBJJlG31S/xCGF4+rGkf3vGojKf7s/wH6d31eM4N33rz8aMLxe1qfIyoGm+Oq4jZFEx+HVC3bCQ+1txZEF0j54cuAw=
X-Received: by 2002:a2e:b0d7:0:b0:2b7:a64:6c3e with SMTP id
 g23-20020a2eb0d7000000b002b70a646c3emr11228841ljl.26.1689695226824; Tue, 18
 Jul 2023 08:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230718134446.168654-1-brgerst@gmail.com> <20230718134446.168654-3-brgerst@gmail.com>
 <a7b18c6b-1b27-b9fa-8936-2c0b7f5e5151@redhat.com> <CAMzpN2jzsbUh=2JyCxvOCGJNpycaKPW9WL3JniwrzZB+-mf+tg@mail.gmail.com>
 <f25d597b-a0e5-95db-5538-79893b8d37b2@redhat.com> <CAMzpN2jjFmhiuufPk-qdpA6_S0ne_V8g0QgoLNz6SfCYhkp1+A@mail.gmail.com>
In-Reply-To: <CAMzpN2jjFmhiuufPk-qdpA6_S0ne_V8g0QgoLNz6SfCYhkp1+A@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Tue, 18 Jul 2023 11:46:54 -0400
Message-ID: <CAMzpN2iGp6s1Yjj3VKMHWqU=u2dVoRfpWmxNXiQnPQnxtyiRNw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 11:21=E2=80=AFAM Brian Gerst <brgerst@gmail.com> wr=
ote:
>
> On Tue, Jul 18, 2023 at 10:49=E2=80=AFAM Mika Penttil=C3=A4 <mpenttil@red=
hat.com> wrote:
> >
> >
> >
> > On 18.7.2023 17.25, Brian Gerst wrote:
> > > On Tue, Jul 18, 2023 at 10:17=E2=80=AFAM Mika Penttil=C3=A4 <mpenttil=
@redhat.com> wrote:
> > >>
> > >> Hi,
> > >>
> > >>
> > >> On 18.7.2023 16.44, Brian Gerst wrote:
> > >>> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > >>> ---
> > >>>    arch/x86/entry/common.c        | 50 ++++++++++++++++++++++++++++=
++-
> > >>>    arch/x86/entry/entry_64.S      | 55 ++--------------------------=
------
> > >>>    arch/x86/include/asm/syscall.h |  2 +-
> > >>>    3 files changed, 52 insertions(+), 55 deletions(-)
> > >>>
> > >>> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> > >>> index 6c2826417b33..afe79c3f1c5b 100644
> > >>> --- a/arch/x86/entry/common.c
> > >>> +++ b/arch/x86/entry/common.c
> > >>> @@ -70,8 +70,12 @@ static __always_inline bool do_syscall_x32(struc=
t pt_regs *regs, int nr)
> > >>>        return false;
> > >>>    }
> > >>>
> > >>> -__visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
> > >>> +/* Returns true to return using SYSRET, or false to use IRET */
> > >>> +__visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
> > >>>    {
> > >>> +     long rip;
> > >>> +     unsigned int shift_rip;
> > >>> +
> > >>>        add_random_kstack_offset();
> > >>>        nr =3D syscall_enter_from_user_mode(regs, nr);
> > >>>
> > >>> @@ -84,6 +88,50 @@ __visible noinstr void do_syscall_64(struct pt_r=
egs *regs, int nr)
> > >>>
> > >>>        instrumentation_end();
> > >>>        syscall_exit_to_user_mode(regs);
> > >>> +
> > >>> +     /*
> > >>> +      * Check that the register state is valid for using SYSRET to=
 exit
> > >>> +      * to userspace.  Otherwise use the slower but fully capable =
IRET
> > >>> +      * exit path.
> > >>> +      */
> > >>> +
> > >>> +     /* XEN PV guests always use IRET path */
> > >>> +     if (cpu_feature_enabled(X86_FEATURE_XENPV))
> > >>> +             return false;
> > >>> +
> > >>> +     /* SYSRET requires RCX =3D=3D RIP and R11 =3D=3D EFLAGS */
> > >>> +     if (unlikely(regs->cx !=3D regs->ip || regs->r11 !=3D regs->f=
lags))
> > >>> +             return false;
> > >>> +
> > >>> +     /* CS and SS must match the values set in MSR_STAR */
> > >>> +     if (unlikely(regs->cs !=3D __USER_CS || regs->ss !=3D __USER_=
DS))
> > >>> +             return false;
> > >>> +
> > >>> +     /*
> > >>> +      * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
> > >>> +      * in kernel space.  This essentially lets the user take over
> > >>> +      * the kernel, since userspace controls RSP.
> > >>> +      *
> > >>> +      * Change top bits to match most significant bit (47th or 56t=
h bit
> > >>> +      * depending on paging mode) in the address.
> > >>> +      */
> > >>> +     shift_rip =3D (64 - __VIRTUAL_MASK_SHIFT + 1);
> > >>
> > >> Should this be:
> > >>
> > >>          shift_rip =3D (64 - __VIRTUAL_MASK_SHIFT - 1);
> > >> ?
> > >
> > > I removed a set of parentheses, which switched the sign from -1 to +1=
.
> > > I could put it back if that's less confusing.
> > >
> >
> > I mean isn't it supposed to be:
> > shift_rip =3D (64 - 48) for 4 level, now it's
> > shift_rip =3D (64 - 46)
> >
> > __VIRTUAL_MASK_SHIFT =3D=3D 47

My apologies, you were right.  I've been sitting on this series for a
while and finally got around to posting it and didn't catch that
error.

>
> Original:
> (64 - (47 + 1)) =3D (64 - 48) =3D 16
>
>   c5:   48 c1 e1 10             shl    $0x10,%rcx
>   c9:   48 c1 f9 10             sar    $0x10,%rcx

This was wrong.  I hastily compiled this after I had reverted to the
original formula.

> New:
> (64 - 47 - 1) =3D (17 - 1) =3D 16
>
>  18b:   b9 10 00 00 00          mov    $0x10,%ecx
>  193:   48 d3 e2                shl    %cl,%rdx
>  196:   48 d3 fa                sar    %cl,%rdx
>
> Anyways, I'll switch it back to the original formula.  I'm not going
> to argue any more about basic math.

I'll send a v2 later after any more feedback.  Thanks.

 Brian Gerst
