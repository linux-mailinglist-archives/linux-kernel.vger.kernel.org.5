Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0429D797A5C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244795AbjIGRij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244709AbjIGRig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:38:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9828210B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:38:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD9CC32780;
        Thu,  7 Sep 2023 11:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694087558;
        bh=U/onYJkOH506fHRRI8gaS+3dyG+/KTS7kKooy/dBzRM=;
        h=From:To:Cc:Subject:Date:From;
        b=nQ3KgW+Nw8cmpQGfehNkMrDUO+Qy1+K1MPrCFAsjcgg9WZ9cW2pxA+xLxKAnTWexE
         OFDPl57l9drkEsmHMGQTHkfUZ9hchTjijCokmNsF+FLU7orxUGeoJVb+N8M7UlPioq
         KwxHzcybh4d8ay4tnQwrmf5//RaKKK/bhlGtlCyil5gGPguvKzQJzj2m4AK6zUIuVi
         foYJfttZrnsjDyQ9GOZoLdF+EwxLePx38sm3z4hM2Lh03zbTMeUQKH+XPfViyMUtlH
         lODvodoips71/oU51jUAOoovdeSKiDyCnHMf+vFpc/e7UyihOnZbiF/eztx/jGBlwd
         PgJvcS7DfD1eg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.5-rc7
Date:   Thu, 07 Sep 2023 12:52:26 +0100
Message-Id: <20230907115238.5BD9CC32780@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:

  Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.5-rc7

for you to fetch changes up to e4eea71222725b7366d61ce7a9ce35202d8a6dfa:

  regulator: da9063: better fix null deref with partial DT (2023-08-23 14:02:50 +0100)

----------------------------------------------------------------
regulator: Fixes for v6.5

Two driver specific fixes here, one for handling of malformed DTs in
DA9063 where a v2 of the original patch had been missed somehow and
another for an incorrectly described regulator on the Qualcomm PM8550.

----------------------------------------------------------------
Abel Vesa (1):
      regulator: qcom-rpmh: Fix LDO 12 regulator for PM8550

Martin Fuzzey (1):
      regulator: da9063: better fix null deref with partial DT

 drivers/regulator/da9063-regulator.c    | 12 ++++++------
 drivers/regulator/qcom-rpmh-regulator.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)
