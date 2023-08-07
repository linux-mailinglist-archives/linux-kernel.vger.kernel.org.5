Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D93772E88
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjHGTKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjHGTKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:10:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B00510F7;
        Mon,  7 Aug 2023 12:10:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28AE26217C;
        Mon,  7 Aug 2023 19:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9BCC433C7;
        Mon,  7 Aug 2023 19:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691435442;
        bh=VZdvkZW5VU7ZVM1yMeC1WaXZnebwezMbAiJaja9tidg=;
        h=From:To:Cc:Subject:Date:From;
        b=D/SctkxGJzucLunDmysK9iC5PaJ4Ldm++PRMxccoxq+jU7p8gwGj+eZWVr88gU4On
         +MFfkH/jFfiydU3aIo/PTR98sJyDywt2JnlSsBJhwEmiW5oEEVDHEBrJfwqd9iOz8d
         tBPpQ9dWOe0EersZG6J17difqgbMDVdeiPGEJ/4wlCO2sNbwxGtcb93UcUqJf3cYqM
         XFXD0b3DT1ARSMTBjyqVSHz4qwRIylVBr3tjxVhGxLj8GhyE/dW9VQCOfG1jtvGGnn
         xlsnQ0QHBDm+lPXSxk4YKv30xMqBqlu6QyrJJGYXpTGt7eYFT/hN9fkp+IBTiSEIe1
         G2lEWlbxEStoQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [GIT PULL] tpmdd changes for v6.5-rc6
Date:   Mon,  7 Aug 2023 19:10:36 +0000
Message-Id: <20230807191037.103938-1-jarkko@kernel.org>
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

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2023-08-07 10:18:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.5-rc6

for you to fetch changes up to e117e7adc637e364b599dc766f1d740698e7e027:

  tpm/tpm_tis: Disable interrupts for Lenovo P620 devices (2023-08-07 18:01:01 +0000)

----------------------------------------------------------------
Hi,

contains a few more bug fixes.

BR, Jarkko

----------------------------------------------------------------
Jonathan McDowell (1):
      tpm/tpm_tis: Disable interrupts for Lenovo P620 devices

Mario Limonciello (1):
      tpm: Disable RNG for all AMD fTPMs

Takashi Iwai (1):
      tpm/tpm_tis: Disable interrupts for TUXEDO InfinityBook S 15/17 Gen7

Tom Rix (1):
      sysctl: set variable key_sysctls storage-class-specifier to static

 drivers/char/tpm/tpm-chip.c | 68 ++-------------------------------------------
 drivers/char/tpm/tpm_crb.c  | 30 ++++++++++++++++++++
 drivers/char/tpm/tpm_tis.c  | 16 +++++++++++
 include/linux/tpm.h         |  1 +
 security/keys/sysctl.c      |  2 +-
 5 files changed, 50 insertions(+), 67 deletions(-)
