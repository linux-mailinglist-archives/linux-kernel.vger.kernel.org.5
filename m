Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743AA78A8E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjH1JYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjH1JYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:24:07 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E420F139;
        Mon, 28 Aug 2023 02:23:37 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qaYRv-008SRJ-C5; Mon, 28 Aug 2023 17:22:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 28 Aug 2023 17:22:20 +0800
Date:   Mon, 28 Aug 2023 17:22:20 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Update for 6.6
Message-ID: <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
References: <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

The following changes since commit 419caed6cc77f19148faefe13515f8685ede219b:

  Merge tag 'v6.5-p2' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 (2023-07-10 09:53:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.6-p1 

for you to fetch changes up to 85b9bf9a514d991fcecb118d0a8a35e754ff9265:

  Revert "dt-bindings: crypto: qcom,prng: Add SM8450" (2023-08-25 19:01:45 +0800)

----------------------------------------------------------------
This update includes the following changes:

API:

- Move crypto engine callback from tfm ctx into algorithm object.
- Fix atomic sleep bug in crypto_destroy_instance.
- Move lib/mpi into lib/crypto.

Algorithms:

- Add chacha20 and poly1305 implementation for powerpc p10.

Drivers:

- Add AES skcipher and aead support to starfive.
- Add Dynamic Boost Control support to ccp.
- Add support for STM32P13 platform to stm32.
----------------------------------------------------------------
Adam Guerin (1):
      crypto: qat - fix crypto capability detection for 4xxx

Arnd Bergmann (2):
      crypto: caam - fix PM operations definition
      crypto: drivers - avoid memcpy size warning

Azeem Shaikh (1):
      crypto: lrw,xts - Replace strlcpy with strscpy

Chang S. Bae (1):
      crypto: x86/aesni - Align the address before aes_set_key_common()

Christophe JAILLET (2):
      crypto: caam - Use struct_size()
      crypto: caam - Remove messages related to memory allocation failure

Damian Muszynski (5):
      crypto: qat - add internal timer for qat 4xxx
      crypto: qat - drop obsolete heartbeat interface
      crypto: qat - add measure clock frequency
      crypto: qat - add heartbeat feature
      crypto: qat - add heartbeat counters check

Danny Tsen (5):
      crypto: chacha20-p10 - An optimized Chacha20 implementation with 8-way unrolling for ppc64le
      crypt: chacha20-p10 - Glue code for optmized Chacha20 implementation for ppc64le
      crypto: poly1305-p10 - An optimized Poly1305 implementation with 4-way unrolling for ppc64le
      crypto: poly1305-p10 - Glue code for optmized Poly1305 implementation for ppc64le
      crypto: powerpc - Add chacha20/poly1305-p10 to Kconfig and Makefile

David Howells (1):
      crypto: af_alg - Fix missing initialisation affecting gcm-aes-s390

Eric Biggers (1):
      crypto: x86/aesni - remove unused parameter to aes_set_key_common()

Florian Fainelli (1):
      hwrng: iproc-rng200 - Implement suspend and resume calls

Franck LENORMAND (1):
      crypto: caam - Change structure type representing DECO MID

Frederick Lawler (1):
      crypto: af_alg - Decrement struct key.usage in alg_set_by_key_serial()

GUO Zihua (1):
      hwrng: core - Remove duplicated include

Gaosheng Cui (1):
      KEYS: fix kernel-doc warnings in verify_pefile

Gaurav Jain (1):
      crypto: caam - fix unchecked return value error

Giovanni Cabiddu (1):
      crypto: qat - change value of default idle filter

Herbert Xu (38):
      crypto: api - Use work queue in crypto_destroy_instance
      crypto: lib - Move mpi into lib/crypto
      crypto: sun8i-ce - Remove prepare/unprepare request
      crypto: sun8i-ss - Remove prepare/unprepare request
      crypto: amlogic - Remove prepare/unprepare request
      crypto: aspeed - Remove prepare/unprepare request
      crypto: sl3516 - Remove prepare/unprepare request
      crypto: keembay - Remove prepare/unprepare request
      crypto: omap - Remove prepare/unprepare request
      crypto: rk3288 - Remove prepare/unprepare request
      crypto: jh1100 - Remove prepare/unprepare request
      crypto: stm32 - Remove prepare/unprepare request
      crypto: virtio - Remove prepare/unprepare request
      crypto: zynqmp - Remove prepare/unprepare request
      crypto: engine - Remove prepare/unprepare request
      crypto: jh7110 - Include crypto/hash.h in header file
      crypto: engine - Move crypto inclusions out of header file
      crypto: jh7110 - Include scatterwalk.h for struct scatter_walk
      crypto: engine - Create internal/engine.h
      crypto: omap - Include internal/engine.h
      crypto: caam - Include internal/engine.h
      crypto: engine - Move struct crypto_engine into internal/engine.h
      crypto: engine - Move crypto_engine_ops from request into crypto_alg
      crypto: sun8i-ce - Use new crypto_engine_op interface
      crypto: sun8i-ss - Use new crypto_engine_op interface
      crypto: amlogic - Use new crypto_engine_op interface
      crypto: aspeed - Use new crypto_engine_op interface
      crypto: aspeed - Remove non-standard sha512 algorithms
      crypto: caam - Use new crypto_engine_op interface
      crypto: sl3516 - Use new crypto_engine_op interface
      crypto: keembay - Use new crypto_engine_op interface
      crypto: omap - Use new crypto_engine_op interface
      crypto: rk3288 - Use new crypto_engine_op interface
      crypto: jh7110 - Use new crypto_engine_op interface
      crypto: stm32 - Use new crypto_engine_op interface
      crypto: virtio - Use new crypto_engine_op interface
      crypto: zynqmp - Use new crypto_engine_op interface
      crypto: engine - Remove crypto_engine_ctx

Horia Geanta (1):
      crypto: caam - add power management support

Horia Geantă (1):
      crypto: caam/jr - fix shared IRQ line handling

Iuliana Prodan (1):
      crypto: caam - increase the domain of write memory barrier to full system

Jia Jie Ho (1):
      crypto: starfive - Add AES skcipher and aead support

Jiapeng Chong (1):
      crypto: sig - Remove some unused functions

Joachim Vandersmissen (1):
      crypto: jitter - Add clarifying comments to Jitter Entropy RCT cutoff values

Konrad Dybcio (2):
      dt-bindings: crypto: qcom,prng: Add SM8450
      crypto: qcom-rng: Make the core clock optional regardless of ACPI presence

Krzysztof Kozlowski (1):
      crypto: exynos - fix Wvoid-pointer-to-enum-cast warning

Lionel Debieve (1):
      dt-bindings: crypto: add new compatible for stm32-hash

Lucas Segarra Fernandez (1):
      crypto: qat - add fw_counters debugfs file

Mahmoud Adam (1):
      KEYS: use kfree_sensitive with key

Mario Limonciello (11):
      crypto: ccp - Rename macro for security attributes
      crypto: ccp - Add support for displaying PSP firmware versions
      crypto: ccp - Add bootloader and TEE version offsets
      crypto: ccp - move setting PSP master to earlier in the init
      crypto: ccp - Add support for fetching a nonce for dynamic boost control
      crypto: ccp - Add support for setting user ID for dynamic boost control
      crypto: ccp - Add support for getting and setting DBC parameters
      crypto: ccp - Add a sample library for ioctl use
      crypto: ccp - Add a sample python script for Dynamic Boost Control
      crypto: ccp - Add unit tests for dynamic boost control
      crypto: ccp - Add Mario to MAINTAINERS

Mark O'Donovan (1):
      crypto: lib/mpi - avoid null pointer deref in mpi_cmp_ui()

Martin Kaiser (25):
      hwrng: nomadik - keep clock enabled while hwrng is registered
      hwrng: nomadik - use dev_err_probe
      hwrng: imx-rngc - use dev_err_probe
      hwrng: exynos - switch to DEFINE_SIMPLE_DEV_PM_OPS
      hwrng: pic32 - enable compile-testing
      hwrng: pic32 - use devm_clk_get_enabled
      hwrng: pic32 - remove unused defines
      hwrng: pic32 - enable TRNG only while it's used
      hwrng: ingenic - enable compile testing
      hwrng: ingenic - remove two unused defines
      hwrng: ingenic - remove dead assignments
      hwrng: ingenic - use devm_clk_get_enabled
      hwrng: ingenic - use dev_err_probe in error paths
      hwrng: ingenic - don't disable the rng in ingenic_trng_remove
      hwrng: ingenic - switch to device managed registration
      hwrng: ba431 - do not set drvdata
      hwrng: ba431 - don't init of_device_id's data
      hwrng: ba431 - use dev_err_probe after failed registration
      hwrng: arm-smccc-trng - don't set drvdata
      hwrng: cctrng - don't open code init and exit functions
      hwrng: cctrng - let devres enable the clock
      hwrng: cctrng - merge cc_trng_clk_init into its only caller
      hwrng: cctrng - use dev_err_probe in error paths
      hwrng: cn10k - delete empty remove function
      hwrng: cn10k - use dev_err_probe

Masahiro Yamada (1):
      crypto: arm64/aes - remove Makefile hack

Neil Armstrong (1):
      Revert "dt-bindings: crypto: qcom,prng: Add SM8450"

Rob Herring (4):
      hwrng: Explicitly include correct DT includes
      hwrng: Enable COMPILE_TEST for more drivers
      hwrng: xgene: Add explicit io.h include
      crypto: drivers - Explicitly include correct DT includes

Ruan Jinjie (1):
      crypto: hisilicon/sec - Do not check for 0 return after calling platform_get_irq()

Thomas Bourgoin (6):
      crypto: stm32 - add new algorithms support
      crypto: stm32 - remove bufcnt in stm32_hash_write_ctrl.
      crypto: stm32 - fix loop iterating through scatterlist for DMA
      crypto: stm32 - check request size and scatterlist size when using DMA.
      crypto: stm32 - fix MDMAT condition
      crypto: stm32 - remove flag HASH_FLAGS_DMA_READY

Thore Sommer (1):
      X.509: if signature is unsupported skip validation

Uwe Kleine-König (4):
      crypto: starfive - Convert to platform remove callback returning void
      crypto: stm32 - Properly handle pm_runtime_get failing
      crypto: stm32 - Drop if block with always false condition
      crypto: stm32 - Convert to platform remove callback returning void

Wang Ming (1):
      crypto: atmel - Use dev_err_probe instead of dev_err

Weili Qian (5):
      crypto: hisilicon/hpre - ensure private key less than n
      crypto: hisilicon/qm - flush all work before driver removed
      crypto: hisilicon/qm - stop function and write data to memory
      crypto: hisilicon/qm - increase device doorbell timeout
      crypto: hisilicon/hpre - enable sva error interrupt event

Yang Yingliang (2):
      crypto: starfive - fix return value check in starfive_aes_prepare_req()
      crypto: qat - use kfree_sensitive instead of memset/kfree()

Yangtao Li (6):
      crypto: omap-des - Use devm_platform_get_and_ioremap_resource()
      crypto: keembay - Convert to devm_platform_ioremap_resource()
      crypto: atmel-aes - Use devm_platform_get_and_ioremap_resource()
      crypto: atmel-sha - Use devm_platform_get_and_ioremap_resource()
      crypto: atmel-tdes - Use devm_platform_get_and_ioremap_resource()
      hwrng: timeriomem - Use devm_platform_get_and_ioremap_resource()

You Kangren (1):
      crypto: qat - replace the if statement with min()

Yue Haibing (3):
      crypto: allwinner - Remove unused function declarations
      crypto: qat - Remove unused function declarations
      crypto: chelsio - Remove unused declarations

 Documentation/ABI/testing/debugfs-driver-qat       |   61 ++
 Documentation/ABI/testing/sysfs-driver-ccp         |   18 +
 .../devicetree/bindings/crypto/st,stm32-hash.yaml  |    1 +
 MAINTAINERS                                        |   12 +
 arch/arm64/crypto/Makefile                         |    5 -
 arch/arm64/crypto/aes-glue-ce.c                    |    2 +
 arch/arm64/crypto/aes-glue-neon.c                  |    1 +
 arch/powerpc/crypto/Kconfig                        |   26 +
 arch/powerpc/crypto/Makefile                       |    4 +
 arch/powerpc/crypto/chacha-p10-glue.c              |  221 ++++
 arch/powerpc/crypto/chacha-p10le-8x.S              |  842 +++++++++++++++
 arch/powerpc/crypto/poly1305-p10-glue.c            |  186 ++++
 arch/powerpc/crypto/poly1305-p10le_64.S            | 1075 ++++++++++++++++++++
 arch/x86/crypto/aesni-intel_glue.c                 |   22 +-
 crypto/af_alg.c                                    |    4 +
 crypto/algapi.c                                    |   16 +-
 crypto/asymmetric_keys/public_key.c                |    8 +-
 crypto/asymmetric_keys/verify_pefile.c             |    2 +-
 crypto/asymmetric_keys/x509_public_key.c           |    5 +
 crypto/crypto_engine.c                             |  244 ++++-
 crypto/jitterentropy.c                             |   10 +-
 crypto/lrw.c                                       |    6 +-
 crypto/sig.c                                       |    5 -
 crypto/xts.c                                       |    6 +-
 drivers/char/hw_random/Kconfig                     |   37 +-
 drivers/char/hw_random/amd-rng.c                   |    1 +
 drivers/char/hw_random/arm_smccc_trng.c            |    2 -
 drivers/char/hw_random/atmel-rng.c                 |    2 +-
 drivers/char/hw_random/ba431-rng.c                 |   10 +-
 drivers/char/hw_random/bcm2835-rng.c               |    3 +-
 drivers/char/hw_random/cctrng.c                    |   93 +-
 drivers/char/hw_random/cn10k-rng.c                 |   18 +-
 drivers/char/hw_random/core.c                      |    3 +-
 drivers/char/hw_random/exynos-trng.c               |    8 +-
 drivers/char/hw_random/imx-rngc.c                  |   24 +-
 drivers/char/hw_random/ingenic-rng.c               |    2 +-
 drivers/char/hw_random/ingenic-trng.c              |   59 +-
 drivers/char/hw_random/iproc-rng200.c              |   28 +-
 drivers/char/hw_random/nomadik-rng.c               |   19 +-
 drivers/char/hw_random/npcm-rng.c                  |    3 +-
 drivers/char/hw_random/omap-rng.c                  |    2 -
 drivers/char/hw_random/omap3-rom-rng.c             |    1 -
 drivers/char/hw_random/pasemi-rng.c                |    3 +-
 drivers/char/hw_random/pic32-rng.c                 |   76 +-
 drivers/char/hw_random/stm32-rng.c                 |    3 +-
 drivers/char/hw_random/timeriomem-rng.c            |   25 +-
 drivers/char/hw_random/xgene-rng.c                 |    6 +-
 drivers/char/hw_random/xiphera-trng.c              |    1 -
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c  |    1 -
 .../crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c    |   41 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c  |  172 ++--
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c  |  100 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h       |   16 +-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c    |   27 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c  |  155 +--
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c  |  114 ++-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h       |   19 +-
 drivers/crypto/amlogic/amlogic-gxl-cipher.c        |   13 +-
 drivers/crypto/amlogic/amlogic-gxl-core.c          |   61 +-
 drivers/crypto/amlogic/amlogic-gxl.h               |    5 +-
 drivers/crypto/aspeed/aspeed-acry.c                |   40 +-
 drivers/crypto/aspeed/aspeed-hace-crypto.c         |  134 ++-
 drivers/crypto/aspeed/aspeed-hace-hash.c           |  285 ++----
 drivers/crypto/aspeed/aspeed-hace.c                |    9 +-
 drivers/crypto/aspeed/aspeed-hace.h                |   30 +-
 drivers/crypto/atmel-aes.c                         |   21 +-
 drivers/crypto/atmel-ecc.c                         |    2 +-
 drivers/crypto/atmel-sha.c                         |   28 +-
 drivers/crypto/atmel-tdes.c                        |   20 +-
 drivers/crypto/bcm/cipher.c                        |    6 +-
 drivers/crypto/caam/caamalg.c                      |  386 +++++--
 drivers/crypto/caam/caamhash.c                     |   47 +-
 drivers/crypto/caam/caampkc.c                      |   25 +-
 drivers/crypto/caam/caampkc.h                      |    3 -
 drivers/crypto/caam/ctrl.c                         |  107 ++
 drivers/crypto/caam/intern.h                       |   25 +-
 drivers/crypto/caam/jr.c                           |  206 +++-
 drivers/crypto/caam/qi.c                           |    1 +
 drivers/crypto/caam/regs.h                         |    9 +-
 drivers/crypto/ccp/Makefile                        |    3 +-
 drivers/crypto/ccp/dbc.c                           |  250 +++++
 drivers/crypto/ccp/dbc.h                           |   56 +
 drivers/crypto/ccp/psp-dev.c                       |   19 +-
 drivers/crypto/ccp/psp-dev.h                       |    1 +
 drivers/crypto/ccp/sp-dev.h                        |    7 +
 drivers/crypto/ccp/sp-pci.c                        |   96 +-
 drivers/crypto/ccree/cc_driver.c                   |    1 -
 drivers/crypto/chelsio/chcr_algo.c                 |    3 +-
 drivers/crypto/chelsio/chcr_core.h                 |    1 -
 drivers/crypto/chelsio/chcr_crypto.h               |    1 -
 drivers/crypto/exynos-rng.c                        |    4 +-
 drivers/crypto/gemini/sl3516-ce-cipher.c           |   22 +-
 drivers/crypto/gemini/sl3516-ce-core.c             |   50 +-
 drivers/crypto/gemini/sl3516-ce.h                  |    8 +-
 drivers/crypto/hisilicon/hpre/hpre_crypto.c        |   10 +-
 drivers/crypto/hisilicon/hpre/hpre_main.c          |    5 +-
 drivers/crypto/hisilicon/qm.c                      |   28 +-
 drivers/crypto/hisilicon/sec/sec_drv.c             |    4 +-
 drivers/crypto/img-hash.c                          |    4 +-
 .../crypto/intel/keembay/keembay-ocs-aes-core.c    |  431 ++++----
 drivers/crypto/intel/keembay/keembay-ocs-ecc.c     |   73 +-
 .../crypto/intel/keembay/keembay-ocs-hcu-core.c    |  243 +++--
 .../crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c   |   23 +
 .../crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h   |    4 +
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c        |    3 +
 .../crypto/intel/qat/qat_c3xxx/adf_c3xxx_hw_data.c |   28 +
 .../crypto/intel/qat/qat_c3xxx/adf_c3xxx_hw_data.h |    7 +
 .../crypto/intel/qat/qat_c62x/adf_c62x_hw_data.c   |   28 +
 .../crypto/intel/qat/qat_c62x/adf_c62x_hw_data.h   |    7 +
 drivers/crypto/intel/qat/qat_common/Makefile       |    5 +
 .../intel/qat/qat_common/adf_accel_devices.h       |   14 +
 drivers/crypto/intel/qat/qat_common/adf_admin.c    |   61 ++
 .../crypto/intel/qat/qat_common/adf_cfg_strings.h  |    2 +
 drivers/crypto/intel/qat/qat_common/adf_clock.c    |  131 +++
 drivers/crypto/intel/qat/qat_common/adf_clock.h    |   14 +
 .../crypto/intel/qat/qat_common/adf_common_drv.h   |   14 +-
 drivers/crypto/intel/qat/qat_common/adf_dbgfs.c    |   12 +
 .../crypto/intel/qat/qat_common/adf_fw_counters.c  |  264 +++++
 .../crypto/intel/qat/qat_common/adf_fw_counters.h  |   11 +
 .../crypto/intel/qat/qat_common/adf_gen2_config.c  |    7 +
 .../crypto/intel/qat/qat_common/adf_gen2_hw_data.h |    3 +
 .../crypto/intel/qat/qat_common/adf_gen4_hw_data.h |    3 +
 drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h  |    2 +-
 .../crypto/intel/qat/qat_common/adf_gen4_timer.c   |   70 ++
 .../crypto/intel/qat/qat_common/adf_gen4_timer.h   |   21 +
 .../crypto/intel/qat/qat_common/adf_heartbeat.c    |  336 ++++++
 .../crypto/intel/qat/qat_common/adf_heartbeat.h    |   79 ++
 .../intel/qat/qat_common/adf_heartbeat_dbgfs.c     |  194 ++++
 .../intel/qat/qat_common/adf_heartbeat_dbgfs.h     |   12 +
 drivers/crypto/intel/qat/qat_common/adf_init.c     |   28 +
 drivers/crypto/intel/qat/qat_common/adf_isr.c      |    6 +
 .../intel/qat/qat_common/icp_qat_fw_init_admin.h   |   23 +-
 drivers/crypto/intel/qat/qat_common/icp_qat_hw.h   |    5 +-
 .../crypto/intel/qat/qat_common/qat_compression.c  |    3 +-
 drivers/crypto/intel/qat/qat_common/qat_uclo.c     |    7 +-
 .../intel/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c  |   13 +
 .../intel/qat/qat_dh895xcc/adf_dh895xcc_hw_data.h  |    5 +
 drivers/crypto/n2_core.c                           |    2 +-
 drivers/crypto/omap-aes-gcm.c                      |   39 +-
 drivers/crypto/omap-aes.c                          |  264 ++---
 drivers/crypto/omap-aes.h                          |   15 +-
 drivers/crypto/omap-des.c                          |  212 ++--
 drivers/crypto/omap-sham.c                         |  291 +++---
 drivers/crypto/qcom-rng.c                          |   10 +-
 drivers/crypto/rockchip/rk3288_crypto.c            |   59 +-
 drivers/crypto/rockchip/rk3288_crypto.h            |   21 +-
 drivers/crypto/rockchip/rk3288_crypto_ahash.c      |   80 +-
 drivers/crypto/rockchip/rk3288_crypto_skcipher.c   |   60 +-
 drivers/crypto/s5p-sss.c                           |    1 -
 drivers/crypto/sa2ul.c                             |    3 +-
 drivers/crypto/sahara.c                            |    1 -
 drivers/crypto/starfive/Kconfig                    |    2 +
 drivers/crypto/starfive/Makefile                   |    2 +-
 drivers/crypto/starfive/jh7110-aes.c               | 1024 +++++++++++++++++++
 drivers/crypto/starfive/jh7110-cryp.c              |   53 +-
 drivers/crypto/starfive/jh7110-cryp.h              |   74 +-
 drivers/crypto/starfive/jh7110-hash.c              |  290 +++---
 drivers/crypto/stm32/Kconfig                       |    2 +
 drivers/crypto/stm32/stm32-cryp.c                  |  356 +++----
 drivers/crypto/stm32/stm32-hash.c                  |  988 +++++++++++++-----
 drivers/crypto/talitos.c                           |    4 +-
 .../crypto/virtio/virtio_crypto_akcipher_algs.c    |   35 +-
 .../crypto/virtio/virtio_crypto_skcipher_algs.c    |   25 +-
 drivers/crypto/xilinx/zynqmp-aes-gcm.c             |   41 +-
 drivers/crypto/xilinx/zynqmp-sha.c                 |    1 -
 include/crypto/algapi.h                            |    3 +
 include/crypto/engine.h                            |  118 +--
 include/crypto/internal/engine.h                   |   74 ++
 include/linux/hisi_acc_qm.h                        |    2 +-
 include/linux/psp-platform-access.h                |    4 +
 include/uapi/linux/psp-dbc.h                       |  147 +++
 lib/Makefile                                       |    1 -
 lib/crypto/Makefile                                |    2 +
 lib/{ => crypto}/mpi/Makefile                      |    0
 lib/{ => crypto}/mpi/ec.c                          |    0
 lib/{ => crypto}/mpi/generic_mpih-add1.c           |    0
 lib/{ => crypto}/mpi/generic_mpih-lshift.c         |    0
 lib/{ => crypto}/mpi/generic_mpih-mul1.c           |    0
 lib/{ => crypto}/mpi/generic_mpih-mul2.c           |    0
 lib/{ => crypto}/mpi/generic_mpih-mul3.c           |    0
 lib/{ => crypto}/mpi/generic_mpih-rshift.c         |    0
 lib/{ => crypto}/mpi/generic_mpih-sub1.c           |    0
 lib/{ => crypto}/mpi/longlong.h                    |    0
 lib/{ => crypto}/mpi/mpi-add.c                     |    0
 lib/{ => crypto}/mpi/mpi-bit.c                     |    0
 lib/{ => crypto}/mpi/mpi-cmp.c                     |    8 +-
 lib/{ => crypto}/mpi/mpi-div.c                     |    0
 lib/{ => crypto}/mpi/mpi-inline.h                  |    0
 lib/{ => crypto}/mpi/mpi-internal.h                |    0
 lib/{ => crypto}/mpi/mpi-inv.c                     |    0
 lib/{ => crypto}/mpi/mpi-mod.c                     |    0
 lib/{ => crypto}/mpi/mpi-mul.c                     |    0
 lib/{ => crypto}/mpi/mpi-pow.c                     |    0
 lib/{ => crypto}/mpi/mpi-sub-ui.c                  |    0
 lib/{ => crypto}/mpi/mpicoder.c                    |    0
 lib/{ => crypto}/mpi/mpih-cmp.c                    |    0
 lib/{ => crypto}/mpi/mpih-div.c                    |    0
 lib/{ => crypto}/mpi/mpih-mul.c                    |    0
 lib/{ => crypto}/mpi/mpiutil.c                     |    0
 tools/crypto/ccp/.gitignore                        |    1 +
 tools/crypto/ccp/Makefile                          |   13 +
 tools/crypto/ccp/dbc.c                             |   72 ++
 tools/crypto/ccp/dbc.py                            |   64 ++
 tools/crypto/ccp/dbc_cli.py                        |  134 +++
 tools/crypto/ccp/test_dbc.py                       |  266 +++++
 205 files changed, 10033 insertions(+), 2915 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-driver-qat
 create mode 100644 arch/arm64/crypto/aes-glue-ce.c
 create mode 100644 arch/arm64/crypto/aes-glue-neon.c
 create mode 100644 arch/powerpc/crypto/chacha-p10-glue.c
 create mode 100644 arch/powerpc/crypto/chacha-p10le-8x.S
 create mode 100644 arch/powerpc/crypto/poly1305-p10-glue.c
 create mode 100644 arch/powerpc/crypto/poly1305-p10le_64.S
 create mode 100644 drivers/crypto/ccp/dbc.c
 create mode 100644 drivers/crypto/ccp/dbc.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_clock.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_clock.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_fw_counters.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_fw_counters.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_timer.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_timer.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_heartbeat.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_heartbeat.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.h
 create mode 100644 drivers/crypto/starfive/jh7110-aes.c
 create mode 100644 include/crypto/internal/engine.h
 create mode 100644 include/uapi/linux/psp-dbc.h
 rename lib/{ => crypto}/mpi/Makefile (100%)
 rename lib/{ => crypto}/mpi/ec.c (100%)
 rename lib/{ => crypto}/mpi/generic_mpih-add1.c (100%)
 rename lib/{ => crypto}/mpi/generic_mpih-lshift.c (100%)
 rename lib/{ => crypto}/mpi/generic_mpih-mul1.c (100%)
 rename lib/{ => crypto}/mpi/generic_mpih-mul2.c (100%)
 rename lib/{ => crypto}/mpi/generic_mpih-mul3.c (100%)
 rename lib/{ => crypto}/mpi/generic_mpih-rshift.c (100%)
 rename lib/{ => crypto}/mpi/generic_mpih-sub1.c (100%)
 rename lib/{ => crypto}/mpi/longlong.h (100%)
 rename lib/{ => crypto}/mpi/mpi-add.c (100%)
 rename lib/{ => crypto}/mpi/mpi-bit.c (100%)
 rename lib/{ => crypto}/mpi/mpi-cmp.c (96%)
 rename lib/{ => crypto}/mpi/mpi-div.c (100%)
 rename lib/{ => crypto}/mpi/mpi-inline.h (100%)
 rename lib/{ => crypto}/mpi/mpi-internal.h (100%)
 rename lib/{ => crypto}/mpi/mpi-inv.c (100%)
 rename lib/{ => crypto}/mpi/mpi-mod.c (100%)
 rename lib/{ => crypto}/mpi/mpi-mul.c (100%)
 rename lib/{ => crypto}/mpi/mpi-pow.c (100%)
 rename lib/{ => crypto}/mpi/mpi-sub-ui.c (100%)
 rename lib/{ => crypto}/mpi/mpicoder.c (100%)
 rename lib/{ => crypto}/mpi/mpih-cmp.c (100%)
 rename lib/{ => crypto}/mpi/mpih-div.c (100%)
 rename lib/{ => crypto}/mpi/mpih-mul.c (100%)
 rename lib/{ => crypto}/mpi/mpiutil.c (100%)
 create mode 100644 tools/crypto/ccp/.gitignore
 create mode 100644 tools/crypto/ccp/Makefile
 create mode 100644 tools/crypto/ccp/dbc.c
 create mode 100644 tools/crypto/ccp/dbc.py
 create mode 100755 tools/crypto/ccp/dbc_cli.py
 create mode 100755 tools/crypto/ccp/test_dbc.py

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
