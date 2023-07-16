Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE727551AC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 21:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjGPT66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 15:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjGPT65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:58:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D95AE50;
        Sun, 16 Jul 2023 12:58:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19F4B60EB2;
        Sun, 16 Jul 2023 19:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 807AAC433CB;
        Sun, 16 Jul 2023 19:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689537535;
        bh=M87fb+iQpicnQvHUJ8GkJkkq0X06ZFDxi/xlnVjT8/E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZlQVpzEcDfj4eFXp1hnvS5hQZoLv9XoyT0hvahkYZV5lzhf+IJiDsBPHgY5uNufCA
         frp1hJAEd3yrkwi3tFNX6FKtWcWGKrJTzjO1BHlRzDGTkncw5tiXDk9qwGPkg7dIrk
         VY1tIjzj0jqrdFaaPjiCUcJJcg4zNQzMS6eQHU1LA3A/vFpGMTR6D52FmktepSJ6b1
         oro0h+t1da5DaYiFA9K3TBp4V8rK8Hbi714poNnXTCS+SsubCkwyv//Y8e+qzIVYSd
         1q7/BQyOXaVOVka+kHzLQBfI1BduoKajb4oaUOFRVzWUxzm10ITAlFGxOAcxjZ7K91
         b0qIEfo3pTGJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C62FC40C5E;
        Sun, 16 Jul 2023 19:58:55 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mu_m5J8Nxop9Of133-g3KgGydrX0-TMrFJt08zOVcYg=g@mail.gmail.com>
References: <CAH2r5mu_m5J8Nxop9Of133-g3KgGydrX0-TMrFJt08zOVcYg=g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mu_m5J8Nxop9Of133-g3KgGydrX0-TMrFJt08zOVcYg=g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.5-rc1-smb3-fixes
X-PR-Tracked-Commit-Id: 69cba9d3c1284e0838ae408830a02c4a063104bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe756ad0214619ac01503c37f43ca5b912d760d4
Message-Id: <168953753543.5443.13571012228765369741.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Jul 2023 19:58:55 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Jul 2023 09:59:59 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.5-rc1-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe756ad0214619ac01503c37f43ca5b912d760d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
