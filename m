Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A1D80B419
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjLIMBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 07:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjLIMBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:01:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB9E10E6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 04:01:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03DAC433C9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 12:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702123315;
        bh=ivFsOSgwviRbxCdV/HZOaDIko5Llynvw15OE80tETss=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MaU+cL8FnSJCL5k2K8QhOzLor81yo9ImCRnWMnhPcP1bxO2ljA/GZq0lZWvN7pzRH
         NTPgdqW2qq1eO4N4AYGJtj9uJ6HZURtre7ySk28wk9m5iYp1TkidGV9+CNOafNP4B2
         +yaQN/59F5s8MzSTsJENWzj46FEwFmaNd7uSdsq8/SP+Z3kshnJJxf7B3af8vt+xgW
         AZ0FWZKv2uZgVhUxpdJ9Tp6qI8r+6AQ1e1CmdBs0MVZ437A3F2OdvP3Fwbb5ZbeqcA
         5/aMKX20yTq9d6TxsMYgeBS/3qgo4RpyCVNvgCsBk6FhHeCudQGWZcC8S1Hn8cTO6y
         eg6qBiB5SeTEA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a1d2f89ddabso352705966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 04:01:55 -0800 (PST)
X-Gm-Message-State: AOJu0Yz+ZLL6yS9ZiBFwJdtsAc3xiBd8PtPnQRYuhzgH+M419Dqg7p7X
        Y/6zMgZmXqfa09dsrP8IqPKZ9gXQsqqemq9ztv0=
X-Google-Smtp-Source: AGHT+IHyvMsUFvPg2VTnl9SYqVZLp2t4+7XqzZsBzz6PBP5lSDwXKnWjYvHkbN1WosxnVz60tLIV3jDoe8KP85A1WJ8=
X-Received: by 2002:a17:907:7663:b0:a18:b889:d453 with SMTP id
 kk3-20020a170907766300b00a18b889d453mr793925ejc.2.1702123314320; Sat, 09 Dec
 2023 04:01:54 -0800 (PST)
MIME-Version: 1.0
References: <20231207032951.16334-1-yangtiezhu@loongson.cn>
 <20231207032951.16334-3-yangtiezhu@loongson.cn> <CAEyhmHRs-bJ7Pd9t1wqs4H8FBYZg27gi7gXWZjpEqzLT+naAHA@mail.gmail.com>
In-Reply-To: <CAEyhmHRs-bJ7Pd9t1wqs4H8FBYZg27gi7gXWZjpEqzLT+naAHA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 9 Dec 2023 20:01:44 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5ysu4FhFsrY6iof1WtAHJno1Jfx+g0FD5Ah66au_1m5Q@mail.gmail.com>
Message-ID: <CAAhV-H5ysu4FhFsrY6iof1WtAHJno1Jfx+g0FD5Ah66au_1m5Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] LoongArch: BPF: Fix unconditional bswap instructions
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied, thanks.

Huacai

On Sat, Dec 9, 2023 at 2:06=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com> =
wrote:
>
> On Thu, Dec 7, 2023 at 11:30=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.=
cn> wrote:
> >
> > We can see that "bswap32: Takes an unsigned 32-bit number in either
> > big- or little-endian format and returns the equivalent number with
> > the same bit width but opposite endianness" in BPF Instruction Set
> > Specification, so it should clear the upper 32 bits in the case 32
> > for BPF_ALU and BPF_ALU64.
> >
> > [root@linux fedora]# echo 1 > /proc/sys/net/core/bpf_jit_enable
> > [root@linux fedora]# modprobe test_bpf
> >
> > Before:
> > test_bpf: #313 BSWAP 32: 0x0123456789abcdef -> 0xefcdab89 jited:1 ret 1=
460850314 !=3D -271733879 (0x5712ce8a !=3D 0xefcdab89)FAIL (1 times)
> > test_bpf: #317 BSWAP 32: 0xfedcba9876543210 -> 0x10325476 jited:1 ret -=
1460850316 !=3D 271733878 (0xa8ed3174 !=3D 0x10325476)FAIL (1 times)
> >
> > After:
> > test_bpf: #313 BSWAP 32: 0x0123456789abcdef -> 0xefcdab89 jited:1 4 PAS=
S
> > test_bpf: #317 BSWAP 32: 0xfedcba9876543210 -> 0x10325476 jited:1 4 PAS=
S
> >
>
> Nice catch. I wasn't aware of test_bpf before. For the patch:
>
> Acked-by: Hengqi Chen <hengqi.chen@gmail.com>
>
> > Fixes: 4ebf9216e7df ("LoongArch: BPF: Support unconditional bswap instr=
uctions")
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >  arch/loongarch/net/bpf_jit.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index 8c907c2c42f7..da48398e8794 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -774,8 +774,8 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
> >                         break;
> >                 case 32:
> >                         emit_insn(ctx, revb2w, dst, dst);
> > -                       /* zero-extend 32 bits into 64 bits */
> > -                       emit_zext_32(ctx, dst, is32);
> > +                       /* clear the upper 32 bits */
> > +                       emit_zext_32(ctx, dst, true);
> >                         break;
> >                 case 64:
> >                         emit_insn(ctx, revbd, dst, dst);
> > --
> > 2.42.0
> >
