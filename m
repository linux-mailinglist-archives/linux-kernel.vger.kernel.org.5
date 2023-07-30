Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4636276864F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 17:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjG3P61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 11:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjG3P60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 11:58:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57EA115
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 08:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5320F60B98
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 15:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4016AC433C8;
        Sun, 30 Jul 2023 15:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690732704;
        bh=ZCxah2rMegctVEI3agWe4XgCI402K6BYEBNBAtraVw4=;
        h=From:To:Cc:Subject:Date:From;
        b=daOTZpFzd30gVWtXS5uTZ7B4zX4UaH00pRbybSrAH05X9uzRO0/fqoSdEAwDbec64
         pmIEIHNw5BPrA2iqQHTD92sbPo0q56nltDgDgVcrKWnN6xNXb1BCxCiP8DkRZfEp7V
         C1dRtOJIxF8ACoIve1+M5GUVRobvJN0VjQtw2weDHNEpdX/cw3K/XezxR50xNN/MLA
         h3ouv2RNRIUVzxBww+vvdZ6uOeqKsqg2iQSLuuKY3w8GuiGAfFdaZLO5mDf8tE0bXc
         2/x1GrLQPndQXoPF8BqDDgHlNtwlUnOumIRjokuGr25DKhFxNbuMIpjnN0FRJ/A8vD
         XRdp9b4Ah8IHw==
Message-ID: <56c33730faf0170df5a64351dcc4fb63.broonie@kernel.org>
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.5-rc3
Date:   Sun, 30 Jul 2023 16:58:12 +0100
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.5-rc3

for you to fetch changes up to 67cb608838e0aac8efb48828b1165156f99c1af9:

  regulator: mt6358: Fix incorrect VCN33 sync error message (2023-07-23 23:40:09 +0100)

----------------------------------------------------------------
regulator: Fixes for v6.5

A couple of small fixes for the the mt6358 driver, fixing error
reporting and a bootstrapping issue.

----------------------------------------------------------------
Chen-Yu Tsai (2):
      regulator: mt6358: Sync VCN33_* enable status after checking ID
      regulator: mt6358: Fix incorrect VCN33 sync error message

 drivers/regulator/mt6358-regulator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
