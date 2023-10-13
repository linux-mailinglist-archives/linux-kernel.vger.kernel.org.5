Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67ACC7C865F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjJMNGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjJMNGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:06:11 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDD0BD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:06:10 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so25057771fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697202369; x=1697807169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DK51toRuvEyC4XxD8JJ3v08lCOGveUpNKHDsanrs0bg=;
        b=I1M7lfgQQVYPiPMX5n6H+uAr/Ms1StJdQ5MvNxqeAXwDCkMQGRkr/iMpTOifpHV6TW
         xyf5QTFmA+FOvN+UHpc5VvqZCgkLNWf6Ek6xfiDqteIazEVjghS4XE4mOhherhXSTVC+
         5k6PAC/2/FNUhgIwgfTbFmoAWJPyxW++R2zKCNTkeDqUkIkESDVUJpAjmCCQqQWZDK90
         Q9ljt15ni1Urm9Vyu8wz4qcXhSOlid+BuRi3rs1KId5JW+xk7xUpehu6D293I/ldLQJp
         fxWnf3e95fLhH0pbq2qqqzdLTYLYuyvNPYJu7e1h0Jwd+FNqzYjdf9RYIAKTCNtCGL56
         Wo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697202369; x=1697807169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DK51toRuvEyC4XxD8JJ3v08lCOGveUpNKHDsanrs0bg=;
        b=P+7f6wqAXwu3qii4pkgDSNDV4W3+Fn2uZgCfhfqF/oA8MliWPwCbXlm1uyGQbzzLtD
         R10O2h6diRtt06SKLmYI/DzgkHVAYVZt7zIMzufPZv8i4ImGHK0w2T6AfYruMlbLj6OF
         KVWKaI0cwCwIcEsRv4nv/5eKpkYWvXlyLuSS80LWk2TYpvFmyXpL1kDziPV8+v8HBCh7
         uYY99evV8ogy5ccXTKcbwt+EVuXUd0Nax1KuB1Egt/ovWcWHiIPWSMEaWdKda+NaAI4T
         0vr04OpLj2yrpsZ8jBghnotfjwpAJ8WG6av4Kkm3cnVzCpnDwqqv2GwxFpodWUCv458Z
         oNBQ==
X-Gm-Message-State: AOJu0YzceSBf4e98QFTdpidKhTACIJuCgUvh5NRoFiiHeOufgqPX6OWU
        RcnhkIswDgYO/HH+FKnzxFvImGPFcXi/KygFIg==
X-Google-Smtp-Source: AGHT+IFOQDqVu2VVbVYv+QVYi8VkQku+W+tBpf1uvDqh7LU/iyX02lA0Z5aiIi6oY+xRc3sLxgXNcDK/7AaVIOTVhC8=
X-Received: by 2002:a05:6512:ea5:b0:502:f2a4:152f with SMTP id
 bi37-20020a0565120ea500b00502f2a4152fmr29412611lfb.10.1697202368314; Fri, 13
 Oct 2023 06:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231011224351.130935-1-brgerst@gmail.com> <20231011224351.130935-2-brgerst@gmail.com>
 <2df50490-a493-4e27-a8b1-15b094ab99d8@suse.com>
In-Reply-To: <2df50490-a493-4e27-a8b1-15b094ab99d8@suse.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 13 Oct 2023 09:05:56 -0400
Message-ID: <CAMzpN2gsRqO3eFtHFvCddNOWPQunuTc7W=OKxdGhqodq0oYQkg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] x86/entry/64: Convert SYSRET validation tests to C
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
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

On Fri, Oct 13, 2023 at 8:39=E2=80=AFAM Nikolay Borisov <nik.borisov@suse.c=
om> wrote:
>
>
>
> On 12.10.23 =D0=B3. 1:43 =D1=87., Brian Gerst wrote:
> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > ---
> >   arch/x86/entry/common.c        | 43 ++++++++++++++++++++++++++-
> >   arch/x86/entry/entry_64.S      | 53 ++-------------------------------=
-
> >   arch/x86/include/asm/syscall.h |  2 +-
> >   3 files changed, 45 insertions(+), 53 deletions(-)
> >
> > diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> > index 0551bcb197fb..207149a0a9b3 100644
> > --- a/arch/x86/entry/common.c
> > +++ b/arch/x86/entry/common.c
> > @@ -71,7 +71,8 @@ static __always_inline bool do_syscall_x32(struct pt_=
regs *regs, int nr)
> >       return false;
> >   }
> >
> > -__visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
> > +/* Returns true to return using SYSRET, or false to use IRET */
> > +__visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
> >   {
> >       add_random_kstack_offset();
> >       nr =3D syscall_enter_from_user_mode(regs, nr);
> > @@ -85,6 +86,46 @@ __visible noinstr void do_syscall_64(struct pt_regs =
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
>
>
> Under what conditions do we expect this to not be true since we've come
> via the syscall which adheres to this layout? IOW isn't this always
> going to be true and we can simply eliminate it?

Any syscall that can modify pt_regs, like sigreturn(), exec(), etc.
Also ptrace can change registers.

Brian Gerst
