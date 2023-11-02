Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FED07DECFE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 07:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjKBG4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 02:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKBG4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 02:56:17 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8EB123;
        Wed,  1 Nov 2023 23:56:10 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qyRcU-00DTpj-VO; Thu, 02 Nov 2023 14:56:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 02 Nov 2023 14:56:05 +0800
Date:   Thu, 2 Nov 2023 14:56:05 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Update for 6.7
Message-ID: <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
References: <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.7-p1 

for you to fetch changes up to a312e07a65fb598ed239b940434392721385c722:

  crypto: adiantum - flush destination page before unmapping (2023-11-01 12:58:42 +0800)

----------------------------------------------------------------
This update includes the following changes:

API:

- Add virtual-address based lskcipher interface.
- Optimise ahash/shash performance in light of costly indirect calls.
- Remove ahash alignmask attribute.

Algorithms:

- Improve AES/XTS performance of 6-way unrolling for ppc.
- Remove some uses of obsolete algorithms (md4, md5, sha1).
- Add FIPS 202 SHA-3 support in pkcs1pad.
- Add fast path for single-page messages in adiantum.
- Remove zlib-deflate.

Drivers:

- Add support for S4 in meson RNG driver.
- Add STM32MP13x support in stm32.
- Add hwrng interface support in qcom-rng.
- Add support for deflate algorithm in hisilicon/zip.
----------------------------------------------------------------

Adam Guerin (1):
      crypto: qat - enable dc chaining service

Alexey Romanov (2):
      hwrng: meson - add support for S4
      dt-bindings: rng: meson: add meson-rng-s4 compatible

Andrei Coardos (5):
      hwrng: bcm2835 - removed call to platform_set_drvdata()
      hwrng: hisi - removed unneeded call to platform_set_drvdata()
      hwrng: mpfs - removed unneeded call to platform_set_drvdata()
      hwrng: xgene - removed unneeded call to platform_set_drvdata()
      hwrng: xiphera - removed unnneded platform_set_drvdata()

André Apitzsch (1):
      crypto: qcom-rng - Add missing dependency on hw_random

Ashish Kalra (1):
      MAINTAINERS: update AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - SEV SUPPORT

Bartosz Golaszewski (1):
      dt-bindings: crypto: ice: document the sa8775p inline crypto engine

Bo Liu (1):
      crypto: aesni - Fix double word in comments

Chang S. Bae (3):
      crypto: x86/aesni - Refactor the common address alignment code
      crypto: x86/aesni - Correct the data type in struct aesni_xts_ctx
      crypto: x86/aesni - Perform address alignment early for XTS mode

Christophe JAILLET (1):
      crypto: hisilicon/hpre - Fix a erroneous check after snprintf()

Ciunas Bennett (3):
      crypto: qat - add rate limiting sysfs interface
      crypto: qat - add rp2svc sysfs attribute
      crypto: qat - add num_rps sysfs attribute

Damian Muszynski (4):
      units: Add BYTES_PER_*BIT
      crypto: qat - add bits.h to icp_qat_hw.h
      crypto: qat - add retrieval of fw capabilities
      crypto: qat - add rate limiting feature to qat_4xxx

Danny Tsen (1):
      crypto: vmx - Improved AES/XTS performance of 6-way unrolling for ppc

Dimitri John Ledkov (11):
      crypto: pkcs7 - remove md4 md5 x.509 support
      crypto: pkcs7 - remove sha1 support
      crypto: mscode_parser - remove sha224 authenticode support
      module: Do not offer sha224 for built-in module signing
      certs: Limit MODULE_SIG_KEY_TYPE_ECDSA to SHA384 or SHA512
      x509: Add OIDs for FIPS 202 SHA-3 hash and signatures
      crypto: FIPS 202 SHA-3 register in hash info for IMA
      crypto: rsa-pkcs1pad - Add FIPS 202 SHA-3 support
      crypto: asymmetric_keys - allow FIPS 202 SHA-3 signatures
      module: enable automatic module signing with FIPS 202 SHA-3
      Documentation/module-signing.txt: bring up to date

Eric Biggers (65):
      crypto: xts - use 'spawn' for underlying single-block cipher
      crypto: shash - optimize the default digest and finup
      crypto: shash - fold shash_digest_unaligned() into crypto_shash_digest()
      crypto: arm64/sha2-ce - implement ->digest for sha256
      crypto: x86/sha256 - implement ->digest for sha256
      crypto: adiantum - add fast path for single-page messages
      crypto: arm/nhpoly1305 - implement ->digest
      crypto: arm64/nhpoly1305 - implement ->digest
      crypto: x86/nhpoly1305 - implement ->digest
      crypto: arm64/sha1-ce - clean up backwards function names
      crypto: arm64/sha2-ce - clean up backwards function names
      crypto: arm64/sha512-ce - clean up backwards function names
      crypto: arm64/sha256 - clean up backwards function names
      crypto: arm64/sha512 - clean up backwards function names
      crypto: skcipher - fix weak key check for lskciphers
      crypto: shash - eliminate indirect call for default import and export
      crypto: sparc/crc32c - stop using the shash alignmask
      crypto: stm32 - remove unnecessary alignmask
      crypto: xilinx/zynqmp-sha - remove unnecessary alignmask
      crypto: mips/crc32 - remove redundant setting of alignmask to 0
      crypto: loongarch/crc32 - remove redundant setting of alignmask to 0
      crypto: cbcmac - remove unnecessary alignment logic
      crypto: cmac - remove unnecessary alignment logic
      crypto: hmac - remove unnecessary alignment logic
      crypto: vmac - don't set alignmask
      crypto: xcbc - remove unnecessary alignment logic
      crypto: shash - remove support for nonzero alignmask
      libceph: stop checking crypto_shash_alignmask
      crypto: drbg - stop checking crypto_shash_alignmask
      crypto: testmgr - stop checking crypto_shash_alignmask
      crypto: adiantum - stop using alignmask of shash_alg
      crypto: hctr2 - stop using alignmask of shash_alg
      crypto: shash - remove crypto_shash_alignmask
      crypto: shash - remove crypto_shash_ctx_aligned()
      crypto: sun4i-ss - remove unnecessary alignmask for ahashes
      crypto: sun8i-ce - remove unnecessary alignmask for ahashes
      crypto: sun8i-ss - remove unnecessary alignmask for ahashes
      crypto: atmel - remove unnecessary alignmask for ahashes
      crypto: artpec6 - stop setting alignmask for ahashes
      crypto: mxs-dcp - remove unnecessary alignmask for ahashes
      crypto: s5p-sss - remove unnecessary alignmask for ahashes
      crypto: talitos - remove unnecessary alignmask for ahashes
      crypto: omap-sham - stop setting alignmask for ahashes
      crypto: rockchip - remove unnecessary alignmask for ahashes
      crypto: starfive - remove unnecessary alignmask for ahashes
      crypto: stm32 - remove unnecessary alignmask for ahashes
      crypto: ahash - remove support for nonzero alignmask
      crypto: authenc - stop using alignmask of ahash
      crypto: authencesn - stop using alignmask of ahash
      crypto: testmgr - stop checking crypto_ahash_alignmask
      net: ipv4: stop checking crypto_ahash_alignmask
      net: ipv6: stop checking crypto_ahash_alignmask
      crypto: ccm - stop using alignmask of ahash
      crypto: chacha20poly1305 - stop using alignmask of ahash
      crypto: gcm - stop using alignmask of ahash
      crypto: ahash - remove crypto_ahash_alignmask
      crypto: ahash - remove struct ahash_request_priv
      crypto: ahash - improve file comment
      crypto: chelsio - stop using crypto_ahash::init
      crypto: talitos - stop using crypto_ahash::init
      crypto: hash - move "ahash wrapping shash" functions to ahash.c
      crypto: ahash - check for shash type instead of not ahash type
      crypto: ahash - optimize performance when wrapping shash
      crypto: testmgr - move pkcs1pad(rsa,sha3-*) to correct place
      crypto: adiantum - flush destination page before unmapping

Fabio Estevam (3):
      dt-bindings: crypto: fsl-imx-sahara: Shorten the title
      dt-bindings: crypto: fsl-imx-sahara: Document the clocks
      dt-bindings: crypto: fsl-imx-sahara: Fix the number of irqs

Gatien Chevallier (8):
      dt-bindings: rng: introduce new compatible for STM32MP13x
      hwrng: stm32 - use devm_platform_get_and_ioremap_resource() API
      hwrng: stm32 - implement STM32MP13x support
      hwrng: stm32 - implement error concealment
      hwrng: stm32 - rework error handling in stm32_rng_read()
      hwrng: stm32 - restrain RNG noise source clock
      hwrng: stm32 - support RNG configuration locking mechanism
      hwrng: stm32 - rework power management sequences

Gaurav Jain (2):
      crypto: caam/qi2 - fix Chacha20 + Poly1305 self test failure
      crypto: caam/jr - fix Chacha20 + Poly1305 self test failure

Giovanni Cabiddu (15):
      Documentation: ABI: debugfs-driver-qat: fix fw_counters path
      crypto: qat - fix state machines cleanup paths
      crypto: qat - do not shadow error code
      crypto: qat - ignore subsequent state up commands
      crypto: qat - fix unregistration of crypto algorithms
      crypto: qat - fix unregistration of compression algorithms
      crypto: qat - consolidate services structure
      crypto: qat - increase size of buffers
      crypto: qat - add namespace to driver
      crypto: qat - refactor fw config related functions
      crypto: qat - use masks for AE groups
      crypto: qat - fix ring to service map for QAT GEN4
      crypto: qat - move admin api
      crypto: qat - move adf_cfg_services
      crypto: qat - fix deadlock in backlog processing

Herbert Xu (45):
      wireguard: do not include crypto/algapi.h
      KEYS: Include linux/errno.h in linux/verification.h
      hwrng: octeon - Fix warnings on 32-bit platforms
      fscrypt: Do not include crypto/algapi.h
      ubifs: Do not include crypto/algapi.h
      Bluetooth: Do not include crypto/algapi.h
      ah: Do not include crypto/algapi.h
      mptcp: Do not include crypto/algapi.h
      SUNRPC: Do not include crypto/algapi.h
      evm: Do not include crypto/algapi.h
      KEYS: encrypted: Do not include crypto/algapi.h
      chelsio: Do not include crypto/algapi.h
      crypto: aead - Add crypto_has_aead
      ipsec: Stop using crypto_has_alg
      crypto: hash - Hide CRYPTO_ALG_TYPE_AHASH_MASK
      crypto: skcipher - Add lskcipher
      crypto: lskcipher - Add compatibility wrapper around ECB
      crypto: testmgr - Add support for lskcipher algorithms
      crypto: ecb - Convert from skcipher to lskcipher
      crypto: cbc - Convert from skcipher to lskcipher
      ipsec: Select CRYPTO_AEAD
      crypto: qat - Remove zlib-deflate
      crypto: deflate - Remove zlib-deflate
      crypto: testmgr - Remove zlib-deflate
      crypto: skcipher - Add dependency on ecb
      crypto: arc4 - Convert from skcipher to lskcipher
      crypto: skcipher - Add crypto_spawn_skcipher_alg_common
      crypto: essiv - Handle lskcipher spawns
      crypto: cryptd - Only access common skcipher fields on spawn
      crypto: adiantum - Only access common skcipher fields on spawn
      crypto: authenc - Only access common skcipher fields on spawn
      crypto: authencesn - Only access common skcipher fields on spawn
      crypto: ccm - Only access common skcipher fields on spawn
      crypto: chacha20poly1305 - Only access common skcipher fields on spawn
      crypto: ctr - Only access common skcipher fields on spawn
      crypto: cts - Only access common skcipher fields on spawn
      crypto: gcm - Only access common skcipher fields on spawn
      crypto: hctr2 - Only access common skcipher fields on spawn
      crypto: lrw - Only access common skcipher fields on spawn
      crypto: xts - Only access common skcipher fields on spawn
      crypto: skcipher - Remove obsolete skcipher_alg helpers
      crypto: lskcipher - Return EINVAL when ecb_name fails sanity checks
      crypto: hifn_795x - Silence gcc format-truncation false positive warnings
      certs: Break circular dependency when selftest is modular
      crypto: rsa - Add module alias for pkcs1pad

Jinjie Ruan (1):
      crypto: qat - Use list_for_each_entry() helper

John Allen (1):
      crypto: ccp - Dump SEV command buffer registers on SEV command error

Jonas Gorski (1):
      hwrng: geode - fix accessing registers

Justin Stitt (2):
      crypto: cavium/nitrox - refactor deprecated strncpy
      crypto: qat - refactor deprecated strncpy

Kees Cook (1):
      crypto: qat - Annotate struct adf_fw_counters with __counted_by

Li zeming (1):
      crypto: api - Remove unnecessary NULL initialisation

Longfang Liu (3):
      crypto: hisilicon/qm - fix PF queue parameter issue
      crypto: hisilicon/qm - fix EQ/AEQ interrupt issue
      crypto: hisilicon/qm - prevent soft lockup in receive loop

Lu Jialin (1):
      crypto: pcrypt - Fix hungtask for PADATA_RESET

Lucas Segarra Fernandez (3):
      crypto: qat - refactor included headers
      crypto: qat - add pm_status debugfs file
      crypto: qat - add cnv_errors debugfs file

Lukas Wunner (2):
      X.509: Add missing IMPLICIT annotations to AKID ASN.1 module
      treewide: Add SPDX identifier to IETF ASN.1 modules

Mario Limonciello (9):
      crypto: ccp - Get a free page to use while fetching initial nonce
      crypto: ccp - Fix ioctl unit tests
      crypto: ccp - Fix DBC sample application error handling
      crypto: ccp - Fix sample application signature passing
      crypto: ccp - Fix some unfused tests
      crypto: ccp - Add support for extended PSP mailbox commands
      crypto: ccp - Add a communication path abstraction for DBC
      crypto: ccp - Add a macro to check capabilities register
      crypto: ccp - Add support for DBC over PSP mailbox

Martin Kaiser (7):
      hwrng: ks-sa - access private data via struct hwrng
      hwrng: ks-sa - remove dev from struct ks_sa_rng
      hwrng: ks-sa - use dev_err_probe
      hwrng: nomadik - add MODULE_DESCRIPTION
      hwrng: st - add MODULE_DESCRIPTION
      hwrng: imx-rngc - reasonable timeout for selftest
      hwrng: imx-rngc - reasonable timeout for initial seed

Neil Armstrong (2):
      dt-bindings: crypto: qcom,prng: document that RNG on SM8450 is a TRNG
      dt-bindings: crypto: qcom,prng: document SM8550

Om Prakash Singh (2):
      crypto: qcom-rng - Add hw_random interface support
      dt-bindings: crypto: qcom,prng: document SA8775P and SC7280

Randy Dunlap (2):
      crypto: akcipher - fix kernel-doc typos
      crypto: sig - fix kernel-doc typo

Rob Herring (2):
      crypto: aspeed-hace - Use device_get_match_data()
      hwrng: n2 - Use device_get_match_data()

Roxana Nicolescu (1):
      crypto: x86/sha - load modules based on CPU features

Shashank Gupta (9):
      crypto: qat - add infrastructure for error reporting
      crypto: qat - add reporting of correctable errors for QAT GEN4
      crypto: qat - add reporting of errors from ERRSOU1 for QAT GEN4
      crypto: qat - add handling of errors from ERRSOU2 for QAT GEN4
      crypto: qat - add handling of compression related errors for QAT GEN4
      crypto: qat - add adf_get_aram_base() helper function
      crypto: qat - add handling of errors from ERRSOU3 for QAT GEN4
      crypto: qat - add error counters
      crypto: qat - count QAT GEN4 errors

Stefan Wahren (1):
      hwrng: bcm2835 - Fix hwrng throughput regression

Stephan Müller (5):
      crypto: jitter - add RCT/APT support for different OSRs
      crypto: jitter - Allow configuration of memory size
      crypto: jitter - Allow configuration of oversampling rate
      crypto: jitter - reuse allocated entropy collector
      crypto: jitter - use permanent health test storage

Svyatoslav Pankratov (1):
      crypto: qat - fix double free during reset

Tom Lendacky (1):
      crypto: ccp - Move direct access to some PSP registers out of TEE

Uwe Kleine-König (44):
      crypto: keembay - Don't pass errors to the caller in .remove()
      crypto: engine - Make crypto_engine_exit() return void
      crypto: sun4i-ss - Convert to platform remove callback returning void
      crypto: sun8i-ce - Convert to platform remove callback returning void
      crypto: sun8i-ss - Convert to platform remove callback returning void
      crypto: amcc/crypto4xx - Convert to platform remove callback returning void
      crypto: amlogic-gxl-core - Convert to platform remove callback returning void
      crypto: aspeed-acry - Convert to platform remove callback returning void
      crypto: aspeed-hace - Convert to platform remove callback returning void
      crypto: atmel-aes - Convert to platform remove callback returning void
      crypto: atmel-sha - Convert to platform remove callback returning void
      crypto: atmel-tdes - Convert to platform remove callback returning void
      crypto: axis/artpec6 - Convert to platform remove callback returning void
      crypto: bcm/cipher - Convert to platform remove callback returning void
      crypto: caam/jr - Convert to platform remove callback returning void
      crypto: ccp/sp - Convert to platform remove callback returning void
      crypto: ccree/cc - Convert to platform remove callback returning void
      crypto: exynos-rng - Convert to platform remove callback returning void
      crypto: gemini/sl3516-ce - Convert to platform remove callback returning void
      crypto: hisilicon/sec - Convert to platform remove callback returning void
      crypto: hisilicon/trng - Convert to platform remove callback returning void
      crypto: img-hash - Convert to platform remove callback returning void
      crypto: inside-secure/safexcel - Convert to platform remove callback returning void
      crypto: intel/ixp4xx-crypto - Convert to platform remove callback returning void
      crypto: intel/keembay-ocs-aes - Convert to platform remove callback returning void
      crypto: intel/keembay-ocs-ecc - Convert to platform remove callback returning void
      crypto: intel/keembay-ocs-hcu - Convert to platform remove callback returning void
      crypto: marvell/cesa - Convert to platform remove callback returning void
      crypto: mxs-dcp - Convert to platform remove callback returning void
      crypto: n2_core - Convert to platform remove callback returning void
      crypto: omap-aes - Convert to platform remove callback returning void
      crypto: omap-des - Convert to platform remove callback returning void
      crypto: omap-sham - Convert to platform remove callback returning void
      crypto: qce - Convert to platform remove callback returning void
      crypto: qcom-rng - Convert to platform remove callback returning void
      crypto: rockchip/rk3288 - Convert to platform remove callback returning void
      crypto: s5p-sss - Convert to platform remove callback returning void
      crypto: sa2ul - Convert to platform remove callback returning void
      crypto: sahara - Convert to platform remove callback returning void
      crypto: stm32/crc32 - Convert to platform remove callback returning void
      crypto: stm32/cryp - Convert to platform remove callback returning void
      crypto: talitos - Convert to platform remove callback returning void
      crypto: xilinx/zynqmp-aes-gcm - Convert to platform remove callback returning void
      crypto: xilinx/zynqmp-sha - Convert to platform remove callback returning void

WangJinchao (1):
      padata: Fix refcnt handling in padata_free_shell()

Weili Qian (3):
      crypto: hisilicon/qm - fix the type value of aeq
      crypto: hisilicon/qm - check function qp num before alg register
      crypto: hisilicon/qm - alloc buffer to set and get xqc

Wenkai Lin (1):
      crypto: hisilicon/sec - fix for sgl unmmap problem

Yang Shen (2):
      crypto: hisilicon/zip - support deflate algorithm
      crypto: hisilicon/zip - remove zlib and gzip

zhenwei pi (1):
      crypto: virtio - handle config changed by work queue

 Documentation/ABI/testing/debugfs-driver-qat       |   24 +-
 Documentation/ABI/testing/sysfs-driver-qat         |   48 +
 Documentation/ABI/testing/sysfs-driver-qat_ras     |   41 +
 Documentation/ABI/testing/sysfs-driver-qat_rl      |  226 +++
 Documentation/admin-guide/module-signing.rst       |   17 +-
 Documentation/crypto/devel-algos.rst               |    4 +-
 .../devicetree/bindings/crypto/fsl-imx-sahara.yaml |   43 +-
 .../bindings/crypto/qcom,inline-crypto-engine.yaml |    1 +
 .../devicetree/bindings/crypto/qcom,prng.yaml      |   28 +-
 .../devicetree/bindings/rng/amlogic,meson-rng.yaml |    1 +
 .../devicetree/bindings/rng/st,stm32-rng.yaml      |   20 +-
 MAINTAINERS                                        |    2 +-
 arch/arm/crypto/nhpoly1305-neon-glue.c             |    9 +
 arch/arm64/crypto/nhpoly1305-neon-glue.c           |    9 +
 arch/arm64/crypto/sha1-ce-core.S                   |    8 +-
 arch/arm64/crypto/sha1-ce-glue.c                   |   21 +-
 arch/arm64/crypto/sha2-ce-core.S                   |    8 +-
 arch/arm64/crypto/sha2-ce-glue.c                   |   39 +-
 arch/arm64/crypto/sha256-glue.c                    |   26 +-
 arch/arm64/crypto/sha512-ce-core.S                 |    8 +-
 arch/arm64/crypto/sha512-ce-glue.c                 |   26 +-
 arch/arm64/crypto/sha512-glue.c                    |   12 +-
 arch/loongarch/crypto/crc32-loongarch.c            |    2 -
 arch/mips/crypto/crc32-mips.c                      |    2 -
 arch/sparc/crypto/crc32c_glue.c                    |   43 +-
 arch/x86/crypto/aesni-intel_asm.S                  |    4 +-
 arch/x86/crypto/aesni-intel_avx-x86_64.S           |    4 +-
 arch/x86/crypto/aesni-intel_glue.c                 |   52 +-
 arch/x86/crypto/nhpoly1305-avx2-glue.c             |    9 +
 arch/x86/crypto/nhpoly1305-sse2-glue.c             |    9 +
 arch/x86/crypto/sha1_ssse3_glue.c                  |   12 +
 arch/x86/crypto/sha256_ssse3_glue.c                |   44 +
 certs/Kconfig                                      |    6 +-
 crypto/Kconfig                                     |   63 +-
 crypto/Makefile                                    |    6 +-
 crypto/adiantum.c                                  |   80 +-
 crypto/aead.c                                      |    6 +
 crypto/ahash.c                                     |  406 +++--
 crypto/api.c                                       |    2 +-
 crypto/arc4.c                                      |   60 +-
 crypto/asymmetric_keys/Kconfig                     |    3 +-
 crypto/asymmetric_keys/Makefile                    |    3 +-
 crypto/asymmetric_keys/mscode_parser.c             |   19 +-
 crypto/asymmetric_keys/pkcs7.asn1                  |    7 +
 crypto/asymmetric_keys/pkcs7_parser.c              |   22 +-
 crypto/asymmetric_keys/pkcs8.asn1                  |    6 +
 crypto/asymmetric_keys/public_key.c                |    8 +-
 crypto/asymmetric_keys/selftest.c                  |   15 +-
 crypto/asymmetric_keys/signature.c                 |    2 +-
 crypto/asymmetric_keys/x509.asn1                   |    7 +
 crypto/asymmetric_keys/x509_akid.asn1              |   29 +-
 crypto/asymmetric_keys/x509_cert_parser.c          |   36 +-
 crypto/asymmetric_keys/x509_parser.h               |    9 -
 crypto/asymmetric_keys/x509_public_key.c           |    8 +-
 crypto/authenc.c                                   |   20 +-
 crypto/authencesn.c                                |   28 +-
 crypto/cbc.c                                       |  159 +-
 crypto/ccm.c                                       |   29 +-
 crypto/chacha20poly1305.c                          |   11 +-
 crypto/cmac.c                                      |   39 +-
 crypto/cryptd.c                                    |   14 +-
 crypto/crypto_engine.c                             |    8 +-
 crypto/ctr.c                                       |   14 +-
 crypto/cts.c                                       |   12 +-
 crypto/deflate.c                                   |   61 +-
 crypto/drbg.c                                      |    2 +-
 crypto/ecb.c                                       |  206 ++-
 crypto/essiv.c                                     |   20 +-
 crypto/gcm.c                                       |   12 +-
 crypto/hash.h                                      |   14 +-
 crypto/hash_info.c                                 |    6 +
 crypto/hctr2.c                                     |   11 +-
 crypto/hmac.c                                      |   56 +-
 crypto/jitterentropy-kcapi.c                       |   17 +-
 crypto/jitterentropy.c                             |  342 +++--
 crypto/jitterentropy.h                             |    5 +-
 crypto/lrw.c                                       |   12 +-
 crypto/lskcipher.c                                 |  634 ++++++++
 crypto/pcrypt.c                                    |    4 +
 crypto/rsa-pkcs1pad.c                              |   27 +-
 crypto/rsaprivkey.asn1                             |    7 +
 crypto/rsapubkey.asn1                              |    7 +
 crypto/shash.c                                     |  387 +----
 crypto/skcipher.c                                  |   81 +-
 crypto/skcipher.h                                  |   28 +
 crypto/testmgr.c                                   |   57 +-
 crypto/testmgr.h                                   |  155 --
 crypto/vmac.c                                      |    1 -
 crypto/xcbc.c                                      |   32 +-
 crypto/xts.c                                       |   33 +-
 drivers/char/hw_random/bcm2835-rng.c               |    4 +-
 drivers/char/hw_random/core.c                      |    6 +
 drivers/char/hw_random/geode-rng.c                 |    6 +-
 drivers/char/hw_random/hisi-rng.c                  |    2 -
 drivers/char/hw_random/imx-rngc.c                  |   10 +-
 drivers/char/hw_random/ks-sa-rng.c                 |   26 +-
 drivers/char/hw_random/meson-rng.c                 |   80 +-
 drivers/char/hw_random/mpfs-rng.c                  |    2 -
 drivers/char/hw_random/n2-drv.c                    |   10 +-
 drivers/char/hw_random/nomadik-rng.c               |    1 +
 drivers/char/hw_random/octeon-rng.c                |    6 +-
 drivers/char/hw_random/st-rng.c                    |    1 +
 drivers/char/hw_random/stm32-rng.c                 |  519 +++++--
 drivers/char/hw_random/xgene-rng.c                 |    1 -
 drivers/char/hw_random/xiphera-trng.c              |    2 -
 drivers/crypto/Kconfig                             |    1 +
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c  |    7 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c  |   11 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c  |   11 +-
 drivers/crypto/amcc/crypto4xx_core.c               |    6 +-
 drivers/crypto/amlogic/amlogic-gxl-core.c          |    5 +-
 drivers/crypto/aspeed/aspeed-acry.c                |    6 +-
 drivers/crypto/aspeed/aspeed-hace.c                |   16 +-
 drivers/crypto/atmel-aes.c                         |    6 +-
 drivers/crypto/atmel-sha.c                         |    8 +-
 drivers/crypto/atmel-tdes.c                        |    6 +-
 drivers/crypto/axis/artpec6_crypto.c               |    8 +-
 drivers/crypto/bcm/cipher.c                        |    5 +-
 drivers/crypto/caam/caamalg.c                      |    3 +-
 drivers/crypto/caam/caamalg_qi2.c                  |    3 +-
 drivers/crypto/caam/jr.c                           |   22 +-
 drivers/crypto/cavium/nitrox/nitrox_hal.c          |    2 +-
 drivers/crypto/ccp/dbc.c                           |   74 +-
 drivers/crypto/ccp/dbc.h                           |   29 +-
 drivers/crypto/ccp/psp-dev.c                       |  122 +-
 drivers/crypto/ccp/psp-dev.h                       |   55 +
 drivers/crypto/ccp/sev-dev.c                       |   14 +
 drivers/crypto/ccp/sp-dev.h                        |    4 +
 drivers/crypto/ccp/sp-pci.c                        |   22 +-
 drivers/crypto/ccp/sp-platform.c                   |    6 +-
 drivers/crypto/ccp/tee-dev.c                       |   48 +-
 drivers/crypto/ccp/tee-dev.h                       |   15 +-
 drivers/crypto/ccree/cc_driver.c                   |    6 +-
 drivers/crypto/chelsio/chcr_algo.c                 |    9 +-
 drivers/crypto/exynos-rng.c                        |    6 +-
 drivers/crypto/gemini/sl3516-ce-core.c             |    6 +-
 drivers/crypto/hifn_795x.c                         |   11 +-
 drivers/crypto/hisilicon/debugfs.c                 |   79 +-
 drivers/crypto/hisilicon/hpre/hpre_crypto.c        |   25 +-
 drivers/crypto/hisilicon/hpre/hpre_main.c          |   21 +-
 drivers/crypto/hisilicon/qm.c                      |  520 +++----
 drivers/crypto/hisilicon/qm_common.h               |    6 +-
 drivers/crypto/hisilicon/sec/sec_drv.c             |    6 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c         |   32 +-
 drivers/crypto/hisilicon/sec2/sec_main.c           |   29 +-
 drivers/crypto/hisilicon/trng/trng.c               |    6 +-
 drivers/crypto/hisilicon/zip/zip_crypto.c          |  290 +---
 drivers/crypto/hisilicon/zip/zip_main.c            |   23 +-
 drivers/crypto/img-hash.c                          |    6 +-
 drivers/crypto/inside-secure/safexcel.c            |    6 +-
 drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c        |    6 +-
 .../crypto/intel/keembay/keembay-ocs-aes-core.c    |    6 +-
 drivers/crypto/intel/keembay/keembay-ocs-ecc.c     |    6 +-
 .../crypto/intel/keembay/keembay-ocs-hcu-core.c    |   15 +-
 .../crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c   |  245 ++-
 .../crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h   |   30 +-
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c        |   36 +-
 .../crypto/intel/qat/qat_c3xxx/adf_c3xxx_hw_data.c |    1 +
 drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c       |    1 +
 drivers/crypto/intel/qat/qat_c3xxxvf/adf_drv.c     |    1 +
 .../crypto/intel/qat/qat_c62x/adf_c62x_hw_data.c   |    1 +
 drivers/crypto/intel/qat/qat_c62x/adf_drv.c        |    1 +
 drivers/crypto/intel/qat/qat_c62xvf/adf_drv.c      |    1 +
 drivers/crypto/intel/qat/qat_common/Makefile       |   10 +
 .../intel/qat/qat_common/adf_accel_devices.h       |   61 +-
 drivers/crypto/intel/qat/qat_common/adf_admin.c    |  156 +-
 drivers/crypto/intel/qat/qat_common/adf_admin.h    |   27 +
 drivers/crypto/intel/qat/qat_common/adf_aer.c      |    3 +-
 .../crypto/intel/qat/qat_common/adf_cfg_services.c |   20 +
 .../crypto/intel/qat/qat_common/adf_cfg_services.h |   24 +
 .../crypto/intel/qat/qat_common/adf_cfg_strings.h  |    1 +
 drivers/crypto/intel/qat/qat_common/adf_clock.c    |    1 +
 .../crypto/intel/qat/qat_common/adf_cnv_dbgfs.c    |  300 ++++
 .../crypto/intel/qat/qat_common/adf_cnv_dbgfs.h    |   11 +
 .../crypto/intel/qat/qat_common/adf_common_drv.h   |   20 +-
 drivers/crypto/intel/qat/qat_common/adf_dbgfs.c    |    6 +
 .../crypto/intel/qat/qat_common/adf_fw_counters.c  |    3 +-
 .../crypto/intel/qat/qat_common/adf_gen4_hw_data.h |    7 +
 drivers/crypto/intel/qat/qat_common/adf_gen4_pm.c  |   27 +-
 drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h  |   50 +-
 .../intel/qat/qat_common/adf_gen4_pm_debugfs.c     |  266 ++++
 drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c | 1566 ++++++++++++++++++++
 drivers/crypto/intel/qat/qat_common/adf_gen4_ras.h |  825 +++++++++++
 .../crypto/intel/qat/qat_common/adf_gen4_timer.c   |    1 +
 .../crypto/intel/qat/qat_common/adf_heartbeat.c    |    1 +
 .../intel/qat/qat_common/adf_heartbeat_dbgfs.c     |    1 +
 drivers/crypto/intel/qat/qat_common/adf_init.c     |   63 +-
 drivers/crypto/intel/qat/qat_common/adf_isr.c      |   18 +
 drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs.c |   48 +
 drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs.h |   12 +
 drivers/crypto/intel/qat/qat_common/adf_rl.c       | 1169 +++++++++++++++
 drivers/crypto/intel/qat/qat_common/adf_rl.h       |  176 +++
 drivers/crypto/intel/qat/qat_common/adf_rl_admin.c |   97 ++
 drivers/crypto/intel/qat/qat_common/adf_rl_admin.h |   18 +
 drivers/crypto/intel/qat/qat_common/adf_sysfs.c    |  112 +-
 .../intel/qat/qat_common/adf_sysfs_ras_counters.c  |  112 ++
 .../intel/qat/qat_common/adf_sysfs_ras_counters.h  |   27 +
 drivers/crypto/intel/qat/qat_common/adf_sysfs_rl.c |  451 ++++++
 drivers/crypto/intel/qat/qat_common/adf_sysfs_rl.h |   11 +
 .../intel/qat/qat_common/adf_transport_debug.c     |    4 +-
 .../intel/qat/qat_common/icp_qat_fw_init_admin.h   |   82 +
 drivers/crypto/intel/qat/qat_common/icp_qat_hw.h   |    2 +
 .../crypto/intel/qat/qat_common/qat_algs_send.c    |   46 +-
 .../crypto/intel/qat/qat_common/qat_comp_algs.c    |  129 +-
 drivers/crypto/intel/qat/qat_common/qat_uclo.c     |    2 +-
 .../intel/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c  |    1 +
 drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c    |    1 +
 drivers/crypto/intel/qat/qat_dh895xccvf/adf_drv.c  |    1 +
 drivers/crypto/marvell/cesa/cesa.c                 |    6 +-
 drivers/crypto/mxs-dcp.c                           |    8 +-
 drivers/crypto/n2_core.c                           |   12 +-
 drivers/crypto/omap-aes.c                          |    6 +-
 drivers/crypto/omap-des.c                          |    6 +-
 drivers/crypto/omap-sham.c                         |   22 +-
 drivers/crypto/qce/core.c                          |    5 +-
 drivers/crypto/qcom-rng.c                          |   71 +-
 drivers/crypto/rockchip/rk3288_crypto.c            |    5 +-
 drivers/crypto/rockchip/rk3288_crypto_ahash.c      |    3 -
 drivers/crypto/s5p-sss.c                           |   12 +-
 drivers/crypto/sa2ul.c                             |    6 +-
 drivers/crypto/sahara.c                            |    6 +-
 drivers/crypto/starfive/jh7110-hash.c              |   13 +-
 drivers/crypto/stm32/stm32-crc32.c                 |   17 +-
 drivers/crypto/stm32/stm32-cryp.c                  |   16 +-
 drivers/crypto/stm32/stm32-hash.c                  |   20 -
 drivers/crypto/talitos.c                           |   23 +-
 drivers/crypto/virtio/virtio_crypto_common.h       |    3 +
 drivers/crypto/virtio/virtio_crypto_core.c         |   14 +-
 drivers/crypto/vmx/aesp8-ppc.pl                    |  141 +-
 drivers/crypto/xilinx/zynqmp-aes-gcm.c             |    6 +-
 drivers/crypto/xilinx/zynqmp-sha.c                 |    7 +-
 .../chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c    |    2 -
 .../chelsio/inline_crypto/ch_ipsec/chcr_ipsec.h    |    1 -
 .../ethernet/chelsio/inline_crypto/chtls/chtls.h   |    1 -
 drivers/net/wireguard/cookie.c                     |    2 +-
 drivers/net/wireguard/netlink.c                    |    2 +-
 drivers/net/wireguard/noise.c                      |    2 +-
 fs/crypto/keysetup_v1.c                            |    2 +-
 fs/smb/server/ksmbd_spnego_negtokeninit.asn1       |    8 +
 fs/smb/server/ksmbd_spnego_negtokentarg.asn1       |    7 +
 fs/ubifs/auth.c                                    |    3 +-
 fs/ubifs/replay.c                                  |    1 -
 fs/ubifs/ubifs.h                                   |    2 +-
 include/crypto/aead.h                              |   12 +
 include/crypto/akcipher.h                          |    4 +-
 include/crypto/algapi.h                            |    5 -
 include/crypto/engine.h                            |    2 +-
 include/crypto/hash.h                              |   95 +-
 include/crypto/hash_info.h                         |    1 +
 include/crypto/internal/hash.h                     |    9 +-
 include/crypto/internal/skcipher.h                 |  130 +-
 include/crypto/sig.h                               |    2 +-
 include/crypto/skcipher.h                          |  296 +++-
 include/linux/crypto.h                             |   30 +-
 include/linux/hisi_acc_qm.h                        |   39 +-
 include/linux/hw_random.h                          |    1 +
 include/linux/oid_registry.h                       |   23 +-
 include/linux/units.h                              |    4 +
 include/linux/verification.h                       |    1 +
 include/uapi/linux/hash_info.h                     |    3 +
 kernel/module/Kconfig                              |   25 +-
 kernel/padata.c                                    |    8 +-
 net/bluetooth/smp.c                                |    3 +-
 net/ceph/messenger_v2.c                            |    4 -
 net/ipv4/ah4.c                                     |   19 +-
 net/ipv4/netfilter/nf_nat_snmp_basic.asn1          |    8 +
 net/ipv6/ah6.c                                     |   19 +-
 net/mptcp/subflow.c                                |    2 +-
 net/sunrpc/auth_gss/gss_krb5_crypto.c              |    2 +-
 net/sunrpc/auth_gss/gss_krb5_unseal.c              |    2 -
 net/xfrm/Kconfig                                   |    1 +
 net/xfrm/xfrm_algo.c                               |   19 +-
 security/integrity/evm/evm_main.c                  |    3 +-
 security/keys/encrypted-keys/encrypted.c           |    2 +-
 tools/crypto/ccp/dbc.c                             |   17 +-
 tools/crypto/ccp/dbc.py                            |    8 +-
 tools/crypto/ccp/test_dbc.py                       |   45 +-
 277 files changed, 10706 insertions(+), 3352 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-qat_ras
 create mode 100644 Documentation/ABI/testing/sysfs-driver-qat_rl
 create mode 100644 crypto/lskcipher.c
 create mode 100644 crypto/skcipher.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_admin.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_cfg_services.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_cfg_services.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_cnv_dbgfs.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_cnv_dbgfs.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_ras.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_rl.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_rl.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_rl_admin.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_rl_admin.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_sysfs_ras_counters.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_sysfs_ras_counters.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_sysfs_rl.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_sysfs_rl.h

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
