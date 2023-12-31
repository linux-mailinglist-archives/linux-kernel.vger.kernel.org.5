Return-Path: <linux-kernel+bounces-13730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F52820BC2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 16:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C289C1F21B21
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4DE8484;
	Sun, 31 Dec 2023 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kFuiS5cC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55456124
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-35fef061484so27645775ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 07:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704036473; x=1704641273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9j/PDsQCKNxJvXhPSwnRjZEPWOEDy7gzBo8k7L9PKtc=;
        b=kFuiS5cCZCHgDecpy7HmOg6lPDfo3qFK7VIe2asrczaDt2YImG84woemSZ3loGy2u4
         HTl2c8Lsc6ojC5sjCP9ha+LureOxEiLOGCTZz9vq96usJJqPOAP8EfFKuKfw2FpZ5Y85
         kT4NSUQIs3nUSoFb0OPvcre01sqVViRYk+2UvvOSSf/Wy0LoeJCQU/LBNTUjaj1aVopZ
         v2FL5LGJsgAhqHN8goEDD569AS25/vU3+B3buW0oSdsiHGbzSbAeniKmiEUcFtNUCXKn
         hA1TH5vJHi740cCmIHJTjZdvsl/t17vrq5T6IdqJyeRLCvN7ZWNQdmW9091hWhtj0lCr
         7VPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704036473; x=1704641273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9j/PDsQCKNxJvXhPSwnRjZEPWOEDy7gzBo8k7L9PKtc=;
        b=SciBm33UejUMLS2iRCsMBaL1KbqwdhYEwnM2pK7cQ9d/y+r22RcVs2XoYRGTn3zYF9
         D9SuMHPulwoxtWKyYcny8VfL9tuFIPbHHD4Ol3t509/RzCJ1UCuTW7Agoe+YXULFTtie
         0GjsnOERSmhxENpaJsjMZn5YUmpjKz8syqlycU1u0bXbmASAps7wWp0qKVdDff8qwxmc
         7K0qSGM9ZwO+NhmN0Wqdtld09t+hKAWljD3VtPK+l6zMTo3a7hVcjGjoKX0kHbS6gGez
         0W0NzGVdyNiU98MFIC+VJRwX5DNa+bMvZmNvMjCQy5kiU098kFVLsp3uuZqcYqLnNLRh
         DhhA==
X-Gm-Message-State: AOJu0Yywchihr6NuWWHU6+efTe9wIsSbs8tpTprn04BsZrg+XnkSUOXN
	ZFsdHcAPqg/hWmo8y08iveVKt4XPW3YTuw==
X-Google-Smtp-Source: AGHT+IG8+YjoIiWGe/fJn9ezufjBAu+c+cQL9Jt2yHbbsR6y5VuXGEf72rzp1+nF0qsl5amU3ifDiA==
X-Received: by 2002:a05:6e02:214b:b0:360:29f:b7a6 with SMTP id d11-20020a056e02214b00b00360029fb7a6mr14781805ilv.18.1704036473641;
        Sun, 31 Dec 2023 07:27:53 -0800 (PST)
Received: from localhost.localdomain ([49.216.222.63])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902e54400b001cc3c521affsm18624430plf.300.2023.12.31.07.27.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Dec 2023 07:27:52 -0800 (PST)
From: Jerry Shih <jerry.shih@sifive.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	conor.dooley@microchip.com,
	ebiggers@kernel.org,
	ardb@kernel.org
Cc: heiko@sntech.de,
	phoebe.chen@sifive.com,
	hongrong.hsu@sifive.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v4 00/11] RISC-V: provide some accelerated cryptography implementations using vector extensions
Date: Sun, 31 Dec 2023 23:27:32 +0800
Message-Id: <20231231152743.6304-1-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series provides cryptographic implementations using the vector crypto
extensions[1] including:
1. AES cipher
2. AES with CBC/CTR/ECB/XTS block modes
3. ChaCha20 stream cipher
4. GHASH for GCM
5. SHA-224/256 and SHA-384/512 hash
6. SM3 hash
7. SM4 cipher

This patch set is based on Heiko Stuebner's work at:
Link: https://lore.kernel.org/all/20230711153743.1970625-1-heiko@sntech.de/

The implementations reuse the perl-asm scripts from OpenSSL[2] with some
changes adapting for the kernel crypto framework.
The perl-asm scripts generate the RISC-V RVV 1.0 and the vector crypto 1.0
instructions into `.S` files.

All changes pass the kernel run-time crypto self tests and the extra tests
with vector-crypto-enabled qemu.
Link: https://lists.gnu.org/archive/html/qemu-devel/2023-11/msg00281.html

This series depend on:
1. kernel riscv/for-next(6.7-rc1)
Link: https://github.com/linux-riscv/linux-riscv/commit/f352a28cc2fb4ee8d08c6a6362c9a861fcc84236
2. support kernel-mode vector
Link: https://lore.kernel.org/all/20231229143627.22898-1-andy.chiu@sifive.com/

Here is a branch on github applying with all dependent patches:
Link: https://github.com/JerryShih/linux/tree/dev/jerrys/vector-crypto-upstream-v4

And here is the previous v3 link:
Link: https://lore.kernel.org/all/20231205092801.1335-1-jerry.shih@sifive.com/

[1]
Link: https://github.com/riscv/riscv-crypto/blob/56ed7952d13eb5bdff92e2b522404668952f416d/doc/vector/riscv-crypto-spec-vector.adoc
[2]
Link: https://github.com/openssl/openssl/pull/21923

Updated patches (on current order): 4, 5, 6, 7, 8, 9, 10, 11
New patch: 3
Unchanged patch: 1, 2
Deleted patch: 3, 5 in v3

Changelog v4:
 - Check the assembler capability for using the vector crypto asm
   mnemonics.
 - Use asm mnemonics for the instructions in vector crypto 1.0 extension.
 - Revert the usage of simd skcipher interface for AES-CBC/CTR/ECB/XTS and
   Chacha20.

Changelog v3:
 - Use asm mnemonics for the instructions in RVV 1.0 extension.
 - Use `SYM_TYPED_FUNC_START` for indirect-call asm symbols.
 - Update aes xts_crypt() implementation.
 - Update crypto function names with the prefix/suffix of `riscv64` or the
   specific extensions to avoid the collision with functions in `crypto/`
   or `lib/crypto/`.

Changelog v2:
 - Do not turn on the RISC-V accelerated crypto kconfig options by
   default.
 - Assume RISC-V vector extension could support unaligned access in
   kernel.
 - Turn to use simd skcipher interface for AES-CBC/CTR/ECB/XTS and
   Chacha20.
 - Rename crypto file and driver names to make the most important
   extension at first place.

Heiko Stuebner (2):
  RISC-V: add helper function to read the vector VLEN
  RISC-V: hook new crypto subdir into build-system

Jerry Shih (9):
  RISC-V: add TOOLCHAIN_HAS_VECTOR_CRYPTO in kconfig
  RISC-V: crypto: add Zvkned accelerated AES implementation
  RISC-V: crypto: add accelerated AES-CBC/CTR/ECB/XTS implementations
  RISC-V: crypto: add Zvkg accelerated GCM GHASH implementation
  RISC-V: crypto: add Zvknha/b accelerated SHA224/256 implementations
  RISC-V: crypto: add Zvknhb accelerated SHA384/512 implementations
  RISC-V: crypto: add Zvksed accelerated SM4 implementation
  RISC-V: crypto: add Zvksh accelerated SM3 implementation
  RISC-V: crypto: add Zvkb accelerated ChaCha20 implementation

 arch/riscv/Kbuild                             |    1 +
 arch/riscv/Kconfig                            |    8 +
 arch/riscv/crypto/Kconfig                     |  110 ++
 arch/riscv/crypto/Makefile                    |   68 +
 .../crypto/aes-riscv64-block-mode-glue.c      |  459 +++++++
 arch/riscv/crypto/aes-riscv64-glue.c          |  137 ++
 arch/riscv/crypto/aes-riscv64-glue.h          |   18 +
 .../crypto/aes-riscv64-zvkned-zvbb-zvkg.pl    |  949 +++++++++++++
 arch/riscv/crypto/aes-riscv64-zvkned-zvkb.pl  |  415 ++++++
 arch/riscv/crypto/aes-riscv64-zvkned.pl       | 1199 +++++++++++++++++
 arch/riscv/crypto/chacha-riscv64-glue.c       |  109 ++
 arch/riscv/crypto/chacha-riscv64-zvkb.pl      |  321 +++++
 arch/riscv/crypto/ghash-riscv64-glue.c        |  175 +++
 arch/riscv/crypto/ghash-riscv64-zvkg.pl       |  100 ++
 arch/riscv/crypto/sha256-riscv64-glue.c       |  145 ++
 .../sha256-riscv64-zvknha_or_zvknhb-zvkb.pl   |  317 +++++
 arch/riscv/crypto/sha512-riscv64-glue.c       |  139 ++
 .../crypto/sha512-riscv64-zvknhb-zvkb.pl      |  265 ++++
 arch/riscv/crypto/sm3-riscv64-glue.c          |  124 ++
 arch/riscv/crypto/sm3-riscv64-zvksh.pl        |  227 ++++
 arch/riscv/crypto/sm4-riscv64-glue.c          |  121 ++
 arch/riscv/crypto/sm4-riscv64-zvksed.pl       |  268 ++++
 arch/riscv/include/asm/vector.h               |   11 +
 crypto/Kconfig                                |    3 +
 24 files changed, 5689 insertions(+)
 create mode 100644 arch/riscv/crypto/Kconfig
 create mode 100644 arch/riscv/crypto/Makefile
 create mode 100644 arch/riscv/crypto/aes-riscv64-block-mode-glue.c
 create mode 100644 arch/riscv/crypto/aes-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/aes-riscv64-glue.h
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned-zvbb-zvkg.pl
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned-zvkb.pl
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned.pl
 create mode 100644 arch/riscv/crypto/chacha-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/chacha-riscv64-zvkb.pl
 create mode 100644 arch/riscv/crypto/ghash-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zvkg.pl
 create mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.pl
 create mode 100644 arch/riscv/crypto/sha512-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha512-riscv64-zvknhb-zvkb.pl
 create mode 100644 arch/riscv/crypto/sm3-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sm3-riscv64-zvksh.pl
 create mode 100644 arch/riscv/crypto/sm4-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sm4-riscv64-zvksed.pl

--
2.28.0


