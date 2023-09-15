Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBD67A25B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbjIOS3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236572AbjIOS3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:29:34 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEC82709
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:29:20 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68fbd5cd0ceso2132343b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694802560; x=1695407360; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/nmIdsonQN3As2T1chhFUGzsAAH6aCPTvliuI7z4jzM=;
        b=y3IXFrF4oJDtP/fFwql4dj+q6j1e2pOG+GC1Eggl+ExLtbgOd4jpKyeLWtf+pY3X2p
         0KN2lu0K6I6e+BCdUaU2y2eT8Vc6w49O5pRnAbpxvUeU47l9UsrSpWnXSHSFaPccbZZ/
         13C9aeER92EgXK2dtXbl735xahgR3VgnmCGTvcmio0Ru0/ar0OJSSubld0lThNVxv7sL
         iCNye2ea52hYgOdkxBCyLYJsoTnL+Ff+NjFPANLA8/XpxlBNS1TjkJMImq139A9FD9lb
         HNOw+q6Mvo0wKbICqhsj6PxghWfpTxEk8UqY+ICvr7RFhe9i+JOZGPEGkXW/7ZrImPOv
         zRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694802560; x=1695407360;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nmIdsonQN3As2T1chhFUGzsAAH6aCPTvliuI7z4jzM=;
        b=ugaKnU74yNneV/Y7RdlBKAyuXg8lEIirzEK9vvMLLW0R9AGbH3g8m4P/B9QEappWDA
         KWb5q0Okur5h2q0JYrDMYHZ6EWJlYI5RZvQhc6sBzXaydH89hVh9v6uuyss+IqrmyhP5
         TYm9uClsHfOVJjFAjwHz0uGIf3vDnKPf8ol0gLntOdHDu9rFXYpuXOHAWuaGcEWsUS1D
         +AmfDG3M3cJXPsiaL0iARUcZIN9DPsTzP99K56FS8t7rrj2/XvR9h0F+NVrQNYKbwiFC
         GKGeyrTG3Msu6AAs4yOWwMh2CdVM3tJs2YSiciwoMKVTL/zwsGeJBKO5odVqaF7mRmyY
         b4/Q==
X-Gm-Message-State: AOJu0Yz3iMRmqqwleo2cZQMtCrY8MT85OVCdg4v+e+w0mGsDtCeVTgW2
        aaWlqiwsocdjcc5cqIG8uG8hvg==
X-Google-Smtp-Source: AGHT+IGhtlUWFNzUzQjWie/iIVxGfAgAr89kBqzDBd+JOcOwZoW49FJqc6vRcQS11GEXu2cPvAcM4A==
X-Received: by 2002:a05:6a00:2d90:b0:68f:c7c5:a73a with SMTP id fb16-20020a056a002d9000b0068fc7c5a73amr2811298pfb.16.1694802559608;
        Fri, 15 Sep 2023 11:29:19 -0700 (PDT)
Received: from ghost ([50.168.177.76])
        by smtp.gmail.com with ESMTPSA id ey4-20020a056a0038c400b0064d74808738sm3270085pfb.214.2023.09.15.11.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 11:29:19 -0700 (PDT)
Date:   Fri, 15 Sep 2023 14:29:14 -0400
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Andy Chiu <andy.chiu@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] riscv: Add BLAKE2s V implementation
Message-ID: <ZQSieofQfDY5mTlI@ghost>
References: <20230912115728.172982-1-bjorn@kernel.org>
 <20230912115728.172982-7-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912115728.172982-7-bjorn@kernel.org>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 01:57:28PM +0200, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> BLAKE2s is used in various places, most notably in Wireguard, and as
> of v5.17 in drivers/char/random.
> 
> Add a BLAKE2s implementation using the V-extension. This is a
> translation of the x86-64 AVX512 variant
> (arch/x86/crypto/blake2s-core.S) to the RISC-V V-extension.
> 
> The AVX512 variant requires registers >= 256b (ymm*), and hence this
> implementation requires a VLEN of >=256.
> 
> The implementation passes the kernel BLAKE2s selftest, and has been
> tested on spike and qemu.
> 
> Instruction-wise, the V-variant uses 60% less instructions than the
> generic, C-based, implementation.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>  arch/riscv/Kbuild                |   2 +-
>  arch/riscv/crypto/Kconfig        |  16 +++
>  arch/riscv/crypto/Makefile       |   6 ++
>  arch/riscv/crypto/blake2s-glue.c |  39 ++++++++
>  arch/riscv/crypto/blake2s-v.S    | 164 +++++++++++++++++++++++++++++++
>  crypto/Kconfig                   |   3 +
>  drivers/net/Kconfig              |   1 +
>  7 files changed, 230 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/crypto/Kconfig
>  create mode 100644 arch/riscv/crypto/Makefile
>  create mode 100644 arch/riscv/crypto/blake2s-glue.c
>  create mode 100644 arch/riscv/crypto/blake2s-v.S
> 
> diff --git a/arch/riscv/Kbuild b/arch/riscv/Kbuild
> index d25ad1c19f88..1a5d89a18920 100644
> --- a/arch/riscv/Kbuild
> +++ b/arch/riscv/Kbuild
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  
> -obj-y += kernel/ mm/ net/
> +obj-y += kernel/ mm/ net/ crypto/
>  obj-$(CONFIG_BUILTIN_DTB) += boot/dts/
>  obj-y += errata/
>  obj-$(CONFIG_KVM) += kvm/
> diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
> new file mode 100644
> index 000000000000..e072400eb456
> --- /dev/null
> +++ b/arch/riscv/crypto/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +menu "Accelerated Cryptographic Algorithms for CPU (RISC-V)"
> +
> +config CRYPTO_BLAKE2S_RISCV
> +	bool "Hash functions: BLAKE2s (V)"
> +	depends on 64BIT && MMU && RISCV_ISA_V
> +	select CRYPTO_LIB_BLAKE2S_GENERIC
> +	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
> +	help
> +	  BLAKE2s cryptographic hash function (RFC 7693)
> +
> +	  Architecture: riscv64 using:
> +	  - V extension (VLEN >= 256)
> +
> +endmenu
> diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
> new file mode 100644
> index 000000000000..1768025c13ae
> --- /dev/null
> +++ b/arch/riscv/crypto/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# RISC-V crypto algorithms
> +
> +obj-$(CONFIG_CRYPTO_BLAKE2S_RISCV) += libblake2s-riscv.o
> +libblake2s-riscv-y := blake2s-v.o blake2s-glue.o
> diff --git a/arch/riscv/crypto/blake2s-glue.c b/arch/riscv/crypto/blake2s-glue.c
> new file mode 100644
> index 000000000000..d3de0e8e5872
> --- /dev/null
> +++ b/arch/riscv/crypto/blake2s-glue.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 Rivos, Inc. All Rights Reserved.
> + * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> + */
> +
> +#include <crypto/internal/blake2s.h>
> +
> +#include <linux/types.h>
> +#include <linux/minmax.h>
> +#include <linux/sizes.h>
> +
> +#include <linux/sched.h>
> +#include <linux/sched/task_stack.h>
> +#include <asm/simd.h>
> +#include <asm/vector.h>
> +
> +asmlinkage void blake2s_compress_vector(struct blake2s_state *state, const u8 *block,
> +					const size_t nblocks, const u32 inc);
> +
> +void blake2s_compress(struct blake2s_state *state, const u8 *block, size_t nblocks, const u32 inc)
> +{
> +	if (!(has_vector() && riscv_v_vsize >= 256 * 32 / 8) || !may_use_simd()) {
> +		blake2s_compress_generic(state, block, nblocks, inc);
> +		return;
> +	}
> +
> +	do {
> +		const size_t blocks = min_t(size_t, nblocks, SZ_4K / BLAKE2S_BLOCK_SIZE);
> +
> +		kernel_vector_begin();
> +		blake2s_compress_vector(state, block, blocks, inc);
> +		kernel_vector_end();
> +
> +		nblocks -= blocks;
> +		block += blocks * BLAKE2S_BLOCK_SIZE;
> +	} while (nblocks);
> +}
> +EXPORT_SYMBOL(blake2s_compress);
> diff --git a/arch/riscv/crypto/blake2s-v.S b/arch/riscv/crypto/blake2s-v.S
> new file mode 100644
> index 000000000000..9653b7a19127
> --- /dev/null
> +++ b/arch/riscv/crypto/blake2s-v.S
> @@ -0,0 +1,164 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/*
> + * BLAKE2s RISC-V V implementation
> + *
> + * Copyright (C) 2022 Rivos, Inc. All Rights Reserved.
> + * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> + * Copyright (C) 2017-2019 Samuel Neves <sneves@dei.uc.pt>. All Rights Reserved.
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/asm.h>
> +
> +.section .rodata, "a", @progbits
> +
> +.align 8
> +IV:
> +.octa 0xA54FF53A3C6EF372BB67AE856A09E667
> +.octa 0x5BE0CD191F83D9AB9B05688C510E527F
> +
> +.align 8
> +SIGMA2:
> +.long  0,  2,  4,  6,  1,  3,  5,  7, 14,  8, 10, 12, 15,  9, 11, 13
> +.long  8,  2, 13, 15, 10,  9, 12,  3,  6,  4,  0, 14,  5, 11,  1,  7
> +.long 11, 13,  8,  6,  5, 10, 14,  3,  2,  4, 12, 15,  1,  0,  7,  9
> +.long 11, 10,  7,  0,  8, 15,  1, 13,  3,  6,  2, 12,  4, 14,  9,  5
> +.long  4, 10,  9, 14, 15,  0, 11,  8,  1,  7,  3, 13,  2,  5,  6, 12
> +.long  2, 11,  4, 15, 14,  3, 10,  8, 13,  6,  5,  7,  0, 12,  1,  9
> +.long  4,  8, 15,  9, 14, 11, 13,  5,  3,  2,  1, 12,  6, 10,  7,  0
> +.long  6, 13,  0, 14, 12,  2,  1, 11, 15,  4,  5,  8,  7,  9,  3, 10
> +.long 15,  5,  4, 13, 10,  7,  3, 11, 12,  2,  0,  6,  9,  8,  1, 14
> +.long  8,  7, 14, 11, 13, 15,  0, 12, 10,  4,  5,  6,  3,  2,  1,  9
> +
> +.align 8
> +GATHER_DIAG1:
> +.long  3, 0, 1, 2
> +.align 8
> +GATHER_DIAG2:
> +.long  2, 3, 0, 1
> +.align 8
> +GATHER_DIAG3:
> +.long  1, 2, 3, 0
> +
> +.section .text
> +
> +.macro VROR REG BITS TMPREG
> +	vmv.v.v		\TMPREG, \REG
> +	vsrl.vi		\REG, \REG, \BITS
> +	vsll.vi		\TMPREG, \TMPREG, 32-\BITS
> +	vor.vv		\REG, \REG, \TMPREG
> +.endm

This seems like it would be a good candidate to use the Zvkb extension
that has vector rotate [1]. It would be a pain to use because you need
two versions of the roundloop, but you could get away with 1 extra
branch/nop and save 3 instructions per VROR which looks like it happens
8*10 times, so 239 fewer instructions.

[1] https://github.com/riscv/riscv-crypto/releases

- Charlie

> +
> +/*
> + * void blake2s_compress_vector(struct blake2s_state *state,
> + *        const u8 *block, size_t nblocks, const u32 inc)
> + *
> + * blake2s_compress_vector is a translation of the AVX512 variant
> + * (arch/x86/blake2s-core.S) to RISC-V V. The implementation requires
> + * VLEN>=256b.
> + *
> + */
> +SYM_FUNC_START(blake2s_compress_vector)
> +	vsetivli	t0, 1, e32, m1, ta, ma
> +	vmv.v.x		v5, a3
> +	vsetivli	t0, 4, e32, m1, ta, ma
> +	vle32.v		v0, (a0)
> +	addi		t0, a0, 0x10
> +	vle32.v		v1, (t0)
> +	addi		t0, t0, 0x10
> +	vle32.v		v4, (t0)
> +	la		t0, IV
> +	vle32.v		v14, (t0)
> +	la		t0, IV+16
> +	vle32.v		v15, (t0)
> +	la		t0, GATHER_DIAG1
> +	vle32.v		v16, (t0)
> +	la		t0, GATHER_DIAG2
> +	vle32.v		v18, (t0)
> +	la		t0, GATHER_DIAG3
> +	vle32.v		v19, (t0)
> +.Lblake2s_compress_vector_mainloop:
> +	vmv.v.v		v10, v0
> +	vmv.v.v		v11, v1
> +	vadd.vv		v4, v5, v4
> +	vmv.v.v		v2, v14
> +	vxor.vv		v3, v15, v4
> +	vsetivli	t0, 8, e32, m1, ta, ma
> +	vle32.v		v6, (a1)
> +	addi		a1, a1, 0x20
> +	vle32.v		v7, (a1)
> +	addi		a1, a1, 0x20
> +	la		t1, SIGMA2
> +	li		t2, 0xa
> +.Lblake2s_compress_vector_roundloop:
> +	vsetivli	t0, 8, e32, m1, ta, ma
> +	vle32.v		v12, (t1)
> +	addi		t1, t1, 0x20
> +	vle32.v		v13, (t1)
> +	addi		t1, t1, 0x20
> +	vsetivli	t0, 16, e32, m2, ta, ma
> +	vrgather.vv	v8, v6, v12
> +	vmv.v.v		v6, v8
> +	vsetivli	t0, 4, e32, m1, ta, ma
> +	vadd.vv		v0, v8, v0
> +	vadd.vv		v0, v1, v0
> +	vxor.vv		v3, v0, v3
> +	VROR		v3 16 v17
> +	vadd.vv		v2, v3, v2
> +	vxor.vv		v1, v2, v1
> +	VROR		v1 12 v17
> +	vsetivli	t0, 8, e32, m1, ta, ma
> +	vslidedown.vi	v8, v8, 4
> +	vsetivli	t0, 4, e32, m1, ta, ma
> +	vadd.vv		v0, v8, v0
> +	vadd.vv		v0, v1, v0
> +	vxor.vv		v3, v0, v3
> +	VROR		v3 8 v17
> +	vadd.vv		v2, v3, v2
> +	vxor.vv		v1, v2, v1
> +	VROR		v1, 7, v17
> +	vmv.v.v		v17, v0
> +	vrgather.vv	v0, v17, v16
> +	vmv.v.v		v17, v3
> +	vrgather.vv	v3, v17, v18
> +	vmv.v.v		v17, v2
> +	vrgather.vv	v2, v17, v19
> +	vadd.vv		v0, v9, v0
> +	vadd.vv		v0, v1, v0
> +	vxor.vv		v3, v0, v3
> +	VROR		v3 16 v17
> +	vadd.vv		v2, v3, v2
> +	vxor.vv		v1, v2, v1
> +	VROR		v1 12 v17
> +	vsetivli	t0, 8, e32, m1, ta, ma
> +	vslidedown.vi	v9, v9, 4
> +	vsetivli	t0, 4, e32, m1, ta, ma
> +	vadd.vv		v0, v9, v0
> +	vadd.vv		v0, v1, v0
> +	vxor.vv		v3, v0, v3
> +	VROR		v3, 8, v17
> +	vadd.vv		v2, v3, v2
> +	vxor.vv		v1, v2, v1
> +	VROR		v1 7 v17
> +	vmv.v.v		v17, v0
> +	vrgather.vv	v0, v17, v19
> +	vmv.v.v		v17, v3
> +	vrgather.vv	v3, v17, v18
> +	vmv.v.v		v17, v2
> +	vrgather.vv	v2, v17, v16
> +	addi		t2, t2, -1
> +	bne		t2, x0, .Lblake2s_compress_vector_roundloop
> +	vxor.vv		v0, v10, v0
> +	vxor.vv		v1, v11, v1
> +	vxor.vv		v0, v2, v0
> +	vxor.vv		v1, v3, v1
> +	addi		a2, a2, -1
> +	bne		a2, x0, .Lblake2s_compress_vector_mainloop
> +	vse32.v		v0, (a0)
> +	addi		a0, a0, 0x10
> +	vse32.v		v1, (a0)
> +	addi		a0, a0, 0x10
> +	vse32.v		v4, (a0)
> +	ret
> +SYM_FUNC_END(blake2s_compress_vector)
> +
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index 650b1b3620d8..c7b23d2c58e4 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -1436,6 +1436,9 @@ endif
>  if PPC
>  source "arch/powerpc/crypto/Kconfig"
>  endif
> +if RISCV
> +source "arch/riscv/crypto/Kconfig"
> +endif
>  if S390
>  source "arch/s390/crypto/Kconfig"
>  endif
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 44eeb5d61ba9..f7fb168a3944 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -94,6 +94,7 @@ config WIREGUARD
>  	select CRYPTO_CHACHA_MIPS if CPU_MIPS32_R2
>  	select CRYPTO_POLY1305_MIPS if MIPS
>  	select CRYPTO_CHACHA_S390 if S390
> +	select CRYPTO_BLAKE2S_RISCV if RISCV && 64BIT
>  	help
>  	  WireGuard is a secure, fast, and easy to use replacement for IPSec
>  	  that uses modern cryptography and clever networking tricks. It's
> -- 
> 2.39.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
