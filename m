Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F6B794183
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243252AbjIFQ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjIFQ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:29:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A6319B1;
        Wed,  6 Sep 2023 09:28:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C21E3C43397;
        Wed,  6 Sep 2023 16:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694017664;
        bh=hthk+pY8fjwypZLQ2j/TWWg7VUX2AvpAPwTTBme6ZVw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eEGVXH7/ltjPwoQBN7qBIoYRbr6sZglnefQN9n/rbqiy31FdlO7RsKbyI1F+2UtQx
         +4g6DtS4I3tsR36VnDkaTEDuN0mNsZViXDjMZrz+yIcRl7t4Msrn26u1246fIft0E+
         oYfIEwYbQVC1oH9rpM++6gco29pLQQ/ImFPMcIeoa3AZskaGjUKQMJXPcaHVz63tMY
         OOXF7ld6yHPh/NUc4vXUnTyjV20wTN+Kab5UjyTtp2QX0hQQ2QyGCbk95nxfA7epEM
         2gEE/5hEbSVpaY/CqjZZFeP2PhySFFCE7YUfg5EUr0CwDZoGt/zjYD6NQrX6zESi/v
         KQsiETRuCfm0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9EE2C04E28;
        Wed,  6 Sep 2023 16:27:44 +0000 (UTC)
Subject: Re: [GIT PULL REQUEST] watchdog - v6.6 release cycle.
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230905201327.GA31462@www.linux-watchdog.org>
References: <20230905201327.GA31462@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-watchdog.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230905201327.GA31462@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.6-rc1
X-PR-Tracked-Commit-Id: 8c776a0401f1dcfcfc8e5549c5260668bec59c0e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29057cc5bddc785ea0a11534d7ad2546fa0872d3
Message-Id: <169401766468.7147.18358548810150523575.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Sep 2023 16:27:44 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Chengfeng Ye <dg573847474@gmail.com>,
        Fabio Estevam <festevam@denx.de>,
        Florent CARLI <fcarli@gmail.com>,
        Huqiang Qin <huqiang.qin@amlogic.com>,
        Li Hua Qian <huaqian.li@siemens.com>,
        Li Zetao <lizetao1@huawei.com>,
        Mathieu Othacehe <othacehe@gnu.org>,
        Meng Li <meng.li@windriver.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Raag Jadav <raag.jadav@intel.com>,
        Robert Marko <robimarko@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Ruan Jinjie <ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Sep 2023 22:13:27 +0200:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29057cc5bddc785ea0a11534d7ad2546fa0872d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
