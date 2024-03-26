Return-Path: <linux-kernel+bounces-118579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0924A88BCD6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02191F2A437
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039C714F62;
	Tue, 26 Mar 2024 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEIMhhai"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3298079D3;
	Tue, 26 Mar 2024 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443122; cv=none; b=MZb7gwpy44lJb2pm0C+Xhz5rq6+TvlmEaH6LVjlKF/B8x+Rx3Y1M5m55bw34XvvKoI6yxJL7L/I5Bo0uHIIxrLYRgD4V/MkADzQY7zV6ji3mE3j1AqfH/rzj3eIdxipyHFe4jYfzsfvAYbBwRplcmW+jRSZoIg85WrHA8Qt3f+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443122; c=relaxed/simple;
	bh=m6eeM13RX7QtoF+0dazm66ZZ4J2w9eAtzSEqabRqfsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAbOu1nZ5kZL050lIDQzJsohCkdZDC6xpJO2P7JuWMBuT3X74eDDqRxy3o8XijlX5ZwY3Gi0KzD4MV0w2qWiJfCtmpe5jh99aDhMRrsDNUtIlR0Y8sStO6TxCyW4M1sV/KkLBB9cdft1j6UOtcdBSPU0T2WIeqBccCRtpbtTThI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEIMhhai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A78C433C7;
	Tue, 26 Mar 2024 08:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711443121;
	bh=m6eeM13RX7QtoF+0dazm66ZZ4J2w9eAtzSEqabRqfsA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iEIMhhai5JAyCYGoWthaf/kfJB//YtXj8epRpa8C2HER6o9iXamDJPgLYG3C2XRO6
	 2jWFdEIMqgCzMxsteABDIgh9BqWc3TK+oakPcl56Nu0lBdGhVzHKA9MiJpyIE9QTh+
	 FZ7186oX7V0wYLuki2nF2uRkD2XHwnQOKsugOimArIxMhTmzw91BjG0u8/b4oglWW1
	 MCUHsexLEkxgreHktfrZ1Vm/L08xdEgz8RQQ9gWA9FCBa4JeqK3M1dXIbdGsitzvM9
	 jloazxjcPNXLCwm+xwiYttoNDMt7u3irB2InX9Nck5nWflWZ8R3Ab3o1OwUJnTJ8cW
	 jnXEmt+zWjmqQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so66313841fa.3;
        Tue, 26 Mar 2024 01:52:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJfUdjclsbFFvaJqlLluMf6FZrBZ4vsQD4Qn2uMMh/M19ceaAIS8GUzyrO1xZHQQ7lQxaMrC6beTfXjah/0BEZfTjXhryKkVHjhzPL
X-Gm-Message-State: AOJu0YyFTh9EjcHhh9jl+BODEmep0FCW4V595c77CS7UlHF+w3/bNktt
	P5c7IHNIx7v7tsw4+ug64TZJeem+wIVYzdVR5mJ84zv4g6cd/1XcqW1VntAqI5cyZcHleab+H+o
	kmw3XtTXQXpUH50A02IkylCP7KZ8=
X-Google-Smtp-Source: AGHT+IHt+yhkC2OlG+Uf53nRYd3ZdWFMKJcvkZleUik87R6L9QZgYhrhlqjibg3W7Cz5FLhX14I90QV3wocL7cHHsHk=
X-Received: by 2002:a2e:7c06:0:b0:2d6:b0b5:bb12 with SMTP id
 x6-20020a2e7c06000000b002d6b0b5bb12mr5632431ljc.18.1711443120145; Tue, 26 Mar
 2024 01:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326080305.402382-1-ebiggers@kernel.org>
In-Reply-To: <20240326080305.402382-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 26 Mar 2024 10:51:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH4fNevFzrbazJptadxh_spEY3W91FZni5eMqD+UKrSUQ@mail.gmail.com>
Message-ID: <CAMj1kXH4fNevFzrbazJptadxh_spEY3W91FZni5eMqD+UKrSUQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Faster AES-XTS on modern x86_64 CPUs
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Andy Lutomirski <luto@kernel.org>, "Chang S . Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 10:06, Eric Biggers <ebiggers@kernel.org> wrote:
>
> This patchset adds new AES-XTS implementations that accelerate disk and
> file encryption on modern x86_64 CPUs.
>
> The largest improvements are seen on CPUs that support the VAES
> extension: Intel Ice Lake (2019) and later, and AMD Zen 3 (2020) and
> later.  However, an implementation using plain AESNI + AVX is also added
> and provides a small boost on older CPUs too.
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
> This patchset increases the throughput of AES-256-XTS decryption by the
> following amounts on the following CPUs:
>
>                           | 4096-byte messages | 512-byte messages |
>     ----------------------+--------------------+-------------------+
>     Intel Skylake         |        1%          |       11%         |
>     Intel Ice Lake        |        92%         |       59%         |
>     Intel Sapphire Rapids |       115%         |       78%         |
>     AMD Zen 1             |        25%         |       20%         |
>     AMD Zen 2             |        26%         |       20%         |
>     AMD Zen 3             |        82%         |       40%         |
>     AMD Zen 4             |       118%         |       48%         |
>
> (The results for encryption are very similar to decryption.  I just tend
> to measure decryption because decryption performance is more important.)
>
> There's no separate kconfig option for the new AES-XTS implementations,
> as they are included in the existing option CONFIG_CRYPTO_AES_NI_INTEL.
>
> To make testing easier, all four new AES-XTS implementations are
> registered separately with the crypto API.  They are prioritized
> appropriately so that the best one for the CPU is used by default.
>

This is very nice work!

I didn't check the performance delta on my system (it's Intel but I
have no idea which uarch), but it supports all flavours that you
implemented here, and all pass the selftests with
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y, so for the series

Tested-by: Ard Biesheuvel <ardb@kernel.org>

I will try to make time to review the code as well.

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

I don't have much input here, except that I think we should just
disable AVX512 kernel-wide on systems where there is no benefit in
terms of throughput. I suspect this might change with algorithms that
rely more heavily on the masking, but so far, we have been making
quite effective use of simple permute vectors and overlapping loads
and stores to do the same. And as Eric points out, the only relevant
use case in the kernel is blocks of size 2^n where n is at least 9.

