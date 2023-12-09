Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC37C80B24D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 07:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbjLIGGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 01:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjLIGGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 01:06:34 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA6710DF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 22:06:40 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1fb104887fbso1796399fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 22:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702101999; x=1702706799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nf6OOTcG7PxYCx6vPFQxKfuzNKzfWsQNsizZ/iXT2to=;
        b=Ac8p8MJWzVQTOc94MqD9cJmpKz1SjIurkpHFJFZSRSW4VMKaYX1gG3KXFoNILY3EnC
         8JpNIB/pVDRRsC7k3WzLaBH5DylfyAMMpd6JWnWKmEr4iB+WS7QuI3iSc6Z20m2KFAdF
         QhnuKoWJAujgzHGX464mQsmk4/+KiN1W4Ih5O7YW9Zgmxl5+C44QNR+mYIO6xJP7J2c7
         e/JDXgms/grfRURyA6u7OhPV4V3hijknSPSeINg4m7+TrpwHmiMEzCKNAjio7y3BYGrF
         pWBWWKBE8IPv6y2KiS4SSZ9XPoXsNongCDvp1lPJJmQxM/RxTzDvUzesJbKH15ijBQSq
         1w9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702101999; x=1702706799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nf6OOTcG7PxYCx6vPFQxKfuzNKzfWsQNsizZ/iXT2to=;
        b=XJQjsYUjy7LiR31BWfUz2fsfRIGakUBcNlnxz1inYDYBekQjpw1gKQxhkx9nzpKRqQ
         GgR0PJVxsvhsBor+1bteYg1V8UwLXkrLnZznS85alaQRiy21p7+QiSNH5+Tvd6auCOAx
         x8TIXd0Y6Fm4cA9Y83S07sBYJlZjfnqlqWcqfD9+NNCRg9nbFzd3WhpwCPwyhoXPpR8w
         4j3Wm37SQFEFaXWwmmmD96L59+CA7hafiRrpTrpBme6oadOq8DpSGKm5DQnxxIitj3tQ
         2rhvgK5CTzk0XDAj/ko8YFoZ0fRKt53cFC4/tLwqPYfsSXTYgSERptjHs1SLvmHMyKeW
         o8Bg==
X-Gm-Message-State: AOJu0Yz1xk+UVRll43KPEzeK3OB3DhaYurjWnwRad6553KrmYVYVPFRx
        2knm6GX4ohjPLOw1HA5p/Qu49vOd0LBdv+JopN4s7XIskJLJtw==
X-Google-Smtp-Source: AGHT+IFopuEBCifPNBT3duj2vrRMB+gTm7VJSiDvYQwASu+1M93cE8+e6nL+a/r5JVbktW+0O1BQ1pb2lk390P8M7Io=
X-Received: by 2002:a05:6870:d38a:b0:1fb:6e5d:1ecb with SMTP id
 k10-20020a056870d38a00b001fb6e5d1ecbmr1708470oag.54.1702101999590; Fri, 08
 Dec 2023 22:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20231207032951.16334-1-yangtiezhu@loongson.cn> <20231207032951.16334-3-yangtiezhu@loongson.cn>
In-Reply-To: <20231207032951.16334-3-yangtiezhu@loongson.cn>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Date:   Sat, 9 Dec 2023 14:06:28 +0800
Message-ID: <CAEyhmHRs-bJ7Pd9t1wqs4H8FBYZg27gi7gXWZjpEqzLT+naAHA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] LoongArch: BPF: Fix unconditional bswap instructions
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 11:30=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> We can see that "bswap32: Takes an unsigned 32-bit number in either
> big- or little-endian format and returns the equivalent number with
> the same bit width but opposite endianness" in BPF Instruction Set
> Specification, so it should clear the upper 32 bits in the case 32
> for BPF_ALU and BPF_ALU64.
>
> [root@linux fedora]# echo 1 > /proc/sys/net/core/bpf_jit_enable
> [root@linux fedora]# modprobe test_bpf
>
> Before:
> test_bpf: #313 BSWAP 32: 0x0123456789abcdef -> 0xefcdab89 jited:1 ret 146=
0850314 !=3D -271733879 (0x5712ce8a !=3D 0xefcdab89)FAIL (1 times)
> test_bpf: #317 BSWAP 32: 0xfedcba9876543210 -> 0x10325476 jited:1 ret -14=
60850316 !=3D 271733878 (0xa8ed3174 !=3D 0x10325476)FAIL (1 times)
>
> After:
> test_bpf: #313 BSWAP 32: 0x0123456789abcdef -> 0xefcdab89 jited:1 4 PASS
> test_bpf: #317 BSWAP 32: 0xfedcba9876543210 -> 0x10325476 jited:1 4 PASS
>

Nice catch. I wasn't aware of test_bpf before. For the patch:

Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

> Fixes: 4ebf9216e7df ("LoongArch: BPF: Support unconditional bswap instruc=
tions")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/net/bpf_jit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 8c907c2c42f7..da48398e8794 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -774,8 +774,8 @@ static int build_insn(const struct bpf_insn *insn, st=
ruct jit_ctx *ctx, bool ext
>                         break;
>                 case 32:
>                         emit_insn(ctx, revb2w, dst, dst);
> -                       /* zero-extend 32 bits into 64 bits */
> -                       emit_zext_32(ctx, dst, is32);
> +                       /* clear the upper 32 bits */
> +                       emit_zext_32(ctx, dst, true);
>                         break;
>                 case 64:
>                         emit_insn(ctx, revbd, dst, dst);
> --
> 2.42.0
>
