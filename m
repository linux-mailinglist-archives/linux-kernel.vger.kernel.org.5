Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3B87BC693
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 11:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343784AbjJGJ5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 05:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343778AbjJGJ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 05:57:09 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24DEBC
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 02:57:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53627feca49so4945796a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 02:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696672625; x=1697277425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcqvIMKkfE5QIsgQKUvuiqQssRgDPpRj+/74oXDIspY=;
        b=VuAcebwJllMA47LbTWuxY5FCLpYsFIaMO5O5y326cNCiDuPLYa9uUbs5rYxik4Dcro
         1Nhv4b+jiwk5szFpRrwIrlQAQ5yNadCxKdL1ecnT2mDc/Zj4kxWrO3DBkJlsjRhZwDiQ
         TjLl+p6rhpyZhA+SgwqVh5r0tkBHDDg4LNIn21Xwk3L6LktmjbuDW41k7EaIMTjKk8em
         U4LuQ9sVLX63goe+OJy1RskWabhE8G4JB/65KrMDVAYBZG23yNx4VR5YtbaHHDZ2fge4
         yg3kN4/E8J1UPgYmvWzHIwn5P/nNlyoQWH3yd4FsZi696fnQmdqhuoNFS9WtXqYw7mOx
         COwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696672625; x=1697277425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcqvIMKkfE5QIsgQKUvuiqQssRgDPpRj+/74oXDIspY=;
        b=IJBAzFZt0ZnFJJPaehD6Ju3sPOQ+nZy2K92or+e1JDCKzzrTBdU16t4a6IBF/jyVRF
         zKN9idEuq7jXp+ADpVFppXVuQXzKdQSNgnc5S4NO1VPuEEDXD+OUIw3spdlK7+PtkQYb
         PUF5WDKsbVW807rPC0R9CirDlJYmASzwBx4CRw+NfNZ6nl113SvAtG9tJ+j7cQlaP2Q+
         U53P+YMXzz6UsS7hCHqCEYkAGWD7Ffz8S6ZPo+Z7Gi1gwcYPrRzSgiXtNS/Dz3YhOp9V
         ru3bS93rWvG3Kd7gDdWyLnIstc+KIw0lRzFNq2kiRQ93RYve7g5POBZS0EPN2bYMzM5p
         ptDQ==
X-Gm-Message-State: AOJu0YyHG1Ghu6asZUj3oN5Jhjbt2F1oZnU769XZFS0v3ujtieP4prkg
        QSdXG1cQdPKsGeR+QMBVch0rWYJIpWgahme9yTc=
X-Google-Smtp-Source: AGHT+IEvnPu8pP6V6n59ZTFaLnvAeDRyogsdYuYsHtxOe4bVbU3D+8WXXoGQysYwzLZTHQXNcfwdpzbN35mZT3KiGKs=
X-Received: by 2002:a05:6402:217:b0:533:4c15:c337 with SMTP id
 t23-20020a056402021700b005334c15c337mr8946052edv.16.1696672624908; Sat, 07
 Oct 2023 02:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230721161018.50214-1-brgerst@gmail.com> <ZR5yTecBhCFsVOtQ@gmail.com>
 <CAMzpN2j7qddPEUdD+ZX3dtyQkPq6e4gzwcu5szkZ2esh_8zm9g@mail.gmail.com>
 <ZR8an4+JbkLS8/Ol@gmail.com> <5def7e28-3949-9685-7ddf-19b550847ef0@zytor.com>
In-Reply-To: <5def7e28-3949-9685-7ddf-19b550847ef0@zytor.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Sat, 7 Oct 2023 11:56:58 +0200
Message-ID: <CAFULd4byZBKAUrJ2+5EoEaTHTXpk+0FFeFvze9r+Y1dTezG7YQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] x86: Clean up fast syscall return validation
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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

On Fri, Oct 6, 2023 at 8:59=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrote=
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

The compiler uses 32-bit mode to move values between registers, even
when they are less than 32-bit wide. To avoid partial register stalls,
it uses 32-bit mode as much as possible (e.g. zero-extends from memory
to load 8-bit value, load of 32-bit constant, etc). Since the kernel
is compiled with -O2, the compiler does not care that much for the
size of instructions, and it uses full 32-bit width to initialize
register with a constant.

Please note that 8-bit movb instruction in fact represents insert into
word-mode register. The compiler does not know how this word-mode
register will be used, so to avoid partial register stalls, it takes a
cautious approach and (with -O2) moves constant to a register with a
word-width instruction.

Also, the compiler is quite eager to CSE constants. When there are two
or more uses of the same constant, it will move a constant into the
register first.

Uros.
