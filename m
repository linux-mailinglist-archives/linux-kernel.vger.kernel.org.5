Return-Path: <linux-kernel+bounces-143638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FA88A3BC7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969881F222E7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 08:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E72381B9;
	Sat, 13 Apr 2024 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVfnos+F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF0124A0D;
	Sat, 13 Apr 2024 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712998454; cv=none; b=SQzYFvHvxROmA3DEVR9uwVQCIlT1RI8v7ZWrcpRX364v6SqBj/kjx6hI9YEbinZu/FKheS3KFYOyP4RcP4U9UhsfRHZY12zXRV2xThZUGBn7Gux987uiz3p3W+0o5eSgSfKHKCVAalYRWVnkSCqqTHGKgCcd/4tIzsCo5oEfGtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712998454; c=relaxed/simple;
	bh=HH2cMpjxYOZ9njPFekUwOVOexlYk0u2xmlvbK+U/aY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ls6vkymQabZi56N/hK1bkRaG0MkJKPucLwcbCKbmsoIK581zwDgb7uFHzHATYAqcM8+HqLZAuKJ2GXOz3kLgRe7NHULQwSHMODfnMGRDX+rs8jlOHCvdf9JblKtSXM5TsCEL9/HZtWhWa+3/uIRPrC4appPkXBraBW5xiul2lZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVfnos+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD519C2BBFC;
	Sat, 13 Apr 2024 08:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712998453;
	bh=HH2cMpjxYOZ9njPFekUwOVOexlYk0u2xmlvbK+U/aY0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QVfnos+FRpSsY6yH5YokaFCBZl9e3dXjfmTc8ejFpYh9PBUkyqcgLCacd0ctfqrFk
	 OBEcV1spfRGeFooudJ4Wqtwbrx/Se5BLGr2rszqFjhP+tLbnd+ndRhwgRxA6yOuGdB
	 /09ysgzZhhtiAh0rcqj2TcxASqPyxhazrV6bgccxuvRxYBvOEHf1spuVBgeZfrZzHm
	 gzIxgBfsHr0G/7ToKO0I6KpEkd9e6SVp77fva3qliye4wnP2D2m58uPA13j3xDW+0Y
	 1DWFewKbI9Oj9L4Y1mEqgPqXrwNVcGyX9USV2aNkghkdrIWCcho2nM1AbBs0jzHubY
	 H9iOUwWi3k9Wg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d8b194341eso15305611fa.3;
        Sat, 13 Apr 2024 01:54:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgZEgOuaqX/Rz5MtaFXbK8bC/qF1hr498fDpiKvoKQmZfq8nyUxfhtYlJ8eUaSajwW2Hwv6P2tNjuwuNp0hcmSpSjnFznQNDUSwxvX
X-Gm-Message-State: AOJu0YzYtFRBpE93/oJz21yDDP2Wl1z/1uJ7euUv2uA6jyOEFh0ht/4p
	8VlzEGQd0ggmqlRtrTPHko8g86fJzZOxR8M3iHb/5NC7/KkmOyvrjrG+Mc517mjFP+HAgXh0KCK
	4fpNx7r7P34cQeXbyJmD+ms2nVDI=
X-Google-Smtp-Source: AGHT+IEj1/RCKlAbKCmXaeJo8cSBJq7GZYSQokwTIyVWgPEuHfBie/BLHn+U4f/RDV6H0oVg9Sdth0pOQz+4IBN+Irs=
X-Received: by 2002:a2e:81da:0:b0:2d8:d0c9:1ffc with SMTP id
 s26-20020a2e81da000000b002d8d0c91ffcmr3324151ljg.1.1712998451922; Sat, 13 Apr
 2024 01:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413000947.67988-1-ebiggers@kernel.org>
In-Reply-To: <20240413000947.67988-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 13 Apr 2024 10:54:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGSoc24ZUu0Q01+E26p2OsTB23p5dg9uGHdCca0DM70XQ@mail.gmail.com>
Message-ID: <CAMj1kXGSoc24ZUu0Q01+E26p2OsTB23p5dg9uGHdCca0DM70XQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: x86/aesni-xts - deduplicate aesni_xts_enc() and aesni_xts_dec()
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	"Chang S . Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Apr 2024 at 02:10, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Since aesni_xts_enc() and aesni_xts_dec() are very similar, generate
> them from a macro that's passed an argument enc=1 or enc=0.  This
> reduces the length of aesni-intel_asm.S by 112 lines while still
> producing the exact same object file in both 32-bit and 64-bit mode.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/x86/crypto/aesni-intel_asm.S | 270 +++++++++---------------------
>  1 file changed, 79 insertions(+), 191 deletions(-)
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
> index 1cb55eea2efa..3a3e46188dec 100644
> --- a/arch/x86/crypto/aesni-intel_asm.S
> +++ b/arch/x86/crypto/aesni-intel_asm.S
> @@ -2823,32 +2823,28 @@ SYM_FUNC_END(aesni_ctr_enc)
>  .Lgf128mul_x_ble_mask:
>         .octa 0x00000000000000010000000000000087
>  .previous
>
>  /*
> - * _aesni_gf128mul_x_ble:              internal ABI
> - *     Multiply in GF(2^128) for XTS IVs
> + * _aesni_gf128mul_x_ble: Multiply in GF(2^128) for XTS IVs
>   * input:
>   *     IV:     current IV
>   *     GF128MUL_MASK == mask with 0x87 and 0x01
>   * output:
>   *     IV:     next IV
>   * changed:
> - *     CTR:    == temporary value
> + *     KEY:    == temporary value
>   */
> -#define _aesni_gf128mul_x_ble() \
> -       pshufd $0x13, IV, KEY; \
> -       paddq IV, IV; \
> -       psrad $31, KEY; \
> -       pand GF128MUL_MASK, KEY; \
> -       pxor KEY, IV;
> +.macro _aesni_gf128mul_x_ble
> +       pshufd $0x13, IV, KEY
> +       paddq IV, IV
> +       psrad $31, KEY
> +       pand GF128MUL_MASK, KEY
> +       pxor KEY, IV
> +.endm
>
> -/*
> - * void aesni_xts_enc(const struct crypto_aes_ctx *ctx, u8 *dst,
> - *                   const u8 *src, unsigned int len, le128 *iv)
> - */
> -SYM_FUNC_START(aesni_xts_enc)
> +.macro _aesni_xts_crypt        enc
>         FRAME_BEGIN
>  #ifndef __x86_64__
>         pushl IVP
>         pushl LEN
>         pushl KEYP
> @@ -2863,39 +2859,50 @@ SYM_FUNC_START(aesni_xts_enc)
>         movdqa .Lgf128mul_x_ble_mask(%rip), GF128MUL_MASK
>  #endif
>         movups (IVP), IV
>
>         mov 480(KEYP), KLEN
> +.if !\enc
> +       add $240, KEYP
> +
> +       test $15, LEN
> +       jz .Lxts_loop4\@
> +       sub $16, LEN
> +.endif
>
> -.Lxts_enc_loop4:
> +.Lxts_loop4\@:
>         sub $64, LEN
> -       jl .Lxts_enc_1x
> +       jl .Lxts_1x\@
>
>         movdqa IV, STATE1
>         movdqu 0x00(INP), IN
>         pxor IN, STATE1
>         movdqu IV, 0x00(OUTP)
>
> -       _aesni_gf128mul_x_ble()
> +       _aesni_gf128mul_x_ble
>         movdqa IV, STATE2
>         movdqu 0x10(INP), IN
>         pxor IN, STATE2
>         movdqu IV, 0x10(OUTP)
>
> -       _aesni_gf128mul_x_ble()
> +       _aesni_gf128mul_x_ble
>         movdqa IV, STATE3
>         movdqu 0x20(INP), IN
>         pxor IN, STATE3
>         movdqu IV, 0x20(OUTP)
>
> -       _aesni_gf128mul_x_ble()
> +       _aesni_gf128mul_x_ble
>         movdqa IV, STATE4
>         movdqu 0x30(INP), IN
>         pxor IN, STATE4
>         movdqu IV, 0x30(OUTP)
>
> +.if \enc
>         call _aesni_enc4
> +.else
> +       call _aesni_dec4
> +.endif
>
>         movdqu 0x00(OUTP), IN
>         pxor IN, STATE1
>         movdqu STATE1, 0x00(OUTP)
>
> @@ -2909,63 +2916,84 @@ SYM_FUNC_START(aesni_xts_enc)
>
>         movdqu 0x30(OUTP), IN
>         pxor IN, STATE4
>         movdqu STATE4, 0x30(OUTP)
>
> -       _aesni_gf128mul_x_ble()
> +       _aesni_gf128mul_x_ble
>
>         add $64, INP
>         add $64, OUTP
>         test LEN, LEN
> -       jnz .Lxts_enc_loop4
> +       jnz .Lxts_loop4\@
>
> -.Lxts_enc_ret_iv:
> +.Lxts_ret_iv\@:
>         movups IV, (IVP)
>
> -.Lxts_enc_ret:
> +.Lxts_ret\@:
>  #ifndef __x86_64__
>         popl KLEN
>         popl KEYP
>         popl LEN
>         popl IVP
>  #endif
>         FRAME_END
>         RET
>
> -.Lxts_enc_1x:
> +.Lxts_1x\@:
>         add $64, LEN
> -       jz .Lxts_enc_ret_iv
> +       jz .Lxts_ret_iv\@
> +.if \enc
>         sub $16, LEN
> -       jl .Lxts_enc_cts4
> +       jl .Lxts_cts4\@
> +.endif
>
> -.Lxts_enc_loop1:
> +.Lxts_loop1\@:
>         movdqu (INP), STATE
> +.if \enc
>         pxor IV, STATE
>         call _aesni_enc1
> +.else
> +       add $16, INP
> +       sub $16, LEN
> +       jl .Lxts_cts1\@
>         pxor IV, STATE
> -       _aesni_gf128mul_x_ble()
> +       call _aesni_dec1
> +.endif
> +       pxor IV, STATE
> +       _aesni_gf128mul_x_ble
>
>         test LEN, LEN
> -       jz .Lxts_enc_out
> +       jz .Lxts_out\@
>
> +.if \enc
>         add $16, INP
>         sub $16, LEN
> -       jl .Lxts_enc_cts1
> +       jl .Lxts_cts1\@
> +.endif
>
>         movdqu STATE, (OUTP)
>         add $16, OUTP
> -       jmp .Lxts_enc_loop1
> +       jmp .Lxts_loop1\@
>
> -.Lxts_enc_out:
> +.Lxts_out\@:
>         movdqu STATE, (OUTP)
> -       jmp .Lxts_enc_ret_iv
> +       jmp .Lxts_ret_iv\@
>
> -.Lxts_enc_cts4:
> +.if \enc
> +.Lxts_cts4\@:
>         movdqa STATE4, STATE
>         sub $16, OUTP
> +.Lxts_cts1\@:
> +.else
> +.Lxts_cts1\@:
> +       movdqa IV, STATE4
> +       _aesni_gf128mul_x_ble
>
> -.Lxts_enc_cts1:
> +       pxor IV, STATE
> +       call _aesni_dec1
> +       pxor IV, STATE
> +.endif
>  #ifndef __x86_64__
>         lea .Lcts_permute_table, T1
>  #else
>         lea .Lcts_permute_table(%rip), T1
>  #endif
> @@ -2987,174 +3015,34 @@ SYM_FUNC_START(aesni_xts_enc)
>         movups (IVP), %xmm0
>         pshufb %xmm0, IN1
>         pblendvb IN2, IN1
>         movaps IN1, STATE
>
> +.if \enc
>         pxor IV, STATE
>         call _aesni_enc1
>         pxor IV, STATE
> +.else
> +       pxor STATE4, STATE
> +       call _aesni_dec1
> +       pxor STATE4, STATE
> +.endif
>
>         movups STATE, (OUTP)
> -       jmp .Lxts_enc_ret
> +       jmp .Lxts_ret\@
> +.endm
> +
> +/*
> + * void aesni_xts_enc(const struct crypto_aes_ctx *ctx, u8 *dst,
> + *                   const u8 *src, unsigned int len, le128 *iv)
> + */
> +SYM_FUNC_START(aesni_xts_enc)
> +       _aesni_xts_crypt        1
>  SYM_FUNC_END(aesni_xts_enc)
>
>  /*
>   * void aesni_xts_dec(const struct crypto_aes_ctx *ctx, u8 *dst,
>   *                   const u8 *src, unsigned int len, le128 *iv)
>   */
>  SYM_FUNC_START(aesni_xts_dec)
> -       FRAME_BEGIN
> -#ifndef __x86_64__
> -       pushl IVP
> -       pushl LEN
> -       pushl KEYP
> -       pushl KLEN
> -       movl (FRAME_OFFSET+20)(%esp), KEYP      # ctx
> -       movl (FRAME_OFFSET+24)(%esp), OUTP      # dst
> -       movl (FRAME_OFFSET+28)(%esp), INP       # src
> -       movl (FRAME_OFFSET+32)(%esp), LEN       # len
> -       movl (FRAME_OFFSET+36)(%esp), IVP       # iv
> -       movdqa .Lgf128mul_x_ble_mask, GF128MUL_MASK
> -#else
> -       movdqa .Lgf128mul_x_ble_mask(%rip), GF128MUL_MASK
> -#endif
> -       movups (IVP), IV
> -
> -       mov 480(KEYP), KLEN
> -       add $240, KEYP
> -
> -       test $15, LEN
> -       jz .Lxts_dec_loop4
> -       sub $16, LEN
> -
> -.Lxts_dec_loop4:
> -       sub $64, LEN
> -       jl .Lxts_dec_1x
> -
> -       movdqa IV, STATE1
> -       movdqu 0x00(INP), IN
> -       pxor IN, STATE1
> -       movdqu IV, 0x00(OUTP)
> -
> -       _aesni_gf128mul_x_ble()
> -       movdqa IV, STATE2
> -       movdqu 0x10(INP), IN
> -       pxor IN, STATE2
> -       movdqu IV, 0x10(OUTP)
> -
> -       _aesni_gf128mul_x_ble()
> -       movdqa IV, STATE3
> -       movdqu 0x20(INP), IN
> -       pxor IN, STATE3
> -       movdqu IV, 0x20(OUTP)
> -
> -       _aesni_gf128mul_x_ble()
> -       movdqa IV, STATE4
> -       movdqu 0x30(INP), IN
> -       pxor IN, STATE4
> -       movdqu IV, 0x30(OUTP)
> -
> -       call _aesni_dec4
> -
> -       movdqu 0x00(OUTP), IN
> -       pxor IN, STATE1
> -       movdqu STATE1, 0x00(OUTP)
> -
> -       movdqu 0x10(OUTP), IN
> -       pxor IN, STATE2
> -       movdqu STATE2, 0x10(OUTP)
> -
> -       movdqu 0x20(OUTP), IN
> -       pxor IN, STATE3
> -       movdqu STATE3, 0x20(OUTP)
> -
> -       movdqu 0x30(OUTP), IN
> -       pxor IN, STATE4
> -       movdqu STATE4, 0x30(OUTP)
> -
> -       _aesni_gf128mul_x_ble()
> -
> -       add $64, INP
> -       add $64, OUTP
> -       test LEN, LEN
> -       jnz .Lxts_dec_loop4
> -
> -.Lxts_dec_ret_iv:
> -       movups IV, (IVP)
> -
> -.Lxts_dec_ret:
> -#ifndef __x86_64__
> -       popl KLEN
> -       popl KEYP
> -       popl LEN
> -       popl IVP
> -#endif
> -       FRAME_END
> -       RET
> -
> -.Lxts_dec_1x:
> -       add $64, LEN
> -       jz .Lxts_dec_ret_iv
> -
> -.Lxts_dec_loop1:
> -       movdqu (INP), STATE
> -
> -       add $16, INP
> -       sub $16, LEN
> -       jl .Lxts_dec_cts1
> -
> -       pxor IV, STATE
> -       call _aesni_dec1
> -       pxor IV, STATE
> -       _aesni_gf128mul_x_ble()
> -
> -       test LEN, LEN
> -       jz .Lxts_dec_out
> -
> -       movdqu STATE, (OUTP)
> -       add $16, OUTP
> -       jmp .Lxts_dec_loop1
> -
> -.Lxts_dec_out:
> -       movdqu STATE, (OUTP)
> -       jmp .Lxts_dec_ret_iv
> -
> -.Lxts_dec_cts1:
> -       movdqa IV, STATE4
> -       _aesni_gf128mul_x_ble()
> -
> -       pxor IV, STATE
> -       call _aesni_dec1
> -       pxor IV, STATE
> -
> -#ifndef __x86_64__
> -       lea .Lcts_permute_table, T1
> -#else
> -       lea .Lcts_permute_table(%rip), T1
> -#endif
> -       add LEN, INP            /* rewind input pointer */
> -       add $16, LEN            /* # bytes in final block */
> -       movups (INP), IN1
> -
> -       mov T1, IVP
> -       add $32, IVP
> -       add LEN, T1
> -       sub LEN, IVP
> -       add OUTP, LEN
> -
> -       movups (T1), %xmm4
> -       movaps STATE, IN2
> -       pshufb %xmm4, STATE
> -       movups STATE, (LEN)
> -
> -       movups (IVP), %xmm0
> -       pshufb %xmm0, IN1
> -       pblendvb IN2, IN1
> -       movaps IN1, STATE
> -
> -       pxor STATE4, STATE
> -       call _aesni_dec1
> -       pxor STATE4, STATE
> -
> -       movups STATE, (OUTP)
> -       jmp .Lxts_dec_ret
> +       _aesni_xts_crypt        0
>  SYM_FUNC_END(aesni_xts_dec)
>
> base-commit: 751fb2528c12ef64d1e863efb196cdc968b384f6
> --
> 2.44.0
>
>

