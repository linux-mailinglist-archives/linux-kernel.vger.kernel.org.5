Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DDB7BC12E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbjJFVdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjJFVdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:33:14 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE48BF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:33:11 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50481a0eee7so4549317e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 14:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696627990; x=1697232790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rawKGi5+aCpZkW6aymum55S+bE/zcCvvHQE0Xng8Uug=;
        b=jT825H9VdFf+x9sgpCmYkRZNj4DvrlDGfyk2ayJd3WRAA7yMdGqKiwynz+SEMAkfsp
         6PQ5TEpakykRouGx2YGb/xewmqC1c0txwaC4mgHNvlnEJx6yRcPdK7zjB06EaNLGU9Pi
         H0A4vebKNrx2MxdRD8NZxyEehuqSubLsSovYsSP4K6pQegw5qBo7OxKQSYCGhv21iA6a
         nHm0KCo01AUphbjOezeonFSTokgGxTUl1cLdm6xLsLTQkakiQ4MjPmBcMqbFRrlShj5z
         ujQd6/MYKPnczWjuhxzbfLXtARgrm/yvTUtrv0KXz8AZxEwq0MgoQkF2xXrGE1TIvhcF
         Svnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696627990; x=1697232790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rawKGi5+aCpZkW6aymum55S+bE/zcCvvHQE0Xng8Uug=;
        b=A0Y5tXaLTuo1qnwR8lveZgUU4UIiNIjgD6y6nMqutL7i3ctsa054w+h6ENlY8el1in
         7suCsPvT+TUcsKsmo4+tDyC2/ADXeihvDykeaLckFx/sWm2B5dFLH/84LPTjiaPep9wz
         NhZr9pyc5PJku2pggqaB6yc40+fgLFFayWQPjKA5scjPt7gthptMA7iaXMeRfsNdgAW4
         LWlwFgQ6AkKlbOyry+XqqIxNk5OMG0b0n7S+rDKL3JBZZ089Wpfx32Pujh+TatxAjnav
         p54Yu1pJuvbg7kCZRCFbh7La4M3UqShlNT70/hUfskMvo7tK2wTh5pJlwWCXVeRV9fcU
         t26Q==
X-Gm-Message-State: AOJu0Yym1RAIB/zlYq12GWkJ2Yi8Husu2fwGM+PoXpDExZujWJ0je7Hq
        Ky4NUSWqQxJGyAY5ztilbsRvFPL9T+oMl3ryhQ==
X-Google-Smtp-Source: AGHT+IEMfzsbPLYHtPJIEks7Faun0TDoaT+GiR7oQeWkFswVhjGwOBPrl1TdT+uX/JdusBVtO3GwBS6U3z9CVyAOIMc=
X-Received: by 2002:a05:6512:318b:b0:4fd:daa0:aed8 with SMTP id
 i11-20020a056512318b00b004fddaa0aed8mr4310429lfe.4.1696627989550; Fri, 06 Oct
 2023 14:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230721161018.50214-1-brgerst@gmail.com> <ZR5yTecBhCFsVOtQ@gmail.com>
 <CAMzpN2j7qddPEUdD+ZX3dtyQkPq6e4gzwcu5szkZ2esh_8zm9g@mail.gmail.com>
 <ZR8an4+JbkLS8/Ol@gmail.com> <5def7e28-3949-9685-7ddf-19b550847ef0@zytor.com>
In-Reply-To: <5def7e28-3949-9685-7ddf-19b550847ef0@zytor.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 6 Oct 2023 17:32:58 -0400
Message-ID: <CAMzpN2jdGc1P4Ha_sO5RZv8M9RsHPA+KU3a9c5BdgX5O3D5Jew@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] x86: Clean up fast syscall return validation
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
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

On Fri, Oct 6, 2023 at 2:59=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrote=
:
>
> On 10/5/23 13:20, Ingo Molnar wrote:
> >
> > * Brian Gerst <brgerst@gmail.com> wrote:
> >
> >> Looking at the compiled output, the only suboptimal code appears to be
> >> the canonical address test, where the C code uses the CL register for
> >> the shifts instead of immediates.
> >>
> >>   180:   e9 00 00 00 00          jmp    185 <do_syscall_64+0x85>
> >>                          181: R_X86_64_PC32      .altinstr_aux-0x4
> >>   185:   b9 07 00 00 00          mov    $0x7,%ecx
> >>   18a:   eb 05                   jmp    191 <do_syscall_64+0x91>
> >>   18c:   b9 10 00 00 00          mov    $0x10,%ecx
> >>   191:   48 89 c2                mov    %rax,%rdx
> >>   194:   48 d3 e2                shl    %cl,%rdx
> >>   197:   48 d3 fa                sar    %cl,%rdx
> >>   19a:   48 39 d0                cmp    %rdx,%rax
> >>   19d:   75 39                   jne    1d8 <do_syscall_64+0xd8>
> >
> > Yeah, it didn't look equivalent - so I guess we want a C equivalent for=
:
> >
> > -       ALTERNATIVE "shl $(64 - 48), %rcx; sar $(64 - 48), %rcx", \
> > -               "shl $(64 - 57), %rcx; sar $(64 - 57), %rcx", X86_FEATU=
RE_LA57
> >
> > instead of the pgtable_l5_enabled() runtime test that
> > __is_canonical_address() uses?
> >
>
> I don't think such a thing (without simply duplicate the above as an
> alternative asm, which is obviously easy enough, and still allows the
> compiler to pick the register used) would be possible without immediate
> patching support[*].
>
> Incidentally, this is a question for Uros: is there a reason this is a
> mov to %ecx and not just %cl, which would save 3 bytes?
>
> Incidentally, it is possible to save one instruction and use only *one*
> alternative immediate:
>
>         leaq (%rax,%rax),%rdx
>         xorq %rax,%rdx
>         shrq $(63 - LA),%rdx            # Yes, 63, not 64
>         # ZF=3D1 if canonical
>
> This works because if bit [x] is set in the output, then bit [x] and
> [x-1] in the input are different (bit [-1] considered to be zero); and
> by definition a bit is canonical if and only if all the bits [63:LA] are
> identical, thus bits [63:LA+1] in the output must all be zero.
>
> The first two instructions are pure arithmetic and can thus be done in C:
>
>         bar =3D foo ^ (foo << 1);
>
> ... leaving only one instruction needing to be patched at runtime.
>
>         -hpa

One other alternative I have been considering is comparing against
TASK_SIZE_MAX.  The only user-executable address above that is the
long deprecated vsyscall page.  IMHO it's not worth optimizing for
that case, so just let it fall back to using IRET.

    if (unlikely(regs->ip >=3D TASK_SIZE_MAX)) return false;

compiles to:

 180:   48 b9 00 f0 ff ff ff    movabs $0x7ffffffff000,%rcx
 187:   7f 00 00
 18a:   48 39 c8                cmp    %rcx,%rax
 18d:   73 39                   jae    1c8 <do_syscall_64+0xc8>

0000000000000000 <.altinstr_replacement>:
   0:   48 b9 00 f0 ff ff ff    movabs $0xfffffffffff000,%rcx
   7:   ff ff 00

Brian Gerst
