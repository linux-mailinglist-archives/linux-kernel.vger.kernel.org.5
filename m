Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C75753A44
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbjGNL6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjGNL60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:58:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B58211C;
        Fri, 14 Jul 2023 04:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE9CB61CF4;
        Fri, 14 Jul 2023 11:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD533C433C9;
        Fri, 14 Jul 2023 11:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689335904;
        bh=2/ArIUkFK5gcTofUVa+xOOtuchKM3rATFTnSn/dCsUM=;
        h=From:To:Cc:Subject:Date:From;
        b=mWtLPz/rBJaWCY1FHPGg/aLPqOcnzj48KUmNI3yH2um2ixXcnZEJb2c12CF5R8zHb
         QuqAy/LL49OT9blYlr8l17/I9iE+i4tTuWpH+4woJQ9xpmjWmNu76nB16BrV3WYCve
         grHAbfeCGXK2tdLHf+FGeODowjsnoHkRDPhQ2llKsMj8Um51XQonDkxpae+5rUtEp3
         43dHVxzYWIACI7re7gjntDr5YkjQmeKtT7/i2IiWOwirAAG7QFBk9OHjV761g7xojO
         Yxy60d4Y2LMmKvoZBN58elZhE7VN5Zvn3FIeQLdcDdXoMuMoNIyVMcTNxK2X4HC1pK
         uaRBJbkgXjOXA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] tpmdd changes for v6.5-rc2
Date:   Fri, 14 Jul 2023 11:58:03 +0000
Message-Id: <20230714115803.111346-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4b810bf037e524b54669acbe4e0df54b15d87ea1:

  Merge tag 'erofs-for-6.5-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs (2023-07-13 14:35:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkkojs/linux-tpmdd.git/ tpmdd-v6.5-rc2

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
