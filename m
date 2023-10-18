Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2837CDFE2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345758AbjJROcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345790AbjJROcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:32:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14C124F19;
        Wed, 18 Oct 2023 07:23:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D3AC433C7;
        Wed, 18 Oct 2023 14:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697639006;
        bh=RHYkct3GSStzCzNNQNXsSJmDDCk6GywYTniHzwRPwnQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Q24A6P30QPceMlFd4gGIwsiwDA/fU7ZjlH8L8J2YX84B7RQd5gmN52OpQcCdxBc3b
         QQUHePfdhHkvNJ80mFIMzp6buCeTAV2tycAFiAA2Btwb3+fa0qflJ51DX3D91dcVMu
         cZO7LSEyJxEYD2kVQzcV1QHLIVE1nfcaGxTPgGx+WNY//Oc8o7Ae4eLNi3DM35wAQ7
         MEy+UaFKFnk6utdmapG+u/tp5F4XSi2Xv4gxy3/6eLm8i5rXVoF3mwIXUzbTeP6Lh6
         Q/x1sajmE6F7wVtg5tFmnlvZMp1MqLKnEs0AT2p4QnwvJCwP8Bd6q7qzIZ9r10fQwn
         bsf6lIHiab52Q==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6-6-rc4
Date:   Wed, 18 Oct 2023 15:23:10 +0100
Message-Id: <20231018142326.03D3AC433C7@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1a8196a93e493c0a50b800cb09cef60b124eee15:

  spi: spi-gxp: BUG: Correct spi write return value (2023-09-27 17:06:36 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6-6-rc4

for you to fetch changes up to 2ec8b010979036c2fe79a64adb6ecc0bd11e91d1:

  spi: npcm-fiu: Fix UMA reads when dummy.nbytes == 0 (2023-10-02 15:03:19 +0100)

----------------------------------------------------------------
spi: Fix for v6.6

A fix for the npcm-fiu driver in cases where there are no dummy bytes
during reads.

----------------------------------------------------------------
William A. Kennington III (1):
      spi: npcm-fiu: Fix UMA reads when dummy.nbytes == 0

 drivers/spi/spi-npcm-fiu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
