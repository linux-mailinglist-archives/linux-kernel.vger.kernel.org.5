Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37DA80710F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378607AbjLFNnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378587AbjLFNnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:43:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FD6C7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:43:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFB6C433C9;
        Wed,  6 Dec 2023 13:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701870219;
        bh=2Aido14TVd955IUD8DzOIYivBbWzkNxrhuhlHMTmfPU=;
        h=From:To:Cc:Subject:Date:From;
        b=Tn5MWJYCvR078Ay/OB1NuLMPQIJWKoDaZPyNVbzp1fWg3L3bTi8/a3hoG71T0EgJQ
         Av81198Gjc4S7PwOnxzIDTn7Ht0QzXRbi09UtMCKzzpQJTZNQFQ/Q3l5YlVZBx0gVg
         Rm1v+4RS9MudqHHaiAf8cPZ6Bq+Y75F9pLlvRj7b7newyuufzHFjQy+Vmt7+imsYJe
         nsEZWdGDHpDMdjbWrzniFXvCUDal9Io4wE2cTHpWoF4MW0YiP9LUCInVjHJWhNpTui
         1lCLGrmBtV3iO4tkUkikLnXdDjAF3sg9hW1nx7Qq3SB5G8+Et7Sdpkba4dHfNpbAFl
         7dIxJx3Y5dGEw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v6.7-rc4
Date:   Wed, 06 Dec 2023 13:43:29 +0000
Message-Id: <20231206134339.2BFB6C433C9@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.7-rc4

for you to fetch changes up to fea88064445a59584460f7f67d102b6e5fc1ca1d:

  regmap: fix bogus error on regcache_sync success (2023-12-04 12:36:55 +0000)

----------------------------------------------------------------
regmap: Fix for v6.7

An incremental fix for the fix introduced during the merge window for
caching of the selector for windowed register ranges, we were
incorrectly leaking an error code in the case where the last selector
accessed was for some reason not cached.

----------------------------------------------------------------
Matthias Reichl (1):
      regmap: fix bogus error on regcache_sync success

 drivers/base/regmap/regcache.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
