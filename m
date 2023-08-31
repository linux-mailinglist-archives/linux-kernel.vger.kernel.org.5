Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662FF78E3C0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 02:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345016AbjHaAKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 20:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344969AbjHaAKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 20:10:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AD1CD7;
        Wed, 30 Aug 2023 17:10:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACA6FB8201C;
        Thu, 31 Aug 2023 00:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51AFCC433CB;
        Thu, 31 Aug 2023 00:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693440604;
        bh=Qi7nn00KI9iPpBTkRRrWP9Mxddhfks1+MAIh7yTH8CI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LbAH/Ri1p2v8skUcD4ArivpcDr1PQWdbcO34enR7lvUGTsgKYmg9/bmuMup5U9AgL
         QyYNLz0+qN5N1SJ6S4gGimHW3UBnfw/vYZSIEMeD20qpTEYg/OEf22bx+rGhogEu2p
         0ImXfl/FOSHJBGZ7b02d7sTcpXTY6KaUX6HvIRgdrYNDfqyCAwT5soc0+kK8HxzwCK
         45GlGXbwoYJuQJ9+y/Ii6wSY6VRjUmdPlFPm6Sr9ADs2ZScHJlW9a2lBDNwUHQxLNL
         JdKz67qwjZsoL4yjTyBuutpChjsw5CXkFOOG0Jha35e8E66LpFEpqvJJQKStBmRQxv
         mOsW3T7IFBhRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DD3EC64457;
        Thu, 31 Aug 2023 00:10:04 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree include cleanups for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230830133253.GA112890-robh@kernel.org>
References: <20230830133253.GA112890-robh@kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230830133253.GA112890-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-header-cleanups-for-6.6
X-PR-Tracked-Commit-Id: 86cdae14a58a877ee1ec79d39b1331bc98dace58
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef2a0b7cdbc5b84f7b3f6573b7687e72bede0964
Message-Id: <169344060424.21437.11456166109790852724.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Aug 2023 00:10:04 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Corey Minyard <minyard@acm.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Dipen Patel <dipenp@nvidia.com>, Peter Rosin <peda@axentia.se>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Aug 2023 08:32:53 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-header-cleanups-for-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef2a0b7cdbc5b84f7b3f6573b7687e72bede0964

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
