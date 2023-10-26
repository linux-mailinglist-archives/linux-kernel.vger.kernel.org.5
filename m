Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04C37D85E7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345352AbjJZPXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjJZPXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:23:20 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D24BD7;
        Thu, 26 Oct 2023 08:23:18 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so713648276.2;
        Thu, 26 Oct 2023 08:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698333798; x=1698938598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sA6InHyE33S+TtlRrejYNFZB0PYSGcSq/A0CeCDtcu8=;
        b=UTLmNpAGW2NCtMSa3KUc7TVw1OQcpr27ayPtuDpK/JNmy2oOX+KXqGQ5LqMXCrrQOq
         nwFsa4bBCX7eUw5lxxQa5zI3o6NQGRQPmBcrpL5A87VgJZ/YGL4rH6JNIALtcat2jqWd
         +NbnUk+qUGjgTH97zwA/5AI7fWNhh92wt+Yxa0LI7b22QTsng+ntfJhMQgQ9InGbDy45
         /I0X3A+lLpNpTze7xvdp8tcOFte9Dr4UghvmDjBttOSF21nRqWjlr5K+ARQVA75m2jR5
         WLWFR75TiEMQRWs4Pmn9oP+HpUIg/JNU228QfYaFjPSi+bXu9gIw+f3RQ0E3h6dCJx9k
         WURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698333798; x=1698938598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sA6InHyE33S+TtlRrejYNFZB0PYSGcSq/A0CeCDtcu8=;
        b=F3kQYNmrWKuQrutu6LsGOul3Bm7qbby+GuwQzayu61Np/4Mq5QVFC3C7LpRsOHz25S
         R7EN/onSLjoPVJ+WC6gFYTHjZ8aVpnNSQJ2jq+Q64SHFIGN6HTommZdPftuQmCSCLDtb
         atKC4zyF2RIADhdQMDTD1ri3kqxR8Ya2Ou55GYVHG9k4zeVMBAxwz2O4R3N1hJOw5EN+
         gg/pNmq371jWikCbMqteYeUQfS1CNvN6QTyB/Ni5Q4pUjioDvIZnYoE7QFU1jFEpTpFL
         2Dc/l9jkQ9RAyeYJVSIRb0xzMkbPXh4dtQBB99V3ehhV+liWITGrqHcG9VWXiT8ZEBnD
         zE4w==
X-Gm-Message-State: AOJu0YzNxBlJVuy+MuU/K1b80MIBou/9Pc0Pmy5M793wREh1MUOkZI3r
        2GMZDwUOJoi6nGjN+4LD4ByIYUJ3CHfrq2Zh0w==
X-Google-Smtp-Source: AGHT+IEOr2mvY/nmjB54d0ZcyeFl1qCttMQtezl1T5F0bJf+jbPG8dp0SsKMhFC03kg7VrkDm7FWi5eBxjB9ltufLgQ=
X-Received: by 2002:a25:3206:0:b0:d9c:707f:1f4f with SMTP id
 y6-20020a253206000000b00d9c707f1f4fmr16996829yby.3.1698333797553; Thu, 26 Oct
 2023 08:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsYXA8myxoP0Naz=ZxB0FWG-xS9e28CSFffGk1bA_n5RXw@mail.gmail.com>
 <17e03fa708cf0c1d297c2fa3d139a22a358a65e7.camel@gmail.com> <940ed5abeb10f8e56d28dd003f2e771fc416fb3b.camel@gmail.com>
In-Reply-To: <940ed5abeb10f8e56d28dd003f2e771fc416fb3b.camel@gmail.com>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Thu, 26 Oct 2023 17:23:06 +0200
Message-ID: <CACkBjsb3mxW4FJx2U9_jWFZFogNxXtBcd9PpeFphHGVk7vRhTA@mail.gmail.com>
Subject: Re: bpf: incorrect value spill in check_stack_write_fixed_off()
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 2:48=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2023-10-25 at 15:14 +0300, Eduard Zingerman wrote:
> > On Wed, 2023-10-25 at 11:16 +0200, Hao Sun wrote:
> > > Hi,
> > >
> > > In check_stack_write_fixed_off(), the verifier creates a fake reg to =
store the
> > > imm in a BPF_ST_MEM:
> > > ...
> > > else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
> > > insn->imm !=3D 0 && env->bpf_capable) {
> > >         struct bpf_reg_state fake_reg =3D {};
> > >
> > >         __mark_reg_known(&fake_reg, (u32)insn->imm);
> > >         fake_reg.type =3D SCALAR_VALUE;
> > >         save_register_state(state, spi, &fake_reg, size);
> > >
> > > Here, insn->imm is cast to u32, and used to mark fake_reg, which is i=
ncorrect
> > > and may lose sign information.
> >
> > This bug is on me.
> > Thank you for reporting it along with the example program.
> > Looks like the patch below is sufficient to fix the issue.
> > Have no idea at the moment why I used u32 cast there.
> > Let me think a bit more about it and I'll submit an official patch.
>
> Yeap, I see no drawbacks in that patch, imm field is declared as s32,
> so it would be correctly sign extended by compiler before cast to u64,
> so there is no need for additional casts.
> It would be wrong if I submit the fix, because you've done all the work.

Done. Besides, users or binaries with CAP_BPF can exploit this bug.

> Here is a refined test-case to be placed in verifier/bpf_st_mem.c
> (be careful with \t, test_verifier uses those as glob marks inside errstr=
).
>
> {
>         "BPF_ST_MEM stack imm sign",
>         /* Check if verifier correctly reasons about sign of an
>          * immediate spilled to stack by BPF_ST instruction.
>          *
>          *   fp[-8] =3D -44;
>          *   r0 =3D fp[-8];
>          *   if r0 s< 0 goto ret0;
>          *   r0 =3D -1;
>          *   exit;
>          * ret0:
>          *   r0 =3D 0;
>          *   exit;
>          */
>         .insns =3D {
>         BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, -44),
>         BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
>         BPF_JMP_IMM(BPF_JSLT, BPF_REG_0, 0, 2),
>         BPF_MOV64_IMM(BPF_REG_0, -1),
>         BPF_EXIT_INSN(),
>         BPF_MOV64_IMM(BPF_REG_0, 0),
>         BPF_EXIT_INSN(),
>         },
>         /* Use prog type that requires return value in range [0, 1] */
>         .prog_type =3D BPF_PROG_TYPE_SK_LOOKUP,
>         .expected_attach_type =3D BPF_SK_LOOKUP,
>         .result =3D VERBOSE_ACCEPT,
>         .runs =3D -1,
>         .errstr =3D "0: (7a) *(u64 *)(r10 -8) =3D -44        ; R10=3Dfp0 =
fp-8_w=3D-44\
>         2: (c5) if r0 s< 0x0 goto pc+2\
>         2: R0_w=3D-44",
> },
