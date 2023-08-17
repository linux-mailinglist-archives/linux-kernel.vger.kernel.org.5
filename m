Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6A577FEEF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354669AbjHQUUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345854AbjHQUTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:19:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDE5359C;
        Thu, 17 Aug 2023 13:19:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2058563036;
        Thu, 17 Aug 2023 20:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15F4C433C7;
        Thu, 17 Aug 2023 20:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692303581;
        bh=iMf2k4nTwKFBthKBVaGzMKaPqXWT9IOPKgKnd4BzqjY=;
        h=From:To:Cc:Subject:Date:From;
        b=TyEDhq5CPlrq0hhaapkmPTDUQ7x5K7LNM9h1XUK2NoxspiSXD6mv6WyZzvGd6ueTQ
         aIcX3SCtQjjvNC+zwsNBZKRiSd+M8yig7hs0HgsHwjfeouMOEZbt1y8BfTRs8hTg8/
         FvjVqVQS0s74XYLm+elhrOYmTEo8DS91FPkaRiYydWzgXk6sJlg+8U6bXyi2iLkj/B
         a1l1Ig2BZ8DoODRiYc5VcQGfUe6Ry23QfpwL1nzEvlHEw91qSM16lcOapSUvPNczvR
         Xm14YmbXlOFW9BEPsIg/sxAIkElQKOB5ewcDfAby4mXKM8gIbRSRKht4QvfGHq6Ja5
         VwHlg53H4v4PA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [GIT PULL] tpmdd changes for v6.6
Date:   Thu, 17 Aug 2023 20:19:35 +0000
Message-Id: <20230817201935.31399-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Merge tag 'nfsd-6.5-4' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux (2023-08-17 16:38:48 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.6

for you to fetch changes up to 218a2680624cba1611e3dfc7d9b646d240e5f855:

  certs: Reference revocation list for all keyrings (2023-08-17 20:12:41 +0000)

----------------------------------------------------------------
Hi,

Contents:

- Restrict linking of keys to .ima and .evm keyrings based on
  digitalSignature attribute in the certificate.
- PowerVM: load machine owner keys into the .machine [1] keyring.
- PowerVM: load module signing keys into the secondary trusted keyring
  (keys blessed by the vendor).
- tpm_tis_spi: half-duplex transfer mode
- tpm_tis: retry corrupted transfers
- Apply revocation list (.mokx) to an all system keyrings (e.g. .machine
  keyring).

[1] https://blogs.oracle.com/linux/post/the-machine-keyring

BR, Jarkko

----------------------------------------------------------------
Alexander Steffen (3):
      tpm_tis: Move CRC check to generic send routine
      tpm_tis: Use responseRetry to recover from data transfer errors
      tpm_tis: Resend command to recover from data transfer errors

Azeem Shaikh (1):
      KEYS: Replace all non-returning strlcpy with strscpy

Colin Ian King (1):
      tpm: remove redundant variable len

Eric Snowberg (3):
      KEYS: DigitalSignature link restriction
      integrity: Enforce digitalSignature usage in the ima and evm keyrings
      certs: Reference revocation list for all keyrings

Jarkko Sakkinen (1):
      tpm_tis: Revert "tpm_tis: Disable interrupts on ThinkPad T490s"

Krishna Yarlagadda (1):
      tpm_tis_spi: Add hardware wait polling

Li Zetao (1):
      tpm/tpm_tis_synquacer: Use module_platform_driver macro to simplify the code

Nayna Jain (6):
      integrity: PowerVM support for loading CA keys on machine keyring
      integrity: ignore keys failing CA restrictions on non-UEFI platform
      integrity: remove global variable from machine_keyring.c
      integrity: check whether imputed trust is enabled
      integrity: PowerVM machine keyring enablement
      integrity: PowerVM support for loading third party code signing keys

 Documentation/admin-guide/kernel-parameters.txt    |  7 ++
 certs/system_keyring.c                             | 91 +++++++++++++++++++--
 crypto/asymmetric_keys/restrict.c                  | 44 ++++++++++
 drivers/char/tpm/eventlog/tpm1.c                   |  3 +-
 drivers/char/tpm/tpm_tis.c                         | 93 +---------------------
 drivers/char/tpm/tpm_tis_core.c                    | 60 ++++++++++----
 drivers/char/tpm/tpm_tis_core.h                    |  1 +
 drivers/char/tpm/tpm_tis_spi_main.c                | 91 ++++++++++++++++++++-
 drivers/char/tpm/tpm_tis_synquacer.c               | 18 +----
 include/crypto/public_key.h                        | 12 +++
 include/keys/system_keyring.h                      | 14 ++++
 security/integrity/Kconfig                         |  4 +-
 security/integrity/digsig.c                        |  6 +-
 security/integrity/evm/Kconfig                     |  3 +-
 security/integrity/ima/Kconfig                     |  3 +-
 security/integrity/integrity.h                     |  5 +-
 .../integrity/platform_certs/keyring_handler.c     | 19 ++++-
 .../integrity/platform_certs/keyring_handler.h     | 10 +++
 security/integrity/platform_certs/load_powerpc.c   | 34 ++++++++
 .../integrity/platform_certs/machine_keyring.c     | 22 ++++-
 security/keys/request_key_auth.c                   |  2 +-
 21 files changed, 394 insertions(+), 148 deletions(-)
