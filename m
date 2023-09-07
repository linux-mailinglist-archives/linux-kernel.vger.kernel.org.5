Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8CE79773C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjIGQXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241673AbjIGQWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:22:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CF76A6E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:19:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042F8C4936D;
        Thu,  7 Sep 2023 12:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694090080;
        bh=ZzIB6F7PZKrp44QS70ZLsfQS7NOVHl+IkMIXv6FGCHM=;
        h=From:To:Cc:Subject:Date:From;
        b=KRTcxKY8HpH5zZ1QqJCfVjX+OWAxca3Nsgg8X79av1GpYL9PGJxbWuGDat8Gew92n
         Z6PUVxfdquqdl6Vu65RlH0YbONjbvbWcytzMnSr387jenuFC4hJ9kC0imAxTCqjHDY
         jmKDqKKlP2LlahzIJAqDjU9OGVLMP0vmlmocQKZlqq+IaQveriQI/mnNiZtiVZWSt/
         +ylCcFSZgTNTyPXlMH+PodICAwm3fpHj6Z3Uim2O1Fnbn3l+8MI4scKDvjNz7FGuaP
         WLQtOALM13CBQX5DVKpFN5TvRxUfGMHTYHWJosCeDf86K9qY0mE8udcHR+hCbQcX0w
         s+Wt1xPVX7zEA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.6-merge-window
Date:   Thu, 07 Sep 2023 13:34:30 +0100
Message-Id: <20230907123440.042F8C4936D@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b96c22476ff4bc3459933f87ba52cbb7910ffc6b:

  regulator: userspace-consumer: Drop event support for this cycle (2023-08-24 23:58:34 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.6-merge-window

for you to fetch changes up to ca0e36e3e39a4e8b5a4b647dff8c5938ca6ccbec:

  regulator: tps6594-regulator: Fix random kernel crash (2023-09-05 20:58:41 +0100)

----------------------------------------------------------------
regulator: Fixes for v6.6

A couple of fixes that came in during the merge window, both driver
specific - one for a bug that came up in testing, one for a bug due to a
misreading of the datasheet.

----------------------------------------------------------------
Jerome Neanne (1):
      regulator: tps6594-regulator: Fix random kernel crash

Vincent Whitchurch (1):
      regulator: tps6287x: Fix n_voltages

 drivers/regulator/tps6287x-regulator.c |  2 +-
 drivers/regulator/tps6594-regulator.c  | 31 +++++++++++++++----------------
 2 files changed, 16 insertions(+), 17 deletions(-)
