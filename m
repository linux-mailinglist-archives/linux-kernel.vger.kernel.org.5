Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD247929F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355195AbjIEQai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354226AbjIEKMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:12:02 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478CBCF6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 03:11:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5007abb15e9so3872211e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 03:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693908712; x=1694513512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHEH9rnQ97SImbcU7qAAWtu/p+2tFkTRvQr/ac40kco=;
        b=S5cUGFOtH8m2eNDiQ6GW92zAaBgv668/nJ6gExtSPk08Fj8uxpkQFps3xRBf8AcBIp
         9CYSzIBNkY+2AsNoOi8tN5E39qprTabVmkvkMkSCikX0/ZXy5fsNIs2vQmHZrPapgsYO
         StT5+gd0qD3YSsb4p5fNYpbnKo8HntukXzsUd9/RsxnJBxNLq5Zpf9OF3l1Ft/WBJ+3l
         5ZYcVF9GvwLVD+ZkSPe7MWdj/PDMVHxEWdsfSKEV59acpus/Itu52Qo5M33KoEmk8AxM
         Sf85/obZc9AmREsW6Fn+kJfAHk/wC/qIn+ADFio/D/2pdTB6zWto/ZjyESc+zR8xaxop
         OLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693908712; x=1694513512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHEH9rnQ97SImbcU7qAAWtu/p+2tFkTRvQr/ac40kco=;
        b=BF/9khei4eciTSY+GqgF0/8ahVLPx9L+XLoqyQsMRqxV2gWQqh+gq6o8/g9kYE7JXC
         5pN2dZ8wJjFHi9cXovtg1B8LhHnF7E02gkzVNZbbIupDyscul7t/hdzNY9xOnOsvt8ah
         2l40YZbAOb9OsgcUGkYWIrCOuRrM4IvBMgYt8l4AykjjhHw4QB81aLNL3+M0r3KZRpHf
         clMbErwwVSDpIIOfxrx8stl6iQeEF6QbMGtICwWwexRZmXEzrnZ09yNPDcsahgJzDWc1
         49A+lHPPbm+yms9XNXrAGJdZaoge9xlqWiu8Z7jL5LFAsY5ixjKm3sgLwdRMXZI/fRtC
         dx0A==
X-Gm-Message-State: AOJu0YxkMWeyGrcI0gmOrjfW+g29oyLDcZ0dbXU75TlSLyGdWUQj9hGx
        cFKOZnV1iEckTrSjyBwvOdrevxS9AusOvZ+1m+Cb6BoNqIfXiw==
X-Google-Smtp-Source: AGHT+IF9IY3RYqucOi52/vHPu6UTpRWZ5T237B6hgu9ACXAHR7ZkPR60rDE2lf9Xe3hy4iPJ0vDCJA7I/NgY9ZUVE1Y=
X-Received: by 2002:a05:6512:3990:b0:500:9734:b415 with SMTP id
 j16-20020a056512399000b005009734b415mr9566704lfu.30.1693908712167; Tue, 05
 Sep 2023 03:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230904152230.9227-1-ubizjak@gmail.com> <ZPb5kt_XD6Ta2X6n@FVFF77S0Q05N>
In-Reply-To: <ZPb5kt_XD6Ta2X6n@FVFF77S0Q05N>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 5 Sep 2023 12:11:40 +0200
Message-ID: <CAFULd4Yc3g1+20X6xaKmDJ_eGt17Ea=RHtKm7d21-Fci5ZbtHQ@mail.gmail.com>
Subject: Re: [PATCH] panic: Use atomic_try_cmpxchg in panic() and nmi_panic()
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
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

On Tue, Sep 5, 2023 at 11:49=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Mon, Sep 04, 2023 at 05:21:01PM +0200, Uros Bizjak wrote:
> > Use atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) =3D=
=3D old
> > in panic() and nmi_panic().  x86 CMPXCHG instruction returns success in
> > ZF flag, so this change saves a compare after cmpxchg (and related move
> > instruction in front of cmpxchg).
> >
> > Also, rename cpu variable to this_cpu in nmi_panic() and try to unify
> > logic flow between panic() and nmi_panic().
> >
> > No functional change intended.
>
> Do we really need to save a compare here? A panic isn't exactly a fast pa=
th,
> and robustness and code clarity is far more important than performance he=
re.
>
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > ---
> >  kernel/panic.c | 22 +++++++++++++---------
> >  1 file changed, 13 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index 07239d4ad81e..8740ac65cb2c 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -192,14 +192,15 @@ atomic_t panic_cpu =3D ATOMIC_INIT(PANIC_CPU_INVA=
LID);
> >   */
> >  void nmi_panic(struct pt_regs *regs, const char *msg)
> >  {
> > -     int old_cpu, cpu;
> > +     int old_cpu, this_cpu;
> >
> > -     cpu =3D raw_smp_processor_id();
> > -     old_cpu =3D atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, cpu);
> > +     old_cpu =3D PANIC_CPU_INVALID;
> > +     this_cpu =3D raw_smp_processor_id();
> >
> > -     if (old_cpu =3D=3D PANIC_CPU_INVALID)
> > +     /* atomic_try_cmpxchg updates old_cpu on failure */
> > +     if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu))
> >               panic("%s", msg);
> > -     else if (old_cpu !=3D cpu)
> > +     else if (old_cpu !=3D this_cpu)
> >               nmi_panic_self_stop(regs);
> >  }
> >  EXPORT_SYMBOL(nmi_panic);
> > @@ -311,15 +312,18 @@ void panic(const char *fmt, ...)
> >        * stop themself or will wait until they are stopped by the 1st C=
PU
> >        * with smp_send_stop().
> >        *
> > -      * `old_cpu =3D=3D PANIC_CPU_INVALID' means this is the 1st CPU w=
hich
> > -      * comes here, so go ahead.
> > +      * cmpxchg success means this is the 1st CPU which comes here,
> > +      * so go ahead.
> >        * `old_cpu =3D=3D this_cpu' means we came from nmi_panic() which=
 sets
> >        * panic_cpu to this CPU.  In this case, this is also the 1st CPU=
.
> >        */
> > +     old_cpu =3D PANIC_CPU_INVALID;
> >       this_cpu =3D raw_smp_processor_id();
> > -     old_cpu  =3D atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_c=
pu);
> >
> > -     if (old_cpu !=3D PANIC_CPU_INVALID && old_cpu !=3D this_cpu)
> > +     /* atomic_try_cmpxchg updates old_cpu on failure */
> > +     if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu))
> > +             ;
> > +     else if (old_cpu !=3D this_cpu)
> >               panic_smp_self_stop();
>
> That empty statement is quite painful to read and would be easy to break =
in
> future with other changes. It'd be better to either avoid that entirely, =
or use
> braces, e.g.
>
>         if (!atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu) &&
>             old_cpu !=3D this_cpu)
>                  panic_smp_self_stop();
>
> ... or:
>
>         if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
>                 /* do nothing */
>         } else if (old_cpu !=3D this_cpu) {
>                 panic_smp_self_stop();
>         }
>
> The former is closer to the existing logic, so that's probably best.

The reason for the split of the conditional is the comment above the
function that says to go ahead in case old_cpu =3D=3D PANIC_CPU_INVALID
(or with patch, in case cmpxchg succeeds). I think that with the split
conditional it is easier to follow the logic, so maybe this part of
the code should read:

    /* atomic_try_cmpxchg updates old_cpu on failure */
    if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
        /* go ahead */
    } else if (old_cpu !=3D this_cpu)
        panic_smp_self_stop();

Uros.
