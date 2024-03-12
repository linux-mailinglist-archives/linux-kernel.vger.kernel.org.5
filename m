Return-Path: <linux-kernel+bounces-99917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2F8878F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6AC1C2109D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672CF69970;
	Tue, 12 Mar 2024 07:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs/zyoPA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FC816FF2B;
	Tue, 12 Mar 2024 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710229632; cv=none; b=PSCzRm4Y5k/zvNqt0R+fZx6pbutZE/lq4wILdKU4ZdwrRQXRwYfGLKrCIaqIDCWPeFyFwpSrqN9sCgU/HZSBB3QhOWbouk4UGcxOLZqdFQMMCfdPrugYzNhbp9uynYf0fkue8aTdVWWzZo94V8mOgAGJJ9bqaYWc+pqmX4tvsvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710229632; c=relaxed/simple;
	bh=FMH/xzSsT5yF9cAlBjt4jL2n7DTvWEKPwtnA09hxQfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dl9hrU2mDtZgkN88whfO2fHOIVBz+ehBsym58DZd6v9Z2N5SMZO6r3f5MxiX5bIkUZB0iLWML0mhL/yS8OWx6DXiT84bUKO9+zm5fGYpAgmJxsGhv0FFPH09ijafuLrI5iKddJeji9PLMPYtRdWOimJw/9knCx3peHcJQ5vGWeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs/zyoPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB12C433C7;
	Tue, 12 Mar 2024 07:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710229632;
	bh=FMH/xzSsT5yF9cAlBjt4jL2n7DTvWEKPwtnA09hxQfA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gs/zyoPAiiS7avIeC2i2SDCWaGS40xe/9muqFXmL2eOt3dtI21UZtfcs02h+tJnI6
	 HwdN8Dd3nysDN2NeV5+RVXMjsMFbBw2jZ+VpqYnESvT8gOtKr5ThGmPXq1lz23ESGo
	 5vlpSnVyubRJO4N1qsshQzvXoLjETq03YKGaXCgeBxqeivu6xKUvyAJrY46xy4Ym1l
	 NDHNx16SvGC+Cq1sAR4iFT/zk4M+jYZnkALTfgZ8fhqNCbxPdG9WhXL/YbLz5UbC+n
	 NpTJ6KejJc65QwKKQDFbIsJlXh4Hv+BgtDNf7Z8Kx17CSqHHgKrU+OG3mUc85bHi7P
	 IYXk6cbbxQa/w==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d41d1bedc9so57613451fa.3;
        Tue, 12 Mar 2024 00:47:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwqsCyK3XNqareGWho7bSIW1C4CsomeIRH2wxG2KqIpcHVZzXHq7Nu9yLM0mt+awcM10mH7AR4KxPNxHth6GpV/aulMEHoYDlmixJG
X-Gm-Message-State: AOJu0YyEC2iEpXpfXbo+zBj0JVB4Aw5HCrXrI5QVJDL0SICEzT0azuWN
	/6Ow7zmu1veOJA7kFd7dhfY2F/HiuUQwUnHO75WqV5OEMc85ASJfV4wjFcCmllHNhwluM6bjWac
	a5a3eMH/JJfZXYcWBaxDyNue1UUE=
X-Google-Smtp-Source: AGHT+IE8wH/JQX41mJXqZgFOFOf9uf0ev7uR/qkAq+0QM5/4Z9IgFj1H7yJgvVfIWY5dkf0Oz8hdxJJZRy56kzikeVw=
X-Received: by 2002:a2e:9252:0:b0:2d3:93dd:c54b with SMTP id
 v18-20020a2e9252000000b002d393ddc54bmr5048309ljg.25.1710229630362; Tue, 12
 Mar 2024 00:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607053558.GC941@sol.localdomain> <20240311213232.128240-1-chang.seok.bae@intel.com>
In-Reply-To: <20240311213232.128240-1-chang.seok.bae@intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 12 Mar 2024 08:46:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEQpFhDaxJ-rBb221ggdZEYWPzeoueKJr5SqRx60Ezf-w@mail.gmail.com>
Message-ID: <CAMj1kXEQpFhDaxJ-rBb221ggdZEYWPzeoueKJr5SqRx60Ezf-w@mail.gmail.com>
Subject: Re: [PATCH] crypto: x86/aesni - Update aesni_set_key() to return void
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, davem@davemloft.net, ebiggers@kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 22:48, Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> The aesni_set_key() implementation has no error case, yet its prototype
> specifies to return an error code.
>
> Modify the function prototype to return void and adjust the related code.
>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: linux-crypto@vger.kernel.org
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Previously, Eric identified a similar case in my AES-KL code [1]. Then,
> this parallel issue was realized.
>
> [1]: https://lore.kernel.org/lkml/20230607053558.GC941@sol.localdomain/
> ---
>  arch/x86/crypto/aesni-intel_asm.S  | 5 ++---
>  arch/x86/crypto/aesni-intel_glue.c | 6 +++---
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
> index 411d8c83e88a..7ecb55cae3d6 100644
> --- a/arch/x86/crypto/aesni-intel_asm.S
> +++ b/arch/x86/crypto/aesni-intel_asm.S
> @@ -1820,8 +1820,8 @@ SYM_FUNC_START_LOCAL(_key_expansion_256b)
>  SYM_FUNC_END(_key_expansion_256b)
>
>  /*
> - * int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
> - *                   unsigned int key_len)
> + * void aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
> + *                    unsigned int key_len)
>   */
>  SYM_FUNC_START(aesni_set_key)
>         FRAME_BEGIN
> @@ -1926,7 +1926,6 @@ SYM_FUNC_START(aesni_set_key)
>         sub $0x10, UKEYP
>         cmp TKEYP, KEYP
>         jb .Ldec_key_loop
> -       xor AREG, AREG
>  #ifndef __x86_64__
>         popl KEYP
>  #endif
> diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
> index b1d90c25975a..c807b2f48ea3 100644
> --- a/arch/x86/crypto/aesni-intel_glue.c
> +++ b/arch/x86/crypto/aesni-intel_glue.c
> @@ -87,8 +87,8 @@ static inline void *aes_align_addr(void *addr)
>         return PTR_ALIGN(addr, AESNI_ALIGN);
>  }
>
> -asmlinkage int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
> -                            unsigned int key_len);
> +asmlinkage void aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
> +                             unsigned int key_len);
>  asmlinkage void aesni_enc(const void *ctx, u8 *out, const u8 *in);
>  asmlinkage void aesni_dec(const void *ctx, u8 *out, const u8 *in);
>  asmlinkage void aesni_ecb_enc(struct crypto_aes_ctx *ctx, u8 *out,
> @@ -241,7 +241,7 @@ static int aes_set_key_common(struct crypto_aes_ctx *ctx,
>                 err = aes_expandkey(ctx, in_key, key_len);
>         else {
>                 kernel_fpu_begin();
> -               err = aesni_set_key(ctx, in_key, key_len);
> +               aesni_set_key(ctx, in_key, key_len);

This will leave 'err' uninitialized.

>                 kernel_fpu_end();
>         }
>
> --
> 2.34.1
>
>

