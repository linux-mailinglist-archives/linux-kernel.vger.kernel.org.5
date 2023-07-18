Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4103758256
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjGRQoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGRQoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:44:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C026F118;
        Tue, 18 Jul 2023 09:44:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 551246167A;
        Tue, 18 Jul 2023 16:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA8BC433C7;
        Tue, 18 Jul 2023 16:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689698655;
        bh=KHZCd/nJ25NPZ2OT/3SmdbcC2TTHaZIhY3NAbhBmwZA=;
        h=From:To:Cc:Subject:Date:From;
        b=Hk4gNuqjlw71rnaFKtTYOD1RlIjGKSPtpOb3NGuWGucJgWxGU9qNN12WOK7JYplbs
         w20iL3fX87X2XmJEBOfWjQDqIUwDD94tmXVtSWbJ5cYwvH4qwLXhMYdoI5dgRm7CEP
         Ia/97+z8yKw+6JVnTDexLklky70V+7BNk4Ro0Jryc1XNa0Qx/l306qcJFLUC2O+nR9
         fVTmhD619+z0ip+fzGsqZTTT3GrlyafahZSnlI8wNHMor+mpGljqjyVzTL97WkDjMg
         /R0DTXaFLO9FPh5e9W5TngkNixpJlBj9qs0YonNVi/JoiDPuTxO55ZDZNJI5Enzmkk
         CiLuQqWF5glnA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [GIT PULL] tpmdd changes for v6.5-rc3
Date:   Tue, 18 Jul 2023 19:43:48 +0300
Message-Id: <20230718164348.35519-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.5-rc3

for you to fetch changes up to 481c2d14627de8ecbb54dd125466e4b4a5069b47:

  tpm,tpm_tis: Disable interrupts after 1000 unhandled IRQs (2023-07-17 19:40:27 +0000)

----------------------------------------------------------------
Hi Linus,

This the trimmed down version of the previous pull request.

BR, Jarkko

----------------------------------------------------------------
Alexander Sverdlin (2):
      tpm: tis_i2c: Limit read bursts to I2C_SMBUS_BLOCK_MAX (32) bytes
      tpm: tis_i2c: Limit write bursts to I2C_SMBUS_BLOCK_MAX (32) bytes

Christian Hesse (2):
      tpm/tpm_tis: Disable interrupts for Framework Laptop Intel 12th gen
      tpm/tpm_tis: Disable interrupts for Framework Laptop Intel 13th gen

Florian Bezdeka (1):
      tpm/tpm_tis: Disable interrupts for Lenovo L590 devices

Jarkko Sakkinen (1):
      tpm: tpm_vtpm_proxy: fix a race condition in /dev/vtpmx creation

Jerry Snitselaar (1):
      tpm: return false from tpm_amd_is_rng_defective on non-x86 platforms

Jiapeng Chong (1):
      security: keys: Modify mismatched function name

Lino Sanfilippo (1):
      tpm,tpm_tis: Disable interrupts after 1000 unhandled IRQs

Peijie Shao (1):
      tpm_tis_spi: Release chip select when flow control fails

Peter Ujfalusi (1):
      tpm: tpm_tis: Disable interrupts *only* for AEON UPX-i11

Petr Pavlu (1):
      keys: Fix linking a duplicate key to a keyring's assoc_array

Valentin David (1):
      tpm: Do not remap from ACPI resources again for Pluton TPM

 drivers/char/tpm/tpm-chip.c               |   7 ++
 drivers/char/tpm/tpm_crb.c                |  19 +++---
 drivers/char/tpm/tpm_tis.c                |  25 ++++++++
 drivers/char/tpm/tpm_tis_core.c           | 103 +++++++++++++++++++++++++-----
 drivers/char/tpm/tpm_tis_core.h           |   4 ++
 drivers/char/tpm/tpm_tis_i2c.c            |  59 ++++++++++-------
 drivers/char/tpm/tpm_tis_spi_main.c       |   8 +++
 drivers/char/tpm/tpm_vtpm_proxy.c         |  30 ++-------
 security/keys/request_key.c               |  35 ++++++----
 security/keys/trusted-keys/trusted_tpm2.c |   2 +-
 10 files changed, 212 insertions(+), 80 deletions(-)
