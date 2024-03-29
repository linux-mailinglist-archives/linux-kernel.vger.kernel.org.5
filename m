Return-Path: <linux-kernel+bounces-124303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A15891555
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCB1283508
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CB239ADD;
	Fri, 29 Mar 2024 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/GSuVGj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD772554B;
	Fri, 29 Mar 2024 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703000; cv=none; b=pkqnBM7NignsdOkTOvRXKZbza4HANHJMZS+VncXqdf/B5g1obVp5dUQBWdK31FEEqqxZsdHn9bluT6l1FdLro762BblzZVRSrRW4GoKvyF0temDujoDjhCxbcfSn/VlfA8e7jG0IoLmF334dlxr6cgI/Jc0HvNZLuhK35WoLR+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703000; c=relaxed/simple;
	bh=9+XxVWlnVEGD6Kgr0GSGU5MeBsUU3Gt2QSEOy7liNpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mvhygaqj/i0gFjJcCMalWAWC7QTlruDV5umi1JGWYM3vdxruJnPRGwP2N1isfaKMTW4K1PwmlohI+0+vFS+N7l87L+/RqoQpuIyDZgKcgpeWvihOb//CmcQjKHoHci1ZakUmDZnVOUcXVRNpJeYCWzr3l+Ns+wMRJ1hhVeQmd3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/GSuVGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276E7C433C7;
	Fri, 29 Mar 2024 09:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703000;
	bh=9+XxVWlnVEGD6Kgr0GSGU5MeBsUU3Gt2QSEOy7liNpo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s/GSuVGjyKWXBQXEJEukGgl6lfAyaQuQbdVdbltFjUfdjZBDvdj1CYrBj3x4lE/RI
	 PGJFmxI70SH7YccdP8gd6nJAJRDjUBiU+ZUcjL9KjNY7k0MjlTYKz5YZiNEKiMkYcB
	 aYzBF0GOrjxppZNslwQNsiSEsUEjx4PiNaIXxjShK0ClvQW5n8Qx+1jSHUua3BMtzP
	 auhpOlwENkoSoymAn1PVEOizJs4ZegFlibOtOMkTNri4sYLg2onSZ4HIWPtbfiWbda
	 Lk0wpGmu3tt49jwS5HN8/sgdhMZL3LHFsWxfojC6M+RXEQTRwUiWo8bUjsO21ZRFCJ
	 i8YMWoXFKHGpg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-515c3eeea5dso1840095e87.1;
        Fri, 29 Mar 2024 02:03:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgAWwVos3nUtU2Y+Cq2nsJ34oJOxYZ2J4m+w+qpBZjro4Evzy+WYCysxx4pdmkyRIiKm2yCvgOxQoEnEQZqTqJEQLVYiOxsGluGjEN
X-Gm-Message-State: AOJu0Yzkd5sm6s9TqnHJj9OUNxTSTLyXkiVEYF52YGkpHxcvgEqVh6UR
	rQSX63zC0vtfQYohkVgXMpBkH3GzqtkbGTb9l11QMUphgU/TMm9wrCFr3Rxy836LgcYVmRR6ASD
	t9lszTuALPKgp1/NzpTNMGwcrZ5E=
X-Google-Smtp-Source: AGHT+IGy3Yn/+h8SR2x5X5rKl+0pk4khdVWMdTeWMdjmcHsyPPT4Zwby1ei1AAVW2/CwgoNDZ0FBLpXRAfRqY97qh4M=
X-Received: by 2002:ac2:4d0f:0:b0:515:bf51:a533 with SMTP id
 r15-20020ac24d0f000000b00515bf51a533mr973506lfi.23.1711702998438; Fri, 29 Mar
 2024 02:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329080355.2871-1-ebiggers@kernel.org>
In-Reply-To: <20240329080355.2871-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 29 Mar 2024 11:03:07 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEupfkpe98PdtbxQbtx1z5J_fZFPzT7wJ2tsJnCT9uaxA@mail.gmail.com>
Message-ID: <CAMj1kXEupfkpe98PdtbxQbtx1z5J_fZFPzT7wJ2tsJnCT9uaxA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Faster AES-XTS on modern x86_64 CPUs
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Andy Lutomirski <luto@kernel.org>, "Chang S . Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Mar 2024 at 10:06, Eric Biggers <ebiggers@kernel.org> wrote:
>
> This patchset adds new AES-XTS implementations that accelerate disk and
> file encryption on modern x86_64 CPUs.
>
> The largest improvements are seen on CPUs that support the VAES
> extension: Intel Ice Lake (2019) and later, and AMD Zen 3 (2020) and
> later.  However, an implementation using plain AESNI + AVX is also added
> and provides a boost on older CPUs too.
>
> To try to handle the mess that is x86 SIMD, the code for all the new
> AES-XTS implementations is generated from an assembly macro.  This makes
> it so that we e.g. don't have to have entirely different source code
> just for different vector lengths (xmm, ymm, zmm).
>
> To avoid downclocking effects, zmm registers aren't used on certain
> Intel CPU models such as Ice Lake.  These CPU models default to an
> implementation using ymm registers instead.
>
> To make testing easier, all four new AES-XTS implementations are
> registered separately with the crypto API.  They are prioritized
> appropriately so that the best one for the CPU is used by default.
>
> There's no separate kconfig option for the new implementations, as they
> are included in the existing option CONFIG_CRYPTO_AES_NI_INTEL.
>
> This patchset increases the throughput of AES-256-XTS by the following
> amounts on the following CPUs:
>
>                           | 4096-byte messages | 512-byte messages |
>     ----------------------+--------------------+-------------------+
>     Intel Skylake         |        6%          |       31%         |
>     Intel Cascade Lake    |        4%          |       26%         |
>     Intel Ice Lake        |       127%         |      120%         |
>     Intel Sapphire Rapids |       151%         |      112%         |
>     AMD Zen 1             |        61%         |       73%         |
>     AMD Zen 2             |        36%         |       59%         |
>     AMD Zen 3             |       138%         |       99%         |
>     AMD Zen 4             |       155%         |      117%         |
>
> To summarize how the XTS implementations perform in general, here are
> benchmarks of all of them on AMD Zen 4, with 4096-byte messages.  (Of
> course, in practice only the best one for the CPU actually gets used.)
>
>     xts-aes-aesni                  4247 MB/s
>     xts-aes-aesni-avx              5669 MB/s
>     xts-aes-vaes-avx2              9588 MB/s
>     xts-aes-vaes-avx10_256         9631 MB/s
>     xts-aes-vaes-avx10_512         10868 MB/s
>
> ... and on Intel Sapphire Rapids:
>
>     xts-aes-aesni                  4848 MB/s
>     xts-aes-aesni-avx              5287 MB/s
>     xts-aes-vaes-avx2              11685 MB/s
>     xts-aes-vaes-avx10_256         11938 MB/s
>     xts-aes-vaes-avx10_512         12176 MB/s
>
> Notes about benchmarking methods:
>
> - All my benchmarks were done using a custom kernel module that invokes
>   the crypto_skcipher API.  Note that benchmarking the crypto API from
>   userspace using AF_ALG, e.g. as 'cryptsetup benchmark' does, is bad at
>   measuring fast algorithms due to the syscall overhead of AF_ALG.  I
>   don't recommend that method.  Instead, I measured the crypto
>   performance directly, as that's what this patchset focuses on.
>
> - All numbers I give are for decryption.  However, on all the CPUs I
>   tested, encryption performs almost identically to decryption.
>
> Open questions:
>
> - Is the policy that I implemented for preferring ymm registers to zmm
>   registers the right one?  arch/x86/crypto/poly1305_glue.c thinks that
>   only Skylake has the bad downclocking.  My current proposal is a bit
>   more conservative; it also excludes Ice Lake and Tiger Lake.  Those
>   CPUs supposedly still have some downclocking, though not as much.
>
> - Should the policy on the use of zmm registers be in a centralized
>   place?  It probably doesn't make sense to have random different
>   policies for different crypto algorithms (AES, Poly1305, ARIA, etc.).
>
> - Are there any other known issues with using AVX512 in kernel mode?  It
>   seems to work, and technically it's not new because Poly1305 and ARIA
>   already use AVX512, including the mask registers and zmm registers up
>   to 31.  So if there was a major issue, like the new registers not
>   being properly saved and restored, it probably would have already been
>   found.  But AES-XTS support would introduce a wider use of it.
>
> - Should we perhaps not even bother with AVX512 / AVX10 at all for now,
>   given that on current CPUs most of the improvement is achieved by
>   going to VAES + AVX2?  I.e. should we skip the last two patches?  I'm
>   hoping the improvement will be greater on future CPUs, though.
>
> Changed in v2:
>   - Additional optimizations:
>       - Interleaved the tweak computation with AES en/decryption.  This
>         helps significantly on some CPUs, especially those without VAES.
>       - Further optimized for single-page sources and destinations.
>       - Used fewer instructions to update tweaks in VPCLMULQDQ case.
>       - Improved handling of "round 0".
>       - Eliminated a jump instruction from the main loop.
>   - Other
>       - Fixed zmm_exclusion_list[] to be null-terminated.
>       - Added missing #ifdef to unregister_xts_algs().
>       - Added some more comments.
>       - Improved cover letter and some commit messages.
>       - Now that the next tweak is always computed anyways, made it be
>         returned unconditionally.
>       - Moved the IV encryption to a separate function.
>
> Eric Biggers (6):
>   x86: add kconfig symbols for assembler VAES and VPCLMULQDQ support
>   crypto: x86/aes-xts - add AES-XTS assembly macro for modern CPUs
>   crypto: x86/aes-xts - wire up AESNI + AVX implementation
>   crypto: x86/aes-xts - wire up VAES + AVX2 implementation
>   crypto: x86/aes-xts - wire up VAES + AVX10/256 implementation
>   crypto: x86/aes-xts - wire up VAES + AVX10/512 implementation
>

Retested this v2:

Tested-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Hopefully, the AES-KL keylocker implementation can be based on this
template as well. I wouldn't mind retiring the existing xts(aesni)
code entirely, and using the xts() wrapper around ecb-aes-aesni on
32-bit and on non-AVX uarchs with AES-NI.

