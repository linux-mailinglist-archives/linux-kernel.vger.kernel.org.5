Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0667BFBB1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjJJMpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjJJMpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:45:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E26AF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:45:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CECC433CB
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696941950;
        bh=+tbJlB90cI7yVFvSZ3Lkmio51aSBjQFEe67y/6pEblk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V5j/MoBU8MexXOv4CoUvktrsS2yrOuzcmqqtUqcM67c9YZ1W0jjB+aPrKM9k7Y0Tx
         2QA5m9+ADarjMBz+7zpvVzEbpbyIPUbqT9lO7b2ILdfAEV4T6FQjHxMoYgrnKxSYwS
         hyO22GRGbK0mss1ushP0nJvLpULxklB7fwpjol8I/43FuE/ZaItRjLk6dWkLo1fYzH
         W/RNF7pZGVMVi2LbJ1ZFgntDcXsI88AeXV571rKp13FxeQJ/0IvEMWBnjlsybUe/+b
         DvK2cfoQxBvNvdRftPCgt3TLV9bmWK5OXQzg0KBZjD8F0QTK38yelB2pKJSYQqpHOi
         GmgCu2X8C635g==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-53808d5b774so10046889a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:45:49 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy3inEtXyw21LVici88kZVNepoRahiEAmdRGwbk/OR+LvORZH9X
        92WqMr/pWhu+PltzcfbY+APh+J406DNSRWx7mFI=
X-Google-Smtp-Source: AGHT+IGWu/eIjqzRD4Pz/QseE6i/kOK+j0e3GSKTqUjXrfkqFCMngTv42jgqVEE5lklKT96cixOMrYmRQb7k4CvOhl4=
X-Received: by 2002:a05:6402:32e:b0:534:77a5:84cb with SMTP id
 q14-20020a056402032e00b0053477a584cbmr17137125edw.36.1696941948370; Tue, 10
 Oct 2023 05:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <1696856590-30298-1-git-send-email-yangtiezhu@loongson.cn> <1696856590-30298-2-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1696856590-30298-2-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 10 Oct 2023 20:45:35 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7NQM_W-T80UdPy0F7jUFa-eWKLymoLHkgUGoAGzZPUTQ@mail.gmail.com>
Message-ID: <CAAhV-H7NQM_W-T80UdPy0F7jUFa-eWKLymoLHkgUGoAGzZPUTQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] objtool/LoongArch: Enable objtool to be built
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiezhu,

On Mon, Oct 9, 2023 at 9:03=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn>=
 wrote:
>
> Add the minimal changes to enable objtool build on LoongArch,
> most of the functions are stubs to only fix the build errors
> when make -C tools/objtool.
>
> This is similar with commit e52ec98c5ab1 ("objtool/powerpc:
> Enable objtool to be built on ppc").
>
> Co-developed-by: Jinyang He <hejinyang@loongson.cn>
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> Co-developed-by: Youling Tang <tangyouling@loongson.cn>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/objtool/arch/loongarch/Build                 |  2 +
>  tools/objtool/arch/loongarch/decode.c              | 71 ++++++++++++++++=
++++++
>  .../objtool/arch/loongarch/include/arch/cfi_regs.h | 21 +++++++
>  tools/objtool/arch/loongarch/include/arch/elf.h    | 30 +++++++++
>  .../objtool/arch/loongarch/include/arch/special.h  | 33 ++++++++++
>  tools/objtool/arch/loongarch/special.c             | 15 +++++
>  6 files changed, 172 insertions(+)
>  create mode 100644 tools/objtool/arch/loongarch/Build
>  create mode 100644 tools/objtool/arch/loongarch/decode.c
>  create mode 100644 tools/objtool/arch/loongarch/include/arch/cfi_regs.h
>  create mode 100644 tools/objtool/arch/loongarch/include/arch/elf.h
>  create mode 100644 tools/objtool/arch/loongarch/include/arch/special.h
>  create mode 100644 tools/objtool/arch/loongarch/special.c
>
> diff --git a/tools/objtool/arch/loongarch/Build b/tools/objtool/arch/loon=
garch/Build
> new file mode 100644
> index 0000000..d24d563
> --- /dev/null
> +++ b/tools/objtool/arch/loongarch/Build
> @@ -0,0 +1,2 @@
> +objtool-y +=3D decode.o
> +objtool-y +=3D special.o
> diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/l=
oongarch/decode.c
> new file mode 100644
> index 0000000..cc74ba4
> --- /dev/null
> +++ b/tools/objtool/arch/loongarch/decode.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <string.h>
> +#include <objtool/check.h>
> +
> +int arch_ftrace_match(char *name)
> +{
> +       return !strcmp(name, "_mcount");
> +}
> +
> +unsigned long arch_jump_destination(struct instruction *insn)
> +{
> +       return insn->offset + (insn->immediate << 2);
> +}
> +
> +unsigned long arch_dest_reloc_offset(int addend)
> +{
> +       return addend;
> +}
> +
> +bool arch_pc_relative_reloc(struct reloc *reloc)
> +{
> +       return false;
> +}
> +
> +bool arch_callee_saved_reg(unsigned char reg)
> +{
> +       switch (reg) {
> +       case CFI_RA:
> +       case CFI_FP:
> +       case CFI_S0 ... CFI_S8:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
> +int arch_decode_hint_reg(u8 sp_reg, int *base)
> +{
> +       return 0;
> +}
> +
> +int arch_decode_instruction(struct objtool_file *file, const struct sect=
ion *sec,
> +                           unsigned long offset, unsigned int maxlen,
> +                           struct instruction *insn)
> +{
> +       return 0;
> +}
> +
> +const char *arch_nop_insn(int len)
> +{
> +       return NULL;
> +}
> +
> +const char *arch_ret_insn(int len)
> +{
> +       return NULL;
> +}
> +
> +void arch_initial_func_cfi_state(struct cfi_init_state *state)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < CFI_NUM_REGS; i++) {
> +               state->regs[i].base =3D CFI_UNDEFINED;
> +               state->regs[i].offset =3D 0;
> +       }
> +
> +       /* initial CFA (call frame address) */
> +       state->cfa.base =3D CFI_SP;
> +       state->cfa.offset =3D 0;
> +}
> diff --git a/tools/objtool/arch/loongarch/include/arch/cfi_regs.h b/tools=
/objtool/arch/loongarch/include/arch/cfi_regs.h
> new file mode 100644
> index 0000000..c768d39
> --- /dev/null
> +++ b/tools/objtool/arch/loongarch/include/arch/cfi_regs.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef _OBJTOOL_ARCH_CFI_REGS_H
> +#define _OBJTOOL_ARCH_CFI_REGS_H
> +
> +#define CFI_RA         1
> +#define CFI_SP         3
> +#define CFI_FP         22
> +#define CFI_S0         23
> +#define CFI_S1         24
> +#define CFI_S2         25
> +#define CFI_S3         26
> +#define CFI_S4         27
> +#define CFI_S5         28
> +#define CFI_S6         29
> +#define CFI_S7         30
> +#define CFI_S8         31
> +#define CFI_NUM_REGS   32
> +
> +#define CFI_BP         CFI_FP
> +
> +#endif /* _OBJTOOL_ARCH_CFI_REGS_H */
> diff --git a/tools/objtool/arch/loongarch/include/arch/elf.h b/tools/objt=
ool/arch/loongarch/include/arch/elf.h
> new file mode 100644
> index 0000000..9623d66
> --- /dev/null
> +++ b/tools/objtool/arch/loongarch/include/arch/elf.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef _OBJTOOL_ARCH_ELF_H
> +#define _OBJTOOL_ARCH_ELF_H
> +
> +/*
> + * See the following link for more info about ELF Relocation types:
> + * https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-=
EN.html#_relocations
> + */
> +#ifndef R_LARCH_NONE
> +#define R_LARCH_NONE           0
> +#endif
> +#ifndef R_LARCH_32
> +#define R_LARCH_32             1
> +#endif
> +#ifndef R_LARCH_64
> +#define R_LARCH_64             2
> +#endif
> +#ifndef R_LARCH_32_PCREL
> +#define R_LARCH_32_PCREL       99
> +#endif
> +
> +#define R_NONE                 R_LARCH_NONE
> +#define R_ABS32                        R_LARCH_32
> +#define R_ABS64                        R_LARCH_64
> +#define R_DATA32               R_LARCH_32_PCREL
> +#define R_DATA64               R_LARCH_32_PCREL
> +#define R_TEXT32               R_LARCH_32_PCREL
> +#define R_TEXT64               R_LARCH_32_PCREL
> +
> +#endif /* _OBJTOOL_ARCH_ELF_H */
> diff --git a/tools/objtool/arch/loongarch/include/arch/special.h b/tools/=
objtool/arch/loongarch/include/arch/special.h
> new file mode 100644
> index 0000000..1a8245c
> --- /dev/null
> +++ b/tools/objtool/arch/loongarch/include/arch/special.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef _OBJTOOL_ARCH_SPECIAL_H
> +#define _OBJTOOL_ARCH_SPECIAL_H
> +
> +/*
> + * See more info about struct exception_table_entry
> + * in arch/loongarch/include/asm/extable.h
> + */
> +#define EX_ENTRY_SIZE 12
> +#define EX_ORIG_OFFSET 0
> +#define EX_NEW_OFFSET 4
Other archs use tab for indentation in special.h

Huacai
> +
> +/*
> + * See more info about struct jump_entry
> + * in include/linux/jump_label.h
> + */
> +#define JUMP_ENTRY_SIZE 16
> +#define JUMP_ORIG_OFFSET 0
> +#define JUMP_NEW_OFFSET 4
> +#define JUMP_KEY_OFFSET 8
> +
> +/*
> + * See more info about struct alt_instr
> + * in arch/loongarch/include/asm/alternative.h
> + */
> +#define ALT_ENTRY_SIZE 12
> +#define ALT_ORIG_OFFSET 0
> +#define ALT_NEW_OFFSET 4
> +#define ALT_FEATURE_OFFSET 8
> +#define ALT_ORIG_LEN_OFFSET 10
> +#define ALT_NEW_LEN_OFFSET 11
> +
> +#endif /* _OBJTOOL_ARCH_SPECIAL_H */
> diff --git a/tools/objtool/arch/loongarch/special.c b/tools/objtool/arch/=
loongarch/special.c
> new file mode 100644
> index 0000000..9bba1e9
> --- /dev/null
> +++ b/tools/objtool/arch/loongarch/special.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <objtool/special.h>
> +
> +bool arch_support_alt_relocation(struct special_alt *special_alt,
> +                                struct instruction *insn,
> +                                struct reloc *reloc)
> +{
> +       return false;
> +}
> +
> +struct reloc *arch_find_switch_table(struct objtool_file *file,
> +                                    struct instruction *insn)
> +{
> +       return NULL;
> +}
> --
> 2.1.0
>
