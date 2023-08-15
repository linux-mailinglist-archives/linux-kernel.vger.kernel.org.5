Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B9E77D05B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbjHOQrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238475AbjHOQrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:47:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13511B2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FCE662367
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4451BC433C7;
        Tue, 15 Aug 2023 16:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692118021;
        bh=CQV2kN8cGR6NtkIsl8Yqixmv70Cv/SCqJUzqEvda7lc=;
        h=From:To:Cc:Subject:Date:From;
        b=OJsSzPgpx64K6KIFXc29DPOtK6PvQ2p+NRUA9N4NYqfXjwjgcptYhTpbRjomDcRdH
         D3x58eRA/Qowq6TooHK9gxEAsie2pAIMpPkZWkOFBPZKAGLKJMss0YLKOcBhvLpRzr
         C0ZN11qKqySuGvBLwMM9wSpqoafHT/IWaR6NSpXm7+/gT3ZHDQYdXYtkGNusdsLxYL
         IJIyFnuR+86g8ggqCrw1OG3GqeiemULDXhTFLtpW56noYkWB0grcN8TwQXaakvGvca
         IolkRyfDxs2rMKmoXIPnVVVCnpnz88kr4uqKe9bPcEUTlwhWGpuqRhX+NAJ9LGBlhs
         OmRblLq4jL2MA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.5-rc6
Date:   Tue, 15 Aug 2023 17:46:50 +0100
Message-Id: <20230815164701.4451BC433C7@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.5-rc6

for you to fetch changes up to 7cdf55462c5533a1c78ae13ab8563558e30e4130:

  regulator: qcom-rpmh: Fix LDO 12 regulator for PM8550 (2023-08-07 15:13:27 +0100)

----------------------------------------------------------------
regulator: Fixes for v6.5

A couple of small, driver specific fixes - one incorrect definition for
one of the Qualcomm regulators and better handling of poorly formed DTs
in the DA9063 driver.

----------------------------------------------------------------
Abel Vesa (1):
      regulator: qcom-rpmh: Fix LDO 12 regulator for PM8550

Martin Fuzzey (1):
      regulator: da9063: better fix null deref with partial DT

 drivers/regulator/da9063-regulator.c    | 12 ++++++------
 drivers/regulator/qcom-rpmh-regulator.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)
