Return-Path: <linux-kernel+bounces-63624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC48C853266
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C241F245D7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35B856766;
	Tue, 13 Feb 2024 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7XwfuQc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC60556740;
	Tue, 13 Feb 2024 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832595; cv=none; b=NRZGE70TnF49yxJ3ouwmOqMFib/LzVElhx6sVlmVsQwunD1XbiKQXUdvDLjT+riApsYCahPPjtMjRnOCyYJvAb5wa5gFRZxrPojNpw7tyrCQdEgl8FgXGUrviTU18wKD9iR9m9p4Y8G1/HOe24GoDxkuZsOVPZz5ifReqpP1x14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832595; c=relaxed/simple;
	bh=0XomEVqzuk5nnm18UN4BiFse7jJOJ9BScWs48dFcA3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYZQCPpEo7har0Fh4Hfh3q9CzE1LOoNb651r4Tb+MgAZuDmXWobd2VE0kMS3qs8F8j/zfhGyuJy5LvaXvJ7oZnB83hnCTVjJYqBOdQmTfI654cbViUkRfW1xKTdZ8ty7nHYmWTCtlT50ba0qqgJbQCkF/RvunyEfz+IOe6eGKtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7XwfuQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868A8C43143;
	Tue, 13 Feb 2024 13:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707832594;
	bh=0XomEVqzuk5nnm18UN4BiFse7jJOJ9BScWs48dFcA3o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u7XwfuQcaw0hvNXIP0XM7ZzVVUC3VHT8EYqANc/5kFI483u6K8OHYoNxVwEis7uFq
	 yjCjiDCdlN/cMKR+FLFFEqNBIGN7qQNyPtixr/vxBxH9/mFPx+o01a00bfacq0mZHo
	 uNA6YahpdLm0/x3bLpsywL4wvslNDGWuRItUzX+OzMkh1HCWt2Ahpy7BCSSQpM94pc
	 3ZJpdDpuvdje5/CusghQg38WimlxI3aZpQTiQlcJEMV53+/ph32epwJ1E79l2adQ23
	 m0wjV6TOQa8J2YSjVf+dddNTQWt3RYBHXsNMcOyNotculGgUJk1pqYKrOfJfmTY8MJ
	 ISouD+BSErgpw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d1080cb9easo9000801fa.1;
        Tue, 13 Feb 2024 05:56:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU2NaCeh2dKqk6Y21teBaBl2O5gAwxeIHy3S3pHSDK9o6P8acd47olGFpZf7jCmAOJj9QKyV6Y8ZlvfNvyMxEut6bYTn7CZCBTI7Z9QojosjbS0eb0S1aJY3Jftab3WmWMnZHa9Fp9iJ1vk
X-Gm-Message-State: AOJu0Yy4ne84VuycdgEl8HBh+bHXBwPJIDnSyVlUBJOjlC+fiZTwUJ7P
	mAjTk6wdchae/8cY0Xec7Fr3MmD1p8IxYU280Kb2xaXgGYdxAcklZONQyZPCQdyQ5WhG1N5zGnS
	SCXjNG0vqjJB+XQOr44IC7oz95FA=
X-Google-Smtp-Source: AGHT+IH9aiCUTWDVl3tbhNLVoO+d2CO/JX7FACbk0dTpucaGfy3RJWbieGZ4mgcR0qTgbQ4rmll44dLLKbDHoQ1Ll7Y=
X-Received: by 2002:ac2:5398:0:b0:511:4fbb:47ac with SMTP id
 g24-20020ac25398000000b005114fbb47acmr6167461lfh.29.1707832592705; Tue, 13
 Feb 2024 05:56:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213135000.3400052-1-arnd@kernel.org>
In-Reply-To: <20240213135000.3400052-1-arnd@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 13 Feb 2024 14:56:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH9fDXp0u7kRGVbom_EWhob-VAu67gpWYacUMx-N-p+Fg@mail.gmail.com>
Message-ID: <CAMj1kXH9fDXp0u7kRGVbom_EWhob-VAu67gpWYacUMx-N-p+Fg@mail.gmail.com>
Subject: Re: [PATCH] [v2] ARM: crypto: fix function cast warnings
To: Arnd Bergmann <arnd@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	"David S. Miller" <davem@davemloft.net>, Russell King <linux@armlinux.org.uk>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jussi Kivilinna <jussi.kivilinna@iki.fi>, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Feb 2024 at 14:50, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang-16 warns about casting between incompatible function types:
>
> arch/arm/crypto/sha256_glue.c:37:5: error: cast from 'void (*)(u32 *, con=
st void *, unsigned int)' (aka 'void (*)(unsigned int *, const void *, unsi=
gned int)') to 'sha256_block_fn *' (aka 'void (*)(struct sha256_state *, co=
nst unsigned char *, int)') converts to incompatible function type [-Werror=
,-Wcast-function-type-strict]
>    37 |                                 (sha256_block_fn *)sha256_block_d=
ata_order);
>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
> arch/arm/crypto/sha512-glue.c:34:3: error: cast from 'void (*)(u64 *, con=
st u8 *, int)' (aka 'void (*)(unsigned long long *, const unsigned char *, =
int)') to 'sha512_block_fn *' (aka 'void (*)(struct sha512_state *, const u=
nsigned char *, int)') converts to incompatible function type [-Werror,-Wca=
st-function-type-strict]
>    34 |                 (sha512_block_fn *)sha512_block_data_order);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Fix the prototypes for the assembler functions to match the typedef.
> The code already relies on the digest being the first part of the
> state structure, so there is no change in behavior.
>
> Fixes: c80ae7ca3726 ("crypto: arm/sha512 - accelerated SHA-512 using ARM =
generic ASM and NEON")
> Fixes: b59e2ae3690c ("crypto: arm/sha256 - move SHA-224/256 ASM/NEON impl=
ementation to base layer")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: rewrite change as suggested by Herbert Xu.
> ---
>  arch/arm/crypto/sha256_glue.c | 13 +++++--------
>  arch/arm/crypto/sha512-glue.c | 12 +++++-------
>  2 files changed, 10 insertions(+), 15 deletions(-)
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> diff --git a/arch/arm/crypto/sha256_glue.c b/arch/arm/crypto/sha256_glue.=
c
> index 433ee4ddce6c..f85933fdec75 100644
> --- a/arch/arm/crypto/sha256_glue.c
> +++ b/arch/arm/crypto/sha256_glue.c
> @@ -24,8 +24,8 @@
>
>  #include "sha256_glue.h"
>
> -asmlinkage void sha256_block_data_order(u32 *digest, const void *data,
> -                                       unsigned int num_blks);
> +asmlinkage void sha256_block_data_order(struct sha256_state *state,
> +                                       const u8 *data, int num_blks);
>
>  int crypto_sha256_arm_update(struct shash_desc *desc, const u8 *data,
>                              unsigned int len)
> @@ -33,23 +33,20 @@ int crypto_sha256_arm_update(struct shash_desc *desc,=
 const u8 *data,
>         /* make sure casting to sha256_block_fn() is safe */
>         BUILD_BUG_ON(offsetof(struct sha256_state, state) !=3D 0);
>
> -       return sha256_base_do_update(desc, data, len,
> -                               (sha256_block_fn *)sha256_block_data_orde=
r);
> +       return sha256_base_do_update(desc, data, len, sha256_block_data_o=
rder);
>  }
>  EXPORT_SYMBOL(crypto_sha256_arm_update);
>
>  static int crypto_sha256_arm_final(struct shash_desc *desc, u8 *out)
>  {
> -       sha256_base_do_finalize(desc,
> -                               (sha256_block_fn *)sha256_block_data_orde=
r);
> +       sha256_base_do_finalize(desc, sha256_block_data_order);
>         return sha256_base_finish(desc, out);
>  }
>
>  int crypto_sha256_arm_finup(struct shash_desc *desc, const u8 *data,
>                             unsigned int len, u8 *out)
>  {
> -       sha256_base_do_update(desc, data, len,
> -                             (sha256_block_fn *)sha256_block_data_order)=
;
> +       sha256_base_do_update(desc, data, len, sha256_block_data_order);
>         return crypto_sha256_arm_final(desc, out);
>  }
>  EXPORT_SYMBOL(crypto_sha256_arm_finup);
> diff --git a/arch/arm/crypto/sha512-glue.c b/arch/arm/crypto/sha512-glue.=
c
> index 0635a65aa488..1be5bd498af3 100644
> --- a/arch/arm/crypto/sha512-glue.c
> +++ b/arch/arm/crypto/sha512-glue.c
> @@ -25,27 +25,25 @@ MODULE_ALIAS_CRYPTO("sha512");
>  MODULE_ALIAS_CRYPTO("sha384-arm");
>  MODULE_ALIAS_CRYPTO("sha512-arm");
>
> -asmlinkage void sha512_block_data_order(u64 *state, u8 const *src, int b=
locks);
> +asmlinkage void sha512_block_data_order(struct sha512_state *state,
> +                                       u8 const *src, int blocks);
>
>  int sha512_arm_update(struct shash_desc *desc, const u8 *data,
>                       unsigned int len)
>  {
> -       return sha512_base_do_update(desc, data, len,
> -               (sha512_block_fn *)sha512_block_data_order);
> +       return sha512_base_do_update(desc, data, len, sha512_block_data_o=
rder);
>  }
>
>  static int sha512_arm_final(struct shash_desc *desc, u8 *out)
>  {
> -       sha512_base_do_finalize(desc,
> -               (sha512_block_fn *)sha512_block_data_order);
> +       sha512_base_do_finalize(desc, sha512_block_data_order);
>         return sha512_base_finish(desc, out);
>  }
>
>  int sha512_arm_finup(struct shash_desc *desc, const u8 *data,
>                      unsigned int len, u8 *out)
>  {
> -       sha512_base_do_update(desc, data, len,
> -               (sha512_block_fn *)sha512_block_data_order);
> +       sha512_base_do_update(desc, data, len, sha512_block_data_order);
>         return sha512_arm_final(desc, out);
>  }
>
> --
> 2.39.2
>

