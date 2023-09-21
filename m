Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0364E7A9E69
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjIUUBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjIUUAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:00:52 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF36101A8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:30:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c382f23189so12785ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695317397; x=1695922197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2rhuVc5nDe//8n4ZYcZiDm+U/AGb9s4mBHSicI1GSU=;
        b=KXcVOliK0C28HKNXNLsMoYaaB/NzIZWBQg185Wd+Br038cWTT4P0ZjYVj9aPY8jzpg
         MvfpxtPVj4/QaSEje7FROcodnuUQYQJgFmD4UDEZBuJLtSQUPhAqaL1BNdVWbrOVbuEd
         IR+huad0dWiKg+ph565KOJ0yThD3PZ/uhn2fOBtLykfS102yXmdAd4TCJOEtV3GFDuc0
         edRjKRFEecv3usN8wZo35GVEVXPdEhqApdvLIiRM2MKEfcPkT+v7pys30/fBcKkHKQKw
         Y/ti0W126yvxvTBH9cbk4u5cZD/gRGFXPtcK9z0ZYlBKw0WoAv4uybraZCSoMfuvCjj8
         cBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317397; x=1695922197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2rhuVc5nDe//8n4ZYcZiDm+U/AGb9s4mBHSicI1GSU=;
        b=dlXpwB3lmFZhDSLXmTffdyreGn+7mBoqDGwvwMa74usievNl/yyZBg1wvHgLvZgjdN
         CJRfpCEaq/wc40l4+/VDV/RQq+fRUXTuIifw4xfYGo4cYST7RtsaHqm9dTuIYStSlbSe
         15Lm4OV3b96q04M95hxvuAKKld4MttuEptqyjidMj35jw4mes55vGMl8ZNplkQTGc5vW
         enHdJtRL6sQfDaTAfYLmd5o71sqi8u/t+KedMVSeKqXh2YTrqa4HLG/iQvLoq27OXraV
         +H17cdgl1hpNBM+hm8Ep0TY7+vhU/GhZBLpgichBoQTNbouIR46a7uW45t6Z5YC/kAxI
         sK7w==
X-Gm-Message-State: AOJu0YwnLBhwWopfYoC2febMN9LtLLnCyPL6sOgfJvhfEmfx7T99bZwo
        OYjinNVnNI5SzRQFEV5WVQYzrC6+c3q41gdHyDcD45WTx1VsF1pt8TApRg==
X-Google-Smtp-Source: AGHT+IEZxStINr93IpohyJB9AbIwy1arHrw2m221GKh/X/f6s+z2YlLr2FxQ4xoq5T6PXi/9DfYfuXLWX6YuhYB6jXg=
X-Received: by 2002:a05:622a:1341:b0:417:9045:50c9 with SMTP id
 w1-20020a05622a134100b00417904550c9mr303608qtk.22.1695313614576; Thu, 21 Sep
 2023 09:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230920001728.1439947-1-maskray@google.com> <20230921072655.GA14803@noisy.programming.kicks-ass.net>
 <CAFP8O3+_8H+fetuoqwwcfqJLNtYmpsWZhY2arD7HMuPmcN+X_g@mail.gmail.com> <20230921153537.GG14803@noisy.programming.kicks-ass.net>
In-Reply-To: <20230921153537.GG14803@noisy.programming.kicks-ass.net>
From:   Fangrui Song <maskray@google.com>
Date:   Thu, 21 Sep 2023 09:26:43 -0700
Message-ID: <CAFP8O3K6Lgxe=Res9d2GKipRYdXqzv3wa_0PLtDcyn7g7H=z5w@mail.gmail.com>
Subject: Re: [PATCH] x86/speculation, objtool: Use absolute relocations for annotations
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 8:35=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Sep 21, 2023 at 12:58:13AM -0700, Fangrui Song wrote:
> > On Thu, Sep 21, 2023 at 12:26=E2=80=AFAM Peter Zijlstra <peterz@infrade=
ad.org> wrote:
> > >
> > > On Tue, Sep 19, 2023 at 05:17:28PM -0700, Fangrui Song wrote:
> > > > .discard.retpoline_safe sections do not have the SHF_ALLOC flag.  T=
hese
> > > > sections referencing text sections' STT_SECTION symbols with PC-rel=
ative
> > > > relocations like R_386_PC32 [0] is conceptually not suitable.  Newe=
r
> > > > LLD will report warnings for REL relocations even for relocatable l=
inks
> > > > [1].
> > > >
> > > >     ld.lld: warning: vmlinux.a(drivers/i2c/busses/i2c-i801.o):(.dis=
card.retpoline_safe+0x120): has non-ABS relocation R_386_PC32 against symbo=
l ''
> > >
> > > What, why ?!? Please explain more.
> >
> > This can be read as a pedantic warning from the linker.
> >
> > A location relocated by an R_386_PC32 relocation in
> > .discard.retpoline_safe records an offset from the current location
> > (non-allocable) to an text symbol.
> > This offset is conceptually not suitable: in the ELF object file
> > format's model, the non-SHF_ALLOC section is not part of the memory
> > image, so
> > we cannot say that the offset from the non-memory thing to a text
> > symbol is a fixed value.
>
> Bah, so why has this worked at all then? Clearly the linkers aren't very
> strict about things.

GNU ld isn't very strict, but LLD has had a warning for
non-relocatable links for a long time
(https://github.com/llvm/llvm-project/blob/main/lld/test/ELF/non-abs-reloc.=
s).
LLD just did not report warnings for relocatable links.

> Anyway, I think what we want is to just mark the section SHF_ALLOC. The
> reason is that one of the plans we have is to collapse all the different
> annotations into a single section and then have something like:
>
>         struct objtoo_annotation {
>                 s32 location;
>                 u32 type;
>         }
>
> So that we can easily extend the annotations and don't need to add
> yet-another-section-reader-function to objtool.
>
> This is just one of the things we've not gotten around to yet. But as
> is, we have:
>
>         .discard.unreachable
>         .discard.reachable
>         .discard.func_stack_frame_non_standard
>         .discard.ignore_alts
>         .discard.unwind_hints
>         .discard.noendbr
>         .discard.retpoline_safe
>         .discard.instr_end
>         .discard.instr_begin
>         .discard.validate_unret
>         .discard.intra_function_calls
>
> And with the exception of unwind_hints, they're all just trivial
> location things.
>
> The very last thing we need is yet more of that.

If these sections are guaranteed to be discarded (*(.discard.*) in
scripts/module.lds.S and include/asm-generic/vmlinux.lds.h),
using non-SHF_ALLOC sections isn't a bad choice.
The intention is actually clearer.

> If we were to use absolute things, we get 12 byte entries and while that
> probably wouldn't spell the end of the world, why make thing larger than
> they have to be.
>
> After all, its not like any of this actually survives the final link.

I do not see why absolute things need 12 byte entries.
We can freely use `.long .text.foo` even in ELFCLASS64 object files.
There is no risk of overflow (the ultimate link .text.foo may have an
address of 0xffffffff........) since the section will be discarded.

Referencing SHF_ALLOC sections with absolute relocations in
non-SHF_ALLOC sections has well-defined semantics, as used by .debug_*
sections.


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
