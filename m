Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64BC7E458E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344336AbjKGQLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbjKGQLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:11:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE2322DC0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:03:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14E8C433C8;
        Tue,  7 Nov 2023 16:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372989;
        bh=W71zoZNN8hkPqINZEfjTZGltuBT4tagvw/usts6LFTg=;
        h=From:To:Cc:Subject:Date:From;
        b=Dc3zcXlMLGMnSKwrZiPh0TZwAyew+PRGweWeUUk0LXFDsu58ZfByZ+o31SSf3eeVS
         TVdhRmrybeaZAPwqmX77HaYUMgE/LyajrNHY2ENwCxnIzKH8rdCftEYbEe+bGqinTC
         zDh56ZX0Cvc2GOADsVk4qZ8agLXxFGMv+gcu/ui/deV8cHto4BhgTyoHeBw7XanC+x
         1qU6XTgu5vM27F0zIySqFKv4mpuSREhW4HP67euYCN3E8jP0F45DBXCYUfxs7WG0OK
         OFBJ6aZlMuMZsyz01w5w4t7mLS4fOZhAa7aAMRlYy8UykZ+UZOxlCIFarlaa1tNAtf
         K2b4tVBMsB+4A==
Message-ID: <e3356ba4abdbbb74002a76ea30dd6a4e.broonie@kernel.org>
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v6.7-merge-window
Date:   Tue, 07 Nov 2023 16:03:00 +0000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6a2e332c2cbddd17d7dcb8f334953593f1324c8e:

  regmap: kunit: Add test for cache sync interaction with ranges (2023-10-26 14:00:42 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.7-merge-window

for you to fetch changes up to 984a4afdc87a1fc226fd657b1cd8255c13d3fc1a:

  regmap: prevent noinc writes from clobbering cache (2023-11-01 20:22:55 +0000)

----------------------------------------------------------------
regmap: Fix for v6.7

One fix here, for an interaction between noinc registers and caches - if
a device uses noinc registers (which is rare) then we could corrupt
registers after the noinc register in the cache.

----------------------------------------------------------------
Ben Wolsieffer (1):
      regmap: prevent noinc writes from clobbering cache

 drivers/base/regmap/regmap.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)
