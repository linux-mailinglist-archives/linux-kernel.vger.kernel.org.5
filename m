Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA7E78E56B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 06:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346015AbjHaEaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 00:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345695AbjHaEaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 00:30:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1388CC5;
        Wed, 30 Aug 2023 21:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8037D62086;
        Thu, 31 Aug 2023 04:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7044C433CC;
        Thu, 31 Aug 2023 04:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693456209;
        bh=1xTuk4g27JKy8qJFjLeESRGDqh68efJ7+pdB81XayyM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GZpKuUgdk0Cpiuoiqh3/wFrecv/JD/pyyuVCh+aoDY84qPp582SDoZyJoj4ifHaUd
         B8ghouc/bZzPLqo0CpzLeQ06O6tzTh5xqatFQp+iCuNd79z0gZIgUZMnA3yGfL/3Ne
         IYk5YfZakiFLUAwk3BfnVLjBEgUwgfIgdQ0W9AvZGyWHjBRRQ6fZLCcKV+4CUjJJRK
         KzhIpuEmV+rCnys/ygkxex13hNawVjFZ9gMbSArJCseE41EbaBQbgyWeJXa6NNCYv8
         98E4rcTxrmLAXRu75SPQFEqHyt12mKYuHX8FwHxdQX17/yayZEARgbeTEUFaxg0M6l
         L8n/Gd8g4gf6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3B3BE29F32;
        Thu, 31 Aug 2023 04:30:09 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtpOtiP3Hk6FJPav8tYDhKJTQmELP31zYzVxf4DPNKbiQ@mail.gmail.com>
References: <CAH2r5mtpOtiP3Hk6FJPav8tYDhKJTQmELP31zYzVxf4DPNKbiQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtpOtiP3Hk6FJPav8tYDhKJTQmELP31zYzVxf4DPNKbiQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.6-rc-smb3-client-fixes-part1
X-PR-Tracked-Commit-Id: f3a9b3758e0b6d40183929aba599a7da52313a3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b97d64c722598ffed42ece814a2cb791336c6679
Message-Id: <169345620979.29893.15723133495949975465.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Aug 2023 04:30:09 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Aug 2023 15:48:32 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.6-rc-smb3-client-fixes-part1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b97d64c722598ffed42ece814a2cb791336c6679

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
