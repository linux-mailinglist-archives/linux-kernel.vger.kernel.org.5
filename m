Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DB1767584
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjG1Sev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbjG1Sda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:33:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E964488;
        Fri, 28 Jul 2023 11:33:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F12B621B1;
        Fri, 28 Jul 2023 18:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8285C433C7;
        Fri, 28 Jul 2023 18:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690569208;
        bh=+48uYUbulAYjXZZuYUhEs0ufhSocbE0poGoccmjKNF4=;
        h=From:To:Cc:Subject:Date:From;
        b=F2Haz54WQ4HPZugo6nR/APznE3S+XjikZ+ePFVADT+ds6YRAJuSy9ymsiltWGolR1
         zxy9oRcdGoDhacFCiqWVe3Mxh6I7xVk/LfqYokDY6DcenTf6NPnUp6/6FFpStuC1uO
         h7f8RfdbPdJgqDec8OuQGc6Y+4PxUsVBkazjX257dWxJ+8sQTpH4CdrLQaTc8SXjbz
         oBNncB5n6uKYszJtVoeN+rQIKNdTV7jbq8z4t+8dbGHD18S5/r8L2MTnK/Htdih85n
         00cr3PwCkPfOpKH02TP/DXvPuC+Q3MGR/TxIMn44R6FaQno2U4n5WExxSn6tp4dqRu
         O2rl87cpvSqWA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [GIT PULL] tpmdd changes for v6.5-rc4
Date:   Fri, 28 Jul 2023 18:33:22 +0000
Message-Id: <20230728183322.16359-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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

  Merge tag 'net-6.5-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-07-27 12:27:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.5-rc4

for you to fetch changes up to 513253f8c293c0c8bd46d09d337fc892bf8f9f48:

  tpm_tis: Explicitly check for error code (2023-07-28 18:13:39 +0000)

----------------------------------------------------------------
Hi,

I picked three small scale updates from my 'master' branch, which I think
would improve the quality of the release.

BR, Jarkko

----------------------------------------------------------------
Alexander Steffen (1):
      tpm_tis: Explicitly check for error code

Christian Göttsche (1):
      security: keys: perform capable check only on privileged operations

Uwe Kleine-König (1):
      tpm: Switch i2c drivers back to use .probe()

 drivers/char/tpm/st33zp24/i2c.c     |  2 +-
 drivers/char/tpm/tpm_i2c_atmel.c    |  2 +-
 drivers/char/tpm/tpm_i2c_infineon.c |  2 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c  |  2 +-
 drivers/char/tpm/tpm_tis_core.c     |  9 +++++++--
 drivers/char/tpm/tpm_tis_i2c.c      |  2 +-
 drivers/char/tpm/tpm_tis_i2c_cr50.c |  2 +-
 security/keys/keyctl.c              | 11 ++++++++---
 8 files changed, 21 insertions(+), 11 deletions(-)
