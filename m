Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0CB75AF1F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjGTNFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGTNFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:05:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE981135
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:05:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59A4C61ADA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 13:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCF7C433CA;
        Thu, 20 Jul 2023 13:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689858335;
        bh=3JNyOLAdgarna3nn/QyclL3Y9tEvYmpK60mqh1viD/E=;
        h=From:To:Cc:Subject:Date:From;
        b=mTC2GYvbxWtqRFQE6MHdBMIP9xvo8mUCF2sutpJff08Ogd1np4IqeYvbBUaYCb2B+
         FsZI4OLdJYErv92CqqHqHN38maHYY9cKc+NF7p2RPLpQznKpJM8+ekY3HbcTgyIrHA
         cSIF/67MQmFeTVPzh1jcVHSo2ehnFRHsApL61iNTWAYlEYAbNwr1fdH1nuhWFaHVhk
         sgUTiJrizE7nqsW6kdMkgmQcu2iR1HoyA5El9stSwKTwsIQKNQI7b7rxOymTW5XaL8
         uCTKDNwzE7L/k1s/mBTvF2PvSjpL4qzu3hfTrwimcsuGASv2aUUUPTK/uEBG07Tc0U
         Zx4o/oXWJLW2g==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.5-rc1
Date:   Thu, 20 Jul 2023 14:05:26 +0100
Message-Id: <20230720130535.4CCF7C433CA@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.5-rc1

for you to fetch changes up to 98e2dd5f7a8be5cb2501a897e96910393a49f0ff:

  regulator: da9063: fix null pointer deref with partial DT config (2023-07-17 06:15:18 +0100)

----------------------------------------------------------------
regulator: Fix for v6.5

One fix for an issue with parsing partially specified DTs.

----------------------------------------------------------------
Martin Fuzzey (1):
      regulator: da9063: fix null pointer deref with partial DT config

 drivers/regulator/da9063-regulator.c | 3 +++
 1 file changed, 3 insertions(+)
