Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431817BA5B8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242920AbjJEQTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241041AbjJEQPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:15:47 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DF722C83
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 08:13:30 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-505748580ceso1373498e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 08:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696518808; x=1697123608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WOkTf+KvQpYLbgOVg/WsRb6kzaoZFybJsqG8dX0T4M=;
        b=S46btaGgcK0lSAAkSnT0TDTueYNoAb0PtyoME7eO952szyqBDKaEIsd2My3ko03Snq
         WjSL1YD7s0pbLA9ZwF93zXv3f16oCcFud30eXZBFqH153znwPRUD0GguurDeWKJisGhE
         TusAow6z0zMk9aRLnr2Bqu0VpM3XrunX7172l8fu8J476LnUDoYWEJJYsSuaZ6ZNAg9W
         0qnC2NU5XaODIPWb5NmzW4R8KifE5wm+hTp4gRiq91WeZ6gO3SQbKAQijd9HyC38/Whc
         9B2yMhNL381Q4ASFIhUFC2bxRS1dahCp31feuX9KUfZlTzsa4pPGjT+L3JS41qsZNjMU
         qUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696518808; x=1697123608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WOkTf+KvQpYLbgOVg/WsRb6kzaoZFybJsqG8dX0T4M=;
        b=ue1rRr3NVuJF44XHIBbW2nLPZ6o2J12RT4lfQU0hSLzXyYV9NyQiXnao06R+czbpiU
         lbB1dqF5z52MkCEhck4C4rwESqtO4JRucUPOPylljeuHvftcoU3ZLXpFI7rkGw3fJKGR
         ON1Q32mkdlyhxblp0an5ww6MK/U0zAWyUlJpq3u5yqbeMZWtRwpSlZ/jxbOvPAzpyGV5
         fCKXoNP5j54qEeUA59mpIL8RuptRxhyu8cRpoqMtzoGcAipFkh1cJtwuiDX6ruFG6hDx
         oyGvqrpdE4Zu4F6XFOQHqI5wUls2VTVC0TvThO+cA0FLsqaS78xLgEQ7LVlcvSuzVWu1
         lQvg==
X-Gm-Message-State: AOJu0YwY3AAoJbmR+NsBlETv6O3Tj1z6Yhhjp7E999sVoFv324JsHbIg
        P7kYHyRHtTT7WddsIZgRas3wq+HKESYy7RGkYL7q8GMxMw==
X-Google-Smtp-Source: AGHT+IGPtBPrR+de4EGZi/YPvP2g877ZESnI56I1oZzAQVvWNy1Enf9xoao81I11XRPj3EH35m5fZ6h9lKbXkXJ+C/A=
X-Received: by 2002:ac2:4da8:0:b0:500:bffa:5b85 with SMTP id
 h8-20020ac24da8000000b00500bffa5b85mr4358930lfe.32.1696518807791; Thu, 05 Oct
 2023 08:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230721161018.50214-1-brgerst@gmail.com> <ZR5yTecBhCFsVOtQ@gmail.com>
In-Reply-To: <ZR5yTecBhCFsVOtQ@gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 5 Oct 2023 11:13:16 -0400
Message-ID: <CAMzpN2j7qddPEUdD+ZX3dtyQkPq6e4gzwcu5szkZ2esh_8zm9g@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] x86: Clean up fast syscall return validation
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
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

On Thu, Oct 5, 2023 at 4:22=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * Brian Gerst <brgerst@gmail.com> wrote:
>
> > This patch set cleans up the tests done to determine if a fast syscall
> > return instruction can be used to return to userspace.  It converts the
> > code to C, and refactors existing code to be more readable.
> >
> > v2:
> >  - Fix shift value for canonical RIP test and use
> >    __is_canonical_address()
> >
> > Brian Gerst (6):
> >   x86/entry/64: Remove obsolete comment on tracing vs. SYSRET
> >   x86/entry/64: Convert SYSRET validation tests to C
> >   x86/entry/compat: Combine return value test from syscall handler
> >   x86/entry/32: Convert do_fast_syscall_32() to bool return type
> >   x86/entry/32: Remove SEP test for SYSEXIT
> >   x86/entry/32: Clean up syscall fast exit tests
> >
> >  arch/x86/entry/common.c          | 99 +++++++++++++++++++++-----------
> >  arch/x86/entry/entry_32.S        |  2 +-
> >  arch/x86/entry/entry_64.S        | 68 +---------------------
> >  arch/x86/entry/entry_64_compat.S | 12 ++--
> >  arch/x86/include/asm/syscall.h   |  6 +-
> >  5 files changed, 77 insertions(+), 110 deletions(-)
>
> Ok, so I've applied patches #1, #3, #4 and #5 to tip:x86/entry,
> (ie. skipped #2 & #6 for now), as they look correct and are good
> improvements. None of these four patches depend on the skipped
> patches in some way I missed, correct?
>
> As for #2, I looked at the before/after disassembly, and the new
> C code in do_syscall_64() looked suboptimal on x86-64 defconfig,
> if I was reading it right.
>
> Mind re-evaluating that, and if you still think the C conversion
> is a good idea, mind putting a before/after analysis of the
> generated instructions into the changelog? This is our primary
> system call return path after all.

Looking at the compiled output, the only suboptimal code appears to be
the canonical address test, where the C code uses the CL register for
the shifts instead of immediates.

 180:   e9 00 00 00 00          jmp    185 <do_syscall_64+0x85>
                        181: R_X86_64_PC32      .altinstr_aux-0x4
 185:   b9 07 00 00 00          mov    $0x7,%ecx
 18a:   eb 05                   jmp    191 <do_syscall_64+0x91>
 18c:   b9 10 00 00 00          mov    $0x10,%ecx
 191:   48 89 c2                mov    %rax,%rdx
 194:   48 d3 e2                shl    %cl,%rdx
 197:   48 d3 fa                sar    %cl,%rdx
 19a:   48 39 d0                cmp    %rdx,%rax
 19d:   75 39                   jne    1d8 <do_syscall_64+0xd8>

Was there anything else specifically that you can point out?

Brian Gerst
