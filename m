Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207E87878F5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243356AbjHXTpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243355AbjHXToq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:44:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7651FC1;
        Thu, 24 Aug 2023 12:44:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3028D66EBA;
        Thu, 24 Aug 2023 19:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB375C433C7;
        Thu, 24 Aug 2023 19:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692906267;
        bh=xyMcHvNO8wXBTatKUK3qpMMhOqKl23C9JPMzqwblmfM=;
        h=From:To:Cc:Subject:Date:From;
        b=GWzOEQnFv+ltauBMjimchKlOB6fl9XwiAFFSuLLHs3KxNYo3kB70se5Fpo60YrMg2
         1RpwnO/MWHPgnd7w9lmUZEfeKHiEzNYfwZyLa+KCpQ61A85omod/c9BKbv03wTEbgk
         ULF+/lMzNZGq3pd2GkJGflAJm+ofvSscVdx17PS5yc/GsJHd7xBN5V8pHaNtB+sRbs
         hDYbzyCWWy0g731xUmSChW9wFTJ+evD+ZdQA/e2VJ+0f6s0G0sIXftGRHW4WWXiVuk
         dwcdQnz9SREIvxAcLdUpzEhXVCFg2+0ZRJ361Z/XyDRi1jWN7Kcf5MGIwkWwcQFOTl
         AeRDBF/pftGmA==
Message-ID: <9a29df1bae4a68227ef337ae9f0a4cf6.broonie@kernel.org>
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.5-rc7
Date:   Thu, 24 Aug 2023 20:44:21 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:

  Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.5-rc7

for you to fetch changes up to 627d05a41ca1fbb9d390f9513af262f001f261f7:

  spi: spi-cadence: Fix data corruption issues in slave mode (2023-08-21 13:09:57 +0100)

----------------------------------------------------------------
spi: Fixes for v6.5

A couple more small driver specific fixes for v6.5, the device mode for
Cadence had been broken by some recent updates done for host mode and
large transfers for multi-byte words on stm32 had been broken by an API
update in what I think was a rebasing incident.

----------------------------------------------------------------
Leonard Göhrs (1):
      spi: stm32: fix accidential revert to byte-sized transfer splitting

Srinivas Goud (1):
      spi: spi-cadence: Fix data corruption issues in slave mode

 drivers/spi/spi-cadence.c | 19 ++++++++++++-------
 drivers/spi/spi-stm32.c   |  6 +++---
 2 files changed, 15 insertions(+), 10 deletions(-)
