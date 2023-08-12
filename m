Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E46A779BBD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 02:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbjHLAFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 20:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjHLAFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 20:05:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463511BF9;
        Fri, 11 Aug 2023 17:05:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E117641EA;
        Sat, 12 Aug 2023 00:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EE2C433C7;
        Sat, 12 Aug 2023 00:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691798691;
        bh=wzo63f8E943NP+JH4HHaZ920MDCt5eaYTMG1WRXJLN0=;
        h=From:To:Cc:Subject:Date:From;
        b=BAQTh4G4iRsxxm2LiUX3BNbPIx/4PRrbytyl+d9P9voo/4bDiZ21uHn0VqxozoBEb
         cRhTTa87iqsMz6fr+0qq7AgPTd+hnJF3MMg/I0dio2/QrhYj2GgsBbAs3R/pRHmbnP
         /LTv390x6ayBVllO2YrtWfunJPjNxo0lCyXyWan3+07cNDHBLibNZvxX5VyrWphbUR
         TK+zQ3Pq5rP9ROdf/FCNQm0j/IX0zYNYX0NdxGrOEiWwy8ao04ICSCBWrLZb8G58Oi
         KXUpkHkIDKovXQs3nIRL7aHJZvB+LJQ0b8y/RpTpYxzUl2KtcsdMDPEr8KNM4Le6Ry
         Y0B/75nxyhuaw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [GIT PULL] tpmdd changes for v6.5-rc7
Date:   Sat, 12 Aug 2023 03:04:40 +0300
Message-Id: <20230812000440.2663553-1-jarkko@kernel.org>
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

  Merge tag 'mm-hotfixes-stable-2023-08-11-13-44' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2023-08-11 14:19:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.5-rc7

for you to fetch changes up to 6aaf663ee04a80b445f8f5abff53cb92cb583c88:

  tpm_tis: Opt-in interrupts (2023-08-12 02:36:28 +0300)

----------------------------------------------------------------
Hi,

These change the probing and enabling of interrupts advertised by the
platform firmware (i.e. ACPI, Device Tree) to tpm_tis as an opt-in,
which can be set from the kernel command-line.

BR, Jarkko

----------------------------------------------------------------
Jarkko Sakkinen (1):
      tpm_tis: Opt-in interrupts

Peter Ujfalusi (1):
      tpm: tpm_tis: Fix UPX-i11 DMI_MATCH condition

 drivers/char/tpm/tpm_tis.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
