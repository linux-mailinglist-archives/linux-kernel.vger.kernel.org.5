Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728F3791E30
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 22:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbjIDUZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 16:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjIDUZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 16:25:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7887D180;
        Mon,  4 Sep 2023 13:25:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FC36B80EF3;
        Mon,  4 Sep 2023 20:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BF1C433C7;
        Mon,  4 Sep 2023 20:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693859120;
        bh=FggEjww8QLUdp3IBCOYDhk1zkN5RqlHJMWAdvJShDWU=;
        h=From:To:Cc:Subject:Date:From;
        b=nwRBsmkdIJ43xdekdMc+FujCPaOJ7nqYNk80tqvl8+gXsgUekwBvvk+pOXoGPnXZz
         Oscw8NHbpYfzJlkMeGLkMCyMovS+BlYYHCaSS0CkdN3dY3zUVbrqbcMrvApPfceRbs
         s2Kckcz2VMHzDOd1wQzMoBXwH9sl+AyVgoJ2jednZEs+NsV4D7ybPu6Xjl3GXNcCsy
         Mo2T2HCAbesC6/3UIHQ7FfuUOt8XORL/NjVvOmE7YyayOFEvoWup17iTkwkxABWxnR
         zEP6KYUxDzeERlcD9X+kFtHooMOtwXPkd2lpqcBbWFzoSlyJjUNi/BbRMaXfr/SuZG
         zoXQT9kbXNAZA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [GIT PULL] tpmdd changes for v6.6-rc1
Date:   Mon,  4 Sep 2023 23:25:12 +0300
Message-Id: <20230904202512.29825-1-jarkko@kernel.org>
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

  Merge tag 'dmaengine-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine (2023-09-03 10:49:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.6-rc1

for you to fetch changes up to 8f7f35e5aa6f2182eabcfa3abef4d898a48e9aa8:

  tpm: Enable hwrng only for Pluton on AMD CPUs (2023-09-04 21:57:59 +0300)

----------------------------------------------------------------
Hi,

This pull request contains two more bug fixes for tpm_crb, in other
words categorically disabling rng for AMD CPU's in the tpm_crb driver,
discarding the earlier probing approach.

BR, Jarkko

----------------------------------------------------------------
Christophe JAILLET (1):
      tpm_crb: Fix an error handling path in crb_acpi_add()

Jarkko Sakkinen (1):
      tpm: Enable hwrng only for Pluton on AMD CPUs

 drivers/char/tpm/tpm_crb.c | 38 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)
