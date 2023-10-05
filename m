Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676D77BA507
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240654AbjJEQNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240723AbjJEQMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:12:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F1C99C3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 08:30:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88444C433C9;
        Thu,  5 Oct 2023 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696519830;
        bh=gdwC0Rpxxq2U0n9P/VBZ7U0/r0IFGfIdjqqQH21/zOs=;
        h=Date:From:To:Cc:Subject:From;
        b=BNlEf41KTiLUiHESqbZ3thFLKSuvinN+pci3TBX4dbN4e9TqoqS9AFLGMr1VlMYWm
         OOCyDf9ZLyT+R3FxIEyKOSFGje7JA4h8IhcgNXw2kOn2QBMETEe56Pbbkd+GlQiCm9
         qiPUr86owHEDAkzID/W/IamSKPokTVLuNy0JZVxJMLfREklSJ30GMxY2mTpt0Dhpdu
         FJmlgTRWScKdyajs1ztSeNZAqhBM1Dz6KqUog7kZROj3jfu6Ude5konvlTVNb+8ILn
         0VgDZtoHZs7DiLuK25CqmZAN1KBacwdqB7hPHJKKO5YBrZWwwSt4treMy3f0kBy5Jh
         Ll/v35RZLIa3A==
Date:   Thu, 5 Oct 2023 16:30:26 +0100
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [GIT PULL] LEDs fixes for v6.6
Message-ID: <20231005153026.GB808963@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good evening Linus,

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-fixes-6.6

for you to fetch changes up to 9dc1664fab2246bc2c3e9bf2cf21518a857f9b5b:

  leds: Drop BUG_ON check for LED_COLOR_ID_MULTI (2023-09-19 15:16:23 +0100)

----------------------------------------------------------------
Just the one bug-fix:

  - Fix regression affecting LED_COLOR_ID_MULTI users

----------------------------------------------------------------
Marek Behún (1):
      leds: Drop BUG_ON check for LED_COLOR_ID_MULTI

 drivers/leds/led-core.c | 4 ----
 1 file changed, 4 deletions(-)

-- 
Lee Jones [李琼斯]
