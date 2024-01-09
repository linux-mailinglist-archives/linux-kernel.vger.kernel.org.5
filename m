Return-Path: <linux-kernel+bounces-21465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8F8828FC7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F42201C20E30
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007A23E461;
	Tue,  9 Jan 2024 22:17:47 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9133DB9F;
	Tue,  9 Jan 2024 22:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rNKPR-000oS6-6K; Wed, 10 Jan 2024 06:17:22 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Jan 2024 06:17:32 +0800
Date: Wed, 10 Jan 2024 06:17:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Update for 6.8
Message-ID: <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au>
References: <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
 <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>

Hi Linus:

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.8-p1 

for you to fetch changes up to b8910630c967ffee582289451ddb5f9f19c26872:

  crypto: iaa - Account for cpu-less numa nodes (2023-12-29 11:25:56 +0800)

----------------------------------------------------------------
This update includes the following changes:

API:

- Add incremental lskcipher/skcipher processing.

Algorithms:

- Remove SHA1 from drbg.
- Remove CFB and OFB.

Drivers:

- Add comp high perf mode configuration in hisilicon/zip.
- Add support for 420xx devices in qat.
- Add IAA Compression Accelerator driver.
----------------------------------------------------------------

Bharat Bhushan (2):
      crypto: octeontx2 - By default allocate one CPT LF per CPT VF
      crypto: octeontx2 - Fix cptvf driver cleanup

Chanho Park (1):
      crypto: jh7110 - Correct deferred probe return

Chen Ni (1):
      crypto: sa2ul - Return crypto_aead_setkey to transfer the error

Chenghai Huang (3):
      crypto: hisilicon/zip - add zip comp high perf mode configuration
      crypto: hisilicon/qm - delete a dbg function
      crypto: hisilicon/sec2 - optimize the error return process

Chengming Zhou (1):
      crypto: scomp - fix req->dst buffer overflow

Christophe JAILLET (1):
      hwrng: virtio - Remove usage of the deprecated ida_simple_xx() API

Damian Muszynski (5):
      crypto: qat - add sysfs_added flag for ras
      crypto: qat - add sysfs_added flag for rate limiting
      crypto: qat - fix error path in add_update_sla()
      crypto: qat - fix mutex ordering in adf_rl
      crypto: qat - generate dynamically arbiter mappings

Dan Carpenter (2):
      crypto: rsa - add a check for allocation failure
      crypto: qat - prevent underflow in rp2srv_store()

Dave Jiang (1):
      dmaengine: idxd: add external module driver support for dsa_bus_type

Dimitri John Ledkov (4):
      crypto: drbg - ensure most preferred type is FIPS health checked
      crypto: drbg - update FIPS CTR self-checks to aes256
      crypto: drbg - ensure drbg hmac sha512 is used in FIPS selftests
      crypto: drbg - Remove SHA1 from drbg

Dinghao Liu (1):
      crypto: ccp - fix memleak in ccp_init_dm_workarea

Eric Biggers (4):
      crypto: sun8i-ss - use crypto_shash_tfm_digest() in sun8i_ss_hashkey()
      crypto: shash - don't exclude async statuses from error stats
      crypto: x86/sha1 - autoload if SHA-NI detected
      crypto: x86/sha256 - autoload if SHA-NI detected

Giovanni Cabiddu (1):
      crypto: qat - add NULL pointer check

Gonglei (Arei) (1):
      crypto: virtio - Handle dataq logic with tasklet

Gustavo A. R. Silva (1):
      crypto: p10-aes-gcm - Avoid -Wstringop-overflow warnings

Herbert Xu (31):
      crypto: ccree - Silence gcc format-truncation false positive warnings
      crypto: marvell/cesa - Silence gcc format-truncation false positive warnings
      crypto: n2 - Silence gcc format-truncation false positive warnings
      crypto: af_alg - Disallow multiple in-flight AIO requests
      hwrng: core - Fix page fault dead lock on mmap-ed hwrng
      crypto: s390/aes - Fix buffer overread in CTR mode
      crypto: arm64/sm4 - Remove cfb(sm4)
      crypto: x86/sm4 - Remove cfb(sm4)
      crypto: crypto4xx - Remove cfb and ofb
      crypto: aspeed - Remove cfb and ofb
      crypto: atmel - Remove cfb and ofb
      crypto: cpt - Remove cfb
      crypto: nitrox - Remove cfb
      crypto: ccp - Remove cfb and ofb
      crypto: hifn_795x - Remove cfb and ofb
      crypto: hisilicon/sec2 - Remove cfb and ofb
      crypto: safexcel - Remove cfb and ofb
      crypto: octeontx - Remove cfb
      crypto: n2 - Remove cfb
      crypto: starfive - Remove cfb and ofb
      crypto: bcm - Remove ofb
      crypto: ccree - Remove ofb
      crypto: tcrypt - Remove cfb and ofb
      crypto: testmgr - Remove cfb and ofb
      crypto: cfb,ofb - Remove cfb and ofb
      crypto: skcipher - Add internal state support
      crypto: skcipher - Make use of internal state
      crypto: arc4 - Add internal state
      crypto: algif_skcipher - Fix stream cipher chaining
      crypto: api - Disallow identical driver names
      crypto: skcipher - Pass statesize for simple lskcipher instances

Jia Jie Ho (8):
      crypto: starfive - Update driver dependencies
      crypto: starfive - RSA poll csr for done status
      crypto: starfive - Pad adata with zeroes
      hwrng: starfive - Fix dev_err_probe return error
      crypto: starfive - Remove unneeded NULL checks
      crypto: starfive - Fix dev_err_probe return error
      dt-bindings: rng: starfive: Add jh8100 compatible string
      hwrng: starfive - Add runtime pm ops

Jiapeng Chong (1):
      crypto: iaa - remove unneeded semicolon

Jie Wang (5):
      crypto: qat - relocate and rename get_service_enabled()
      crypto: qat - change signature of uof_get_num_objs()
      crypto: qat - relocate portions of qat_4xxx code
      crypto: qat - move fw config related structures
      crypto: qat - add support for 420xx devices

Krzysztof Kozlowski (2):
      dt-bindings: crypto: qcom-qce: constrain clocks for IPQ9574 QCE
      dt-bindings: crypto: qcom-qce: constrain clocks for SM8150-compatible QCE

Longfang Liu (1):
      MAINTAINERS: update SEC2/HPRE driver maintainers list

Lucas Segarra Fernandez (4):
      crypto: qat - include pci.h for GET_DEV()
      crypto: qat - add admin msgs for telemetry
      crypto: qat - add support for device telemetry
      crypto: qat - add support for ring pair level telemetry

Martin Kaiser (1):
      hwrng: virtio - remove #ifdef guards for PM functions

Neil Armstrong (3):
      dt-bindings: crypto: qcom,inline-crypto-engine: document the SM8650 ICE
      dt-bindings: crypto: qcom-qce: document the SM8650 crypto engine
      dt-bindings: crypto: qcom,prng: document SM8650

Nikita Zhandarovich (1):
      crypto: safexcel - Add error handling for dma_map_sg() calls

Nithin Dabilpuram (2):
      crypto: octeontx2 - register error interrupts for inline cptlf
      crypto: octeontx2 - support setting ctx ilen for inline CPT LF

Om Prakash Singh (1):
      dt-bindings: crypto: qcom-qce: document the SC7280 crypto engine

Ovidiu Panait (28):
      crypto: sahara - remove FLAGS_NEW_KEY logic
      crypto: sahara - fix cbc selftest failure
      crypto: sahara - fix ahash selftest failure
      crypto: sahara - fix processing requests with cryptlen < sg->length
      crypto: sahara - fix error handling in sahara_hw_descriptor_create()
      crypto: sahara - remove unused error field in sahara_dev
      crypto: sahara - avoid skcipher fallback code duplication
      crypto: rk3288 - Use helper to set reqsize
      crypto: amlogic - Use helper to set reqsize
      crypto: artpec6 - Use helper to set reqsize
      crypto: stm32/cryp - Use helper to set reqsize
      crypto: sl3516 - Use helper to set reqsize
      crypto: sun8i-ce - Use helper to set reqsize
      crypto: sun8i-ss - Use helper to set reqsize
      crypto: sahara - handle zero-length aes requests
      crypto: sahara - fix ahash reqsize
      crypto: sahara - fix wait_for_completion_timeout() error handling
      crypto: sahara - improve error handling in sahara_sha_process()
      crypto: sahara - fix processing hash requests with req->nbytes < sg->length
      crypto: sahara - do not resize req->src when doing hash operations
      crypto: sahara - clean up macro indentation
      crypto: sahara - use BIT() macro
      crypto: sahara - use devm_clk_get_enabled()
      crypto: sahara - use dev_err_probe()
      crypto: sahara - remove 'active' flag from sahara_aes_reqctx struct
      crypto: sahara - remove unnecessary NULL assignments
      crypto: sahara - remove error message for bad aes request size
      crypto: sahara - add support for crypto_engine

Rafał Miłecki (1):
      dt-bindings: crypto: convert Inside Secure SafeXcel to the json-schema

Rob Herring (1):
      hwrng: ingenic - Replace of_device.h with explicit of.h include

Sagar Vashnav (1):
      crypto: lib/aesgcm - Add kernel docs for aesgcm_mac

Srujana Challa (7):
      crypto: octeontx2 - remove CPT block reset
      crypto: octeontx2 - add SGv2 support for CN10KB or CN10KA B0
      crypto: octeontx2 - add devlink option to set t106 mode
      crypto: octeontx2 - remove errata workaround for CN10KB or CN10KA B0 chip.
      crypto: octeontx2 - add LF reset on queue disable
      crypto: octeontx2 - update CPT inbound inline IPsec mailbox
      crypto: octeontx2 - add ctx_val workaround

Thomas Bourgoin (1):
      crypto: stm32/crc32 - fix parsing list of devices

Tianjia Zhang (1):
      crypto: lib/mpi - Fix unexpected pointer access in mpi_ec_init

Tom Zanussi (16):
      dmaengine: idxd: Rename drv_enable/disable_wq to idxd_drv_enable/disable_wq, and export
      dmaengine: idxd: Export descriptor management functions
      dmaengine: idxd: Export wq resource management functions
      dmaengine: idxd: Add wq private data accessors
      dmaengine: idxd: add callback support for iaa crypto
      crypto: iaa - Add IAA Compression Accelerator Documentation
      crypto: iaa - Add Intel IAA Compression Accelerator crypto driver core
      crypto: iaa - Add per-cpu workqueue table with rebalancing
      crypto: iaa - Add compression mode management along with fixed mode
      crypto: iaa - Add support for deflate-iaa compression algorithm
      crypto: iaa - Add irq support for the crypto async interface
      crypto: iaa - Add IAA Compression Accelerator stats
      dmaengine: idxd: Add support for device/wq defaults
      crypto: iaa - Change desc->priv to 0
      crypto: iaa - Remove unneeded newline in update_max_adecomp_delay_ns()
      crypto: iaa - Account for cpu-less numa nodes

Uwe Kleine-König (12):
      hwrng: atmel - Convert to platform remove callback returning void
      hwrng: cctrng - Convert to platform remove callback returning void
      hwrng: exynos - Convert to platform remove callback returning void
      hwrng: ingenic - Convert to platform remove callback returning void
      hwrng: ks-sa - Convert to platform remove callback returning void
      hwrng: mxc - Convert to platform remove callback returning void
      hwrng: n2 - Convert to platform remove callback returning void
      hwrng: npcm - Convert to platform remove callback returning void
      hwrng: omap - Convert to platform remove callback returning void
      hwrng: stm32 - Convert to platform remove callback returning void
      hwrng: timeriomem - Convert to platform remove callback returning void
      hwrng: xgene - Convert to platform remove callback returning void

Vegard Nossum (2):
      crypto: shash - remove excess kerneldoc members
      crypto: skcipher - remove excess kerneldoc members

WangJinchao (1):
      crypto: tcrypt - add script tcrypt_speed_compare.py

Weili Qian (5):
      crypto: hisilicon/qm - print device abnormal information
      crypto: hisilicon/qm - remove incorrect type cast
      crypto: hisilicon/sgl - small cleanups for sgl.c
      crypto: hisilicon/qm - simplify the status of qm
      crypto: hisilicon/qm - add comments and remove redundant array element

Wenkai Lin (1):
      crypto: hisilicon/qm - add a function to set qm algs

Yang Yingliang (1):
      hwrng: stm32 - add missing clk_disable_unprepare() in stm32_rng_init()

Zhiqi Song (4):
      crypto: hisilicon/qm - save capability registers in qm init process
      crypto: hisilicon/hpre - save capability registers in probe process
      crypto: hisilicon/sec2 - save capability registers in probe process
      crypto: hisilicon/zip - save capability registers in probe process

wangyangxin (1):
      crypto: virtio - Wait for tasklet to complete on device remove

 .../ABI/testing/debugfs-driver-qat_telemetry       |  228 ++
 Documentation/ABI/testing/debugfs-hisi-hpre        |    2 +-
 Documentation/ABI/testing/debugfs-hisi-sec         |    2 +-
 Documentation/ABI/testing/debugfs-hisi-zip         |    2 +-
 Documentation/crypto/device_drivers/index.rst      |    9 +
 Documentation/crypto/device_drivers/octeontx2.rst  |   25 +
 Documentation/crypto/index.rst                     |    1 +
 .../bindings/crypto/inside-secure,safexcel.yaml    |   86 +
 .../bindings/crypto/inside-secure-safexcel.txt     |   40 -
 .../bindings/crypto/qcom,inline-crypto-engine.yaml |    1 +
 .../devicetree/bindings/crypto/qcom,prng.yaml      |    1 +
 .../devicetree/bindings/crypto/qcom-qce.yaml       |   14 +
 .../bindings/rng/starfive,jh7110-trng.yaml         |    6 +-
 Documentation/driver-api/crypto/iaa/iaa-crypto.rst |  824 ++++++++
 Documentation/driver-api/crypto/iaa/index.rst      |   20 +
 Documentation/driver-api/crypto/index.rst          |   20 +
 Documentation/driver-api/index.rst                 |    1 +
 MAINTAINERS                                        |   15 +-
 arch/arm64/crypto/Kconfig                          |    6 +-
 arch/arm64/crypto/sm4-ce-core.S                    |  158 --
 arch/arm64/crypto/sm4-ce-glue.c                    |  108 +-
 arch/arm64/crypto/sm4-ce.h                         |    3 -
 arch/arm64/crypto/sm4-neon-core.S                  |  113 -
 arch/arm64/crypto/sm4-neon-glue.c                  |  105 +-
 arch/powerpc/crypto/aes-gcm-p10-glue.c             |    2 +-
 arch/s390/crypto/aes_s390.c                        |    4 +-
 arch/s390/crypto/paes_s390.c                       |    4 +-
 arch/x86/crypto/Kconfig                            |    8 +-
 arch/x86/crypto/sha1_ssse3_glue.c                  |    7 +-
 arch/x86/crypto/sha256_ssse3_glue.c                |    7 +-
 arch/x86/crypto/sm4-aesni-avx-asm_64.S             |   52 -
 arch/x86/crypto/sm4-aesni-avx2-asm_64.S            |   55 -
 arch/x86/crypto/sm4-avx.h                          |    4 -
 arch/x86/crypto/sm4_aesni_avx2_glue.c              |   26 -
 arch/x86/crypto/sm4_aesni_avx_glue.c               |  130 --
 crypto/Kconfig                                     |   23 -
 crypto/Makefile                                    |    2 -
 crypto/af_alg.c                                    |   14 +-
 crypto/algapi.c                                    |    1 +
 crypto/algif_skcipher.c                            |   72 +-
 crypto/arc4.c                                      |   11 +-
 crypto/cbc.c                                       |    6 +-
 crypto/cfb.c                                       |  254 ---
 crypto/drbg.c                                      |   40 +-
 crypto/ecb.c                                       |   10 +-
 crypto/lskcipher.c                                 |   43 +-
 crypto/ofb.c                                       |  106 -
 crypto/rsa.c                                       |    2 +
 crypto/scompress.c                                 |    6 +
 crypto/shash.c                                     |    6 +-
 crypto/skcipher.c                                  |   80 +-
 crypto/tcrypt.c                                    |   76 -
 crypto/testmgr.c                                   |   74 +-
 crypto/testmgr.h                                   | 1148 ----------
 drivers/char/hw_random/atmel-rng.c                 |    6 +-
 drivers/char/hw_random/cctrng.c                    |    6 +-
 drivers/char/hw_random/core.c                      |   36 +-
 drivers/char/hw_random/exynos-trng.c               |    6 +-
 drivers/char/hw_random/ingenic-rng.c               |    8 +-
 drivers/char/hw_random/jh7110-trng.c               |   10 +-
 drivers/char/hw_random/ks-sa-rng.c                 |    6 +-
 drivers/char/hw_random/mxc-rnga.c                  |    6 +-
 drivers/char/hw_random/n2-drv.c                    |    6 +-
 drivers/char/hw_random/npcm-rng.c                  |    6 +-
 drivers/char/hw_random/omap-rng.c                  |    6 +-
 drivers/char/hw_random/stm32-rng.c                 |    7 +-
 drivers/char/hw_random/timeriomem-rng.c            |    6 +-
 drivers/char/hw_random/virtio-rng.c                |   14 +-
 drivers/char/hw_random/xgene-rng.c                 |    6 +-
 drivers/crypto/Kconfig                             |    1 +
 .../crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c    |    4 +-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c    |    5 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c  |   25 +-
 drivers/crypto/amcc/crypto4xx_alg.c                |   14 -
 drivers/crypto/amcc/crypto4xx_core.c               |   40 -
 drivers/crypto/amcc/crypto4xx_core.h               |    4 -
 drivers/crypto/amlogic/amlogic-gxl-cipher.c        |    4 +-
 drivers/crypto/aspeed/Kconfig                      |    4 +-
 drivers/crypto/aspeed/aspeed-hace-crypto.c         |  230 --
 drivers/crypto/atmel-aes.c                         |  214 +-
 drivers/crypto/atmel-tdes.c                        |  205 +-
 drivers/crypto/axis/artpec6_crypto.c               |   12 +-
 drivers/crypto/bcm/cipher.c                        |   57 -
 drivers/crypto/cavium/cpt/cptvf_algs.c             |   24 -
 drivers/crypto/cavium/nitrox/nitrox_skcipher.c     |   19 -
 drivers/crypto/ccp/ccp-crypto-aes.c                |   18 -
 drivers/crypto/ccp/ccp-ops.c                       |    5 +-
 drivers/crypto/ccree/cc_aead.c                     |   10 +-
 drivers/crypto/ccree/cc_cipher.c                   |   45 +-
 drivers/crypto/gemini/sl3516-ce-cipher.c           |    4 +-
 drivers/crypto/hifn_795x.c                         |  126 +-
 drivers/crypto/hisilicon/debugfs.c                 |   54 +-
 drivers/crypto/hisilicon/hpre/hpre_main.c          |  122 +-
 drivers/crypto/hisilicon/qm.c                      |  264 ++-
 drivers/crypto/hisilicon/qm_common.h               |    4 -
 drivers/crypto/hisilicon/sec2/sec.h                |    7 +
 drivers/crypto/hisilicon/sec2/sec_crypto.c         |   43 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.h         |    2 -
 drivers/crypto/hisilicon/sec2/sec_main.c           |   72 +-
 drivers/crypto/hisilicon/sgl.c                     |   12 +-
 drivers/crypto/hisilicon/zip/zip_main.c            |  227 +-
 drivers/crypto/inside-secure/safexcel.c            |    4 -
 drivers/crypto/inside-secure/safexcel.h            |    4 -
 drivers/crypto/inside-secure/safexcel_cipher.c     |  171 +-
 drivers/crypto/intel/Kconfig                       |    1 +
 drivers/crypto/intel/Makefile                      |    1 +
 drivers/crypto/intel/iaa/Kconfig                   |   19 +
 drivers/crypto/intel/iaa/Makefile                  |   12 +
 drivers/crypto/intel/iaa/iaa_crypto.h              |  173 ++
 drivers/crypto/intel/iaa/iaa_crypto_comp_fixed.c   |   92 +
 drivers/crypto/intel/iaa/iaa_crypto_main.c         | 2193 ++++++++++++++++++++
 drivers/crypto/intel/iaa/iaa_crypto_stats.c        |  312 +++
 drivers/crypto/intel/iaa/iaa_crypto_stats.h        |   53 +
 drivers/crypto/intel/qat/Kconfig                   |   11 +
 drivers/crypto/intel/qat/Makefile                  |    1 +
 drivers/crypto/intel/qat/qat_420xx/Makefile        |    4 +
 .../crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c |  528 +++++
 .../crypto/intel/qat/qat_420xx/adf_420xx_hw_data.h |   55 +
 drivers/crypto/intel/qat/qat_420xx/adf_drv.c       |  202 ++
 .../crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c   |  339 +--
 .../crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h   |   52 -
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c        |  277 +--
 drivers/crypto/intel/qat/qat_common/Makefile       |    4 +
 .../intel/qat/qat_common/adf_accel_devices.h       |   16 +-
 .../crypto/intel/qat/qat_common/adf_accel_engine.c |    2 +-
 drivers/crypto/intel/qat/qat_common/adf_admin.c    |   37 +
 drivers/crypto/intel/qat/qat_common/adf_admin.h    |    4 +
 .../crypto/intel/qat/qat_common/adf_cfg_common.h   |    1 +
 .../crypto/intel/qat/qat_common/adf_cfg_services.c |   27 +
 .../crypto/intel/qat/qat_common/adf_cfg_services.h |    4 +
 drivers/crypto/intel/qat/qat_common/adf_dbgfs.c    |    3 +
 .../crypto/intel/qat/qat_common/adf_fw_config.h    |   18 +
 .../crypto/intel/qat/qat_common/adf_gen4_config.c  |  287 +++
 .../crypto/intel/qat/qat_common/adf_gen4_config.h  |   11 +
 .../crypto/intel/qat/qat_common/adf_gen4_hw_data.c |  238 +++
 .../crypto/intel/qat/qat_common/adf_gen4_hw_data.h |   87 +
 drivers/crypto/intel/qat/qat_common/adf_gen4_tl.c  |  153 ++
 drivers/crypto/intel/qat/qat_common/adf_gen4_tl.h  |  158 ++
 drivers/crypto/intel/qat/qat_common/adf_init.c     |   12 +
 drivers/crypto/intel/qat/qat_common/adf_rl.c       |    7 +-
 drivers/crypto/intel/qat/qat_common/adf_rl.h       |    1 +
 drivers/crypto/intel/qat/qat_common/adf_sysfs.c    |    6 +-
 .../intel/qat/qat_common/adf_sysfs_ras_counters.c  |    7 +-
 drivers/crypto/intel/qat/qat_common/adf_sysfs_rl.c |    8 +
 .../crypto/intel/qat/qat_common/adf_telemetry.c    |  288 +++
 .../crypto/intel/qat/qat_common/adf_telemetry.h    |   99 +
 .../crypto/intel/qat/qat_common/adf_tl_debugfs.c   |  710 +++++++
 .../crypto/intel/qat/qat_common/adf_tl_debugfs.h   |  117 ++
 .../intel/qat/qat_common/icp_qat_fw_init_admin.h   |   10 +
 drivers/crypto/intel/qat/qat_common/icp_qat_hw.h   |   14 +-
 drivers/crypto/intel/qat/qat_common/icp_qat_uclo.h |    2 +-
 drivers/crypto/intel/qat/qat_common/qat_hal.c      |    6 +-
 drivers/crypto/intel/qat/qat_common/qat_uclo.c     |    1 +
 drivers/crypto/marvell/cesa/cesa.c                 |    6 +-
 drivers/crypto/marvell/octeontx/otx_cptvf_algs.c   |   23 -
 drivers/crypto/marvell/octeontx2/cn10k_cpt.c       |   86 +-
 drivers/crypto/marvell/octeontx2/cn10k_cpt.h       |   27 +
 drivers/crypto/marvell/octeontx2/otx2_cpt_common.h |   54 +-
 .../crypto/marvell/octeontx2/otx2_cpt_devlink.c    |   44 +-
 .../crypto/marvell/octeontx2/otx2_cpt_hw_types.h   |    9 +-
 .../marvell/octeontx2/otx2_cpt_mbox_common.c       |   26 +
 drivers/crypto/marvell/octeontx2/otx2_cpt_reqmgr.h |  298 +++
 drivers/crypto/marvell/octeontx2/otx2_cptlf.c      |  139 +-
 drivers/crypto/marvell/octeontx2/otx2_cptlf.h      |  103 +-
 drivers/crypto/marvell/octeontx2/otx2_cptpf.h      |    4 +
 drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c |   74 +-
 drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c |   82 +-
 .../crypto/marvell/octeontx2/otx2_cptpf_ucode.c    |   49 +-
 .../crypto/marvell/octeontx2/otx2_cptpf_ucode.h    |    3 +-
 drivers/crypto/marvell/octeontx2/otx2_cptvf.h      |    2 +
 drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c |   31 +
 drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.h |    5 +
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c |   29 +-
 drivers/crypto/marvell/octeontx2/otx2_cptvf_mbox.c |   28 +
 .../crypto/marvell/octeontx2/otx2_cptvf_reqmgr.c   |  162 +-
 drivers/crypto/n2_core.c                           |   36 +-
 drivers/crypto/rockchip/rk3288_crypto_skcipher.c   |    4 +-
 drivers/crypto/sa2ul.c                             |    3 +-
 drivers/crypto/sahara.c                            |  845 ++++----
 drivers/crypto/starfive/Kconfig                    |    2 +-
 drivers/crypto/starfive/jh7110-aes.c               |   77 +-
 drivers/crypto/starfive/jh7110-cryp.c              |   20 +-
 drivers/crypto/starfive/jh7110-cryp.h              |   12 +-
 drivers/crypto/starfive/jh7110-rsa.c               |   58 +-
 drivers/crypto/stm32/stm32-crc32.c                 |    2 +-
 drivers/crypto/stm32/stm32-cryp.c                  |    2 +-
 drivers/crypto/virtio/virtio_crypto_common.h       |    2 +
 drivers/crypto/virtio/virtio_crypto_core.c         |   26 +-
 drivers/dma/idxd/Makefile                          |    2 +-
 drivers/dma/idxd/bus.c                             |    6 +
 drivers/dma/idxd/cdev.c                            |    6 +-
 drivers/dma/idxd/defaults.c                        |   53 +
 drivers/dma/idxd/device.c                          |   13 +-
 drivers/dma/idxd/dma.c                             |    9 +-
 drivers/dma/idxd/idxd.h                            |   83 +-
 drivers/dma/idxd/init.c                            |    7 +
 drivers/dma/idxd/irq.c                             |   12 +-
 drivers/dma/idxd/submit.c                          |    9 +-
 include/crypto/hash.h                              |    4 -
 include/crypto/if_alg.h                            |    5 +
 include/crypto/skcipher.h                          |  133 +-
 include/linux/hisi_acc_qm.h                        |   28 +-
 lib/crypto/aesgcm.c                                |   13 +
 lib/crypto/mpi/ec.c                                |    3 +
 tools/crypto/tcrypt/tcrypt_speed_compare.py        |  190 ++
 205 files changed, 10087 insertions(+), 5779 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-driver-qat_telemetry
 create mode 100644 Documentation/crypto/device_drivers/index.rst
 create mode 100644 Documentation/crypto/device_drivers/octeontx2.rst
 create mode 100644 Documentation/devicetree/bindings/crypto/inside-secure,safexcel.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/inside-secure-safexcel.txt
 create mode 100644 Documentation/driver-api/crypto/iaa/iaa-crypto.rst
 create mode 100644 Documentation/driver-api/crypto/iaa/index.rst
 create mode 100644 Documentation/driver-api/crypto/index.rst
 delete mode 100644 crypto/cfb.c
 delete mode 100644 crypto/ofb.c
 create mode 100644 drivers/crypto/intel/iaa/Kconfig
 create mode 100644 drivers/crypto/intel/iaa/Makefile
 create mode 100644 drivers/crypto/intel/iaa/iaa_crypto.h
 create mode 100644 drivers/crypto/intel/iaa/iaa_crypto_comp_fixed.c
 create mode 100644 drivers/crypto/intel/iaa/iaa_crypto_main.c
 create mode 100644 drivers/crypto/intel/iaa/iaa_crypto_stats.c
 create mode 100644 drivers/crypto/intel/iaa/iaa_crypto_stats.h
 create mode 100644 drivers/crypto/intel/qat/qat_420xx/Makefile
 create mode 100644 drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
 create mode 100644 drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.h
 create mode 100644 drivers/crypto/intel/qat/qat_420xx/adf_drv.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_fw_config.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_config.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_config.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_tl.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_tl.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_telemetry.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_telemetry.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.h
 create mode 100644 drivers/dma/idxd/defaults.c
 create mode 100755 tools/crypto/tcrypt/tcrypt_speed_compare.py

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

