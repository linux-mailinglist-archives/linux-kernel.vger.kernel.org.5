Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735E47BFBCF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjJJMxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjJJMw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:52:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B24AAF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:52:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED77C433CB
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696942375;
        bh=iJDKWdvtQS5TT9+VNrY6wjrBGQRw7FK21y3XZcyH9jk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ThoriJ4UFma4dmv/4OwlMGM06PeoFGiYPwqz7QkiV3HqR+o+aBUC/5J2d/MGOIEnG
         Ql06FD+tJwMtd0jj0Mxa/2UzI7nuJRTZWXZ+bdd1eL1ZSUlJyeORkwN5g4KLi2tIPn
         dPKNMHwFk7EwzEyzuTM2GwRxk76wJltm3HK1gVEN55Ol4W9v+TfPNvEJ7jXnUpN2Qu
         nyHW22nS10g3QOXVxcGhlFr/YRl74TPEuU5A3HSkmoIldzBBo4JtykSsU+UC+pSWAi
         PhACGP06otIOHB56lN+BHDkoKTIhGuX0SGsiz6taoVHTEponFgP7HbnLmh/bSahmJJ
         ZWC1/DN45USyw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so10035042a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:52:55 -0700 (PDT)
X-Gm-Message-State: AOJu0YwovqCF1a6xuGKdRzyz5bPa91f5Xue0mwnNkW6r9rb/ROM06VcL
        Sw6QS1yu2NnfvBHltz0pJ0EMzsrWd7WRfIlgTd8=
X-Google-Smtp-Source: AGHT+IHI61sbsjhZcrALcRKpIHbPnlmfjfUxYmJrSZpW784bpJkgW3oOq2RSZBeMLDxY8uswbCjFm6iqFgBQXwmkc4E=
X-Received: by 2002:aa7:df03:0:b0:532:c046:9e01 with SMTP id
 c3-20020aa7df03000000b00532c0469e01mr16461779edy.7.1696942373953; Tue, 10 Oct
 2023 05:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <1696856590-30298-1-git-send-email-yangtiezhu@loongson.cn> <1696856590-30298-5-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1696856590-30298-5-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 10 Oct 2023 20:52:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6bKnCjjbD=ghJvjYkD4vnMsUNzataMV965zvO=vzQf5Q@mail.gmail.com>
Message-ID: <CAAhV-H6bKnCjjbD=ghJvjYkD4vnMsUNzataMV965zvO=vzQf5Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] objtool/LoongArch: Enable orc to be built
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiezhu,

On Mon, Oct 9, 2023 at 9:03=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn>=
 wrote:
>
> Implement arch-specific init_orc_entry(), reg_name(), orc_type_name(),
> print_reg() and orc_print_dump(), then set BUILD_ORC as y to build the
> orc related files.
>
> Co-developed-by: Jinyang He <hejinyang@loongson.cn>
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> Co-developed-by: Youling Tang <tangyouling@loongson.cn>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/arch/loongarch/include/asm/orc_types.h |  58 ++++++++++
>  tools/objtool/Makefile                       |   4 +
>  tools/objtool/arch/loongarch/Build           |   1 +
>  tools/objtool/arch/loongarch/decode.c        |  16 +++
>  tools/objtool/arch/loongarch/orc.c           | 155 +++++++++++++++++++++=
++++++
>  5 files changed, 234 insertions(+)
>  create mode 100644 tools/arch/loongarch/include/asm/orc_types.h
>  create mode 100644 tools/objtool/arch/loongarch/orc.c
>
> diff --git a/tools/arch/loongarch/include/asm/orc_types.h b/tools/arch/lo=
ongarch/include/asm/orc_types.h
> new file mode 100644
> index 0000000..1d37e62
> --- /dev/null
> +++ b/tools/arch/loongarch/include/asm/orc_types.h
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef _ORC_TYPES_H
> +#define _ORC_TYPES_H
> +
> +#include <linux/types.h>
> +
> +/*
> + * The ORC_REG_* registers are base registers which are used to find oth=
er
> + * registers on the stack.
> + *
> + * ORC_REG_PREV_SP, also known as DWARF Call Frame Address (CFA), is the
> + * address of the previous frame: the caller's SP before it called the c=
urrent
> + * function.
> + *
> + * ORC_REG_UNDEFINED means the corresponding register's value didn't cha=
nge in
> + * the current frame.
> + *
> + * The most commonly used base registers are SP and BP -- which the prev=
ious SP
> + * is usually based on -- and PREV_SP and UNDEFINED -- which the previou=
s BP is
> + * usually based on.
> + *
> + * The rest of the base registers are needed for special cases like entr=
y code
> + * and GCC realigned stacks.
> + */
> +#define ORC_REG_UNDEFINED              0
> +#define ORC_REG_PREV_SP                        1
> +#define ORC_REG_SP                     2
> +#define ORC_REG_BP                     3
There is no BP register for LoongArch, so I think all 'BP' should be
'FP' in this patch.

Huacai

> +#define ORC_REG_MAX                    4
> +
> +#define ORC_TYPE_UNDEFINED             0
> +#define ORC_TYPE_END_OF_STACK          1
> +#define ORC_TYPE_CALL                  2
> +#define ORC_TYPE_REGS                  3
> +#define ORC_TYPE_REGS_PARTIAL          4
> +
> +#ifndef __ASSEMBLY__
> +/*
> + * This struct is more or less a vastly simplified version of the DWARF =
Call
> + * Frame Information standard.  It contains only the necessary parts of =
DWARF
> + * CFI, simplified for ease of access by the in-kernel unwinder.  It tel=
ls the
> + * unwinder how to find the previous SP and BP (and sometimes entry regs=
) on
> + * the stack for a given code address.  Each instance of the struct corr=
esponds
> + * to one or more code locations.
> + */
> +struct orc_entry {
> +       s16             sp_offset;
> +       s16             bp_offset;
> +       s16             ra_offset;
> +       unsigned int    sp_reg:4;
> +       unsigned int    bp_reg:4;
> +       unsigned int    ra_reg:4;
> +       unsigned int    type:3;
> +       unsigned int    signal:1;
> +};
> +#endif /* __ASSEMBLY__ */
> +
> +#endif /* _ORC_TYPES_H */
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index 83b100c..bf7f7f8 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -57,6 +57,10 @@ ifeq ($(SRCARCH),x86)
>         BUILD_ORC :=3D y
>  endif
>
> +ifeq ($(SRCARCH),loongarch)
> +       BUILD_ORC :=3D y
> +endif
> +
>  export BUILD_ORC
>  export srctree OUTPUT CFLAGS SRCARCH AWK
>  include $(srctree)/tools/build/Makefile.include
> diff --git a/tools/objtool/arch/loongarch/Build b/tools/objtool/arch/loon=
garch/Build
> index d24d563..1d4b784 100644
> --- a/tools/objtool/arch/loongarch/Build
> +++ b/tools/objtool/arch/loongarch/Build
> @@ -1,2 +1,3 @@
>  objtool-y +=3D decode.o
>  objtool-y +=3D special.o
> +objtool-y +=3D orc.o
> diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/l=
oongarch/decode.c
> index 3a426e4..1c96759 100644
> --- a/tools/objtool/arch/loongarch/decode.c
> +++ b/tools/objtool/arch/loongarch/decode.c
> @@ -3,6 +3,8 @@
>  #include <objtool/check.h>
>  #include <objtool/warn.h>
>  #include <asm/inst.h>
> +#include <asm/orc_types.h>
> +#include <linux/objtool_types.h>
>
>  int arch_ftrace_match(char *name)
>  {
> @@ -38,6 +40,20 @@ bool arch_callee_saved_reg(unsigned char reg)
>
>  int arch_decode_hint_reg(u8 sp_reg, int *base)
>  {
> +       switch (sp_reg) {
> +       case ORC_REG_UNDEFINED:
> +               *base =3D CFI_UNDEFINED;
> +               break;
> +       case ORC_REG_SP:
> +               *base =3D CFI_SP;
> +               break;
> +       case ORC_REG_BP:
> +               *base =3D CFI_FP;
> +               break;
> +       default:
> +               return -1;
> +       }
> +
>         return 0;
>  }
>
> diff --git a/tools/objtool/arch/loongarch/orc.c b/tools/objtool/arch/loon=
garch/orc.c
> new file mode 100644
> index 0000000..7d7ecee
> --- /dev/null
> +++ b/tools/objtool/arch/loongarch/orc.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/objtool_types.h>
> +#include <asm/orc_types.h>
> +
> +#include <objtool/check.h>
> +#include <objtool/orc.h>
> +#include <objtool/warn.h>
> +#include <objtool/endianness.h>
> +
> +int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi, struct =
instruction *insn)
> +{
> +       struct cfi_reg *bp =3D &cfi->regs[CFI_BP];
> +       struct cfi_reg *ra =3D &cfi->regs[CFI_RA];
> +
> +       memset(orc, 0, sizeof(*orc));
> +
> +       if (!cfi) {
> +               /*
> +                * This is usually either unreachable nops/traps (which d=
on't
> +                * trigger unreachable instruction warnings), or
> +                * STACK_FRAME_NON_STANDARD functions.
> +                */
> +               orc->type =3D ORC_TYPE_UNDEFINED;
> +               return 0;
> +       }
> +
> +       switch (cfi->type) {
> +       case UNWIND_HINT_TYPE_UNDEFINED:
> +               orc->type =3D ORC_TYPE_UNDEFINED;
> +               return 0;
> +       case UNWIND_HINT_TYPE_END_OF_STACK:
> +               orc->type =3D ORC_TYPE_END_OF_STACK;
> +               return 0;
> +       case UNWIND_HINT_TYPE_CALL:
> +               orc->type =3D ORC_TYPE_CALL;
> +               break;
> +       case UNWIND_HINT_TYPE_REGS:
> +               orc->type =3D ORC_TYPE_REGS;
> +               break;
> +       case UNWIND_HINT_TYPE_REGS_PARTIAL:
> +               orc->type =3D ORC_TYPE_REGS_PARTIAL;
> +               break;
> +       default:
> +               WARN_INSN(insn, "unknown unwind hint type %d", cfi->type)=
;
> +               return -1;
> +       }
> +
> +       orc->signal =3D cfi->signal;
> +
> +       switch (cfi->cfa.base) {
> +       case CFI_SP:
> +               orc->sp_reg =3D ORC_REG_SP;
> +               break;
> +       case CFI_BP:
> +               orc->sp_reg =3D ORC_REG_BP;
> +               break;
> +       default:
> +               WARN_INSN(insn, "unknown CFA base reg %d", cfi->cfa.base)=
;
> +               return -1;
> +       }
> +
> +       switch (bp->base) {
> +       case CFI_UNDEFINED:
> +               orc->bp_reg =3D ORC_REG_UNDEFINED;
> +               orc->bp_offset =3D 0;
> +               break;
> +       case CFI_CFA:
> +               orc->bp_reg =3D ORC_REG_PREV_SP;
> +               orc->bp_offset =3D bp->offset;
> +               break;
> +       case CFI_BP:
> +               orc->bp_reg =3D ORC_REG_BP;
> +               break;
> +       default:
> +               WARN_INSN(insn, "unknown BP base reg %d", bp->base);
> +               return -1;
> +       }
> +
> +       switch (ra->base) {
> +       case CFI_UNDEFINED:
> +               orc->ra_reg =3D ORC_REG_UNDEFINED;
> +               orc->ra_offset =3D 0;
> +               break;
> +       case CFI_CFA:
> +               orc->ra_reg =3D ORC_REG_PREV_SP;
> +               orc->ra_offset =3D ra->offset;
> +               break;
> +       case CFI_BP:
> +               orc->ra_reg =3D ORC_REG_BP;
> +               break;
> +       default:
> +               WARN_INSN(insn, "unknown RA base reg %d", ra->base);
> +               return -1;
> +       }
> +
> +       orc->sp_offset =3D cfi->cfa.offset;
> +
> +       return 0;
> +}
> +
> +static const char *reg_name(unsigned int reg)
> +{
> +       switch (reg) {
> +       case ORC_REG_SP:
> +               return "sp";
> +       case ORC_REG_BP:
> +               return "fp";
> +       case ORC_REG_PREV_SP:
> +               return "prevsp";
> +       default:
> +               return "?";
> +       }
> +}
> +
> +static const char *orc_type_name(unsigned int type)
> +{
> +       switch (type) {
> +       case UNWIND_HINT_TYPE_CALL:
> +               return "call";
> +       case UNWIND_HINT_TYPE_REGS:
> +               return "regs";
> +       case UNWIND_HINT_TYPE_REGS_PARTIAL:
> +               return "regs (partial)";
> +       default:
> +               return "?";
> +       }
> +}
> +
> +static void print_reg(unsigned int reg, int offset)
> +{
> +       if (reg =3D=3D ORC_REG_UNDEFINED)
> +               printf(" (und) ");
> +       else
> +               printf("%s + %3d", reg_name(reg), offset);
> +
> +}
> +
> +void orc_print_dump(struct elf *dummy_elf, struct orc_entry *orc, int i)
> +{
> +       printf("type:%s", orc_type_name(orc[i].type));
> +
> +       printf(" sp:");
> +
> +       print_reg(orc[i].sp_reg, bswap_if_needed(dummy_elf, orc[i].sp_off=
set));
> +
> +       printf(" bp:");
> +
> +       print_reg(orc[i].bp_reg, bswap_if_needed(dummy_elf, orc[i].bp_off=
set));
> +
> +       printf(" ra:");
> +
> +       print_reg(orc[i].ra_reg, bswap_if_needed(dummy_elf, orc[i].ra_off=
set));
> +
> +       printf(" signal:%d\n", orc[i].signal);
> +}
> --
> 2.1.0
>
