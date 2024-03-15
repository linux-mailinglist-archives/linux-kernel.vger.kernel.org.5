Return-Path: <linux-kernel+bounces-104005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E02787C7D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413F4282A37
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C89D27A;
	Fri, 15 Mar 2024 03:04:49 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F213B1A38CB;
	Fri, 15 Mar 2024 03:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710471888; cv=none; b=m+4GCuOc+U1EccSMi/6O/AbnvdTSN5oxnF7uEWRAFgZF8tA+iSqQICQ0k9/opSRUt+nic3y70rUk/2MWg9R9u/A/ZisOFJT7CdV5IHTxCQw5egnLt7I6c8GyTDCSu76NoXap8XcXz0XQNTV65nYm2JK/d3UhwJ5ZSUWi6tsa6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710471888; c=relaxed/simple;
	bh=7wi83nSP/1otgJQLcJFZSU4RN4Mcccw45f4EVT19BME=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA/XPSasOmtbpr+XuCbmsJM7wfZOeGEwglp4K+F8ndf8ZV1NCFaV89ikDLb+1lI3/gZdGlEjtc93RaoAJ3XafffeUabB9ddkcanelvDRSb6rIJPJGa9QSx2xRy4dznSG/bLTJAjZ5T859Mr3inwuR+nvcCW9veZN5eoGrjPufu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rkxrw-007Bk4-Vi; Fri, 15 Mar 2024 11:04:30 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 Mar 2024 11:04:44 +0800
Date: Fri, 15 Mar 2024 11:04:44 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Update for 6.9
Message-ID: <ZfO6zKtvp2jSO4vF@gondor.apana.org.au>
References: <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
 <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
 <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au>

Hi Linus:

The following changes since commit c5a2f74db71a849f3a60bc153d684d6d28a0c665:

  crypto: caam - fix asynchronous hash (2024-01-26 16:35:55 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.9-p1 

for you to fetch changes up to 6a8dbd71a70620c42d4fa82509204ba18231f28d:

  Revert "crypto: remove CONFIG_CRYPTO_STATS" (2024-03-13 09:49:37 +0800)

----------------------------------------------------------------
This update includes the following changes:

API:

- Avoid unnecessary copying in scomp for trivial SG lists.

Algorithms:

- Optimise NEON CCM implementation on ARM64.

Drivers:

- Add queue stop/query debugfs support in hisilicon/qm.
----------------------------------------------------------------

Adam Guerin (6):
      crypto: qat - remove unused macros in qat_comp_alg.c
      crypto: qat - removed unused macro in adf_cnv_dbgfs.c
      crypto: qat - avoid division by zero
      crypto: qat - remove double initialization of value
      crypto: qat - remove unnecessary description from comment
      crypto: qat - fix comment structure

Ard Biesheuvel (8):
      crypto: arm64/aes-ccm - Revert "Rewrite skcipher walker loop"
      crypto: arm64/aes-ccm - Keep NEON enabled during skcipher walk
      crypto: arm64/aes-ccm - Pass short inputs via stack buffer
      crypto: arm64/aes-ccm - Replace bytewise tail handling with NEON permute
      crypto: arm64/aes-ccm - Reuse existing MAC update for AAD input
      crypto: arm64/aes-ccm - Cache round keys and unroll AES loops
      crypto: arm64/aes-ccm - Merge encrypt and decrypt tail handling
      crypto: arm64/aes-ccm - Merge finalization into en/decrypt asm helpers

Arnd Bergmann (2):
      crypto: qat - avoid memcpy() overflow warning
      crypto: arm/sha - fix function cast warnings

Barry Song (3):
      crypto: hisilicon/zip - fix the missing CRYPTO_ALG_ASYNC in cra_flags
      crypto: iaa - fix the missing CRYPTO_ALG_ASYNC in cra_flags
      crypto: scomp - remove memcpy if sg_nents is 1 and pages are lowmem

Borislav Petkov (AMD) (1):
      crypto: ccp - State in dmesg that TSME is enabled

Clay Chang (1):
      KEYS: include header for EINVAL definition

Colin Ian King (2):
      crypto: pcbc - remove redundant assignment to nbytes
      crypto: asymmetric_keys - remove redundant pointer secs

Damian Muszynski (7):
      crypto: qat - add heartbeat error simulator
      crypto: qat - add auto reset on error
      crypto: qat - change SLAs cleanup flow at shutdown
      crypto: qat - resolve race condition during AER recovery
      crypto: qat - fix ring to service map for dcc in 4xxx
      crypto: qat - fix ring to service map for dcc in 420xx
      crypto: qat - make ring to service map common for QAT GEN4

Dan Carpenter (1):
      crypto: qat - uninitialized variable in adf_hb_error_inject_write()

Danny Tsen (1):
      crypto: vmx - Move to arch/powerpc/crypto

David Wronek (1):
      dt-bindings: crypto: ice: Document SC7180 inline crypto engine

Eric Biggers (2):
      crypto: ahash - unexport crypto_hash_alg_has_setkey()
      crypto: remove CONFIG_CRYPTO_STATS

Erick Archer (2):
      crypto: sun8i-ce - Use kcalloc() instead of kzalloc()
      crypto: qat - use kcalloc_node() instead of kzalloc_node()

Furong Zhou (3):
      crypto: qat - add fatal error notify method
      crypto: qat - disable arbitration before reset
      crypto: qat - limit heartbeat notifications

Giovanni Cabiddu (1):
      Documentation: qat: fix auto_reset section

Herbert Xu (2):
      crypto: dh - Make public key test FIPS-only
      Revert "crypto: remove CONFIG_CRYPTO_STATS"

Joachim Vandersmissen (2):
      crypto: testmgr - remove unused xts4096 and xts512 algorithms from testmgr.c
      crypto: rsa - restrict plaintext/ciphertext values more

Kilian Zinnecker (1):
      crypto: rockchip - fix to check return value

Li RongQing (1):
      crypto: virtio - remove duplicate check if queue is broken

Luca Weiss (1):
      dt-bindings: qcom-qce: Add compatible for SM6350

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entries after crypto vmx file movement

Mario Limonciello (2):
      crypto: ccp - Avoid discarding errors in psp_send_platform_access_msg()
      crypto: ccp - Update return values for some unit tests

Markus Elfring (1):
      crypto: virtio - Less function calls in __virtio_crypto_akcipher_do_req() after error detection

Martin Kaiser (1):
      hwrng: hisi - use dev_err_probe

Minjie Du (1):
      crypto: iaa - Remove unnecessary debugfs_create_dir() error check in iaa_crypto_debugfs_init()

Mun Chun Yep (4):
      crypto: qat - update PFVF protocol for recovery
      crypto: qat - re-enable sriov after pf reset
      crypto: qat - add fatal error notification
      crypto: qat - improve aer error reset handling

Qi Tao (3):
      crypto: hisilicon/sec2 - updates the sec DFX function register
      crypto: hisilicon/sec2 - modify nested macro call
      crypto: hisilicon/sec2 - fix some cleanup issues

Quanyang Wang (1):
      crypto: xilinx - call finalize with bh disabled

Randy Dunlap (1):
      crypto: jitter - fix CRYPTO_JITTERENTROPY help text

Tom Zanussi (3):
      crypto: iaa - Remove header table code
      crypto: iaa - Fix async_disable descriptor leak
      crypto: iaa - Fix comp/decomp delay statistics

Tudor Ambarus (1):
      MAINTAINERS: Remove T Ambarus from few mchp entries

Varshini Rajendran (4):
      dt-bindings: crypto: add sam9x7 in Atmel AES
      dt-bindings: crypto: add sam9x7 in Atmel SHA
      dt-bindings: crypto: add sam9x7 in Atmel TDES
      dt-bindings: rng: atmel,at91-trng: add sam9x7 TRNG

Vladis Dronov (1):
      crypto: tcrypt - add ffdhe2048(dh) test

Weili Qian (5):
      crypto: hisilicon/qm - support get device state
      crypto: hisilicon/qm - dump important registers values before resetting
      crypto: hisilicon/qm - add stop function by hardware
      crypto: hisilicon/qm - obtain stop queue status
      crypto: hisilicon/qm - change function type to void

Wenkai Lin (2):
      crypto: hisilicon - Fix smp_processor_id() warnings
      crypto: hisilicon/sec - remove unused parameter

 Documentation/ABI/testing/debugfs-driver-qat       |  26 ++
 Documentation/ABI/testing/debugfs-hisi-hpre        |  22 ++
 Documentation/ABI/testing/debugfs-hisi-sec         |  22 ++
 Documentation/ABI/testing/debugfs-hisi-zip         |  22 ++
 Documentation/ABI/testing/sysfs-driver-qat         |  20 ++
 .../bindings/crypto/atmel,at91sam9g46-aes.yaml     |   6 +-
 .../bindings/crypto/atmel,at91sam9g46-sha.yaml     |   6 +-
 .../bindings/crypto/atmel,at91sam9g46-tdes.yaml    |   6 +-
 .../bindings/crypto/qcom,inline-crypto-engine.yaml |   1 +
 .../devicetree/bindings/crypto/qcom-qce.yaml       |   1 +
 .../devicetree/bindings/rng/atmel,at91-trng.yaml   |   4 +
 MAINTAINERS                                        |  25 +-
 arch/arm/crypto/sha256_glue.c                      |  13 +-
 arch/arm/crypto/sha512-glue.c                      |  12 +-
 arch/arm64/crypto/Kconfig                          |   1 +
 arch/arm64/crypto/aes-ce-ccm-core.S                | 265 ++++++++-------------
 arch/arm64/crypto/aes-ce-ccm-glue.c                | 154 ++++++++----
 arch/arm64/crypto/aes-glue.c                       |   1 +
 arch/powerpc/crypto/Kconfig                        |  20 ++
 arch/powerpc/crypto/Makefile                       |  20 +-
 {drivers/crypto/vmx => arch/powerpc/crypto}/aes.c  |   0
 .../crypto/vmx => arch/powerpc/crypto}/aes_cbc.c   |   0
 .../crypto/vmx => arch/powerpc/crypto}/aes_ctr.c   |   0
 .../crypto/vmx => arch/powerpc/crypto}/aes_xts.c   |   0
 .../crypto/vmx => arch/powerpc/crypto}/aesp8-ppc.h |   0
 .../vmx => arch/powerpc/crypto}/aesp8-ppc.pl       |   0
 .../crypto/vmx => arch/powerpc/crypto}/ghash.c     |   0
 .../vmx => arch/powerpc/crypto}/ghashp8-ppc.pl     |   0
 {drivers/crypto/vmx => arch/powerpc/crypto}/vmx.c  |   0
 crypto/Kconfig                                     |   5 +-
 crypto/ahash.c                                     |  21 +-
 crypto/asymmetric_keys/verify_pefile.c             |   4 +-
 crypto/dh.c                                        |  63 ++---
 crypto/pcbc.c                                      |   4 +-
 crypto/rsa.c                                       |  36 ++-
 crypto/scompress.c                                 |  38 ++-
 crypto/tcrypt.c                                    |   3 +
 crypto/testmgr.c                                   |   8 -
 drivers/char/hw_random/hisi-rng.c                  |   6 +-
 drivers/crypto/Kconfig                             |  14 +-
 drivers/crypto/Makefile                            |   2 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c  |   2 +-
 drivers/crypto/ccp/platform-access.c               |  11 +-
 drivers/crypto/ccp/psp-dev.c                       |  11 +-
 drivers/crypto/hisilicon/debugfs.c                 |  58 +++++
 drivers/crypto/hisilicon/hpre/hpre_main.c          |   2 +-
 drivers/crypto/hisilicon/qm.c                      | 184 +++++++++-----
 drivers/crypto/hisilicon/sec2/sec_crypto.c         |  33 +--
 drivers/crypto/hisilicon/sec2/sec_main.c           |   7 +-
 drivers/crypto/hisilicon/zip/zip_crypto.c          |   1 +
 drivers/crypto/hisilicon/zip/zip_main.c            |   2 +-
 drivers/crypto/intel/iaa/iaa_crypto.h              |  25 --
 drivers/crypto/intel/iaa/iaa_crypto_comp_fixed.c   |   1 -
 drivers/crypto/intel/iaa/iaa_crypto_main.c         | 122 ++--------
 drivers/crypto/intel/iaa/iaa_crypto_stats.c        |  30 ---
 drivers/crypto/intel/iaa/iaa_crypto_stats.h        |   8 +-
 drivers/crypto/intel/qat/Kconfig                   |  14 ++
 .../crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c |  64 ++---
 .../crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c   |  64 ++---
 drivers/crypto/intel/qat/qat_common/Makefile       |   2 +
 .../intel/qat/qat_common/adf_accel_devices.h       |   3 +
 drivers/crypto/intel/qat/qat_common/adf_aer.c      | 138 ++++++++++-
 .../crypto/intel/qat/qat_common/adf_cfg_strings.h  |   1 +
 drivers/crypto/intel/qat/qat_common/adf_clock.c    |   3 +
 .../crypto/intel/qat/qat_common/adf_cnv_dbgfs.c    |   1 -
 .../crypto/intel/qat/qat_common/adf_common_drv.h   |  10 +
 drivers/crypto/intel/qat/qat_common/adf_dev_mgr.c  |   4 +-
 .../crypto/intel/qat/qat_common/adf_gen4_hw_data.c |  59 +++++
 .../crypto/intel/qat/qat_common/adf_gen4_hw_data.h |   1 +
 drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c |   6 +-
 .../crypto/intel/qat/qat_common/adf_heartbeat.c    |  20 +-
 .../crypto/intel/qat/qat_common/adf_heartbeat.h    |  21 ++
 .../intel/qat/qat_common/adf_heartbeat_dbgfs.c     |  53 +++++
 .../intel/qat/qat_common/adf_heartbeat_inject.c    |  76 ++++++
 .../crypto/intel/qat/qat_common/adf_hw_arbiter.c   |  25 ++
 drivers/crypto/intel/qat/qat_common/adf_init.c     |  12 +
 drivers/crypto/intel/qat/qat_common/adf_isr.c      |  11 +-
 drivers/crypto/intel/qat/qat_common/adf_pfvf_msg.h |   7 +-
 .../crypto/intel/qat/qat_common/adf_pfvf_pf_msg.c  |  64 ++++-
 .../crypto/intel/qat/qat_common/adf_pfvf_pf_msg.h  |  21 ++
 .../intel/qat/qat_common/adf_pfvf_pf_proto.c       |   8 +
 .../intel/qat/qat_common/adf_pfvf_vf_proto.c       |   6 +
 drivers/crypto/intel/qat/qat_common/adf_rl.c       |  20 +-
 drivers/crypto/intel/qat/qat_common/adf_sriov.c    |  38 ++-
 drivers/crypto/intel/qat/qat_common/adf_sysfs.c    |  37 +++
 drivers/crypto/intel/qat/qat_common/adf_vf_isr.c   |   2 -
 .../crypto/intel/qat/qat_common/qat_comp_algs.c    |   9 -
 drivers/crypto/intel/qat/qat_common/qat_crypto.c   |   4 +-
 drivers/crypto/rockchip/rk3288_crypto.c            |   5 +
 .../crypto/virtio/virtio_crypto_akcipher_algs.c    |  12 +-
 drivers/crypto/virtio/virtio_crypto_core.c         |   2 -
 drivers/crypto/vmx/.gitignore                      |   3 -
 drivers/crypto/vmx/Kconfig                         |  14 --
 drivers/crypto/vmx/Makefile                        |  23 --
 drivers/crypto/vmx/ppc-xlate.pl                    | 231 ------------------
 drivers/crypto/xilinx/zynqmp-aes-gcm.c             |   3 +
 include/crypto/internal/hash.h                     |   2 -
 include/crypto/public_key.h                        |   1 +
 include/linux/hisi_acc_qm.h                        |  10 +-
 tools/crypto/ccp/test_dbc.py                       |   8 +-
 100 files changed, 1450 insertions(+), 1016 deletions(-)
 rename {drivers/crypto/vmx => arch/powerpc/crypto}/aes.c (100%)
 rename {drivers/crypto/vmx => arch/powerpc/crypto}/aes_cbc.c (100%)
 rename {drivers/crypto/vmx => arch/powerpc/crypto}/aes_ctr.c (100%)
 rename {drivers/crypto/vmx => arch/powerpc/crypto}/aes_xts.c (100%)
 rename {drivers/crypto/vmx => arch/powerpc/crypto}/aesp8-ppc.h (100%)
 rename {drivers/crypto/vmx => arch/powerpc/crypto}/aesp8-ppc.pl (100%)
 rename {drivers/crypto/vmx => arch/powerpc/crypto}/ghash.c (100%)
 rename {drivers/crypto/vmx => arch/powerpc/crypto}/ghashp8-ppc.pl (100%)
 rename {drivers/crypto/vmx => arch/powerpc/crypto}/vmx.c (100%)
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_heartbeat_inject.c
 delete mode 100644 drivers/crypto/vmx/.gitignore
 delete mode 100644 drivers/crypto/vmx/Kconfig
 delete mode 100644 drivers/crypto/vmx/Makefile
 delete mode 100644 drivers/crypto/vmx/ppc-xlate.pl

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

