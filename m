Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCC47580CA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbjGRPWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjGRPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:22:30 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629FC1FE2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:22:04 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b6ff1ada5dso89452531fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689693697; x=1692285697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLxUwQKdUnLhIEfILgYdu4kHBHhDSMlRlhRfKuBqvIU=;
        b=SjUFUCKhkwmEpgQC+24njer/T+Q6NJrEP4V36XbJbg8Re23QnQoHaDvr4ts8y2kiiV
         DjJTX9v5HZcnpySDJWyIt2zXG3XGNQ92N8qMY5eACtpv5MM6q1MxlIM//DFF4bjdCbUe
         bpTcnWbAbYUbkX/cb5rjjDfxLMWJj+yxw2V9chDgeMPVj3GhpbNp/gG/vTUryH/l4GFP
         OFS6Xck14fHLbArFQ/xmVf6M1pAJDgjsQ6AVl/Ybtuq4ttV8h05rW3/i8jM0FZMR7KPB
         MZJcY1FGSM+bTbv674MKqJzSqH2W3+e1/8pVmOtclT1p/CtZPZFvwcmG9FO0Z45KMbng
         nMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689693697; x=1692285697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLxUwQKdUnLhIEfILgYdu4kHBHhDSMlRlhRfKuBqvIU=;
        b=TeV0j88DFgTEzigm59wsflCFcOB8mRiP14wpHV7LjzkaoVZ6RpQwY9D7UZ7oLl5jcD
         sO4F9XrPLz9sNvLpoGUXJDxigRtSTHvzi7VOcnQ2D7+vFGDG/E2o+FGVvNQnMmvOnM3z
         MvxcV/2JeLmYTwVqEcvwZ7UGSbyTDkKkfmr61Pzp4hyChl4vuf1zGJ5Bbfvu843bkDrR
         UDVga52cmWlivJ7cVCXjwAOFW3uo4LfAMj544KJsC6i1XYwZg2aCFm+KP48Z8FdH0Kqw
         dGaMw0z5wYVtL6YQZ3CmJ3A8EBb29OmeBBjsr2ZtlLM/6ExBr1BAFdg/D9ccHVj/Dgl9
         m+TQ==
X-Gm-Message-State: ABy/qLaKMkdQt+qzdeb7YoRv8kK1yFnkkVCrM3HKLYe33OUHw6Pri8S4
        y3iNLZMRGXsFRRc2WofsQ50BjmpxFDn00ElwgB/hhdAyoQ==
X-Google-Smtp-Source: APBJJlEWyWge/zhGQc9jHZPfoIk+4tW0DTnLy6OfcjM1y9mKpRTDb+se9Uwf8B09UWMy1CHpNc25j1Ux9uwkQag0q7A=
X-Received: by 2002:a2e:8456:0:b0:2b6:e6cc:9057 with SMTP id
 u22-20020a2e8456000000b002b6e6cc9057mr10354291ljh.51.1689693696650; Tue, 18
 Jul 2023 08:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230718134446.168654-1-brgerst@gmail.com> <20230718134446.168654-3-brgerst@gmail.com>
 <a7b18c6b-1b27-b9fa-8936-2c0b7f5e5151@redhat.com> <CAMzpN2jzsbUh=2JyCxvOCGJNpycaKPW9WL3JniwrzZB+-mf+tg@mail.gmail.com>
 <f25d597b-a0e5-95db-5538-79893b8d37b2@redhat.com>
In-Reply-To: <f25d597b-a0e5-95db-5538-79893b8d37b2@redhat.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Tue, 18 Jul 2023 11:21:24 -0400
Message-ID: <CAMzpN2jjFmhiuufPk-qdpA6_S0ne_V8g0QgoLNz6SfCYhkp1+A@mail.gmail.com>
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

On Tue, Jul 18, 2023 at 10:49=E2=80=AFAM Mika Penttil=C3=A4 <mpenttil@redha=
t.com> wrote:
>
>
>
> On 18.7.2023 17.25, Brian Gerst wrote:
> > On Tue, Jul 18, 2023 at 10:17=E2=80=AFAM Mika Penttil=C3=A4 <mpenttil@r=
edhat.com> wrote:
> >>
> >> Hi,
> >>
> >>
> >> On 18.7.2023 16.44, Brian Gerst wrote:
> >>> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> >>> ---
> >>>    arch/x86/entry/common.c        | 50 ++++++++++++++++++++++++++++++=
-
> >>>    arch/x86/entry/entry_64.S      | 55 ++----------------------------=
----
> >>>    arch/x86/include/asm/syscall.h |  2 +-
> >>>    3 files changed, 52 insertions(+), 55 deletions(-)
> >>>
> >>> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> >>> index 6c2826417b33..afe79c3f1c5b 100644
> >>> --- a/arch/x86/entry/common.c
> >>> +++ b/arch/x86/entry/common.c
> >>> @@ -70,8 +70,12 @@ static __always_inline bool do_syscall_x32(struct =
pt_regs *regs, int nr)
> >>>        return false;
> >>>    }
> >>>
> >>> -__visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
> >>> +/* Returns true to return using SYSRET, or false to use IRET */
> >>> +__visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
> >>>    {
> >>> +     long rip;
> >>> +     unsigned int shift_rip;
> >>> +
> >>>        add_random_kstack_offset();
> >>>        nr =3D syscall_enter_from_user_mode(regs, nr);
> >>>
> >>> @@ -84,6 +88,50 @@ __visible noinstr void do_syscall_64(struct pt_reg=
s *regs, int nr)
> >>>
> >>>        instrumentation_end();
> >>>        syscall_exit_to_user_mode(regs);
> >>> +
> >>> +     /*
> >>> +      * Check that the register state is valid for using SYSRET to e=
xit
> >>> +      * to userspace.  Otherwise use the slower but fully capable IR=
ET
> >>> +      * exit path.
> >>> +      */
> >>> +
> >>> +     /* XEN PV guests always use IRET path */
> >>> +     if (cpu_feature_enabled(X86_FEATURE_XENPV))
> >>> +             return false;
> >>> +
> >>> +     /* SYSRET requires RCX =3D=3D RIP and R11 =3D=3D EFLAGS */
> >>> +     if (unlikely(regs->cx !=3D regs->ip || regs->r11 !=3D regs->fla=
gs))
> >>> +             return false;
> >>> +
> >>> +     /* CS and SS must match the values set in MSR_STAR */
> >>> +     if (unlikely(regs->cs !=3D __USER_CS || regs->ss !=3D __USER_DS=
))
> >>> +             return false;
> >>> +
> >>> +     /*
> >>> +      * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
> >>> +      * in kernel space.  This essentially lets the user take over
> >>> +      * the kernel, since userspace controls RSP.
> >>> +      *
> >>> +      * Change top bits to match most significant bit (47th or 56th =
bit
> >>> +      * depending on paging mode) in the address.
> >>> +      */
> >>> +     shift_rip =3D (64 - __VIRTUAL_MASK_SHIFT + 1);
> >>
> >> Should this be:
> >>
> >>          shift_rip =3D (64 - __VIRTUAL_MASK_SHIFT - 1);
> >> ?
> >
> > I removed a set of parentheses, which switched the sign from -1 to +1.
> > I could put it back if that's less confusing.
> >
>
> I mean isn't it supposed to be:
> shift_rip =3D (64 - 48) for 4 level, now it's
> shift_rip =3D (64 - 46)
>
> __VIRTUAL_MASK_SHIFT =3D=3D 47

Original:
(64 - (47 + 1)) =3D (64 - 48) =3D 16

  c5:   48 c1 e1 10             shl    $0x10,%rcx
  c9:   48 c1 f9 10             sar    $0x10,%rcx

New:
(64 - 47 - 1) =3D (17 - 1) =3D 16

 18b:   b9 10 00 00 00          mov    $0x10,%ecx
 193:   48 d3 e2                shl    %cl,%rdx
 196:   48 d3 fa                sar    %cl,%rdx

Anyways, I'll switch it back to the original formula.  I'm not going
to argue any more about basic math.

Brian Gerst
