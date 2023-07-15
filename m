Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0767E754878
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 13:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjGOLxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 07:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGOLxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 07:53:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B291B6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 04:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9A2B60B86
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 11:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AF1C433C8;
        Sat, 15 Jul 2023 11:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689421993;
        bh=dLk6e0CuIngX8Oxe0o79snTusqw8srgVU9wSwuQf1pI=;
        h=From:To:Cc:Subject:Date:From;
        b=dWOQHlTJGY4GxQ55r/cUdhdsOoTUMEwKJ0fMOZklCUaNO/2Bnu0v4hfD2VlTojJIM
         eXs8ivPgxSTYnL7aaSHJQhLB2Cfp4J9yQXcqYXR79uemmcLWV7N/99b/a5/c561Ob1
         kMD6WWNNbqT2iob3ozpQ+57BfYyvzcwNkZTR91HWTNlvWvDhudL1xwhFEJWQ8rkbhM
         nhHjUqUgBPIxoK8EkMp7iEpCcpBatfXmmNlIDVoWd5ulElo6zTRm92Z+b4ez1pyet1
         7AG2l7cRA3oSAaE5NJrdQc2uRHE17nX7oW+a13OKdDUi7gIqVv3OOE7m5n12MvAoMO
         SrXomDXjj8Nmw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v6.5-rc1
Date:   Sat, 15 Jul 2023 12:53:04 +0100
Message-Id: <20230715115312.95AF1C433C8@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.5-rc1

for you to fetch changes up to 963b54df82b6d6206d7def273390bf3f7af558e1:

  regmap-irq: Fix out-of-bounds access when allocating config buffers (2023-07-12 12:05:10 +0100)

----------------------------------------------------------------
regmap: Fix for v6.5

One fix for an out of bounds access in the interupt code here.

----------------------------------------------------------------
Isaac J. Manjarres (1):
      regmap-irq: Fix out-of-bounds access when allocating config buffers

 drivers/base/regmap/regmap-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
