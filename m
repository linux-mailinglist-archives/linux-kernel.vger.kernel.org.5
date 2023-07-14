Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478DD754266
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbjGNSOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbjGNSOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:14:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CD93A8B;
        Fri, 14 Jul 2023 11:14:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AF3D61D96;
        Fri, 14 Jul 2023 18:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2260DC433C7;
        Fri, 14 Jul 2023 18:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689358437;
        bh=nVZL7RlxRXIjaRFfK62a2o5A3geyjYMe5I9/3v5xSZ4=;
        h=From:To:Cc:Subject:Date:From;
        b=WmTXcQFOgByfSWynr0rdqdM+XengPBpavhvU9Vo/Ntaybu3Mj97iSkTkMc/TLW0PY
         z5djKYkMamkSmUG8rRDdSQHK60xH+W4A7vgPAz4C3QMFeg4tvyPYlJ7cVOEi9tWm8g
         +MDSi7r/bnx/qu8FPlFq44KAK6fbGmoiSTLPLDtPQSQ5eHs+5lKXZMNDZ3qLtHyneN
         /hcb6+YJOCUfOCeSOdit6hqpVMAH+irUFoivXZOe4APFOLncHDM+skh8cEXYbpCIzP
         MOznCmhxXsTtstBkZftczZc2gyVeay9wXGmQqmPpgK37Im0/pLQ4kN9JtJa4RrwNFo
         eCC3hDTx5cELA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] tpmdd changes for v6.5-rc2
Date:   Fri, 14 Jul 2023 18:13:25 +0000
Message-Id: <20230714181325.3351-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4b810bf037e524b54669acbe4e0df54b15d87ea1:

  Merge tag 'erofs-for-6.5-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs (2023-07-13 14:35:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/jarkko/linux-tpmdd.git/ tpmdd-v6.5-rc2-fixed

for you to fetch changes up to 0ec1b5bea32bce719ebdab253462f9c9cb0aca3e:

  tpm,tpm_tis: Disable interrupts after 1000 unhandled IRQs (2023-07-14 06:38:04 +0000)

----------------------------------------------------------------
Hi Linus,

This comes late but it is really just a flush of bug fixes for the most
part. I've also hold for some tpm_tis IRQ fixes. And holiday season in
FI has caused some slow downs and conflicts between personal and work
life.

BR, Jarkko

----------------------------------------------------------------
Alexander Steffen (4):
      tpm_tis: Explicitly check for error code
      tpm_tis: Move CRC check to generic send routine
      tpm_tis: Use responseRetry to recover from data transfer errors
      tpm_tis: Resend command to recover from data transfer errors

Alexander Sverdlin (2):
      tpm: tis_i2c: Limit read bursts to I2C_SMBUS_BLOCK_MAX (32) bytes
      tpm: tis_i2c: Limit write bursts to I2C_SMBUS_BLOCK_MAX (32) bytes

Azeem Shaikh (1):
      KEYS: Replace all non-returning strlcpy with strscpy

Christian Göttsche (1):
      security: keys: perform capable check only on privileged operations

Christian Hesse (2):
      tpm/tpm_tis: Disable interrupts for Framework Laptop Intel 12th gen
      tpm/tpm_tis: Disable interrupts for Framework Laptop Intel 13th gen

Colin Ian King (1):
      tpm: remove redundant variable len

Eric Snowberg (2):
      KEYS: DigitalSignature link restriction
      integrity: Enforce digitalSignature usage in the ima and evm keyrings

Florian Bezdeka (1):
      tpm/tpm_tis: Disable interrupts for Lenovo L590 devices

Ivan Orlov (1):
      tpm: make all 'class' structures const

Jarkko Sakkinen (1):
      tpm: tpm_vtpm_proxy: fix a race condition in /dev/vtpmx creation

Jerry Snitselaar (1):
      tpm: return false from tpm_amd_is_rng_defective on non-x86 platforms

Jiapeng Chong (1):
      security: keys: Modify mismatched function name

Krishna Yarlagadda (1):
      tpm_tis-spi: Add hardware wait polling

Lino Sanfilippo (1):
      tpm,tpm_tis: Disable interrupts after 1000 unhandled IRQs

Peijie Shao (1):
      tpm_tis_spi: Release chip select when flow control fails

Peter Ujfalusi (1):
      tpm: tpm_tis: Disable interrupts *only* for AEON UPX-i11

Petr Pavlu (1):
      keys: Fix linking a duplicate key to a keyring's assoc_array

Uwe Kleine-König (1):
      tpm: Switch i2c drivers back to use .probe()

Valentin David (1):
      tpm: Do not remap from ACPI resources again for Pluton TPM

 certs/system_keyring.c                    |  49 +++++++++
 crypto/asymmetric_keys/restrict.c         |  44 ++++++++
 drivers/char/tpm/eventlog/tpm1.c          |   3 +-
 drivers/char/tpm/st33zp24/i2c.c           |   2 +-
 drivers/char/tpm/tpm-chip.c               |  18 +++-
 drivers/char/tpm/tpm-interface.c          |  21 ++--
 drivers/char/tpm/tpm.h                    |   4 +-
 drivers/char/tpm/tpm2-space.c             |   2 +-
 drivers/char/tpm/tpm_crb.c                |  19 ++--
 drivers/char/tpm/tpm_i2c_atmel.c          |   2 +-
 drivers/char/tpm/tpm_i2c_infineon.c       |   2 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c        |   2 +-
 drivers/char/tpm/tpm_tis.c                |  25 +++++
 drivers/char/tpm/tpm_tis_core.c           | 172 ++++++++++++++++++++++++------
 drivers/char/tpm/tpm_tis_core.h           |   5 +
 drivers/char/tpm/tpm_tis_i2c.c            |  61 +++++++----
 drivers/char/tpm/tpm_tis_i2c_cr50.c       |   2 +-
 drivers/char/tpm/tpm_tis_spi_main.c       |  99 ++++++++++++++++-
 drivers/char/tpm/tpm_vtpm_proxy.c         |  30 ++----
 include/crypto/public_key.h               |  11 ++
 include/keys/system_keyring.h             |  10 ++
 security/integrity/digsig.c               |   4 +-
 security/integrity/evm/Kconfig            |   3 +-
 security/integrity/ima/Kconfig            |   3 +-
 security/keys/keyctl.c                    |  11 +-
 security/keys/request_key.c               |  35 ++++--
 security/keys/request_key_auth.c          |   2 +-
 security/keys/trusted-keys/trusted_tpm2.c |   2 +-
 28 files changed, 509 insertions(+), 134 deletions(-)
