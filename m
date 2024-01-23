Return-Path: <linux-kernel+bounces-34616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2736F8383F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E4D2965FB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852B665BAC;
	Tue, 23 Jan 2024 01:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="2JOi9WUH"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB6065BA6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975100; cv=none; b=rKRK1KcyL4N55JY0d/pVEDXeS49e6tDiJb8nxBjqZgxiQmoJJ9CTL7xIPGInK3Gb09TiPTcaFnNwuNRo/91DHDh2T7+KpJHlNFQNMX6g1UD/PX3ANglVBxjSF4vFFqtbzuBgS7H5fxc0GzOLRwAgidYt6zXcx12hGpWTDiBIi+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975100; c=relaxed/simple;
	bh=C0cmY3Yc126hc3Jzzmo/IPOo+CewaLsKcA1hSSoU9oc=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=cHmyijYz12fAsVBz5jbn0n6WWIfHkGRjFvO0hNv8+e0YTNHnv4FNI0msTD0T7PCgKg4KjPKrUI+lidhbhnL8vreZ/Ul1s99KBfe0WUjqRwwy+u6NxLD/JkIzF5uyUcjgA2hBPtMYf3vGkWwxmjflG46FGf+0l7B9BrTIFvZ48Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=2JOi9WUH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d71e24845aso20284365ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1705975098; x=1706579898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xl1bS9xx12/4+TlYvqy1BacmMJQkNZFYVSIgYjkxeXA=;
        b=2JOi9WUHZey91jPG/eqkEKD87lUZXBsg5GyTTKnQrSxkMGsWcPjTHghbaLaSM6CG3m
         IpVRwHzc895eydG2Z1UX+yHwScZ+qU3nEQuu7SClxotSIqI0EmGYRddtHybS+qNXCq3P
         5zaW65u9aVDNsz+Tz6q1sjr76L4kZTKdcqbe7khBZLUfnw7sEbNUDsDPp9D0QLGG0h9U
         kqNWZrr2eOzBClCVK7BejyRkHYjBT5aj5ODxdHR+XzKqcvit2h7/wKVZ+tWqeU+ymhGE
         MwVd0J1zPhHj4hDShCWhVv5Jmy3nugagIkph4up1mdHfd7pccD4sTzHTDF4jWm3Svq9A
         o5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705975098; x=1706579898;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xl1bS9xx12/4+TlYvqy1BacmMJQkNZFYVSIgYjkxeXA=;
        b=IV2uFgBRuLmGS7qV/FRXYlJXa7QeK7LekT4tZcAC1+boPIXUmiyoesz/94CI1+xg0L
         /40JaImUUZ5BNyN7xH31xxkGNGUhfQ4fZe0m3WoiZf+Pp7B6AfxRTOI9ymbq4N7QTvNa
         PYfBBnAXcF+RPKxGt8tCkPB/u04JBBGYLPkscWlHTutPDElbqrRejht9f/ex13ytl0kL
         Ca3ry5J6XZVnWEzgOlVdsHR3g/Ckpl3rf7tbnBpqNNpxgUmnrvhJEolApd3/Wmja7B+A
         o/PB8g33cCeISnAl8KEe4T1mgOfsDPPJWV0dyfoogRztztsvDOjV/IaaoQkgYgoL+RWD
         sA4A==
X-Gm-Message-State: AOJu0Yz778dRZTAJMtZuSB7kUw1m3EZY5gy8FF7qRsqRidcDGXGAobER
	UZpJhsq6wUEEgX9e5sqTv7RSgU0/BzPcT5OgwJiUeo7MRCBSGhr+j5IMOq9bHoc=
X-Google-Smtp-Source: AGHT+IGfPm27pCdlWIEdcPx9mb5M1+rrIWMsXK6AMdbrIt8teRpxerMx5/kPe/+y5EpMdTUT160Btw==
X-Received: by 2002:a17:902:ef93:b0:1d7:131a:1f05 with SMTP id iz19-20020a170902ef9300b001d7131a1f05mr2047709plb.23.1705975097784;
        Mon, 22 Jan 2024 17:58:17 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902ef0500b001d7244c8ee0sm5634529plx.117.2024.01.22.17.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 17:58:17 -0800 (PST)
Date: Mon, 22 Jan 2024 17:58:17 -0800 (PST)
X-Google-Original-Date: Mon, 22 Jan 2024 17:58:10 PST (-0800)
Subject:     Re: [PATCH v3 00/10] RISC-V crypto with reworked asm files
In-Reply-To: <20240122002024.27477-1-ebiggers@kernel.org>
CC: linux-crypto@vger.kernel.org, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu, andy.chiu@sifive.com, Ard Biesheuvel <ardb@kernel.org>,
  christoph.muellner@vrull.eu, heiko@sntech.de, jerry.shih@sifive.com,
  Paul Walmsley <paul.walmsley@sifive.com>, phoebe.chen@sifive.com, hongrong.hsu@sifive.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: ebiggers@kernel.org
Message-ID: <mhng-4b573769-2306-43f9-8c7a-c7a1bc461502@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Sun, 21 Jan 2024 16:19:11 PST (-0800), ebiggers@kernel.org wrote:
> This patchset, which applies to v6.8-rc1, adds cryptographic algorithm
> implementations accelerated using the RISC-V vector crypto extensions
> (https://github.com/riscv/riscv-crypto/releases/download/v1.0.0/riscv-crypto-spec-vector.pdf)
> and RISC-V vector extension
> (https://github.com/riscv/riscv-v-spec/releases/download/v1.0/riscv-v-spec-1.0.pdf).
> The following algorithms are included: AES in ECB, CBC, CTR, and XTS modes;
> ChaCha20; GHASH; SHA-2; SM3; and SM4.
>
> In general, the assembly code requires a 64-bit RISC-V CPU with VLEN >= 128,
> little endian byte order, and vector unaligned access support.  The ECB, CTR,
> XTS, and ChaCha20 code is designed to naturally scale up to larger VLEN values.
> Building the assembly code requires tip-of-tree binutils (future 2.42) or
> tip-of-tree clang (future 18.x).  All algorithms pass testing in QEMU, using
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y.  Much of the assembly code is derived from
> OpenSSL code that was added by https://github.com/openssl/openssl/pull/21923.
> It's been cleaned up for integration with the kernel, e.g. reducing code
> duplication, eliminating use of .inst and perlasm, and fixing a few bugs.
>
> This patchset incorporates the work of multiple people, including Jerry Shih,
> Heiko Stuebner, Christoph Müllner, Phoebe Chen, Charalampos Mitrodimas, and
> myself.  This patchset went through several versions from Heiko (last version
> https://lore.kernel.org/linux-crypto/20230711153743.1970625-1-heiko@sntech.de),
> then several versions from Jerry (last version:
> https://lore.kernel.org/linux-crypto/20231231152743.6304-1-jerry.shih@sifive.com),
> then finally several versions from me.  Thanks to everyone who has contributed
> to this patchset or its prerequisites.  Since v6.8-rc1, all prerequisite kernel
> patches are upstream.  I think this is now ready, and I'd like for it to be
> applied for 6.9, either to the crypto or riscv tree (at maintainers' choice).

I'm OK taking this through the RISC-V tree if folks want, I've gone and 
queued it up for my tester.  Just LMK if it should go somewhere else, 
otherwise it'll end up on for-next in a day or so (I'm trying to get LTO 
builds added right now, so it might take a bit).

>
> Below is the changelog for my versions of the patchset.  For the changelog of
> the older versions, see the above links.
>
> Changed in v3:
>   - Fixed a bug in the AES-XTS implementation where it assumed the CPU
>     always set vl to the maximum possible value.  This was okay for
>     QEMU, but the vector spec allows CPUs to have different behavior.
>   - Increased the LMUL for AES-ECB to 8, as the registers are available.
>   - Fixed some license text that I had mistakenly changed when doing a
>     find-and-replace of code.
>   - Addressed a checkpatch warning by not including filename in file.
>   - Rename some labels.
>   - Constify a variable.
>
> Changed in v2:
>   - Merged the AES modules together to prevent a build error.
>   - Only unregister AES algorithms that were registered.
>   - Corrected walksize properties to match the LMUL used by asm code.
>   - Simplified the CTR and XTS glue code slightly.
>   - Minor cleanups.
>
> Changed in v1:
>   - Refer to my cover letter
>     https://lore.kernel.org/linux-crypto/20240102064743.220490-1-ebiggers@kernel.org/
>
> Eric Biggers (1):
>   RISC-V: add TOOLCHAIN_HAS_VECTOR_CRYPTO
>
> Heiko Stuebner (2):
>   RISC-V: add helper function to read the vector VLEN
>   RISC-V: hook new crypto subdir into build-system
>
> Jerry Shih (7):
>   crypto: riscv - add vector crypto accelerated AES-{ECB,CBC,CTR,XTS}
>   crypto: riscv - add vector crypto accelerated ChaCha20
>   crypto: riscv - add vector crypto accelerated GHASH
>   crypto: riscv - add vector crypto accelerated SHA-{256,224}
>   crypto: riscv - add vector crypto accelerated SHA-{512,384}
>   crypto: riscv - add vector crypto accelerated SM3
>   crypto: riscv - add vector crypto accelerated SM4
>
>  arch/riscv/Kbuild                             |   1 +
>  arch/riscv/Kconfig                            |   7 +
>  arch/riscv/crypto/Kconfig                     |  93 +++
>  arch/riscv/crypto/Makefile                    |  23 +
>  arch/riscv/crypto/aes-macros.S                | 156 +++++
>  arch/riscv/crypto/aes-riscv64-glue.c          | 550 ++++++++++++++++++
>  .../crypto/aes-riscv64-zvkned-zvbb-zvkg.S     | 312 ++++++++++
>  arch/riscv/crypto/aes-riscv64-zvkned-zvkb.S   | 146 +++++
>  arch/riscv/crypto/aes-riscv64-zvkned.S        | 180 ++++++
>  arch/riscv/crypto/chacha-riscv64-glue.c       | 101 ++++
>  arch/riscv/crypto/chacha-riscv64-zvkb.S       | 294 ++++++++++
>  arch/riscv/crypto/ghash-riscv64-glue.c        | 168 ++++++
>  arch/riscv/crypto/ghash-riscv64-zvkg.S        |  72 +++
>  arch/riscv/crypto/sha256-riscv64-glue.c       | 137 +++++
>  .../sha256-riscv64-zvknha_or_zvknhb-zvkb.S    | 225 +++++++
>  arch/riscv/crypto/sha512-riscv64-glue.c       | 133 +++++
>  .../riscv/crypto/sha512-riscv64-zvknhb-zvkb.S | 203 +++++++
>  arch/riscv/crypto/sm3-riscv64-glue.c          | 112 ++++
>  arch/riscv/crypto/sm3-riscv64-zvksh-zvkb.S    | 123 ++++
>  arch/riscv/crypto/sm4-riscv64-glue.c          | 107 ++++
>  arch/riscv/crypto/sm4-riscv64-zvksed-zvkb.S   | 117 ++++
>  arch/riscv/include/asm/vector.h               |  11 +
>  crypto/Kconfig                                |   3 +
>  23 files changed, 3274 insertions(+)
>  create mode 100644 arch/riscv/crypto/Kconfig
>  create mode 100644 arch/riscv/crypto/Makefile
>  create mode 100644 arch/riscv/crypto/aes-macros.S
>  create mode 100644 arch/riscv/crypto/aes-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned-zvbb-zvkg.S
>  create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned-zvkb.S
>  create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned.S
>  create mode 100644 arch/riscv/crypto/chacha-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/chacha-riscv64-zvkb.S
>  create mode 100644 arch/riscv/crypto/ghash-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/ghash-riscv64-zvkg.S
>  create mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S
>  create mode 100644 arch/riscv/crypto/sha512-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/sha512-riscv64-zvknhb-zvkb.S
>  create mode 100644 arch/riscv/crypto/sm3-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/sm3-riscv64-zvksh-zvkb.S
>  create mode 100644 arch/riscv/crypto/sm4-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/sm4-riscv64-zvksed-zvkb.S
>
>
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d

