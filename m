Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC5A7A8220
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbjITM5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbjITM5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:57:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560618F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:57:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A0AC433C8;
        Wed, 20 Sep 2023 12:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695214654;
        bh=3xJgp1vSJGAww9tqYQEQKyTXiVwxfxP2Rhs9/bJJTfg=;
        h=From:To:Cc:Subject:Date:From;
        b=BqlVLBrve2ZA4Bj86iAO5LliQkpCdry8q7jdKNKr544sTva/HaZ/1w0jEyrFZNtE6
         cY4xhPoNDac33DrIme7AXa3so2qkissFdB4EYOe0dC8MRqel2h9zc0jqlMdSnr5Eyk
         l+J5kT/LVWImAI1t3GqD7yEYLR3/t68woYPW9n/KdyNVbWoxExupuyFgVdDeQ7xjXV
         FVZpoCKsiyYY8HAK1qK0rFfpz0/NSYx753V2P6chEeT1QRZHnoMaZEn+qJZ/sO4tlE
         LN58r9kiDDqYbJuhVpjvcdv8C/sg1KB5vw5U8dBZjuKSEqqFuvZEYcMSDokTdkDV1I
         KJp2ItH/YtwaA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.6-rc2
Date:   Wed, 20 Sep 2023 13:57:26 +0100
Message-Id: <20230920125733.92A0AC433C8@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.6-rc2

for you to fetch changes up to 6223e073db78458f8846c380ccd224a7a73a3867:

  regulator: Fix voltage range selection (2023-09-11 13:51:36 +0100)

----------------------------------------------------------------
regulator: Fix for v6.6

One fix for the tps6287x driver which was incorrectly specifying the
field for voltage range selection leading to incorrect voltages being
set.

----------------------------------------------------------------
Vincent Whitchurch (1):
      regulator: Fix voltage range selection

 drivers/regulator/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
