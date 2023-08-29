Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CEF78C474
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbjH2MsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbjH2Mru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:47:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08517C0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E3AB617E1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED69BC433C9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693313266;
        bh=ZPmIeIIoXWcok2AYVU0nQSTUFZ/WHtGi8637bsdEXzc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KRu4pL58adMRb9bw51nG9gOsgR2v3cYkgH8FOROqoZc0aecbj6DjRObOGhF6wTur0
         ZTthKYEVbyDVtMOCZEEHcZDPUzBAvD1C41+Y6U/j5D4FzL8Sguf+tROJ+BtWewWoJl
         cEkR/OsO9DaOmSYXDzpuFRoxarXGYjGqRrsku2GpLkmGFM8wucGZR26G0m4B1fdMYJ
         jwkTSRKVjOTUyj7Kkyz759Y7pQE2OEjwSuRV1yJYwteZzHc5wMWuU4V6quem6TX2Ww
         fvG58hzFOn4yVQ2umLdkDpRCPuge0D6kK1t1G7yZfX4hjsNPyWML5rVy5ms6tPzBRi
         u5iAhe9o9ZA3w==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-99bcf2de59cso575598566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:47:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YwE46iKf6AvlGrWLLLSc4ak1/MrZoxsK6y+apSfpHGNJvXWhNzi
        FxsUwrHokzLmUqFdTmp9jJcweLFR+j5Arnr68i0=
X-Google-Smtp-Source: AGHT+IFh0DhlMY3u4JsUm66loxt5MstXiFdmK81tz9T03kyGfYLRywdvfMMH4gbgsye/dHg8/fHxR32Giaep3ekOXNk=
X-Received: by 2002:a17:907:789a:b0:99c:e037:e4b8 with SMTP id
 ku26-20020a170907789a00b0099ce037e4b8mr22947255ejc.72.1693313264133; Tue, 29
 Aug 2023 05:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <1693290485-3516-1-git-send-email-yangtiezhu@loongson.cn>
 <b826520103c7462b0c2f10a7bc69347799d1217b.camel@xry111.site> <a4bd839b-d55e-07e5-67a5-016d77f77112@loongson.cn>
In-Reply-To: <a4bd839b-d55e-07e5-67a5-016d77f77112@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 29 Aug 2023 20:47:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7BDyeU5UNOV2QJm+vOKyk1_1K2bnS8TKMyLUZ57A4++g@mail.gmail.com>
Message-ID: <CAAhV-H7BDyeU5UNOV2QJm+vOKyk1_1K2bnS8TKMyLUZ57A4++g@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Define the symbol fault as a local label in fpu.S
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 8:40=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
>
>
> On 08/29/2023 02:45 PM, Xi Ruoyao wrote:
> > On Tue, 2023-08-29 at 14:28 +0800, Tiezhu Yang wrote:
> >> The initial aim is to silence the following objtool warnings:
> >>
> >>   arch/loongarch/kernel/fpu.o: warning: objtool: _save_fp_context() fa=
lls through to next function fault()
> >>   arch/loongarch/kernel/fpu.o: warning: objtool: _restore_fp_context()=
 falls through to next function fault()
> >>   arch/loongarch/kernel/fpu.o: warning: objtool: _save_lsx_context() f=
alls through to next function fault()
> >>   arch/loongarch/kernel/fpu.o: warning: objtool: _restore_lsx_context(=
) falls through to next function fault()
> >>   arch/loongarch/kernel/fpu.o: warning: objtool: _save_lasx_context() =
falls through to next function fault()
> >>   arch/loongarch/kernel/fpu.o: warning: objtool: _restore_lasx_context=
() falls through to next function fault()
> >>
> >> Obviously, the symbol fault is not a function, it is just a local labe=
l,
> >
> > Hmm why?  To me this seems a function.  We don't branch to it but store
> > its address (a "function pointer") in the extable.
> >
> > And these warnings do not make any sense to me:
> >
> > /* snip */
> >
> >> diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
> >> index b4032de..7defe50 100644
> >> --- a/arch/loongarch/kernel/fpu.S
> >> +++ b/arch/loongarch/kernel/fpu.S
> >> @@ -521,7 +521,7 @@ SYM_FUNC_START(_restore_lasx_context)
> >>         jr      ra
> >
> > _restore_lasx_context returns with this instruction.  How can it fall
> > through into fault?
> >
> >>  SYM_FUNC_END(_restore_lasx_context)
> >
> >> -SYM_FUNC_START(fault)
> >> +SYM_CODE_START_LOCAL(fault)
> >>         li.w    a0, -EFAULT                             # failure
> >>         jr      ra
> >> -SYM_FUNC_END(fault)
> >> +SYM_CODE_END(fault)
> >
>
> In the current code, SYM_FUNC_END() defines the symbol as SYM_T_FUNC
> which is STT_FUNC, the objtool warnings are generated through the
> following code.
>
> arch/loongarch/include/asm/linkage.h
> #define SYM_FUNC_END(name)                              \
>         .cfi_endproc;                                   \
>         SYM_END(name, SYM_T_FUNC)
>
> include/linux/linkage.h
> /* SYM_T_FUNC -- type used by assembler to mark functions */
> #ifndef SYM_T_FUNC
> #define SYM_T_FUNC                              STT_FUNC
> #endif
>
> tools/objtool/include/objtool/check.h
> static inline struct symbol *insn_func(struct instruction *insn)
> {
>         struct symbol *sym =3D insn->sym;
>
>         if (sym && sym->type !=3D STT_FUNC)
>                 sym =3D NULL;
>
>         return sym;
> }
>
> tools/objtool/check.c
> static int validate_branch(struct objtool_file *file, struct symbol *func=
,
>                            struct instruction *insn, struct insn_state st=
ate)
> {
> ...
>         while (1) {
>                 next_insn =3D next_insn_to_validate(file, insn);
>
>                 if (func && insn_func(insn) && func !=3D insn_func(insn)-=
>pfunc) {
>                         /* Ignore KCFI type preambles, which always fall =
through */
>                         if (!strncmp(func->name, "__cfi_", 6) ||
>                             !strncmp(func->name, "__pfx_", 6))
>                                 return 0;
>
>                         WARN("%s() falls through to next function %s()",
>                              func->name, insn_func(insn)->name);
>                         return 1;
>                 }
> ...
> }
>
> We can see that the fixup can be a local label in the following code.
>
> arch/loongarch/include/asm/asm-extable.h
> #define __ASM_EXTABLE_RAW(insn, fixup, type, data)      \
>         .pushsection    __ex_table, "a";                \
>         .balign         4;                              \
>         .long           ((insn) - .);                   \
>         .long           ((fixup) - .);                  \
>         .short          (type);                         \
>         .short          (data);                         \
>         .popsection;
>
>         .macro          _asm_extable, insn, fixup
>         __ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_FIXUP, 0)
>         .endm
>
> Like arch/loongarch/lib/*.S does, I prefer the following changes,
> if you are ok, I will send v2 later.
>
> diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
> index b4032deb8e3b..3177725ea832 100644
> --- a/arch/loongarch/kernel/fpu.S
> +++ b/arch/loongarch/kernel/fpu.S
> @@ -22,7 +22,7 @@
>
>          .macro  EX insn, reg, src, offs
>   .ex\@: \insn   \reg, \src, \offs
> -       _asm_extable .ex\@, fault
> +       _asm_extable .ex\@, .L_fixup_fpu_fault
>          .endm
>
>          .macro sc_save_fp base
> @@ -521,7 +521,6 @@ SYM_FUNC_START(_restore_lasx_context)
>          jr      ra
>   SYM_FUNC_END(_restore_lasx_context)
>
> -SYM_FUNC_START(fault)
> +.L_fixup_fpu_fault:
>          li.w    a0, -EFAULT                             # failure
>          jr      ra
> -SYM_FUNC_END(fault)
You can only fix the fpu.S, lbt.S part can be squashed to its own patch.

Huacai

> diff --git a/arch/loongarch/kernel/lbt.S b/arch/loongarch/kernel/lbt.S
> index ecf08bbff650..402eb8ec4024 100644
> --- a/arch/loongarch/kernel/lbt.S
> +++ b/arch/loongarch/kernel/lbt.S
> @@ -16,7 +16,7 @@
>
>          .macro  EX insn, reg, src, offs
>   .ex\@: \insn   \reg, \src, \offs
> -       _asm_extable .ex\@, lbt_fault
> +       _asm_extable .ex\@, .L_fixup_lbt_fault
>          .endm
>
>   /*
> @@ -150,7 +150,6 @@ SYM_FUNC_START(_restore_ftop_context)
>          jr              ra
>   SYM_FUNC_END(_restore_ftop_context)
>
> -SYM_FUNC_START(lbt_fault)
> +.L_fixup_lbt_fault:
>          li.w            a0, -EFAULT             # failure
>          jr              ra
> -SYM_FUNC_END(lbt_fault)
>
> Thanks,
> Tiezhu
>
